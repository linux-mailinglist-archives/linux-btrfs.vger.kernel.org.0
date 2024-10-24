Return-Path: <linux-btrfs+bounces-9145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F99AEBEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F731C22AD8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D060E1F9EDA;
	Thu, 24 Oct 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvUafAcf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021BD1F9EC7
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787087; cv=none; b=csNVzf14RdfhZ6i2WoXcJItZjBPh+jouSfAFmJSsv+gmxRp/vK6I0gJfig/2nPoCreG7tSH4tOoZLEi1iqtqFq7m3yNbMdEc8x0mTAePNClMvp2qRXgb5cT79JHwnPORQBcrNrvyZ70QttWYq56wmtLfR/vGhzG3cmutdbULUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787087; c=relaxed/simple;
	bh=HwCcXjdhcx4SVussFAGFoWDEyo2vaeTZ0ZJA3N2ia40=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hegjzX3wrVE86IZcGKBS1yGGvTR48Z24cadsYJ/QzOhnjquk6FpGymF7LttDhBpO1S2yrZn7kGZsKXpvM0tgu6eEoomBEC5MK2U+5+hsE51iVkrFs4U5eNbAY6gFUa8jDqkBzGtBq5dnAXOjNwAJb620DWOg8eoF6VMHSYf0DZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvUafAcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E552CC4CEE5
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787086;
	bh=HwCcXjdhcx4SVussFAGFoWDEyo2vaeTZ0ZJA3N2ia40=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fvUafAcfJvkRwEQGQd/4Zlh4Rnh17oIAeT2+spWtW8nDPtvmz+5NZdyl2CRoDSlNe
	 Z8bkcQGR/J1iZOhCcMEQwaZBnXBW0blaDpxwz+E0N+wAEmhKJ9ie9IeEV61Y/a5eSK
	 HC48cb/OC+OdLx4trClwuSDPJqx4dK1Q0UzDXA46EYCj+gAAPzL9C7SzRE3kKxs/yA
	 KtqtElVhDV2/0zn6sxOu93CLNVe6F+uCmvyF32FrwI+h9XWFPX86kgWFdjfHtf4Rjl
	 lz6iCfNNYfn2cwmDr428Qn1k5wJu/zTNMkS7APxnpaak3vVq0yVqu3/R4EBonXHIio
	 WEgocF3hCdj5Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/18] btrfs: add comments regarding locking to struct btrfs_delayed_ref_root
Date: Thu, 24 Oct 2024 17:24:24 +0100
Message-Id: <47b682443436ae1533393fc0bfc25deef1f92366.1729784713.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Add some comments to struct btrfs_delayed_ref_root's fields to mention
what its spinlock protects.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index c3749e6cc374..0a9f4d7dd87b 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -213,19 +213,33 @@ struct btrfs_delayed_ref_root {
 	 */
 	struct xarray dirty_extents;
 
-	/* this spin lock protects the rbtree and the entries inside */
+	/*
+	 * Protects the rbtree href_root, its entries and the following fields:
+	 * num_heads, num_heads_ready, pending_csums and run_delayed_start.
+	 */
 	spinlock_t lock;
 
-	/* total number of head nodes in tree */
+	/* Total number of head refs, protected by the spinlock 'lock'. */
 	unsigned long num_heads;
 
-	/* total number of head nodes ready for processing */
+	/*
+	 * Total number of head refs ready for processing, protected by the
+	 * spinlock 'lock'.
+	 */
 	unsigned long num_heads_ready;
 
+	/*
+	 * Track space reserved for deleting csums of data extents.
+	 * Protected by the spinlock 'lock'.
+	 */
 	u64 pending_csums;
 
 	unsigned long flags;
 
+	/*
+	 * Track from which bytenr to start searching ref heads.
+	 * Protected by the spinlock 'lock'.
+	 */
 	u64 run_delayed_start;
 
 	/*
-- 
2.43.0


