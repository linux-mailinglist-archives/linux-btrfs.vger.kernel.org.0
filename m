Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE6324177C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 09:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgHKHmm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 03:42:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:46413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgHKHml (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 03:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597131758;
        bh=f6Dw/ur1OKLPb6FzUdqQR1tnzBo5xGTUWZVA61lGBKg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=f5YqTC8sXgTrLKXsCMD6SVXflEnZpzcmZXX3GtDOscyN4q7cH5NvXo3DX23vhdYzF
         if8oeLe8NlPwd6Pv9nT+aggm4QT1ainkxVDwqc2WiAWI9MrEEg08R5S2O8cmxbCvQE
         2IY64dyNiiqajagjkCDudyqt6Ieu9mj4FbixIejU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33ET-1kr4O81lwj-013MJc; Tue, 11
 Aug 2020 09:42:38 +0200
Subject: Re: [PATCH v4] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
 <20200731140807.GM3703@twin.jikos.cz>
 <9ec86d30-96b5-2e80-969e-158342c273ab@gmx.com>
 <20200811072234.GK2026@twin.jikos.cz>
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
Message-ID: <8796039b-d0b1-a129-3b01-a260a051154b@gmx.com>
Date:   Tue, 11 Aug 2020 15:42:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811072234.GK2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oHWaBfSc+17rh4c2OI1WjVoqL7GN/hdW27csLKEnuQdJI51fWhz
 h1Vt0NhKMHTXhyoPGXxYrn9IuclGvb7OTq9M8VEqB6Z3TzDBeAMDqGppgbgKUtfA+NqHU7S
 3aIswJLPBelzMgkpiZI3gqYhgEaxyFAic4K/gpSFaHtt5dlYBj55zAtmpcZSCCtEW4u6kP9
 QyNGgdSYxnj5I5N8/5vSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o7duzCCwgZQ=:elhqiO0kti54bHQpOnjHtN
 BAaoTDj3UE83GLrSePLRVHsJpjqeQ9AznyBrXZ0eRaI4mUSgNtoafoxeAD54tT/SOcLfdLT+u
 fccImEnqnLY561C/2k9JTZ3ZZQ7UlRdp3hvnQq9Qh3aooCz98O2A7Y9vDOMAvvVSKA1x3gC6U
 ljNjVd3oILPy8al1buJRW07L9gRGFZMnK5Ajas5WOQwOddKCjTT4fkallF95T0b75hZMK+7vv
 HzGpfH5F0od+2niUuQjkoU56I33ckVqwwPY3qmmNTmf1mpQk5eIqU4jCle9tTwHVV+sgCQosz
 CE7bGXgeJGlYxazxJj6J+YWkmIw/OfoD7bYItOTxc5bTLhdo/50hnq3fCLQoUjxXPGTZvJlK8
 /tMv4G7vSJbwv4p41PNsEbNa+pHZk9jtDViL1HqeaSLYMRRH4phffGT0fTycckGNLclKUASIF
 ngC1569EZOzfHe6daKf7fsnLzoyChsIZeYdQxVJ2INhX0u7OrgW9E7WCC4FsUSfiqj1vV/KPq
 uwbBMANx3+UhauI55ePZ+hPqWynMb3IF9dCF5s5xwaXkC4ORZr6anSDoIIH/uF4bnOgFJDXLo
 duK96PuqpCgggNRBR2b/zfK9b+N/i/vjd0uPzbFAnL7VGJpkyjUGXmjurc0R+O6LXUdcqAvGr
 dS+fCb59C8RiurgnDBQvbPtE5dvEa5Y2a8/nifcrGVBVoErthp3KFf6W1ENFLLZ+0c5EtTiiA
 AD6wg0lawbAOZoxywghykTBnRS8eWYejQzNZwK8ySk4jfjhFxpTF8T0yPDvQTbzPQ9PKOPGqw
 nezjcneEZeYeKxbGjpONtn2h8F1iOF0uFopjZq6qgOv+02BxqBeyc5z46CbK/tZx0jTEuS81I
 OSLzXcrDpbVB+X8NZc/PwVmrDteDzjfE4GnsLVCipGNgNhXMeuTjYB6u+kr8Zm4rQ+qbuvCHx
 HWzNOSZElgju7LRJU8FJ84pRBxkuq+4T+p347MoAaWfQmvIPtRng5aaTGHg3bCUqQ/MTkGpb1
 sbO9fhTJwWoSFk6UvIKD2OP4B5a5Ha8R7Ec22ZuV18X218T3Fu55Gio+QBpFbhBtb/nt4stds
 lasXrcTCo4Hc8oN0IfHlmF/WIW3XS2AiHOvOp0967e8xUCzLTzEqBWqM60lFGuDjRJXFP82uw
 gBjF/v9sL79i0sVE7VHCttSc2svn0JmdycUtJBWI2uNxrmxE6CVm71TOLFlRKkislKn30zAgp
 WJ15RJsdR++ptmULeQ8lsSNfvCnDguZtZVQ5rcg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/11 =E4=B8=8B=E5=8D=883:22, David Sterba wrote:
> On Sat, Aug 01, 2020 at 07:35:26AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/7/31 =E4=B8=8B=E5=8D=8810:08, David Sterba wrote:
>>> On Fri, Jul 31, 2020 at 07:29:11PM +0800, Qu Wenruo wrote:
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *d=
evice, u64 new_size)
>>>>  	}
>>>>
>>>>  	mutex_lock(&fs_info->chunk_mutex);
>>>> +	/*
>>>> +	 * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond the
>>>> +	 * current device boundary.
>>>> +	 * This shouldn't fail, as alloc_state should only utilize those tw=
o
>>>> +	 * bits, thus we shouldn't alloc new memory for clearing the status=
.
>>>
>>> If this fails or not depends on implementation details of
>>> clear_extent_bits and this comment will get out of sync eventually, so=
 I
>>> don't think it should be that specific.
>>>
>>> If the new_size is somewhere in the middle of an existing state, it'll
>>> need to be split anyway, no?
>>
>> Nope. Because in alloc_state we only have two bits utilized,
>> CHUNK_TRIMMED and CHUNK_ALLOCATED.
>>
>> Thus what we're doing is to clear all utilized bits.
>
> Which is true for now, adding a new bit would change that.

Yep, that's also why I had the comment here.

>
>>>
>>> alloc_state |-----+++++|
>>> clear             |------------------------- ... (u64)-1|
>>>
>>> So we'd need to keep the state "-" and unset bits only from "+", and
>>> this will require a split.
>>
>> In this case, we would only reduce the the size of the existing status,
>> or just remove it completely.
>
> I haven't found the 'only reduce the size' in the code, thre's always
> some split. The case in __clear_extent_bit is
>
>  773          *     | ---- desired range ---- |
>  774          *  | state | or
>  775          *  | ------------- state -------------- |
>
> the case on line 774 and followed by split_state.

You're right, we still need to allocate memory in this case.
And it's the BUG_ON() and the preallocated state saving us from the
memory failure.

>
>>> But I still have doubts about just clearing the range, why are there a=
ny
>>> device->alloc_state entries at all after device is shrunk?
>>
>> Because the alloc_state is mostly only utilized by trim facility, thus
>> existing functions won't bother clearing/setting it.
>>
>> In this particular case, previous fstrim run would set the CHUNK_TRIMME=
D
>> bit for all unallocated range (except the super reserve).
>> Then shrink doesn't clear the exceed range, and cause problem.
>
> So the unallocated range on a device is also represented in the
> alloc_state tree?

If the unallocated range has been trimmed, then it has an state, with
CHUNK_TRIMMED bit set.

>
>> Thus clearing the bit in btrfs_shrink_device() makes sense.
>>
>>> Using
>>> clear_extent_bits here is not wrong if we look at the end result of
>>> clearing the range, but otherwise it leaves some state information
>>> and allocated memory behind.
>>>
>> Not that complex case, just plain not fully considered corner case.
>
> So what to do about that? I expect the alloc_state tree to represent the
> device accurately and don't want to leave known issues unfixed.
>
The patch still stand as it is.

The reproducer is still the same:
- fstrim
  This marks the unallocated range of one device with CHUNK_TRIMMED bit
  And the range starts from the last dev extent end, to the end of the
device.

- shrink device
  We need to remove the CHUNK_* bits, or problems will happen in next step

- fstrim again
  Due to the bad check, we could underflow the length of the range, leads =
to
  access beyond boundary.

The patch fixes it in two locations.
When shrink, we clear the CHUNK_* bits, as these bits makes no sense for
range beyond device boundary.

When fstrim, we do extra check to ensure we don't underflow/overflow
anything.

Is there anything unclear that needs extra comments?

Thanks,
Qu
