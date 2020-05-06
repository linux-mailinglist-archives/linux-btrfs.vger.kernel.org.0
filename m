Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A244E1C7DA2
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 00:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgEFW5v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 18:57:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:51757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbgEFW5u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 18:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588805862;
        bh=jxNu9XqL7jnOBV+8rS6wyECRptl/XBxd0JxFLZiOM2o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HwOCwXEhI7C1cOfRZaG3SwtP2wHqCazVrfVzG2KYE7VCWbu57OEgmk3mBenGojnZD
         mFLy2cAtfPFaDdPawWZR74vs6slFrOPrPK4GQXTycuLWMLPaypCNMFYVWOBlfy9z18
         99aRtxPkT1jAHPICkwRWUMuCG4HOJM+kJsVWRzmU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7K3i-1jVOeo0ISC-007ilW; Thu, 07
 May 2020 00:57:42 +0200
Subject: Re: btree [was Re: [PATCH v2 1/2] btrfs: add authentication support]
To:     kreijack@inwind.it, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200504205935.GA51650@gmail.com>
 <SN4PR0401MB359843476634082E8329168A9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <d395520c-0763-8551-ec80-9cde9b39c3cd@gmx.com>
 <d649407a-7ca4-e9ee-f291-7845c89c622b@libero.it>
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
Message-ID: <2ca44136-438d-2b88-160d-9a321cff6f49@gmx.com>
Date:   Thu, 7 May 2020 06:57:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d649407a-7ca4-e9ee-f291-7845c89c622b@libero.it>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GKrMqDhfaAql14qnfaP8qJRIWZy8QVpwS"
X-Provags-ID: V03:K1:UkxZiaIdNmJ2z7yaE1OJ2AW1vQ6RQ9jbPAzGMrVhTh/wx46eSrz
 qRoQyfiBZCDe+VBbRIKw9EQGlHFZbeFz89YAA34c0Tw2DMgt4L3sEGFuwsnfZuFoOAvX1Mb
 SKjO2RxvTNSdrCXa2koshsXfSE6QPtMtlh43+cyJhDKyJOtOe4dr50ueRrych5rvGNQvn6/
 4Ile28u8p3ZeeOBBUa3BA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0rHFNjZTf/o=:KVhZMXZb/0N7G61VKutRrm
 /f91grFzu5a3CDaWpThx8+9woXH/VN+0P/AJS1ujbjBM2BinKS2bDRkbkuS+oPmZ8N4eeDEXV
 ETFadzCiRrJcn6yz2c92eHrU9QlWz1iQ/20WVA7un7cqHaGfM9TTvwo0TVtLzLprj+v+semSR
 N6eTi5brepNVEd98Hs7Tq91sqJ1SC+VvAStMngS4JBGobt7/XRpqXItHVEulvkx28rzlC5H+V
 vHSjmSdVoz33rnu5DJzNDg9tSmHcaquoSbUGQKF+8G1VVGMqv/gEyfcDT1mILTZ2rSmHBq6FN
 MOxEGLzfSj0OlW9cwLASbbbKSnGIQQxZ5lID0mVrxOrrJELsfUCXQ42tOgADTVray+/2jfCbv
 pZupxIrhS/ZWkyiICTAqZA/d02RaQoKr1Je0LKB0BUOHZQ6JFLQJR2nkhFlr7p6PAJMtdm5Es
 zMjprKO2xluK7qH+KN8iQPuH6PDhr0lUpfyTgGUt6ioW2zcl8qJApHdRSRr9h8STNrrutQ9lT
 w9RrS5akJJqS//nYEHYii8Tbmfuz14dDSYd/Dn6So7bBeXCF981A/K5sc0yBtlwpTMJ09hi0j
 q+kgy5Fv5Gc6x4W5UqWYioDGcuf8Ag44pSfMyqeEgouCfc8bl5e1pMfcXTK94S+3UPNhcwbJz
 e658T/CIv63N0ojURnNy0loDm9qSOXT6lhRmOwKeycWv5EjYA+x/q5tQGb2/suGoSXLT9lFaT
 QhB+G/zjULu/gdrvW8tUzTDRyNghLd6rqWPtOK+zKnLkABTJAxXZ2d/+F0mb+nPFY9pSH181B
 zZNJYKUTXdZ+VMqWdRBUn67IKYmaM/+/ughKg6lVFuLw2pJi5DYblTQ9h/WCwFeXpV+XutoP5
 pQ/0je2C4TOf2ixvA+VmyyRywoBfGzWVD3Jmo6lrHdNboO3VeeIa3emg7kkmCAFt0yqUjbd5p
 6WE3535Y45iTtT4QUokJzqgPdTJ5OnBnSlaDO7nCrsxghypDIUnfAnowxBxslQqbwD6hN0PyV
 IZ+5eGtVX60KxR72ZPCu28EzAWV9nAS0vpNSlH1GPhHAXbuUhXWQwMQUoz5CrGE7x4E3bvnLc
 djlgUM2yMYduwJiy8TO1ZnvtWgH2D5sx4Bojaf6E7frDyPHvM5WcmFOQU8BVm5Cgm0IUuiDQI
 cYIoIjZjF/rDFZNazOGhZZ9h3BQDBAbSpWfURGJBN3T/RkjBEFMERogZjZ7qot3MOmMJ76aVJ
 6qf7Kdv2CQQAeSDDO
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GKrMqDhfaAql14qnfaP8qJRIWZy8QVpwS
Content-Type: multipart/mixed; boundary="ExN8DTTJt8oBejO9kyXN0NSsFgCJiF7PA"

--ExN8DTTJt8oBejO9kyXN0NSsFgCJiF7PA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/7 =E4=B8=8A=E5=8D=884:40, Goffredo Baroncelli wrote:
> Hi Qu,
>=20
> I will go a bit off topic, because I am interested more in the
> understanding of the btrees than the topic of this thread

Then removing unrelated CCs to reduce the noise.

> On 5/5/20 11:26 AM, Qu Wenruo wrote:
> [...]
>>
>> My personal idea on this swap-tree attack is, the first key, generatio=
n,
>> bytenr protection can prevent such case.
>>
>> The protection chain begins from superblock, and ends at the leaf tree=

>> blocks, as long as superblock is also protected by hmac hash, it shoul=
d
>> be safe.
>>
>>
>> Btrfs protects parent-child relationship by:
>> - Parent has the pointer (bytenr) of its child
>> =C2=A0=C2=A0 The main protection. If attacker wants to swap one tree b=
lock, it must
>> =C2=A0=C2=A0 change the parent tree block.
>> =C2=A0=C2=A0 The parent is either a tree block (parent node), or root =
item in root
>> =C2=A0=C2=A0 tree, or a super block.
>> =C2=A0=C2=A0 All protected by hmac csum. Thus attack can only do such =
attach by
>> =C2=A0=C2=A0 knowing the key.
>>
>> - Parent has the first key of its child
>> =C2=A0=C2=A0 Unlike previous one, this is just an extra check, no extr=
a protection.
>> =C2=A0=C2=A0 And root item doesn't contain the first key.
>=20
> It always true ? When a key is inserted, we update the key of the paren=
t
> to be equal to the first of the (right) child. However when a key is
> removed, this should be not mandatory. Is it enough that the parent key=

> is greater (or equal) than the first key of the left node, and lesser
> than the last of the right node ?
>=20
> Supposing to have
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 10=
 (A)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=
=A0=C2=A0 \
> 1 2 3 4 5 (B)=C2=A0=C2=A0=C2=A0=C2=A0 10 11 12 13 (C)
>=20
> If you remove 10 in the right child node, is it mandatory to updated th=
e
> '10' in the parent node (to 11) ?

Yes. And we're always COW so tree block C and A will get COWed (and if A
has parents, the path towards the tree root will get COWed).

If we remove 10, then the result would be:
	1 11 (Cowed A)
       /    \
1 ~ 5 (B)    11 12 13 (Cowed C)

Thanks,
Qu

>=20
>=20
> [...]
>=20


--ExN8DTTJt8oBejO9kyXN0NSsFgCJiF7PA--

--GKrMqDhfaAql14qnfaP8qJRIWZy8QVpwS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6zQOIACgkQwj2R86El
/qj7aAf/Qd6wn1CaXeMXp15dz8DDqkDkU/osvWnxdoHYlM8ZV0BQxbY+/IhHwz28
iQgnaAnx/tNxPqVJL3KiHSFsktm2i7IT+F/Zye4z/9HccBj5tBGaYyeGjjpTbuRy
bJor4zOJ3Q8cEQKSoZ5WPU5mWQcvpOApmnAtIwX6Otf577+1PcMkLarhLT5qv7hl
spMq9VPcXQfyMh4XX9H/RObtokSGI4tFgQh4Iug2cp/hHH7Xz8687DqgXDvtWs8N
CzTwNbwB09NQ//UG9b+5zBnoX6kdK59nHf+8ypM6tfkED5s7NtOibQlBSa56eooL
gWU/Jf6uLjlbNIRttB3Tibf6r4+Ypw==
=rvU6
-----END PGP SIGNATURE-----

--GKrMqDhfaAql14qnfaP8qJRIWZy8QVpwS--
