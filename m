Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E305B0206
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIGKpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 06:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIGKo7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 06:44:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808FB37
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662547491;
        bh=GA/cjhkL2jXRM7nOpiyGOtx+uIrVKXxYICv/FuyvsaI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bFNB2qNy08tS/ZG1wNe9hH4bhpEaM1pF4GvOcmTlNL7IipKWCmyEnbhXQ8rZuA54C
         Cx1pyCSlUFawWvcPpqy7sF5pvvOO9Aj2J39AA9gZdRLELLS7dDx4bdg5eacKrm6Qop
         2EH9qgX7VcOvK3jSQV+f93QToUfUrp5uLHc3UWkc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4z6q-1pWbbi1rbY-010vUH; Wed, 07
 Sep 2022 12:44:51 +0200
Message-ID: <de83ac46-a4a3-88d3-85ce-255b7abc5249@gmx.com>
Date:   Wed, 7 Sep 2022 18:44:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs: fix the max chunk size and stripe length
 calculation
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
References: <17e7c38b0cc6fe90c90f4b383734c06eafd2f9b5.1660806386.git.wqu@suse.com>
 <20220907183750.9FF9.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220907183750.9FF9.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YD9wfNSM5xiijMVMjQ4vqi56VKWuL5dGkXSE07WBaiC3WvIi2yT
 n5moSCI6FDvLSWcoVqE0r1ww+8C8aIxDOTrOkSJV569bojr+ww4e6LypZ9/Rf6rPQOWEDTG
 YiUYGolTu/o0J0TnD5I76d5dsrBlcOq5sTfC4Y2X9HvoMmxloAisaKjrmJYttoG8CFh+kaE
 9jMZ3bX9JczBMIvqK5vIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ZBpbcEX4ws=:V7FEbmTd3ZDegrs56YmlzI
 4fyGmfhIXthLK3r1AkSxRW/RjlAec0SMlijL1nMg6tD4lAudL41c3+TQoUmV1Vn2UrPRn+KKt
 VgGQBZi5lXn6vM4TlbadD0t9PhQ8kdsSnbRZNa6Or+hdYPbZDriZM8kqrF2wvDhWv2PBQ/dbI
 eHmAcdhxgug7/rdEi6HS2dd5Bm8XbJEM7sj2A+aHZI4gJp52qzcZ5JLkLV8mh4WLAu8tGJ5mx
 RIjSMxi/Srd7J5RU3EqiL/u6Zqu5toCiDPUl65miaMNhC6NUOUIIrkTkYPB8jR3OckuDUYBJf
 KMMq/Pwq2JaiRKPFbMXU0tPOx2RbSMCuaVJJ18IogE+KAqkDWuk+SBWR9diK51FN3ZOX/txXD
 6zAyCEKpIMsqX7fHJ7PIHStK5JQFBpKJ7hhB3jywuJU9nyfJ0b2/BbjY6CBhErHWYcZENl6AF
 8PNfigMOfR/f0p33HFP8HH4WmbomywByrlGXKaCOeS1rVRVUUsNSKnHVA0uKI26+3OqMwvSk1
 tAq7/FFqhQi5iRrsQwOV9oApSvZd7buOwS/MLwkbekeeCpDLvkdMKPyqLXh0MOFhJCUIJZ/2X
 xM8e0Iy9EJ25Y8i41loKjBEUnGJcFSNoqcK1Xpk0Oz/AUSNMMHkVts9+SxUdHxfVGUu5Zl8Ra
 3YwV8DIaM5IIn8fE16MNNRnSl9+6siEZZ2i3VGenPa5c2AzEVOW5QpEHZnkOmT/NjhTZtgTj3
 RXuW9vQk0dI4RMGS50UwMjVICH3zal88G9/RkC/Xz1dcc2cP3/4tW/eIGCBZapJqzw8mXtWa2
 rN0Pwzwux3uR44Bc/UPOF7AG9ZSq2fjKOkYjfUgxnxoAvDVv5xDu+uzDtg0b5X4xTDhtSz1Xg
 +In3kQ+4w+M+pBFSR/xkgc46p+UaOQhG7c2GdhmvMM/CvoqKGxRP4wrzEF+WewkeVFayEKwxr
 oy4aGqedzVk3xavpVsF0UE1PqMlm5FwzSn2W84LUGWhzrD9Ture+Kw21eZr6F80nMyVej3lbm
 6GTi6u6Ib9UzH6CIf6q9EcYJl3jpQStHZqr8bdEaBQLzeWDIoe385oqrBpWp6LPueFUlA8wSA
 v4rpAo8D+G+b13GfZ2yD3nxCGwOzJP4OsMwIjYfGApvdwCKJa7xb7qX844OilaSdJwuIt51AJ
 fUC2j77ExlE+Xv0zQE5Ut9lrJO
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/7 18:37, Wang Yugui wrote:
> Hi,
>
>> [BEHAVIOR CHANGE]
>> Since commit f6fca3917b4d ("btrfs: store chunk size in space-info
>> struct"), btrfs no longer can create larger data chunks than 1G:
>>
>>    mkfs.btrfs -f -m raid1 -d raid0 $dev1 $dev2 $dev3 $dev4
>>    mount $dev1 $mnt
>>
>>    btrfs balance start --full $mnt
>>    btrfs balance start --full $mnt
>>    umount $mnt
>>
>>    btrfs ins dump-tree -t chunk $dev1 | grep "DATA|RAID0" -C 2
>>
>> Before that offending commit, what we got is a 4G data chunk:
>>
>> 	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 9492758528) itemoff 15491 item=
size 176
>> 		length 4294967296 owner 2 stripe_len 65536 type DATA|RAID0
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 4 sub_stripes 1
>>
>> Now what we got is only 1G data chunk:
>>
>> 	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 6271533056) itemoff 15491 item=
size 176
>> 		length 1073741824 owner 2 stripe_len 65536 type DATA|RAID0
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 4 sub_stripes 1
>>
>> This will increase the number of data chunks by the number of devices,
>> not only increase system chunk usage, but also greatly increase mount
>> time.
>>
>> Without a properly reason, we should not change the max chunk size.
>>
>> [CAUSE]
>> Previously, we set max data chunk size to 10G, while max data stripe
>> length to 1G.
>>
>> Commit f6fca3917b4d ("btrfs: store chunk size in space-info struct")
>> completely ignored the 10G limit, but use 1G max stripe limit instead,
>> causing above shrink in max data chunk size.
>>
>> [FIX]
>> Fix the max data chunk size to 10G, and in decide_stripe_size_regular()
>> we limit stripe_size to 1G manually.
>>
>> This should only affect data chunks, as for metadata chunks we always
>> set the max stripe size the same as max chunk size (256M or 1G
>> depending on fs size).
>>
>> Now the same script result the same old result:
>>
>> 	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 9492758528) itemoff 15491 item=
size 176
>> 		length 4294967296 owner 2 stripe_len 65536 type DATA|RAID0
>> 		io_align 65536 io_width 65536 sector_size 4096
>> 		num_stripes 4 sub_stripes 1
>>
>> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
>> Fixes: f6fca3917b4d ("btrfs: store chunk size in space-info struct")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/space-info.c | 2 +-
>>   fs/btrfs/volumes.c    | 3 +++
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 477e57ace48d..b74bc31e9a8e 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -199,7 +199,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_in=
fo *fs_info, u64 flags)
>>   	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
>>
>>   	if (flags & BTRFS_BLOCK_GROUP_DATA)
>> -		return SZ_1G;
>> +		return BTRFS_MAX_DATA_CHUNK_SIZE;
>>   	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
>>   		return SZ_32M;
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 8c64dda69404..e0fd1aecf447 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5264,6 +5264,9 @@ static int decide_stripe_size_regular(struct allo=
c_chunk_ctl *ctl,
>>   				       ctl->stripe_size);
>>   	}
>>
>> +	/* Stripe size should never go beyond 1G. */
>> +	ctl->stripe_size =3D min_t(u64, ctl->stripe_size, SZ_1G);
>> +
>>   	/* Align to BTRFS_STRIPE_LEN */
>>   	ctl->stripe_size =3D round_down(ctl->stripe_size, BTRFS_STRIPE_LEN);
>>   	ctl->chunk_size =3D ctl->stripe_size * data_stripes;
>
> Is it a better place to do this SZ_1G limit?
>     init_alloc_chunk_ctl_policy_regular()
> 	ctl->max_stripe_size =3D min_t(u64, SZ_1G, ctl->max_stripe_size);

Doing that won't cause much difference AFAIK.

As in decide_stripe_size_regular() we never bothered
ctl->max_stripe_size from the beginning anyway...

Thanks,
Qu

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/07
>
