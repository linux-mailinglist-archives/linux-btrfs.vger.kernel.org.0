Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A00F357EF6
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 11:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDHJUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 05:20:09 -0400
Received: from out20-85.mail.aliyun.com ([115.124.20.85]:38550 "EHLO
        out20-85.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHJUG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 05:20:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436377|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00890282-0.000734832-0.990362;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Jwr1hSc_1617873594;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Jwr1hSc_1617873594)
          by smtp.aliyun-inc.com(10.147.41.138);
          Thu, 08 Apr 2021 17:19:54 +0800
Date:   Thu, 08 Apr 2021 17:20:00 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Dennis Zhou <dennis@kernel.org>
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
In-Reply-To: <YG5uFrWpwDHMhdR1@google.com>
References: <20210408072800.6C1F.409509F4@e16-tech.com> <YG5uFrWpwDHMhdR1@google.com>
Message-Id: <20210408171959.2D72.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Thu, Apr 08, 2021 at 07:28:01AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > > > > upper caller:
> > > > > >     nofs_flag = memalloc_nofs_save();
> > > > > >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> > > > > >     memalloc_nofs_restore(nofs_flag);
> > > 
> > > The issue is here. nofs is set which means percpu attempts an atomic
> > > allocation. If it cannot find anything already allocated it isn't happy.
> > > This was done before memalloc_nofs_{save/restore}() were pervasive.
> > > 
> > > Percpu should probably try to allocate some pages if possible even if
> > > nofs is set.
> > 
> > Thanks.
> > 
> > I will wait for the patch, and then test it.
> > 
> 
> I'm currently a bit busy with some other things. Adding support I don't
> think will be much work, just a little bit tricky.
> 
> I recommend carrying what you have minus the change to reserved percpu
> memory for now. If I'm the one to write it, I'll cc you.
> 
> Thanks,
> Dennis


In the recent test, another problem is triggered too with my extended
percpu buffer size patch. maybe this info is helpful.

problem:
OS/VGA console is freezed , and no call stace is outputed.
Just some info is outputed to IPMI/dell iDRAC
   2 | 04/03/2021 | 11:35:01 | OS Critical Stop #0x46 | Run-time critical stop () | Asserted
   3 | Linux kernel panic: Fatal excep
   4 | Linux kernel panic: tion
   5 | 04/05/2021 | 19:09:14 | OS Critical Stop #0x46 | Run-time critical stop () | Asserted
   6 | Linux kernel panic: Fatal excep
   7 | Linux kernel panic: tion
   8 | 04/06/2021 | 13:08:42 | OS Critical Stop #0x46 | Run-time critical stop () | Asserted
   9 | Linux kernel panic: Fatal excep
   a | Linux kernel panic: tion
   b | 04/08/2021 | 02:12:46 | OS Critical Stop #0x46 | Run-time critical stop () | Asserted
   c | Linux kernel panic: Fatal excep
   d | Linux kernel panic: tion
kernel: at least 5.10.26/5.10.27/5.10.28

This problem is triggered by our application, NOT xfstests.
But our applicaiton have some heavy write load just like xfstest/generic/476.
Our application use at most 75% of memory, if still not enough, 
it will write out all buffer info to filesystem.

This problem is happen in linux kernel 5.10.x, but not happen in linux
kernel 5.4.x. It have high frequency to repduce too.

If any guide to get more info for troubleshooting, I will follow it to test.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/08


