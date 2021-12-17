Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30B747945B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbhLQSwX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:52:23 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:53002 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240500AbhLQSwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:52:21 -0500
Received: from venice.bhome ([78.12.25.242])
        by santino.mail.tiscali.it with 
        id XWnP2601f5DQHji01WnRpf; Fri, 17 Dec 2021 18:47:25 +0000
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
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/6] btrfs: add flags to give an hint to the chunk allocator
Date:   Fri, 17 Dec 2021 19:47:17 +0100
Message-Id: <377d6c51cb957fbad5627bb93ff0a76ce9ba79da.1639766364.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1639766364.git.kreijack@inwind.it>
References: <cover.1639766364.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1639766845; bh=jbkkU8asLw/4hSQLus/n6WoA4G/fKeJmATWmP6RZJEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=zIWpeK1qkLxxrqsUxv742y7Si0H3tK8S0kXc9IPYAlCkfxnYOlwB8zGln4ZQdiPdd
         GBEF4BLl9MuBYSgq3kuzxtyb0GW+EUexnR9kFbpLtqk+EfTLDZUMrJr/cSx2NF53T/
         D4owOvXbZT5jFQ4MVsMfTfm7d7lz+WJ6t8azl0Es=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add the following flags to give an hint about which chunk should be
allocated in which a disk:

- BTRFS_DEV_ALLOCATION_HINT_PREFERRED_DATA
  preferred data chunk, but metadata chunk allowed
- BTRFS_DEV_ALLOCATION_HINT_PREFERRED_METADATA
  preferred metadata chunk, but data chunk allowed
- BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
  only metadata chunk allowed
- BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
  only data chunk allowed

Signed-off-by: Goffredo Baroncelli <kreijack@inwid.it>
---
 include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 5416f1f1a77a..55da906c2eac 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -386,6 +386,22 @@ struct btrfs_key {
 	__u64 offset;
 } __attribute__ ((__packed__));
 
+/* dev_item.type */
+
+/* btrfs chunk allocation hint */
+#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
+/* btrfs chunk allocation hint mask */
+#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
+	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) -1)
+/* preferred data chunk, but metadata chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_PREFERRED_DATA	(0ULL)
+/* preferred metadata chunk, but data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_PREFERRED_METADATA	(1ULL)
+/* only metadata chunk are allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
+/* only data chunk allowed */
+#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
+
 struct btrfs_dev_item {
 	/* the internal btrfs device id */
 	__le64 devid;
-- 
2.34.1

