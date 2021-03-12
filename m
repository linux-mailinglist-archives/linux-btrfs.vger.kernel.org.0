Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479B6339835
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhCLU0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbhCLUZk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:40 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F785C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:40 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id l132so25715800qke.7
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WEg5NZ7Z9SwA81D5qtcCbo6KqyrEoQGpeqB3rxmufLs=;
        b=J9lx4RQLmbUqnjwv2yhF8XdDWU16GOZ8QfZFiHx2sOCq03CRMCCHAVzhPsCaWDPBRt
         r0uI/ZIyLSL+NyndHQlc7SupWbRSgp/0vMVg9s+XksNs4jrAXq3ICEWo+2NcNam+SgKy
         1GIYLXD01aMFtMz4nep5x5ZxLSI9imBM1/68Xr2TDkZXOPkGfjdEdgWrJswdpL6TAQDj
         WHHBGX1vSq1i11qPsLUvH0x1XGqYEmbxWdeE+HwwYRb7Wr964tAx2HpRxX0eYmLtcW+V
         ZKYy/86BG23lh0uH1R/r+FFigFf+Bu4R3MbsN4tRmwMAXYY4jGWKeCs5rn6sp/344Qup
         b7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WEg5NZ7Z9SwA81D5qtcCbo6KqyrEoQGpeqB3rxmufLs=;
        b=qORsJith0wuA6snAWoGbFepqcqs7Sas2klfMjj/pUZ9ReFiQCQhLrXWG7zWGT8sKCN
         Fl8hf3aAR2rpU4VzzD6b1QHL9k3VMke3I8K/swy/eDjdpgHjcGqepr69KBwIJ9tZJKS7
         pent5rXr00ZXKq4GvLZh1aoN+L2yWjpUUzvIApCnNbPoJf3U7/iXRyVxRyCpTgw/OH3e
         SQG4/cXcc5qAPH9rLLadnRan+R12N2zLKhNgHVPTMUCUNDODxkRxT18Jp+lsksXIcC+T
         3ZuEaZ5Ps36pqbAe6G8XTfR6glpVLdFRdeUxf59BV/c18jvMLmJGqnh0SYEsmfbhVagd
         JDfg==
X-Gm-Message-State: AOAM531uRDs5jTj5tctSQe50AQEI7iZE1GvFuNKXSIe1StYVBnxbntlk
        +F0RuUXDfqwelyNTM7rF/V+eZAAvCHMYhIBY
X-Google-Smtp-Source: ABdhPJzcm8KAVJ1RacsVKHGlps1yzYloliZKJkr6KhDmoSEUsNzKkZAD1C3ukEY+AQolRRN4okX+7w==
X-Received: by 2002:a05:620a:22f6:: with SMTP id p22mr14818838qki.297.1615580739424;
        Fri, 12 Mar 2021 12:25:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f12sm3723647qti.63.2021.03.12.12.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 02/39] btrfs: convert BUG_ON()'s in relocate_tree_block
Date:   Fri, 12 Mar 2021 15:24:57 -0500
Message-Id: <4b260de8ad7f37a5efdd2c50446e970c3e7f6572.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a couple of BUG_ON()'s in relocate_tree_block() that can be
tripped if we have file system corruption.  Convert these to ASSERT()'s
so developers still get yelled at when they break the backref code, but
error out nicely for users so the whole box doesn't go down.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 63e416ac79ae..1f371a878831 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2454,8 +2454,28 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
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

