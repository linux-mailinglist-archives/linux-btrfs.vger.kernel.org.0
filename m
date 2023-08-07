Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914737721CA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 13:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjHGLZH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 07:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjHGLYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 07:24:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050651BFE
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 04:21:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7576b53e75eso67207785a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Aug 2023 04:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691407220; x=1692012020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5ij/O+E/bk/tTzX9mgxwiCynzBHcXx4EKtI9EsHayo=;
        b=KlCzpa+HweO5nK0VIlZBRpNaHFQ/kVTag22itCsbSNAT5l84Fai20X9wQuvl4MCmcG
         HnKfuJQr09yvNQVL2E4NJIhvse7y5Hr99REmrxl5UQJbRd+UbgD/ZymCaX4RASWMgEHR
         i+dm0wUvNhmPoIiq8QNrWz7ByqGCyJ5Z3SSo7tRhMV4LfZVEqqKSSWbKXaxowebacvbY
         xUrWN53gXaRUUxYEKkyAE3/lhfMoaqvHdmnhFwALkoe7tETkpWahNUYLrG6zKuBKgFHX
         fbMbq2REplee85WdJCKtr6FAnm/aEwEIulG+/1/SufEDnYuoiswQW8H8ykZHToQFNHhM
         Q4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407220; x=1692012020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5ij/O+E/bk/tTzX9mgxwiCynzBHcXx4EKtI9EsHayo=;
        b=gGmYYB9LhjZCnLCChhZkxABUDe6Wewa9foDPueYGHC1c3HXkX+RYUd4PNoyUt3C9w/
         beAqchfCFTHhSrp40trYFCOpZDmjL2ccMiV9N5Vqvds1G2GsX7QILlnIQZE/hM51JxZc
         M2X/6t28Z6HBRIlCoR5ofHAVsK54pWa0ch1sZLDQyjjkiqCuRt8Xq3//lMQ5VBUREXMv
         7fFFKKvCqiFQdtvOKnfBdNug2jSljFR/5gmpIZdB5wsyyhxytqYw1VHnLSQ06qU3qoCN
         m5AZdjdRQNzhu6QQhTD+l/WWuVwd2bcmOJRj9ITutmmMYKom3+GV5ICCDO6+sRNroI9J
         gztg==
X-Gm-Message-State: AOJu0YxkoaU5LtHeL1cbxkCvNJhCDpqvSWlWh1AVHT38Ug83ltkAVbHp
        DB83WNpwFlPgxvsLLVUhOd/PBBghBKBK1xx1rag=
X-Google-Smtp-Source: AGHT+IH1iUQIXRu8fJbzxUHSh+kWmc44BJdJFh0ZxZy41KSEiq7lusFAb/6JfkXEPdg45Q03TKbByg==
X-Received: by 2002:a17:90a:9c3:b0:269:41cf:7212 with SMTP id 61-20020a17090a09c300b0026941cf7212mr4973775pjo.4.1691407200010;
        Mon, 07 Aug 2023 04:20:00 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:19:59 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org
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
Subject: [PATCH v4 47/48] mm: shrinker: hold write lock to reparent shrinker nr_deferred
Date:   Mon,  7 Aug 2023 19:09:35 +0800
Message-Id: <20230807110936.21819-48-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For now, reparent_shrinker_deferred() is the only holder of read lock of
shrinker_rwsem. And it already holds the global cgroup_mutex, so it will
not be called in parallel.

Therefore, in order to convert shrinker_rwsem to shrinker_mutex later,
here we change to hold the write lock of shrinker_rwsem to reparent.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index fee6f62904fb..a12dede5d21f 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -299,7 +299,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_read(&shrinker_rwsem);
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -312,7 +312,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			}
 		}
 	}
-	up_read(&shrinker_rwsem);
+	up_write(&shrinker_rwsem);
 }
 #else
 static int shrinker_memcg_alloc(struct shrinker *shrinker)
-- 
2.30.2

