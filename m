Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2518A629EAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiKOQQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbiKOQQi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:38 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F5E2AE05
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:38 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id x15so10101041qvp.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IY8/3x1FQl3Y/WCX8GpVgDewJMRRUaPyKX+UfV5V2io=;
        b=WLB2g2dp0/TxpW6wvYw4OoUebNuZPIFP5jpEm4/yqlyYyIP2c3/Uvc+Sul4FeQkK93
         KfrEHMiN6QvFnA/ttmNpp9tQQCRB7ENqyeHPYJjxXNsY62xntW9WoTwt/EYOS+AXFkXc
         m6a6lsZTtxAUmaYtQJlHboxypfeHoO/ZJe9wFWCWECJMaOiDjg2plwe46CLOxlrsy4at
         I3g0ukzaCJooOCDNPKLIvFohcgqKm1/yA9wK2zGYERMjCfYGiAwYq+TfQ7XgBEo+n4Wh
         c9t3nmIgNVSWBb6iSjYo2ssrfHoZWWLyziq6y8c5/EEYDIbbVIJCcRmOsU9T06vhcIKG
         /IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IY8/3x1FQl3Y/WCX8GpVgDewJMRRUaPyKX+UfV5V2io=;
        b=VnNXiMRqP1hzzxFtJaVdz8lPtzl3Q4GqEC44NKY4akE+gbaELQPHCi05U5p32sT9gO
         D7nFauFQYJIMirpdqYQnaME3t7RLnC1M1v0NOGRtXYUCHUgqozZXBnmspGFfmA2XUwQl
         Fd9XnderoZKE4Sf9w4drdY3/hhUv6dkYGliBZUaOUR5ipk+tfmuOxJArnXaQlHnCVvcQ
         99GK/SxJdLoKtJlNI+9dzJXXd9McKYC5zg/trirRLC3mnT6lKoUhKJrqCS3yp5PcJdD5
         e2oqgc0cMcY8DzqX4FX6o9FDVxdOPYUKjF7C8gReLoxPcGwcfK//6EXrfi4SP53AVewG
         QwTQ==
X-Gm-Message-State: ANoB5pl2GQ8iNwiv+nTlEVMd3YLwqyRo9nCh0zgzkfu/XnCzFWY6oQZD
        NIPtTjL79cIg7GwViP+ItNWKhK74ExGYFQ==
X-Google-Smtp-Source: AA0mqf5ffifEgN1AH2P4UYeT0ufdpgo9dKSqluFzEKxyloLax9c0r9RIptPdvXwuEoauTmZhf07lsQ==
X-Received: by 2002:ad4:4147:0:b0:4bc:26a6:b710 with SMTP id z7-20020ad44147000000b004bc26a6b710mr17441311qvp.92.1668528996899;
        Tue, 15 Nov 2022 08:16:36 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id br7-20020a05620a460700b006eeca296c00sm8467540qkb.104.2022.11.15.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/11] btrfs: add nr_global_roots to the super block definition
Date:   Tue, 15 Nov 2022 11:16:19 -0500
Message-Id: <d0b325fd5265eac54b47e8e99a36e39aff6703ec.1668526429.git.josef@toxicpanda.com>
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

We already have this defined in btrfs-progs, add it to the kernel to
make it easier to sync these files into btrfs-progs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h            | 2 ++
 include/uapi/linux/btrfs_tree.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index e6228ff73c81..75c181b579eb 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -889,6 +889,8 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
 BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
 BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 			 uuid_tree_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
+			 nr_global_roots, 64);
 
 /* struct btrfs_file_extent_item */
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 29895ffa470d..ab38d0f411fa 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -688,8 +688,9 @@ struct btrfs_super_block {
 	/* The UUID written into btree blocks */
 	__u8 metadata_uuid[BTRFS_FSID_SIZE];
 
+	__u64 nr_global_roots;
+
 	/* Future expansion */
-	__u8 reserved8[8];
 	__le64 reserved[27];
 	__u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
-- 
2.26.3

