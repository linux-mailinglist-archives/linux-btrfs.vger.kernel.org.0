Return-Path: <linux-btrfs+bounces-14546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7C4AD154F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 00:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61457A3D9C
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Jun 2025 22:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD925484D;
	Sun,  8 Jun 2025 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huVGf5vs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1337D27E
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Jun 2025 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749422619; cv=none; b=oFk9pQTwxtic6o+3voGtG15dSja6JlDLE0jIUUdn/ZkdjLVfX9/zyaIFSSv94egykc2evKRTQqkVy1XAxaxSAF3rOjiJaQlT6BAQu7LrbFsLxPuMv6F8sBHRrLvCEIXyTZ3sEh76KmDKdVQ3S3RueDUED9t4OvDUnPkOa3NN7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749422619; c=relaxed/simple;
	bh=Zn/FHYc70u5MHf00VdFz6wx6VI+47PL9kzqhqN2spTY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kHp9my9goNZMNXyza0uXECw694Mt1kR14XgZfRS+/CEceBzrOLOfpf6IsEDgSaVdsadJ2xfrhjsJwSQgEshXRyl0OBQFPW/Eaaq2TVu9kHpafw6TB8L5zOItxhffpAI8NG+FJk/nlS55mpyCcet5HEvO5aZ7uSvtShsVQQPMnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huVGf5vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F95C4CEEE
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Jun 2025 22:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749422619;
	bh=Zn/FHYc70u5MHf00VdFz6wx6VI+47PL9kzqhqN2spTY=;
	h=From:To:Subject:Date:From;
	b=huVGf5vsW8eQhFUBQgN7DKOSwX9ka3sUOf90/D0CA6fuGG6A490AnIFnk9MB1LIzR
	 JqxV1Aus9d/Ka+S1ZIWp0cmcVrIY5IfcGMaBc+pY6ROMb++duVANuLIEYfuyVdjCQ+
	 1eUQz2f+j5w8VyKZkzvHp0XG/Y9tXXManbace+GiknkhfLMbr9Tut8+R6nuH+1rkAv
	 /OA2vKBv4QXf9oMAPcqN1i8pjH2ZN6NYOIbunpo175CzKpVhvUITpqE3xApsZdNb+O
	 MEmdF5gfSVBX0qO1qnHtGPDKrRVvBBIFUWSULUHhAt7iho/ZIBs4lU76nRj2RDG5Zm
	 lvFJ0+SXEBfmA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: free space tree fixes and cleanups
Date: Sun,  8 Jun 2025 23:43:31 +0100
Message-ID: <cover.1749421865.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a regression when rebuilding a free space tree, reported by syzbot,
ensure transaction aborts where critical when adding a new block group to
the free space tree, and a cleanup. Details in the changelogs.

Filipe Manana (3):
  btrfs: fix failure to rebuild free space tree using multiple transactions
  btrfs: always abort transaction on failure to add block group to free space tree
  btrfs: check BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE at __add_block_group_free_space()

 fs/btrfs/block-group.h     |   2 +
 fs/btrfs/free-space-tree.c | 110 +++++++++++++++++++++++++------------
 2 files changed, 77 insertions(+), 35 deletions(-)

-- 
2.47.2


