Return-Path: <linux-btrfs+bounces-8197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B369843F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 12:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914F92885E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92731A304F;
	Tue, 24 Sep 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgZ3OL+y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112CF1A3043
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174754; cv=none; b=A4CVOai8FWO68GfNOkjxJdALUi4yDFVqp+38QV2NQvqe1qsuK7fFyHTBXeUYPnnp5CVFfDhtSHCu4G1ypp4wkvb7q9naenqF7Ktt2R4q7a/sccv0y9UGIgX0aCvBQWY43NvKCbtdWreSRSmvF301Bu3bOWHGHk3glrUaDNSx9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174754; c=relaxed/simple;
	bh=j0GV9dcu1E2eFQSBJ4ohjZm8NFdN10BtEOCekIqpXgk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6L3hHukII1RCKxX3gC2xW0sJJDI2mPmNBW1JoSgcF/3ap3GSKmmRXsXVpjxfWmVC0agx9DJZflPnQiblyPD3yjcYRHFS8qE63DBebsLQMJPefHQ4NDqkuo1FfNSWO0GIjsxuQ756IcxCPUwerpE8gp21nwPLNyz6yIR1E1Pc34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgZ3OL+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E7BC4CEC6
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727174753;
	bh=j0GV9dcu1E2eFQSBJ4ohjZm8NFdN10BtEOCekIqpXgk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qgZ3OL+yGVI2LiKpqZFBsgfnGErtWZ1V5f/as8eqZJLwv5PZ62iZ23xXEyuDuqg3u
	 +AsYxH8Ws6DNrsCGCJWPN5+7X+iaugiSar/BLJMWtmaV90JM/fdB3BgFx/3zFkMFGD
	 GtdtlRYTA6SKh8+fFWx9vhX1c6uGMOdHjzpa3gtYFSQxiuhuxdqX7KhbMI2L1x462T
	 RM7IK5jQWuxa/GVsY+/YhlNLglSW3mQtfKmoFJrd0VQtcyH+8qfGMmG+IVbYAX3ZBW
	 patUkOxbmGm/3EvT3CBPfE7JyrxhcGtnafGn3r4ggPT4rE76UjVzoBg58Ro1+Vu5Ux
	 Jp2xSpsBq6s8Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: re-enable the extent map shrinker
Date: Tue, 24 Sep 2024 11:45:45 +0100
Message-Id: <2ddc45133bcee20c64699abf10cc24bf2737b606.1727174151.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727174151.git.fdmanana@suse.com>
References: <cover.1727174151.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Now that the extent map shrinker can only be run by a single task and runs
asynchronously as a work queue job, enable it as it can no longer cause
stalls on tasks allocating memory and entering the extent map shrinker
through the fs shrinker (implemented by btrfs_free_cached_objects()).

This is crucial to prevent exhaustion of memory due to unbounded extent
map creation, primarily with direct IO but also for buffered IO on files
with holes. This problem, for the direct IO case, was first reported in
the Link tag below. That report was added to a Link tag of the first patch
that introduced the extent map shrinker, commit 956a17d9d050 ("btrfs: add
a shrinker for extent maps"), however the Link tag disappeared somehow
from the committed patch (but was included in the submitted patch to the
mailing list), so adding it below for future reference.

Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c55e@amazon.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/super.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e9e209dd8e05..7e20b5e8386c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2401,13 +2401,7 @@ static long btrfs_nr_cached_objects(struct super_block *sb, struct shrink_contro
 
 	trace_btrfs_extent_map_shrinker_count(fs_info, nr);
 
-	/*
-	 * Only report the real number for EXPERIMENTAL builds, as there are
-	 * reports of serious performance degradation caused by too frequent shrinks.
-	 */
-	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL))
-		return nr;
-	return 0;
+	return nr;
 }
 
 static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_control *sc)
-- 
2.43.0


