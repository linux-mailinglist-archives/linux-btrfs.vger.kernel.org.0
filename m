Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989767BCD79
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Oct 2023 11:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344552AbjJHJRe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Oct 2023 05:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344549AbjJHJRd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Oct 2023 05:17:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65365BA
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Oct 2023 02:17:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c364fb8a4cso30867285ad.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Oct 2023 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696756651; x=1697361451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9DQlvd3k99P2AHDDStyFhNyOUtajCeUWyctk7cKSHo=;
        b=KcMp65Rs2ShipnW+QsmCHMmd/dtuVy9exMhSJMv75DyRTQ3dzfPG2Mvng1XcLcwnAz
         X1TtLCUuvU2OKktgY7Ang0z2UOkWmk5md6FHtM9ys9a/Ca8IEYest8Rr4FyUTIcBuYt2
         PNdX8Eq7bHkDVEtmTfqQz/UCvLBS7GI2VYLAdoUS7dPDvHAHAHweXink80FwxtMx72CV
         /mGdvBJMB6BrSEaiB+dYdM688nnzJQq1xzfoWFtZu3mLoMCs4hb50g19NYmOAUQE85yq
         yK49Z9arXDXtn/LS6ZfGJV/N9lhmFjY07ovQIX0WvFva0lU4DuFM0X/VWRao6wpRdhsl
         dBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696756651; x=1697361451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9DQlvd3k99P2AHDDStyFhNyOUtajCeUWyctk7cKSHo=;
        b=HmCVJiSfm4UToLGSTliMxJsRN+w3cGkOZds2E0nOkVSROBGClovpqxoRdBMiAocrKy
         esmNHsMKDoDO9rQ1EnVXIKs1mhcNddDbLsSwu3AJF+xdkaGNhHxfArAikiEUc7LfURNE
         jwskW4J7XyS8yz+LmuDQMqJ1nt1LSRB/pqVkUngjnM/uIgHjfKB36Yd8I96kaBKnzJSU
         9CzSOpm5vmWIHW3M3F43y+2BLi3RaeHEcx/gLEMfl2ulE59qw6p9e6uA2oM6kLd4SVMR
         MffhfIX4a8zJPfIFK3bTFEYraA0+vxKzuKYJ+w/ViXVYpFBmpwPIBLAL8kgFqchxtMYa
         pMMQ==
X-Gm-Message-State: AOJu0YyPbLnAculOqkSB5YHTOyhYclkgsPCQlKu6tRpTqOjG8T20HJW5
        uu58t6JF4J37mkzvIFPhk4RnfuW4DMV7nQ==
X-Google-Smtp-Source: AGHT+IExF2voVEP5meEi/OFas4XMzB7czyTnmWHi9q5QJs8KySdUIHA6sI2gozGbcCyi6vbg6IQquA==
X-Received: by 2002:a17:902:9885:b0:1c6:117b:7086 with SMTP id s5-20020a170902988500b001c6117b7086mr12197155plp.5.1696756651431;
        Sun, 08 Oct 2023 02:17:31 -0700 (PDT)
Received: from sidong.. ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c20a00b001ae0152d280sm7127020pll.193.2023.10.08.02.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 02:17:30 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: qgroup: check null in comparing paths
Date:   Sun,  8 Oct 2023 09:17:17 +0000
Message-Id: <20231008091717.27049-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch fixes a bug that could occur when comparing paths in showing
qgroups list. Old code doesn't check it and the bug occur when there is
stale qgroup its path is null. This patch checkes whether it is null and
return without comparing paths.

Issue: #687
Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/qgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index d9104d1a..265c4910 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -486,6 +486,14 @@ static int comp_entry_with_path(struct btrfs_qgroup *entry1,
 	if (ret)
 		goto out;
 
+	if (!p1) {
+		ret = p2 ? 1 : 0;
+		goto out;
+	} else if (!p2) {
+		ret = -1;
+		goto out;
+	}
+
 	while (*p1 && *p2) {
 		if (*p1 != *p2)
 			break;
-- 
2.34.1

