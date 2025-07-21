Return-Path: <linux-btrfs+bounces-15605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDE9B0C96F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1791C227E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F22E4244;
	Mon, 21 Jul 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIbhorFN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B22E3B1E
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118213; cv=none; b=CGxVGPhOd0Tg81V7s3jMBORm0v/8cRx2Heo6lB6V2OWPz2aIHWH9VAo+HvFxzdVJEOgSlbidKcnj0nW/Pxq6ORN6YOxuJjvg8vuSxnJZmxowidjnlazjJr/goyTGRHK7pIWqDNstf9rT6haUFr5TTh0QCY92eHfzmaLWJAxgmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118213; c=relaxed/simple;
	bh=n9hJmqYmGjoOX+RwdcioKGieLIB5OL8MyMgWRJKt/dY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcFpq3hg0wpC7OTeiBQ2+eyJlO0enc9PTK9rV1/Jrh8vijAEHlOI7+ZJ7Q5UVWBPCG1TqoW23CNQCBlPyFFLGZ+8F92Mul4MoQmhbdkvaAAodaJJILxdzaVivcIE3M5dFxHhF8A8p0QTlaTXNEWlWSKcS8VjWkzrjU2P50oXgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIbhorFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371B5C4CEF7
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118212;
	bh=n9hJmqYmGjoOX+RwdcioKGieLIB5OL8MyMgWRJKt/dY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dIbhorFNLVgwV/Wlu6HTR9OjK1SywktQA5U3pZa6+UIIR+xVfE/q3ntwwnMBeCX1N
	 I3VNfqBkQtWDjnNms3C4vuJEg/M+gSGY/JVEg7dqzYaHayfOQp/rTL2P2tV7BRAJE8
	 srdBE5uCwTA865FbVqK+82OepBFknV4xx4dejakcgPsEa7HFf/iVV1t6ynGqAuME53
	 2tw8uK3BJ1Ti6TsQLGDZu4/rZqM/pdr6EyIXE8JGGscqI+mJsCCDDH8St3EYqnqe7R
	 EzIYtFIwybw6NfA5W9TDdtzzaCACJ8DANJMBc+gHPQhXeSHLvX1gu40dJfS2oQFbxH
	 Yd1BnFKpYz39w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs: use local key variable to pass arguments in replay_one_extent()
Date: Mon, 21 Jul 2025 18:16:36 +0100
Message-ID: <fa8f9bead52fb2e344de8b683a643940163722ec.1753117707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753117707.git.fdmanana@suse.com>
References: <cover.1753117707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of extracting again the disk_bytenr and disk_num_bytes values from
the file extent item to pass to btrfs_qgroup_trace_extent(), use the key
local variable 'ins' which already has those values, reducing the size of
the source code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8817dfa5b353..85b623850a57 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -786,9 +786,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	 * as the owner of the file extent changed from log tree (doesn't affect
 	 * qgroup) to fs/file tree (affects qgroup).
 	 */
-	ret = btrfs_qgroup_trace_extent(trans,
-					btrfs_file_extent_disk_bytenr(eb, item),
-					btrfs_file_extent_disk_num_bytes(eb, item));
+	ret = btrfs_qgroup_trace_extent(trans, ins.objectid, ins.offset);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
-- 
2.47.2


