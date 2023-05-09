Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55C06FD31E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 01:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjEIXrZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 19:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEIXrY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 19:47:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225184EE8;
        Tue,  9 May 2023 16:47:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24e4f674356so5985186a91.3;
        Tue, 09 May 2023 16:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683676042; x=1686268042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhUCLQ7ZrV4DdwmSYqQPD67Er0hUj9pRQQE02cLTraE=;
        b=HYlSoj8lwXn3BKBpO43qLwd3E57tBWEEWoH3hpWLiodFlmVTEMmMK6MFJQzhqrBMpb
         r+8nDbjpBW+lcdbBcDbskrzit9BDCx73TQihePoy8Y0CMeuypXEyk//OwrfHPBlZS4E0
         KgYUf+32y88Dg6gSFzQSvlaPwv3rxhpjSKI7ayRt6cDWe+1YCbiqWYW+2NHolgOBDHfl
         ilAEj4rwYiGpoe7FmOunUmDORouIjhQUGDH4hyB2q9qqVMB7m9awV3ucNfVbJOYl8FKj
         oQ30szT7yNmp0cdkv50oX5QMp2jIuJAimplVz7H6QkusaWUsEqq/eJxp00/uKXU3E4jV
         Kx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683676042; x=1686268042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhUCLQ7ZrV4DdwmSYqQPD67Er0hUj9pRQQE02cLTraE=;
        b=XaEYFGCcMRp385P1/8z7b8KWpNjlUZNG2uDqsFYOttwqvFPo5SVG4/y88LmhM58qte
         MHROzHXeJWbNJyQsa97YDLxFWZFhjSiFvoXu5o/PUgVgeGMAHZrVhtGEcjn9r5LB78p0
         7vYX2C0acLEasChIKCR7DMGxUsy/MdmiuThRU4eNHtu8qKC4GIIWF2RIV3B8i7Zk2e5w
         0KMrk1P+A7LVwDzm3OzR2n6O3R0IAMrEUbsmxsgfn3ArTxrmmqo/PBfe68uWzV8pFmk2
         /75oxh1I9EYEpUrDbmQwi7H5kT9DimCJJ6NnK9yHaBq5Hwu77yuZGsilAtEfPd5pGbzl
         uHCw==
X-Gm-Message-State: AC+VfDz/RVtaTIofZrdFEjD3krbKoiOg7BT6YEejxIuh8fFNCzYMiq/0
        +KgJMkU2svZ6fkpfacfT/os=
X-Google-Smtp-Source: ACHHUZ7azMw2HdFtvpjDKJr0+Y8feIYmzMFLn06xZDIopOW+RUWqdmORhFFGKmsmnwIwS9M6R8N/qA==
X-Received: by 2002:a17:90a:9c07:b0:250:1961:f6b0 with SMTP id h7-20020a17090a9c0700b002501961f6b0mr15837259pjp.32.1683676042217;
        Tue, 09 May 2023 16:47:22 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090a474a00b0025063e893c9sm5469929pjg.55.2023.05.09.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 16:47:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 May 2023 13:47:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Wang Yugui <wangyugui@e16-tech.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/13] btrfs: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZFrbiAyCiZ2aIZ4_@slm.duckdns.org>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-9-tj@kernel.org>
 <20230509145332.GA32559@twin.jikos.cz>
 <ZFptXG44WVoWE0s4@slm.duckdns.org>
 <20230509233620.GN32559@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509233620.GN32559@twin.jikos.cz>
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

Hello, David.

On Wed, May 10, 2023 at 01:36:20AM +0200, David Sterba wrote:
...
> Yeah I think so but I'm not entierly sure. The ordering for all queues
> that don't start with max_active > 1 should not be required, here the
> parallelization and out of order processing is expected and serialized
> or decided once the work is done.
> 
> > > In btrfs_resize_thread_pool the workqueue_set_max_active is called
> > > directly or indirectly so this can set the max_active to a user-defined
> > > mount option. Could this be a problem or trigger a warning? This would
> > > lead to max_active==1 + WQ_UNBOUND.
> > 
> > That's not a problem. The only thing we need to make sure is that the
> > workqueues which actually *must* be ordered use alloc_ordered_workqueue() as
> > they won't be implicitly treated as ordered in the future.
> > 
> > * The current patch converts two - fs_info->discard_ctl.discard_workers and
> >   scrub_workers when @is_dev_replace is set. Do they actually need to be
> >   ordered?
> > 
> > * As you pointed out, fs_info->fixup_workers and
> >   fs_info->qgroup_rescan_workers are also currently implicitly ordered. Do
> >   they actually need to be ordered?
> 
> I think all of them somehow implictly depend on the ordering. The
> replace process sequentially goes over a block group and copies blocks.
> 
> The fixup process is quite obscure and we should preserve the semantics
> as much as possible. It has something to do with pages that get out of
> sync with extent state without btrfs knowing and that there are more such
> requests hapenning at the same time is low but once it happens it can
> lead to corruptions.
> 
> Quota rescan is in its nature also a sequential process but I think it
> does not need to be ordered, it's started from higher level context like
> enabling quotas or rescan but there are also calls at remount time so
> this makes it less clear.
> 
> In summary, if the ordered queue could be used then I'd recommend to do
> it as the safe option.

I see. It seems rather error-prone to make workqueues implicitly ordered
from btrfs_alloc_workqueue(). I'll see if I can make it explicit and keep
all workqueues which are currently guaranteed to be ordered ordered.

Thanks.

-- 
tejun
