Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D898F477FD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 23:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhLPWHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 17:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhLPWHz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 17:07:55 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FA1C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 14:07:54 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id kk22so689349qvb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 14:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y0m134dylOg9hfNMQUsf/n2B7KHI2De8sN1JFBRjWxM=;
        b=VEzU+weGmGo86/rQnM+7QUyB8dHC8KrI/4Ge/nlgUH/5YMMbT552MHFnDcXoD45lt0
         NRMY0j+WTxfrlYhGAvy0W4sTquzN0MTroKIMg4NtWAxMr/aBHIgfsbDokEf63WvPz7S7
         gd87MEHTg6guUBu63JZUR+TrVOH4k3m6SA5AX36mpQJOmXJqLRJ2dZTZaRaTHKiqSM7X
         Cm6ijqPROzwkGWnWbx1TiGMFlwgtzwxCz25vFIpxTtqSTW/a3Um2lHRJU4XePWdSY9Uv
         CwwPMWlnph9RCM/AHZVx9rgnhGYF4yBTtdnNupx+Xz8hFKnypA+MW7LKB/XdCtVtN+Br
         sDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y0m134dylOg9hfNMQUsf/n2B7KHI2De8sN1JFBRjWxM=;
        b=C/52dAaq2emx+oGB4y/9Ya4UqZXT73/aINLYX9PhzGUQWw1/J53FoEWUjyN+5AmFOv
         /nTZgPMUwIdQ48xpHw8fW4O/crQ4/ece8ZQUNs8BhHo2PgTc93uxzvvkaL0sGZKhpugi
         JkR+LmEnjEq/goCLxagM1TfrggwtCBsK1TyG2pFUMdMGbT+rKLQH78ans/783jbJOYTw
         QXPMOcleHylqCByMjPtjxtksJIIpWk40HeK0WunT3IT8ZvuzgQZ+8DUw4Es6ckxyBIvV
         TnoUzLTHLe+vY75pHuNB0uqC5zhoEdfjYy6ti/my1j9NEBWoursqvVPMX+mpZhlSu0aI
         VSgg==
X-Gm-Message-State: AOAM53383Oo2heZMNtV5N/zdPvEU+Jw5luI54KUp0LuzwS3WyX38f9+R
        RZqGV+ARgHCUkd82vc/ZR/gGsg==
X-Google-Smtp-Source: ABdhPJxKV2cKqhyPNZcGgOfTBxsxIQh0KBOsbxCJAFvwxadxzBQOaCbAvCJw24W1lXoFQV0nsb/lEg==
X-Received: by 2002:a0c:f205:: with SMTP id h5mr212498qvk.128.1639692473489;
        Thu, 16 Dec 2021 14:07:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b5sm3444162qka.51.2021.12.16.14.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 14:07:51 -0800 (PST)
Date:   Thu, 16 Dec 2021 17:07:50 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: bisected: btrfs dedupe regression in v5.11-rc1: 3078d85c9a10
 vfs: verify source area in vfs_dedupe_file_range_one()
Message-ID: <Ybu4tuzqpaiast5H@localhost.localdomain>
References: <20211210183456.GP17148@hungrycats.org>
 <25f4d4fd-1727-1c9f-118a-150d9c263c93@suse.com>
 <YbfTYFQVGCU0Whce@hungrycats.org>
 <fc395aed-2cbd-f6e5-d167-632c14a07188@suse.com>
 <Ybj1jVYu3MrUzVTD@hungrycats.org>
 <c6125582-a1dc-1114-8211-48437dbf4976@suse.com>
 <YbrPkZVC/MazdQdc@hungrycats.org>
 <ab295d78-d250-fe8f-33a5-09cc90d5e406@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab295d78-d250-fe8f-33a5-09cc90d5e406@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 16, 2021 at 11:29:06PM +0200, Nikolay Borisov wrote:
> 
> 
> On 16.12.21 г. 7:33, Zygo Blaxell wrote:
> > On Wed, Dec 15, 2021 at 12:25:04AM +0200, Nikolay Borisov wrote:
> >> Huhz, this means there is an open transaction handle somewhere o_O. I
> >> checked back the stacktraces in your original email but couldn't see
> >> where that might be coming from. I.e all processes are waiting on
> >> wait_current_trans and this happens _before_ the transaction handle is
> >> opened, hence num_extwriters can't have been incremented by them.
> >>
> >> When an fs wedges, and you get again num_extwriters can you provde the
> >> output of "echo w > /proc/sysrq-trigger"
> > 
> > Here you go...
> 
> <snip>
> 
> > 
> > Again we have "3 locks held" but no list of locks.  WTF is 10883 doing?
> > Well, first of all it's using 100% CPU in the kernel.  Some samples of
> > kernel stacks:
> > 
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] down_read_nested+0x32/0x140
> > 	[<0>] __btrfs_tree_read_lock+0x2d/0x110
> > 	[<0>] btrfs_tree_read_lock+0x10/0x20
> > 	[<0>] btrfs_search_old_slot+0x627/0x8a0
> > 	[<0>] btrfs_next_old_leaf+0xcb/0x340
> > 	[<0>] find_parent_nodes+0xcd7/0x1c40
> > 	[<0>] btrfs_find_all_leafs+0x63/0xb0
> > 	[<0>] iterate_extent_inodes+0xc8/0x270
> > 	[<0>] iterate_inodes_from_logical+0x9f/0xe0
> 
> That's the real culprit, in this case we are not searching the commit
> root hence we've attached to the transaction. So we are doing backref
> resolution which either:
> 
> a) Hits some pathological case and loops for very long time, backref
> resolution is known to take a lot of time.
> 
> b) We hit a bug in backref resolution and loop forever which again
> results in the transaction being kept open.
> 
> Now I wonder why you were able to bisect this to the seemingly unrelated
> commit in the vfs code.
> 
> Josef any ideas how to proceed further to debug why backref resolution
> takes a long time and if it's just an infinite loop?
> 

It's probably an infinite loop, I'd just start with something like this

bpftrace -e 'tracepoint:btrfs:btrfs_prelim_ref_insert { printf("bytenr is %llu", args->bytenr); }'

and see if it's spitting out the same shit over and over again.  If it is can I
get a btrfs inspect-internal dump-tree -e on the device along with the bytenr
it's hung up on so I can figure out wtf it's tripping over?

If it's not looping there, it may be looping higher up, but I don't see where it
would be doing that.  Lets start here and work our way up if we need to.
Thanks,

Josef
