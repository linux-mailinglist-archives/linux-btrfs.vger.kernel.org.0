Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C49335AEED
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 17:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhDJPwY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Apr 2021 11:52:24 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:46968 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhDJPwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 11:52:21 -0400
Received: by mail-il1-f180.google.com with SMTP id l19so3382215ilk.13
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 08:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=23EKbp9zlt1ctsp4N80b48v3urJ7l3pIXgbyxpzzJPI=;
        b=LBd6YDxaB+RsLmLckgCDDiX3lSq3q2sZ7smfRAFK+IPiGt099T3bkqmG6gIM318pnf
         usL6EWLAxYVnd8659P7PBhyofFp+ttugn3OdDlE1EG1Nzm8IykKp+DyIAiVnwiL3/A6J
         KNiB+tR6UMSi2fXeEwNWV/uYKdX76KumpS3XA22WuqSkkR/ExYl+8INIiD8cLLRQyKdH
         2RzlWwRZPZ3paoZ6846tBiinopr44G5gsdCRBXFUkAOju/ErCJYkJ3Flw6rgLy1yt2gs
         adQxx1dRTlP2ZDBu1h7RNkkOaIhvsyl/CUCWBvS+iNUIzTc+6QMlvuLACzYsXyTn8HIX
         yt4A==
X-Gm-Message-State: AOAM532YkNsSRSaa7qsKqm2SL9oJJ/FYeF6Os50MOyLXDfIoqqSg/8rp
        ofFq/ogXaVr8JI2YS9O6CKHPeKdpvWU=
X-Google-Smtp-Source: ABdhPJw50EzdVLLwIiFxzTTRlIHrnxiymhe1mgKYZtbKmNTsSU2uurcksf/dkRoaWpOA49PEjwdtrw==
X-Received: by 2002:a05:6e02:1d99:: with SMTP id h25mr15224232ila.114.1618069926054;
        Sat, 10 Apr 2021 08:52:06 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id b4sm2846685iog.15.2021.04.10.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 08:52:05 -0700 (PDT)
Date:   Sat, 10 Apr 2021 15:52:04 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Message-ID: <YHHJpCVpS8sQg7Go@google.com>
References: <20210409153636.C53D.409509F4@e16-tech.com>
 <YHBc+e8WQHZ/W0Bv@google.com>
 <20210410232913.6F82.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410232913.6F82.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 10, 2021 at 11:29:17PM +0800, Wang Yugui wrote:
> Hi, Dennis Zhou 
> 
> Thanks for your ncie answer.
> but still a few questions.
> 
> > Percpu is not really cheap memory to allocate because it has a
> > amplification factor of NR_CPUS. As a result, percpu on the critical
> > path is really not something that is expected to be high throughput.
> 
> > Ideally things like btrfs snapshots should preallocate a number of these
> > and not try to do atomic allocations because that in theory could fail
> > because even after we go to the page allocator in the future we can't
> > get enough pages due to needing to go into reclaim.
> 
> pre-allocate in module such as mempool_t is just used in a few place in
> linux/fs.  so most people like system wide pre-allocate, because it is
> more easy to use?
> 
> can we add more chance to management the system wide pre-alloc
> just like this?
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index dc1f4dc..eb3f592 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -226,6 +226,11 @@ static inline void memalloc_noio_restore(unsigned int flags)
>  static inline unsigned int memalloc_nofs_save(void)
>  {
>  	unsigned int flags = current->flags & PF_MEMALLOC_NOFS;
> +
> +	// just like slab_pre_alloc_hook
> +	fs_reclaim_acquire(current->flags & gfp_allowed_mask);
> +	fs_reclaim_release(current->flags & gfp_allowed_mask);
> +
>  	current->flags |= PF_MEMALLOC_NOFS;
>  	return flags;
>  }
> 
> 
> > The workqueue approach has been good enough so far. Technically there is
> > a higher priority workqueue that this work could be scheduled on, but
> > save for this miss on my part, the system workqueue has worked out fine.
> 
> > In the future as I mentioned above. It would be good to support actually
> > getting pages, but it's work that needs to be tackled with a bit of
> > care. I might target the work for v5.14.
> > 
> > > this is our application pipeline.
> > > 	file_pre_process |
> > > 	bwa.nipt xx |
> > > 	samtools.nipt sort xx |
> > > 	file_post_process
> > > 
> > > file_pre_process/file_post_process is fast, so often are blocked by
> > > pipe input/output.
> > > 
> > > 'bwa.nipt xx' is a high-cpu-load, almost all of CPU cores.
> > > 
> > > 'samtools.nipt sort xx' is a high-mem-load, it keep the input in memory.
> > > if the memory is not enough, it will save all the buffer to temp file,
> > > so it is sometimes high-IO-load too(write 60G or more to file).
> > > 
> > > 
> > > xfstests(generic/476) is just high-IO-load, cpu/memory load is NOT high.
> > > so xfstests(generic/476) maybe easy than our application pipeline.
> > > 
> > > Although there is yet not a simple reproducer for another problem
> > > happend here, but there is a little high chance that something is wrong
> > > in btrfs/mm/fs-buffer.
> > > > but another problem(os freezed without call trace, PANIC without OOPS?,
> > > > the reason is yet unkown) still happen.
> > 
> > I do not have an answer for this. I would recommend looking into kdump.
> 
> percpu ENOMEM problem blocked many heavy load test a little long time?
> I still guess this problem of system freeze is a mm/btrfs problem.
> OOM not work, OOPS not work too.
> 

I don't follow. Is this still a problem after the patch?

> I try to reproduce it with some simple script. I noticed the value of
> 'free' is a little low, although 'available' is big.
> 
> # free -h
>               total        used        free      shared  buff/cache   available
> Mem:          188Gi       1.4Gi       5.5Gi        17Mi       181Gi       175Gi
> Swap:            0B          0B          0B
> 
> vm.min_free_kbytes is auto configed to 4Gi(4194304)
> 
> # write files with the size >= memory size *3
> #for((i=0;i<10;++i));do dd if=/dev/zero bs=1M count=64K of=/nodetmp/${i}.txt; free -h; done
> 
> any advice or patch to let the value of 'free' a little bigger?
> 
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/10
> 
> 
> 
