Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0876CA4A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjHBKEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 06:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjHBKD7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 06:03:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986312710
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 03:02:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9481E219F8;
        Wed,  2 Aug 2023 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690970561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/cvMkW8Kj/6lKYtJdKRtnMOBUKXn+A5Ui1tby3DMCM=;
        b=JlYaPTjNfITTXXYeDPBx6IBilgIXSSjrAY2pjyjAn7nIKLyuErBOc1jhHr1V7h3kWTFI/I
        3v/dyaYvhp8bJFqlN9P0e3PU5ZNBSXw4o0BGf9zhIplzWjrlMPhKHwLXcTuRGd81cPLE+N
        g9U8cMb8yGljWcOM9v7h5X2YWf2iMBM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C0A213909;
        Wed,  2 Aug 2023 10:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KG8KGMApymQDeAAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 02 Aug 2023 10:02:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Subject: [PATCH v2 1/3] btrfs: avoid race with qgroup tree creation and relocation
Date:   Wed,  2 Aug 2023 18:02:19 +0800
Message-ID: <f72bd0cd2198d017d31f7f797546944b2afdd4ab.1690970028.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690970028.git.wqu@suse.com>
References: <cover.1690970028.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Syzbot reported a weird ASSERT() triggered inside prepare_to_merge().

With extra debug output, it shows we're trying to relocate tree blocks
for quota root:

 BTRFS error (device loop1): reloc tree mismatch, root 8 has no reloc root, expect reloc root key (-8, 132, 8) gen 17
 ------------[ cut here ]------------
 BTRFS: Transaction aborted (error -117)

[CAUSE]
Normally we should not use reloc tree for quota root at all, as reloc
trees are only for subvolume trees.

But there is a race between quota enabling and relocation, this happens
after commit 85724171b302 ("btrfs: fix the btrfs_get_global_root return value").

Before that commit, for quota and free space tree, we exit immediately
if we can not grab it from fs_info.

But now we would try to read it from disk, just as if they are fs trees,
this sets ROOT_SHAREABLE flags in such race:

            Thread A             |           Thread B
---------------------------------+------------------------------
btrfs_quota_enable()             |
|                                | btrfs_get_root_ref()
|                                | |- btrfs_get_global_root()
|                                | |  Returned NULL
|                                | |- btrfs_lookup_fs_root()
|                                | |  Returned NULL
|- btrfs_create_tree()           | |
|  Now quota root item is        | |
|  inserted                      | |- btrfs_read_tree_root()
|                                | |  Got the newly inserted quota root
|                                | |- btrfs_init_fs_root()
|                                | |  Set ROOT_SHAREABLE flag

[FIX]
Get back to the old behavior by returning PTR_ERR(-ENOENT) if the target
objectid is not a subvolume tree or data reloc tree.

Fixes: 85724171b302 ("btrfs: fix the btrfs_get_global_root return value")
Reported-and-tested-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index da51e5750443..5fd336c597e9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1300,6 +1300,16 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 	root = btrfs_get_global_root(fs_info, objectid);
 	if (root)
 		return root;
+
+	/*
+	 * If we're called for non-subvolume trees, and above function didn't
+	 * found one, do not try to read it from disk.
+	 *
+	 * This is mostly for fst and quota trees, which can change at runtime
+	 * and should only be grabbed from fs_info.
+	 */
+	if (!is_fstree(objectid) && objectid != BTRFS_DATA_RELOC_TREE_OBJECTID)
+		return ERR_PTR(-ENOENT);
 again:
 	root = btrfs_lookup_fs_root(fs_info, objectid);
 	if (root) {
-- 
2.41.0

