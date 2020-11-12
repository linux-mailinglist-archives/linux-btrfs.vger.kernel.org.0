Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38B72B0FEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgKLVTV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVTU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:20 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9310BC0617A6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:20 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so5239069qtp.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wvlptdhOHNXdTmxMxsjHew+2CVsG7O6ODP9R3C3EDiY=;
        b=CSXlgHwC2VH4qUq2Q6Jzud9i38ebLScVV76H00vVzfBe6nrecPEX+VwvIa0rTvugeX
         +fEiFyTaL+1H45uxlP4K8lhjVtxjyrcC3zTdB+wSxib39yDVVhe0i0uOPc0ByjFMLLNi
         8/h22tK1zPaPt+VfsppfdP5n/umvFI3tO4ufEIAndCylaDU78tOA9z02cnXviLdXSNWI
         WfAjH/1mowDuV2ekoxAD0fRA6EJ/S4+3Ka4/nn8gY6vP/t4PoSBEnKtMsT/BmwMTXTcD
         JezSf8qJaz44wgmcjLCOJmZ81qkgMgvxlm3d5u4TLQ6P8SkuRIP7bL0orZT01V5QkngF
         jvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvlptdhOHNXdTmxMxsjHew+2CVsG7O6ODP9R3C3EDiY=;
        b=cZl15xP0+0DP5QFfRlZM1lODUCUTG5TTszOS5eDpSNHFjz0eSrK98JYmDByr0K0jby
         YDczzBDN/9/+RQaEotYcH7dJoBkcDTcWpOe8QIBPoD//dsJakIAi3e0aopzwPjHgqEW+
         U8LuWtW31LoEqqeKKRimKmq1m6RbVqrRpoN82Ryv5Yu1KHxYb8IfaMcGrXiRH2ptim0B
         jwQuJQDvEBkBc1hFTeL2a6gmA4iuNv6BpXX1jWAVdp0Wx2Vm4yzq0C5kTyKI0FU60F4W
         yXfPOTQzhVsVrg2h6A1nfTDWSM6LcsmreRmwWGtGTTYbl/hmxLId7ds3ysY+QrTn012z
         lMaw==
X-Gm-Message-State: AOAM533tyw9Gl0eNmDlxkrA33dKEVKVZPCWapxCz7Bgujqh9E61WFpau
        /4HCnL909TVfuRpq08AqaVW5Hc2PaiAAMQ==
X-Google-Smtp-Source: ABdhPJyR2VspoZlkPISXBTQVCg5h8P0RtZ19vE0H3ckxlVDWG8eRqE9tNWYJ52pG7wFAIXTWv+7JTw==
X-Received: by 2002:ac8:5901:: with SMTP id 1mr1267626qty.350.1605215959429;
        Thu, 12 Nov 2020 13:19:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d184sm5663680qkf.136.2020.11.12.13.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/42] btrfs: convert BUG_ON()'s in relocate_tree_block
Date:   Thu, 12 Nov 2020 16:18:31 -0500
Message-Id: <9724af1d84f1a58a769ec6d6dd1c79ed400774eb.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a couple of BUG_ON()'s in relocate_tree_block() that can be
tripped if we have file system corruption.  Convert these to ASSERT()'s
so developers still get yelled at when they break the backref code, but
error out nicely for users so the whole box doesn't go down.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6c9bba61bfde..bc598eb014fd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2504,8 +2504,28 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
 	if (root) {
 		if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
-			BUG_ON(node->new_bytenr);
-			BUG_ON(!list_empty(&node->list));
+			/*
+			 * This block was the root block of a root, and this is
+			 * the first time we're processing the block and thus it
+			 * should not have had the ->new_bytenr modified and
+			 * should have not been included on the changed list.
+			 *
+			 * However in the case of corruption we could have
+			 * multiple refs pointing to the same block improperly,
+			 * and thus we would trip over these checks.  ASSERT()
+			 * for the developer case, because it could indicate a
+			 * bug in the backref code, however error out for a
+			 * normal user in the case of corruption.
+			 */
+			ASSERT(node->new_bytenr == 0);
+			ASSERT(list_empty(&node->list));
+			if (node->new_bytenr || !list_empty(&node->list)) {
+				btrfs_err(root->fs_info,
+				  "bytenr %llu has improper references to it",
+					  node->bytenr);
+				ret = -EUCLEAN;
+				goto out;
+			}
 			btrfs_record_root_in_trans(trans, root);
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
-- 
2.26.2

