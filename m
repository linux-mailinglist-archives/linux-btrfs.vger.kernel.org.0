Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D2C5EEE34
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 09:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiI2HAe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 03:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiI2HAZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 03:00:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA375004D;
        Thu, 29 Sep 2022 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664434809;
        bh=MQ9u1VHs47gY1n/Q8/lklOVfT3g0V7cat9t+os+xW7I=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=GVIQ+Nf+MXRA1QpT73T2bJEi7ax4QNq868FRyWNxf8yn3QY7kyMUKzJ7X+lUQzWDG
         ubIaeZDuYY7pmAX9uqph1kKqz6jT0nPO5DZqSU+rFQzJ41egofK7ZwIwQUTW9V+jrs
         MQliQSNoyXz7a3dlUxYs5eHyvHmv0LH2YqfJsVm4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt757-1pWb8T1Cdl-00tXk2; Thu, 29
 Sep 2022 09:00:08 +0200
Message-ID: <8f1adbef-7146-c8f9-92a3-c18e10e9a66b@gmx.com>
Date:   Thu, 29 Sep 2022 15:00:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     hmsjwzb <hmsjwzb@zoho.com>, Qu Wenruo <wqu@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220929014402.2450-1-hmsjwzb@zoho.com>
 <c4293742-06ba-8720-e2eb-d4d3bc4da044@suse.com>
 <18acd4e0-9d3d-77a7-a1de-b805bc259bcf@suse.com>
 <b1687080-a702-e1f7-0fac-e837b0317aa4@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs:remove redundant index_rbio_pages in
 raid56_rmw_stripe
In-Reply-To: <b1687080-a702-e1f7-0fac-e837b0317aa4@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CHXCsP7YN5FnKLr10iu9q7KXMbq1mpofYPqNlfRw5P9j1jvZit0
 cnfjJPpnvrzpxMGRDTk4Juv4oWI75OGJSTJgjb9a1N8iABQF1Ht3xHOxKM/EBwqrqHe8N6a
 G2YECi1zAzLtUsHX+tzX8J5GYYLtlP7qgap9AFrgvAXltDvshOVZc0bftfPc/xEnE8hoAtT
 M1M3mH2bSdaSYInZnXI6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jeURLwcNzEQ=:PRATV2ibZCBVSZjYxe+XHl
 Q/yq8CFWsovYZHWLmJZz2HZbK2dMg2n0BVwD+YuaM8Crc35n39aTO0O346Dab5Tpkf2LvZ0ti
 RaNnZhgOu9NziNur5HqNSwDcTcOXK4tBCqHGHlBVz96eu1XL+/012pB3o878iUmAcM+u7w+uF
 NLW8rF/o9rJm3t7Z742BbZu/bb/DV8cS6vnnYdZOggRRKodh7J5T28dYAA+AtVPRD+tFvRDkx
 5nhNBNYn/3HbhltB8j9Itpdqxulk2d1iUEoe9CH5ykyKHjU6FV02wWHA6rzRpxdF8wihiar/x
 XJ6n99e3o9K3GycIrGAagYzefHLUFoZzvI4ac7a46GsCZfR7FBrAVJF1tcpKXILKgL4HGjFdk
 +JQMT59MzgSlmkVpMA+P8DYaMGnAgTZRB5NB6CPZsRmzv1gAn9Tw3csrdvkBWW6gA1rB2QTOo
 3LKNCJ9WxNxbbg95Cx+Pn/it51xkokI58J6uPPlXJxCjqprF93b8PrFDHnQeCVAUBQrvg/dJs
 IwZjXvhjTGj6I1Q5C2IJtOks1jiDiwlhsKzTsPKzSn5Vzs54xHCyIZrOvQtua6V23KxECf4mA
 FHwmMz0XSqS5HXruyTT1MqQ7ZhTPlb+hkjHPEW/oQZin8pxmGexeYLNy8+BdtJgxSIVFggcHr
 Aq+DFgGNgPj8TgXVyhR5D5MBoYUOdREfhFbdeeACRmf7r58AeyqzyGcPXOqivHJqEtRzLK5u2
 px86ODe66S1VAfh4qHSFuZI+1iclUm92B5scz/FZizMR2UMEWLXFZrEa4oqvmp6boqg/LZqzF
 aytfxkiz4IuIQnd4FSPxHBJFP6QASJKZGAX+KJD1IIh9F1QiM8szxQPElnjbXWLnSg/mSOKiC
 QfRa7lc+y966Cv0vjdHW0SIRYot+XbwXPRvipv5cMNQadIB027SQeZul14wRfw0Rkku0+48BJ
 aHDWlFBK5E8dL0bDoTD9IQjktQafDJFSTtkZRsdzTdNQxCF9SozZpYarsAZCb/EluRKkS/klz
 q+qBgBa4BDX2BTq6U93DqWZ95ax+3ErUAbb9R3PHE4sm9stsozWELJcpw2ip/nxKXV1y3VOMp
 UVglT5ygrLe9YaHwflI01Z2lfs//JtfdK7IbK6zUepgnY8pyzguRbw6b966PeqwIf4R4xmPYP
 drvfA68orrW7v3WI//Hzca85qg
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/29 14:41, hmsjwzb wrote:
> Hi Qu,
>
> 	Thanks for your reply.
> 	Here is my plan about destructive RMW.

The overall idea is fine, but some details need to be addressed.

>
> 	1. Read all the stripes in through raid56_rmw_stripe.

Note that, even we reached raid56_rmw_stripe(), we may still be a full
stripe write (due to substripe writes merged into one full stripe).

In that case, we should not waste IO to read any stripe.

That's what your patch lacks.
(Also all the comments should be updated since you changed the behavior)

> 	2. Do xor operation in finish_rmw.

You may want to do the verification/recovery all before finish_rmw().

The function finish_rmw() is currently the last step of RMW.

> 	3. If the xor result matches, nothing happened.
> 	4. If the xor result mismatches, we can recover the data or trigger som=
e user space progress to fix the data corruption.

For now just focus on the recover part, no need to bother user space.

>
> 	But here are some problems.
> 	1. If the stripe is new allocated, the check will fail.

For now we should focus on data recovery only (metadata will be much
more complex), and for data we will need to grab checksum for the full
stripe anyway.

So in newly allocated case, there will be no checksum, thus no need to
really do any recovery, we just trust all data which doesn't has no
checksum.

> 	2. Is it convient for kernel get checksum in finish_rmw and recover dat=
a?

If not convenient, you'll need to be creative to grab the checksum.

But from what I see, if you pre-fetch the checksum for the full stripe
at raid56_parity_write() timing, it should be fine.

Thanks,
Qu

>
> Thanks,
> Flint
>
> On 9/28/22 23:13, Qu Wenruo wrote:
>>
>>
>> On 2022/9/29 11:08, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/9/29 09:44, Flint.Wang wrote:
>>>>  =C2=A0=C2=A0 The index_rbio_pages in raid56_rmw_stripe is redundant.
>>>
>>> index_rbio_pages() is to populate the rbio->bio_sectors array.
>>>
>>> In raid56_rmw_stripe() we later calls sector_in_rbio(), which will che=
ck if a sector is belonging to bio_lists.
>>>
>>> If not called, all sector will be returned using the sectors in rbio->=
bio_sectors, not using the sectors in bio lists.
>>>
>>> Have you tried your patch with fstests runs?
>>
>> Well, for raid56_rmw_stripe() it's fine, as without the index_rbio_page=
s() call, we just read all the sectors from the disk.
>>
>> This would include the new pages from bio lists.
>>
>> It would only cause extra IO, but since they can all be merged into one=
 64K stripe, it should not cause performance problem.
>>
>> Furthermore it would read all old sectors from disk, allowing us later =
to do the verification before doing the writes.
>>
>> But it should really contain a more detailed explanation.
>>
>> Thanks,
>> Qu
>>>
>>> IMHO it should fail a lot of very basic writes in RAID56.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>  =C2=A0=C2=A0 It is invoked in finish_rmw anyway.
>>>>
>>>> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
>>>> ---
>>>>  =C2=A0 fs/btrfs/raid56.c | 2 --
>>>>  =C2=A0 1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>>>> index f6395e8288d69..44266b2c5b86e 100644
>>>> --- a/fs/btrfs/raid56.c
>>>> +++ b/fs/btrfs/raid56.c
>>>> @@ -1546,8 +1546,6 @@ static int raid56_rmw_stripe(struct btrfs_raid_=
bio *rbio)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup;
>>>> -=C2=A0=C2=A0=C2=A0 index_rbio_pages(rbio);
>>>> -
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&rbio->error, 0);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Build a list of bios to read all t=
he missing data sectors. */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (total_sector_nr =3D 0; total_sec=
tor_nr < nr_data_sectors;
