Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F037B0F74
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjI0XGa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjI0XG3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:06:29 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5508F5;
        Wed, 27 Sep 2023 16:06:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3985F5C2938;
        Wed, 27 Sep 2023 19:06:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Sep 2023 19:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695855987; x=
        1695942387; bh=nKPcB7v/h+P6IKZebcF+3glNhmXxwFRSsv67QuHq9ik=; b=x
        MJzS6l5q41qeqbNpZUaUyhcKACNPO3BwUctfuzt2tYBJ3aGTyzHGgH2zpB0Hj9co
        +khB20SBjK6K8yZYJM/eaZaciB5PJgwtVfVYjz0GF/dztk65Kl9hsA/j9Q3d0dMf
        QG8uYfhbTOunGC7w2fnPJlWtnfOcsiano1bJtZ/E3DCcuMVP9/YisC/bb1oJ1AFl
        yuP4HQRrvO1ZJl1gbadgZbBDXTOrG9o7i+lx5wqJKPy+azAve7rVtyYTqxX7HVSu
        Nh2aYHGwdFkzus8gMyQnn5eob5UG507s0fmvgvI/lRTC1a1sOQOfgSLrhRDhoIM9
        iBjqIxwcsmQB86iwfGmFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695855987; x=1695942387; bh=n
        KPcB7v/h+P6IKZebcF+3glNhmXxwFRSsv67QuHq9ik=; b=S8Tgb2bGs1V+PIrdc
        SBJr7hgxP78YrqOmhkjI823EWanBh9Bg3f0QYwwkLwakyfDQh9rKdyaJ611bDIjZ
        9tURqNygxTq23orZE+oRvtXpOwn15oEL/O1s5bGqP2xPYEKnKD9fqerYLbd0DM3Y
        RISuqzcdJUMA1S21MuyZAIlUmI+/mpPedLPO636h8T9JVs6bpQ2H5yHfl9axipN1
        dfEvOozSXuQk156PITfYukjcN41onVlAhwq1POfpu2KKqbWwIf9MgXyvfZDLmql/
        P4IG/Ukx9hjW39gecDA6VvjQhjWf2BARege/HAz5bYXjAithaFlRzuNXhuR2wwTk
        C0ZIg==
X-ME-Sender: <xms:c7UUZWaBurqzOdQFrei7S-TPBNbRUCXU6W2jQp8GR8yf39zoc3zWGQ>
    <xme:c7UUZZbYqBfi8IAt0_XjpbgVKWdNNCaFTG-LrwtwtVS8YfZmfEU29oobh65qFLCEv
    5drKXnuYl9ka1UJU4k>
X-ME-Received: <xmr:c7UUZQ9UI3t0GnGLQI2LlbN6c-H1y42FbDhSkDTWxzuAt3ewS-Kbw3ruAstpWPKlKK4ttGAEZcGujTcA_RfAN6s1Nfo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:c7UUZYqwR_C3D1CcLouHQzlUaLHQqGhLcK_b3hM7M8MBU8ON9RtSJA>
    <xmx:c7UUZRrrnV4j3OWyH8aMlhAkG05bQHg9YZ1MZnHiRS4hN6IQfU5cUA>
    <xmx:c7UUZWQSVfNEJ-O2o_H8wTkgYL-4foCsnbiZYAKCdGKJGH5794Doww>
    <xmx:c7UUZSCDLNWGWG5TbPX-XJlKc5kASSVqP5gWBafm5ngfj-frZKVSrw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:06:26 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2 4/6] btrfs: quota rescan helpers
Date:   Wed, 27 Sep 2023 16:07:16 -0700
Message-ID: <a1eb6944ff3b05688c8878e2781b5fca61be7a88.1695855635.git.boris@bur.io>
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

