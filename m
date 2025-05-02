Return-Path: <linux-btrfs+bounces-13619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E832AA6FA9
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3111BC7F65
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12424469A;
	Fri,  2 May 2025 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgdU4BVT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A523D29B
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181841; cv=none; b=if7kvJFTlLoJEy6xdnrqgkILXu6k1NABV62R1nl52c1MLWA87rvqxTbgnHfgCbX98+CmHcvfBtAqF9xC9E+79x83huteez9GBIDMXkiW1PrWcLegNB9wR7wf3tnhleTvuSEDN4ifqfRFkziVNtTKquAB6pLB38MdeQqi9GVLGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181841; c=relaxed/simple;
	bh=yckMPublzHqrlVUpgihtQ6DLBDO8sW1eZnkokqKNCkY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHHr5ffhfAO2gIrCo6mjvnTX+YNpKqrdmRUZhzfzt3DO0BJJL6mSQoi1/Av+LAV2zP0J5ROpbqAtLoIZfy5PCS007/0lfBxmy4guK3WK1AB6z6RFNLkrtRO7Og0YdtKsFPezsExtAOwVqpwHDVlp+Hc3Ru0carmAvdL/MFJi/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgdU4BVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CDFC4CEEE
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746181840;
	bh=yckMPublzHqrlVUpgihtQ6DLBDO8sW1eZnkokqKNCkY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YgdU4BVTW03TcUFat1rHjlTuc8r5VdDdE4XZEntu/d2T77Hx43vQNPkk3KL2TnFla
	 oNMYojORifMIVWN0c1wsVUWI42KkuqE7QXbmChLqvmUClNtgfvYw+BxBKK2YSOhitn
	 gbSA3kBI/djI0d7pZI6Qw+0hkEurddvtpavPHWuPXFLQlJ9QhAVY1QFnTZJWQ3vRs3
	 0T4bZ39XQuWo1zlPQUMKuR32Mm+eZIpzOud6W9CIuXqnvNKj76iNU7es30CVJQJD0c
	 NLN+x9kkCFWecM8s08CtrcIkiysM/Depwyok8y/0Bj3M+FV5H8xe2XeKW6y8moSH4/
	 h+WwcRaoi6wkw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: defrag: use list_last_entry() at defrag_collect_targets()
Date: Fri,  2 May 2025 11:30:28 +0100
Message-Id: <9710805966e88439eb0fe5e693fc493b2adc8fab.1746181528.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746181528.git.fdmanana@suse.com>
References: <cover.1746181528.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using list_entry() against the list's prev entry, use
list_last_entry(), which removes the need to know the last member is
accessed through the prev list pointer and the naming makes it easier
to reason about what we are doing.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/defrag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 48e12c8a90a7..1831618579cb 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1068,8 +1068,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			/* Empty target list, no way to merge with last entry */
 			if (list_empty(target_list))
 				goto next;
-			last = list_entry(target_list->prev,
-					  struct defrag_target_range, list);
+			last = list_last_entry(target_list,
+					       struct defrag_target_range, list);
 			/* Not mergeable with last entry */
 			if (last->start + last->len != cur)
 				goto next;
@@ -1087,8 +1087,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (!list_empty(target_list)) {
 			struct defrag_target_range *last;
 
-			last = list_entry(target_list->prev,
-					  struct defrag_target_range, list);
+			last = list_last_entry(target_list,
+					       struct defrag_target_range, list);
 			ASSERT(last->start + last->len <= cur);
 			if (last->start + last->len == cur) {
 				/* Mergeable, enlarge the last entry */
-- 
2.47.2


