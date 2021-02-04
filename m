Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BDD30FE16
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 21:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbhBDUW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 15:22:28 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39089 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240032AbhBDUWK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 15:22:10 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id CCE745C0174;
        Thu,  4 Feb 2021 15:09:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Feb 2021 15:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=3pexGCVdmdeOeWBvdnmebNLp3T
        y3ClHIYREeVlPQR4U=; b=V0MKjrsy2iDCHwspiqJqtqVwJhvZgZ11V8aCvJi3hr
        S7OEvIb4dg7Xa/eAjouNdCr4SdoCL2JHD81HoN78S4qm0I4ITfKDsjBkFLSOilZf
        rn9TMsN93FXVu4taM3VbKw9w9NQTUZjLyfmh7NXwi4DQwtVGMKaZJ++80zwgTeQO
        iu4aOGLSdIu3P1xvcIflC+X33L4MkrwaRimfItW5DyYZz1Qy0D2h9pKk6JllOlrd
        ZAKKlkv1uoI51GlmrvjJpIVNP/KK+pE26CZGTWjXlcOw+WOgc7E9rDgqvX+rrNvu
        VRRgcl9lL2vJTFmlrdpDsTJtcu4XjMKWQMUYMUePB+fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3pexGCVdmdeOeWBvd
        nmebNLp3Ty3ClHIYREeVlPQR4U=; b=ft7WOuUQLqqA7RUfDMztcJogkJAqD8WpS
        Ld5+ndVQhAyQ/0xv3VlgOWp28+WHwSvZWVr+XznLP2v3F5t556QvG+PBgPUe7Y+j
        qY0f5IfuepjyWQjNAPyzzEq33tBk7pXsU/7GAv6aHrThC8iDw9ZB3kysoF+Am+fU
        dUY1kHbOqfJwa9R/p1qLydCop6RhRpn/FGHhQtClaKlNnz9RZpdnOnmZHGAkS4Nn
        0u6EM3LrKjQkbaTrN2tTVSt4tAufxHFLdP6AGBt8PDM7nc1pcqAOl+6u5qhxyV6Y
        33GaRofJAFc3cSic3A07xTBGigDnCpMwWQ+gmFIo8tZUoMkhI2UdA==
X-ME-Sender: <xms:gVQcYPv2tBO5EKl3F0bic5khuVk5DRMj8UA5ZRwfRXOyYdxRWmKlPQ>
    <xme:gVQcYAfHTJs1uqg2a2vTvYHMlrHUpAwLqjmTSgKBv4NCIXqxqCsN0ekI1Y7QqeLsV
    IEcpVqRJky8q1jSzzY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucfkphepudeifedruddugedrudefvddrfeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:gVQcYCxgVZ65Mcx7GieLPw9sfuTYTvT0z_VSN9YAgr1HmyplMqZwXA>
    <xmx:gVQcYOPmNDRmsnMDwLS03mIWEhrRd5U7qdBgI9PJ9FvLx8rXZpSzKA>
    <xmx:gVQcYP8EfrF2Jvior55H6POLLQNZnwE0M3HRr7VItrgEeiz3P3_hXQ>
    <xmx:gVQcYMIzSkEFoXLvKLKoH6cFK0gtbgEdZ7nWFpKIVukJSpe8TJ-D8w>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 621991080059;
        Thu,  4 Feb 2021 15:09:37 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] btrfs-corrupt-block btree data corruption
Date:   Thu,  4 Feb 2021 12:09:30 -0800
Message-Id: <cover.1612468824.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add some more generic corruption to btrfs-corrupt-block which allows
corrupting the data in metadata items.

Motivated by testing fsverity which requires rather specific corruption
of the metadata.

The first patch adds corrupting arbitrary regions of item data with -I.
The second patch adds corrupting holes and prealloc in extent data.

Boris Burkov (2):
  btrfs-progs: corrupt generic item data with btrfs-corrupt-block
  btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block

 btrfs-corrupt-block.c | 93 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 8 deletions(-)

-- 
2.24.1

