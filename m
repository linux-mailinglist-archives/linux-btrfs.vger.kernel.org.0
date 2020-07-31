Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15F5233CB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 03:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgGaBDx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 21:03:53 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60009 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728080AbgGaBDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 21:03:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 282185C016A;
        Thu, 30 Jul 2020 21:03:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 30 Jul 2020 21:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=ZEYX26wA9OkR7rzNgVwdD7DIXj
        zXjUlsOuh9Ofl2Np0=; b=NnJFuFl8xdVL3uiilpW9Hl3GLb4i9TiASPgNYM0RXw
        5UyxlCI8DUU/wofGqIeq5EWMi9UsYg+tDuP43IRW7Y8LIGiNgV5R79TF9L61hytr
        ybnN8liTssmY0QJxJvbfjO9b2IrG5GhvWd3L41W4zMMtu4L2b19HzHM4ehYXkQJT
        Nd77xvQSq6LGBju01lNup6LfGMHufk1WaZ0qMYZT2XIpUYGUmwZgN4IVoWFw66XV
        044a9zpvKY5H10vlauX/IDhB69Wr2loYKpp0ldlKWF3bl0fzKwZ1UqllOVEHsyHU
        okcTZkqbMDd5q2Ttylgoo95eO8wgtq07SYOqYJm7IzrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZEYX26wA9OkR7rzNg
        VwdD7DIXjzXjUlsOuh9Ofl2Np0=; b=T5IwXmoaKjN2bgFzf0tr8H6d8IQfY0cUl
        6ZznfIBzsrUTAGG0++Y0jBVX2BeQVCeHUmfaVOnGUzCFwy74s0pLMvHuzi1zFScp
        MZ/JXfua+DterGjn3HY+hBRUKnqhRKpCCo3VtOdBaen3Orb1bcV2x6caAg/6YwwU
        /lqiVTLfqvBttjN/bU6yZyBLeINN3D09qn0BNmndyrOyBj54tU5jUSCzS0k2AxGR
        AdXfgzLLuQnhq7hhty6DnxdvM9WC0SAobw1ysigE18ibSl42urHI26R9wwPFxJyT
        wm3B2/YDA2ZV43Wjk1/U++tc1wwM1MGROE4tnLBEwCz7jAuClLz1g==
X-ME-Sender: <xms:920jXz92BCC9f3gFLm5I483eS1vhHgNBwq3W_QTBzKX8TmeH1u7Jsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrieejgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdffveekheekveejjeeigfeghf
    eijeeluefgkeeiuddvgeevfeejhedtfeevtdejnecuffhomhgrihhnpegvughithhorhgt
    ohhnfhhighdrohhrghenucfkphepjeefrdelfedrvdegjedrudefgeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:920jX_sOLZC0exI2_4ebiElmzINWT0-lPWdZ0h8NbInCt_o5xD4nqQ>
    <xmx:920jXxA7aU-mMw5x9zfQMfnhT_p7ZBinSJ6Z7_mA8QybyXCKL7gFvA>
    <xmx:920jX_fxgfLjal5CWG726NuZsayb9U-wAlPwyFugNzsKCRxV41YSDg>
    <xmx:-G0jXzYGKBFbMybTwukvPbu61c7MGssK7ZHAe4WrCWdXHStPT3klVg>
Received: from localhost.localdomain (c-73-93-247-134.hsd1.ca.comcast.net [73.93.247.134])
        by mail.messagingengine.com (Postfix) with ESMTPA id D7C3B328005E;
        Thu, 30 Jul 2020 21:03:50 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: Update README.md with editorconfig hint
Date:   Thu, 30 Jul 2020 18:03:34 -0700
Message-Id: <20200731010334.47406-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a helpful hint in the README to encourage contributors to install an
editorconfig plugin. This should help maintain source file consistency
in the long term (eg tabs instead of spaces).

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 README.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README.md b/README.md
index 537c77c5..2d5f360f 100644
--- a/README.md
+++ b/README.md
@@ -82,6 +82,10 @@ the patches meet some criteria (often lacking in github contributions):
     substitute in order to allow contributions without much bothering with
     formalities
 
+btrfs-progs is configured with an `.editorconfig`. Please consider installing an
+[EditorConfig](https://editorconfig.org/) plugin for your text editor to help
+maintain source file format consistency.
+
 Documentation updates
 ---------------------
 
-- 
2.27.0

