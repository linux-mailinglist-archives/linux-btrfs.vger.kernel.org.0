Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C45982287
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 18:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHEQg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 12:36:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51808 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHEQg1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 12:36:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so75405013wma.1;
        Mon, 05 Aug 2019 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6IgxkcJMKz9Fy1Bo9Dhv0qnNKVUCye+F6rQM5HpFywU=;
        b=R9HAs/WWeJNgXR6IAv8PwPneDnspd43Kg+L40q6WUEkNAZce927JpS1Xhn17UVd/lf
         3IVCffEadLNaPdWlvs+jab5/BJv50/OLioU0R2AO/vtTKVMs8NtxUhFufJUaSqhLc54/
         fpl6+2OjFLZgPXPpX2s7eIXMB5ZEPy2E514rV9YpG2jk3RHsfPUdNb0f2P8LSG5Epqd8
         zXHJYXbBm650wRYA4KOsoBPzmwCuVeYv6FvdgKgMKwkKCymOa7un09wBlYYoQ1fEQMg1
         gC2ch/1UkJlgcBYmQOAvtfpU1egUaYQHm3xfCAsEDahdj7riOAe13mrt4L9OpuoXesbM
         5pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6IgxkcJMKz9Fy1Bo9Dhv0qnNKVUCye+F6rQM5HpFywU=;
        b=rd95mgCV7vrKDfL7cHZqWDx3Ltcy2wQaxlnWDSf3r6r2wRfnwAYXHRB3rtxHnl5M4J
         5T2lO4R0W/ojXsdgN7LY+l+vLMT/hhFO1HlDB5rmC73El2YolxyHv3V3gGxI3qi2r3Hj
         jnrxu2J9cam74J8UkwsLk3MRkh7DK5RFjDnPjQ4ASR9l7AbXQ/MlJcIkYBXCp0g8RoP2
         InkBuXuEledVtljpSJI5+FguXLbh2WYJx5cmbOcjz5/URibUIdaZjMtRxMIefcV7iI8x
         nyLFpjA3HY3RBmOltJCW57ZzFhsz8BKmgZgbZjsuUec/1tSTq63lMrRrDDU0qhDAUC6b
         HuVw==
X-Gm-Message-State: APjAAAUWGJrIA6VCDF0WbPVIeuOMOWap0SRwXgJxyh9MELADhFWVZx9A
        qfjEqbraOw5V/Bdz3YvR1ws=
X-Google-Smtp-Source: APXvYqzbpu3kVYNUDDAXxV+dNYJGnZMcPvxxEVAAIi6y9bRvr28PjCrHtWzjJfI+1O7EG2m0xfkNRQ==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr19909838wmk.88.1565022983407;
        Mon, 05 Aug 2019 09:36:23 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id v65sm99792928wme.31.2019.08.05.09.36.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 09:36:22 -0700 (PDT)
Date:   Mon, 5 Aug 2019 09:36:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] btrfs: Hook btrfs' DRW lock to locktorture
 infrastructure
Message-ID: <20190805163621.GA94502@archlinux-threadripper>
References: <20190719083949.5351-1-nborisov@suse.com>
 <20190719084808.5877-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719084808.5877-1-nborisov@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 19, 2019 at 11:48:08AM +0300, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> Hello Paul, 
> 
> Here is the code I used to test the DRW lock via the lock torture infrastructure. 
> It's rather ugly but got the job done for me. It's definitely not in a mergeable
> form. At the very least I think including btrfs headers constitutes a violation 
> of separation of different subsystems. Would it be acceptable to guard them 
> behind something like "#if BTRFS && BTRFS_DEBUG" ? 
> 
> I'm really posting this just for posterity/provenance purposes. I'm fine with 
> dropping the patch. 
> 
> 
>  fs/btrfs/locking.h           |  1 +
>  kernel/locking/locktorture.c | 77 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
> index 44378c65f843..27627d4fd3a9 100644
> --- a/fs/btrfs/locking.h
> +++ b/fs/btrfs/locking.h
> @@ -9,6 +9,7 @@
>  #include <linux/atomic.h>
>  #include <linux/wait.h>
>  #include <linux/percpu_counter.h>
> +#include "extent_io.h"
>  
>  #define BTRFS_WRITE_LOCK 1
>  #define BTRFS_READ_LOCK 2
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 80a463d31a8d..774e10a25876 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -30,6 +30,8 @@
>  #include <linux/slab.h>
>  #include <linux/percpu-rwsem.h>
>  #include <linux/torture.h>
> +#include "../../fs/btrfs/ctree.h"
> +#include "../../fs/btrfs/locking.h"
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
> @@ -85,6 +87,7 @@ struct lock_torture_ops {
>  
>  	unsigned long flags; /* for irq spinlocks */
>  	const char *name;
> +	bool multiple;
>  };
>  
>  struct lock_torture_cxt {
> @@ -600,6 +603,7 @@ static void torture_percpu_rwsem_up_read(void) __releases(pcpu_rwsem)
>  	percpu_up_read(&pcpu_rwsem);
>  }
>  
> +
>  static struct lock_torture_ops percpu_rwsem_lock_ops = {
>  	.init		= torture_percpu_rwsem_init,
>  	.writelock	= torture_percpu_rwsem_down_write,
> @@ -612,6 +616,76 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
>  	.name		= "percpu_rwsem_lock"
>  };
>  
> +static struct btrfs_drw_lock torture_drw_lock;
> +
> +void torture_drw_init(void)
> +{
> +	BUG_ON(btrfs_drw_lock_init(&torture_drw_lock));
> +}
> +
> +static int torture_drw_write_lock(void) __acquires(torture_drw_lock)
> +{
> +	btrfs_drw_write_lock(&torture_drw_lock);
> +	return 0;
> +}
> +
> +static void torture_drw_write_unlock(void) __releases(torture_drw_lock)
> +{
> +	btrfs_drw_write_unlock(&torture_drw_lock);
> +}
> +
> +static int torture_drw_read_lock(void) __acquires(torture_drw_lock)
> +{
> +	btrfs_drw_read_lock(&torture_drw_lock);
> +	return 0;
> +}
> +
> +static void torture_drw_read_unlock(void) __releases(torture_drw_lock)
> +{
> +	btrfs_drw_read_unlock(&torture_drw_lock);
> +}
> +
> +static void torture_drw_write_delay(struct torture_random_state *trsp)
> +{
> +	const unsigned long longdelay_ms = 100;
> +
> +	/* We want a long delay occasionally to force massive contention.  */
> +	if (!(torture_random(trsp) %
> +	      (cxt.nrealwriters_stress * 2000 * longdelay_ms)))
> +		mdelay(longdelay_ms * 10);
> +	else
> +		mdelay(longdelay_ms / 10);
> +	if (!(torture_random(trsp) % (cxt.nrealwriters_stress * 20000)))
> +		torture_preempt_schedule();  /* Allow test to be preempted. */
> +}
> +
> +static void torture_drw_read_delay(struct torture_random_state *trsp)
> +{
> +	const unsigned long longdelay_ms = 100;
> +
> +	/* We want a long delay occasionally to force massive contention.  */
> +	if (!(torture_random(trsp) %
> +	      (cxt.nrealreaders_stress * 2000 * longdelay_ms)))
> +		mdelay(longdelay_ms * 2);
> +	else
> +		mdelay(longdelay_ms / 2);
> +	if (!(torture_random(trsp) % (cxt.nrealreaders_stress * 20000)))
> +		torture_preempt_schedule();  /* Allow test to be preempted. */
> +}
> +
> +static struct lock_torture_ops btrfs_drw_lock_ops = {
> +	.init		= torture_drw_init,
> +	.writelock	= torture_drw_write_lock,
> +	.write_delay	= torture_drw_write_delay,
> +	.task_boost     = torture_boost_dummy,
> +	.writeunlock	= torture_drw_write_unlock,
> +	.readlock       = torture_drw_read_lock,
> +	.read_delay     = torture_drw_read_delay, /* figure what to do with this */
> +	.readunlock     = torture_drw_read_unlock,
> +	.multiple = true,
> +	.name		= "btrfs_drw_lock"
> +};
> +
>  /*
>   * Lock torture writer kthread.  Repeatedly acquires and releases
>   * the lock, checking for duplicate acquisitions.
> @@ -630,7 +704,7 @@ static int lock_torture_writer(void *arg)
>  
>  		cxt.cur_ops->task_boost(&rand);
>  		cxt.cur_ops->writelock();
> -		if (WARN_ON_ONCE(lock_is_write_held))
> +		if (!cxt.cur_ops->multiple && WARN_ON_ONCE(lock_is_write_held))
>  			lwsp->n_lock_fail++;
>  		lock_is_write_held = 1;
>  		if (WARN_ON_ONCE(lock_is_read_held))
> @@ -852,6 +926,7 @@ static int __init lock_torture_init(void)
>  #endif
>  		&rwsem_lock_ops,
>  		&percpu_rwsem_lock_ops,
> +		&btrfs_drw_lock_ops
>  	};
>  
>  	if (!torture_init_begin(torture_type, verbose))
> -- 
> 2.17.1
> 

Looks like this is in next-20190805 and causes a link time error when
CONFIG_BTRFS_FS is unset:

  LD      vmlinux.o
  MODPOST vmlinux.o
  MODINFO modules.builtin.modinfo
ld.lld: error: undefined symbol: btrfs_drw_lock_init
>>> referenced by locktorture.c
>>>               locking/locktorture.o:(torture_drw_init) in archive kernel/built-in.a

ld.lld: error: undefined symbol: btrfs_drw_write_lock
>>> referenced by locktorture.c
>>>               locking/locktorture.o:(torture_drw_write_lock) in archive kernel/built-in.a

ld.lld: error: undefined symbol: btrfs_drw_write_unlock
>>> referenced by locktorture.c
>>>               locking/locktorture.o:(torture_drw_write_unlock) in archive kernel/built-in.a

ld.lld: error: undefined symbol: btrfs_drw_read_lock
>>> referenced by locktorture.c
>>>               locking/locktorture.o:(torture_drw_read_lock) in archive kernel/built-in.a

ld.lld: error: undefined symbol: btrfs_drw_read_unlock
>>> referenced by locktorture.c
>>>               locking/locktorture.o:(torture_drw_read_unlock) in archive kernel/built-in.a

If this commit is to remain around, there should probably be static
inline stubs in fs/btrfs/locking.h. Apologies if this has already been
reported, I still see the commit in the btrfs for-next branch.

Cheers,
Nathan
