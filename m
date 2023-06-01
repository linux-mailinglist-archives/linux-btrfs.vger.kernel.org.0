Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B471F244
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 20:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjFASqQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 14:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjFASqP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 14:46:15 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA3419D
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 11:46:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 924EF5C00C2;
        Thu,  1 Jun 2023 14:46:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Jun 2023 14:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1685645167; x=1685731567; bh=KMzM4APtiS
        D20bABdS1NGBl0Hd8rWwldWrUZ64sYpps=; b=fzZVJH+yFp2S4HNe2ovWdGBpQV
        JgvZriKPEJaGZIqNuLbWHBml8G3sqqc2kr7kgCC2LxlYMGNH/PZax3pMoOjQwLuO
        pSILdCFFT+wKIC7UTTuGXMMDJHsrdZy5E/s8wsz3ZzxIs3tISQ716F2ZUuEK3OlQ
        JjjoE1WNI/m4cbhCXZ38F2s57mYVNH1ZBUSsZyzk/MIFH1eDmzybI0a/gdagmldL
        lflNVx1LhLlpNpA8zyIs1FWzrefH2vuuzbvlLE439gCkcPVWXm6Iho+/RbpyW0qq
        Ut7zTBtq065d1cyZxI5lId2FP+69ryjCvd6nbqC+++BZ6cF+6FMMP4UR4qmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1685645167; x=1685731567; bh=KMzM4APtiSD20bABdS1NGBl0Hd8r
        WwldWrUZ64sYpps=; b=JBG6V0VYpOP444SnsgAF11ifJNiSuFHkj5/oj78D730q
        t06bKwfjULqxCHnSojzHi9ZBnhU+PQ26GicEzJc3pb4Io96qBjKj3eiXJwbfXOPu
        CV3OX4QW9EOWIZUxzw777NlUhFaGC4PNpVWSax6Sh2fU9/ogndWTYtKFjuAQI2mU
        v4Vch3oli19Ol2uSncMmM9P4P5ijsxSLM33Zd0aLnT5jsvHQjaaKiXYDTLOHNgsR
        r27GohUkLi4kAeC2TH3hRBS92+3AaZ0ZMBMnKVtVYHDuazLg/97yY0dBZ34a2+j4
        959JUIAtEKLDslXuezEKottseKLIIjFCPU33Yg+YnA==
X-ME-Sender: <xms:b-d4ZJtFK9a8oNPzpqEDznMhQ40eEp6dRiElun4a2cHqNDi8VdSGcA>
    <xme:b-d4ZCcB0O2cfMDmYgb15vsdr4Y2NJxzqD7dmCZG1tWltmUqdIxXVwl3pMrO_FAKL
    TYtrV-gkraFxevCyUk>
X-ME-Received: <xmr:b-d4ZMzf7ftRlrkYIcmVQDS2mkqTG2h33OSmua0rpDBUz61s1_hl_z-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:b-d4ZAP-THh6H19NwVqdvustO49HFGbr2cnZWUPX2WsGL4MJnHC9ng>
    <xmx:b-d4ZJ-dBmbuEVuOYaVA0KY0gTlbckZuePouSwIpHHLps4KjsUYFGA>
    <xmx:b-d4ZAWT6BP8uWN40h1Ee-tyDcgauibJBvmDU2W8tzXx624mGbsNyw>
    <xmx:b-d4ZLmmdgK_MrDT7bynBQrr61YSX1hxdlmKWzeOzOT6IJFRrJ_4Mw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 14:46:07 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fdmanana@kernel.org
Subject: [PATCH v3 0/2] btrfs: fix logical_to_ino panic in btrfs_map_bio
Date:   Thu,  1 Jun 2023 11:45:52 -0700
Message-Id: <cover.1685644887.git.boris@bur.io>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The gory details are in the second patch, but it is possible to panic
the kernel by running the ioctl BTRFS_IOC_LOGICAL_INO (and V2 of that
ioctl).

The TL;DR of the problem is that we do not properly handle logging a
move from a push_node_left btree balancing operation in the tree mod
log, so it is possible for backref walking using the tree mod log to
construct an invalid extent_buffer and ultimately try to map invalid
bios for block 0 which ultimately hits a null pointer error and panics.

The patch set introduces additional bookkeeping in tree mod log to warn
on this issue and also fixes the issue itself.

---
Changelog:
v3:
- fix bug from missing RB_CLEAR_NODE
- assert on move nr_items = 0 and max_slot < -1
- document max_slot with a comment
- change to ints for max_slot
- get rid of now redundant warning. max_slot=-1, move_dst_end=-1 is "OK"
  though it will assert.
- re-add max_slot setting after move that got lost in v2...
- remove unrelated formatting changes
v2:
- move WARN to before the bad memmove
- change WARN to WARN_ON + btrfs_warn
- fix tm freeing bug in tree_mod_log_insert_move
- unify error handling for tm alloc failures on setting tm=NULL after
  setting ret=PTR_ERR(tm) and then calling kfree unconditionally
- tidying/nits

Boris Burkov (2):
  btrfs: warn on invalid slot in tree mod log rewind
  btrfs: insert tree mod log move in push_node_left

 fs/btrfs/ctree.c        | 11 +++--
 fs/btrfs/tree-mod-log.c | 95 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 93 insertions(+), 13 deletions(-)

-- 
2.40.1

