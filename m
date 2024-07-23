Return-Path: <linux-btrfs+bounces-6667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC693A988
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 00:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609A9284377
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 22:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4AF1494B1;
	Tue, 23 Jul 2024 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WEGYRaQo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWLKLPED"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517ED14600B
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775442; cv=none; b=HzOzg8mXBGlROTEIXKisQ+WVnlx9z37GCH63mheA3zNlhOu4MYq82BSxghF3rqcTS51osiPyoDHAFx7jfv6dWY285GlOOtRygsBDf3/nCUTliBTSSANgzAICFgBw8d+Rgv0iRfiEy6PIccruTOZL/JIAZVK7XJgyhQbrMF/9IvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775442; c=relaxed/simple;
	bh=CGDi6SzruJlHyWbqAtwWb8ySDgNI/OFPRuclKtGO7lQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twmIzsqX7NWIEwVJu6gFBFlC5dCWtJB1lunNxFxtlcatSJf3EWYCYkG/X1qHPelVa2f7KEUjYZBjReWqe2nx/Y/UG5JBbL4MUTWpstiqjdUFOuFDP2EHc4Il3tV7fDwmRGiX8gPZc/8YDZCKXsjv9oceMLCovrKBgnEYEmhiysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WEGYRaQo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWLKLPED; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5BF581140140;
	Tue, 23 Jul 2024 18:57:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 23 Jul 2024 18:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1721775439; x=
	1721861839; bh=Hac/x86uqpcAeNjze03RMZOgc60kVxy74eJqwUWT+68=; b=W
	EGYRaQoDaWV1oZ5I7hsHUJttBlLsV4s4KadtpU9NYlFMcHng2+HQQbumy/HFR+ZH
	dEcVb/iylm/WdRxCqjbSEp+gSTZvm8e2EcVfMi99h6szWILTd8YulVCMqcMgGuV6
	fjg9yuHJDUF1RtjzjX2fZ0tt4ybfU3h/VooONiPxeuhASQ8GL1HWLZuyfwzjw59C
	B5gQQl0G2xcW/vYBhzQALwApCcYjzIR5d5+1Y9vB95JnCYQDwqen6Nr8rldxFJMY
	v57g45QabO1yMk0hbvsJyjKJiinosz3bMIWB76Qt0g24CIYLQfUWHUw9Z/1faFDx
	bHS63/qigAC8mtq+OoZpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1721775439; x=1721861839; bh=Hac/x86uqpcAe
	Njze03RMZOgc60kVxy74eJqwUWT+68=; b=eWLKLPEDOk0lRp6MwHPDrvGUln4K7
	KdKhgBWUC1oUUsOpshJ8hxLpAFPWzo3stnIMJqfifHe8axpeP8t9nkgVXDSfQQjI
	k/IO/EuajLCvddRagyfa6lyr1trhyag1Ecl1kZnC4UbSatqKDF1z7Trl8lwq1z9g
	CDD6tYuShHakZAt4vhZveRYUA/BJ+rt7YBTTadpM183ETrDlMiNQyNLLv+SQablt
	7NIVcHFX6bsopEOU9ofwlDij0RXzjVWVktaXOKf7EOhs4ZLrnczJ5qGi+ze2aZMp
	AB4Ghec/OGCjqhqfFG4cbMI2Lxy4WQW8sgprcTPFC4LYsenFlbcgO7fZg==
X-ME-Sender: <xms:TzWgZrQOYAXJxpX55sYrvQooTU7IT0XTiL7xT5WsRAvyKB2Qrcnong>
    <xme:TzWgZswWAoV8KxeAbxrevl7cNudTLldW4gkW-BjsoVqItEvh8RslO--AWhmSgxEOy
    74KO_-zb-rNsXO5ps4>
X-ME-Received: <xmr:TzWgZg1Vz2UKXOrFHXZZrU4NVKVi4tI9P0ujPSL-LZu6fURzo57R386kA3JEd4plL03JGT8ydj9JQCBPpXkguVJN4kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:TzWgZrBQkJL0hCa3qr-jzrvF-ooJo0-RJuYbcp69-TptXdJfas1yRw>
    <xmx:TzWgZkg_dE6hyU-U95N9tjlqZwZ1XaxFiFFeya2IBEOQuoE0uZphFQ>
    <xmx:TzWgZvo9oB9SAiGhlvSNF6WOtjvDv6Feh2yzUUtbvA5Hy03JRx46lQ>
    <xmx:TzWgZviQ_s809Veby-JtL3iqforA93B8ikMAXMDdHsxBRal1f-oejg>
    <xmx:TzWgZnvtfOqEc-3gXUf5N-v8Nke5c2bcNiASxJPmN4Up592oA1Wt2LtC>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 18:57:18 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: implement launder_folio for clearing dirty page rsv
Date: Tue, 23 Jul 2024 15:55:56 -0700
Message-ID: <070b1d025ef6eb292638bb97683cd5c35ffe42eb.1721775142.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721775142.git.boris@bur.io>
References: <cover.1721775142.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the buffered write path, dirty pages can be said to "own" the qgroup
reservation until they create an ordered_extent. It is possible for
there to be outstanding dirty pages when a transaction is aborted, in
which case there is no cancellation path for freeing this reservation
and it is leaked.

We do already walk the list of outstanding delalloc inodes in
btrfs_destroy_delalloc_inodes and call invalidate_inode_pages2 on them.

This does *not* call btrfs_invalidate_folio, as one might guess, but
rather calls launder_folio and release_folio. Since this is a
reservation associated with dirty pages only, rather than something
associated with the private bit (ordered_extent is cancelled separately
already in the cleanup txn path), implementing this release should be
done via launder_folio.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f38eefc8acd..c5155981f99a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7198,6 +7198,11 @@ static void wait_subpage_spinlock(struct page *page)
 	spin_unlock_irq(&subpage->lock);
 }
 
+static int btrfs_launder_folio(struct folio *folio)
+{
+	return btrfs_qgroup_free_data(folio_to_inode(folio), NULL, folio_pos(folio), PAGE_SIZE, NULL);
+}
+
 static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	if (try_release_extent_mapping(&folio->page, gfp_flags)) {
@@ -10133,6 +10138,7 @@ static const struct address_space_operations btrfs_aops = {
 	.writepages	= btrfs_writepages,
 	.readahead	= btrfs_readahead,
 	.invalidate_folio = btrfs_invalidate_folio,
+	.launder_folio	= btrfs_launder_folio,
 	.release_folio	= btrfs_release_folio,
 	.migrate_folio	= btrfs_migrate_folio,
 	.dirty_folio	= filemap_dirty_folio,
-- 
2.45.2


