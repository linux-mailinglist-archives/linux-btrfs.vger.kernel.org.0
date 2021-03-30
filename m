Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC3F34E1F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 09:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhC3HQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 03:16:17 -0400
Received: from out20-110.mail.aliyun.com ([115.124.20.110]:60441 "EHLO
        out20-110.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhC3HQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 03:16:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05020833|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0916714-0.00572171-0.902607;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JsQIcxI_1617088559;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JsQIcxI_1617088559)
          by smtp.aliyun-inc.com(10.147.41.231);
          Tue, 30 Mar 2021 15:16:00 +0800
Date:   Tue, 30 Mar 2021 15:16:02 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: xfstests generic/476 failed on btrfs(errno=-12 Out of memory, kernel 5.11.10)
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <8bcfb096-8de5-2176-0bf8-c2c9049aefe5@suse.com>
References: <20210330142446.AB2E.409509F4@e16-tech.com> <8bcfb096-8de5-2176-0bf8-c2c9049aefe5@suse.com>
Message-Id: <20210330151601.7E69.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

H,

> On 30.03.21 §Ô. 9:24, Wang Yugui wrote:
> > Hi, Nikolay Borisov
> > 
> > With a lot of dump_stack()/printk inserted around ENOMEM in btrfs code,
> > we find out the call stack for ENOMEM.
> > see the file 0000-btrfs-dump_stack-when-ENOMEM.patch
> > 
> > 
> > #cat /usr/hpc-bio/xfstests/results//generic/476.dmesg
> > ...
> > [ 5759.102929] ENOMEM btrfs_drew_lock_init
> > [ 5759.102943] ENOMEM btrfs_init_fs_root
> > [ 5759.102947] ------------[ cut here ]------------
> > [ 5759.102950] BTRFS: Transaction aborted (error -12)
> > [ 5759.103052] WARNING: CPU: 14 PID: 2741468 at /ssd/hpc-bio/linux-5.10.27/fs/btrfs/transaction.c:1705 create_pending_snapshot+0xb8c/0xd50 [btrfs]
> > ...
> > 
> > 
> > btrfs_drew_lock_init() return -ENOMEM, 
> > this is the source:
> > 
> >     /*
> >      * We might be called under a transaction (e.g. indirect backref
> >      * resolution) which could deadlock if it triggers memory reclaim
> >      */
> >     nofs_flag = memalloc_nofs_save();
> >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> >     memalloc_nofs_restore(nofs_flag);
> >     if (ret == -ENOMEM) printk("ENOMEM btrfs_drew_lock_init\n");
> >     if (ret)
> >         goto fail;
> > 
> > And the souce come from:
> > 
> > commit dcc3eb9638c3c927f1597075e851d0a16300a876
> > Author: Nikolay Borisov <nborisov@suse.com>
> > Date:   Thu Jan 30 14:59:45 2020 +0200
> > 
> >     btrfs: convert snapshot/nocow exlcusion to drew lock
> > 
> > 
> > Any advice to fix this ENOMEM problem?
> 
> This is likely coming from changed behavior in MM, doesn't seem related
> to btrfs. We have multiple places where nofs_save() is called. By the
> same token the failure might have occurred in any other place, in any
> other piece of code which uses memalloc_nofs_save, there is no
> indication that this is directly related to btrfs.
> 
> > 
> > top command show that this server have engough memory.
> > 
> > The hardware of this server:
> > CPU:  Xeon(R) CPU E5-2660 v2(10 core)  *2
> > memory:  192G, no swap
> 
> You are showing that the server has 192G of installed memory, you have
> not shown any stats which prove at the time of failure what is the state
> of the MM subsystem. At the very least at the time of failure inspect
> the output of :
> 
> cat /proc/meminfo
> 
> and "free -m" commands.
> 
> <snip>

Only one xfstest job is running in this server.


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/03/30


