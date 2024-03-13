Return-Path: <linux-btrfs+bounces-3266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421CF87B558
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 00:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB481C210EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 23:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E35E07F;
	Wed, 13 Mar 2024 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="n+CtNB6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i0grKGAk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB05DF23;
	Wed, 13 Mar 2024 23:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373550; cv=none; b=WybkzcBlR5bfHKzKRrEIpn8F9OvR0zRO1fPA9AE8mNf/Ek0pYsEBGqMlAjYzV8c+GULGAT6L22sCuuZexPIzvP1C+m9l7pRfBX5EQjBqEcTA4XktybSM0sqUqXWuu7BQ4cSJ7LZqaJfcp+nAkWQKNwMOuW+2+GZUd1nfEoZq8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373550; c=relaxed/simple;
	bh=hhieElAaqS6OmOm+yhjdw4TRnqZFL+gfcqDh7gU76p4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmyl1hsO7CVoZp2igegbZqGent51aaJnuaF43KWcxVgxmuYDPc6DnPCn7eBWm5Aq6rp967S16EyoZ0exwUC+3IUwMsgD4vI3qCuzbkeZl8bKfnFvpdt3bu3ZkX1LK6eUN91II7l+hw8O4+k62Rffkhm4yFQfJspBqCebN8UrKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=n+CtNB6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i0grKGAk; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 483B832009FD;
	Wed, 13 Mar 2024 19:45:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 13 Mar 2024 19:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1710373546; x=
	1710459946; bh=RUiufpH62OWLBOhOEK4N/hzsHkPzFZsiNnnTy0oJ1UY=; b=n
	+CtNB6V5ywGB3/OxNa96c9fvZ0/l6Knhg5DvkFMXKFCgqwP1DgnCpKS9RAS2CxI3
	fxM3L0SbtAMuxVRohvoxEHE8AFPQXj3K8CVqEpSkqytYI6ijPQAvc0kq2jCB1QSQ
	e+SRty25ctSIv7dERWRymVIljLp32yu4dMkJvHf5IuPs0q+f8m2F/0BWeaYvX5KJ
	yl1PLn2aVzxn0sb35Xhsc6IwUyCjlN2ZBKW+swYKAmFg77Cn5M5DVPUTaQOWm4y1
	BSvcvTPg5XMPgbd5w9XrPDFFfkrYQ4RgxhV4Cp0g4wTutwJXuPM1+8yzqigu/SMJ
	fbdvDdurbbCfyUjIJ7aYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1710373546; x=1710459946; bh=RUiufpH62OWLB
	OhOEK4N/hzsHkPzFZsiNnnTy0oJ1UY=; b=i0grKGAk7RyYhqlq+V+/+wBPVV1+H
	vyn3ChGv0be+j6pyryoApLWECP2VwCDBA6pWVbczDaxomGjkh4d78YuUyU4UTuMO
	y3HeubhWY/dKVTLRy0lh0eb069YbFxPF2Y1mh//1bLUqYTxt1FbcOtCm+Wkm/8cm
	erhcbiglf2S9NRgeso+vSPsGIVx0QEILRY6Klj3gl50r/dqMHSElhZI4Iqmu6exp
	R6DFlrHweukNps0f0wUhKn0sCVQVXkpq8AAHldz4prZ72DWceqhO9qsjwaT9OjEh
	awFjaI8wF4OQ6B61ysKCpKytggyVoBiTYkpy7QvM87QH8ZOBSUSgAvx6g==
X-ME-Sender: <xms:qjryZWauWS6YaHjC_VxJWWUoQ5FBxdhfGnXba041TvSoKRp-GNXVFA>
    <xme:qjryZZYB3dAfpX2MxORyD9n0aVrcqigI5TRk3IseqRlv3YeKENL_AOk4tOTfGVSHE
    4_iVVe7y9hj-rx6h6k>
X-ME-Received: <xmr:qjryZQ_JLv-QFRLLo6Rb3c4kM5Vqv2Ubn88Cb9q1oucEpZN-5DS2wZQwzQenD21RZuLWrNa-lOQ9Z9EafAdt1yVvSHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:qjryZYqBRlCBNaurUOaWxbdATXPtTw6XiXt846amPXaPuXeeAmBLZw>
    <xmx:qjryZRro4tkgQjcl39YxbaiD0mAqjFoTNMNCIqYdumAaeBeyUBxpbg>
    <xmx:qjryZWTLAqdyeFFYe0ucY9-BdXREM7QeRiY7bcf1oT9hwQgqDm0dfQ>
    <xmx:qjryZRoDuknBjzTk17QMNUZXTeAQtdWdCI7LjNWmQnyhYIVK30NrYg>
    <xmx:qjryZY0e9XKkWPpFf8-45F1tohAAaxb9NPoEdenVVYyyEhrgAgYLHg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 19:45:46 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs: fix _require_btrfs_mkfs_uuid_option
Date: Wed, 13 Mar 2024 16:46:31 -0700
Message-ID: <37d57d3ae473b67270137151e4fa18ed7464cba1.1710373423.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
References: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

currently, this helper causes tests to fail on my system due to
unexpected warning messages about dangling '\' characters from grep.
Change the invocation to not escape the '-' characters but instead to
use -- to instruct grep that the options list is over. Fixes
btrfs/31[345] for me (and I believe the btrfs github ci)

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/btrfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/btrfs b/common/btrfs
index 3eb2a91b7..aa344706c 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -93,7 +93,7 @@ _require_btrfs_mkfs_uuid_option()
 	local cnt
 
 	cnt=$($MKFS_BTRFS_PROG --help 2>&1 | \
-				grep -E --count "\-\-uuid|\-\-device-uuid")
+				grep -E --count -- "--uuid|--device-uuid")
 	if [ $cnt != 2 ]; then
 		_notrun "Require $MKFS_BTRFS_PROG with --uuid and --device-uuid options"
 	fi
-- 
2.43.0


