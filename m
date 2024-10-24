Return-Path: <linux-btrfs+bounces-9142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E99AEBE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A51D1F20C36
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797BB1F9EB4;
	Thu, 24 Oct 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwcr7aet"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996091F9EA1
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787083; cv=none; b=Cx4L8XhbxOL72mSAaKlpxpAiCBnMN/KhIfOZ+aqTKZty5vVItzgEx+3gTzvs09wy5vNJ3cHR1s2MrJ3AtPfEgue2tSws/XPjbUVtlfIf4px3z3OfIMT322yDMdUJCQxPyzIuoGBc4zOyorfWY9b4tkmV5N98NJx3bvZLKNPCkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787083; c=relaxed/simple;
	bh=YFSBtq+3ZUHRvrDCiKZPFsnciF9AJYaJLg7W8rn8exE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZK8Io0CplvCo+9hyMWc1Hypay/S3NoSDxXrKRH7U2Bk9vtweTVWnG7Zn5VgD/JIAGj44gv0ab7ZfsJaX3HWdd6jPxqimCLhv3EMgOmQnV7uMHbp4fxYXEKuMUxiL7W/+6SD3lhYA3Q423owekrXZrgyvze5FUsZwQl8SebSVIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwcr7aet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C106AC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787083;
	bh=YFSBtq+3ZUHRvrDCiKZPFsnciF9AJYaJLg7W8rn8exE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nwcr7aetpxCAV44/ZncMdssC1sbSdn4oIwCZNbpxImGuV1srPAqc57xyvJTlwBDQN
	 8m/dFhF+r4r8oaK0wmxsuaTwm9fhjrH4ionwrMipxUQCXHkz/c99ayuUkjcL/VoWYN
	 cVDTzrTgaqaMTXHmSWnz+Ggd66N8txVo6oCj8FvjFvCHK4yz03qLBlpeSPthWEOvcl
	 nBZiP+wDzbIlqGc33ssP3n6ZbgxYDoc2fqHacM4YfnI4w97upCD5hSZeKftYB+J2uO
	 4Xj4fDRuKi3nllxIbgamCtCGBWx+Drk5b+DaR1PqtsMQPuSQkoVWWzoXHY/ARmCwyK
	 zPQeP02EnqUCA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/18] btrfs: assert delayed refs lock is held at find_ref_head()
Date: Thu, 24 Oct 2024 17:24:21 +0100
Message-Id: <56f462d0498e3f89dd06587e2f8be803c28d29a9.1729784713.git.fdmanana@suse.com>
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

We have 3 callers for find_ref_head() so assert at find_ref_head() that we
have the delayed refs lock held, removing the assertion from one of its
callers (btrfs_find_delayed_ref_head()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index e81aa112d137..3aeb2c79c1ae 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -407,6 +407,8 @@ static struct btrfs_delayed_ref_head *find_ref_head(
 	struct rb_node *n;
 	struct btrfs_delayed_ref_head *entry;
 
+	lockdep_assert_held(&dr->lock);
+
 	n = root->rb_node;
 	entry = NULL;
 	while (n) {
@@ -1195,8 +1197,6 @@ btrfs_find_delayed_ref_head(struct btrfs_fs_info *fs_info,
 			    struct btrfs_delayed_ref_root *delayed_refs,
 			    u64 bytenr)
 {
-	lockdep_assert_held(&delayed_refs->lock);
-
 	return find_ref_head(fs_info, delayed_refs, bytenr, false);
 }
 
-- 
2.43.0


