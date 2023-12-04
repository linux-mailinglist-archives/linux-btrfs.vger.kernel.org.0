Return-Path: <linux-btrfs+bounces-580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A801A803A0B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6441D28103D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1302E824;
	Mon,  4 Dec 2023 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p46pASB5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB392E64E
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DBFC433CA
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706843;
	bh=MGMMOPfmskEocKsVkAeaCnVN0yIHSXR5NKaBqezT04U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p46pASB5ecdKIew2tsZmYRDWQrhV27AnH/pdgGpqmeeosLgcO+m0XzKuZ/xD1JJXH
	 ltfDsKZCm7lyKQ4tLY+pXLnpzzzUFOJM9sBijfJQkhbH9VZRFQG/pgkQQg0sPv5MK7
	 j3XMrxNO/gXduG/mftrGskNylJjI45FU2o3MkqpbL7f6awn1fGyggWYGXXMIUfvkc7
	 2t0cEYyBvV+pQI1xTlkQh72YvoUsFW3zR1LBYC1hIxs7PIhWkbwXZj+jGd+Bh60Okc
	 7dhxagl3PYE7bg3MA7zK6PoXwIegodSXQzpWwzYRR9gnNPjnAhRHtn2XbwTowfSv3/
	 4cFZqc27G5vcQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/11] btrfs: remove redundant value assignment at btrfs_add_extent_mapping()
Date: Mon,  4 Dec 2023 16:20:28 +0000
Message-Id: <2817890ac4b8027e099331b4a5d563f685d4fdcf.1701706418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701706418.git.fdmanana@suse.com>
References: <cover.1701706418.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_add_extent_mapping(), in case add_extent_mapping() returned
-EEXIST, it's pointless to assign 0 to 'ret' since we will assign a value
to it shortly after, without 'ret' being used before that. So remove that
pointless assignment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 18a5c4332ed6..a3d69c943eec 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -586,8 +586,6 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 	if (ret == -EEXIST) {
 		struct extent_map *existing;
 
-		ret = 0;
-
 		existing = search_extent_mapping(em_tree, start, len);
 
 		trace_btrfs_handle_em_exist(fs_info, existing, em, start, len);
-- 
2.40.1


