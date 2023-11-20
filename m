Return-Path: <linux-btrfs+bounces-207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F857F1E87
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 22:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723B7281133
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673033717A;
	Mon, 20 Nov 2023 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="jxxn8Ayz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9kj4eWg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8D1F5;
	Mon, 20 Nov 2023 13:10:05 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id B80DE5C10F9;
	Mon, 20 Nov 2023 16:10:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 Nov 2023 16:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1700514602; x=1700601002; bh=vAe1jxs0Zk
	ngAMx0ExLMRLzbU3hnZxCFMpt4PgM/Gis=; b=jxxn8AyzezQE98UyXn6uH6h0vg
	WNfrciOIlUWNP3w3foopb9p/qgnlT9RQ3Ex8L/ARg447l6ly/PxQpQezugdSMTVj
	AwdsvfsOUCJ8LFzfHV0Ac1IAA/RD5QSoZ/8mcO47gxxAKBReqDpsrW837rCt8Jeq
	SWUIrnNsJN9E2uxio+lR13WArBhSxPrJ7hmH/4SOlEqOpQbl6N0KmgCBjKc40EwS
	mIhGhsZ3/BRN94NiwWV2WTaG3XizIGDOTJgmpmq7WC9APk4OEjDRfBWMCg+9wy3D
	FvlZStc6zXVFokykaQ0qq+jUfeBnquhPurq/OcTkhBs3IPAqJvOfBiMjtvWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1700514602; x=1700601002; bh=vAe1jxs0ZkngAMx0ExLMRLzbU3hn
	ZxCFMpt4PgM/Gis=; b=p9kj4eWge2SWHjYBse933nhAOaUyBTWJpDR0nrEldfXa
	xg6AXGDt2q9X3DWpny9lmQaCm2/wvCAeLk34r0cHxbn2bSX5JAOGZqh1zCFEGgqb
	xK8ScoDDwAzlURzYuvxWFdp3fhglgFPEK+dlYYyek/7I/coZwgDUJhwU7dywNpg7
	1QMqUUPclgNMuh/424jEKDqlaXX1C1tDjL1zqh+vAphyMWDLYg/Sh3sk4udqRjSX
	T75kCHb23zWVQwgfqWYPUVZ1gMjWKPgbNv/9c3N/7YPp09SthxcJcioUBtWqR8lR
	hAQcc/L7PstGFN3SE3EXMTkbDWmVYQEgmJ9okkyxKw==
X-ME-Sender: <xms:KstbZakWITlOBtEdfxleYDRH_e5XY1HbBOuydDnmmP8bbLkz5g0FaQ>
    <xme:KstbZR2YNMcST5goU4L53l5QYUQkZqTrSeJsRCUevi-_zAg9oHeEdgg-N1NXj9xmG
    RO_5A2Wvbl-5DLt2Bo>
X-ME-Received: <xmr:KstbZYoqK2qhrBq8PQfK0bH-0xbTbx0HO_5AlFCnsEw1EOH5CGbHsQG3wciWQ3UX6FMd9Rt3lVCfOOyoeXCgljyLx80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:KstbZemEtCRFqGVmkjFptyFOnZvEt8HswkgvlUybDW-16A2U11XI-g>
    <xmx:KstbZY2xVaHw1I8xcwEPKyt8MlCbisG6g1VfU_xtM5uSoAWBOog1mQ>
    <xmx:KstbZVvj4yPEdXeFSouSWsRRGlOkwCaIG2o1cTd4Py3fdVxAmJIjfw>
    <xmx:KstbZV_k1eFZLUNwu4f9SJp9CHNdhqZrEYBhW7tAComMiK0LcCjy-A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 16:10:02 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs/301: test fixes for squotas vs other features
Date: Mon, 20 Nov 2023 13:10:53 -0800
Message-ID: <cover.1700514431.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The squotas targeting tests in btrfs/301 do not currently pass test runs
with compression enabled or free space tree disabled. We can fix the no
free space tree case by querying subvolid rather than assuming
256,257,etc.. Skip compression, it is covered anyway by fsck on the rest
of the tests.
---
V2:
- fix tons of mistakes from global subvid/snapid variables by making
  them local
- handle the nested subvol too
- fix descriptions from previous confusion about noholes
- run with and without free space tree

Boris Burkov (2):
  btrfs/301: fix hardcoded subvolids
  btrfs/301: require_no_compress

 tests/btrfs/301 | 172 +++++++++++++++++++++++++++++-------------------
 1 file changed, 104 insertions(+), 68 deletions(-)

-- 
2.42.0


