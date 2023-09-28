Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD25F7B28AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 01:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjI1XQF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 19:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjI1XQE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 19:16:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1E31A3;
        Thu, 28 Sep 2023 16:16:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E7B485C00FD;
        Thu, 28 Sep 2023 19:15:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Sep 2023 19:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695942959; x=
        1696029359; bh=l4ZHhDlqoTZg/LmFnodXCFvG0S8zJyyVhIsZF/Z9sbM=; b=s
        ockXJQFlkYxVGwE1Blqy/lRP9JYRw49NyL0+UW1EX3Mym+9BLSVBy2ol9MPLkU9K
        AC1r1ufbTzFaT2x1cgPPVVF05pLfH3q7WCuJDUZfAVno5yl/vz4aOLNvlxQp2fxV
        ZihmIu5QLRKdkMZ+neRcBeaiD+r24++NYMH1QKsWkiMMDAkrjgMucmrz3BhdCA3K
        OlO5xQbAvUPHzGixXO+dXkFIrnNNn0WjON+nLj1SqucWTios2S8ERvef2Pw2pUZ4
        cLKeg4E4zMQXqbdlytK2oTs5xddmiYnr6tZYo8FYyskA4fuaDXOYIxcb1JinaqT5
        Idx18t8mJAPfCjfA4E0cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695942959; x=1696029359; bh=l
        4ZHhDlqoTZg/LmFnodXCFvG0S8zJyyVhIsZF/Z9sbM=; b=QsKXBuursVlY9h8B4
        urAK3GktizBVXAxFPVysDgocC23WsdHsDzANWc6IcrDllBnUuyFHClInSUTYRvac
        nRRz6gjxawIttMFmiV9UULXcsN3ScnrbIHHU1FsGc7I/o2rZ3Wi3CNdVLAA0TsF1
        FDJHd18sSxPNs9x3NLbCnhJag2n/FamyluN5OC1yHvA+evpv8m7mxc/4gJObJM/K
        HlpU291w6aTkJuceSDl2a4g0LR6alNC0+4j2luvlUzsqRKN2HGfhwpETJwa2gUqw
        lHsBEuYmj+R2R1N5jcvMDT33itdggmeTj56SjeSZ12r9+MzHmnxebQwdQmcrq/U9
        BIelg==
X-ME-Sender: <xms:LwkWZTQfuO26awM6MYyMJB2ErvP2wbOmaU-UcJS-GoeoxRBF0sCedQ>
    <xme:LwkWZUwdVMcZepaThyb0e_xkR-Z_N9DMSJgHBUaEK-W1w2uIVPsROw21PD3OLZ6m6
    1REu4H1eQ4zprfsSMk>
X-ME-Received: <xmr:LwkWZY0Zk1J4Of8m5kilPHBJ3oVKJ5oGO3KFf76OTd76CQfarWztAEg7av0w4qAonmzGWAuk06ufAu1BWP4eyKRQIkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddugddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:LwkWZTD7dWrIp3692BAmfGBJiNXTKGp_bHcqRVa5QaYJ2oM8XuQC-g>
    <xmx:LwkWZcjXbMCfhVMX_fW0OvQJzgL80xOPWW4e_SByzziCREE-wEY0HA>
    <xmx:LwkWZXosfJXwA_2MYcgZUssPuBYs2Q8-geymLoIwpBSOERXeKQYvDg>
    <xmx:LwkWZYY8fzkU5bCZe_jhbmOLPkIkbbFCJGxH_gPvW8h9w6GOffSZcg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 19:15:59 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v4 2/6] btrfs: quota mode helpers
Date:   Thu, 28 Sep 2023 16:16:44 -0700
Message-ID: <fd723f002c3019b79c515d3408f951f0897f414f.1695942727.git.boris@bur.io>
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

To facilitate skipping tests depending on the qgroup mode after mkfs,
add support for figuring out the mode. This cannot just rely on the new
sysfs file, since it might not be present on older kernels.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/btrfs | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index c9903a413..8d51bd522 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -689,3 +689,41 @@ _require_btrfs_scratch_logical_resolve_v2()
 	fi
 	_scratch_unmount
 }
+
+_qgroup_mode()
+{
+	local dev=$1
+
+	if [ ! -b "$dev" ]; then
+		_fail "Usage: _qgroup_mode <mounted_device>"
+	fi
+
+	if _has_fs_sysfs_attr $dev /qgroups/mode; then
+		_get_fs_sysfs_attr $dev qgroups/mode
+	else
+		echo "disabled"
+	fi
+}
+
+_check_regular_qgroup()
+{
+	_qgroup_mode "$@" | grep -q 'qgroup'
+}
+
+_require_scratch_qgroup()
+{
+	_scratch_mkfs >>$seqres.full 2>&1
+	_scratch_mount
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	_check_regular_qgroup $SCRATCH_DEV || _notrun "not running normal qgroups"
+	_scratch_unmount
+}
+
+_require_scratch_enable_simple_quota()
+{
+	_scratch_mkfs >>$seqres.full 2>&1
+	_scratch_mount
+	_qgroup_mode $SCRATCH_DEV | grep 'squota' && _notrun "cannot enable simple quota; on by default"
+	$BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT || _notrun "simple quotas not available"
+	_scratch_unmount
+}
-- 
2.42.0

