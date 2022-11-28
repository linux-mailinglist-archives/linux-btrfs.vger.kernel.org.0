Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1363B236
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 20:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiK1T0n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 14:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiK1T0l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 14:26:41 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AA36350
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 11:26:40 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id k2so8075659qkk.7
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOEABLdKR6gEaF7LpDhQvVvBBzUVg35g1G1In0LBm0A=;
        b=m/a4wIbxmifZkCB3G9+VPA7sx3REXXDYmhxy2XdkTOxkQXy/mD2pnQrHYE0yAVBRgE
         BJWlZEe/fKn874uwD2RxKk4zPdzi3g0GbjL8csBjWUus0R4pHguecaezqKjqM2Ef7xh8
         UnimKtkIn9pmnJgPhEq6HCSqpsbe+uWWNxSVb0Ol8/nbh5y7VaJqsYZuniUMxyqBROs0
         CQYS+2oJOMlrykpBOYi2f9V5uNdiJte0MqQs8frfsQwja2PR0HdHaGKR8YYqMjwB5m5f
         QtKjEgxi6S7zuctV8J8Se+sOH1Xbz22jtsOzaIElx4Qmglo0fXsYwxlwHsZ6NxUS9cz2
         ueDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOEABLdKR6gEaF7LpDhQvVvBBzUVg35g1G1In0LBm0A=;
        b=l/syJGMA2ac1kCa0GyBBVenp9q1OrL3LyRC/IIpgQnsLtV2oW14VdsScy9SoOxPbex
         uEE/P90oe2vz68a9CnSXyH6XxwW87IdDe7laWxtaMRxqs1lmnEICplnTH1zM84/ZQvmP
         zM4T6IyjkotXgb56aRDkBY9i2B5JMCiZruROP0JcMmT2KxC+LkCRu5dvfWN4iwCL1emp
         kYOXBT1kV0NwI4I3WfhE7oGAOQXW9zcd1HhkNAYvxUysMOFNzdvJjc+s8EyB1Qp4z0I+
         fiZRQD3Qr6127QT0VVv6D34e4neOKnph72mhjjvYlzKaTW5A9f31y+4/oJxKPpsVT/Vm
         VgJA==
X-Gm-Message-State: ANoB5pkEHaQ4PUldOaOQ9/qKvAKwtz10qQu2b52xaHfk4ueQcAHjwXUj
        DmAt3vkD4s9AdUcIS4WS1U4i0QSCeE9bfA==
X-Google-Smtp-Source: AA0mqf6CYTPNvv1MvGL2BGIAPcxwMXjR8cnVCzRRrxa/Oz9Hz/MmUuYXmubfjREx//jJ/CVAs2yS9Q==
X-Received: by 2002:a05:620a:689:b0:6fa:2ffe:aab0 with SMTP id f9-20020a05620a068900b006fa2ffeaab0mr31784638qkh.567.1669663599611;
        Mon, 28 Nov 2022 11:26:39 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id q38-20020a05620a2a6600b006b949afa980sm8995372qkp.56.2022.11.28.11.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:26:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: sync some cleanups from progs into uapi/btrfs.h
Date:   Mon, 28 Nov 2022 14:26:38 -0500
Message-Id: <a4476b6b3363587c1e9e3f81db9d2dc003d5724c.1669663591.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When syncing this code into btrfs-progs Dave noticed there's some things
we were losing in the sync that are needed.  This syncs those changes
into the kernel, which include a few comments that weren't in the
kernel, some whitespace changes, an attribute, and the cplusplus bit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/uapi/linux/btrfs.h | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 5655e89b962b..b4f0f9531119 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -19,8 +19,14 @@
 
 #ifndef _UAPI_LINUX_BTRFS_H
 #define _UAPI_LINUX_BTRFS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/fs.h>
 
 #define BTRFS_IOCTL_MAGIC 0x94
 #define BTRFS_VOL_NAME_MAX 255
@@ -333,6 +339,12 @@ struct btrfs_ioctl_feature_flags {
  */
 struct btrfs_balance_args {
 	__u64 profiles;
+
+	/*
+	 * usage filter
+	 * BTRFS_BALANCE_ARGS_USAGE with a single value means '0..N'
+	 * BTRFS_BALANCE_ARGS_USAGE_RANGE - range syntax, min..max
+	 */
 	union {
 		__u64 usage;
 		struct {
@@ -549,7 +561,7 @@ struct btrfs_ioctl_search_header {
 	__u64 offset;
 	__u32 type;
 	__u32 len;
-};
+} __attribute__ ((__may_alias__));
 
 #define BTRFS_SEARCH_ARGS_BUFSIZE (4096 - sizeof(struct btrfs_ioctl_search_key))
 /*
@@ -562,6 +574,10 @@ struct btrfs_ioctl_search_args {
 	char buf[BTRFS_SEARCH_ARGS_BUFSIZE];
 };
 
+/*
+ * Extended version of TREE_SEARCH ioctl that can return more than 4k of bytes.
+ * The allocated size of the buffer is set in buf_size.
+ */
 struct btrfs_ioctl_search_args_v2 {
 	struct btrfs_ioctl_search_key key; /* in/out - search parameters */
 	__u64 buf_size;		   /* in - size of buffer
@@ -570,10 +586,11 @@ struct btrfs_ioctl_search_args_v2 {
 	__u64 buf[];                       /* out - found items */
 };
 
+/* With a @src_length of zero, the range from @src_offset->EOF is cloned! */
 struct btrfs_ioctl_clone_range_args {
-  __s64 src_fd;
-  __u64 src_offset, src_length;
-  __u64 dest_offset;
+	__s64 src_fd;
+	__u64 src_offset, src_length;
+	__u64 dest_offset;
 };
 
 /*
@@ -677,8 +694,11 @@ struct btrfs_ioctl_logical_ino_args {
 	/* struct btrfs_data_container	*inodes;	out   */
 	__u64				inodes;
 };
-/* Return every ref to the extent, not just those containing logical block.
- * Requires logical == extent bytenr. */
+
+/*
+ * Return every ref to the extent, not just those containing logical block.
+ * Requires logical == extent bytenr.
+ */
 #define BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET	(1ULL << 0)
 
 enum btrfs_dev_stat_values {
@@ -1144,4 +1164,8 @@ enum btrfs_err_code {
 #define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
 				     struct btrfs_ioctl_encoded_io_args)
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.26.3

