Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F68629EA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiKOQQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKOQQ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:26 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AF821269
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:25 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e15so9019163qts.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLLHDLWtHTidzc0MuDneCL+O1YoJg/8zvgEK+mOLUac=;
        b=yoyLROZOURGGOh1cKWlZ6qrp2JGg8rql9rxDPMSpxpf7JyE0eWSmZ1vbJinH+BERIi
         1xgvW0vrqZkRCCD+saB3/NzGANy8hQnMaU1bNsTWhsxEP7M21uPJtu6Aj3hSx69hD4hZ
         TG8gEZAHk8e44urAyNsTB9vsNPYpmUWHUaLWFkvfpGJhB/NL2WsTZ+vbMfj6rMpjEJgB
         uhAEDCpMe6r8BvpZKgRuiiUiK4NbQhc4lyAzv69uqm/pDFjZXel7k9XxWAhUPNeA4zvY
         7NSHj34FvlQkeXg+Xre8trUq4PWRIr+R5ckTa20GqD8UhhPSryHeGK0jq+V2SS5cpRW4
         +esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLLHDLWtHTidzc0MuDneCL+O1YoJg/8zvgEK+mOLUac=;
        b=YVxrlt0LzOfhHR6/R/tMYcvDL2SxEG0dbjVgmISCaz4xDlMQ7ReLcphaJLLJDemxYu
         k7tuvGTc/2CG9UJDD2AdLcfgOaCG57rAtPHFrPua2vmH0QyTCatNHBU1OLQQnZnA3ynU
         IsaOREbNRG4L7RlZ8csNu3dMAJCGdwKobdWZ2eY8kX+Rv5raliEJm8gfaOtKNMHEyEZE
         4nMjqnBBtOeCjvwbZFIDgp9ivWsyV042ns1rSDAufrQlZVJFuBLUv7hoyk/EKD2PdVlh
         fReMQyYorNmUoTx6retWJjF7CzX1xtvmAyR05f6LDk17Gf5E2+sy/3JSySq5oduS33hB
         qhFA==
X-Gm-Message-State: ANoB5pkAvzcjxqM30GNdXMwG89VBLEiYtLWfilIN6sPnTrvVl/IRHN9U
        vEddb9ttjPKxPpskbnI1SkaU7fCNC8GoUA==
X-Google-Smtp-Source: AA0mqf60mpJP3wiS31ukok1TQAjbDTUi7Z/dY5g8hnH6n+aS50TZEtzoTt1+7rEYu5jTgUYWgSCuaA==
X-Received: by 2002:ac8:5405:0:b0:35b:b52b:bd01 with SMTP id b5-20020ac85405000000b0035bb52bbd01mr17424762qtq.466.1668528984565;
        Tue, 15 Nov 2022 08:16:24 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006f8665f483fsm8587824qkp.85.2022.11.15.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/11] btrfs: move root helpers back into ctree.h
Date:   Tue, 15 Nov 2022 11:16:10 -0500
Message-Id: <d74e17f38f37b4cdfb54e373b98a2ed399cd0f38.1668526429.git.josef@toxicpanda.com>
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

These accidentally got brought into accessors.h, but belong with the
btrfs_root definitions which are currently in ctree.h.  Move these to
make it easier to sync accessors.[ch] into btrfs-progs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h | 17 -----------------
 fs/btrfs/ctree.h     | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index cb59b69d2af1..57ba6894a5f4 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -712,23 +712,6 @@ BTRFS_SETGET_STACK_FUNCS(root_otransid, struct btrfs_root_item, otransid, 64);
 BTRFS_SETGET_STACK_FUNCS(root_stransid, struct btrfs_root_item, stransid, 64);
 BTRFS_SETGET_STACK_FUNCS(root_rtransid, struct btrfs_root_item, rtransid, 64);
 
-static inline bool btrfs_root_readonly(const struct btrfs_root *root)
-{
-	/* Byte-swap the constant at compile time, root_item::flags is LE */
-	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_RDONLY)) != 0;
-}
-
-static inline bool btrfs_root_dead(const struct btrfs_root *root)
-{
-	/* Byte-swap the constant at compile time, root_item::flags is LE */
-	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_DEAD)) != 0;
-}
-
-static inline u64 btrfs_root_id(const struct btrfs_root *root)
-{
-	return root->root_key.objectid;
-}
-
 /* struct btrfs_root_backup */
 BTRFS_SETGET_STACK_FUNCS(backup_tree_root, struct btrfs_root_backup,
 		   tree_root, 64);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5649f8907984..1d045febe1cc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -335,6 +335,23 @@ struct btrfs_root {
 #endif
 };
 
+static inline bool btrfs_root_readonly(const struct btrfs_root *root)
+{
+	/* Byte-swap the constant at compile time, root_item::flags is LE */
+	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_RDONLY)) != 0;
+}
+
+static inline bool btrfs_root_dead(const struct btrfs_root *root)
+{
+	/* Byte-swap the constant at compile time, root_item::flags is LE */
+	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_DEAD)) != 0;
+}
+
+static inline u64 btrfs_root_id(const struct btrfs_root *root)
+{
+	return root->root_key.objectid;
+}
+
 /*
  * Structure that conveys information about an extent that is going to replace
  * all the extents in a file range.
-- 
2.26.3

