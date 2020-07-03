Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA909213A2A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGCMjb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 08:39:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:39891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgGCMja (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 08:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593779966;
        bh=Ot6Mkj4mBQIC7lJ+pd7t1jmlmSSz9aCzu8V7tcyOcWQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=U0Rh09iePhwhI0K+sQUgXYdcUIgNfCuAt7QPvoRDY3S+HElEikeL4NPOTAjVsQnIV
         gptAmFDqSRm5gLvtWQhDDrkeu7zjAqDIVWuoOd+Q8IsRNSzNtnvWlJx6gwlzZ3EG3D
         rF9KQZKy/xwt+hy/niOG149T4507rw1dXwVpQVPY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26r3-1jos8F0P6n-002bBY; Fri, 03
 Jul 2020 14:39:26 +0200
Subject: Re: [PATCH 3/4] btrfs: preallocate anon_dev for subvolume and
 snapshot creation
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-4-wqu@suse.com> <20200616151004.GE27795@twin.jikos.cz>
 <f792151a-ebd5-2ac7-c9ac-0c274ea1ab8e@gmx.com>
 <20200701173928.GF27795@twin.jikos.cz>
 <0cfc15be-3a4a-c6d2-b294-eeb0a4506df4@gmx.com>
 <20200702160821.GT27795@twin.jikos.cz> <20200702234632.GU27795@twin.jikos.cz>
 <dce7628b-f182-783b-6f8f-da543bc5421b@gmx.com>
 <20200703122910.GZ27795@twin.jikos.cz>
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
Message-ID: <b9dca058-857a-e7c5-9a49-edfb6712152c@gmx.com>
Date:   Fri, 3 Jul 2020 20:39:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200703122910.GZ27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RPXbg43CcbGD8OVrygvw4dMgIm5madltq"
X-Provags-ID: V03:K1:XzZvwwLzVGhm67slOxBNRids9l3E10DSo+ie+QJzuRpVeCINZKg
 n0pXp5ljpJIt0utM5e89r5YNcskO8+oamRnQSmUWd+g5dvXkjW42tfEIW1/+i4qPnpnq6df
 qQHNu5/Xu4Y1xZDbeGLHZPPxh++pVPNiXGAN+jDPjrB8MOG0WOD5icP92xZf6ePx9vlNazV
 FXdXOhYt9B9d3F0FqDTLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HcgJF90rlfY=:cK9S7Qu4Lhj5z5tNwmE2uY
 JJrI3mFlcK3GMAb8FhzEsqqMxWjTJFuGOfBPYVoJVnqhrzQbVqJfdrj/73SCI2f0KqpmIvpnT
 /jH4u03Ysk5dlc56Jr6qcLfeyYBVQxJdhyD8Dp+mbSuPc5OQKmOJwAHdQPFx60BmvD+vH5pAf
 RxjWS6HMyqkWbxjgeQx9bEIN0CeubonIL/b4vOG8fHMFo4oNC8hokXwQrmpeywXxqeG0XXX/+
 AM8Ord3bA7piQMJmq1b6t0ekbUXUxxIpgRbigfbsqHaXDkAAJyn++GvuR2BVW4R6naJqxsQUW
 hvn+w6pr+65wORgcwTJLx9K1uKogJsu1n4g4SluJUPzuHC2/yt234E/ccBuW5Achqjn1/CnX2
 TFFFG/LCCrwNBn94Hj49yXKsdPYaq1Faf6imJdscjvpGR+XjlRJv06hzyLol0oaKvC3DBvZCm
 r1IxYbcsRM/G2rumUAuUkTYcC0uLSyuFkeCwxN9yrFNLR2ZzjO0IzBGVDLu6VjTXPajxxLRXi
 vpo2lvyKPHTVqlRevCb0xdKc7Xa3g2dzniXQ7iSpDp0dZgFyGRwuHXZvrWE/p4VY/HR0rega4
 zkSWwLhs5GNm7iTJ3a/0PhlquMKao/07CjSJSz0dVveRYaH2cXlr9JiydpqHK0Na3qUrDjxVp
 JG/YPgfwiCUiP2K0jHV2cq+J3fbp3YxgA3ObqWGWJd+D5L46Qi4OUZ74sZ0TTExIC+6fds2Xp
 rhZ66KiExgccDcawiqnrMJ2F/Ma9sJYypwXOTew1cAyrkAk1n5+SfncKpRU8/+UiVktslk/me
 Sb0oqdHGBnrHHvdeMxQYT0dwzIjZsKob2Yk2SxBvgjjCvYGfwq13vc0YE1zVCQyCJjZxMNMim
 CoPWjB2fiWcf28Wr705w0lTxvTC6CEig3IZD2GrUJi9EGCYoIwoeWSif/9CxikuuaIz+IAJst
 1S46OwJl4k6kQ4rpBYP/PwaFwHNcFlFoCxBTCbxOb7zqeYF1RSdreuzcR668syb1noc53qzKu
 zJcVXA+gyrGSwDw2mMha8tLLMU7qW8v6ioUn2aWl/3G26x5kd6tFoizd/zx3LpKodII5ZUBLX
 sI6njlclMMM8Lk8KizmPuCmxWVP/H1qkYNM5BeCh2tQiZ1Mfxs4DDPQTl+EN4vvlHscYCuM3O
 dCs7YL6MtsaSUHY3rw+xAz2lW4JVh+aeubboqCWPkd7m3590O1v6sElF2u2od5mkPeoDIqLlN
 FZ15IzxVTYSySpwYU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RPXbg43CcbGD8OVrygvw4dMgIm5madltq
Content-Type: multipart/mixed; boundary="UieM7bxeOhsypg8osU79TbjSJVqnIk0LE"

--UieM7bxeOhsypg8osU79TbjSJVqnIk0LE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/3 =E4=B8=8B=E5=8D=888:29, David Sterba wrote:
> On Fri, Jul 03, 2020 at 01:19:14PM +0800, Qu Wenruo wrote:
>>>> In conclusion, your proposal is better and I'm going to merge it.
>>>>
>>>>> Although I would definitely remove the "__" prefix as we shouldn't =
add
>>>>> such prefix anymore.
>>>>
>>>> Yeah with the small naming fixups.
>>>
>>> It's in for-next-20200703. I've updated the changelogs to reflect wha=
t
>>> we found during debugging the issue, the __ function renamed to
>>> btrfs_get_root_ref and some function comments added. All patches
>>> reordered and tagged for stable though the preallocation is not withi=
n
>>> the size limit.
>>>
>>
>> Thanks for the merge and dropping the unneeded check patch.
>>
>> All the modification looks good to me.
>>
>> Just a small nitpick for commit a561defc34aa ("btrfs: don't allocate
>> anonymous block device for user invisible roots"), there is an
>> unnecessary new line after "[CAUSE]".
>=20
> Fixed, thanks for checking. I'm not entirely satisfied with the name of=

> btrfs_get_root_ref, as it could be confused with the on-disk
> btrfs_root_ref.

My original plan is even simpler, just get_fs_root(), remove the btrfs_
prefix...

> The get-ref functions could use some cleanup as
> btrfs_get_fs_root is sometimes used for non-filesystem roots. Adding a
> generic get_any_root that would accept any tree and btrfs_get_fs_root
> would be only for subvolume roots or perhaps related trees like data
> reloc. But this is not essential for the anon bdev fixes so that's for
> later.

No problem.

Thanks,
Qu


--UieM7bxeOhsypg8osU79TbjSJVqnIk0LE--

--RPXbg43CcbGD8OVrygvw4dMgIm5madltq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7/JvoACgkQwj2R86El
/qgmWQf/V1HDXxyix3nZnrb0gnEOLSn8lkS6YOTuhyt6ZS6mZbCEdWp1tb1+0wAK
195DZ1WdqL34yysDQzwN/7mbmQ42glLj5pL1ngrtCiN7fJ9uB8TAEeu10XmOuWRF
qVsO8p6gD+zkn7vNomCIwoYs85o4i0rj5ig54jJzm/d+rsQTdlRaookJNW9xaOWP
EZQOKP+yV+H+U+fTzc+Pb2PV3Jhrl8i6uOIhDbp9I3ymrWJyT8ztGMsgWjncURxq
8z4Bxfs2kcTFR/rO0z5/2n0GrLeyrB5jA55l/FU9Q6AB6mkRiCfOAnw2NiTFXUgX
1TIDSiiXUm9TJPApHZYLUdj32izTUw==
=jrrw
-----END PGP SIGNATURE-----

--RPXbg43CcbGD8OVrygvw4dMgIm5madltq--
