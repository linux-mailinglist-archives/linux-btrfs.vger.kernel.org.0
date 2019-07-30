Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB17A666
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 13:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfG3LDh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 07:03:37 -0400
Received: from foss.arm.com ([217.140.110.172]:59290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfG3LDh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 07:03:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 929AE344;
        Tue, 30 Jul 2019 04:03:36 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD0F93F575;
        Tue, 30 Jul 2019 04:03:35 -0700 (PDT)
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
Message-ID: <69ef76a2-ebd6-956e-c611-2e742606ed95@arm.com>
Date:   Tue, 30 Jul 2019 12:03:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <60eda0ab-08b3-de82-5b06-98386ee1928f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/07/2019 17:32, Valentin Schneider wrote:
> On 29/07/2019 16:33, Catalin Marinas wrote:
[...]
>> I'd say that's one of the pitfalls of PlusCal. The above is executed
>> atomically, so you'd have the lock_state read and updated in the same
>> action. Looking at the C patches, there is an
>> atomic_read(&lock->readers) followed by a
>> percpu_counter_inc(&lock->writers). Between these two, you can have
>> "readers" becoming non-zero via a different CPU.
>>
>> My suggestion would be to use procedures with labels to express the
>> non-atomicity of such sequences.
>>
> 

FYI, with a very simple and stupid modification of the spec:

----->8-----
macro ReadUnlock()
{
    reader_count := reader_count - 1;
    \* Condition variable signal is "implicit" here
}

macro WriteUnlock()
{
    writer_count := writer_count - 1;
    \* Ditto on the cond var
}

procedure ReadLock()
{
add:
    reader_count := reader_count + 1;
lock:
    await writer_count = 0;
    return;
}

procedure WriteLock()
{
add:
    writer_count := writer_count + 1;
lock:
    await reader_count = 0;
    return;
};
-----8<-----

it's quite easy to trigger the case Paul pointed out in [1]:

----->8-----
Error: Deadlock reached.
Error: The behavior up to this point is:
State 1: <Initial predicate>
/\ stack = (<<reader, 1>> :> <<>> @@ <<writer, 1>> :> <<>>)
/\ pc = (<<reader, 1>> :> "loop" @@ <<writer, 1>> :> "loop_")
/\ writer_count = 0
/\ reader_count = 0
/\ lock_state = "idle"

State 2: <loop_ line 159, col 16 to line 164, col 72 of module specs>
/\ stack = ( <<reader, 1>> :> <<>> @@
  <<writer, 1>> :> <<[pc |-> "write_cs", procedure |-> "WriteLock"]>> )
/\ pc = (<<reader, 1>> :> "loop" @@ <<writer, 1>> :> "add")
/\ writer_count = 0
/\ reader_count = 0
/\ lock_state = "idle"

State 3: <add line 146, col 14 to line 149, col 63 of module specs>
/\ stack = ( <<reader, 1>> :> <<>> @@
  <<writer, 1>> :> <<[pc |-> "write_cs", procedure |-> "WriteLock"]>> )
/\ pc = (<<reader, 1>> :> "loop" @@ <<writer, 1>> :> "lock")
/\ writer_count = 1
/\ reader_count = 0
/\ lock_state = "idle"

State 4: <loop line 179, col 15 to line 184, col 71 of module specs>
/\ stack = ( <<reader, 1>> :> <<[pc |-> "read_cs", procedure |-> "ReadLock"]>> @@
  <<writer, 1>> :> <<[pc |-> "write_cs", procedure |-> "WriteLock"]>> )
/\ pc = (<<reader, 1>> :> "add_" @@ <<writer, 1>> :> "lock")
/\ writer_count = 1
/\ reader_count = 0
/\ lock_state = "idle"

State 5: <add_ line 133, col 15 to line 136, col 64 of module specs>
/\ stack = ( <<reader, 1>> :> <<[pc |-> "read_cs", procedure |-> "ReadLock"]>> @@
  <<writer, 1>> :> <<[pc |-> "write_cs", procedure |-> "WriteLock"]>> )
/\ pc = (<<reader, 1>> :> "lock_" @@ <<writer, 1>> :> "lock")
/\ writer_count = 1
/\ reader_count = 1
/\ lock_state = "idle"
-----8<-----

Which I think is pretty cool considering the effort that was required
(read: not much).

[1]: https://lore.kernel.org/lkml/20190607105251.GB28207@linux.ibm.com/
