Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF2790E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfG2QcP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 12:32:15 -0400
Received: from foss.arm.com ([217.140.110.172]:47346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfG2QcP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 12:32:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7922F337;
        Mon, 29 Jul 2019 09:32:14 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97143F694;
        Mon, 29 Jul 2019 09:32:13 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Refactor snapshot vs nocow writers locking
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        paulmck@linux.ibm.com, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org
References: <20190719083949.5351-1-nborisov@suse.com>
 <ed015bb1-490e-7102-d172-73c1d069476c@arm.com>
 <20190729153319.GH2368@arrakis.emea.arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <60eda0ab-08b3-de82-5b06-98386ee1928f@arm.com>
Date:   Mon, 29 Jul 2019 17:32:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729153319.GH2368@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/07/2019 16:33, Catalin Marinas wrote:
[...]
>> ---- MODULE specs ----
>> EXTENDS Integers, Sequences, TLC
>>
>> CONSTANTS
>>     NR_WRITERS,
>>     NR_READERS,
>>     WRITER_TASK,
>>     READER_TASK
>>
>> WRITERS == {WRITER_TASK} \X (1..NR_WRITERS)
>> READERS == {READER_TASK} \X (1..NR_READERS)
>> THREADS == WRITERS \union READERS
> 
> Recommendation: use symbolic values for WRITERS and READERS (defined in
> .cfg: e.g. r1, r2, r3, w1, w2, w2). It allows you do to symmetry
> optimisations. We've also hit a TLC bug in the past with process values
> made up of a Cartesian product (though it may have been fixed since).
> 

Right, I had forgotten that one:

  https://github.com/tlaplus/tlaplus/issues/164

Being very lazy I dislike having to manually input those, but as you say
it can't be avoided if we want to use symmetry.

>> macro ReadLock(tid)
>> {
>>     if (lock_state = "idle" \/ lock_state = "read_locked") {
>>         lock_state := "read_locked";
>>         threads[tid] := "read_locked";
>>     } else {
>>         assert lock_state = "write_locked";
>>         \* waiting for writers to finish
>>         threads[tid] := "write_waiting";
>>         await lock_state = "" \/ lock_state = "read_locked";
> 
> lock_state = "idle"?
> 

Aye, I didn't modify those macros from the original spec.

>> macro WriteLock(tid)
>> {
>>     if (lock_state = "idle" \/ lock_state = "write_locked") {
>>         lock_state := "write_locked";
>>         threads[tid] := "write_locked";
>>     } else {
>>         assert lock_state = "read_locked";
>>         \* waiting for readers to finish
>>         threads[tid] := "read_waiting";
>>         await lock_state = "idle" \/ lock_state = "write_locked";
>>     };
>> }
> 
> I'd say that's one of the pitfalls of PlusCal. The above is executed
> atomically, so you'd have the lock_state read and updated in the same
> action. Looking at the C patches, there is an
> atomic_read(&lock->readers) followed by a
> percpu_counter_inc(&lock->writers). Between these two, you can have
> "readers" becoming non-zero via a different CPU.
> 
> My suggestion would be to use procedures with labels to express the
> non-atomicity of such sequences.
> 

Agreed, I've suggested something like this in my reply.

[...]
