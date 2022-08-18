Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211DE597FEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 10:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiHRINa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiHRIN3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 04:13:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BA2356FB
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660810400;
        bh=D6HdVqD9ID+tX1jF06feSsh9Jm+zip1iAuQMXyKSgUA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AsAqvPo4r2MAy2VCW+7xFauRJAEuBWIhi3PlT/+xhg2AJ8P5NbIjHBE4sk3B4YhvZ
         g65w9sLhrNH5vy0r6JPnjk8VCCunEThHvpQotHjXlmcP2Wf+yVkxCGI6QV7YR9K/0/
         rL3TuUx9xqi6KSCeAOIaWqKlVFhNDbP52OF9uIMA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4hvR-1nNvYW2IqN-011jr0; Thu, 18
 Aug 2022 10:13:20 +0200
Message-ID: <69f30de8-0d1d-4ada-c563-6f88bc4a4f40@gmx.com>
Date:   Thu, 18 Aug 2022 16:13:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] btrfs: fix the max chunk size and stripe length
 calculation
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <17e7c38b0cc6fe90c90f4b383734c06eafd2f9b5.1660806386.git.wqu@suse.com>
 <20220818160425.511E.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220818160425.511E.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TLOfWUuMfJsZBrDyVORp0Bi32UJmAR7UBU3KQCFLPAPKrdtZqg1
 3duwO1bEKmDIbI+KjombsDQhmzWzGpOBomDNAEhSr8CFiDqT9MVCkshlEOI8ArlUiY/hjWG
 qTuqBIwRhW2++VQT05tdCBb5a/44Li2B4Qx1HomFhVGF4YiwNTRDpf1aWZXomzpADteKgha
 wh3JhZoSiN/O5/4BkBb9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x6ZK89kl8XA=:j/7JlLPlanbsSYftUiauCH
 WWRALV0vID3Kw0kj7LzNggl345xlqG+PiKl7bxEVE06yTdzbBzUFULpRFwBoMpXGOM8Y4eZPU
 6BeJDtyFfYCUWhwwOkq//xR1/xRM7NHHc+V+Mk9cx0XxHv/oNOaNgVf1zTKa17R7qkPEa2V8n
 Z7cAJymXvtADrk+x1bZ/Al5kKHIlFn7SPTVeJoK40XZlOAEM17vj1u+odlrG+2x6GAz9v2v36
 1gMxUCCw8WBA+c0/VRB5lkQ2+jaHToVqYKGDb/9cKc4+yTbD1tKWBAJ8i/Q/wQ3CoYIFX8rkV
 23Aqc5EiZrOzb3nV+agmLrbsq3xTD3EH1ATQFKPJmLv+70K5rzVxWPUisYhxr0WLuDEmK9g6p
 s5rRGSck0PLvypDMZD+cxSXddgwplat2MR+U/jE+u6na0Egroc1jP4FwFMUkHBP6sf4mjdxS+
 MB3bKiQXlbD05b91OmShYyMmE3NvASlMe3N/trTkLCJXa3hrZ8K9EpF5fbTj5TFKxE+lE2kbN
 rv/VNK+Nl7uQpc9KRq3oZQ2Vlbh61posikGF6GmNHfJ+MI1svujkQGKt8ywlfPeUIzm1TBSoz
 QXD0yD7NlI5nomoIPKbXG5ExDD0FfYkLnlxC8piu/4lOJSIXiVO3R7Hca0KvLjYXHVRz5N7XM
 jSBz2oAAP2S4tkL5HN8WKskiR8zXAc49+Qt2RoLikvSXcU5w3AMMzZERvniHeFl20hGnjq23C
 olcIUtu+gk8KpNYjFOi83X7/51rwb8IjBoSwWJrF3fjxiO8o5B9pB0uMWlLYC3oqINLcGe5SP
 sghoGBsd/RsIvaxb9pfYJ4fVq5SDtjYQVQ+W6XH6p2NO+BBcVtmnd1gJt+M2P9hxTu17Xd6T4
 7nYMEC7P9iQ8j3du+Otpluvy3xV0NyQT/AdGm4f/QleyJhGJ4PCE7IKL8zeQjtSBejzxNlAs/
 M9dj72IxsokDVZQoa1u7UEe2YA3CizGyEZXq+NyWQZFXCBzNAIr7INCgl3j/uKWDVHA8sUHCE
 etprDECvT521QqkcUEt4tnLjSs2DOuMaCvv/fVN9ZU3pN3ZCJdCThAF8RRs5o1fRwAeWdppdV
 trotrFAdEd/7g3uiIHW0zpUSvrF1Jr0QirbXLKbc/dtCRl3r2UpXnmqzw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/18 16:04, Wang Yugui wrote:
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
>
> Currently we  limit  the stripe size to SIZE_1G.
>
> Is there some technical limit such as 'used as signed 32bit, so max
> SIZE_1G or SIZE_2G?' or 'used as unsigned 32bit, so max SIZE_2G or
> SIZE_4G?'

AFAIK the only problem with larger stripe size is for unbalanced
data/metadata case it will be harder to reclaim block groups.

Other than that I'm not aware of certain problems related the stripe size.

Thanks,
Qu
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/08/18
>
>
>> +	ctl->stripe_size =3D min_t(u64, ctl->stripe_size, SZ_1G);
>> +
>>   	/* Align to BTRFS_STRIPE_LEN */
>>   	ctl->stripe_size =3D round_down(ctl->stripe_size, BTRFS_STRIPE_LEN);
>>   	ctl->chunk_size =3D ctl->stripe_size * data_stripes;
>> --
>> 2.37.1
>
>
