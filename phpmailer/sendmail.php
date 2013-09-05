<?php
$ROOT="/home/thongngo/portscan/logs";
require("class.phpmailer.php");

$mail = new PHPMailer();

$mail->IsSMTP();                                      // set mailer to use SMTP
$mail->Host = "mail.myserver.com";  // specify main and backup server
$mail->SMTPAuth = true;     // turn on SMTP authentication
$mail->Username = "portscan";  // SMTP username
$mail->Password = "portscan123"; // SMTP password

$mail->From = "portscan@myserver.com";
$mail->FromName = "PORT SCAN AUDIT";
$mail->AddAddress("it@myserver.com");

$mail->WordWrap = 50;                                 // set word wrap to 50 characters
$mail->IsHTML(true);                                  // set email format to HTML
$today = date("Y-m-d");

$data = "";
$file = fopen("$ROOT/$today",'r');

while(!feof($file))
{
	$data .= fgets($file)."<br/>";
}
fclose($file);

$mail->Subject = "[Port Scan Audit] $today";
$mail->Body    = $data;


if(!$mail->Send())
{
   echo "Message could not be sent. <p>";
   echo "Mailer Error: " . $mail->ErrorInfo;
   exit;
}

echo "Message has been sent";
?>

