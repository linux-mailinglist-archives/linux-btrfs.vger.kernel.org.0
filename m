Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7E73A099
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2019 18:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfFHQG0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Jun 2019 12:06:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727165AbfFHQGZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 Jun 2019 12:06:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x58FuxFH096979
        for <linux-btrfs@vger.kernel.org>; Sat, 8 Jun 2019 12:06:23 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t075xxgwm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Jun 2019 12:06:23 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-btrfs@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 8 Jun 2019 17:06:23 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Jun 2019 17:06:19 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x58G6I3833751312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jun 2019 16:06:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADEABB2068;
        Sat,  8 Jun 2019 16:06:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CBCAB2067;
        Sat,  8 Jun 2019 16:06:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.180.36])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  8 Jun 2019 16:06:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4E3C016C5D71; Sat,  8 Jun 2019 09:06:20 -0700 (PDT)
Date:   Sat, 8 Jun 2019 09:06:20 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org
Subject: Re: [PATCH 1/2] btrfs: Implement DRW lock
Reply-To: paulmck@linux.ibm.com
References: <20190606135219.1086-1-nborisov@suse.com>
 <20190606135219.1086-2-nborisov@suse.com>
 <20190607105251.GB28207@linux.ibm.com>
 <7a1c1f42-6e2f-57fc-5cdd-8c2bea23dffa@suse.com>
 <20190608151345.GC28207@linux.ibm.com>
 <4e3d5950-027d-c581-2bff-26602ca63521@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e3d5950-027d-c581-2bff-26602ca63521@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060816-2213-0000-0000-0000039BF844
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011234; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01215065; UDB=6.00638761; IPR=6.00996157;
 MB=3.00027235; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-08 16:06:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060816-2214-0000-0000-00005EC5FFEE
Message-Id: <20190608160620.GH28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906080120
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 08, 2019 at 06:44:17PM +0300, Nikolay Borisov wrote:
> On 8.06.19 г. 18:13 ч., Paul E. McKenney wrote:
> > On Fri, Jun 07, 2019 at 02:59:34PM +0300, Nikolay Borisov wrote:
> >> On 7.06.19 г. 13:52 ч., Paul E. McKenney wrote:
> >>> On Thu, Jun 06, 2019 at 04:52:18PM +0300, Nikolay Borisov wrote:
> >>>> A (D)ouble (R)eader (W)riter lock is a locking primitive that allows
> >>>> to have multiple readers or multiple writers but not multiple readers
> >>>> and writers holding it concurrently. The code is factored out from
> >>>> the existing open-coded locking scheme used to exclude pending
> >>>> snapshots from nocow writers and vice-versa. Current implementation
> >>>> actually favors Readers (that is snapshot creaters) to writers (nocow
> >>>> writers of the filesystem).
> >>>>
> >>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >>>
> >>> A preliminary question...
> >>>
> >>> What prevents the following sequence of events from happening?
> >>>
> >>> o	btrfs_drw_write_lock() invokes btrfs_drw_try_write_lock(),
> >>> 	which sees that lock->readers is zero and thus executes
> >>> 	percpu_counter_inc(&lock->writers).
> >>>
> >>> o	btrfs_drw_read_lock() increments lock->readers, does the
> >>> 	smp_mb__after_atomic(), and then does the wait_event().
> >>> 	Because btrfs_drw_try_write_lock() incremented its CPU's
> >>> 	lock->writers, the sum is the value one, so it blocks.
> >>>
> >>> o	btrfs_drw_try_write_lock() checks lock->readers, sees that
> >>> 	it is now nonzero, and thus invokes btrfs_drw_read_unlock()
> >>> 	(which decrements the current CPU's counter, so that a future
> >>> 	sum would get zero), and returns false.
> >>
> >> btrfs_drw_read_unlock is actually btrfs_drw_write_unlock, my bad, Filipe
> >> already pointed that out and I've fixed it.
> > 
> > Ah!  I must then ask what you are using to test this.  kernel/locktorture.c?

Right...  Make that kernel/locking/locktorture.c

> At the moment - nothing. I rely on the fact that the original code I
> extracted that from is bug-free (ha-ha). So perhahps hooking up
> locktorture seems like a good suggestion. From a quick look I guess I
> could mostly model that lock against the rwsem. The question is how do I
> model the trylock semantics as well as the "double" part?

Implementing a correct synchronization primitive is like committing the
perfect crime.  There are at least 50 things that can go wrong, and if
you are a highly experienced genius, you -might- be able to anticipate
and handle 25 of them.  (With apologies to any Kathleen Turner fans who
might still be alive.)  Please note that this still applies to code
ported from somewhere else because different environments likely have
different assumptions and properties.

Therefore, heavy-duty stress testing is not optional.  In fact, formal
verification is becoming non-optional as well -- please see Catalin
Marinas's work on verifying the Linux kernel's queued spinlock for
an example.

You are right, current locktorture would get upset about having concurrent
writers.  To teach locktorture about this, I suggest adding a flag to
the lock_torture_ops structure named something like concurrent_write,
but hopefully shorter.  Then this flag can be used to disable the "only
one writer" check in lock_torture_writer().

Seem reasonable?

							Thanx, Paul

> >> The idea here is that if a reader came after we've incremented out
> >> percpu counter then it would have blocked, the writer would see that and
> >> invoke btrfs_drw_write_unlock which will decrement the percpu counter
> >> and will wakeup the reader that is now blocked on pending_readers.
> > 
> > OK, I will await your next version.
> > 
> > 							Thanx, Paul
> > 
> >>> o	btrfs_drw_write_lock() therefore does its wait_event().
> >>> 	Because lock->readers is nonzero, it blocks.
> >>>
> >>> o	Both tasks are now blocked.  In the absence of future calls
> >>> 	to these functions (and perhaps even given such future calls),
> >>> 	we have deadlock.
> >>>
> >>> So what am I missing here?
> >>>
> >>> 							Thanx, Paul
> >>>
> >>>> ---
> >>>>  fs/btrfs/Makefile   |  2 +-
> >>>>  fs/btrfs/drw_lock.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
> >>>>  fs/btrfs/drw_lock.h | 23 +++++++++++++++
> >>>>  3 files changed, 95 insertions(+), 1 deletion(-)
> >>>>  create mode 100644 fs/btrfs/drw_lock.c
> >>>>  create mode 100644 fs/btrfs/drw_lock.h
> >>>>
> >>>> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> >>>> index ca693dd554e9..dc60127791e6 100644
> >>>> --- a/fs/btrfs/Makefile
> >>>> +++ b/fs/btrfs/Makefile
> >>>> @@ -10,7 +10,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
> >>>>  	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
> >>>>  	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
> >>>>  	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
> >>>> -	   uuid-tree.o props.o free-space-tree.o tree-checker.o
> >>>> +	   uuid-tree.o props.o free-space-tree.o tree-checker.o drw_lock.o
> >>>>  
> >>>>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
> >>>>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
> >>>> diff --git a/fs/btrfs/drw_lock.c b/fs/btrfs/drw_lock.c
> >>>> new file mode 100644
> >>>> index 000000000000..9681bf7544be
> >>>> --- /dev/null
> >>>> +++ b/fs/btrfs/drw_lock.c
> >>>> @@ -0,0 +1,71 @@
> >>>> +#include "drw_lock.h"
> >>>> +#include "ctree.h"
> >>>> +
> >>>> +void btrfs_drw_lock_init(struct btrfs_drw_lock *lock)
> >>>> +{
> >>>> +	atomic_set(&lock->readers, 0);
> >>>> +	percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
> >>>> +	init_waitqueue_head(&lock->pending_readers);
> >>>> +	init_waitqueue_head(&lock->pending_writers);
> >>>> +}
> >>>> +
> >>>> +void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock)
> >>>> +{
> >>>> +	percpu_counter_destroy(&lock->writers);
> >>>> +}
> >>>> +
> >>>> +bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock)
> >>>> +{
> >>>> +	if (atomic_read(&lock->readers))
> >>>> +		return false;
> >>>> +
> >>>> +	percpu_counter_inc(&lock->writers);
> >>>> +
> >>>> +	/*
> >>>> +	 * Ensure writers count is updated before we check for
> >>>> +	 * pending readers
> >>>> +	 */
> >>>> +	smp_mb();
> >>>> +	if (atomic_read(&lock->readers)) {
> >>>> +		btrfs_drw_read_unlock(lock);
> >>>> +		return false;
> >>>> +	}
> >>>> +
> >>>> +	return true;
> >>>> +}
> >>>> +
> >>>> +void btrfs_drw_write_lock(struct btrfs_drw_lock *lock)
> >>>> +{
> >>>> +	while(true) {
> >>>> +		if (btrfs_drw_try_write_lock(lock))
> >>>> +			return;
> >>>> +		wait_event(lock->pending_writers, !atomic_read(&lock->readers));
> >>>> +	}
> >>>> +}
> >>>> +
> >>>> +void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock)
> >>>> +{
> >>>> +	percpu_counter_dec(&lock->writers);
> >>>> +	cond_wake_up(&lock->pending_readers);
> >>>> +}
> >>>> +
> >>>> +void btrfs_drw_read_lock(struct btrfs_drw_lock *lock)
> >>>> +{
> >>>> +	atomic_inc(&lock->readers);
> >>>> +	smp_mb__after_atomic();
> >>>> +
> >>>> +	wait_event(lock->pending_readers,
> >>>> +		   percpu_counter_sum(&lock->writers) == 0);
> >>>> +}
> >>>> +
> >>>> +void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock)
> >>>> +{
> >>>> +	/*
> >>>> +	 * Atomic RMW operations imply full barrier, so woken up writers
> >>>> +	 * are guaranteed to see the decrement
> >>>> +	 */
> >>>> +	if (atomic_dec_and_test(&lock->readers))
> >>>> +		wake_up(&lock->pending_writers);
> >>>> +}
> >>>> +
> >>>> +
> >>>> diff --git a/fs/btrfs/drw_lock.h b/fs/btrfs/drw_lock.h
> >>>> new file mode 100644
> >>>> index 000000000000..baff59561c06
> >>>> --- /dev/null
> >>>> +++ b/fs/btrfs/drw_lock.h
> >>>> @@ -0,0 +1,23 @@
> >>>> +#ifndef BTRFS_DRW_LOCK_H
> >>>> +#define BTRFS_DRW_LOCK_H
> >>>> +
> >>>> +#include <linux/atomic.h>
> >>>> +#include <linux/wait.h>
> >>>> +#include <linux/percpu_counter.h>
> >>>> +
> >>>> +struct btrfs_drw_lock {
> >>>> +	atomic_t readers;
> >>>> +	struct percpu_counter writers;
> >>>> +	wait_queue_head_t pending_writers;
> >>>> +	wait_queue_head_t pending_readers;
> >>>> +};
> >>>> +
> >>>> +void btrfs_drw_lock_init(struct btrfs_drw_lock *lock);
> >>>> +void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock);
> >>>> +void btrfs_drw_write_lock(struct btrfs_drw_lock *lock);
> >>>> +bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock);
> >>>> +void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock);
> >>>> +void btrfs_drw_read_lock(struct btrfs_drw_lock *lock);
> >>>> +void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock);
> >>>> +
> >>>> +#endif
> >>>> -- 
> >>>> 2.17.1
> >>>>
> >>>
> >>>
> >>
> > 
> > 
> 

