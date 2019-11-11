Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 327D7F712E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 10:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKKJtn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 04:49:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:41343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfKKJtm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 04:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573465781;
        bh=l4MOzDxBFm9nRWqVBJ5Q7cD/l943t5TTf6bMOLeQRM8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=O5OlT0QdBMa+UEWpRMVJtixDJ9MnzsY+u+EHPnlB1R17LURa2d5nkecixKGisPVKg
         EXiwyA1CQWegxkNs/RRYkxMdT6T5ghbLWnPvsOuo9IbcGwywHLcz4OnlRibVNsbVX0
         bZZmiipXaJVNSa5o4EJA7ptPyNQYS0LWnmjBim+Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.167] ([34.92.246.95]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MV67o-1iMynN3dBu-00S6kA; Mon, 11
 Nov 2019 10:49:40 +0100
Subject: Re: [PATCH 1/2] btrfs-progs: add comments of block group lookup
 functions
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191111084226.475957-1-Damenly_Su@gmx.com>
 <97915605-5df1-ab83-ca98-3133b0648df9@gmx.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <bf2131c4-c780-a66f-8963-452082438375@gmx.com>
Date:   Mon, 11 Nov 2019 17:49:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <97915605-5df1-ab83-ca98-3133b0648df9@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QXHGNYzIXjTHmW9NZAOPoSy7KAnbj9RS3lTxfiCvbcxaVNdCI0h
 +udqh5HGcXBUOmUjJbM1yG6LOyWKCN+mPnEjR5bCeDdTx/p6uY7k/9ZUpDAL08WD/Q3cOql
 oZocJ+VCeYVPJ+4PZZ6T1vFqmz/X2lzSzsQFomvsLKLY1wlrCEUY/9Tgg5x0j1fwTj2J5qb
 uXunxfB7zmZLJD5LWIwZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eClBEUSMM2Y=:BV8bpJmYTIq53rDU3odKBE
 hkvlZvXYuQawqMk0939qWxwSQlS+FTc6P5Z8fK5UqXhYpNK8THHmmP3qOJJN4Pjag7/GPm/zd
 TEXnjUZSSbbBmnMYpddWvyStxR+EyM8UmuE2+9ELeoOQfwIuLOcczBBFaUEfdS8KUZEKdC5FG
 yANArkqR6XS3ZCW/e/w28ftAJQA6Ag1FfNpg82QtFozU89pzNbeU9BXVCLDZ17J6CaQb3KBdB
 ICHzUlOiZuKBHDD9WudV4WYWUcBfjg/9PbcrWE1xvhf/vPrO5vhYT0QInWCvFRGIESclgOu4V
 DIo1NUWgPv2do1jxCCe90pwnFFRs2NeZU6FXhbaRH8Tgli3VC09bk4GVKhxwRBi8fVfQyoflp
 WaeCZ4pIrQ3mRUJszuks/VRHz27+A1szQ8zBQFPyDMr+NQQ7VtYURZBkOzR5tkgwIqXM40bnD
 2+41sZTmQBqwUW7UQuyxfXqM6jsTXcDJ+bvbGmwiDUoceUMZCR/DCfCpaWLkT+v7QLXGcaD3I
 gpsf59fjRKBegg+2+yNgLHQirPruBCfiir5in9ejfQObUyKMW52qjBP3wOfy9VKQpS6wqrm+y
 1SiEg9r/WYcll/oHURJiieO1By8rqx7TS3aYZObM6zpdP0yrbyvw7n5p2M/HYObis9V1q0p1K
 Di1ZHHe8A5F6PPIfWNBG8vACd0KuagB3uRTG4mgM9jAGwF8R+XbGj74BIfEV/uXwfbzn2Zr6F
 YYYYtC5pMjmAt8Bub7fpiKurwwYH3RFt6LMgS/kfNhA2pKTNpSNMhUfWZe+Gntu5th8sOG8Rg
 LERh1h5+imIx2QfN2Ye2NK23F0LyDph9ksbpBb2DuTt8n90YB9pnw46cbOXvucvEwjD0ghtOi
 oXsakwv/ikng0vJo13+Mb1ZCa6/HYPHqKQgf9gcPgUfwnBqHQwwPOihr0AUxAU+UVC4n5ikJE
 WFg4X1vOI7K+aPhNDrXa72L2VrR7ZwDZuvz7BLFgnsiKgw/86JLmBzV7lzFakykpr60/1D8nh
 QVUilE6aWSwY20YrYoSQy+qtpiQOpvP94jFc9HkKeYXdmai/cWTq5MuU4/bYNr1Qtb+3T588A
 AJP8gHPKKcfwMpP7PWs03zKNjSeMiMdr5z1Vi6sxUaYIVHovm92PCXdvB8apfklGaRq8n2ZgV
 jPKrSpfiRJdZFtz+MqJLV9aDBeYe329C6nKLLP3hquSOkglTc/3dK+yeQq6m4C3YG9oWxEZ3s
 Wav+0UWQTSd81tUxeQTMRBaf5XoOUiHORFnS/wuRLzL3GUM0V+R5e12unCtM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/11 5:28 PM, Qu Wenruo wrote:
>
>
> On 2019/11/11 =E4=B8=8B=E5=8D=884:42, damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> The progs side function btrfs_lookup_first_block_group() calls
>> find_first_extent_bit() to find block group which contains bytenr
>> or after the bytenr. This behavior differs from kernel code, so
>> add the comments.
>>
>> Add the coments of btrfs_lookup_block_group() too, this one works
>> like kernel side.
>>
>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>> ---
>>   extent-tree.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/extent-tree.c b/extent-tree.c
>> index d67e4098351f..f690ae999f37 100644
>> --- a/extent-tree.c
>> +++ b/extent-tree.c
>> @@ -164,6 +164,9 @@ err:
>>   	return 0;
>>   }
>>
>> +/*
>> + * Return the block group that contains or after bytenr
>> + */
>
> What about "Return the block group thart starts at or after @bytenr" ?
>

That's what documented in kernel already.
The thing I try to express is "contains".
For such a block group marked as B[n, m).
btrfs_lookup_first_block_group(x) (x > n && x < m). Kernel code will
return the block group next to B. However, progs side will return the
block group B.

Thanks.
> Thanks,
> Qu
>
>>   struct btrfs_block_group_cache *btrfs_lookup_first_block_group(struct
>>   						       btrfs_fs_info *info,
>>   						       u64 bytenr)
>> @@ -193,6 +196,9 @@ struct btrfs_block_group_cache *btrfs_lookup_first_=
block_group(struct
>>   	return block_group;
>>   }
>>
>> +/*
>> + * Return the block group that contains the given bytenr
>> + */
>>   struct btrfs_block_group_cache *btrfs_lookup_block_group(struct
>>   							 btrfs_fs_info *info,
>>   							 u64 bytenr)
>>
>
