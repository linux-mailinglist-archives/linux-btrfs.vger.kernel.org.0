Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4502871F26E
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFASzb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFASza (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 14:55:30 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F87C18C
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 11:55:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C722C5C01B9;
        Thu,  1 Jun 2023 14:55:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Jun 2023 14:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1685645727; x=1685732127; bh=vYcDTMS6Ro
        ErC6adSrjZMG8rKznyqSQtufhrmNa9YfI=; b=GJA2O9wWg7v3QDtZO/DrF9Q2li
        0+oPyPBDRRVFq/qVs6wRUF3jN+FqUSd727orwrImSKaNjXL0Ox3Lv7WWjmoVVaKf
        aRwfgHOd7/BCAnKNCS6u772ZkzsGGPJM39CSP7V6kIg7tvFqaQFafNp45fncGbyL
        ovc11ysGCZCruyFOAR49KZbItmoY0+6z6kjJVPJNTpREpR6GlPW3TIxMNai0f1qK
        JXRQNbWG2yPJ+QBf0FGyCa344d1kQfRjzjLuMi63txYT+zGxFf8Q0VzY9CPBu6ci
        ZM9CmC2jgwubqzRjuTqEz6ahET7CjmULQrciSDp6dkZfAsQIg+K4FezQUS+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1685645727; x=1685732127; bh=vYcDTMS6RoErC6adSrjZMG8rKzny
        qSQtufhrmNa9YfI=; b=UiY7ZrBIW+dPnI1QYnOJ2mRLN7sUJGNSGtAsXQia9QP2
        UVhRSTM745XpLFtmbjnpJizaA+Tdmc16WFNK4Ok8gIOX6Akqh6DMy92SbIBRAL9k
        eMOCPOPl9CVK+/daF1AQkC1PFKB1nspn1bQ5fLC0xt+O1Cb85XL2ej/IfMJtOdRL
        cOeX8snsu0KfzcKybGY1LH9cK9Cboz8NRT/ZhoBg7v30SHbUpA1yiKIujlhBbAGY
        fmeP5/YRz49/nAAuu4G1NCwE1EG+S9awHiB/LLGxikP8rHHme43C4MHajYAMbkFg
        dNXgGArCBj/2YjYZpsRtS7pgbRBRaQEJMTvUcX5KkQ==
X-ME-Sender: <xms:n-l4ZBVGRkuekKEylkX-pJvLcOge8SyJMEtfSTN9qzad4siVv9HA7A>
    <xme:n-l4ZBnRNEmDTXosBl1XQ_smZrdrf3bR5NGv_36bP4oC0_J_Xn3dhw0JDWMMhWJuS
    XjGsIyeVqicQefx_I4>
X-ME-Received: <xmr:n-l4ZNbVxQe3nOnViv37Dw9e9P61xHAg5ZWZa2FPdKp1rdCQNSmOywSL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:n-l4ZEW8hQdAgZ5n3nkH76Fmm73ibHmKEYYsuYTcQuBob0d-DzZHmg>
    <xmx:n-l4ZLnr9vzB3rcdi3ze806_zgjrHQR4Dcwnl-4P6Ol-KkI6Qw_xmA>
    <xmx:n-l4ZBcwXcpQYdSHXo6mYm3YiqJuWjIpq2ssMQinWEySeg1Vi4gx4w>
    <xmx:n-l4ZDsrfDQkxXFKZ3rGgJUW_jpsGEjvZ23YWhJLNYphZNSwOYxM8A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 14:55:27 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fdmanana@kernel.org
Subject: [PATCH v4 0/2] btrfs: fix logical_to_ino panic in btrfs_map_bio
Date:   Thu,  1 Jun 2023 11:55:12 -0700
Message-Id: <cover.1685645613.git.boris@bur.io>
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
v4:
- actually include the changes to Patch 1 cited in v3, my mistake.
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

 fs/btrfs/ctree.c        |  11 ++--
 fs/btrfs/tree-mod-log.c | 114 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 112 insertions(+), 13 deletions(-)

-- 
2.40.1

