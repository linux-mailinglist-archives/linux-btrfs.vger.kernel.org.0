Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008B94C0498
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiBVW06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiBVW05 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:26:57 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97D4B23
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:30 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id v5so1870931qkj.4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ihXMTpnzi1FSNblBDeAIrCHeYX++xu+aaMtFvJzpH34=;
        b=jMyJia3/t7d9mHFix3c92wWoJP2DuVMvaMkkEDlRYxcVo/DuwVlJ340yeF3Zfv1mHr
         vSuc6b3elt9lHBpi29q08p1PoZc4BG2OxcOW5FygY0eTnfZjXORLfZ27ThQ5fLsQlrib
         htSLey5R4VGK83SzS8r/HyVImZMRUMuDiWHTJUcxTzky2HKF7OF5jmtwtAJjIHx2jAqj
         uTgN59TlbINlpuD2Kp5IoVq51k8l10SjLGfLUn8tQUZJBbcxRxKsPWIcvN/YKcvNS55B
         jSrH3nn75OSEGX2vVfvdZQ4WKsKaidot7WDc1v2LdqBE5whpXFntrgLaZvAvj/3GZi0W
         YBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihXMTpnzi1FSNblBDeAIrCHeYX++xu+aaMtFvJzpH34=;
        b=NKJ04kqWTNYH9LR+KG7YJOTO4A2K6T3TWqw2sJR9DTK/FHms3p8GGFZaHu/DPXVKwU
         5A2OK27jzM/N5DIgtuB+DYcD8tBKXwtJiB4+U2vGCiCU3V+CEUT4TCZH0xrYHi6Hm9ts
         /iJosWf3sQ8ODj8W5YNtVkW8vH6mbnv07wN5eQNIBHIisgjbtmcHt0uo9ItOhiwEbk9R
         10RLlbWLDygDkeKdpYfee+d0K84ZSvDAjoNdjERroZG3RIGNsObUnkCMue1HlN44UWU7
         pBCr/Nn4KLaILg676H9AMF1D7Ff3ibv9M35rURTMz4R8RmeCNZI3NGTuP1S4jdLgEpg+
         dFHw==
X-Gm-Message-State: AOAM533+/GSNvZdxvdwUOZGIyeHiJgYBomU2QgjZ2WzAl8oR4JV3sQ4K
        QZ93cbq+Mf3/LWJo1a4TIxLV0QI49jkelPIk
X-Google-Smtp-Source: ABdhPJyvy+k6cYoyMJQ5WwOkOKon8ghZ30uY70YIRkDjGGsTiowkntRbGmSYU4o0v1RR8KVoKAykcA==
X-Received: by 2002:ae9:e40e:0:b0:62c:ec14:9277 with SMTP id q14-20020ae9e40e000000b0062cec149277mr13283891qkc.432.1645568789777;
        Tue, 22 Feb 2022 14:26:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z3sm556790qkl.13.2022.02.22.14.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/13] btrfs-progs: convert: use cfg->leaf_data_size
Date:   Tue, 22 Feb 2022 17:26:14 -0500
Message-Id: <c0abc5a5a87e6e8f22d225185a0fd23cafe0325e.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The mkfs_config can hold the BTRFS_LEAF_DATA_SIZE, so calculate this at
config creation time and then use that value throughout convert instead
of calling __BTRFS_LEAF_DATA_SIZE.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 convert/common.c | 8 ++++----
 convert/main.c   | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index 00a7e553..356c2b4c 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -238,7 +238,7 @@ static int setup_temp_root_tree(int fd, struct btrfs_mkfs_config *cfg,
 				u64 dev_bytenr, u64 fs_bytenr, u64 csum_bytenr)
 {
 	struct extent_buffer *buf = NULL;
-	u32 itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
+	u32 itemoff = cfg->leaf_data_size;
 	int slot = 0;
 	int ret;
 
@@ -419,7 +419,7 @@ static int setup_temp_chunk_tree(int fd, struct btrfs_mkfs_config *cfg,
 				 u64 chunk_bytenr)
 {
 	struct extent_buffer *buf = NULL;
-	u32 itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
+	u32 itemoff = cfg->leaf_data_size;
 	int slot = 0;
 	int ret;
 
@@ -490,7 +490,7 @@ static int setup_temp_dev_tree(int fd, struct btrfs_mkfs_config *cfg,
 			       u64 dev_bytenr)
 {
 	struct extent_buffer *buf = NULL;
-	u32 itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
+	u32 itemoff = cfg->leaf_data_size;
 	int slot = 0;
 	int ret;
 
@@ -688,7 +688,7 @@ static int setup_temp_extent_tree(int fd, struct btrfs_mkfs_config *cfg,
 				  u64 fs_bytenr, u64 csum_bytenr)
 {
 	struct extent_buffer *buf = NULL;
-	u32 itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
+	u32 itemoff = cfg->leaf_data_size;
 	int slot = 0;
 	int ret;
 
diff --git a/convert/main.c b/convert/main.c
index 333d5be1..b72d1e51 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1228,6 +1228,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	mkfs_cfg.sectorsize = blocksize;
 	mkfs_cfg.stripesize = blocksize;
 	mkfs_cfg.features = features;
+	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
 
 	printf("Create initial btrfs filesystem\n");
 	ret = make_convert_btrfs(fd, &mkfs_cfg, &cctx);
-- 
2.26.3

