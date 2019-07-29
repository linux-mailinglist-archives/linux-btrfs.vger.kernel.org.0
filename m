Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5008E78F5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfG2PdY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 11:33:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387887AbfG2PdX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 11:33:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15FDA337;
        Mon, 29 Jul 2019 08:33:23 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 132313F694;
        Mon, 29 Jul 2019 08:33:21 -0700 (PDT)
Date:   Mon, 29 Jul 2019 16:33:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        paulmck@linux.ibm.com, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Refactor snapshot vs nocow writers locking
Message-ID: <20190729153319.GH2368@arrakis.emea.arm.com>
References: <20190719083949.5351-1-nborisov@suse.com>
 <ed015bb1-490e-7102-d172-73c1d069476c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed015bb1-490e-7102-d172-73c1d069476c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some nitpicking below:

On Mon, Jul 29, 2019 at 03:13:42PM +0100, Valentin Schneider wrote:
> specs.tla:
> 
> ---- MODULE specs ----
> EXTENDS Integers, Sequences, TLC
> 
> CONSTANTS
>     NR_WRITERS,
>     NR_READERS,
>     WRITER_TASK,
>     READER_TASK
> 
> WRITERS == {WRITER_TASK} \X (1..NR_WRITERS)
> READERS == {READER_TASK} \X (1..NR_READERS)
> THREADS == WRITERS \union READERS

Recommendation: use symbolic values for WRITERS and READERS (defined in
.cfg: e.g. r1, r2, r3, w1, w2, w2). It allows you do to symmetry
optimisations. We've also hit a TLC bug in the past with process values
made up of a Cartesian product (though it may have been fixed since).

> macro ReadLock(tid)
> {
>     if (lock_state = "idle" \/ lock_state = "read_locked") {
>         lock_state := "read_locked";
>         threads[tid] := "read_locked";
>     } else {
>         assert lock_state = "write_locked";
>         \* waiting for writers to finish
>         threads[tid] := "write_waiting";
>         await lock_state = "" \/ lock_state = "read_locked";

lock_state = "idle"?

> macro WriteLock(tid)
> {
>     if (lock_state = "idle" \/ lock_state = "write_locked") {
>         lock_state := "write_locked";
>         threads[tid] := "write_locked";
>     } else {
>         assert lock_state = "read_locked";
>         \* waiting for readers to finish
>         threads[tid] := "read_waiting";
>         await lock_state = "idle" \/ lock_state = "write_locked";
>     };
> }

I'd say that's one of the pitfalls of PlusCal. The above is executed
atomically, so you'd have the lock_state read and updated in the same
action. Looking at the C patches, there is an
atomic_read(&lock->readers) followed by a
percpu_counter_inc(&lock->writers). Between these two, you can have
"readers" becoming non-zero via a different CPU.

My suggestion would be to use procedures with labels to express the
non-atomicity of such sequences.

> macro ReadUnlock(tid) {
>     if (threads[tid] = "read_locked") {
>         threads[tid] := "idle";
>         if (\A thread \in THREADS: threads[thread] # "read_locked") {
>             \* we were the last read holder, everyone else should be waiting, unlock the lock
>             lock_state := "idle";
>         };
>     };
> }

I'd make this close to the proposed C code with atomic counters. You'd
not be able to check each thread atomically in practice anyway.

-- 
Catalin
