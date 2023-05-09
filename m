Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD4B6FD313
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 01:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjEIXma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 19:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjEIXm3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 19:42:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF1449E6;
        Tue,  9 May 2023 16:42:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1CAF21B53;
        Tue,  9 May 2023 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683675739;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UhXINiTaFgT7BrxS/vPCfG3eLNTGe/+tEY2XQOzoxgo=;
        b=NC9DIW5rQM2KHTh4rY1hLxuY+uQHxljWdI7MhJSdGE3mcprR+/EqT8BNw3RVBTzXXzzuGC
        qtsnDnkbrLRSEaWggUWefU5yIa3RazFH+dD6bMT1jrC7vHOt6mvuESCIZAyQT5rCsB5wRD
        4KncxPqxgvTcy/6P93/FN8Km4ffI7ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683675739;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UhXINiTaFgT7BrxS/vPCfG3eLNTGe/+tEY2XQOzoxgo=;
        b=6SzslbxHTO7Qnu+dwbTVmj4GB+cbtSog5WjEmi/uHTwqG9etK77VNKyXt8CCxiUGrnlWU/
        lBD/iC2o0gZtyQAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B23F7139B3;
        Tue,  9 May 2023 23:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tcSjKlvaWmSGEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 23:42:19 +0000
Date:   Wed, 10 May 2023 01:36:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Wang Yugui <wangyugui@e16-tech.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/13] btrfs: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <20230509233620.GN32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-9-tj@kernel.org>
 <20230509145332.GA32559@twin.jikos.cz>
 <ZFptXG44WVoWE0s4@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFptXG44WVoWE0s4@slm.duckdns.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 09, 2023 at 05:57:16AM -1000, Tejun Heo wrote:
> Hello, David.
> 
> Thanks for taking a look.
> 
> On Tue, May 09, 2023 at 04:53:32PM +0200, David Sterba wrote:
> > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > index 59ea049fe7ee..32d08aed88b6 100644
> > > --- a/fs/btrfs/disk-io.c
> > > +++ b/fs/btrfs/disk-io.c
> > > @@ -2217,7 +2217,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
> > >  	fs_info->qgroup_rescan_workers =
> > >  		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
> > >  	fs_info->discard_ctl.discard_workers =
> > > -		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
> > > +		alloc_ordered_workqueue("btrfs_discard", WQ_FREEZABLE);
> > >  
> > >  	if (!(fs_info->workers && fs_info->hipri_workers &&
> > >  	      fs_info->delalloc_workers && fs_info->flush_workers &&
> > 
> > I think there are a few more conversions missing. There's a local flags
> > variable in btrfs_init_workqueues
> > 
> > 2175 static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
> > 2176 {
> > 2177         u32 max_active = fs_info->thread_pool_size;
> > 2178         unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;
> > 
> > And used like
> > 
> > 2194         fs_info->fixup_workers =
> > 2195                 btrfs_alloc_workqueue(fs_info, "fixup", flags, 1, 0);
> > 
> > 2213         fs_info->qgroup_rescan_workers =
> > 2214                 btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
> 
> Right you are.
> 
> > WQ_UNBOUND is not mentioned explicitliy like for the "btrfs_discard"
> > workqueue.  Patch v2 did the switch in btrfs_alloc_workqueue according
> > to the max_active/limit_active parameter but this would affect all
> > queues and not all of them require to be ordered.
> 
> The thresh mechanism which auto adjusts max active means that the workqueues
> allocated btrfs_alloc_workqueue() can't be ordered, right? When thresh is
> smaller than DFT_THRESHOLD, the mechanism is disabled but that looks like an
> optimization.

Yeah I think so but I'm not entierly sure. The ordering for all queues
that don't start with max_active > 1 should not be required, here the
parallelization and out of order processing is expected and serialized
or decided once the work is done.

> > In btrfs_resize_thread_pool the workqueue_set_max_active is called
> > directly or indirectly so this can set the max_active to a user-defined
> > mount option. Could this be a problem or trigger a warning? This would
> > lead to max_active==1 + WQ_UNBOUND.
> 
> That's not a problem. The only thing we need to make sure is that the
> workqueues which actually *must* be ordered use alloc_ordered_workqueue() as
> they won't be implicitly treated as ordered in the future.
> 
> * The current patch converts two - fs_info->discard_ctl.discard_workers and
>   scrub_workers when @is_dev_replace is set. Do they actually need to be
>   ordered?
> 
> * As you pointed out, fs_info->fixup_workers and
>   fs_info->qgroup_rescan_workers are also currently implicitly ordered. Do
>   they actually need to be ordered?

I think all of them somehow implictly depend on the ordering. The
replace process sequentially goes over a block group and copies blocks.

The fixup process is quite obscure and we should preserve the semantics
as much as possible. It has something to do with pages that get out of
sync with extent state without btrfs knowing and that there are more such
requests hapenning at the same time is low but once it happens it can
lead to corruptions.

Quota rescan is in its nature also a sequential process but I think it
does not need to be ordered, it's started from higher level context like
enabling quotas or rescan but there are also calls at remount time so
this makes it less clear.

In summary, if the ordered queue could be used then I'd recommend to do
it as the safe option.
