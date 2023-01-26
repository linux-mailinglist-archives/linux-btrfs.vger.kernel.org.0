Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5BF67D437
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 19:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjAZSb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 13:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjAZSbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 13:31:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A7C5B88
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 10:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674757841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJ8MdjffZpW5lQ84mrB4VkeRYCCIBYfwyQ9vUthM6jo=;
        b=UzQKYTTtHlTrTKGO+CJGbAfK9+u197zBgjumR3cQO/uFJ5C4XLM1HjqBsDYB0QWSCRBnf+
        Q+hWhoZY6aA65Yt03lI2LZMrrrnPOlihowPlnpNOMlmYpDUpb8CdDFRpuQh6G09XtArs3w
        DK23M+MINZa9AOr4h0CKTBMwKFj0Dv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-d_NhYaU3MwuMT2DQJBei5Q-1; Thu, 26 Jan 2023 13:30:35 -0500
X-MC-Unique: d_NhYaU3MwuMT2DQJBei5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4387D858F09;
        Thu, 26 Jan 2023 18:30:35 +0000 (UTC)
Received: from [10.22.33.13] (unknown [10.22.33.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C241A40C1141;
        Thu, 26 Jan 2023 18:30:34 +0000 (UTC)
Message-ID: <017f7b9e-323c-f9aa-12fa-9c9a16dabd35@redhat.com>
Date:   Thu, 26 Jan 2023 13:30:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9K6m5USnON/19GT@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/23 12:38, Boqun Feng wrote:
> [Cc lock folks]
>
> On Thu, Jan 26, 2023 at 02:47:42PM +0500, Mikhail Gavrilov wrote:
>> On Wed, Jan 25, 2023 at 10:21 PM David Sterba <dsterba@suse.cz> wrote:
>>> On Wed, Jan 25, 2023 at 01:27:48AM +0500, Mikhail Gavrilov wrote:
>>>> On Tue, Jul 26, 2022 at 9:47 PM David Sterba <dsterba@suse.cz> wrote:
>>>>> On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
>>>>>> Hi guys.
>>>>>> Always with intensive writing on a btrfs volume, the message "BUG:
>>>>>> MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
>>>>> Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
>>>>> tends to work.
>>>> Hi,
>>>> Today I was able to get the message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
>>>> low!" again even with LOCKDEP_CHAINS_BITS=18 and kernel 6.2-rc5.
>>>>
>>>> ❯ cat /boot/config-`uname -r` | grep LOCKDEP_CHAINS_BITS
>>>> CONFIG_LOCKDEP_CHAINS_BITS=18
>>>>
>>>> [88685.088099] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
>>>> [88685.088124] turning off the locking correctness validator.
>>>> [88685.088133] Please attach the output of /proc/lock_stat to the bug report
>>>> [88685.088142] CPU: 14 PID: 1749746 Comm: mv Tainted: G        W    L
>>>>    -------  ---  6.2.0-0.rc5.20230123git2475bf0250de.38.fc38.x86_64 #1
>>>> [88685.088154] Hardware name: System manufacturer System Product
>>>> Name/ROG STRIX X570-I GAMING, BIOS 4408 10/28/2022
>>>>
>>>> What's next? Increase this value to 19?
>>> Yes, though increasing the value is a workaround so you may see the
>>> warning again.
>> Is there any sense in this WARNING if we would ignore it and every
>> time increase the threshold value?
> Lockdep uses static allocated array to track lock holdings chains to
> avoid dynmaic memory allocation in its own code. So if you see the
> warning it means your test has more combination of lock holdings than
> the array can record. In other words, you reach the resource limitation,
> and in that sense it makes sense to just ignore it and increase the
> value: you want to give lockdep enough resource to work, right?
>
>> May Be set 99 right away? Or remove such a check condition?
> That requires having 2^99 * 5 * sizeof(u16) memory for lock holding
> chains array..

Note that every increment of LOCKDEP_CHAINS_BITS double the storage 
space. With 99, that will likely exceed the total amount of memory you 
have in your system.

Boqun, where does the 5 figure come from. It is just a simple u16 array 
of size MAX_LOCKDEP_CHAIN_HLOCKS. The chain_hlocks array stores the lock 
chains that show up in the lockdep splats and in the /proc/lockdep* 
files. Each chain is variable size. As we add new lock into the chain, 
we have to repeatedly deallocate and reallocate a larger chain buffer. 
That will cause fragmentation in the chain_hlocks[]. So if we have a 
very long lock chain, the allocation may fail because the largest free 
block is smaller than the requested chain length. There may be enough 
free space in chain_hlocks, but it is just too fragmented to be useful.

Maybe we should figure out a better way to handle this fragmentation. In 
the mean time, the easiest way forward is just to increase the 
LOCKDEP_CHAINS_BITS by 1.

>
> However, a few other options we can try in lockdep are:
>
> *	warn but not turn off the lockdep: the lock holding chain is
> 	only a cache for what lock holding combination lockdep has ever
> 	see, we also record the dependency in the graph. Without the
> 	lock holding chain, lockdep can still work but just slower.
>
> *	allow dynmaic memory allocation in lockdep: I think this might
> 	be OK since we have lockdep_recursion to avoid lockdep code ->
> 	mm code -> lockdep code -> mm code ... deadlock. But maybe I'm
> 	missing something. And even we allow it, the use of memory
> 	doesn't change, you will still need that amout of memory to
> 	track lock holding chains.

It is not just the issue of calling the memory allocator. There is also 
the issue of copying data from old chain_hlocks to new one while the old 
one may be updated during the copying process unless we can freeze 
everything else.

Cheers,
Longman

