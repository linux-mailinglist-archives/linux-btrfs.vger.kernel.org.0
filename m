Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3076EA1F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 04:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjDUCvz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Apr 2023 22:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjDUCvW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:22 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CAD3ABC;
        Thu, 20 Apr 2023 19:51:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63d4595d60fso11556768b3a.0;
        Thu, 20 Apr 2023 19:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045480; x=1684637480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ7Cn95EWZ5JETSsGI/LC39uqQkeGr0Ng7A7gd766EA=;
        b=CFt5GCPcXiSYIqNG/mYRk8ghpeyEkcNq4qwBUDPRaEev1fEYOmm7mjIY9zy86NaTe7
         nalXKDKQ7iFVeuyyWtCByf1EZSR1+vl9feDKy3HKhBve7m38ctf3Yq0GU5GnLY7HZUqK
         falqItKIfqZQl4XGg01+vfIx2rS5cLzS1FsU5nWY9mUomVBErSS7TvYIix0qczmQxegi
         sW3l5bEHmOJkEsywt0ZDgn2navgiwLgYpaHRea1OAZbuKVDsCHNZaD5FJAo7V746ARoH
         SJuBclkFJ1SKVXtZZMIZ73j2KPhC4P8iZYttA+XsYJ85BbO6wxy+1lWaTjvQeSTp6eez
         K5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045480; x=1684637480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TJ7Cn95EWZ5JETSsGI/LC39uqQkeGr0Ng7A7gd766EA=;
        b=O0Neetxt5xGTTuTJWc2w7amfvhAF5lMJIECQuo7mAAAFdMdVCQ4SlvhmNceMlxmb7c
         N7CSYumKVYmb7RQGFMOLKHYr5WelhIitaCEeh2ClGOLkwjeLdEcZvSnBpVKnIy1SEpsA
         E9dltHp+fctaxg7NgPE49Mqr8+f88K4pUhiA9eY0VQpp/fXhfyJpWU6XuTl2Sz8yJGRH
         kNs861/HtPIV6EcfEesm+USh6J13dvnU3BXYD2gZMpvFmjmfWMr4GcQLx+OmaitOQU1Y
         GLqR+LVrEcRgHlnxFEMiOKJqKxmuOJch1KQfdkWoAMfNkLNO6Ww0fNiOUheG/XzswkZY
         P2Pg==
X-Gm-Message-State: AAQBX9ecDE9/O+TX71yg08TTvGjAarnRreKD/eqTNRTj1EaPC6N40uo4
        EeXtRKXQsZvMiF9VLLgK/PU=
X-Google-Smtp-Source: AKy350baSiCst6dCvRKF/+TZ4yzGbYkZbLlcaPduhbROqJlnfjSZgMY/gKn9hDq3YGyDVgfzPoSCaQ==
X-Received: by 2002:a17:903:22c7:b0:1a6:3737:750c with SMTP id y7-20020a17090322c700b001a63737750cmr9367527plg.21.1682045480309;
        Thu, 20 Apr 2023 19:51:20 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709029a4900b001a6388ce38bsm1724224plv.240.2023.04.20.19.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:51:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 16/22] btrfs: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:40 -1000
Message-Id: <20230421025046.4008499-17-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421025046.4008499-1-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
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

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
---
 fs/btrfs/disk-io.c | 2 +-
 fs/btrfs/scrub.c   | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9e1596bb208d..b1f6ff69dbe1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2218,7 +2218,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->qgroup_rescan_workers =
 		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
 	fs_info->discard_ctl.discard_workers =
-		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
+		alloc_ordered_workqueue("btrfs_discard", WQ_FREEZABLE);
 
 	if (!(fs_info->workers && fs_info->hipri_workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 69c93ae333f6..70882358bdb0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4245,8 +4245,10 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
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
2.40.0

