Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08FE35B930
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Apr 2021 06:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhDLEDV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Apr 2021 00:03:21 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:42520 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhDLEDU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Apr 2021 00:03:20 -0400
Received: by mail-il1-f181.google.com with SMTP id 6so9819132ilt.9
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Apr 2021 21:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KNLHPkplIW2H49/uEelRQIdqnn7xgelsGuhU8RzvU9Y=;
        b=VUKitrRpXANXfy77nXtiWFQK70EkiHXMlCCdKLIPK7xEP47IDskWbqCeXkU2rWkV1o
         yRG6V57RLGLhVVotMmz8ahlBGqOw3P0alCiiyvCOQVDa8qG6uqF/smkjwHYwt1Nqg2CN
         5b9NcnNSViXvZCk0gFYH2WBuJgA/N3BUHx13eeFmeyYdH6OFv6yzbfsBUkhZndIaFQN9
         C1F86mtqmfc/voXyV9pv1jn1vho1cbjhG1t5bC0PZ0e902wDOQ+l5+8P63/zJEGiZ7Yt
         ssYlRyFIoYLcG4G3nksHq3rrUIrdjIFuOR2JuvOaTDLuK8qXp2zFT7eEP/N3455rrjAq
         kieA==
X-Gm-Message-State: AOAM533HQrXyV2UkqwOjC3ciSuFjznHxXbS2/SO7AodroT9dclLEjnaS
        GH7LNT1mFkj9N5wZDJyfI33qfwKP1GQ=
X-Google-Smtp-Source: ABdhPJwAlWLgLTRtHraR07nUzI+3h2NVMSQnNgvonV8ln7OJMiyoiprA7+l+/KXOL47bgtCSqMfRyA==
X-Received: by 2002:a92:1306:: with SMTP id 6mr5338608ilt.289.1618200183071;
        Sun, 11 Apr 2021 21:03:03 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id h13sm1857889ild.16.2021.04.11.21.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 21:03:02 -0700 (PDT)
Date:   Mon, 12 Apr 2021 04:03:01 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Message-ID: <YHPGdVDc6/4jxggg@google.com>
References: <YHHJpCVpS8sQg7Go@google.com>
 <20210411000846.9CC6.409509F4@e16-tech.com>
 <20210411232000.BF15.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411232000.BF15.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 11, 2021 at 11:20:00PM +0800, Wang Yugui wrote:
> Hi, Dennis Zhou
> 
> > Hi,
> > 
> > > On Sat, Apr 10, 2021 at 11:29:17PM +0800, Wang Yugui wrote:
> > > > Hi, Dennis Zhou 
> > > > 
> > > > Thanks for your ncie answer.
> > > > but still a few questions.
> > > > 
> > > > > Percpu is not really cheap memory to allocate because it has a
> > > > > amplification factor of NR_CPUS. As a result, percpu on the critical
> > > > > path is really not something that is expected to be high throughput.
> > > > 
> > > > > Ideally things like btrfs snapshots should preallocate a number of these
> > > > > and not try to do atomic allocations because that in theory could fail
> > > > > because even after we go to the page allocator in the future we can't
> > > > > get enough pages due to needing to go into reclaim.
> > > > 
> > > > pre-allocate in module such as mempool_t is just used in a few place in
> > > > linux/fs.  so most people like system wide pre-allocate, because it is
> > > > more easy to use?
> > > > 
> > > > can we add more chance to management the system wide pre-alloc
> > > > just like this?
> > > > 
> > > > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > > > index dc1f4dc..eb3f592 100644
> > > > --- a/include/linux/sched/mm.h
> > > > +++ b/include/linux/sched/mm.h
> > > > @@ -226,6 +226,11 @@ static inline void memalloc_noio_restore(unsigned int flags)
> > > >  static inline unsigned int memalloc_nofs_save(void)
> > > >  {
> > > >  	unsigned int flags = current->flags & PF_MEMALLOC_NOFS;
> > > > +
> > > > +	// just like slab_pre_alloc_hook
> > > > +	fs_reclaim_acquire(current->flags & gfp_allowed_mask);
> > > > +	fs_reclaim_release(current->flags & gfp_allowed_mask);
> > > > +
> > > >  	current->flags |= PF_MEMALLOC_NOFS;
> > > >  	return flags;
> > > >  }
> > > > 
> > > > 
> > > > > The workqueue approach has been good enough so far. Technically there is
> > > > > a higher priority workqueue that this work could be scheduled on, but
> > > > > save for this miss on my part, the system workqueue has worked out fine.
> > > > 
> > > > > In the future as I mentioned above. It would be good to support actually
> > > > > getting pages, but it's work that needs to be tackled with a bit of
> > > > > care. I might target the work for v5.14.
> > > > > 
> > > > > > this is our application pipeline.
> > > > > > 	file_pre_process |
> > > > > > 	bwa.nipt xx |
> > > > > > 	samtools.nipt sort xx |
> > > > > > 	file_post_process
> > > > > > 
> > > > > > file_pre_process/file_post_process is fast, so often are blocked by
> > > > > > pipe input/output.
> > > > > > 
> > > > > > 'bwa.nipt xx' is a high-cpu-load, almost all of CPU cores.
> > > > > > 
> > > > > > 'samtools.nipt sort xx' is a high-mem-load, it keep the input in memory.
> > > > > > if the memory is not enough, it will save all the buffer to temp file,
> > > > > > so it is sometimes high-IO-load too(write 60G or more to file).
> > > > > > 
> > > > > > 
> > > > > > xfstests(generic/476) is just high-IO-load, cpu/memory load is NOT high.
> > > > > > so xfstests(generic/476) maybe easy than our application pipeline.
> > > > > > 
> > > > > > Although there is yet not a simple reproducer for another problem
> > > > > > happend here, but there is a little high chance that something is wrong
> > > > > > in btrfs/mm/fs-buffer.
> > > > > > > but another problem(os freezed without call trace, PANIC without OOPS?,
> > > > > > > the reason is yet unkown) still happen.
> > > > > 
> > > > > I do not have an answer for this. I would recommend looking into kdump.
> > > > 
> > > > percpu ENOMEM problem blocked many heavy load test a little long time?
> > > > I still guess this problem of system freeze is a mm/btrfs problem.
> > > > OOM not work, OOPS not work too.
> > > > 
> > > 
> > > I don't follow. Is this still a problem after the patch?
> > 
> > 
> > After the patch for percpu ENOMEM,  the problem of system freeze have a high
> > frequecy (>75%) to be triggered by our user-space application.
> > 
> > The problem of system freeze maybe not caused by the percpu ENOMEM patch.
> > 
> > percpu ENOMEM problem maybe more easy to happen than the problem of
> > system freeze.
> 
> After highmem zone +80% / otherzone +40% of WMARK_MIN/ WMARK_LOW/
> WMARK_HIGH, we walked around or reduced the reproduce frequency of the
> problem of system freeze.
> 
> so this is a problem of linux-mm.
> 
> the user case of our user-space application.
> 1)  write the files with the total size > 3 * memory size.
>      the memory size > 128G
> 2)  btrfs with SSD/SAS, SSD/SATA, or btrfs RAID6 hdd
>     SSD/NVMe maybe too fast, so difficult to reproduce.
> 3) some CPU load, and some memory load.
> 

To me it just sounds like writeback is slow. It's hard to debug a system
without actually observing it as well. You might want to limit the
memory allotted to the workload cgroup possibly memory.high. This may
help kick reclaim in earlier.

> btrfs and other fs seem not like mempool_t wiht pre-alloc, so difficult
> job is left to the system-wide reclaim/pre-alloc of linux-mm.
> 
> maye memalloc_nofs_save() or memalloc_nofs_restore() is a good place to
>  add some sync/aysnc memory reclaim/pre-alloc operations for WMARK_MIN/
> WMARK_LOW/WMARK_HIGH and percpu PCPU_EMPTY_POP_PAGES_LOW.
> 

It's not that simple. Memory reclaim is a balancing act and these places
mark where reclaim cannot trigger writeback and thus oom-killer is the
only way out. I'm sorry, but beyond the above, I don't really have any
additional advice besides retuning your workload to use less memory and
give the system more headroom.

I appreciate the bug report though and if its anything percpu related I
will always be available.

> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/11
> 

Thanks,
Dennis
