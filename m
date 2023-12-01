Return-Path: <linux-btrfs+bounces-475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C18014DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 21:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD43281D11
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 20:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E95C58AB5;
	Fri,  1 Dec 2023 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="oNor3wCw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mzQG8Tly"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066212A
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 12:58:58 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id AA5C85C014F;
	Fri,  1 Dec 2023 15:58:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 15:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1701464337; x=1701550737; bh=Ol7Y2AeorX
	abVlkh7Vu8uIt/Zle7CnLBXc+hvj4ChMA=; b=oNor3wCwXYYnDFOmMHLn5/bqXh
	8vZiw880HK518KO780BM3adUmBCF6AFTyQT5rFJoNPdZYT1+cjZj3rNK9F9Ao0dI
	+eZC5mCmu8w1CK8NYr4HxDY3Z7qIJ2XDC5mpDy4HAt+99jXJpyy/wnAiksQx3inH
	23jhrp8FTAIVklsEXCqAcFVecHATnOL6+2d+H1Uu5fJrasSLI85tCHANWNoJhog3
	LdRHBjck08XF0wsWkQ+wMwlgyg+HUG6Dt1MpBlOMUQ2fUGss4va2GKF8CmVTjGoc
	JfoaE0tsf5Efy/QLokoJQ7yH+onYbLs4IWHYRr6dwsPTmEbt3VAHrf+E9qDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1701464337; x=1701550737; bh=Ol7Y2AeorXabVlkh7Vu8uIt/Zle7
	CnLBXc+hvj4ChMA=; b=mzQG8Tly8XCf///7O2P7XCi66WdcLq1T4ZvfVGJ0kl0z
	iMl/5KyI3bEtAeeFH/y/6Q+NX9RZOK6hkxy2Q1vCSPa5jv8pCvrvsfQckGw2Km6R
	TXwiHznZyh105HwHnBWQVcoRxjE57qofC2r6chsOzxq81N3QAwdo1naKm731Uyvz
	5VBKQrRwzcYIYVf7wR5baMuW31aIw9G4NIztp1dgUgx3/QC6zetfc6Bgsd3OnXMP
	p+edPPu1BnymO6ymkLmLF4KnyOdC8bAGFw8E2FgzNsh4B91eSQVzMQaJwtmgTYZl
	rBy24187LPKcQKnoiFRQ84iDCy0ivEgm63GVUc9+tg==
X-ME-Sender: <xms:EUlqZUPphjULEzX_uIkinfJv5KtLdPihClqcw5FA44w1iZZY8Wmikw>
    <xme:EUlqZa-fvWvn8LGpFcgIxOJYMSqiQinl3LsZNUx7Mrgc_xEJjLX8orP84tPLlG1U2
    mHfQ1536kxuxu7812g>
X-ME-Received: <xmr:EUlqZbSP6CvviaSzP9Sazsu1zMLmW6jGbtUSHXzAFFioXkez3i9iMWZZnC7326x-KAskNZdtRtNVe-CcFKulzz_Q_jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:EUlqZctT9HmRd4currP9NFdzl3NjVRM2obmfh2XaK4yzq8CtqHWx9A>
    <xmx:EUlqZcfTt_XrMJEutyHCU0zK9snWV968fCxLV8KSLsbLqAAGSD9Org>
    <xmx:EUlqZQ2S5BWCxCD00rNYcEWpOdpmeob9BKAKfWBVFLH_yMxid5f9QA>
    <xmx:EUlqZUlvjNO5_ATk04suQF6mEp95lwUIfzxRJqMj5jJEjX8aOlMdFQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:58:57 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/5] btrfs: qgroups rsv fixes
Date: Fri,  1 Dec 2023 13:00:08 -0800
Message-ID: <cover.1701464169.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains a number of related but relatively orthogonal fixes
for various bugs in qgroup/squota reservation accounting. Most of these
manifest as either rsv underflow WARNINGs (in qgroup_rsv_release) or as
WARNINGs at umount for unreleased space.

With these fixes, I am able to get a fully clean '-g auto' fstests run
on my setup and with -O squota in MKFS_OPTIONS.

Boris Burkov (5):
  btrfs: free qgroup rsv on ioerr ordered_extent
  btrfs: fix qgroup_free_reserved_data int overflow
  btrfs: free qgroup pertrans rsv on trans abort
  btrfs: dont clear qgroup rsv bit in release_folio
  btrfs: ensure releasing squota rsv on head refs

 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/disk-io.c        | 28 +++++++++++++++++++++++
 fs/btrfs/extent-tree.c    | 47 +++++++++++++++++++++++++++------------
 fs/btrfs/extent_io.c      |  3 ++-
 fs/btrfs/file.c           |  2 +-
 fs/btrfs/inode.c          | 16 ++++++-------
 fs/btrfs/ordered-data.c   | 10 +++++----
 fs/btrfs/qgroup.c         | 46 +++++++++++++++++++++++++-------------
 fs/btrfs/qgroup.h         |  8 +++----
 9 files changed, 114 insertions(+), 48 deletions(-)

-- 
2.42.0


