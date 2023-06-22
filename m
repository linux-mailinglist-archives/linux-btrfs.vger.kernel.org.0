Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72995739BD0
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 11:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjFVJEb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 05:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjFVJDt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 05:03:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0646C2126
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 01:57:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-54fd4a7ce25so1096462a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424227; x=1690016227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsvVWwvjCNbIpzLWR+JMbRdqcPMoA6IncSRNtrMJjtk=;
        b=btQFnTi1+Jxgpt9ZEv6SV1CxbtEwEnpYQ1WSSwhfGLNNoz+3LZU80wQIeDEMGJinhi
         8+hFjjrmI0Ti2weoui+1nba3fuqZZ6jN3eQN4e+CjSeo0Ggyrqg3j3GGKdGsxTGtEKKB
         6n4ntOH8ClqO9PsI9RmJeFYa/h0xYT0vefdwMfx1z83TBiR/mTSXCJDkn82jEtfe964Z
         +W5pu2WQm5/BmUewzteVLri/ASv79HUROzRO9GvLtgUyAJkwQyVDE/hnKFhVeWh3zZR/
         QE/dybVozXXKkm+aMId69JeSrmobjvQPBxgZrNjMENKTPWKUy1hHiQ4+Qa8p1f7rRS3j
         Hymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424227; x=1690016227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsvVWwvjCNbIpzLWR+JMbRdqcPMoA6IncSRNtrMJjtk=;
        b=BaTb3z3XYlScmeBItSh/MvCiFqQAiw+PuT5jKY27dLjGZd01F8XOgIFoy1KI5ywHm7
         VWjDfPn4cJLFaEwasSCSZcGmztfmPqU9Tm0jJsBDHlwLFJCH1pn+U+XDlD3I81ODg8fN
         +IXVcUMFtsQY6Gd4nJHfEhLKqty2dZW2gWWL+yZorJPsuiR5Rq4qxxsF5OEqgc8ylgUt
         y3tN9mgjNrCmtCTEwtDoUmRmA7VXUHs7Buhhh1GTJ74f1QmSQhiI0MYGtkKfO91s5byY
         pqQGA+8YYvQDWYoaYbW8Ew9TsoJmKc6/f9NUlaYPKfIBc+S8crTaGSdUOPKjYVrRh0Yp
         UiSg==
X-Gm-Message-State: AC+VfDwTCDC0arr0I8vwazIbcNFe8SlBiRoe/pwfmJhost5FdIi1wUTl
        D7vaKnLT55yY3FZgjLccdYcEHQ==
X-Google-Smtp-Source: ACHHUZ6IzlQYehvkbwm6qTB7qvbww6jKgEwXRnqs2X+ZAvHSdOqqO5hMcbKXrRtXSYnzqJ1v0JsE2A==
X-Received: by 2002:a17:903:1105:b0:1b3:ebda:654e with SMTP id n5-20020a170903110500b001b3ebda654emr20780380plh.5.1687424227653;
        Thu, 22 Jun 2023 01:57:07 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:57:07 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 23/29] mm: shrinker: add refcount and completion_wait fields
Date:   Thu, 22 Jun 2023 16:53:29 +0800
Message-Id: <20230622085335.77010-24-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit introduces refcount and completion_wait
fields to struct shrinker to manage the life cycle
of shrinker instance.

Just a preparation work for implementing the lockless
slab shrink, no functional changes.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h | 11 +++++++++++
 mm/vmscan.c              |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 4094e4c44e80..7bfeb2f25246 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -4,6 +4,8 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
+#include <linux/refcount.h>
+#include <linux/completion.h>
 
 /*
  * This struct is used to pass information from page reclaim to the shrinkers.
@@ -70,6 +72,9 @@ struct shrinker {
 	int seeks;	/* seeks to recreate an obj */
 	unsigned flags;
 
+	refcount_t refcount;
+	struct completion completion_wait;
+
 	void *private_data;
 
 	/* These are for internal use */
@@ -118,6 +123,12 @@ struct shrinker *shrinker_alloc_and_init(count_objects_cb count,
 void shrinker_free(struct shrinker *shrinker);
 void unregister_and_free_shrinker(struct shrinker *shrinker);
 
+static inline void shrinker_put(struct shrinker *shrinker)
+{
+	if (refcount_dec_and_test(&shrinker->refcount))
+		complete(&shrinker->completion_wait);
+}
+
 #ifdef CONFIG_SHRINKER_DEBUG
 extern int shrinker_debugfs_add(struct shrinker *shrinker);
 extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3a8d50ad6ff6..6f9c4750effa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -740,6 +740,8 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
+	refcount_set(&shrinker->refcount, 1);
+	init_completion(&shrinker->completion_wait);
 	list_add_tail(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
@@ -794,6 +796,9 @@ void unregister_shrinker(struct shrinker *shrinker)
 	if (!(shrinker->flags & SHRINKER_REGISTERED))
 		return;
 
+	shrinker_put(shrinker);
+	wait_for_completion(&shrinker->completion_wait);
+
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
-- 
2.30.2

