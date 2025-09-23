Return-Path: <linux-btrfs+bounces-17112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDFB94E38
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 09:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC73AAE9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D67B3168E3;
	Tue, 23 Sep 2025 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="GND9dpg2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570462741C9;
	Tue, 23 Sep 2025 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614271; cv=none; b=nEC2PUjBtGq7QviucrNXQ5fBkID9Tqjd7e0EOB7V72X+S2hRL9GF9xgBOJUQaO0z8eBsc2bKgOZp+Yb/FLm6B1Ah/f+Y4Vr4OLDADtPinK2/CZBYU6h4BmI+/qthMV0VyuJzskqwJ0YLNdXeh00vzMTueTw8HTJt7Xu5x+JR3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614271; c=relaxed/simple;
	bh=KPoniv+5a1ulYJefPcMYTGUZRK0Uk84dJMrnhftqm7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rpK1n1XpLKbBseCBb5FCYbp8t6FFB/Afx8f9ef2LXvvWjVwuWJR6mrRrJEQdKLw1cNADKljtuTVIz576Hz0Rw9xed+2X/kexgFiGX+r8CiL7I3n3XSjn8FVWb6ddTggQSMDVESt44MOkA/7Vp6oucDMAqLPukJdl9MHl1QmcjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=GND9dpg2; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cWC5333J6zB0Q8;
	Tue, 23 Sep 2025 09:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758614263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uRD0hv7YadqcdMwRCIq0WRFSpK8kMoec7xf+m+yzcVA=;
	b=GND9dpg2ATz1eRjYhjrJ/I50km8sjkrUq5MtqCl57tWEziwTIAD5U2vv48OZIJgJzZr062
	KVETEbt4wn/1rlL1lCt1H7XIV0dUuYSWvd+BAVUhf+D8vU2KEgoZNAOsBvaTVXzKgs+EBi
	2qekcCY4x2X6aH/wrcvRe10Ahk9Uqt3bFcuVGds597EaKc5Y7xlnCbZnMmDticA/n78rhn
	TYD91Wpzkz9domKAKMFI0Rp2h1Ljt10QlK5xnkNu6zEJJD24opjxBpdnwRVfmP9lnJBvPc
	4uDXluTtP6niU4U0yNQSDORls8I5lyvwCxvBFUC9hETxWprmIec8zkoeqkC58w==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v2] btrfs: Remove open-coded arithmetic in kmalloc
Date: Tue, 23 Sep 2025 09:56:58 +0200
Message-ID: <20250923075658.180417-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an API cleanup in which the deprecated use of 'kmalloc' with
open-coded arithmetic is being removed in favor of 'kmalloc_array'. This
doesn't fix any overflow we are currently facing as all multipliers are
bounded small numbers derived from number of items in leaves/nodes, but
it's still a good idea to move away from deprecated uses of 'kmalloc'.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>

---

Changes in v2:
- Provide better wording since this is not fixing any current overflow
  issues.
- Drop commit introducing some new __free(kfree) uses in favor of a
  new patch set to be provided in the future which does a more
  systematic change.

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

