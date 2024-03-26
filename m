Return-Path: <linux-btrfs+bounces-3630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF988D02D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA911F81762
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7A13D8A4;
	Tue, 26 Mar 2024 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="AYgsukOo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FXtHOrbg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6D13D891
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489075; cv=none; b=duLeA1A2j1PYLKcqV/UwHhzbWAvJqqHq/mqYzKOLrA2IdIMzhGVCaohV0apAO9n9haryivsA2h/iZ7xsOXADLevS1S5YGvt9EXEOpueIhaRANv1U+Mdxz9uRFUQ2eHSFqPwhPm5pns1CtXgMhFvsRFRWMeF9327IH3E0j/fYdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489075; c=relaxed/simple;
	bh=MlhTw0HgvuZ7Y3juHPG3kl+rZACt1j0OA1dMrPMeHyE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3y9hWdkzmgKmCArGrKg9mpbuvc3/3zoZ/ogn4gEt53scMtFCBjbeewtfX3OfSjHxgvMQVdlvSnbES3EkFpWHdlfu1mD19thvKMI69QTpV30nbLhSi+dw5ECFT+/42hmqC1RTGXX0v3Aunu+yipF8HaGlK/VuBi2IAiSnHuKmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=AYgsukOo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FXtHOrbg; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 07EC03200A02;
	Tue, 26 Mar 2024 17:37:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 17:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711489072; x=
	1711575472; bh=0czY3r/Xzx7E1Y3gcaOZSXFpRPQH0pb6jkNCJzXqoDU=; b=A
	YgsukOoUmzyX6cnNDOeAyJEu29gByrvG7hPULiCtmdakWvU8I/L289hbU5r0nMLr
	jENsrF3MXx5nH4Itkru0o7vRsj/rkgaJQu73HkALIumRn0MPJ7yUNVnQUYIj1yVh
	nNyoli1JJALfRQHSz1C3hGoS/3BNUitUrTkHvGHcfa/iKd2/c9w0fFibHesBPCy3
	v0LFxizNHsMwXJPjHCU7fORim6B5SppFQPxy200+4KCD8JPtBH/kTgbikPTx/DAP
	js9BhKNUlSLdgH0gZ291Ea4nL27k0E4HO8FpnC8EK1RUkIz1+Wo1vt+hMJynWfo7
	+GGJt2D2lXXDC89XXuMMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711489072; x=1711575472; bh=0czY3r/Xzx7E1
	Y3gcaOZSXFpRPQH0pb6jkNCJzXqoDU=; b=FXtHOrbg3BlF4iocl4dkV7BaDXxm7
	KJWrK/A/YItVPwmdOwwqFAMZU3zvyLDfLxx9l5ox09/c4nwTPLOcsqhpJ3N6s61R
	zfNuMSnGt8fcym4Fg6ObjwYwo18ROU8Mbqs5s1K27V9+d4+FXxSJ7ewZ+/QBuJoV
	NrZuCDRGN0eS82bVgGtRo9e18Lvs4qUEVQTjQT3uqszjjyR7FjDKCk60YUTn2Wt2
	8hchEXHeQHfkTc/xGL0I52p2UeMhjyunJQy3/c/C57CzhWJFLsNIfj6er2EWlkTU
	obxYTGrRHJYpA2XrNAzbDI81xo4W1RDDEUW/Y6179pTr1YAG7DrkajpuA==
X-ME-Sender: <xms:MEADZkvEiU3eEHtZXh4-PNDi7ogVZqZWmpnXSz-TLPC5ONMqQi-f3Q>
    <xme:MEADZhcSHhGfxMhyCosA3ggmNvIqf5FTK5qVgY6KDY65_kCuQg0FEA7wJOoEImMkz
    agvxfgbafqhQEfGEkA>
X-ME-Received: <xmr:MEADZvy1ouTDKYIg7pcckjLg2MhQ6mnwTCa2cBHOImWtlbLE0Ryo5_D10e_WhuipuyDhvFzZ42XVN-B4cACoYPxYnJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:MEADZnNQ-xl6E-TrCxPMqOV5FLZUatnCj3AK97l5_mQid2a5zbYyNg>
    <xmx:MEADZk9XkPqL9i2A-dMBGSCMHt7h4L3GeXhfA6P7vxGpyo_pDkz8mg>
    <xmx:MEADZvXCoN1DvlTNT0TaVR-vsVGVhoc4Yt7_IfGUONuXs54hsoEhCQ>
    <xmx:MEADZtexFG_dma4eLq1JJ75weko_5jzgf7s1UGRTrm7P12u-dQRkbA>
    <xmx:MEADZinXUpl9lP1TZEtuJmOqzdIDb0Q5d5M1LKf5YcV3xXkQDILNpA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 17:37:52 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 4/7] btrfs: convert PREALLOC to PERTRANS after record_root_in_trans
Date: Tue, 26 Mar 2024 14:39:38 -0700
Message-ID: <acdebc0c8ca16f410a5d13487d1b9e69ae7240aa.1711488980.git.boris@bur.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711488980.git.boris@bur.io>
References: <cover.1711488980.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The transaction is only able to free PERTRANS reservations for a root
once that root has been recorded with the TRANS tag on the roots radix
tree. Therefore, until we are sure that this root will get tagged, it
isn't safe to convert. Generally, this is not an issue as *some*
transaction will likely tag the root before long and this reservation
will get freed in that transaction, but technically it could stick
around until unmount and result in a warning about leaked metadata
reservation space.

This path is most exercised by running the generic/269 xfstest with
CONFIG_BTRFS_DEBUG.

Fixes: a6496849671a ("btrfs: fix start transaction qgroup rsv double free")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/transaction.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index feffff91c6fe..1c449d1cea1b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -745,14 +745,6 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		h->reloc_reserved = reloc_reserved;
 	}
 
-	/*
-	 * Now that we have found a transaction to be a part of, convert the
-	 * qgroup reservation from prealloc to pertrans. A different transaction
-	 * can't race in and free our pertrans out from under us.
-	 */
-	if (qgroup_reserved)
-		btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
-
 got_it:
 	if (!current->journal_info)
 		current->journal_info = h;
@@ -786,8 +778,15 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		 * not just freed.
 		 */
 		btrfs_end_transaction(h);
-		return ERR_PTR(ret);
+		goto reserve_fail;
 	}
+	/*
+	 * Now that we have found a transaction to be a part of, convert the
+	 * qgroup reservation from prealloc to pertrans. A different transaction
+	 * can't race in and free our pertrans out from under us.
+	 */
+	if (qgroup_reserved)
+		btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
 
 	return h;
 
-- 
2.44.0


