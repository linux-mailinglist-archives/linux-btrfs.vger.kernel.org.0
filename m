Return-Path: <linux-btrfs+bounces-2957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F586D828
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 01:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27ED61F2338D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B1629;
	Fri,  1 Mar 2024 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="m36Ly5wb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hxvEaWys"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC12622
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251839; cv=none; b=h/3Xney8N6l32pkcGpRXrYZ4KGzuYxOwVNMfFD/tnhwGzGZRrjFIx3YOTXmJJVpYe1gFrtGJHtPzXXeALtt+WzUz3YMw1vVJijHWrcgknryWg4jTscVC+D3pZ3A2WpwfAAJHRJQbZ/zSn7bQAAJYPQHvMiWuzTYF5tskhtCLUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251839; c=relaxed/simple;
	bh=SZv2MbfGVgUen7s6CfCKC27iAGOj8cXEwWGWlUBvOcY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s/vFudkCSV15TbXpBd90Dqw7qerxw9qfWGowQq74B0kEpzpsVcWryk3MoxdhVLNALMO0Qi9CGVUQe4KdAPF5AGlDltmcaQ1DgznWVTAKKm+lv5CNhvmfyo4U7uTuXiG39ENsedkfAk5MNFaV7qiUQUwhzApKwQL46RajuzcB9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=m36Ly5wb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hxvEaWys; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id C69EF3200C0E;
	Thu, 29 Feb 2024 19:10:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 29 Feb 2024 19:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1709251835; x=1709338235; bh=MsRW//exr/cXPzror6xdM
	+8y2lzKw4t8d8C1gP0uPRY=; b=m36Ly5wbC6c+duMxSxn4T7isD75sozHCYPGMu
	v6omlYODXGFw3yTp4Zcaq1ooSeSnl9Aa/zCLWU/x7htBr9+ro0zxcESHgEnjuOhK
	SO3wCVMcXBYQ6iJkNa4+lLji2Jsctlef1Jmde2ksErXSPyLbrQPniu73o36tQcua
	EJZ2XTThXFUwkt/GkdbWZvA8i1ZNY3XFeHJcRVvB9Tn7afZWO148i1xhK76KjbBQ
	5NJ/fyk3NHiCpDuSUqT+Ryf+RpuH96l3QkrtE3cCWds4fp3jIHZdBskti7zbyFbK
	vmz27eCwiKl0a6d53yEGYpzberMHRSI+ebjbd0Ma+H0nhTcSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709251835; x=1709338235; bh=MsRW//exr/cXPzror6xdM+8y2lzK
	w4t8d8C1gP0uPRY=; b=hxvEaWysfhRyRbE9GYiIiPmxwV4tzcGZtGtvVyeLF9kn
	Uifp1CpE1LqB0qzkRriFZNRYTgf41L05tv26RzgwC+wsXtxWthI3pLSNb6CinRi4
	oQq6u8HRz9vWqejcLLDHDOuT7tXD2pvBXRYr8aSt4gazs6CnlXlkKSLMuJqRogR1
	WP+0e2Anm8kasGU7BVwaRzkcq5jkM/WWqkVh3SpqCHFiFuEJJNwkQe9ulgBcftcr
	T5SnsUANoonqZQ6WQthOJ55g4MTzrk6+1Wy9S9yZqcEM5GLyEu87EvDhhAh7dp2h
	jYYLkaXnaTWzRn/3sx9Twg2NWtzEh17IfbM1LhidNQ==
X-ME-Sender: <xms:-xzhZVH3hhHmYbDXr9ujlSlneg4FJaRZ9C_O_psheluEVr4aVntkew>
    <xme:-xzhZaUvTD2m6T_fE_wBcBOGlev7j9JGgoylnvtZzhtHMzB8K02iAMX1N34cWndks
    Qpm5A5yVEd8K2Or-Ns>
X-ME-Received: <xmr:-xzhZXLfuoVwyj2fX-zClkgTG_KkyxUp8dc3CvQWWEKfvyLFpKtmcvDHbpLEtcbBMad6OjAFte0QugGLyqG2VPE6bX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedtgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:-xzhZbH7TPN5WzowQCb9Tn74mAJI8D1MusLGvsSWXsFItMS2yXM76Q>
    <xmx:-xzhZbX0V4Mm5OzR1weta7TznOqTa43xRYIzzH0YaUX1SmP-VaVTvQ>
    <xmx:-xzhZWNrEAD0Ie8kY3hbyLWDV4fgfbiBT1GkEsQ700XIqjp_v7IU2Q>
    <xmx:-xzhZce4pY_PXG214B1_U6w4EPfXxWLKTYVYee4g6vz5PVLZG2zLig>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 19:10:34 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: warn on wrong dev_t in fs_devices cache
Date: Thu, 29 Feb 2024 16:11:41 -0800
Message-ID: <c07bfcf1ca8ec66b8cfd1c6afae0b755af655cd1.1709251888.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are trying to close up loopholes that can cause this, but until we
are sure they are gone, this feels like a good precaution.

There are lots of ways the device scanning code can end up masking this
condition in a way that doesn't immediately bite us, but could be a
timebomb for the future. Try to make it more obviously a problem by
WARNing on it.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3cc947a42116..0d81ec3cadf6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -690,6 +690,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 	device->bdev_handle = bdev_handle;
 	device->bdev = bdev_handle->bdev;
+	WARN_ON(device->devt != device->bdev->bd_dev);
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 
 	fs_devices->open_devices++;
-- 
2.43.0


