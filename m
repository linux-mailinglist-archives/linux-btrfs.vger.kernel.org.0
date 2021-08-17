Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059F43EF45F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 23:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhHQVHt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 17:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhHQVHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 17:07:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EC7C0613CF
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 14:07:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c4so479562plh.7
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6R9Vd2maqMCg6CU5suTV5BaqWqGpiPjxoTcJOVMmJO4=;
        b=Jj6xNU7z4WjdjnAYcMOp/wxV74XoxVgMPAq/rYVZF13oWOSH/QWgWTDvxRd3P0BJuk
         Xq0VQVnYNwSLQQSXK12X749ECUsgVczcVm3i83A8uhRagMCR9gXxIfVA3VOJ+7XYH1wN
         IuZGUyxPvlLbEUuvWW1bWyi9lfNF6hqMkEkgdgAM2OQ0LidSh2mpMWhHG1UVcAYDWVwY
         9AufTcDLc4x5BIYIRpX3MFNvM/rw4buhTSQs5v0p2OfMltWehyhMm/j+hKNF0z41sqEw
         qXVi+pYPJdMuE5NHY/Gu1dG4/tetPOa30cP4AV9I0yd/oYep4hzYQmwftLouH3kIJYTq
         c+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6R9Vd2maqMCg6CU5suTV5BaqWqGpiPjxoTcJOVMmJO4=;
        b=AYXpfcWMZqFPNilD1LeYWWRIcv91qBh0dMaKz+snN1F4Jki6OAsBhLsaRkFQUt+opy
         Nl4c6h1C6JJzR3fCj5SNy/5LZE6AyGC+xboqCo6Ymlvj9HJiuuG3QOv4ccIywfD5bLhs
         loUiHKcmIPmgwmd7TFiQ1e7CHJmcxm/TQWn71VzmOoBK7prjRrkpvsccx0wDkYV5nhsp
         uTickhgyCvv3BRrfBZs5auXxtoqa4ijjymb/Yc+ScnJjI2KbSBXyUi55GQQp2GV/GUVg
         CH8gUZdLv1lXvgRA80hRFz5Y6eMKYFM9T8EQVJe69PrUm84KJoflrsI1bhgaevtuobFu
         ofVg==
X-Gm-Message-State: AOAM532EdxhB2Q42Ba4e+lEFzwb6v5rUuUL1yU7fr2z5ZD3dL+SuVpGP
        AWjGHEjCxzW8TtvNg/qr782dGsOh8ax8+A==
X-Google-Smtp-Source: ABdhPJy/IGP9mxfFNXIhWM8VfsdDpyaceuJliqtIQm4fmHsyghQE3aFPmzbN6LSm8HYEjyDqlsgWXQ==
X-Received: by 2002:a05:6a00:23ca:b0:3e1:2d8:33f3 with SMTP id g10-20020a056a0023ca00b003e102d833f3mr5663577pfc.42.1629234433301;
        Tue, 17 Aug 2021 14:07:13 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:12 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 01/14] fs: export rw_verify_area()
Date:   Tue, 17 Aug 2021 14:06:33 -0700
Message-Id: <64c8b0e519aba3e66ac450b80309546836ae857f.1629234193.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

I'm adding Btrfs ioctls to read and write compressed data, and rather
than duplicating the checks in rw_verify_area(), let's just export it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/internal.h      | 5 -----
 fs/read_write.c    | 1 +
 include/linux/fs.h | 1 +
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 82e8eb32ff3d..f471894d87d4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -165,11 +165,6 @@ extern char *simple_dname(struct dentry *, char *, int);
 extern void dput_to_list(struct dentry *, struct list_head *);
 extern void shrink_dentry_list(struct list_head *);
 
-/*
- * read_write.c
- */
-extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
-
 /*
  * pipe.c
  */
diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..0029ff2b0ca8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -400,6 +400,7 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 	return security_file_permission(file,
 				read_write == READ ? MAY_READ : MAY_WRITE);
 }
+EXPORT_SYMBOL(rw_verify_area);
 
 static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1751addcb36e..0de4d75339b9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3274,6 +3274,7 @@ extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
 		int whence, loff_t size);
 extern loff_t no_seek_end_llseek_size(struct file *, loff_t, int, loff_t);
 extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
+extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
 extern int generic_file_open(struct inode * inode, struct file * filp);
 extern int nonseekable_open(struct inode * inode, struct file * filp);
 extern int stream_open(struct inode * inode, struct file * filp);
-- 
2.32.0

