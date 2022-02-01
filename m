Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3956B4A57C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiBAHbK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 02:31:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:33275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233720AbiBAHbI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 02:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643700667;
        bh=UXsrZ8Ae0HKlgaiUtMkguGVu/LN+I9maW0/gLApZkNA=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=OnZhVsB14eBHHtvY0DiOF5V5twIM2veXCP993+4EfTNmmX9/SCq4yfB5JmDDqIYWs
         DoOOQ6tHmAabOGFOcFC1bzHFpzE+tMZup6BhOrx7QAXDE+4v13vaLaW6VsqpzV41Pn
         ls59j/7BnUVD5/p3Ly4AA57uIhTy2GXbyYOcaxVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbox-1mrNsv2XSV-00P7cm; Tue, 01
 Feb 2022 08:31:07 +0100
Message-ID: <b7bc0568-d29f-0347-22f8-6aa93b6ad1fc@gmx.com>
Date:   Tue, 1 Feb 2022 15:31:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220131154040.GA25010@realwakka>
 <f5d1c08b-b843-6d5d-341d-c19890872e04@gmx.com>
 <20220201040558.GA25465@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: A question for kernel code in btrfs_run_qgroups()
In-Reply-To: <20220201040558.GA25465@realwakka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iSEdkiOsEUCnOIemfjUiAbbZKw319kTYviZKxnKDxw4JEhUQhiI
 PSuBbMbKVfi43l+wokJfU1lejDYlCGKoFs/gCCZYhq3pvHya/iIi2WH+sA+VtCpltLeFWqZ
 wIfYNX1OUTgQEHejnxqYL6OBaE4xNZJuz/038ufE/wO0cCfgVCFVWcoQ7w+cCZlRaKZQQqM
 lmkzhkzlFRCgcwzr2RiTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:84H9fWG5txw=:kiyW1+ORoogi9Up8WLfJwY
 LAOnUc9jbhvyuI8D3j2xKrytk8el6gor8d3K/XcfirYKabBPr7bBYUbPeSI8w1gZFxChvQEzH
 06oCiOHXBoOihrsdDsuyRgbaw1/dOsJ2FYwBf/x8MefSItN77ERUqcNSCwOok8P+xaBXv9ZyS
 ZA8W8FAGmpQ+7VtVm1N6o72bv1YfdHmwD2O8p2dLu27ErjrskyXaqkRr79KYkOXQeTXpF+eTs
 9vWpwvqRt5h71PJ5LWPokDt0NxGsswdPHguFCx5Mehj7HEQ4hhXcLhhzs+nZJcmqwRpJk6T5x
 mvxFyYPpc66w2BesXKuo7IFQS2RJ4ChtpLtq9CBleA39LK+Bp2gSC6ztXgrDoZ6YRN2Y9z0ez
 I2mMRgtPUw1sCS5iExYegKIRiB90ImFATgc1v+++ULWzugMurtv8Sg0mvDLO51Sj3/O4syVJR
 IQwBoW+Z8yupQXik9SsTRRktYfXu1+rqG3+wNxD69qTR2fL36l6Q46XWZqqNaGsu6rlp3czXF
 j0wzEzV/cjPzFb7ZzLtXgZHDrcfqZU66S/PKm8yrHArR3FUuHa7jhppq8Ru9NhG5/oUetxkp3
 BTA+ll9hbYzMFHLz15zwL3xfB8NMz6gsdMQzmKBKmL6xGdJvCLhsiQrVf+BX8yLYq1uZDtRbz
 S8XqOgxc1bXM0DAqBGCnT/ruvRrjAiF7iTS1xCNaFaHOsqUH8qWO0U4E02oPmElLrxTY6/wP3
 SUxzqfxJhDQfFEWer5Bm0Kj2DJNSM1L+YtOUu9KuG3tya+DAybDDsG5l+Kh5Y58NXTpjp5YmJ
 elGL9LZvvI4vZRYbRK9fBchXDZPCfuxRQB2VyxuI1f3vywBzaRA8kJe5QDnmBY7xA2wufRk2W
 Vyuth37X5JD1/HmY8F3v0GQ/ThHK5+L8nBCdFeH+rl95hrbt+tADR7XYbZ6BWuMoxhfalWqNX
 42bs8SHUUoVQDb/lk0TDgaKNuJQRJlEY6qs2UAO1PByiqHbukjOo6t2FbS+jofYlKJy03z2Rr
 Zk6/gCm02wOkzPkY5j//zeq1k6Ew/mnV3jW0Z5tMPcgp0Um7MUSqojzBnmIqJ2aIjV2QO3V5Z
 JwRtXIE+VpZ6x8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/1 12:05, Sidong Yang wrote:
> On Tue, Feb 01, 2022 at 08:21:22AM +0800, Qu Wenruo wrote:
>
> Hi Qu,
>
> Thanks for answering
>
>>
>>
>> On 2022/1/31 23:40, Sidong Yang wrote:
>>> Hi, I'm reading btrfs code for contributing.
>>> I have a question about code in btrfs_run_qgroups().
>>>
>>> It seems that it updates dirty qgroups modified in transaction.
>>
>> Yep.
>>
>>> And it iterates dirty qgroups with locking and unlocking qgroup_lock f=
or
>>> protecting dirty_qgroups list. According to code, It locks before ente=
r
>>> the loop and pick a entry and unlock. At the end of loop, It locks aga=
in
>>> for next loop. And after loop, it set some flags and unlock.
>>>
>>> I wonder that it should be locked with setting STATUS_FLAG_ON? if not,
>>> is there unnecessary locking in last loop?
>>
>>  From a quick look, it indeed looks like we don't need to hole
>> qgroup_lock to modify qgroup_flags.
>> In fact, just lines below, we update qgroup_flags without any lock for
>> INCONSISTENT bit.
>
> Apparently it is, but I don't know surely that it really don't need to
> hold lock while modifying qgroup_flags.
> It has FLAG_ON that it indicates that quota turned on. I think it should
> be modified carefully. Or it can be protected by other locks like
> qgroup_lock or ioctl_lock?

In fact, for qgroup_flags, FLAG_ON is rarely changed.
Only qgroup enable/disable would change that.

And qgroup enable/disable have to acquire qgroup_ioctl_lock, thus AFAIK
FLAG_ON is less a concern.

To me, the concern is around INCONSISTENT flag.

As it can happen at almost any time.

As btrfs_qgroup_trace_extent()/trace_extent_post() can fail and cause
qgroup to be inconsistent.
Another location is in the future to make snapshot creation/snapshot
drop to mark qgroup INCONSISTENT to avoid super expensive subtree rescan.

>
>>
>>
>> Unfortunately we indeed have inconsistent locking for qgroups_flags.
>
> I agree. there is a lot of codes that modify qgroup_flags without lock
> or with lock.

So far we use it just as bit operations, thus it may be convert to
set/clear/test_bit() to be atomic, and then get rid of the chaos of locks.

>
>>
>> So it's completely possible that we may not need to do modify the
>> qgroup_flags under qgroup_lock.
>>
>> In fact there are tons of call sites that we don't hold locks for
>> qgroups_flags update.
>>
>> So if you're interested in contributing to btrfs, starting from sorting
>> the qgroup_lock usage would be a excellent start.
>
> Yeah, I really interested in this. but I don't know good way to handle
> this problem. is it really good way to remove the code holding lock
> while modifying flags?

Maybe you can start by converting it to bit ops and move all the flags
operation out of critical sections?

Thanks,
Qu

>
> Thanks,
> Sidong
>
>>
>> Thanks,
>> Qu
