Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4392228C4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 00:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgGUW6s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 18:58:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:56065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgGUW6r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 18:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595372323;
        bh=DyKo7ZHGl5liUSaw85fLhX1JG7toYiDUyfvOxs9oFcA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dXnaMdbwg2QcJtbm6SbafW9P/cETgNHIE7Tcw/iqx/mF1BF2ITeB7ecLYmmfr8CMp
         y2eUbYjQ5rJBoqBN1y0PH9kSQp+rbYAonopKErRTnYKLdLZXe4vY3P74XdtqZfwIKZ
         WJL6BTNZ92y17JZ1J91jmGcwZzUGs/o0e3hn/pyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6bk4-1ktnGm1NZm-0186jz; Wed, 22
 Jul 2020 00:58:42 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Christian Zangl <coralllama@gmail.com>
References: <20200720125109.93970-1-wqu@suse.com>
 <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com>
 <20200721095826.GJ3703@twin.jikos.cz>
 <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com>
 <20200721135533.GL3703@twin.jikos.cz>
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
Message-ID: <cccdcdc8-db5a-779d-7b99-346ef14133e5@gmx.com>
Date:   Wed, 22 Jul 2020 06:58:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721135533.GL3703@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xGFZMvEsT+BLImN2xvti2AOz05otyfs1v+zy9RtjVNBXVosi6Lc
 R1C3jmEjWH3ElfVS5HtWl3LidoSEM3jC8BgVHzHhjXQ0Jnrlgu/xjewq6v7RVAjNfVVrltl
 oYwbgtqSeAAkOYe1/oSQ/bQBtlL1Ky82hUpDkw7vOP/Zobf5/ITZSO7TLsQA9WEJb60lVq3
 CDNv/ufFBCmh9/hjWl8ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VPTgejeGmZQ=:qknFoi9WfKuxcOp4lVBhs1
 ymnCcAB/VnY0XxyrIxfh+gcfbjl247LQ5i6aNMs2lGuFFQKGo+D7woNxbN84VGLiBf0BT0GD9
 Za2S1MFFTh0cuCjY3hhdfSiIJrwuAgVYe8qeBHqRgwroQwMXx/AEtBH1EmY6wyT7cQ1VNwC8A
 ZXvhMjr3Dtpy2NCdzWS9p4IzbcgCgkxYPsdd85WPZgBZ+8FemgmK3T2mm+PZ37f2rCCUZBM7Z
 elyAdMUAI688cTkaEdoLh4/LUlNlW/hvw836yF7igeWKTFEGYjP0waO+g77vrWucUXvqJFiTf
 o8pxW0Sm9kPX40c1Q80mbw2+poCyKahchn8CuvRfBXJZNUpvR/uxZwMk4LWv6olriTZt5rPBv
 hF0fuCzw8/A6KWDKmYFJM+Fionxajl0TGC87imBvmf7bdghitZtSYGSvH7C2mprekIbVtFESU
 HXfII82kNH7DL7M5seu845LAxY/uTuYWcCkUVgh8NmmpUnVljmD5QiCiGnKKsDfy19XRgMHXM
 pfj6R3sSqZqCKcCZSyiFckEij0JENSIKeLq9BSn48dN0Ne8hivc1eO1tZ9W6im+1PQO7faMwV
 dUd035Uh3aE97Oq3pf1k3YXgZYtvnwj+NbQWHmT3cTpYGnW7kijwK8KiUlldX/Us8qACXO4py
 lc21Fv/H2ypHd3Vu08MUsIwpsLuFyn0L4F3a9VCve0FRMet/PBfQTrQkjgwekXAqBlTQd6lJ4
 Ugj7O8GlJ9sJQ4o2F5MmX/TY7h29OVHYZHhiy6r7DcFfOGiX2yVNfPGfX+kpNxHHt9HlYhFe/
 k2Qv9LNHzEFFmTO2XnJudwRNcU/XVFRgcbRYoAg2Qf0eIuapzBvTFIHTCzJpR//iv7sKCTCjE
 6xyh23XUQjdNNrgPXmfyhMYSrtC97CtfFQFPNhEolgD9/Rw6vadRVME9HBkmP6jEzRmnDcq/b
 3J4YJcDPVnHzrZrJjM9SEMvlFS6zwPupz8x9ON08hKx43jhVQVE7dqSPnEMFo9iva5RdMXZHz
 I2gpXjDAPBU1dy/e5TjNTA+az9ItbtPvLingNrVECSRQ09LIfSzfToHF+vbyVnkwsbB8mqB2L
 YMKGwL9knhnDcBDezvdJcZCLm8NzKP864FjrJz9OtQS79Q20rMOra6IX9A/luHjohaSkFqNnS
 VK1Xu8PrX4cr+Zd7c2a0L0ei3Q6uZObSidDzVTdkI15LGY3FiRKjFtbmZcfOM+zTZBKlK2h6v
 6IL0T2cYRXjn/7K7U8XbMd7aorMx5OxpJ2N40HQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/21 =E4=B8=8B=E5=8D=889:55, David Sterba wrote:
> On Tue, Jul 21, 2020 at 06:29:31PM +0800, Qu Wenruo wrote:
>> On 2020/7/21 =E4=B8=8B=E5=8D=885:58, David Sterba wrote:
>>> On Tue, Jul 21, 2020 at 07:51:00AM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/7/21 =E4=B8=8A=E5=8D=8812:09, David Sterba wrote:
>>>>> On Mon, Jul 20, 2020 at 08:51:08PM +0800, Qu Wenruo wrote:
>>>>>> --- a/convert/source-ext2.c
>>>>>> +++ b/convert/source-ext2.c
>>>>>> @@ -87,7 +87,8 @@ static int ext2_open_fs(struct btrfs_convert_cont=
ext *cctx, const char *name)
>>>>>>  	cctx->fs_data =3D ext2_fs;
>>>>>>  	cctx->blocksize =3D ext2_fs->blocksize;
>>>>>>  	cctx->block_count =3D ext2_fs->super->s_blocks_count;
>>>>>> -	cctx->total_bytes =3D ext2_fs->blocksize * ext2_fs->super->s_bloc=
ks_count;
>>>>>> +	cctx->total_bytes =3D (u64)ext2_fs->blocksize *
>>>>>> +			    (u64)ext2_fs->super->s_blocks_count;
>>>>>
>>>>> Do you need to cast both? Once one of the types is wide enough for t=
he
>>>>> result, there should be no loss.
>>>>>
>>>> I just want to be extra safe.
>>>
>>> Typecasts in code raise questions why are they needed, 'to be extra'
>>> safe is not a good reason. One typecast in multiplication/shifts is a
>>> common pattern to widen the result but two look more like lack of
>>> understanding of the integer promotion rules.
>>
>> My point here is, I don't want the reviewers or new contributors to
>> bother about the promotion rules at all.
>
> Ouch, I hope you don't mean that contributors should ignore the trickier
> parts of C language. Especially reviewers _have_ to bother about all
> sorts of subtle behaviour.
>
>> They only need to know that using blocksize and blocks_count directly t=
o
>> do multiply would lead to overflow.
>>
>> Other details like whether the multiply follows the highest factor or
>> the left operator or the right operator, shouldn't be the point and we
>> don't really need to bother.
>
> ... and introduce bugs?
>
>> Thus casting both would definitely be right, without the need to refer
>> to the complex rule book, thus save the reviewer several minutes.
>
> The opposite, if you send me code that's not following known schemes or
> idiomatic schemes I'll be highly suspicious and looking for the reasons
> why it's that way and making sure it's correct costs way more time.
>
OK, then would you please remove one casting at merge time, or do I need
to resend?

Thanks,
Qu
