Return-Path: <linux-btrfs+bounces-8060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC297A064
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 13:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E0E2811CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB9154452;
	Mon, 16 Sep 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBLh7DZ4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5613A89B
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726486630; cv=none; b=Xb2isbbspCS8zaB2AjW0Oo8SajqFAh32PR2NOb7g94Pel6aEvUMXv1sqmRiS9LxD8wxdf18krD95RzyNGJ37e01jpZPlEHKAWq1xbouTWuaHsaI1lOBNg/dJnIbGitqMflzubcbvJhvDXTZmu63deVVfwJEKtDVg2j7N8HjWGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726486630; c=relaxed/simple;
	bh=+Xe4MZ1BC86uCFT96XDn11RV9TZjUbsfBlaPM2dXI/o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=csNqbVKpBokuhMsM6HQzavQxEQzjCp/2KrQCmuOSrFePs9fwlqEdTBO79RmcCWsQjdd1YKK0tY52JWJQue1pYBzR9uXgUMALkv4I2pd6ym0zRvITDejDTaAwv/b0yisX44nt2A4VjolU+Da8uG6NFkGTESEexOLEePsv89PXrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBLh7DZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D00AC4CEC4
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726486629;
	bh=+Xe4MZ1BC86uCFT96XDn11RV9TZjUbsfBlaPM2dXI/o=;
	h=From:To:Subject:Date:From;
	b=oBLh7DZ4BbNBUG7RuCL2etq5FSq5hceQPUSsTiXvWoNjUh4WRDUisyAE/6wElvgl8
	 F7FyhmSi0caH+CGojvZNWrIfrjQ1ZJagElXCGSrg1qamSukZ2KUHm66eh3fgebbTg7
	 TdMnkUhcLRhNQvdYyTj+Jg/k2hRRAS9Mm3V8gu9pX/H6r74NXT/V4ScoC+phKxYCS5
	 WRs34qSZ+2Fd+UMBVD4MWMbOg18a4vmzwf1ujz25RP5WRFa2VAPaxwlgpFBAgrfLAf
	 ddYOZRCK5oPFvnBFQwiZXTtapBFDpc7QNV/Jaofe53pvM66WgVwilB1bE4YhCLr6Ku
	 bSb3d7FRNgpZw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix use-after-free on rbtree that tracks inodes for auto defrag
Date: Mon, 16 Sep 2024 12:37:06 +0100
Message-Id: <743f120462032370c7ae8ff899bfd8dbfb0ed006.1726486545.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When cleaning up defrag inodes at btrfs_cleanup_defrag_inodes(), called
during remount and unmount, we are freeing every node from the rbtree
that tracks inodes for auto defrag using
rbtree_postorder_for_each_entry_safe(), which doesn't modify the tree
itself. So once we unlock the lock that protects the rbtree, we have a
tree pointing to a root that was freed (and a root pointing to freed
nodes, and their children pointing to other freed nodes, and so on).
This makes further access to the tree result in a use-after-free with
unpredictable results.

Fix this by initializing the rbtree to an empty root after the call to
rbtree_postorder_for_each_entry_safe() and before unlocking.

Fixes: 276940915f23 ("btrfs: clear defragmented inodes using postorder in btrfs_cleanup_defrag_inodes()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/defrag.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index acf1f39e45d0..b95ef44c326b 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -213,6 +213,8 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
 					     &fs_info->defrag_inodes, rb_node)
 		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 
+	fs_info->defrag_inodes = RB_ROOT;
+
 	spin_unlock(&fs_info->defrag_inodes_lock);
 }
 
-- 
2.43.0


