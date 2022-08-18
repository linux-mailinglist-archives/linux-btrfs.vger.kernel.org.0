Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271D5597E9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 08:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbiHRG0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 02:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbiHRG0J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 02:26:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F38AB073
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 23:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660803961;
        bh=iPYTtTspsmtkRzY6nmTCmZpE5hiDFGlCmxlPcK8Uwuk=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=TysW04ISOgMDj9O1I1xgMQ8wT0+y+GAJCP2+VN4fSCHQPjNDMsabO9cmpSdjTbN/7
         80R135z3UuQ0SBjg+7pfz2YI0K8Tltb2YoRQs1IEgA2SYhPqg456QS2fLJITwdPY6d
         P7k1//kvAI1yiIFrsWj6cmi8uj9k21+FGdXdhIU0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1Obb-1nMrIZ2rfv-012rV9; Thu, 18
 Aug 2022 08:26:01 +0200
Message-ID: <c082f1f0-db71-4f16-43ee-08fd9fb3398f@gmx.com>
Date:   Thu, 18 Aug 2022 14:25:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220817145800.36175-1-wangyugui@e16-tech.com>
 <13f00165-53f8-1f16-7857-8749e21f3fa2@gmx.com>
 <20220818135316.E5CA.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3]btrfs: round down stripe size and chunk size to pow of
 2
In-Reply-To: <20220818135316.E5CA.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+EUaFn+LNtwOKWTmRVE6nI23rSRL88NawJ1jtzjfk/Gvxo29/hx
 I+nys8xPE8Wg4YTRM+K55nP+qeS59S24fBxEOqmZWruzZuPUn80gLOgcqyKz7p+DoWrRyFo
 TyB1iQzHAezZka10XatPo+KuYJDzd5trOrlx5QGiULTm02plYr+7OfLSK8PT62w0ui+5UNW
 J+GIJ+1/nl84K3L/T0otw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ttZ1sWa5S6o=:1urIj/NFQrZHkYlGNNFJ8A
 gRonatGmucBuyH3dJ1sxK/5ydgkeN5P4D/W2E4z1+vFbjxwMaRmGTQAc6rGLCwfiv+cDCfz/5
 dEhKEAHi6d+4SUBd3+VUHMkyw78n6ED5xiLmnTJ6wVSGGWoR9XqV4Si8ykovnY7UHfLhFeeNx
 K6i4QJVDwragSUXSfw4Gih0j0MnuGzDtzsws1ZUVJX/3kUXPGglhNGDT+oxzUVePeAHyChWcE
 bUN/FUJORMcg5w5tXuxZMEhC7H4rGhbZZ6w0FZpgp+mqYCJOPmEqXUELlRe9Qid8E13hp2kak
 xH8UJpfWDT64yIVl6Id46vQd36zRf7B5htcCg6Ha4/kkJqFrHeMIRiHqHMc9CpH9ZvBlJ2y09
 /QJP8tu4u/YTxZOpDZ38FOSkVAdnToZz8cw4IrI5RVe0tIYZXnbSHoaKMkyfvKi+IT6E5QYvT
 O+BK68kmBMvYdOqqLb4IxdJZkbFXKs97gwC+PL4ROZkP9SFUhZ18GHF78lcOnLE4xzzIJ9OyK
 fUmjvzc0On+gtTer/rLcxep/aw7wVi3ejHUJgbBL+22huUU+sJMbmv90MaiMisG1QWPp2YlcV
 DLXpL3oDPkl1Wicx1bbqhYPQMhp2ZSfZ4rAuWoEtN4Km3Nw5YJkBfXSJqLw9NTKxFaONLa1x1
 5+S3gHahlY1csz5A8ejZe8ZxtFRouiEsMAjixXY+KNShppRee/S2acrx9IVge6s87dJyUaixM
 1FMwbirv4bYXwDFSMbipFqPlGHBKVdfucVSt8OcUXuPCah6TcZHFuMFAaVfn9xvaVzGZhBIUF
 zlljYusofuUarxk1UjtfAy3KDdwKL7utRgo5JJ3Gp2BPA3xh0egRTzL1gxwQCnsrGuWXxXYd8
 /UoxGoyDuEeb50dLin2FeN9+NIpY2jI2B7O02V5tBE+itsD/dE1NXerKoP/LVaTc+6zlxvGnx
 Ic5jDHrNEFnQ8JX97CLVFmkWDe9QqYiispBnF+CxKuertwTBUdHOAzyqTk1yneScoDM64gCpP
 lmDbNOEFL1CK/LLx/qWR2udfheWLUu1iXfNX7GZ9oQH8iAaT8eKE2n2FVyQb5Q4oqnN477BBG
 i0/JmvKSPjaWGWyCZCk4J7yOFZVa6XjZc5ag16KVPDBgPyGCveXUp3zig==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/18 13:53, Wang Yugui wrote:
> Hi,
>
>> On 2022/8/17 22:58, Wang Yugui wrote:
>>> In decide_stripe_size_regular(), when new disk is added to RAID0/RAID1=
0/RAID56,
>>> it is better to free-then-reuse the free space if stripe size is kept =
or
>>> changed to 1/2. so stripe size of pow of 2 will be more friendly. Alth=
ough
>>> roundup_pow_of_two() match better with orig round_up(), but
>>> rounddown_pow_of_two() is better to make sure <=3Dctl->max_chunk_size =
here.
>>
>> Why insist on round*_pow_of_two()?
>>
>> I see no reason that a power of 2 sized chunk has any benefit to btrfs.
>
> For stripe size, in some case,
> decide_stripe_size_regular()
>      if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
>          /*
>           * Reduce stripe_size, round it up to a 16MB boundary again and
>           * then use it, unless it ends up being even bigger than the
>           * previous value we had already.
>           */
>          ctl->stripe_size =3D min(round_up(div_u64(ctl->max_chunk_size,
>                              data_stripes), SZ_16M),
>                         ctl->stripe_size);
>      }
>
> For example, RAID0/3 disk/max_chunk_size=3D1G,
> then stripe_size =3D about 1/3G

It's not correct already.

Firstly, @data_stripes for 3 disks RAID0 we should not have
max_chunk_size as 1G.

This is already a behavior change and should be investigated first.

>
> If another disk is added, RAID0/4 disk/max_chunk_size=3D1G,
> then stripe_size =3D 1/4G

Then your assumption on reduced stripe_size is already based on the
incorrect max chunk size behavior.

You're fixing a problem with wrong root cause.
>
> the mix of 1/3G and 1/4G stripe_size is difficult to manage alloc/free
> the space than the mix of 1/2G and 1/4G .
>
> For chunk size, it is more complex because of raid profile.
> decide_stripe_size_regular()
>      ctl->chunk_size =3D ctl->stripe_size * data_stripes;
> '
> for some raid proflie  such as single/RAID1,
> because stripe size is already set to a power of 2,
> if we set max_chunk_size to  a power of 2, then max_chunk_size will have
> a value same to chunk size/ stripe size in some case. it will be more
> easy to understand.
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/08/18
>
>
>>>
>>> In another rare case that file system is quite small, we calc max chun=
k size
>>> in pow of 2 too, so that max chunk size / chunk size /stripe size are =
same or
>>> match easy in some case.
>>>
>>> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
>>> ---
>>> changes since v2:
>>> 	restore to rounddown_pow_of_two() from roundup_pow_of_two()
>>> changes since v1:
>>>    - change rounddown_pow_of_two() to roundup_pow_of_two() to match be=
tter with
>>>      orig roundup().
>>>
>>>    fs/btrfs/volumes.c | 20 +++++++++-----------
>>>    1 file changed, 9 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 6595755..fab9765 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -5083,9 +5083,9 @@ static void init_alloc_chunk_ctl_policy_regular(
>>>    	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
>>>    		ctl->devs_max =3D min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CH=
UNK);
>>>
>>> -	/* We don't want a chunk larger than 10% of writable space */
>>> -	ctl->max_chunk_size =3D min(div_factor(fs_devices->total_rw_bytes, 1=
),
>>> -				  ctl->max_chunk_size);
>>> +	/* We don't want a chunk larger than 1/8 of writable space */
>>> +	ctl->max_chunk_size =3D min_t(u64, ctl->max_chunk_size,
>>> +			rounddown_pow_of_two(fs_devices->total_rw_bytes >> 3));
>>>    	ctl->dev_extent_min =3D BTRFS_STRIPE_LEN * ctl->dev_stripes;
>>>    }
>>>
>>> @@ -5143,10 +5143,9 @@ static void init_alloc_chunk_ctl_policy_zoned(
>>>    		BUG();
>>>    	}
>>>
>>> -	/* We don't want a chunk larger than 10% of writable space */
>>> -	limit =3D max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
>>> -			       zone_size),
>>> -		    min_chunk_size);
>>> +	/* We don't want a chunk larger than 1/8 of writable space */
>>> +	limit =3D max_t(u64, min_chunk_size,
>>> +		rounddown_pow_of_two(fs_devices->total_rw_bytes >> 3));
>>>    	ctl->max_chunk_size =3D min(limit, ctl->max_chunk_size);
>>>    	ctl->dev_extent_min =3D zone_size * ctl->dev_stripes;
>>>    }
>>> @@ -5284,13 +5283,12 @@ static int decide_stripe_size_regular(struct a=
lloc_chunk_ctl *ctl,
>>>    	 */
>>>    	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
>>>    		/*
>>> -		 * Reduce stripe_size, round it up to a 16MB boundary again and
>>> +		 * Reduce stripe_size, round it down to pow of 2 boundary again and
>>>    		 * then use it, unless it ends up being even bigger than the
>>>    		 * previous value we had already.
>>>    		 */
>>> -		ctl->stripe_size =3D min(round_up(div_u64(ctl->max_chunk_size,
>>> -							data_stripes), SZ_16M),
>>> -				       ctl->stripe_size);
>>> +		ctl->stripe_size =3D min_t(u64, ctl->stripe_size,
>>> +			rounddown_pow_of_two(div_u64(ctl->max_chunk_size, data_stripes)));
>>>    	}
>>>
>>>    	/* Align to BTRFS_STRIPE_LEN */
>
>
