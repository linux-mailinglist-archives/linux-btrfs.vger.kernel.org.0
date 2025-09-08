Return-Path: <linux-btrfs+bounces-16701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3D2B4891F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9837A4B3E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BF42EB85D;
	Mon,  8 Sep 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eReOcTFC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAB2F616E
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325217; cv=none; b=gEC7V+MyPFAZVT6ry0XKG+qH9IXOxiNK/mlXEb57270hcpBH4nF2zUe0/8E1eduxYWCIm3dQIvAHtR2k+5phWARchlvVs3wmtN6KuLk+jZ+f0zOX1UciuLCH95LiB54n/hJb511SvPeDvwtI5nuMpvhz2miaS34443d8OcDgP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325217; c=relaxed/simple;
	bh=dLkby40ziB33v6+PY52OcmIkU1TRoOTGcDfT3CTe1o4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTHZ5ZPj0Kb1FkfkPL5IfPkL3/UnaFl+07QRpjB+OxL3UIadOGTWrnJUA04ygx1btcZyWnNCl8m1f5uGQ5skNuWCIjWiK2U5bXZ36HLl8GVYaIkY5llFkcB2oa2kmVstaU73pB8+d/m0LxVNv+DzpHUVXzilhFM2VVs402WbA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eReOcTFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6337C4CEF9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325216;
	bh=dLkby40ziB33v6+PY52OcmIkU1TRoOTGcDfT3CTe1o4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eReOcTFCgBN7RWZ2ON57nbt+bJs5p8DFSlAhDHO7OrvwqGYfZX9L9CyEGmKDfcF8O
	 a6YgKKmViwMT5dtJjBslrAvh2t8uZISkEZ/RyCrXzf+sLxp+qctdW650figN8/TOZj
	 2ewiMdqit9ovaOsdb0GWh2xxLb0I59c9FCzlQhWP2+LA81L615kOu1HXVTR/Gcw3r4
	 EoPyAIY82CCtLfnTCWVc2r5DhnfNSIBuEuZ4ug1oz4sHdjPK4oOkhvuC/HqEAhog8b
	 T+xpKckfy+4q6MD/GTEY5mlAaa9tDYEz5CfcGHqcgYYsb4UFLLaejt7FuDJd3S+Auj
	 Gs1Nans+mFfGQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/33] btrfs: deduplicate log root free in error paths from btrfs_recover_log_trees()
Date: Mon,  8 Sep 2025 10:53:00 +0100
Message-ID: <33e657e1205e043cb20b223212406a75714a14b4.1757271913.git.fdmanana@suse.com>
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

Instead of duplicating the dropping of a log tree in case we jump to the
'error' label, move the dropping under the 'error' label and get rid of the
the unnecessary setting of the log root to NULL since we return immediately
after.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7d1b21df698d..f039f0613a38 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7491,8 +7491,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			ret = PTR_ERR(wc.root);
 			wc.root = NULL;
 			if (ret != -ENOENT) {
-				btrfs_put_root(wc.log);
-				wc.log = NULL;
 				btrfs_abort_transaction(trans, ret);
 				goto error;
 			}
@@ -7510,8 +7508,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 */
 			ret = btrfs_pin_extent_for_log_replay(trans, wc.log->node);
 			if (ret) {
-				btrfs_put_root(wc.log);
-				wc.log = NULL;
 				btrfs_abort_transaction(trans, ret);
 				goto error;
 			}
@@ -7597,6 +7593,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 error:
 	if (wc.trans)
 		btrfs_end_transaction(wc.trans);
+	btrfs_put_root(wc.log);
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
 	btrfs_free_path(path);
 	return ret;
-- 
2.47.2


