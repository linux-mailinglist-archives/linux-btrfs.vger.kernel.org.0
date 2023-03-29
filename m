Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78116CCE9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 02:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjC2AN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 20:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2AN0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 20:13:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9D1737
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 17:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t3oqXQlVWS+Mrq7D7uPldV7hw7+VU6vOEbLoWNd4m6g=; b=F4YTbpdGUllXbJtZrg2Wmww4lG
        41wLyGcWNCkNNJu4F0d/qVwhp78Pd0q89+2uxVQ9tKcicvm1khe+CnlaEJ9aUc0gFlajssUhIC9uU
        GNz9Lo8gu5mLWcI1Q/hZSKX4l4xVff/D/phWpE2r9mkFWEzEZ5O7Og9G4edpBKd0IH6KumekUTDCO
        2DOsugxrhsOZ7beV+HZbDIUjVHZhTL/bLVOlUIt5C75DCLvCmS4nlUfyXVKiJZjjffQUIXtgisr/R
        sRrRaerMRAEDgW0TlTMqV+NK3BYyAK1p7asEEpFIQe8KRl7rTZ0cbBrcjqbaDot0FuAnkI8M22770
        oZMJYPZA==;
Received: from mo146-160-37-65.air.mopera.net ([146.160.37.65] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phJRK-00GAyw-33;
        Wed, 29 Mar 2023 00:13:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: fix fast csum detection
Date:   Wed, 29 Mar 2023 09:13:05 +0900
Message-Id: <20230329001308.1275299-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329001308.1275299-1-hch@lst.de>
References: <20230329001308.1275299-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The BTRFS_FS_CSUM_IMPL_FAST flag is current set whenever a non-generic
crc32c is detected, which is the incorrect check if the file system uses
a different checksumming algorithm.  Refactor the code to only checks
this if crc32 is actually used.  Note that in an ideal world the
information if an algorithm is hardware accelerated or not should be
provided by the crypto API instead, but that's left for another day.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 18 +++++++++++++++++-
 fs/btrfs/super.c   |  2 --
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3f57c41f41bf5f..ec765d6bc53673 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -154,6 +154,21 @@ static bool btrfs_supported_super_csum(u16 csum_type)
 	}
 }
 
+/*
+ * Check if the CSUM implementation is a fast accelerated one.
+ * As-is this is a bit of a hack and should be replaced once the
+ * csum implementations provide that information themselves.
+ */
+static bool btrfs_csum_is_fast(u16 csum_type)
+{
+	switch (csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+		return !strstr(crc32c_impl(), "generic");
+	default:
+		return false;
+	}
+}
+
 /*
  * Return 0 if the superblock checksum type matches the checksum value of that
  * algorithm. Pass the raw disk superblock data.
@@ -3373,7 +3388,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
-
+	if (btrfs_csum_is_fast(csum_type))
+		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 	fs_info->csum_size = btrfs_super_csum_size(disk_super);
 
 	ret = btrfs_init_csum_hash(fs_info, csum_type);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d8885966e801cd..e94a4cd06607e1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1517,8 +1517,6 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
 					s->s_id);
 		btrfs_sb(s)->bdev_holder = fs_type;
-		if (!strstr(crc32c_impl(), "generic"))
-			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		error = btrfs_fill_super(s, fs_devices, data);
 	}
 	if (!error)
-- 
2.39.2

