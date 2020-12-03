Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690102CDD69
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436594AbgLCSYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436511AbgLCSYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:46 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07ABC08ED7E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:30 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id x25so3038572qkj.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZtS+/iNcUGZ7qi8wPR9jUj/YATP0ShgqNn+aX93evM=;
        b=EoYIvTlsFM55mpmYQeqjWGPLdoJZN1QvpiKRHsFk0lzDjWi02eLCdHU6KAnqY4+Xkd
         TR8F4SGlVQFlUiiuppllZhGswsHXT0fS65wrD+MW3Jh9aBYWw7Du60t7vPTnjtZEiFEZ
         PXDpQOL67K9dCyv1rtAdjYgDkxSexWr/2bqkFs6xzsyzZRBbR6vBUjv/kMWrjJavNN5n
         kihJUz4kIQLTcwKdo8Pik5MBvWX1FoTL6ek0qz6DAMmqSMILAo1ZTYOYcPgtAsbUuYVX
         vz9dNpG5nu4lF2wsCVM7fPsYB0W+2XlG3cfqmpfuv64ZJwNmpACWk4tmETbjgJyPGkNa
         g+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZtS+/iNcUGZ7qi8wPR9jUj/YATP0ShgqNn+aX93evM=;
        b=J/D9rHuwq9m0GZwUC0O6HF9NtMMGBFdpDj7YyVgqkSoz4Kqx0rmjqlFJRsqwhAMdJl
         aNy3A4aWkQvaS/S/LOkO4NiS7gOc8sCAXD2eUdcx3/zXX1O6qjqfwSwu9Q8YUPNlARSR
         YVGMhcMhjosDLD8v/wt0dfloMJotw89rUySkY/OP1VUkzbldzCpeeoWkMGc2PzK/BrhE
         gJ68mkjoPIc59FWVaT9CQSNpOM0opA1HhUJLn5L60YHLgRaFJQSMXlHRtCYOai4OqdIM
         Y03n596fD4ehr0FpWZtljEsOtVs30iwINuSb0HsAB/yS/tzj5tb0oHRLak+1ih1UbCTh
         57yw==
X-Gm-Message-State: AOAM533NKW7TDMp80AMq3GLmdVGxLjnFnn4gLxhVILScBErp2BCTdH+s
        ZcWmg8EvXkbS0QNcHcZk12+ylXXAokh1wByO
X-Google-Smtp-Source: ABdhPJyEdaw8gZkhMDd/2Zxj2PKSimps3IcAfA3m8RdUe4eeRC03dkqn6qIn4otSYNmFrCLdXW33VQ==
X-Received: by 2002:a37:ac8:: with SMTP id 191mr4038603qkk.381.1607019809853;
        Thu, 03 Dec 2020 10:23:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x21sm2023229qkx.31.2020.12.03.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 16/53] btrfs: check record_root_in_trans related failures in select_reloc_root
Date:   Thu,  3 Dec 2020 13:22:22 -0500
Message-Id: <216e7d9de97a4d6db2f9de7a09ca1d5d7b8f8b24.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will record the fs root or the reloc root in the trans in
select_reloc_root.  These will actually return errors in the following
patches, so check their return value here and return it up the stack.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 05b80b9ab1e1..a3ad44605695 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1990,6 +1990,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_node *next;
 	struct btrfs_root *root;
 	int index = 0;
+	int ret;
 
 	next = node;
 	while (1) {
@@ -2025,11 +2026,15 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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

