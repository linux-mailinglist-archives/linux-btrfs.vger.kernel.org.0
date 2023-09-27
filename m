Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94D7B0F70
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjI0XGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0XGW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:06:22 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AAEF4;
        Wed, 27 Sep 2023 16:06:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0AA865C2924;
        Wed, 27 Sep 2023 19:06:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 Sep 2023 19:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1695855980; x=1695942380; bh=0ugX3xILH8
        0OBULxpahgdONffdW0qbYIrFln5s8teO8=; b=cQQXs+2mu31dA1l3sxvPhe1jse
        u6JIGDwVA8MJVldPyM0G5xrAsbPezWFCy4iqy2ZyicQksnhZZKgyZKr6thhkLl/F
        1h0cUXE8komdERg6/DiqmhPW/KrtPLB5gBmbfu9HiQbzsnOB+XG2+Um542y3cKM6
        WV2nlWG7mwudphrDLHzoYpse9vegpXbL1yZ3ws8y+GMC+acJcVDG0yCDiK2Jky2U
        KmfeAuzqSudFNOVVY1gtigbtpmlnPIRGVFAe75Wk9Q7Jg4wX2B2XMnr3oQhXHYwU
        fZjcUa6EaF6IReI1pMYbN/F1uKKNjHOOqjh8F0hA42oo/2JLEfYgu4cm1+3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1695855980; x=1695942380; bh=0ugX3xILH80OBULxpahgdONffdW0
        qbYIrFln5s8teO8=; b=N+cGnqqM4jtEJvm8Eec/YJx19zSn5I65yIYcCjn2lAVd
        TGhrMYbAXcc9I6dt+z3eF7i/eTb8rUBKjQzUGL8rZxLpWWBM3fX3z5D9j38FU3lR
        AOMHXpBMQbzGalsRBWYeWkvS5JujDC0bNZHJVtkwPy5O6nrW1kHBIrCyOl3NMro+
        3AHAHqCNtj1cEKjIS9uu6cbE+ovK2oQSUjzOlDCYSnwNojFUZULlq7JgpFyuIX84
        wf4ZI8ATYFi70T/W4AHXqEgWUAU+IwUPQS41nfbagWJ8gQwbUSSWiuMmu45131wi
        2nQPjSBRnttoeYXYvGKFXe5dkPfoVa/zOaiDxcV7Gg==
X-ME-Sender: <xms:a7UUZZl553IFkOeGlo71eSkdEh75Pn9b8lBrBoBqbkLBSE-f_gcOFg>
    <xme:a7UUZU1Y0PI7PvqKqnBB3dG99KXxYg53d-OmBVWA3l_r3Txxjf10fatGFxAcIXeQ8
    hzELpzL2I-L3hkwN8Y>
X-ME-Received: <xmr:a7UUZfoeZ7b5G2ZlIuqk2oNFezIbHRZhAvb6qaI6FJphioVFht0-ptc0lfc9xKYSE--BmFhBiC8xRzRf93pOQxZgNr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepieeltdffhffhvddtfeegvdeiteelieejjeeitdfhfeegke
    ehveehkeejleekgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:a7UUZZk4GO_bSNSm8pNZH6lURHw0TpGfzflAF6glHIAk09IZTOPgKg>
    <xmx:a7UUZX1Tead0Riu0na3AFcdNZL7z3wjA2j3WKukxs1MC8Gcz-xybnw>
    <xmx:a7UUZYt2zS1X99SKstgiVa57e_jYdojL8CyK8Fkafhi6MDDXrFEqgg>
    <xmx:bLUUZQ9eui2kA_ZwvZdrlOEN3TPsNdJASV6iAdmvCSDOjZReWjJUSQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:06:19 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2 0/6] btrfs: simple quotas fstests
Date:   Wed, 27 Sep 2023 16:07:12 -0700
Message-ID: <cover.1695855635.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add new tests (btrfs/400 for now, but intend to grab a real number
before the last version)

Also made modifications for passing existing qgroups tests when possible
and for passing all tests with simple quota enabled via mkfs and with
squota-aware `btrfs check`. Since this required reading sysfs files of
scratch fses, did a bit of refactoring to make those checks target a
device rather than assuming TEST_DEV.

btrfs/400 depends on the kernel patchset:
https://lore.kernel.org/linux-btrfs/cover.1694563454.git.boris@bur.io/
and the btrfs-progs patchset:
https://lore.kernel.org/linux-btrfs/cover.1695836680.git.boris@bur.io/
(and config appropriate binaries to use squota-aware versions)
---
Changelog:
v2:
- new sysfs helpers in common
- better gating for the new squota test
- fix various formatting issues
- get rid of noisy dmesg logging

Boris Burkov (6):
  common: refactor sysfs_attr functions
  btrfs: quota mode helpers
  btrfs/400: new test for simple quotas
  btrfs: quota rescan helpers
  btrfs: use new rescan wrapper
  btrfs: skip squota incompatible tests

 common/btrfs        |  56 ++++++
 common/rc           | 127 ++++++++-----
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
 tests/btrfs/400     | 423 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/400.out |   2 +
 23 files changed, 587 insertions(+), 65 deletions(-)
 create mode 100755 tests/btrfs/400
 create mode 100644 tests/btrfs/400.out

-- 
2.42.0

