Return-Path: <linux-btrfs+bounces-8142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B28CC97D39D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 11:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EAFB257C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2814386D;
	Fri, 20 Sep 2024 09:29:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mira.cbaines.net (mira.cbaines.net [212.71.252.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC013F431
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.252.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824585; cv=none; b=T6VaIgv6yQ3ypgCWIRfFUmpaMaYgHyqZM7n6NTP9LXlxl4CYnoGq0B/0bttPmQ3A2We13cBHh38G+N8JH17gpgPr9bcAWa4LRP/J5MiHaoGwg2VoPWZLtFTEw5wKSTZkBrE84ZB90Y4khwGCxbJLk7OfbUNN01EUDbaZMJuDonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824585; c=relaxed/simple;
	bh=9cd0NhadhB+I8pCldVqlOo4TlWy5HXc/MigGoCdQ9po=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKTsRQS1fXa8b/3X1OJpW4CicF9o1ep8wWGs1YQypynFuaR1fIEZ6iPncpeeUNoDq/zycuqXhYSdW/mAWvQm2AGQswc5zGEBbr27Ivi4Dn9DaOvjntD49zKZNLjVgRnicg9Ig3p5ghFRLbeVmuxFTJfacheAmNumsPgBSJVjyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cbaines.net; spf=pass smtp.mailfrom=cbaines.net; arc=none smtp.client-ip=212.71.252.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cbaines.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cbaines.net
Received: from localhost (unknown [212.132.255.81])
	by mira.cbaines.net (Postfix) with ESMTPSA id 8639427BBE2
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 10:22:53 +0100 (BST)
Received: from felis (localhost [127.0.0.1])
	by localhost (OpenSMTPD) with ESMTP id 990c1546
	for <linux-btrfs@vger.kernel.org>;
	Fri, 20 Sep 2024 09:22:52 +0000 (UTC)
From: Christopher Baines <mail@cbaines.net>
To: linux-btrfs@vger.kernel.org
Subject: kernel BUG at fs/btrfs/relocation.c:4498!
Date: Fri, 20 Sep 2024 10:22:50 +0100
Message-ID: <87ploy8ys5.fsf@cbaines.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I seem to have run in to some problems when trying to swap two new disks
for two old disks in a RAID 1 array. It currently looks like:

Label: none  uuid: f47f0803-0bdb-4152-93b6-c4719c64d459
        Total devices 6 FS bytes used 19.82TiB
        devid    1 size 5.46TiB used 5.46TiB path /dev/sdc1
        devid    2 size 5.46TiB used 5.46TiB path /dev/sde1
        devid    3 size 10.91TiB used 10.91TiB path /dev/sdf1
        devid    4 size 18.19TiB used 18.19TiB path /dev/sdd1
        devid    5 size 18.19TiB used 2.09GiB path /dev/sda1
        devid    6 size 18.19TiB used 4.84GiB path /dev/sdb1

I added the two new disks /dev/sda1 and /dev/sdb1, but then got errors
when trying to remove the two old disks /dev/sdc1 and /dev/sde1. I can't
figure out if the "parent transid verify failed" are recoverable from,
so I'm now trying to remove the two new disks so I can create a new
filesystem and copy the data over.

I can't seem to remove the two new disks though, the following command
segfaults:

btrfs device remove /dev/sda1 /dev/sdb1 /var/lib/nars
Segmentation fault


I see the following in /var/log/messages, any ideas?

Sep 20 10:14:29 localhost vmunix: [  280.448501] BTRFS info (device sdc1): =
relocating block group 39503958835200 flags data|raid1
Sep 20 10:14:37 localhost vmunix: [  288.187838] BTRFS info (device sdc1): =
found 1215 extents, stage: move data extents
Sep 20 10:14:39 localhost vmunix: [  289.282157] ------------[ cut here ]--=
----------
Sep 20 10:14:39 localhost vmunix: [  289.286774] kernel BUG at fs/btrfs/rel=
ocation.c:4498!
Sep 20 10:14:39 localhost vmunix: [  289.291815] Internal error: Oops - BUG=
: 00000000f2000800 [#1] PREEMPT SMP
Sep 20 10:14:39 localhost vmunix: [  289.298592] Modules linked in: btrfs b=
lake2b_generic libcrc32c xor xor_neon raid6_pq zstd_compress onboard_usb_hu=
b crct10dif
_ce rtc_fsl_ftm_alarm ipv6
Sep 20 10:14:39 localhost vmunix: [  289.312074] CPU: 12 PID: 4932 Comm: bt=
rfs Not tainted 6.8.7-arm64-generic #1
Sep 20 10:14:39 localhost vmunix: [  289.319113] Hardware name: SolidRun Lt=
d. SolidRun CEX7 Platform, BIOS EDK II Aug  9 2021
Sep 20 10:14:39 localhost vmunix: [  289.327190] pstate: 20000005 (nzCv dai=
f -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
Sep 20 10:14:39 localhost vmunix: [  289.334141] pc : btrfs_reloc_cow_block=
+0x218/0x22c [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.339651] lr : btrfs_force_cow_block=
+0x474/0x924 [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.345149] sp : ffff80008326b5e0
Sep 20 10:14:39 localhost vmunix: [  289.348451] x29: ffff80008326b5e0 x28:=
 ffff0a41a1c66000 x27: 00001a63ec748000
Sep 20 10:14:39 localhost vmunix: [  289.355579] x26: 0000000000000001 x25:=
 0000000000000001 x24: ffff0a42aa57c980
Sep 20 10:14:39 localhost vmunix: [  289.362706] x23: ffff0a41e227f0a8 x22:=
 ffff0a41a3d96800 x21: ffff0a424da6b2c0
Sep 20 10:14:39 localhost vmunix: [  289.369832] x20: ffff0a41c464e000 x19:=
 ffff0a41a1c66000 x18: 0000000000000001
Sep 20 10:14:39 localhost vmunix: [  289.376959] x17: 0000000000000000 x16:=
 ffffdd11142ddbf0 x15: 0000000000000000
Sep 20 10:14:39 localhost vmunix: [  289.384085] x14: 0000000000000000 x13:=
 0000000000000000 x12: 0000000000000001
Sep 20 10:14:39 localhost vmunix: [  289.391211] x11: 00000000000000b6 x10:=
 00000000ffffffff x9 : 0000000000000000
Sep 20 10:14:39 localhost vmunix: [  289.398337] x8 : 0000000000000000 x7 :=
 00002352f5098000 x6 : ffff000000000000
Sep 20 10:14:39 localhost vmunix: [  289.405463] x5 : 00000000001486f3 x4 :=
 ffff0a41c436b000 x3 : 00000000001486f2
Sep 20 10:14:39 localhost vmunix: [  289.412590] x2 : 0000000000000001 x1 :=
 0000000000000000 x0 : 00001a6405058000
Sep 20 10:14:39 localhost vmunix: [  289.419716] Call trace:
Sep 20 10:14:39 localhost vmunix: [  289.422151]  btrfs_reloc_cow_block+0x2=
18/0x22c [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.427302]  btrfs_force_cow_block+0x4=
74/0x924 [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.432452]  btrfs_cow_block+0xd8/0x2b=
8 [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.436994]  btrfs_search_slot+0x6d8/0=
xb24 [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.441795]  btrfs_delayed_ref_exit+0x=
43ac/0x4ee8 [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.447205]  btrfs_delayed_ref_exit+0x=
4c9c/0x4ee8 [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.452615]  btrfs_should_cancel_balan=
ce+0xa58/0xd7c [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.458285]  btrfs_relocate_block_grou=
p+0x240/0x378 [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.463868]  btrfs_relocate_chunk+0x3c=
/0x13c [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.468843]  btrfs_shrink_device+0x228=
/0x5ec [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.473818]  btrfs_rm_device+0x1d8/0x6=
14 [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.478447]  btrfs_flush_workqueue+0x2=
c98/0x515c [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.483769]  btrfs_ioctl+0x1618/0x2544=
 [btrfs]
Sep 20 10:14:39 localhost vmunix: [  289.488223]  __arm64_sys_ioctl+0xa8/0x=
ec
Sep 20 10:14:39 localhost vmunix: [  289.492138]  invoke_syscall+0x48/0x118
Sep 20 10:14:39 localhost vmunix: [  289.495881]  el0_svc_common.constprop.=
0+0x40/0xe8
Sep 20 10:14:39 localhost vmunix: [  289.500576]  do_el0_svc+0x20/0x2c
Sep 20 10:14:39 localhost vmunix: [  289.503881]  el0_svc+0x34/0xb8
Sep 20 10:14:39 localhost vmunix: [  289.506926]  el0t_64_sync_handler+0x13=
c/0x158
Sep 20 10:14:39 localhost vmunix: [  289.511271]  el0t_64_sync+0x190/0x194
Sep 20 10:14:39 localhost vmunix: [  289.514925] Code: 17ffffc2 f9401301 eb=
01001f 54fff760 (d4210000)=20
Sep 20 10:14:39 localhost vmunix: [  289.521006] ---[ end trace 00000000000=
00000 ]---
Sep 20 10:14:39 localhost vmunix: [  289.976689] note: btrfs[4932] exited w=
ith irqs disabled
Sep 20 10:14:39 localhost vmunix: [  289.981937] note: btrfs[4932] exited w=
ith preempt_count 1
Sep 20 10:14:39 localhost vmunix: [  289.987717] ------------[ cut here ]--=
----------
Sep 20 10:14:39 localhost vmunix: [  289.992331] WARNING: CPU: 12 PID: 0 at=
 kernel/context_tracking.c:128 ct_kernel_exit.constprop.0+0x98/0xa0
Sep 20 10:14:39 localhost vmunix: [  289.992341] Modules linked in: btrfs b=
lake2b_generic libcrc32c xor xor_neon raid6_pq zstd_compress onboard_usb_hu=
b crct10dif
_ce rtc_fsl_ftm_alarm ipv6
Sep 20 10:14:39 localhost vmunix: [  289.992360] CPU: 12 PID: 0 Comm: swapp=
er/12 Tainted: G      D            6.8.7-arm64-generic #1
Sep 20 10:14:39 localhost vmunix: [  289.992364] Hardware name: SolidRun Lt=
d. SolidRun CEX7 Platform, BIOS EDK II Aug  9 2021
Sep 20 10:14:39 localhost vmunix: [  289.992366] pstate: 200003c5 (nzCv DAI=
F -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
Sep 20 10:14:39 localhost vmunix: [  289.992370] pc : ct_kernel_exit.constp=
rop.0+0x98/0xa0
Sep 20 10:14:39 localhost vmunix: [  289.992375] lr : ct_idle_enter+0x10/0x=
1c
Sep 20 10:14:39 localhost vmunix: [  289.992379] sp : ffff8000801abd10
Sep 20 10:14:39 localhost vmunix: [  289.992381] x29: ffff8000801abd10 x28:=
 0000000000000000 x27: 0000000000000000
Sep 20 10:14:39 localhost vmunix: [  289.992387] x26: 0000000000000000 x25:=
 00000043849d4753 x24: ffff0a41a40f2800
Sep 20 10:14:39 localhost vmunix: [  289.992392] x23: ffffdd1115965d68 x22:=
 0000000000000001 x21: ffffdd1115965dd0
Sep 20 10:14:39 localhost vmunix: [  289.992398] x20: ffffdd1115d05ad8 x19:=
 ffff0a50b87afb50 x18: ffff80008326b168
Sep 20 10:14:39 localhost vmunix: [  289.992403] x17: 0000000000000000 x16:=
 ffffdd11134eaea8 x15: 0000000000000000
Sep 20 10:14:39 localhost vmunix: [  289.992408] x14: 0000000000000000 x13:=
 0000000000000000 x12: 0000000000000003
Sep 20 10:14:39 localhost vmunix: [  289.992413] x11: 071c71c71c71c71c x10:=
 ffff0a50b87b21a4 x9 : 000000000000377c
Sep 20 10:14:39 localhost vmunix: [  289.992419] x8 : 0000000000001c1c x7 :=
 ffff0a50b87b21c4 x6 : 00000000a796b599
Sep 20 10:14:39 localhost vmunix: [  289.992425] x5 : 4000000000000002 x4 :=
 ffff2d3fa37a1000 x3 : ffff8000801abd10
Sep 20 10:14:39 localhost vmunix: [  289.992430] x2 : 4000000000000000 x1 :=
 ffffdd111500eb50 x0 : ffffdd111500eb50
Sep 20 10:14:39 localhost vmunix: [  289.992435] Call trace:
Sep 20 10:14:39 localhost vmunix: [  289.992437]  ct_kernel_exit.constprop.=
0+0x98/0xa0
Sep 20 10:14:39 localhost vmunix: [  289.992442]  ct_idle_enter+0x10/0x1c
Sep 20 10:14:39 localhost vmunix: [  289.992446]  psci_cpu_suspend_enter+0x=
3c/0x90
Sep 20 10:14:39 localhost vmunix: [  289.992451]  acpi_processor_ffh_lpi_en=
ter+0x88/0x9c
Sep 20 10:14:39 localhost vmunix: [  289.992456]  acpi_idle_lpi_enter+0x48/=
0x64
Sep 20 10:14:39 localhost vmunix: [  289.992461]  cpuidle_enter_state+0x108=
/0x2d8
Sep 20 10:14:39 localhost vmunix: [  289.992465]  cpuidle_enter+0x38/0x50
Sep 20 10:14:39 localhost vmunix: [  289.992469]  do_idle+0x1fc/0x270
Sep 20 10:14:39 localhost vmunix: [  289.992474]  cpu_startup_entry+0x38/0x=
3c
Sep 20 10:14:39 localhost vmunix: [  289.992479]  secondary_start_kernel+0x=
130/0x150
Sep 20 10:14:39 localhost vmunix: [  289.992484]  __secondary_switched+0xb8=
/0xbc
Sep 20 10:14:39 localhost vmunix: [  289.992489] ---[ end trace 00000000000=
00000 ]---

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKlBAEBCgCPFiEEPonu50WOcg2XVOCyXiijOwuE9XcFAmbtPupfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDNF
ODlFRUU3NDU4RTcyMEQ5NzU0RTBCMjVFMjhBMzNCMEI4NEY1NzcRHG1haWxAY2Jh
aW5lcy5uZXQACgkQXiijOwuE9Xeivg//RDC+pjDa/ault9giiA2y8NqECj5eQTJE
8LTZBZ1QCniUvsrIBXHf+CSKesUxrTh16oJ8S6J71gDX8CN4NV5b7rrtAifi9uoI
GV4rcT5vkbEVuRTbdRU5qS3CAN0m7r/W9jHO859NuCl3GCr18Xfm1Jcsz2l9nE3M
p1L8d6o48BL0f0wz2veDMexU4rxDGPR/gqmC+EBdhiGHMx6z7m2aSOxOeKzv4y0u
KX7qmB8J0v0jGd2QKyZCbBKiDQn1QG5WaauOxJHQBLBS3kJX2qUyaYuGxqX9xxYA
ZvOJLm50rwuqf+EdiLtHuyJLET0TyUGOWMaWg9zxRh8zYrmDOHD+2H5J3YUL6kEU
mbWyOJjOzl+Lu559no8bkjriYT6/N1M+nUfTyXYbnI9OYN+dTl9im0h2qhnqP4mq
9aDokEo7WouJNZ9Q2wItM24qZS5fX33DHVT4eRCTh/QspcADeTqOuwK5NdKvZB63
3UgaAR+qn5EBBMsiGv6MYB+KVh/xwLTFlsaELTbrplBzVJbb1s/CDnXnOwRnLbVI
oiBn48Xb4NivPVdwzRQw1W4dMcDHRDJd/Rm3nqBADEXWX5+E7/F+QY0m9jEXtubw
Qbl0x4TRikYm7FPJWbndbUwPH7X6WOUT2JZXZxZ+pEY/z8cIXCgOHg1bjROZMDeB
PXw0zoBvAbE=
=wBXh
-----END PGP SIGNATURE-----
--=-=-=--

