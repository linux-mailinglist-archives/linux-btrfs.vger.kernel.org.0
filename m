Return-Path: <linux-btrfs+bounces-10368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545E9F19BF
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 00:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1142C7A03C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736F1B85C9;
	Fri, 13 Dec 2024 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="c/OnLmcR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ylVxEUTX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D86193073
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131732; cv=none; b=Rq+7nz3WCubtzem74UaZ5YcMBV51r/7voNDOlpHj15PoifGcFPHofFjHskYsrf8EbpwInt4P25v7Ann+XkZEPBsYuk3nao8RCn8NXP449LnrmaAtWiHff12gjPgLeOwsUh9XHXKaiLF/PM8oy75tjUT4bfCOi58/aF9Sg56U6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131732; c=relaxed/simple;
	bh=Awh/xf/BjxugPsDblwlH/zn3h8Se5Xzw0Xc9gbG6Xxo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAp7jY6C+YA173BOawUNQZwx02u86Bm1E69Q5/irVS3h8/vXK12GH9hC7G4A6yNDkZJ2CXy8J659BY2ePWvf32VeqT9UcultiMiXgcoHoieihtpwDgUZRBDKRAoEexU9eCrgWd7IxCJSdX2XQ5LpZ6Bwe5Pjj3jel5y21zZgeNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=c/OnLmcR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ylVxEUTX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8BED1140154;
	Fri, 13 Dec 2024 18:15:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 13 Dec 2024 18:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734131729; x=
	1734218129; bh=XyrE1aVFJGzs9pH0NiVvoKUoqK9YcvBRiPwnLYrV8zI=; b=c
	/OnLmcR4452ajmqT7nNR+y3wVxXZA4R3M7HljoA38qmQlwd8uqip1sbkPnx6qvzz
	bS8NWu8iMYl+4s2R+F8pYjaAbMGnWhr8nZXpkiayh1UKknOF8Hi75Cz+z2JttmfN
	7U6a4reqOvuLgX8DXqf5EOFKAZMmhuH212iaceAJm7TPsNaSaxooDuM6V14HYD7k
	aiPIHGOga/uOIeSvMXWtUXvU828bQ2OCbEBj+gR574wNTG7ZhLljrZKhkOEKDPPL
	Eyl92isufXqfCcgFzE3NubRLhnvaHJ9ZI+W9Mqsx94C3RS4iE20FNWXZyQHzbodQ
	V6XfNWgHi+PauK5T+8UkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1734131729; x=1734218129; bh=XyrE1aVFJGzs9pH0NiVvoKUoqK9Y
	cvBRiPwnLYrV8zI=; b=ylVxEUTXt83YlR/QqIbyC5x89l1i3XV+s1NHy5ZGabjO
	vDIPb2eQByrv1uLNKnI4DW1IF/4uYCuPHn8b4GIRpK6IyLD0S9IStAWsLeMSByKw
	46sNZBgWZrIa9u061HsybeCQYKH1sGZfTjwMxKTMZoF0POm7xNL460M/7OSaXOt/
	a5Z5aw9yDojpdK0UroyipxY3fS1KddgmpIQD9XDQhShksqivzSgnzheXI3yfplpr
	JQraGn91poasdTyfjOK0gH5/SpY58walS4P1rJp0dEcWCh5aRmR2EnBVbFFmob3g
	1S7jHVexIpi85EapKzLpPYpl09W8pgYqALfzRt/Gxw==
X-ME-Sender: <xms:EcBcZ1Tyofp0oYZ6g6ergHXs4oXdEMSjtrdJU1G3NycATHsSdNQ2bA>
    <xme:EcBcZ-zBEbxPE4keCZh0oNYFyKjqiDwtCc-OJY0oVjfiRQElTJ7SA8GS1aOvTpKbz
    ODbd3poJs4E-sNVBis>
X-ME-Received: <xmr:EcBcZ63xuWyM08HGmymXkPeH_4zyyWTLNVn_PnWnqQMZXTzA-cXQSyoxLV0r0udqJtjIN5EEF0vmQ8rb40_8cckx43o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeekgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkf
    fojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegs
    ohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehie
    fgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgs
    thhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqd
    htvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:EcBcZ9DArHAawrGcXh3pPvXnTfCF4rcEdm85dJLwTqY_iS54xFdXyg>
    <xmx:EcBcZ-i8zIoKnojPuUfpd7pZ8yn7d4vd_Lrp1qU1GLlcWnS0g4wrog>
    <xmx:EcBcZxp7q-EMeeW3vUVcFDca9Vx4JV13FXIvWbmKKlSnXds2R0Rrsw>
    <xmx:EcBcZ5hXMqF7q8QtevCyh0gacZRGT-w-iLoqwsL47z2Op2dSvt18ZA>
    <xmx:EcBcZxt_CzDQrs-ITFq1hLHqQvNoUKHYbXcakzTY9vPQndk7kB0n-JbF>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 18:15:29 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: fix btrfs_read_folio race in send
Date: Fri, 13 Dec 2024 15:13:14 -0800
Message-ID: <e55d48ca1bd763a232f9eb1b2d57585dfd598065.1734131353.git.boris@bur.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734131353.git.boris@bur.io>
References: <cover.1734131353.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we call btrfs_read_folio we get an unlocked folio, so it is possible
for a different thread to concurrently modify folio->mapping. We must
check that this hasn't happened once we do have the lock.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/send.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c5a318feb8ae..f437138fefbc 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5280,6 +5280,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 		unsigned cur_len = min_t(unsigned, len,
 					 PAGE_SIZE - pg_offset);
 
+again:
 		folio = filemap_lock_folio(mapping, index);
 		if (IS_ERR(folio)) {
 			page_cache_sync_readahead(mapping,
@@ -5312,6 +5313,11 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 				ret = -EIO;
 				break;
 			}
+			if (folio->mapping != mapping) {
+				folio_unlock(folio);
+				folio_put(folio);
+				goto again;
+			}
 		}
 
 		memcpy_from_folio(sctx->send_buf + sctx->send_size, folio,
-- 
2.47.0


