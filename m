Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7C815700E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 08:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgBJHpt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 02:45:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:34702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgBJHpt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 02:45:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 17AA2AE4E;
        Mon, 10 Feb 2020 07:45:46 +0000 (UTC)
Subject: Re: [PATCH] fstests: btrfs/179 call quota rescan
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <1581076895-6688-1-git-send-email-anand.jain@oracle.com>
 <1fae4e42-e8ce-d16d-8b2f-cada33ee67bf@gmx.com>
 <580c99c8-dcfd-d12b-6ede-7636bf404d32@oracle.com>
 <e4a8a688-40bc-c88e-7ccb-ca7c958fc457@gmx.com>
 <84b66420-4c4a-93b9-52af-37e85a343773@oracle.com>
 <73b9d157-840b-b93f-b86a-5041745f08ce@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2937988f-3ebc-8cd8-a6dd-82648faf126e@suse.com>
Date:   Mon, 10 Feb 2020 09:45:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <73b9d157-840b-b93f-b86a-5041745f08ce@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.02.20 г. 3:36 ч., Qu Wenruo wrote:
> 
> 
> On 2020/2/8 下午5:06, Anand Jain wrote:
>>
>>
>> On 2/8/20 7:28 AM, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/2/7 下午11:59, Anand Jain wrote:
>>>>
>>>>
>>>> On 7/2/20 8:15 PM, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2020/2/7 下午8:01, Anand Jain wrote:
>>>>>> On some systems btrfs/179 fails as the check finds that there is
>>>>>> difference in the qgroup counts.
>>>>>>
>>>>>> By the async nature of qgroup tree scan, the latest qgroup counts
>>>>>> at the
>>>>>> time of umount might not be upto date,
>>>>>
>>>>> Yes, so far so good.
>>>>>
>>>>>> if it isn't then the check will
>>>>>> report the difference in count. The difference in qgroup counts are
>>>>>> anyway
>>>>>> updated in the following mount, so it is not a real issue that this
>>>>>> test
>>>>>> case is trying to verify.
>>>>>
>>>>> No problem either.
>>>>>
>>>>>> So make sure the qgroup counts are updated
>>>>>> before unmount happens and make the check happy.
>>>>>
>>>>> But the solution doesn't look correct to me.
>>>>>
>>>>> We should either make btrfs-check to handle such half-dropped case
>>>>> better,
>>>>
>>>>   Check is ok. The count as check counts matches with the count after
>>>> the
>>>> mount. So what is recorded in the qgroup is not upto date.
>>>
>>> Nope. Qgroup records what's in commit tree. For unmounted fs, there is
>>> no difference in commit tree and current tree.
>>>
>>> Thus the qgroup scan in btrfs-progs is different from kernel.
>>> Please go check how the btrfs-progs code to see how the difference comes.
>>>
>>>>
>>>>> or find a way to wait for all subvolume drop to be finished in
>>>>> test case.
>>>>
>>>> Yes this is one way. Just wait for few seconds will do, test passes. Do
>>>> you know any better way?
>>>
>>> I didn't remember when, but it looks like `btrfs fi sync` used to wait
>>> for snapshot drop.
>>> But not now. If we have a way to wait for cleaner to finish, we can
>>> solve it pretty easily.
>>
>> A sleep at the end of the test case also makes it count consistent.
>> As the intention of the test case is to test for the hang, so sleep 5
>> at the end of the test case is reasonable.
> 
> That looks like a valid workaround.
> 
> Although the immediate number 5 looks no that generic for all test
> environments.
> 
> I really hope to find a stable way to wait for all subvolume drops other
> than rely on some hard coded numbers.

 what about btrfs filesystem sync?


<snip>
