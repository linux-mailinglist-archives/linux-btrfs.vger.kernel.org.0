Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C428D22FF2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 03:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgG1B52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 21:57:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38521 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgG1B51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 21:57:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B5EB65C005E;
        Mon, 27 Jul 2020 21:57:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 27 Jul 2020 21:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=y+Hv4bOLu8IzxsdIlE4274tG+6
        Nj2x3476eUq0OndR0=; b=T4YMe+Sw0rU9bPTzWPQUK3ePuQdyZ2A+IbrxlNrKAM
        4WQaMIPNV7Zs4GMDYMRm6uCCjTCTsikhCDCHZ7LNjKYVgicFbTGRZHP5oXADSAH+
        zGCLMGdU5832oI5Go6GvLWPhSqVwSLjnPXBY0QPT7Me9sYam17EYRTWSyq5sq+lm
        NRBukhQdNnpsxY546LhYrWLhCI5k7zE2t2h73o5U85xCsZjmbNUauZQ8z27eOoTJ
        EWh2qpRRwXyZ2t+eop1TT2cLMiW8d+qnZyQXXKIoIRabzOlLOAWTD2L+nKt+aglB
        Raq3a7Yiup9BWz+8fvDBQBshbXqrBtGqaXpJISQYiVug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=y+Hv4bOLu8IzxsdIl
        E4274tG+6Nj2x3476eUq0OndR0=; b=W7o2r/7rfTsNh2PX/jQ6/Q64eUzUn97po
        vdYPEqmmK3sY/ggktNTT50R+zgMKM2oO9d1IFzs0CxPdbpjK3u8aDnMExn4LNpZd
        WpRhihhe4LgbZ+J6zfSaYD2h73Vo3da5gvztuqIsCaPLu3kb7yDRR1LUuDdM6qRt
        5//RucO8eqVNQLDza2Bs4ZYJvDwIFqAaUxyuwW931hJw7iHzfwrY5TAQQLLBCSO3
        8YTO77qwEPKJZbABahux87kHLgOPw27owodx+Ry/FpfFd7mps1OfHX/b0zBpYdPQ
        aHLDAlGp+sgWsnDGZYOqQBAlPawjSsO6OdCINYj7rsx6Lt75R+jGQ==
X-ME-Sender: <xms:BoYfX7qyC_iKO_XA4WAgaW7D_FuWUnFq398fI3bWNjm7-XZHm5yB0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedriedugdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdffveekheekveejjeeigfeghf
    eijeeluefgkeeiuddvgeevfeejhedtfeevtdejnecuffhomhgrihhnpegvughithhorhgt
    ohhnfhhighdrohhrghenucfkphepjeefrdelfedrvdegjedrudefgeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:BoYfX1pR_HY744vEWc5RChXZftaXToKgfAt3l6CQGAF4d2GeUKW28Q>
    <xmx:BoYfX4PX3Vx0m4Nzb6wJc_lHCaAuovgHBeAMFfHRVMOJDwn1JdoaQQ>
    <xmx:BoYfX-7gu2UdG1IETsru69pQKQwu07VmgQxHjrhYVpuhlsjGTEIaEw>
    <xmx:BoYfX3WV0yTmMSAytzUMl7uUnLFUJVyIbF0MhiJjAkPDM2wFfGpMBA>
Received: from localhost.localdomain (c-73-93-247-134.hsd1.ca.comcast.net [73.93.247.134])
        by mail.messagingengine.com (Postfix) with ESMTPA id B155830600B7;
        Mon, 27 Jul 2020 21:57:25 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH v2] btrfs-progs: Add basic .editorconfig
Date:   Mon, 27 Jul 2020 18:57:15 -0700
Message-Id: <20200728015715.142747-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Not all contributors work on projects that use linux kernel coding
style. This commit adds a basic editorconfig [0] to assist contributors
with managing configuration.

[0]: https://editorconfig.org/

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
Changes from V1:
* use tabs instead of spaces

 .editorconfig | 10 ++++++++++
 .gitignore    |  1 +
 2 files changed, 11 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 00000000..7e15c503
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,10 @@
+[*]
+end_of_line = lf
+insert_final_newline = true
+trim_trailing_whitespace = true
+charset = utf-8
+indent_style = tab
+indent_size = 8
+
+[*.py]
+indent_size = 4
diff --git a/.gitignore b/.gitignore
index aadf9ae7..1c70ec94 100644
--- a/.gitignore
+++ b/.gitignore
@@ -65,6 +65,7 @@
 /cscope.in.out
 /cscope.po.out
 .*
+!.editorconfig

 /Documentation/Makefile
 /Documentation/*.html
--
2.27.0

