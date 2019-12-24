Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60DD129EEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Dec 2019 09:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfLXIU5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Dec 2019 03:20:57 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:48852 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726065AbfLXIU5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Dec 2019 03:20:57 -0500
Received: from [192.168.1.38] (lfbn-poi-1-151-241.w86-233.abo.wanadoo.fr [86.233.118.241])
        by box.speed47.net (Postfix) with ESMTPSA id AB89EF3C;
        Tue, 24 Dec 2019 09:20:52 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1577175652;
        bh=aAxTv746K6N9rAIYQlwjioJT/hkWtDjDKrsRPR5/UPA=;
        h=From:To:CC:Date:In-Reply-To:References:Subject;
        b=JpFomu3arUW0gFowoN5p5RtoLaOdon2YNxJULz/mBaVPFT9GYLjWt1FPUgFTnZRlx
         ENJT5486rgGI1UAGba8CdFEiykkA0/ccEq2wafcb8qjalwJzq13weEsSMbhxCMm+7D
         a3AuvDDO3f19FvKE0fdxGw0io7WSu2u0rj03tSC4=
From:   =?UTF-8?B?U3TDqXBoYW5lIExlc2ltcGxl?= <stephane_btrfs@lesimple.fr>
To:     Wang Shilong <wangshilong1991@gmail.com>,
        Hans van Kranenburg <hans@knorrie.org>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Tue, 24 Dec 2019 09:20:51 +0100
Message-ID: <16f36fe8ed0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
In-Reply-To: <CAP9B-QkL60aELFZzOzZStbAz2UWj11V8YNPtSWWgwzeEnbLpvQ@mail.gmail.com>
References: <16f33002870.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <fbf7c50b-fc02-bf51-b55f-6449121e7eec@knorrie.org>
 <CAP9B-QkL60aELFZzOzZStbAz2UWj11V8YNPtSWWgwzeEnbLpvQ@mail.gmail.com>
User-Agent: AquaMail/1.22.0-1511 (build: 102200004)
Subject: Re: Metadata chunks on ssd?
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Le 24 décembre 2019 03:04:34 Wang Shilong <wangshilong1991@gmail.com> a écrit :

> On Tue, Dec 24, 2019 at 7:38 AM Hans van Kranenburg <hans@knorrie.org> wrote:
>>
>> Hi Stéphane,
>>
>> On 12/23/19 2:44 PM, Stéphane Lesimple wrote:
>>>
>>> Has this ever been considered to implement a feature so that metadata
>>> chunks would always be allocated on a given set of disks part of the btrfs
>>> filesystem?
>>
>> Yes, many times.
>
> I implement it locally before for my local testing before.

If you happen to still have a couple patches around (even if they dont 
apply cleanly), I'm interested!

>
>>> As metadata use can be intensive and some operations are known to be slow
>>> (such as backref walking), I'm under the (maybe wrong) impression that
>>> having a set of small ssd's just for the metadata would give quite a boost
>>> to a filesystem. Maybe even make qgroups more usable with volumes having 10
>>> snapshots?
>>
>> No, it's not wrong. For bigger filesystems this would certainly help.
>>
>>> This could just be a preference set on the allocator,
>>
>> Yes. Now, the big question is, how do we 'just' set this preference?
>>
>> Be sure to take into account that the filesystem has no way to find out
>> itself which disks are those ssds. There's no easy way to discover this
>> in a running system.
>
> No, there is API for filesystem to detect whether lower device is SSD or not.
> Something like:
>       if (!blk_queue_nonrot(q))
>                fs_devices->rotating = 1;
>
> Currently, btrfs will treat filesystem as rotational disks if any of
> one disk is rotational,
> We might record how many non-rotational disks, and make chunk allocation 
> try SSD
> firstly if it possible.

My first idea was a preference to be set by the admin himself actually. A 
tristate that would be set for data chunks and for metadata chunks, for 
each device. Something like:

- "never": never allocate this type of chunk on this device
- "default": keep the current allocator behavior
- "always": consider this device first when trying to allocate

The allocator would then run in 2 passes max, like this:

- try to allocate considering only the device tagged "always"
- if this fails, try to allocate considering the devices tagged "always" 
and "default"

For my setup, I would use 2 small SSDs set to metadata=always data=never, 
and the other rotational drives set to metadata=default data=default.

If we want to autodetect things while not being too invasive, on fs 
creation and on device add/replace, we could autodetect the rotational 
status, and maybe set data=default metadata=always for non-rotational 
drives, and data=default metadata=default for the others. This would 
enhance the overall experience without getting the user potential "out of 
space" issues he wouldn't expect.

Migration from a previous preference-unaware code would see all the prefs 
set to "default", without adding a incompat flag as being 
preference-unaware doesn't break the filesystem.

-- 
Stéphane.


