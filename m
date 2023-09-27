Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1F27B0F83
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjI0XNx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjI0XNv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:13:51 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBCDF5;
        Wed, 27 Sep 2023 16:13:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 54EB15C2806;
        Wed, 27 Sep 2023 19:13:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Sep 2023 19:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695856429; x=
        1695942829; bh=CuKeb7gcDG2KWgI3Hg1tmbpftN4qV0t4VFVG31vkJm0=; b=3
        bKSDvIPfWPX97O5c+CL5hViKS/HLhaApdfGzJJITUbbSf5gc1CHAtQToBcdL2A33
        /IP2OFtN5pea+PKFfNiVw5cLrH2mhqkMOI8YcvBiO3QVDL8CxA0GBb6gHSQy6pc+
        oQX2N4LLPoPSUw9GOIf7iXk27aEk8TCTv7gmiFek3L9alYL+D+muMu+tE5qQO/Gj
        /ByFTWeDyDVJeMCu2lQs0gNf/N+Gycol3RCiv0AWuJCQOh/VJgsW0l0MgjfIi911
        5eW4aAJT++ItWlEb3UQEZGAErsRX7S7iw6sQsCBVyfEyT8KcvRDqSj9ijrg+iT4/
        sDi8mr1SoXCyzyGAvLroA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695856429; x=1695942829; bh=C
        uKeb7gcDG2KWgI3Hg1tmbpftN4qV0t4VFVG31vkJm0=; b=o7hiyutEdcnM3cvSc
        lHCnz4D3RMgu3owix2lcWgCxw2b9CMHxEWqhrIa0YTkS4nJoKbbvffVQoK2WX30z
        kqbZaCX0CigolJ7XrcAzOdkxOEq+XQ/zNRZ2OCprFzde6LNJShoGMacacBG3zx+A
        /QpHL4/LYXcUJNI5XtY0LYER0g79vrdG+5RCYBM7ZMlHLodOakb4O63B1TxQ0Gga
        05BSn+25Lsdlwn0u3Pl/PoxEkavFKKa84MIchjsm+Db/FXRnAQfgkVioa9TwEYpE
        HM7lN10F9pU4op0H3Yuup912pSmjpxUPALzJ8V7rHxZAC+TIXUXdgJ9W1GOgZv0N
        VwjMA==
X-ME-Sender: <xms:LbcUZevItT6_soN5gsaJgFODmXQKbaMIIo1Y9pFlcGk8wC-mgWbYGw>
    <xme:LbcUZTfKg1Azhz9uP5D5-_3Pk-tcjROrB-3WMxjyRS8KFWfF0hQW3kWrVuXmjmVKR
    eOuPqYnJlOtB4r-GLg>
X-ME-Received: <xmr:LbcUZZzb3sMthEi4M2saE4em-mE4HB6g-YcMGG7VG11oUDx_kSMFjNxADuzMDpHUyJVgm7OqcYzWxLlaLicc1FjDNKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:LbcUZZMV5Z_1f7uNnXqEr8EDlqe8Kl3Mpmppx3SaCaGYbz1OHY7WoQ>
    <xmx:LbcUZe8FtH9rRldWO-BpYOMkLeUUn450NGQ78nDxHPL9GfUjYv-FWQ>
    <xmx:LbcUZRXdNVhvzVLPT2Pw_mnGDYR-YrXvXZqsnafWKgSFg5NgKPdjtw>
    <xmx:LbcUZUkghGuB4xUOlkXiySd3w-Ma0KRkLPmEzq9TFK-YD9_O2gdXMQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:13:48 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v3 6/6] btrfs: skip squota incompatible tests
Date:   Wed, 27 Sep 2023 16:14:38 -0700
Message-ID: <bad217d44f555bbd3391ae1517d7c1f38a885ba0.1695856385.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695856385.git.boris@bur.io>
References: <cover.1695856385.git.boris@bur.io>
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
 tests/btrfs/301 | 5 +++++
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
diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 527c25230..f6b55c83f 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
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

