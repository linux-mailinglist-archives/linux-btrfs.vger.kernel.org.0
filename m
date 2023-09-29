Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33B07B3910
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjI2Rmk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 13:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjI2Rmj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 13:42:39 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3FD1B0;
        Fri, 29 Sep 2023 10:42:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 750623200912;
        Fri, 29 Sep 2023 13:42:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 29 Sep 2023 13:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1696009353; x=
        1696095753; bh=RmFn27W4xJ6QCZjRU+J2koBQk2XmNSs2EABRQgbdEyE=; b=K
        qDTaDiTKC2EI6B2JmmCHoMKBT2bBID0bZUQErYyL5hxChWz3v1hTaGF3dhO0sG0t
        MDYQfMfKxVzlVP89QRFbgEZKZyFpbsU96PhXNqaZaQsRVDtlykvOvS96Y2hjPDzB
        VQvK5n9R669dTu9jS/jTzrqU+RDenoBI+q4efx/RESkGr903j6rcNDKHk8wi1TYF
        1wWn1KCMn0v2N4XyfD5vDJGJ8qWb7zYSUPIiAGD1mDvJSXEUQrylopDv3cv+MyAg
        qq8Gm8VqH9ji6Nmi63iCEYYIh/cerKQIQBAaFe6gfFZkqhV+pKiczSyMu4v37G6t
        +rYK9SaEFp7r2VJhgJIuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1696009353; x=1696095753; bh=R
        mFn27W4xJ6QCZjRU+J2koBQk2XmNSs2EABRQgbdEyE=; b=bB7hRpC7mxZt9+aYk
        iClj+0eeixFmdSzpJglAXKqfQp2MDrMIP9KkRHj9NTka8iosOdNhYv1XB5rAMmef
        Z7OWgjw2KLidFZghvkjY9puEkkq8EwZ3x/kuDCo+vDF14PepWboDudAjdN+KrMx7
        Wvc2hWg5MK+miqgYA9k6DZZj7L5DCaSO4f3tPTEQ8RQmFIQDQbVjj2ektm2WxPXs
        86+3HrPhU35iPPSOyvo09gjXYxRt+GOcYJQHtu8LgY+loMhDXxZPRmcJs7A15ooq
        ItxD+dCgCO6vDt0WsbjSLGitgs6OeyvBTCyih8LA456k0aDjWVApckYeQuKk+bSY
        nkUvw==
X-ME-Sender: <xms:iQwXZcLip4uqQumuXl_mnrtFDSNKnE2_n7gg9FGcxwCcnbrYu4RXMQ>
    <xme:iQwXZcL0A9sBk2bL7nGz2ooTEB4LC8LMepdDzYYZaPDxwm_Q4mf4gI4Wo_P5sqnuF
    ncOPo1Td6PKs1nWwWI>
X-ME-Received: <xmr:iQwXZcvazaStMqpChEjvy8tvt-SBOhpjxt6j2IvpdGuqiTHaJYp4yof0SwawCpKPbzRPWjXhXMSZZ6VTWJuiPMuI9_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:iQwXZZb2PyAJ73Zn2TqQlO1ArUL03ZloSi8hLoNFijWP9FhL_cDBCg>
    <xmx:iQwXZTaGUtUiXypZomdJw0FStLPyYXcTBxYNxHziT_96JYTW2PWiLA>
    <xmx:iQwXZVBFZgfdpvFkS8u5r8aeRSuW--Z8sqRhp1aYtfko0cZSHHMX2A>
    <xmx:iQwXZSnkl22Sojl9pZvUIgFefvu-Ta8A1gZpxndtaxqYuqwKmXALsg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 13:42:33 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org, anand.jain@oracle.com
Subject: [PATCH] btrfs: fix rescan helper
Date:   Fri, 29 Sep 2023 10:43:30 -0700
Message-ID: <d51adc803f344fb0bb5e63243e94f94f287ac2c0.1696009118.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ea2c732f-68be-74b1-f05e-218ebaa2b359@oracle.com>
References: <ea2c732f-68be-74b1-f05e-218ebaa2b359@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

rescan -w silently handles the case where a rescan is already running.
rescan -W works even in squota mode, so it is insufficient to implement
the requires. Therefore, preface the rescan -w with rescan -W, which
should reliably trigger a real rescan start.

This results in an extra log line reliably appearing in stdout, so also
redirect the output to $seqres.full.

btrfs/022 and btrfs/057 now pass with and without mkfs -O squota.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/btrfs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/btrfs b/common/btrfs
index 34fa3a157..eff8e8386 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -724,7 +724,10 @@ _require_qgroup_rescan()
 	_scratch_mkfs >>$seqres.full 2>&1
 	_scratch_mount
 	_run_btrfs_util_prog quota enable $SCRATCH_MNT
-	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT ||  _notrun "not able to run quota rescan"
+	# Wait for the first rescan.
+	$BTRFS_UTIL_PROG quota rescan -W $SCRATCH_MNT || _notrun "not able to wait on a quota rescan"
+	# Make sure we can start a rescan.
+	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full || _notrun "not able to run quota rescan"
 	_scratch_unmount
 }
 
-- 
2.42.0

