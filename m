Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2482CC71E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbgLBTxF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgLBTxE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:04 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C112C08E864
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:15 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id z188so2458743qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TTb/5zE+ygBXYb5Zd2mchi73Z/HKs2TAejUgXdrdOJQ=;
        b=oWYRuITNDbi4YwfUM0BtkfWrlPU/t/MNtPfkrrr45kI9zANDLupoO0BC1cgluTMQVH
         1KR7ykoOA3vJo2LJUR/7M48WmvJlrqpWCjRGBEeFVn0MZZexDUtMnXrVx36I08vzTXKP
         MbBNr/aRl13h+KDmxmScbRraUrNClWCSKwiP8Ffp1ZfYhlgRdBYr45QW0uBmEtzPMQyo
         KaMZgR78YZpHtWh50m7SDbH7/JuGtKtMJi/ICaUga3SKUzBieuOmQ80Q+Qy3PhC4oXWU
         ojG94+vrRd0sVmieimWlmgynWaFz6+wfeAebpshY/iWFPsEy6dqcuKthNBcanasmW2LY
         Sz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTb/5zE+ygBXYb5Zd2mchi73Z/HKs2TAejUgXdrdOJQ=;
        b=Yp7+b33i1LMJnt5MUNGFvXtnTuas9LIUAlPeEjUU3uzruVP2cFDT71YMVks0pw8X+9
         +tX67fNSi3gRSKdH1VwAgB+U1+PO1Ta9x/PQCjtl6/vDpDDa9D8sPhY+RIMi7STL0O/F
         ungGbcTwBrBkzDjHKaEcwc8Usrso2GhRUFfGHo+2HRwj2KG45LMNnH7N3oRuavY2q4DY
         pwLzccyaY4XqNehr4CTmDZp++fmMqpxLLmnSftcnkXjyMyezrd26neUg4IcQG8ncAmLe
         3vj1nT2B1tlTV/ylOO1R12xgrIPO9+Fgkrw+k+iEMIWS0w2TO1qbs9al1uAcDm/FKG4n
         uFBA==
X-Gm-Message-State: AOAM532EL34HJfVzac+gip0m8b8Q4mSspQ5WxL7/KxM8te8tCqM6OcZu
        gW713cGgsRHM8Sgs2ZYNYu/vjmtX4aId0g==
X-Google-Smtp-Source: ABdhPJzveWByL2Uvj0+7jLKxs7WrjnlaZ3pz5SiQ/SjjCWdmMVGWFQkGO4ewTjjvDE+xQ3cJdPG9KQ==
X-Received: by 2002:a37:5185:: with SMTP id f127mr4233069qkb.225.1606938733924;
        Wed, 02 Dec 2020 11:52:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i11sm3054203qkg.45.2020.12.02.11.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 33/54] btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
Date:   Wed,  2 Dec 2020 14:50:51 -0500
Message-Id: <7db77da1018bf56f0256a29aeb68ab585d212466.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in insert_dirty_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6b2d7168f98e..96cc9376b3a6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1562,6 +1562,7 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
+	int ret;
 
 	/* @root must be a subvolume tree root with a valid reloc tree */
 	ASSERT(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
@@ -1572,7 +1573,9 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		sizeof(reloc_root_item->drop_progress));
 	btrfs_set_root_drop_level(reloc_root_item, 0);
 	btrfs_set_root_refs(reloc_root_item, 0);
-	btrfs_update_reloc_root(trans, root);
+	ret = btrfs_update_reloc_root(trans, root);
+	if (ret)
+		return ret;
 
 	if (list_empty(&root->reloc_dirty_list)) {
 		btrfs_grab_root(root);
-- 
2.26.2

