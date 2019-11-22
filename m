Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC31073BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 14:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfKVN4X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 08:56:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:53691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVN4X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 08:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574430981;
        bh=Rb8lTO4BaMYIcsXGaHcfMoXmOcp9TWpNUT3WDoXusd8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Hs0rQC0dm/tj0JMLhneIR2FBDKgbmw/qmTYpqgHag2hpoj/bZLi3Rxuqj01nBDdYW
         xre5jW5nK8fLu9ddAvbFL0NC4Dvc75LyZBIGp9F0Nf37xMAmNW88q6dV/aZz7GmCQr
         VHSzW66I2IH0BJmplqjPecK+VCChNhNcAjI5Yd6U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M59C2-1iX3UO33Ku-001D9k; Fri, 22
 Nov 2019 14:56:21 +0100
Subject: Re: Problems balancing BTRFS
To:     devel@roosoft.ltd.uk,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <65447748-9033-f105-8628-40a13c36f8ce@casa-di-locascio.net>
 <1de2144f-361a-4657-662f-ac1f17c84b51@gmx.com>
 <e382e662-b09f-c9f3-e589-44560a7b9b97@casa-di-locascio.net>
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
Message-ID: <b1df6eec-4e23-33df-214c-6d49fb5fc085@gmx.com>
Date:   Fri, 22 Nov 2019 21:56:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e382e662-b09f-c9f3-e589-44560a7b9b97@casa-di-locascio.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lJP4QapQtBjTvNhbg00bFrc0FUbZIbFiR"
X-Provags-ID: V03:K1:nlU2ThBhK2efibEWCgc08Kw9DJGEEJlnfw2S+OFBaBjDyHcPCsd
 ftPIq3iJHnSUR1t5bLY58D9K+xuLe8KxuuOKyReWobjWkkP2gos7jxsFHEoktSj13N2VVCV
 G2Y9jNu6RjvrC48MjmsnqRqjI3KCAG8KMJm3TA28HvryBzZ5uqIB6hkPB8BziCDeZzDGtqY
 Nbhdel5jHNWI3b6Kr6l9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YYHzBpnVsTA=:ztUY7V8IfJ+mCu1hCKfd0G
 NOX9pif5UWLdYlpe2mh1RxsjSbYpMTVeyzEO5bdaTuWYFQdYstkK3z4fFbumbKUAEdIlKBVSe
 ZGCVwGRndPHVnYqFFjBPdae3czxaZF2vilD6RQj7oPBgaZRVRRGBp38c7xkuqcnW3fH93hWAh
 mG3rfS6m1KiQm9VFxa0Y6wUhuDGHJObHu6Yyj+PJSrLeAVK9qWGirUDd+KE6Ym+co64YVDXmo
 4a9D7L+c7pTccI9XjHnpiZDOjNkGmtwmK298hsd5dFzQFmMrGrs6KM6ag1Jn1mDVfLBFReExE
 X2wnrGRJiy6LBSIWzufXbE2IHjgRnEdwX338/VgzqIO22O1Y8R8vSbM4jkPFHJg8WpZXCYZ2I
 IfVX5MHMMowRAYDycLADxpPmtNos8LRio2GLZh7n+tCWcN4AHeJJr7l8tmaESzMn5597hHnsT
 H09jKzbdtZuH65T7dAELsnaFJuEQAtiDYyLESrqy5KNTKkLqXbcJmrTO2XT/ly42lgfMt4AFh
 kCvE59/XPunY3l+qZXnfRIeOSxiQNEfyxoVnywr4gKG/5EGuVTEyXOqbdAhDLL9f//Yngpik3
 yQdXjMZe5GMgXDW4CxbYrLSVbys3j1MdCe2L0H6FetcmnTkBNtuDYE9VoEbG1wL2mNcsXvo1B
 0uctvK64ZYW0zq6ak4I/Gl255x5pnk3yT2nK3rMleF7QKn+wghL3puBT++j8B0/35OEDIGCCn
 Vk+D9dAM7i9xppbd78TqGvzYHu/DjjG3OVGwWOtA7P5ET02WOp4vawCpnaQVMFDCQcRLxRtTd
 7ybwtdY+K3P7pO2I2TNivbyFpdWPJMtOGqngveuevcwywhf4mji2jTUP0n8SUi7cYrhYFxRJI
 u0vPaKz4ctk+3JyyA4CHrW9RbMwJ2gYrSJemkRbzuqWKR37LzZTQiTrrB1EjoqD/USgs1XtgC
 RhI1hU6OLpg6cGzIzpMSew7ovEBKQocryfBzMd8WAlkgV90eI81Z8oheU3Uw9GVAF6MGNfGCz
 L8sJrJqDdncA9gu/5ffYd5uQgzypXx3hOD0XwMjYkz+zpBeUdu/cKiIgUI/x/2VfW56Hn3O+X
 i5enzmkZp5l/VTUvloUFEFshp3lycFPz4IqNMDaZmnJFxYPMvZ9dRybbjAbscYE18tGbP76kC
 DPOJQLG/Byw/EcDSudxaINguozmqGYSTBcFFRcy60OJ7URqqVfC7Xe3awQ2++rQ+wagc2yh9W
 +woi2WfgHZRxY+jB8d7lqMqhOO9Dagxx9mzTFN+qxUph3UuF6gsPCxCOXiFY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lJP4QapQtBjTvNhbg00bFrc0FUbZIbFiR
Content-Type: multipart/mixed; boundary="yvdzNFtUgmDudySesRZddz2Mp867HDwhV"

--yvdzNFtUgmDudySesRZddz2Mp867HDwhV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/22 =E4=B8=8B=E5=8D=889:20, devel@roosoft.ltd.uk wrote:
> On 22/11/2019 13:10, Qu Wenruo wrote:
>>
>> On 2019/11/22 =E4=B8=8B=E5=8D=888:37, devel@roosoft.ltd.uk wrote:
>>> So been discussing this on IRC but looks like more sage advice is nee=
ded.
>> You're not the only one hitting the bug. (Not sure if that makes you
>> feel a little better)
>=20
>=20
>=20
> Hehe.. well always help to know you are not slowly going crazy by onese=
lf.
>=20
>>>
>>> The csum error is from data reloc tree, which is a tree to record the=

>>> new (relocated) data.
>>> So the good news is, your old data is not corrupted, and since we hit=

>>> EIO before switching tree blocks, the corrupted data is just deleted.=

>>>
>>> And I have also seen the bug just using single device, with DUP meta =
and
>>> SINGLE data, so I believe there is something wrong with the data relo=
c tree.
>>> The problem here is, I can't find a way to reproduce it, so it will t=
ake
>>> us a longer time to debug.
>>>
>>>
>>> Despite that, have you seen any other problem? Especially ENOSPC (nee=
ds
>>> enospc_debug mount option).
>>> The only time I hit it, I was debugging ENOSPC bug of relocation.
>>>
>=20
> As far as I can tell the rest of the filesystem works normally. Like I
> show scrubs clean etc.. I have not actively added much new data since
> the whole point is to balance the fs so a scrub does not take 18 hours.=


Sorry my point here is, would you like to try balance again with
"enospc_debug" mount option?

As for balance, we can hit ENOSPC without showing it as long as we have
a more serious problem, like the EIO you hit.

>=20
>=20
> So really I am not sure what to do. It only seems to appear during a
> balance, which as far as I know is a much needed regular maintenance
> tool to keep a fs healthy, which is why it is part of the
> btrfsmaintenance tools=20

You don't need to be that nervous just for not being able to balance.

Nowadays, balance is no longer that much necessary.
In the old days, balance is the only way to delete empty block groups,
but now empty block groups will be removed automatically, so balance is
only here to address unbalanced disk usage or convert.

For your case, although it's not comfortable to have imbalanced disk
usages, but that won't hurt too much.

So for now, you can just disable balance and call it a day.
As long as you're still writing into that fs, the fs should become more
and more balanced.

>=20
> Are there some other tests to try and isolate what the problem appears
> to be?

Forgot to mention, is that always reproducible? And always one the same
block group?

Thanks,
Qu

>=20
>=20
> Thanks.
>=20


--yvdzNFtUgmDudySesRZddz2Mp867HDwhV--

--lJP4QapQtBjTvNhbg00bFrc0FUbZIbFiR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3X6PwACgkQwj2R86El
/qgmDAgAoWHQjjIQFu0Sxz57xKBxU4jw2baNZimGa0Db2cakrM+HtoC/tZg/dsO9
fN4P7sPM3aKsV7v4kBwcOuEZfC5D7JAHQNend5jHXbZmYoK/YkEoHLerQpSODf4J
YOv8qz3NWiD2QlWfzT3gw0fFHjMi2ketwtfB8h6fkaVTpphu7jqV7zBAOY85KEWq
f4uuVMYBmOdfZhIJC+8Bdua/deQjvb4CB1MYrbahDjSfOcJnJ5g1c9wLRuNhD0PU
IlzwkLxEMLvm2J1pCN8hLuCfXpCBJiXI4Hkm9QUJZ7A+9NL8uMq0QhcyK+dg8Vgx
im4aoSe392F9768jU57CGz1/tEQa1A==
=TcXI
-----END PGP SIGNATURE-----

--lJP4QapQtBjTvNhbg00bFrc0FUbZIbFiR--
