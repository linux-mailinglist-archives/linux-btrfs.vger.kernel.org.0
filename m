Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D781A9237
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfIDTNg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 15:13:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44047 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732132AbfIDTNg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 15:13:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so8826368pfn.11
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h7OBsZRAY0e/kJE/6aAVfZOyG4ZOHITRFYFtR25HrKU=;
        b=cmH//oC26aIuI6AqcajkSoDcKbT+ua1+Jsxw2+qEiHBpVl8yRigwd5xXjKS3lJDB8z
         LgdU/0Cu5wba3oKFBWoUBV6rell+dytb5SIC0CRzifhQRl8F2IKtc70XJqdk7clWkEPF
         +GOMWcCQbzIS7EO3tAfMRHj6xrr1BibFeoZ9JUI6KwGPdgss38QgUNkgLHFlTvX5Cx2S
         2R3dBhuTKLHSryl4r8QDocLNlb/6Z61/r+2D1/yPTJdRGOXE+gV/T2aTrzgObwWFoU0N
         uX2Dz0OWVdGWuCbskgE7RNiGuYJXNCW7RLHT//6kCEMFogs3C6S1PvzJBY//11GK+X/2
         FzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h7OBsZRAY0e/kJE/6aAVfZOyG4ZOHITRFYFtR25HrKU=;
        b=IJZq3AJiN/2yGXRzlWzwkebD2lAL51bIr9k3atpUiqiWZLk3kHvIGNc0VeNATx3Nvd
         3WrKpE9zaXAAtv/MoBNUrSu/veIvQNnckyAZxPwNeQuWR+pwzQeF50xdSU7RQ1U6JQdX
         I8uc7MD3pwLUsfzsnQUX8sB+XuMFf8V2gH51wbdvqsh6D/RHPPI2bmArwQtgvF6ll9ix
         +6qvgA00q53nbibJrwfSkn7JfIf/Nx9o9WQVW1FzNDKFmI1LUfZ/ZBhEVaWv9GJtzCXt
         vh/49SOteHHvhefOOdhWVtpAdKrGnCqb61E7IDaurTNYBBvJ9FHZy3mru05qe/j1HUEy
         AI3g==
X-Gm-Message-State: APjAAAWsOczJuja3vB/sisEkFGo963CYIuC7YLd1u4pEbesAnesfIxIx
        ehNeIMkB5VoAOV3U9Rd5FsshY+es6FQ=
X-Google-Smtp-Source: APXvYqye+8+eNmus3Scr9Rk8TWD1MIWirqjwNTj+rU5T+fxzlICrKzdKXMeCbD4vs5TD51ebFgQSTg==
X-Received: by 2002:a17:90a:36ae:: with SMTP id t43mr6545358pjb.7.1567624415274;
        Wed, 04 Sep 2019 12:13:35 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::3502])
        by smtp.gmail.com with ESMTPSA id w6sm5495661pfw.84.2019.09.04.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:13:34 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/2] fs: export rw_verify_area()
Date:   Wed,  4 Sep 2019 12:13:25 -0700
Message-Id: <60306e9f9874cf207594dd986b7aff94275caf05.1567623877.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567623877.git.osandov@fb.com>
References: <cover.1567623877.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

I'm adding a Btrfs ioctl to write compressed data, and rather than
duplicating the checks in rw_verify_area(), let's just export it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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
index 5bbf587f5bc1..76d0dd85d4f3 100644
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
2.23.0

