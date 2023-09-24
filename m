Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099B87AC6BA
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Sep 2023 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjIXGOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Sep 2023 02:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjIXGOo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Sep 2023 02:14:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F1C101
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Sep 2023 23:14:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA4A0215EF
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695536076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2xw8MQq4qcgBfJ1EqWkXguVXaZ+X+XZv/x39UIs2s9E=;
        b=SMXLvYdzE4L+x9zyOdCWRJ7z86go97o1HgOl+3+Dxbe5o2QP6kLto+Y1P1o8Cc0122xaHi
        uUtFCwoVdaCvNsmZ8XiX9Ws1sk4Ucd7RJBpTBAMkye7l9WypxOJCL/jTqCinc606BgdM4K
        7vjDM3wgbPEBUmL2NYeXhhqZ09vIrFE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28BDD138FE
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UO4XNsvTD2X+CgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: introduce allow_data_failure sysfs interface
Date:   Sun, 24 Sep 2023 15:44:14 +0930
Message-ID: <9cb5abd136ffd38b357f8acd3f939ea33ee36e42.1695535440.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695535440.git.wqu@suse.com>
References: <cover.1695535440.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if btrfs fails to write data blocks, it will not really cause
any great damage, but mostly -EIO for involved writeback functions like
fsync() or direct io for that inode.

Normally it's not a big deal, but it can be an indicator of a bigger
problem (e.g. unreliable hardware).

Thus this patch would allow debug builds to toggle if any data writeback
failure is allowed"

  /sys/fs/btrfs/<uuid>/debug/allow_data_failure

The entry is read-write, 0 means the fs would not tolerate any data
writeback failure, and would falls read-only after such failure.

The default value is 1.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |  1 +
 fs/btrfs/extent_io.c |  8 +++++++-
 fs/btrfs/fs.h        |  2 ++
 fs/btrfs/inode.c     |  9 ++++++++-
 fs/btrfs/sysfs.c     | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 062e28ac94b1..160f8f6b906d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2723,6 +2723,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->allocated_ebs);
 	spin_lock_init(&fs_info->eb_leak_lock);
 	fs_info->allow_backup_super_failure = true;
+	fs_info->allow_data_failure = true;
 	fs_info->super_failure_tolerance = -1;
 #endif
 	extent_map_tree_init(&fs_info->mapping_tree);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5e5852a4ffb5..95725c5027de 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -483,8 +483,14 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 				   bvec->bv_offset, bvec->bv_len);
 
 		btrfs_finish_ordered_extent(bbio->ordered, page, start, len, !error);
-		if (error)
+		if (error) {
 			mapping_set_error(page->mapping, error);
+			if (!READ_ONCE(fs_info->allow_data_failure))
+				btrfs_handle_fs_error(fs_info, -EIO,
+		"data write back failed, root %lld ino %llu fileoff %llu",
+					BTRFS_I(inode)->root->root_key.objectid,
+					btrfs_ino(BTRFS_I(inode)), start);
+		}
 		btrfs_page_clear_writeback(fs_info, page, start, len);
 	}
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 7608a1cf612f..fa26ae33a29d 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -689,6 +689,8 @@ struct btrfs_fs_info {
 	/* If we allow backup superblocks writeback to fail. */
 	bool allow_backup_super_failure;
 
+	/* If we allow data writeback to fail. */
+	bool allow_data_failure;
 	/*
 	 * Tolerance on how many devices can fail their superblock writeback.
 	 *
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 514d2e8a4f52..4388eeced1bf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7703,13 +7703,20 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 	struct btrfs_dio_private *dip =
 		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio = &bbio->bio;
 
 	if (bio->bi_status) {
-		btrfs_warn(inode->root->fs_info,
+		btrfs_warn(fs_info,
 		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
 			   btrfs_ino(inode), bio->bi_opf,
 			   dip->file_offset, dip->bytes, bio->bi_status);
+		if (!READ_ONCE(fs_info->allow_data_failure))
+			btrfs_handle_fs_error(fs_info, -EIO,
+	"direct IO data write back failed, root %lld ino %llu fileoff %llu len %u",
+				inode->root->root_key.objectid,
+				btrfs_ino(inode), dip->file_offset,
+				dip->bytes);
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index bd9f574c2471..a32a7b2d1b7a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -673,6 +673,37 @@ static ssize_t super_failure_tolerance_store(struct kobject *debug_kobj,
 }
 BTRFS_ATTR_RW(debug, super_failure_tolerance, super_failure_tolerance_show,
 	      super_failure_tolerance_store);
+
+static ssize_t allow_data_failure_show(struct kobject *debug_kobj,
+				       struct kobj_attribute *a,
+				       char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(debug_kobj->parent);
+
+	ASSERT(fs_info);
+	return sysfs_emit(buf, "%d\n",
+			  READ_ONCE(fs_info->allow_data_failure));
+}
+
+static ssize_t allow_data_failure_store(struct kobject *debug_kobj,
+					struct kobj_attribute *a,
+					const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(debug_kobj->parent);
+	u8 new_number;
+	int ret;
+
+	ASSERT(fs_info);
+
+	ret = kstrtos8(buf, 10, &new_number);
+	if (ret)
+		return -EINVAL;
+	WRITE_ONCE(fs_info->allow_data_failure, !!new_number);
+	return len;
+}
+BTRFS_ATTR_RW(debug, allow_data_failure, allow_data_failure_show,
+	      allow_data_failure_store);
+
 /*
  * Per-filesystem runtime debugging exported via sysfs.
  *
@@ -686,6 +717,7 @@ BTRFS_ATTR_RW(debug, super_failure_tolerance, super_failure_tolerance_show,
  */
 static const struct attribute *btrfs_debug_mount_attrs[] = {
 	BTRFS_ATTR_PTR(debug, allow_backup_super_failure),
+	BTRFS_ATTR_PTR(debug, allow_data_failure),
 	BTRFS_ATTR_PTR(debug, super_failure_tolerance),
 	NULL,
 };
-- 
2.42.0

