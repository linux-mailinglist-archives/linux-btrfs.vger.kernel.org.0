Return-Path: <linux-btrfs+bounces-20983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FFryECU9dWmbCgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20983-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 22:44:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 923837F155
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 22:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A40743002321
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 21:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562C27CB04;
	Sat, 24 Jan 2026 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="HH5+rlz5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QUKh+r+H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B41D5174
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Jan 2026 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769291041; cv=none; b=tfWuLr2skj9lvbFjmIqDOliFQU6rSKyQQlTZ+lq5LmIgOo+tCxo2klvF+iYFGbusgM9gYIfZj56qG+77MuSYgsgkGQ/X2KKv5kCZavafFMVkr4OnYfd5GXQBDfciM0Al299z3sBJ4wJnETnXlVYQS1uIjd9tvRiNdIwlCaIwcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769291041; c=relaxed/simple;
	bh=8FFi1OhGf4fQEPvDcmGOIpBVC9e9r7lSfkE/PMxRVp0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z9n2hDGB3h+MO5wYtCHSPhhDEup2QxSmdNo6MNfGElEV1BUyUsXoKoowXpnV1HLXNeFrV6B6yymJavHfa6nzTH2aKmYpx3NwXWeHDyi8oglKYcOcaZg/wDfBdrBCmiETvrLywY5fUxgQpKcmSSmHcMS2M38DI2tnIvxP1tY7AN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=HH5+rlz5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QUKh+r+H; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C4F5BEC00A7;
	Sat, 24 Jan 2026 16:43:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 24 Jan 2026 16:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1769291038; x=1769377438; bh=btSlU+EqIr
	VZXvNs6Y3lq73kCcXqpZ40i8LCHbr4Xnw=; b=HH5+rlz5+IFbRdZSXEtN3DY4ru
	dEQpYkHQ3akp9cp4F3va97ATYRW2k6y8lQDswS5K/cOwwtFneLe09WCTP5XWaUJX
	NLFehSo5ebDEKQjxNgZw0/+IhfbpcVg6D5aIsLXMOH+7lQCJh2PX0JkIMPLixvRP
	Fkjpya6VkoZ/kQTKFjIsD2lFYsvDza0rFjP5mtIcujcZdeuE/IJNjftYXAWWg8Ur
	1jcR9rh3MlbVYiL6XGACACx2oGKEuOGJRo4dOZcng5BuPXvDA/XeuxkhX31CNAeT
	uYxbqg8LnnDPKIyV/OdpTaYB9Wo4WOwFMYk8rbXdptMn22lpRLBAQIidU11w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769291038; x=1769377438; bh=btSlU+EqIrVZXvNs6Y3lq73kCcXqpZ40i8L
	CHbr4Xnw=; b=QUKh+r+HJ2dj1ysn6rEpboVbQNb1Cd/bQ2US9u72renK+7UCjei
	Bw1KtMGZZp21MvC32h+vVN7XhfgZEh5TVKdiQPwaIC+VJHY8zV0PMrnB32kEFXBR
	Ir0V56MQRxUmhCdIcTxnzOdYzq5ln1rwQQs/CKwtpX4eiIkFNr49y2viZT65zm8z
	8HPVJyhMRghG2rZHcERToZAPIXKIooWN+hlHNwHxDBUaU4K8PFgS4mtD3jFuJvL/
	1RrqB6Hop4jK7JLcKQvVA8m+ixhRflunVaW1JzoWFBP+QjJLlkni5Rngie+YhlX3
	tAdMB1RddL2bVTM0ati6Cxu/KhuyoHYCFbw==
X-ME-Sender: <xms:Hj11abOES5qwXZEfNEX2dmevqzeZeuUjzjVsHBm0xjKeNrr5bISdBA>
    <xme:Hj11ab_x9_Jy6OhZjmJrjzqlYZ_oIRwauwOsvYmfCb5RVhKA5FW5VHKM7Csf67JVE
    BsYd46sc0hMyccFjOpRrnDmLsRpiPoR2fOrCFs2lqIGDCjJHgi6NkI>
X-ME-Received: <xmr:Hj11aX5-IOk79iFSbdT7SOPrPKMo2Tr4D5hoEs8aaAN_LH-rZlRhlhuyXBXzt4053YQpErsLNrImOR0AcZX91-WlMBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheeftdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertdertd
    ejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnheptdfgkeeufeehvdetvdekuddvudffvdegveeifedtvdekhf
    ehkeevleekleeuvefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:Hj11aa1YfXyiu4iTeUYTYj6-IMzg-UB1vRYx8LshPromOOtWqIFoLw>
    <xmx:Hj11aWCtTE70959PBIPA3W9BPVkBF-xKL3xJsoNQi0_1hfWkg5826A>
    <xmx:Hj11aU39gewmnPG8qHaoxVpvh-om2uBLROjrBV_AbttWhcmOgwZSKA>
    <xmx:Hj11aYu6fKF3MQ_tjAOKECEAQQFSe2WhRI0WrRxh1HS0Az-nIpQbrw>
    <xmx:Hj11aawlJdUY9-J6EGo78LCZho7QoaHd9Fee2DHy5K111CfkQ90AdN-F>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jan 2026 16:43:58 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/3] pending chunk allocation EEXIST fix
Date: Sat, 24 Jan 2026 13:43:32 -0800
Message-ID: <cover.1769290938.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[bur.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-20983-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bur.io:mid,bur.io:dkim]
X-Rspamd-Queue-Id: 923837F155
X-Rspamd-Action: no action

Fix a somewhat convoluted bug in chunk allocation with non consecutive
pending extents. Also, add unit tests covering the new search functions
and fix a build warning

Changelog:
v2:
- change the semantics of btrfs_find_hole_in_pending_extents to return
  the largest hole on failure. A different bug in the implementation of
  the incorrect v1 semantics was hiding this.
- add the unit tests
- add the build warning fix

Boris Burkov (3):
  btrfs: fix EEXIST abort due to non-consecutive gaps in chunk
    allocation
  btrfs: unit tests for pending extent walking functions
  btrfs: forward declare btrfs_fs_info in volumes.h

 fs/btrfs/Makefile                       |   3 +-
 fs/btrfs/tests/btrfs-tests.c            |   3 +
 fs/btrfs/tests/btrfs-tests.h            |   1 +
 fs/btrfs/tests/chunk-allocation-tests.c | 481 ++++++++++++++++++++++++
 fs/btrfs/volumes.c                      | 246 +++++++++---
 fs/btrfs/volumes.h                      |   5 +
 6 files changed, 677 insertions(+), 62 deletions(-)
 create mode 100644 fs/btrfs/tests/chunk-allocation-tests.c

-- 
2.52.0


