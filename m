Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B067B0F81
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjI0XNu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjI0XNs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:13:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7597CF5;
        Wed, 27 Sep 2023 16:13:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E10695C2806;
        Wed, 27 Sep 2023 19:13:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 27 Sep 2023 19:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695856425; x=
        1695942825; bh=nKPcB7v/h+P6IKZebcF+3glNhmXxwFRSsv67QuHq9ik=; b=x
        X2V2fqQCJjyOywobUs9uCvhmKWMhDNgYNMftuGNcOsjDxBBHWd50U9ULdY15C1EJ
        UQQzVp9S4t994ncGTEqQK8gGjOB+d6J/W72L7KxwvCfBDRkMu/pQsYMMlSbCMGfc
        wrm5WIaQKP6aFPMPKtLzgniBWX7p+m7exVilEmFBA1fI10TGMX5z6ht5CZeDoPkv
        FQlfyGguMBnb3yVfyW1n7YiVC94mBXpnxesKtcmRdwzEFekyHLjjDd19L/5BFDKg
        c77KZZtQyvq9VHxulFagpAPTuMSHTys5dBi0MfKLuKamC8ht8oHZe/9ZNKDeQXXS
        ABNy91JKr/iVIDuB0ZUVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695856425; x=1695942825; bh=n
        KPcB7v/h+P6IKZebcF+3glNhmXxwFRSsv67QuHq9ik=; b=bONNCpe4xjOcY/2ZM
        ycAJ/JS2u5MBiOQ1UUG6M/mRXC+tIp9HXXWZtdLG1ZTS4Maf1rvlpKIkyvVPfTBb
        iNgKF3EjK2ut+073em/TRkVpGrMmEHieB5jOgv9tKlrBcQKa/MhzzLGTYv9AhydL
        SRjkQDt0pX4ulmdIe8xMQxk3aEnv83L9NYGUJ1qs88Qvt1y19DO4cPv5BKxrQySg
        u7hcn1PdpwA98HpY5xOQ1aTmqwjhTYL/h/6A5keCc82n+/NRJZHu4WUa/3y0dh8+
        u2uLIqQkLiQJlAM4OP8N1cnp7FGRrquFTqEgwZtkb30eta/DmzZsEwygzMqsCa3z
        LZTvQ==
X-ME-Sender: <xms:KbcUZYTnSbXq3pXEluD5N99GhmI9gWV-3l6mpXOvY_PZ3-dJoAVmIw>
    <xme:KbcUZVxHHsS_YlXaWYFb_PXB4nlSAdvwi1XPcrIkuHbT3yTY56gAjBuD4DOsBEQpc
    QZTqOAy1AckdZ7nFJ4>
X-ME-Received: <xmr:KbcUZV1iMT1USngP-0xsI_7wdcUqfVdo4SLNkSDM1qClDeF2ayDtAb93WdGSWEAd7fz88nD2W0InGluQhBOJtIez_gU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:KbcUZcDbBQWVcM4U1N9dbB3y9Z_kfl7x9BNSQPI6w1Y6VrvTBB7luQ>
    <xmx:KbcUZRjVMLhEEAF6IsdZiTpzVOxb2vWGNlP8O9xVBNLrjoR16tzubQ>
    <xmx:KbcUZYrnRA-I21rfZ77ByGNsUXlKPVT55wq2sqysOWqR-ow9R3RD6w>
    <xmx:KbcUZRafVGdKl3vD6DbW1H6L0FZVEilkgegKjJ83FMj3C7oGroBcoQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:13:45 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v3 4/6] btrfs: quota rescan helpers
Date:   Wed, 27 Sep 2023 16:14:36 -0700
Message-ID: <1111e2f58d73dfe7571598cdd044211e15076a1b.1695856385.git.boris@bur.io>
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

Many btrfs tests explicitly trigger quota rescan. This is not a
meaningful operation for simple quotas, so we wrap it in a helper that
doesn't blow up quite so badly and lets us run those tests where the
rescan is a qgroup detail.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/btrfs | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 37796cc6e..0053fec48 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -710,6 +710,24 @@ _check_regular_qgroup()
 	_qgroup_mode "$@" | grep -q 'qgroup'
 }
 
+_qgroup_rescan()
+{
+	local mnt=$1
+
+	_check_regular_qgroup $dev || return 1
+	_run_btrfs_util_prog quota rescan -w $mnt
+}
+
+_require_qgroup_rescan()
+{
+	_scratch_mkfs >>$seqres.full 2>&1
+	_scratch_mount
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT || \
+		_notrun "not able to run quota rescan"
+	_scratch_unmount
+}
+
 _require_scratch_qgroup()
 {
 	_scratch_mkfs >>$seqres.full 2>&1
-- 
2.42.0

