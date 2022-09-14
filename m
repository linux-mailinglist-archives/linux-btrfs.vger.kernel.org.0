Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED655B8B5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiINPHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiINPHK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:07:10 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F479A49
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:08 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b23so6461831qtr.13
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=rx8NeG33Fl4q8q9d+yc1PuVafftTRjEnSflraFqsZUI=;
        b=0ffH4QpgElWLc0ibgoivHqZO6eUmUCeOpzY/fiwuYsFph3k9vgZWgwgDq87veIQCK5
         nfh2/CBCFxmkDL8s6A8GhVjk21+qmprx09iq+phtctbeuDtLaw1p0F+HHXBdrfJwFKMD
         5BcpCKfwUfigry/znnozVh7/KfGzeP9/dqzng2aO5sO3hgmp7ToT5/bhAbB5dLBQJE9c
         1TjdUiKmRr6rU647C30O9bXGFqRMI6t+nKnC1BGBBzHmpPi2zsf1iUhQ/553LsUcm4Pp
         ihYQ7JG/e7mZt3E2NhQ+G3jMm8ITQXbuuPxDenTmVn+RO2Bg7tUMuHWekiA3p9oIfxF0
         BFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rx8NeG33Fl4q8q9d+yc1PuVafftTRjEnSflraFqsZUI=;
        b=rAO7nkL8D/RoiKjfxgOwqiNHICT2bOfsCmn9v6uttq+QVhqHxPuw9SJkT+r8iu0Dmq
         iXMzovq0Mr7r/Z4X4Njl/nwXFCU3eq55sJtyHwCD1EVXnHgBpDy/HQUhIxRw5OsYYm4o
         v2Wk8cQwWRX1YAy0TTB9q2ybnl1AlNhm60g3WbscaDxP7Eiit9/pF+GfIBW/N1S3GGci
         s6wtrU4lqsePIrSiYUGdR52qpHuv2KFfSwXfyukb1AQIa7wpRA6kym9uOaMo34lbImnk
         SMGGVBXCiXyom8Vybrs9uV93OlZswdu0lRoST+2gHIcpr4xv9NPg83sL8mN0aBbAr+/p
         ENMQ==
X-Gm-Message-State: ACgBeo0vqTOUvppo/eMD8M4yqaq0h+tfoZ+Pi0NlrBhLqbS4530sNvPs
        DPK1ZM+q8r6r5XCDSFc3mSK00pB6+jkUpQ==
X-Google-Smtp-Source: AA6agR5fqWonoVDVoD+yBYC1xsTX2idy5uqzpZiUslSI9eMz4V2xorTyBXbv6t+mWc2K5GFZcE75CQ==
X-Received: by 2002:a05:622a:138b:b0:35b:b619:b87d with SMTP id o11-20020a05622a138b00b0035bb619b87dmr12860787qtk.146.1663168027293;
        Wed, 14 Sep 2022 08:07:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id de42-20020a05620a372a00b006b945519488sm2117543qkb.88.2022.09.14.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:07:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/17] btrfs: move btrfs_next_old_item into ctree.c
Date:   Wed, 14 Sep 2022 11:06:40 -0400
Message-Id: <6b4e55458868b7d8f7b61be137fe9f9d7860dea1.1663167824.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

This uses btrfs_header_nritems, which I will be moving out of ctree.h.
In order to avoid needing to include the relevant header in ctree.h,
simply move this helper function into ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c |  9 +++++++++
 fs/btrfs/ctree.h | 10 ++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1f0355c74fe6..0f7f93bc2582 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4775,6 +4775,15 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	return ret;
 }
 
+int btrfs_next_old_item(struct btrfs_root *root, struct btrfs_path *p,
+			u64 time_seq)
+{
+	++p->slots[0];
+	if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
+		return btrfs_next_old_leaf(root, p, time_seq);
+	return 0;
+}
+
 /*
  * this uses btrfs_prev_leaf to walk backwards in the tree, and keeps
  * searching until it gets past min_objectid or finds an item of 'type'
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index af6f6764d9a4..42dec21b3517 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2836,14 +2836,8 @@ int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
 		(path)->slots[0]++						\
 	)
 
-static inline int btrfs_next_old_item(struct btrfs_root *root,
-				      struct btrfs_path *p, u64 time_seq)
-{
-	++p->slots[0];
-	if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
-		return btrfs_next_old_leaf(root, p, time_seq);
-	return 0;
-}
+int btrfs_next_old_item(struct btrfs_root *root, struct btrfs_path *p,
+			u64 time_seq);
 
 /*
  * Search the tree again to find a leaf with greater keys.
-- 
2.26.3

