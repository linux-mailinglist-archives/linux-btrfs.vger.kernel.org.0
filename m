Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BEFDDECD
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 16:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfJTOMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Oct 2019 10:12:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:56621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfJTOMG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Oct 2019 10:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571580720;
        bh=LnjKKKS+9gMsTj9OajxM8MhMbwCQf+QPtY/c4KhO2bc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Q9F3FFeAZDZ0Jpo4uP1B6h+IkiLBGWZZbkAmfP8NKFKTPftXDzKJrNUBJUPPQzCGu
         V41smk37oxRHV5hKUGvxA9lU9VRtE0caRNiZsIRtjDz8yRnzpLEVx8cf1fS3SvlVh4
         6Ze3uWyibn7S6Tu0+13qiohheywgwQCCd7YxiQ1M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mulm5-1i5U441RI3-00rnoc; Sun, 20
 Oct 2019 16:12:00 +0200
Subject: Re: [PATCH 0/3] btrfs-progs: Add check and repair for invalid inode
 generation
To:     Ferry Toth <fntoth@gmail.com>, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190924081120.6283-1-wqu@suse.com>
 <36d45e31-f125-4b21-a68e-428f807180f7@gmail.com>
 <b1c32c4b-734f-0f4e-44d1-cb4ef69b7fe1@suse.com>
 <796be1b6-1f1d-7946-e53e-9b85610c7c65@gmail.com>
 <c56c880f-22c9-4200-87e5-81e61a1ada0b@gmx.com>
 <5315fc1e-f0e6-68ca-8938-33bc0dbce07d@gmx.com>
 <df807dde-ecdf-9bc9-cb7d-1bf1cc9c27c1@gmail.com>
 <a14ac7f0-e85c-3172-8570-3755320ea235@suse.com>
 <218ddabb-d419-31cd-f092-59f8ffb1a5b4@gmail.com>
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
Message-ID: <6ec4c90c-d276-c03d-9315-f808f21b3769@gmx.com>
Date:   Sun, 20 Oct 2019 22:11:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <218ddabb-d419-31cd-f092-59f8ffb1a5b4@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="55w02pmPTjoFvpXTqhz4HCy7JFXXDcpeS"
X-Provags-ID: V03:K1:DsxZmnaMdhbTHGMfwXoIyURZgFuSK7DbyIftz7gSWC7RvFT6JW0
 C5dL4lEzYcecgaKGyaG6YKrELcNN2RbxFLrKkeL/OzzGMGKsVxsEtweVtBT0gESpIWSvnjR
 utPuwZcER0N2PS5MXKGCPek74xXNBVltfe6AOnz7evS+71I8T3Ou96DIZsI4Xm7ThWipgmy
 ihvaSo3cnFGSEEVDQBIwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NfUiaUsRbaA=:Jh8CJu1c2pDgpTB9zJ4zZa
 Zq6I1C7Zhx7cmZfx/Ivi+ub9kp9zzUPEF1MEhJg9uENuWHDih15uaShit2l20SxAZASFMSK6O
 jH+rQxuglw1IZ/D6afeVYnL9kjK35A/RP6vJpO/lny1bfh6PjqZrh9pd53XroDIuVi+aQgCEx
 vMO7MpYyXoqwP/WJgQtCQF6BtnYetw3s+nAD1gl6Q5R5Pt+wo+vT1F8pFLtj1GlK2gyGRQoGC
 jxZ4kRBlSSkDvx5OrEo8grquUDU1W9kS4Ft3tgVRFOQvsF6MLJNLBUr3pSSiSGF4TN8g4ob/G
 uU5tQ9IRCxodlcz1VXyazZOWTduruh7fSaY14mG8r7ppJXTd8jBHP40tWQVTEqETBLMlWd8l7
 AOAvEHioGAGzxpzPIaBwKtYwAErsZyYLpwGkjJUU5oV5+mhpxa9yNi+SwRcYwzFgHbNswCu45
 Rtxtn2XkLKKcNzo9JU0gAd8xCCjJpMfynU+tH5iGFbKcf2CnKhFDGz4VS9JoGz2Q+qxd6TeVH
 c6AdHkA4YNnR1gwACOAV5zeZjwcxlzd7cRmOLOFyEBM2aS/Qf1eQNAGdBnnCnZ1nKfoxo+Pxp
 /3axB0sq5JD191dHMb1NlKeTDXYchYbIIbPvcfSI5Cu9dGAoRow/GgGrmo+Z/MnAgZQkW2ZC7
 k9qgyECsvXq/0NHYl/vbOBpzcwD7/xYAk5jgQfGoSor6YKWwBbmVDgW+Lg0qyf9yeHWtJPsVt
 X15uxrq63BR5Pqsg7W1t/5ttudRrNYfMjmLU0ftocuo7B1XYduIWtUnEmVWqZbZD1te1eSzRp
 7TuoF3x7MlnsSwmOEg0XTfGtucKJw5q9Mj/h5cCBsnxUM3hQNgrJF8Kck8igAA+AeTiTzEq52
 bPUvk3HcdN+RDi0iteC3QsSAP/YH7FiVEtbA4qmTg+I/FvFnArEdnMxMRAcaXk6Bh23zSSlL0
 TJSK9Ey8wVqCV3pg0n8S0PPOMP+O/WKQcvY/WhB7P9IhFKM27fT+o2Zyn0wNeQZupoMwTET0P
 EUJMXT9852IAbifK6Kp9oBbW9Usl6P/Xh+s6h4N5O1tHcBcBE4ZM8Q1lwNJNM6xthHCF2XxK9
 2oYKeC1o3DT0ikkfa315G7Wogh3qr2fdMv4cKaRJo9IiV2BXOuZpxDhcZTyu/0IoNFa911x30
 hm11hnOk1lHJyW/5Nw8HQ6Upa2Tl2fHB/cvqm01R3AQUUPUj/dGiuoJdUO7RcuQbjaZyXXPyQ
 Sqcy4S9l6ZS/2U/1hhBs5L+AOK+Hf3Dmrgk3YCnafhWNJnvG+lf/l0sjRXUE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--55w02pmPTjoFvpXTqhz4HCy7JFXXDcpeS
Content-Type: multipart/mixed; boundary="BioU0wI4msWMqXPgoWVdOUMZ0PrlA2DR9"

--BioU0wI4msWMqXPgoWVdOUMZ0PrlA2DR9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/20 =E4=B8=8B=E5=8D=889:29, Ferry Toth wrote:
> Op 20-10-2019 om 15:15 schreef Qu WenRuo:
>>
>>
>> On 2019/10/20 =E4=B8=8B=E5=8D=889:04, Ferry Toth wrote:
>>> Op 20-10-2019 om 02:51 schreef Qu Wenruo:
>>>>
>>>>
>>>> On 2019/10/20 =E4=B8=8A=E5=8D=888:26, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2019/10/20 =E4=B8=8A=E5=8D=8812:24, Ferry Toth wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Op 19-10-2019 om 01:50 schreef Qu WenRuo:
>>>>>>>
>>>>>>>
>>>>>>> On 2019/10/19 =E4=B8=8A=E5=8D=884:32, Ferry Toth wrote:
>>>>>>>> Op 24-09-2019 om 10:11 schreef Qu Wenruo:
>>>>>>>>> We have at least two user reports about bad inode generation ma=
kes
>>>>>>>>> kernel reject the fs.
>>>>>>>>
>>>>>>>> May I add my report? I just upgraded Ubuntu from 19.04 -> 19.10 =
so
>>>>>>>> kernel went from 5.0 -> 5.3 (but I was using 4.15 too).
>>>>>>>>
>>>>>>>> Booting 5.3 leaves me in initramfs as I have /boot on @boot and =
/
>>>>>>>> on /@
>>>>>>>>
>>>>>>>> In initramfs I can try to mount but get something like
>>>>>>>> btrfs critical corrupt leaf invalid inode generation open_ctree
>>>>>>>> failed
>>>>>>>>
>>>>>>>> Booting old kernel works just as before, no errors.
>>>>>>>>
>>>>>>>>> According to the creation time, the inode is created by some 20=
14
>>>>>>>>> kernel.
>>>>>>>>
>>>>>>>> How do I get the creation time?
>>>>>>>
>>>>>>> # btrfs ins dump-tree -b <the bytenr reported by kernel> <your
>>>>>>> device>
>>>>>>
>>>>>> I just went back to the office to reboot to 5.3 and check the
>>>>>> creation
>>>>>> times and found they were 2013 - 2014.
>>>>>>
>>>>>>>>
>>>>>>>>> And the generation member of INODE_ITEM is not updated (unlike =
the
>>>>>>>>> transid member) so the error persists until latest tree-checker=

>>>>>>>>> detects.
>>>>>>>>>
>>>>>>>>> Even the situation can be fixed by reverting back to older kern=
el
>>>>>>>>> and
>>>>>>>>> copying the offending dir/file to another inode and delete the
>>>>>>>>> offending
>>>>>>>>> one, it still should be done by btrfs-progs.
>>>>>>>>>
>>>>>>>> How to find the offending dir/file from the command line manuall=
y?
>>>>>>>
>>>>>>> # find <mount point> -inum <inode number>
>>>>>>
>>>>>> This works, thanks.
>>>>>>
>>>>>> But appears unpractical. After fix 2 files and reboot, I found 4
>>>>>> more,
>>>>>> then 16, then I gave up.
>>>>
>>>> Another solution is use "find" to locate the files with creation tim=
e
>>>> before 2015, and copy them to a new file, then replace the old file
>>>> with
>>>> the new file.
>>>
>>> Hmm. But how do I "find" by creation time (otime)? Do you have a
>>> suggestion for this?
>>
>> $ touch -t 201501010000 /tmp/sample
>> $ find <mnt> -not -cnewer /tmp/sample
>=20
> AFAIK this compares file modified date with status changed date. So, no=

> search for creation date.
>=20
> And stat /tmp/sample (sorry dutch lang output):
>=20
> ferry@ferry-quad:~$ stat /tmp/sample
> =C2=A0 Bestand: /tmp/sample
> =C2=A0 Grootte: 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Blokken: 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 IO-blok: 4096=C2=A0=C2=A0 leeg
> normaal bestand
> Apparaat: 1bh/27d=C2=A0=C2=A0 Inode: 62005381=C2=A0=C2=A0=C2=A0=C2=A0 K=
oppelingen: 1
> Toegang: (0664/-rw-rw-r--)=C2=A0=C2=A0 UID: ( 1001/=C2=A0=C2=A0 ferry)=C2=
=A0=C2=A0 GID: ( 1001/=C2=A0=C2=A0 ferry)
> Toegang:=C2=A0=C2=A0 2015-01-01 00:00:00.000000000 +0100
> Gewijzigd: 2015-01-01 00:00:00.000000000 +0100
> Veranderd: 2019-10-20 15:20:50.366163766 +0200
> Ontstaan:=C2=A0 -

My bad, always got confused by o/a/c/mtime, as c really looks like *c*
reation, so I always got confused between ctime and otime.

Then considering not all fs supports otime, find doesn't support that.
I guess it's only possible by other tools....

BTW, did you find any patterns in those existing offending inodes?
I guess it would be faster than finding a tool supporting otime search.

Thanks,
Qu

>=20
>=20
>> If you want, you can add -exec to that find, but I'd only add that aft=
er
>> confirming the execution load is verified.
>>
>> Thanks,
>> Qu
>>
>>>
>>>> It would be much safer than btrfs check --repair.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>>
>>>>>>>>> This patchset adds such check and repair ability to btrfs-check=
,
>>>>>>>>> with a
>>>>>>>>> simple test image.
>>>>>>>>>
>>>>>>>>> Qu Wenruo (3):
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: check/lowmem: Add c=
heck and repair for invalid
>>>>>>>>> inode
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: check/original: Add=
 check and repair for
>>>>>>>>> invalid inode
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: fsck-tests: Add tes=
t image for invalid inode
>>>>>>>>> generation
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repair
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 check/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 50
>>>>>>>>> +++++++++++-
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 check/mode-lowmem.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 76
>>>>>>>>> ++++++++++++++++++
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 check/mode-original.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 .../.lowmem_repairable=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 .../bad_inode_geneartion.img.xz=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | Bin 0 -> 2012
>>>>>>>>> bytes
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 5 files changed, 126 insertions(+), 1 =
deletion(-)
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 create mode 100644
>>>>>>>>> tests/fsck-tests/043-bad-inode-generation/.lowmem_repairable
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 create mode 100644
>>>>>>>>> tests/fsck-tests/043-bad-inode-generation/bad_inode_geneartion.=
img.xz
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>> I checked out and built v5.3-rc1 of btrfs-progs. Then ran it on my=

>>>>>> mounted rootfs with linux 5.0 and captured the log (~1800 lines 20=
9
>>>>>> errors).
>>>>>
>>>>> It's really not recommended to run btrfs check, especially repair
>>>>> on the
>>>>> mounted fs, unless it's RO.
>>>>>
>>>>> A new transaction from kernel can easily screw up the repaired fs.
>>>>>>
>>>>>> I'm not sure if using the v5.0 kernel and/or checking mounted
>>>>>> distorts
>>>>>> the results? Else I'm going to need a live usb with a v5.3 kernel =
and
>>>>>> v5.3 btrfs-progs.
>>>>>>
>>>>>> If you like I can share the log. Let me know.
>>>>>>
>>>>>> This issue can potentially cause a lot of grief. Our company serve=
r
>>>>>> runs
>>>>>> Ubuntu LTS (18.04.02) with a 4.15 kernel on a btrfs boot/rootfs wi=
th
>>>>>> ~100 snapshots. I guess the problematic inodes need to be fixed on=

>>>>>> each
>>>>>> snapshot prior to upgrading to 20.04 LTS (which might be on kernel=

>>>>>> ~5.6)?
>>>>>
>>>>> Yes.
>>>>>
>>>>>>
>>>>>> Do I understand correctly that this FTB is caused by more strict
>>>>>> checking of the fs by the kernel, while the tools to fix the detec=
ted
>>>>>> corruptions are not yet released?
>>>>>
>>>>> Yes.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>
>>>
>=20


--BioU0wI4msWMqXPgoWVdOUMZ0PrlA2DR9--

--55w02pmPTjoFvpXTqhz4HCy7JFXXDcpeS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2sayoACgkQwj2R86El
/qjEAwgAl+4k3VKyca6YkcSBh5YE0Nq4uPb8I+IzCsGUyiju6yRQmOZJgV/rSdbE
kD+X93thWHWP41q7KDr7HcXWJ9NnS2AF5yLFG3Yoc0b+lxsizvPtQmjjVabOpDgY
F9ZXGlrMDx4BV1exXcIad618mXr17W+YH9q8yQbITwAKzOzbCBcUaDK+06BnrKiR
n23/WMPbYAYwJLeunz+Q2AknXyE4teT+Xa3VxmVerkVUk/voCNUzz3lWyg6xafZl
ub2PZduuhpnOyTKGNwr2GRbviHlRgOMlvN3btkTirZr8xsKqRtjzZI+lwWa+bnFu
cb4bkXGfXgLXpagDeb9PlZ3jnail5g==
=q2ny
-----END PGP SIGNATURE-----

--55w02pmPTjoFvpXTqhz4HCy7JFXXDcpeS--
