Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10A1496E49
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jan 2022 00:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiAVX2o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jan 2022 18:28:44 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:53623 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231288AbiAVX2n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jan 2022 18:28:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 351E532009E8
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Jan 2022 18:28:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 22 Jan 2022 18:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=B6W4oau+v3nIGhZM9ye8AUzsiryTaDH67bC9adGje/Q=; b=II+Z5
        gFLaVYkmGzuBYVluXy48rg7R070K7uC611bTE+BwKkWQtpytrCgwmqFByS7OaHqy
        L8V7H+KLvlBWwUUWJIZzPm/ZVUfrrtbCPvuhM0eNfZeoLfMvfoBdXfinYjCC2kMq
        F7q8nqymW14/RvE5ty9zYxtLNWVI+9h4Lkes8vo9xn13uEYmIY+cCqUyNe9exazP
        CPeu9y+se2h26YL2Bg141MySxth0RNLnddHVwMhNWDq861jEGNEwbd+oABGcpf5i
        KQQHJ1vjo0c/irvaGyR3tkW7gg9aK4X7ke0ukkVBkc7LLE1TV1TOROrfdJ8h+81r
        VEolkiQK9HIO+c8SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=B6W4oau+v3nIGhZM9ye8AUzsiryTa
        DH67bC9adGje/Q=; b=dsTuW7QUxgz5I/QstRALoe0YE19KXQRBi3XAp1xb91elZ
        PcBHl+bUkromBKNkgX+eK7r4l+QktQZVP1o526cY/r39L0rgflLhODF8cmX+mSDp
        3ptGKC+iqAiow/U1QyYusSb1aTNnfS05JO57MKTzfaKtyYK0gL+7ocU3n6DlBxdk
        I7+/Jwo/xLCkWs8n52B3ppm9ANvvDv42hCrEk4Rpk2BFhrrd+SUYQUfh1X07sCjo
        oNV0hiOVjOkvL//Yxfu7h1Zl0y8LO293mDhFNUMg7zvil/7s0I/aU12jfKeRN+gF
        G42byZ/1Q5XIRZHcVq5ez0++1IVQZUi89NR03PhUQ==
X-ME-Sender: <xms:KZPsYZeoBNqJwHS4XT1--_JwrQC3bO9HnZ4F6KKNHrCQ8BEtQx5pgw>
    <xme:KZPsYXOOnai5_CDuMoiYQt-FX_OTH-l7m_qVHVXM2nYTrr-8F2Mbz2gzOan9Y4WVt
    mbRzIr8Oen5vjlZcA>
X-ME-Received: <xmr:KZPsYShRdVwxMSxNnyLOd1c9XJUjjeWMmvsOGp2CdUB4xHeEusEyb3xNIkrrgsUJZ_eOTtSTWtU0UrXOlVfJG0K9KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdefgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeen
    ucggtffrrghtthgvrhhnpeehvdffgffhteeijefgteeftdfghfdvheeuhedvjedugfeggf
    eljefgleefvefgfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehqhihlihhsshesvghvvgdrqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:KZPsYS_qoIqrvj91I0BypjIpDnzM1tbe_UYxUxVli_ac16kGDG7tkA>
    <xmx:KZPsYVu0gXrHT9R57c-I3m7vx7xZRwCX1pUTr-e7LeXP-gajZtYNog>
    <xmx:KZPsYREpDmDmAN0njeKbDLDL0DC9IqWVI5dw_lvQnWn2RoO2R8lOmQ>
    <xmx:KZPsYa78KwtcaMDaFyPEKu7a4N6q94GGz-pQnPnzsRBzp1aQm95iTQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Sat, 22 Jan 2022 18:28:41 -0500 (EST)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 3461880F7; Sat, 22 Jan 2022 23:28:39 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     linux-btrfs@vger.kernel.org
Cc:     Alyssa Ross <hi@alyssa.is>
Subject: [PATCH] btrfs-progs: docs: fix typo in btrfs-balance(8)
Date:   Sat, 22 Jan 2022 23:28:33 +0000
Message-Id: <20220122232833.304515-1-hi@alyssa.is>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 Documentation/btrfs-balance.asciidoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/btrfs-balance.asciidoc b/Documentation/btrfs-balance.asciidoc
index feccea48..e7620cca 100644
--- a/Documentation/btrfs-balance.asciidoc
+++ b/Documentation/btrfs-balance.asciidoc
@@ -27,7 +27,8 @@ is temporarily stored as an internal state and will be resumed upon mount,
 unless the mount option 'skip_balance' is specified.
 
 WARNING: running balance without filters will take a lot of time as it basically
-move data/metadata from the whol filesystem and needs to update all block pointers.
+move data/metadata from the whole filesystem and needs to update all block
+pointers.
 
 The filters can be used to perform following actions:
 

base-commit: 8ad326b2f28c044cb6ed9016d7c3285e23b673c8
-- 
2.33.0

