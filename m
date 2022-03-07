Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996C4D0B3C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbiCGWiT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiCGWiM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:12 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351366158
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:18 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id o22so4994490qta.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QcwZ3r0R65WVfk8zYBoKGcCZQdoarc8HGdNMB4KwkqM=;
        b=3+368lKWF1E25bhzZLO3iT/ysKLTIVpj534aYtgi/tntbofsg3F4qONbMNlBWgSx1h
         We8/Pcqhu5MtGINKC8QtpfCL8s4cyX3uIp6ikWDrXhpisub7sfDKS5zpeNw4di+gvBFj
         NvzPcez7lmydapT7ZWNJUF2a2zco1MarPcM3EaxjzsDR0VE0su+VfGGCEjth9XpqFW8B
         Fw11PEnyzuxoXFNq8gAy4VlBaRSTgKmD2sknqF5zpfN1gAOd9OACRkVbhU4NSEwLPLmh
         oHh4sG0oRzSeNfPiV+CyD7Cr7HypGnVOwtlyzp6+d51APUxF/FdtIKjmwpwazpim4qMM
         +ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcwZ3r0R65WVfk8zYBoKGcCZQdoarc8HGdNMB4KwkqM=;
        b=qvLf0E38q+XUUq/BvOBY/RZol/JFfel5bVKL5ZCJIlSNsjhEzxD31ZrAbaHIU02TKq
         Pvl4SNge9kN7YyqovGNTMAt1R3vsHSgFPj9I99rm/Tai+NPaXd8s9SiwnYmuciwm5bvG
         Okx8I3HYfvmS4UTWnWsiZRaaMp3CA2a8PHeFgR2JVDxVsLqn5zdtVq/MYZarPsZhaSMT
         tY4T9go26BZybenN2KN0VVdBae/CgJdNYF1huXa7+dWwm0IHdSMr2MBUCD+49a1++yhY
         lWKT6iMcgbL+gpAaAQbhX2Zu4f97Zh3IbV+6BD/uj8fWI+plDBuxZuuHvjnyEUA56J6u
         9ClA==
X-Gm-Message-State: AOAM530xJsGxtJApQ30KfX0MgxLPPX89s5QTtKMUyqLIntVc2jCSbi6M
        dCHqHrcYv5G2o8q+oBluSjkJ2gpDq7SK+ETE
X-Google-Smtp-Source: ABdhPJyPvHqh/3ypWrf7ICQIaxSRYjxxrDeSIRoXlrVkrZ4s3E4s6UK3CI//FVyQxqjbMGfohm70Aw==
X-Received: by 2002:a05:622a:3cf:b0:2dd:57f6:f112 with SMTP id k15-20020a05622a03cf00b002dd57f6f112mr11202063qtx.522.1646692637065;
        Mon, 07 Mar 2022 14:37:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a22b000b0067b7b158985sm660295qkh.128.2022.03.07.14.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/11] btrfs: don't do the global_id thing if we are a DUMMY_FS_INFO
Date:   Mon,  7 Mar 2022 17:37:00 -0500
Message-Id: <43b43374beb50ec94e26260ddcf06e303bc3cfa5.1646692474.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692474.git.josef@toxicpanda.com>
References: <cover.1646692474.git.josef@toxicpanda.com>
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

I want to use extent tree v2 in our self tests to make sure the extent
buffer related tests all do the correct thing, which requires setting
BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 on the fs_info.  However we won't
be having per-block group global roots for the dummy fs_info, so add
another check to btrfs_global_root_id to bail if we have DUMMY set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c4e9d69ed672..00e97156101b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1308,6 +1308,10 @@ static u64 btrfs_global_root_id(struct btrfs_fs_info *fs_info, u64 bytenr)
 	struct btrfs_block_group *block_group;
 	u64 ret;
 
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
+		return 0;
+#endif
 	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
 		return 0;
 
-- 
2.26.3

