Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C6C7A9CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 15:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfG3NhC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 09:37:02 -0400
Received: from foss.arm.com ([217.140.110.172]:32820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfG3NhB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 09:37:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D84B028;
        Tue, 30 Jul 2019 06:37:00 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0729D3F694;
        Tue, 30 Jul 2019 06:36:59 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Refactor snapshot vs nocow writers locking
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        paulmck@linux.ibm.com, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org
References: <20190719083949.5351-1-nborisov@suse.com>
 <ed015bb1-490e-7102-d172-73c1d069476c@arm.com>
 <20190729153319.GH2368@arrakis.emea.arm.com>
 <60eda0ab-08b3-de82-5b06-98386ee1928f@arm.com>
 <69ef76a2-ebd6-956e-c611-2e742606ed95@arm.com>
Message-ID: <2dcaf81c-f0d3-409e-cb29-733d8b3b4cc9@arm.com>
Date:   Tue, 30 Jul 2019 14:36:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <69ef76a2-ebd6-956e-c611-2e742606ed95@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

And with a more accurate spec (appended at the end of this email):

    Model checking completed. No error has been found.
      Estimates of the probability that TLC did not check all reachable states
      because two distinct states had the same fingerprint:
      calculated (optimistic):  val = 8.6E-8
      based on the actual fingerprints:  val = 9.8E-9
    3100306 states generated, 651251 distinct states found, 0 states left on queue.

IOW, it seems fine in regards to the defined properties + the deadlock
check.

The EventuallyRead liveness property shows that a waiting reader will
always eventually get the lock (no reader starvation), of course assuming
no lock-user blocks in its critical section (i.e. no stuttering steps).

It doesn't hold for writers - they can be starved by a never-ending stream
of readers. IOW

  \* Eventually one writer gets the lock
  <> \E writer \in WRITERS: pc[writer] = "write_cs"

can be disproven by some behaviours. However,

  \* No writer ever gets the lock
  [] \A writer \in WRITERS: pc[writer] # "write_cs"

can be disproven as well - there are *some* paths that allow writers to
get the lock. I haven't found a neater way to check that other than by
having a "debug" property that I don't include in the full-fledged check.



Note that the entire content of a label is considered atomic by TLC. From
the point of view of that spec:

Read lock:
- reader count increment is atomic
- writer count read is atomic

Read unlock:
- reader count decrement is atomic
(The model's writer counter read is in the same atomic block as the
reader count decrement, but it's only used for updating a model-internal
variable, so I'm not including it here)

Write lock:
- write count increment is atomic
- reader count read is atomic
- writer count decrement is atomic

Write unlock:
- writer count increment is atomic
(ditto on the reader counter read)

This doesn't help for the placement of memory barriers, but from an
algorithm point of view that seems to be holding up.



Here's the actual spec (if I keep this up I'll get a git tree going...)
---------------------------------------------------------------------------
specs.tla:

---- MODULE specs ----
EXTENDS Integers, Sequences, FiniteSets, TLC

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
    reader_count = 0,
    writer_count = 0

define {

LOCK_STATES == {"idle", "write_locked", "read_locked"}

(* Safety invariants *)
TypeCheck ==
    /\ lock_state \in LOCK_STATES
    /\ reader_count \in (0..NR_READERS)
    /\ writer_count \in (0..NR_WRITERS)

(* Ensure critical section exclusiveness *)
Exclusion ==
    /\ \E writer \in WRITERS: pc[writer] = "write_cs" =>
        \A reader \in READERS: pc[reader] # "read_cs"
    /\ \E reader \in READERS: pc[reader] = "read_cs" =>
        \A writer \in WRITERS: pc[writer] # "write_cs"

(* Ensure the lock state is sane *)
LockState ==
    /\ lock_state = "idle" =>
        (* Not much can be said about the counts - the whole range is valid *)
        /\ \A writer \in WRITERS: pc[writer] # "write_cs"
        /\ \A reader \in READERS: pc[reader] # "read_cs"
    /\ lock_state = "read_locked" =>
        (* Some readers can still be in the locking procedure, just make sure  *)
	(* all readers in their critical section are accounted for *)
        reader_count >= Cardinality({r \in READERS: pc[r] = "read_cs"})
    /\ lock_state = "write_locked" =>
        (* Ditto for writers *)
        writer_count >= Cardinality({w \in WRITERS: pc[w] = "write_cs"})

(* Liveness properties *)

(* A waiting reader *always* eventually gets the lock *)
EventuallyRead ==
    reader_count > 0 /\ lock_state # "read_locked" ~>
        lock_state = "read_locked"

(* A waiting writer *can* eventually get the lock *)
EventuallyWrite ==
    (* TODO: find a way to express that this can be false in some behaviours *)
    (*       but has to be true in > 0 behaviours *)
    TRUE
}

macro ReadUnlock()
{
    reader_count := reader_count - 1;
    \* Condition variable signal is "implicit" here
    if (reader_count = 0) {
        lock_state := "idle";
    };
}

macro WriteUnlock()
{
    writer_count := writer_count - 1;
    \* Ditto on the cond var
    if (writer_count = 0) {
        lock_state := "idle";
    };
}

procedure ReadLock()
{
add:
    reader_count := reader_count + 1;
lock:
    await writer_count = 0;
    lock_state := "read_locked";
    return;
}

procedure WriteLock()
variables rc;
{
loop:
    while (TRUE) {
        writer_count := writer_count + 1;
get_readers:
        rc := reader_count;
check_readers:
        if (rc > 0) {
            writer_count := writer_count - 1;
wait:
            await reader_count = 0;
        } else {
            goto locked;
        };
    };

locked:
    lock_state := "write_locked";
    return;
};

fair process(writer \in WRITERS)
{
loop:
    while (TRUE) {
        call WriteLock();
write_cs:
        skip;
unlock:
        WriteUnlock();
    };
}

fair process(reader \in READERS)
{
loop:
    while (TRUE) {
        call ReadLock();
read_cs:
        skip;
unlock:
        ReadUnlock();
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
	LockState
	Exclusion

PROPERTIES
	EventuallyRead
	EventuallyWrite
