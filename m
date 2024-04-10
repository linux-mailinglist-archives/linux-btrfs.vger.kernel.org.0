Return-Path: <linux-btrfs+bounces-4101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB8389F0DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4D928BDA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C8115E7EE;
	Wed, 10 Apr 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW+NtJqJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284A315E203
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748531; cv=none; b=Uq9Y77nDXwQRWAILU3/nxR9zpOmvSWcpf0caj4jG6agQbMYWZMA5D6r00dOPydOwZ9AGrWJrM9uzHWDfq2eIwi4RM9Q4AzG/t7tOwbP41eOFj/zVnwTUe4INapiKCRdSataTE01jHHPCMn5aqsHwehiw0h/2JU5a8Zr3VsZhIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748531; c=relaxed/simple;
	bh=i36mBH7l60yk68YJs2uXhf0sDC820kJcHiCqGgLb03E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/HJhG0xOK7jAXlogFq5jzWmZJT3T4Kfn/WZ0v5uJO41A2lx3eIPLqmtT0kAYdpY26jIQdSM9emFo+vKyyJQqZ8HazebMi7g9OanuPb7ri0efoBPNe/mOs/TsvjA94Vp/jmdsFV2K/QnyfYEbSPCHPOUr3yKSAP6NPza0vnRtTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW+NtJqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346E8C433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748530;
	bh=i36mBH7l60yk68YJs2uXhf0sDC820kJcHiCqGgLb03E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RW+NtJqJyzCGtRV2UrShfy96jIMPYRaibFbn1AEpABwUveLr6ZHO4zQ0uMB+IL8DP
	 S55GJITlD+FMZ23RfthYmJfLjsUGLOa6xvRrbZS1YfQn28hOPriryll9xaM3OZ/8Nm
	 wQlVP12gvvfGn5QO1BIgwPMkRut+iWj0awzP+XamjdShxDPc6wkecpF4ciKDI2ByYL
	 BkSVZmEyRXY+vYd5U7vqW18z/Uq7Af+Riv+89irIjztCAVNpeKGESVQ29/Vr0YDvlb
	 Isr94LpTpz6EX2w0YR66SZNlYS9TdLg9wRlSP5P0rto6dBqqgH9qtuWL0SErhck6qf
	 vgcvAJS57Qnwg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/11] btrfs: simplify add_extent_mapping() by removing pointless label
Date: Wed, 10 Apr 2024 12:28:35 +0100
Message-Id: <2c0c07d9cf4b7743eaf41c6072e63cd3439696eb.1712748143.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712748143.git.fdmanana@suse.com>
References: <cover.1712748143.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The add_extent_mapping() function is short and trivial, there's no need to
have a label for a quick exit in case of an error, even because there's no
error handling needed, we just need to return the error. So remove that
label and return directly.

Also while at it remove the redundant initialization of 'ret', as that may
help avoid some warnings with clang tools such as the one reported/fixed
by commit 966de47ff0c9 ("btrfs: remove redundant initialization of
variables in log_new_ancestors").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 840be23d2c0a..d125d5ab9b1d 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -370,17 +370,17 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
 static int add_extent_mapping(struct extent_map_tree *tree,
 			      struct extent_map *em, int modified)
 {
-	int ret = 0;
+	int ret;
 
 	lockdep_assert_held_write(&tree->lock);
 
 	ret = tree_insert(&tree->map, em);
 	if (ret)
-		goto out;
+		return ret;
 
 	setup_extent_mapping(tree, em, modified);
-out:
-	return ret;
+
+	return 0;
 }
 
 static struct extent_map *
-- 
2.43.0


