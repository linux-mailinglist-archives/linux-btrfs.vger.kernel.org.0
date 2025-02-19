Return-Path: <linux-btrfs+bounces-11566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28371A3BD3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC727A478F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D71B1DFE29;
	Wed, 19 Feb 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7OaDpYC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EBB1DFE10
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965411; cv=none; b=rdLkBgoJvcxp/YAXyJxD+aIjxa0ts9zzmR+SlMmrmYYecTcCcjd9F5/ylJkTki0l79PpeLrf5YtpfswKfulye2wyMgq1mOC1VQCNO6K9jzEv1FVtNTKvZWJVm+RcYNnbhAuUkU9VlbBvruJOQo9iVZyfycwZoKk1pToye9Y5ud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965411; c=relaxed/simple;
	bh=SFoXfHCjtGJFKLXsvz0msUIJ3NMfNEF9czHWurNCZcY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Epi67D60yxwPblUiox+GXuG8IO1jmbGUgiaL8JiZ/qSsbQo6uRlEBvaWL0VAB3tHi54JMDoAqqbvx6UcYjfAZWC0PP0/uyFuhQGtR0/njbHd4xUaOQdV1AWp73nnXLUEMbxavbZQvVt9+0S/daMnXoHs1Dam/qfyiEfgnu8FmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7OaDpYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C550FC4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965411;
	bh=SFoXfHCjtGJFKLXsvz0msUIJ3NMfNEF9czHWurNCZcY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k7OaDpYCQ77/i7ElalthN9hf8yKbQEwM7PNP0FugpxLROtz0G26MZoDk22jit6R8H
	 F5Y161/LT2XVm+FjGKYB39lVGQ6FpTpjFiXr9u60csRG+VVsDyOLTokwn8ad6SHzKc
	 +LeKIaH6emwCrp5zv0+6lKf8lEZx6pCJ8VUeI8F3XAyHPmxYUkjpJ00H4GFBZMFrXh
	 OgLHqIwZyz0ef2l4OPWr+ennDXqtlJ10KKKOuGp4kMjtYCQmI9pe7UCt4SAs76L/a/
	 hV80cG7FTudNSZ+/10phNB9eKsKo9l9OOjObNt4kCYrlmMPkC9s+7qXpvC+37bGYUy
	 atZ8DmkVfLz9g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/26] btrfs: send: remove duplicated logic from fs_path_reset()
Date: Wed, 19 Feb 2025 11:43:01 +0000
Message-Id: <47d18790786cbf47aa764a45222e3a92e2c4da81.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's duplicated logic in both branches of the if statement, so move it
outside the branches.

This also reduces the object code size.

Before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1746279	 163600	  16920	1926799	 1d668f	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1746047	 163592	  16920	1926559	 1d659f	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d513f7fd5fe8..8de561fb1390 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -424,15 +424,13 @@ static int need_send_hole(struct send_ctx *sctx)
 
 static void fs_path_reset(struct fs_path *p)
 {
-	if (p->reversed) {
+	if (p->reversed)
 		p->start = p->buf + p->buf_len - 1;
-		p->end = p->start;
-		*p->start = 0;
-	} else {
+	else
 		p->start = p->buf;
-		p->end = p->start;
-		*p->start = 0;
-	}
+
+	p->end = p->start;
+	*p->start = 0;
 }
 
 static struct fs_path *fs_path_alloc(void)
-- 
2.45.2


