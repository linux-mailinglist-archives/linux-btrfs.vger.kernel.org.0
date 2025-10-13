Return-Path: <linux-btrfs+bounces-17728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA042BD58E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B962B403624
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174263093CB;
	Mon, 13 Oct 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN6Y71vt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49D308F0F
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377106; cv=none; b=Olx1qgynyWbBWyYkD+ijU7TGUhAY1mDDXaC7cxkyxx3xdNUeoTBffM66RRFUgADjLRVrE4ousjIcM01SLr/9GkRsbhA1LSSEKiDlNA4QzpWdzGaUPOS3GObBx8KpQovJqOtEe1wDMgMYkAVGCPdeJxKHuaPWD0biXFiEmjxFARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377106; c=relaxed/simple;
	bh=0ASuRuAp/dE21EuBywOcrnwtaW4QGbadRxVscKzAa/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ju2EV7pP9V/EbopHQI9ZFiJ5fZ5dhYaYbrUNzf+MJwZT/mEJuIe/ZLOcxITHTaSgy6/51KJP3w6kFlrFWty68ir7pB8rBTTw3P72rtuZ1mLFl1kqO55PVKyFSQn++ULN8U+ag8ZOrjwprCt2yf9QatRZA+M7Ppnfg6EQniV/wpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN6Y71vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDD3C4CEFE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377106;
	bh=0ASuRuAp/dE21EuBywOcrnwtaW4QGbadRxVscKzAa/U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hN6Y71vt5A9M5zFqdvcmrde62uk4Jl5Usa+AMY0Jd2TZlXsgCMP+Ys8NcGttoT168
	 Ct35VrJXyBaj0F7Gesrv1Fm4ZYoVy4Ma4jRPzujr4bLESGfnJgum3NvR6RuYPzAZtn
	 DZiUlmLqNarjtCxgI6L/+O6LF071W4pOiQLRoJGDbv5yEMWiwBQNchaGR1yJZWU/Qg
	 im4oDYNkF6MyLY70hS8jmVGffbhqu0mNB/jDs7uHwLlnLbNAkso/CWbBUZjR58wwbv
	 OCoUniVXVdiaG5J/k2FyMlPcWnkQ19Sy6t6HNqP4EthQq9+OAm97tvPjZOPqL3w/+D
	 XxAs31dSDabTQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/16] btrfs: remove fs_info argument from handle_reserve_ticket()
Date: Mon, 13 Oct 2025 18:38:07 +0100
Message-ID: <a9f3416b4a991f1b8b5ff6540c24814ad47e86ab.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
References: <cover.1760376569.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5c17f5234ef5..778bf239a35f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1602,7 +1602,6 @@ static void wait_reserve_ticket(struct btrfs_space_info *space_info,
 /*
  * Do the appropriate flushing and waiting for a ticket.
  *
- * @fs_info:    the filesystem
  * @space_info: space info for the reservation
  * @ticket:     ticket for the reservation
  * @start_ns:   timestamp when the reservation started
@@ -1612,8 +1611,7 @@ static void wait_reserve_ticket(struct btrfs_space_info *space_info,
  * This does the work of figuring out how to flush for the ticket, waiting for
  * the reservation, and returning the appropriate error if there is one.
  */
-static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
-				 struct btrfs_space_info *space_info,
+static int handle_reserve_ticket(struct btrfs_space_info *space_info,
 				 struct reserve_ticket *ticket,
 				 u64 start_ns, u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush)
@@ -1653,8 +1651,8 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	 * space wasn't reserved at all).
 	 */
 	ASSERT(!(ticket->bytes == 0 && ticket->error));
-	trace_btrfs_reserve_ticket(fs_info, space_info->flags, orig_bytes,
-				   start_ns, flush, ticket->error);
+	trace_btrfs_reserve_ticket(space_info->fs_info, space_info->flags,
+				   orig_bytes, start_ns, flush, ticket->error);
 	return ret;
 }
 
@@ -1845,8 +1843,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	if (!ret || !can_ticket(flush))
 		return ret;
 
-	return handle_reserve_ticket(fs_info, space_info, &ticket, start_ns,
-				     orig_bytes, flush);
+	return handle_reserve_ticket(space_info, &ticket, start_ns, orig_bytes, flush);
 }
 
 /*
-- 
2.47.2


