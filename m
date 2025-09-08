Return-Path: <linux-btrfs+bounces-16703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED4B4891D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16621189A8AB
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457F02F7AB4;
	Mon,  8 Sep 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezu2dy5j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E02ECE95
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325219; cv=none; b=ipG+g3UGGEr2Xn3olAW8xTdcZ36d+m2JlxFCtss9X0sCCt+1yQsxYrLKpExFPZ8S8tIJf/I9zEa5E7WGKqmycQeTxn9RYu2y5+R8y+wfL/d1CDnqFvgf0rxUH2nkp+jLnaeiYz9WroAe16NPerbdTrPGw+IL1O4EBndZJ5DyReA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325219; c=relaxed/simple;
	bh=WrPUjdBmbhzCP+aKKSUcCdIA/eIW9KdPLe/lVxNndFY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkcnLjIdEaoaoFzlngj6DNdnIRAfgFaZL62gMs51AOe7hfdXKQdjLhn/iqB+JXGd3TvdKsPhitYubWN112meufBLVlMc3NWyxalX3qTqmXT/tpEK5/LvI7Sv0XFMlgdDOX/Dt5wBZ7l0fDhNXkBntXIAhh4jT+5HGIjR8b/ikoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezu2dy5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE653C4CEF9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325218;
	bh=WrPUjdBmbhzCP+aKKSUcCdIA/eIW9KdPLe/lVxNndFY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ezu2dy5j1vDkPjtdRPucZ1CE4EBvNuh+EjDvBqamREEyIajFOGHUfVyqXlSRNBGcw
	 fueig2ecCujP7JbMH4eEiq4BlNj168xRSYX7F9lrxjFHJXn1t1hIeD8rqrxNgd09i6
	 1y7q5wrta2NvxvyWDV6ykrp7B64omlV5ctF05t4atXxiBWtVChkiwbXqIcmekDCOJY
	 8zVlMl/efR1aiWcoXGPzFHXTpzyNuiwJsggm4jmP1hY1t8HVpnCXAoNOnJpPeRFNz7
	 31RHATQNOMVuzzScKt58PmYO2yYe8IOXxBBhc+b0Dakx9KfOYhc3UGZEsLaEZXDjch
	 alJqPIajhAddw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/33] btrfs: stop setting log_root_tree->log_root to NULL in btrfs_recover_log_trees()
Date: Mon,  8 Sep 2025 10:53:02 +0100
Message-ID: <a89749bb98dae4138d258043d23703edb305de74.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in setting log_root_tree->log_root to NULL as this is
already NULL, we never assigned anything to it before and it's meaningless
as a log root never has a value other than NULL for the ->log_root field,
that can be not NULL only for non log roots.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index dee306101d8e..ab2f6bab096b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7585,7 +7585,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	if (ret)
 		return ret;
 
-	log_root_tree->log_root = NULL;
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
 	btrfs_put_root(log_root_tree);
 
-- 
2.47.2


