Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9B7491E8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGEXhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGEXhe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:37:34 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823561989
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:37:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EAEEF5C00B4;
        Wed,  5 Jul 2023 19:37:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 05 Jul 2023 19:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1688600252; x=1688686652; bh=+JK4XpH13L
        W45KQQEiacK2s1WUzK9J4m+vOMdtaSkAc=; b=J7zhlbzbPSviWAjyEMNcRWif7i
        RZwTcqUk0gMIlDbviflnPOxeHQIr4+GdjDb3G5rdv1/CLrQzaADDFGPOmQx32pzX
        Y9gZ5bkfQynhkKJ68XMwxrCMh1F/HaxBz81ctOaK0l86v3kdaEFjzRWgEr2/0Dgy
        kxmDbbHa+eNVCnRAVSy7Tx4evkkMkeDg2q4ehYccKB1ifKl3W4SGm/m8dNbsyvgM
        7tmzfC7TeB9w/hUrT2qJeRvh4+5g3ut9XOCAsXsWpg1qgeRyyg2D+E61XwT68k3X
        b6FZqbsC2q0IwkXE9A8dqohvjXI5pBijznt/kbnvWonIS/AELSKdQsFE9yoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1688600252; x=1688686652; bh=+JK4XpH13LW45KQQEiacK2s1WUzK
        9J4m+vOMdtaSkAc=; b=q7WDdQcb4yHIbjaErR09wbvbDUR1jL3wo1cr6xUPS2i0
        8wN0NKfyPbLItnUoNnEShYzZI6IsVktf4WzY6SMXlbpx34s0AkaLuf16cZAhA7N0
        wpPdYwmR44oUbGRDM5E/4H1hRebRoG+gzAjurQlbuqzG8YksRfmBn1u6NqG7pVkH
        oosmIIqFoxTkHF5faqae0ALb3JXX2mAzrhBuwNrZihsRmcuoYJ8WmqMIyp1Zsh3g
        XJawKnfpJSJ8U6AhFWDO4g6nTBj5iTnRz0abulkF+JZy0CnZrN3WnlJITHTXRKN0
        bwgj6eg3jNg7KSmVkxrhVKN3MwvWSgU2aeOvr7MEqg==
X-ME-Sender: <xms:vP6lZASx-sOh8AOHlsTfu8pmZbQpruEXHmy4EQqiqRWb64gdiivxAQ>
    <xme:vP6lZNwSbZwU-7kBmzwq5DAh4c5CcLIND6vUvO21zRaIo5_aPsv4U3HO1ktlq46Z4
    -weG2bZA0N3Vt0XDfw>
X-ME-Received: <xmr:vP6lZN0Hk7tUEhXM1UrD5BipwVavztsqlNdoFtaVz9uSNo4lDydPXfw5ENEMJJQkTqN0eN5wsBzVV748NHosm-FbcuY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:vP6lZEBTSiF7ZtlQHk5TZwns8qhtmPDv7QswNYTcTh-B9Kq4bSZYsg>
    <xmx:vP6lZJi2tG4ErlnwEwddrKNsmCoECrI1YLjMO8dTSlarE7dGz65p5Q>
    <xmx:vP6lZArrBCRf7eQQcLogIrJvAR9yLM3beRyLq0WtStX3ioe_KTbQ4g>
    <xmx:vP6lZJJjFA4_lqxm5laPt6F_9NhdvJTnG4jnabOq5cosX475Kf1oZA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:37:32 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8] btrfs-progs: simple quotas
Date:   Wed,  5 Jul 2023 16:36:19 -0700
Message-ID: <cover.1688599734.git.boris@bur.io>
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

btrfs-progs changes for supporting simple quotas. Notably:
btrfs quota can enable squota via ioctl
mkfs can create an fs with squota enabled
btrfstune can enable squota
btrfs inspect commands dump squota fields
btrfs check validates and repairs squota invariants

Boris Burkov (8):
  btrfs-progs: document squotas
  btrfs-progs: simple quotas kernel definitions
  btrfs-progs: simple quotas dump commands
  btrfs-progs: simple quotas fsck
  btrfs-progs: simple quotas mkfs
  btrfs-progs: simple quotas btrfstune
  btrfs-progs: simple quotas enable cmd
  btrfs-progs: tree-checker: handle owner ref items

 Documentation/btrfs-quota.rst    |   7 +-
 Documentation/ch-quota-intro.rst |  59 +++++++++++
 Documentation/mkfs.btrfs.rst     |   6 ++
 Makefile                         |   2 +-
 check/main.c                     |   2 +
 check/qgroup-verify.c            | 122 ++++++++++++++++++----
 cmds/quota.c                     |  41 ++++++--
 common/fsfeatures.c              |   9 ++
 kernel-shared/accessors.h        |   9 ++
 kernel-shared/ctree.h            |   6 +-
 kernel-shared/print-tree.c       |  27 ++++-
 kernel-shared/tree-checker.c     |   2 +
 kernel-shared/uapi/btrfs.h       |   4 +
 kernel-shared/uapi/btrfs_tree.h  |  12 +++
 mkfs/main.c                      |  63 ++++++++++--
 tune/main.c                      |  13 ++-
 tune/quota.c                     | 169 +++++++++++++++++++++++++++++++
 tune/tune.h                      |   3 +
 18 files changed, 513 insertions(+), 43 deletions(-)
 create mode 100644 tune/quota.c

-- 
2.41.0

