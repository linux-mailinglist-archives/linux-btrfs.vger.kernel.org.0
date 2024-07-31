Return-Path: <linux-btrfs+bounces-6928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C41943779
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 23:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5666F284635
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 21:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190394E1B3;
	Wed, 31 Jul 2024 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="SkgPyJ+r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvdSIeqO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62E14F123
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459677; cv=none; b=oaGSk7KY0zxCe7remrylewy+/wFHywTXoC3DefpLRmidkm+ZOQ0PsE35tDjkiJbLyxyG5qOy5RXfleaoOQAZcNc7nabQ4X+IRDhRN2EDAdzKYtmk+6K2pbkmbeRRPvw850B3wr+0HtUizVR2ZHB26plld8kJi0pvyEAnQUx0GzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459677; c=relaxed/simple;
	bh=oXVUFlVfVi1wou6Dt+QEIckslpmg+H9C7eHA5OEvUV8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ko6GOyiVKKghkQMWdaa9eE5aW6MCBaWNR+Y7CVgJeCHoIoSL5aS6gnCWWIxE+VN4naCXMTaC63FLJW37FlBRzVcvrlMgAJyO/QyqMIRx0BFzRK9ttb+U0/EdHJ46udBWip5GRyIrClMvskYTPa6uCkzgH3X9JYO6Y/w2u6UvSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=SkgPyJ+r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvdSIeqO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id A4ED2138365E;
	Wed, 31 Jul 2024 17:01:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 31 Jul 2024 17:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1722459673; x=1722546073; bh=cuOFmUlYjnjcYPLvNJ7iX
	yzUaFU3olJneomGc1Jdzxk=; b=SkgPyJ+rKGd/nrMalsGnZX5X2o2wK9IPNtxat
	uHweW3rNNFFfB/hOtasqVUm2tom8xSBq5/8m5fJESVWRflu5t/WcxH/fTpo+sqUl
	q/3XcAAeXL0xujP7HJWiUkhA9zOWbzKA/2r+J6w8YQomFh7U4y1mKvMB65ZUQiD0
	K09gtGy05PnXneDgA+4iUq+3jXUK6AUJ0VftIjChwEnOdTf3sgIcsolnTLjPShQL
	ilezdr8mjeo1aLweM555L/4euG+7sQpfC8cc0ECXhVdbsYf+tays2H+5itLWVXq3
	Zm6MjA/wLN+OXJGGWxMCwn7ktY3Pt5sD3KsXF5mGlzHjrRwzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722459673; x=1722546073; bh=cuOFmUlYjnjcYPLvNJ7iXyzUaFU3
	olJneomGc1Jdzxk=; b=VvdSIeqOSLaVRzOEW4cGgtlCexiF48w5rUkYuJfLOUCc
	meGeIUz5DSp1pBn8l/tpIotiY77L056l73saEnwmqHom7h2L1LVY5V3yTL0KbZbO
	jb3UkBiv9BovOMU5jFWJBOHkW1H2pMW27T/HrWUwoB07HhTD/TeNBPwfF4sxslCN
	KMWB1Lj2qPJy2WIpt808OKoO9vPEwrcMFVOpKwmyU4mtMU6RkKrbv2msMDfDXnEt
	VIhura1QzRtI2OnTOgK5DkasdU+Chgc19Rvm5wXg/L3Nqp6g1o9SFF7pRn34ZDFS
	igJCmrYHr8I1EXn5DQ0FMWhhPQr1Hh6yOo3c8e8oRg==
X-ME-Sender: <xms:GaaqZk0qm27kz0W9CoL-YDLMQIWMSrMiJKxZU1wpNYXFYHWdp0uqVQ>
    <xme:GaaqZvFMBI3sSPdyZ-2boR7Xqd6o_4rM0FyM30P_g-qi1cmkB-ABLXFhSyVIEoDVs
    Xmyv87CSAzrKz2xrgY>
X-ME-Received: <xmr:GaaqZs6ggcv3j4dS3qkI-poTtmH4d_49KgV17a8Pc79MKOYeB1L9PuPCsi1fS7-4tr7zitfDLuvtFelWVy1vjxP-H70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:GaaqZt33dUM5UEMgTQ3rgLLqs-S_sVaW5KGzUnQEQS7fOPgZpR9Kdw>
    <xmx:GaaqZnHb6hdd-YvodQDeu8ne-5qY5vJRS5gMDHZD_Je4zvdxBLNY3g>
    <xmx:GaaqZm-ROftzJxWr1bnsmZrGzjGRcLHMqEtJ8GnaUwKgjaNlIXiRsw>
    <xmx:GaaqZsk3Hnf7UXVU3PPxKfVRKgbaBEV-HII3hHUgSHEdnBns6AQ18Q>
    <xmx:GaaqZsSFsZa7I9hUJdgn1XKoqVVCIRXw7jXUZFDOkGM6V50qDphp0ZcG>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 17:01:13 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: locking comment for cow_file_range_inline
Date: Wed, 31 Jul 2024 13:59:40 -0700
Message-ID: <38338e851f80eb505894092dcd898de19ce720bd.1722459563.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a comment to document the complicated locked_page unlock logic in
cow_file_range_inline. The specifically tricky part is that a caller
just up the stack converts ret == 0 to ret == 1 and then another
caller far up the callstack handles ret == 1 as a success, AND returns
without cleanup in that case, both of which "feel" unnatural and led to
the original bug.

Try to document that somewhat specific callstack logic here to explain
the weird un-setting of locked_folio on success.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ed95040f4bb6..07858d63378f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -744,6 +744,20 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode,
 		return ret;
 	}
 
+	/*
+	 * In the successful case (ret == 0 here), cow_file_range will return 1.
+	 *
+	 * Quite a bit further up the callstack in __extent_writepage, ret == 1
+	 * is treated as a short circuited success and does not unlock the folio,
+	 * so we must do it here.
+	 *
+	 * In the failure case, the locked_folio does get unlocked by
+	 * btrfs_folio_end_all_writers, which asserts that it is still locked
+	 * at that point, so we must *not* unlock it here.
+	 *
+	 * The other two callsites in compress_file_range do not have a
+	 * locked_folio, so they are not relevant to this logic.
+	 */
 	if (ret == 0)
 		locked_folio = NULL;
 
-- 
2.45.2


