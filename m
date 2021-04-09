Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD74A3591E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 04:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhDICOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 22:14:36 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:38677 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhDICOf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 22:14:35 -0400
Received: by mail-io1-f41.google.com with SMTP id e8so4349237iok.5
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Apr 2021 19:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q9i3utj55rMfcASKIs0hHytGCyCVB4AFFBo8GdIry9M=;
        b=g0aRhNrWsn+th6cCn4Dkh8GV9n8SJXsO9z3Y+nJJg9jU+8Dscecu6KCnJqHIuI+gXl
         OhsaADEmY+jFuIOlkkdC80452yo5JfJA8oR2R4PPFqqrnb1LoSS9Z1Hdqg93F+tahhgv
         2q8lBvodWB35sYOZxlgbcUs0WYyyuLxGgS2sweEXEY6Bxedt7zJjfv6l2jGn2uQx00gC
         8AnTR+0mvdYWRSDpVTLtDyI7IlPT5/CkTLdioWyxo7PbigYQnzu039flok/5edu2xWHU
         chTaIEypq2IMwFeEc7ofSFpAwGKNLY/zJr00QymY8peky0zY5bmbunuWD2mokhdq9Q4C
         bYLQ==
X-Gm-Message-State: AOAM531g8HiaP0w1VT5eFDOJZp47gguekDnKsFGzsWgQfcdYKgG2l+am
        Q1ljZQB9PUwike5R3JNmlNr16RxI4+E=
X-Google-Smtp-Source: ABdhPJytOhL7B0XkwJk21PpgR0PMMZsQzUNTrZzOwPkgi09y+WjF9q4bH2WKu6J3F83V6zxNgo9dGA==
X-Received: by 2002:a5e:d907:: with SMTP id n7mr9794770iop.177.1617934463152;
        Thu, 08 Apr 2021 19:14:23 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id s7sm523760ioj.16.2021.04.08.19.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 19:14:22 -0700 (PDT)
Date:   Fri, 9 Apr 2021 02:14:21 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Message-ID: <YG+4fS7W+Ii4IxO6@google.com>
References: <20210408171959.2D72.409509F4@e16-tech.com>
 <YG8JsdAebEPqOhr/@google.com>
 <20210409080759.4B68.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210409080759.4B68.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 09, 2021 at 08:08:00AM +0800, Wang Yugui wrote:
> Hi,
> 
> > > kernel: at least 5.10.26/5.10.27/5.10.28
> > > 
> > > This problem is triggered by our application, NOT xfstests.
> > > But our applicaiton have some heavy write load just like xfstest/generic/476.
> > > Our application use at most 75% of memory, if still not enough, 
> > > it will write out all buffer info to filesystem.
> > 
> > Do you use cgroups at all? If yes can you describe the workload pattern
> > a bit.
> 
> cgroups is enabled defaultly, so cgroups is used.
> 
> This is the output of systemd-cgls, ''samtools.nipt sort -m 60G" is one
> of our application.  but our application is NOT cgroups-aware, and it NOT
> call any cgroup interface directly.
> 
> Control group /:
> -.slice
> ├─user.slice
> │ └─user-0.slice
> │   ├─session-55.scope
> │   │ ├─48747 sshd: root [priv]
> │   │ ├─48788 sshd: root@notty
> │   │ ├─48795 perl -e @GNU_Parallel=split/_/,"use_IPC::Open3;_use_MIME::Base6...
> │   │ ├─48943 samtools.nipt sort -m 60G -T /nodetmp//nfs/biowrk/baseline.wgs2...
> │   │ ├─....
> │   └─user@0.service
> │     └─init.scope
> │       ├─48775 /usr/lib/systemd/systemd --user
> │       └─48781 (sd-pam)
> ├─init.scope
> │ └─1 /usr/lib/systemd/systemd --switched-root --system --deserialize 18
> └─system.slice
>   ├─rngd.service
>   │ └─1577 /sbin/rngd -f --fill-watermark=0
>   ├─irqbalance.service
>   │ └─1543 /usr/sbin/irqbalance --foreground
> ....
> 
> 
> > > This problem is happen in linux kernel 5.10.x, but not happen in linux
> > > kernel 5.4.x. It have high frequency to repduce too.
> > 
> > Ah. Can you try the following patch?
> > https://lore.kernel.org/lkml/20210408035736.883861-4-guro@fb.com/
> > 
> > Thanks,
> > Dennis
> 
> kernel: kernel 5.10.28+this patch
> result: yet not happen after 4 times test.
>           without this path, the reproduce frequency is >50%
> 
> And a question about this,
> > > > > upper caller:
> > > > >     nofs_flag = memalloc_nofs_save();
> > > > >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> > > > >     memalloc_nofs_restore(nofs_flag);
> > 
> > The issue is here. nofs is set which means percpu attempts an atomic
> > allocation. If it cannot find anything already allocated it isn't happy.
> > This was done before memalloc_nofs_{save/restore}() were pervasive.
> > 
> > Percpu should probably try to allocate some pages if possible even if
> > nofs is set.
> 
> Should we check and pre-alloc memory inside memalloc_nofs_restore()?
> another memalloc_nofs_save() may come soon.
> 
> something like this in memalloc_nofs_save()?
> 	if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_LOW)
>  		pcpu_schedule_balance_work();
> 

Percpu does do this via a workqueue item. The issue is in v5.9 we
introduced 2 types of chunks. However, the free float page number was
for the total. So even if 1 chunk type dropped below, the other chunk
type might have enough pages. I'm queuing this for 5.12 and will send it
out assuming it does fix your problem.

> 
> by the way, this problem still happen in kernel 5.10.28+this patch.
> Is this is a PANIC without OOPS?  any guide for troubleshooting please.

Sorry I don't follow. Above you said the problem hasn't reproed. But now
you're saying it does? Does your issue still reproduce with the patch
above?

> > problem:
> > OS/VGA console is freezed , and no call trace is outputed.
> > Just some info is outputed to IPMI/dell iDRAC
> >    2 | 04/03/2021 | 11:35:01 | OS Critical Stop #0x46 | Run-time critical stop () | Asserted
> >    3 | Linux kernel panic: Fatal excep
> >    4 | Linux kernel panic: tion
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/08
> 

Thanks,
Dennis
