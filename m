Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD432A8012
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 14:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgKENzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 08:55:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:44141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgKENzQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 08:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604584512;
        bh=zxZ4Ok6wkb4pXF6MegkVrtg91xYN7tG/uaQJmKSujls=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=h2sOatdBkWpGVEYosheuj6UI4WEdLKMW+PnJBl7pyQ4IWsLzr7/kN0oP6vcZYVwiE
         lAF3lxvADVxtYnPt9bHtTZswC1M81yRoAjLRJ+yFDBPIghXsHqNH1E5mT3eEC2DlRZ
         TJzYwzlNsK0wKBRxwVb30pNtCRO2poAFWKw+wRmg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1kniQK436N-00Wr7e; Thu, 05
 Nov 2020 14:55:12 +0100
Subject: Re: [PATCH 08/32] btrfs: extent_io: sink less common parameters for
 __set_extent_bit()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-9-wqu@suse.com>
 <9ad4bb74-a6b0-1a15-a515-e765949bbfbe@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <ea94387e-3eb7-b903-2351-d75442b0b824@gmx.com>
Date:   Thu, 5 Nov 2020 21:55:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9ad4bb74-a6b0-1a15-a515-e765949bbfbe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qa6eXywyDZttiDQ7OXYyy+MaE9gTizO+bg4k2m0pbgPfLSwEzGD
 1iRYzNy8Q9zsXY1aK2KXDY5cNxTG0P05XkM6MtDDG+W4cxdPl47xrSliUFOEBGkZxVmZMJh
 Nff3EY/5nOn9uNIeaFsF25fy8/hMsEVYrXpQPRmI5u6IzufCP5hJkrD3ock61xaQC5z5y87
 zo9BLiYADrsCk2S5XjsUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vmPkVla4DBg=:AQTYExAWAy1Y+qYy/ZuyBa
 AaOXOXWGrtTaN2sffIB/BfwbHr+TO2+z9SMpBjJfzhUv6u7xBmIc86iHAWCCNWIhVZvXtacBe
 6rG4OyKpBzeFTSewLJZq5D6fyRXTO1KjV3hSA6yOBFRQ9wbeP6gULG2bfS/E23p5YsodyHTJH
 cwkIxoepO/3gjHSlw5FHzcFGhdP2nY8o55sjQ69XoFpy1dPTZE6+bB/ZLpWngd61F/LwuW4jF
 XmLZs9uIiI7orUbj9fR5jHBvgLlMSA1A3UVAbKlgKgPZmvri9V9lbMeiCSr9xumwPphHWWJ9v
 k6G1CHCFnUydTXXeqjjM+iFKAivFJgsHXWUXqiU7atYnfjWBDGj7aYUUBNcJq0HHkMXv2fhAb
 YoCHEXTnjBM+y07cJ/Ld8/I+DHUjAqdAZC+NqDBurvfMRCHqJGeFF9O0b1/0lI/7Jdds5WkKh
 WDROedRM2EfXee1cl4yC3xm1P6PcQOjXqK0E1W4RE6rdHYUQwsWkDGccan654Nhyci8+g+Zso
 6mLu8RA0RI6aBYHfiKKoxZRo3/wrqL5TA5WM3g4yYcyEvK1qAyP8S61zc2AwnH8WE0sBHqz7X
 y0nCX5MSVB7lkCPvv9XOEUN2w/zefzk2liA22F5ITEjfb+jaocXKSc3vshMGBulexsyjk0llW
 0HCWOBwEg2QJ+QyTpw1L3B3tK157nh5oP6FPaLKggUQmMrqpKFzHKYCGWvZxlYROq51e0fQO4
 uxyhAZ6Ghf7mVeOVFkjR27XbzKZxgV2rEwzXziNeD74oLt0y+1ofydAcchyR73F3UFzWQvRoS
 arzdSG0gaTJbI1kNxHzJ5EESKwHsrvtNeqWFb0fUdrYARyGYhHMqktMVGr5lzZRoo0t5VNjto
 D4Ixo/NTQJrcWcEYXcQg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/5 =E4=B8=8B=E5=8D=889:35, Nikolay Borisov wrote:
>
>
> On 3.11.20 =D0=B3. 15:30 =D1=87., Qu Wenruo wrote:
>> For __set_extent_bit(), those parameter are less common for most
>> callers:
>> - exclusive_bits
>> - failed_start
>>   Mostly for extent locking.
>>
>> - extent_changeset
>>   For qgroup usage.
>>
>> As a common design principle, less common parameters should have their
>> default values and only callers really need them will set the parameter=
s
>> to non-default values.
>>
>> Sink those parameters into a new structure, extent_io_extra_options.
>> So most callers won't bother those less used parameters, and make later
>> expansion easier.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> IMO I feel this is an overkill, __set_extent_Bit is really some
> low-level, hidden interface which is being wrapped around by other
> high-level extent bit manipulation functions. Following this logic I did
> send today a patch renaming __set_extent_bit to set_extent_bit,
> essentially removing a level of indirection.
>
> Having said that what you are doing right now might make more sense for
> future changes since you state it's preparatory anyway. But in any case
> I believe the interface for this function is just broken if we have to
> resort to such type of refactoring.
>
> See below for one idea of extent bits handling.
>
>> ---
>>  fs/btrfs/extent-io-tree.h | 22 ++++++++++++++
>>  fs/btrfs/extent_io.c      | 61 ++++++++++++++++++++++++---------------
>>  2 files changed, 59 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
>> index cab4273ff8d3..c93065794567 100644
>> --- a/fs/btrfs/extent-io-tree.h
>> +++ b/fs/btrfs/extent-io-tree.h
>> @@ -82,6 +82,28 @@ struct extent_state {
>>  #endif
>>  };
>>
>> +/*
>> + * Extra options for extent io tree operations.
>> + *
>> + * All of these options are initialized to 0/false/NULL by default,
>> + * and most callers should utilize the wrappers other than the extra o=
ptions.
>> + */
>> +struct extent_io_extra_options {
>> +	/*
>> +	 * For __set_extent_bit(), to return -EEXIST when hit an extent with
>> +	 * @excl_bits set, and update @excl_failed_start.
>> +	 * Utizlied by EXTENT_LOCKED wrappers.
>
> nit: excl_bits can be removed if we simply check for the presence of
> EXTENT_LOCKED in 'bits' and if the result is true then also check if the
> found extent has EXTENT_LOCKED if it does -> return the failure_start,
> that we we can get rid of 'excl_bits'. All uses of EXTENT_LOCKED is via
> lock_extent_range except the one in the private failure tree but I
> believe it should be ok.

Nope, there are users for excl_bits without using EXTENT_LOCKED.
It's from compression code, although I doubt if the existing code is
correct, but at least I kept the behavior the same for right now.

And you will see more parameters moved to this structure in the rest of
the series.

Like wake/delete, skip_lock and prealloc, where the last two are mostly
for subpage only cases.

With all these extra options involved, I hope the need is more obvious.

Thanks,
Qu

>
> I had a crazy idea to overload cached_state to return the failure range
> and use it in lock_extent_bit but that makes it rather messy. ...
>
>> +	 */
>> +	u32 excl_bits;
>> +	u64 excl_failed_start;
>> +
>> +	/*
>> +	 * For __set/__clear_extent_bit() to record how many bytes is modifie=
d.
>> +	 * For qgroup related functions.
>> +	 */
>> +	struct extent_changeset *changeset;
>> +};
>> +
>>  int __init extent_state_cache_init(void);
>>  void __cold extent_state_cache_exit(void);
>>
>
> <snip>
>
>
