Return-Path: <linux-btrfs+bounces-16264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4089B309FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 01:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F52D680166
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 23:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566882E88AE;
	Thu, 21 Aug 2025 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="URi5efgu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QA88Whhm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A22737E8;
	Thu, 21 Aug 2025 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755819224; cv=none; b=OGpHmtFXMRMb3/IvtQLi0XP/b6QAq+mYCghHRKj+A6pOAzjdWtZDMjui2MP9uZoY+O3hq71cA3qnYIcAqVmSZedVsScD4UW8ZtGLSB+GIqOCt9lN5CpeF3oNp+BnSMPZ34UiORvW/O1RWyfgfI/XtoUE74HJPeO4yHLKDC/NaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755819224; c=relaxed/simple;
	bh=H8X+9ZDIi6xeckXtvT7mZJKBEzSrehG2kS/3HYvtxgY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ku9ztsfhgxp1iRURQUJtLmnD1Us3n2U0cgqPPTTrrvSj2ux729TYBu16zSotRUqGKP8O/LvnxKtqjwVV18UY7CcVT9Z25Tf2lG6qUZ2ymzN7JG7HhIvX7TjOrUSBPv9sRhfOdHJfjDggSFuus3pa0QaxTIlTTwAoxCwvvTBQRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=URi5efgu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QA88Whhm; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D21687A0140;
	Thu, 21 Aug 2025 19:33:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 19:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755819220; x=
	1755905620; bh=HT0twJwnpdUjMd22R6+oRpDlpbYwB4dsyPbH9JVybIE=; b=U
	Ri5efguQiC55S5ZOBn2b86s2d9yIjb6qQoNCo+HLac2JkM042DjR0SwPJE12Z9Mb
	bI2W/R6JezQqj+qojwSr8Ng0V5zeXstuh1HFS/sHWlk77BkafuIZ5vVIkUGMq0ie
	cHW/+xcWttXX6EgibB+D3DKjU9MjjIMVH9ZUo0RvX1d5yULiyB+dX60vLsm0AWR1
	RMkQdNajSYQPv9yCQFnahnE4j8t7E2b7veCcZb4/ko7AsNAxT3YUL9oeZyWdnalK
	118cKOEP5t16efkWIe3rR5kV/jmUnZZUrv1+2WiPx+tlcAsZqgqzJ4r/UYU9Thfo
	y+N/raW6hPr/8Qr84sbtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755819220; x=1755905620; bh=HT0twJwnpdUjMd22R6+oRpDlpbYw
	B4dsyPbH9JVybIE=; b=QA88Whhmu+UXHIxA7dyMXzbLsiKaNHEt27a2ywY4kDYT
	lV8QEOADRyhul8wisEEQSYMcJn2i8EhtcrVdgFYpFl0a6kb9fBcLoKzyszRnlbsQ
	ihWlXuBxFd0xupucdFGAyzGdlUTTl3KjOEaylskwBXp89kTDgRkevQDVn4kgnVc5
	X55pRIdbHVb5265EB4TttqqyTUyZF9/yaAx+9k7SADw8exotZYetynI0t8zCywNd
	S4AliulmH1XRposmbP3eIilcKbbJV3d99nIG6An7cXwtdslPu0zbe2C5nXHe+jqd
	gXiLoAZgUSHwgIYhILYPlVA3ML8aT4batLofdgwUFw==
X-ME-Sender: <xms:1KynaI9r4xKXq7X__QQA6NTQw7nOQ8UL664rHlwA-n0rH9XcxjgMyA>
    <xme:1KynaHnBrPHJ2F54smlhTfRJ4csqFzrlC7a-OJrpuuZM10swUqRcms8vQ3Uh2SRn_
    xeI125pB7nCQnM-5wg>
X-ME-Received: <xmr:1KynaK-XfnDMzHYIZ3BSymtykt6du5Wxiuxm_1zUFR3NyEv5ZNR-9Jz8pWIWruX7mmLQ6ABUipwo4o0wiQKKKEJaojc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffvedvhe
    dtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:1KynaFnZVKcA6z1761O-jotvN6JchPQMXprNScV2EdRCK1WBcT-aAQ>
    <xmx:1KynaH1BoWmb6s10pMn714e3KNCM346HEzJAFkJ69IiWkradHw9LSA>
    <xmx:1KynaAo-pQ0Cu8SL_2vYW6Flwk5-k5CT_m3J9jQJRQjPcmpXpM_PjA>
    <xmx:1KynaEd0cPssUb0KkDS80QaXf4AKAY-6yWNy2XPbMKn3OT0NInFyRA>
    <xmx:1KynaHR_PLo3XvE1khv47K4ovKMZ7QWiHZW5tBo9oH-ki1O1rUjTRSpd>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 19:33:40 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs/301: test nested squota teardown
Date: Thu, 21 Aug 2025 16:35:41 -0700
Message-ID: <49ed1733eaa2fcc3a9ec3f6cd8544016253d6914.1755819214.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <af8736b1-e85a-4867-a884-194fe8f9abb5@gmx.com>
References: <af8736b1-e85a-4867-a884-194fe8f9abb5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nested squotas with snapshots is the most complicated case, so add some
extra checks to it. Specifically, ensure that full tear down of the
subvols and parent qgroups works properly.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/301 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 7f676001..4c0ba119 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -21,6 +21,8 @@ _require_no_compress
 
 _fixed_by_kernel_commit XXXXXXXXXXXX \
 	"btrfs: fix iteration bug in __qgroup_excl_accounting()"
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: fix squota _cmpr stats leak"
 
 subv=$SCRATCH_MNT/subv
 nested=$SCRATCH_MNT/subv/nested
@@ -393,6 +395,13 @@ nested_accounting()
 	check_qgroup_usage 2/100 $(($subv_usage + $nested_usage))
 	do_enospc_falloc $nested/large_falloc 2G
 	do_enospc_write $nested/large 2G
+	# ensure we can tear everything down in the nested scenario
+	$BTRFS_UTIL_PROG qgroup limit none 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG subvolume delete $nested >> $seqres.full
+	$BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
+	trigger_cleaner
+	$BTRFS_UTIL_PROG qgroup destroy 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup destroy 2/100 $SCRATCH_MNT
 	_scratch_unmount
 }
 
-- 
2.50.1


