Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88E15F5ABA
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 21:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJETta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 15:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJETt2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 15:49:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E477F246
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 12:49:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4705F5C00D5;
        Wed,  5 Oct 2022 15:49:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 05 Oct 2022 15:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1664999364; x=1665085764; bh=/AOSmRC76ykDZP5lXD9Ed+48E
        B0O/T9Xt1U+zFmQXH8=; b=Ac+L93f7cGo/3gGNU/+6DIMmHvekZv1qa0Jx92qxa
        ldA7ozk1n/F7Djbj3WEsWcILDZPlSVlFLe7BRccpOWbhQAEIHDvZkrokJFEVOvXE
        LlPA6b6hpz0yL4wISVoX231Z8abgjYzfspa8S2U1vo2b2yLmV1ODHUzt3Ze7aS3u
        ETc7Q6XSPkGFFKB7RPVToFtn+ghfJVF/xOqpHYpjvhpmLIIlgtMOamhveHRT8PMU
        V0zUBmTSiRm0huJTtq8AhdeuI22kAgSTKyyxbrwFJVfD6qKSFSzsgP0OHGgItCDL
        pJ/ByJL2QVVUjVwxAzdsyHo7H5Z3D8Hl4NyIokGleaklA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1664999364; x=1665085764; bh=/AOSmRC76ykDZP5lXD9Ed+48EB0O/T9Xt1U
        +zFmQXH8=; b=sGb3uxEH1Q7iGRuYR70ofbvw84mnm9k3rlfvvIudoEPYdRtAbOo
        dllSWKxeEXqQEdnl+B/icnvAjEW/NIePtCo0hT9ve1Ga+dL4ldennjxoRV+oN4ka
        gGUOSVcoRFz/+srV2qz5MT3ug8gkcZAqpU1u1oBMeiMIx9deVDgwx84zITrtmDX8
        Ntbed4e7mZPvh924Mm8VqU4x0vxNL6Kp1zxBX3GheaHrV8o9g9B2wTKas5/7s+8h
        Cq6+YvhwpkFqShIetYMGRuA7FS/nH9NqjPxghLYWUF4H0uT3gDdie53IeuL+HhmC
        4rVmo1SsSJfIHGY+D0CHzDiQ335BvKO2ztg==
X-ME-Sender: <xms:w989Y4Aq3Kwb8tP2R6ZeLVRrD67ltvg3Fwnrpz3JfPo3xCzsoEwMCQ>
    <xme:w989Y6g049320sqwCp8HTnltmLwAQQ2FUYA0jXnSRjlCTqM_d5VfmNwjqUZOJcwbj
    gkA915Hgi_Z58h4iHM>
X-ME-Received: <xmr:w989Y7mzTM1FTOMMGcn3xnZF6NtsGmVOgqQQa0nishP9uwfWARM2fW28LXeF8q6sZkOrQy9GH2DB01LgOybfv-EyCiza4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:xN89Y-wnkLTMsO5l5G-XqyeaIBZZklRMGZ_x7mrwc_SILchikDIGtQ>
    <xmx:xN89Y9TLEhefmlNu84kBfM07gP8jiIWCrmmlX9qMq1aTO7jBX_AV3A>
    <xmx:xN89Y5bdd_YKXN-HeNp4DomA51N3N_s9ETXfizW-t7DAMk_kh9jwpQ>
    <xmx:xN89Y-4ujSN2M2hp2N3L1vUntnFubWq4Ta7lRJ7JE0qE3MSBoTbOrw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Oct 2022 15:49:23 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5] btrfs: data block group size classes
Date:   Wed,  5 Oct 2022 12:49:17 -0700
Message-Id: <cover.1664999303.git.boris@bur.io>
X-Mailer: git-send-email 2.37.2
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

This patch set introduces the notion of size classes to the block group
allocator for data block groups. This is specifically useful because the
first fit allocator tends to perform poorly when large extents free up
in older block groups and small writes suddenly shift there. Generally,
it should lead to slightly more predictable allocator behavior as the
gaps left by frees will be used by allocations of a similar size.

Details about the changes and performance testing are in the individual
commit messages.

The last two patches constitute the business of the change. One adds the
size classes and the other handles the fact that we don't want to
persist the size class, so we don't know it when we first load a block
group.

Boris Burkov (5):
  btrfs: 1G falloc extents
  btrfs: use ffe_ctl in btrfs allocator tracepoints
  btrfs: add more ffe tracepoints
  btrfs: introduce size class to block group allocator
  btrfs: load block group size class when caching

 fs/btrfs/block-group.c       | 234 ++++++++++++++++++++++++++++++++---
 fs/btrfs/block-group.h       |  15 ++-
 fs/btrfs/extent-tree.c       | 166 +++++++------------------
 fs/btrfs/extent-tree.h       |  86 +++++++++++++
 fs/btrfs/inode.c             |   2 +-
 fs/btrfs/super.c             |   1 +
 include/trace/events/btrfs.h | 128 +++++++++++++++----
 7 files changed, 472 insertions(+), 160 deletions(-)
 create mode 100644 fs/btrfs/extent-tree.h

-- 
2.37.2

