Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAA72172AB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgGGPmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPmx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:42:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFEAC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:42:53 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b185so27939164qkg.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3V6irZLnsZrtYJPX/dX6i+oAV4ziCPw7VoqYDNQ8cw=;
        b=xH9FhkuxdD5bw+bx3J5l8d0+ifM99OuP+wxOiQ/S0q5uR8T9pxgbpQi2VfCDhxlWgK
         qGW7Xraf+iiXuzz3JkYUUYR2hn+pVdrp6BWY9bfyjeS+3bwwwB4v7009sTqbjfc1cthV
         UIoLeJJZFUajWaDlhnytMY2utbGTfDJvz2Va6fiQqhMgzb6cU9lXe4wQ1jw1/Iod7jJS
         yKGo9ruADQoUi2w4Oc2xMYp8dZaIvcpdfV9zQnB7hePCWRgIFZdeu/r6szVIInfDtZRr
         Jgdc1x35XuQ/SazCoyGBuNVcRyaKBUxzP0cHTjfrlU7a+Pj10IALKhZ777paJlvS/FN2
         h+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3V6irZLnsZrtYJPX/dX6i+oAV4ziCPw7VoqYDNQ8cw=;
        b=M+ifh1Yr6QJTgBONdlITn1V/mBsp2FxVjHrz2w8HeKk1vefltQ4pCtx+LFIKoB/kot
         FZuxoB+ncgeqrnpou/YMu4k6pStZnFIORz6BM+dBeqwc/vj+bPYKu6aks2blKvea6h89
         9Yq51rsrDLlCEHVMv1VgDACDafYDIjhYaUKIZ4UAYr7RwNVAllImNgLBL+7kkduLZ+Gx
         Q6rja3P71rLb+x9qIAoicAzxqcp3M/43LaciPFtUR3JlxLmYK/fGWdu8Z/HblmlHh2TB
         oyluUL6mQl9jKrow/vzC58JDrwHIJcKTdJ7Sd7f+DD25QlbFgXeHMPnaAy+Qp/Myihf+
         dFgA==
X-Gm-Message-State: AOAM531oqO0Qwexxdci47vmcD1F3scWZceaL40jV+xtirc1LVoW+ZoRQ
        /+2msvzCA0e/6wb2pseGgwKbuevLll0V2A==
X-Google-Smtp-Source: ABdhPJw9zjsuiuEvxfFy6AqZAbqQ3vzEDgGIb47HJ+/kaBe1sZ52Xwqvi2KbVrJXUBe/ZBTOG6YwQQ==
X-Received: by 2002:a05:620a:2eb:: with SMTP id a11mr49904420qko.383.1594136572365;
        Tue, 07 Jul 2020 08:42:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i35sm25856201qtd.96.2020.07.07.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:42:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 01/23] btrfs: change nr to u64 in btrfs_start_delalloc_roots
Date:   Tue,  7 Jul 2020 11:42:24 -0400
Message-Id: <20200707154246.52844-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have btrfs_wait_ordered_roots() which takes a u64 for nr, but
btrfs_start_delalloc_roots() that takes an int for nr, which makes using
them in conjunction, especially for something like (u64)-1, annoying and
inconsistent.  Fix btrfs_start_delalloc_roots() to take a u64 for nr and
adjust start_delalloc_inodes() and it's callers appropriately.

This means we've adjusted start_delalloc_inodes() to take a pointer of
nr since we want to preserve the ability for start-delalloc_inodes() to
return an error, so simply make it do the nr adjusting as necessary.

Part of adjusting the callers to this means changing
btrfs_writeback_inodes_sb_nr() to take a u64 for items.  This may be
confusing because it seems unrelated, but the caller of
btrfs_writeback_inodes_sb_nr() already passes in a u64, it's just the
function variable that needs to be changed.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/inode.c       | 27 +++++++++++----------------
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/space-info.c  |  2 +-
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e40eb210670d..93cd1ff878cb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2926,7 +2926,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       u32 min_type);
 
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root);
-int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr);
+int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr);
 int btrfs_set_extent_delalloc(struct inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index db93909b25e0..769ac3098880 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -630,7 +630,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	 * flush all outstanding I/O and inode extent mappings before the
 	 * copy operation is declared as being finished
 	 */
-	ret = btrfs_start_delalloc_roots(fs_info, -1);
+	ret = btrfs_start_delalloc_roots(fs_info, U64_MAX);
 	if (ret) {
 		mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
 		return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d301550b9c70..b1ca1e3fcc54 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9394,7 +9394,8 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
  * some fairly slow code that needs optimization. This walks the list
  * of all the inodes with pending delalloc and forces them to disk.
  */
-static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
+static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr,
+				 bool snapshot)
 {
 	struct btrfs_inode *binode;
 	struct inode *inode;
@@ -9434,9 +9435,11 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
 		list_add_tail(&work->list, &works);
 		btrfs_queue_work(root->fs_info->flush_workers,
 				 &work->work);
-		ret++;
-		if (nr != -1 && ret >= nr)
-			goto out;
+		if (*nr != U64_MAX) {
+			(*nr)--;
+			if (*nr == 0)
+				goto out;
+		}
 		cond_resched();
 		spin_lock(&root->delalloc_lock);
 	}
@@ -9461,18 +9464,15 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	int ret;
+	u64 nr = U64_MAX;
 
 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
 		return -EROFS;
 
-	ret = start_delalloc_inodes(root, -1, true);
-	if (ret > 0)
-		ret = 0;
-	return ret;
+	return start_delalloc_inodes(root, &nr, true);
 }
 
-int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr)
+int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr)
 {
 	struct btrfs_root *root;
 	struct list_head splice;
@@ -9495,15 +9495,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr)
 			       &fs_info->delalloc_roots);
 		spin_unlock(&fs_info->delalloc_root_lock);
 
-		ret = start_delalloc_inodes(root, nr, false);
+		ret = start_delalloc_inodes(root, &nr, false);
 		btrfs_put_root(root);
 		if (ret < 0)
 			goto out;
-
-		if (nr != -1) {
-			nr -= ret;
-			WARN_ON(nr < 0);
-		}
 		spin_lock(&fs_info->delalloc_root_lock);
 	}
 	spin_unlock(&fs_info->delalloc_root_lock);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b3e4c632d80c..0ffc4b2d2627 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4829,7 +4829,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_SYNC: {
 		int ret;
 
-		ret = btrfs_start_delalloc_roots(fs_info, -1);
+		ret = btrfs_start_delalloc_roots(fs_info, U64_MAX);
 		if (ret)
 			return ret;
 		ret = btrfs_sync_fs(inode->i_sb, 1);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 41ee88633769..571b87cf1c41 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -477,7 +477,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 }
 
 static void btrfs_writeback_inodes_sb_nr(struct btrfs_fs_info *fs_info,
-					 unsigned long nr_pages, int nr_items)
+					 unsigned long nr_pages, u64 nr_items)
 {
 	struct super_block *sb = fs_info->sb;
 
-- 
2.24.1

