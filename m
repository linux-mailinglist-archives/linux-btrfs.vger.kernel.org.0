Return-Path: <linux-btrfs+bounces-9325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68069BB933
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 16:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034961C20F39
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5D11C07CA;
	Mon,  4 Nov 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoLPOZ0w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EE1B6CE8
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734926; cv=none; b=W/TWc3fGlsNdHaci95cO6Kvy6PuGFNaYru3D3KHVBQo59kHEZeNg8NuF8C1Rdy10Li857vgyuw1viMUkLYhQ61lL2+JhEXUdGw1Auf2varCx8OZa9aib2fPqolAksvJrb3e2UlzE6MppRKpiG+ubMVOogomq0sRu612yLPJWGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734926; c=relaxed/simple;
	bh=FhPQnOD4kwEPrMYAsXaT4v7PdOD4WtGGs4kfacOF2j0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JKoaWgWi+a68gVei6ZTexP5SuwiGS69e4zWGf2HQH8rtNNpM7FMUSwhjuM3KSke9OJQPTJA3CZTRgNgM61Emb85+gyBouuHEb+AVaBK8Qm4zNfF67HZtqjZuT/cDTovrOrT7VTvpx0zq+qmVj2maAJHyoWnxaJbHt8daSIyOMxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoLPOZ0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC9EC4CECE
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2024 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730734923;
	bh=FhPQnOD4kwEPrMYAsXaT4v7PdOD4WtGGs4kfacOF2j0=;
	h=From:To:Subject:Date:From;
	b=BoLPOZ0waDmLl9uPpflSaD0uGG4XMpAoGGzU9wE+zb4DPQQl74B+YbrkYz5COWbrD
	 2fQacFec8GvMA+ZY1iGHQulHj5GT6JVMgFY182IZjjc7+8/pI0mp27iIkEB/LDGTdH
	 ctS3LQd27iq55Ca5ccxo3+wa1Go4LBdu11yeP9aksKJsmEgBkva378ar+ED5EOi3+Q
	 9jz6n3BDL9uWP7/EXFtMwTHZI+KnFgtjcPjswKn7C++Kc3YB/VFkd/5pGJG0sDiYCe
	 ++clnMgNPdHZq76Yg9QJYTfBqsSekSC3ZVOqBE23+Ipmq80bBfI3KmdxC8+6GQXBLs
	 X7Y9AexroJXkg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reinitialize delayed ref list after deleting it from the list
Date: Mon,  4 Nov 2024 15:42:00 +0000
Message-Id: <6bcfd46957685e044fbeab230ca13cbf6f469de3.1730734807.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At insert_delayed_ref() if we need to update the action of an existing
ref to BTRFS_DROP_DELAYED_REF, we delete the ref from its ref head's
ref_add_list using list_del(), which leaves the ref's add_list member
not reinitialized, as list_del() sets the next and prev members of the
list to LIST_POISON1 and LIST_POISON2, respectively.

If later we end up calling drop_delayed_ref() agains the ref, which can
happen during merging or when destroying delayed refs due to a transaction
abort, we can trigger a crash since at drop_delayed_ref() we call
list_empty() against the ref's add_list, which returns true since
the list was not reinitialized after the list_del() and as a consequence
we call list_del() again at drop_delayed_ref(). This results in an
invalid list access since the next and prev members are set to poison
pointers, resulting in a splat if CONFIG_LIST_HARDENED and
CONFIG_DEBUG_LIST are set or invalid poison pointer dereferences
otherwise.

So fix this by deleting from the list with list_del_init() instead.

Fixes: 1d57ee941692 ("btrfs: improve delayed refs iterations")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 012fce255866..4d2ad5b66928 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -594,7 +594,7 @@ static bool insert_delayed_ref(struct btrfs_trans_handle *trans,
 					      &href->ref_add_list);
 			else if (ref->action == BTRFS_DROP_DELAYED_REF) {
 				ASSERT(!list_empty(&exist->add_list));
-				list_del(&exist->add_list);
+				list_del_init(&exist->add_list);
 			} else {
 				ASSERT(0);
 			}
-- 
2.45.2


