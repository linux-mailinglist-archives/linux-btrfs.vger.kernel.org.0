Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630223599DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDIJwu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 05:52:50 -0400
Received: from out20-49.mail.aliyun.com ([115.124.20.49]:35466 "EHLO
        out20-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDIJwu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 05:52:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04458401|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0133605-0.000248439-0.986391;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JxOoXU6_1617961955;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JxOoXU6_1617961955)
          by smtp.aliyun-inc.com(10.147.41.121);
          Fri, 09 Apr 2021 17:52:35 +0800
Date:   Fri, 09 Apr 2021 17:52:43 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Cc:     linux-mm@kvack.org, linux-btrfs@vger.kernel.org
In-Reply-To: <60e9b994-e37c-d059-4af5-0cb7860ca4f3@suse.cz>
References: <20210401185158.3275.409509F4@e16-tech.com> <60e9b994-e37c-d059-4af5-0cb7860ca4f3@suse.cz>
Message-Id: <20210409175242.C545.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Dennis Zhou, Vlastimil Babka, Filipe Manana

The root reason of this problem maybe the design of
'memalloc_nofs_restore()/memalloc_nofs_save()'.

When some job such as memory pre-alloc and reclaim is needed,  that is
done in a workqueue now.

This is a problem for high-load and over-load. In that case, we need to
do these job in current task/process, so that current task/process will
be blocked until necessary job is done.

If we let these job in done in a workqueue, and current task/process is
not blocked, that means failure is very near, and then we can not work
stable in high-load and over-load.

For high-load and over-load, failure is not expected,  we expect some
job be blocked well.

> > Percpu does do this via a workqueue item. The issue is in v5.9 we
> > introduced 2 types of chunks. However, the free float page number was
> > for the total. So even if 1 chunk type dropped below, the other chunk
> > type might have enough pages. I'm queuing this for 5.12 and will send it
> > out assuming it does fix your problem.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/09

> +CC btrfs
> 
> On 4/1/21 12:51 PM, Wang Yugui wrote:
> > Hi,
> > 
> > an unexpected -ENOMEM from percpu_counter_init() happened when xfstest 
> > with kernel 5.11.10 and 5.10.27
> 
> Is there a dmesg log showing allocation failure or something?
> 
> > direct caller:
> > int btrfs_drew_lock_init(struct btrfs_drew_lock *lock)
> > {
> >     int ret;
> > 
> >     ret = percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
> >     if (ret)
> >         return ret;
> > 
> >     atomic_set(&lock->readers, 0);
> >     init_waitqueue_head(&lock->pending_readers);
> >     init_waitqueue_head(&lock->pending_writers);
> > 
> >     return 0;
> > }
> > 
> > upper caller:
> >     nofs_flag = memalloc_nofs_save();
> >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> >     memalloc_nofs_restore(nofs_flag);
> >     if (ret == -ENOMEM) printk("ENOMEM btrfs_drew_lock_init\n");
> >     if (ret)
> >         goto fail;
> > 
> > The hardware of this server:
> > CPU:  Xeon(R) CPU E5-2660 v2(10 core)  *2
> > memory:  192G, no swap
> > 
> > Only one xfstests job is running in this server, and about 7% of memory
> > is used.
> > 
> > Any advice please.
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2021/04/01
> > 
> > 


