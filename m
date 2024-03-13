Return-Path: <linux-btrfs+bounces-3261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1288587AFF9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 19:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29D8285D6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A884A3C;
	Wed, 13 Mar 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os6u2zqc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0384A30
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350910; cv=none; b=f1yAoPac9+j1UD5mTXa0mIGTzF6jU3bV8SO7bDQDLvvWF49PKjsiabZbCFHRaJWmDXkZBkEa9RUWrpPx8MNMT7UhLW7uTTnuTBR9ze7CbXR3qm1CsRjTNePWairV0Yi4WHVObyCSQLLuyZu7KGiO/jVzk/oWl1j4tF/ZTav6h48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350910; c=relaxed/simple;
	bh=DVPDeU0cmDBdqhuhGCk7LpAUe3v+CuTzMTDHPA17fcA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOxiPMkwFb3rkRkNY40GNZW5A5Bzp1SrRy0cBmh2X3r/xIE5ZmiKc+tq55AlehMyb20LnLp+bsoZ087wPdVaQ1whe5JgGFmt3HV6/xNnY/31iJ6tpGYAARw5J53MPPO8f9jyDcuDESLgqcur0SPYGnflrDcp1kmilxGQqlR6wj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os6u2zqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB8EC43390
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350909;
	bh=DVPDeU0cmDBdqhuhGCk7LpAUe3v+CuTzMTDHPA17fcA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=os6u2zqcKNFyy6YCHxnOgjkDf0larSgFzahmz5FSckbYQBVJs/sQYAqur8bmpaUJg
	 3PgPajjPLMTO+rpgpge7ERpWQ4Hq6Asa/e8qqPFMjH1QXfF65dzCR3g1IG1+ibheR0
	 wSFI6vI1TehPNyrzI9rOBGmgr6s1UMZdp2K/RIhJKSEQIAhfdWmHsL2ZbvqlA/fYU5
	 /d4c6oV6T/qBE7kvIHxngXp99zvZmokcPRYIP238VrGkkCT+TzWvVtA/Q+pQ6clne1
	 O9UgfEG/hVQyaBOAKiklooRewiGzTy/cTOy3hGVRDGK8iov6HewFSBGxpDwOZlRWLJ
	 qlGbBpEWEKltw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: use btrfs_warn() to log message at btrfs_add_extent_mapping()
Date: Wed, 13 Mar 2024 17:28:22 +0000
Message-Id: <0e3229ebf093bd436e4323ef0fd8f2b9124ba308.1710350741.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710350741.git.fdmanana@suse.com>
References: <cover.1710350741.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_add_extent_mapping(), if we failed to merge the extent map, which
is unexpected and theoretically should never happen, we use WARN_ONCE() to
log a message which is not great because we don't get information about
which filesystem it relates to in case we have multiple btrfs filesystems
mounted. So change this to use btrfs_warn() and surround the error check
with WARN_ON() so we always get a useful stack trace and the condition is
flagged as "unlikely" since it's not expected to ever happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 16685cb8a91d..445f7716f1e2 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -629,13 +629,13 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 			 */
 			ret = merge_extent_mapping(em_tree, existing,
 						   em, start);
-			if (ret) {
+			if (WARN_ON(ret)) {
 				free_extent_map(em);
 				*em_in = NULL;
-				WARN_ONCE(ret,
-"extent map merge error existing [%llu, %llu) with em [%llu, %llu) start %llu\n",
-					  existing->start, extent_map_end(existing),
-					  orig_start, orig_start + orig_len, start);
+				btrfs_warn(fs_info,
+"extent map merge error existing [%llu, %llu) with em [%llu, %llu) start %llu",
+					   existing->start, extent_map_end(existing),
+					   orig_start, orig_start + orig_len, start);
 			}
 			free_extent_map(existing);
 		}
-- 
2.43.0


