Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72C638843
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfFGKw6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 06:52:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728121AbfFGKw6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jun 2019 06:52:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x57ApdQF038332
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jun 2019 06:52:56 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2syn3wc1h5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2019 06:52:56 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-btrfs@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 7 Jun 2019 11:52:55 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Jun 2019 11:52:53 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x57AqqjZ27197776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jun 2019 10:52:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9E49B205F;
        Fri,  7 Jun 2019 10:52:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68537B2064;
        Fri,  7 Jun 2019 10:52:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.183.181])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jun 2019 10:52:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DB9FE16C374D; Fri,  7 Jun 2019 03:52:51 -0700 (PDT)
Date:   Fri, 7 Jun 2019 03:52:51 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org
Subject: Re: [PATCH 1/2] btrfs: Implement DRW lock
Reply-To: paulmck@linux.ibm.com
References: <20190606135219.1086-1-nborisov@suse.com>
 <20190606135219.1086-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606135219.1086-2-nborisov@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060710-0052-0000-0000-000003CCBF80
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011228; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01214489; UDB=6.00638411; IPR=6.00995574;
 MB=3.00027220; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-07 10:52:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060710-0053-0000-0000-00006138BCB0
Message-Id: <20190607105251.GB28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070078
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 06, 2019 at 04:52:18PM +0300, Nikolay Borisov wrote:
> A (D)ouble (R)eader (W)riter lock is a locking primitive that allows
> to have multiple readers or multiple writers but not multiple readers
> and writers holding it concurrently. The code is factored out from
> the existing open-coded locking scheme used to exclude pending
> snapshots from nocow writers and vice-versa. Current implementation
> actually favors Readers (that is snapshot creaters) to writers (nocow
> writers of the filesystem).
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

A preliminary question...

What prevents the following sequence of events from happening?

o	btrfs_drw_write_lock() invokes btrfs_drw_try_write_lock(),
	which sees that lock->readers is zero and thus executes
	percpu_counter_inc(&lock->writers).

o	btrfs_drw_read_lock() increments lock->readers, does the
	smp_mb__after_atomic(), and then does the wait_event().
	Because btrfs_drw_try_write_lock() incremented its CPU's
	lock->writers, the sum is the value one, so it blocks.

o	btrfs_drw_try_write_lock() checks lock->readers, sees that
	it is now nonzero, and thus invokes btrfs_drw_read_unlock()
	(which decrements the current CPU's counter, so that a future
	sum would get zero), and returns false.

o	btrfs_drw_write_lock() therefore does its wait_event().
	Because lock->readers is nonzero, it blocks.

o	Both tasks are now blocked.  In the absence of future calls
	to these functions (and perhaps even given such future calls),
	we have deadlock.

So what am I missing here?

							Thanx, Paul

> ---
>  fs/btrfs/Makefile   |  2 +-
>  fs/btrfs/drw_lock.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/drw_lock.h | 23 +++++++++++++++
>  3 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 fs/btrfs/drw_lock.c
>  create mode 100644 fs/btrfs/drw_lock.h
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index ca693dd554e9..dc60127791e6 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -10,7 +10,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>  	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
>  	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
>  	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
> -	   uuid-tree.o props.o free-space-tree.o tree-checker.o
> +	   uuid-tree.o props.o free-space-tree.o tree-checker.o drw_lock.o
>  
>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
> diff --git a/fs/btrfs/drw_lock.c b/fs/btrfs/drw_lock.c
> new file mode 100644
> index 000000000000..9681bf7544be
> --- /dev/null
> +++ b/fs/btrfs/drw_lock.c
> @@ -0,0 +1,71 @@
> +#include "drw_lock.h"
> +#include "ctree.h"
> +
> +void btrfs_drw_lock_init(struct btrfs_drw_lock *lock)
> +{
> +	atomic_set(&lock->readers, 0);
> +	percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
> +	init_waitqueue_head(&lock->pending_readers);
> +	init_waitqueue_head(&lock->pending_writers);
> +}
> +
> +void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock)
> +{
> +	percpu_counter_destroy(&lock->writers);
> +}
> +
> +bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock)
> +{
> +	if (atomic_read(&lock->readers))
> +		return false;
> +
> +	percpu_counter_inc(&lock->writers);
> +
> +	/*
> +	 * Ensure writers count is updated before we check for
> +	 * pending readers
> +	 */
> +	smp_mb();
> +	if (atomic_read(&lock->readers)) {
> +		btrfs_drw_read_unlock(lock);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +void btrfs_drw_write_lock(struct btrfs_drw_lock *lock)
> +{
> +	while(true) {
> +		if (btrfs_drw_try_write_lock(lock))
> +			return;
> +		wait_event(lock->pending_writers, !atomic_read(&lock->readers));
> +	}
> +}
> +
> +void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock)
> +{
> +	percpu_counter_dec(&lock->writers);
> +	cond_wake_up(&lock->pending_readers);
> +}
> +
> +void btrfs_drw_read_lock(struct btrfs_drw_lock *lock)
> +{
> +	atomic_inc(&lock->readers);
> +	smp_mb__after_atomic();
> +
> +	wait_event(lock->pending_readers,
> +		   percpu_counter_sum(&lock->writers) == 0);
> +}
> +
> +void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock)
> +{
> +	/*
> +	 * Atomic RMW operations imply full barrier, so woken up writers
> +	 * are guaranteed to see the decrement
> +	 */
> +	if (atomic_dec_and_test(&lock->readers))
> +		wake_up(&lock->pending_writers);
> +}
> +
> +
> diff --git a/fs/btrfs/drw_lock.h b/fs/btrfs/drw_lock.h
> new file mode 100644
> index 000000000000..baff59561c06
> --- /dev/null
> +++ b/fs/btrfs/drw_lock.h
> @@ -0,0 +1,23 @@
> +#ifndef BTRFS_DRW_LOCK_H
> +#define BTRFS_DRW_LOCK_H
> +
> +#include <linux/atomic.h>
> +#include <linux/wait.h>
> +#include <linux/percpu_counter.h>
> +
> +struct btrfs_drw_lock {
> +	atomic_t readers;
> +	struct percpu_counter writers;
> +	wait_queue_head_t pending_writers;
> +	wait_queue_head_t pending_readers;
> +};
> +
> +void btrfs_drw_lock_init(struct btrfs_drw_lock *lock);
> +void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock);
> +void btrfs_drw_write_lock(struct btrfs_drw_lock *lock);
> +bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock);
> +void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock);
> +void btrfs_drw_read_lock(struct btrfs_drw_lock *lock);
> +void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock);
> +
> +#endif
> -- 
> 2.17.1
> 

