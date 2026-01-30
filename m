Return-Path: <linux-btrfs+bounces-21224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIkfOVn3e2nWJgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21224-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 01:12:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D88DB5D01
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 01:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26B8730137B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 00:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A013B58A;
	Fri, 30 Jan 2026 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="lN6sx0Tv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jltic62i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA23450F2
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769731918; cv=none; b=WpXMKOF/zHh1nk9aBcE/vnOR2RZrWzcXUk0P2huPlnUF5uL3rOl6sEpe0dRnGvZzekxgE7uiHNeRDCdLcPpDKFnS8NXyqWO2EEIPB6dVIbfnlPDAaSPjAdbfacvtFINnOR0DEjQPqPflqBAh2gts0mKn3ZN8OAYSOJJ/YxPmvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769731918; c=relaxed/simple;
	bh=Cry29UxfZTdOJDUIOd3L+ZRDKNvzFtLK0YySIZuCtw4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ygc/PD7MvzvvRBrZUS8AsoMEi9Fm20oTdfzJxElGzkaEztUmCbD44w425j3ryux5jXmrWUMF5VrEG34tMzfcpCDWp1BWC+D8bf1D63Hazz8czzgJPNFbU+iGZfqaOCpchaeFYL5I639p7jdgRICcmZB9WgjyKelY0r5I0g5Hkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=lN6sx0Tv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jltic62i; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C723A7A0064;
	Thu, 29 Jan 2026 19:11:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 29 Jan 2026 19:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1769731915; x=1769818315; bh=o9ly8q6kwLfyrMA/5+mVb
	7VwSWwKKit4Wd5wW075i+I=; b=lN6sx0TvTdFr4cHXthBhExixHm/BuOcdDgzi2
	XKH1astkQVzZrEPrZZx/AYlS0oMaBI2eknQ+EntyxPTsbG4GDs40GJ7wTg31ejKG
	snu88wiG4xrtnRZ3HXN3FVtn16bQ4ibqHGMYMv4YBAhHoVY8ibugPgti0zOs61yb
	fITKZNGh0lirs8kzXPucKp0kfOUzfxcPr0Q+qCJPhtzsjSJVJxP4TJGGvM1VjG1c
	KqGoAcsFsUP2WZ5tddOJG1Dk7Vs/9rwL1PR+B8MFxpp6OUH0pKfRK+/0jdzvDojR
	/6PZofEIqHGpwK8bO4Vi9+Wq/9mwelyGsUBVHfLnqlgx45D5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769731915; x=1769818315; bh=o9ly8q6kwLfyrMA/5+mVb7VwSWwKKit4Wd5
	wW075i+I=; b=Jltic62iGrNCv9Li6oKQnFAU4l3K1RyDXh6IlrVcrJodvK7TtQR
	AUZsbcPeNkjqMUHh0aew+wZz3RIDPgmHqJoZy1a/t7qZbawF+lIEP+4jFJnqWvH8
	q90ReD0SIC9Xk+LTDzLUnx6mOrk9J7IW0XuegD1TkC52icKGw6ozHIYjC9UIzI01
	rV59GSkZsvL29J2jzDJ290wWTbm6n/rKzANCs61FhauGp9de5y7sfFiNRSum4zIs
	Ja4gNJr2jQtoktFmagBJwFPJtYzTEMlEEWqiJDzzXGF6TxlqBwRSlAmpmZt7ih/m
	Sx8GZj2UI4Nq02Q9gpUfLGa+daJe+Ale3uQ==
X-ME-Sender: <xms:S_d7aQy2ipaXJxHuqyJsLv7JnffFD4kaGytkpUkciEAISh4s1SojFw>
    <xme:S_d7aaTqQcxvmPVFoP5c3ufFFgMFmtu6k9XSJnZ1Nr6W4ONgMYoFELt-IvC-dgBzs
    gGdNwTjCBmusshYqUk7vK7IaVhZlV_gDaGwv4yWv6wY5louK2Z2GAs>
X-ME-Received: <xmr:S_d7af81WewGfiaItpzI1Qa0z6DFmHVlUbl9X8y8qUeA6y1rNM1EUHX_Niv63B_1FmNCiwmMq-giZKgfEjW56orfiP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeen
    ucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduudetfe
    ekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:S_d7aZpgbdmYqcugaza0yt5mHSqfFPSLdYKXsC2hbGsiRLadglqKLQ>
    <xmx:S_d7aUn7Glyeq5UiwFkkiwO-j6NJreNbhM_HxtDpUKfvTe9Y3BbzhQ>
    <xmx:S_d7aYJ_JAgdMFWoLrwKFoVRXVCCFVwO01MW760vYFweq1YdqY13Ew>
    <xmx:S_d7aRzJhWV0bh-57OM5sie0ZnR-MZelIBRu6maeeySuM3m7_uPL9w>
    <xmx:S_d7aRWc5eK8uQ54Uw6gFyTNSghx4Wlby7jTeNSXz8fB1KgCcCUh9iA1>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 19:11:55 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 0/2] pending chunk allocation EEXIST fix
Date: Thu, 29 Jan 2026 16:11:20 -0800
Message-ID: <cover.1769731508.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-21224-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D88DB5D01
X-Rspamd-Action: no action

Fix a somewhat convoluted bug in chunk allocation with non consecutive
pending extents. Also, add unit tests covering the new search functions
and fix a build warning

Changelog:
v4:
- fold the build warning fix into the unit test patch
- clean up subtle and not-so-subtle coding style issues I missed in the
  AI generated test boilerplate.
v3:
- fix build warning when CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
v2:
- change the semantics of btrfs_find_hole_in_pending_extents to return
  the largest hole on failure. A different bug in the implementation of
  the incorrect v1 semantics was hiding this.
- add the unit tests
- add the build warning fix


Boris Burkov (2):
  btrfs: fix EEXIST abort due to non-consecutive gaps in chunk
    allocation
  btrfs: unit tests for pending extent walking functions

 fs/btrfs/Makefile                       |   3 +-
 fs/btrfs/tests/btrfs-tests.c            |   3 +
 fs/btrfs/tests/btrfs-tests.h            |   1 +
 fs/btrfs/tests/chunk-allocation-tests.c | 476 ++++++++++++++++++++++++
 fs/btrfs/volumes.c                      | 246 +++++++++---
 fs/btrfs/volumes.h                      |   6 +
 6 files changed, 673 insertions(+), 62 deletions(-)
 create mode 100644 fs/btrfs/tests/chunk-allocation-tests.c

-- 
2.52.0


