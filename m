Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519D469A57C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 07:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBQGJB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 01:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBQGJA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 01:09:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D0659710
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 22:08:58 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxUrx-1oeCwv1eob-00xtoe; Fri, 17
 Feb 2023 07:08:48 +0100
Message-ID: <a32e3b63-8ea2-4c66-7e88-cb0fb1edb241@gmx.com>
Date:   Fri, 17 Feb 2023 14:08:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Stefan Behrens <sbehrens@giantdisaster.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
 <Y+sy5xHfz6S16/oc@infradead.org>
 <e7a2cb06-d6b1-f40b-477a-dca130a4a5d2@gmx.com>
 <Y+x+GjgREMyYe5pP@infradead.org>
 <d2f73a10-7ec8-0b42-1a4e-eb86b0740741@gmx.com>
 <Y+yCncfD0EyfsxTe@infradead.org>
 <7f78db15-7f82-5349-a4da-6fa58365e3e0@giantdisaster.de>
 <538f28aa-66e1-8c9b-85ef-151e058b35dc@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] btrfs: do not use the replace target device as an
 extra mirror
In-Reply-To: <538f28aa-66e1-8c9b-85ef-151e058b35dc@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ptfQ+HRQaiedXVqXnvDag5SJoxrikXUU1da6W14+zej/aN26wpv
 UdU0T2ouKvkIcC3xW4WzFRbMUIc3FEXXx77DesvqmZUhplSeM6szRIYtKIRkHPJu5eAFvra
 5Ku2LvzyhefO4iRdAxcDff21TXcuv2Lzj2HYS6WJQ18fNT9R+9hkrDOI7kplFNVynV+Unvx
 ISw5+1JtnM+0uxaLWKQcw==
UI-OutboundReport: notjunk:1;M01:P0:DCaYPmgRFdg=;0z01BF8wMTQG2LplIZz/gk21GVM
 0kBwBFtmcjpOeaR3Wiy1dt7KvK7ynCuICmG8YnAndB6LG6ar7toMGvjsvoXy9/g7oylc2RolF
 E47H/85L0emr1zITkrlu/k6gkuIFg6SqstjtXZ2e8YtjmZkzFFo7n6xWuoUWRsK/Rw8P2U0x3
 zknE/Bjrxu6qvwkWx6ND9p9U1fKgH2CxZhHLfDfyBlMJ0F9Sp4KqiHCTQNxEPjKIypX807eC+
 jqZ2nvri+ltI+VLnyoHilqmgJAaQR8fsOQAyZbLx1bPTrFLw5S/O7/1yMMrIky3TMiFI+EfTF
 dQHcvrDE2KhRja+4o2HiE2gjUfEtVMwm4o10o4Z/elDDuRAlOilQfrC8NfDBBWhkYWFsW/sgi
 +DCrvqKkfKwa2jKd5uVG8ol7E8VkV9NKTAZXazYYbBnZ8vcq3MoXSrRZ+u0YPd6OeWPd+IjrI
 YwQojB/9N6wY4H6Jgoh3osqykfoZQiB0oYRNezITRK6GiMhM9+8wEYBPZVAM3+jV8Fvz0EoR8
 svVJd9VeTxx2u4JeSvku6f2rNhq9zJajFz44HgbXXjyJEUlkoeOl0f8gSvMWPIcNoWeX7WuYg
 LEgXyu52XPuxM2LeXIm81q0Z/DBsNGJzhXR4e9U7sVTzqLOIBAFA4XgOqccrgp9VmEjRGtJvy
 G3jhYpdX5FKzCfQ4hw04zBl0Ty/cO5/JB9+vz7azKBHUJsWscqUpicGcLfjGuS5wRwJC8W3Ny
 KT7P1zKlTb4jJSWAxCnNrNvITdsIE0ZJTh5DS8pkIX/Q35I7DLwfqEzGcdgMjQTDYDU1zeDa7
 3OPShAv0vN6fguMRNdPvxNkRpi6utNR/JSrPF2/Etd1CEAhYVuZca0/yDxABbA47mqDVgoy8Z
 3yLa0Vy/fwiHFKHIS7pj6sw2MCV8GNLgcgRaIA03oC7pW2kqZctuZm0uvhWb7eCTE7FMhKuwY
 Hb+VcG9uCQbkEdNG6h7HHKU2SfY=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/16 08:29, Qu Wenruo wrote:
> 
> 
> On 2023/2/15 21:58, Stefan Behrens wrote:
>> On 2/15/2023 7:58 AM, Christoph Hellwig wrote:
>>> On Wed, Feb 15, 2023 at 02:56:39PM +0800, Qu Wenruo wrote:
>>>> Meanwhile replace hasn't yet reached that bytenr, thus we're reading 
>>>> garbage
>>>> from target device.
>>>> And since NODATASUM, we trust the garbage, thus corrupting the data.
>>>
>>> Yes, for a read from the target device to be useful, the progress
>>> needs to be tracked, and the read only needs to happen on data
>>> that actually was written.
>>
>> The device replace code maintains (or used to maintain) a concept of a 
>> cursor.
>>
>> There's a small area on the target device which is currently written 
>> to. Left of this area is valid and already written data, which can 
>> also be read in case it's needed to fix read errors or to avoid access 
>> to an almost damaged hard drive which tries to reread every bad block 
>> 2048 times (which is 17 seconds at 7200rpm and something you want to 
>> avoid). Right of the area is data that must not be read because it is 
>> garbage and uninitialized contents of the new disk.
> 
> So the main reason for the concept is just to avoid read on the damaged 
> device?
> 
> Is there any real world data on the behavior?
> 
> I don't know which commit removed the cursor, but considering the extra 
> work needed to properly handle the cursor and only provide the extra 
> mirror on the correct condition, I'm not that convinced it's a total win.

BTW, the current code, find_live_mirror() itself is already following 
the DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID, to avoid the 
source device if needed, no matter if we have a cursor or not.

Thus even we get rid of the target-device-as-extra-mirror behavior, we 
can still avoid reads from the source device (at least for read-repair).

Although the scrub part doesn't seem to care about that at all...

Thanks,
Qu
> 
> Thus I'm more towards dropping the behavior.
> 
> Thanks,
> Qu
> 
>>
>> There are several comments about this concept in volumes.c. And 
>> scrub.c is the place that keeps the left and right cursor up to date 
>> which define the area that is already written, currently written to 
>> and not yet written.
