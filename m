Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACD475BAEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGTW7I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTW7H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:59:07 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1612619A6
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:59:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 83D2D5C0113;
        Thu, 20 Jul 2023 18:59:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 20 Jul 2023 18:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893945; x=
        1689980345; bh=ef9wLWbt0+nPzMM17UYWtWZShfGXjlwNtXYeC80vZQg=; b=a
        2w6cUlOM3nP6zM8bPXYFExJJyBVgD4JK9cQ7kRmS3QLVfOEGydF0Rv5H5rnrXQRd
        IhMt1diTgXO1Y2Qu5DniZeEdMwpYIFcU9Sc4KBWi0ZiMUXiuHCRxZ0g0KmKfnXXB
        AJ9G/M9Mv/Z18CZYOSROm073xn7YPHp2703BiyjVtIkuADts1oG/GrkJFBcYBshp
        L1qFYQONqRUZVZGTevtFpDkBOySTCEoH8Wny+YHlA6C3+MBZ6CBGFz9tJIE7xuUK
        o0AHvUIWFy4sLwlPWq5s4ua3UcaU7z0ZTh//HBYpf4aa9RiAsZ+X99ikA3P4HCWQ
        +/Zx/vzN2YW2dqGZw8Kgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893945; x=1689980345; bh=e
        f9wLWbt0+nPzMM17UYWtWZShfGXjlwNtXYeC80vZQg=; b=rERbL6T5JjiIsMBN2
        xOvRSm8aCJfWahtwj9sSJjYX8MZx+/QOFp437iB7twYinEwYd94hGrtw/T7726mc
        C8aWabzK5sGldoAC/viSM2I78tQteq6WBjLB47AKp9utQ4CU126ucNI+Fml0ZC9o
        bSzDKHlMCWp/Pz1Hzi9S33csBVpE6/nOaxBxoOgdyUjwLpuDmk2tybcwJS7u+iiP
        6r4qLy31JgptJ9vAq2dVVwvt06U3awrWswvEuc410mg2GIMy6ovDtAaJLiU2VdFT
        Ej8O0JGIFo3JgpEyL3G7dF1/mlu/0YUpCokXyjVkEyf3FxeJb5qLAnlF8YdGf4jW
        h6TQg==
X-ME-Sender: <xms:Oby5ZFIsiWGc6DR7CvXjw6zxJqIj9P1yGPXyspJUYBrS8TTfVYda4w>
    <xme:Oby5ZBKnxwS-YeK1uz7HCYCmjCwxWGXhFfD5PfHtUrgRfvHMZhQmQogk_s3Wy_eBW
    oOF92IUjXqJ8BwaRZ4>
X-ME-Received: <xmr:Oby5ZNumFAGO-ZemAaRxbV8Xxl_AJ5FWAMYDSZXTMqD87qIlUjblTEDvJIXCkEJ7nuQqhh8n6QYy4e9NriEIZt0VD58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Oby5ZGY5ewQcuJ7JeDnyY_wsfgqI2hJ9aN4WaW4wVTRms_SAcS1HfQ>
    <xmx:Oby5ZMbYVDjwMKhWe2NPDWoSDYpBjpO5SY7-Q8zr-rOM37oJeX-iGg>
    <xmx:Oby5ZKDMUEL356dMNP0GySpARUX4sf2udEg2etGYGJ08yaA-WLMSvg>
    <xmx:Oby5ZFCkP0Lhis73oDiaASXGXmT_WJV_LYxbDALD16eaeuKlb8eMQQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:59:04 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 7/8] btrfs-progs: simple quotas enable cmd
Date:   Thu, 20 Jul 2023 15:57:23 -0700
Message-ID: <f0ca6ccbf2625e578705ebc6b1725ce3b6fd0e7e.1689893698.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893698.git.boris@bur.io>
References: <cover.1689893698.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a --simple flag to btrfs quota enable. If set, this enables simple
quotas instead of full qgroups by using the new ioctl command value.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/quota.c               | 39 ++++++++++++++++++++++++++++++--------
 kernel-shared/uapi/btrfs.h |  2 ++
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/cmds/quota.c b/cmds/quota.c
index cd874f9ed..a7d032a03 100644
--- a/cmds/quota.c
+++ b/cmds/quota.c
@@ -34,17 +34,13 @@ static const char * const quota_cmd_group_usage[] = {
 	NULL
 };
 
-static int quota_ctl(int cmd, int argc, char **argv)
+static int quota_ctl(int cmd, char *path)
 {
 	int ret = 0;
 	int fd;
-	char *path = argv[1];
 	struct btrfs_ioctl_quota_ctl_args args;
 	DIR *dirstream = NULL;
 
-	if (check_argc_exact(argc, 2))
-		return -1;
-
 	memset(&args, 0, sizeof(args));
 	args.cmd = cmd;
 
@@ -67,16 +63,40 @@ static const char * const cmd_quota_enable_usage[] = {
 	"Any data already present on the filesystem will not count towards",
 	"the space usage numbers. It is recommended to enable quota for a",
 	"filesystem before writing any data to it.",
+	"",
+	"-s|--simple	simple qgroups account ownership by extent lifetime rather than backref walks",
 	NULL
 };
 
 static int cmd_quota_enable(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	int ret;
+	int ctl_cmd = BTRFS_QUOTA_CTL_ENABLE;
 
-	clean_args_no_options(cmd, argc, argv);
+	optind = 0;
+	while (1) {
+		static const struct option long_options[] = {
+			{"simple", no_argument, NULL, 's'},
+			{NULL, 0, NULL, 0}
+		};
+		int c;
 
-	ret = quota_ctl(BTRFS_QUOTA_CTL_ENABLE, argc, argv);
+		c = getopt_long(argc, argv, "s", long_options, NULL);
+		if (c < 0)
+			break;
+
+		switch (c) {
+		case 's':
+			ctl_cmd = BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA;
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
+	if (check_argc_exact(argc - optind, 1))
+		return -1;
+
+	ret = quota_ctl(ctl_cmd, argv[optind]);
 
 	if (ret < 0)
 		usage(cmd, 1);
@@ -97,7 +117,10 @@ static int cmd_quota_disable(const struct cmd_struct *cmd,
 
 	clean_args_no_options(cmd, argc, argv);
 
-	ret = quota_ctl(BTRFS_QUOTA_CTL_DISABLE, argc, argv);
+	if (check_argc_exact(argc, 2))
+		return -1;
+
+	ret = quota_ctl(BTRFS_QUOTA_CTL_DISABLE, argv[1]);
 
 	if (ret < 0)
 		usage(cmd, 1);
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index d312b9f4f..09152f8bf 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -786,9 +786,11 @@ struct btrfs_ioctl_get_dev_stats {
 };
 _static_assert(sizeof(struct btrfs_ioctl_get_dev_stats) == 1032);
 
+/* cmd values */
 #define BTRFS_QUOTA_CTL_ENABLE	1
 #define BTRFS_QUOTA_CTL_DISABLE	2
 #define BTRFS_QUOTA_CTL_RESCAN__NOTUSED	3
+#define BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA 4
 struct btrfs_ioctl_quota_ctl_args {
 	__u64 cmd;
 	__u64 status;
-- 
2.41.0

