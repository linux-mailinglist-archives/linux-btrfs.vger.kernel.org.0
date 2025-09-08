Return-Path: <linux-btrfs+bounces-16715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B39EBB48928
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513921894A05
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654B2FB09C;
	Mon,  8 Sep 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6qGay4d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD852FB095
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325229; cv=none; b=ORTilRDBJAsuRLAspt2YYVYQgg16R4P1+BoRDWssZmqDN6YUSv+Zrd57qNuyffelJyLROl1UeskQ1gt7GqnYijRQcLxCwKX0wgrKIYKYNVAstlNk0wdqxcXIgz3H8QyHU5isPeTgaGG7x7f68/TZT2alD0fWYsShUBrkbleQ+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325229; c=relaxed/simple;
	bh=eOkPsc1D+qNHb6MJHVRKfswGGW7slzmCr3iHMgH/6+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/Ndonh/iGWiBbiiNMrobqMzA0UZEJkVjEsRVkszYZRKJWzL91XyODyQx20n8CIK6cgWiB0wfyFxiFo7OrZ3myAr1fo7PtWYQGi74fezPeeQKyhDXd/oAEUg+ijtoOGfN4Alp9X4o1FpLBXgZ9M0+pvgLOLZA9kZSLOz0IZIMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6qGay4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCECFC4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325229;
	bh=eOkPsc1D+qNHb6MJHVRKfswGGW7slzmCr3iHMgH/6+8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u6qGay4dOeP+XtYp7tdSUsUC6dXMXv6q693kx2s1Q5UMgSbwmutGk83MTMgMZ03eh
	 UnmhxnD1wj0OLdX9fwLxUyTKX28xNiqEfaTsHk+TtNUEdn764+v6Xtsb73jaeIQ+zq
	 rZ5Zfdej2oImF1Vk4GTg8K1NP1v2T1kcV+4tS0Y4KKAZK16TLDZlKuFwG1ypdzinm+
	 fO8hZiiosC58k6olRHcMAcheozTdB1GjX+yG6oQTca8zjL3sEDyxaDuawcXxOg6WC1
	 ipYYYD14ivtE5izigio/Wmknf1bHe7dEfpdN+2oTzMNmpIsflxGN9dG0kSa1cvdAfj
	 XBlGHr/5nK5qA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 20/33] btrfs: use level argument in log tree walk callback replay_one_buffer()
Date: Mon,  8 Sep 2025 10:53:14 +0100
Message-ID: <3d151e659dd1b9e8e8c967b3927e91d149e6dff7.1757271913.git.fdmanana@suse.com>
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

We already have the extent buffer's level in an argument, there's no need
to first ensure the extent buffer's data is loaded (by calling
btrfs_read_extent_buffer()) and then call btrfs_header_level() to check
the level. So use the level argument and do the check before calling
btrfs_read_extent_buffer().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 166ceb003a1e..88e813bb28d8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2591,17 +2591,15 @@ static int replay_one_buffer(struct extent_buffer *eb,
 	int i;
 	int ret;
 
+	if (level != 0)
+		return 0;
+
 	ret = btrfs_read_extent_buffer(eb, &check);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 
-	level = btrfs_header_level(eb);
-
-	if (level != 0)
-		return 0;
-
 	path = btrfs_alloc_path();
 	if (!path) {
 		btrfs_abort_transaction(trans, -ENOMEM);
-- 
2.47.2


