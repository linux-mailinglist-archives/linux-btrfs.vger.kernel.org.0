Return-Path: <linux-btrfs+bounces-18958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14866C592AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 18:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7D33A670F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D2361DD8;
	Thu, 13 Nov 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiN1X177"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B1361DCD
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053011; cv=none; b=ckerJxCMvjf5ZiWLeg5+5aepEz03jhAr1yLotFuseXd9kf6PxQhvshZ5O5GmIokcwIPNy72pu7ApezXcl21hBnpyJGRpUnCFTZ64Xb9M41cdvQMm+yZ7JjQ9TX9+DCvzzLwKzKQ+82gdMARs6s5sowj0WFYkKc8RDWiAOJz/2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053011; c=relaxed/simple;
	bh=QSOB/ndm17H7o4xPL65X6POj/NrA2SaWxrIObc/FcQI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEgXFoYWXxKQSpiO+0IyMJc4nHludzhPcmExMWCYANOPPjSqWHApKi4TGF3QGqhSVKBeGAPla9p/T1IuDrxnhM572alF01nD2RVSRbVhBLIQnYIXKsPyziO7wE+n7f8wadCi4TP+hhQXOj/2IWrJ86ZgQr3hnz2974QQgLbJuh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiN1X177; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5625C4CEF5
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053011;
	bh=QSOB/ndm17H7o4xPL65X6POj/NrA2SaWxrIObc/FcQI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NiN1X1771x69HtHJcDp4lCSJ191MVHSWEoWUQxHEWynhj3KW6nRlPeKc25+4yYP23
	 C+1WKUlVaTVLAnHo17oLMptHGWkI57DJGBpzdo6XnAbZxBqkh/ALDe2fyFGRkxUZ3q
	 ABzeGx6YEC4ylplk3ZN0liLfDAlH38kfNClP7P9VLts6lwKks99CCUI+OX4l53spaY
	 Umavc/aicGWzcz4wRFgtGSSuZkBIAwbQOVyH+reb/4JTcrH+Z8roEfSG6AMMQMPy8w
	 C9FZCoF7LOsLJwVYeRQyZ764ABk+HZJ7VeqRREjSieaKnoCDs0c6wBARvMFBQWcnua
	 Ai6ip9fxHLI1g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: update check_skip variable after unlocking current node
Date: Thu, 13 Nov 2025 16:56:39 +0000
Message-ID: <87ef62148060dab687bba9ed8d3a69bb8dfdab09.1763052647.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763052647.git.fdmanana@suse.com>
References: <cover.1763052647.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to update the local variable 'check_skip' to false inside
the critical section delimited by the lock of the current node, so do it
after unlocking the node.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8b54daf3d0e7..46262939e873 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1435,8 +1435,8 @@ static noinline void unlock_up(struct btrfs_path *path, int level,
 		}
 
 		if (i >= lowest_unlock && i > skip_level) {
-			check_skip = false;
 			btrfs_tree_unlock_rw(path->nodes[i], path->locks[i]);
+			check_skip = false;
 			path->locks[i] = 0;
 			if (write_lock_level &&
 			    i > min_write_lock_level &&
-- 
2.47.2


