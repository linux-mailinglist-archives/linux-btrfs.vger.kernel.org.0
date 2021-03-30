Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38D934E157
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 08:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhC3Gkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 02:40:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:52410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhC3GkS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 02:40:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617086417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcYKRknOKNTMYeWru94sRaN5et1tdwhiEBqAu2oxtjU=;
        b=RtqMvpYeQZbnBWU+9zrUvBk1z1wGTztJtKO9mWU+Gp9hwl8PfRl+MJ16dbiDbAIq1XYMqw
        TaD5sgDnS0czmmEl3LEBbp2vqsEw7oZ8sCnw201aN2DHJgt01KUWrlaiH7M4fCCpik8tbD
        TSI0ai1ggrP3JdSrbIIVzd87pxkRIn0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2219AD6D;
        Tue, 30 Mar 2021 06:40:17 +0000 (UTC)
Subject: Re: xfstests generic/476 failed on btrfs(errno=-12 Out of memory,
 kernel 5.11.10)
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20210327230400.844B.409509F4@e16-tech.com>
 <20210328185609.D969.409509F4@e16-tech.com>
 <20210330142446.AB2E.409509F4@e16-tech.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <8bcfb096-8de5-2176-0bf8-c2c9049aefe5@suse.com>
Date:   Tue, 30 Mar 2021 09:40:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330142446.AB2E.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.03.21 г. 9:24, Wang Yugui wrote:
> Hi, Nikolay Borisov
> 
> With a lot of dump_stack()/printk inserted around ENOMEM in btrfs code,
> we find out the call stack for ENOMEM.
> see the file 0000-btrfs-dump_stack-when-ENOMEM.patch
> 
> 
> #cat /usr/hpc-bio/xfstests/results//generic/476.dmesg
> ...
> [ 5759.102929] ENOMEM btrfs_drew_lock_init
> [ 5759.102943] ENOMEM btrfs_init_fs_root
> [ 5759.102947] ------------[ cut here ]------------
> [ 5759.102950] BTRFS: Transaction aborted (error -12)
> [ 5759.103052] WARNING: CPU: 14 PID: 2741468 at /ssd/hpc-bio/linux-5.10.27/fs/btrfs/transaction.c:1705 create_pending_snapshot+0xb8c/0xd50 [btrfs]
> ...
> 
> 
> btrfs_drew_lock_init() return -ENOMEM, 
> this is the source:
> 
>     /*
>      * We might be called under a transaction (e.g. indirect backref
>      * resolution) which could deadlock if it triggers memory reclaim
>      */
>     nofs_flag = memalloc_nofs_save();
>     ret = btrfs_drew_lock_init(&root->snapshot_lock);
>     memalloc_nofs_restore(nofs_flag);
>     if (ret == -ENOMEM) printk("ENOMEM btrfs_drew_lock_init\n");
>     if (ret)
>         goto fail;
> 
> And the souce come from:
> 
> commit dcc3eb9638c3c927f1597075e851d0a16300a876
> Author: Nikolay Borisov <nborisov@suse.com>
> Date:   Thu Jan 30 14:59:45 2020 +0200
> 
>     btrfs: convert snapshot/nocow exlcusion to drew lock
> 
> 
> Any advice to fix this ENOMEM problem?

This is likely coming from changed behavior in MM, doesn't seem related
to btrfs. We have multiple places where nofs_save() is called. By the
same token the failure might have occurred in any other place, in any
other piece of code which uses memalloc_nofs_save, there is no
indication that this is directly related to btrfs.

> 
> top command show that this server have engough memory.
> 
> The hardware of this server:
> CPU:  Xeon(R) CPU E5-2660 v2(10 core)  *2
> memory:  192G, no swap

You are showing that the server has 192G of installed memory, you have
not shown any stats which prove at the time of failure what is the state
of the MM subsystem. At the very least at the time of failure inspect
the output of :

cat /proc/meminfo

and "free -m" commands.

<snip>
