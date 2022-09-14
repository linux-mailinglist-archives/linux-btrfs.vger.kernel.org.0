Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1695B90C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiINXFF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiINXFA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:00 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520318367
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:04:58 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j8so2000406qvt.13
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=BcGA3Wmzbvy7Fkoup35RJ0w5yvuuEpFxyRZfOKD8KU8=;
        b=N8zIkAIh/GO2wd63i9In+XMS0I8BI30dfYDVa0YABorSDjKqH8zVPrStxPlhpjaxlN
         iseaO23qakgIjGnNqTU3YrxPUPOz0j2IYyNO2dy+4v5OdjquM629hGFEWqfxZHn6SiUg
         DxVwtPBc7xPLroL6sVAZVwbutqyAag4tKXo09dILOk0h5L/IpnUVxxa0TXY6QDsaeI98
         nmBqX5cJhYCxcZy/EMLMlrbThtaWkvsJ/GlrSGb9TNKfSsGPg1TxdeFii9MOadgsoeND
         iEtM8JbCm0f2UuyYuDGJO/n7W/rs+jxSVYJ62ozKL2Bjp0uTCs45tsqElYqr6imEkWJ1
         rpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BcGA3Wmzbvy7Fkoup35RJ0w5yvuuEpFxyRZfOKD8KU8=;
        b=lhNaHqPMAhJGYyhaheeIxnaQ67uL/5j1N3JDDwGd49B0DGHZ1MXvbRko1z8LEev+XG
         HJo6NFggYAn/6aPEGqiMQAMN5cBV4wdSN7EMwnPO6fOW6Y2mGSfioIE5LsGmA/ghAVkT
         Tge1Ptyy/pr4O4PjOk7TyK5YnRN72psoqx8vj2+AAaQXUqmJ0rzagBfmiwLYMPJKQwLb
         89v0zfknQ5TnKqkmxcJGXNCkVzvxV74HO9gXlvnjDg009035oSjzK5H6JhOjg4zYpQZx
         Q0zz2l32IkfK/4jt0GDNg095AW9r3rKCp2Tv3wHtNS9MHBfVSaMkQDPR7GYz7qAjiOFK
         mumw==
X-Gm-Message-State: ACgBeo0fVSBz6w3kenA8sLqCkQeLf2VEWzt/B4Vdco6tNIew60l3qY7Z
        AZheGLY44msyLt+45UMIqnBG01UZV/7MQg==
X-Google-Smtp-Source: AA6agR5hY5ouAd09oMNuPthqrHyPbONak8/E2kJt8JkUqYqPskvnlWvSKwtqDG4Im/wI5Czjs5FI2g==
X-Received: by 2002:a05:6214:1cc9:b0:496:aa2c:c927 with SMTP id g9-20020a0562141cc900b00496aa2cc927mr33673044qvd.15.1663196697377;
        Wed, 14 Sep 2022 16:04:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e12-20020ac8670c000000b0035bb6298526sm2436395qtp.17.2022.09.14.16.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:04:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/15] btrfs: move btrfs_init_async_reclaim_work prototype to space-info.h
Date:   Wed, 14 Sep 2022 19:04:39 -0400
Message-Id: <57fcc1acc5720b8edf4b3d6bc2df224a8e196d4d.1663196541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
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

The code for this helper is in space-info.c, move the prototype to
space-info.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      | 2 --
 fs/btrfs/space-info.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 12d626e78182..0c5a6ea2eeb3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -211,8 +211,6 @@ struct btrfs_discard_ctl {
 	atomic64_t discard_bytes_saved;
 };
 
-void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
-
 /* fs_info */
 struct reloc_control;
 struct btrfs_device;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 729820582fa7..6e2947688c53 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -217,5 +217,6 @@ static inline void btrfs_space_info_free_bytes_may_use(
 int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush);
 void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
+void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.26.3

