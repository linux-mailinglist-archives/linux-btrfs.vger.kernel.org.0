Return-Path: <linux-btrfs+bounces-15225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2AEAF7D82
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 18:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3FC582E78
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1DC2EE98D;
	Thu,  3 Jul 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYOTfua2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E002E7F39
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559010; cv=none; b=tCK/IqaUF/n5hLD4dFG7Zl0yY1nX1j7eCq3cLz9gAmal57MKmXAcJBSLl4Mh90L3eS30NgY6F3FbwCIiuz6yjL6AecW/VpHzbKHRazlOLOFZULVX87Xo6t0mnZ6k/lmodyIvfbNzPBSiGniVT95WHs7F+niuwmC2RJCNCC6Y9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559010; c=relaxed/simple;
	bh=3/y/G/6FILEakliPdvqz5NhC++f0oqwChijMn3EzQ1o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RTijkJ4xYi2MkMuPom1ikmiWPDyuYYhnTKRfHdfJs0FoTt1iJrWqUZq/CYYAufNvACrmD+MV378dlKszgPkFMZVtqQ7SbnnRgRuRiE0y0Ytl2g6SNEpQque2VbK7NvLEOiBpPgMPfCG9QejOlVfiumpaNTI57ASJ/uk7Rlp2hag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYOTfua2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81CFC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751559010;
	bh=3/y/G/6FILEakliPdvqz5NhC++f0oqwChijMn3EzQ1o=;
	h=From:To:Subject:Date:From;
	b=WYOTfua2UfybiNB6/jXdo+OFfayiOvFiHRbwI/BmZ0Hw81NNeu3vLsxN8JTk4nQVh
	 WNS4Go31XeOm7vrWFzFAMQjlgx46FzVEJyxy3PP4Tqcpm25eOBT49Gjgi16OLLYcVA
	 NPkMiw3FIrP+u/zOqjsIAmY7kd76oakomG8TaVnkXZwfOGlONTIZDaCDR98IuMLfRp
	 2aD5dkRybZBFpK4e+Vl1rT223dOzhbTY79uKRZm8NZn+RVX4R1gKIoF6N8BdvqqZq2
	 A98OYfkaOjjX7pA4/U9+KGdjKFRAIMp7Jv9s8CoLYxrSjE8VTuO4zZonjQsKZVw4ia
	 IwlW4F958FPFg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: directly return strcmp() result when comparing recorded refs
Date: Thu,  3 Jul 2025 17:10:06 +0100
Message-ID: <30bcc022fde1071a86db10f10c984bddd87fcef9.1751558928.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in converting the return values from strcmp() as all we
need is that it returns a negative value if the first argument is less
than the second, a positive value if it's greater and 0 if equal. We do
not have a need for -1 instead of any other negative value and no need
for 1 instead of any other positive value - that's all that rb_find()
needs and no where else we need specific negative and positive values.

So remove the intermediate local variable and checks and return directly
the result from strcmp().

This also reduces the module's text size.

Before:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1888116	 161347	  16136	2065599	 1f84bf	fs/btrfs/btrfs.ko

After:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1888052	 161347	  16136	2065535	 1f847f	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 01aab5b7c93a..09822e766e41 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4628,7 +4628,6 @@ static int rbtree_ref_comp(const void *k, const struct rb_node *node)
 {
 	const struct recorded_ref *data = k;
 	const struct recorded_ref *ref = rb_entry(node, struct recorded_ref, node);
-	int result;
 
 	if (data->dir > ref->dir)
 		return 1;
@@ -4642,12 +4641,7 @@ static int rbtree_ref_comp(const void *k, const struct rb_node *node)
 		return 1;
 	if (data->name_len < ref->name_len)
 		return -1;
-	result = strcmp(data->name, ref->name);
-	if (result > 0)
-		return 1;
-	if (result < 0)
-		return -1;
-	return 0;
+	return strcmp(data->name, ref->name);
 }
 
 static bool rbtree_ref_less(struct rb_node *node, const struct rb_node *parent)
-- 
2.47.2


