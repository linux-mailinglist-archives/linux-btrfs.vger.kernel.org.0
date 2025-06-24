Return-Path: <linux-btrfs+bounces-14917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3DBAE69B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5706C4E64D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC92E0B43;
	Tue, 24 Jun 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us9J5LSq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6482DFF3F
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776148; cv=none; b=BFYavFZD6DHWmFU+sYQgE1hsaX36nNRqg7mVFIItewKRgQKdXZdL6/xRlyTUL1RiO0suAgLbMrbCHVRBoFPluY/D1Uzp8YZqEKthjK+bN2yfKRobB6y+LK7ldRSpoCO1peNxZhVClXWna9t574FAtraPSV1Sk4zucTbSrA/nmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776148; c=relaxed/simple;
	bh=ABXoF4f2z/qBE503PAcMq/XrgUjzRZjcC5r8XcLlg+o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/9Dn5C97NRtZhhy+HHG4Q724j5JK0JEPU9fTus9DQ+nMDBJGbLYPh/zlvuSbS/rz3OhKX04xoBH7/xDiOFegiqI+PSSlOqtB76GqWaxAPkEoF/GwwrdicC0nGAVk1nojOL8MQtzwMQjk+9gmI94JCkPiKSRKe+j8URN/HS/YU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us9J5LSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2C3C4CEEE
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776147;
	bh=ABXoF4f2z/qBE503PAcMq/XrgUjzRZjcC5r8XcLlg+o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Us9J5LSq/S9AbTCln9m7Iff+pbCN76WYRjCoRMQSuIV0tOXbBXqyn6hRZ6XGj0tm+
	 5Svrt27zwVIl/Er/K3mI7qCo+ABqFKWaFokyFvuKYUmy50NNyEFpTAkQXP82Q2xztf
	 R8RXanwAkIP7Ic1S5QL46BPI/JMF3aZZP3uEISAinT3MxtqN8Sx9pUYQ0amgzzoX8A
	 NktitQSS15PGHkwQIJhWVhSKTzFAvXxOjiNpOx2RZ2wl9GsoWyiqd7PHmkk/lfOePD
	 5N7Qv5nBWqTWVG1KToPLyvZwuO8ogoppPlYe6qjeV7xAKYj2vNAa/sz5KxkYWF8YU+
	 ElOtQkvwK2uDA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/12] btrfs: fix missing error handling when searching for inode refs during log replay
Date: Tue, 24 Jun 2025 15:42:11 +0100
Message-ID: <78786d6de8f9d4564abaee440ed6260d5c9afd8e.1750709410.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750709410.git.fdmanana@suse.com>
References: <cover.1750709410.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During log replay, at __add_inode_ref(), when we are searching for inode
ref keys we totally ignore if btrfs_search_slot() returns an error. This
may make a log replay succeed when there was an actual error and leave
some metadata inconsistency in a subvolume tree. Fix this by checking if
an error was returned from btrfs_search_slot() and if so, return it to
the caller.

Fixes: e02119d5a7b4 ("Btrfs: Add a write ahead tree log to optimize synchronous operations")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 839252881138..08948803c857 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1073,7 +1073,9 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	search_key.type = BTRFS_INODE_REF_KEY;
 	search_key.offset = parent_objectid;
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
-	if (ret == 0) {
+	if (ret < 0) {
+		return ret;
+	} else if (ret == 0) {
 		struct btrfs_inode_ref *victim_ref;
 		unsigned long ptr;
 		unsigned long ptr_end;
-- 
2.47.2


