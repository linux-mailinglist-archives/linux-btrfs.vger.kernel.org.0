Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68F4A5B45
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 12:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbiBALfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 06:35:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:37387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233560AbiBALfG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 06:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643715304;
        bh=k6Y941F0SWZziV2+3qoJ83uFMUqA+wBVT2RGGsr6kks=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=crBv6x/drsng2JboaEuyaRfhKjdmjYfr4EdTym78JMvClpRu3ZjY7TC6q9cxK0mj3
         u0t5n1JFfLSX9LG8Q72ihaMoPyRTGP651ileC/BhvPG+X/B6h091ikW9XkctUfQf9A
         aAHHIQZhnOjPQtggJMMpPRW6wiQfI84wSBn4impY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNNo-1mkhEL1Qry-00VRf8; Tue, 01
 Feb 2022 12:35:03 +0100
Message-ID: <d09f5826-cc87-4983-84a5-914aeac66630@gmx.com>
Date:   Tue, 1 Feb 2022 19:35:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: A question for kernel code in btrfs_run_qgroups()
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220131154040.GA25010@realwakka>
 <f5d1c08b-b843-6d5d-341d-c19890872e04@gmx.com>
 <20220201040558.GA25465@realwakka>
 <b7bc0568-d29f-0347-22f8-6aa93b6ad1fc@gmx.com>
 <20220201092414.GB25465@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220201092414.GB25465@realwakka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lQfKQg7DpqcHaYGCfO2eF1f2l8oTkDxEipT/cODvPZ0k88q865K
 CRDszjSDB6rjrzSAJAe9P/8Jm8NFi6pFoE6S3BMMDmYs59GjWZPwYiVO2RsXief1gkt+zuX
 w7yUN3mw0wG46sjv9aS3tYe7GgB+h2mwlWZw8ut+CNWal3UJcvs40QeipmfsLdqyYU8R1Nw
 TySGL9batLJW5C+mlqcFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3byW+WknIYU=:e5PzYDPfkIyRZ4tQgqAJR9
 GpVLMyYRlQqzVmqfZi205a4YBki4mDFzkCjFTP536cQgJo4+pk8A+ZNJwg4wHmNZfSbSdtqMp
 jNOND2/IFsa/EFw/nym9btrdEXBQ5BU9KujFncLt/W4d7wSW5Ob6b/otWHbWQnplx/TfSmT5I
 UMWMmSkNuqlXfciDNfxhim174GD6Z2OEu0VnfWRICsbm5JDr7pw39RoxRwJVIJPLLUxHMX1cP
 GwB3qzOqUlbHiVze+E6/30wL7mt8w+v3QDdYFUZmuymXz2uBu73PjLD5ve+6JgEfIE+edzG+i
 gUsmf65OL2plmzUxLwN0gPcndBJMOr/mGC3lnvUDM6dFac1JW/JPZatj+nIKv0Fy0DkuWWTcr
 EXt71zBim/sxgE9gxR0YG11BtrTV7sXtYw6870u6Q7GTgC79KL/uyohbTcTr7nrKkHglTlBc3
 +0ivjFcELPRiIwp/QG4xtYfUUMyVS5Y5/IqgMadPK1YfkYJJ1bxos30yDP10Uyn6CWdEAn8IV
 /qdm1tY7KuCvnjNys2KXXjcAm/gadlMpxPpW1DlQltuwZU2jllQXLcsPtgkyfZ5kMugl7I9vA
 BjYTqHFibrivkEI5FLporPP1CiL78gQ+z1d9djtRBpwRtT3zf3DKJNQex0XFXjba3PvGDAk5P
 +NASFn6KnJ8cFFfyUvZqA0rYYe+9YmW24XsqA0Hlr6+nWOtSh4v+OTnmbzHuj3cBY3rhj6r0x
 APT9sQhdcp4nEXwtn+CCVZL7F+fwj+ZyhE1xkgzXyzr+TxaIHSrubNvnxhqZFXSzIZTJGK2r9
 rSLolp92D2EKvFd3RfM8NYxxtQuix+pX0v1fQIWpu+bzQK5s+ivGu3Wc2cUnBPqQDDyl3cjq+
 v9nDHXYlLr3Qq6vfdmkUjziZA5wDpPUnT8DNHfwAJKACpumlx+qZ13+7i9MzAm6aDoRkBlT/Z
 dG0xMeBURj/toxuwltxUuW7a4laEzlrPBUwy4jQv1uP+e2mpPM546z7AuO75wPR5ppW24/QRY
 zu5yYv5UXPVk7HLI30MSAfJ3Z+pDujb1iKgad56bN4UlOE7OnAAU0V7trrnrIOkYoUWy0nZOo
 R8NVyTT/yFc164=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/1 17:24, Sidong Yang wrote:
> On Tue, Feb 01, 2022 at 03:31:03PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/2/1 12:05, Sidong Yang wrote:
>>> On Tue, Feb 01, 2022 at 08:21:22AM +0800, Qu Wenruo wrote:
>>>
>>> Hi Qu,
>>>
>>> Thanks for answering
>>>
>>>>
>>>>
>>>> On 2022/1/31 23:40, Sidong Yang wrote:
>>>>> Hi, I'm reading btrfs code for contributing.
>>>>> I have a question about code in btrfs_run_qgroups().
>>>>>
>>>>> It seems that it updates dirty qgroups modified in transaction.
>>>>
>>>> Yep.
>>>>
>>>>> And it iterates dirty qgroups with locking and unlocking qgroup_lock=
 for
>>>>> protecting dirty_qgroups list. According to code, It locks before en=
ter
>>>>> the loop and pick a entry and unlock. At the end of loop, It locks a=
gain
>>>>> for next loop. And after loop, it set some flags and unlock.
>>>>>
>>>>> I wonder that it should be locked with setting STATUS_FLAG_ON? if no=
t,
>>>>> is there unnecessary locking in last loop?
>>>>
>>>>   From a quick look, it indeed looks like we don't need to hole
>>>> qgroup_lock to modify qgroup_flags.
>>>> In fact, just lines below, we update qgroup_flags without any lock fo=
r
>>>> INCONSISTENT bit.
>>>
>>> Apparently it is, but I don't know surely that it really don't need to
>>> hold lock while modifying qgroup_flags.
>>> It has FLAG_ON that it indicates that quota turned on. I think it shou=
ld
>>> be modified carefully. Or it can be protected by other locks like
>>> qgroup_lock or ioctl_lock?
>>
>> In fact, for qgroup_flags, FLAG_ON is rarely changed.
>> Only qgroup enable/disable would change that.
>>
>> And qgroup enable/disable have to acquire qgroup_ioctl_lock, thus AFAIK
>> FLAG_ON is less a concern.
>>
>> To me, the concern is around INCONSISTENT flag.
>>
>> As it can happen at almost any time.
>>
>> As btrfs_qgroup_trace_extent()/trace_extent_post() can fail and cause
>> qgroup to be inconsistent.
>> Another location is in the future to make snapshot creation/snapshot
>> drop to mark qgroup INCONSISTENT to avoid super expensive subtree resca=
n.
>
> I agree. INCONSISTENT flag could be set anywhere. And it could make more
> bigger problem.
>>
>>>
>>>>
>>>>
>>>> Unfortunately we indeed have inconsistent locking for qgroups_flags.
>>>
>>> I agree. there is a lot of codes that modify qgroup_flags without lock
>>> or with lock.
>>
>> So far we use it just as bit operations, thus it may be convert to
>> set/clear/test_bit() to be atomic, and then get rid of the chaos of loc=
ks.
>>
>>>
>>>>
>>>> So it's completely possible that we may not need to do modify the
>>>> qgroup_flags under qgroup_lock.
>>>>
>>>> In fact there are tons of call sites that we don't hold locks for
>>>> qgroups_flags update.
>>>>
>>>> So if you're interested in contributing to btrfs, starting from sorti=
ng
>>>> the qgroup_lock usage would be a excellent start.
>>>
>>> Yeah, I really interested in this. but I don't know good way to handle
>>> this problem. is it really good way to remove the code holding lock
>>> while modifying flags?
>>
>> Maybe you can start by converting it to bit ops and move all the flags
>> operation out of critical sections?
>
> Thanks. I would write a patch that converts the code to bitops first.

One thing to mention is, if you're converting the flags operations to
bit ops, then please considering protecting it under qgroup_lock.

For now, it's fine as under most cases we just set/clear/test one bit once=
.

But for future patches, like this one:
https://patchwork.kernel.org/project/linux-btrfs/patch/20211207011655.2157=
9-4-wqu@suse.com/

Which will introduce a new flag beyond the existing three flags.

And we need to set that flag along with the existing INCONSITENT flag,
thus it's no longer atomic, and may need to use spin lock to protect them.

Thanks,
Qu
>
> Thanks,
> Sidong
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Sidong
>>>
>>>>
>>>> Thanks,
>>>> Qu
