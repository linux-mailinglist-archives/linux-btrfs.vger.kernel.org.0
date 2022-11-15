Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F2F629EAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiKOQQr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiKOQQj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:39 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D746B2BB1C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:38 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id ml12so10131252qvb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9GeUBmcwMoBfsjRHtYG2hTvKYVzivu3jkxJPGfdWpw=;
        b=plHX9KAbC0NQp1EX8H5zefAphk+aMIcBGeswJSvBN++bUQFGBRj9bE91pBYuGwYasg
         rySdlnOWCFgWRWbjE0CI8NftmnmuYCRXGUp5mV8Wu5Otz6DxPKohX3o8ARmEbXCz9903
         MdPAn3zLCMr87HUHDZpZD9K8IT6T3T9+T4ChNExDFaY1ye13yhSE/Z+D5cfQkXg3+zUZ
         iwIIID0fUkhoY1ip5d0EuAHRB32Zuz61TqWPceCpL0LenqHW467as2LJEuVJXGaR3hS/
         y2axbKMGVSFQPDo8/XPqrrEZ7FSte83CjsFBKy6+sXouxxTiia07d+XytK0rO4bBMBtC
         J4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9GeUBmcwMoBfsjRHtYG2hTvKYVzivu3jkxJPGfdWpw=;
        b=xz3Ph1nTRTiH6FgGsdi8cE8qY2mPQSfLAgt4NwVCmxQ8JSkoSspYfNwtLvJFs87O1G
         i+U+S9x8kHcVRIN0VnrV2OFVCy5yoN10SN+ZZpeVZK3KS/oKj79Pa3qL2uk0uSR23YlM
         8pdFEvy77J6/WrSXNyZjCnELrPFFine2ksrY1BUnD4siYXNW1WfkPYUGlduHqIOFPJ28
         4w88Tj4IhJv5VWOYSZiVzx9k9pZBXLmQ+0FgW9z2p6MjevVd3MuXxHv1TX8VZLG5sOK5
         CCQI+Wq892V05Hn/jcsKZYCIVaQfpCKEN2GfG2wSm9RbmkCzSLMmtK6P4HYbKuWJnFl0
         oXfw==
X-Gm-Message-State: ANoB5pnCfcF0tTbKTtAD+ynUb3Je64e3VUhcQ++wmsudeF6EeziOvJoi
        TcaxAaSYvhe2tA39wQs9XF2ehU9cikqPUg==
X-Google-Smtp-Source: AA0mqf6tfhjlxd5CIL2Il+0G2i39fF4OdJpXr8qdGEptGNnbu94IWDRknUgqzgbC4jS/6D0zYh/SJA==
X-Received: by 2002:a05:6214:428d:b0:4b3:e8bc:b06d with SMTP id og13-20020a056214428d00b004b3e8bcb06dmr17595745qvb.72.1668528998248;
        Tue, 15 Nov 2022 08:16:38 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a16aa00b006fa31bf2f3dsm8239422qkj.47.2022.11.15.08.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/11] btrfs: add stack helpers for a few btrfs items
Date:   Tue, 15 Nov 2022 11:16:20 -0500
Message-Id: <bb2c59f036523df2459800906529dd3b78ef29d5.1668526429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526429.git.josef@toxicpanda.com>
References: <cover.1668526429.git.josef@toxicpanda.com>
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

We don't have these defined in the kernel because we don't have any
users of these helpers.  However we do use them in btrfs-progs, so
define them to make keeping accessors.h in sync between progs and the
kernel easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 75c181b579eb..ceadfc5d6c66 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -221,12 +221,26 @@ static inline u64 btrfs_stripe_offset_nr(const struct extent_buffer *eb,
 	return btrfs_stripe_offset(eb, btrfs_stripe_nr(c, nr));
 }
 
+static inline void btrfs_set_stripe_offset_nr(struct extent_buffer *eb,
+					      struct btrfs_chunk *c, int nr,
+					      u64 val)
+{
+	btrfs_set_stripe_offset(eb, btrfs_stripe_nr(c, nr), val);
+}
+
 static inline u64 btrfs_stripe_devid_nr(const struct extent_buffer *eb,
 					 struct btrfs_chunk *c, int nr)
 {
 	return btrfs_stripe_devid(eb, btrfs_stripe_nr(c, nr));
 }
 
+static inline void btrfs_set_stripe_devid_nr(struct extent_buffer *eb,
+					     struct btrfs_chunk *c, int nr,
+					     u64 val)
+{
+	btrfs_set_stripe_devid(eb, btrfs_stripe_nr(c, nr), val);
+}
+
 /* struct btrfs_block_group_item */
 BTRFS_SETGET_STACK_FUNCS(stack_block_group_used, struct btrfs_block_group_item,
 			 used, 64);
@@ -248,6 +262,8 @@ BTRFS_SETGET_FUNCS(free_space_flags, struct btrfs_free_space_info, flags, 32);
 /* struct btrfs_inode_ref */
 BTRFS_SETGET_FUNCS(inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
 BTRFS_SETGET_FUNCS(inode_ref_index, struct btrfs_inode_ref, index, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_ref_index, struct btrfs_inode_ref, index, 64);
 
 /* struct btrfs_inode_extref */
 BTRFS_SETGET_FUNCS(inode_extref_parent, struct btrfs_inode_extref,
@@ -297,6 +313,14 @@ BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
 BTRFS_SETGET_FUNCS(dev_extent_chunk_offset, struct btrfs_dev_extent,
 		   chunk_offset, 64);
 BTRFS_SETGET_FUNCS(dev_extent_length, struct btrfs_dev_extent, length, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_extent_chunk_tree, struct btrfs_dev_extent,
+			 chunk_tree, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_extent_chunk_objectid, struct btrfs_dev_extent,
+			 chunk_objectid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_extent_chunk_offset, struct btrfs_dev_extent,
+			 chunk_offset, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_extent_length, struct btrfs_dev_extent, length, 64);
+
 BTRFS_SETGET_FUNCS(extent_refs, struct btrfs_extent_item, refs, 64);
 BTRFS_SETGET_FUNCS(extent_generation, struct btrfs_extent_item, generation, 64);
 BTRFS_SETGET_FUNCS(extent_flags, struct btrfs_extent_item, flags, 64);
@@ -479,6 +503,9 @@ BTRFS_SETGET_FUNCS(dir_log_end, struct btrfs_dir_log_item, end, 64);
 BTRFS_SETGET_FUNCS(root_ref_dirid, struct btrfs_root_ref, dirid, 64);
 BTRFS_SETGET_FUNCS(root_ref_sequence, struct btrfs_root_ref, sequence, 64);
 BTRFS_SETGET_FUNCS(root_ref_name_len, struct btrfs_root_ref, name_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_root_ref_dirid, struct btrfs_root_ref, dirid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_root_ref_sequence, struct btrfs_root_ref, sequence, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_root_ref_name_len, struct btrfs_root_ref, name_len, 16);
 
 /* struct btrfs_dir_item */
 BTRFS_SETGET_FUNCS(dir_data_len, struct btrfs_dir_item, data_len, 16);
@@ -972,6 +999,16 @@ BTRFS_SETGET_FUNCS(qgroup_limit_rsv_rfer, struct btrfs_qgroup_limit_item,
 		   rsv_rfer, 64);
 BTRFS_SETGET_FUNCS(qgroup_limit_rsv_excl, struct btrfs_qgroup_limit_item,
 		   rsv_excl, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_flags,
+			 struct btrfs_qgroup_limit_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_rfer,
+			 struct btrfs_qgroup_limit_item, max_rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_excl,
+			 struct btrfs_qgroup_limit_item, max_excl, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_rfer,
+			 struct btrfs_qgroup_limit_item, rsv_rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_excl,
+			 struct btrfs_qgroup_limit_item, rsv_excl, 64);
 
 /* btrfs_dev_replace_item */
 BTRFS_SETGET_FUNCS(dev_replace_src_devid,
-- 
2.26.3

