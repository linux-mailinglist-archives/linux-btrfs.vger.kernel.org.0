Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58F360BA76
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiJXUhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiJXUge (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:36:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB871CC75D
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:25 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m6so6643081qkm.4
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUQv0b9y+FnSE/941xqXglEbXL2ugL78z0kytNSqe90=;
        b=09oYtDU+tznnB36K2OS8VKh6CiBX7mTYc8526BuR8Szw8320bQgb/zoxkJucGYOTlE
         9yPZdXwqhiqZDQwcRzQHtPuABJk3eru5Ax6ooOxRcQI0kuqkKz76msgugb2QyNVoeala
         ge5xDJTCO3Ymp4y/BxRKLhrau+wqB/9AlPU3RMP6z4sdWpy4GGHuPkjrfmdu8aWg2e1T
         XfAmYHyptI4T4tGUOqbYvDlJP7AMb+ZMoRWg8Z8T6+cJIDGSoO5TDQOuW83c4gqPhAQI
         6nF/HWGmZSzSl/jTB93/rFEE8paLrF7IsB3cZunaDI57fwj3cTJFtpiatTEC7dLT6qQg
         8tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUQv0b9y+FnSE/941xqXglEbXL2ugL78z0kytNSqe90=;
        b=45oVsu1XekQuJPqrmQ/ZOXVTpC820/wKzcmd+193tTnd2qVt5chSdUh97H93gnfNUP
         Pc0ySKrVWFHyWrfmrAtwCMJsahPXfojNog1i3HaLdFci00WrHE+67fulAZClOyTd6qJ+
         Uei3MKQEde5WPp493f2ALuHjlMzXdJjW1fbj5ntDULavXlCcgWlRmZbBn3akkx0aSS5y
         xr8MW+qe1QfBUkppziSpelUbraZq8cNJejK1kEPFF8n2BUjDWJj87keRFLtoix7qJ/mr
         iqkZLGJmMK+Lo8WZpjPaq1do08aZ9QNWwlDmUBVr6Z822ZHIYOGIDDamqbtIxhlsJgFP
         9u0A==
X-Gm-Message-State: ACrzQf1eoIrRyE3/P4yjmaAe2nDqHE3pWpusNuZE7AS2De5Nv7aG6xNc
        FCgpFilvupZZ0hnzgPl1Kpw8CtajL+a8aA==
X-Google-Smtp-Source: AMsMyM7hd2qqVrEDjqaahcvz8xxBClpxfbCzC2ywzvMSL4eyWs1eNDQyoeVuNM6UqmUisFvPOyzv0g==
X-Received: by 2002:a37:4247:0:b0:6e7:6992:93c4 with SMTP id p68-20020a374247000000b006e7699293c4mr23725065qka.696.1666637234975;
        Mon, 24 Oct 2022 11:47:14 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05622a489200b0039cb59f00fcsm380478qtb.30.2022.10.24.11.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:47:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/9] btrfs: delete unused function prototypes in ctree.h
Date:   Mon, 24 Oct 2022 14:46:59 -0400
Message-Id: <13fc8df173747660da9bbc8e8da7e082d7ff060a.1666637013.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666637013.git.josef@toxicpanda.com>
References: <cover.1666637013.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This batch of prototypes no longer have code associated with them, so
remove them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 04d1568b4bd4..1aff14f35796 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -498,12 +498,6 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes);
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 
-int btrfs_delayed_refs_qgroup_accounting(struct btrfs_trans_handle *trans,
-					 struct btrfs_fs_info *fs_info);
-int btrfs_start_write_no_snapshotting(struct btrfs_root *root);
-void btrfs_end_write_no_snapshotting(struct btrfs_root *root);
-void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
-
 /* ctree.c */
 int __init btrfs_ctree_init(void);
 void __cold btrfs_ctree_exit(void);
-- 
2.26.3

