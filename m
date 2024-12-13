Return-Path: <linux-btrfs+bounces-10366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4229F19BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 00:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D779816607A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 23:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A101B0F2D;
	Fri, 13 Dec 2024 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="QU/ZLgSH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obYV1tRy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD272E62B
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131730; cv=none; b=nqbQkB4mXRKlvvZ0rdBks1cOd5Jyy6i6mdoOV9hR3pqOhjLfIt5sDhV4VSKOpX5pHxcDM7wvTeF9hfUnT6tdGDmVKZJA2Fyg6x0l7YMwiPZ5+0EAAfxINkd3jp1luAIK3S7ATweaWW+Rr2ReoZ2nQtEKnbT7he08pGs7khFvV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131730; c=relaxed/simple;
	bh=+xyEYLW/yBA9uoTmeojPU5ROc4IidobN1L5gjyjYmSA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jb8c5mfdtFxsfZRzYFHNL0+aknjlwxpVU91ihKZr9r0b2MaQX6Kugcudw1n8P+KlRhaOQkhYbV4POPceNGbnmjZPkTQ6ZcysNhut3ktHZvmo9O6SguRH5g6tq8rKVDh6RRkWlqAnGmM596D+F4VruejyjHHZPYao24B0d/uwfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=QU/ZLgSH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obYV1tRy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4765E114015D;
	Fri, 13 Dec 2024 18:15:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 18:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1734131726; x=1734218126; bh=WWC4ZK33Knbg+fiZGNz7y
	UL9VjecyfAs17K+/oFrfcY=; b=QU/ZLgSH3G+ekOwlsLafhYTYn8s+ZoU1SZsEf
	lUQuznoynRt+zAr8kR/y4dbgSfIhf2OmateSVeyevShNHw/gyGQvxxZf0WReKqf4
	aYff4lVOYuOmWcmnPsto1J/0YX7WJH8aMB9hMoan7668JDNwB8iQv6BRue6/bqP9
	n2wuJxpuiiZw3Bvamw7Qy7n7lHAGahB/39lbO0JnAVpnAENnFglNtIV+8Ryhaxn3
	7xdiGIOLJFQeeEbgUWNImMtMJ7UdILA4m1u+1m1ndIza+7I4/G1Xp26KhIpOsNIi
	KHGvvffveOuy+Y1QETqd+NU2T9Nabtf08YzTAnfDiAX982/0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734131726; x=1734218126; bh=WWC4ZK33Knbg+fiZGNz7yUL9VjecyfAs17K
	+/oFrfcY=; b=obYV1tRyW95APC/jcrMxvzdO7K5y7QWiXHjBoWLxeJ3arveYtuu
	ApD3o97OfRL4TRKtGioOIQ8IwHV7OHwm7U/KhsRxQYotyYjDjjrRJ08i4VJFtw3g
	pVsjULejLY03cy3lgt89D7mG+c9PNRRl1hynolksZFdSkKZjTtwdDtcW3tVZQJwM
	chzurq9MAZUrWf/Gx+cLWy+ONCaJM5uZ3pMsxiHCo/mK8+HN61oNGJW2+Yy+mGwd
	n5hymuZm5rO07lxTdwA0ieJ+lTFC0RJc1i5w9vcQXCdofqbu3W13HXWBKHsWsZV/
	JpVUeJ48gB+r0uwWQ6Ghlu78zgOUGhOawoA==
X-ME-Sender: <xms:DcBcZ-g4cnR_F7p6xtMHyQiDuFrw-5iqT7Nz32DbiOhCbhpAflS5CQ>
    <xme:DcBcZ_DGmCGwwYEthVUFZyCkcZ0uBkgvi-DrmiCst0Yooi_1kQ-6uEXp8g0b_oGop
    AQgCC2SNmvxm7ZeHoM>
X-ME-Received: <xmr:DcBcZ2GsaA2FmpaBHdVFiR6oBaGtwBrZyvsalAO8X8bqI3yzws_Zr4ZmE4oTAkXHz-sBRRQxzjdPccY3ayVEPl0wAK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeekgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkf
    foggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhr
    ihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelie
    efgfejjeeigeekudduteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhr
    fhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvg
    grmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:DcBcZ3T3vwzQ4S3nx_PCz61nWxbUY8SkLINjUcbiANkJFSj1_r8OXQ>
    <xmx:DcBcZ7xYQtleO-48sD5mhUYTxyjqvZpa3Zn-9tKf92GNFbL5hqJSlg>
    <xmx:DcBcZ15ML3N-kdjkFDi5o7Hec1XjAgc8jyn2l-N6K3dawc5_kwhDhg>
    <xmx:DcBcZ4yJBecosThwXTKFmnSVbBW7EzCVQnzuDUCwOqY4JTbC-LR8-w>
    <xmx:DsBcZ29BoYqC9kCjWRK2D0gzvXpWRbdrYMQFM1b8vAKx9l8URBW_iwvn>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 18:15:25 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] fixes for btrfs_read_folio races
Date: Fri, 13 Dec 2024 15:13:12 -0800
Message-ID: <cover.1734131353.git.boris@bur.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a common pattern of getting a folio (locked) checking if it is
uptodate, then reading it with btrfs_read_folio if it is not.

btrfs_read_folio returns the folio unlocked, so we immediately lock it
again with folio_lock. However, in the time that it is unlocked, a
different thread can modify folio->mapping (like set it NULL with
an invalidate) so we must also check that folio->mapping is still what
we expect after folio_lock. Most users of btrfs_read_folio do it
correctly (retry on mismatched folio->mapping), and this series tidies
up a couple that were doing it wrong.

Boris Burkov (2):
  btrfs: fix btrfs_read_folio race in relocation
  btrfs: fix btrfs_read_folio race in send

 fs/btrfs/relocation.c | 6 ++++++
 fs/btrfs/send.c       | 6 ++++++
 2 files changed, 12 insertions(+)

-- 
2.47.0


