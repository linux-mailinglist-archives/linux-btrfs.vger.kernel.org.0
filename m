Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BA935A067
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhDIN40 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 09:56:26 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:38499 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIN4Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 09:56:25 -0400
Received: by mail-il1-f172.google.com with SMTP id x3so4166543ilg.5
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Apr 2021 06:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hnToDMIf1Fki+bNzsYO2DOzEZd4Lcc1Sjb6xiW6usec=;
        b=PDFvN+KpPvGURgiCr31gy1RrNpeDaOCs2ixY6/heouK7UM8S5Ia2Mm3YKJktfIadfo
         21P4LumcyXpPmJ8SHjZJ1T01GB6wQZ5NrVF0UFjVFG60x/EnoNlqQXKbQIyiVkEncgVq
         kO8O6M4e0LEKhJy6RsBwCyuyMRHKfw3E6DwRqUSKUeQXQUOzMvy/gw0p+dSRIJ8rDSEs
         g10N38l4tSs4I0M5UanvnncWpPtCCAYOEZsXOeBU6YN7e87Fr9DNpnUYZA4u+Gw5G1k2
         RXND16rXCWCxpMuGIGPnmqgoxmNhYNg35Vkb/Iwirs9lj/z/XT3ecYDcYrpbW6kIUw/4
         Gamw==
X-Gm-Message-State: AOAM5327bmX6S1vU3Oggmx6OFDKNfgE7vqqea/r5YJ3XziSZ1pBmhRD9
        eR4lpVy7ZoDYJhkKBuC+vfc7aV8dZlg=
X-Google-Smtp-Source: ABdhPJxqD/ZI2sj1OfCydZKz1cQE3cW8PEZ+wdDwxF6NofDP8cTI3CNpmFsp4FXMm3pS0U3G9c54Ig==
X-Received: by 2002:a05:6e02:1a24:: with SMTP id g4mr10866321ile.56.1617976571356;
        Fri, 09 Apr 2021 06:56:11 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id e6sm1282448ilr.81.2021.04.09.06.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:56:10 -0700 (PDT)
Date:   Fri, 9 Apr 2021 13:56:09 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Message-ID: <YHBc+e8WQHZ/W0Bv@google.com>
References: <YG+4fS7W+Ii4IxO6@google.com>
 <20210409120214.7BB6.409509F4@e16-tech.com>
 <20210409153636.C53D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409153636.C53D.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 09, 2021 at 03:36:39PM +0800, Wang Yugui wrote:
> Hi,
> 
> some question about workqueue for percpu.
> 
> > > > 
> > > > And a question about this,
> > > > > > > > upper caller:
> > > > > > > >     nofs_flag = memalloc_nofs_save();
> > > > > > > >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> > > > > > > >     memalloc_nofs_restore(nofs_flag);
> > > > > 
> > > > > The issue is here. nofs is set which means percpu attempts an atomic
> > > > > allocation. If it cannot find anything already allocated it isn't happy.
> > > > > This was done before memalloc_nofs_{save/restore}() were pervasive.
> > > > > 
> > > > > Percpu should probably try to allocate some pages if possible even if
> > > > > nofs is set.
> > > > 
> > > > Should we check and pre-alloc memory inside memalloc_nofs_restore()?
> > > > another memalloc_nofs_save() may come soon.
> > > > 
> > > > something like this in memalloc_nofs_save()?
> > > > 	if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_LOW)
> > > >  		pcpu_schedule_balance_work();
> > > > 
> > > 
> > > Percpu does do this via a workqueue item. The issue is in v5.9 we
> > > introduced 2 types of chunks. However, the free float page number was
> > > for the total. So even if 1 chunk type dropped below, the other chunk
> > > type might have enough pages. I'm queuing this for 5.12 and will send it
> > > out assuming it does fix your problem.
> 
> workqueue for percpu maybe not strong enough( not scheduled?) when high
> CPU load?
> 

Percpu is not really cheap memory to allocate because it has a
amplification factor of NR_CPUS. As a result, percpu on the critical
path is really not something that is expected to be high throughput.

Ideally things like btrfs snapshots should preallocate a number of these
and not try to do atomic allocations because that in theory could fail
because even after we go to the page allocator in the future we can't
get enough pages due to needing to go into reclaim.

The workqueue approach has been good enough so far. Technically there is
a higher priority workqueue that this work could be scheduled on, but
save for this miss on my part, the system workqueue has worked out fine.

In the future as I mentioned above. It would be good to support actually
getting pages, but it's work that needs to be tackled with a bit of
care. I might target the work for v5.14.

> this is our application pipeline.
> 	file_pre_process |
> 	bwa.nipt xx |
> 	samtools.nipt sort xx |
> 	file_post_process
> 
> file_pre_process/file_post_process is fast, so often are blocked by
> pipe input/output.
> 
> 'bwa.nipt xx' is a high-cpu-load, almost all of CPU cores.
> 
> 'samtools.nipt sort xx' is a high-mem-load, it keep the input in memory.
> if the memory is not enough, it will save all the buffer to temp file,
> so it is sometimes high-IO-load too(write 60G or more to file).
> 
> 
> xfstests(generic/476) is just high-IO-load, cpu/memory load is NOT high.
> so xfstests(generic/476) maybe easy than our application pipeline.
> 
> Although there is yet not a simple reproducer for another problem
> happend here, but there is a little high chance that something is wrong
> in btrfs/mm/fs-buffer.
> > but another problem(os freezed without call trace, PANIC without OOPS?,
> > the reason is yet unkown) still happen.

I do not have an answer for this. I would recommend looking into kdump.

> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/09
> 
> 
> 

Thanks,
Dennis
