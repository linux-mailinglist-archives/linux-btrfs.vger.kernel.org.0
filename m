Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA82617A183
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 09:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCEIiE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 03:38:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:57159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgCEIiE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 03:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583397477;
        bh=HycUncipTCzI0cZZSU8PPc1JKsEPxvh6YtNPDjbbt2s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Wd+Rfd61pbaR1srClVUAgRVBlLFTg1GybmgZBRN2rXam7U3H74JIM86aAaq1iFIIp
         A+zT2WYdb3/BVuDsD1kLi6qb53KVmqKUXvMLcOpyyRQNa/vwwSMAy//t57ACoh9IaL
         UDVKb+AYAiRS06fZ9KWYVe5resfyTA5nQMLDhDgA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5mKP-1jPrrD1gYV-017AHo; Thu, 05
 Mar 2020 09:37:57 +0100
Subject: Re: [PATCH v2 08/10] btrfs: relocation: Remove the open-coded goto
 loop for breadth-first search
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-9-wqu@suse.com>
 <30ec7909-9ced-fb21-cf8e-1fa0c970d9a0@suse.com>
 <e76f9a62-6c7c-b1fc-e1fe-c985ff395b9d@gmx.com>
 <09fa33e1-740d-b4b0-2ff6-467cee674feb@suse.com>
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
Message-ID: <bb1aa705-5735-0c93-1f55-7051810d9e33@gmx.com>
Date:   Thu, 5 Mar 2020 16:37:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <09fa33e1-740d-b4b0-2ff6-467cee674feb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BGjT1LcLC9ZUOD5+s3h5BRw1CZPFDzQAynSJSolPeVHYn0AHGTa
 Ls2vnK7kdEdIshO1h5V9uAM/0xTZAeujPrGd3dbrlC/yWa8Rr4s5a4PrVH/25kj6x5n4HMN
 HuyHSxWrT/n856boe/kYvzDpE6xZ7yBo9oEixV/1063YMp9z/yagZFkTV+O8WDeyi8ADAfZ
 NY4SOtAXaw6y3TMr6h6Eg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F7nSUewxXDQ=:JTdbO4ibFfsySBmZqpaY6w
 4ZnWA3sTYqBTo3nivhsNKUFvyET62qe8kY9mmznUPFuhe9woINvbA/K3yLFuZs3W4RdNDupXM
 LOo3G82nTX3Wb9kh9xa4feH4arJgtm7Nt+k8FmIiSlWbWLem09IKV+AuVOvp3Ya0ap3oEvEAX
 ZAlyc4dXrHS1f6X/umcsvMOp/h9PopLrkveVVaoNZGGZs3I1PUc/EwGhq0zQvSmwNqJq+NHSY
 tQ9CD6l80Zy3TQy+Jz3Exouekv/o6y1vW/RT/lav6rXQ//A30yVyFPshreqHqV5PRwf1F+b0Z
 ZT2cWmChA5G1fjrnpJ01Cyx+UpLLEXjGf6LDb4VHCDvd+VtpredNBMSMETk7KWboIh24MbWp5
 sBLthwrAjlCdMxaPCP8VteRzxUw8o+mXylx7VS4NRI+eiK61gYUCYfJT//OGCQ9vgXCoLks1F
 /3nBpj17o1InbcYSi/BX5Myg1X5K7jq4XsjIKnB4GZPxE4cv+oMevpd8KuUeU4NKZfI1tlk7M
 nU9YYQyfSjix7OmPJY97q7ot5dULIFaqJ7CjbY7BYnSFzgsgClJ+HACiEWsRnlJTXf0vWn7dK
 A3ZntsqEIpqYfkbA7P6IBo82dW0awV5/O8qLxiEbAIZiombI01yae0kYGWLx+qtI1E9Azd10T
 gmaM/+H/rwzY7mOwPINokB2xPipZf6VIPO1nqzDMvhQsvHeqGT+71la+4ttvsqf9lWz+tD1iA
 A9gimLNuyjIUAywtkHHtSHZEFTgpl/7imSeqn3fXGV40mTLvIKoc86kWyx0+S+tCAfdORWxwV
 BBqIcVhD0aW0QMc2PLlgqruY3J/uRkXEl1zgz+Mx+YHrj/IUMjSsNcL5o8ZZWmDWNiiy5Y+6F
 uY4fMZROA7lQ4YewCxwt4/PpkDPHtJJ1NpML/QOo80PEZkbPSBIhsH+pT2y7Tm4L9LSfoMTLZ
 wDtjlHysgA4YG1cH6JLxJtjQWPgA5gNqf67+a3RFkr1IiFwOHML/TOhp4BRIvO76OJDZCiT5g
 aF1bmgUcifviLRg9GvNl+hD/dFuMKi/VzyjOp1fzGF1pjxrPXplVSYUoUyaCdCg3p/QxbeQVh
 F4/PLLOTkBCwDo1jFCPka3bAqI68qyx7qPXM/d2a4HDzLYD5TgVY0ftgy2wN6V6k+eelE5+MI
 m1KC4S84Qjtz31bAVKz0Qs/zBmdzPWqhw+1ovARXwo+ZLabakjtTyZ5Nb+LeDN+mPzDuUlj6z
 ujP5iaEXdr1BD+Exp
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/3/5 =E4=B8=8B=E5=8D=884:17, Nikolay Borisov wrote:
>
>
> On 5.03.20 =D0=B3. 2:40 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2020/3/4 =E4=B8=8B=E5=8D=8810:24, Nikolay Borisov wrote:
>>>
>> [...]
>>>> +	int err =3D 0;
>>>> +
>>>> +	iter =3D btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOF=
S);
>>>> +	if (!iter)
>>>> +		return ERR_PTR(-ENOMEM);
>>>
>>> This iterator can be made private to handle_one_tree_block as I don't =
see it being used outside of that function.
>>
>> It's kinda a performance optimization.
>>
>> Instead of allocating memory for each loop, we allocate the memory just
>> once, and reuse it until the whole backref map for the bytenr is built.
>>>
>>>> +	path =3D btrfs_alloc_path();
>>>> +	if (!path) {
>>>> +		err =3D -ENOMEM;
>>>> +		goto out;
>>>> +	}
>>>
>>> Same thing with this path. Overall this will reduce the argument to ha=
ndle_one_tree_block by 2.
>>
>> Same performance optimization here.
>
> Ok, fair point.
>>
>>>
>
> <snip>
>
>>>
>>> or simply if (!edge)
>>> break;
>>>
>>> Also this loop can be rewritten as a do {} while() and it will look:
>>
>> Yep, but I'm not sure if such do {} while() loop is preferred.
>> IIRC there are some docs saying to avoid such loop?
>
> I'm not aware of any such docs, can you point me to them?

Then I guess it's not a problem. Pretty happy to utilize do {} while ()
loop in the future.

Thanks,
Qu
>
>>
>> If there is no such restriction, I would be pretty happy to go that way=
.
>>
>> Thanks,
>> Qu
>>
>
> <snip>
>
