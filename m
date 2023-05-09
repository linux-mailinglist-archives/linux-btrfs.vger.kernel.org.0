Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C836FBCB8
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 03:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjEIBvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 21:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjEIBvN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 21:51:13 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5597293FB;
        Mon,  8 May 2023 18:50:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ab032d9266so49781765ad.0;
        Mon, 08 May 2023 18:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597051; x=1686189051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1J6Uhx7TdNa04N1msjENwvqnJR9gOFa4BQJITMRpS4=;
        b=gzWF12j+f8UHaykX6yDNVACmPlRUC0e+ltWVDGfncxHVSKQf3wuisdYV7wzrDGAt+p
         AAxNEgDFuPtKZ6xyu1JIbH/T8eeOGBPkUwxP8y9DaE188kc2J9E23SJEi364QtiVKKHB
         GkP6iRWoOS+BX9waw50uSbCgDIaOa9qfvRYtjcb5yBJX1O89QozI+FAKzgGz1QyqZNaZ
         V0lBc4ofgtARKJe8sPuxOQlBYsJfcgubXLYT9csuQA59a/ggbw3ipSYez5FeuqhJwREO
         bO7QG394ITobJfja44AzxtPCw2UiLxvnQtOWsI6CsoUpfX+rEcsJkXk2GsejhX0x2wuA
         Mxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597051; x=1686189051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1J6Uhx7TdNa04N1msjENwvqnJR9gOFa4BQJITMRpS4=;
        b=fWPZNB4R+s5vIUkE4WjCePh0k1f6EvKWhQ+WxH+F/Wc4/rsYf3aI5IG5c+KdZ4G9La
         LDnVDPniWMi7OUZPvvXGE2ZmLh42SUJPdyQIrU95M3gkieGhSLSMyg8xU4EDPlZO/ay7
         6tJGK1mhVXz8eWp4NZxbyAYZlr5GhrzZHopdw8Rfj6STyyuiFPGWkd8OAeUxEcqFjk9J
         rwU+3AJ655sc5knQN3Z3G7g9G/82XYUFYl+nujh1fel7YnTnmYQAKLMqh+UX8aUTGCiG
         vQ51cJXFGozcVsssnzVDiYTHnGKA+6Iczgr92/YO2b4DS+eqtl/PDldTLDc4hosFW4KY
         npCw==
X-Gm-Message-State: AC+VfDwG9UrF33wHWJZ3Rd3m7YkJqV87O9cJNXgSf7c5dt9CCYMEC98W
        DCfwgNWbzYY5jxEurJsaDOA=
X-Google-Smtp-Source: ACHHUZ5tlOomablQCfBOV3M3RYiFDxwoUeDISy95o83jiqJZkLxAwQFDiwqwZraoDlTrekIiSTvxmA==
X-Received: by 2002:a17:902:ec8a:b0:1aa:f3c4:7582 with SMTP id x10-20020a170902ec8a00b001aaf3c47582mr16797753plg.31.1683597051056;
        Mon, 08 May 2023 18:50:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b0019a7ef5e9a8sm157241plk.82.2023.05.08.18.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:50:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Wang Yugui <wangyugui@e16-tech.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 08/13] btrfs: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Mon,  8 May 2023 15:50:27 -1000
Message-Id: <20230509015032.3768622-9-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509015032.3768622-1-tj@kernel.org>
References: <20230509015032.3768622-1-tj@kernel.org>
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

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

v3: btrfs_alloc_workqueue() excluded again. The concurrency level of a
    workqueue allocated through btrfs_alloc_workqueue() may be dynamically
    adjusted through thresh_exec_hook(), so they can't be ordered.

v2: btrfs_alloc_workqueue() updated too as suggested by Wang.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Wang Yugui <wangyugui@e16-tech.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
---
 fs/btrfs/disk-io.c | 2 +-
 fs/btrfs/scrub.c   | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59ea049fe7ee..32d08aed88b6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2217,7 +2217,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->qgroup_rescan_workers =
 		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
 	fs_info->discard_ctl.discard_workers =
-		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
+		alloc_ordered_workqueue("btrfs_discard", WQ_FREEZABLE);
 
 	if (!(fs_info->workers && fs_info->hipri_workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 836725a19661..d5401d7813a5 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2734,8 +2734,10 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	if (refcount_inc_not_zero(&fs_info->scrub_workers_refcnt))
 		return 0;
 
-	scrub_workers = alloc_workqueue("btrfs-scrub", flags,
-					is_dev_replace ? 1 : max_active);
+	if (is_dev_replace)
+		scrub_workers = alloc_ordered_workqueue("btrfs-scrub", flags);
+	else
+		scrub_workers = alloc_workqueue("btrfs-scrub", flags, max_active);
 	if (!scrub_workers)
 		goto fail_scrub_workers;
 
-- 
2.40.1

