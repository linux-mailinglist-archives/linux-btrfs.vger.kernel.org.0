Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0E4469D2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhKEUng (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhKEUne (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31AC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:40:54 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bq14so9888942qkb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QKXiyseXhQbPFFyxX7MyImwdI7hDpamDr18fg7TVr34=;
        b=OqaTupeS5aiXtgXBmh7BoZ0XpU6wD4P8P8g5bMlLxIWicarrRWQd+Cy1p959pZ/Se2
         U40hw7bZfXr/dPTyHcMdt5NGmrbUGT5F0xtNJq9R0SE1U3DqzyaFcQPhDEMnEBgVm+06
         jbla9eiA6fj39wuHT+NP6YtKFP0juY98E8qtT2bGG86dR0DTDuztAQHQTDgCDydyz6yt
         txF/4syBKi4jdbmYyCBsQVYt61lZzVcHWWzraytO8TGrr1LYtk8zyaY/RbpJWlqfTh3x
         NFXc9kLkdVASRYhIVsEAp0vCYLVSoLJHdUVuGrWiC6Wq2BMseDkQvPcAmDMboPCHTUQP
         5nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKXiyseXhQbPFFyxX7MyImwdI7hDpamDr18fg7TVr34=;
        b=VYyZdicdS+SbhwdTZiI2pSM9KQfpBjoQQHSkxdnA/6kYJu20PHUFpaTynUjy3SoVrq
         E4wttrQipNyS3yaUXQxi2HLcmSFn6qKyXxvYpZzRdoAINR8Ho8YtuuS7lEo4QgAWwjZv
         H0LV3wgb1LKvbyL7uxdiZKkaF7tFInJwmLatjcIU8iM+3dyb2ttlMd/pYCb/hrT2c9Y9
         4ouXdS1BQygEjiu4auIOyKKYz2E4+OaRLr1aQkpRUq2VLyQVnzBAYN0ortjZv391+lk4
         id/Z/QhLM4X9YX5RXOAhkmYyKa1VgGiW71dkagsWDneTs/yxYMu/KJkDEOXGm1dXmmoU
         /U5A==
X-Gm-Message-State: AOAM532WyMpTJCEUZlT6WPDuurqNmrxWpkPLSe8AU64ajeSQBFJS+zva
        KLwc0Ar4FKGiK0cyutOC5wsOukVDWOX2dA==
X-Google-Smtp-Source: ABdhPJxF65SLOKndqMAVkqSFHlbYDsbWlgkBtntKtPgTkoi+1IbU7YoTYJxcWLjJcTfVEnGPJRBU8g==
X-Received: by 2002:ae9:f405:: with SMTP id y5mr20361577qkl.233.1636144853366;
        Fri, 05 Nov 2021 13:40:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e10sm6409570qtx.66.2021.11.05.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:40:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/22] btrfs-progs: add on disk pointers to global tree ids
Date:   Fri,  5 Nov 2021 16:40:29 -0400
Message-Id: <7dfbff180e23ed8a82a81ee3a9c0320b4d2969df.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to start creating multiple sets of global trees, which at
the moment are the free space tree, csum tree, and extent tree.
Generally we will assign these at block group creation time, but Dave
would like to be able to have them per-subvolume at some point, so
reserve a slot for that as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 17216053..e54e03c4 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -824,7 +824,13 @@ struct btrfs_root_item {
 	struct btrfs_timespec otime;
 	struct btrfs_timespec stime;
 	struct btrfs_timespec rtime;
-        __le64 reserved[8]; /* for future */
+
+	/*
+	 * If we want to use a specific set of fst/checksum/extent roots for
+	 * this root.
+	 */
+	__le64 global_tree_id;
+        __le64 reserved[7]; /* for future */
 } __attribute__ ((__packed__));
 
 /*
@@ -1709,6 +1715,12 @@ BTRFS_SETGET_FUNCS(block_group_flags,
 BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
 			struct btrfs_block_group_item, flags, 64);
 
+/* extent tree v2 uses chunk_objectid for the global tree id. */
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_global_tree_id,
+			 struct btrfs_block_group_item, chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(block_group_global_tree_id, struct btrfs_block_group_item,
+		   chunk_objectid, 64);
+
 /* struct btrfs_free_space_info */
 BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
 		   extent_count, 32);
-- 
2.26.3

