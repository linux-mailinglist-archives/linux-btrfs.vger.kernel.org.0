Return-Path: <linux-btrfs+bounces-16645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE685B45D7F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3040F1626A7
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77817302145;
	Fri,  5 Sep 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvbKrF/4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFE2FB0B2
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088636; cv=none; b=NS75B4JZ5x0SkDPyt9tFiUw2aUBQze5MLzOKC7hlq5gEvXl71VXNFCnwkd29dKD69QKnLYrvvGykUw1olZ3zu8O+PUdXxapmCeGeugRP0+nfgmugEJepewlSjnBv9Hma3b4X26OHWc6RqDo3m6v4AzJZmBnaLLM0VSEjvzVRmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088636; c=relaxed/simple;
	bh=rwnbfINxEY6deZMhj7TGneuNUzMHgCbZad9wPEJ11dk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c25kyYbqrE/tVT+VG/U1/DSVHEWMTvPUO/E69hz9QB3mfomNtnzb/L3UchA+TCknJRohwnW49Iyu85tw909+p4oaaDJGYLRqxeOQ6zDQHqyA1hYtoAuWfGCXUXul0vNkn7hGaub4uKOmOZdlNSVog/5qlgYWQP4jXH+qk/5ujDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvbKrF/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51A7C4CEF7
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088636;
	bh=rwnbfINxEY6deZMhj7TGneuNUzMHgCbZad9wPEJ11dk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nvbKrF/4ueKYQ6dGveZJ3LRyCbGNs8uNEXw2h4kVngwDP95qqnoA6Bl0N4eboRdPP
	 SBxdSXB1CFMmQVaRqnJwZiggth8Zgr8J+vknHT8CaZ7Htl5cKB2flllWqvsjHF0Ldp
	 HC+q4OAUahZ9nAq7dzzG+VGjB8JVz0+f3lzAk2aqXi+z5BY1dZNCqpDMfPIoWiUyF0
	 2WoQL3yYSfUv4PnYkkgj5Q3YfhLrFf/hNOV7V1umFSXRyLZVYbrXaVBvej5Z4RJsyz
	 qIxBDUsDCE0TdqytG7T0rG/N3w75aPHy6UJghc00uIcfoKan6HBU28n0nYsoUSxmdu
	 XRhwvu+Ir8i0g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/33] btrfs: fix invalid extref key setup when replaying dentry
Date: Fri,  5 Sep 2025 17:09:49 +0100
Message-ID: <1a76c9506d4b2e0d8e54de14e7db939c3e72a74c.1757075118.git.fdmanana@suse.com>
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

The offset for an extref item's key is not the object ID of the parent
dir, otherwise we would not need the extref item and would use plain ref
items. Instead the offset is the result of a hash computation that uses
the object ID of the parent dir and the name associated to the entry.
So fix this by setting the key offset at replay_one_name() to be the
result of calling btrfs_extref_hash().

Fixes: 725af92a6251 ("btrfs: Open-code name_in_log_ref in replay_one_name")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b91cc7ac28d8..861f96ef28cf 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2058,7 +2058,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 
 	search_key.objectid = log_key.objectid;
 	search_key.type = BTRFS_INODE_EXTREF_KEY;
-	search_key.offset = key->objectid;
+	search_key.offset = btrfs_extref_hash(key->objectid, name.name, name.len);
 	ret = backref_in_log(root->log_root, &search_key, key->objectid, &name);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
-- 
2.47.2


