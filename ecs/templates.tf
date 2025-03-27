data "aws_db_instance" "rds" {
  db_instance_identifier = "project-ecs-dev-db"
}


data "template_file" "wp-container" {
  template = file("task-definitions/wordpress.json")
  vars = {
    # db_host     = "${aws_db_instance.db.endpoint}"
    db_host     = data.aws_db_instance.rds.endpoint
    db_name     = "${var.db_name}"
    db_user     = "${var.db_user}"
    db_password = "${var.db_password}"
    region      = "${var.region}"
  }
}