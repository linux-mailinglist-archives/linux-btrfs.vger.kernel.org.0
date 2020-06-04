Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FEB1EE1F6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jun 2020 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgFDKA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jun 2020 06:00:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:58191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgFDKAW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jun 2020 06:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591264817;
        bh=bPYIhbIPXMGM3OFZwfnybS4A8XDNKb+kEDNa8Q/aqnI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FsWts0XKzeMwGdzSkhXz6FsngOu2O7lILAct5jlMBT3v8ilqxNu3QnK5D9nnP9KvN
         fdrqSeO+pZHrTnA6nfsDPn3WQnkwD9n88w+nexpjD14oXbD+UNB/vI2mAbobNlYfVi
         JLTPj0g6HLfmMGuCsCRzcbNkI6UjtL04TMm4Sj9g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwUm-1iogcG19JM-00uGRJ; Thu, 04
 Jun 2020 12:00:16 +0200
Subject: Re: corrupt leaf; invalid root item size
To:     Thorsten Rehm <thorsten.rehm@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CABT3_pzBdRqe7SRBptM1E5MPJfwEGF6=YBovmZdj1Vxjs21iNQ@mail.gmail.com>
 <5fdc798c-c8eb-b4cf-b247-e70f5fd49fc4@gmx.com>
 <CABT3_pwG1CrxYBDXTzQZLVGYkLoxKpexEdyJWnm_7TCaskbOeA@mail.gmail.com>
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
Message-ID: <1cf994f7-3efb-67ac-d5b1-22929e8ef3fd@gmx.com>
Date:   Thu, 4 Jun 2020 18:00:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CABT3_pwG1CrxYBDXTzQZLVGYkLoxKpexEdyJWnm_7TCaskbOeA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C2IasBHStCXOmRsXBCPkJg6ijRW3WYhhF"
X-Provags-ID: V03:K1:+vF68XO6MHzsSD310v6wR03JPVeZ8qT8gyT48v8HvKMHe7uSScE
 JpmxrsnYCnEJrOkgO1RSOwor7SBFlvs6PB/hWnzFvRpenXRAKHfsBsemwLgpBOY3t4VjeCT
 WpkHN7Tibm5AKAqOKn+I+RBIbOq+jj6c1Qa68OZnmExPehhndKW46hRmdgzO/dj+J/pVgJ4
 k0pUk3stj1m2CQEG3wxtw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ocKxDHxfeW0=:ygoo1FdAa12Vr8nDsmKnab
 cwRDVBOhlEolw4l5wJ1JBNjqku6FR8hkvgw1W6ZtvE097m3UqOaUNdxY6EFU77pTVZ1+LgsPv
 aqpXgKsCwFqhbl8PLWHznT/usb0k5UkSuSOtzUuELF1Zkgtxj8PI0U7EZgPeo2RvWIb/9jZqj
 QtxGPVjo0V/cW3FSBhBIekDKCpVb6VRYLL/sq2Rk3qRB+COvCru08gbzpRtUSDLjed+z/SBNj
 tXxzQX2l3+l2zkzFd7/BIg114gavKfykAT7ZY2JSFwYWxX908fX6SJ0c9z2xCvZbePOpHwWK+
 twrXRFS8NBxVoPjD2AvrIy2HvSH2SDVk04f6IxfcadbyDFbdWu5kHLECDM39eCmVczGYWNPhi
 waw3DW2jPbeeYpQCxN+RxncohHRrFYB+WH5vNJUCMVDh7WVS0mC0Q6Ly5gZu3gitvbV8V3Sv6
 yrkQ4HxpZCYSr5aGHHG47WcwQ7jBU3zZMxK4/MQ1M+jI9SV5HM0NXDbuGy2CZei1FgQobv0JQ
 tOuUc42fniXRC8DXiDGOHdFhQO+qrzGkcwflsCoTtGItIZ7sqdCUU0B72ui9oxbcHnjDp1bNO
 C++EYWIC0TlYnDRQwtCdPFIeVJaixvuoQp0wm5O/MbWfdPMYDQ3deDh7HVQTda/efaUeOfT53
 pBtt8PlF3mlscR9NP5y8mxCdbJHcPh3ULR/e4KjR3p8Gi157fDPytW2ydzacL2w11OAQER9mr
 AjoPx2tUSW7hN2deEi3em8Q581XLMmwF8tqCjBglQEvlCA/4mGmx9Mrck+wWW7kz45gC57plb
 T9/HI3+S5mx5WUqh1ZrVUFqAh3DXT5Bg0MmmrlNP/lsAlo80UpCmhnyKy0RX9q+Yaf2OMwj/t
 /LlzV3FQjpRL5eBtpmH8l6Ms7dlWos/5Dr70HyRUKKND1/RzEaV5wrgnpqzn7HNyW3Rjjmxk9
 D+df13Uy4WlUMOK/8htI1ZR2HYU7Nl2IUbFbQ0EHIEgC4jl9ukhdACUfqjx2eOY0bjH2YrKQL
 ztpZchHiPKWjCIdqAKsMcSwje151lqMWiEGt/rllt9HpdAN1JFk6vgugNl0xsSNORhv4Y6fVl
 MSj9538MdEZqy5d0Hmzq4KCJ/RKrbc3KtwHECH1zKdGifXMfjRotGNlbJjuaVhY+GBjwvRL2i
 18tUrlkt+bj89xHlBW3dkBcHfn145MSXvy16r46UAfWXZ0VExZ/iNfbZ9TZkMIoQWoSKAZDI6
 1Q3jiuUIB0MIMT22s
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C2IasBHStCXOmRsXBCPkJg6ijRW3WYhhF
Content-Type: multipart/mixed; boundary="8AjjROuseeUAMAWg1FnZtydEYDwOP2pDW"

--8AjjROuseeUAMAWg1FnZtydEYDwOP2pDW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/4 =E4=B8=8B=E5=8D=885:45, Thorsten Rehm wrote:
> Thank you for you answer.
> I've just updated my system, did a reboot and it's running with a
> 5.6.0-2-amd64 now.
> So, this is how my kern.log looks like, just right after the start:
>=20

>=20
> There are too many blocks. I just picked three randomly:

Looks like we need more result, especially some result doesn't match at a=
ll.

>=20
> =3D=3D=3D Block 33017856 =3D=3D=3D
> $ btrfs ins dump-tree -b 33017856 /dev/dm-0
> btrfs-progs v5.6
> leaf 33017856 items 51 free space 17 generation 24749502 owner FS_TREE
> leaf 33017856 flags 0x1(WRITTEN) backref revision 1
> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
=2E..
>         item 31 key (4000670 EXTENT_DATA 1933312) itemoff 2299 itemsize=
 53
>                 generation 24749502 type 1 (regular)
>                 extent data disk byte 1126502400 nr 4096
>                 extent data offset 0 nr 8192 ram 8192
>                 extent compression 2 (lzo)
>         item 32 key (4000670 EXTENT_DATA 1941504) itemoff 2246 itemsize=
 53
>                 generation 24749502 type 1 (regular)
>                 extent data disk byte 0 nr 0
>                 extent data offset 1937408 nr 4096 ram 4194304
>                 extent compression 0 (none)
Not root item at all.
At least for this copy, it looks like kernel got one completely bad
copy, then discarded it and found a good copy.

That's very strange, especially when all the other involved ones seems
random and all at slot 32 is not a coincident.


> =3D=3D=3D Block 44900352  =3D=3D=3D
> btrfs ins dump-tree -b 44900352 /dev/dm-0
> btrfs-progs v5.6
> leaf 44900352 items 19 free space 591 generation 24749527 owner FS_TREE=

> leaf 44900352 flags 0x1(WRITTEN) backref revision 1

This block doesn't even have slot 32... It only have 19 items, thus slot
0 ~ slot 18.
And its owner, FS_TREE shouldn't have ROOT_ITEM.

>=20
>=20
> =3D=3D=3D Block 55352561664 =3D=3D=3D
> $ btrfs ins dump-tree -b 55352561664 /dev/dm-0
> btrfs-progs v5.6
> leaf 55352561664 items 33 free space 1095 generation 24749497 owner ROO=
T_TREE
> leaf 55352561664 flags 0x1(WRITTEN) backref revision 1
> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
=2E..
>         item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsize=
 239
>                 generation 4 root_dirid 256 bytenr 29380608 level 0 ref=
s 1
>                 lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)=

>                 drop key (0 UNKNOWN.0 0) level 0

This looks like the offending tree block.
Slot 32, item size 239, which is ROOT_ITEM, but in valid size.

Since you're here, I guess a btrfs check without --repair on the
unmounted fs would help to identify the real damage.

And again, the fs looks very damaged, it's highly recommended to backup
your data asap.

Thanks,
Qu

> --- snap ---
>=20
>=20
>=20
> On Thu, Jun 4, 2020 at 3:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/6/3 =E4=B8=8B=E5=8D=889:37, Thorsten Rehm wrote:
>>> Hi,
>>>
>>> I've updated my system (Debian testing) [1] several months ago (~
>>> December) and I noticed a lot of corrupt leaf messages flooding my
>>> kern.log [2]. Furthermore my system had some trouble, e.g.
>>> applications were terminated after some uptime, due to the btrfs
>>> filesystem errors. This was with kernel 5.3.
>>> The last time I tried was with Kernel 5.6.0-1-amd64 and the problem p=
ersists.
>>>
>>> I've downgraded my kernel to 4.19.0-8-amd64 from the Debian Stable
>>> release and with this kernel there aren't any corrupt leaf messages
>>> and the problem is gone. IMHO, it must be something coming with kerne=
l
>>> 5.3 (or 5.x).
>>
>> V5.3 introduced a lot of enhanced metadata sanity checks, and they cat=
ch
>> such *obviously* wrong metadata.
>>>
>>> My harddisk is a SSD which is responsible for the root partition. I'v=
e
>>> encrypted my filesystem with LUKS and just right after I entered my
>>> password at the boot, the first corrupt leaf errors appear.
>>>
>>> An error message looks like this:
>>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>
>> Btrfs root items have fixed size. This is already something very bad.
>>
>> Furthermore, the item size is smaller than expected, which means we ca=
n
>> easily get garbage. I'm a little surprised that older kernel can even
>> work without crashing the whole kernel.
>>
>> Some extra info could help us to find out how badly the fs is corrupte=
d.
>> # btrfs ins dump-tree -b 35799040 /dev/dm-0
>>
>>>
>>> "root=3D1", "slot=3D32", "have 239 expect 439" is always the same at =
every
>>> error line. Only the block number changes.
>>
>> And dumps for the other block numbers too.
>>
>>>
>>> Interestingly it's the very same as reported to the ML here [3]. I've=

>>> contacted the reporter, but he didn't have a solution for me, because=

>>> he changed to a different filesystem.
>>>
>>> I've already tried "btrfs scrub" and "btrfs check --readonly /" in
>>> rescue mode, but w/o any errors. I've also checked the S.M.A.R.T.
>>> values of the SSD, which are fine. Furthermore I've tested my RAM, bu=
t
>>> again, w/o any errors.
>>
>> This doesn't look like a bit flip, so not RAM problems.
>>
>> Don't have any better advice until we got the dumps, but I'd recommend=

>> to backup your data since it's still possible.
>>
>> Thanks,
>> Qu
>>
>>>
>>> So, I have no more ideas what I can do. Could you please help me to
>>> investigate this further? Could it be a bug?
>>>
>>> Thank you very much.
>>>
>>> Best regards,
>>> Thorsten
>>>
>>>
>>>
>>> 1:
>>> $ cat /etc/debian_version
>>> bullseye/sid
>>>
>>> $ uname -a
>>> [no problem with this kernel]
>>> Linux foo 4.19.0-8-amd64 #1 SMP Debian 4.19.98-1 (2020-01-26) x86_64 =
GNU/Linux
>>>
>>> $ btrfs --version
>>> btrfs-progs v5.6
>>>
>>> $ sudo btrfs fi show
>>> Label: 'slash'  uuid: 65005d0f-f8ea-4f77-8372-eb8b53198685
>>>         Total devices 1 FS bytes used 7.33GiB
>>>         devid    1 size 115.23GiB used 26.08GiB path /dev/mapper/sda5=
_crypt
>>>
>>> $ btrfs fi df /
>>> Data, single: total=3D22.01GiB, used=3D7.16GiB
>>> System, DUP: total=3D32.00MiB, used=3D4.00KiB
>>> System, single: total=3D4.00MiB, used=3D0.00B
>>> Metadata, DUP: total=3D2.00GiB, used=3D168.19MiB
>>> Metadata, single: total=3D8.00MiB, used=3D0.00B
>>> GlobalReserve, single: total=3D25.42MiB, used=3D0.00B
>>>
>>>
>>> 2:
>>> [several messages per second]
>>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>> May  7 14:39:35 foo kernel: [  100.998530] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D35885056 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>> May  7 14:39:35 foo kernel: [  101.348650] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D35926016 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>> May  7 14:39:36 foo kernel: [  101.619437] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D35995648 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>> May  7 14:39:36 foo kernel: [  101.874069] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D36184064 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>> May  7 14:39:36 foo kernel: [  102.339087] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D36319232 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>> May  7 14:39:37 foo kernel: [  102.629429] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D36380672 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>> May  7 14:39:37 foo kernel: [  102.839669] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D36487168 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>> May  7 14:39:37 foo kernel: [  103.109183] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D36597760 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>> May  7 14:39:37 foo kernel: [  103.299101] BTRFS critical (device
>>> dm-0): corrupt leaf: root=3D1 block=3D36626432 slot=3D32, invalid roo=
t item
>>> size, have 239 expect 439
>>>
>>> 3:
>>> https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-5f6c64960=
35c@web.de/
>>>
>>


--8AjjROuseeUAMAWg1FnZtydEYDwOP2pDW--

--C2IasBHStCXOmRsXBCPkJg6ijRW3WYhhF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7Yxi0ACgkQwj2R86El
/qimcwgAl5NCoJKkga6cQMGQ7aoTSa/3+fF1zHP1wPFhOZEvbNH2a+WLqhlQ60Sr
9YHh40Zm5rbSrWEfqXV9ulrk+rDRhGfD86aYUmfsEUvki5YBTfN1vDwVDD8BQBq8
cc4moe1KN6tZkzDZpF2ncuiIWUDae9XIIXQTPMeF8VlTLhZHCO03ZHO9AGthsuDU
6J+446aPKDvyLSoHsTlNEkDSojo/Yx4y14vjOIagi2xlKe9GOGh/bKmLr2QgRsPG
l5mMlYrhq0QGRW3JCaj6nZY4YULTVKFY0WjEGxMRPfxEyhNxWLd1BANjEN54tZ7Y
ciNyJAnYQyT/SASIxSt9DmrJKH4zcA==
=zPwk
-----END PGP SIGNATURE-----

--C2IasBHStCXOmRsXBCPkJg6ijRW3WYhhF--
