Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B623596B4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 09:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDIHsT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 03:48:19 -0400
Received: from out20-75.mail.aliyun.com ([115.124.20.75]:48028 "EHLO
        out20-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhDIHsS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 03:48:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04501791|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.141684-0.00314613-0.85517;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JxL0YAj_1617954484;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JxL0YAj_1617954484)
          by smtp.aliyun-inc.com(10.147.41.158);
          Fri, 09 Apr 2021 15:48:04 +0800
Date:   Fri, 09 Apr 2021 15:48:12 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Dennis Zhou <dennis@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
In-Reply-To: <20210409153636.C53D.409509F4@e16-tech.com>
References: <20210409120214.7BB6.409509F4@e16-tech.com> <20210409153636.C53D.409509F4@e16-tech.com>
Message-Id: <20210409154811.C541.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Add top/free info when our applicaiton pipeline is running.

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


# nproc
40
# top
top - 15:43:06 up 10:16,  1 user,  load average: 41.39, 37.90, 35.98
Tasks: 488 total,   3 running, 485 sleeping,   0 stopped,   0 zombie
%Cpu(s): 99.6 us,  0.1 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.3 hi,  0.0 si,  0.0 st
MiB Mem : 58.3/193384.1 [||||||||||||||||||||||||||||||||||||||||||||||||||||||                                       ]
MiB Swap:  0.0/0.0      [                                                                                             ]


# free -h
              total        used        free      shared  buff/cache   available
Mem:          188Gi        98Gi       5.8Gi        17Mi        84Gi        78Gi
Swap:            0B          0B          0B

memory reclaim from 'buff/cache' is easy to happen.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/09


> Although there is yet not a simple reproducer for another problem
> happend here, but there is a little high chance that something is wrong
> in btrfs/mm/fs-buffer.
> > but another problem(os freezed without call trace, PANIC without OOPS?,
> > the reason is yet unkown) still happen.
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/09
> 


