Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C575C6FCA97
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjEIP5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 11:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbjEIP5T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 11:57:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE20230DF;
        Tue,  9 May 2023 08:57:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6439f186366so3469566b3a.2;
        Tue, 09 May 2023 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683647838; x=1686239838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbVH4vqkeFwPRNjfxUo33/C88de6z8TiEMMkxHNwSTk=;
        b=XzmgQY1ax4Ijq6szx6EFvcc2YO+Q9SE+K02EQW+RhKzGl9zyTFm+PtjW4l0imfvHHy
         zbagoAZXHdco7WAPssK6/AGqfqhyEAlVWmUFmekjlbQUIZixsBI5Q/tqOzBUCE0AagR6
         ssHcfNv4chwvAGLpAgEN+XkAYz/v+kFUHAniUzo7OWwJjxZicTOq1VchUiX89awbNIhU
         r5Cf+rWWL0sLJGzb9faSBDe2rTMbHWdl62sNQUEw8o82AxfCpXy4PJig1hpcXhSoexdL
         TFNzLsa0gO8UH6trDBJgmnfsGWheywPkHXwI7dmbQdqe316eEHtykdfvfULCZnRpZ2OK
         Rmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683647838; x=1686239838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbVH4vqkeFwPRNjfxUo33/C88de6z8TiEMMkxHNwSTk=;
        b=Bt4MriYsDbWBrZfNtsNn0B1OpCuMiTa38i8BsXDqtvMPqmsM3xiWapCXlBpj19LK8U
         oEPnEYnoakhuPX/iHHPJ2sgDJpvJSmrNteroxq31yCtz0ZwOhBOCISEs4Azdkoi5lPKZ
         31qeAL9cN726hcAikDs+CR5sMdc16DhWPphWysN8WY/7FKQlkeEwzf2+C3rE6R1Ssv6x
         urH5WqRlWsEnwXzbod2munBfgEQaLmIQ8hrnoBd1KJWXRZZl26riBiZ8eaCBfzW4tRWA
         9LM9ZowwuRXKyCoIeTmpjJspARQjZInVp+D4/UrvqdYOpmog78gI3WuJnYpGFyaegdG8
         24Iw==
X-Gm-Message-State: AC+VfDyHuFEQGI6HshC/Lw2sgYLXU0N4aOFdeJqVyqrECn5NZ1A0uge8
        fuHnIg5CYJ0ip9muawOEJQo=
X-Google-Smtp-Source: ACHHUZ6RecSEW9U5L+EeUoIeI0y9R14pXguMOGOkmg+a6MOa9MYIjdIka06kPIuXfjzUKSvWBEYjjg==
X-Received: by 2002:a05:6a00:240a:b0:63d:3a18:4a08 with SMTP id z10-20020a056a00240a00b0063d3a184a08mr17455102pfh.24.1683647837866;
        Tue, 09 May 2023 08:57:17 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y20-20020a62b514000000b0062e12f945adsm1910114pfe.135.2023.05.09.08.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:57:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 May 2023 05:57:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Wang Yugui <wangyugui@e16-tech.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/13] btrfs: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZFptXG44WVoWE0s4@slm.duckdns.org>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-9-tj@kernel.org>
 <20230509145332.GA32559@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509145332.GA32559@twin.jikos.cz>
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

Thanks for taking a look.

On Tue, May 09, 2023 at 04:53:32PM +0200, David Sterba wrote:
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 59ea049fe7ee..32d08aed88b6 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2217,7 +2217,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
> >  	fs_info->qgroup_rescan_workers =
> >  		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
> >  	fs_info->discard_ctl.discard_workers =
> > -		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
> > +		alloc_ordered_workqueue("btrfs_discard", WQ_FREEZABLE);
> >  
> >  	if (!(fs_info->workers && fs_info->hipri_workers &&
> >  	      fs_info->delalloc_workers && fs_info->flush_workers &&
> 
> I think there are a few more conversions missing. There's a local flags
> variable in btrfs_init_workqueues
> 
> 2175 static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
> 2176 {
> 2177         u32 max_active = fs_info->thread_pool_size;
> 2178         unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;
> 
> And used like
> 
> 2194         fs_info->fixup_workers =
> 2195                 btrfs_alloc_workqueue(fs_info, "fixup", flags, 1, 0);
> 
> 2213         fs_info->qgroup_rescan_workers =
> 2214                 btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);

Right you are.

> WQ_UNBOUND is not mentioned explicitliy like for the "btrfs_discard"
> workqueue.  Patch v2 did the switch in btrfs_alloc_workqueue according
> to the max_active/limit_active parameter but this would affect all
> queues and not all of them require to be ordered.

The thresh mechanism which auto adjusts max active means that the workqueues
allocated btrfs_alloc_workqueue() can't be ordered, right? When thresh is
smaller than DFT_THRESHOLD, the mechanism is disabled but that looks like an
optimization.

> In btrfs_resize_thread_pool the workqueue_set_max_active is called
> directly or indirectly so this can set the max_active to a user-defined
> mount option. Could this be a problem or trigger a warning? This would
> lead to max_active==1 + WQ_UNBOUND.

That's not a problem. The only thing we need to make sure is that the
workqueues which actually *must* be ordered use alloc_ordered_workqueue() as
they won't be implicitly treated as ordered in the future.

* The current patch converts two - fs_info->discard_ctl.discard_workers and
  scrub_workers when @is_dev_replace is set. Do they actually need to be
  ordered?

* As you pointed out, fs_info->fixup_workers and
  fs_info->qgroup_rescan_workers are also currently implicitly ordered. Do
  they actually need to be ordered?

Thanks.

-- 
tejun
