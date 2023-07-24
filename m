Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC27375F154
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjGXJ4v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 05:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjGXJ4c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 05:56:32 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F181709
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 02:51:17 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1bb5dda9fb7so55235fac.0
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192179; x=1690796979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVIFplaZ76DyAQXZ2ZJxr5973JfmLiF6XogxT7JwM8U=;
        b=IMUEORjdlWhSmNbZ8C87l7r8U0AAnqDq1kS91Y9PryaVoBPpt12B3R2EPITKemYxFT
         cTbotH9duDwEC6zbz58LF7e1mOrlQMfNsUzCpG5I7vCWYuwMqfJAgY6T5nkBBpa5b4fX
         ifzDCt67Qs532BO9x06euq5RUMILjDmWiXveNZtrvboj0oP79W8NTk+wdcLpuCaN1ym+
         I32zZiKOLgR9Z50+hIuA7HR7ucvkzUQ6vNBPBf8BnZDH8yPLNU1XerFoolxB0pjBTUyo
         wOy7ybn62IKA+GvT1vDibUOGWwkycDhLPCfA8VReMlg/bkgjXfP7cfVfl7hANLeut+bD
         ERpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192179; x=1690796979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVIFplaZ76DyAQXZ2ZJxr5973JfmLiF6XogxT7JwM8U=;
        b=KO+TH+exvn/cHWN7M7CM/tLBxL4mi7X6WCUCIkPfpwIPqYeA3R8Y/EAmtzvuc+IqeY
         20Ch1m07Qsp3ioJ9ewOumWkOVswpiFM1H5Md2mxsl0x03O5zz08Y3jDEVRXXppGC0OqO
         Ytlq+5gWzmBDi+QAbYYqxfxOYa4FpSNRnuCTswUYAAR91ToYlr0XRe0bpqkehKJ+sLqj
         Li4eNVYseXrVwsOJEB/NYbg27SzNML+3DhYs+OzIv04w9WejsiBVFoP8zKELZqi/f+VJ
         YugyJw3/2VmXh7C7kLDMYRd/vCnHCwqcNb8DqBZEq2yD/JCM+OhWi4ugqWJoK+XhVTAu
         YPyA==
X-Gm-Message-State: ABy/qLbgXmIYUtrtuQvycNmOpJ0vGdDyLhPX0OED3aKnYm0FkjSfntEH
        nEi4orK+MihOp2ZeO8tiFdrsLZnwXAfV7OHdo74=
X-Google-Smtp-Source: APBJJlFR9Ju5Vfb3AHUJ7jWuLYrfbcu6xuKCy8KktQCx0EpABVN8oHS8r350MQ/TdmOpiBIOkTrovA==
X-Received: by 2002:a17:902:d484:b0:1b8:a27d:f591 with SMTP id c4-20020a170902d48400b001b8a27df591mr12261184plg.5.1690192158548;
        Mon, 24 Jul 2023 02:49:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:49:18 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 21/47] mm: workingset: dynamically allocate the mm-shadow shrinker
Date:   Mon, 24 Jul 2023 17:43:28 +0800
Message-Id: <20230724094354.90817-22-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use new APIs to dynamically allocate the mm-shadow shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/workingset.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 4686ae363000..4bc85f739b13 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -762,12 +762,7 @@ static unsigned long scan_shadow_nodes(struct shrinker *shrinker,
 					NULL);
 }
 
-static struct shrinker workingset_shadow_shrinker = {
-	.count_objects = count_shadow_nodes,
-	.scan_objects = scan_shadow_nodes,
-	.seeks = 0, /* ->count reports only fully expendable nodes */
-	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
-};
+static struct shrinker *workingset_shadow_shrinker;
 
 /*
  * Our list_lru->lock is IRQ-safe as it nests inside the IRQ-safe
@@ -779,7 +774,7 @@ static int __init workingset_init(void)
 {
 	unsigned int timestamp_bits;
 	unsigned int max_order;
-	int ret;
+	int ret = -ENOMEM;
 
 	BUILD_BUG_ON(BITS_PER_LONG < EVICTION_SHIFT);
 	/*
@@ -796,17 +791,24 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = prealloc_shrinker(&workingset_shadow_shrinker, "mm-shadow");
-	if (ret)
+	workingset_shadow_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
+						    SHRINKER_MEMCG_AWARE,
+						    "mm-shadow");
+	if (!workingset_shadow_shrinker)
 		goto err;
+
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
-			      &workingset_shadow_shrinker);
+			      workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
-	register_shrinker_prepared(&workingset_shadow_shrinker);
+
+	workingset_shadow_shrinker->count_objects = count_shadow_nodes;
+	workingset_shadow_shrinker->scan_objects = scan_shadow_nodes;
+
+	shrinker_register(workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	free_prealloced_shrinker(&workingset_shadow_shrinker);
+	shrinker_free_non_registered(workingset_shadow_shrinker);
 err:
 	return ret;
 }
-- 
2.30.2

