Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500E9661E99
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jan 2023 07:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjAIGLj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Jan 2023 01:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjAIGLi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Jan 2023 01:11:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8303A195;
        Sun,  8 Jan 2023 22:11:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B28D3430B;
        Mon,  9 Jan 2023 06:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673244696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndzPNsUCO70JQRIDapRiknVFqDnpri0cFfgnMBt385M=;
        b=eSmSXJfisUkZvDGBr0uHD4450Mz8VEgt2/5K9FDcScTS/AlhJWnY3y4mWttuvV7HGTnpPl
        Qbax5G8TzD4ADhxSKgQZUvyXNKCChCf3APfh1QQ2vECnOjfQ5mUbjt6A2JxqSsbonyW2LT
        rzIwpa8FB23K26SzsnHlBskFCDhQLHw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08A98134AD;
        Mon,  9 Jan 2023 06:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EJdoMRawu2PJGgAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 09 Jan 2023 06:11:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>, stable@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: fix resolving backrefs for inline extent followed by prealloc
Date:   Mon,  9 Jan 2023 14:11:16 +0800
Message-Id: <560840afc3e63bbe5d9c5ef6b2ecf8f3589adff6.1672970015.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <e8b3a59de5f43c185427a8d87c303ba3e8ff6ff1.1673244671.git.wqu@suse.com>
References: bsc#1206456
MIME-Version: 1.0
Git-commit: 560840afc3e63bbe5d9c5ef6b2ecf8f3589adff6
Patch-mainline: v6.2-rc3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

If a file consists of an inline extent followed by a regular or prealloc
extent, then a legitimate attempt to resolve a logical address in the
non-inline region will result in add_all_parents reading the invalid
offset field of the inline extent. If the inline extent item is placed
in the leaf eb s.t. it is the first item, attempting to access the
offset field will not only be meaningless, it will go past the end of
the eb and cause this panic:

  [17.626048] BTRFS warning (device dm-2): bad eb member end: ptr 0x3fd4 start 30834688 member offset 16377 size 8
  [17.631693] general protection fault, probably for non-canonical address 0x5088000000000: 0000 [#1] SMP PTI
  [17.635041] CPU: 2 PID: 1267 Comm: btrfs Not tainted 5.12.0-07246-g75175d5adc74-dirty #199
  [17.637969] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
  [17.641995] RIP: 0010:btrfs_get_64+0xe7/0x110
  [17.649890] RSP: 0018:ffffc90001f73a08 EFLAGS: 00010202
  [17.651652] RAX: 0000000000000001 RBX: ffff88810c42d000 RCX: 0000000000000000
  [17.653921] RDX: 0005088000000000 RSI: ffffc90001f73a0f RDI: 0000000000000001
  [17.656174] RBP: 0000000000000ff9 R08: 0000000000000007 R09: c0000000fffeffff
  [17.658441] R10: ffffc90001f73790 R11: ffffc90001f73788 R12: ffff888106afe918
  [17.661070] R13: 0000000000003fd4 R14: 0000000000003f6f R15: cdcdcdcdcdcdcdcd
  [17.663617] FS:  00007f64e7627d80(0000) GS:ffff888237c80000(0000) knlGS:0000000000000000
  [17.666525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [17.668664] CR2: 000055d4a39152e8 CR3: 000000010c596002 CR4: 0000000000770ee0
  [17.671253] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [17.673634] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [17.676034] PKRU: 55555554
  [17.677004] Call Trace:
  [17.677877]  add_all_parents+0x276/0x480
  [17.679325]  find_parent_nodes+0xfae/0x1590
  [17.680771]  btrfs_find_all_leafs+0x5e/0xa0
  [17.682217]  iterate_extent_inodes+0xce/0x260
  [17.683809]  ? btrfs_inode_flags_to_xflags+0x50/0x50
  [17.685597]  ? iterate_inodes_from_logical+0xa1/0xd0
  [17.687404]  iterate_inodes_from_logical+0xa1/0xd0
  [17.689121]  ? btrfs_inode_flags_to_xflags+0x50/0x50
  [17.691010]  btrfs_ioctl_logical_to_ino+0x131/0x190
  [17.692946]  btrfs_ioctl+0x104a/0x2f60
  [17.694384]  ? selinux_file_ioctl+0x182/0x220
  [17.695995]  ? __x64_sys_ioctl+0x84/0xc0
  [17.697394]  __x64_sys_ioctl+0x84/0xc0
  [17.698697]  do_syscall_64+0x33/0x40
  [17.700017]  entry_SYSCALL_64_after_hwframe+0x44/0xae
  [17.701753] RIP: 0033:0x7f64e72761b7
  [17.709355] RSP: 002b:00007ffefb067f58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  [17.712088] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f64e72761b7
  [17.714667] RDX: 00007ffefb067fb0 RSI: 00000000c0389424 RDI: 0000000000000003
  [17.717386] RBP: 00007ffefb06d188 R08: 000055d4a390d2b0 R09: 00007f64e7340a60
  [17.719938] R10: 0000000000000231 R11: 0000000000000246 R12: 0000000000000001
  [17.722383] R13: 0000000000000000 R14: 00000000c0389424 R15: 000055d4a38fd2a0
  [17.724839] Modules linked in:

Fix the bug by detecting the inline extent item in add_all_parents and
skipping to the next extent item.

CC: stable@vger.kernel.org # 4.9+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 21c92c74bf71..46851511b661 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -484,6 +484,7 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 	u64 wanted_disk_byte = ref->wanted_disk_byte;
 	u64 count = 0;
 	u64 data_offset;
+	u8 type;
 
 	if (level != 0) {
 		eb = path->nodes[level];
@@ -538,6 +539,9 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 			continue;
 		}
 		fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
+		type = btrfs_file_extent_type(eb, fi);
+		if (type == BTRFS_FILE_EXTENT_INLINE)
+			goto next;
 		disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
 		data_offset = btrfs_file_extent_offset(eb, fi);
 
-- 
2.39.0

