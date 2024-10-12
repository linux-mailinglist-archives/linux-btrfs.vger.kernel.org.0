Return-Path: <linux-btrfs+bounces-8873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFBC99B202
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 10:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3841F22653
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF59145A03;
	Sat, 12 Oct 2024 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="KgzVCq6a";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="aK80M2MG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-4.smtp-out.eu-west-1.amazonses.com (a4-4.smtp-out.eu-west-1.amazonses.com [54.240.4.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF6137742
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Oct 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720633; cv=none; b=kY+nSStdLDFG7nvvt7+DzwawvnFg4+J7haFo6YP/6QxyMCTBguzA9qpUMYNkhrO4Iq2lbOx6P1dK80/3I8iSaDAh4nlpbitljHmITju9jsf7QOCjWJZeaS+HUcwaLQecOf9EimHXOgSCBotArMQ/UerpJejMEfjtw4VT+SpHJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720633; c=relaxed/simple;
	bh=nqhw4AXkOp/2V0D6AADK/LgN6VdNhrAeCNfdRutHHRA=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=H6xkr57bzq5rTddzq6JsWS+Ubweh96cXAv3OvAXRyDrsOBQORWZmlmRGzgzDuKg03RBODsWjQu0FH5bUOg/C0mZom68KTpltjhyOfeksusoglJqlJ8hwNDPpZce8rsSHnQJS4TqUZCfY0Ia4Ijg/rqjuVqIOXMyKJZVp8mCpysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=KgzVCq6a; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=aK80M2MG; arc=none smtp.client-ip=54.240.4.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1728720630;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type:Content-Transfer-Encoding;
	bh=nqhw4AXkOp/2V0D6AADK/LgN6VdNhrAeCNfdRutHHRA=;
	b=KgzVCq6aAWuNvLdJHBv5tmgYHNUwfjJWZs4/4Y6R2cw5MW6rcbUS7HC8+EiMaFDY
	VhZQZl9FeB7BLNokHMjnaIjx1dDzWzudp9a2f8PCs5SaMBplyln4kRoBSApDBnFV3Tm
	qkiBZ5o3eNaa6j4JR//oRctSSyCAwg7W2ArXwOwg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1728720630;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=nqhw4AXkOp/2V0D6AADK/LgN6VdNhrAeCNfdRutHHRA=;
	b=aK80M2MG4CfObIeF59Vp+VbnHhwPoS4L/A2529Kz4L3WSZXYoRfEJ/RyAEfM1Vhb
	X4mp/3gNZ7brdNbpSy+QcKhjxe8hZBtpw3Qq2uHVl88y4r+KRKhhI7kV3F/lfcDRbCu
	ktKcn70Cm+9u9nTDYTZnXFmSedZCq/6aPgwY+MuE=
Message-ID: <010201927fc76ecd-1130f575-7e05-469b-a721-d4ef98432dfe-000000@eu-west-1.amazonses.com>
Date: Sat, 12 Oct 2024 08:10:29 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martin Raiber <martin@urbackup.org>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: ENOSPC in btrfs_delete_unused_bgs (6.6)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2024.10.12-54.240.4.4

Hi,

currently getting following ENOSPC, remount to read-only after running for a few days:


[286211.180852] ------------[ cut here ]------------
[286211.180856] BTRFS: Transaction aborted (error -28)
[286211.180889] WARNING: CPU: 4 PID: 7160 at fs/btrfs/volumes.c:3198 btrfs_remove_chunk+0x96e/0x990
[286211.180898] Modules linked in: loop dm_crypt bfq xfs raid1 md_mod dm_mod st sr_mod cdrom bridge stp llc ext4 intel_rapl_msr crc16 intel_rapl_common mbcache jbd2 ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 snd_pcm sg hyperv_drm snd_timer drm_shmem_helper hyperv_key>
[286211.181012] CPU: 4 PID: 7160 Comm: btrfs-cleaner Tainted: G        W          6.6.54 #2
[286211.181016] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090007  05/18/2018
[286211.181019] RIP: 0010:btrfs_remove_chunk+0x96e/0x990
[286211.181024] Code: c5 fe ff ff be fb ff ff ff 48 c7 c7 20 71 b1 9b e8 87 59 b4 ff 0f 0b e9 df fe ff ff 89 ce 48 c7 c7 20 71 b1 9b e8 72 59 b4 ff <0f> 0b 8b 0c 24 e9 54 ff ff ff 89 ee 48 c7 c7 20 71 b1 9b e8 5a 59
[286211.181027] RSP: 0018:ffffacbecf35fd70 EFLAGS: 00010286
[286211.181031] RAX: 0000000000000000 RBX: ffff988e93a10d80 RCX: 0000000000000027
[286211.181034] RDX: ffff9892b92213c8 RSI: 0000000000000001 RDI: ffff9892b92213c0
[286211.181036] RBP: ffff988f186e2670 R08: 0000000000000000 R09: ffffacbecf35fc08
[286211.181039] R10: 0000000000000003 R11: ffffffff9c1e2408 R12: 00056d6f6c180000
[286211.181041] R13: ffff988eb96dc888 R14: 0000000000000001 R15: ffff988b5343a640
[286211.181044] FS:  0000000000000000(0000) GS:ffff9892b9200000(0000) knlGS:0000000000000000
[286211.181047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[286211.181050] CR2: 00007f1a32634340 CR3: 00000004773b0000 CR4: 00000000003506e0
[286211.181054] Call Trace:
[286211.181057]  <TASK>
[286211.181060]  ? btrfs_remove_chunk+0x96e/0x990
[286211.181064]  ? __warn+0x81/0x130
[286211.181071]  ? btrfs_remove_chunk+0x96e/0x990
[286211.181076]  ? report_bug+0x171/0x1a0
[286211.181081]  ? srso_return_thunk+0x5/0x5f
[286211.181086]  ? prb_read_valid+0x1b/0x30
[286211.181093]  ? handle_bug+0x41/0x70
[286211.181097]  ? exc_invalid_op+0x17/0x70
[286211.181101]  ? asm_exc_invalid_op+0x1a/0x20
[286211.181111]  ? btrfs_remove_chunk+0x96e/0x990
[286211.181122]  btrfs_delete_unused_bgs+0x70e/0x9b0
[286211.181134]  ? __pfx_cleaner_kthread+0x10/0x10
[286211.181139]  cleaner_kthread+0xf5/0x130
[286211.181144]  kthread+0xe8/0x120
[286211.181149]  ? __pfx_kthread+0x10/0x10
[286211.181153]  ret_from_fork+0x34/0x50
[286211.181159]  ? __pfx_kthread+0x10/0x10
[286211.181162]  ret_from_fork_asm+0x1b/0x30
[286211.181173]  </TASK>
[286211.181175] ---[ end trace 0000000000000000 ]---
[286211.181178] BTRFS info (device loop0: state A): dumping space info:
[286211.181181] BTRFS info (device loop0: state A): space_info DATA has 2241260216320 free, is not full
[286211.181185] BTRFS info (device loop0: state A): space_info total=27155909967872, used=7519504883712, pinned=0, reserved=5688012247040, may_use=11706058747904, readonly=1073872896 zone_unusable=0
[286211.181191] BTRFS info (device loop0: state A): space_info METADATA has 128141934592 free, is not full
[286211.181194] BTRFS info (device loop0: state A): space_info total=346287833088, used=199112523776, pinned=212992, reserved=24543232, may_use=19008618496, readonly=0 zone_unusable=0
[286211.181199] BTRFS info (device loop0: state A): space_info SYSTEM has 0 free, is not full
[286211.181202] BTRFS info (device loop0: state A): space_info total=4194304, used=3358720, pinned=32768, reserved=802816, may_use=0, readonly=0 zone_unusable=0
[286211.181207] BTRFS info (device loop0: state A): global_block_rsv: size 536870912 reserved 536002560
[286211.181210] BTRFS info (device loop0: state A): trans_block_rsv: size 1048576 reserved 1048576
[286211.181213] BTRFS info (device loop0: state A): chunk_block_rsv: size 0 reserved 0
[286211.181216] BTRFS info (device loop0: state A): delayed_block_rsv: size 1572864 reserved 1572864
[286211.181219] BTRFS info (device loop0: state A): delayed_refs_rsv: size 17007902720 reserved 17007902720
[286211.181222] BTRFS: error (device loop0: state A) in btrfs_remove_chunk:3198: errno=-28 No space left
[286211.181252] BTRFS info (device loop0: state EA): forced readonly


The device should have plenty of free space:

Overall:
    Device size:                  28.08TiB
    Device allocated:             25.07TiB
    Device unallocated:            3.02TiB
    Device missing:                  0.00B
    Device slack:               1023.97PiB
    Used:                         22.79TiB
    Free (estimated):              5.16TiB      (min: 5.16TiB)
    Free (statfs, df):             5.16TiB
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:24.75TiB, Used:22.61TiB (91.36%)
   /dev/loop0     24.75TiB

Metadata,single: Size:322.50GiB, Used:187.11GiB (58.02%)
   /dev/loop0    322.50GiB

System,single: Size:4.00MiB, Used:3.20MiB (80.08%)
   /dev/loop0      4.00MiB

Unallocated:
   /dev/loop0      3.02TiB

Regards,

Martin


