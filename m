Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE562D12C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgLGN7X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgLGN7W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:22 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9AEC061A56
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:10 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so12472317qkc.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vx6FQGPAtVmSplymEMoDA9sA2iSVI0CL70LRafsPBms=;
        b=LGsOsfMZ1jKHLdPAtoIOhAaQ04qNbUKg6dYAy4ZPlnOUN6/1d8rbGvZ8nXfKgLgldp
         bkAL9+64iltQYLKWZteCh/z34gl7EBcNZGLroOjDA0nIhNtAlg2wcXgScfCcsJWO0EZI
         AiZ6/qObFv0NGIctbILWJ9/Axjdp2jSO5ctXuf3wbBhTwJkSlUywjnMdI70LB8l0XytF
         ptAi7J7lc+VpAVzgMOBjUaP7zEgqa/x+C9G50HLmIvICEY3aMxPn59JxHOsjFFmlmL3A
         tI/ajnj+EniYpGkeaFTzrkTd4beFVKZqRsynf7LFqzvaHEVmKG6B6SD+E9ODJEdYBOzb
         5sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vx6FQGPAtVmSplymEMoDA9sA2iSVI0CL70LRafsPBms=;
        b=OB2Q6EDFtiHSArXLRtMjp01og6VpDC/+Eyv3XEY363nTM7+YekA+aGMazTaz+P0pN6
         whtEWHCw8FzkYtSyRlwI0JjX+ESiK3Ln0b4Vfdjeiz/4AuBBwdJQCm7V+G8KHoyBoR9C
         dZj48ZemWQqShNva3khzylaEVJJ2QY1NCnlO3yTncVkQy8/XwuTZS4gPlfNhrKZneymW
         FXjHiTBrfo6I50P8QItYYSRK9LyGIwnMO/IVtnYg5qdhkSCeO5uy53DhBSKTUbP45QzG
         d1UiQtcVNBlRRKI747dz6PsTV43HG3dvJ1KOUmN/dLF8h3QJq0/J1lKRL494gf+v7v4q
         6Hew==
X-Gm-Message-State: AOAM530li5YaglKWP7AvA3EpAh9RtRqUofHdFmaFkSsKJkgNaaflMNRa
        5rd+mlKk6i+y3dz5aE6o2OKFiaJJWLfh+9JF
X-Google-Smtp-Source: ABdhPJx/+QHuG4xjWi2rG39dfZmYUt5nW/uo5eCbktaeYXg6MD0G6O3qAvXXjjmzetpww96fDtFWOA==
X-Received: by 2002:ae9:f819:: with SMTP id x25mr4515801qkh.429.1607349488853;
        Mon, 07 Dec 2020 05:58:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c65sm11763930qkf.47.2020.12.07.05.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 11/52] btrfs: convert BUG_ON()'s in relocate_tree_block
Date:   Mon,  7 Dec 2020 08:57:03 -0500
Message-Id: <aa4408fa3d3cf6229eb5a26e51aac0d2d2e8aacc.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

