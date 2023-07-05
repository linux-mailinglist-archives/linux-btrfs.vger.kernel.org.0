Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B740749201
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjGEXnj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjGEXni (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:43:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B609129;
        Wed,  5 Jul 2023 16:43:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 132F25C0225;
        Wed,  5 Jul 2023 19:43:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 19:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600617; x=
        1688687017; bh=rTQsD8RxB2wP7/jpatNWxh24EyNHQD+1wCTHp9DkLyA=; b=K
        xi0FEJUtaMYLuVPbP64y6k85yu8XqADQ9S/klavIIWOW2zejcKuOYkGJjL1R3g9T
        r+5M1UW9ofYLWZLl39F+ABwUkfNJM76rBkLHzPW5T4z0p2i91nOn531GpQw7tzxA
        fB4SOpd/QGO+zzuASaRNctqpv1AtcgHYz/pKuk0I9qpPZEzttuS3uIAduN3S6FTT
        uM+A/SXGrClDuuaAQU69/fFKaXJRBVFuGu5/entrYrJkBE/QwSYYhM+gyiqjSa3o
        32bikUhSnNcIlssLTUjPnvcqiUzQKkCK0nPLEONWWlrMuHBwxE57pgAMH+poQCXl
        VkJrlVlpycSzUCnh85qUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600617; x=1688687017; bh=r
        TQsD8RxB2wP7/jpatNWxh24EyNHQD+1wCTHp9DkLyA=; b=Teyqg3wKdQgov7XuU
        Hl08rLl5KrmzC1L47Eczy3fyXV0cDNCV6aOFHq4sJIx/u26koblrRZGGtXbHxmry
        FSniXpyfQySTFt0S64sHwdimw2X4RzfIAi25zdSJJQZpNknw/0KYPhL3L5I/DNLA
        JUdd6wD9JyErJD1Hm8yT3XCrrtKOsFd6WOo9vETpD2a8OUg0glQZ1O5KXNSzW6Ig
        Gl/ru4UAUb20cjLjzwUmR/u55RVSuQtjdUnpGScqi2PrVDZKmv5LX35Na/bFTWyl
        oWDIfGeAXBJQbqJRX+NUnKt4KUx1vHFRy9TSPO/fDn5jLlo+DNznwTTg0/J74Aep
        8JblQ==
X-ME-Sender: <xms:KACmZP3Yidi4UYXNVS7Gm5_d4TX1Y_8gTBt9E7hqtL48mLWkWIATjg>
    <xme:KACmZOHN1sK6p3AIT-X168fupXp9kS2TcHk2vqFWaHZpX1k92MHBgoonCkzjt7COk
    Y505RLSBUEp6krFqr8>
X-ME-Received: <xmr:KACmZP4mOtOQWWODqHazHGAQFeUZwIlVyxQwhzuiT8n8EwuCOq7zSUVtqc5NTdr0YdzdLnQI0fxEdURRr_czXWH7Vzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:KACmZE061qmK4JCG3oY6slrv87Vn1FQ6b9IVT5lbARlJZZUcx5QkRg>
    <xmx:KACmZCHF14nVClUpfVvw2W7BJEa87mlSuCvmADAhF2ydtwSfeVVV_g>
    <xmx:KACmZF8xTWVp9efxXsLF1d0ej6lslsm4FvWM9HtP7m2_eOeBUbzwmg>
    <xmx:KQCmZENiS066TcMANK85DKQGerL04Ty9lOvj9ZYmgTxHxkRK4UeQJQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:43:36 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH 2/5] common/btrfs: quota mode helpers
Date:   Wed,  5 Jul 2023 16:42:24 -0700
Message-ID: <e4ea95fc4d1eaef56aabe417c33fa3af350c860f.1688600422.git.boris@bur.io>
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

To facilitate skipping tests depending on the qgroup mode after mkfs,
add support for figuring out the mode. This cannot just rely on the new
sysfs file, since it might not be present on older kernels.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/btrfs | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 175b33aee..66c065a10 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -680,3 +680,46 @@ _require_btrfs_scratch_logical_resolve_v2()
 	fi
 	_scratch_unmount
 }
+
+_qgroup_mode_file()
+{
+	local mnt=$1
+
+	uuid=$(findmnt -n -o UUID $mnt)
+	echo /sys/fs/btrfs/${uuid}/qgroups/mode
+}
+
+_qgroup_enabled_file()
+{
+	local mnt=$1
+
+	uuid=$(findmnt -n -o UUID $mnt)
+	echo /sys/fs/btrfs/${uuid}/qgroups/enabled
+}
+
+_qgroup_mode()
+{
+	local mnt=$1
+
+	if [ ! -f "$(_qgroup_enabled_file $mnt)" ]; then
+		echo "disabled"
+		return
+	fi
+
+	if [ -f "$(_qgroup_mode_file $mnt)" ]; then
+		cat $(_qgroup_mode_file $mnt)
+	elif [ $(cat $(_qgroup_enabled_file $mnt)) -eq "1" ]; then
+		echo "qgroup"
+	else
+		echo "disabled" # should not be reachable, the enabled file won't exist.
+	fi
+}
+
+_require_scratch_qgroup()
+{
+	_scratch_mkfs >>$seqres.full 2>&1
+	_scratch_mount
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	_check_regular_qgroup $SCRATCH_MNT || _notrun "not running normal qgroups"
+	_scratch_unmount
+}
-- 
2.41.0

