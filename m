Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156C2474B7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 20:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbhLNTDr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 14:03:47 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:47005 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237301AbhLNTDr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 14:03:47 -0500
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id xD5Vm5ih7g9rVxD5VmaoOR; Tue, 14 Dec 2021 20:03:45 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639508626; bh=zHY2YBW2aBERqLR6FKeGyz8mCJFN2oao2+syp8XwY2M=;
        h=From;
        b=wtEugDyWr1ZP92MLxFhLxx27LyDPkUWtSRwRLZRvCd1Sjq+XjT1KuFuepG83iB4ut
         8tbJUiFIjFnpN0xZWj6QbVvDrb1lnCFwZDaCNMsoCusZvQ8bLH/sBjVFpbUI3Wr6GL
         6xV8hLbyiMwdpxJfxCZuB1dg7PlJO7AuwWXu6hWK2BQK4Uv7LH91iWTJ1Kr27oW5oB
         S/xUIFSY3V3NX1bPUBXQfc5xaVTyjD/9RLUtDK6cDvRpf1D71KJJFCSpzRhrfkkKRJ
         p1Gomae3UHJuEMSrAbZ/+Jl0IAgT5srImmsYYpVXnbV8XszDOLhM7Z9AsRJZdpO9OP
         r73GDdIw7ZF8g==
X-CNFS-Analysis: v=2.4 cv=T8hJ89GQ c=1 sm=1 tr=0 ts=61b8ea92 cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=fD4G899YbeJozRQIVVEA:9 a=QEXdDO2ut3YA:10
Message-ID: <71e523dc-2854-ca9b-9eee-e36b0bd5c2cb@libero.it>
Date:   Tue, 14 Dec 2021 20:03:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain> <YbfN8gXHsZ6KZuil@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <YbfN8gXHsZ6KZuil@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfL9pTpCqdrWlbnBTyLpqRQyq52FdbhlBYpMYYSQONM/je1Xe6sxudY6J+TlW7hPS20XljWBoMFOqh1AJoArccoMhsghEbJwlNu9TTlSkoDKIUEJsoRAA
 SwXyuCko3GV+r4yvECy26Lod+bVkS/nR9j7DkSjkFi04a+y61NBE2iIXC2dRng/NNEdfQd3eX/jXVcv0quFEv9jH1SU0D0t9bhBRC4NANTuf11wBYLJcnOp4
 IxxMnx6mwdBQ0+KHArv3YAeQymbOvdZZKmw3KG0Ga5gvcOgPtEfbta0GP2qQsQ/mN5tQ7Y1G7AHln5/ez4q8+81oolxH9luIvfzlmZvIvslEk+xc1dU8S218
 b1wj4Tit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/13/21 23:49, Zygo Blaxell wrote:
> On Mon, Dec 13, 2021 at 04:15:14PM -0500, Josef Bacik wrote:
>> On Mon, Dec 13, 2021 at 08:54:24PM +0100, Goffredo Baroncelli wrote:
>>> Gentle ping :-)
>>>
>>> Are there anyone of the mains developer interested in supporting this patch ?
>>>
>>> I am open to improve it if required.
>>>
>>
>> Sorry I missed this go by.  I like the interface, we don't have a use for
>> device->type yet, so this fits nicely.
>>
>> I don't see the btrfs-progs patches in my inbox, and these don't apply, so
>> you'll definitely need to refresh for a proper review, but looking at these
>> patches they seem sane enough, and I like the interface.  I'd like to hear
>> Zygo's opinion as well.
> 
> I've been running earlier versions with modifications since summer 2020,
> and this version mostly unmodified (rebase changes only) since it was
> posted.  It seems to work, even in corner cases like converting balances,
> replacing drives, and running out of space.  The "running out of space"
> experience is on btrfs is weird at the best of times, and these patches
> add some more new special cases, but it doesn't behave in ways that
> would surprise a sysadmin familiar with how btrfs chunk allocation works.
> 
> One major piece that's missing is adjusting the statvfs (aka df)
> available blocks field so that it doesn't include unallocated space on
> any metadata-only devices.  Right now all the unallocated space on
> metadata-only devices is counted as free even though it's impossible to
> put a data block there, so anything that is triggered automatically
> on "f_bavail < some_threshold" will be confused.
> 
> I don't think that piece has to block the rest of the patch series--if
> you're not using the feature, df gives the right number (or at least the
> same number it gave before), and if you are using the feature, you can
> subtract the unavailable data space until a later patch comes along to
> fix it.
> 
> I like
> 
> 	echo data_only > /sys/fs/btrfs/$uuid/devinfo/3/type

Only to be clear, for now you can pass a numeric value to "type". Not a text
like your example.

However I want to put on the table another option: to not expose all the
"type" field, but only the "allocation policy"; we can add a new sysfs field
called "allocation policy" that internally change the dev_item->type field.

It is not only a "cosmetic" change. If we want to change the allocation
policy, now the correct way is:
- read the type field
- change the "allocation policy" bits
- write the type field

Which is race 'prone'

For now it is not a problem, because type contains only the allocation bits.
But in future when the type field will contains further properties this could
be a problem.

> 
> more than patching btrfs-progs so I can use
> 
> 	btrfs prop set /dev/... allocation_hint data_only
> 
> but I admit that might be because I'm weird.

I prefer the echo approach too; however it is not very ergonomics in conjunction
to sudo....

> 
>> If we're going to use device->type for this, and since we don't have a user of
>> device->type, I'd also like you to go ahead and re-name ->type to
>> ->allocation_policy, that way it's clear what we're using it for now.
>>
>> I'd also like some xfstests to validate the behavior so we're sure we're testing
>> this.  I'd want 1 test to just test the mechanics, like mkfs with different
>> policies and validate they're set right, change policies, add/remove disks with
>> different policies.
>>
>> Then a second test to do something like fsstress with each set of allocation
>> policies to validate that we did actually allocate from the correct disks.  For
>> this please also test with compression on to make sure the test validation works
>> for both normal allocation and compression (ie it doesn't assume writing 5gib of
>> data == 5 gib of data usage, as compression chould give you a different value).
>>
>> With that in place I think this is the correct way to implement this feature.
>> Thanks,
>>
>> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
