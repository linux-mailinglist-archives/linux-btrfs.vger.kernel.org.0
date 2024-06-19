Return-Path: <linux-btrfs+bounces-5814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05590E8F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 13:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7893AB214C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB4136E0E;
	Wed, 19 Jun 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcecr0Hu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DC0135A6D
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795208; cv=none; b=nhdBFBG/81udgyRLdfunt4tK3SpZpetNAqOYfpRRA00gcyPf05tiReqWZPXXQk4cyumpmcH+sw32UNqSXjYdQCxxdDzLurd6sa5Fz9qNLHMNsVPciF47ooHUjTBFzdiSULsNRMIjnkOBcXfH65etXw4X/YQ2LISjF+Biby/7Llo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795208; c=relaxed/simple;
	bh=rR6DMQkCf2iqBmxgUqpf6uND0QhqDp9IavAFgv49zr8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9w2L3hL2KvoGyWmIP/19Ww+T8jc36/6G/M6GI//sVshzngO6k4/O1AX28b/MemWgJ2iJYQEHnCYHZI5pyRhCnUlcoGMltdoRvmKuDoGF2BGUzwO/h5QjGmtI+jkVsY+6r4Nl3LAI2bu4hBWBw07jwiWuRV8UG1sdXpKrUsQrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcecr0Hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F366C4AF1A
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718795208;
	bh=rR6DMQkCf2iqBmxgUqpf6uND0QhqDp9IavAFgv49zr8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hcecr0HurVZX59ivMin8axsiiBMz/4G8PRvQPnR46FuM9YSd+GRx+rQmByNJRGdqW
	 sCoXqHrAiNtT/vwdFpA6nPLI4YbU2+7m2qfbxuGoZx0/E9oSQcefnqZY+SLjJNNAGW
	 ZGoWKlGpMZ5acnR6fsBzPLGh0ck4uuWc6823NguI6JqJOFPTWXu/HQRWPDcANooXos
	 Hgj6BxcJeeE/SpwVFagtxN3g0MUBIKhYu5gLqWvcejW5CrFbInmJkVtMx3aj8ydS15
	 zep4XGP9CGiZ2EgA12R16yflYwBnTb02kQucqhJCTLcmI6NL10ClzuC68xgAIL9cl9
	 vA5tGQwtYHeEw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: remove superfluous metadata check at btrfs_lookup_extent_info()
Date: Wed, 19 Jun 2024 12:06:42 +0100
Message-Id: <faa3bc9b7781d5f590e6a959a5acfa8fdcd03365.1718794792.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718794792.git.fdmanana@suse.com>
References: <cover.1718794792.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we didn't found an extent item with the initial btrfs_search_slot()
call, it's pointless to test if the "metadata" variable is "true", because
right after we check if the key type is BTRFS_METADATA_ITEM_KEY and that
is the case only when "metadata" is set to "true". So remove the redundant
check.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 21d123d392c0..a14d2a74d7fd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -139,7 +139,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		goto out_free;
 
-	if (ret > 0 && metadata && key.type == BTRFS_METADATA_ITEM_KEY) {
+	if (ret > 0 && key.type == BTRFS_METADATA_ITEM_KEY) {
 		if (path->slots[0]) {
 			path->slots[0]--;
 			btrfs_item_key_to_cpu(path->nodes[0], &key,
-- 
2.43.0


