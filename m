Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020AB749205
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjGEXno (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjGEXnn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:43:43 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D289A10F5;
        Wed,  5 Jul 2023 16:43:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C1685C0219;
        Wed,  5 Jul 2023 19:43:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 05 Jul 2023 19:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600622; x=
        1688687022; bh=aBayHqKavYXrgYFyNe4SuqiEedKcdOoJYCEvYtGmLAU=; b=T
        4sGektRsFXUh4oPgPQgpIrB36aPU4sZBYmAdiaSOIiZBaF7/RqIg7HCD8yBUZVBD
        Cu0CmZJmJSmtRsZ2n1Ghf/ljChzFpoSNOgy6A+n23m46gm/t0tgY1hsCICyQPgQn
        hvDye1hVHhephl5OfNHS4UMfv4w4bS5yLnCro/wQGkB/tP90r4KB8f+2YdDG3AhE
        StPz/Xe8lrMOzkAEvuKjngu8G2cWtrkNaeF2eUugFReuhYbxdW1GYrXge1XeWX0s
        YwTEeDpWGrU47tgVrHD0BfHNtOL2WbPXe9GZ4c/efy0vq22wDCI+lgEfjPqaHrAL
        HYx5P+CKq4YtnUxH+ObHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600622; x=1688687022; bh=a
        BayHqKavYXrgYFyNe4SuqiEedKcdOoJYCEvYtGmLAU=; b=DuntRNMb4N2VJ2dqr
        DEEgezSH5odiHuE1caSqdaOYmm+cbkn5TR3kaXMD4FDyqKUhS0jQiNZm8y1XDj8B
        323LcFDXKb71qCcYKyga6ysFVUFdyCqRcDO2Gzx/6gahIpC+bCyU+XPYFf90eDEr
        IVSd4xJAASJsZW8J7yZw7s+CcRD6P4N6yJmI5s0ORwD1lfPPZtJIWivTQudDMc3V
        0Kj4+3dHWMYmu+prgA9lCovuhPcBHW+VzfPtBGjiPZO1+9x/Oqoa7M8SO8WYHwJb
        FqvDNvx8kAEjS7pzwh06+oHk0s+qXHGhHZZbIVGVIATIsX/BPzKq0mj4MhU5kHM9
        ziA0Q==
X-ME-Sender: <xms:LgCmZP-DzXRQeuotvBJFlU10D7DmpxDKIzILAg9Mge98ZOJnI9vxOw>
    <xme:LgCmZLtpInkQxCnhcA7JmDxTfHkSO11ptcjjMvOhFL6nhCjVwdHqLXoAvFCdyvy3G
    vr7OSoTl92KV7qv_Os>
X-ME-Received: <xmr:LgCmZNBeaRg3jRpg_rwsIvrmv6OxFU2hJ2x4jbppPviQ-TliA_60S7ZGm4Xd_2Dhtoo2fI25Z2BZ4uHWdJLEtbPZ-dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:LgCmZLeqrxzYCuzTa0uoVxAgOIiHmo-Tm4P1zs7JOZxu_H45GCRwlA>
    <xmx:LgCmZEPeI1lDZyuCbi6CE8iaR8i9Tpm-xr6JHJWVglt_iCfEz-40Dw>
    <xmx:LgCmZNlwoK4gbO-UPYEZxxu37sxaKFZtqzCRwaImfjieNW8bmYdxkQ>
    <xmx:LgCmZO21dj6RyQqS57IkBX9v7Hc9YSQzbbeXRh0mTJ-YqEATKDGiLA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:43:41 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH 5/5] btrfs: skip squota incompatible tests
Date:   Wed,  5 Jul 2023 16:42:27 -0700
Message-ID: <f41f220de0b8e57efc668c3bbf99769898904f0b.1688600422.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688600422.git.boris@bur.io>
References: <cover.1688600422.git.boris@bur.io>
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
index c3548d42e..e05f259d0 100755
--- a/tests/btrfs/400
+++ b/tests/btrfs/400
@@ -32,6 +32,11 @@ EXT_SZ=$((128 * M))
 LIMIT_NR=8
 LIMIT=$(($EXT_SZ * $LIMIT_NR))
 
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+_qgroup_mode $SCRATCH_MNT | grep 'squota' && _notrun "test relies on starting without simple quotas enabled"
+_scratch_unmount
+
 get_qgroup_usage()
 {
 	local qgroupid=$1
-- 
2.41.0

