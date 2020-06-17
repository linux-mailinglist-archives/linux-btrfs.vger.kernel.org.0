Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A511FD9B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 01:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFQXji (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 19:39:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:58167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgFQXjh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 19:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592437172;
        bh=9qa7JsvfgCQj6s4iia5rNNJdW8JFoDc/NT7HJdEp5GU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jr8/krd8al0cr1awN5EG18YntYXDN++BXesdyuqTJ1CWuwETTmu8l6qPlXeQcGTV/
         tucg9Hl2AziPyRld7tDgP2D9SWLQLA30rhYPOegsbDcICXSLULs6MIkwDNWPNHk8IF
         yGaMD37HztK9HjBqcq+BFIvkj7k1wPqhsn0w8cxI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiacH-1jHc9s3sJz-00fh86; Thu, 18
 Jun 2020 01:39:32 +0200
Subject: Re: [PATCH 2/4] btrfs: detect uninitialized btrfs_root::anon_dev for
 user visible subvolumes
To:     Josef Bacik <josef@toxicpanda.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-3-wqu@suse.com>
 <d17609b5-ac29-937c-763d-fc978e3f1bad@toxicpanda.com>
 <f1f940ba-3f1d-302a-0d28-5620286bcdc0@gmx.com>
 <a7417666-56a0-be6a-1691-e647802e1df7@toxicpanda.com>
 <0e274dc7-ac05-078a-2a2c-348e72745d45@suse.com>
 <20200617113109.GK27795@twin.jikos.cz>
 <e665ed96-63f1-ae72-15dd-ba8d75288568@toxicpanda.com>
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
Message-ID: <38c70792-fb5b-f986-e4cc-087efcb3d54b@gmx.com>
Date:   Thu, 18 Jun 2020 07:39:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e665ed96-63f1-ae72-15dd-ba8d75288568@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tz8IWc7vshQ0UtDv3a0xtYjx9ANvssDnC1tkz/5i71+cNtddtXP
 jIWqC1o0NzhoQAGk8AGyCetvKRdhnxzIJOVChBP+XRkpfy/8xXjzzVajvNgCW7SWVWCPiZK
 KJbPXZ0WqwlK5Tz34ddScdvzzDfJ/dZx5GfFAT7mj3V/SNoC4mzYnQAliS+c9wuexlI6aKH
 mK27dOa5tgc5ITKI1jf9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3aiZDh+I8YE=:1Xx0bbldJUrcyG+/fkDv1S
 u5qGsBZV5VcJoQmLtE0l3bG00xM+bZMxPZjZ515vk3MMYYkF3pmVO/VPRuNfiG5ZHyKtvPFK3
 AUieiC3fZEzplIUJb1JzZuyuit/y4oHk7LFHVAlaqO31TRTt95GxkCIWt9E4eBr3MUaxYXSw1
 kkKaWQYXs6W9Q7SkNyJQq3oDWvQucyLXVXksjRMepJ4VbKwBqYkmx90RXOBEGiHM84AVsaEEb
 3uPiDhrusc3LmTUGOzh7cK4SMVrn/ws+KdoTTPbA8zSf6mc/biBsj4IF9/rmqo2j9ZvM79LnW
 TIpUS0hCRUNiFC3RmMxBEh3C6+MQoFEgiApypDhxLydjmGzzx4yQVyUK+ILV9Xx6R6zGeYNxP
 XJPehV5id+p5hUtQFsJLIvpzdaEbX3OTlKeq7AfDEjK17bzB88y6FQei11BnHerzTIJ8Mi2Lj
 L+iiDqSQs2kgB+nTG/7tq8+M0FRzhcDT3ZxtpGzLdjkXqz6prlM/RpnVee1ggSWslZaOVUoEA
 avO4KWBpXElXdf5mbfRQb9FQhysTG8BovMPfx8ypMjp/8TmZjVh/Ba3/VovS0lWhYbtYB2jmT
 LWNhU/aUtwlHBQVXLwseKcXwHRNIj9E++2utUhIUtCDZ7Y6NfsU501R9Sb7CxIjvXQRuyQCfO
 MmQeGyA3fpNsAC/S4xM0hkUUPQmV8CgOBTtCidUvQy20nDPy459dINlVAFoiNo5eiNdc3x5R9
 DOcc9INDkOjMMOwXtvJDqGB1UlzYQAiIi54+qzHzHtygd8+Npvieg1xiuq+LzqcbsEmYXjVYU
 X+1z9Iq6kjdrnxMB8dnV6mu7vyGwbfVoQPWS3hewR5ilY6o8HJjyK4kUhlIVXcbp2nCpu1seC
 JTbp+vS6yt6hZF7q7DJ2/63ALtVc8nbGb4zJT618TnEd5goFCuJWbOmbc9nY0ONknDP3Y7kbo
 oFlRoNsjgNV9X6UZq/xnwlaydFAunFKxRfC87q9tIKv0CVR3IJnZyx6UyLORSW6Oqu+nk0jZ8
 MM+gBaHFPgFxATX2a9eLGrY3A08tU61MiCW/nOalIZN3aNvdNRVWpqY0sirfcI+fIglVxUfzs
 93TZesV6iR+urVyYqDJGTGo7u+nA4tSPTTQPH1BaCeqDq6kzWG6l34IS5DQFDCdIUaz7uGXIc
 5DEhMrV8Uy0UTwnFZI+MMHBUdADs5MFxtpn7Au10ZF0maCijWzTI4mPT8A8jU7z3ktCW8ARfF
 x/JCQHF/y9qAcJ8dR
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/6/17 =E4=B8=8B=E5=8D=889:37, Josef Bacik wrote:
> On 6/17/20 7:31 AM, David Sterba wrote:
>> On Wed, Jun 17, 2020 at 07:49:33AM +0800, Qu Wenruo wrote:
>>>>>> Can we handle stat->dev not having a device set?=C2=A0 Or will this
>>>>>> blow up
>>>>>> in other ways?=C2=A0 Thanks,
>>>>>
>>>>> We can handle it without any problem, just users get confused.
>>>>>
>>>>> As a common practice, we use different bdev as a namespace for
>>>>> different
>>>>> subvolumes.
>>>>> Without a valid bdev, some user space tools may not be able to
>>>>> distinguish inodes in different subvolumes.
>>>>>
>>>>
>>>> Alright that's fine then.=C2=A0 But I feel like stat is one of those =
things
>>>> that'll flood the console, can we put this somewhere else that's goin=
g
>>>> to be hit less? Thanks,
>>>
>>> Unfortunately, stat() is the only user of btrfs_root::anon_dev.
>>>
>>> While fortunately, the logical is pretty simple, even without the safe
>>> net we can understand the lifespan pretty well.
>>>
>>> I'm fine to drop this patch if you're concerned about the possible
>>> warning flood, as the benefit is really not that much.
>>
>> It could be a developer-only warning but if there's a root with a bad
>> anon_dev, a simple 'ls -l' would flood the log for sure.
>>
>
> We'll know in btrfs_init_fs_root() when get_anon_bdev() fails right?=C2=
=A0
> Can't we just complain then?=C2=A0 That seems less spammy.=C2=A0 Thanks,

That's exactly where we do the allocation, that would be something like
warning about the allocation result.

That's why I'm fine to drop this patch if it's too spammy.

Thanks,
Qu
>
> Josef
