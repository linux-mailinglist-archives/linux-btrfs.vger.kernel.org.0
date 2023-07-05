Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599517491C6
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjGEXXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjGEXXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:11 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856261997
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F29D15C0290;
        Wed,  5 Jul 2023 19:23:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 05 Jul 2023 19:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599387; x=
        1688685787; bh=b3jua4w23nT6O4K4s/88PvMhnBjoQifAb7uk9Iq0ANQ=; b=I
        D2K/PeXSvofYA+LlCvspDlv6yElmtOgwUenJ4vTuwVvi023z7NrEfHcQohz+hH3h
        QzbYsHYbdCA4UcudFlNl1hvn4BEL6hceQ90nQM6Zpni62UYno5ANRbdMyPg9VBa+
        /g//kAD9VgxSh6SDAvG0+MurACzAVTJ+TFtpHXp6NqE/9QBZYTxToXrBEGi0XRhp
        v+Q13ESUzU/YkXSZDUuYvp2wcfrHxIZWAfopk1SmtByIlbjKOBKokjQsMkTVJy4q
        H6W0WOUcKIIdkMKOl9htV0yim34P6LYp7q1l4Y2wZpi9cPPQ0ccROnymiWkm8/mx
        Kzk6hSk6qSVcGkf/JUuvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599387; x=1688685787; bh=b
        3jua4w23nT6O4K4s/88PvMhnBjoQifAb7uk9Iq0ANQ=; b=C3xYEybsqjHCAPbwU
        OP5v2VWGoycjH3xtC8FasZe/AC+rmzAejd3WGlWLYba3QsGWYAzA1+qZRsX5o9fC
        /wrCpAlc2E2pXjHPgdkJvC3P4Y+DVtcSoJz/Y1yAG4tnco+E2L8yVeHIlJjbSluJ
        bEv4kXw1kZ+KN5eiYTcs4u+jqcbm5kNNe8mau7GtyoMCKgwaRcc5ymMj8vy0D8+p
        NYWMtCa0ua1RpLflAgYLTMLMsp6hTM0j0GE7PRiqrORGA6GJXVbhOLnQ1LiyG4jy
        ycJ3IrttEIYFIIu+6gGldlXXySw5zWwJ3Br9YhqAJopDrOByA8cLN3F7wwSN4Fvu
        NM21w==
X-ME-Sender: <xms:W_ulZCA0nVkeySnITCEJlgWxwtyo7SbTkWoBWlS5DqqJ969C9USEzA>
    <xme:W_ulZMgNOnpGa4Gw-Sb_aS2LjWlA2zCbVdkgVxWTQdeKs-_iBHGehqIuR6hnQ4AxV
    L7LFaaIhCQS4BT9AKo>
X-ME-Received: <xmr:W_ulZFnm2U5KSR9-CkWBiH1N-a6hpkWwPdxM8ZjEu-XL7aCMw42CLBsOKvlucThdv1ov50Gwh7Hj6Kimi8wT62gLXN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:W_ulZAx2qiSv9WrOqg4qA2Rx2D9PUONrrqk1qch7ecjUI3TRXVGNuA>
    <xmx:W_ulZHTP9jm0kHYwgmDNMB5RByovYRltBsa5IHRqWzhxvWtOOIVOxQ>
    <xmx:W_ulZLYoT8Twfvgvk0GVQXz8PUtNYlgNDSm5Er0-ZLvhOe4Gocw3ew>
    <xmx:W_ulZI4VUjqJTBnqJwkS5WCsSPMv_IUvjYoezYKtqcPSzQXcjPg4GA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:07 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/18] btrfs: introduce quota mode
Date:   Wed,  5 Jul 2023 16:20:40 -0700
Message-ID: <2a0d955252c28b3652bac098e6229223f0847be6.1688597211.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688597211.git.boris@bur.io>
References: <cover.1688597211.git.boris@bur.io>
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

In preparation for introducing simple quotas, change from a binary
setting for quotas to an enum based mode. Initially, the possible modes
are disabled/full. Full quotas is normal btrfs qgroups.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 7 +++++++
 fs/btrfs/qgroup.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index da1f84a0eb29..2b4473cb77d6 100644
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

