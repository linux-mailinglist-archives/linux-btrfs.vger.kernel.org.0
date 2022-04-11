Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F474FC1AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348388AbiDKP6a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 11:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348354AbiDKP6T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 11:58:19 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104CD205C8;
        Mon, 11 Apr 2022 08:56:05 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b16so19237176ioz.3;
        Mon, 11 Apr 2022 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vceo+RAyT/EW19vQ+PlKVYgDIlHxuAYrR67tVfgRoO4=;
        b=LB1SK6Ycdncwa1zdGkw756ua7rfc6E4fcHZOziYi0BxUXsTSAQjc5TE7FsyFA4KnJL
         AZcNGvXacROBNUEzDiGOdCGP/I0X0PF3gI4r8tzxqU2X5jwqRmP5O/NdZQdesaw9I4Ax
         gP0VftP2ZWMpi0WytiVkhytrVI+oBXWxQB0BpaL+GndPVt0GimT7f3Fc8V8tqbJ1Gi8O
         SoZJZ2Gs8/83Y/yDNXjYtqpvYcRHAlrUmt3mdtVU/OSqXM+T897aIjpTgOnutT0IKZ1O
         T6fFgWtUuxJRgv1T/UdrA299GJkvhM3ZKcVbKaFVfJ5/k+4jdXNhahbnpPQABxuiiPfY
         UD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vceo+RAyT/EW19vQ+PlKVYgDIlHxuAYrR67tVfgRoO4=;
        b=y1yarJvZZl05i6zqt6Bd6Lec1jtrjX+clPH1seYG210qQ5pUkpA0Im6xOY+8rFl38V
         F0itCimwKgZ5TJc6Vr6a92yzXbnIotXD+uTe4/xVOIHZ1soTIamXVPONGdqhzWz8tBhC
         YI5kbhaEVsuNbf8M4STyNyXfoMavXbY+xnyaFjQLYtJg0J3zKOIgjZLZkxoVrZlVnYyi
         qK2M0uZu8VI2XQHYWYAoQ9Kz7F0+SVgrAdg7lWbgmURW22FV7WLP+3JdJXg0J57i5kn2
         w2/aGjP0aXtPTLU0iwhs8naL7dA8sDY8IJJI2yV73NgunveBtVxgcbjGfxitOcBEhwpH
         o4gQ==
X-Gm-Message-State: AOAM532yhibZfxfs0pKEZb5vyw13uImOQYUoK+iXXrFLI7dR8CwjM0TM
        LOFyreIBETpOVBvRwItziwxifnUH7tWKsqO8oio=
X-Google-Smtp-Source: ABdhPJxJAlWWh0EZgcZeswPbH8fIeCWZQFEJN1N2cmO8OHyOUBKsKTdDu/YUqyc9aSFBwZJB5fZMpg==
X-Received: by 2002:a02:604f:0:b0:30f:e6f1:3883 with SMTP id d15-20020a02604f000000b0030fe6f13883mr16630902jaf.266.1649692564453;
        Mon, 11 Apr 2022 08:56:04 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id j9-20020a926e09000000b002c9f3388cd4sm18299328ilc.21.2022.04.11.08.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 08:56:04 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     dsterba@suse.cz
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com, terrelln@fb.com
Subject: [PATCH v2] btrfs: zstd: use spin_lock in timer callback
Date:   Mon, 11 Apr 2022 23:55:41 +0800
Message-Id: <20220411155540.36853-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220411135136.GG15609@suse.cz>
References: <20220411135136.GG15609@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an optimization for fix fee13fe96529 ("btrfs:
correct zstd workspace manager lock to use spin_lock_bh()")

The critical region for wsm.lock is only accessed by the process context and
the softirq context.

Because in the soft interrupt, the critical section will not be preempted by the
soft interrupt again, there is no need to call spin_lock_bh(&wsm.lock) to turn
off the soft interrupt, spin_lock(&wsm.lock) is enough for this situation.

Changelog:
v1 -> v2:
	- Change the commit message to make it more readable.

[1] https://lore.kernel.org/all/20220408181523.92322-1-schspa@gmail.com/

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 fs/btrfs/zstd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index fc42dd0badd7..faa74306f0b7 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -105,10 +105,10 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 	unsigned long reclaim_threshold = jiffies - ZSTD_BTRFS_RECLAIM_JIFFIES;
 	struct list_head *pos, *next;
 
-	spin_lock_bh(&wsm.lock);
+	spin_lock(&wsm.lock);
 
 	if (list_empty(&wsm.lru_list)) {
-		spin_unlock_bh(&wsm.lock);
+		spin_unlock(&wsm.lock);
 		return;
 	}
 
@@ -137,7 +137,7 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 	if (!list_empty(&wsm.lru_list))
 		mod_timer(&wsm.timer, jiffies + ZSTD_BTRFS_RECLAIM_JIFFIES);
 
-	spin_unlock_bh(&wsm.lock);
+	spin_unlock(&wsm.lock);
 }
 
 /*
-- 
2.24.3 (Apple Git-128)

