Return-Path: <linux-btrfs+bounces-16668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C4EB45D9D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C402E1C8027F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC40313287;
	Fri,  5 Sep 2025 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KozAnrkd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D5302172
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088661; cv=none; b=exvS6Eo5BiYvEWlozLc+8QxXLecPrIwlBIBw4+u9b55G4KWQ5hc5geisGFkGlqOmHMnDyVSqR8FJa4mbL0TN4TNOXqwnUcsM7Z6YZBwrVDFctYORz+U7ugpLx5YRhTRmLAi7uf9WFfQ7w9sIQABgFVQEofkwPoU1KAIwcktC1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088661; c=relaxed/simple;
	bh=IALC/6q8CAqIN66MazCuZsnR3lrM28OnEoajgIWJ1Xw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCSNRnmwcOGEzb534K0pqiacZAXjVvQFolk9xK6StP9k8xjKAVCEB9GZn8okayJgIOJFQYfHL32xN19y3ILiu+z7bqCHC0Zrc0a5Pc+GmwkOI/bsZEhvHDYlmNE3EFayNamQUNDxvYe+eOwyYyTZMOFublol8bVGWvU6nObp5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KozAnrkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84084C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088661;
	bh=IALC/6q8CAqIN66MazCuZsnR3lrM28OnEoajgIWJ1Xw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KozAnrkdWDymg/MggZDtH0qketBrkRK/O94BkeNVz3zT2PB9Dj0w0Qy5Owh9teOLl
	 iJBSE3xEC+cEwnwmTsiEY0da6oO+HRfC/Wwm+6o2jt5PytgReetoQJ+x1+n9N3r+9I
	 Y2Rj728CuYlsNQ6+IfOT3xWf/6Nmrcwl+t6UvptggLlhu9Ln79rDfga6Zd+XX45bBb
	 kx98mksrFlSy1zbiQ/GwAv5nd1P4MvAY+OGSlKKLtnoO7QAo5I56MpzViDN2yh/dkA
	 OKWexb+J/69OK/knzddC9nqZAIhSed+yTVgZ4jmAo7hzTSXspC/b+ZjYiksBDsC/tj
	 X2o/wad3sh1zg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 24/33] btrfs: avoid path allocations when dropping extents during log replay
Date: Fri,  5 Sep 2025 17:10:12 +0100
Message-ID: <bbaba71c1804c456f487fad8b39a885865cbaf40.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We can avoid a path allocation in the btrfs_drop_extents() calls we have
at replay_one_extent() and replay_one_buffer() by passing the path we
already have in those contextes as it's unused by the time they call
btrfs_drop_extents().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5754333ae732..a912ccdf1485 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -738,6 +738,7 @@ static noinline int replay_one_extent(struct walk_control *wc, struct btrfs_path
 	drop_args.start = start;
 	drop_args.end = extent_end;
 	drop_args.drop_cache = true;
+	drop_args.path = path;
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -2676,6 +2677,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 				drop_args.start = from;
 				drop_args.end = (u64)-1;
 				drop_args.drop_cache = true;
+				drop_args.path = path;
 				ret = btrfs_drop_extents(trans, root, inode,  &drop_args);
 				if (ret) {
 					btrfs_abort_transaction(trans, ret);
-- 
2.47.2


