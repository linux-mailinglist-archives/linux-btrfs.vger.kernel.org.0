Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9161675CD07
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjGUQEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjGUQEN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:13 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E3E42
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DCB1A32000E5;
        Fri, 21 Jul 2023 12:04:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 21 Jul 2023 12:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955450; x=
        1690041850; bh=cdAF2g7upC4q8bhzChoEZzsUwDmUmT5k4kRthZMvmz4=; b=q
        N1bCYNH54xLnvK33Fa18EA8rQAvirxlMUv5SEOx90uCqgJT8GC5ZuT+BQBA169Wq
        ke0r6U7jwCX2wns1Mf82EJWn+QqdSgQYjAsL0+/E3Pi4fuJhinzWW4s2tTMEnAF/
        En+CFrzD6TjZPisaBSBVO8p0TXIKepxYyQcejIkZwdpH9A6+EVZGOA8Ublo5hoaC
        H7QVzrorSwjCZUx4cd5ZOQ1JIFRbhoq0OJHJpD7zLBT2guIa2Lzgi5ke/cJmt5KO
        oXA38h8W2gqkmOFLvB4pY8/j2oyg1bncavqQpwKqZ9OPrdH+y5hypgj58DA6ekqR
        BwmIvP0mQKPGfGNliKIBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955450; x=1690041850; bh=c
        dAF2g7upC4q8bhzChoEZzsUwDmUmT5k4kRthZMvmz4=; b=WpDSBFYP3aCWkDR4M
        1Y9L6xuIoGj8hoDOVI7qqptmFIg34xv+exM+F7uIWnCzuJdm7xzofid2HQSleWyd
        NO3l+k9ZWHd/UMQkptFt+DU95IyJfsYSWw+IHOHtRsHoz0k9XeUJJWIIsidOzS0G
        JJvIJW4mmZMCfgsBNq+3hm/k73VcYeti6lCQka2zk4mvTI2kNvaVoQCoznrEcE6i
        cUtqBzX0DaFrVakWflkxotuK2xqAMifV3keJXPveHyV4YZMfsJcq6ip0FFAxJgUX
        vfeyBDVdSX6kZxn6GIEOuAofd2ohrtKQGQIiZ5LFyvvS1ZzJPILJVAnSZShTfAQG
        zWCDw==
X-ME-Sender: <xms:eqy6ZGQQ0-iecjioXKHGRJp9YDFoPY5THz7hZ6VHiJkknXG23yEyVQ>
    <xme:eqy6ZLzuvd4zimIrva_rHChqT24k6N6ROO87Ri3S4g9mVTEKerHZNxEVnvGvMKvJP
    FS0Pjn4vfEreLmPRh0>
X-ME-Received: <xmr:eqy6ZD3mC5AUW54oltJIjhzTmUob04WaurTblkWts4F_lm8vqP3RwZJIRv50py-8hKGDIdhQpSW1fMl31xfRt9Sc3jE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:eqy6ZCBCC3E2Nb1chWjwDEs5AhFK8VwbPwKp6-qXyV5F26SJOD6Cmw>
    <xmx:eqy6ZPir9zAqEcqMtwWITpzAXsI_srv-0RcJhQZis6ts683TR8RwtA>
    <xmx:eqy6ZOqke3eY_Jq0wHYGb0RHMeR17LM4TBX0Q74888IsArLFZQFqMA>
    <xmx:eqy6ZPKtpkcVlB7xzX2q_jC4nkedFHGYRh5FLGi_EmD7EgkzYwOLsg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:09 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 03/20] btrfs: introduce quota mode
Date:   Fri, 21 Jul 2023 09:02:08 -0700
Message-ID: <1f49b7f9cfa8480d54b0887f0d69f349b7f42e52.1689955162.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689955162.git.boris@bur.io>
References: <cover.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation for introducing simple quotas, change from a binary
setting for quotas to an enum based mode. Initially, the possible modes
are disabled/full. Full quotas is normal btrfs qgroups.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 7 +++++++
 fs/btrfs/qgroup.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2637d6b157ff..0a2085ae9bcd 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -30,6 +30,13 @@
 #include "root-tree.h"
 #include "tree-checker.h"
 
+enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
+{
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+		return BTRFS_QGROUP_MODE_DISABLED;
+	return BTRFS_QGROUP_MODE_FULL;
+}
+
 /*
  * Helpers to access qgroup reservation
  *
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 7bffa10589d6..bb15e55f00b8 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -250,6 +250,12 @@ enum {
 };
 
 int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
+enum btrfs_qgroup_mode {
+	BTRFS_QGROUP_MODE_DISABLED,
+	BTRFS_QGROUP_MODE_FULL,
+};
+
+enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
-- 
2.41.0

