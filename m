Return-Path: <linux-btrfs+bounces-5833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76163910339
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3B41F2395E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D61ABCC0;
	Thu, 20 Jun 2024 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6rmdR4P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7953CF6A
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883673; cv=none; b=V0KNhmrXHdM0D2EcQpSMNWR/mlfWi1Oaz50pA5AizXvoMDDWMcrZRCxTaaHlY+vul7HOmixjFA1VelQSddPh12dCjddOLZZe9q/aOK0CW0xD/CK17BMftNgS0nCtyW0p2INnlqEKHo42B6EFukEAoJWGOwJLXXnn9WnXBsUo6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883673; c=relaxed/simple;
	bh=mlGHpv7PLMGMHR92PBFFMFzYB0lrDq/D6wmDg5n91Hk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TYtR0JiGyhpKyVrV2i0vn+ln7r+Hk2M+qVdsFIQ2wYJTapZlK3me5RSzNCH+iTAX7/l7fmcBH1vFrf3RuhN868rz3WgKEyr2nO+4LBr/J4S3T/USpv9kpWI2ooMnUElMSaGqfyN1Ex+kuloR3PTPX8Me+KFNkz43FrjHQj4Gg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6rmdR4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ABBC2BD10
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718883673;
	bh=mlGHpv7PLMGMHR92PBFFMFzYB0lrDq/D6wmDg5n91Hk=;
	h=From:To:Subject:Date:From;
	b=n6rmdR4PnH5UtfwnZEZAyeEUKFv7xZPmN+bC3uIcdjqSOoKU+z4H4YlONUQWG2l4u
	 tE/OzDg48R6F2Vt/XqkRYXXm9jaDsHYeZZuHywGq+/63+BFn2/kcvJ5g9JgvLOOeDY
	 F+l5rY8IMHj2w5jnJ2K1YnDwp6OoHGrdB/QjprHGvYWMpG17HRaW3LpX+8DcEtFlaQ
	 fjCanarCgBCAA0kS88ixWDdVsSOByIQnF+oCpE/eXj0MC59tqzdteXkeBoy1TjS2ZG
	 KQZ4mq1kXq7//Wpv4swg0aYzpAxCKU5k/b/P6BirlWAX7/x/EenGH15SqTFzKkmOpx
	 NX4fAnb4Kmf3A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: fix quota root leak after quota disable failure
Date: Thu, 20 Jun 2024 12:41:09 +0100
Message-Id: <d4186215561658577a9622bf111c79909f0521c6.1718883560.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If during the quota disable we fail when cleaning the quota tree or when
deleting the root from the root tree, we jump to the 'out' label without
ever dropping the reference on the quota root, resulting in a leak of the
root since fs_info->quota_root is no longer pointing to the root (we have
set it to NULL just before those steps).

Fix this by always doing a btrfs_put_root() call under the 'out' label.
This is a problem that exists since qgroups were first added in 2012 by
commit bed92eae26cc ("Btrfs: qgroup implementation and prototypes"), but
back then we missed a kfree on the quota root and free_extent_buffer()
calls on its root and commit root nodes, since back then roots were not
yet reference counted.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3edbe5bb19c6..d89240512796 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1346,7 +1346,7 @@ static int flush_reservations(struct btrfs_fs_info *fs_info)
 
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *quota_root;
+	struct btrfs_root *quota_root = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	int ret = 0;
 
@@ -1445,9 +1445,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 				    quota_root->node, 0, 1);
 	if (ret < 0)
 		btrfs_abort_transaction(trans, ret);
-	btrfs_put_root(quota_root);
 
 out:
+	btrfs_put_root(quota_root);
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (ret && trans)
 		btrfs_end_transaction(trans);
-- 
2.43.0


