Return-Path: <linux-btrfs+bounces-3246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E787A830
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 14:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE3C1C21BE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0872142ABC;
	Wed, 13 Mar 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTQaAzWt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226C41C7F
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336054; cv=none; b=KSumnyuczqNCmj71GlBF70kThVZnU5Ge1iKlNeYxUKomyXz/7qC/276AVfvRlakDR9sCk2AAdvmVHS51QdGJ6Hfc8UWLvq8tm5ybe8qxy8R8mPKRC5oaLgGE9k5wWtm+ugIjRPJi99qPeTUNWG0NFg9ase+sAVZpQpR3jj8tqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336054; c=relaxed/simple;
	bh=TPIpgh436/RTkMU6hqLipvWCgLN+GFBBbvyuHhDu76s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cP6npnpGi3f7qoqFHy6aLDwCVFrFFfWiEYgxYb1IiHE458cZ52I6GKMIMkFGwayEUpwx6XHs1+pwNy4kH9dJjPuR0N60BIuRw5oVSp4D2jefWJwa9kkDdYFlLtq95rM84d4R1zQQqYlYF+/xCfMziWIiVENImm2znUbya8UApFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTQaAzWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CA5C433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710336054;
	bh=TPIpgh436/RTkMU6hqLipvWCgLN+GFBBbvyuHhDu76s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uTQaAzWtjFIHV3pAVrXvA4+9E1iVXGk822O5E0ISTT9NRW4Cc+4vtrlr8bDPZhhJy
	 M84gTul+XxHQ3Szw69nb0O3jcjrxACUj0i9mQDvebN6eLrQ/OZyK/NNNXwaKj0N/P1
	 WssuDf0t4YndEGGZ0xMWbRST6N1RVOK28UnuQpWOKpm5EYdFrsx0LDNZCsPK8tcnV9
	 vcnTNL/0Pyvyl7TYRX58VAn+UziTX/Ph70s/19eQochvy60eQqLsILpI7T0rMFaKYr
	 VJHkiexTgNRxWrut5LdwqkC7yIGuhG2aEhdq1ClK8NPD5r8JeSk/aNRu+SukNNXU3U
	 O380n3JzFJhWA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: fix message not properly printing interval when adding extent map
Date: Wed, 13 Mar 2024 13:20:46 +0000
Message-Id: <ed32b1183350d7b8a5c9cce7d3e04cada65b828d.1710335452.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710335452.git.fdmanana@suse.com>
References: <cover.1710335452.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_add_extent_mapping(), if we are unable to merge the existing
extent map, we print a warning message that suggests interval ranges in
the form "[X, Y)", where the first element is the inclusive start offset
of a range and the second element is the exclusive end offset. However
we end up printing the length of the ranges instead of the exclusive end
offsets. So fix this by printing the range end offsets.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 2cfc6e8cf76f..16685cb8a91d 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -634,8 +634,8 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 				*em_in = NULL;
 				WARN_ONCE(ret,
 "extent map merge error existing [%llu, %llu) with em [%llu, %llu) start %llu\n",
-					  existing->start, existing->len,
-					  orig_start, orig_len, start);
+					  existing->start, extent_map_end(existing),
+					  orig_start, orig_start + orig_len, start);
 			}
 			free_extent_map(existing);
 		}
-- 
2.43.0


