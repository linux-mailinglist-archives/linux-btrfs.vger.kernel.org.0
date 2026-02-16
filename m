Return-Path: <linux-btrfs+bounces-21691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH1wN2CIk2kI6QEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21691-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 22:13:04 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82258147A7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 22:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF4CC3032647
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77087331237;
	Mon, 16 Feb 2026 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="AXTFpfrl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34132F6573;
	Mon, 16 Feb 2026 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771276367; cv=none; b=LoD+gmpKoswyBHfM4lqLpZ/D2lNmW6QFCjpBinhI9X6+2HjoHDnMMQDC2GJwiN+ssRFS2245RKlOCc39WLlrs1MQZwEiUpsOEJ49OF9qEryOITAYHU09pHoko9t+hdkZcFjzD35/OktVWwLDGmlmnpO++rVJltU1ZR1aIqy8zSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771276367; c=relaxed/simple;
	bh=7tG2PXBobVkt2JMSl+jHZzRTbBgugqA4prBaGIwMipo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ekIuQrjD9S6fSfmPF7Y4P4Ii8kNel72F2tZSZeqlM8D1ZcbU65W2Jj1aeY8eWFqh44SzmUoV0AVRmK8BaoU3JDuYpkUVWb8SmdvL7bWNwfTwTavDw/wNsL0caR2PTvl2YslEgQPN5SfduUHiza2DXS9D604QPmdTOzWMYQ5S7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=AXTFpfrl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fFFpp5lZQz9tnG;
	Mon, 16 Feb 2026 22:12:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771276354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O6vK1YxVwMDywQ6L1Zar+t9XPV//4+D7IKbgnFs54Rg=;
	b=AXTFpfrlVGm2/ewjSqfbUYc8vOPj+15fmx2cTXy7lB0TFm5UtiexmlpycFP3wAf4Lv/t1T
	mKHQ8tXycjjVS/eLV9c5OfbN+LbA/OxTfL9rVE2SMJ5wB1q02nZX4zHIszuXLa3p5RlI4S
	Ammj3JeOfWd5bvzYoR3okdbJG8cnnwNIy8y+9gx3G9vka9znwD9c7GAwmWST5eDZQ9uR6u
	fvg8P9xffHXYNJzu/KX0C7zTwI/URQSS9ds6LH7utDoxSWkY4ejC31I+BEA7GnWHa60Bna
	cuqyMatDxEXTk+3gsKTgaolKG6uJ31SBLtixD5JsteoCZ0zCFAGi76pBBdrevg==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: dsterba@suse.com
Cc: clm@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH] btrfs: free pages on error on 'btrfs_uring_read_extent'
Date: Mon, 16 Feb 2026 22:12:15 +0100
Message-ID: <20260216211215.4149234-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.33 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.83)[subject];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21691-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82258147A7D
X-Rspamd-Action: no action

In this function the 'pages' object is never freed in the hopes that is
picked up by btrfs_uring_read_finished() whenever that executes in the
future. But that's just the happy path. Along the way previous
allocations might have gone wrong, or we might not get -EIOCBQUEUED from
btrfs_encoded_read_regular_fill_pages(). In all these cases, we go to a
cleanup section that frees all memory allocated by this function without
assuming any deferred execution, and this also needs to happen for the
'pages' allocation.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 38d93dae71ca..b3e8a8d9b19d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4651,7 +4651,7 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(iocb->ki_filp));
 	struct extent_io_tree *io_tree = &inode->io_tree;
-	struct page **pages;
+	struct page **pages = NULL;
 	struct btrfs_uring_priv *priv = NULL;
 	unsigned long nr_pages;
 	int ret;
@@ -4709,6 +4709,11 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 	btrfs_unlock_extent(io_tree, start, lockend, &cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	kfree(priv);
+	for (int i = 0; i < nr_pages; i++) {
+		if (pages[i])
+			__free_page(pages[i]);
+	}
+	kfree(pages);
 	return ret;
 }
 
-- 
2.53.0


