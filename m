Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB5478D52
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 16:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfG2N77 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 09:59:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:57581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfG2N77 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 09:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564408797;
        bh=rQfPWU7v8Sqij/VH66aSwXGjqbJcherRKVdrCnX9NIU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=cIxMzHptMCNQVLiOd/kzwCLOGhxbahFZaOIKnmTa31yfO44omuWNjpufwBbvw9BVC
         0wqyfhV1RDaS2N9XeK+sto9EkZqHtdMPbaMqKxT/650m4j9SPGBBBu/W8JRoGmjCyK
         kT0l6LubZT7Kl2its0in++qHuRlMDy5S2r5nd60c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MGjfl-1hf7dE1InJ-00DWTk; Mon, 29
 Jul 2019 15:59:57 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
 <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org>
 <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <ad72f3dc-d801-8857-885c-32b7ee206518@gmx.com>
Date:   Mon, 29 Jul 2019 21:59:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b6PWeO9qMcebly/0mccxiTETWI1Rc8V5RcZgFqGktxIxstIwU58
 RSdfZb/7hq0/K69ON7ASb+DpYbOJ2e/z3wkpFuWTO9dimSCHIaq1SQRXvCT6cpUiR74MNkE
 AZbrJ8KMgWV01xQ2MkevzBangh5OLDgXbDkitLUmiIjZdjxxaKKF/9RiFwyWzjka8uP6pUB
 gmeoFZNj9cZ7i0Bvxzl2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DNLgRSYKlZ0=:pMUP2cM/JNm/V1ALMFGn12
 oPTM3JgsVlsTTgOyGH4YYo8B5pxtOByHv09zLm0+J7vkelZcvBJskDlzqGOkRKAQU+a+1yjx8
 xzhdhzD8pZwcNwUADAEG9TjOBf8p0rvVrb918qmxKUcxsCtkkP0Jqw+sKE9Kx81NQkJlUzpKS
 9Zwr+oHrfqKfeqQJo+/0HgzXn09YCKUueeww2NFjyN3T6UdO72RWDZ0WfcGrEvMtilpbLCXNO
 CJtfeZYBnvjuS7JMpeHRP2NiGSRRamTRodU0yklcTMB/Besqo5wvxeeZCzEOsJP4p6BGRCJUg
 c0ooHqYPwip2HjNXSLdflBaV5qnTWkAR4KXNaz6E0e0czZUx8SzWlzVgn7oPEmZkWsDZ2Jrpx
 +/O+SXVKCFXPDPU8GeBjT5ca2s49FmPeKuIKBCrWZm/IrNuxT9TutAcYGLO6z5MczFrBy1+z2
 IY+yx/AcN2i4JgKPAYQZaHPjDX98IBwjeQ1PTGpwoTuIE4d6QiWTJKRjS3MPpATkOEZKYxHTo
 CLVo6nqBS3rVEq4CEtlQNtAjEhgOqgwWzxPgacxbW2c4kogfkFsz/ZdhQdZxpq/A5wNNxCg+T
 48wGtgRtoph0UF0ZPWohF2U5X+btnqt/GY+4wlK1DgcHhL2IkbIR8/WbulaHKYlNadkhilOdl
 KSfYPOjpDyqe1eejT63TYmpdQvsu3/kQj2gDSebv+6KzKWWuHY9Vo+crt2Z/6KaAylFnoQO5M
 EIXtqzDKSNNpNMhMtQMdC5Dh7YrtpTUiOsS7H9FlRJtkGjmWpASVQQLcH8kAU9xWUoH6eG2Fh
 Il8hUxDpL9gSoKtqE4Pyd+xhpuwbwTTi3Cj8L56/vo6/Baz1c5aPQ5uNFARHLTm3OQkdsqTTj
 MtpT/g9g2xK56XhcXAT/xA+IX1/uP2tEWAYBnfdayK7/AepQ2tqWWLVzjyxuVre9nqAp7Nn81
 ThVQgTEyedPnrmR02UWoxLOKD6vSahb0Tp33h7YscpW9n3z8Q+e8YMHPfshedNPL/4wr1hu7l
 r9yUJf0QaYltJghJ1TXE+WYvRp+/XRnN4RyF+6KMzjpA6tr6hgU5LvAxJvCYMRwM01fx1o6Nu
 IHilvbFbLcP4EHLazm5bhBDCJK4/JI0V6F1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=889:52, Sw=C3=A2mi Petaramesh wrote:
> On 7/29/19 3:47 PM, Qu Wenruo wrote:
>> Although there are some bug fixes queued for stable, it doesn't look
>> like related to such CoW breakage.
>>
>> Thus we need to rule out lower layer bugs to make sure it's btrfs
>> causing the problem.
>
> Please tell me how I could help.

Full history of the backup device please.

Including the mount/usage before and after 5.2 kernel.

>
> This machine was extremely stable (for years) before upgrading from
> kernel 5.1 to 5.2 so unless the hardware is failing, I can hardly
> imagine what else could be the problem...

You know, LUKS/LVM all uses device mapper, which adds an extra layer for
the storage stack, and it may affects how FLUSH/FUA is handled, and
break the fragile CoW used in btrfs.

And device mapper code is also upgraded with kernel.
(Although I don't believe that's the case, but we still need to wipe out
all possibilities)

Despite that, testing btrfs without LUKS/LVM on the same backup disk
(after you have restored needed data) would help us to determine if it's
the disk to blame.

(It's possible the disk itself doesn't handle FUA/FLUSH correctly thus
it's just a problem of time to hit such problem)

Thanks,
Qu

>
> Both FSes are BTRFS over LUKS (one using an LVM, the other not).
>
> Kind regards.
>
