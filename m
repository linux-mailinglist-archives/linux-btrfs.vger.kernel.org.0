Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224C34D0AB2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbiCGWOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbiCGWOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:31 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F75577B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:36 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id bt3so14638192qtb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sby9k+j/0Lu6x5fv0KN2tRTj6XthIzrvAHb77ZUSPZ0=;
        b=ovDj1VrHLdn0qYpZcudGxjSvy8AI0GR/ourtUvwL09gEn0YDTtdy35RVdusEiIZAcf
         jqZ6rmWGwO9H3t3WYVema+BTCPkJV0nJY3P5PfqzSMnXtc7nxb/DMRqOoLxtzx72s4WW
         wI+x3gsOuQv870HkybF/H0vMMOC4z9+wGRDv9WnKKSv3rzFXiQM4pSyRiOaQitK5RpPG
         UXyim2fkeJu3DtURHM7GsI9tPM7hlr9vopvHlISY/M+BTyd4rd0Lbyfb+pZGNW+TQZxo
         RiicZyzfKYckQgNrrocgYXnLoMZoPVQHGQsaN4q/qT7fux5ykrGrGh4wCzhVdeigISpN
         mWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sby9k+j/0Lu6x5fv0KN2tRTj6XthIzrvAHb77ZUSPZ0=;
        b=n2g1XGWbQtADA2ZcLZAadtCoebukn4PTXZqK1tJEZoko9jGk/CUxc/E4Vzdy3Vb6Yp
         SkbT8if3jm0sg9BYg/8oWjrD+zRlTveFZdSrfzwgqPrAFIWxyA8mZuT82nLlFg/TiPcX
         KxP7JsJtAbQwP3mrfDyrzQuAHmlfJ0VesWHEyphLMq5Mf0T423CLBRXvokVlMsZT1Ynn
         e5bksbNAS5ysPGnjM+uuweVhDIfhc0l7e8jmLnrsWnM1kFvyVSfqYvR/2xABCFkuleXL
         KLeAb/LqLlfaf4qw6KA8I3iYNLXbCUtM+TrAo8Vwo3xefNqTdchILH6sgpvpyu7J+MCw
         hFOA==
X-Gm-Message-State: AOAM530T+lS6DIrRvwnzS715wPnK6+w4BU9t8PlRFvuucQjBG6d4dFJh
        lvXXPDgKzWpJTe4buusHVbMREOHIwDe+tzJD
X-Google-Smtp-Source: ABdhPJwzY2JvyM/f1j+k3EHH6iu6s89kcLYrHlCy3BEr/uFXvYSclJuxQrSZZRZ33q7Co4cSY4iCGQ==
X-Received: by 2002:a05:622a:138a:b0:2cc:a8ab:8846 with SMTP id o10-20020a05622a138a00b002cca8ab8846mr10893072qtk.596.1646691215174;
        Mon, 07 Mar 2022 14:13:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i66-20020a378645000000b0067b31beb87esm1628397qkd.73.2022.03.07.14.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/15] btrfs-progs: repair: traverse tree blocks for extent tree v2
Date:   Mon,  7 Mar 2022 17:13:14 -0500
Message-Id: <d390f5aa73e9f2a95d02dce73798d6eeab54aaa0.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have extent-tree-v2 enabled we can't only rely on the extent trees
to find all the used space, we have to walk all the trees as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/repair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/repair.c b/common/repair.c
index 37a6943f..db462955 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -219,6 +219,12 @@ int btrfs_mark_used_blocks(struct btrfs_fs_info *fs_info,
 	struct rb_node *n;
 	int ret;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		ret = btrfs_mark_used_tree_blocks(fs_info, tree);
+		if (ret)
+			return ret;
+	}
+
 	root = btrfs_extent_root(fs_info, 0);
 	while (1) {
 		ret = populate_used_from_extent_root(root, tree);
-- 
2.26.3

