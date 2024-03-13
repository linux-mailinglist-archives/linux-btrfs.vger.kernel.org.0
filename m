Return-Path: <linux-btrfs+bounces-3264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0087B556
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 00:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E85283D8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 23:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342965D8E4;
	Wed, 13 Mar 2024 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="VCz0zsXw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYH1dLnx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189505D74E;
	Wed, 13 Mar 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373545; cv=none; b=Hb8SJwJiuZSkb1DmfeK2t+tW+rx/j8iSNcBs7M9o6UCQ0Lt0f5LVy96pXWUhUdLs025EkBcX6bfapO9v7MroAleJmOOwEaw9kOQw42S7YNp8MyMK49mywumEWtULGvvncDliHdtXjzlBwRtizv7SQQTxuZSQ8QgjEs0baf0FoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373545; c=relaxed/simple;
	bh=l3SS3zhNbAcmNY2Y0cNYgZjOSCY/WmbTxrlSMAXhjx8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RF/sRK/M8QlN9KLLYS6yUDTr4rXs043lDBC5Po50E5GU56GWIxNogXGzLeQoKsE6murjyb55lyK33Ynb79hwPkwqqEdf0eaJfbw58rUesV9KRKywvEc6I7v95UjE77YkkbTnP4ipELwfTQA5BP2YrXIsmFDw3+tZMutJ6kxaaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=VCz0zsXw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYH1dLnx; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id B4F5532009FD;
	Wed, 13 Mar 2024 19:45:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 13 Mar 2024 19:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710373541; x=1710459941; bh=IT8meFKXO8+79QKh7WmT/
	2X5ESCARYejQK37eU8VGkk=; b=VCz0zsXwBkDiaJ6aU8EXUU0o0IMir0Ny26/at
	g89betjoeN+bQMpU1R4OdDFoeJ93GwaBP30EydRXyeGmDR0mZwkgeNn3jRW8pEsm
	H1WFyRA4mIWxuCC/wpErIqWZeiy+T+np8rfW7L6M6PVifLwehY3xFkpmgluQlEuw
	8pBXHLZOuR5JTdnaKjrh6/jBGWEEfd/x5kosHZSXK+U6Ii2xRlaAmecuegn+oSpr
	NS6vwYBIJwkWvWBko+BybXhR5q1WUaOQRZjXuzHbhC0poNUw8xka2HPbRnxNdMSP
	Mv02bNMApSZPTqSM0kf5nIQ4oyWlPaM5NawWgRp/Sc4k5b32A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710373541; x=1710459941; bh=IT8meFKXO8+79QKh7WmT/2X5ESCA
	RYejQK37eU8VGkk=; b=GYH1dLnxfTpJtnh0tLRv68WxIhFSjbmfYaqDqodbqo4a
	1g67CHCMtA/IYddVtfth9sFbUoJs3LwHaM3fVtu3HSdCa0BVU3pzlGLMAgSlflr8
	I6rh5B73J/XJcEY6zD9E92Thgwr9XG3WRo6MRm23kSCptjKCwxOy0cqcJ2cy1M2d
	ICxhrK9lQXhT0QailGA8F7lS0/GY0qh2m0RONnlKfV8WlPFBcwzlKpL5LwWNXMWe
	COe28okIgWPttFQuT0LXWRhkIMAZAWmFy6CV3eEU/0qofRb8haVN/0JN23omtcDr
	oP6Mzn1mFRI8ijeLS9uLFBH4c/8NWvy4UiZ3Dz5tCg==
X-ME-Sender: <xms:pTryZV11iUzoKn-nWjyScpmK4VOgo6FIxWSQzvyH125TaCeWwxjE2Q>
    <xme:pTryZcGiqjWQyxnI302JkXGJUKM2-Bwmx1WF2KBm67AUuehHcyzVA2LsBw46SzG_8
    12kdbvCc_xwsC5tTvc>
X-ME-Received: <xmr:pTryZV4KLYeulRDfjObgd_JPbI6X2yBJiTioEDheaJbxsL89qXnLnU1HNJ-s1MPCWayNqCSUy63HqkDNAnOorEnArXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:pTryZS1KCV3zIY7A1y9G0iXstWp298_EGYvgV95IC2QyQRdMmx16Ww>
    <xmx:pTryZYHHWJm2Mdb7fEerf1iyEDLm3-qktKOONxSpSC1q9cEBCFlXoQ>
    <xmx:pTryZT903VeuHVXi4NE7lqxPHwdjU1qNLM8uIa3Nb8_NPiEkAsWSIA>
    <xmx:pTryZVmqbJ7IWOK7pb97HqENxvp-9L9IuzVYer2ttAvGiLlZGOSLSQ>
    <xmx:pTryZdTjypktr1BGNEGfY5iwzdgJ3gB5dkWaNZxD2r47k3rpIVlzDQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 19:45:40 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/277: specify protocol version 3 for verity send
Date: Wed, 13 Mar 2024 16:46:29 -0700
Message-ID: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test uses btrfs send with fs-verity which relies on protocol
version 3. The default in progs is version 2, so we need to explicitly
specify the protocol version. Note that the max protocol version in
progs is also currently broken (not properly gated by EXPERIMENTAL) so
that needs fixing as well.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/277 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/277 b/tests/btrfs/277
index f5684fde1..3898bda4d 100755
--- a/tests/btrfs/277
+++ b/tests/btrfs/277
@@ -84,7 +84,7 @@ _test_send_verity() {
 	echo "set subvolume read only"
 	$BTRFS_UTIL_PROG property set $subv ro true
 	echo "send subvolume"
-	$BTRFS_UTIL_PROG send $subv -f $stream -q >> $seqres.full
+	$BTRFS_UTIL_PROG send $subv -f $stream -q --proto=3 >> $seqres.full
 
 	echo "blow away fs"
 	_scratch_unmount
-- 
2.43.0


