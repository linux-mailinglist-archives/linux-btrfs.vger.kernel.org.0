Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2282116CD
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgGAXu2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 19:50:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:49615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgGAXu1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 19:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593647425;
        bh=YTC1zgIVKoXQajqO2uiAnh4LbN+S35jHpPBuSztgHL4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hEbhfHieYAl42duUc6ZgA3RQynCJkIkjgvI3a0xqVXDWm59E0bx1WufYpbTGqrtIz
         5LLjk9iftSxzQqdf2wJwxEdaBjGNAjdZ4WRHle1DwlA2hCnn0C+IT1//ZW5T2PRBd0
         bJKUCbWdezLbqXkW2BH/VZ0UMZ/lErzxVWJ+Lcb0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4zAy-1iqGI81SQm-010vKw; Thu, 02
 Jul 2020 01:50:24 +0200
Subject: Re: "parent transid verify failed" and mount usebackuproot does not
 seem to work
To:     Illia Bobyr <illia.bobyr@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHzXa9XOa1bppK44pKrqbSq50Xdsm63D_698gvo2G-JDWrNeLg@mail.gmail.com>
 <45900280-c948-05d2-2cd8-67480baaedae@gmx.com>
 <2f22bd0a-aa48-d0f1-04d0-cb130897249d@gmail.com>
 <39558ad7-dfb3-05f7-1583-181f76f2a93d@gmx.com>
 <f6fcf7b7-37c8-8a0e-e373-03b8c828ce09@gmail.com>
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
Message-ID: <7ddf8614-a7e9-2284-828b-644b5fad510d@gmx.com>
Date:   Thu, 2 Jul 2020 07:50:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f6fcf7b7-37c8-8a0e-e373-03b8c828ce09@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QNeAo8OPhVIMOeFo5JlOH5GDgQmFNMTCO"
X-Provags-ID: V03:K1:Edh9WujSXBeRU9amXsT13niOi3LRNkPkQx6VOAaZu+1jS1Se5IE
 lTgQjnV7sXD3cQpUHeduerYcklayoWSKeneowWAMO26XkmilGm2a2iGX7apTI7CB9hh8z2r
 RVoWl14TN3SlV3ueCpq+jLWfzASbp+P0dp72YrvXwfYje2lAWLUGgx7fXtdPYa8ppM2Ep0f
 U0kRJL/y0+3VOpTHmFedg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q0SxBlpyfNc=:19bpa6m+13WaFc254ZWlfd
 n4xY3A/O6yH4uq2bwfEU4OzclBSj891Yi6Di213EktDR2n9v8WotcihTegQ4adCU89Xq3GRoN
 +aMEP2lgC0c9Imj8UK5OGp5eC/0vildpwWRcm0IKqGEQHLxzR4zryiUIOnOPwUcKOZOVqmoMn
 pNmIe8bt9E+QBm8jj2Csf4IQU2Lj4vhFSL2kLpMu7i1wXCziWU1DQq3jZlrQ4W/jQU6ZO3Uyx
 cPiZUGLK3mZibV8I5bDuUixamc0WmcwlPTrqjYvP1YJpnOVtaMd+j5dG7T64wqFlEWnjG04i/
 hb4Fi3tZmh8lvOzvri53nfDEdbG7oSQ8WYrGFbNzQA1i1TodVlxavHXg1zWZzApmp1MoZe5Mp
 sQqlWtbhGvXsFE4gfVwZhOvtFIYRfQqd3WT7cBIOes3ItxDinJd2FqCia+hOC/ol+nAr6GifN
 mDMLoZYglyuKv4JIBTNxXv2ziB9y3Fax1cxKl11IqRYCSVe63Hh93O48jMMU0qNRfLmWceKB9
 IGPSsZ3qfjJlJN/EI0PtDVOymkSAGd+mTo53h5pV/Zai8eYNLdyjVRdBGIldIzsJO+BLm0lZh
 dxsrT2FxiDpDrbgMvCviWzIQC1ZLKhygoov77P7VHvpErqgNLPl3GqffiWsKRZKpU8SjMSDku
 yVE8eeKv0Cwz+6ks/eU66019tqfAKa3fBvM8Z6CchqLGmkDwQm27Q//ZQbjOd4aavYFNV9TEt
 p/SqzBvrRzXRY279rF2UBNvXyV/ckaILZ9PbXwQZYMW0NyfKd4EMjzw/JKIar0RKdHeRkADzt
 OJpRFUVz1xRMRVmf3glD2IPINSQyb+a0S3kfFvGwem7eSgSwtyom2ZZ+kEns4WpYKk/xHg12r
 MvE6pgccFERBlbKIdV5hqd8ELWUou1uNhz6zYk3vwjydRzGtw6MfSUSU/kmK4tRwiTHSBuv8M
 +WhHRNiPRhVMeAFEywM1Q/yiXA9SF2NuZ9+4uuV8hnDv5lezPxaoOCQ5uiag/eEpQmxNBIlPY
 Elw5cFxGuyf8quQ8BSYkGOh6eHsDpQTAs/CNMz0KHB6ChSyEp8PIJWYnYSzNnyoZ0FQ4jsWZi
 3UuvPL1SIVkgv2MrU1CqJ1RpMlFUwxDMbch6hhRpS1g2yR59JTYF2b1moUhsLlmjO7xI87Qei
 41wlcp/rBG6+KuTBphmX1YZsfwfJ7AgLDSQTpDrISgiI7oOHOmlV6TmM5bd+Rzo8z96Uc0dOb
 UYS/FAn+Fsx1xXrRR
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QNeAo8OPhVIMOeFo5JlOH5GDgQmFNMTCO
Content-Type: multipart/mixed; boundary="NarNln21r5VePwXu2toAW8UdcQp9K4oN5"

--NarNln21r5VePwXu2toAW8UdcQp9K4oN5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8A=E5=8D=885:36, Illia Bobyr wrote:
> On 7/1/2020 3:48 AM, Qu Wenruo wrote:
>> On 2020/7/1 =E4=B8=8B=E5=8D=886:16, Illia Bobyr wrote:
>>> On 6/30/2020 6:36 PM, Qu Wenruo wrote:
>>>> On 2020/7/1 =E4=B8=8A=E5=8D=883:41, Illia Bobyr wrote:
>>>>> [...]
>>>> Looks like some tree blocks not written back correctly.
>>>>
>>>> Considering we don't have known write back related bugs with 5.6, I
>>>> guess bcache may be involved again?
>>> A bit more details: the system started to misbehave.
>>> Interactive session was saying that the main file system became read/=
only.
>> Any dmesg of that RO event?
>> That would be the most valuable info to help us to locate the bug and
>> fix it.
>>
>> I guess there is something wrong before that, and by somehow it
>> corrupted the extent tree, breaking the life keeping COW of metadata a=
nd
>> screwed up everything.
>=20
> After I will restore the data, I will check the kernel log to see if
> there are any messages in there.
> Will post here if I will find anything.
>=20
>>> [...]
>>>> In this case, I guess "btrfs ins dump-super -fFa" output would help =
to
>>>> show if it's possible to recover.
>>> Here is the output: https://pastebin.com/raw/DtJd813y
>> OK, the backup root is fine.
>>
>> So this means, metadata COW is corrupted, which caused the transid mis=
match.
>>
>>>> Anyway, something looks strange.
>>>>
>>>> The backup roots have a newer generation while the super block is st=
ill
>>>> old doesn't look correct at all.
>>> Just in case, here is the output of "btrfs check", as suggested by "A=
 L
>>> <mail@lechevalier.se>".=C2=A0 It does not seem to contain any new inf=
ormation.
>>>
>>> parent transid verify failed on 16984014372864 wanted 138350 found 13=
1117
>>> parent transid verify failed on 16984014405632 wanted 138350 found 13=
1127
>>> parent transid verify failed on 16984013406208 wanted 138350 found 13=
1112
>>> parent transid verify failed on 16984075436032 wanted 138384 found 13=
1136
>>> parent transid verify failed on 16984075436032 wanted 138384 found 13=
1136
>>> parent transid verify failed on 16984075436032 wanted 138384 found 13=
1136
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D16984175853568 item=3D8 pa=
rent
>>> level=3D2 child level=3D0
>>> ERROR: failed to read block groups: Input/output error
>> Extent tree is completely screwed up, no wonder the transid error happ=
ens.
>>
>> I don't believe it's reasonable possible to restore the fs to RW statu=
s.
>> The only remaining method left is btrfs-restore then.
>=20
> There are no more available SATA connections in the system and there is=

> a lot of data in that FS (~7TB).
> I do not immediately have another disk that would be able to hold this =
much.
>=20
> At the same time this FS is RAID0.
> I wonder if there is a way to first check if restore will work should I=

> will disconnect half of the disks, as each half contains all the data.
> And then if it does, I would be able to restore by reusing the space on=

> of the mirrors.

Yes, there is.

We have the out-of-tree rescue mount options patchset.
It allows you to mount the fs RO, with extent tree completely corrupted.

It's in David's misc-next branch already:
https://github.com/kdave/btrfs-devel/tree/misc-next

Then you can try to mount the fs with "-o
ro,rescue=3Dskipbg,rescue=3Dnologreplay" and do your tests on what can be=

salvaged and what can not as if your fs is still alive.

This should provide a more flex solution compared to btrfs-restore, but
it needs to compile the kernel.

>=20
> I see "-D: Dry run" that can be passed to "btrfs restore", but, I guess=
,
> it would not really do a full check of the data, making sure that the
> restore would really succeed, does it?

It would only check the metadata, but that should cover most of the risks=
=2E

Thanks,
Qu
>=20
> Is there a way to perform this kind of check?
> Or is "btrfs restore" the only option at the moment?
>=20


--NarNln21r5VePwXu2toAW8UdcQp9K4oN5--

--QNeAo8OPhVIMOeFo5JlOH5GDgQmFNMTCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl79IT0ACgkQwj2R86El
/qhOAQf8DRHkfV4MRUFyVVg958TKemIgKnwAepH35TjBJkvSw7Tg739ZNMbCkFLB
rJ9m21wsgBDs+/To+FA121AgC/hWO/D0Dc52qfVR1iucl4l1CxDW+be7it3aLu/F
uyPEhiEAR58QPHDllt9YIipk80NgP0ywTiev0KMAxGo95B5LoAvDoA16b1ChaI+/
loz4YWHtyadivM1uiSVZZi/RAXcsVFqu5maniX/2DHkzhh+S1yWNBqAWUBdO4iI3
AmjBPXM8RXSgHfl/FbSxXl1sLf4x/YCNPCTaJei5bw85DjG/05ctud/7GtgdahDK
ApNFnfjedy16U9xMsRrVJM30UCO/Kg==
=xx4x
-----END PGP SIGNATURE-----

--QNeAo8OPhVIMOeFo5JlOH5GDgQmFNMTCO--
