Return-Path: <linux-btrfs+bounces-14918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08963AE69BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732BF4C49F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9E62E0B52;
	Tue, 24 Jun 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVfG3MrI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027E2E0B49
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776149; cv=none; b=DSaWFpV9gUmg4D2MtvGXjqGZdSzlYY5udYHiF+hCymoesbewdtPRY1rhKaNX/w/vFVQ2hpo9vKzTo2TIvXvdWbhHpnC72iDqmeiAv+Ob9jxzTUqDvygg11y03VH/QFFT1J1wR7QXVb0FrpNpMH19pDBGmerh1NTWbnJniyKfIqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776149; c=relaxed/simple;
	bh=5mvBoxTaZeXm6y0SzxujCJJBGVLQiHzbgoNJG/CVvV8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvhp8O5ojG3KyRZrd/6pxpwu04ktnhSANpiEjS2Gqw+3mGITrIuMDv1M1SShne5BYZsH88zwZhj+vz0wDJvx0I6b40mcgzdVtPBrLrZH2jEX2DIuAKRu7p6DoHgczAxaVUWgUXqBTBnjSz/+Aqtlc13QZNc/WlbFX4/2ZfbhuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVfG3MrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D712C4CEFC
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776148;
	bh=5mvBoxTaZeXm6y0SzxujCJJBGVLQiHzbgoNJG/CVvV8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hVfG3MrIZRzONRWJUQaD0Sw2H+jYmTEzJasiM9G72KD8xlrehEqgzyvxFDoj6Pvnu
	 uSmwM6GTwJy16B+I9lkpp9rPW9tzr7GvnK4+d2cgkdCRzJtqqx4sADSjmTCAj3vNCR
	 XHTvleCy7rY73Y5F/YyvgFi45KY2AGRuJjU1XbWz8o9GeGcEhyAfBIPpVbutkG4IIK
	 JZ/0rwt5Y4ekzvsLy9C+kB4ZOk3pRL2j68gu4pZz+YKzvGwOqTAvNvF/1QztI51622
	 DHkzaRZv9IBzX7X7LtU5SyU2ZZwGouiCWh+EwYFdUds270AWbWsxPHWUofmosw6bR/
	 LKET0eN/Yey3w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/12] btrfs: fix iteration of extrefs during log replay
Date: Tue, 24 Jun 2025 15:42:12 +0100
Message-ID: <894622cd2bfaf3d1871f2d88ba0a212e7661e136.1750709410.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750709410.git.fdmanana@suse.com>
References: <cover.1750709410.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At __inode_add_ref() when processing extrefs, if we jump into the next
label he have an undefined value of victim_name.len, since we haven't
initialized it before we did the goto. This results in an invalid memory
access in the next iteration of the loop since victim_name.len was not
initialized to the length of the name of the current extref.

Fix this by initializing victim_name.len with the current extref's name
length.

Fixes: e43eec81c516 ("btrfs: use struct qstr instead of name and namelen pairs")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 08948803c857..e862deaf27da 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1146,13 +1146,13 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 			struct fscrypt_str victim_name;
 
 			extref = (struct btrfs_inode_extref *)(base + cur_offset);
+			victim_name.len = btrfs_inode_extref_name_len(leaf, extref);
 
 			if (btrfs_inode_extref_parent(leaf, extref) != parent_objectid)
 				goto next;
 
 			ret = read_alloc_one_name(leaf, &extref->name,
-				 btrfs_inode_extref_name_len(leaf, extref),
-				 &victim_name);
+						  victim_name.len, &victim_name);
 			if (ret)
 				return ret;
 
-- 
2.47.2


