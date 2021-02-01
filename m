Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C430B21A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 22:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBAV3X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 16:29:23 -0500
Received: from smtp-36-i2.italiaonline.it ([213.209.12.36]:48287 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232421AbhBAV3P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 16:29:15 -0500
Received: from venice.bhome ([84.220.24.72])
        by smtp-36.iol.local with ESMTPA
        id 6gkIlJHtRi3tS6gkIlGsyh; Mon, 01 Feb 2021 22:28:31 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1612214911; bh=VQDd9RXqHxXOygdNSrac2NxK+M6PWNqwQg5nBtEXQMw=;
        h=From;
        b=VWs6Eo4KGhIefgiEe3r1n4V3/UPihbUbCjgKDMaMPvsLkXjiGW4mlfvV48CTC5wQm
         BUBLTZBToJxMp0VD0wpbmQ6e0v3nxCWQGIGUQ84+RZiHoESNGpeH5mOftgWGGWQWhM
         m+5BCAxFukl5Hk2Op2H2JkBA/pimgY2tJre+Feqphc1KVG3K6Gst8RzVuC4B7teQGv
         T3qDu4YTOS+gkqHtY4Z7tqjBfjuwQBsIrovQZD0YPnCfagtbrz4FklVsrVCeivi62A
         3oSLojpVxibTyvwfaLX4wZuebsgHKoaeGy5Lw4Ti785qgJO7qYSMCuYglY2/2i6KZ7
         nEnuQxaBo5hTA==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=6018727f cx=a_exe
 a=tAq5w2qrEf5dL+VNPEPBHQ==:117 a=tAq5w2qrEf5dL+VNPEPBHQ==:17
 a=tDkV-r6f1uA8TNYtaPcA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/2] btrfs-progs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
Date:   Mon,  1 Feb 2021 22:28:28 +0100
Message-Id: <20210201212829.64966-2-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201212829.64966-1-kreijack@libero.it>
References: <20210201212829.64966-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEY/thlbimuanFa9UWLg67RvGMqW7ZqkPN+9JE4dYzIK0JlItMi6+pI9XgI/CQAZ8+VIwSWwBd1Rd7RQoEJQKdE5o531/dvQZdNZyhAGgT3zu4LViCl+
 K8oV4LKXKT9nQ59heZKDGwrjTY540o5LJhKEYQYXjjDBcXCueOwuxyBfDSATbVNQ4M3KqEo1dfAvRkhN0Y4kfPRFOZfk3V7nYjbEV8X20Q//LBEdpDJNsYaS
 anrDCh/eY2s7DS3USj60LYEzV2MGSAgrfA07dWDS+3sRdSPjY5dcFEqE1H0vuxW4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Update the header to add the BTRFS_IOC_DEV_PROPERTIES ioctl:
- add ioctl BTRFS_IOC_DEV_PROPERTIES define
- add struct btrfs_ioctl_dev_properties
- add the BTRFS_DEV_PROPERTY_ define

This ioctl is a base for returning / setting information from / to  the
fields of the btrfs_dev_item object.

For now only the "type" field is returned / set.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 ioctl.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/ioctl.h b/ioctl.h
index ade6dcb9..a4febb95 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -775,6 +775,44 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 };
 BUILD_ASSERT(sizeof(struct btrfs_ioctl_get_subvol_rootref_args) == 4096);
 
+#define BTRFS_DEV_PROPERTY_TYPE		(1ULL << 0)
+#define BTRFS_DEV_PROPERTY_DEV_GROUP	(1ULL << 1)
+#define BTRFS_DEV_PROPERTY_SEEK_SPEED	(1ULL << 2)
+#define BTRFS_DEV_PROPERTY_BANDWIDTH	(1ULL << 3)
+#define BTRFS_DEV_PROPERTY_READ		(1ULL << 60)
+
+/*
+ * The ioctl BTRFS_IOC_DEV_PROPERTIES can read and write the device properties.
+ *
+ * The properties that the user want to write have to be set
+ * in the 'properties' field using the BTRFS_DEV_PROPERTY_xxxx constants.
+ *
+ * If the ioctl is used to read the device properties, the bit
+ * BTRFS_DEV_PROPERTY_READ has to be set in the 'properties' field.
+ * In this case the properties that the user want have to be set in the
+ * 'properties' field. The kernel doesn't return a property that was not
+ * required, however it may return a subset of the requested properties.
+ * The returned properties have the corrispondent BTRFS_DEV_PROPERTY_xxxx
+ * flag set in the 'properties' field.
+ *
+ * Up to 2020/05/11 the only properties that can be read/write is the 'type'
+ * one.
+ */
+struct btrfs_ioctl_dev_properties {
+	__u64	devid;
+	__u64	properties;
+	__u64	type;
+	__u32	dev_group;
+	__u8	seek_speed;
+	__u8	bandwidth;
+
+	/*
+	 * for future expansion
+	 */
+	__u8	unused1[2];
+	__u64	unused2[4];
+};
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	notused,
@@ -949,6 +987,8 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				   struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_DEV_PROPERTIES _IOW(BTRFS_IOCTL_MAGIC, 64, \
+				struct btrfs_ioctl_dev_properties)
 
 #ifdef __cplusplus
 }
-- 
2.30.0

