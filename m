Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1248F62D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 23:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfHOVEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 17:04:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33320 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbfHOVEU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 17:04:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so1958277pfq.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yb5MuXDtp5/ug4m1ACXUxjVR5CvLpRxfqu2oJ4pk/yA=;
        b=rTJMEsfkXYJfdfbByBhO81xJgi+7r2etgFiG5b0yxq6AXcccarzzVCzNjiQfo8C41C
         ET0Rxf/vYHvTBlQpWb442SL3uku1euWSzWmMimDMdvx4L716e/UAUOrt3iFThQZaCB0g
         xORYRl8fJD29soY232uysJQBVmYhdBNlgRJVBvtjuZxL28tdtS/ra4uu5AYMZoZif/4n
         WbNpbBV9WKoc3HIxyPLT2Il0X3XlAiM4fEQ61FSroddADwq+q8HEMt3DKpoGGv9zYvMF
         IuiRG1nXw9Do5qJgOUJTOyvCNZoVKHjQysfrGUFes6hg8a1avsaM1WEKMjt++Cl3kQtB
         s5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yb5MuXDtp5/ug4m1ACXUxjVR5CvLpRxfqu2oJ4pk/yA=;
        b=BGQmHNZK9tD3d3uiCDvS6xUARtGXkwJoyIdIat9/IMhNfBjOgcHh5VV6EIrVY3S2pS
         wT2uac6fz4F2ZRPFfLiD1SxhLYJSuq3epPuOwFOcmimRZc7zs2wis6VkAvTsnJGzNQ0j
         PeDDj7AhLQK5RdKOhmI3OCszdgS9pENkiJ3MCevW7FB18WRBWDW4Y953ErXacTLTkZYS
         +8uT0jHo7lDGGE6xPJdbCXKYkz/EqIlT2mYlXMIxbAo4lEerf5qR4tTfUqhJYhi4nhMM
         qfgNxdA64gZb2LRPXyGZ4VhsleuXNIid6/TfyZrdSdXI7Gc0+qjlJ8fH4aQ/oSMwWseR
         UACA==
X-Gm-Message-State: APjAAAWl+L+kERpJvzT7zF3mVEDI6uMeX1eIMpmxwioLCGDH/WyBLxgW
        JnNCK3tjmtpwAtham/w5GONJzqxGvKw=
X-Google-Smtp-Source: APXvYqyka8tU+/79QeTkjlIBe+kdEzZihNcKKtUwtRCf/pDfR6HflDBMb2bUmp8QKqb1RIhZvM422Q==
X-Received: by 2002:a62:7789:: with SMTP id s131mr7351815pfc.50.1565903059178;
        Thu, 15 Aug 2019 14:04:19 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:2aa9])
        by smtp.gmail.com with ESMTPSA id i124sm4073230pfe.61.2019.08.15.14.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:04:18 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 1/5] Btrfs: use correct count in btrfs_file_write_iter()
Date:   Thu, 15 Aug 2019 14:04:02 -0700
Message-Id: <06b24b06988a5fac5881a0eef613aa2ef0c63834.1565900769.git.osandov@fb.com>
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

generic_write_checks() may modify iov_iter_count(), so we must get the
count after the call, not before. Using the wrong one has a couple of
consequences:

1. We check a longer range in check_can_nocow() for nowait than we're
   actually writing.
2. We create extra hole extent maps in btrfs_cont_expand(). As far as I
   can tell, this is harmless, but I might be missing something.

These issues are pretty minor, but let's fix it before something more
important trips on it.

Fixes: edf064e7c6fe ("btrfs: nowait aio support")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b31991f0f440..4393b6b24e02 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1885,7 +1885,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	bool sync = (file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host);
 	ssize_t err;
 	loff_t pos;
-	size_t count = iov_iter_count(from);
+	size_t count;
 	loff_t oldsize;
 	int clean_page = 0;
 
@@ -1906,6 +1906,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	}
 
 	pos = iocb->ki_pos;
+	count = iov_iter_count(from);
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		/*
 		 * We will allocate space in case nodatacow is not set,
-- 
2.17.1

