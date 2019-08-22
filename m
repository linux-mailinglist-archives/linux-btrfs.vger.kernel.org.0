Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF67699F86
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391583AbfHVTLX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:11:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41243 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfHVTLU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id g17so6117874qkk.8
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWqO91MBMGp6m7eBB6gcnYr0fxdUY3GsTNytSY+/aqk=;
        b=nhvr64WNwQqzRExqlxK6d+cdlAKpEMQtJTqU1chyox55GGXDP7/ad0mbM7QUqkTb9+
         Dkrq8Vy+D00uXD6/awsLDMbMQW7LmOnCyNp2SazVTvAA+6glNTn6YsZqFooQvsxojN1f
         HxDHpq1nA1yd2+kplaS2sProe/925uCj0eA5HGaMUWfmmoF+54eagdiosoRs6xIbJchE
         B5Ajv/d1+K1AI44uUrMpQ/55eHoJMmVlPVOUETLBHk5wqF/M9UjlZ6WXUxqIC28L0lPM
         r9QCkpZdWtz3MD5xqb618uj/qEU6X1PWoZ9HIep8AslPZHGJYd4Uqnwek3Im7neBla7h
         2N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWqO91MBMGp6m7eBB6gcnYr0fxdUY3GsTNytSY+/aqk=;
        b=KQJFfg4qs7WUIFqESE69MXVVQ7jrgtTLLtkL/SzWbLbVvoXnNQ6FU5H4lcPRpa6SMD
         uXMF/o+y60FWmFHWVB4ya+82aCV+FQP9PWLt2+QVlYQKdMNGaSZKPb2EnADFbKAXTGy/
         FWGJkkd4qQai1kr4RJdgni73vFW3KRwAeHVaz8qUX+RnOhRTcI5uxLsKylFkLXrigqv9
         JO0kCdmu2VTQpamEIsiIENE4F4OcCOvKxLw4cD1cBYJhFyTWujcjSHsA8M5pcoiLbWAB
         h18JpKRawACJEOA6t1F5GRnJJhnhmwLJiJ0tP5e6GYxFXEtnMF/wEqi7djOBQo/Huujw
         Nzsg==
X-Gm-Message-State: APjAAAV1ZeV9yCx7EWkF3mINOvmEgsa/IxURdftJz96RbKA9lzZrT4cT
        /bWK4trW7gMrdqpKhCoe6C8MxkttRQBv1A==
X-Google-Smtp-Source: APXvYqzX8BjeyqCsTfMejaWziOY8ZWGNqvnKscrwOOJJo/K2+hfO5/pCA4D9qvAxJZ+rgq62/eRu1A==
X-Received: by 2002:a37:a6cf:: with SMTP id p198mr523477qke.259.1566501079215;
        Thu, 22 Aug 2019 12:11:19 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o18sm259940qtt.4.2019.08.22.12.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:11:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 8/9] btrfs: remove orig_bytes from reserve_ticket
Date:   Thu, 22 Aug 2019 15:11:01 -0400
Message-Id: <20190822191102.13732-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-1-josef@toxicpanda.com>
References: <20190822191102.13732-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we do not do partial filling of tickets simply remove
orig_bytes, it is no longer needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/space-info.c | 8 --------
 fs/btrfs/space-info.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index cec6db0c41cc..c5939c24c963 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -905,7 +905,6 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 				 struct reserve_ticket *ticket,
 				 enum btrfs_reserve_flush_enum flush)
 {
-	u64 reclaim_bytes = 0;
 	int ret;
 
 	switch (flush) {
@@ -930,17 +929,11 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	spin_lock(&space_info->lock);
 	ret = ticket->error;
 	if (ticket->bytes || ticket->error) {
-		if (ticket->bytes < ticket->orig_bytes)
-			reclaim_bytes = ticket->orig_bytes - ticket->bytes;
 		list_del_init(&ticket->list);
 		if (!ret)
 			ret = -ENOSPC;
 	}
 	spin_unlock(&space_info->lock);
-
-	if (reclaim_bytes)
-		btrfs_space_info_add_old_bytes(fs_info, space_info,
-					       reclaim_bytes);
 	ASSERT(list_empty(&ticket->list));
 	return ret;
 }
@@ -1000,7 +993,6 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	 * the list and we will do our own flushing further down.
 	 */
 	if (ret && flush != BTRFS_RESERVE_NO_FLUSH) {
-		ticket.orig_bytes = orig_bytes;
 		ticket.bytes = orig_bytes;
 		ticket.error = 0;
 		init_waitqueue_head(&ticket.wait);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0e805b5b1fca..d61550f06c94 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -70,7 +70,6 @@ struct btrfs_space_info {
 };
 
 struct reserve_ticket {
-	u64 orig_bytes;
 	u64 bytes;
 	int error;
 	struct list_head list;
-- 
2.21.0

