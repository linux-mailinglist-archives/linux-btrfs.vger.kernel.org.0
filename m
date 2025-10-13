Return-Path: <linux-btrfs+bounces-17729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E1BD58B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F37C4E77BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C5308F26;
	Mon, 13 Oct 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBF8TS40"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992673093CE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377107; cv=none; b=koDObCL10mn0HCVa5iHu6OCHtNWZ70N25y2WiqPdeH1rYopK8gZ2bBc/JmRcvB08FMdna8CBlnq83dVnngEjV/voH9s7Yibe5FkijB1DYO/kTH7Ifo9IK5xznoCElVhcIwcoseqR1iz+s/MDD/oT1aWiaJm/najPWKIzMo8dkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377107; c=relaxed/simple;
	bh=4ttPiUvSKCkDSOjjxCrmiJ3BdZV72aXf7G88/whuIlk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SB5y3iLIOZXiVkKIlUFpCGc4FL0hOa2MGwwj89/95jxc5z5FgtB1zYRqjKBOqAdI4w+9yoWwxvBA0gow1b6K5HWK0lsXrywJxaHD9R2JPyJ4YYar92jJFUAnOkHlTgZjAIGKfiYT4izxKzDs27bDvwyPDqtaStkJquGCtD5Fp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBF8TS40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2F3C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377107;
	bh=4ttPiUvSKCkDSOjjxCrmiJ3BdZV72aXf7G88/whuIlk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eBF8TS40vdVFsDnps/IeSuVboZXrfjIQPRLGGT9q9NQt58hpn0kRi6Gd//oI8NAdu
	 FiTsapgXF02zLDcB9FnQMIb8lkV1JgRTzBfmlU7oZUw7EXFCvVPp+X4PZ0rVD3Kn7D
	 7vyGID7hdI/ks7ju6p6j1xFE/dGzngU5awYxxAZUQl2yZZXYYy3emvm8njVtXltdBp
	 1mZEj5wIuoWm5wSUL4bjrp5Y85hgl91dMuxykHPyFxgwFJ259Sbg48bYwYxV7xohEq
	 uOhfHo4rlop+VD/0H/GcqFwpff/S5KlO5bKGx4e4xEd+uNOZ2wvTT5da4yen18FI0o
	 p+r1+twMzD+Yw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/16] btrfs: remove fs_info argument from maybe_clamp_preempt()
Date: Mon, 13 Oct 2025 18:38:08 +0100
Message-ID: <69553541c6a724a4169fd4aa082f4ffb06ebbace.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
References: <cover.1760376569.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 778bf239a35f..7e4e185fdcf5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1666,9 +1666,9 @@ static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
 		(flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
 }
 
-static inline void maybe_clamp_preempt(struct btrfs_fs_info *fs_info,
-				       struct btrfs_space_info *space_info)
+static inline void maybe_clamp_preempt(struct btrfs_space_info *space_info)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	u64 ordered = percpu_counter_sum_positive(&fs_info->ordered_bytes);
 	u64 delalloc = percpu_counter_sum_positive(&fs_info->delalloc_bytes);
 
@@ -1811,7 +1811,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 				 * preemptive flushing in order to keep up with
 				 * the workload.
 				 */
-				maybe_clamp_preempt(fs_info, space_info);
+				maybe_clamp_preempt(space_info);
 
 				space_info->flush = true;
 				trace_btrfs_trigger_flush(fs_info,
-- 
2.47.2


