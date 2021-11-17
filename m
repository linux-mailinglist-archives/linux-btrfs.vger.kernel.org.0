Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78017454E60
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbhKQUXF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbhKQUXB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:01 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E99C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:02 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id n15so3942665qta.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nn41RlDLf23cRu2RSsH/3qOMW/nWsLUvpnY8raPHOAk=;
        b=ndpvYXi0HuS2R7+Imnd5XIK1TYTXFORVNGW4IL4KMUOajJaPJjZkNtMkYP/4XHXQUK
         EJNw/5sVGJtW2SpgaTRf6vuIIwmKB8JgYexQFfnkBXK/1Xc71NAQITNl/iRDjVvFSKya
         Nb2BKyda8iCtbNAEhqprct3EOPxwaGnIYqWhpTg4xTIUiJYHkuUJs+QNjOFLADUuSlQx
         n/EeG8uYAfy9iaZ4K6Un2MI02rgXibxgfx8UH2uVBDg3BNKXNH44cJobVnsoucNn/Yqr
         RjtxL2170BQluIomimifT8LLgglc4iohHSDROTKi2Yc0Adn2T+Tbu+dky5VNmccwbTUY
         9nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nn41RlDLf23cRu2RSsH/3qOMW/nWsLUvpnY8raPHOAk=;
        b=j3GYf1HJCkauTae3GeiQNOrJXL16lngUuUnk/1MY5rsPnslWlr9rVmt+/uXa6qehTg
         nerrM5hLe81IxuxheBzDNJ6CYWVWUtblsYQQHKeWEkMDHd+8K278152Ek3AbXIocZlQS
         2oOMHpO5CUhZyoo83mlvDEoU+EaEe4CvL4D84XKGwMIataBgLuS9M51nafajm66yH55h
         fxWLjyCKF0kiytuWQPPH7BT8eHEg9KrZPvNFvbPh4l3MOReNIKTT3n/XGBMgjW5rzhQT
         fFkMkTZc0YSxaBZRvbrCUxULPbCOXzcGRwgHJLDlnaybeOmHIfQtSIpZapZsGMYFNH5E
         dQGQ==
X-Gm-Message-State: AOAM532ZFjKTrb+mL1TW7LzBZ7W0FCahKCpjHW47SlDj8FHanjcIVIoH
        6ZNur2hcjzDDFO4qcdv937NfL/FZ31VHoA==
X-Google-Smtp-Source: ABdhPJwxLelo73O4hH7ab21Mam27T0JL4acZM9Y5YDtohcmBGV6BGN8TzXE08HzjnOz3zk5eCZisow==
X-Received: by 2002:ac8:4e8c:: with SMTP id 12mr20120407qtp.45.1637180401905;
        Wed, 17 Nov 2021 12:20:01 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:01 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 01/17] fs: export rw_verify_area()
Date:   Wed, 17 Nov 2021 12:19:11 -0800
Message-Id: <11bc0fc15490afc6ce15c405cca3e16582f2f0ec.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
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
index 7979ff8d168c..8e400574401e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -157,11 +157,6 @@ extern char *simple_dname(struct dentry *, char *, int);
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
index 0074afa7ecb3..4d60146243df 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -385,6 +385,7 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 	return security_file_permission(file,
 				read_write == READ ? MAY_READ : MAY_WRITE);
 }
+EXPORT_SYMBOL(rw_verify_area);
 
 static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1cb616fc1105..364940c6a299 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3244,6 +3244,7 @@ extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
 		int whence, loff_t size);
 extern loff_t no_seek_end_llseek_size(struct file *, loff_t, int, loff_t);
 extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
+extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
 extern int generic_file_open(struct inode * inode, struct file * filp);
 extern int nonseekable_open(struct inode * inode, struct file * filp);
 extern int stream_open(struct inode * inode, struct file * filp);
-- 
2.34.0

