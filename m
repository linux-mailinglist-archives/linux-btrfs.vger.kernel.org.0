Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C57B28AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 01:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjI1XQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 19:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1XQF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 19:16:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7B219D;
        Thu, 28 Sep 2023 16:16:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 66F205C0DBB;
        Thu, 28 Sep 2023 19:16:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 28 Sep 2023 19:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695942963; x=
        1696029363; bh=VHL3K3RZ6/F72JVZUkxSZ3tzq++vFi+1nAyKppki0Dw=; b=J
        x0oBJlUNjK/350NJed494eMGRaPCFeHHUEWTOXBn9Btnc6+uZe57GHfAqp8A2a7g
        iHvGWnGm/jgCkJGAAppocR+EeSq/k3C5jVWkZXV4fDxboBnBqZij10iaSyrW69/H
        73cqy7FP7RrRaaNd+YFq/aFy9DfumJ4h0eMyXH9poVTk9ePRTILWXBHRpx7C+Qtu
        hMPU0s+/qQEC2kkoJsoZAxaHFdSMhmBgwkC3HBBBHqh7JFtVkhRIsgicX0BSzxst
        JjRCLcrRCxilXoyuvRR7p17jfwY7vBohkN0CWwK0okb9pevnMIh1muMIvKi1P7rB
        K2PhaPfPL5b4nI5++lQsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695942963; x=1696029363; bh=V
        HL3K3RZ6/F72JVZUkxSZ3tzq++vFi+1nAyKppki0Dw=; b=UTJvTibAEM9WfDnz9
        3MFoYJ3e4UNHO/k8G2p7PUTbT9e2ni/UBCRGmEAl+iGLPGSu1oC8oZOb30bSdT18
        V12HIDS+nVf8C11vTM/KgbHogDErAAYyKHBQfOWi1WJPt2FjhQVuh0IFo1ODoJSx
        uobgIK4Ei1vIuKOIn+9J8Ctzat/6F4/Yd+jLj7cmz2HyFqtItfeiGJCInIBzbbNj
        kWy97hJn7xgD24xmCq+qn7cmZ6w1FdpAkdKWKSHeISjvPqPVfEThyznnS6rea3Ob
        6E1pfQ3mMcd2+2Tq0GnM/6Ip490xnMQRNlAXyBxTtazs+tICsf01x31iIW8G0Wuo
        Pthzw==
X-ME-Sender: <xms:MwkWZRUK3GNpEYIf-YIl-eC_TVNuUHtzwjsPLUoLJPodvSoMxUypeQ>
    <xme:MwkWZRlFEf9WRdaTIGLE4BYrndcxuGxIsXnZoHunOf7d7mqOuwiGM0u91ACdcPoHv
    HFcH08B7YkHHbCr_RM>
X-ME-Received: <xmr:MwkWZdY523YG3h5GzBl-XpTLdHq6wY61rAJPIx44FAVJ8MrtdfFILV33ErYdfnKhdEVOiYE-jna36HTg51hh9eQqvxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddugddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:MwkWZUVQebtHF_G7WcvKsJwzd1Ped7WrUYStG8ajca9xM5kKe_M6NQ>
    <xmx:MwkWZbnvpOK7q37LOFTFSFvrMSPGbf15Qhvq11bzHb6Rlq5dCAr_jQ>
    <xmx:MwkWZRfkDJ3v7jS_Q1ruSpeWZQ9V6d1reUxt_IHpD5FSjm_P1oTglg>
    <xmx:MwkWZTs_zhOkpFi573XIlfT1sKBhFSZe_YvK81UzhJ--dOI6COvU4g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 19:16:02 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v4 4/6] btrfs: quota rescan helpers
Date:   Thu, 28 Sep 2023 16:16:46 -0700
Message-ID: <1f8549eb7f043ab9071faf896121896e759daab7.1695942727.git.boris@bur.io>
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

Many btrfs tests explicitly trigger quota rescan. This is not a
meaningful operation for simple quotas, so we wrap it in a helper that
doesn't blow up quite so badly and lets us run those tests where the
rescan is a qgroup detail.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/btrfs | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 8d51bd522..34fa3a157 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -710,6 +710,24 @@ _check_regular_qgroup()
 	_qgroup_mode "$@" | grep -q 'qgroup'
 }
 
+_qgroup_rescan()
+{
+	local mnt=$1
+	local dev=$(findmnt -n -o SOURCE $mnt)
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
+	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT ||  _notrun "not able to run quota rescan"
+	_scratch_unmount
+}
+
 _require_scratch_qgroup()
 {
 	_scratch_mkfs >>$seqres.full 2>&1
-- 
2.42.0

