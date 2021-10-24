Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA64389F3
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Oct 2021 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJXPl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Oct 2021 11:41:59 -0400
Received: from michael.mail.tiscali.it ([213.205.33.246]:57678 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229788AbhJXPl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Oct 2021 11:41:58 -0400
Received: from venice.bhome ([78.14.151.87])
        by michael.mail.tiscali.it with 
        id 9rXD2600J1tPKGW01rXEbw; Sun, 24 Oct 2021 15:31:15 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/4] btrfs: add flags to give an hint to the chunk allocator
Date:   Sun, 24 Oct 2021 17:31:04 +0200
Message-Id: <39a928f4184beb1385076c80630ef78cee18755a.1635089352.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1635089352.git.kreijack@inwind.it>
References: <cover.1635089352.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1635089475; bh=YcxZtFrBTYRGVAVYu8BJWnH8JhK7+fmx89cliadrdQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=uXb0xZsqiUXF5EJ/AzMETmBS69rXWqD9j2btXTIE0JE2RBTJJEFsclAO0Zv9xFPFC
         U0h3oJbGQfyV3HKcV9Xj0suWhcY3qNstoOXNzYFEH5vNgwRU7xUBxUsyyHreTgZ+3U
         hR0P9ZQQaqFl1hE3a5YTwPNzuQtmY+Fn0J0T4G8U=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add the following flags to give an hint about which chunk should be
allocated in which a disk.
The following flags are created:

- BTRFS_DEV_ALLOCATION_PREFERRED_DATA
  preferred data chunk, but metadata chunk allowed
- BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
  preferred metadata chunk, but data chunk allowed
- BTRFS_DEV_ALLOCATION_METADATA_ONLY
  only metadata chunk allowed
- BTRFS_DEV_ALLOCATION_DATA_ONLY
  only data chunk allowed

Signed-off-by: Goffredo Baroncelli <kreijack@inwid.it>
---
 include/uapi/linux/btrfs_tree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index ccdb40fe40dc..b45322b347c2 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -361,6 +361,20 @@ struct btrfs_key {
 	__u64 offset;
 } __attribute__ ((__packed__));
 
+/* dev_item.type */
+
+/* btrfs chunk allocation hints */
+#define BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT	3
+/* preferred data chunk, but metadata chunk allowed */
+#define BTRFS_DEV_ALLOCATION_PREFERRED_DATA	(0ULL)
+/* preferred metadata chunk, but data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_PREFERRED_METADATA	(1ULL)
+/* only metadata chunk are allowed */
+#define BTRFS_DEV_ALLOCATION_METADATA_ONLY	(2ULL)
+/* only data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_DATA_ONLY		(3ULL)
+/* 5..7 are unused values */
+
 struct btrfs_dev_item {
 	/* the internal btrfs device id */
 	__le64 devid;
-- 
2.33.0

