Return-Path: <linux-btrfs+bounces-17817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43AEBDCD2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 09:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D7E480913
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 07:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7762FE577;
	Wed, 15 Oct 2025 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QXs9nBaE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1FA29BDBC
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512011; cv=none; b=WYw+K1EWhM2oLztP4jRXGCY8jGhJWMw2bkkBOsQ06u8YPatq9u6MJkMnMKHqv8TdXc8HTrM3Saq2/IICSA972FpBCbwtuN9dhDDx0DiQMc+YdmZRdZh7sztDOPk/0T2feezC9h9POfzhJjBJJ/ugTb3/akRgcXz/Np7zB3djbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512011; c=relaxed/simple;
	bh=r+ASaLYnzb6vdNs9o7EUK0CxbPKP+y1bfaTk/hFsiXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OqvNCTS4VhAFTPmoREbtMPJ6h9pCqzd94p4i3gZT5w0WPkgw7v37chuzJQnxaeUuQxvrCNDGUkZtg+OmttgcsK05o3gM3dJNPJvW80c17kHh1w6GrsldKLOQ6ReKrCNOy3bXDQOO8ROP0HjsKR5nV7LGTxZZWd6T8NwDa7vzdFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QXs9nBaE; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760512005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4oeT7jWw33U51/Lw09GmgWWjKvWcplVzI0vfcZAieAY=;
	b=QXs9nBaEJEe/yX0Ztw0NgPQQpAH1fw7+854TBEwqpyhxIQahlTelWFtLaauSgUdkh/b38u
	woCmBOmfydBkk6ESFRZR+tQBOHZnjxHfqOJsBIzMhw1n+8QLhubKKeCsgQUIYKrC3IbcLt
	0Cs7HMRF5Cima19boTrVs8WaSlPGIJk=
From: xuanqiang.luo@linux.dev
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v1] btrfs: remove redundant refcount check in btrfs_put_transaction()
Date: Wed, 15 Oct 2025 15:05:21 +0800
Message-Id: <20251015070521.620364-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Eric Dumazet removed the redundant refcount check for sk_refcnt, I noticed
a similar issue in btrfs_put_transaction().

refcount_dec_and_test() already checks for a zero refcount and complains,
making the preceding WARN_ON redundant.

Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 fs/btrfs/transaction.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 89ae0c7a610a..485bef0ba419 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -138,7 +138,6 @@ static const unsigned int btrfs_blocked_trans_types[TRANS_STATE_MAX] = {
 
 void btrfs_put_transaction(struct btrfs_transaction *transaction)
 {
-	WARN_ON(refcount_read(&transaction->use_count) == 0);
 	if (refcount_dec_and_test(&transaction->use_count)) {
 		BUG_ON(!list_empty(&transaction->list));
 		WARN_ON(!xa_empty(&transaction->delayed_refs.head_refs));
-- 
2.25.1


