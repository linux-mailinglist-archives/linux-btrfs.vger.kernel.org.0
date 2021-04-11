Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6725735B5DE
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Apr 2021 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhDKPUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Apr 2021 11:20:20 -0400
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:44473 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhDKPUU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Apr 2021 11:20:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436413|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0615919-5.09365e-05-0.938357;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JyLkfKm_1618154399;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JyLkfKm_1618154399)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 11 Apr 2021 23:19:59 +0800
Date:   Sun, 11 Apr 2021 23:20:00 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Dennis Zhou <dennis@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
In-Reply-To: <20210411000846.9CC6.409509F4@e16-tech.com>
References: <YHHJpCVpS8sQg7Go@google.com> <20210411000846.9CC6.409509F4@e16-tech.com>
Message-Id: <20210411232000.BF15.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Dennis Zhou

> Hi,
> 
> > On Sat, Apr 10, 2021 at 11:29:17PM +0800, Wang Yugui wrote:
> > > Hi, Dennis Zhou 
> > > 
> > > Thanks for your ncie answer.
> > > but still a few questions.
> > > 
> > > > Percpu is not really cheap memory to allocate because it has a
> > > > amplification factor of NR_CPUS. As a result, percpu on the critical
> > > > path is really not something that is expected to be high throughput.
> > > 
> > > > Ideally things like btrfs snapshots should preallocate a number of these
> > > > and not try to do atomic allocations because that in theory could fail
> > > > because even after we go to the page allocator in the future we can't
> > > > get enough pages due to needing to go into reclaim.
> > > 
> > > pre-allocate in module such as mempool_t is just used in a few place in
> > > linux/fs.  so most people like system wide pre-allocate, because it is
> > > more easy to use?
> > > 
> > > can we add more chance to management the system wide pre-alloc
> > > just like this?
> > > 
> > > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > > index dc1f4dc..eb3f592 100644
> > > --- a/include/linux/sched/mm.h
> > > +++ b/include/linux/sched/mm.h
> > > @@ -226,6 +226,11 @@ static inline void memalloc_noio_restore(unsigned int flags)
> > >  static inline unsigned int memalloc_nofs_save(void)
> > >  {
> > >  	unsigned int flags = current->flags & PF_MEMALLOC_NOFS;
> > > +
> > > +	// just like slab_pre_alloc_hook
> > > +	fs_reclaim_acquire(current->flags & gfp_allowed_mask);
> > > +	fs_reclaim_release(current->flags & gfp_allowed_mask);
> > > +
> > >  	current->flags |= PF_MEMALLOC_NOFS;
> > >  	return flags;
> > >  }
> > > 
> > > 
> > > > The workqueue approach has been good enough so far. Technically there is
> > > > a higher priority workqueue that this work could be scheduled on, but
> > > > save for this miss on my part, the system workqueue has worked out fine.
> > > 
> > > > In the future as I mentioned above. It would be good to support actually
> > > > getting pages, but it's work that needs to be tackled with a bit of
> > > > care. I might target the work for v5.14.
> > > > 
> > > > > this is our application pipeline.
> > > > > 	file_pre_process |
> > > > > 	bwa.nipt xx |
> > > > > 	samtools.nipt sort xx |
> > > > > 	file_post_process
> > > > > 
> > > > > file_pre_process/file_post_process is fast, so often are blocked by
> > > > > pipe input/output.
> > > > > 
> > > > > 'bwa.nipt xx' is a high-cpu-load, almost all of CPU cores.
> > > > > 
> > > > > 'samtools.nipt sort xx' is a high-mem-load, it keep the input in memory.
> > > > > if the memory is not enough, it will save all the buffer to temp file,
> > > > > so it is sometimes high-IO-load too(write 60G or more to file).
> > > > > 
> > > > > 
> > > > > xfstests(generic/476) is just high-IO-load, cpu/memory load is NOT high.
> > > > > so xfstests(generic/476) maybe easy than our application pipeline.
> > > > > 
> > > > > Although there is yet not a simple reproducer for another problem
> > > > > happend here, but there is a little high chance that something is wrong
> > > > > in btrfs/mm/fs-buffer.
> > > > > > but another problem(os freezed without call trace, PANIC without OOPS?,
> > > > > > the reason is yet unkown) still happen.
> > > > 
> > > > I do not have an answer for this. I would recommend looking into kdump.
> > > 
> > > percpu ENOMEM problem blocked many heavy load test a little long time?
> > > I still guess this problem of system freeze is a mm/btrfs problem.
> > > OOM not work, OOPS not work too.
> > > 
> > 
> > I don't follow. Is this still a problem after the patch?
> 
> 
> After the patch for percpu ENOMEM,  the problem of system freeze have a high
> frequecy (>75%) to be triggered by our user-space application.
> 
> The problem of system freeze maybe not caused by the percpu ENOMEM patch.
> 
> percpu ENOMEM problem maybe more easy to happen than the problem of
> system freeze.

After highmem zone +80% / otherzone +40% of WMARK_MIN/ WMARK_LOW/
WMARK_HIGH, we walked around or reduced the reproduce frequency of the
problem of system freeze.

so this is a problem of linux-mm.

the user case of our user-space application.
1)  write the files with the total size > 3 * memory size.
     the memory size > 128G
2)  btrfs with SSD/SAS, SSD/SATA, or btrfs RAID6 hdd
    SSD/NVMe maybe too fast, so difficult to reproduce.
3) some CPU load, and some memory load.

btrfs and other fs seem not like mempool_t wiht pre-alloc, so difficult
job is left to the system-wide reclaim/pre-alloc of linux-mm.

maye memalloc_nofs_save() or memalloc_nofs_restore() is a good place to
 add some sync/aysnc memory reclaim/pre-alloc operations for WMARK_MIN/
WMARK_LOW/WMARK_HIGH and percpu PCPU_EMPTY_POP_PAGES_LOW.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/11


> > > I try to reproduce it with some simple script. I noticed the value of
> > > 'free' is a little low, although 'available' is big.
> > > 
> > > # free -h
> > >               total        used        free      shared  buff/cache   available
> > > Mem:          188Gi       1.4Gi       5.5Gi        17Mi       181Gi       175Gi
> > > Swap:            0B          0B          0B
> > > 
> > > vm.min_free_kbytes is auto configed to 4Gi(4194304)
> > > 
> > > # write files with the size >= memory size *3
> > > #for((i=0;i<10;++i));do dd if=/dev/zero bs=1M count=64K of=/nodetmp/${i}.txt; free -h; done
> > > 
> > > any advice or patch to let the value of 'free' a little bigger?
> > > 
> > > 
> > > Best Regards
> > > Wang Yugui (wangyugui@e16-tech.com)
> > > 2021/04/10
> > > 
> > > 
> > > 
> 


