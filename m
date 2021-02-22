Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94406322174
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 22:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhBVVcf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 16:32:35 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:59720 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231976AbhBVVca (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 16:32:30 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-34.iol.local with ESMTPA
        id EInxl5gOr5WrZEInxlGr7o; Mon, 22 Feb 2021 22:31:45 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1614029505; bh=7XUOCErVdRZSa3xRcDmBaBJyuVBE6VybS9fa6/zL3Do=;
        h=From;
        b=N0fpSqzTOok/8VUIVjJDPc/Fi7lyE2H9qfVG05YNkLnM7jfABVCJJDzfE371LaPAQ
         nF03Sps8TFdbj9Q2My29rg0ZWQO4PbVoGSvt+PJjzjpVpnLjoVhfuwx12WwgdXHAtz
         tEn39CpUMste3p1n7lp08RWVQkj3QMYbCNyCSvK+TO6Am6rqgKBmAWx39mQej7QoSN
         EDK010v6Rp5egpypd9djkgntQFJPl1pMZB429kgYQ9ctcV/ljuA77N8Hc3qlYXbrdk
         Z2EawCSB1PUf2Jr4C+gC4+inkYNYeeAGRxLQGPHkNX1dt6AGrRWMXytTCUlyTxcR5t
         3V8E/6i/PcrJA==
X-CNFS-Analysis: v=2.4 cv=W4/96Tak c=1 sm=1 tr=0 ts=603422c1 cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=tDkV-r6f1uA8TNYtaPcA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/2] btrfs-progs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
Date:   Mon, 22 Feb 2021 22:31:44 +0100
Message-Id: <0b56879b789ea5be52538a884dde04a8d2ca7d45.1614029416.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1614029416.git.kreijack@inwind.it>
References: <cover.1614029416.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDehX7XwPEJ3EbDtz9KDmwB/KFflojmAjkSDYtRM0kESZMtaYqXAvKSwKGDd17WURcK+aYnvtjWvYvX/IZLUbh7y1nEBvL4BwL8NYCRNOtgUPG2hY/J0
 Vo7KNH/4d9xLLsImIbAnM9FXK/h+dj3asQovw6GxF/litU7l0NwP+JBQHCgR00P4rg0ZkfQX3oofbSs2SBEsXcK4y1H5dHmOynrhDmXEdXr171HAu5PI7Mzf
 Kn286SFAbenWmgcS4FwPO77MHO31YuTbYPorqpohe34wwvmCi14YqK2cA5ZEngbY
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
 ioctl.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/ioctl.h b/ioctl.h
index ade6dcb9..22a9c7a3 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -775,6 +775,43 @@ struct btrfs_ioctl_get_subvol_rootref_args {
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
+	 * for future expansion, pad up to 1k
+	 */
+	__u8	reserved[1024-30];
+};
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	notused,
@@ -949,6 +986,8 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				   struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_DEV_PROPERTIES _IOW(BTRFS_IOCTL_MAGIC, 64, \
+				struct btrfs_ioctl_dev_properties)
 
 #ifdef __cplusplus
 }
-- 
2.30.0

