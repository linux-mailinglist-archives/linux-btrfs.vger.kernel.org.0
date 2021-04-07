Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9C356F6A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbhDGO4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 10:56:50 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:47103 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345603AbhDGO4u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 10:56:50 -0400
Received: by mail-il1-f179.google.com with SMTP id p8so12097537ilm.13
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Apr 2021 07:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ciYyOe2TaR+zXgJWJq9y6FIUTM0gYXQGEgNe2yv7a4I=;
        b=sctw5OB2ustRV2zeDXgr45yejnM4S0OFvUloeYS5+hm59d1/q0h9hj0ki2fv09MDnN
         z9wyvzpZnZC5En0YIhEWkLL4bDEaI1I2imvFlNAFL/xjMgaNNjCvwR9TZbz8qOlW7yfG
         /w/XeuWlj1u2NHmhF1t32fegHAdSLpWeXgGZ7qZkNhLMAXL2CCwVkCz/tU24B6nss7/t
         jI1ItrbEnkJbIitoDymfu7wy2U8r/Kb3gFV4VpKG+3foev4UkRvS2v/QU4uXL90hmWL1
         Yi4Ip0wfnhT7IkhVzI5XL1RiWx9GqnacMrYYNTYy/ag0QHdVMF/vUqrKeXb1NSMWFYOZ
         MZMw==
X-Gm-Message-State: AOAM5313v/RaCVJXT98Z6s7DtGaksIasJfvppkJqI5p8WIGudEakeRUL
        3BgYY/hc3AyckV992sjjzak=
X-Google-Smtp-Source: ABdhPJxhFiE344XNDJScIHvn5IO6BT61+VbgASZ+gBhMDBwUwjrmk+T77X/ajyR/aTzzLVD86BL/LQ==
X-Received: by 2002:a05:6e02:1d99:: with SMTP id h25mr2951443ila.114.1617807400123;
        Wed, 07 Apr 2021 07:56:40 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id y3sm15450047iot.15.2021.04.07.07.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:56:39 -0700 (PDT)
Date:   Wed, 7 Apr 2021 14:56:38 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Message-ID: <YG3IJnAjgikZ0PkC@google.com>
References: <20210401185158.3275.409509F4@e16-tech.com>
 <60e9b994-e37c-d059-4af5-0cb7860ca4f3@suse.cz>
 <20210407210905.F790.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407210905.F790.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

On Wed, Apr 07, 2021 at 09:09:07PM +0800, Wang Yugui wrote:
> Hi,
> 
> > +CC btrfs
> > 
> > On 4/1/21 12:51 PM, Wang Yugui wrote:
> > > Hi,
> > > 
> > > an unexpected -ENOMEM from percpu_counter_init() happened when xfstest 
> > > with kernel 5.11.10 and 5.10.27
> > 
> > Is there a dmesg log showing allocation failure or something?
> 
> When unexpected -ENOMEM of percpu_counter_init(), btrfs as upper caller
> finally output something to dmesg.
> 
> And we add one trace to btrfs source to make sure that.
> >     if (ret == -ENOMEM) printk("ENOMEM btrfs_drew_lock_init\n");
> 
> 
> Now the reproduce frequency become from >50% to not happen or very slow
> with the flowing change.
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 6596a0a..0127be1 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -104,8 +104,8 @@
>  /* chunks in slots below this are subject to being sidelined on failed alloc */
>  #define PCPU_SLOT_FAIL_THRESHOLD	3
>  
> -#define PCPU_EMPTY_POP_PAGES_LOW	2
> -#define PCPU_EMPTY_POP_PAGES_HIGH	4
> +#define PCPU_EMPTY_POP_PAGES_LOW	8
> +#define PCPU_EMPTY_POP_PAGES_HIGH	16
>  

These settings are from 2014 when Tejun initially implemented the atomic
allocation float. It is probably time to think about increasing the
number of pages. I'd prefer to do it in a dynamic way though (some X% of
a chunk instead of a fixed number increase).

>  #ifdef CONFIG_SMP
>  /* default addr <-> pcpu_ptr mapping, override in asm/percpu.h if necessary */
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 5e76af7..8cc091b 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -14,7 +14,7 @@
>  
>  /* enough to cover all DEFINE_PER_CPUs in modules */
>  #ifdef CONFIG_MODULES
> -#define PERCPU_MODULE_RESERVE		(8 << 10)
> +#define PERCPU_MODULE_RESERVE		(32 << 10)
>  #else
>  #define PERCPU_MODULE_RESERVE		0
>  #endif
> 

This is a reserved region purely for module static inits.
btrfs_drew_lock_init() is a dynamic init.

> 
> Just some guess,
> 1) maybe some releationship to the trigger of 'vm.dirty_bytes=10737418240'.
> 
> this problem happen in 
> server/T7610 with E5-2660v2 *2 and SSD/SAS(6Gb/s) and 192G memory
> but not happen in
> server/T620 with E5-2680v2 *2 and SSD/NVMe and 192G memory.
> 
> 2) maybe some releationship to numa.
> 128G memory in node1(CPU1), and 64G in node2(CPU2)
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/07
> 
> 
> > > direct caller:
> > > int btrfs_drew_lock_init(struct btrfs_drew_lock *lock)
> > > {
> > >     int ret;
> > > 
> > >     ret = percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
> > >     if (ret)
> > >         return ret;
> > > 
> > >     atomic_set(&lock->readers, 0);
> > >     init_waitqueue_head(&lock->pending_readers);
> > >     init_waitqueue_head(&lock->pending_writers);
> > > 
> > >     return 0;
> > > }
> > > 
> > > upper caller:
> > >     nofs_flag = memalloc_nofs_save();
> > >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> > >     memalloc_nofs_restore(nofs_flag);

The issue is here. nofs is set which means percpu attempts an atomic
allocation. If it cannot find anything already allocated it isn't happy.
This was done before memalloc_nofs_{save/restore}() were pervasive.

Percpu should probably try to allocate some pages if possible even if
nofs is set.

> > >     if (ret == -ENOMEM) printk("ENOMEM btrfs_drew_lock_init\n");
> > >     if (ret)
> > >         goto fail;
> > > 
> > > The hardware of this server:
> > > CPU:  Xeon(R) CPU E5-2660 v2(10 core)  *2
> > > memory:  192G, no swap
> > > 
> > > Only one xfstests job is running in this server, and about 7% of memory
> > > is used.
> > > 
> > > Any advice please.
> > > 
> > > Best Regards
> > > Wang Yugui (wangyugui@e16-tech.com)
> > > 2021/04/01
> > > 
> > > 
> 

Thanks,
Dennis
