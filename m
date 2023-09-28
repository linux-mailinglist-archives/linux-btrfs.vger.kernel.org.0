Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469AB7B28B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 01:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjI1XQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 19:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjI1XQJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 19:16:09 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBAA19E;
        Thu, 28 Sep 2023 16:16:07 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DE3D65C0130;
        Thu, 28 Sep 2023 19:16:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 28 Sep 2023 19:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695942966; x=
        1696029366; bh=IJ1AtBs/+gvrd7LgN9ORPYT44X0HNrNvDB6Q80vzeH0=; b=a
        vn9i9ZJSaXN5/v1SKAEVoaaSoSOBTpnRvp2Ri2mEtbezx+PM53rr6ho+yiGfJQey
        zdCNWh/FVsjm/a6d9QWSnQqMBWxAVNv5wzvJkt2ZHcsvBPhSoJRzoL1P1t2A+7OI
        9E2CaQcuqaSHBtXyQPsITZ5p4QxDR/lhD7/KTpJwVljfB9qEiQqY+DQ8l9COxlCd
        lR4w1ae7CygMlt3WlanqF2KNCnmzsD5j0qEJ1hFwGJg8d/e1WY1i2BGO8O/jTHg6
        62h+HvDQ7wrR6co7Rfupt8aD29/JfhTuR+jzWbpabt3R0Z3gF+bxj+oubq0lHXmA
        XDUasKCI3GkEkhPcuTZSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695942966; x=1696029366; bh=I
        J1AtBs/+gvrd7LgN9ORPYT44X0HNrNvDB6Q80vzeH0=; b=ijXznA//kwP/7awba
        jzMomBpmPqRlm2oI5Etw0+UQInknyAWnOqVkLtvoqhRxMjqLyiCcmmdyZWcOn4jw
        UbapNzAmAy3+gLqy2WuGBtjziOzh8ZobBt8ubQk40OKD/9z0KNIbC7X2hQOn6d3L
        mX9MJ3W3zRfojOCWvuks6akpzj2i4B9R97StmFnoxCYvD3/6ntr7W3qlyEvrbCKt
        SnwSVTMGmnwkWtY02H9NjiKR6SL2kku92LGeoPfWY5M0bWRyStvPdd1Z7mriotY0
        jUGM8M59S091jt5iH8OgDnUJCdYq5s4wgZPGD0fEeW4tKlaeGR3XTc8C23MtX5fx
        xxhoA==
X-ME-Sender: <xms:NgkWZXz0ieIj4ygiocnQ02JNGUG2xQyRMB42Sge5KPHMVqm38kISAA>
    <xme:NgkWZfScqpidFatTHqGOn6Lzg4mWr8ol9I65eZ-xdY534ONh6yGWQGaAQijlHH99C
    Gku_FIhs_zAZCDyEyU>
X-ME-Received: <xmr:NgkWZRVk-Ik9X5GbfL2hmZ1mRYSzwBB2KgU493NDgQukAV59eCz39mAcbsusFoq-VrKILealp2dD2sc2y9SUomWTjhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddugddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:NgkWZRjn7KbDM2t9J7weBZQO1ZYrf87LLCdXMdBovX8J7kvtrYcNpA>
    <xmx:NgkWZZC54QCuUHXfKcPvGD-4KiQ5LRcNpxi7osUv20ECcLIEKipG9Q>
    <xmx:NgkWZaL-eZ79yc_f5roLKC2D-pn_-vXvLnXbdYdz0NlbcYRLyKHwPQ>
    <xmx:NgkWZW694BE-Q18tpBBKnyvmnRF_bPF3qdrKogPp7hgy6vBVurMu0A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 19:16:06 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v4 6/6] btrfs: skip squota incompatible tests
Date:   Thu, 28 Sep 2023 16:16:48 -0700
Message-ID: <32ac4b162efb7356eb02398446f9cc082344436f.1695942727.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695942727.git.boris@bur.io>
References: <cover.1695942727.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 3 files changed, 4 insertions(+), 1 deletion(-)

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
-- 
2.42.0

