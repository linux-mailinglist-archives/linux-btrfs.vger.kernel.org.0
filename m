Return-Path: <linux-btrfs+bounces-8134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2161E97CEDD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 23:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446611C2180B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 21:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746914A088;
	Thu, 19 Sep 2024 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYDcS84K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FE1CAA6
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782656; cv=none; b=K01cDJgLoIeD3h6bxVyIR4h9dUNgvWadkuFc2iHqH9B3Mf9/aQhS3lf79IcUtikxtP2vr7Bw3ZCFVeUk8kL+Fo7p8aed1FOL5yz3cw6r+m+e8hPQhMzVraAAxubPP5b/M83VcmgrAFkT9VtWcz502AGAF/R0r4gaPoQmPG04ah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782656; c=relaxed/simple;
	bh=hq6qwCrwo9Z8/4bjxUDSF9AiWqssyKqYb0W+t60WQ7w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mccGy6Lnmyv+HQQSqcaTjEuViut9qLKX2tksHwofDsybCaux2ItMv2f6Dmr6Js43DOpS5AcNcKJYQVd9R72AMVqElP/tzgIJtELv1cgPx1TRCZh4U/XS0BlXvregvVbJVthydm7xZHqinDs7bYQaw/fhhaqBshVxNy78V5nANwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYDcS84K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097E9C4CEC4
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 21:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726782655;
	bh=hq6qwCrwo9Z8/4bjxUDSF9AiWqssyKqYb0W+t60WQ7w=;
	h=From:To:Subject:Date:From;
	b=iYDcS84KH+9OukTqWY6TDWUHRA4DwtDK7FXH5Zk/O3W41gsTwGI/FZRMw6IZ0A2Nx
	 Q/vnHpKrRBrJv6tV7uB3W2yPOAeNY1vKLtgfO5RvGAKYkZU1U0CsUS79uREUDjCvub
	 JBgp0/LFwSZehPd+lQFKBPbnfZSnTzM4AbTPHLU0Au2cpS2HQ5OnfxDFFG6m51Ej87
	 6Im655MaAK8kAeBcKLfmqMbqnLWtIkjMFD6RB2z5Ha3NNQUpbXO7pYkLtFiJ/C4zVX
	 y0AXG2dtVC1AoCfvNSakzQH4SxNowEZzlYMw68qM6EXA9/3L9KcNI8rTVN+KvCFwAz
	 MjkbbLBO/j5Ww==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: fix buffer overflow detection when copying path to cache entry
Date: Thu, 19 Sep 2024 22:50:52 +0100
Message-Id: <ee24884b0255f717071ca932bda1ab398707d9cf.1726782272.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Starting with commit c0247d289e73 ("btrfs: send: annotate struct
name_cache_entry with __counted_by()") we annotated the variable length
array "name" from the name_cache_entry structure with __counted_by() to
improve overflow detection. However that alone was not correct, because
the length of that array does not match the "name_len" field - it matches
that plus 1 to include the nul string terminador, so that makes a
fortified kernel think there's an overflow and report a splat like this:

   Sep 15 23:32:17 sdslinux1 kernel: ------------[ cut here ]------------
   Sep 15 23:32:17 sdslinux1 kernel: strcpy: detected buffer overflow: 20
   byte write of buffer size 19
   Sep 15 23:32:17 sdslinux1 kernel: WARNING: CPU: 3 PID: 3310 at
   __fortify_report+0x45/0x50
   Sep 15 23:32:17 sdslinux1 kernel: Modules linked in: nfsd auth_rpcgss
   lockd grace nfs_acl bridge stp llc bonding tls vfat fat binfmt_misc
   snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common x8
   6_pkg_temp_thermal intel_powerclamp kvm_intel iTCO_wdt intel_pmc_bxt
   spi_intel_platform kvm at24 mei_wdt spi_intel mei_pxp
   iTCO_vendor_support mei_hdcp btusb snd_hda_codec_realtek btbcm btinte
   l snd_hda_scodec_component i915 rapl iwlwifi snd_hda_codec_generic btrtl
   intel_cstate btmtk cec snd_hda_intel intel_uncore cfg80211
   snd_intel_dspcfg drm_buddy coretemp snd_intel_sdw_acpi bluet
   ooth ttm pcspkr snd_hda_codec rfkill snd_hda_core snd_hwdep intel_vbtn
   snd_pcm mei_me drm_display_helper snd_timer sparse_keymap i2c_i801 mei
   snd i2c_smbus lpc_ich soundcore cdc_mbim cdc_wdm cdc_ncm cdc_ether
   usbnet crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
   polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3
   igb r8152 serio_raw i2c_algo_bit mii dca e1000e video wmi sunrpc
   Sep 15 23:32:17 sdslinux1 kernel: CPU: 3 UID: 0 PID: 3310 Comm: btrfs
   Not tainted 6.11.0-prnet #1
   Sep 15 23:32:17 sdslinux1 kernel: Hardware name: CompuLab Ltd.
   sbc-ihsw/Intense-PC2 (IPC2), BIOS IPC2_3.330.7 X64 03/15/2018
   Sep 15 23:32:17 sdslinux1 kernel: RIP: 0010:__fortify_report+0x45/0x50
   Sep 15 23:32:17 sdslinux1 kernel: Code: 48 8b 34 (...)
   Sep 15 23:32:17 sdslinux1 kernel: RSP: 0018:ffff97ebc0d6f650 EFLAGS:
   00010246
   Sep 15 23:32:17 sdslinux1 kernel: RAX: 7749924ef60fa600 RBX:
   ffff8bf5446a521a RCX: 0000000000000027
   Sep 15 23:32:17 sdslinux1 kernel: RDX: 00000000ffffdfff RSI:
   ffff97ebc0d6f548 RDI: ffff8bf84e7a1cc8
   Sep 15 23:32:17 sdslinux1 kernel: RBP: ffff8bf548574080 R08:
   ffffffffa8c40e10 R09: 0000000000005ffd
   Sep 15 23:32:17 sdslinux1 kernel: R10: 0000000000000004 R11:
   ffffffffa8c70e10 R12: ffff8bf551eef400
   Sep 15 23:32:17 sdslinux1 kernel: R13: 0000000000000000 R14:
   0000000000000013 R15: 00000000000003a8
   Sep 15 23:32:17 sdslinux1 kernel: FS:  00007fae144de8c0(0000)
   GS:ffff8bf84e780000(0000) knlGS:0000000000000000
   Sep 15 23:32:17 sdslinux1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
   0000000080050033
   Sep 15 23:32:17 sdslinux1 kernel: CR2: 00007fae14691690 CR3:
   00000001027a2003 CR4: 00000000001706f0
   Sep 15 23:32:17 sdslinux1 kernel: Call Trace:
   Sep 15 23:32:17 sdslinux1 kernel:  <TASK>
   Sep 15 23:32:17 sdslinux1 kernel:  ? __warn+0x12a/0x1d0
   Sep 15 23:32:17 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
   Sep 15 23:32:17 sdslinux1 kernel:  ? report_bug+0x154/0x1c0
   Sep 15 23:32:17 sdslinux1 kernel:  ? handle_bug+0x42/0x70
   Sep 15 23:32:17 sdslinux1 kernel:  ? exc_invalid_op+0x1a/0x50
   Sep 15 23:32:17 sdslinux1 kernel:  ? asm_exc_invalid_op+0x1a/0x20
   Sep 15 23:32:17 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
   Sep 15 23:32:17 sdslinux1 kernel:  __fortify_panic+0x9/0x10
   Sep 15 23:32:17 sdslinux1 kernel: __get_cur_name_and_parent+0x3bc/0x3c0
   Sep 15 23:32:17 sdslinux1 kernel:  get_cur_path+0x207/0x3b0
   Sep 15 23:32:17 sdslinux1 kernel:  send_extent_data+0x709/0x10d0
   Sep 15 23:32:17 sdslinux1 kernel:  ? find_parent_nodes+0x22df/0x25d0
   Sep 15 23:32:17 sdslinux1 kernel:  ? mas_nomem+0x13/0x90
   Sep 15 23:32:17 sdslinux1 kernel:  ? mtree_insert_range+0xa5/0x110
   Sep 15 23:32:17 sdslinux1 kernel:  ? btrfs_lru_cache_store+0x5f/0x1e0
   Sep 15 23:32:17 sdslinux1 kernel:  ? iterate_extent_inodes+0x52d/0x5a0
   Sep 15 23:32:17 sdslinux1 kernel:  process_extent+0xa96/0x11a0
   Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_lookup_backref_cache+0x10/0x10
   Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_store_backref_cache+0x10/0x10
   Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_iterate_backrefs+0x10/0x10
   Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_check_extent_item+0x10/0x10
   Sep 15 23:32:17 sdslinux1 kernel:  changed_cb+0x6fa/0x930
   Sep 15 23:32:17 sdslinux1 kernel:  ? tree_advance+0x362/0x390
   Sep 15 23:32:17 sdslinux1 kernel:  ? memcmp_extent_buffer+0xd7/0x160
   Sep 15 23:32:17 sdslinux1 kernel:  send_subvol+0xf0a/0x1520
   Sep 15 23:32:17 sdslinux1 kernel:  btrfs_ioctl_send+0x106b/0x11d0
   Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx___clone_root_cmp_sort+0x10/0x10
   Sep 15 23:32:17 sdslinux1 kernel:  _btrfs_ioctl_send+0x1ac/0x240
   Sep 15 23:32:17 sdslinux1 kernel:  btrfs_ioctl+0x75b/0x850
   Sep 15 23:32:17 sdslinux1 kernel:  __se_sys_ioctl+0xca/0x150
   Sep 15 23:32:17 sdslinux1 kernel:  do_syscall_64+0x85/0x160
   Sep 15 23:32:17 sdslinux1 kernel:  ? __count_memcg_events+0x69/0x100
   Sep 15 23:32:17 sdslinux1 kernel:  ? handle_mm_fault+0x1327/0x15c0
   Sep 15 23:32:17 sdslinux1 kernel:  ? __se_sys_rt_sigprocmask+0xf1/0x180
   Sep 15 23:32:17 sdslinux1 kernel:  ? syscall_exit_to_user_mode+0x75/0xa0
   Sep 15 23:32:17 sdslinux1 kernel:  ? do_syscall_64+0x91/0x160
   Sep 15 23:32:17 sdslinux1 kernel:  ? do_user_addr_fault+0x21d/0x630
   Sep 15 23:32:17 sdslinux1 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
   Sep 15 23:32:17 sdslinux1 kernel: RIP: 0033:0x7fae145eeb4f
   Sep 15 23:32:17 sdslinux1 kernel: Code: 00 48 89 (...)
   Sep 15 23:32:17 sdslinux1 kernel: RSP: 002b:00007ffdf1cb09b0 EFLAGS:
   00000246 ORIG_RAX: 0000000000000010
   Sep 15 23:32:17 sdslinux1 kernel: RAX: ffffffffffffffda RBX:
   0000000000000004 RCX: 00007fae145eeb4f
   Sep 15 23:32:17 sdslinux1 kernel: RDX: 00007ffdf1cb0ad0 RSI:
   0000000040489426 RDI: 0000000000000004
   Sep 15 23:32:17 sdslinux1 kernel: RBP: 00000000000078fe R08:
   00007fae144006c0 R09: 00007ffdf1cb0927
   Sep 15 23:32:17 sdslinux1 kernel: R10: 0000000000000008 R11:
   0000000000000246 R12: 00007ffdf1cb1ce8
   Sep 15 23:32:17 sdslinux1 kernel: R13: 0000000000000003 R14:
   000055c499fab2e0 R15: 0000000000000004
   Sep 15 23:32:17 sdslinux1 kernel:  </TASK>
   Sep 15 23:32:17 sdslinux1 kernel: ---[ end trace 0000000000000000 ]---
   Sep 15 23:32:17 sdslinux1 kernel: ------------[ cut here ]------------

Fix this by not storing the nul string terminator since we don't actually
need it for name cache entries, this way "name_len" corresponds to the
actual size of the "name" array. This requires marking the "name" array
field with __nonstring and using memcpy() instead of strcpy() as
recommended by the guidelines at:

   https://github.com/KSPP/linux/issues/90

Reported-by: David Arendt <admin@prnet.org>
Link: https://lore.kernel.org/linux-btrfs/cee4591a-3088-49ba-99b8-d86b4242b8bd@prnet.org/
Fixes: c0247d289e73 ("btrfs: send: annotate struct name_cache_entry with __counted_by()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7f48ba6c1c77..ae2872033601 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -346,8 +346,10 @@ struct name_cache_entry {
 	u64 parent_gen;
 	int ret;
 	int need_later_update;
+	/* Name length without NUL terminator. */
 	int name_len;
-	char name[] __counted_by(name_len);
+	/* Not NUL terminaed. */
+	char name[] __counted_by(name_len) __nonstring;
 };
 
 /* See the comment at lru_cache.h about struct btrfs_lru_cache_entry. */
@@ -2388,7 +2390,7 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	/*
 	 * Store the result of the lookup in the name cache.
 	 */
-	nce = kmalloc(sizeof(*nce) + fs_path_len(dest) + 1, GFP_KERNEL);
+	nce = kmalloc(sizeof(*nce) + fs_path_len(dest), GFP_KERNEL);
 	if (!nce) {
 		ret = -ENOMEM;
 		goto out;
@@ -2400,7 +2402,7 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	nce->parent_gen = *parent_gen;
 	nce->name_len = fs_path_len(dest);
 	nce->ret = ret;
-	strcpy(nce->name, dest->start);
+	memcpy(nce->name, dest->start, nce->name_len);
 
 	if (ino < sctx->send_progress)
 		nce->need_later_update = 0;
-- 
2.43.0


