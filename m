Return-Path: <linux-btrfs+bounces-11636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7986AA3D7AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941243AF9E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1E1F03ED;
	Thu, 20 Feb 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijZ0B8eM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5561E0B7F
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049489; cv=none; b=c/AM7tBN0Am6fI041nDSWfGwRhxVo26E4K0C24suCAlgiYmhCFOP+oJG6YrD83OKAaOfocApSQaJZUHi+DZ/mZzNsRRfWOTfA7CFpZ6XfzXdib0tZenCIr4VcNNKn8STLpQB48X+n2qyq+2BDAWNnV4+pqujYvJV9nZhuGoKvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049489; c=relaxed/simple;
	bh=SFoXfHCjtGJFKLXsvz0msUIJ3NMfNEF9czHWurNCZcY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HoNDZQZuYkXXeFdA1KmCkZok7HHtqTg5lQvjI9LCOXnjYFlfpC2xt+7iGxRJnJBV0w5yr69Esus1mauxHfCD2xu6MYfUrpSMSK7x8d1k6KtTqw6tF+i/XMhjC+MdFJYOmvp3KnEWOecJO2AH68DC83gM79pRtJkaFBxjDdWQe0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijZ0B8eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD8BC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049488;
	bh=SFoXfHCjtGJFKLXsvz0msUIJ3NMfNEF9czHWurNCZcY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ijZ0B8eM2uWD1Gea15zEflf3SLDY3u8LzYo6I1hzOoHkVVaapX5VhQ6Bn35tfw4Bh
	 XLfI6FfAE0ccP2FGhwm9L0cZY82/fiOLDErC/+IIa6jwqqJnuKmVutz+vARIUdSMvg
	 nWhaQTf01WKnYnmOSwB0R6aY3IAkEWjsmTsbY0PYvLtjjK3HQtZ7i07fz8qF+V3RDs
	 X1rt5oJ1zK/K91eVe/fzWHYiGgF3asVUMrWVz1Dq1iU3RQz0vmji2csI8VIUK0Y0nD
	 1oRCrJn3ED1WV4FeqVUTfDuH/s8CmN8m4kRNXQOvQEnVvrOsyRCabj1aI0Oggz8OS/
	 FlkA9RctQtTXw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/30] btrfs: send: remove duplicated logic from fs_path_reset()
Date: Thu, 20 Feb 2025 11:04:14 +0000
Message-Id: <11c4195087f7e815a71e9803ad276897df156c83.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
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


