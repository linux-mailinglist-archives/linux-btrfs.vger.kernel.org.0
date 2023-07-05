Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6733D7491EF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjGEXhq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjGEXhq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:37:46 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4793812A
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:37:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B52345C01DF;
        Wed,  5 Jul 2023 19:37:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Jul 2023 19:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600264; x=
        1688686664; bh=0bgg29wXyH/HJ/8250BxoeU/AmHZbhrqeuGkDdQREj4=; b=E
        lZyt7rGc7Xj2OLql4ev/P5jptPd/COfvUZyU1LYun+pnSy1BcNXKrGL3qHig6MSX
        Pyw50p9pYHe3WWPxYI7KX3zbbhGueIV9M0VV3gAbou0U6PV6wjICYpykL9I4LfNU
        8pSpBez+/Aav4vTcQYT+3EPSf6cM88zQvVmHLPXZTp0cEDT5te73CQZzlB6lV0iu
        7rJM7XORi3tEdC4Jq2hSpX9xO7eOqaEoKlDCCNA+oh7ssxnfhRfoIAlxLyqAm/nO
        QPUxRrIilpzjPZXjRUtG2NOp5IzNtg/cXwUJlfOF/zucUrwWbxMNpFZ+KPXlxU3b
        54f2i4ATQK3pEmwOSFzCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600264; x=1688686664; bh=0
        bgg29wXyH/HJ/8250BxoeU/AmHZbhrqeuGkDdQREj4=; b=I1XePTkCV/CIIy4gK
        tXFoLd4MKT1hDGBIYBkuT+wOTtKrLiI5iztFcppvkNfGEBcCIWu7XJLEPgIkB5Ik
        0D9ykqyw7lZcFHR3Pf3ZHLjLDAS51wgMj/Z/xqOLWUV14VBOJFBYoWy2RlxKS9hu
        V6XV1PIMkOLBTX86j0BVTKKI1jwe6mTeseTETmBLqRg8eeBz7pV+4VzI+rPNBKhl
        abvFsbe7XQ8s6kFLvDHmUtzz3bWZoCOGGX/lvXLOYHbg+CjDA2YauaRnO6Hm12RA
        VCeqf2X8G8fo4CVgD/nKd/TkPzyXUSN7lvNi5zXUdBS30p+LA5w3HLxloVGYJ4Xk
        8t8cA==
X-ME-Sender: <xms:yP6lZOPzbVqcT2AfEkwAMrclXkYxArVVob3xsFJjQT_9vN7ctzegiQ>
    <xme:yP6lZM_lKEG1JPsZsxxR2Lptnl5GKIvAjmmWr2-rHXMWcnkQ5mGdr-xnylVj2FidK
    L5bwDegX1YfX7nXomU>
X-ME-Received: <xmr:yP6lZFQrFtGrt8GpetvwSzMfbmov7m_wx94KdcnpEiYwIagGovFtv2SKV8PIFREyykG-Mia1l_C5S7inX2GsCurW2H4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:yP6lZOtWsf-radjoaCS5SL2E5f4l1VJRhrJxTATdyYC5ozpUcDja4Q>
    <xmx:yP6lZGfogFn3H6MKjYWqZxAMX32P3ibe0p-xQWZsCmOhwmAI_p2w5Q>
    <xmx:yP6lZC0aiv4G6TZhPADOiCHqSalwbdDc1zlg_lN36EE1ttf-SX2HJQ>
    <xmx:yP6lZOneNVBt7nYEfDLl9t7rw4gxh-9vSMO7KtrGUge2XAwSoMX3Yw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:37:44 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs-progs: simple quotas enable cmd
Date:   Wed,  5 Jul 2023 16:36:26 -0700
Message-ID: <83c39c42c2d04a3d6bf7fdb7f63a31d3def1223f.1688599734.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688599734.git.boris@bur.io>
References: <cover.1688599734.git.boris@bur.io>
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

Add a --simple flag to btrfs quota enable. If set, this enables simple
quotas instead of full qgroups.

This re-uses the deprecated 'status' field of the quota ioctl to avoid
adding a new ioctl.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/quota.c               | 41 ++++++++++++++++++++++++++++++--------
 kernel-shared/uapi/btrfs.h |  3 +++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/cmds/quota.c b/cmds/quota.c
index cd874f9ed..31d36fcd8 100644
--- a/cmds/quota.c
+++ b/cmds/quota.c
@@ -34,19 +34,17 @@ static const char * const quota_cmd_group_usage[] = {
 	NULL
 };
 
-static int quota_ctl(int cmd, int argc, char **argv)
+static int quota_ctl(int cmd, char *path, bool simple)
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
+	if (cmd == BTRFS_QUOTA_CTL_ENABLE && simple)
+		args.status = BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA;
 
 	fd = btrfs_open_dir(path, &dirstream, 1);
 	if (fd < 0)
@@ -67,16 +65,40 @@ static const char * const cmd_quota_enable_usage[] = {
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
+	bool simple = false;
 
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
+			simple = true;
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
+	if (check_argc_exact(argc - optind, 1))
+		return -1;
+
+	ret = quota_ctl(BTRFS_QUOTA_CTL_ENABLE, argv[optind], simple);
 
 	if (ret < 0)
 		usage(cmd, 1);
@@ -97,7 +119,10 @@ static int cmd_quota_disable(const struct cmd_struct *cmd,
 
 	clean_args_no_options(cmd, argc, argv);
 
-	ret = quota_ctl(BTRFS_QUOTA_CTL_DISABLE, argc, argv);
+	if (check_argc_exact(argc, 2))
+		return -1;
+
+	ret = quota_ctl(BTRFS_QUOTA_CTL_DISABLE, argv[1], false);
 
 	if (ret < 0)
 		usage(cmd, 1);
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index d312b9f4f..34c295fd6 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -786,9 +786,12 @@ struct btrfs_ioctl_get_dev_stats {
 };
 _static_assert(sizeof(struct btrfs_ioctl_get_dev_stats) == 1032);
 
+/* cmd values */
 #define BTRFS_QUOTA_CTL_ENABLE	1
 #define BTRFS_QUOTA_CTL_DISABLE	2
 #define BTRFS_QUOTA_CTL_RESCAN__NOTUSED	3
+/* status values */
+#define BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA (1UL)
 struct btrfs_ioctl_quota_ctl_args {
 	__u64 cmd;
 	__u64 status;
-- 
2.41.0

