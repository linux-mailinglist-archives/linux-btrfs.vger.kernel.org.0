Return-Path: <linux-btrfs+bounces-21461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE29IBrwhmlsSQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21461-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 08:56:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D13681052C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 08:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D034A30214D0
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353FB3002D8;
	Sat,  7 Feb 2026 07:55:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 10.mo581.mail-out.ovh.net (10.mo581.mail-out.ovh.net [178.33.250.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE5279DAB
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.250.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770450931; cv=none; b=pOwA03yUuZ1SlF5MfsqoFBm+zZgU5y+jW+6oYQWSL7MwpKnN6oGbOZqtHJcdkdVMExaWoc1ohm2FU4ozqiDfqjK2/N5PRWY9xZvwbkS2wkY5d5f9s1X/6vMRdL23htKUBSjRpq45gSU/X1L4tpmY5UZO6MyxVyPdmVLiptIa4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770450931; c=relaxed/simple;
	bh=Mcf45H7xuPtyHbhr9XDKNpqfjEds5Pjig+AKgJffsWU=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=OiWwhqeoEKbtgi1wO3EG3Cu2W6gTPOj3IzLP0TCSOqlpnxvG6kFqtyk8vkxed6cFLo3GT5TQea/l1+pu2uzWDZIRqYqPQgtnCn7V8snmr/FI9Vlnbnz5DYbrvuonKFmDbPDq7VQeA5Iwj8qFndWocKfW6dN6cPcV2WgHyGtaz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dennet.eu; spf=pass smtp.mailfrom=dennet.eu; arc=none smtp.client-ip=178.33.250.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dennet.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dennet.eu
Received: from director4.ghost.mail-out.ovh.net (unknown [10.110.43.65])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4f7Mjs5Rq6z62qV
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 07:17:53 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-sz4l9 (unknown [10.111.174.161])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 80D7FC289E
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 07:17:53 +0000 (UTC)
Received: from dennet.eu ([37.59.142.101])
	by ghost-submission-7d8d68f679-sz4l9 with ESMTPSA
	id d4eYECHnhmkJSRcArTWXHw
	(envelope-from <wwwadmin@dennet.eu>)
	for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 07:17:53 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G004b9843799-5c52-4955-b1b6-39410eafc396,
                    F5807B2DCCC1E34D162C8A49AA02AC54BA5BD153) smtp.auth=polhypro@dennet.eu
X-OVh-ClientIp:109.190.121.188
Content-Type: multipart/mixed; boundary="------------iXDYdnU9LgzZMuJZcUxpaRyH"
Message-ID: <d4fcad84-c881-41d9-a88f-62e28a55a544@dennet.eu>
Date: Sat, 7 Feb 2026 08:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: fr, oc-FR-gascon, oc-FR-lengadoc, en-GB
To: linux-btrfs@vger.kernel.org
From: =?UTF-8?Q?ma=C3=AEtrepostier?= <wwwadmin@dennet.eu>
Subject: Partition lost
X-Ovh-Tracer-Id: 16654592901165082485
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEIZtVn8mVD4tpU7uoADwe6JmjqWODh4Q6ylvJerHJ6WpulG0BMsBL3QQFR9dHd5e71xU/2qv0OHMlJggXjPKsbjMMhjRQYGeg1xHvsOUOt4G5yRh2JnzuYF8T2LBcJMO7fNee4W8r9+7Z5nPPArkYqjDTl9o0+WCNtxh2fmRIJS4Zks4cctjXU6WJwaNEECLzNG/Qr2tZNII0kM+hDdgoUN0ltsbw6QatXiM5h8nsf6SzCqVRab0E8aI+8OOZVTJa32wUH5+h/8vBRpwrWGuQGkWVtcWHEvK/Owf18ue9E4aIwjslvYwUa0snWF7Cjhz3xux77YUpi6/EsgHSfsLpmrwlQ/ozy6e0GidgfXpIxtGGSjwRPRvO0HhXyOtmbecudpWQ8j4gQmNkOKMuOYOk4pz0JUkY6HkGVB8rxWglahTt37vfv2O8DMi83GpOU9T1qeFFMocM+XR6yFr/cf9alGP4dPZbCWbkomekI+hv2BW3p5SxV10pb2G1Oe52bYV6YcL0Sl7sO1m0zTm0P+Kip4hrqitgg1Hfr5AQncWDSGPIUF6knhq6Xg4k4+A5tcORlhQ710Kn1ntnJeBcO2/sAYFIFoWmtYbUli8/CeBOlBzki5Jb4dO1kGNOCIBSkFgiIqZ/5TaZBoQDLResnQBbnV19KWzuQuufzZA5kxMXaOA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	MIME_BAD_EXTENSION(2.00)[html];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21461-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dennet.eu];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:-,4:~];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wwwadmin@dennet.eu,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D13681052C2
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------iXDYdnU9LgzZMuJZcUxpaRyH
Content-Type: multipart/alternative;
 boundary="------------xXsaRIxXJvh0XeJmyD48Iyvf"

--------------xXsaRIxXJvh0XeJmyD48Iyvf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Will copying by 2 different ways about 130 Go in total, I suddenly loose 
the partition :

cp -a files1_subvol1_part1_disk1_btrfs to part1_btrfs_disk2

and via dolpin I was copying from files_subvol2_part1_disk1_btrfs to 
part1_btrfs_disk2



Suddenly the system held on part3_disc0_btrfs disepeared.

Att. the result of btrfs check


Regards

--
Administrateur du domaine dennet.eu

--------------xXsaRIxXJvh0XeJmyD48Iyvf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFCC33">
    <p><font face="TeX Gyre Chorus">Hi,</font></p>
    <p><font face="TeX Gyre Chorus">Will copying by 2 different ways
        about 130 Go in total, I suddenly loose the partition :</font></p>
    <p><font face="TeX Gyre Chorus">cp -a
        files1_subvol1_part1_disk1_btrfs to </font><font
        face="TeX Gyre Chorus">part1_btrfs_disk2</font></p>
    <p><font face="TeX Gyre Chorus">and via dolpin I was copying from </font><font
        face="TeX Gyre Chorus">files_subvol2_part1_disk1_btrfs to
        part1_btrfs_disk2</font></p>
    <p><font face="TeX Gyre Chorus"><br>
      </font></p>
    <p><font face="TeX Gyre Chorus"><br>
      </font></p>
    <p><font face="TeX Gyre Chorus">Suddenly the system held on
        part3_disc0_btrfs disepeared.</font></p>
    <p><font face="TeX Gyre Chorus">Att. the result of btrfs check</font></p>
    <p><font face="TeX Gyre Chorus"><br>
      </font></p>
    <p><font face="TeX Gyre Chorus">Regards</font></p>
    <pre class="moz-signature" cols="72">
--
Administrateur du domaine dennet.eu</pre>
  </body>
</html>

--------------xXsaRIxXJvh0XeJmyD48Iyvf--
--------------iXDYdnU9LgzZMuJZcUxpaRyH
Content-Type: text/html; charset=UTF-8; name="perte_sda3"
Content-Disposition: attachment; filename="perte_sda3"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBYSFRNTCAxLjAgVHJhbnNpdGlv
bmFsLy9FTiIKImh0dHA6Ly93d3cudzMub3JnL1RSL3hodG1sMS9EVEQveGh0bWwxLXRyYW5z
aXRpb25hbC5kdGQiPgo8aHRtbCB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRt
bCIgeG1sOmxhbmc9ImVuIiBsYW5nPSJlbiI+CjxoZWFkPgoJPHRpdGxlPkdlc3Rpb25uYWly
ZSBkZSBwYXJ0aXRpb25zIGRlIEtERcKgOiByYXBwb3J0IGQnw6l0YXQgU01BUlQ8L3RpdGxl
PgoJPG1ldGEgaHR0cC1lcXVpdj0iY29udGVudC10eXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7
IGNoYXJzZXQ9dXRmLTgiLz4KPC9oZWFkPgoKPGJvZHk+CjxoMT5HZXN0aW9ubmFpcmUgZGUg
cGFydGl0aW9ucyBkZSBLREXCoDogcmFwcG9ydCBkJ8OpdGF0IFNNQVJUPC9oMT4KCjx0YWJs
ZT4KPHRyPgo8dGQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7cGFkZGluZy1yaWdodDoyMHB4
Oyc+RGF0ZcKgOjwvdGQ+Cjx0ZD4wNy8wMi8yMDI2IDA4OjAwPC90ZD4KPC90cj4KPHRyPgo8
dGQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7cGFkZGluZy1yaWdodDoyMHB4Oyc+VmVyc2lv
biBkZSBwcm9ncmFtbWXCoDo8L3RkPgo8dGQ+MjUuMTIuMTwvdGQ+CjwvdHI+Cjx0cj4KPHRk
IHN0eWxlPSdmb250LXdlaWdodDpib2xkO3BhZGRpbmctcmlnaHQ6MjBweDsnPk1vdGV1csKg
OjwvdGQ+Cjx0ZD5wbXNmZGlza2JhY2tlbmRwbHVnaW4gKDEpPC90ZD4KPC90cj4KPHRyPgo8
dGQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7cGFkZGluZy1yaWdodDoyMHB4Oyc+VmVyc2lv
biBkZSBLREXCoEZyYW1ld29ya3PCoDo8L3RkPgo8dGQ+Ni4yMi4wPC90ZD4KPC90cj4KPHRy
Pgo8dGQgc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQ7cGFkZGluZy1yaWdodDoyMHB4Oyc+TWFj
aGluZcKgOjwvdGQ+Cjx0ZD5MaW51eCBlNzQ3MC5kZW5uZXQgNi4xOC41LTEwMC5mYzQyLng4
Nl82NCAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIFN1biBKYW4gMTEgMTg6MTY6NDYgVVRDIDIw
MjYgeDg2XzY0PC90ZD4KPC90cj4KPC90YWJsZT4KPGJyLz4KPHRhYmxlPgo8ZGl2PgoKPGI+
VsOpcmlmaWVyIGV0IHLDqXBhcmVyIGxhIHBhcnRpdGlvbiDCq8KgL2Rldi9zZGEzwqDCuyAo
NDY0LDE3wqBHaW8sIGJ0cmZzKTwvYj4KCjxkaXYgc3R5bGU9J21hcmdpbi1sZWZ0OjI0cHg7
bWFyZ2luLXRvcDoxMnB4O21hcmdpbi1ib3R0b206MTJweCc+Cgo8Yj5Uw6JjaGXCoDogVsOp
cmlmaWVyIGxlIHN5c3TDqG1lIGRlIGZpY2hpZXJzIHN1ciBsYSBwYXJ0aXRpb24gwqvCoC9k
ZXYvc2RhM8Kgwrs8L2I+Cgo8ZGl2IHN0eWxlPSdtYXJnaW4tbGVmdDoyNHB4O21hcmdpbi10
b3A6MTJweDttYXJnaW4tYm90dG9tOjEycHgnPgoKPGI+Q29tbWFuZGXCoDogYnRyZnMgY2hl
Y2sgL2Rldi9zZGEzPC9iPgoKPGJyLz4KPC9kaXY+Cgo8Yj5Ww6lyaWZpZXIgbGUgc3lzdMOo
bWUgZGUgZmljaGllcnMgc3VyIGxhIHBhcnRpdGlvbiDCq8KgL2Rldi9zZGEzwqDCu8KgOiBF
cnJldXI8L2I+PGJyLz4KCjwvZGl2PgoKPGI+VsOpcmlmaWVyIGV0IHLDqXBhcmVyIGxhIHBh
cnRpdGlvbiDCq8KgL2Rldi9zZGEzwqDCuyAoNDY0LDE3wqBHaW8sIGJ0cmZzKcKgOiBFcnJl
dXI8L2I+PGJyLz4KCjwvZGl2PgoKCgo8L2JvZHk+CjwvaHRtbD4KCioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKgpMaWduZSBkZSBjb21tYW5kZSAKKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqCnN1ZG8gYnRyZnNjayAtcCAtRSAvZGV2L3NkYTMg
CkVSUk9SOiAvZGV2L3NkYTMgaXMgbm90IGEgdmFsaWQgbnVtZXJpYyB2YWx1ZQo=

--------------iXDYdnU9LgzZMuJZcUxpaRyH--

