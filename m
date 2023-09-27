Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7CC7B0B47
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjI0RqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjI0RqM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:46:12 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A831A7
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:46:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4A1453200A31;
        Wed, 27 Sep 2023 13:46:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Sep 2023 13:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695836769; x=
        1695923169; bh=EAJzeNrebYA4fz8wK/r/eveCHdguJ+mKDlTqNvzszqw=; b=B
        iE/HyrvSk7rdOxRt3rjM4qV3ixRoFqAn0LX6A0LGsb1IWpFRgP2rVMEbcHgAmkT1
        5NfxVKzSVkfYP481jDbJdXGZe1RJmeK3bxpfUkAFoL+3f6CDK5OvqvbYJz3jvE6c
        yMzIgAfDC1/Tk1QhqEGBANFuY9W/tF6G71Qnt3mCuGbpZsKgFyevzHxibA4oL85B
        t45ara6B4174DpIp4LDyfY28tEqvx2ae44SsIaVc1mRAQL8+ecGFThg89RfITrfO
        kbj5HGZQKCPHdTxjXvVktJHExnysLELMDbhwHERvplWgrMebvqgIuiPDwZwBlYiO
        5SQ0OoypdXYcUFipR7h/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695836769; x=1695923169; bh=E
        AJzeNrebYA4fz8wK/r/eveCHdguJ+mKDlTqNvzszqw=; b=ZGjW0WjvoReljf/Qf
        +FJIHav0meCqMJMTMqzmBTvnBZxmmquwWFb0vZmr3jPsFmtsHVvNG0eQas9FgRBU
        Aj4QAAzmdmVvaP03L8aydXTacq9vC8gNTH0e75Kfns/KdhFJUwXAROZde6bnYicW
        nqR4UhbrMNxaxekpBWcMela1PfZ5KJLsuc/YKTz66oxSgYKOV865wkAIlfuyaUif
        h1i3G4KxyzVPx7OrVeLSANIKWZj/KqvSt/lhA1fPGLHdmihk6AlUrUHe0VyeeXPV
        /zUW+LoL8qD7ZR5HFKPWdoppV9uaUPF4h5m8Tlf/P9KXPrdgIS3ZbjDWe2ZdctGa
        nhh9A==
X-ME-Sender: <xms:YWoUZZCcyUOK9cr7Ej0-PuBymw2_d9NV8exbDj17DqVlcoKVCSf81A>
    <xme:YWoUZXglN3x7c7N-gtoROjKUM8bg83oFaJ9trgcINLjSiBgYQV3PmexxkfDfGGL3u
    phavdYlm4DQO0Aaf9Q>
X-ME-Received: <xmr:YWoUZUkcJQFgqXK10JY68n1OJWOaZvOVZKxdNNeWBbU1zXISgNCjcfygbZsqCKnXMnxvukZ6ZjL8oZI5tw9oELSVm08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:YWoUZTwNZno6hVBGmIqY3coXa53xlBkRGboY3dVJleLLAjTbyirRFw>
    <xmx:YWoUZeRO60S0akuP_QVxlVnnkn1C6ltmyxVGn0bPEJtWbpyzL6ONrg>
    <xmx:YWoUZWYLKLTbhlbPWzcqdY5SGiQT_MR2X9MclZcd3MNoVVpSMFZahw>
    <xmx:YWoUZX4ZNMgNbPDaFzFHJbtvchchRReti7gbGlSwxIFT9tGCSofv1A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 13:46:09 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 7/8] btrfs-progs: simple quotas enable cmd
Date:   Wed, 27 Sep 2023 10:46:48 -0700
Message-ID: <aab56bfb675a0ce87e9d4b4d18b354880262f139.1695836680.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695836680.git.boris@bur.io>
References: <cover.1695836680.git.boris@bur.io>
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
index 7e0078a5d..11ffd54d4 100644
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
2.42.0

