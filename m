Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394BF8F631
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 23:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbfHOVEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 17:04:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39333 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733066AbfHOVEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 17:04:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so1829751pgi.6
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLmdrP3jD5HVPP2Cz3irDkNqURlCkLxkHINRWjSCIkg=;
        b=DalCDu+u/1WFZ1z4Kh7e9tksjQRn5M/LpfC9YEz8MS2UGJ/L0Avoc1dAUXw7fdW87L
         6qD8N2n4lSjJhIdDqp32RFPzZD+iMktKpAocr2AdtYeSmhnU/Ooe/BuEOEaa6JsldOSn
         472ArrV9WO3A1Zkdfc+6/n52gb9NyEUv60gsnDW+F+xC76z0dCejGBBs8Sr0VTaSfs3M
         2LkcENqMLBCrfWgx9KSQCGY38RNW8w+cHVS3op6Ti7LI74vxMKHxvmeOouMwJrCmNNS5
         730YvN6qVW2R5eVGfd/nW/+eS7StIeZGBHv9B5QD9OsiCEWvsADNGCkrzlp+k8rASoFf
         FVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLmdrP3jD5HVPP2Cz3irDkNqURlCkLxkHINRWjSCIkg=;
        b=Vr+Si73WZNHceJaMSaDiZubVKQPZPGden2huTBhOtKhNCt4aDpaEn4neCOsharnq+y
         Wp0mSwwhZiNxrw3pseoqcgzVdLbprlcDOd4LvJYu+s98DU/Al7ab2WZ4rbQ/R2gX8ESx
         pXJI6Vc9dCchFYak6OQuP/mC2DzAUBAZlxM2eYFNUwB7lYHIQpIwIXSyAAttI5U6zcGO
         ORfKA9NapCSLs9cAk6urFveJwkzOHDvRSZ7grK7IDVF4txXjNPKbEm0dGh0XSE4Ge70S
         LkF+btYxXWvWoE00aapymM1fNWYR1efk3Z2bbm0y2RsoctGhKlndPwaW8IuzIIr6b1FX
         7LAQ==
X-Gm-Message-State: APjAAAXv/1zSt3QnXTktOBbk2RPZmnyXHyDf+M4i46NfSzbVCwOIgZeu
        mXnSTMxPMFeBOrz81zN9jji3Fgh+wqk=
X-Google-Smtp-Source: APXvYqyW9mdTGSJrnCfzDbA5xM68zGti+UeyvDAbtf8r2DmaEhaHCypxrt2WRzpIEVI77cidab2TlA==
X-Received: by 2002:a62:1d8a:: with SMTP id d132mr3888769pfd.187.1565903062624;
        Thu, 15 Aug 2019 14:04:22 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:2aa9])
        by smtp.gmail.com with ESMTPSA id i124sm4073230pfe.61.2019.08.15.14.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:04:21 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [RFC PATCH 4/5] fs: export rw_verify_area()
Date:   Thu, 15 Aug 2019 14:04:05 -0700
Message-Id: <0f80a1adaf1dfd1eec71cf937db76a1b0459a0bf.1565900769.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <cover.1565900769.git.osandov@fb.com>
References: <cover.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

I'm adding a Btrfs ioctl to write compressed data, and rather than
duplicating the checks in rw_verify_area(), let's just export it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/internal.h      | 5 -----
 fs/read_write.c    | 1 +
 include/linux/fs.h | 1 +
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 315fcd8d237c..94e1831d4c95 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -160,11 +160,6 @@ extern char *simple_dname(struct dentry *, char *, int);
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
index 1f5088dec566..9d95491ce9ab 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -399,6 +399,7 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 	return security_file_permission(file,
 				read_write == READ ? MAY_READ : MAY_WRITE);
 }
+EXPORT_SYMBOL(rw_verify_area);
 
 static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 997a530ff4e9..a9a1884768e4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3082,6 +3082,7 @@ extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
 		int whence, loff_t size);
 extern loff_t no_seek_end_llseek_size(struct file *, loff_t, int, loff_t);
 extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
+extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
 extern int generic_file_open(struct inode * inode, struct file * filp);
 extern int nonseekable_open(struct inode * inode, struct file * filp);
 extern int stream_open(struct inode * inode, struct file * filp);
-- 
2.17.1

