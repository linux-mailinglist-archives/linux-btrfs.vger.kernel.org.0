Return-Path: <linux-btrfs+bounces-5441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F31888FB0C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 13:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1551F22AA0
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9267145A1E;
	Tue,  4 Jun 2024 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi3jP1cu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85B145A0A
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499342; cv=none; b=SqGLhoVGYeoj+oVwtyo7OvAREDFOx/eQkFZbTYVyP3Vb27nJl3ryCRpyLFhKB4ksVAXMc5vv0E8S2G5hoOzw01BHcdfieurTPjojZJ/z0rmIuyclwgCCUUmT3yRnrRLb+9vRXUGfQb7oE6m5JO7cyf0lSJckhyn/8ch1Gzt0Z4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499342; c=relaxed/simple;
	bh=WDlbdXQB+rtsAS1b5TyHDWvhrGK9LV0h3drAnw4p8P4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PfAu8Rt7+PgXJGFQxbufzwyaStaIZ+KaLlXpxgYJ+2GcjQezZ52Lq8lKWwCGirax4Z43h0+6rcEGyhxXGnaQ5gbVPJFbKNhtZvrCA6ci5t9Wcm/5j6Mhx4JPc2DvB/KOnrlNPVAE5gWon7HexK4zF3dBvmyXhf0CPtYVDQmIEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi3jP1cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED39C2BBFC
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717499341;
	bh=WDlbdXQB+rtsAS1b5TyHDWvhrGK9LV0h3drAnw4p8P4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bi3jP1cunylitEhKWpsK6qGsFansD05pz28v2cdOlNXfdCz2Zir6l2kEoO20VUcvN
	 3vAiZtH95HEy756VHudtITdkqq8gzxcZ7J+FnHuxCtG9copo0O4f5XQTRYX2tI2Ilx
	 Hc6ex4hZyg6a0P9IINu5jJdG3BGADNlVW0z9WPdBAuYuDhPkCMouTme7RvRoXtxQqZ
	 RVzfMF8GqPDMsq/eLbAeOOjl6tKrC4d3wfo6+1fTZghQCtZuEJFJ026i4y/EMrM4ME
	 Cys0a58pPatTZmKuhgcwLd/DhIZOgYzQmz5rzY8Togsq2UaNAodg9Z2yhaTQPFafUx
	 9k6ycsNwEZVPA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: update panic message when splitting ordered extent
Date: Tue,  4 Jun 2024 12:08:52 +0100
Message-Id: <d65806df6d41acb1e90eb04cc849723eef13ff57.1717495660.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717495660.git.fdmanana@suse.com>
References: <cover.1717495660.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During ordered extent splitting if we find a duplicated ordered extent
when attempting to insert the new ordered extent we panic but with a
message that has the "zoned:" prefix. This is because the splitting used
to be exclusive for zoned filesystems, but as of commit b73a6fd1b1ef
("btrfs: split partial dio bios before submit") it can also be done for
non zoned filesystems during direct IO writes. So remove the "zoned:"
prefix from the message and mention the split to make it more specific
and different from the panic message at insert_ordered_extent().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index c98c8fdc14a1..a3343656e0a7 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1305,7 +1305,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	node = tree_insert(&inode->ordered_tree, new->file_offset, &new->rb_node);
 	if (unlikely(node))
 		btrfs_panic(fs_info, -EEXIST,
-			"zoned: inconsistency in ordered tree at offset %llu",
+			"inconsistency in ordered tree at offset %llu after split",
 			new->file_offset);
 	spin_unlock(&inode->ordered_tree_lock);
 
-- 
2.43.0


