Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140FB749202
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjGEXnl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjGEXnk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:43:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A5B129;
        Wed,  5 Jul 2023 16:43:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D2B605C0219;
        Wed,  5 Jul 2023 19:43:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 19:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600618; x=
        1688687018; bh=+i6Cr6FLp8Jnxqu3nf2JljcSF75fpl4+hJuCRs9uTKw=; b=g
        tb7Q2GsFwR183atTG+RiaTyz3azBE0lXwbF+wHqgZdC6TrmwJUm/ACYd5mJQqr4T
        r/aHfsTRjePuKSNFg3f7rqmnApljDUWFvV1TjC+Npxc7sQGLkNTMqUu43FUPKC9+
        A2p1Iie4rNSl4hE2lUjN5P0uwvxI2Tjb/JE+RYMpCQH71rO/2LfxAxkUs1MbTh0+
        1ekqwmUBIgmjTgF9wvnd4xyTjhsp8mtqy6V8nQT2xrDfkY8IivpNSf7AOd4rwdHQ
        dqcCdz3oKvyzIcrpvQH4xuKRtAiysTF92QABo+1BSry7zAID51nUPAEMbtrDpzqL
        HKYQqmzJCs65LcxomTL7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600618; x=1688687018; bh=+
        i6Cr6FLp8Jnxqu3nf2JljcSF75fpl4+hJuCRs9uTKw=; b=LPuRfZ9OGdSwkvj4Z
        n3JU0Nq1Lw9uTCK1Yg9nm3OXf79rebIbcaggoW+QTonJLzNXyKEG7GSz5LIsBZhd
        HO53ipL7HNDxUi+G+GQS0ll3uaUZ2Kl2uYMhFqrB6lgwWch5iEiJMnmjZP+aVZPZ
        H41phVVstadcw4wtZ5nj3kWT1UGIiepFk9tT3bhkzYyZEAUcLimbRzS32mkDjN2L
        BYD/1pqx+1OkJkIoLswA78pwOMm8go+SN4ykR9Ooci0MWUa6xZwMxtHiPfttGrcl
        6CHFi3FDuwGxxfBHdmpCqHEaSLcyL9O5FaowWRrBZwQBp6+bYuWCgCpIikuIEHLb
        1HI/A==
X-ME-Sender: <xms:KgCmZG4dEmvsMLJBiN0TLGR5NnfndE5WE5aFmanL-u94fIw-gPQnqw>
    <xme:KgCmZP53haoNujZuCGKQziFgIk8xtWHhSUrPx1JC2bwW1HxXiWWQRJ2sK2GLuZvpO
    iA1rAzjozgcyhENoJw>
X-ME-Received: <xmr:KgCmZFejKl6yoD4QrcVk9UTIavruOO0EBuOmrlHzZT3ZaF5m6kKzYkh0oLxxjjJ2c4w_-YBcAdhQOrevNl1mFvL42SU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:KgCmZDIi_7Hp7Tlnw5bL0n7d43pvQrlzNhN2o0Y631fDLzdgjbZkQw>
    <xmx:KgCmZKI_tiA_nRlcAzaIFZ0Jl0ntEG87nz75q0kJ-M5ACvaQQgN7zw>
    <xmx:KgCmZExAA1GV4qq54MXGztJEuHy2uvOh5tQGo4ge0z5ou0V132kLBg>
    <xmx:KgCmZMiBsYJwU63xI3c9pNz1HSSJqdl9OPrG1IbrALyRzGXjaVr2Gg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:43:38 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH 3/5] common/btrfs: quota rescan helpers
Date:   Wed,  5 Jul 2023 16:42:25 -0700
Message-ID: <0e9cb76f3ddad71bb36b70464b62423b77fd6399.1688600422.git.boris@bur.io>
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

Many btrfs tests explicitly trigger quota rescan. This is not a
meaningful operation for simple quotas, so we wrap it in a helper that
doesn't blow up quite so badly and lets us run those tests where the
rescan is a qgroup detail.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/btrfs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 66c065a10..d88feaded 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -715,6 +715,31 @@ _qgroup_mode()
 	fi
 }
 
+_check_regular_qgroup()
+{
+	local mnt=$1
+
+	_qgroup_mode $mnt | grep -q 'qgroup'
+}
+
+_qgroup_rescan()
+{
+	local mnt=$1
+
+	_check_regular_qgroup $mnt || return 1
+	_run_btrfs_util_prog quota rescan -w $mnt
+}
+
+_require_qgroup_rescan()
+{
+	_scratch_mkfs >>$seqres.full 2>&1
+	_scratch_mount
+    _run_btrfs_util_prog quota enable $SCRATCH_MNT
+    $BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT || \
+         _notrun "not able to run quota rescan"
+	_scratch_unmount
+}
+
 _require_scratch_qgroup()
 {
 	_scratch_mkfs >>$seqres.full 2>&1
-- 
2.41.0

