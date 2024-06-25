Return-Path: <linux-btrfs+bounces-5969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874FF916F51
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 19:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF471C23252
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA34176FB6;
	Tue, 25 Jun 2024 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="oHgiSfrj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTfmpoM6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778B17623E
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336777; cv=none; b=RiLk+EFxqeGyC0xxSKFFTK8ajqGeEHmD2rvWyvdo8/QL7xhc97yMUSYAcDq1Hk3oXsqhQb2CA6WRdsSgFjyrP8dYs9+p34OmCTdG091M2qbmgONExeQ0P+y6481aGiP11iDpdHLZRq08k5blPbU98VtFs4wwNELc4pQ7ru+o/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336777; c=relaxed/simple;
	bh=SSDKw6pSK9OjeGJr5QydOunvylph3IiZEz2GuORBlY4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MZWJitrXvTh+0Q/S7ENPPgt8oARZNmL3DgzvgNfgYnuU0/E/UJmujPEbjAemYNncfBU/Qj2EfYwMOpN4+pbPhEAqJphT7xL4tFN7MIwaEI+i+etCot5GbIfzT3fEqj1TSpC9+p0JCy5g8g2S+vbXEOaJYgCvbYl3Nznq3X2+oIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=oHgiSfrj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTfmpoM6; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D959C1380115;
	Tue, 25 Jun 2024 13:32:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 25 Jun 2024 13:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1719336774; x=1719423174; bh=VhQj5jXluy35dNYveiG1+
	c9Z5+YnM3RcJDWBcEcy7w8=; b=oHgiSfrjAMiYzC9HOQkp8ZVwHWdbLUjsKFxgw
	T/5WVYgJjDP1I6Ckg0MPismP72uAGrLeyaFMigrda4BXKypGwUltDs0iPLz6togt
	ffuRRssQX24ztBYQG+lSN4zTclCJhwGG3b1H2ZIbHgu334/FM2t1p2bhf4GMH+UN
	SrhZvlKBo3jtfDBBsFovjYBbCjG8FXrBmIvJxNPiNWwDLt9I1fY4fjpOtHQN/hf6
	na82YwiqGiSE6O9VwApUm9C1Pl1NlbEahgMSldI0ExUnImSyMl+XjJLR/lgN6I53
	xH+TeBTwdL1Tqx2DW6ZuOvLjsCWu3rdGcwEM1rttRqegmq+pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719336774; x=1719423174; bh=VhQj5jXluy35dNYveiG1+c9Z5+Yn
	M3RcJDWBcEcy7w8=; b=lTfmpoM6uX8ZOeS0Uunhm8aD6wmWn+g3Ao3hG0JCHO3m
	kw5J7CViYoMx/U5aX1wTN1xHJXXClTbTqYrQshtV4YAUm5L2BPjVCO8I9ks0VIsR
	4FMfE1eajWElpV3rstHFjbvHwO/MJO1ozz/VKZTvFtdkvLUnkX2TfY+kXgPl+NGK
	T1a6tl9NDAFzXb4aAolxTeTZi8PuV50s8ht9NERscTKxlI5Bmkfjs8V+0kf5YA/N
	rI/jEG2C68IZoWPq/ozTCkmSohVn4m3zj26YcoBhU7ssmrcfYf6C4vlmM+qYtASL
	aWEzkoJ0LEKqXtIE1PCUH0zClBGwrOEsUGZCu/FYKg==
X-ME-Sender: <xms:Rv96ZqCE_DJL6qvFi_KpUk8ex3Zy5U7sPK4HR1nQh8bg-tS7vRjdLQ>
    <xme:Rv96ZkhUIuBtGpKW9El2ZQ4M2KCauvWn-NDAJa_2qroaxLPpFcW8Tde7qS4CQwOM6
    gW4_TZBDIRkMnE_Xns>
X-ME-Received: <xmr:Rv96ZtnqFmDva1e4sV9x4dH7Us4hQH_aolcE2M87Snjo3oidJh-ZylQr7ajTQefaAUiVArbiyid4ox9AuR9QjZ0e7cE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Rv96ZoxgsHNqOXYZLnvtabNxQUbCCWi5NHMdE-hkU7oqILN4RI3YeQ>
    <xmx:Rv96ZvSnKl4YJPPtAW3Wiv9Mxahcz0AimyfsVeLxGAkAMMgX0lTR5Q>
    <xmx:Rv96ZjZX5VghWrQ6tj6W-sUTGk3EWO8dG8LcbSAqpsGDCypVwOASlQ>
    <xmx:Rv96ZoQ3ZpLYfXE9skYpnTI3oxcc-f5Hh-VVOtt8fHJwS6tPn4E3Hw>
    <xmx:Rv96Zqc_3zAotRK00BG07lR2P4JmgyJbc6mWo9JLXJRdEZTjpxRLWZrk>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 13:32:54 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: don't check NULL ulist in ulist_prealloc
Date: Tue, 25 Jun 2024 10:32:11 -0700
Message-ID: <3034f66918cf06066b769f4d834905e25824ae8c.1719336718.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no callers with a NULL ulist, so the check is not meaningful.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ulist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index f35d3e93996b..fc59b57257d6 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -110,7 +110,7 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
 
 void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
 {
-	if (ulist && !ulist->prealloc)
+	if (!ulist->prealloc)
 		ulist->prealloc = kzalloc(sizeof(*ulist->prealloc), gfp_mask);
 }
 
-- 
2.45.2


