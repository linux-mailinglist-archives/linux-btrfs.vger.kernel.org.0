Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA514AE355
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 23:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387155AbiBHWVt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 17:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386205AbiBHTnt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 14:43:49 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD6C0613CB;
        Tue,  8 Feb 2022 11:43:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso2203146pjg.0;
        Tue, 08 Feb 2022 11:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47Zt1ciDlAfZ4CsVaghTCf8CTxEeHu+p/hM6Ax63pg8=;
        b=SMmHEK9AqUbqZLIwucjvRyGysfK96AdDbYtNYRCgagZmSxwc1w2HIUufH1A8ItRgep
         Jz5mDipLmvR9OY5cEMy1DwAGNkeDaQQn8Reuo1OukFlRbZB+oN+A1Q9D7cLj9Mbid/G7
         R3DxXDARvZCk6cSJL4vMoQduuaAowtBA/tRJtoqA5ha8uM2TW4qXxT/GVLp9w73Dv/n7
         3d5yBVIg8yaLMeshP38X1FNuWWahuIsRvFClqT+LI52wWuuToWlLAF9RzkdHnWbT8zdF
         BcA/Me+ULcQlKO1W4biSCA9doeTMeXKKfNQ+72B2MxdxTiF6pYTzdxDNRYV028gfR1nq
         Sq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=47Zt1ciDlAfZ4CsVaghTCf8CTxEeHu+p/hM6Ax63pg8=;
        b=Vskd9rXTdoWmq77k7M2RTdDJTGZbF4qUWwI4TPST5GLM5xg23Kp/p0+WhsyT/Nc1QL
         jSw7rjP8pdGO79iBoTnYZ9XQuBP2USw354lehNg02C4HhLRlV5mu5zjsnY7CnO4AJ7SZ
         YyApipqbMWOo41cPoKal5Vo72hHtO3POjpZW37zxnEmPlQAT5CpHph1gxg/edBCsHOSz
         iH/nf07Xj5zKNirzTD/U3iw5FdR7mN0JAZTqjf1huhvjzg3qKk+F9Rpk5FFGu5W9VIid
         T+hu6I4GgYfVpZy83tGqRjNUz0XWfv6EU95UKEYlVJjErzHdahVu7IgofWvIwO70w+J/
         kGHw==
X-Gm-Message-State: AOAM532I5eoe59PwKwPwavNRtQkEIfSuxf4iTqk4R/RWbeQKwpwpdQds
        Ir84hqDjbDhr//cNv4XTQpI=
X-Google-Smtp-Source: ABdhPJzd2Xi0GuGR4M7cbShojHTa5914O2E9YTB2ynvlq39JbRXCTw81IBVhXHOA5wx+3FrqqomSiQ==
X-Received: by 2002:a17:902:9343:: with SMTP id g3mr5950056plp.11.1644349428375;
        Tue, 08 Feb 2022 11:43:48 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:47 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [PATCH 06/12] btrfs: change lockdep class size check using ks->names
Date:   Tue,  8 Feb 2022 11:43:18 -0800
Message-Id: <20220208194324.85333-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208194324.85333-1-namhyung@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With upcoming lock tracepoints config, it'd allow some lockdep
annotation code without enabling CONFIG_LOCKDEP actually.  In that
config, size of the struct lock_class_key would be 0.

But it'd cause divide-by-zero in btrfs_set_buffer_lockdep_class() due
to ARRAY_SIZE macro.  Let's change it to use ks->names[] instead.  It
should have the same size as with ks->keys[].

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Acked-by: David Sterba <dsterba@suse.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 87a5addbedf6..be41e35bee92 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -190,7 +190,7 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
 {
 	struct btrfs_lockdep_keyset *ks;
 
-	BUG_ON(level >= ARRAY_SIZE(ks->keys));
+	BUG_ON(level >= ARRAY_SIZE(ks->names));
 
 	/* find the matching keyset, id 0 is the default entry */
 	for (ks = btrfs_lockdep_keysets; ks->id; ks++)
-- 
2.35.0.263.gb82422642f-goog

