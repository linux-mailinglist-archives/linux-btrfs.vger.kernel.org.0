Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B305FEF98
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiJNOCw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 10:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiJNOCh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 10:02:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC81D347D
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:01:31 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id cr19so417920qtb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2nhG6drTSbfSI7gf5b0s8uqBtc2n80Gqrd3Oc8irVY=;
        b=efiIYEjGgelJWZJhUsO0OYEoeLiYUiom8j7cryx8s5+drhMTmlkJf+uqvJQDF2K09q
         jo1IlMkCcYdoypof9lwyhH4M2nujSaY3SZwl/x1sCBufflxh/ZUJ1cFsnaWI1d1Y/Jh+
         6BQZ0+sFukLLz0AaExSi0Mx8zNXDMatZ0tqPjl7eXDGuMsZ9SclVATZ4El4PjBmSIjHF
         vRBvWAfQpFrU6WJGh9BN4exY6bc6rlUycJaAsFe026sTqF2vb1GN6B2j4mIM0yuyb+I4
         JfMBcuYjHI+RdhIznHORZQ5MVbqJBL+tYDPBccOvRzCpuAmvwuDKcNd6SXjgpEL030vZ
         IOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2nhG6drTSbfSI7gf5b0s8uqBtc2n80Gqrd3Oc8irVY=;
        b=vViLqNkzxa/8roEyK2hgSjIs1SZPlTrEqRrw3eeg68PXZVzXmDLHfSlWPR94q/odOr
         xfuoYTqB228bRQE92R0yAGquCZ7FxLC9cLqNuxu8zylne/vmy3TvOT0yPt+lIS98Qbky
         R58LOAb2bd46nBSKl7QZ9P16KTNvFRLGXEGdimDkFTMYIHfhf3P3yMMNChwRvU6/sRRP
         lIRHmQDpBmByLwWtiqpu3w9JiaADwY/iEKe60HSQYRCZ1TYMmsFVq4ID602BhCufIjfZ
         A2syTpP3rRS6j8kmzW1AFZotsUSqS5xi4eXn+5GTdEVWI+xO0XG7RkuZajsxnKo6pz/V
         uM3Q==
X-Gm-Message-State: ACrzQf3oIttCb+FQ7ks/N9W+ojqGdsq9R9uYH1H3EgPFpxVaDsoGIjqo
        RfOL8PDUduEo6E/hrFbqTkimvubgQRlhMA==
X-Google-Smtp-Source: AMsMyM467O3VjBQAfp7ghHx/Umj2ffZHQRywhnBIEcGz5vljOEZSqYQwPyBgik9PtdzVMReSLkQjhA==
X-Received: by 2002:ac8:7d90:0:b0:35b:b5b2:e05a with SMTP id c16-20020ac87d90000000b0035bb5b2e05amr4140245qtd.513.1665756049831;
        Fri, 14 Oct 2022 07:00:49 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d8-20020a05622a100800b0039cd508f1d3sm2136907qte.75.2022.10.14.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:00:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: do not panic if we can't allocate a prealloc extent state
Date:   Fri, 14 Oct 2022 10:00:41 -0400
Message-Id: <97fb0828deb341efe99ef2bc35cda0eccc5963de.1665755095.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1665755095.git.josef@toxicpanda.com>
References: <cover.1665755095.git.josef@toxicpanda.com>
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

We sometimes have to allocate new extent states when clearing or setting
new bits in an extent io tree.  Generally we preallocate this before
taking the tree spin lock, but we can use this preallocated extent state
sometimes and then need to try to do a GFP_ATOMIC allocation under the
lock.

Unfortunately sometimes this fails, and then we hit the BUG_ON() and
bring the box down.  This happens roughly 20 times a week in our fleet.

However the vast majority of callers use GFP_NOFS, which means that if
this GFP_ATOMIC allocation fails, we could simply drop the spin lock, go
back and allocate a new extent state with our given gfp mask, and begin
again from where we left off.

For the remaining callers that do not use GFP_NOFS, they are generally
using GFP_NOWAIT, which still allows for some reclaim.  So allow these
allocations to attempt to happen outside of the spin lock so we don't
need to rely on GFP_ATOMIC allocations.

This in essence creates an infinite loop for anything that isn't
GFP_NOFS.  To address this we will want to migrate to using mempools for
extent states so that we will always have emergency reserves in order to
make our allocations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 618275af19c4..6ad09ba28aae 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -572,7 +572,7 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (bits & (EXTENT_LOCKED | EXTENT_BOUNDARY))
 		clear = 1;
 again:
-	if (!prealloc && gfpflags_allow_blocking(mask)) {
+	if (!prealloc) {
 		/*
 		 * Don't care for allocation failure here because we might end
 		 * up not needing the pre-allocated extent state at all, which
@@ -636,7 +636,8 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 	if (state->start < start) {
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc)
+			goto search_again;
 		err = split_state(tree, state, prealloc, start);
 		if (err)
 			extent_io_tree_panic(tree, err);
@@ -657,7 +658,8 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	if (state->start <= end && state->end > end) {
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc)
+			goto search_again;
 		err = split_state(tree, state, prealloc, end + 1);
 		if (err)
 			extent_io_tree_panic(tree, err);
@@ -966,7 +968,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	else
 		ASSERT(failed_start == NULL);
 again:
-	if (!prealloc && gfpflags_allow_blocking(mask)) {
+	if (!prealloc) {
 		/*
 		 * Don't care for allocation failure here because we might end
 		 * up not needing the pre-allocated extent state at all, which
@@ -991,7 +993,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	state = tree_search_for_insert(tree, start, &p, &parent);
 	if (!state) {
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc)
+			goto search_again;
 		prealloc->start = start;
 		prealloc->end = end;
 		insert_state_fast(tree, prealloc, p, parent, bits, changeset);
@@ -1062,7 +1065,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		}
 
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc)
+			goto search_again;
 		err = split_state(tree, state, prealloc, start);
 		if (err)
 			extent_io_tree_panic(tree, err);
@@ -1099,7 +1103,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			this_end = last_start - 1;
 
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc)
+			goto search_again;
 
 		/*
 		 * Avoid to free 'prealloc' if it can be merged with the later
@@ -1130,7 +1135,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		}
 
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc)
+			goto search_again;
 		err = split_state(tree, state, prealloc, end + 1);
 		if (err)
 			extent_io_tree_panic(tree, err);
-- 
2.26.3

