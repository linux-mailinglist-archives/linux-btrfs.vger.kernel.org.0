Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C687A7D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfG3MLu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 08:11:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfG3MLu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 08:11:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9961AC8E;
        Tue, 30 Jul 2019 12:11:48 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] Refactor snapshot vs nocow writers locking
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     andrea.parri@amarulasolutions.com, paulmck@linux.ibm.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190719083949.5351-1-nborisov@suse.com>
 <ed015bb1-490e-7102-d172-73c1d069476c@arm.com>
 <20190729153319.GH2368@arrakis.emea.arm.com>
 <60eda0ab-08b3-de82-5b06-98386ee1928f@arm.com>
 <69ef76a2-ebd6-956e-c611-2e742606ed95@arm.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <356e1044-b676-1028-3b80-a922acfae5b2@suse.com>
Date:   Tue, 30 Jul 2019 15:11:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <69ef76a2-ebd6-956e-c611-2e742606ed95@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.07.19 г. 14:03 ч., Valentin Schneider wrote:
> On 29/07/2019 17:32, Valentin Schneider wrote:
>> On 29/07/2019 16:33, Catalin Marinas wrote:
> [...]
>>> I'd say that's one of the pitfalls of PlusCal. The above is executed
>>> atomically, so you'd have the lock_state read and updated in the same
>>> action. Looking at the C patches, there is an
>>> atomic_read(&lock->readers) followed by a
>>> percpu_counter_inc(&lock->writers). Between these two, you can have
>>> "readers" becoming non-zero via a different CPU.
>>>
>>> My suggestion would be to use procedures with labels to express the
>>> non-atomicity of such sequences.
>>>
>>
> 
> FYI, with a very simple and stupid modification of the spec:
> 
> ----->8-----
> macro ReadUnlock()
> {
>     reader_count := reader_count - 1;
>     \* Condition variable signal is "implicit" here
> }
> 
> macro WriteUnlock()
> {
>     writer_count := writer_count - 1;
>     \* Ditto on the cond var
> }
> 
> procedure ReadLock()
> {
> add:
>     reader_count := reader_count + 1;
> lock:
>     await writer_count = 0;
>     return;
> }
> 
> procedure WriteLock()
> {
> add:
>     writer_count := writer_count + 1;
> lock:
>     await reader_count = 0;
>     return;
> };
> -----8<-----
> 
> it's quite easy to trigger the case Paul pointed out in [1]:

Yes, however, there was a bug in the original posting, in that
btrfs_drw_try_write_lock should have called btrfs_drw_write_unlock
instead of btrfs_drw_read_unlock if it sees that readers incremented
while it has already incremented its percpu counter.

Additionally the implementation doesn't await with the respective
variable incremented. Is there a way to express something along the
lines of :


> procedure WriteLock()
> {
> add:
>     writer_count := writer_count + 1;
> lock:
>     await reader_count = 0;

If we are about to wait then also decrement writer_count?  I guess the
correct way to specify it would be:

procedure WriteLock()
 {

     writer_count := writer_count + 1;
     await reader_count = 0;
     return;
 };


Because the implementation (by using barriers and percpu counters
ensures all of this happens as one atomic step?) E.g. before going to
sleep we decrement the write unlock.

>     return;
> };

> 
> ----->8-----
> Error: Deadlock reached.
> Error: The behavior up to this point is:
> State 1: <Initial predicate>
> /\ stack = (<<reader, 1>> :> <<>> @@ <<writer, 1>> :> <<>>)
> /\ pc = (<<reader, 1>> :> "loop" @@ <<writer, 1>> :> "loop_")
> /\ writer_count = 0
> /\ reader_count = 0
> /\ lock_state = "idle"
> 
> State 2: <loop_ line 159, col 16 to line 164, col 72 of module specs>
> /\ stack = ( <<reader, 1>> :> <<>> @@
>   <<writer, 1>> :> <<[pc |-> "write_cs", procedure |-> "WriteLock"]>> )
> /\ pc = (<<reader, 1>> :> "loop" @@ <<writer, 1>> :> "add")
> /\ writer_count = 0
> /\ reader_count = 0
> /\ lock_state = "idle"
> 
> State 3: <add line 146, col 14 to line 149, col 63 of module specs>
> /\ stack = ( <<reader, 1>> :> <<>> @@
>   <<writer, 1>> :> <<[pc |-> "write_cs", procedure |-> "WriteLock"]>> )
> /\ pc = (<<reader, 1>> :> "loop" @@ <<writer, 1>> :> "lock")
> /\ writer_count = 1
> /\ reader_count = 0
> /\ lock_state = "idle"
> 
> State 4: <loop line 179, col 15 to line 184, col 71 of module specs>
> /\ stack = ( <<reader, 1>> :> <<[pc |-> "read_cs", procedure |-> "ReadLock"]>> @@
>   <<writer, 1>> :> <<[pc |-> "write_cs", procedure |-> "WriteLock"]>> )
> /\ pc = (<<reader, 1>> :> "add_" @@ <<writer, 1>> :> "lock")
> /\ writer_count = 1
> /\ reader_count = 0
> /\ lock_state = "idle"
> 
> State 5: <add_ line 133, col 15 to line 136, col 64 of module specs>
> /\ stack = ( <<reader, 1>> :> <<[pc |-> "read_cs", procedure |-> "ReadLock"]>> @@
>   <<writer, 1>> :> <<[pc |-> "write_cs", procedure |-> "WriteLock"]>> )
> /\ pc = (<<reader, 1>> :> "lock_" @@ <<writer, 1>> :> "lock")
> /\ writer_count = 1
> /\ reader_count = 1
> /\ lock_state = "idle"
> -----8<-----
> 
> Which I think is pretty cool considering the effort that was required
> (read: not much).
> 
> [1]: https://lore.kernel.org/lkml/20190607105251.GB28207@linux.ibm.com/
> 
