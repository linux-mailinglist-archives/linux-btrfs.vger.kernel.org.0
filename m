Return-Path: <linux-btrfs+bounces-575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF04803A05
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B9C280EE3
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0BD2E3F7;
	Mon,  4 Dec 2023 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skktMps4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E42D7BA
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFF2C433CA
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706838;
	bh=9lK5D4TO6krBmepnpurGqzPEWZhoG7lbhgCvCAzcGcc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=skktMps4fJUUCskZOMYtb8er40FWh7BT4N700z1+c3iDDS+0kh7GIOA8vl/u9Qn5g
	 USLVfHyOscnUbeUDmM/IG/DulzILrpOgeSHe8WaMIfT6f/m1AeizAPo3n+HI2PQuiP
	 LaOgNq39R81r4RuBWFcVuMX/9k9AIMgebsKnHlE9TlVL043+g1Ywns0EUAlDQD7x/t
	 k0n9cyM6CPEG4tEcNLV4a9Uv1ozAaK9UigFkPuyHODCEaDOWfxesEfkDVZl3NysRmK
	 KF7E9nz62N5fslV82Z2hKR4+z44igrS1zM3/VP/9u3uIRe53VDRD4d0ttvXFTwIY4G
	 GVKKBVu53Wxzw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/11] btrfs: assert extent map is not in a list when setting it up
Date: Mon,  4 Dec 2023 16:20:23 +0000
Message-Id: <1c7823ba659077cc792b1af1ddbb1e837dbb118d.1701706418.git.fdmanana@suse.com>
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

When setting up a new extent map, at setup_extent_mapping(), we're doing
a list move operation to add the extent map the tree's list of modified
extents. This is confusing because at this point the extent map can not
be in any list, because it's a new extent map. So replace the list move
with a list add and add an assertion that checks that the extent map is
not currently in any list.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 80f86503a5cd..d29097a8550a 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -345,8 +345,10 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
 	em->mod_start = em->start;
 	em->mod_len = em->len;
 
+	ASSERT(list_empty(&em->list));
+
 	if (modified)
-		list_move(&em->list, &tree->modified_extents);
+		list_add(&em->list, &tree->modified_extents);
 	else
 		try_merge_map(tree, em);
 }
-- 
2.40.1


