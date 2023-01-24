Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7780E67A636
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 23:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjAXW7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 17:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjAXW7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 17:59:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C34391C
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 14:59:46 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1po0-1pMfBn1iDw-002HGB; Tue, 24
 Jan 2023 23:59:36 +0100
Message-ID: <d1be019a-cd1c-c3f8-0a11-67feae9ca564@gmx.com>
Date:   Wed, 25 Jan 2023 06:59:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: btrfs corruption, extent buffer leak
To:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <Y8voyTXdnPDz8xwY@mail.gmail.com>
 <CAL3q7H5vjCrVEPVm0qySoXndBsnNDDT6H5VYMLORFxsZegXNpA@mail.gmail.com>
 <Y853dpWJQjUoBo4Q@mail.gmail.com>
 <CAL3q7H5auixGxxjALT0D3mFcq-Lj=s2yX-HPEgLk=XZbUTTqng@mail.gmail.com>
 <Y8/+aOngUIC2ytGB@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y8/+aOngUIC2ytGB@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:30TQPX2AUt4fyD1Z8E6coyebgZ0ayt5QZXcPlIwPpYRJXCh6noC
 77rn8mZ7wLmsqM2uW8XwZn0aVy69jf6WXdhM+GPS49YDI81fFfbWqbqExUYV41f5hWyIkDJ
 pAaA8GJxGq4U7aPSSg0H4Hijb5hbbrYBYsEt8mxJWWWD6uKo4fDQVnF0MUM0qSJzjdHf3Jg
 VVUL1CSK1JDiUtReQoGWA==
UI-OutboundReport: notjunk:1;M01:P0:L5G+ZAQj26U=;+QqKuhpeRG92SVn8WeDZ6OWr6nD
 SDZY2NA62sOa1fR4Tu9OFAyK+700d0YPQITWPHEYCjgwdC6RWWvFNXjFmFHykeoRHX0im5UaE
 sU3MZJYsjxx0fGROu1KA+05n4vwf/A7+EkIp8ELMQJG66BHSZBNjrDn/00Uwe8SM2QBZAO6yS
 wA+6m51IRCAhK9F/YnX64nvWczFDG8IH1NVdUGxbec0Oc50PMOvOCkCXIW6an27o/FQu/mtnx
 aKg3kMDf/AZO5C5CFMIVJSsRDiSdMjgsk3mukN0IgsdGm7E/1xijGxs97qZqMILS0H7AD4Phz
 vdypKpgZK7QjZi5iyHCcCrndEPEkY0beeQWtGzRj1D9YMzlALi66mtVJJSw3pVadA72oJf+RN
 xme3uqBso/NpVTU//U2osrv0Fx5SwRSUUMPdEaBD80I8jl2+DY/RNjnVHlMaW/w1h89a7c3ea
 hRJhsP9gSwVcWGXNxT6B462sIrDq53kIzScPr17gmTHXInAROGgDw1wxn63GUzBlk9XMMNa4V
 yGfyLrXdaQWUpDH9Y7vigBwyswelSBoTDQp3tOZ76QKz6JuO/SsWETp8WwoONlm3W69dSA/4F
 oQ9kiKNay6AbXBd6jxjEb2LhpavBzNP0z+EHBXdkIlldFLmFwZNk2KfqTt7NmIbNW2rZjcJKH
 k2bjlizkJwtzZxXG6NLg0BnLQp6xr+X4Ea1lwt+ByFKwpn6u71tsnyC8frTa5dT9ZX8zmL2TP
 /33c0QWsdb3gueWd04eRb3snfTSjwDqkP0Z4CY59kRVduxpQKVTEUGR591/OfM8utIWl8vTUP
 cPuiGzjCYJDHuJa0bvtiCDLO7YeUpivzTV4hLilq2uNRE5uQMmDIfHFNG7dxwlQhAXp4XNNs7
 9J5J4rFD3qJYZosKHK47U+KjmjcVRy+BFJwEn4tM/bh4GnSKjBS76TMiOlIZhug/5DLcZVV+x
 1PP7rMVhGOy+/a6x96NEoXZJ9YM=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/24 23:51, Maxim Mikityanskiy wrote:
> Thanks for the advice!
> 
> On Mon, Jan 23, 2023 at 01:23:25PM +0000, Filipe Manana wrote:
>> On Mon, Jan 23, 2023 at 12:03 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
>>>
>>>>
>>>> https://lore.kernel.org/linux-btrfs/ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info/
>>>
>>> So it seems to be a known issue for 6.1. Is there any known workaround,
>>> or should I downgrade the kernel? Is there any risk of running an older
>>> kernel (and an older btrfs driver) on a filesystem that was driven by
>>> 6.1?
>>
>> You can temporarily downgrade to a 6.0 or older kernel if you want to.
>>
>>>
>>>>> Other than that, I couldn't list files in a directory two levels higher
>>>>> than the file that I attempted to create.
>>>>
>>>> You couldn't list files while the fs was in RO state, or after
>>>> rebooting? Or both?
>>>
>>> Only when it was in readonly. After rebooting, I could access that
>>> directory again, and the contents seemed to be intact.
>>>
>>>> What happened exactly when attempting to list files? What error did you get?
>>>
>>> Sorry, I didn't write down the error code...
>>>
>>> ls didn't show any entries and just displayed one line with an error,
>>> which I didn't save.
>>>
>>>>>
>>>>> After rebooting from a live USB, I ran btrfs scrub (no errors found) and
>>>>> btrfs check (some errors found):
>>>>>
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/mapper/root
>>>>> UUID: ********-****-****-****-************
>>>>> [1/7] checking root items
>>>>> [2/7] checking extents
>>>>> [3/7] checking free space tree
>>>>> [4/7] checking fs roots
>>>>> [5/7] checking only csums items (without verifying data)
>>>>> [6/7] checking root refs
>>>>> [7/7] checking quota groups
>>>>> ERROR: failed to add qgroup relation, member=258 parent=71776119061217538: No such file or directory
>>>>> ERROR: loading qgroups from disk: -2
>>>>> ERROR: failed to check quota groups
>>>>
>>>> This is a different issue, it's the first time I see it, nothing
>>>> related to the previous one. I'm adding Qu to CC since he knows
>>>> qgroups much better than I do, and so he may have an idea.
>>>
>>> More info on this: after I rebooted and continued using the filesystem,
>>> I started seeing these messages in dmesg:
>>>
>>> BTRFS warning (device dm-0): qgroup rescan is already in progress
>>> BTRFS warning (device dm-0): qgroup rescan is already in progress
>>> ...
>>> BTRFS warning (device dm-0): qgroup rescan is already in progress
>>> BTRFS info (device dm-0): qgroup scan completed (inconsistency flag cleared)
>>>
>>> These messages repeated multiple times, i.e. qgroup rescan was
>>> apparently constantly triggered multiple times, and even after it was
>>> completed, something retriggered it again and again.
>>>
>>> Then I removed a few hundreds of gigabytes of files, deleted most
>>> subvolumes (there were several dozens of docker subvolumes), and I
>>> noticed that quotas became disabled on this filesystem. I reenabled
>>> quotas, rescanned qgroups, and the quota issue seems to be fixed: I no
>>> longer see repeated rescans in dmesg, and btrfs check doesn't show any
>>> errors now.
>>
>> Disabling and re-enabling qgroups, or just rescanning, sometimes
>> solves qgroup related problems.
> 
> I noticed that after I use docker, a lot of stale qgroups appear. They
> can be easily cleared with btrfs qgroup clear-stale, but I don't recall
> seeing them before:
> 
> 0/3026           0.00B        0.00B   <stale>
> 0/3027           0.00B        0.00B   <stale>
> 0/3028           0.00B        0.00B   <stale>
> 0/3029           0.00B        0.00B   <stale>
> 0/3030           0.00B        0.00B   <stale>
> 0/3031           0.00B        0.00B   <stale>
> 0/3032           0.00B        0.00B   <stale>
> 0/3033           0.00B        0.00B   <stale>
> 0/3034           0.00B        0.00B   <stale>
> 0/3035           0.00B        0.00B   <stale>
> 0/3036           0.00B        0.00B   <stale>
> 0/3037           0.00B        0.00B   <stale>
> 
> Is there some garbage-collecting mechanism that will remove them over
> time? Is it normal to see them at all?

The auto removal of qgroup is not yet implemented.

There are some patches submitted, but not yet merged for a long time.

Thanks,
Qu
> 
>>
>>>
>>>>> found 1211137126400 bytes used, error(s) found
>>>>> total csum bytes: 1170686968
>>>>> total tree bytes: 10738614272
>>>>> total fs tree bytes: 8738439168
>>>>> total extent tree bytes: 557547520
>>>>> btree space waste bytes: 1726206798
>>>>> file data blocks allocated: 1533753126912
>>>>>   referenced 1324118478848
>>>>> extent buffer leak: start 931127214080 len 16384
>>>>> extent buffer leak: start 103570046976 len 16384
>>>>>
>>>>> The quota error and especially the extent buffer leak error don't look
>>>>> good to me. However, the filesystem seem to mount properly, and so far I
>>>>> didn't find any lost files (still looking). I don't know whether the
>>>>> amount of free space is shown correctly.
>>>>>
>>>>> What should be my steps to fix these errors? I didn't try btrfs check
>>>>> --repair yet, because of numerous warnings not to use it.
>>>>>
>>>>> Also, what is the approximate amount of the data lost due to this extent
>>>>> buffer leak? Is 16384 the number of sectors or the number of bytes?
>>>>
>>>> Why do you think there's data loss?
>>>
>>> The error message looked scary, I thought it meant that some extents
>>> with real data were leaked on the filesystem and became unreferenced.
>>> The "BTRFS critical: corrupt leaf" message in dmesg, followed by
>>> switching to readonly (a standard fallback when the filesystem is
>>> seriously screwed up), also gave me confidence some data were lost.
>>
>> Only data that was not yet flushed to disk (and not fsynced) could be
>> lost, i.e. just like a sudden power failure.
>>
>> And for metadata (file names, directories, xattrs, etc) only for
>> changes done since the last transaction commit and not fsynced.
>> By default, unless you use the mount option commix=xxx, transaction
>> commits happen every 30 seconds, sometimes less
>> as some fyncs may fallback to a transaction commit, or a snapshot was
>> created, etc.
>>
>>>
>>>> The extent buffer leak is just a
>>>> btrfs-progs thing, it means the code failed to release allocated
>>>> memory - but once 'btrfs check' exits, the memory is released. This is
>>>> likely happening due to the qgroups error, some error path is not
>>>> freeing the memory.
>>>
>>> That's a relief to hear. I actually noticed that the "start" numbers
>>> weren't consistent if I ran btrfs check multiple times. And this error
>>> disappeared after fixing quotas, so it indeed seems to be related.
>>>
>>> I appreciate your help, thanks! What's the best thing to do in these
>>> circumstances to minimize further damage? Should I recreate the
>>> filesystem, or is it fine as it is? Should I downgrade the kernel for
>>> now? If the first error repeats, is there any risk for data loss?
>>
>> No, no need to recreate the filesystem.
>> That was corruption detected during a fsync operation, and spitting
>> the error and turning the fs to read-only mode only prevents any
>> corruptions from being persisted.
> 
> Thanks for the explanation! It's nice to hear it wasn't persisted to the
> disk - that was what I worried about.
> 
>> Just downgrade to a 6.0 kernel or older for now, until the relevant
>> fixes land in a 6.1.x stable release.
> 
> Thanks for the advice!
> 
>>
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Max
