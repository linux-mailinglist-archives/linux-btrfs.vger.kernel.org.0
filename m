Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577D07B0F76
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjI0XGc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjI0XGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:06:32 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04698F5;
        Wed, 27 Sep 2023 16:06:31 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 717C85C2919;
        Wed, 27 Sep 2023 19:06:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 27 Sep 2023 19:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695855990; x=
        1695942390; bh=rzFalUu5atlI2uUjvVnXfBx/C1NasgXP9OzHyvnzUl8=; b=t
        LAn4mtePb/xj38JFMiNtLtop6scPM86M3Q5RnActvMT3fmO3G1owmhcssj6zrery
        KJTtx+14Hl9/7jl+iY+FYMmJcKcco2uyiD0pOJYbrCgsul16c4zamomiMSlYIgXD
        zZHzW/ufBsvrzQp5J6SmzwO1AN0MenKc0ubDYaoqOXWkqxBIPxJC3w87vxF2Tz8l
        kfjiUC4wn3OSFL1X7hd2iFHRICfJAfthnoJSgF5vdBFn9Oy/ZDxNtuLyu+vKBSAq
        8dg/9o55ypCpLfpc22u77hM87rLuth1MjquRWVjL5XScRG+WzIe0MPt6aS8Qvxj4
        xSppKTaIODTgITQEdgAGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695855990; x=1695942390; bh=r
        zFalUu5atlI2uUjvVnXfBx/C1NasgXP9OzHyvnzUl8=; b=nQgwhRswp2ZkKUk7x
        syN456Dc8h7Hn9FkMmuafAugIIcgE5YFKUJOmdXkC99F/M8ZLNquQvUSc3drKMsb
        Qhj/zvPRy4PMGjCJ1SY7qIHO96qklyW0eLeUcfnqewIzPBLS06L2usGDoJnBD2jw
        3/R1pTInfseCaM+hiTFBTsdcOo9TvIVyPbY5NCs6UT3/rPCWWam5ZR87XBWeRIC+
        OX8aQSCkTp4PncrsssOziDH/NER1VGXHsd+bWRae5OqORvQ+jiwpvTOpyX2QMljD
        Ni/Ggg3W7dUFJWEKV+f3xkqb30bc4gmgp2sFWEYGclshSn7grqlf4TxlpwV1VZrD
        sqaqQ==
X-ME-Sender: <xms:drUUZRQ7i9VrXg6mEWytEYGj4wPO2Q8sgE_hNFjm-RlxOG_K4n0TCw>
    <xme:drUUZaw7whmVowQV5LT7PkOzG9V-3b8CC0pVezybMgSvtb1A_4gjoBSAfKzAMtZRD
    s8ARByolmoJxUA-J0U>
X-ME-Received: <xmr:drUUZW1IQJvI1H2pZVLyYlTTUnUOutUqvt7fWzak5doKuGimAMLZ4emooOgQT8VvAJpU8pScsVc2FCGBzIP7AO9vaWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:drUUZZAw0GoalOcWAi4MyBh8g0saa5HMoMXOodzfsrygcg5WtXWEfg>
    <xmx:drUUZajRSWfAmyUgtdhzjjwcQoNhPDYSunTAJmj8Tv3UGQFuCLWIFQ>
    <xmx:drUUZdrQkcRJA1fTj4eI6ysrtLG5RWsCmApvn5AJBdRCh8EkQksA8Q>
    <xmx:drUUZea9JqPyVCrMNXcJQPojXkUjfdiYKXVqnBmurZ6s2uZQlXYThw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:06:30 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2 6/6] btrfs: skip squota incompatible tests
Date:   Wed, 27 Sep 2023 16:07:18 -0700
Message-ID: <f321f6571a8293862673188d0bd9d8c26da7703e.1695855635.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695855635.git.boris@bur.io>
References: <cover.1695855635.git.boris@bur.io>
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

These tests cannot succeed if mkfs enable squotas, as they either test
the specifics of qgroups behavior or they test *enabling* squotas. Skip
these in squota mode.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/017 | 1 +
 tests/btrfs/057 | 1 +
 tests/btrfs/091 | 3 ++-
 tests/btrfs/400 | 5 +++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/017 b/tests/btrfs/017
index 622071018..496cc7df1 100755
--- a/tests/btrfs/017
+++ b/tests/btrfs/017
@@ -22,6 +22,7 @@ _begin_fstest auto quick qgroup
 
 _supported_fs btrfs
 _require_scratch
+_require_scratch_qgroup
 _require_cloner
 
 # Currently in btrfs the node/leaf size can not be smaller than the page
diff --git a/tests/btrfs/057 b/tests/btrfs/057
index 782d854a0..e932a6572 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -15,6 +15,7 @@ _begin_fstest auto quick
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
+_require_qgroup_rescan
 
 _scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
 
diff --git a/tests/btrfs/091 b/tests/btrfs/091
index f2cd00b2e..a71e03406 100755
--- a/tests/btrfs/091
+++ b/tests/btrfs/091
@@ -19,6 +19,7 @@ _begin_fstest auto quick qgroup
 _supported_fs btrfs
 _require_scratch
 _require_cp_reflink
+_require_scratch_qgroup
 
 # use largest node/leaf size (64K) to allow the test to be run on arch with
 # page size > 4k.
@@ -35,7 +36,7 @@ _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv2
 _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv3
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_qgroup_rescan $SCRATCH_MNT
 
 $XFS_IO_PROG -f -c "pwrite 0 256K" $SCRATCH_MNT/subv1/file1 | _filter_xfs_io
 cp --reflink $SCRATCH_MNT/subv1/file1 $SCRATCH_MNT/subv2/file1
diff --git a/tests/btrfs/400 b/tests/btrfs/400
index a6d59ba5e..108d9602b 100755
--- a/tests/btrfs/400
+++ b/tests/btrfs/400
@@ -33,6 +33,11 @@ ext_sz=$((128 * m))
 limit_nr=8
 limit=$(($ext_sz * $limit_nr))
 
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+_qgroup_mode $SCRATCH_MNT | grep 'squota' && _notrun "test relies on starting without simple quotas enabled"
+_scratch_unmount
+
 get_qgroup_usage()
 {
 	local qgroupid=$1
-- 
2.42.0

