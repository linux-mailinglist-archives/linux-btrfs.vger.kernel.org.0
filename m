Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE293590C4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 02:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhDIAIH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 8 Apr 2021 20:08:07 -0400
Received: from out20-111.mail.aliyun.com ([115.124.20.111]:53524 "EHLO
        out20-111.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIAIH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 20:08:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04462716|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0188873-0.00381009-0.977303;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Jx7cE6R_1617926873;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Jx7cE6R_1617926873)
          by smtp.aliyun-inc.com(10.147.40.26);
          Fri, 09 Apr 2021 08:07:53 +0800
Date:   Fri, 09 Apr 2021 08:08:00 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Dennis Zhou <dennis@kernel.org>
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
In-Reply-To: <YG8JsdAebEPqOhr/@google.com>
References: <20210408171959.2D72.409509F4@e16-tech.com> <YG8JsdAebEPqOhr/@google.com>
Message-Id: <20210409080759.4B68.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> > kernel: at least 5.10.26/5.10.27/5.10.28
> > 
> > This problem is triggered by our application, NOT xfstests.
> > But our applicaiton have some heavy write load just like xfstest/generic/476.
> > Our application use at most 75% of memory, if still not enough, 
> > it will write out all buffer info to filesystem.
> 
> Do you use cgroups at all? If yes can you describe the workload pattern
> a bit.

cgroups is enabled defaultly, so cgroups is used.

This is the output of systemd-cgls, ''samtools.nipt sort -m 60G" is one
of our application.  but our application is NOT cgroups-aware, and it NOT
call any cgroup interface directly.

Control group /:
-.slice
©À©¤user.slice
©¦ ©¸©¤user-0.slice
©¦   ©À©¤session-55.scope
©¦   ©¦ ©À©¤48747 sshd: root [priv]
©¦   ©¦ ©À©¤48788 sshd: root@notty
©¦   ©¦ ©À©¤48795 perl -e @GNU_Parallel=split/_/,"use_IPC::Open3;_use_MIME::Base6...
©¦   ©¦ ©À©¤48943 samtools.nipt sort -m 60G -T /nodetmp//nfs/biowrk/baseline.wgs2...
©¦   ©¦ ©À©¤....
©¦   ©¸©¤user@0.service
©¦     ©¸©¤init.scope
©¦       ©À©¤48775 /usr/lib/systemd/systemd --user
©¦       ©¸©¤48781 (sd-pam)
©À©¤init.scope
©¦ ©¸©¤1 /usr/lib/systemd/systemd --switched-root --system --deserialize 18
©¸©¤system.slice
  ©À©¤rngd.service
  ©¦ ©¸©¤1577 /sbin/rngd -f --fill-watermark=0
  ©À©¤irqbalance.service
  ©¦ ©¸©¤1543 /usr/sbin/irqbalance --foreground
....


> > This problem is happen in linux kernel 5.10.x, but not happen in linux
> > kernel 5.4.x. It have high frequency to repduce too.
> 
> Ah. Can you try the following patch?
> https://lore.kernel.org/lkml/20210408035736.883861-4-guro@fb.com/
> 
> Thanks,
> Dennis

kernel: kernel 5.10.28+this patch
result: yet not happen after 4 times test.
          without this path, the reproduce frequency is >50%

And a question about this,
> > > > upper caller:
> > > >     nofs_flag = memalloc_nofs_save();
> > > >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> > > >     memalloc_nofs_restore(nofs_flag);
> 
> The issue is here. nofs is set which means percpu attempts an atomic
> allocation. If it cannot find anything already allocated it isn't happy.
> This was done before memalloc_nofs_{save/restore}() were pervasive.
> 
> Percpu should probably try to allocate some pages if possible even if
> nofs is set.

Should we check and pre-alloc memory inside memalloc_nofs_restore()?
another memalloc_nofs_save() may come soon.

something like this in memalloc_nofs_save()?
	if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_LOW)
 		pcpu_schedule_balance_work();


by the way, this problem still happen in kernel 5.10.28+this patch.
Is this is a PANIC without OOPS?  any guide for troubleshooting please.
> problem:
> OS/VGA console is freezed , and no call trace is outputed.
> Just some info is outputed to IPMI/dell iDRAC
>    2 | 04/03/2021 | 11:35:01 | OS Critical Stop #0x46 | Run-time critical stop () | Asserted
>    3 | Linux kernel panic: Fatal excep
>    4 | Linux kernel panic: tion

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/08

