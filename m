Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D0A245529
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Aug 2020 03:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHPBVu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Aug 2020 21:21:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:36115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgHPBVt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Aug 2020 21:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597540904;
        bh=cLGKaJehyp+c/CDNTd61EETf0u80CuakWy+P3B3/uXA=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=ALjBy6DzBF91BKRTg1yHeV6ttoMUHwyMMadddbwc/3HCJR7F95brgoAlQderToqOy
         3FulwP0GO0lPnlhbsG4980f4IGD8qydBM6nBvOtgM1FGD7uGzX2ftesBwaqQ5nhCBw
         +NHNfUT+5igzDKe9rSSETviSIwKoIfjCYD3ECD1s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQXN-1kwCgG27mP-00sJIs; Sat, 15
 Aug 2020 09:54:02 +0200
Subject: Re: AW: Tree-checker Issue / Corrupt FS after upgrade ?
To:     benjamin.haendel@gmx.net
References: <000301d672d7$263c00d0$72b40270$@gmx.net>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
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
Message-ID: <5ac90d92-c706-ad18-3a1e-3c62c966e97b@gmx.com>
Date:   Sat, 15 Aug 2020 15:53:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <000301d672d7$263c00d0$72b40270$@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hHcU0MT2xhyGb7SN7OzBBAk34ycB4Ffue"
X-Provags-ID: V03:K1:Ag/wd70njfx0MfnmNQbyM1RFO6P8vdk6HnZ0emRksixK2umwEk/
 XHRbqezxazNY7CjWNpqHcGIiB9z/ecLNm7HvLQ9EwRMr+39hQGeJWfTc54hgGC9TKpwjTLr
 JCWCuItX6Xr/xDTeN/z4F4QQBl1WCxbFiJIlEkeCA3JwN1OlNQAUaHIe02cJMU6xsMQpWHK
 po2D8NXB2qEbSwMY+y/ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X4JuS0mdZWw=:7UVn/7zWygYHfeXFPyh3Dx
 S5HbnyLvMZbbet9otPMLUgfLsD6BUkYudKXoMnUfZeOS3RlMTsPJGnZk8DavSCnyntEXUwFGw
 GHy+nLrhtI4+aj2kDTbEGyprj6a+Wq6Ff31LN0HMVah+2Rpl7DM6FURbRUhj8t3Dc2us7xbMf
 5m0jVemLl8qrLR6PaRWHZzdbkfTyjS7q/iMPKKgXjvV+qpDtXN6nn6VC7viYv490GmEAXIYk6
 DGU0IAVe1iVTKG3BEvwtp07t+qWZXXT6tBRa8EI3kgWcb8sVWOuDdgMX29OGJApht3bljjX1o
 yY711/nRsTUemE2bJSYSj6U1e6konyKuBEG3VY3Jl8W2LoOEOf5vDbkxiMOlFkvd3Wfr2/8y5
 eYDOModIxPyMZ6P7YigjGXhUXQuI2JLOJSjBDQWAaIsxssBvBakTL5HfIUXEDttVBIY8ScSFS
 94t1NqwXO1V0A0I3ZK+SXIZrGMIsnYwMW8d5qPhihc+LaCgAm4FcvCBlbVqY9M4CPTj/bKsdB
 1vK33Pv13gY1OzGCT/KT5jzNgst+FpLMWmquXdbPjFTPR9X02Bd9L26qVlvNAUb+vLmZYtQz+
 o6gBjkDCK71zYjJblc+oLgO6urOj0oql8B3P7DR3Hr4fwmz4Mjptj68bduF/+15RvNdpAy2So
 cWYoinMssKs85gblC8Uo3c/WZpGwkNKBc9V6cHF900kExSV0PFvMAJfdx4FkjPWl5ig+a3L6I
 +aXj/uPXlqruS4LZ0AsY2GrM+tngLlVXdgHBX/tllYr/DZgWPGxhrA5jJHtGgufoMQNCh7qt8
 ObGljDMN4PG3GLxFKBXpg8YBzDlNd7bUpEy5zwFT+Ql/SQXVp+kyxrjJYJG5fF0WwWEspkPnW
 8VNa+WqYHbnq4cFvJGhPTxVpLsSDRz/T12DSQfJ17TMKoHDyu78DkgBV0zaVIsJ+IRTPlWCzK
 p5A808ihP9lEtnKDkOgWmKqHPfa0/1OY3yXvvquL7uFO6w46KFS2ZYWvH24AZBp26e41q1gAg
 StVISXrCoi6AfOBGwEvDTj2Od7xlT/1Os7SAP6j5IdIREjDlqaBkba/I6Ty6CyU62nAQiJx94
 xVgwYXYst5IQjW+STIuUg6tKmHM7FN4NWvEGL/WuY37CbDlZCCEFz2ICJNgieGGCr0rwZIhp1
 VtuSo0it7VgCwWVP6QCjwdJjxq4tv7Mce0PKhdrotv3gd4oGzKIzORGwPkBfdYA6keYlqjiv/
 GZGnRDRPv5U5LGyAvj3wSNtjftlaQj1uH+YU4xQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hHcU0MT2xhyGb7SN7OzBBAk34ycB4Ffue
Content-Type: multipart/mixed; boundary="zkNi9oheGk93rKH3k705Kvuj1v1vYqY2W"

--zkNi9oheGk93rKH3k705Kvuj1v1vYqY2W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/15 =E4=B8=8B=E5=8D=883:39, benjamin.haendel@gmx.net wrote:
> Hi Qu,
>=20
> i did not know how to log this.
>=20
> I have copy pasted what i could from the shell attached as a txt file f=
rom the latest check.

The fs is kinda OK.

It has some bad extent flags, but that shouldn't affect the fs read and
write.
>=20
> Its not windows related, i meant that when i access the mapped/mounted =
share via my clients (Windows)
> Its showing still the old numbers although a few TB of data are missing=
=2E

That's not missing, just btrfs extent booking.
It's pretty common in btrfs, as btrfs do COW for its data extents.

Thanks,
Qu

>=20
> Best Regards,
> Ben
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
> Gesendet: Samstag, 15. August 2020 01:06
> An: benjamin.haendel@gmx.net
> Cc: linux-btrfs@vger.kernel.org
> Betreff: Re: AW: AW: AW: Tree-checker Issue / Corrupt FS after upgrade =
?
>=20
>=20
>=20
> On 2020/8/15 =E4=B8=8A=E5=8D=883:05, benjamin.haendel@gmx.net wrote:
>> Hi Qu,
>>
>> i did all that and i have now again access to the Storage.
>=20
> Btrfs check --repair log of that run please.
> I guess you haven't keep it...
>=20
> And "btrfs check" of current fs please.
>=20
>> Sadly i am now encountering some errors and bugs and i thought You=20
>> might want to know about that.
>>
>> 1. I am missing some folders and files 2. Some folders are there but=20
>> no files in them 3. i can only access the drive via the samba share - =

>> not on the server directly 4. In Windows it shows "28TB of usage" but =

>> when i mark all data and hit alt+enter it counts to 21.1 TB only
>=20
> Windows? Why it's related to Windows then?
> We're talking about btrfs, right?
>=20
> For the total usage, it's completely sane as btrfs use extent booking, =
which takes extra space.
>=20
> Thanks,
> Qu
>=20
>=20
>>
>> I am unsure if that data is now lost forever or if ist just a bug or w=
hat exactly is the problem.
>> Do you think i could still "btrfs send" the Data and it will all be ba=
ck or are those files lost due to new enumeration by btrfs-check Repair ?=

>>
>> Best Regards,
>> Ben
>>
>>
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Gesendet: Freitag, 14. August 2020 02:57
>> An: benjamin.haendel@gmx.net
>> Cc: linux-btrfs@vger.kernel.org
>> Betreff: Re: AW: AW: Tree-checker Issue / Corrupt FS after upgrade ?
>>
>>
>>
>> On 2020/8/14 =E4=B8=8A=E5=8D=885:01, benjamin.haendel@gmx.net wrote:
>>> Hi Qu,
>>>
>>> i downloaded the code, compiled and installed it.
>>
>> You still need to run "btrfs check --repair".
>>
>> Considering you haven't post that output, I guess you didn't run that.=

>>
>>> Still could not mount the FS with error:
>>> mount: /media/Storage: wrong fs type, bad option, bad superblock on /=
dev/mapper/Crypto, missing codepage or helper program, or other error.
>>>
>>> Dmesg is telling me:
>>> [  174.061205] Btrfs loaded, crc32c=3Dcrc32c-intel [  174.081002] BTR=
FS:=20
>>> device label Storage devid 1 transid 207602 /dev/dm-0 [  192.175157] =

>>> BTRFS info (device dm-0): disk space caching is enabled [ =20
>>> 204.025699] BTRFS critical (device dm-0): corrupt leaf:=20
>>> block=3D22751711027200
>>> slot=3D1 extent bytenr=3D6754755866624 len=3D4096 invalid generation,=
 have
>>> 22795412619264 expect (0, 207603] [  204.025703] BTRFS error (device
>>> dm-0): block=3D22751711027200 read time tree block corruption detecte=
d=20
>>> [ 204.025731] BTRFS error (device dm-0): failed to read block groups:=
=20
>>> -5 [  204.076709] BTRFS error (device dm-0): open_ctree failed
>>>
>>> I am unsure of what to do now. Did i have to run a btrfs check --repa=
ir with the compiled btrfs branch ?
>>
>> Yes.
>>
>>> I also removed all other versions of btrfs now to see if an old versi=
on could read it, it now says:
>>> root@Userv:~# btrfs --version
>>> btrfs-progs v4.1
>>
>> Nope, you're not using the correct version.
>>
>>>
>>> Still i can not mount the drive. How can i at least get read access t=
o my data ?
>>
>> Just go using your older kernel, and wait for your distro to provide n=
ewer enough btrfs-progs.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Best Regards,
>>> Ben
>>>
>>> -----Urspr=C3=BCngliche Nachricht-----
>>> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> Gesendet: Donnerstag, 13. August 2020 01:30
>>> An: benjamin.haendel@gmx.net; linux-btrfs@vger.kernel.org
>>> Betreff: Re: AW: Tree-checker Issue / Corrupt FS after upgrade ?
>>>
>>>
>>>
>>> On 2020/8/13 =E4=B8=8A=E5=8D=887:10, benjamin.haendel@gmx.net wrote:
>>>> Hi Qu,
>>>>
>>>> thanks for your reply, i am not sure what to do from here on.
>>>> What do i have to download from here or compile/make/install etc. ?
>>>
>>> You need to compile that branch.
>>>
>>> For how to compile, please check the README.md.
>>>
>>>
>>>>
>>>> I'm no total idiot but i still don't understand what i have to get=20
>>>> And how to apply it...sorry :(
>>>
>>> Or you can use btrfs-send to send out the content of your fs with old=
er kernel, and create a new fs using newer kernel, then receive the strea=
m.
>>>
>>> The uninitialized data is only in extent tree, which won't be sent wi=
th the stream, by receiving it with newer kernel, you won't lose anything=
=2E
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Best Regards,
>>>> Ben
>>>>
>>>> -----Urspr=C3=BCngliche Nachricht-----
>>>> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>> Gesendet: Donnerstag, 13. August 2020 00:51
>>>> An: benjamin.haendel@gmx.net; linux-btrfs@vger.kernel.org
>>>> Betreff: Re: Tree-checker Issue / Corrupt FS after upgrade ?
>>>>
>>>>
>>>>
>>>> On 2020/8/13 =E4=B8=8A=E5=8D=8812:58, benjamin.haendel@gmx.net wrote=
:
>>>>> Hi,
>>>>>
>>>>> i have been running my little Storage (32TB) on a Ubuntu 18.04 LTS =

>>>>> Machine with btrfs-progs 4.17. I then did my monthly upgrade (apt
>>>>> dist-upgrade) and after a reboot my Partition could not mount with =
the error message:
>>>>> "root@Userv:/home/benjamin# mount -r ro btrfs /dev/mapper/Crypto=20
>>>>> /media/Storage
>>>>> mount: bad usage"
>>>>>
>>>>> I then proceeded to run a btrfs check which gave thousands of=20
>>>>> errors and then also a super-recover:
>>>>> root@Userv:/home/benjamin# btrfs rescue super-recover -v=20
>>>>> /dev/mapper/Crypto All Devices:
>>>>> Device: id =3D 1, name =3D /dev/mapper/Crypto
>>>>>
>>>>> Before Recovering:
>>>>> [All good supers]:
>>>>> device name =3D /dev/mapper/Crypto
>>>>> superblock bytenr =3D 65536
>>>>>
>>>>> device name =3D /dev/mapper/Crypto
>>>>> superblock bytenr =3D 67108864
>>>>>
>>>>> device name =3D /dev/mapper/Crypto
>>>>> superblock bytenr =3D 274877906944
>>>>>
>>>>> [All bad supers]:
>>>>>
>>>>> All supers are valid, no need to recover
>>>>>
>>>>> I now checked my dmesg log:
>>>>> [45907.451840] BTRFS critical (device dm-0): corrupt leaf:
>>>>> block=3D22751711027200 slot=3D1 extent bytenr=3D6754755866624 len=3D=
4096=20
>>>>> invalid generation, have 22795412619264 expect (0, 207589]
>>>>
>>>> This is caused by older kernel, which writes some uninitialized valu=
e onto disk.
>>>>
>>>> You can try to fix it with this branch:
>>>> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>>>>
>>>> Or you can use older kernel to delete the offending extents.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> [45907.451848] BTRFS error (device dm-0): block=3D22751711027200 re=
ad=20
>>>>> time tree block corruption detected [45907.451892] BTRFS error=20
>>>>> (device
>>>>> dm-0): failed to read block groups: -5 [45907.510712] BTRFS error=20
>>>>> (device dm-0): open_ctree failed
>>>>>
>>>>> Google inquiries to this topic led me to this link:
>>>>> https://btrfs.wiki.kernel.org/index.php/Tree-checker
>>>>> It tells me to mail here first so thats what i am doing. I kind of =

>>>>> suspect since everything worked perfect (Memtest also no errors)=20
>>>>> before the update, it has to do something with that update. I am=20
>>>>> wondering if it would help if i deleted my OS Disk and reinstalled =

>>>>> an older Version of Ubuntu, like
>>>>> 16.04.6 LTS ?
>>>>>
>>>>> Since then i upgraded to 20.04 LTS with BTRFS-PROGS 5.7 as a lot of=
=20
>>>>> forum entries said it would be wise to use the newer versions as ol=
der were buggy.
>>>>> That brought no help as well.
>>>>>
>>>>> Since i am no Linux/Unix Expert i thought it might be better to ask=
=20
>>>>> now first as advised in the link above before proceeding with any o=
ther plans.
>>>>>
>>>>> I find it hard to believe that all data is gone, i feel its buggy=20
>>>>> behavior as the partition and everything is still there:
>>>>> root@Userv:/home/benjamin# btrfs fi show
>>>>> Label: 'Storage'  uuid: 46c7d04a-d6ac-45be-94cc-724919faca2b
>>>>> Total devices 1 FS bytes used 28.23TiB
>>>>> devid    1 size 29.10TiB used 29.04TiB path /dev/mapper/Crypto
>>>>>
>>>>> Best Regards,
>>>>> Benjamin H=C3=A4ndel
>>>>>
>>>>
>>>>
>>>
>>>
>>
>>
>=20


--zkNi9oheGk93rKH3k705Kvuj1v1vYqY2W--

--hHcU0MT2xhyGb7SN7OzBBAk34ycB4Ffue
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl83lJYACgkQwj2R86El
/qgXMQgAlimlzXHS2lsG8jeB5VLtHqQlCs8YhQyxEsxBZ7+OKeeIwJasZg33FkLL
ApK79XiROU5TTbi9l4GWYGrt/zmTdhriKNJ6hO3VQkA6kkKzAXxQldf8fzJqZ+6E
USEI9HrZFyG7BeL+7SE/gJKJNsVHmRwIsUXLzhcX+K0w3Y2NIMeDU0SaI9D9GYco
Y14QhhO1DCDZVMpMLZPXWA1i0GkZEcOQj/3URmFpA6wbDmShQ0dljJ72gIoXgNvK
8dC6iwbdqSWLaZLRAFVwWarsH2JP4BJ19VWSnHLbwoFGaaObCOPHzBFKhzk3fYLl
xSh9VURawRYXlt17smOiM4wgBlQeyA==
=TDT6
-----END PGP SIGNATURE-----

--hHcU0MT2xhyGb7SN7OzBBAk34ycB4Ffue--
