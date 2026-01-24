Return-Path: <linux-btrfs+bounces-20986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNL+HC49dWmbCgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20986-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 22:44:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C74697F163
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 22:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D49D3006001
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 21:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B53273D9A;
	Sat, 24 Jan 2026 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qsPSyGsh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jAwgHjUu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9CA27FD71
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Jan 2026 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769291046; cv=none; b=SXkgiH6ijNbRDdU0Q8/KMHs63g8T1iCmTUPcoI7H3GLLDVh0/gVSL14p3iJFK1SqKglDq85gMOHN1gI6PopMyPR+ig8C3YrB/nzsRLMrjiDbNApwlTfBJaVRnpcmLXkucpaGew2Um+V1TbB8K5AvDasp5ueuLxwyNkYqjpt5xxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769291046; c=relaxed/simple;
	bh=zF+Jj724D1u067gQJz5zwOwLd2ukj81Z7DumjE+DvsQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxITUUM76U0eDQ4x9HqFrb1vGhuJp9fnh1CCfgfJQWUrytHKjvcz0p9NhAfqX6TpvQonueTL4F9jgCB4dcrX9g3MBBkJdCAJfYAcK3ijlGCSfSvo6wBfsBueGfUU9BvPxBZsZImNIHBKDRCMr2mETGXZEVp0sQkzJ/g1g2tFdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qsPSyGsh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jAwgHjUu; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEC5B1400035;
	Sat, 24 Jan 2026 16:44:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 24 Jan 2026 16:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769291043;
	 x=1769377443; bh=YiK1uQGtpiPkWrskbQ4ZtK2ZNuwazLEU7S8TWxJyMyE=; b=
	qsPSyGshMjiYRn58gMNB1pKlm8TSFMYTpCqm2pJz3EdfjS7ZLHBY3t8Exev4VdEh
	Oz3770GCi7cA7L0OqCqC8nGWrQJ+XVDjkTan95X5Mq4BryVuA/x33Jcj//8gFtXm
	U+K968JLQRMF17I5syKDzTUByMLFBR4rg4/cg7vSy/ehrdBancicXfPqBvTjNbkN
	4rigM1ssCGyCSPXsZJE4ImMBHWdIaxV84JpbSl7srWSmHur7jqYs4U541aHuSnJW
	0moEebHYI+4jNTl0Oysi6B8vnmhgX9Nc0B6sR95p2R6HaYC7LCMCLn/IWZH6L9l6
	4yOg6hM8o/wP4B0rRXcW9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1769291043; x=1769377443; bh=Y
	iK1uQGtpiPkWrskbQ4ZtK2ZNuwazLEU7S8TWxJyMyE=; b=jAwgHjUujq1OwEMf6
	PmW2MQinhiv4r5EjQCHK447oBHJkTySdYS8v2o3aKPLz3hk5K3xpTsuBzuvk4g/r
	EwoQB8TNOOZjz2vGDq/tScaVqN3Uu780rUSXsQuU504/OhpsGhHhA0ogGadjfSF5
	8Yemi/Sc3IGljzh9s7iPV8Bncu5YSOdVIMiWei8ypX6c8sJBNJPdxQfqagDGKIiy
	OnFGRE4ZBQc+8VN1XEfHRlWQHIxQEB7U3U4kzSAPM8EMqq0l+d2V7/2fIKSGxofJ
	MEWiVWKmlECRo6GL3xC1N0/iB8eji3tlAAC3yDsXKlHl9omLC3/LenyVxtIkSbhR
	GxVBg==
X-ME-Sender: <xms:Iz11aTTXed8B35qCYXjdTc2MYqKubUMeX3HLVRgyXOc6EMSUpzJz2w>
    <xme:Iz11aaz4vPJQKn2mSa2oqzCZim3EGfS_pIgcSUUm4WRZqV5YG3HUJRXwHLnsgLHQc
    onCCYQFdDbVO0Q7yHOqN5B9gmwaVt4NaGX80WA1_sGYNYflS2VN9Q>
X-ME-Received: <xmr:Iz11aWdfubw_IbNZh8IsDni8Ev8tyMQmfqdog_kmjJW19gkvUrCoyjR_DY-5WhGHmOWjeWpaNjnsdF5PXhVz11JEYZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheeftdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertd
    ertdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephfevtdeuffetleegfedvleeggeefkeffgeejgfffff
    eltdduleelgfehveeuteetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtoh
    hm
X-ME-Proxy: <xmx:Iz11aeJxclPu6QcFlQ7TmDF7zibcJ4sfVPkubCo3JpM7SlUpRwnssw>
    <xmx:Iz11afEGKjxoreZxiPgXnectqlzcW99UN6eytKAKK8AGn95-6tf9iw>
    <xmx:Iz11aQpm5WGAFwJflfcVky7Pi12PWeaCNlEHPk4cX1b7Oxyg-wnNhA>
    <xmx:Iz11aQQhJmEQz--kpzve76iCpmhfuy47gAoFS8OvrBm54OPl8nc61Q>
    <xmx:Iz11ab2b61H-Q_HgD89d8HGYzTOCRWMKXZWboP5dyF4J1pXzvXrkyhzw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jan 2026 16:44:03 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 3/3] btrfs: forward declare btrfs_fs_info in volumes.h
Date: Sat, 24 Jan 2026 13:43:35 -0800
Message-ID: <07e957f64db404a0dade65259846412be9eea0d9.1769290938.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769290938.git.boris@bur.io>
References: <cover.1769290938.git.boris@bur.io>
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
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20986-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bur.io:email,bur.io:dkim,bur.io:mid]
X-Rspamd-Queue-Id: C74697F163
X-Rspamd-Action: no action

Fix the build warning:
In file included from fs/btrfs/tests/chunk-allocation-tests.c:8:
fs/btrfs/tests/../volumes.h:721:53: warning: ‘struct btrfs_space_info’ declared inside parameter list will not be visible outside of this definition or declaration
  721 |                                              struct btrfs_space_info *space_info,

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/volumes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 48d82a1903a7..acd9b232b124 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -30,6 +30,7 @@ struct btrfs_block_group;
 struct btrfs_trans_handle;
 struct btrfs_transaction;
 struct btrfs_zoned_device_info;
+struct btrfs_space_info;
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
-- 
2.52.0


