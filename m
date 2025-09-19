Return-Path: <linux-btrfs+bounces-16995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5ABB8A28F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 17:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57E37A1632
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3083191BB;
	Fri, 19 Sep 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="loG3WCmQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0BB316911;
	Fri, 19 Sep 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293985; cv=none; b=CT2CbwZUAR5xL9aEa0EZDSJ2dVwmVzGKQHSHucZRfxz1hg81UmPvd3/JJiDxwvFxblAIG0n/xfSU4z8xDKZ9Lk8lXPwqQoUo0vPSxG7ccXUBLrYSt0PpSgKr/xTTyaSEa9km7+OtOdz1LmPqjMibzucK6swS7URpITwFeefsAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293985; c=relaxed/simple;
	bh=LJY0WDagaEhtz0UvnBGr5yfHdfFuWdFOHF8eBLArAVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzhQhDTQSRP4ugadVA9Q88EoSB31JjGpUIQpl66raIpKePjkTytckwsORez/l4hLJYvOkE8c5f5dn75AXo0I4cjYZqYsOTzZijnqGKxMKX8jbr6dMFBKUeDksqF1eWWyq7KbjpHiV7T0Wwp7mlTQBEutWmfOMEBIIa8q2S2TMOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=loG3WCmQ; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cSwdf0NhkzB0xR;
	Fri, 19 Sep 2025 16:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758293974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp653k4Z2RIN324fuXsolRuumHzroygXPu2pDZbI9qQ=;
	b=loG3WCmQS6ga1JIlrQxYU+fwUEtrkGoVgCQXGOOdEBwZ3a+5FYS7NnUkrtzCaRInnlMQnR
	M6/q62AEggFvmlXg5NA0CLMsLbhHt14GzjDkbcnjnIpRLmZnj5MWB8YsYe/dqhjZyUT7yS
	NKVtpUbxbEQ52+3FBtsb0FtubNTWkrgnDjxz+bBSYrypNuHJv0qXAWe82LkoyasYvswQwL
	DTAKNia22r/kSmNSP34BE3fb0VE72krSn2tBElzHZLxG1W5M7dps2O843YhiELjzX47D4H
	pvVNn1qOmwYABrlowd0SMMoHhmfCwDVKwB7hAWUQhgaDp0PzfgFi5jE4r1LwZw==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH 1/2] btrfs: Prevent open-coded arithmetic in kmalloc
Date: Fri, 19 Sep 2025 16:58:15 +0200
Message-ID: <20250919145816.959845-2-mssola@mssola.com>
In-Reply-To: <20250919145816.959845-1-mssola@mssola.com>
References: <20250919145816.959845-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As pointed out in the documentation, calling 'kmalloc' with open-coded
arithmetic can lead to unfortunate overflows and this particular way of
using it has been deprecated. Instead, it's preferred to use
'kmalloc_array' in cases where it might apply so an overflow check is
performed.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/delayed-inode.c | 4 ++--
 fs/btrfs/tree-log.c      | 9 +++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6adfe62cd0c4..81577a0c601f 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -738,8 +738,8 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		u32 *ins_sizes;
 		int i = 0;
 
-		ins_data = kmalloc(batch.nr * sizeof(u32) +
-				   batch.nr * sizeof(struct btrfs_key), GFP_NOFS);
+		ins_data = kmalloc_array(batch.nr,
+					 sizeof(u32) + sizeof(struct btrfs_key), GFP_NOFS);
 		if (!ins_data) {
 			ret = -ENOMEM;
 			goto out;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7d19a8c5b2a3..d6471cd33f7f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4062,8 +4062,7 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 		struct btrfs_key *ins_keys;
 		u32 *ins_sizes;
 
-		ins_data = kmalloc(count * sizeof(u32) +
-				   count * sizeof(struct btrfs_key), GFP_NOFS);
+		ins_data = kmalloc_array(count, sizeof(u32) + sizeof(struct btrfs_key), GFP_NOFS);
 		if (!ins_data)
 			return -ENOMEM;
 
@@ -4826,8 +4825,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 
 	src = src_path->nodes[0];
 
-	ins_data = kmalloc(nr * sizeof(struct btrfs_key) +
-			   nr * sizeof(u32), GFP_NOFS);
+	ins_data = kmalloc_array(nr, sizeof(struct btrfs_key) + sizeof(u32), GFP_NOFS);
 	if (!ins_data)
 		return -ENOMEM;
 
@@ -6532,8 +6530,7 @@ static int log_delayed_insertion_items(struct btrfs_trans_handle *trans,
 	if (!first)
 		return 0;
 
-	ins_data = kmalloc(max_batch_size * sizeof(u32) +
-			   max_batch_size * sizeof(struct btrfs_key), GFP_NOFS);
+	ins_data = kmalloc_array(max_batch_size, sizeof(u32) + sizeof(struct btrfs_key), GFP_NOFS);
 	if (!ins_data)
 		return -ENOMEM;
 	ins_sizes = (u32 *)ins_data;
-- 
2.51.0


