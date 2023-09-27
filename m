Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D37B0F7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjI0XNl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0XNl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:13:41 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEC0F4;
        Wed, 27 Sep 2023 16:13:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 186A95C290F;
        Wed, 27 Sep 2023 19:13:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Sep 2023 19:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1695856419; x=1695942819; bh=v341R96ajk
        nrj5OagOYD9hy/ub7DKppVsFBBJuN+0lk=; b=fyhi7LXzPB1pWIAQMm864l0OU3
        Vy9Q/drRSszc8k3kGvIeiJFf1Np1U3kJK+b6mRcYzMWCWby7A2bbU1ciIVLLsT02
        7JAJmZbKwKKmQyZd9lL2KRT3xMAgwcpCpFxgw5PlBXZkrdsyf6m/u7q+DCPKkXq/
        8BzTwEFUAYpS4ZFgvnKZ5SDlTKjWIVH+mkjXcX2khOWW/5t87QFlIy8C2Ty7JvgP
        Egek4W+SfUynJzB1b8vWB041HyOOipYQx0CoMC0KBLh7mWA1UthXUNWSt3ADvz0k
        ++Ch+c+088gSdQECGUX3VDUOpjQQrOUNghjRWqryksIIE5nRMhZOlRb8GZZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1695856419; x=1695942819; bh=v341R96ajknrj5OagOYD9hy/ub7D
        KppVsFBBJuN+0lk=; b=DJ/s2kj70C+Hs1hMpAnoTIYGvWW4qXTSGS5t/fGBD4yG
        fGB0tZ2ZSvIoMGRpU5VfQX9knnT8MqkGMgcnKy25KM693lPpVZPFqdAn8TqkL/i1
        XVT+uyT07vcLOhIkGu+WTn9WMcRqUfEF3sYbN4soox1vZU2APHC9dRhi0EhxrOoG
        BJB/TnAVdH6l3ztsFGW5BzeKFIBKCiCLRhibffrD5h2rlN0D0FlfYh9mapuOh/wU
        nx3RBmwh4XG8D+MiIgcZuffcNnA8L63ffGJuvNaHf0nlpDz8xT4gj12ThIA3hHWI
        OxrzfWT4+1lNH7/zwCQsCnlNuMK1lCaAIuxrL+6Hgg==
X-ME-Sender: <xms:IrcUZXygEzEZVPw2m6BNkS9VnrbilRHItuqCMZjC1h4ckeQd65GPbQ>
    <xme:IrcUZfTY0EnkSWphC13nGimjTSu_BMznwb0dvyCkQgEwV1meLyPuk6OiAYu0-vLmD
    W2CHkJC_ckSpxyDbl0>
X-ME-Received: <xmr:IrcUZRXwJ6GjtCLfgUa90hRtjKDBkgFrUSYl3NuKh0Ei5ckAFP85HjXKVxnMhv5U9noO90G8L3RaAAvZ4urOeISEpNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepieeltdffhffhvddtfeegvdeiteelieejjeeitdfhfeegke
    ehveehkeejleekgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:IrcUZRiD800WEKNbZWrxuAwhdKDtjMgFWGzcQhfRj1FC9yBJjs1pSA>
    <xmx:IrcUZZAl2t50-YaG3-CRdprtR4byUdhB3VI0sITkeMka9e6saysXEQ>
    <xmx:IrcUZaL6R-J8N1RzYccWGbYWcTd4zTLgL7kjVJCs5spLgloGPR8oXA>
    <xmx:I7cUZW7ZnkDhWlEIwvYUe1VqrYKZ-RhnsLQu8BzDpFG8enGr6aaqJA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:13:38 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v3 0/6] btrfs: simple quotas fstests
Date:   Wed, 27 Sep 2023 16:14:32 -0700
Message-ID: <cover.1695856385.git.boris@bur.io>
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

Add a new test for specific squota scenarios (btrfs/301)

Also made modifications for passing existing qgroups tests when possible
and for passing all tests with simple quota enabled via mkfs and with
squota-aware `btrfs check`. Since this required reading sysfs files of
scratch fses, did a bit of refactoring to make those checks target a
device rather than assuming TEST_DEV.

btrfs/301 depends on the kernel patchset:
https://lore.kernel.org/linux-btrfs/cover.1694563454.git.boris@bur.io/
and the btrfs-progs patchset:
https://lore.kernel.org/linux-btrfs/cover.1695836680.git.boris@bur.io/
(and config appropriate binaries to use squota-aware versions)
---
Changelog:
v3:
- change btrfs/400 to btrfs/301
v2:
- new sysfs helpers in common
- better gating for the new squota test
- fix various formatting issues
- get rid of noisy dmesg logging

Boris Burkov (6):
  common: refactor sysfs_attr functions
  btrfs: quota mode helpers
  btrfs/301: new test for simple quotas
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
 tests/btrfs/301     | 423 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/301.out |   2 +
 23 files changed, 587 insertions(+), 65 deletions(-)
 create mode 100755 tests/btrfs/301
 create mode 100644 tests/btrfs/301.out

-- 
2.42.0

