Return-Path: <linux-btrfs+bounces-3495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E3D8859E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 14:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F9E1C224AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2FF84A40;
	Thu, 21 Mar 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="RP7aFnqw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B2134CD
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027144; cv=none; b=IJeFHf+A/o7N/nV7mdyIXUXbbrFtZgR6QEpUEU8osRReyzJ0tbCw/zmlKjvIfHCvsstMzuPPX/UdTjuj2TzW0fFD7wKgqDmp1+mK0E7wsM/7oTJhgQaEwTokvSMc1Pzv+PQ0pf6qe+T8KAc9856DVsxlgNI4JakEJJQE5QS0vC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027144; c=relaxed/simple;
	bh=EhvcSMMLi7LmXj1acvdmFtpSieO9OsfP0sCOXXZC0DE=;
	h=Message-ID:Subject:From:To:Content-Type:Date:MIME-Version; b=Ivk3BXFL2hOeTqz5Ga2mquRx5gf+bF17qySQb7qSSIZf99QjsHGW8EU8f1cqN09LAsD+/CgDyhKnDgbdyfp6rmY+a2WDp+qWAjf4SIgqPtkJIYsnh7tuDWxXVcUbAZSA1/am6UE1DxCmRVZ5fONN/CkakfeDoBiVOp1fQE+kpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=RP7aFnqw; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1711027140; x=1711631940; i=massimo.b@gmx.net;
	bh=EhvcSMMLi7LmXj1acvdmFtpSieO9OsfP0sCOXXZC0DE=;
	h=X-UI-Sender-Class:Subject:From:To:Date;
	b=RP7aFnqwnFwBn2DSe9ZoPD6n831JD4068Nyo8v3XpVXsw0RpIlD2V7Fp7qrKoPHW
	 Rel/NLDH+gQd5Larq/koBod+XtUmhkl11u/FvFge+SfduaHe8qdWCWQWGmvcR5WLb
	 +kELVWcDzsFXS0MfAmZeKRjUpDdr15UmFiSXLUoRylQC6dmy0euyXAyLXviigUgIi
	 GtiLFwXTIX+hrgJSAgkQ6AdbaEsTYHxiWofW1qhlflm7EYkTpM6az0AayQiwHaIpn
	 nKEhNDXyp6Dt9OCEaX/oLSu2J9OUDlpKszUsPrbe01TPxAFmBnTKT8CTgdMvrA6Vq
	 Wdgy7xzOcwB/ymrgZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gmb ([46.114.6.140]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QFB-1rmTNG3VyP-001PGZ; Thu, 21
 Mar 2024 14:18:59 +0100
Message-ID: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
Subject: I/O blocked after booting
From: "Massimo B." <massimo.b@gmx.net>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Mar 2024 14:13:59 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.50.2 
X-Provags-ID: V03:K1:5lUd7zDAIXZ6w6RmVXh2Hs61IvhRUwjkkYDNGsZa95ueRoZOKUy
 XzwcTdrHVV5wWYINOxuP/KyQbXGHroOaSOOYNCRA9z+ZHkTF30gA27qkcKVkFKaulMxgjH+
 F6M3nH0LAYMbw7v7flidwIFL13HuIJanOU5Vs6OB+V0QLn6oXmkcIzkMAUQv3qwll51JyPC
 ohKnCq7bUYSzz9drs2wSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WgnIJy/sGQI=;sqX6/NFSbHtqkq6mp/UMZLLotQj
 o0YHdgqFasbbSou8lOFiwXNiVPtYcUi29T0w9klHP/db46FKI1KyCX93E+DeFhyc8zvp1edji
 hJnFUubkpHRwzeZEoE+jYT41W9UL0rvnix5Ua8pTdm95jZod5G9QUJ281izHnlCFvTXNefxrw
 a5l/R5JQ7bKUlK6faM+F1JDnylnqECyzDGi81Aer2/LIqzIAay9+zpS64IwvJuOH1snkChNKx
 VnBnmmx7dwx5GeYbQSr6TikcDfSOHMa+3wc3PfUSpS5rpxHl0Yk1G7opF1/IyEvyYtd8qZLaP
 0kMMdkvY5vKboNY8qi9dM15jlOg7GxYKJc+0CWIYlSCwapEHFW8TgDhpifrtaDxRSuAcG8tw/
 joXGXYsSsKLu/oYZ3N7/WKbdyN0ttWtnvpSAniTgYJpa164C4lkwqIwEa1R0xh156zb9SyPpG
 kiUc4AmS6kqBvE4AEm33jXWfmyGWnATJSwZIX/NhA04DGixk54hbO8ybef2991rbX/6cQMsA+
 /3FcmTLpQ/tOHJ/tQ3YbQmPF6c4izc++8zOrfa89CYOUSomcvi9yn9574bKu4g49HI9+1zYeb
 FHsbRUzcGKMIo0dyCAsWZGRq0hdcrHDfoPH2PyTg3/NbsGukqvqOMEabacsB3V88g0RUnnzcc
 izKcNSOhDn0T44/VJqvsBKeFBmU/sYApL1iHDSkzgT91yYbVYxrWQrHgaAaMfNOZhhvmPEhgd
 5YeRNoSKMayH6dbGB39UVpjwIbDbSnJ7MNv2WyqUalm4RiO2n1bloB26hKC24H0RUe82Nm7uW
 8h/4HWtiBw1weVOfrv0Rs5GqcB7otkCKiBMwKuag5K5k4=

Hello everybody,

I have this issue since years on all my desktop machines (but with almost
identical distribution and configurations):

Sometimes when booting the system, it comes up until the window manager wit=
h
login screen appears. But no further login is possible. Trying to login via
virtual terminals, SSH or trying to reboot, it appears that all I/O to the =
btrfs
is blocked. Also waiting for ~20 minutes doesn't help the filesystem is
blocking.

I thought that might happen on unclean shutdowns or stuff. But it's not
reproducible and also clean shutdowns sometimes lead to the same issue.

First I thought it's some of the btrfsmaintenance jobs. So finally I disabl=
ed
all of them:

# grep PERIOD /etc/default/btrfsmaintenance
BTRFS_DEFRAG_PERIOD=3D"none"
BTRFS_BALANCE_PERIOD=3D"none"
BTRFS_SCRUB_PERIOD=3D"monthly"
BTRFS_TRIM_PERIOD=3D"none"

No success.

What I can confirm, after doing a forced reboot by holy SYSRQ series R,E,I,=
S,U,B
the next startup is always fine and gets a working btrfs.
Then the first line on the screen before doing the reboot are:

sysrq: Keyboard mode set to system default
sysrq: Terminate All Tasks
elogind-daemon[4481]: Received signal 15 [TERM]

BTRFS info (device dm-2): first mount of filesystem 1d677-.....
BTRFS info (device dm-2): using crc32c (crc32c-intel checksum algorithm
BTRFS info (device dm-2): force zstd compression, level 15
BTRFS info (device dm-2): using free space tree
BTRFS warmomg (device dm-0): failed to trim 30 block group(s), last error -=
512
BTRFS warmomg (device dm-0): failed to trim 1 device(s), last error -512

I guess this dm-0 is my main btrfs on PCIe NVMe.

When successfully mounted the mount looks like this:

/dev/mapper/luks-801... on / type btrfs (rw,noatime,nodiratime,compress-
force=3Dzstd:3,ssd,discard=3Dasync,noacl,space_cache=3Dv2,subvolid=3D524,su=
bvol=3D/volumes
/root)

Current kernel is 6.6.13-gentoo, though I don't think that is important as =
I
have the issue for years with all previous kernels.
I'm not only using the self-configured kernel from gentoo-sources but also =
a
universal binary 6.6.16-gentoo-dist.

I thought, maybe my btrbk run by cron could be the culprit. Looking at the
syslogs, before the blocked I/O I see some very last lines in the log, wher=
e
btrbk was started. Right after that the next line is the next boot:

Mar 19 07:43:40 [chronyd] System clock wrong by -3.227396 seconds
Mar 19 07:43:40 [chronyd] System clock was stepped by -3.227396 seconds
Mar 19 07:44:00 [fcron] pam_unix(fcron:session): session opened for user cl=
amav(uid=3D130) by (uid=3D0)
Mar 19 07:44:00 [fcron] Job 'fangfrisch -c /etc/fangfrisch.conf refresh' st=
arted for user clamav (pid 4977)
Mar 19 07:44:00 [fcron] Job 'ionice -c 3 schedtool -D -e btrbk -c /etc/btrb=
k/btrbk.conf run cron && /usr/local/bin/1update_btrbksnapshotlinks -c /etc/=
btrbk/btrbk.conf /mnt/archive/*/* / (truncated)
Mar 19 07:44:00 [fcron] Job 'run-parts /etc/cron.daily' started for user sy=
stab (pid 4984)
Mar 19 07:44:00 [fcron] Job 'run-parts /etc/cron.weekly' started for user s=
ystab (pid 4987)
Mar 19 07:47:32 [kernel] Linux version 6.6.13-gentoo (root@gentoo) (gcc (Ge=
ntoo 13.2.1_p20230826 p7) 13.2.1 20230826, GNU ld (Gentoo 2.40 p7) 2.40.0) =
#1 SMP PREEMPT_DYNAMIC Mon Jan 22 11:11:15 CET 2024

Actually btrbk works fine when the system is up and running, either started
manually or from the cron job. What could happen to block all btrfs IO? How=
 can
I debug that?

Best regards,
Massimo

