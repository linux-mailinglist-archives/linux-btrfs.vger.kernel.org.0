Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C0369D79
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Apr 2021 01:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbhDWXi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 19:38:29 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38417 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244212AbhDWXg6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 19:36:58 -0400
X-Originating-IP: 87.154.223.3
Received: from [192.168.3.4] (p579adf03.dip0.t-ipconnect.de [87.154.223.3])
        (Authenticated sender: chainofflowers@neuromante.net)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id AA11E1C0006;
        Fri, 23 Apr 2021 23:36:17 +0000 (UTC)
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org, Justin.Brown@fandingo.org
References: <5975832.dRgAyDc8OP@luna>
 <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
 <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
 <5494566e-ff98-9aa9-efa3-95db37509b88@neuromante.net>
 <3a374bca-2c0b-7c95-d471-3d88fc805b57@gmx.com>
 <7a02dd5a-f7c0-69b0-0f07-92590e1cd65f@neuromante.net>
 <e179094e-8926-beee-92b7-0885f1665f89@tnonline.net>
 <76971f62-d050-fac2-1694-71d3115e1bf7@neuromante.net>
 <704ad3ea-f795-93c1-3487-c644ea5456d9@gmx.com>
From:   chainofflowers <chainofflowers@neuromante.net>
Message-ID: <dea68577-4f60-afd2-753b-1fec3c13494d@neuromante.net>
Date:   Sat, 24 Apr 2021 01:36:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <704ad3ea-f795-93c1-3487-c644ea5456d9@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu!

So far, I am not experiencing the access-beyond-end-of-device issue
anymore since some weeks.

The new thing I did was:
1. Booted from an external disk
2. Ran:
       btrfs check --clear-space-cache v1
       btrfs check --clear-ino-cache
   on all my volumes.

I had somehow missed this (from man btrfs-check):
> --clear-space-cache v1|v2
>     completely wipe all free space cache of given type
>
>     For free space cache v1, the clear_cache kernel mount option only
>     rebuilds the free space cache for block groups that are modified
>     while the filesystem is mounted with that option. Thus, using this
>     option with v1 makes it possible to actually clear the entire free
>     space cache.

I think, in all of this I had missed that I needed to "clear-space-cache
v1" on the non-mounted volume, as I have always done it while the volume
was mounted.

Maybe this info could help Justin too.


BTW: Could "--clear-ino-cache" have also made any difference? Or was it
just about cleaning unused left-overs?


Thanks a lot for your help, Qu! :-)

Have a nice weekend,

(c)



On 20.02.21 13:13, Qu Wenruo wrote:
> 
> 
> On 2021/2/20 下午8:07, chainofflowers wrote:
>> On 20.02.21 12:46, Forza wrote:
>>
>>> Are you using fstrim by any chance? Could the problem be related to
>>> https://patchwork.kernel.org/project/fstests/patch/20200730121735.55389-1-wqu@suse.com/
>>>
>>
>> Yes, that's what I mentioned in my first post.
>> Actually, it all started with the bug with dm, but some similar
>> behaviour persists even after that bug was fixed:
>> https://lore.kernel.org/linux-btrfs/20190521190023.GA68070@glet/T/
>>
>> The only "maybe unusual" thing in my setup is that I use btrfs on the
>> top of dmcrypt directly, without lvm in-between, but I am not the only
>> one...
>>
>> @Qu:
>> My RAM looks OK so far, I also thought of that, and I actually ran
>> memtest for 12+ hours and more than once. I would exclude that case.
>>
>> I will do a "btrfs check --check-data-csum" and let you know.
>>
>> In the meantime, I thought of a related question:
>> -> When a data-csum is corrupted (for whatever reason), is there a
>> chance that the corruption persists when I copy the whole file system
>> over to a new one?
> 
> You can rule out the possibility that some data checksum itself is
> corrupted.
> Data checksum is stored in btrfs trees, and all tree blocks have their
> own checksum.
> 
>>
>> As I said previously, I copied the whole fs to new, virgin SSDs more
>> than once with "rsync -avAHX", and I couldn't spot any issue related to
>> the copy itself...
> 
> Then you can rule out the checksum problem.
> 
> Thanks,
> Qu

