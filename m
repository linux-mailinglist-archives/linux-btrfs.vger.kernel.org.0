Return-Path: <linux-btrfs+bounces-14176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB2ABFC7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 19:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC0B1BC3DAE
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37E228A716;
	Wed, 21 May 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gACJbueG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259121E0E00
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849459; cv=none; b=G9++MnqZF4wePb9VIDIBlSFnkFJqgJG5zLdETPZ34Qf+3ibwU8nXNcaXVMs6t7vb6DvMRKnmLk9Q4TQD6RgJtLa2RsSwJLGPgWBsQchGxjdkGWdVu3m5SRYUAfHcpzEMBB6Rx1A3fVUGde6p2Ms2/6PijjLjGCT6LJXTJ/MsPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849459; c=relaxed/simple;
	bh=NBpEkcso3qrzt/Op0jA9sSp3MOMxG5H0/bK4vBi0IIg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9Hu8zDeKvHw4OgyK9T3PAEWgQSDVH+Z64VybOPbuWkJBxBh6sIllkqliZsk7MfRtalqehszgY/q28hdlbUlzh8FT24SNCVxjaD8uYaHgXSha+ab+H6HZCuUXpmK2kOEHgwkeTQpsQN20TEadYrWyeC15+ZcH5XLeBEEIqYGbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gACJbueG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E23C4CEE4
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747849457;
	bh=NBpEkcso3qrzt/Op0jA9sSp3MOMxG5H0/bK4vBi0IIg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gACJbueGU8/Pt9X+3LEGs17b9InWmS76q0kykqYJVpAJlzxdNHowcgkkBn4IeApyp
	 ocxqI/yTpsIoS4ol0eHFucf0HT0XKTvbtOg1fXNPJWdIPMQGywXEgmy0q6kXFQVZQi
	 knAsbvy/djk3/ahWeqJClxEnx/61dZNhjSPu3KZUzmcNrRO+Frst31gi5jhgCzmBDy
	 INpGy91o0nlpfnQptZ+146Y7HN/UJ9J42LZBSIn0pm7tL25fvAnkInX5Jk9/93NeIg
	 esmOVajrzmCztOMpzZWGVG7xAynKJmNFwfnq6kopPDSEY28NbwbsQ6qDW80OivYdI0
	 PPSVahEwWDtbA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: remove redundant path release when replaying a log tree
Date: Wed, 21 May 2025 18:44:10 +0100
Message-Id: <12dc5edcc460c6a7fbd384ef39dc51f78705d79a.1747848779.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747848778.git.fdmanana@suse.com>
References: <cover.1747848778.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to call btrfs_release_path() before calling
btrfs_init_root_free_objectid() as we have released the path already at
the top of the loop and the previous call to fixup_inode_link_counts()
also releases the path. So remove it to simplify the code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 730d67dba58c..ca2a2ee3c5f1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7302,8 +7302,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			struct btrfs_root *root = wc.replay_dest;
 
-			btrfs_release_path(path);
-
 			/*
 			 * We have just replayed everything, and the highest
 			 * objectid of fs roots probably has changed in case
-- 
2.47.2


