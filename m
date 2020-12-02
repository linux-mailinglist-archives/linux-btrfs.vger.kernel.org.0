Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCAB2CC715
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbgLBTww (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388416AbgLBTwv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:51 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19613C061A51
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:44 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id n132so2481337qke.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T6rdMJySAx45P25KkcgFnxr92qOVPa5kxeiZJVmSkgs=;
        b=0+3MgzFH6G9Mf28qOpmnoDXYedWeyFbkJ5LeJu5NGegdA1uIJxKbwd5Y183g7D7XvD
         cT222yqwplscdSSTUODe720BLKo/dcBgoKTXLthiAMCPOveMsWveuxFnQf7ldXILRVt7
         nd93UVnW1brHLdRvYSzgxaPyVHlWEfjfun1nB7vECtU5wSdwK6QtGtcSM4LYaS7ioe7I
         NHqgNVImbR5kC2C3UEd2iBLziIFEJdT464vvFuQQhFsULYtshpVWBtRchKt5o6fldFIw
         bO1lUwPtloacwkJbwi5z9BZ4v7vF5+AQ3wghCM79oRVG+pimu32uS2fbpZrhax7NU/hm
         KbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6rdMJySAx45P25KkcgFnxr92qOVPa5kxeiZJVmSkgs=;
        b=Tp6i6BYRuYu4CHK3kvW1Lh8VzYL5b6c3eP2laFK15X1rALPodKRZNjvvp4p/7w7M6P
         SoNrOKZNsZw582ehnRvA/ub6qiSYAK6soXNelCfeJ/BVXyYYiRZdMpuNiDdIKb5fe3xH
         G7O2JOr2eEkYPMtwj3KM2TolMD6yg2bHIQIyiPWax2YqD2RahxNVycaWetCcNubxdvex
         ab2guWFw2LFRDXkf9mHyuwUupgaVKK2+l30VjcKqz6isYY/CRlBI+dS5/PodrlseE/t7
         P2KD5nK+yzJ6uM9ZZtveQ6k8kED8Vair+GmTDww5Hu3LUAB4fiB4OseVahwjgWaLcCOI
         4skQ==
X-Gm-Message-State: AOAM530mdV86RXtsfXykbFwpWdWNskrnK4k/hFFstlsWVmvoWTrycRP2
        J5eJ8Kx8dUM8WZ/fSyv2ICxu43xR9uUj9A==
X-Google-Smtp-Source: ABdhPJzMyf5MQfHrF3Ty/Or5h/MhEurhUSztw6xCZjlGEzghJIUQmocF+EdRqz+zyFVIwwQ5NMOiPw==
X-Received: by 2002:a37:7cb:: with SMTP id 194mr4132671qkh.289.1606938699971;
        Wed, 02 Dec 2020 11:51:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j17sm2685600qtn.2.2020.12.02.11.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 15/54] btrfs: check record_root_in_trans related failures in select_reloc_root
Date:   Wed,  2 Dec 2020 14:50:33 -0500
Message-Id: <b17d60d0e20d5898344b299d7018418d4c082fcb.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will record the fs root or the reloc root in the trans in
select_reloc_root.  These will actually return errors in the following
patches, so check their return value here and return it up the stack.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bf4e1018356a..d663d8fc085d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1990,6 +1990,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_node *next;
 	struct btrfs_root *root;
 	int index = 0;
+	int ret;
 
 	next = node;
 	while (1) {
@@ -2027,11 +2028,15 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		}
 
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
-			record_reloc_root_in_trans(trans, root);
+			ret = record_reloc_root_in_trans(trans, root);
+			if (ret)
+				return ERR_PTR(ret);
 			break;
 		}
 
-		btrfs_record_root_in_trans(trans, root);
+		ret = btrfs_record_root_in_trans(trans, root);
+		if (ret)
+			return ERR_PTR(ret);
 		root = root->reloc_root;
 
 		if (next->new_bytenr != root->node->start) {
-- 
2.26.2

