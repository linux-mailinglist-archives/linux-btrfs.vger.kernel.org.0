Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2803C2CC713
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgLBTwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgLBTws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:48 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3FC061A4C
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:34 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 4so1311249qvh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ipFDz8Y9/En+jh8nzeEiCg0PC01KvoIacPRgVqyOtGQ=;
        b=fKHHsmk7biLb9BcV28YlnN8vWgjOYbh/jAXRm04lfPFja8IhB8aKEEo+lOeLNSelTJ
         0kXsnH2vbHnHUvCap850nxbkFTlT1Nxl49QQJnFefNpZnPgCJc5L/OVgnAlVAu3z0ZSA
         rD+ol6XD4wQn950nvYT0RS5lm3pniWhEvUW/ocmYEVwBb2TpU320NzdPKAiSjnBLNuxh
         emDcZIPXgsXk9UGbqaXI8zwyZ02sMmaqOdKOXWWkRf3PvdDXcX76p6RpLd3Q+GjAQEZV
         DWchNIS/HDhU13ECr06vELLbujEPyU5OLVNzvUjaGXhC8qS5N/DWnnXRyA5xvJyCmsRV
         8lRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipFDz8Y9/En+jh8nzeEiCg0PC01KvoIacPRgVqyOtGQ=;
        b=YO2mExGp29iJwf1NB6EW0Zs9/hKnSZu/MY7FD8oeZyxbp502zaLPDj+A1QBz5ycEWd
         9IrWCU2LGodxQinVbQcgnmXiee8Gh2C1L2vBwNFqQUfnuJ5LkOH8gPcnQkPkw1zHXHld
         X6d6NfGwjHOXGXjh30G9LVZfnwhhxhRW5otMADrctd3shi7cuHqYbNnZSs4TYtnefFfW
         nNt3OfWB26FezrnVpPMhQ39RvkgFou3Lkdm+H9APzYdJ+EC8T2xra6Mf51FZoFy8anpk
         REUa7QZpIx8x2m62U0lEe7BsRAomWj9+EB1Hwa69NupyfS92e8P5XqmOn2qVIuEfRUEJ
         PgYA==
X-Gm-Message-State: AOAM533nNCVwBjtWASY+j66/RIq9vYss1CjcbMpZJNJPFuGnFsX/vFEl
        KZ/eRG6wLgkvAdIzMpnP26FKRsbfYxmLQQ==
X-Google-Smtp-Source: ABdhPJzUrmFpEDIdaWiLUwVNJVbPefLX9JQmvGKOmIYodjyom+VtlAasDrhhHeVzw6KEe032y2TeMA==
X-Received: by 2002:a0c:8149:: with SMTP id 67mr4040608qvc.52.1606938693101;
        Wed, 02 Dec 2020 11:51:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v204sm2946095qka.4.2020.12.02.11.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 11/54] btrfs: convert BUG_ON()'s in relocate_tree_block
Date:   Wed,  2 Dec 2020 14:50:29 -0500
Message-Id: <bba6b87c894fc35055d99f51b16b66e662f1b127.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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
index d0ce771a2a8d..4333ee329290 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2456,8 +2456,28 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
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

