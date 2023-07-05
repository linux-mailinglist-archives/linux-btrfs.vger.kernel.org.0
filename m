Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93D37491FF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjGEXng (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjGEXnf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:43:35 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A174129;
        Wed,  5 Jul 2023 16:43:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B222C5C0219;
        Wed,  5 Jul 2023 19:43:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 19:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1688600613; x=1688687013; bh=fyiir8Oe13
        c5BYoC6MocR2jwwlb1+iuFgB1I7Qe9gs0=; b=Y+uGH9dGGfgkkmuy7t9OiUGv1h
        gSwuVqPxiuohdyjGa2qv249bA0HPrGy7r8YCHgFMg0/SQep0l2oC4e26Aj66swLh
        FNBZuQP88VoXViFr+3XnnxpHG24bMjfB3mT0NoNKDYba1hmD6kypLTEgSf66DFHq
        S9mRxSmX2Dw01M6lndOzd1IfFooPgDyo8woprPicIqnjnAPq7Kt96nwZWi1qzBtJ
        2KvoCefcAp5ZNHQfKrCp+pCIcmWsd7JaRBZOrY8k3/UM0E2qHkbmIOf2Nm0TyUQA
        e3W5EVQsIagW7MdCUdA2a10hss6iiwGPHpb8MksLUvZVDgSY3y1LKA8EIRXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1688600613; x=1688687013; bh=fyiir8Oe13c5BYoC6MocR2jwwlb1
        +iuFgB1I7Qe9gs0=; b=eJX3CebBcGAIv8UCDbpP96aMWoV+Qo5NNUAZOpMHY2T/
        fTc3OTTCftOadQAf7s5o4lCoH1SqwL/OUvrUwt6R+1AIr+zgjEv0F+Z/zQ7WFEie
        keISDDPhS9tIqV3xcxf4CUt4LSFsNKlJ1hrKJcEOxa8W8YXgRRkJv09a8CixqgOm
        1KUt4x2cGmu8MsBjvGGwTfuRHgroeX59fuNgK2jRfaDB5TRwNd7vlTe+za51wE7I
        o4tm1dNtk0Ym7+hD9v4ae5ljpGF145y45ZpKP7D9/543YTB7Vn2pCtR7kgiu9uuj
        irN21ojkBoK+2Ff3Ay6mI14Q7tF9KcIqV3Yx2GN2mA==
X-ME-Sender: <xms:JQCmZPgLCV23UqtV6UxYs4onxKdPyg7eFMsTa6K6jaGMF5zJpx23kg>
    <xme:JQCmZMAEMR4_JkLXWugmRx4dvudO4-068Myfcsf_Qqqxg4P0nbzkAri2Fp9CPeI16
    rCIMAo-bH-O9skiMaY>
X-ME-Received: <xmr:JQCmZPHdg702CYbG6xH8Z_X1DpGunKFwS0hgvQ2boSvTWDfBuYAefaF2LjSs6oj2r4JFHq59Q_8j90W1LgM1KEFV_fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepieeltdffhffhvddtfeegvdeiteelieejjeeitdfhfeegke
    ehveehkeejleekgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:JQCmZMRxmwcuZoWPKs-qb6YGZWiQq7u0PwAPzqoH9kOsJTI7tXXLSw>
    <xmx:JQCmZMxMWfpGgHjr8fqGHBE6BB2l5V8j0qgkTESevYzgEjjS1iHFrA>
    <xmx:JQCmZC6X-wfmcc4g0iUOIO36Fpku-h4LBflS59k5u7LIhn0FkjVQKw>
    <xmx:JQCmZJpxXc8UaC2Cu4Mf8xy5eGcVLovD6RCPvD1XkpvxKt32y4Xa9Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:43:33 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH 0/5] btrfs: simple quotas fstests
Date:   Wed,  5 Jul 2023 16:42:22 -0700
Message-ID: <cover.1688600422.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add new tests (btrfs/400 for now, but intend to grab a real number
before the last version)

Also made modifications for passing existing qgroups tests when possible
and for passing all tests with simple quota enabled via mkfs and with
squota-aware `btrfs check`.

btrfs/400 depends on the kernel patchset:
https://lore.kernel.org/linux-btrfs/cover.1688597211.git.boris@bur.io/T/#t
and the btrfs-progs patchset:
https://lore.kernel.org/linux-btrfs/cover.1688599734.git.boris@bur.io/T/#t
(and config appropriate binaries to use squota-aware versions)

Boris Burkov (5):
  btrfs/400: new test for simple quotas
  common/btrfs: quota mode helpers
  common/btrfs: quota rescan helpers
  btrfs: use new rescan wrapper
  btrfs: skip squota incompatible tests

 common/btrfs        |  68 +++++++
 tests/btrfs/017     |   1 +
 tests/btrfs/022     |   1 +
 tests/btrfs/028     |   2 +-
 tests/btrfs/057     |   1 +
 tests/btrfs/091     |   3 +-
 tests/btrfs/104     |   2 +-
 tests/btrfs/123     |   2 +-
 tests/btrfs/126     |   2 +-
 tests/btrfs/139     |   2 +-
 tests/btrfs/153     |   2 +-
 tests/btrfs/171     |   6 +-
 tests/btrfs/179     |   2 +-
 tests/btrfs/180     |   2 +-
 tests/btrfs/190     |   2 +-
 tests/btrfs/193     |   2 +-
 tests/btrfs/210     |   2 +-
 tests/btrfs/224     |   6 +-
 tests/btrfs/230     |   2 +-
 tests/btrfs/232     |   2 +-
 tests/btrfs/400     | 444 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/400.out |   2 +
 22 files changed, 538 insertions(+), 20 deletions(-)
 create mode 100755 tests/btrfs/400
 create mode 100644 tests/btrfs/400.out

-- 
2.41.0

