Return-Path: <linux-btrfs+bounces-20042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BEDCEA2EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A58302C4E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D5320CD5;
	Tue, 30 Dec 2025 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="uKxaof/1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E82288F7;
	Tue, 30 Dec 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112374; cv=none; b=IhGNfY+tNxxYMexzrQCO343tIalFpMcXlk+1SFzq2EWFj5vEGApPHVYBpHM8zW+F6GAb/vPjKPLgMc6vXkfO9mjPUnSY3isgAYgMIcrl/S5smfQJD1781W858w/GysfDUY49GwVs4/YavtJ6fKdXrn0HGTWpjMt2Hrr1Eyn4KQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112374; c=relaxed/simple;
	bh=UKwD4QA2zc+vS6Yh3+bn4gb44jnXtV4ArUPDPMop0Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TUSe07Fn97szE+BERY/kPhYbKC4IMngD27hPMHyV4LeEHY2yyiJ3u2RgIXPxUvUiE66Oz++fg4RgLSng0P1IaR5x7bJ2Ppff9f3mjKkMvHHhQmznzR3MOeH2K73R06Dd15WD9AZKV/4nOuN7EicDcGVQyiGu/vyNCIgx89H9Ed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=uKxaof/1; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FEEeM9Hl9y3mOpfTNfKcdE5tlFSYWQANApBxVQZG5bA=;
  b=uKxaof/1Czp1XNgPcSddH7vDMo66RiczDGMJTaRebVw/PhLDXzUI9xzb
   QkW5qoZVXq9nuTTngYscm8Naw/dcqX1HQmMunoc461++62Wy5/RHLZAlk
   TnHEJIIhTNdKY+6AGSG79Nxc70HOMiUtakeqvBb3v01rrwJTLuk6aVkel
   M=;
X-CSE-ConnectionGUID: IVOXtZd5T9OCgKgNEGWj5w==
X-CSE-MsgGUID: Ywwrguu8TrqBzTPl4jBQ9g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,189,1763420400"; 
   d="scan'208";a="256361906"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 17:32:50 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Chris Mason <clm@fb.com>
Cc: yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn,
	ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: update outdated comment
Date: Tue, 30 Dec 2025 17:32:45 +0100
Message-Id: <20251230163245.102164-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function add_block_group_free_space() was renamed
btrfs_add_block_group_free_space() by commit 6fc5ef782988 ("btrfs:
add btrfs prefix to free space tree exported functions").  Update
the comment accordingly.

Do some reorganization of the next few lines to keep the comment
within 80 characters

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 fs/btrfs/free-space-tree.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 1ad2ad384b9e..0e353d0aab13 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1396,9 +1396,9 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 	 * can use multiple transactions, every time btrfs_end_transaction() is
 	 * called at btrfs_rebuild_free_space_tree() we finish the creation of
 	 * new block groups by calling btrfs_create_pending_block_groups(), and
-	 * that in turn calls us, through add_block_group_free_space(), to add
-	 * a free space info item and a free space extent item for the block
-	 * group.
+	 * that in turn calls us, through btrfs_add_block_group_free_space(),
+	 * to add a free space info item and a free space extent item for the
+	 * block group.
 	 *
 	 * Then later btrfs_rebuild_free_space_tree() may find such new block
 	 * groups and processes them with populate_free_space_tree(), which can


