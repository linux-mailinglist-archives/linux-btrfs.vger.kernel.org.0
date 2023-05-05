Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB96F8C93
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 May 2023 00:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjEEW6m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 18:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEEW6m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 18:58:42 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C998F5B80;
        Fri,  5 May 2023 15:58:40 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-18ef8aa1576so1994517fac.0;
        Fri, 05 May 2023 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683327520; x=1685919520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sconPnHuLiRb7mO93auUZPY2wLtFsZtIgoJ9KhhDVE=;
        b=dbTiZPGg3LT4PKOruSy7edjsU1L/yLpPXQQ5ZwYcgN2mL9unKkwhk14RuHDGuQFoPH
         ZonY4L/DLMtyqnFUsM/5i4Mjf2t0DyNPK4panROCLfIiTEttXZlLRDUdfkitmPLlJNJv
         rGhZtTPtWf34oZcWK8WHPMcTSyMS9HnABZRWfxAv1XBvMyuwlk30ijG3kVRuGDKsqGBJ
         oIVRpsKGemd8zTrbS3t9Nd1HHfYTfzwHj0iJoQc3DAkDOuoAuWq/2Q3EJDDrolm/HIhe
         x52rvp8q6iZvqw6ob8/C0DZsVo+7UhLkaf8jY6T9HHcQU4KiPWNLwGB/HawFfAkdPKgE
         SE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683327520; x=1685919520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sconPnHuLiRb7mO93auUZPY2wLtFsZtIgoJ9KhhDVE=;
        b=T/xfdCV8wiI/dBBLiTPbzN0CSVqb+gNme4qpcZ7aTTF4OfwrO7jJ5gX+4EjQ9EGOeq
         Yx0CtX1w0lbKuav+C8g8FTx4zoabZncOL5NzcY149w4A0HPHnri5xpg7FvNXqT3BvxjX
         tkyvIUCcB0jw3VpM+ngUhP0BtEOKJUOFr2wTBfDPFBeMQijyM34eA6TKdHlF9qVXChMI
         Q+CTBrSX2CRSEfW1UJmu3E6Bi3QdVwvQQWLddtORgEgOCe1O84nzia4mc6hreGno+4XX
         eQT4mLDEw3zSadzKoYp4UTpfsaXOQZWH8aYUldoj9dB6u5WJBT/tOFyeNvOZOuRp+2PO
         eHwQ==
X-Gm-Message-State: AC+VfDy/yHwoRo1HQ9CHZeZX3tdiuTPHmgEfNkiwfpW4A1q1wQRGD6D7
        QH/tsudWuKGqmfxafec9OoOkSRPgBDk=
X-Google-Smtp-Source: ACHHUZ4h2FAbChuedf3MQXFY1UGQrZr+Qw1Ycdwui8WxtqawY7re1LJpYsaFDWhngMUin214+K/vtg==
X-Received: by 2002:a05:6871:582:b0:17f:ee0f:b03a with SMTP id u2-20020a056871058200b0017fee0fb03amr1680892oan.34.1683327519778;
        Fri, 05 May 2023 15:58:39 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a6-20020a056870618600b0017197629658sm2363638oah.56.2023.05.05.15.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:58:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 12:58:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 16/22] btrfs: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZFWKHRCDsaNDNXIj@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-17-tj@kernel.org>
 <20230430124006.49D2.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430124006.49D2.409509F4@e16-tech.com>
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

v2: btrfs_alloc_workqueue() updated too as suggested by Wang.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Wang Yugui <wangyugui@e16-tech.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
---
Hello,

Wang, yeah, that's a helper that can't tell whether the caller wants an
ordered wq or not, so it needs to be updated too. How does this look?

Thanks.

 fs/btrfs/async-thread.c |    7 +++++--
 fs/btrfs/disk-io.c      |    2 +-
 fs/btrfs/scrub.c        |    6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -99,8 +99,11 @@ struct btrfs_workqueue *btrfs_alloc_work
 		ret->thresh = thresh;
 	}
 
-	ret->normal_wq = alloc_workqueue("btrfs-%s", flags, ret->current_active,
-					 name);
+	if (ret->current_active == 1)
+		ret->normal_wq = alloc_ordered_workqueue("btrfs-%s", flags, name);
+	else
+		ret->normal_wq = alloc_workqueue("btrfs-%s", flags,
+						 ret->current_active, name);
 	if (!ret->normal_wq) {
 		kfree(ret);
 		return NULL;
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2218,7 +2218,7 @@ static int btrfs_init_workqueues(struct
 	fs_info->qgroup_rescan_workers =
 		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
 	fs_info->discard_ctl.discard_workers =
-		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
+		alloc_ordered_workqueue("btrfs_discard", WQ_FREEZABLE);
 
 	if (!(fs_info->workers && fs_info->hipri_workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4245,8 +4245,10 @@ static noinline_for_stack int scrub_work
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
 
