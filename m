Return-Path: <linux-btrfs+bounces-6668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E3C93A989
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 00:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201C82843B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 22:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39401494C1;
	Tue, 23 Jul 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TiMC9krl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mo2szScs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46A148FF2
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775443; cv=none; b=eUvkpdyS2AgPDH+h0NdZPRUbqFJqP+gM0zsSBBqjfV3MrNxjMfOlNFX3qHxE8Dc3IH48pHGAIlC4pt2JZOpB+SyJYjeb+9yXaQLMnGWYBkmxWrCpIMYUMlYP9frNMPWfTqtAkOP/B2pM+ztyuyaWBvOnyTm8i9qC0/T+u4gnheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775443; c=relaxed/simple;
	bh=BMuvsHk6Ybt82ReMh7mP7xjvfbOzw6JvseQmK9W9dn8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXe0f8ZU1E/5MksoDzeIfYKVBbJUiFU/3x32MeI7L0H+veQPmpLZ6xRWBGUfyAfK1a9AdQF7U7qgFTNL8qPZIeseXprpHS8l+9iWuWP6K1kCPrZudMXCLYrVPDh0RvUEqTn8lW/c3eKFYBBBJoAGx2lcu5kA6Z+5HsnijUrDWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TiMC9krl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mo2szScs; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 187BC1140103;
	Tue, 23 Jul 2024 18:57:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 Jul 2024 18:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1721775441; x=
	1721861841; bh=YKqaNtpIK34ITkErnVCiFysUwV17LFkXKcKfatrCcEc=; b=T
	iMC9krllGpYWKCcWZBQWvguFCnOCE/U4c0QNzDmHXhbhxoEszf5n5qCPOM6f6ccQ
	ZibzYmPqObsoalnPFFJSwOkN1237N8GwLv2yLDVZ8zkmZWNbtJGRIKYuJvNRoAch
	24aMqQm+jRFmhpeVURNPkb2Rv7N9hcst9HvMXeHJydn6EgtuUE4ksR1GdmRnPKJe
	34K3jSs3V7gqQRWfHvL4th2fBuWKwJgvmkguXhaZbJ09YnH6nlLJqVSZx0wiTzss
	Id5AbEVtd4wbj1/bfIaKLYIfv5wuhWf7mOx2IB8N4BFAQP+We/Kavdx6GQm6wOxz
	XeQDukIWLwPKK5+RhstQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1721775441; x=1721861841; bh=YKqaNtpIK34IT
	kErnVCiFysUwV17LFkXKcKfatrCcEc=; b=Mo2szScs+3CBpoLOegyyNP7yHGEw9
	Z7TVxr5xbv3oduf8/HN8xiil//L/wIZaynC4ZEO3HbfdFEH3b0mxBS/fFq58gr3Y
	9/U9l1BMRvP25aZ0irnX1S4Fqt2kXkVZjBSE6dEXQjW3SRGox5OUfbb1q0yw1cyG
	911jy2ga/DSqx4uubSGoRmqFoUCKO2WRMPhAMWgQbBIWMBAlA1IvPsNST2VIaKX2
	+OFF9R8GDgt8Oy3E+mcq/uOALmM4KRRPgsREVcR+/UqlS6U+XiGmfgedlw3M8/hI
	SFr9RkzXMraqTVz0qUTQm9QcDI/7qf+Ovii0qvo0yU9PR6jJE7G5hW2bg==
X-ME-Sender: <xms:UDWgZnoVvVJWTmUr99gpNRmJEgRKxM6T0WDrIf4wAMLElebF9WMbwg>
    <xme:UDWgZhrdO_xGpL5umuyLPcr0Ficu0z8QWrdDhsxZupx5OUi-x9acv1tSCDLmUBS-O
    3lNuSL1TTUfXNlBMzQ>
X-ME-Received: <xmr:UDWgZkPYeoUyV3aXCV_fVGf53OQU92StduueThA2QDmIbmZymou8PSHQkhUrqks7wIccr0Q2a948B8ccYuv847kYxh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:UTWgZq6yQfDVReptnGemsvlg4exCeGkRB35TOiwAxzWbMKkGv01S6g>
    <xmx:UTWgZm4sLSue1p0NQqDGL22EsrjYLngU3HzFIV-NNHUerR8no2N52A>
    <xmx:UTWgZihbddKcSoq34OvsBd-Vm6tCjaQyVte97Qb2l-xdXsSPIQlJxA>
    <xmx:UTWgZo5RWzdJ-6kCYfCndwo6EbZJatWAl-ccH_ZsgQy2xzhRRJ7dZg>
    <xmx:UTWgZmEZHBpQs5YWUGLEAy_ETIbm1sMBjVzoN6W5A0Yr_0nw_5Q8LRUA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 18:57:20 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: fix qgroup rsv leaks in cow_file_range
Date: Tue, 23 Jul 2024 15:55:57 -0700
Message-ID: <81a472c49ed24d85ed3c164ac46b8d4e6cc9d1e1.1721775142.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721775142.git.boris@bur.io>
References: <cover.1721775142.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the buffered write path, the dirty page owns the qgroup rsv until it
creates an ordered_extent.

Therefore, any errors that occur before the ordered_extent is created
must free that reservation, or else the space is leaked. The fstest
generic/475 exercises various IO error paths, and is able to trigger
errors in cow_file_range where we fail to get to allocating the ordered
extent. Note that because we *do* clear delalloc, we are likely to
remove the inode from the delalloc list, so the inodes/pages to not have
invalidate/launder called on them in the commit abort path.

This results in failures at the unmount stage of the test that look like:

[ 1903.401193] BTRFS: error (device dm-8 state EA) in
cleanup_transaction:2018: errno=-5 IO failure
[ 1903.402686] BTRFS: error (device dm-8 state EA) in
btrfs_replace_file_extents:2416: errno=-5 IO failure
[ 1903.446415] BTRFS warning (device dm-8 state EA): qgroup 0/5 has
unreleased space, type 0 rsv 28672
[ 1903.447887] ------------[ cut here ]------------
[ 1903.448645] WARNING: CPU: 3 PID: 22588 at fs/btrfs/disk-io.c:4333
close_ctree+0x222/0x4d0 [btrfs]
[ 1903.450130] Modules linked in: btrfs blake2b_generic libcrc32c xor
zstd_compress raid6_pq
[ 1903.451408] CPU: 3 PID: 22588 Comm: umount Kdump: loaded Tainted: G
W          6.10.0-rc7-gab56fde445b8 #21
[ 1903.453058] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Arch Linux 1.16.3-1-1 04/01/2014
[ 1903.454542] RIP: 0010:close_ctree+0x222/0x4d0 [btrfs]
[ 1903.455417] Code: 4d c0 48 c7 c6 a0 92 4d c0 48 c7 c7 78 82 4d c0 e8
63 22 36 d7 90 0f 0b f0 80 4b 10 02 48 89 df e8 33 dc fb ff 84 c0 74 13
90 <0f> 0b 90 48 c7 c6 c8 92 4d c0 48 89 df e8 0c 22 01 00 48 89 df e8
[ 1903.458317] RSP: 0018:ffffb4465283be00 EFLAGS: 00010202
[ 1903.459159] RAX: 0000000000000001 RBX: ffffa1a1818e1000 RCX:
0000000000000001
[ 1903.460286] RDX: 0000000000000000 RSI: ffffb4465283bbe0 RDI:
ffffa1a19374fcb8
[ 1903.461408] RBP: ffffa1a1818e13c0 R08: 0000000100028b16 R09:
0000000000000000
[ 1903.462555] R10: 0000000000000003 R11: 0000000000000003 R12:
ffffa1a18ad7972c
[ 1903.463679] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
[ 1903.464803] FS:  00007f9168312b80(0000) GS:ffffa1a4afcc0000(0000)
knlGS:0000000000000000
[ 1903.466082] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1903.467004] CR2: 00007f91683c9140 CR3: 000000010acaa000 CR4:
00000000000006f0
[ 1903.468124] Call Trace:
[ 1903.468548]  <TASK>
[ 1903.468890]  ? close_ctree+0x222/0x4d0 [btrfs]
[ 1903.469689]  ? __warn.cold+0x8e/0xea
[ 1903.470260]  ? close_ctree+0x222/0x4d0 [btrfs]
[ 1903.471052]  ? report_bug+0xff/0x140
[ 1903.471646]  ? handle_bug+0x3b/0x70
[ 1903.472212]  ? exc_invalid_op+0x17/0x70
[ 1903.472838]  ? asm_exc_invalid_op+0x1a/0x20
[ 1903.473518]  ? close_ctree+0x222/0x4d0 [btrfs]
[ 1903.474283]  generic_shutdown_super+0x70/0x160
[ 1903.475005]  kill_anon_super+0x11/0x40
[ 1903.475630]  btrfs_kill_super+0x11/0x20 [btrfs]
[ 1903.476405]  deactivate_locked_super+0x2e/0xa0
[ 1903.477125]  cleanup_mnt+0xb5/0x150
[ 1903.477699]  task_work_run+0x57/0x80
[ 1903.478267]  syscall_exit_to_user_mode+0x121/0x130
[ 1903.479056]  do_syscall_64+0xab/0x1a0
[ 1903.479658]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1903.480467] RIP: 0033:0x7f916847a887
[ 1903.481034] Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44
00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 71 25 0d 00 f7 d8 64 89 02 b8
[ 1903.483951] RSP: 002b:00007ffe035d1648 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[ 1903.485153] RAX: 0000000000000000 RBX: 000056074eba0508 RCX:
00007f916847a887
[ 1903.486244] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
000056074eba0810
[ 1903.487128] RBP: 0000000000000000 R08: 00007ffe035d03f0 R09:
0000000000000001
[ 1903.488010] R10: 0000000000000103 R11: 0000000000000246 R12:
00007f91685cc22c
[ 1903.488905] R13: 000056074eba0810 R14: 0000000000000000 R15:
000056074eba0400
[ 1903.489792]  </TASK>
[ 1903.490071] ---[ end trace 0000000000000000 ]---
[ 1903.490657] BTRFS error (device dm-8 state EA): qgroup reserved space leaked

Cases 2 and 3 in the out_reserve path both pertain to this type of leak
and must free the reserved qgroup data. Because it is already an error
path, I opted not to handle the possible errors in
btrfs_free_qgroup_data.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c5155981f99a..06337aee856a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1581,6 +1581,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					     locked_page, &cached,
 					     clear_bits,
 					     page_ops);
+		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
 		start += cur_alloc_size;
 	}
 
@@ -1594,6 +1595,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
 		extent_clear_unlock_delalloc(inode, start, end, locked_page,
 					     &cached, clear_bits, page_ops);
+		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
 	}
 	return ret;
 }
@@ -2255,6 +2257,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
 					     PAGE_END_WRITEBACK);
+		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
 	}
 	btrfs_free_path(path);
 	return ret;
-- 
2.45.2


