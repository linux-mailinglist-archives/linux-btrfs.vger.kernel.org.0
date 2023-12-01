Return-Path: <linux-btrfs+bounces-479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E988014E0
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 21:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED9C281DD5
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4BD59B6E;
	Fri,  1 Dec 2023 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="XKSGvavR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wK+xa72a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD5010DB
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 12:59:05 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 5DDC55C00CB;
	Fri,  1 Dec 2023 15:59:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 01 Dec 2023 15:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1701464345; x=
	1701550745; bh=rZbkCaKgzsun6YvoxZu5I8w+KlxOYgvNjTINXJWdl44=; b=X
	KSGvavR8O9am9MP4OaAgc0yv75IPr/ktArIdDmWsPGzKL5vt5ZcJs1UkzPDZ5j5R
	TtIFruT/s5O0/m+5mUgYX9LFIM2QFmbd7CP8hLsWa2fjTz5ezlSN2yb2sK8ph+Wm
	jWirCTYuP8tN6GJIQr0Ueh1Kr4HP7e0uya3lljgvEN5K/tOUIvHgE+bbKSGC1IOd
	8jv/GjwLKIc4aenZIOyz7wzC71xgo6Y5iW7DvBmPf4CdI9fxbJGcIn06rtQ6/k0M
	8RI9z0FlHmCTo1R/ueYBLMha0ZAvVYdd4VqFpKCHu7CJcVKO9yrK5SaJjDhEa3HC
	+I2pGd+9aU9T/fnt/igFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1701464345; x=1701550745; bh=r
	ZbkCaKgzsun6YvoxZu5I8w+KlxOYgvNjTINXJWdl44=; b=wK+xa72aF4nAdorHL
	KeeYiHJHdRW/5w/cYZ/9N8WNOWgMRlOKs3lZffmFVpPyaZdTrLDHT6PDKOm/bAIV
	BwYToVR80aCSSLees7pbT5IGJ89vwFBC5RytHiyedgpgM4VE7lgLcRgervMZkNW3
	4XrDcQBj+5uF8ZyJfDPt537P8ViQh15WcZ+fu44BlnbTD3ig03CQLmE2anAX0fDT
	9axVvSEqZOSSm18CqIywHglTqMdMj29z639JnAnyPidUtCQacALCCczlP6FRA75j
	j696RVQnBa9sc8w5SUedopyAQ3Rp6dSvO8lKODUkqVczTXgPHJ6jVvAZnzhEFWbH
	odEVg==
X-ME-Sender: <xms:GUlqZUhLW9J3F0SCc-7bhOT9TCPfo3k3rDHVHoebW0XYb9saKF8BCQ>
    <xme:GUlqZdDZ17Teyz05WLyN75czoXyM65QOk-lWagmwWHmJyzB98AOfyPCzK88T8SwGg
    CWTBlS5Uy9AgW-hwvs>
X-ME-Received: <xmr:GUlqZcH1uBBKs0r3HG5yVp6BA8oSBHXErZUCaXUm4Dfnc7800NLZBMaeplJFjcfRlNJDsQraELVRBeEhOfJjv-TXKQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:GUlqZVR1W3w9Oj89VfVxb8E7mBqZRBnPOaKZ_BGaEMpvedUWVVT4XA>
    <xmx:GUlqZRwxDlxtEVvRvcwIzDYnR-n3QEmj0Hs6evYFKbcRuYnBvimVwA>
    <xmx:GUlqZT6t4ACDnoiRkqdrPEfr7rWr_YE3LglkofDiwhwSmhU_xGJNhQ>
    <xmx:GUlqZfaprJSYVN10HvTM1QrT0E_Vm1ybUpFionR3it3fQKQZQp60Ag>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:59:04 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: dont clear qgroup rsv bit in release_folio
Date: Fri,  1 Dec 2023 13:00:12 -0800
Message-ID: <9a8e2f9639330dd5e82db11a49f84fa17cb9988d.1701464169.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701464169.git.boris@bur.io>
References: <cover.1701464169.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EXTENT_QGROUP_RESERVED bit is used to "lock" regions of the file for
duplicate reservations. That is two writes to that range in one
transaction shouldn't create two reservations, as the reservation will
only be freed once when the write finally goes down. Therefore, it is
never OK to clear that bit without freeing the associated qgroup rsv. At
this point, we don't want to be freeing the rsv, so mask off the bit.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0143bf63044c..87283087c669 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2310,7 +2310,8 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 		ret = 0;
 	} else {
 		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
-				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
+				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS
+				   | EXTENT_QGROUP_RESERVED);
 
 		/*
 		 * At this point we can safely clear everything except the
-- 
2.42.0


