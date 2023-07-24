Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1033475F09B
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjGXJwO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjGXJv4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 05:51:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8843C0B
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 02:48:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6864c144897so1022806b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192086; x=1690796886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztwb9n/1dXh113w/8xubUIoix8VXd/5rqVT4RvFn/tw=;
        b=Am7FnjS3Cpm4I6+unn47wV0WInP35j7cWyw7YSHmXYddBbEndaPLIOhBD501lhuXhz
         ziS0uq23cHOpl1MZygPYTe8AuNvoAdPlGK8k32I3Ef9lRu2tiO1YjBbYZCD1R2rMLxT1
         sbS7mgch7/EfOaLRKT3V6tvhfJSY21ngFnqMEHN8grEnjoqg0M6Q11qf7CVQTrHQJzW3
         E1Q+qRl3oeLAaumIkMGruzrANQhf6ocLGFa54JS2CwGaWbDUA2Re4gbZJ2jDKM9ntSrw
         dCSeZvHulgVnMl/ivIn59gXFxJS3Mnbl4ERIMhlA37amtawTgx9ciEfDapqLjZzr2ZBw
         AsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192086; x=1690796886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztwb9n/1dXh113w/8xubUIoix8VXd/5rqVT4RvFn/tw=;
        b=Ks4g1lDxbYbDp1E9xzdN5wDGTmjzdf1x3Mfb64IAmqEpR73ScaY8Rj9MTIhg//J/6Z
         3kxwEg1DmMxFFoHYD0+y6cnqxeuxYBxpvrZjK6+UsjbIaI0JryGFWV/G7ELdwPvrmLLy
         AiNQ67amqRPvnSHA3tWtbVKHJQwmKCoey4ZWBii4iK431ylA16bOox/4a5rXTkR6H4wE
         DLhZj3Lgwm19ldVQNfznupA3TM9VDEHo+sWxxQ21VIwr7fFAEZqyHJU5Nw0IwA07QlmS
         /QSUbEPK4Y4j1Wqe69ROVzgKG+tdo+BZ6jtG3/rtwJ9ZQWPZIBkJfi/ciowaDz3DGZD4
         gj1g==
X-Gm-Message-State: ABy/qLbGhypstCPw1h2gNBm6G5JbAIiT3E0To4Gy3kGZIc4ZBw0UFR5e
        q68t3oOdR3ROHIcay7CdBvVp6w==
X-Google-Smtp-Source: APBJJlHRxCFTSeAmJPIiRwzXlrngv0y6n5gqphR6YCBFCcMRvGq0CtVM2WuFHUMj7p5y6QUWxkmpXA==
X-Received: by 2002:a17:902:dad1:b0:1b8:aded:524c with SMTP id q17-20020a170902dad100b001b8aded524cmr12538511plx.1.1690192086608;
        Mon, 24 Jul 2023 02:48:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:48:06 -0700 (PDT)
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
Subject: [PATCH v2 15/47] quota: dynamically allocate the dquota-cache shrinker
Date:   Mon, 24 Jul 2023 17:43:22 +0800
Message-Id: <20230724094354.90817-16-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use new APIs to dynamically allocate the dquota-cache shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/quota/dquot.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index e8232242dd34..6cb2d8911bc3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -791,11 +791,7 @@ dqcache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	percpu_counter_read_positive(&dqstats.counter[DQST_FREE_DQUOTS]));
 }
 
-static struct shrinker dqcache_shrinker = {
-	.count_objects = dqcache_shrink_count,
-	.scan_objects = dqcache_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *dqcache_shrinker;
 
 /*
  * Safely release dquot and put reference to dquot.
@@ -2991,8 +2987,15 @@ static int __init dquot_init(void)
 	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
 		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
 
-	if (register_shrinker(&dqcache_shrinker, "dquota-cache"))
-		panic("Cannot register dquot shrinker");
+	dqcache_shrinker = shrinker_alloc(0, "dquota-cache");
+	if (!dqcache_shrinker)
+		panic("Cannot allocate dquot shrinker");
+
+	dqcache_shrinker->count_objects = dqcache_shrink_count;
+	dqcache_shrinker->scan_objects = dqcache_shrink_scan;
+	dqcache_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(dqcache_shrinker);
 
 	return 0;
 }
-- 
2.30.2

