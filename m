Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5421C124534
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 12:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRLBz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 06:01:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:45245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRLBz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 06:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576666913;
        bh=OtBMfeHKxsKENqq+ye21Ig2Ym9NjWLa9zsvfdx/+lnE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=E20gNVtbhF0E7MaXsf+9HEh0X8ZzkSCZ2odtxX6R7sciIK0pCEB8FWEWUNxshGFpV
         5yQntSCWzn/AkMDzsvN8eoLqsC5TBNkCEc8SjUFggyjvq3Z8mFuhsKttd1ZxyHN24Q
         tpjFxSm6haRTwKrteNBtaIZoHx6jlJBXRBaW1RkA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.178] ([34.92.249.81]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MysRu-1hm0ag1xKM-00vy07; Wed, 18
 Dec 2019 12:01:53 +0100
Subject: Re: [PATCH V2 05/10] btrfs-progs: adjust ported block group lookup
 functions in kernel version
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
 <20191218051849.2587-6-Damenly_Su@gmx.com>
 <b87626bd-911c-8fcd-4713-58968458e078@gmx.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <b0a7e353-5745-5f1e-c9c7-e6bda3fe8ae2@gmx.com>
Date:   Wed, 18 Dec 2019 19:01:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <b87626bd-911c-8fcd-4713-58968458e078@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DVckzpeU/au+6FouNQcphOwMSLgsHnbNEumQpySgsk46G1VFXbv
 Wo7tukP8YjomQh0QnrRVSLHQEoUfvK6sU9ZI+VYdfYSQrAsG1dBqWvqjb229pqjCGUy94Aq
 Io5pOeYSxiMuTGPySsQnLHfdmE7/MVwN60j8LXehqR2xs2mlTqWF+ADQW39teL2Y8u6VnWb
 E0iMXMu01ZJUCeR6vs+4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n6VYSPvc43w=:M9cxKWVOPk9xlwW7ERVjAa
 JMbhpKYbn14mCbfRmylFBIeNJ9PlzKqKgmTe5g0noSuTCjafBaUdYpdyiCUVJqelRrxWHEt8N
 8mHgZ1jzf2XWLkrvXzKIAim9yjFBBPCvBnxXlFTV/SHUHLROvADZhMCgKs5wMjEaQMfpEeOvX
 afEl3Ns3rLnmthMWa3LhjERFKaK2dWN+Pr8Jnn5Gr2SKmHpFje6lLIatkStbRyd6GJgxjMO9w
 4dUUQ3ZDzwojLeIiWbLUl0wDbzeuKBw6ZMBZYXjLx7mRZd4v4QKu9Y5vUp1hPs4TqP4DnZgkc
 6namkyABkyKbe3HkPZdQE36ejYpoASXRUx7R2GrP26H1rPtZ5VAZskshWxVy32gjjT7bfgCHL
 lgDeVjutWPq6hvM3z67b39UaAwGeyUrmWr3IH0aTt/mx64k0kSMAT9xdyftZJSV1k1GfaqhWW
 dLXLDewwDYboCdhmW4clZJaM8ZhuH6sWeTAfApzATFDpcwRlVkiwyRdeebwILNDbhGEU4h/y/
 2WB4YmCz7pYA00jyQnOL9Jo1oM5hl4mpszNNBxjHgBXDVHSn+mkoCuHfe6olDeS8ruVOlLSFU
 YkMY/RKjIui+F99yv/t3mF+Bl+OQyV1D1B3M0bmSLHrqAFc3FIMdLVghdAJ9VPiwXw/9FqJqQ
 m1l3tUqYisHGDaPxsU5f45CXPZOCSHvvYtDYqDo2zgQvMf2CN96Kg/DU4Az3twif2LG08ZBNN
 4nHi4y+00+5xDzrt+i3vSf81PE+TLdU5cORMQnL86RfMiqtsEjHQ72i7xgpGxzC8nSWMut93e
 FZfkOuj/6JMZGzeZZh0pl3+QDtOmFUXLW3pcdhtZB5NKxxPXBQHKik8l3iIBS95ChCk+Ukhet
 hgY7mTfhfojaNiMz0gFArXytGkEHpE9m7gRdNFQyDgTpWmPkbw23DIH2fC6ZAMbNRsZsfKH/x
 ddMNBeuEptoIwtevstmtyWlccomhwjk+H82iObHIVFBuao2cOmvbdDjlL5pT6RWsyru3iHADY
 y19OHHmCPvY58oHP39mmrbzjmhW3FA2GPuYshv/HC93mLOrwzE0fIWaj393Xd8mLa1L9ite0O
 s8UFQ5oFjHoIe7vsQnYj1hMiQ8nfonVCc06x+uuwPZdZXXSwkewfrGNfc71p1uwBJ/4wWDPdI
 faIBvo+v+BKagSGYjBM72XO9kiRy4pIzLcYgeFbHgRzz40XVdjSkshnqFXq5oE4PuITUPrtxh
 U1cr9LmKgrEGIMyqPTtualC7DP00jlcLx/qjqF8crV/ExaWQWcauOiKQ5NbU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/12/18 5:52 PM, Qu Wenruo wrote:
>
>
> On 2019/12/18 =E4=B8=8B=E5=8D=881:18, damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> The are different behavior of btrfs_lookup_first_block_group() and
>> btrfs_lookup_first_block_group_kernel().
>> There are many palaces calling the lookup function include extent
>> allocation part. It's too complicated to check and change those.
>> It will influence many functionalities in progs.
>>
>> So here, just make kernel version lookup functions run likely in
>> progs behavior.
>>
>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>
> It should be folded into previous commit, or this will break bisect.
>

Oh, will do.

Thanks for your review.


> Thanks,
> Qu
>
>> ---
>>   extent-tree.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/extent-tree.c b/extent-tree.c
>> index fdfa29a2409f..3f7b82dc88a2 100644
>> --- a/extent-tree.c
>> +++ b/extent-tree.c
>> @@ -238,12 +238,13 @@ static struct btrfs_block_group_cache *block_grou=
p_cache_tree_search(
>>   }
>>
>>   /*
>> - * Return the block group that starts at or after bytenr
>> + * Return the block group that contains @bytenr, otherwise return the =
next one
>> + * that starts after @bytenr
>>    */
>>   struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel=
(
>>   		struct btrfs_fs_info *info, u64 bytenr)
>>   {
>> -	return block_group_cache_tree_search(info, bytenr, 0);
>> +	return block_group_cache_tree_search(info, bytenr, 1);
>>   }
>>
>>   /*
>> @@ -252,7 +253,7 @@ struct btrfs_block_group_cache *btrfs_lookup_first_=
block_group_kernel(
>>   struct btrfs_block_group_cache *btrfs_lookup_block_group_kernel(
>>   		struct btrfs_fs_info *info, u64 bytenr)
>>   {
>> -	return block_group_cache_tree_search(info, bytenr, 1);
>> +	return block_group_cache_tree_search(info, bytenr, 0);
>>   }
>>
>>   /*
>>
>

