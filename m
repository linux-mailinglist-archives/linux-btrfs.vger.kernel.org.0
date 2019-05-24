Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C670B29928
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2019 15:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403809AbfEXNmC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 May 2019 09:42:02 -0400
Received: from a4-4.smtp-out.eu-west-1.amazonses.com ([54.240.4.4]:58264 "EHLO
        a4-4.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391361AbfEXNmB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 May 2019 09:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1558705319;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=30UkGslChQYKihPC/SDIY6NhAp6CkeV8GeMdXSM5Q6I=;
        b=ByNgDr+C8QBz95mJBpxP7LrXyrBo5xzrfnK6k8mGWbHZHXkB4TKDnvgIR7ZDyOkT
        PcCxZ2dxyBmTbECUDGRSyQr1yyzDaydYKEaO0yIeyFB7pPFMa3auffgKe5ADyQHKJ7I
        VO/jpJTsa7Bpz+35Otsd9zxnvPOedM3tckUGfdvs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1558705319;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=30UkGslChQYKihPC/SDIY6NhAp6CkeV8GeMdXSM5Q6I=;
        b=bBDqWDkszRMxmg223uuZ4RVAOMuKTqb7SWZPteWGqix+6ZSfoYQxn2PIPq2uOn3q
        3ntAxUNjwluWKYx0fuT+y8gEY557KPeRIs5DPRPNr7nM/iO35qgll6IOW7dMW+HjUUd
        qW3QrarwmlfMZ2XKsJTOVChn3ovn9HUaOA7n26P8=
Subject: Re: Citation Needed: BTRFS Failure Resistance
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Martin Raiber <martin@urbackup.org>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
 <8ccec20a-04b1-4a84-6739-afd35b4ab02e@gmail.com>
 <CAJCQCtTp5d+VxsQmVv68VdmCsxSVpi-_c6LJjS_T=xx3GXz9Fg@mail.gmail.com>
 <979559b5-1fb5-debd-e101-6e4227348426@gmail.com>
 <0102016ae5bf1e51-7cedfda5-aff2-4ecb-801b-ec8c04ce84b5-000000@eu-west-1.amazonses.com>
 <2ef383f2-7d70-406c-eb60-6d45a6f8f86f@gmail.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016aea13ad4d-cea4167f-90fe-4b0d-8112-afb187ea8a34-000000@eu-west-1.amazonses.com>
Date:   Fri, 24 May 2019 13:41:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2ef383f2-7d70-406c-eb60-6d45a6f8f86f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.05.24-54.240.4.4
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23.05.2019 19:41 Austin S. Hemmelgarn wrote:
> On 2019-05-23 13:31, Martin Raiber wrote:
>> On 23.05.2019 19:13 Austin S. Hemmelgarn wrote:
>>> On 2019-05-23 12:24, Chris Murphy wrote:
>>>> On Thu, May 23, 2019 at 5:19 AM Austin S. Hemmelgarn
>>>> <ahferroin7@gmail.com> wrote:
>>>>>
>>>>> On 2019-05-22 14:46, Cerem Cem ASLAN wrote:
>>>>>> Could you confirm or disclaim the following explanation:
>>>>>> https://unix.stackexchange.com/a/520063/65781
>>>>>>
>>>>> Aside from what Hugo mentioned (which is correct), it's worth
>>>>> mentioning
>>>>> that the example listed in the answer of how hardware issues could
>>>>> screw
>>>>> things up assumes that for some reason write barriers aren't honored.
>>>>> BTRFS explicitly requests write barriers to prevent that type of
>>>>> reordering of writes from happening, and it's actually pretty
>>>>> unusual on
>>>>> modern hardware for those write barriers to not be honored unless the
>>>>> user is doing something stupid (like mounting with 'nobarrier' or
>>>>> using
>>>>> LVM with write barrier support disabled).
>>>>
>>>> 'man xfs'
>>>>
>>>>          barrier|nobarrier
>>>>                 Note: This option has been deprecated as of kernel
>>>> v4.10; in that version, integrity operations are always performed and
>>>> the mount option is ignored.  These mount options will be removed no
>>>> earlier than kernel v4.15.
>>>>
>>>> Since they're getting rid of it, I wonder if it's sane for most any
>>>> sane file system use case.
>>>>
>>> As Adam mentioned, it's mostly volatile storage that benefits from
>>> this.  For example, on the systems where I have /var/cache configured
>>> as a separate filesystem, I mount it with barriers disabled because
>>> the data there just doesn't matter (all of it can be regenerated
>>> easily) and it gives me a few percent better performance.  In essence,
>>> it's the mostly same type of stuff where you might consider running
>>> ext4 without a journal for performance reasons.
>>>
>>> In the case of XFS, it probably got removed to keep people who fancy
>>> themselves to be power users but really have no clue what they're
>>> doing from shooting themselves in the foot to try and get some more
>>> performance.
>>>
>>> IIRC, the option originally got added to both XFS and ext* because
>>> early write barrier support was a bigger performance hit than it is
>>> today, and BTRFS just kind of inherited it.
>>
>> When I google for it I find that flushing the device can also be
>> disabled via
>>
>> echo "write through" > /sys/block/$device/queue/write_cache
> Disabling write caching (which is what that does) is not really the
> same as mounting with 'nobarrier'.  Write caching actually improves
> performance in most cases, it just makes things a bit riskier because
> of the possibility of write reordering (which barriers prevent).

According to documentation it doesn't change any caching. This changes
how the kernel sees what kind of caching the device does. If the device
claims it does "write through" caching (e.g. battery backed RAID card)
the kernel doesn't need to send device cache flushes, otherwise is does.
If you set a device that has "write back" there to "write through", the
kernel will think it does not require flushes and not send any, thus
causing data loss at power loss (because the device obviously still does
write back caching).

>>
>> I actually used nobarrier recently (albeit with ext4), because a steam
>> download was taking forever (hours), when remounting with nobarrier it
>> went down to minutes (next time I started it with eatmydata). But ext4
>> fsck is probably able to recover nobarrier file systems with unfortunate
>> powerlosses and btrfs fsck... isn't. So combined with the above I'd
>> remove nobarrier.
>>
> Yeah, Steam is another pathological case actually, though that's
> mostly because their distribution format is generously described as
> 'excessively segmented' and they fsync after _every single file_.  If
> you ever use Steam's game backup feature, you'll see similar results
> because it actually serializes the data to the same format that is
> used when downloading the game in the first place.


