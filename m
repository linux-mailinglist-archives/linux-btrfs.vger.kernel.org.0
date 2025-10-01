Return-Path: <linux-btrfs+bounces-17314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54661BB14C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 18:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C843C2A68
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E672125D536;
	Wed,  1 Oct 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ZyDWFpjC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KZd7Ye1x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37D1373
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337464; cv=none; b=Q99427EaLRBtsm7ECrgVci5O0iU70nr3+j9FfeAAEaEtkK5iP41ZJl8/rXMxZ4GGr64TjF5DqqoL7qMTCAwVmac6CrCtRek5Ncj8uoEqB/AoTsaQkxVrfgoyZkY+DGb2ND9kPe7TSPvPAGk4n0N1mdcdvCaDXNCrTi22SiJFwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337464; c=relaxed/simple;
	bh=22r6IURIJMxWPfcK8w2UoKRLvKintc3V6MY+v9RBbVM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d+8rNBMje7e2GXC7GmgVrfhQSzJbskMLOhTNqlJNK88zcFpMu0XyO7QxHsqetzmnulpkRUwrh6T16UZGAuML8t/6FsfVogtVdtToXPEHaOIJgd+CKVZfjnkUtY1yoCbYxXoDTBH3wXAWIw9r2ghphkzJzFCJqtgA92jOLIxcDc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ZyDWFpjC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KZd7Ye1x; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D24CCEC0108;
	Wed,  1 Oct 2025 12:50:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 01 Oct 2025 12:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1759337459; x=1759423859; bh=36C9XdKAutJlqVtgwOER4
	RQou7dScH/lHI/uYw4lAKM=; b=ZyDWFpjC4nUJ/RspXZ/bphH+kKnL8vrS2zZvT
	i1lIWaoqE1nVb+WaNn+iRl4wAowwcnNeTjzNCazoqa+dutIODO8gux8A3lcWBw4i
	PcKaHgD0oryR5B7Imargoh9PDFScFUPeNJPQbQYYxNRgLvkSq4CPoyoUanEMWFVf
	9jHHGt9eZk95GwqRZ54UcWnTB/WXfi2vwdegYXSMKVEL/KSelpMzXTdJ2YszhPnp
	20yrDSZtO8XtSfbFF33c/W0FI/EEVjGeSzbhye8zh12Kcj2p1CTNKuw2AOXLvINh
	7c5RYJeTHw/nHjC3f4J2XywyNmwTrHEvq2WKmr13b0mri+aiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759337459; x=1759423859; bh=36C9XdKAutJlqVtgwOER4RQou7dScH/lHI/
	uYw4lAKM=; b=KZd7Ye1xtzPVdKMNLVZsnYe1s/RwdhWhA2dKFKlhEdDUWhUT5/B
	5EyVDZeyAmDgnb+IEoLrjQrn31zKRXXwRp1jlSpLdal0GQximcSAYAeWbk31Huaj
	Egy3fBeo5cnHHeoL7ug8oqXz5zXUuOkWsYLW3RhHGZmrH3AVz3A9XY55pw0vtIT/
	FGauottMUCBVvXTcwjG8CmAymw3TppKfzQb0vWNhjeeVx+B+yd307KmRuj5enfIT
	8FhuyK9G2XwbNsVGlAahmwct02s8zrbIPBo59gIVRrzDQIg6vQQOWUn6wJct38wM
	53gPy2JeGEDPqKcjSuAe+hzDqAr/tBI9q1Q==
X-ME-Sender: <xms:81vdaI3dvkXibqbGxhhukH9GoWJI7_IYrWuUHd4zh5Vm-VP3x1VKNA>
    <xme:81vdaJGi4Inu319io9qxLTS_Gkb4FS9NDhpdbCL2G70sqdzQMQlwxGY8hpizn6O29
    hp4gbpsY1leDDS7L9zdrIE8lKhq3hxv1NzoWGkyuj7TVohNHhBMWkE>
X-ME-Received: <xmr:81vdaOhzqFbslbKP5b4095DdZGXJCGvPG-xPkUj2OGUgYzDt6HXyMq-_vNzvVBcYrQkTbR31b88o3mle-J49AVUJJPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepjeejgfffleffteeitddvueeuleelleegfeetveegveetffdute
    duuddugeelgfehnecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhi
    nhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvg
    hrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:81vdaM8Slm9IhMcS5MPYQDIKRW6qPzdo-fpVmkmJZ1k6kC_VFpgZ-Q>
    <xmx:81vdaNp5ZhouitNm3rGLL7f0IKpcvwgZdzEFss6QYyqIWbsAPu9bng>
    <xmx:81vdaD-pq00q84XljObEOqJFETV17Z9zczaQ29uV-8iMN8E-LP8bjA>
    <xmx:81vdaJVczs8qEaL5hyFYIZ3pQk0Sst1FSPgJTNTwSclVLItVlmVBvA>
    <xmx:81vdaCa3EENYF9d4P_2zgV4fuXxoCqDaKSIJJqbOKev7UKJ0DaVwMB0Y>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 12:50:58 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix incorrect readahead expansion length
Date: Wed,  1 Oct 2025 09:50:42 -0700
Message-ID: <763f1e5a6d9611638977e24aeead5c9a266da678.1759337413.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent of btrfs_readahead_expand() was to expand to the length of
the current compressed extent being read. However, "ram_bytes" is *not*
that, in the case where a single physical compressed extent is used for
multiple file extents.

Consider this case with a large compressed extent C and then later two
non-compressed extents N1 and N2 written over C, leaving C1 and C2
pointing to offset/len pairs of C:
[               C                 ]
[ N1 ][     C1     ][ N2 ][   C2  ]

In such a case, ram_bytes for both C1 and C2 is the full uncompressed
length of C. So starting readahead in C1 will expand the readahead past
the end of C1, past N2, and into C2. This will then expand readahead
again, to C2_start + ram_bytes, way past EOF. First of all, this is
totally undesirable, we don't want to read the whole file in arbitrary
chunks of the large underlying extent if it happens to exist. Secondly,
it results in zeroing the range past the end of C2 up to ram_bytes. This
is particularly unpleasant with fs-verity as it can zero and set
uptodate pages in the verity virtual space past EOF. This incorrect
readahead behavior can lead to verity verification errors, if we iterate
in a way that happens to do the wrong readahead.

Fix this by using em->len for readahead expansion, not em->ram_bytes,
resulting in the expected behavior of stopping readahead at the extent
boundary.

Reported-by: Max Chernoff <git@maxchernoff.ca>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2399898
Fixes: 9e9ff875e417 ("btrfs: use readahead_expand() on compressed extents")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dfda8f6da194..3a8681566fc5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -972,7 +972,7 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
 {
 	const u64 ra_pos = readahead_pos(ractl);
 	const u64 ra_end = ra_pos + readahead_length(ractl);
-	const u64 em_end = em->start + em->ram_bytes;
+	const u64 em_end = em->start + em->len;
 
 	/* No expansion for holes and inline extents. */
 	if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
-- 
2.50.1


