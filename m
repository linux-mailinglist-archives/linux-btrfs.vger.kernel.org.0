Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A0233C60
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 02:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgGaABt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 20:01:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:32901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbgGaABt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 20:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596153705;
        bh=Jzz+bCt3Gym9cxsm2zLn96q3FifrybRuG7ITMf2ZkXE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=B2fRgcYGGeKJKcy+CFXVDEAo4J0laV9NPKJLNVWWVc2MOywHaVR35kj2zIAF/WLaL
         XE30rqlGSMUFM2U6SSW1DypILwsjUOr4PDkEm8PgV3RIVxySbJacVuOOFXDU80seOJ
         2vm/jzePputC2dyZm7fsX0JQb9yaK2dzLIknPhOk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwwZd-1kxuOR44Wh-00yRy7; Fri, 31
 Jul 2020 02:01:45 +0200
Subject: Re: [PATCH] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200730111921.60051-1-wqu@suse.com>
 <20200730170348.GK3703@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <51c9f9a8-b39e-119d-f888-097c3435aa57@gmx.com>
Date:   Fri, 31 Jul 2020 08:01:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730170348.GK3703@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q+S4AjtwjowYtJHYAxpuyNv7GivH+WGl+pL1tX1b0sD33CRkBwT
 TTRyxDCXmrWFS7JstbFBWXqFtPlhRBeGvW4Lq7h5gPavnMn/bLxVNBML+V7XQVQPHfKSZv7
 abROnKTToSgy9XZKnK6h9ksdF9ZYfLLFsIzwfCLvB5j4bAxpg/ZqKA8uDXiyfdQIaD4I98i
 rykAYkiW3/+9K0v6j9zJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9SbLkdGu8AQ=:BDRqU4muCXXu7+tivIHC+Y
 m4ISwH+I4h/V4JK114mQMdPt3Nk3N7hXdxHd7UjiN+9FKHIqWYHX3LZvU4EoSZpNXa9yiYnw/
 MSPBSPRDpMu+eHtgvj8izEpbqKMrmbjEiDNMxX2lvhzeo/ExT6CbCikIaeZ7O8Opikar5l2Hu
 VcDWwhF9rj0Lyocg8wU6C7Uz2ethH3V0kAUB9StNuRAVJQ8yZURJQaEZ9qKji9lPJcELQr8+8
 aA02X1/wKzP352Q/rKBWTT/2P0WEovcq2IY3ecA2jt6z2wLY3rOImmikx4eksUukHtV6w4DvZ
 GtVyjJK7dms+jM+N9IOdRpay8UNm10sOT9X9BCZNKPuxIbTTVy3CFh2RZMH3kxBm1Qeu8nEDv
 jZb1Vw8pN5s8ZTb5SxhkonRNsIPtuZmApOEEBzHCvN4cV9ECIO0CT+mwSaEFt9n6vzpyaeBgL
 LKBpNEMpA0/WTXRorkoXCJlmqw+GVMyOUrsflsbWIM+TptdrQlw9scnR96ucgS32EiGNNBb2a
 /8mkCgbzvZAeE4fgpKymATxvseni1ijVIhHDHBU/lKNZYVrgboR4G+7wjk89HVC7MZp9snec5
 61h36nOdmM1YmxDwmZYy1VzFoeicYBZeOjOU10o5h1QfyEKR7f32TJS9/V00Q044vKmc0bwxQ
 zstc7Mjp7Q+GbWOcvtkZuOjwCvDK1S6n64J2pOHlpQz4esI70WC30H28CSD5UZo+Ok2Tu02Hy
 44D9ELsamjQgUrhcEGh59RkazYAb1B0T09ohpeKOKANMxMIzA+bogOuBr5QPC4h4Q9dU6mFS6
 cfgSfgZkMhbNQZ3Q3/d0QY6F/Ct1QF6npARR1xbHg1X+ERNwPU69WnXShM7ekV8TKPiGXgiud
 pR1DGDbUKil0/wU8dpDm4L0WVyj85ZdpzwNzpLAVNjfJUj0GE/WOa0yL/3Vq35ecnAq7m5zfE
 Xfiq+PXC0k+q7qrD/3AXBz4PqGiITZX0kz8ld2TqPfTdhp4g88Tg/jcdi7Sklt5bZU1SS1FCN
 mR9T8oPKgWF++3+KF7rJGK6nSqDZu5JzsEpQcpaOM0OeT7lq2L3gZ1mDan+QnxU9j0wr7Gsae
 3BKuFQCr9+AphySnz4H+i8grrjlglEfAbdAAeqHdkUjxXpksw4sjbdyZv5LNhB+l89/hy7v7r
 pAh0c+S54Hw63hcLiI4InbBVqbqZaHRkLHAV7KaZtKo7OMfThtcNTmcGDuDT7ASrNBaFQgmKZ
 KftIG+6MENrqI55A9MURJINSn4lyBDgv+gvx36w==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/31 =E4=B8=8A=E5=8D=881:03, David Sterba wrote:
> On Thu, Jul 30, 2020 at 07:19:21PM +0800, Qu Wenruo wrote:
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4705,6 +4705,18 @@ int btrfs_shrink_device(struct btrfs_device *dev=
ice, u64 new_size)
>>  	}
>>
>>  	mutex_lock(&fs_info->chunk_mutex);
>> +	/*
>> +	 * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond the
>> +	 * current device boundary.
>> +	 */
>> +	ret =3D clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
>> +				CHUNK_TRIMMED | CHUNK_ALLOCATED);
>> +	if (ret < 0) {
>> +		mutex_unlock(&fs_info->chunk_mutex);
>> +		btrfs_abort_transaction(trans, ret);
>> +		btrfs_end_transaction(trans);
>
> Can this be made more lightweight? If the device shrink succeeded, we
> now update only the device status, so failing the whole transaction here
> seems to be too much.

It can be lightweight by just ignoring the return value.

1. Currently clear_extent_bits() only return 0
As currently clear_extent_bits() uses BUG_ON() to handle the memory
allocation error, and can only return 0.

2. We have the extra safenet to prevent problems
But we may want to add extra warning in the safenet itself, so we
shouldn't completely rely on that.

3. Since we're clearing the only two utilized bits, it should not
allocate mew memory
Thus it should always return 0.

So yep, we can safely ignore the return value.

Thanks,
Qu


>
> As the device size is being reduced, we could possibly update the last
> relevant entry in the alloc_state tree and delete everything after that,
> instead of clearing the bits.
>
