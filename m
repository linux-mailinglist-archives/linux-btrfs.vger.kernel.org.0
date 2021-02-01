Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE21C30B215
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 22:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhBAV3O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 16:29:14 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:37045 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232305AbhBAV3G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 16:29:06 -0500
Received: from venice.bhome ([84.220.24.72])
        by smtp-36.iol.local with ESMTPA
        id 6gkAlJHqMi3tS6gkBlGswt; Mon, 01 Feb 2021 22:28:23 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1612214903; bh=BPdX2M7pzcSlW67unwh3vWdpm9eFhj7jTNAL2JEydi0=;
        h=From;
        b=ot213zskJ5faXfMorwuh760KfifMN6Hnw9ZNtK9hPZratxQg5skzWEPipK3J2vLD1
         kwSdvoRS0ZD5HNWm+Sr8nY8bPatTtT0Tc+Pi3QZjsWzndDGV6Uai1njLgDQJBUMgG5
         FzRK9QQBtV79DXcPJNgDIupw8Yoo1Hw2bw3x94UVRe8i5arrf2wWI1t0Ac8p5DX7H+
         gnCEr1013f/L4zx5SRFs9rS6ki1KMI5urSc/3obdlJ1JYIQcAFtKjqk4MULrnyxY7Q
         RM66ExI4Ely5teOdnCmhMHkYYF1g7Rgi3erbRwEm2h19SC1Sc0iSXRHvYGjMK2S3sz
         v/F2QnZsbMGDA==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=60187277 cx=a_exe
 a=tAq5w2qrEf5dL+VNPEPBHQ==:117 a=tAq5w2qrEf5dL+VNPEPBHQ==:17
 a=lLZ8wYX2qvZDYXWRsIgA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/5] btrfs: add flags to give an hint to the chunk allocator
Date:   Mon,  1 Feb 2021 22:28:17 +0100
Message-Id: <20210201212820.64381-3-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201212820.64381-1-kreijack@libero.it>
References: <20210201212820.64381-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFYKrWBstadXte6rQg6x4TKquP1wXXhoyYYM2AI7cSRXuTIpKOEM6dMF0M35KslNX9CHRb27wdGuhAxg+LNzrGNazimiOamvgWENsGVQQxRnL7gBwVNZ
 mPd9T6PL6syZ26czSUmE+T0PdkmjK5PJtc1TQYNESgEmNTrtOfJ5wYOC2gSYK9chIu500oHYpQp58mLev5aFUl6udwR85k/UJtYCYVQPKp036VUnibjNYwiM
 ZV+3dgkoAa5mYtxIakOAOHFMX/SQivx+qxj05ZFbefe9Q6hSeOJXG2uFImzCZTzT
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
 include/uapi/linux/btrfs_tree.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 58d7cff9afb1..bd3af853df0c 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -361,6 +361,24 @@ struct btrfs_key {
 	__u64 offset;
 } __attribute__ ((__packed__));
 
+/* dev_item.type */
+
+/* btrfs chunk allocation hints */
+#define BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT	3
+#define BTRFS_DEV_ALLOCATION_MASK ((1ULL << \
+		BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT) -1)
+#define BTRFS_DEV_ALLOCATION_MASK_COUNT (1ULL << \
+		BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT)
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

