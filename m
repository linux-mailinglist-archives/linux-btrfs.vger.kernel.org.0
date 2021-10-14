Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5371A42DFF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhJNRNR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhJNRNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 13:13:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3B2C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 10:11:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t63so6113210qkf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LpWy5I5n3iyolPlXWzmsx3LbEDWQpGP5bB7jnaaUoVE=;
        b=3TUf5fKZz3Ydnb1ZPIag6hJy7SN2ntiOo4aJs4bHTKa10xeeUOzAFxoxX9YNUZSwde
         HGMc9RYVu5KAFoflsZpVTIMwWScXaBhB4jNcfUf1x/iqwuo52BDUyJS3APMElcVTA30R
         3lnkgMYnoEseV4W7CWnisA4yy4c2dSmokO8t8yTbY8DeB1+wm+CLzBcitRjARLcvLNLo
         yyuDA5tCJxdhe05vY6XxnfNzW923E2sn2QAiW4CcWYtf2igaHD0tgD0RP+Sl6OIoMY8N
         8Th7fABcy/dEsNmG/g/pL3AWkL8hKzWSkOlX9B5tTQWc9mw3T8e4eUKJ/+KgQnu6XC96
         T+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpWy5I5n3iyolPlXWzmsx3LbEDWQpGP5bB7jnaaUoVE=;
        b=wVRf62bLJjxPJED3H22gEQsaq071krvMDAOERaZy3km34jAXvrQOKCJ3TwIm/0c3RB
         3DTaoKVh2wGLTQAZwCzKKewXmd9zSetDUAA8yXNsCZ20tibZN3AiCCIbVSymGxXGJ++6
         m6XsuyZ2/lqugBEJOcuaxvF6WXzoztAtbeosrgAHl582xtCz6s8bpl6yd73iEv5yNke5
         2Ssx1VRnRW1y0tr7N80pZc1xD2LiQjsmz2IZvaBNYBjYhIhc3fPSz2nfFaR6M6bTgxAZ
         18FCzFpv9LhD9fQ+qUKumUcdTAATpU00slHcs2bW+0machfgFbTByiqE+dMW1tOqy1Mp
         I03g==
X-Gm-Message-State: AOAM5328dbzM6mnEfAkJNepLmZ+K0ow09VXeQrB81TsnuiCAGRLIiDDR
        3fct4Gwy/n2pCs7VsAtMsmfrShE9vNsMBw==
X-Google-Smtp-Source: ABdhPJymLhO1y5RMhC8Btx2ukposPL8l4DF5IfI0Un5e3PfTST7nl9IEUs1XS9dWDeDfs+WIVT3dVw==
X-Received: by 2002:a37:bb07:: with SMTP id l7mr6046476qkf.123.1634231464456;
        Thu, 14 Oct 2021 10:11:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c6sm1525983qkg.85.2021.10.14.10.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:11:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/2] fs: export an inode_update_time helper
Date:   Thu, 14 Oct 2021 13:11:00 -0400
Message-Id: <32a87813b58c1ddc3ae4d769cd2b667901621f6a.1634231213.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1634231213.git.josef@toxicpanda.com>
References: <cover.1634231213.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If you already have an inode and need to update the time on the inode
there is no way to do this properly.  Export this helper to allow file
systems to update time on the inode so the appropriate handler is
called, either ->update_time or generic_update_time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c         | 7 ++++---
 include/linux/fs.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ed0cab8a32db..9abc88d7959c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1782,12 +1782,13 @@ EXPORT_SYMBOL(generic_update_time);
  * This does the actual work of updating an inodes time or version.  Must have
  * had called mnt_want_write() before calling this.
  */
-static int update_time(struct inode *inode, struct timespec64 *time, int flags)
+int inode_update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
 	if (inode->i_op->update_time)
 		return inode->i_op->update_time(inode, time, flags);
 	return generic_update_time(inode, time, flags);
 }
+EXPORT_SYMBOL(inode_update_time);
 
 /**
  *	atime_needs_update	-	update the access time
@@ -1857,7 +1858,7 @@ void touch_atime(const struct path *path)
 	 * of the fs read only, e.g. subvolumes in Btrfs.
 	 */
 	now = current_time(inode);
-	update_time(inode, &now, S_ATIME);
+	inode_update_time(inode, &now, S_ATIME);
 	__mnt_drop_write(mnt);
 skip_update:
 	sb_end_write(inode->i_sb);
@@ -2002,7 +2003,7 @@ int file_update_time(struct file *file)
 	if (__mnt_want_write_file(file))
 		return 0;
 
-	ret = update_time(inode, &now, sync_it);
+	ret = inode_update_time(inode, &now, sync_it);
 	__mnt_drop_write_file(file);
 
 	return ret;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..20e2fe398ab6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2498,6 +2498,8 @@ enum file_time_flags {
 
 extern bool atime_needs_update(const struct path *, struct inode *);
 extern void touch_atime(const struct path *);
+extern int inode_update_time(struct inode *inode, struct timespec64 *time,
+			     int flags);
 static inline void file_accessed(struct file *file)
 {
 	if (!(file->f_flags & O_NOATIME))
-- 
2.26.3

