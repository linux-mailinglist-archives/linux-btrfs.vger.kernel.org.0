Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98B578D8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbfG2ONq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 10:13:46 -0400
Received: from foss.arm.com ([217.140.110.172]:44858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387538AbfG2ONq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 10:13:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E5F428;
        Mon, 29 Jul 2019 07:13:45 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94F523F71F;
        Mon, 29 Jul 2019 07:13:44 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Refactor snapshot vs nocow writers locking
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     paulmck@linux.ibm.com, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20190719083949.5351-1-nborisov@suse.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ed015bb1-490e-7102-d172-73c1d069476c@arm.com>
Date:   Mon, 29 Jul 2019 15:13:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719083949.5351-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

On 19/07/2019 09:39, Nikolay Borisov wrote:
> Hello, 
> 
> Here is the second version of the DRW lock for btrfs. Main changes from v1: 
> 
> * Fixed all checkpatch warnings (Andrea Parri)
> * Properly call write_unlock in btrfs_drw_try_write_lock (Filipe Manana)
> * Comment fix. 
> * Stress tested it via locktorture. Survived for 8 straight days on a 4 socket
> 48 thread machine.
> 
> I have also produced a PlusCal specification which I'd be happy to discuss with 
> people since I'm new to formal specification and I seem it doesn't have the 
> right fidelity: 
> 

I haven't played with PlusCal in a while but I figured I'd have a go at it
anyway. I've also Cc'd Catalin who's my local TLA+/PCal guru.


FYI PlusCal also supports a C-like syntax, which means you can use glorious
brackets instead of begin/end (unless you prefer those... I won't judge).

I appended my "clean-up" of your spec - mainly changed to C-style
syntax, added a few more constant definitions, and split the locker
process into separate reader and writer processes. IMO makes it more
readable.

> ---- MODULE specs ----
> EXTENDS Integers, Sequences, TLC
> 
> CONSTANT NumLockers
> 
> ASSUME NumLockers > 0
> 
> (*--algorithm DRW
> 
> variables
>     lock_state = "idle",
>     states = {"idle", "write_locked", "read_locked", "read_waiting", "write_waiting"},
>     threads = [thread \in 1..NumLockers |-> "idle" ] \* everyone is in idle state at first, this generates a tuple
> 
> define
> INV_SingleLockerType  == \/ lock_state = "write_locked" /\ ~\E thread \in 1..Len(threads): threads[thread] = "read_locked"
>                          \/ lock_state = "read_locked" /\ ~\E thread \in 1..Len(threads): threads[thread] = "write_locked"
>                          \/ lock_state = "idle" /\ \A thread \in 1..Len(threads): threads[thread] = "idle"

I've tried to think about liveness properties we would want to check
against this spec, but the usual ones don't really work there: AFAICT
there is no fairness there, readers can completely block writers (and
the opposite is true as well).

TLC checks for deadlocks by default (IIRC that should translate to always
having > 1 non-stuttering step enabled in the next-state formula), so
maybe that is all we need?

> end define;
> 
> macro ReadLock(tid) begin
>     if lock_state = "idle" \/ lock_state = "read_locked" then
>         lock_state := "read_locked";
>         threads[tid] := "read_locked";
>     else
>         assert lock_state = "write_locked";
>         threads[tid] := "write_waiting"; \* waiting for writers to finish
>         await lock_state = "" \/ lock_state = "read_locked";
                             ^^
That's not a valid lock state, was that meant to be "idle"? 

BTW your spec doesn't have a type check invariant (something to make sure
whatever is in your variables is sane). It seems to be common practice, and
it's quite handy to spot stupid mistakes. For this spec it would look
something like this:

LOCK_STATES == {"idle", "write_locked", "read_locked"}
THREAD_STATES == LOCK_STATES \union {"read_waiting", "write_waiting"}

TypeCheck ==
    /\ lock_state \in LOCK_STATES
    /\ \A thread \in THREADS: threads[thread] \in THREAD_STATES

>     end if;
> 
> end macro;
> 
> macro WriteLock(tid) begin
>     if lock_state = "idle" \/ lock_state = "write_locked" then
>         lock_state := "write_locked";
>         threads[tid] := "write_locked";
>     else
>         assert lock_state = "read_locked";
>         threads[tid] := "reader_waiting"; \* waiting for readers to finish
>         await lock_state = "idle" \/ lock_state = "write_locked";

Aren't we missing an extra action here (same goes for the read lock)?

threads[tid] should be set to "write_locked", and lock_state should be
updated if it was previously "idle".

Now the nasty thing is that we'd be setting threads[tid] to two different
values in the same atomic block, so PlusCal will complain and we'll have
to add some labels (which means changing the macro into a procedure).

Maybe something like this?

procedure WriteLock()
{
prepare:
    \* waiting for readers to finish
    threads[self] := "read_waiting";
lock:
    await lock_state = "idle" \/ lock_state = "write_locked";
    lock_state := "write_locked";
    threads[self] := "write_locked";
    return;
};

+ something similar for ReadLock().

Alternatively the "prepare" step could be some counter increment, to more
closely mimic the actual implementation, but I don't think it adds much
value to the model.

---------------------------------------------------------------------------

specs.tla:

---- MODULE specs ----
EXTENDS Integers, Sequences, TLC

CONSTANTS
    NR_WRITERS,
    NR_READERS,
    WRITER_TASK,
    READER_TASK

WRITERS == {WRITER_TASK} \X (1..NR_WRITERS)
READERS == {READER_TASK} \X (1..NR_READERS)
THREADS == WRITERS \union READERS

(*--algorithm DRW {

variables
    lock_state = "idle",
    \* everyone is in idle state at first, this generates a tuple
    threads = [thread \in THREADS |-> "idle" ]

define {

LOCK_STATES == {"idle", "write_locked", "read_locked"}
THREAD_STATES == LOCK_STATES \union {"read_waiting", "write_waiting"}

(* Safety invariants *)
TypeCheck ==
    /\ lock_state \in LOCK_STATES
    /\ \A thread \in THREADS: threads[thread] \in THREAD_STATES

NoReadWhenWrite ==
    lock_state = "write_locked" =>
        \A thread \in THREADS: threads[thread] # "read_locked"

NoWriteWhenRead ==
    lock_state = "read_locked" =>
        \A thread \in THREADS: threads[thread] # "write_locked"

AllIdleWhenIdle ==
    lock_state = "idle" =>
        \A thread \in THREADS: threads[thread] = "idle"

(* Ensure critical section exclusiveness *)
Exclusion ==
    /\ \E writer \in WRITERS: pc[writer] = "write_cs" =>
        \A reader \in READERS: pc[reader] # "read_cs"
    /\ \E reader \in READERS: pc[reader] = "read_cs" =>
        \A writer \in WRITERS: pc[writer] # "write_cs"
}

macro ReadLock(tid)
{
    if (lock_state = "idle" \/ lock_state = "read_locked") {
        lock_state := "read_locked";
        threads[tid] := "read_locked";
    } else {
        assert lock_state = "write_locked";
        \* waiting for writers to finish
        threads[tid] := "write_waiting";
        await lock_state = "" \/ lock_state = "read_locked";
    };
}

macro WriteLock(tid)
{
    if (lock_state = "idle" \/ lock_state = "write_locked") {
        lock_state := "write_locked";
        threads[tid] := "write_locked";
    } else {
        assert lock_state = "read_locked";
        \* waiting for readers to finish
        threads[tid] := "read_waiting";
        await lock_state = "idle" \/ lock_state = "write_locked";
    };
}

macro ReadUnlock(tid) {
    if (threads[tid] = "read_locked") {
        threads[tid] := "idle";
        if (\A thread \in THREADS: threads[thread] # "read_locked") {
            \* we were the last read holder, everyone else should be waiting, unlock the lock
            lock_state := "idle";
        };
    };
}

macro WriteUnlock(tid) {
    if (threads[tid] = "write_locked") {
        threads[tid] := "idle";
        if (\A thread \in THREADS: threads[thread] # "write_locked") {
            \* we were the last write holder, everyone else should be waiting, unlock the lock
            lock_state := "idle";
        };
    };
}

fair process(writer \in WRITERS)
{
loop:
    while (TRUE) {
        WriteLock(self);
write_cs:
        skip;
unlock:
        WriteUnlock(self);
    };
}

fair process(reader \in READERS)
{
loop:
    while (TRUE) {
        ReadLock(self);
read_cs:
        skip;
unlock:
        ReadUnlock(self);
    };

}

}*)
====

specs.cfg:

SPECIFICATION Spec
\* Add statements after this line.

CONSTANTS
	NR_READERS = 3
	NR_WRITERS = 3
	READER_TASK = reader
	WRITER_TASK = writer

INVARIANTS
	TypeCheck
	
	NoReadWhenWrite
	NoWriteWhenRead
	AllIdleWhenIdle
	
	Exclusion
