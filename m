Return-Path: <linux-btrfs+bounces-20246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3FD039FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 16:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 449903028CAB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A389B3033F8;
	Thu,  8 Jan 2026 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="Rrp0yeH7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CD23EAA4
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884008; cv=none; b=aPTJUK5mCQs/It/2BzLEoxr9+0pp0wPftMl2lEHK33dXgn1cnMY79tbzIBx3hLjn/Bk+dwkQjt1gGsAo+mGr68EW8kGaMQxMLMJCk6exKVFOLuRfMl+gtd2m+Tub/FHIkWHfh5/dA6On4TMy9MeY94SVVAlgXxF/nfbc0dI2Dv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884008; c=relaxed/simple;
	bh=gD3EkaPn+d7Tw0QG37jJypwi8DTw+b7GOx3AUmuR/00=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=owusHwuWG/RkGGcVnRKdYkDUPGIVKrSp36AyBtck1v2DCzMuy5OMt2X7nJ6EU6wUi3u+l/KxIPNt6SzUqe8LPyyBPRwKX7/kFjAB+no5afPf3+pC7cZdItDpLTWkdj2NE5jJtXDY63S/APYV/Dm40q2JrPmx1Ag7KTG6UpMFWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=Rrp0yeH7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1767884004; x=1768488804; i=jimis@gmx.net;
	bh=WsjhZOLE8k8ZpNTFR3tldjBaTThrPdBLeh48Ji+Pi4s=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Rrp0yeH7lDpqaIssPfUJkJOJB8OP985M0cOmsSZy3PA231NVEZcfnCJQmCfP7ipv
	 N8a7M4kBpVwBDA1ptNJAGtv9958RafobNH5GTTFRlhiBrnIP3lX0lPNVDvru1i7vh
	 skGus454wbm2W65/MgqmqkFbek+dkwUxh1dNNoXKFqXXAfTvWjY4ogkmiQCinCojd
	 3nIRVWlyY8qtTkN1LayXTzXgGN8KcCa3KGlKKg1pkQnqOveN6ok8R5Qmod8SebEOU
	 l447RGtZYm7WnmyakeHC85W9x8hdBJHAIPyG39WRQkL2J8q+vPFL3XRfeg2bUaFIJ
	 Yybg80geSYr3RmQmAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.66] ([185.55.106.54]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1vMByl3tUu-00NxMr for
 <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 15:53:24 +0100
Date: Thu, 8 Jan 2026 15:53:17 +0100 (CET)
From: Dimitrios Apostolou <jimis@gmx.net>
To: linux-btrfs@vger.kernel.org
Subject: error in btrfs_create_pending_block_groups:2788: errno=-17 Object
 already exists
Message-ID: <q7760374-q1p4-029o-5149-26p28421s468@tzk.arg>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Provags-ID: V03:K1:D5jWz5h3Uw6wMAqJIA0AQ135dhHuzMYM/gi5su4gVChwFDRw3YQ
 hmftPDs2ZbuuySlmP7pVEG0DEN4C1aVcsvM6ApzBa1aFAROVm9oh9aQgvlsX8zjw7bc2f3a
 HD7TXXnX8p99ZkzOvxkr7p8TLBu5N4OcS3I5z/ZMdUGVc1H57ZRX3tzSPe9ESL/Q4Qm3Rf6
 AJhtyzcYNhCeUuPrSElJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TJcZEfGKOtU=;nvL9NRNoHWlinolUCrMI0JapB9q
 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
 H7pVQ==
Content-Transfer-Encoding: quoted-printable

Hello list,

I got an error while copying recursively (cp -a) several TBs of GB-sized=
=20
files, from an old zstd:3 compressed btrfs filesystem, to a newly=20
created same-settings (zstd:3 compressed) btrfs filesystem. Error=20
happened after many hours of copying, without any issues or log messages=
=20
before that. No hardware errors were logged either.

OS: Ubuntu 24.04 with HWE kernel 6.14.0-37-generic.

The kernel source code should be about this one here:
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/noble/t=
ree/fs/btrfs/block-group.c?h=3Dhwe-6.14-next#n2788


Mkfs output:

# mkfs.btrfs /dev/sde
btrfs-progs v6.6.3
See https://btrfs.readthedocs.io for more information.

Performing full device TRIM /dev/sde (10.00TiB) ...
NOTE: several default settings have changed in version 5.15, please make=
=20
sure
       this does not affect your deployments:
       - DUP for metadata (-m dup)
       - enabled no-holes (-O no-holes)
       - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               ff746273-9a0d-419c-9cc0-efe1c85b5857
Node size:          16384
Sector size:        4096
Filesystem size:    10.00TiB
Block group profiles:
   Data:             single            8.00MiB
   Metadata:         DUP               1.00GiB
   System:           DUP               8.00MiB
SSD detected:       yes
Zoned device:       no
Incompat features:  extref, skinny-metadata, no-holes, free-space-tree
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  1
Devices:
    ID        SIZE  PATH
     1    10.00TiB  /dev/sde


Kernel stacktrace:

[Jan 7 21:02] ------------[ cut here ]------------
[  +0.000005] BTRFS: Transaction aborted (error -17)
[  +0.000039] WARNING: CPU: 9 PID: 5589 at fs/btrfs/block-group.c:2788 btr=
fs_create_pending_block_groups+0x525/0x5a0 [btrfs]
[  +0.000071] Modules linked in: tls udp_diag tcp_diag inet_diag qrtr vsoc=
k_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsoc=
k cfg80211 binfmt_misc intel_rapl_msr intel_rapl_common intel_uncore_frequ=
ency_common isst_if_common skx_edac_common nfit rapl vmw_balloon vmwgfx i2=
c_piix>
[  +0.000036] CPU: 9 UID: 0 PID: 5589 Comm: btrfs-transacti Not tainted 6.=
14.0-37-generic #37~24.04.1-Ubuntu
[  +0.000003] Hardware name: VMware, Inc. VMware Virtual Platform/440BX De=
sktop Reference Platform, BIOS 6.00 11/12/2020
[  +0.000002] RIP: 0010:btrfs_create_pending_block_groups+0x525/0x5a0 [btr=
fs]
[  +0.000049] Code: 48 8b 7d 98 e8 ac 9a f6 ff e9 45 fd ff ff 4c 89 ef e8 =
7f 23 3a f9 e9 ff fc ff ff 44 89 e6 48 c7 c7 d8 07 67 c0 e8 7b 19 ff f8 <0=
f> 0b e9 5e fe ff ff 44 89 e6 48 c7 c7 d8 07 67 c0 e8 65 19 ff f8
[  +0.000001] RSP: 0018:ffffcf0b0469fd58 EFLAGS: 00010246
[  +0.000002] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
00000
[  +0.000002] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[  +0.000000] RBP: ffffcf0b0469fde8 R08: 0000000000000000 R09: 00000000000=
00000
[  +0.000001] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fff=
fffef
[  +0.000001] R13: ffff8a86290e2840 R14: ffff8a8bb2f8c118 R15: ffff8a82c07=
cf2a0
[  +0.000001] FS:  0000000000000000(0000) GS:ffff8a91bfa80000(0000) knlGS:=
0000000000000000
[  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 000074cdbd8053e8 CR3: 0000000caf7c0003 CR4: 00000000007=
70ef0
[  +0.000025] PKRU: 55555554
[  +0.000002] Call Trace:
[  +0.000001]  <TASK>
[  +0.000003]  btrfs_commit_transaction+0x7d/0xc50 [btrfs]
[  +0.000051]  ? hrtimers_cpu_dying+0x130/0x1f0
[  +0.000004]  transaction_kthread+0x167/0x1d0 [btrfs]
[  +0.000042]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[  +0.000038]  kthread+0xfb/0x230
[  +0.000003]  ? __pfx_kthread+0x10/0x10
[  +0.000002]  ret_from_fork+0x47/0x70
[  +0.000003]  ? __pfx_kthread+0x10/0x10
[  +0.000001]  ret_from_fork_asm+0x1a/0x30
[  +0.000004]  </TASK>
[  +0.000001] ---[ end trace 0000000000000000 ]---
[  +0.000002] BTRFS: error (device sde state A) in btrfs_create_pending_bl=
ock_groups:2788: errno=3D-17 Object already exists
[  +0.000014] BTRFS info (device sde state EA): forced readonly
[  +0.000603] BTRFS warning (device sde state EA): Skipping commit of abor=
ted transaction.



Any ideas?

Thank you in advance,
Dimitris


