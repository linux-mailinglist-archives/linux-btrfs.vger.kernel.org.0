Return-Path: <linux-btrfs+bounces-12274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33DA5FEAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 18:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D7F17A79C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32E01DB13E;
	Thu, 13 Mar 2025 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbEOPkBJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3686C1EE7A8
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888546; cv=none; b=tgcT+ZyO5maZisfShyvTdhtX+AA6L3djj4O7rM9jYXxDAMA3QePx9uSIMGJEn1B1kJoZj9ucI/Zyg7aKf5ApIKauSwSjgTA7JS/w0UodL9H7Ww3HuRiVoLp4KD2qWtApTa+4+RbPu2bdxeI4piW122/tbaDd11wGTje/M248/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888546; c=relaxed/simple;
	bh=6E7elXrNShAsXcmlKp8m0C7bfMznDt0njsegam2R7MM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJ/uzDue/E3SsGpiE50/E+sFKrEAKZYldz5YQTCDIeNrAY5F3foqczeRcvLr0Agj8QFuJGxeIn1CoXVf+FvDwWYQhuyiF3D0WDAxxMdAwN94gvf0nRhItMjmuBi3AtVlswZqRP+5VPKn+jREwzdikcK5vtwhGqfkBMRoTgSTKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbEOPkBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33758C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741888545;
	bh=6E7elXrNShAsXcmlKp8m0C7bfMznDt0njsegam2R7MM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bbEOPkBJ5JI2Yw8wm0EfMLauY5oxIK3IscnX8DO9nCRsgY60SY/nSW43+Al+/jHCE
	 8xlnzMg7jrDbnMw8diKpV9YCi18osxe0xcm1ADDJDrv3Oda5fD4KiCCvL+UNPlgbZO
	 3ZKJyABw/7ojvatMsllftb6f9B0nw3KLtjuep/LepF8VspgoW/d09erkQ0kzGKkLmw
	 LFEc1ab/l5CGvWNZJjJMHW+2v2F5ETRZcOv9/gdXCzZU80bBttJHKb3A1FWC6VXRdl
	 mKtvzhPBPXYbTFe1cYJ00aiLls3JnkrZJoT27LTrN+yW5GW4lLJ4k2/gQvqqw4tXH3
	 /VRUg6+NaY/BA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: remove redundant else statement from btrfs_log_inode_parent()
Date: Thu, 13 Mar 2025 17:55:35 +0000
Message-Id: <a11e11d7590be613434fb90a29dc6d4affce9463.1741887950.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741887949.git.fdmanana@suse.com>
References: <cover.1741887949.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we don't need to log new directory dentries, there's no point in having
an else branch just to set 'ret' to zero, as it's already zero because
everytime it gets a non-zero value we jump into one of the exit labels.

So remove it, which reduces source code size and the module text size.

Before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1813855	 163737	  16920	1994512	 1e6f10	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1813807	 163737	  16920	1994464	 1e6ee0	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7e0339f5fb6b..6c59c581ebe4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7146,8 +7146,6 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 
 	if (log_dentries)
 		ret = log_new_dir_dentries(trans, inode, ctx);
-	else
-		ret = 0;
 end_trans:
 	if (ret < 0) {
 		btrfs_set_log_full_commit(trans);
-- 
2.45.2


