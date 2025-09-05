Return-Path: <linux-btrfs+bounces-16652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79957B45D8F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B678B58309B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67663309F0E;
	Fri,  5 Sep 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT5EgSUk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C52FB0AB
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088644; cv=none; b=kGESyMdTDkvbA2o/djT591Om3pwF57UVCZU74ziL6IVzzfKJ7nSWGIue3b53ack0MFM6alO1f14xqmiJz35c8XGzy+pFztl0XNd0MNAOZCR7tVqSCmOILQKiVJJh4oUVGbs14DICZqbkmhKnz4601e7knAY5rHM4/wZyC8BLKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088644; c=relaxed/simple;
	bh=WrPUjdBmbhzCP+aKKSUcCdIA/eIW9KdPLe/lVxNndFY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGYKDM/cIfq8BjkyAKXQUTEDlDNLD6Oph+1atDPh4/BE0I3d/0rEzUlSDzGyWUyIQ8QUPsREODXZgusILQ2LNjJ1oJGe4mFgF77+PDqkVsacJBuipBK1dP9dMBx2OeJnWhP2B83X9SbL+qikqSvWga1fqP/4wseIctxsNCPmD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT5EgSUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4D9C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088644;
	bh=WrPUjdBmbhzCP+aKKSUcCdIA/eIW9KdPLe/lVxNndFY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cT5EgSUk1TMSfCxyPH4bH3PqAEbkJEugUn/ciH2/SAbHBq5iNox5EPk6Wq+jHpYS3
	 H+pOlnOoCbQACnIwzhJFsde/rNqQ3yVqaqNxTx+mXXS7KrK9CHWy7qR2Y2uHBZY6oK
	 rjS5IjpIMl4rIwpCgn6/oRp774J7qHMFCvtESSeccIaSyNIWjeBMv2Lin79fwW9VHn
	 gqG4cwzNffpDdJMKcNXLTuUhZwL9G1oGgbSbn1vokhGZjukIIdFQi2hBKsO80vEa1+
	 ZnN6mPTBOR7Zz89igseGjNW0Ts52zj3z4EkxA1atY2rEy+5pnYWeY86qyejZKlG8Fr
	 ttcWkZm8cxQKQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/33] btrfs: stop setting log_root_tree->log_root to NULL in btrfs_recover_log_trees()
Date: Fri,  5 Sep 2025 17:09:56 +0100
Message-ID: <a89749bb98dae4138d258043d23703edb305de74.1757075118.git.fdmanana@suse.com>
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


