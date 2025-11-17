Return-Path: <linux-btrfs+bounces-19073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C4C64072
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 13:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C8DE361979
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E037B32C954;
	Mon, 17 Nov 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCcs3AI1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F832C93D
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763382374; cv=none; b=QW2gR/7cDPst5QSjTw48PB7U9yJcSrlG0yw4mHB9cS/fRyI+dKau889nPT69hHqJA97T3qYkaYlFGkMfYnHMKuviPXcRQRRp1P1GAEeQP1cG51hZ1jLViZjafJPV0O9+3uKEK+CA+xSDEzB0uoOY52gASagzvjgKE7gQYJsAr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763382374; c=relaxed/simple;
	bh=UPkYPFRFpkBOGlopHVxydbTmc1dxBZ8hJQZAhm0e95E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKCpKbeZ4PdzjO1Y1k+WG9TfgO1+xi5Paj+8IgzYf3G0Z/fdDlS0if5oZZ/5YgQMRKS43AWAq2jSFILDB+nMbSC7uX28UOAWeOCRfNxh7pzwsFs4WFCUmB08mRZxvQ1QGpAyw8Q0NPe9fpvPS/ovQN0OTZeerirgFdCDVtmUyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCcs3AI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C51C19421
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763382373;
	bh=UPkYPFRFpkBOGlopHVxydbTmc1dxBZ8hJQZAhm0e95E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UCcs3AI1ofT4kQvOf1uxK+JwiWStMFnr6iB7XUGXC/uk2ULB2r0Vh25+dDR9LisUz
	 csNgsjEdYgyCex+Zl1fGhaY+cgK1AwijlGIXOj2njbGjxp40QFhjbS1t60d/IeKwqD
	 PMqozkl9V9HP9YYLX/Afs/aRKCm3+X5a0JlaH9BzhEf7yacqeqsNvpeXSrXE8rZFO2
	 MnKe81WGU/xiVChBkM+/Gt0+59zWK9MynSs7lDTXGz6f1I5GOAMSJ8pTC5v+EF5c/n
	 YvQoGmtFF2GZ0Jy13i/ZLN14rfpsOdruD7FnGymVCHoYJayGnAgY3fta4XXbVd3jIN
	 Rl2N1qQlJEkaA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: place all boolean fields together in struct find_free_extent_ctl
Date: Mon, 17 Nov 2025 12:26:08 +0000
Message-ID: <346b1a28b3ab4088d545820339ef8a1f54bf0ec3.1763381954.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763381954.git.fdmanana@suse.com>
References: <cover.1763381954.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Move the 'retry_uncached' and 'hint' fields close to the other boolean
fields so that we remove a hole from the structure and reduce its size
from 136 bytes down to 128 bytes. Currently this structure is only
allocated in the stack of btrfs_reserve_extent().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index f96a300a2db4..b284f36af4e8 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -49,6 +49,16 @@ struct find_free_extent_ctl {
 	/* Allocation is called for data relocation */
 	bool for_data_reloc;
 
+	/*
+	 * Set to true if we're retrying the allocation on this block group
+	 * after waiting for caching progress, this is so that we retry only
+	 * once before moving on to another block group.
+	 */
+	bool retry_uncached;
+
+	/* Whether or not the allocator is currently following a hint */
+	bool hinted;
+
 	/* RAID index, converted from flags */
 	int index;
 
@@ -57,13 +67,6 @@ struct find_free_extent_ctl {
 	 */
 	int loop;
 
-	/*
-	 * Set to true if we're retrying the allocation on this block group
-	 * after waiting for caching progress, this is so that we retry only
-	 * once before moving on to another block group.
-	 */
-	bool retry_uncached;
-
 	/* If current block group is cached */
 	int cached;
 
@@ -82,9 +85,6 @@ struct find_free_extent_ctl {
 	/* Allocation policy */
 	enum btrfs_extent_allocation_policy policy;
 
-	/* Whether or not the allocator is currently following a hint */
-	bool hinted;
-
 	/* Size class of block groups to prefer in early loops */
 	enum btrfs_block_group_size_class size_class;
 };
-- 
2.47.2


