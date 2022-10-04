Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA55F3D6C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Oct 2022 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJDHoF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 03:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJDHoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 03:44:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11627B0E
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 00:44:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBFC31F92A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 07:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664869439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHu9tmaArpXBUImiF49MKcRgYfoBUncH1Ly9/YDIvjE=;
        b=FtVA3bvQWIDHQ2d71ccqLtl6/EN2M4krrFBigB8HRpPe9mtYL/keTVmjVcHKgceSTlxmJm
        eL5xhUQH65ylzBVUq/XQAWyjy7cWg5U3Alo/2oygcoD7phVQmBtLjLVUYv2/skBz9TtUVM
        UXFfb8rTmWkuR8tz/3Ou4E7bktXIH30=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CAD0139EF
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 07:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0N4MOj7kO2PxOQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Oct 2022 07:43:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: avoid fs corruption if rootdir contains ino smaller than BTRFS_FIRST_FREE_OBJECTID
Date:   Tue,  4 Oct 2022 15:43:39 +0800
Message-Id: <6550dc400395cefc91214507293beb6e2f667ee9.1664869157.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664869157.git.wqu@suse.com>
References: <cover.1664869157.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running mkfs tests on a newly rebooted minimal system, it can cause
mkfs/009 to fail.

The reproduce steps requires /tmp to has minimal files in the first
place.

  # mkdir /tmp/rootdir
  # xfs_io -f -c "pwrite 0 16k" /tmp/rootdir
  # mkfs.btrfs --rootdir /tmp/rootdir -f $dev
  # btrfs check $dev
  Opening filesystem to check...
  Checking filesystem on /dev/test/scratch1
  UUID: 6821b3db-f056-4c18-b797-32679dcd4272
  [1/7] checking root items
  [2/7] checking extents
  data backref 13631488 root 5 owner 170 offset 0 num_refs 0 not found in extent tree
  incorrect local backref count on 13631488 root 5 owner 170 offset 0 found 1 wanted 0 back 0x55ff6cd72260
  backref 13631488 root 5 not referenced back 0x55ff6cd4c1f0
  incorrect global backref count on 13631488 found 2 wanted 1
  backpointer mismatch on [13631488 16384]
  ERROR: errors found in extent allocation tree or chunk allocation

[CAUSE]
The extent tree has the following weird item:

	item 0 key (13631488 EXTENT_ITEM 16384) itemoff 16250 itemsize 33
		refs 1 gen 0 flags DATA
		tree block backref root FS_TREE

This is an extent item for data, thus it should not have an inline tree
backref.

Then checking the fs tree:

	item 0 key (170 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 7 transid 0 size 16384 nbytes 16384
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 0 flags 0x0(none)
		atime 1664866393.0 (2022-10-04 14:53:13)
		ctime 1664863510.0 (2022-10-04 14:05:10)
		mtime 1664863455.0 (2022-10-04 14:04:15)
		otime 0.0 (1970-01-01 08:00:00)

There is an inode item before the root dir inode.

And that inode number 170 is causing the problem.

In traverse_directory(), we use the inode number reported from stat()
directly as btrfs inode number, and pass it to
btrfs_record_file_extent(), which finally calls btrfs_inc_extent_ref(),
with above 170 passed as @owner parameter.

But inside btrfs_inc_extent_ref() we use that @owner value to determine
if it's a data backref.
Since we got a smaller than BTRFS_FIRST_FREE_OBJECTID, btrfs treats it
as tree block, and cause the above problem.

[FIX]
As a quick fix, always add BTRFS_FIRST_FREE_OBJECTID to all inode number
directly grabbed from stat().

And add an ASSERT() in __btrfs_record_file_extent() to catch unexpected
objectid.

This is not a perfect solution, as the resulted fs will has a huge grap
in its inodes:

	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
	item 4 key (426 INODE_ITEM 0) itemoff 15883 itemsize 160

For a proper fix, we should allocate new btrfs inode numbers in a
sequential order, but that would be another series of patches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent-tree.c | 6 ++++++
 mkfs/rootdir.c              | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 92d5c521abe8..670eb66b9929 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3529,6 +3529,12 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 	u64 extent_offset;
 	u64 num_bytes = *ret_num_bytes;
 
+	/*
+	 * @objectid should be an inode number, thus it should not be smaller
+	 * than BTRFS_FIRST_FREE_OBJECTID.
+	 */
+	ASSERT(objectid >= BTRFS_FIRST_FREE_OBJECTID);
+
 	/*
 	 * All supported file system should not use its 0 extent.
 	 * As it's for hole
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index e6a32e8bd3ba..6c2cc414d36c 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -533,7 +533,13 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
 				goto fail;
 			}
 
-			cur_inum = st.st_ino;
+			/*
+			 * We can not directly use the reported ino number,
+			 * as there is a chance that the ino is smaller than
+			 * BTRFS_FIRST_FREE_OBJECTID, which will screw up
+			 * backref code.
+			 */
+			cur_inum = st.st_ino + BTRFS_FIRST_FREE_OBJECTID;
 			ret = add_directory_items(trans, root,
 						  cur_inum, parent_inum,
 						  cur_file->d_name,
-- 
2.37.3

