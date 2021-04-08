Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7859235851A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 15:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhDHNsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 09:48:47 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:33495 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhDHNsq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 09:48:46 -0400
Received: by mail-io1-f48.google.com with SMTP id a11so225193ioo.0
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Apr 2021 06:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nqFalTZx6UQqInKtJAP8wv0+0cnlIJ20nn+ReArcFHs=;
        b=sglXeHwCUJApWoUSvxSsPdyGIjyb0GP7QIZB0dERnC/2TPpUpqv2cyNwWZGwqhhQTP
         N9ksHFttIIT9ZpKGZYoGP8WkptZ9h062KDnRzPI+hrYkEKXwjf+CLQgKKIdz5T096zf9
         l5VbjInsqMCw7pJ1iK7MwOGCbemfxP6rx27LwIQbz4OmUZZiVFhHW/v5niYmSgdZSbTY
         sPBjx5IfTjvWjPe5PRKbx/2S5HQrVnMlfEbtzH7L4Tf83qUif6ku7SqPklBPB+oU5kFI
         dTb/imv/IUv8iZ18UCA4GD3S+FIHKLBLfEyopKBXzISDJxlUVGz/zkyfFSja0vlCmUqs
         qaCA==
X-Gm-Message-State: AOAM532ALr2uruzw8TSP4Lj5kLltwZagmuydYswNEpXc0MgqGTXCYgXJ
        kmDY6xQQp3rKko6rghgZlv0=
X-Google-Smtp-Source: ABdhPJygRcVlCnE+EG8SpExFB05sFGPSVqhgRy/0SX5+I++8/iCrseCHhbgCih2I1eMxXepRwHGPkA==
X-Received: by 2002:a5e:8d05:: with SMTP id m5mr6857617ioj.114.1617889715170;
        Thu, 08 Apr 2021 06:48:35 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id j8sm3381602ilk.33.2021.04.08.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:48:34 -0700 (PDT)
Date:   Thu, 8 Apr 2021 13:48:33 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Message-ID: <YG8JsdAebEPqOhr/@google.com>
References: <20210408072800.6C1F.409509F4@e16-tech.com>
 <YG5uFrWpwDHMhdR1@google.com>
 <20210408171959.2D72.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408171959.2D72.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 08, 2021 at 05:20:00PM +0800, Wang Yugui wrote:
> Hi,
> 
> > On Thu, Apr 08, 2021 at 07:28:01AM +0800, Wang Yugui wrote:
> > > Hi,
> > > 
> > > > > > > upper caller:
> > > > > > >     nofs_flag = memalloc_nofs_save();
> > > > > > >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> > > > > > >     memalloc_nofs_restore(nofs_flag);
> > > > 
> > > > The issue is here. nofs is set which means percpu attempts an atomic
> > > > allocation. If it cannot find anything already allocated it isn't happy.
> > > > This was done before memalloc_nofs_{save/restore}() were pervasive.
> > > > 
> > > > Percpu should probably try to allocate some pages if possible even if
> > > > nofs is set.
> > > 
> > > Thanks.
> > > 
> > > I will wait for the patch, and then test it.
> > > 
> > 
> > I'm currently a bit busy with some other things. Adding support I don't
> > think will be much work, just a little bit tricky.
> > 
> > I recommend carrying what you have minus the change to reserved percpu
> > memory for now. If I'm the one to write it, I'll cc you.
> > 
> > Thanks,
> > Dennis
> 
> 
> In the recent test, another problem is triggered too with my extended
> percpu buffer size patch. maybe this info is helpful.
> 
> problem:
> OS/VGA console is freezed , and no call stace is outputed.
> Just some info is outputed to IPMI/dell iDRAC
>    2 | 04/03/2021 | 11:35:01 | OS Critical Stop #0x46 | Run-time critical stop () | Asserted
>    3 | Linux kernel panic: Fatal excep
>    4 | Linux kernel panic: tion
>    5 | 04/05/2021 | 19:09:14 | OS Critical Stop #0x46 | Run-time critical stop () | Asserted
>    6 | Linux kernel panic: Fatal excep
>    7 | Linux kernel panic: tion
>    8 | 04/06/2021 | 13:08:42 | OS Critical Stop #0x46 | Run-time critical stop () | Asserted
>    9 | Linux kernel panic: Fatal excep
>    a | Linux kernel panic: tion
>    b | 04/08/2021 | 02:12:46 | OS Critical Stop #0x46 | Run-time critical stop () | Asserted
>    c | Linux kernel panic: Fatal excep
>    d | Linux kernel panic: tion

Unfortunately non of the above to me is useful.

> kernel: at least 5.10.26/5.10.27/5.10.28
> 
> This problem is triggered by our application, NOT xfstests.
> But our applicaiton have some heavy write load just like xfstest/generic/476.
> Our application use at most 75% of memory, if still not enough, 
> it will write out all buffer info to filesystem.

Do you use cgroups at all? If yes can you describe the workload pattern
a bit.

> This problem is happen in linux kernel 5.10.x, but not happen in linux
> kernel 5.4.x. It have high frequency to repduce too.

Ah. Can you try the following patch?
https://lore.kernel.org/lkml/20210408035736.883861-4-guro@fb.com/

Thanks,
Dennis
