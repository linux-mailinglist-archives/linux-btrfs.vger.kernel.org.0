Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA122AB163
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 07:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgKIGpD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 01:45:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:45071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgKIGpC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 01:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604904299;
        bh=QvzB2AwDCRZfUKE0npk05fTpBRVWJii4VO9fy/ogk/8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KqpGEtoy+dWGuO8GO172I3EPoNtyHH9GGJ6wT18FejO8/GELsouBI8k6vDMRaFaWI
         /uOG5DXXR8kr0gEQbdM4a85Y4sBL714Ahj3bFtuUY6UC7x82gBo2eTKJob70nhzzY4
         u8GCMIRfNLqqVTqTPYIQVRVpJmWGlltvX4ZD8Vxw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6DWs-1keEug1mci-006cGz; Mon, 09
 Nov 2020 07:44:59 +0100
Subject: Re: [PATCH 12/32] btrfs: disk-io: extract the extent buffer
 verification from btrfs_validate_metadata_buffer()
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-13-wqu@suse.com>
 <15477e44-e15d-9b8b-634a-d300d3c82d84@suse.com>
 <20201106190346.GT6756@twin.jikos.cz>
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
Message-ID: <bcbd0b74-b433-03a9-5bfe-2f365625c6f3@gmx.com>
Date:   Mon, 9 Nov 2020 14:44:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106190346.GT6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y7gxGCWIUHL6pKfH7QVo9YI90TFxU+ZGVGM1Rt9BTH4UtVLHHg7
 L3D/mm5Biu9EU6zfN5QAkuP5uGld43w9iFvS3sv4sZGKV4PkLRIPIVhj0FMLB0ZqLfOx4ZY
 Hr43VRBrpr5pXjNm/AEfq74q9w9hap2oySv56GVzJkL66CTvAvuoYnaVEsfaAUaKeAX6zIw
 Hkk3VykIpEJB62oYWCUzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v617fqIxnlk=:YZpx0vNqqJLf0bVm0LtZjF
 KW6TkOYj8uwxypq66WugyCLd5CpNCxoKLGVGwGeLzT+UhYwEYyoREyTsLWQttz2kzL+51IrdS
 zmusPgNYHUfL8L462pewkrmP7CNS11Vwl47Kj83tw0UYV7W/d/yP/kJxQzWcVcTgwoy1xUEZw
 ZdBIs6pYeuN2mg5+zrNxdzqPjPIVBsT1Po/nNnLfOaO49THQUHGxh3HUooIdQuqtpSdGIft/1
 Iiwn8qBaIX5iCdrpnYhbSoyH2TAR6HRrCwmR42IHIwGg972ADg1PkZKZG9z1a0cn1DsucwGMc
 qUvniCo2suPs6dvlRFoTACxXMJeaMCfzV0qID0i23AKzvW0ebT+7/WzDw5JpLBtfUvrj2n4jU
 lbLBYt+aGF1eIs5SAHEi5nZMqCd75j9TqL4dVGilNyvWP5X6CZUv8OKpYnkmkREIJHUyeh/OZ
 Paw97PTcXnMLjMjJy2NQoqS2CKFgSL/8OA17r4ERNbdE7HlRl4TpzcGbwb0lMb1c7qV7RuqVs
 QtG5y79vWOMKDyNBkhEJlF4yu+rn1PbIuZbwF6TmdlYgIApZ3zJykpozcgdIwzn7w7kLGe0Ic
 HK0RmBFJtOgtcoUzonxS9upJnn8KJTyLU3KBCiu05efNSWVsrE5hiwj/7lDX9NMr8v1hX5Hv3
 eFz8bMMYznMt/Z3OiLBCNLw+UdN9jYl18z2OURqaVlCB+lxVrP9ltLmXKZYW9PDPPCkLqiTyP
 XfDuMYGn0B1X1knvOlyuCbAkVsEjenWJlTUpbO20ZEgP5HzxD4noUQ/JFuj2zfBBymdWvMqwZ
 dtAG1e80MVpJSW9F4UOxXRt8pM4JDQRMRkQQaeIo1s1lk46TJG0ujR6Z2Pcu24QDz3CycKFe0
 PXnHxwLwy8dcKs28bPcw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/7 =E4=B8=8A=E5=8D=883:03, David Sterba wrote:
> On Thu, Nov 05, 2020 at 03:57:14PM +0200, Nikolay Borisov wrote:
>>> +int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 p=
hy_offset,
>>> +				   struct page *page, u64 start, u64 end,
>>> +				   int mirror)
>>> +{
>>> +	struct extent_buffer *eb;
>>> +	int ret =3D 0;
>>> +	int reads_done;
>>> +
>>> +	if (!page->private)
>>> +		goto out;
>>> +
>>
>> nit:I think this is redundant since metadata pages always have their eb
>> attached at ->private.
>
> We could have an assert here instead.

Yes, we can do that for now.

But later patches, like "implement subpage metadata read and its endio
function" would make subpage page->private initialized to 0 as we no
longer rely on page->private any more.

This means we will add the assert() just for several commits, then
remove it again.

Thanks,
Qu
>
>>> +	eb =3D (struct extent_buffer *)page->private;
>>
>> If the above check is removed then this line can be moved right next to
>> eb's definition.
>>
>> <snip>
