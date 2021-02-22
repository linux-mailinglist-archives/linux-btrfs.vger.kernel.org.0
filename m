Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29C332213E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhBVVUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 16:20:05 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:55235 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229863AbhBVVUE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 16:20:04 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-34.iol.local with ESMTPA
        id EIbml5cmb5WrZEIbwlGloV; Mon, 22 Feb 2021 22:19:20 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1614028760; bh=fyrWQZCKp/t/gLoLBueHmvtjHJXmf/qMqBvk4tlI1lY=;
        h=From;
        b=ZkJR/kVK8ODHE49nW5NgnarOuYYTt6kPoO1GB0oBlDKahCPoHaP/NMgkLcGw9Aw1P
         irygyHkEmaXHo0A7z6WAybnD9oxZ7GrZvWe4sh9mDCieSigHzC0j33oHrnHt5Apzpg
         Too6J+tkGS08yz4ExMnZuUWYCrL+mfgnq+kXhJPUK7yDBcM7E5ux17yr+6mldfbizb
         S0sZkjW5JKjskktjXur4X1gMN/bJQPT0HUUXyZSc0tO/HLtk/3NqMgz5n5SWcJQ8bB
         qQuc2WMLyHXqchEtUravQNe/uSvTj+MdFx8WN2v/OtEapql3jNuq1rInjhiPY8LDCi
         MsSXSNHrJLHsA==
X-CNFS-Analysis: v=2.4 cv=W4/96Tak c=1 sm=1 tr=0 ts=60341fd8 cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=lLZ8wYX2qvZDYXWRsIgA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Goffredo Baroncelli <kreijack@inwid.it>
Subject: [PATCH 2/4] btrfs: add flags to give an hint to the chunk allocator
Date:   Mon, 22 Feb 2021 22:19:07 +0100
Message-Id: <f61b78b94e5e5c84e6f6bba9a8586a957fb66d6d.1614028083.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1614028083.git.kreijack@inwind.it>
References: <cover.1614028083.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCal3Sg7EakDGjxUtmmyvugb4nbwuNm54g/5a4Vt9sSbXly5L+cLCw97fO2acXZ4iHdEn+wPavqxIliwAmfOQweVtSUB1iExoEJv6Usn/OsZ+CqJDUk/
 6l3iUUlYu2sP1EiZUitiRGwdHjfdfq5ZICAtLv/dzF6U2gcPYr8xLEHxQ5v2+94zIQYIfUe0Jyn+3gQFkTx+xi4/TCv3XfWocfjrV6M3W3PCtZXhBUeBdTdH
 8nX/TQDcHUaZFEbc54rBjw==
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
index 58d7cff9afb1..25f522bcdadc 100644
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
2.30.0

