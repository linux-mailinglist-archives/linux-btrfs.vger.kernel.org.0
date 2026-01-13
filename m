Return-Path: <linux-btrfs+bounces-20453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E46D1A6AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 17:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 000DE305F526
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242434EEF9;
	Tue, 13 Jan 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljeHgJOt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364334E746
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323064; cv=none; b=aKbi4RxWGdChZ/kH+4p29Ty9i+2oEnYibVF3rIJrioAHBWf/PpLFZZ8xnCG9u3sQg6VZ5XoNwmTApKuKGZ9lItskmA2xs+/OSnAtSdEKrkkFgDN/go3T4EEKDHA3J+H6kYjrbIzJ4TKg229qtd0ba7gR4TdFmJ+O9s6h9F/P4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323064; c=relaxed/simple;
	bh=dMYaobjerXz/FSTUCgGFDOaHoVAq4iAujb7F4rsvhhk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxfBmVVRXaT548P4kUalmRz8y32OTIXemtYtWAE09NrbKh18PKKpdV9On8xFxBGhYKg788ibNXKAQiEQtvUwebgBj/pEO56DfySfhinXbLD3RQ8P0DSb95Z5b4PHZD1pD2XjfgXCldERtrU4j+Q3c8kba2frOPDn+tpdT/d0xeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljeHgJOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720BDC4DDE6
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768323063;
	bh=dMYaobjerXz/FSTUCgGFDOaHoVAq4iAujb7F4rsvhhk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ljeHgJOtczUyiVBEcYdaBO7LzY3lJgHy2MbpQzI2pJcSSfHH7pdS0vgN0MVV6Cf3/
	 zaNlLK9qzqvemeqXCZsbd+frE3P40VUWghTQPaOnKSmrS+e62tkG23qW+nvs/NBQZe
	 Uy4top0idUsn5jb90rN14J2NlqkmvH84SysTIOFcvFU2fAc27KEQjnRUXBm2AHZ8fb
	 RWcTDJvs8u/Mwwc0yosqY1R3iI5QrGtD076csL0B78UWkzdfTQyKyAq8rZAfj+EU+c
	 sKjkETtjteruVjFGLDEeMazWj4RVdNksVQl8+Fu76dLddkUESd+eToONxQWTJOArft
	 GOwldif+7R36w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: remove unnecessary else branch in run_one_delayed_ref()
Date: Tue, 13 Jan 2026 16:50:58 +0000
Message-ID: <5df7343a6770c9a071be784d971ff7cd8f1ae51b.1768322747.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768322747.git.fdmanana@suse.com>
References: <cover.1768322747.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need for an else branch to deal with an unexpected delayed ref
type. We can just change the previous branch to deal with this by checking
if the ref type is not BTRFS_EXTENT_OWNER_REF_KEY, since that branch is
useless as it only sets 'ret' to zero when it's already zero. So merge the
two branches.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5ca65df8d04e..ffb62b58a919 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1780,9 +1780,7 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 		 node->type == BTRFS_SHARED_DATA_REF_KEY) {
 		ret = run_delayed_data_ref(trans, href, node, extent_op,
 					   insert_reserved);
-	} else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY) {
-		ret = 0;
-	} else {
+	} else if (node->type != BTRFS_EXTENT_OWNER_REF_KEY) {
 		ret = -EUCLEAN;
 		btrfs_err(fs_info, "unexpected delayed ref node type: %u", node->type);
 	}
-- 
2.47.2


