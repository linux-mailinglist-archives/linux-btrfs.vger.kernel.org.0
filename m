Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2BF12A17C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Dec 2019 13:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLXM66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Dec 2019 07:58:58 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:45184 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbfLXM66 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Dec 2019 07:58:58 -0500
Received: from [10.10.173.205] (unknown [92.184.110.217])
        by box.speed47.net (Postfix) with ESMTPSA id E4000F3C;
        Tue, 24 Dec 2019 13:58:53 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1577192334;
        bh=QwvUJAMvfmpQKgnpTGHAmW+Trpw62mYfz/06/Sh7Edw=;
        h=From:To:CC:Date:In-Reply-To:References:Subject;
        b=vtkFEUqZeB8Qpp2PrVf75Ag1WKJzTp1A/i8CjXgqTzU3vFZ/5+BYgJekrkSsxVcWV
         qcR4XPxhkkM4A9YThTz0wHjFleESrEqrOLB9j4mJgmBmQHHU0Qcqq8n0H25Gt2/zpP
         N0kEq0fU5uC5/B4Hf4xOLHCRUCWd2o4CKauyae+c=
From:   =?UTF-8?B?U3TDqXBoYW5lIExlc2ltcGxl?= <stephane_btrfs@lesimple.fr>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Hans van Kranenburg <hans@knorrie.org>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Tue, 24 Dec 2019 13:58:51 +0100
Message-ID: <16f37fd16f8.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
In-Reply-To: <8a45940d-6634-e49d-cfde-e7087060c060@gmail.com>
References: <16f33002870.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <fbf7c50b-fc02-bf51-b55f-6449121e7eec@knorrie.org>
 <CAP9B-QkL60aELFZzOzZStbAz2UWj11V8YNPtSWWgwzeEnbLpvQ@mail.gmail.com>
 <8a45940d-6634-e49d-cfde-e7087060c060@gmail.com>
User-Agent: AquaMail/1.22.0-1511 (build: 102200004)
Subject: Re: Metadata chunks on ssd?
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Le 24 décembre 2019 13:40:56 "Austin S. Hemmelgarn" <ahferroin7@gmail.com> 
a écrit :

> On 2019-12-23 21:04, Wang Shilong wrote:
>> On Tue, Dec 24, 2019 at 7:38 AM Hans van Kranenburg <hans@knorrie.org> wrote:
>>>
>>> Hi Stéphane,
>>>
>>> On 12/23/19 2:44 PM, Stéphane Lesimple wrote:
>>>>
>>>> Has this ever been considered to implement a feature so that metadata
>>>> chunks would always be allocated on a given set of disks part of the btrfs
>>>> filesystem?
>>>
>>> Yes, many times.
>>
>> I implement it locally before for my local testing before.
>>
>>>> As metadata use can be intensive and some operations are known to be slow
>>>> (such as backref walking), I'm under the (maybe wrong) impression that
>>>> having a set of small ssd's just for the metadata would give quite a boost
>>>> to a filesystem. Maybe even make qgroups more usable with volumes having 10
>>>> snapshots?
>>>
>>> No, it's not wrong. For bigger filesystems this would certainly help.
>>>
>>>> This could just be a preference set on the allocator,
>>>
>>> Yes. Now, the big question is, how do we 'just' set this preference?
>>>
>>> Be sure to take into account that the filesystem has no way to find out
>>> itself which disks are those ssds. There's no easy way to discover this
>>> in a running system.
>>
>> No, there is API for filesystem to detect whether lower device is SSD or not.
>> Something like:
>> if (!blk_queue_nonrot(q))
>>         fs_devices->rotating = 1;
>>
>> Currently, btrfs will treat filesystem as rotational disks if any of
>> one disk is rotational,
>> We might record how many non-rotational disks, and make chunk allocation 
>> try SSD
>> firstly if it possible.
> This doesn't tell you that the device is an SSD though, just that it
> reports to the kernel as non+rotational. For example, NBD devices
> present as non-rotational by default, and in most cases you do _not_
> want hot data on a network disc.
>
> The important thing here is disk performance, not whether it's an SSD or
> not. An SD card is non-rotational and solid-state, but on most systems
> the performance is going to be sufficiently bad for BTRFS-type workloads
> that it's almost useless for this type of thing.

That's a good point, which is why I think this kind of preference should be 
set manually by the user on fs creation, on device add/replace or anytime 
later with "btrfs device set allocator.hint.metadata always /tank".

Now, we might still want to add some autodetection routine candy to the 
btrfs user space tool, or for mkfs.btrfs, albeit not enabled by default as 
your counter-examples indicate. But that's entirely optional. A manual mode 
would already be awesome.

>
>>
>>>> so that a 6 disks
>>>> raid1 FS with 4 spinning disks and 2 ssds prefer to allocate metadata on
>>>> the ssd than on the slow drives (and falling back to spinning disks if ssds
>>>> are full, with the possibility to rebalance later).
>>>>
>>>> Would such a feature make sense?
>>>
>>> Absolutely.
>>>
>>> Hans



