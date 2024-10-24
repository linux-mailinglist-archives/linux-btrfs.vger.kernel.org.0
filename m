Return-Path: <linux-btrfs+bounces-9135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45069AEBDF
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666F32855B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCC91F81AE;
	Thu, 24 Oct 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW4q5u+n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F31F81A7
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787076; cv=none; b=HITTgC/1P3nR+3Jf59yVpFI9jvjbqQTaRX8yDjW/ahfeV4W2LjGBZ82hWRO4wJCYjPijQXN3LLl0+e6R2xYGDrVQIr88qPMsG0n7SkL5B7u+0f8QEr9o2Rn4VoUSE5roxXW+XAAM3EYUSINVeHtdi4kfhkv25S4hVuZZARPReF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787076; c=relaxed/simple;
	bh=yd0jgbeMZD0ObYBXMD/TjqkrwO/GNR4bI1bELLEoihA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OEt9o5CQQsUwejjDofdgwU5HCrlE7hunvUHs3qCF2nPZLhEWG7q2M0a2vHUy4aHyjhd5uYgCbAnb3k0hCV4OR+TdGX7vt0PMK8O7ntXaTs+Mmq+foeX9j9YXcl6Z4VZx5u+hWa8jrVxoRZVUaEKHi0YVNsO1eygNJb/e3KGiciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW4q5u+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABC5C4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787076;
	bh=yd0jgbeMZD0ObYBXMD/TjqkrwO/GNR4bI1bELLEoihA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VW4q5u+nacsfIU3MQ8pZaMDmHV+N/WsWJ5CUY+VLX8GTQhXxNqQ5Cz4ZrAF2HfP0t
	 G0bJMfReYXMmjmc+CjcHoe+/x+lsBp7uiGgzP0NUg7CbbiZT7paUu4nI/c5kpr3VUa
	 Gj7b5P2cdMCnny9pHjYXNvQ5EWEggQRLkwkwML9e0uym+p1DzVGwfEQYGVzyhClakK
	 9e+0pS1Ka2A+eqW0GzwSjlL1tgAQnSboKHXg7FX5ZWsP/TLvMTyppgXoaEgYYZ9z4t
	 eoMRyYkKHhJOAwAHFHLZLOs1L8kAQ51TsthGNVOI93BOlXZR1Xm4+O9jm6MJvttiW7
	 qAc4hvbnkMU7Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/18] btrfs: use helper to find first ref head at btrfs_destroy_delayed_refs()
Date: Thu, 24 Oct 2024 17:24:14 +0100
Message-Id: <fc1312db283d8a6953bc7190331625ad01466641.1729784713.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of open coding it, use the find_first_ref_head() helper at
btrfs_destroy_delayed_refs(). This avoids duplicating the logic,
specially with the upcoming changes in subsequent patches.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index db834268faef..2b2273296246 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1241,18 +1241,19 @@ bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
 
 void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 {
-	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
 	spin_lock(&delayed_refs->lock);
-	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
+	while (true) {
 		struct btrfs_delayed_ref_head *head;
 		struct rb_node *n;
 		bool pin_bytes = false;
 
-		head = rb_entry(node, struct btrfs_delayed_ref_head,
-				href_node);
+		head = find_first_ref_head(delayed_refs);
+		if (!head)
+			break;
+
 		if (btrfs_delayed_ref_lock(delayed_refs, head))
 			continue;
 
-- 
2.43.0


