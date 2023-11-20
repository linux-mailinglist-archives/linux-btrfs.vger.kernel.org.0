Return-Path: <linux-btrfs+bounces-200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE847F1CD8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC371C20F6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F65C36B0E;
	Mon, 20 Nov 2023 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="m6cxsPON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ghUDFYMA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C268C8;
	Mon, 20 Nov 2023 10:44:18 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5815D5C08E1;
	Mon, 20 Nov 2023 13:44:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 20 Nov 2023 13:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1700505855; x=1700592255; bh=8Px93DAwzI
	dXk5GyT/7CMPZPpm/GJSBIYMc9KCG6ViY=; b=m6cxsPONGqGw8t410CPboHJd3F
	54IU11qpXOA+evT6sDFaFLELmRvSxHs/R85A3MMLmnI9wMGtbnq+NG6bTHZag2yr
	eAdJHD6ilLsYdefp/X9w5iHh684pxYsJKqTpVAsTteooYe64RPwnr+pnqqU+VqsY
	yvpVO7zBntOUzJr3b5i38PgmBO1GW+nAW3t+oLGjmIGBPGFsc5KUlCWLKMB3oWur
	tO4dtFaLvTGVKSF7hmPV20dNSm7jRi0W13t/9HxUhwM7PHlUZ8pemYttLeRRHkHr
	C26fOND2lVn8YEJvhgQD4/06kXvbLE19Nur50KSMfUnqeSfDPN6nbiuNx7+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1700505855; x=1700592255; bh=8Px93DAwzIdXk5GyT/7CMPZPpm/G
	JSBIYMc9KCG6ViY=; b=ghUDFYMAYWPRO6KabGjIuoNo7ejLi7xqapCgl/Zqw2wa
	a5KlWFrQL8Wttdw0tmFD2ozRxWYdm/UR1k0t7GeS9H9wWv+6OT5/AL/yOryQv7E7
	th2xXZ1xjGEgwprT+5qLMYJHjAjC83LsEz/bqjYh3/mGm/eJsmHbIfMQGplQJCvZ
	gMKCQGikF29F3TNLqX8QqsxcnwUzD+yU+qFKY9gWXn2HhVcZDw7fFz28ECd7FyIA
	8xPbOIBo6h6DQC39gGnWhNrUmFDmW4XyemIKVphPMHt1lgkcBeum8IIXiIxWYIz9
	Phe1lzRaFHDTQlbw/8gw10Ow7yiQhuFb6kNjKPioOA==
X-ME-Sender: <xms:_6hbZVx6_l6a_BW33KG6hb-yN9o22ULDzQsnZIAyJ2_ep1P_nziJWQ>
    <xme:_6hbZVTdDvEm-j1PSj_aRyabY21mc5uy_nyB1dgfRqmPe0w0h9k7bOz3lTPzx1gV2
    HQ4OI9qkYVnwKgNbFI>
X-ME-Received: <xmr:_6hbZfUM_tZiSYVx5OjE5YraiBw44LovV62_Owa39Uac5_gUmz5X72--Y2T3iKeo_gNlTV2-JyTAS5boP0ohShE0pXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegjedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:_6hbZXgOj3ZvOmmAGFrOmy5HTRKU1ipSle7cV3JxCRUojxewA8Vuhw>
    <xmx:_6hbZXC9zKTOqyfM0suW9sgMgQX22MxIiZJUsDiFF0JJb5nzK6k6EA>
    <xmx:_6hbZQLlhWGCxHPBNqcM6bktjY61SoNpe9RgphD7Lz7-Seo6KCEGyg>
    <xmx:_6hbZc5wHN0i-8LPMM_mCpihoAeC2NaYRO8zTxtQ8mX5YUh3jH1pJg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 13:44:14 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH 0/2] btrfs/301: test fixes for squotas vs other features
Date: Mon, 20 Nov 2023 10:45:01 -0800
Message-ID: <cover.1700505679.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the squotas targeting tests in btrfs/301 do not currently pass test runs
with noholes and compression enabled. Noholes can be fixed relatively
easily. Skip compression, it is covered anyway by fsck on the rest of
the tests.

Boris Burkov (2):
  btrfs/301: fix hardcoded subvolids
  btrfs/301: require_no_compress

 tests/btrfs/301 | 139 +++++++++++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 68 deletions(-)

-- 
2.42.0


