Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3BB3A0A3
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2019 18:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfFHQV4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Jun 2019 12:21:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbfFHQV4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 Jun 2019 12:21:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 668C6AED0;
        Sat,  8 Jun 2019 16:21:54 +0000 (UTC)
Subject: Re: [PATCH 1/2] btrfs: Implement DRW lock
To:     paulmck@linux.ibm.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org
References: <20190606135219.1086-1-nborisov@suse.com>
 <20190606135219.1086-2-nborisov@suse.com>
 <20190607105251.GB28207@linux.ibm.com>
 <7a1c1f42-6e2f-57fc-5cdd-8c2bea23dffa@suse.com>
 <20190608151345.GC28207@linux.ibm.com>
 <4e3d5950-027d-c581-2bff-26602ca63521@suse.com>
 <20190608160620.GH28207@linux.ibm.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABtCNOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPokCOAQTAQIAIgUCWIo48QIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQcb6CRuU/KFc0eg/9GLD3wTQz9iZHMFbjiqTCitD7B6dTLV1C
 ddZVlC8Hm/TophPts1bWZORAmYIihHHI1EIF19+bfIr46pvfTu0yFrJDLOADMDH+Ufzsfy2v
 HSqqWV/nOSWGXzh8bgg/ncLwrIdEwBQBN9SDS6aqsglagvwFD91UCg/TshLlRxD5BOnuzfzI
 Leyx2c6YmH7Oa1R4MX9Jo79SaKwdHt2yRN3SochVtxCyafDlZsE/efp21pMiaK1HoCOZTBp5
 VzrIP85GATh18pN7YR9CuPxxN0V6IzT7IlhS4Jgj0NXh6vi1DlmKspr+FOevu4RVXqqcNTSS
 E2rycB2v6cttH21UUdu/0FtMBKh+rv8+yD49FxMYnTi1jwVzr208vDdRU2v7Ij/TxYt/v4O8
 V+jNRKy5Fevca/1xroQBICXsNoFLr10X5IjmhAhqIH8Atpz/89ItS3+HWuE4BHB6RRLM0gy8
 T7rN6ja+KegOGikp/VTwBlszhvfLhyoyjXI44Tf3oLSFM+8+qG3B7MNBHOt60CQlMkq0fGXd
 mm4xENl/SSeHsiomdveeq7cNGpHi6i6ntZK33XJLwvyf00PD7tip/GUj0Dic/ZUsoPSTF/mG
 EpuQiUZs8X2xjK/AS/l3wa4Kz2tlcOKSKpIpna7V1+CMNkNzaCOlbv7QwprAerKYywPCoOSC
 7P25Ag0EWIoHPgEQAMiUqvRBZNvPvki34O/dcTodvLSyOmK/MMBDrzN8Cnk302XfnGlW/YAQ
 csMWISKKSpStc6tmD+2Y0z9WjyRqFr3EGfH1RXSv9Z1vmfPzU42jsdZn667UxrRcVQXUgoKg
 QYx055Q2FdUeaZSaivoIBD9WtJq/66UPXRRr4H/+Y5FaUZx+gWNGmBT6a0S/GQnHb9g3nonD
 jmDKGw+YO4P6aEMxyy3k9PstaoiyBXnzQASzdOi39BgWQuZfIQjN0aW+Dm8kOAfT5i/yk59h
 VV6v3NLHBjHVw9kHli3jwvsizIX9X2W8tb1SefaVxqvqO1132AO8V9CbE1DcVT8fzICvGi42
 FoV/k0QOGwq+LmLf0t04Q0csEl+h69ZcqeBSQcIMm/Ir+NorfCr6HjrB6lW7giBkQl6hhomn
 l1mtDP6MTdbyYzEiBFcwQD4terc7S/8ELRRybWQHQp7sxQM/Lnuhs77MgY/e6c5AVWnMKd/z
 MKm4ru7A8+8gdHeydrRQSWDaVbfy3Hup0Ia76J9FaolnjB8YLUOJPdhI2vbvNCQ2ipxw3Y3c
 KhVIpGYqwdvFIiz0Fej7wnJICIrpJs/+XLQHyqcmERn3s/iWwBpeogrx2Lf8AGezqnv9woq7
 OSoWlwXDJiUdaqPEB/HmGfqoRRN20jx+OOvuaBMPAPb+aKJyle8zABEBAAGJAh8EGAECAAkF
 AliKBz4CGwwACgkQcb6CRuU/KFdacg/+M3V3Ti9JYZEiIyVhqs+yHb6NMI1R0kkAmzsGQ1jU
 zSQUz9AVMR6T7v2fIETTT/f5Oout0+Hi9cY8uLpk8CWno9V9eR/B7Ifs2pAA8lh2nW43FFwp
 IDiSuDbH6oTLmiGCB206IvSuaQCp1fed8U6yuqGFcnf0ZpJm/sILG2ECdFK9RYnMIaeqlNQm
 iZicBY2lmlYFBEaMXHoy+K7nbOuizPWdUKoKHq+tmZ3iA+qL5s6Qlm4trH28/fPpFuOmgP8P
 K+7LpYLNSl1oQUr+WlqilPAuLcCo5Vdl7M7VFLMq4xxY/dY99aZx0ZJQYFx0w/6UkbDdFLzN
 upT7NIN68lZRucImffiWyN7CjH23X3Tni8bS9ubo7OON68NbPz1YIaYaHmnVQCjDyDXkQoKC
 R82Vf9mf5slj0Vlpf+/Wpsv/TH8X32ajva37oEQTkWNMsDxyw3aPSps6MaMafcN7k60y2Wk/
 TCiLsRHFfMHFY6/lq/c0ZdOsGjgpIK0G0z6et9YU6MaPuKwNY4kBdjPNBwHreucrQVUdqRRm
 RcxmGC6ohvpqVGfhT48ZPZKZEWM+tZky0mO7bhZYxMXyVjBn4EoNTsXy1et9Y1dU3HVJ8fod
 5UqrNrzIQFbdeM0/JqSLrtlTcXKJ7cYFa9ZM2AP7UIN9n1UWxq+OPY9YMOewVfYtL8M=
Message-ID: <c15d367e-3423-20cf-5778-3ce65df6fba9@suse.com>
Date:   Sat, 8 Jun 2019 19:21:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608160620.GH28207@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8.06.19 г. 19:06 ч., Paul E. McKenney wrote:
> On Sat, Jun 08, 2019 at 06:44:17PM +0300, Nikolay Borisov wrote:
>> On 8.06.19 г. 18:13 ч., Paul E. McKenney wrote:
>>> On Fri, Jun 07, 2019 at 02:59:34PM +0300, Nikolay Borisov wrote:
>>>> On 7.06.19 г. 13:52 ч., Paul E. McKenney wrote:
>>>>> On Thu, Jun 06, 2019 at 04:52:18PM +0300, Nikolay Borisov wrote:
>>>>>> A (D)ouble (R)eader (W)riter lock is a locking primitive that allows
>>>>>> to have multiple readers or multiple writers but not multiple readers
>>>>>> and writers holding it concurrently. The code is factored out from
>>>>>> the existing open-coded locking scheme used to exclude pending
>>>>>> snapshots from nocow writers and vice-versa. Current implementation
>>>>>> actually favors Readers (that is snapshot creaters) to writers (nocow
>>>>>> writers of the filesystem).
>>>>>>
>>>>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>>>>
>>>>> A preliminary question...
>>>>>
>>>>> What prevents the following sequence of events from happening?
>>>>>
>>>>> o	btrfs_drw_write_lock() invokes btrfs_drw_try_write_lock(),
>>>>> 	which sees that lock->readers is zero and thus executes
>>>>> 	percpu_counter_inc(&lock->writers).
>>>>>
>>>>> o	btrfs_drw_read_lock() increments lock->readers, does the
>>>>> 	smp_mb__after_atomic(), and then does the wait_event().
>>>>> 	Because btrfs_drw_try_write_lock() incremented its CPU's
>>>>> 	lock->writers, the sum is the value one, so it blocks.
>>>>>
>>>>> o	btrfs_drw_try_write_lock() checks lock->readers, sees that
>>>>> 	it is now nonzero, and thus invokes btrfs_drw_read_unlock()
>>>>> 	(which decrements the current CPU's counter, so that a future
>>>>> 	sum would get zero), and returns false.
>>>>
>>>> btrfs_drw_read_unlock is actually btrfs_drw_write_unlock, my bad, Filipe
>>>> already pointed that out and I've fixed it.
>>>
>>> Ah!  I must then ask what you are using to test this.  kernel/locktorture.c?
> 
> Right...  Make that kernel/locking/locktorture.c
> 
>> At the moment - nothing. I rely on the fact that the original code I
>> extracted that from is bug-free (ha-ha). So perhahps hooking up
>> locktorture seems like a good suggestion. From a quick look I guess I
>> could mostly model that lock against the rwsem. The question is how do I
>> model the trylock semantics as well as the "double" part?
> 
> Implementing a correct synchronization primitive is like committing the
> perfect crime.  There are at least 50 things that can go wrong, and if
> you are a highly experienced genius, you -might- be able to anticipate
> and handle 25 of them.  (With apologies to any Kathleen Turner fans who
> might still be alive.)  Please note that this still applies to code
> ported from somewhere else because different environments likely have
> different assumptions and properties.

I agree, I'm far from thinking that the locking scheme is actually bug
free (hence the 'ha-ha') I'm not that arrogant (yet).

> 
> Therefore, heavy-duty stress testing is not optional.  In fact, formal
> verification is becoming non-optional as well -- please see Catalin
> Marinas's work on verifying the Linux kernel's queued spinlock for
> an example.

I assume you are referring to "Formal Methods for kernel hackers"? If
so, TLA+ has been on my radar ever since
https://lamport.azurewebsites.net/tla/formal-methods-amazon.pdf .

However I've yet to invest the time to be able to properly model a real
protocol (be it locking or otherwise) in it. Perhahps I could use the
DRW lock as a learning opportunity, we'll see.

> 
> You are right, current locktorture would get upset about having concurrent
> writers.  To teach locktorture about this, I suggest adding a flag to
> the lock_torture_ops structure named something like concurrent_write,
> but hopefully shorter.  Then this flag can be used to disable the "only
> one writer" check in lock_torture_writer().
> 
> Seem reasonable?

Good idea, I'll see to extending lock-torture but this will happen in a
week or so because I'm about to go on a holiday.

> 
> 							Thanx, Paul
> 
>>>> The idea here is that if a reader came after we've incremented out
>>>> percpu counter then it would have blocked, the writer would see that and
>>>> invoke btrfs_drw_write_unlock which will decrement the percpu counter
>>>> and will wakeup the reader that is now blocked on pending_readers.
>>>
>>> OK, I will await your next version.
>>>
>>> 							Thanx, Paul
>>>
>>>>> o	btrfs_drw_write_lock() therefore does its wait_event().
>>>>> 	Because lock->readers is nonzero, it blocks.
>>>>>
>>>>> o	Both tasks are now blocked.  In the absence of future calls
>>>>> 	to these functions (and perhaps even given such future calls),
>>>>> 	we have deadlock.
>>>>>
>>>>> So what am I missing here?
>>>>>
>>>>> 							Thanx, Paul
>>>>>
>>>>>> ---
>>>>>>  fs/btrfs/Makefile   |  2 +-
>>>>>>  fs/btrfs/drw_lock.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  fs/btrfs/drw_lock.h | 23 +++++++++++++++
>>>>>>  3 files changed, 95 insertions(+), 1 deletion(-)
>>>>>>  create mode 100644 fs/btrfs/drw_lock.c
>>>>>>  create mode 100644 fs/btrfs/drw_lock.h
>>>>>>
>>>>>> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
>>>>>> index ca693dd554e9..dc60127791e6 100644
>>>>>> --- a/fs/btrfs/Makefile
>>>>>> +++ b/fs/btrfs/Makefile
>>>>>> @@ -10,7 +10,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>>>>>>  	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
>>>>>>  	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
>>>>>>  	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
>>>>>> -	   uuid-tree.o props.o free-space-tree.o tree-checker.o
>>>>>> +	   uuid-tree.o props.o free-space-tree.o tree-checker.o drw_lock.o
>>>>>>  
>>>>>>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>>>>>>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
>>>>>> diff --git a/fs/btrfs/drw_lock.c b/fs/btrfs/drw_lock.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..9681bf7544be
>>>>>> --- /dev/null
>>>>>> +++ b/fs/btrfs/drw_lock.c
>>>>>> @@ -0,0 +1,71 @@
>>>>>> +#include "drw_lock.h"
>>>>>> +#include "ctree.h"
>>>>>> +
>>>>>> +void btrfs_drw_lock_init(struct btrfs_drw_lock *lock)
>>>>>> +{
>>>>>> +	atomic_set(&lock->readers, 0);
>>>>>> +	percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
>>>>>> +	init_waitqueue_head(&lock->pending_readers);
>>>>>> +	init_waitqueue_head(&lock->pending_writers);
>>>>>> +}
>>>>>> +
>>>>>> +void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock)
>>>>>> +{
>>>>>> +	percpu_counter_destroy(&lock->writers);
>>>>>> +}
>>>>>> +
>>>>>> +bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock)
>>>>>> +{
>>>>>> +	if (atomic_read(&lock->readers))
>>>>>> +		return false;
>>>>>> +
>>>>>> +	percpu_counter_inc(&lock->writers);
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Ensure writers count is updated before we check for
>>>>>> +	 * pending readers
>>>>>> +	 */
>>>>>> +	smp_mb();
>>>>>> +	if (atomic_read(&lock->readers)) {
>>>>>> +		btrfs_drw_read_unlock(lock);
>>>>>> +		return false;
>>>>>> +	}
>>>>>> +
>>>>>> +	return true;
>>>>>> +}
>>>>>> +
>>>>>> +void btrfs_drw_write_lock(struct btrfs_drw_lock *lock)
>>>>>> +{
>>>>>> +	while(true) {
>>>>>> +		if (btrfs_drw_try_write_lock(lock))
>>>>>> +			return;
>>>>>> +		wait_event(lock->pending_writers, !atomic_read(&lock->readers));
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>> +void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock)
>>>>>> +{
>>>>>> +	percpu_counter_dec(&lock->writers);
>>>>>> +	cond_wake_up(&lock->pending_readers);
>>>>>> +}
>>>>>> +
>>>>>> +void btrfs_drw_read_lock(struct btrfs_drw_lock *lock)
>>>>>> +{
>>>>>> +	atomic_inc(&lock->readers);
>>>>>> +	smp_mb__after_atomic();
>>>>>> +
>>>>>> +	wait_event(lock->pending_readers,
>>>>>> +		   percpu_counter_sum(&lock->writers) == 0);
>>>>>> +}
>>>>>> +
>>>>>> +void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock)
>>>>>> +{
>>>>>> +	/*
>>>>>> +	 * Atomic RMW operations imply full barrier, so woken up writers
>>>>>> +	 * are guaranteed to see the decrement
>>>>>> +	 */
>>>>>> +	if (atomic_dec_and_test(&lock->readers))
>>>>>> +		wake_up(&lock->pending_writers);
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>> diff --git a/fs/btrfs/drw_lock.h b/fs/btrfs/drw_lock.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..baff59561c06
>>>>>> --- /dev/null
>>>>>> +++ b/fs/btrfs/drw_lock.h
>>>>>> @@ -0,0 +1,23 @@
>>>>>> +#ifndef BTRFS_DRW_LOCK_H
>>>>>> +#define BTRFS_DRW_LOCK_H
>>>>>> +
>>>>>> +#include <linux/atomic.h>
>>>>>> +#include <linux/wait.h>
>>>>>> +#include <linux/percpu_counter.h>
>>>>>> +
>>>>>> +struct btrfs_drw_lock {
>>>>>> +	atomic_t readers;
>>>>>> +	struct percpu_counter writers;
>>>>>> +	wait_queue_head_t pending_writers;
>>>>>> +	wait_queue_head_t pending_readers;
>>>>>> +};
>>>>>> +
>>>>>> +void btrfs_drw_lock_init(struct btrfs_drw_lock *lock);
>>>>>> +void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock);
>>>>>> +void btrfs_drw_write_lock(struct btrfs_drw_lock *lock);
>>>>>> +bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock);
>>>>>> +void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock);
>>>>>> +void btrfs_drw_read_lock(struct btrfs_drw_lock *lock);
>>>>>> +void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock);
>>>>>> +
>>>>>> +#endif
>>>>>> -- 
>>>>>> 2.17.1
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 
> 
