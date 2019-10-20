Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E686BDDBC5
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 02:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfJTAvX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Oct 2019 20:51:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:49685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfJTAvW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Oct 2019 20:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571532673;
        bh=eCZkzPWICF7KkQ9MUtpVTU+clpO5UW6XA0LRl6yCzDQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Qe/IJKY649c/HC/zkCqrtqVY3bJ6DdhqpWpmTWd+YigdMk+0pxArdH+F8nfiU1e4x
         T3uoD3vnjwCxbwEK0AzYMFP+OUjQHSTlgXj5JT2EJSOOltiNPb9J54Naknunyk278c
         iuXrX8rjLO3+EcDS4plbnnQ7By/mQVH+OhSmkywg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mj8mV-1hrtHp36u5-00fFBx; Sun, 20
 Oct 2019 02:51:13 +0200
Subject: Re: [PATCH 0/3] btrfs-progs: Add check and repair for invalid inode
 generation
To:     Ferry Toth <fntoth@gmail.com>, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190924081120.6283-1-wqu@suse.com>
 <36d45e31-f125-4b21-a68e-428f807180f7@gmail.com>
 <b1c32c4b-734f-0f4e-44d1-cb4ef69b7fe1@suse.com>
 <796be1b6-1f1d-7946-e53e-9b85610c7c65@gmail.com>
 <c56c880f-22c9-4200-87e5-81e61a1ada0b@gmx.com>
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
Message-ID: <5315fc1e-f0e6-68ca-8938-33bc0dbce07d@gmx.com>
Date:   Sun, 20 Oct 2019 08:51:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c56c880f-22c9-4200-87e5-81e61a1ada0b@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Py2dseqE0l6KILTcnstBvom0q19s86oTb"
X-Provags-ID: V03:K1:HzbjfX8QfKx11rbg40P9ygKSl5LZIJQgIbwVee3c0D8i0RSQbjr
 Spkt7tIy7uRj+rn/EWAkjrTxlAygTfTzYnezUKYOzdVd4R0V8RZLVzJPKJCADiuw/fVBKRR
 F//6P2k0NQQBS2szr/V0wV63rvcVgFo6X3uSV5Vt1sx8dA1oqQcUKP19xNNFPunDswLgNMl
 nUeFxfzsXHgyGaueSbboA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z4yMtjuhFDY=:+Ggqmy9TNykBvXwS8CK26P
 +0hKsHxAt2/ERdhWIWq61Pih9I2pDbRRUiIbD45DD7bcyxIEPW6ei6cJSYV96ar/9cGCdDva+
 hZAR8BmI5fgD0rdDDZjZTtc0W3NSUKGrUhF62qQsUfm8VHTNrUvpB9F07VieVhfwEJ3V19+8T
 AEvs/+wxocDDN04hWA9zT1hzlchmdgvVMcagjIvN9BMJks4pskIbEW9bCwwoeMVto4WxwJfM9
 XWitlx/C3wOEv8n2u0Zsno+LtICdw8W99K6V1aCN0F5LyU/9iYhDc0e0M+ajj1d5fSSDb+4Lp
 EK0aEK4HCG9D4KNMJCxgoeSsGW0z0EHv7zlTG+YtACuH2wfCiFck7HbCLbSKue/szA99UWDuc
 FEQQNhVchT/YK6mjdBL1/2LjkLZDfUn0BLgS9N/EYYY7WeX16zxYp3bEsxLfHJXmISmCotAEP
 C5UWh1K/7yDF86UszjN2NGioPKGzFL1dFW51uLKfpHsWk5ujHOZZLNTngqKCjN88p+tiYLCcL
 HdXHMHEdKUROrREe9h1ebOz9K4THDsae8vSvnnAFETj5BHXZ84yDNOU2WrvrUiMq+/PH3GFdU
 P2EPlFxLpiw0reLQRkfpgscXFJKZWOybAv5PTFOQSB3IM+Lvh4fyMjtpKta2Xz+hM8SgJumQx
 2RdDng0gg/NM0rHnKkVWfIkuRSkHFRpknYToiPdLeg6gR30Y4pDIHcUbNEKwp7zxMMw5ttwan
 5tb6wweNZXKROB20lGGauv/psyGNerdmT0yoBMP4SmIxEi1UNMeYKo651LSg0nthHsnwdX7sj
 5zlvJPq3C/NT2DYw3dJz55jCGqSIh814X/6Wl6/R53b9xvlSu8oQepQInHmsjJf2tjYhBJc22
 ojn5T5GLUk/n8T3vEaEopScjo5ZC1UxIHDXIu6m60Qt0YlXQ9wykKnW6+LUg0kNQrcXvuIaAi
 2pd2gEo2e5/pC9xQP9txmpdBkgZQQHwWHf8C4H51Md56yAVDMjL3Z1v2SL0s64x1cjQL0qFcX
 JyNHIP5hG7sTjIjFFDWRbnZ8ufhTyOCT8zfx42q/QPQvZ3Z5iIhGxbl50tAoGyHQEq2RkGrPu
 nNn47IkchE9bm74g9kZ1mk5ozq+Nu0B0ebbC98UrjGEiD7xgsHJhYz9qcMkyrsAQqiqdM6BPS
 K6Qv7qNXqjSPiQ/GgvAQTxhhWqqk5TT/SvJohny7B7gAE4MnEfwEN7DWZHAUlAsRpQzlSZ2IY
 JAjFTGcg9u9h8AdwhZI+lG9zh1eztdlQzUHBYxH694gCAwV7esqpVxZw+CXo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Py2dseqE0l6KILTcnstBvom0q19s86oTb
Content-Type: multipart/mixed; boundary="8wwQ7uQuxzPHLT0Ub8SWLetcAxGw4Sa9D"

--8wwQ7uQuxzPHLT0Ub8SWLetcAxGw4Sa9D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/20 =E4=B8=8A=E5=8D=888:26, Qu Wenruo wrote:
>=20
>=20
> On 2019/10/20 =E4=B8=8A=E5=8D=8812:24, Ferry Toth wrote:
>> Hi,
>>
>> Op 19-10-2019 om 01:50 schreef Qu WenRuo:
>>>
>>>
>>> On 2019/10/19 =E4=B8=8A=E5=8D=884:32, Ferry Toth wrote:
>>>> Op 24-09-2019 om 10:11 schreef Qu Wenruo:
>>>>> We have at least two user reports about bad inode generation makes
>>>>> kernel reject the fs.
>>>>
>>>> May I add my report? I just upgraded Ubuntu from 19.04 -> 19.10 so
>>>> kernel went from 5.0 -> 5.3 (but I was using 4.15 too).
>>>>
>>>> Booting 5.3 leaves me in initramfs as I have /boot on @boot and / on=
 /@
>>>>
>>>> In initramfs I can try to mount but get something like
>>>> btrfs critical corrupt leaf invalid inode generation open_ctree fail=
ed
>>>>
>>>> Booting old kernel works just as before, no errors.
>>>>
>>>>> According to the creation time, the inode is created by some 2014
>>>>> kernel.
>>>>
>>>> How do I get the creation time?
>>>
>>> # btrfs ins dump-tree -b <the bytenr reported by kernel> <your device=
>
>>
>> I just went back to the office to reboot to 5.3 and check the creation=

>> times and found they were 2013 - 2014.
>>
>>>>
>>>>> And the generation member of INODE_ITEM is not updated (unlike the
>>>>> transid member) so the error persists until latest tree-checker
>>>>> detects.
>>>>>
>>>>> Even the situation can be fixed by reverting back to older kernel a=
nd
>>>>> copying the offending dir/file to another inode and delete the
>>>>> offending
>>>>> one, it still should be done by btrfs-progs.
>>>>>
>>>> How to find the offending dir/file from the command line manually?
>>>
>>> # find <mount point> -inum <inode number>
>>
>> This works, thanks.
>>
>> But appears unpractical. After fix 2 files and reboot, I found 4 more,=

>> then 16, then I gave up.

Another solution is use "find" to locate the files with creation time
before 2015, and copy them to a new file, then replace the old file with
the new file.

It would be much safer than btrfs check --repair.

Thanks,
Qu


>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>>> This patchset adds such check and repair ability to btrfs-check, wi=
th a
>>>>> simple test image.
>>>>>
>>>>> Qu Wenruo (3):
>>>>> =C2=A0=C2=A0=C2=A0 btrfs-progs: check/lowmem: Add check and repair =
for invalid inode
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation
>>>>> =C2=A0=C2=A0=C2=A0 btrfs-progs: check/original: Add check and repai=
r for invalid inode
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation
>>>>> =C2=A0=C2=A0=C2=A0 btrfs-progs: fsck-tests: Add test image for inva=
lid inode
>>>>> generation
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repair
>>>>>
>>>>> =C2=A0=C2=A0 check/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 50 +++++++++++-
>>>>> =C2=A0=C2=A0 check/mode-lowmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 76
>>>>> ++++++++++++++++++
>>>>> =C2=A0=C2=A0 check/mode-original.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>>> =C2=A0=C2=A0 .../.lowmem_repairable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
>>>>> =C2=A0=C2=A0 .../bad_inode_geneartion.img.xz=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Bin 0 -> 2=
012 bytes
>>>>> =C2=A0=C2=A0 5 files changed, 126 insertions(+), 1 deletion(-)
>>>>> =C2=A0=C2=A0 create mode 100644
>>>>> tests/fsck-tests/043-bad-inode-generation/.lowmem_repairable
>>>>> =C2=A0=C2=A0 create mode 100644
>>>>> tests/fsck-tests/043-bad-inode-generation/bad_inode_geneartion.img.=
xz
>>>>>
>>>>
>>
>> I checked out and built v5.3-rc1 of btrfs-progs. Then ran it on my
>> mounted rootfs with linux 5.0 and captured the log (~1800 lines 209
>> errors).
>=20
> It's really not recommended to run btrfs check, especially repair on th=
e
> mounted fs, unless it's RO.
>=20
> A new transaction from kernel can easily screw up the repaired fs.
>>
>> I'm not sure if using the v5.0 kernel and/or checking mounted distorts=

>> the results? Else I'm going to need a live usb with a v5.3 kernel and
>> v5.3 btrfs-progs.
>>
>> If you like I can share the log. Let me know.
>>
>> This issue can potentially cause a lot of grief. Our company server ru=
ns
>> Ubuntu LTS (18.04.02) with a 4.15 kernel on a btrfs boot/rootfs with
>> ~100 snapshots. I guess the problematic inodes need to be fixed on eac=
h
>> snapshot prior to upgrading to 20.04 LTS (which might be on kernel ~5.=
6)?
>=20
> Yes.
>=20
>>
>> Do I understand correctly that this FTB is caused by more strict
>> checking of the fs by the kernel, while the tools to fix the detected
>> corruptions are not yet released?
>=20
> Yes.
>=20
> Thanks,
> Qu
>=20


--8wwQ7uQuxzPHLT0Ub8SWLetcAxGw4Sa9D--

--Py2dseqE0l6KILTcnstBvom0q19s86oTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2rr3kACgkQwj2R86El
/qgJEAf/cFpe3rjaWlpAJptbYKm9v9LpjHxtK8nGg6ntHMAQYE+TBtodO1D8k05f
CMLy64NDhP+ATBuffHfSYwWw9inOw/p5R7JOYIe8lECV7iW4Db74X3pzr1990ZZ+
dsQqipbvnAuIFHIVgtpA9l+PzHlASeq+l9IVbCyO7rE6nzX8etKrIxBOCGCs6zwm
393vfqUt3KKyDDeccq+jDBPrk+XVwNm3dBi95VotHhVVp7LD1zjxY0V6Dygob7ap
qwKqpA7ijKIxIYTKjzj3X/Dsmxon3epWDRUyhTOvbgEGFIgt5wtlJBNTbHdyKOgh
ucPZ48DTX4K5WB6v+9GxBIIDwf+cmg==
=JRmS
-----END PGP SIGNATURE-----

--Py2dseqE0l6KILTcnstBvom0q19s86oTb--
