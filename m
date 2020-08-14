Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F324500B
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Aug 2020 01:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgHNXGM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 19:06:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:53019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNXGL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 19:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597446367;
        bh=gms7SvvkNqoAFsYLFVMNIooEfYu7iuiVVSzbNQpu31U=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=jH8oM9EXTp5syeazIKoUuxUDnsGvoXiE14tBokddkem+J8X/bUY5NUoXRuaCIlRvi
         Oxg0UG84yCP/1MkPQfHjpCwNYk7oBhjnRK5J0+ml9CUcEJOOZBMDeau9gx2qwi7VuE
         eWgPh2Vzr8AbZX+a7HiQSqxzJANnFZnx5fpAU1do=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mulm5-1kwtx73R5v-00rl7J; Sat, 15
 Aug 2020 01:06:07 +0200
Subject: Re: AW: AW: AW: Tree-checker Issue / Corrupt FS after upgrade ?
To:     benjamin.haendel@gmx.net
References: <004201d670c9$c69b9230$53d2b690$@gmx.net>
 <facaa4ae-5001-13e7-3ea1-26d514f73848@gmx.com>
 <000801d670fd$bb2f62d0$318e2870$@gmx.net>
 <940c43d7-b7e0-82fa-d5a5-b81e672b85a9@gmx.com>
 <000301d671b4$fc4a0650$f4de12f0$@gmx.net>
 <0839617b-8d4b-c252-1c74-4a3ff941ba6f@gmx.com>
 <003301d6726d$de5cbe30$9b163a90$@gmx.net>
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
Message-ID: <13619e31-627f-92a7-6d11-1f8bbd6d7d6a@gmx.com>
Date:   Sat, 15 Aug 2020 07:06:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <003301d6726d$de5cbe30$9b163a90$@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WUvMvUvJxcDdjNEVIQ2ogaP0Pru4TIPKG"
X-Provags-ID: V03:K1:INFVgI8whBpTQpZJV9lp5gc7nym7db9xtrNiuL3JAHVQd8pU2UL
 EIghVw29/X0Ou47E5161J+d/LC2CtgIyrb5jt1i86CCV23uDLIJzZRWOSggnMcBbYN50Pyy
 PEadp4jyLed/61YoUxPEYyGBIgvy28oJDwe0H0j52CfuhKBGcl1E2TjgY6x9oHUzvVYG/iR
 9AIlqBnluQeo62Z2UL4oA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kOWDPrYg7Dw=:vUY432kssXo2ptGuIb4dbb
 QAu/jKZNEdp5yEHzpL9vwF5LA1yY/fZtNFJmfndzrmXYetWQ5y/s+I5iLWXfqHPRuC5Fvx5NO
 7xjB8Frhx9pQBM38Nh+84CCPL1HBN2JPpQkAO89hIDsI0CH4hhS652SYG+PcxvgWa2HKWitAo
 AooHXcIrRTwTx/sy+Tq9Xa2tg9jTu0TW4RVlMX0N83C0k03Gn6dWA9K4bRYg8rHIxBeJo/T3P
 dtWoh/Fv5BM+Lm6CTr2RFLyL3qa/ahCEntbwoybjmAK05aVxWtyTtKy7Ya5xunqraeQ81xicE
 crI/2pmTqBLsanLngWx2JCPyDY7U9gQ2IbY8zIxGK+kJdPYNFQ8h237kdwOANgp94iHkESUOf
 lC6MvNPYn66FKV5s4hqGk/qqjf17BN7ilTc3+m1ZUE9NFYXDlqP5uIZOZASvF8a9Mrfl8pP69
 fzP0dIXk5pCPVjzsC5vpcKN3yx8bFVy3WYAJ5lK4hwEipjfQOeAnnZwCwBQH4h7Rlv4gAVMsN
 H80l70hd5qY7C+u44LwH4UMpRlhCJBiiJy+BBzXZz9KPOedHuQu8A/82ZdISZFbL3t3S9ngDr
 b0muRUIfTy2R0CUoLNRYgHzAUaTZF9s4A9LQlM2zCq2ohgIRx68Rvdgvdfum9V8NuxPo3kFQh
 brDvxueucvnCqCe9oZEv/Es9e3GhaWKU1PS1y3nJNVooN/wtw/VcjJcextC9fkKGTsN8YXFqS
 HZrUaYDtypVyzIJea7lJm2senuJOUwBokFrwRgW3w1IF2sj4+c0c3XCIDz9UUGEdBQCakcbUw
 2efOxLCVNbGDl1cwHUiPzBEXthhFmMaw+kkCSZXMCxHRrR/3eP+AmZgW2luOE9LstB9N9pq4f
 7cp5uutFvSqPK+y1+IdovTNWh3DtqCOco8r3eej073duBgHQEzwNTPPfh+o0qY432noYMgXG2
 mKKWbvEOZ1AaOQWyr4gRvvZbZFc9R6cA63S/v2n1lemTQ9Wp7uNoic28PSUg0f6HXrR4L7ASK
 8hUbPpYZYG3UZ5C6qn1Bzd2uLIox9CYXAaZVj8ykVNIO6inNVzZahbKccmQRhmgOXY1ZjO5HY
 h6kX5APwUMlR6HJN0e6ApGqh6ePoV8xtipTMAO9XGasukLrminxr4AKYijdaf4DetLM8jckcL
 NuDLfK90+Y4f6jEHNalEJc6/TExxM0uJNUs24zMcFNju8pKW3uyQ+61jIlra/zuOoG6nNNRiC
 rWRqXZ2dO0M9Kuu2bYanWtHVzUHiuUSBzDV/+6Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WUvMvUvJxcDdjNEVIQ2ogaP0Pru4TIPKG
Content-Type: multipart/mixed; boundary="hIacKGDGEUDWF3SqRcwoCbLkK25J3SmjU"

--hIacKGDGEUDWF3SqRcwoCbLkK25J3SmjU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/15 =E4=B8=8A=E5=8D=883:05, benjamin.haendel@gmx.net wrote:
> Hi Qu,
>=20
> i did all that and i have now again access to the Storage.

Btrfs check --repair log of that run please.
I guess you haven't keep it...

And "btrfs check" of current fs please.

> Sadly i am now encountering some errors and bugs and i thought
> You might want to know about that.
>=20
> 1. I am missing some folders and files
> 2. Some folders are there but no files in them
> 3. i can only access the drive via the samba share - not on the server =
directly
> 4. In Windows it shows "28TB of usage" but when i mark all data and hit=
 alt+enter it counts to 21.1 TB only

Windows? Why it's related to Windows then?
We're talking about btrfs, right?

For the total usage, it's completely sane as btrfs use extent booking,
which takes extra space.

Thanks,
Qu


>=20
> I am unsure if that data is now lost forever or if ist just a bug or wh=
at exactly is the problem.
> Do you think i could still "btrfs send" the Data and it will all be bac=
k or are those files lost due to new enumeration by btrfs-check Repair ?
>=20
> Best Regards,
> Ben
>=20
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
> Gesendet: Freitag, 14. August 2020 02:57
> An: benjamin.haendel@gmx.net
> Cc: linux-btrfs@vger.kernel.org
> Betreff: Re: AW: AW: Tree-checker Issue / Corrupt FS after upgrade ?
>=20
>=20
>=20
> On 2020/8/14 =E4=B8=8A=E5=8D=885:01, benjamin.haendel@gmx.net wrote:
>> Hi Qu,
>>
>> i downloaded the code, compiled and installed it.
>=20
> You still need to run "btrfs check --repair".
>=20
> Considering you haven't post that output, I guess you didn't run that.
>=20
>> Still could not mount the FS with error:
>> mount: /media/Storage: wrong fs type, bad option, bad superblock on /d=
ev/mapper/Crypto, missing codepage or helper program, or other error.
>>
>> Dmesg is telling me:
>> [  174.061205] Btrfs loaded, crc32c=3Dcrc32c-intel [  174.081002] BTRF=
S:=20
>> device label Storage devid 1 transid 207602 /dev/dm-0 [  192.175157]=20
>> BTRFS info (device dm-0): disk space caching is enabled [  204.025699]=
=20
>> BTRFS critical (device dm-0): corrupt leaf: block=3D22751711027200=20
>> slot=3D1 extent bytenr=3D6754755866624 len=3D4096 invalid generation, =
have=20
>> 22795412619264 expect (0, 207603] [  204.025703] BTRFS error (device=20
>> dm-0): block=3D22751711027200 read time tree block corruption detected=
 [ =20
>> 204.025731] BTRFS error (device dm-0): failed to read block groups: -5=
=20
>> [  204.076709] BTRFS error (device dm-0): open_ctree failed
>>
>> I am unsure of what to do now. Did i have to run a btrfs check --repai=
r with the compiled btrfs branch ?
>=20
> Yes.
>=20
>> I also removed all other versions of btrfs now to see if an old versio=
n could read it, it now says:
>> root@Userv:~# btrfs --version
>> btrfs-progs v4.1
>=20
> Nope, you're not using the correct version.
>=20
>>
>> Still i can not mount the drive. How can i at least get read access to=
 my data ?
>=20
> Just go using your older kernel, and wait for your distro to provide ne=
wer enough btrfs-progs.
>=20
> Thanks,
> Qu
>=20
>>
>> Best Regards,
>> Ben
>>
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Gesendet: Donnerstag, 13. August 2020 01:30
>> An: benjamin.haendel@gmx.net; linux-btrfs@vger.kernel.org
>> Betreff: Re: AW: Tree-checker Issue / Corrupt FS after upgrade ?
>>
>>
>>
>> On 2020/8/13 =E4=B8=8A=E5=8D=887:10, benjamin.haendel@gmx.net wrote:
>>> Hi Qu,
>>>
>>> thanks for your reply, i am not sure what to do from here on.
>>> What do i have to download from here or compile/make/install etc. ?
>>
>> You need to compile that branch.
>>
>> For how to compile, please check the README.md.
>>
>>
>>>
>>> I'm no total idiot but i still don't understand what i have to get=20
>>> And how to apply it...sorry :(
>>
>> Or you can use btrfs-send to send out the content of your fs with olde=
r kernel, and create a new fs using newer kernel, then receive the stream=
=2E
>>
>> The uninitialized data is only in extent tree, which won't be sent wit=
h the stream, by receiving it with newer kernel, you won't lose anything.=

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
>>> Gesendet: Donnerstag, 13. August 2020 00:51
>>> An: benjamin.haendel@gmx.net; linux-btrfs@vger.kernel.org
>>> Betreff: Re: Tree-checker Issue / Corrupt FS after upgrade ?
>>>
>>>
>>>
>>> On 2020/8/13 =E4=B8=8A=E5=8D=8812:58, benjamin.haendel@gmx.net wrote:=

>>>> Hi,
>>>>
>>>> i have been running my little Storage (32TB) on a Ubuntu 18.04 LTS=20
>>>> Machine with btrfs-progs 4.17. I then did my monthly upgrade (apt
>>>> dist-upgrade) and after a reboot my Partition could not mount with t=
he error message:
>>>> "root@Userv:/home/benjamin# mount -r ro btrfs /dev/mapper/Crypto=20
>>>> /media/Storage
>>>> mount: bad usage"
>>>>
>>>> I then proceeded to run a btrfs check which gave thousands of errors=
=20
>>>> and then also a super-recover:
>>>> root@Userv:/home/benjamin# btrfs rescue super-recover -v=20
>>>> /dev/mapper/Crypto All Devices:
>>>> Device: id =3D 1, name =3D /dev/mapper/Crypto
>>>>
>>>> Before Recovering:
>>>> [All good supers]:
>>>> device name =3D /dev/mapper/Crypto
>>>> superblock bytenr =3D 65536
>>>>
>>>> device name =3D /dev/mapper/Crypto
>>>> superblock bytenr =3D 67108864
>>>>
>>>> device name =3D /dev/mapper/Crypto
>>>> superblock bytenr =3D 274877906944
>>>>
>>>> [All bad supers]:
>>>>
>>>> All supers are valid, no need to recover
>>>>
>>>> I now checked my dmesg log:
>>>> [45907.451840] BTRFS critical (device dm-0): corrupt leaf:
>>>> block=3D22751711027200 slot=3D1 extent bytenr=3D6754755866624 len=3D=
4096=20
>>>> invalid generation, have 22795412619264 expect (0, 207589]
>>>
>>> This is caused by older kernel, which writes some uninitialized value=
 onto disk.
>>>
>>> You can try to fix it with this branch:
>>> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>>>
>>> Or you can use older kernel to delete the offending extents.
>>>
>>> Thanks,
>>> Qu
>>>
>>>> [45907.451848] BTRFS error (device dm-0): block=3D22751711027200 rea=
d=20
>>>> time tree block corruption detected [45907.451892] BTRFS error=20
>>>> (device
>>>> dm-0): failed to read block groups: -5 [45907.510712] BTRFS error=20
>>>> (device dm-0): open_ctree failed
>>>>
>>>> Google inquiries to this topic led me to this link:
>>>> https://btrfs.wiki.kernel.org/index.php/Tree-checker
>>>> It tells me to mail here first so thats what i am doing. I kind of=20
>>>> suspect since everything worked perfect (Memtest also no errors)=20
>>>> before the update, it has to do something with that update. I am=20
>>>> wondering if it would help if i deleted my OS Disk and reinstalled=20
>>>> an older Version of Ubuntu, like
>>>> 16.04.6 LTS ?
>>>>
>>>> Since then i upgraded to 20.04 LTS with BTRFS-PROGS 5.7 as a lot of =

>>>> forum entries said it would be wise to use the newer versions as old=
er were buggy.
>>>> That brought no help as well.
>>>>
>>>> Since i am no Linux/Unix Expert i thought it might be better to ask =

>>>> now first as advised in the link above before proceeding with any ot=
her plans.
>>>>
>>>> I find it hard to believe that all data is gone, i feel its buggy=20
>>>> behavior as the partition and everything is still there:
>>>> root@Userv:/home/benjamin# btrfs fi show
>>>> Label: 'Storage'  uuid: 46c7d04a-d6ac-45be-94cc-724919faca2b
>>>> Total devices 1 FS bytes used 28.23TiB
>>>> devid    1 size 29.10TiB used 29.04TiB path /dev/mapper/Crypto
>>>>
>>>> Best Regards,
>>>> Benjamin H=C3=A4ndel
>>>>
>>>
>>>
>>
>>
>=20
>=20


--hIacKGDGEUDWF3SqRcwoCbLkK25J3SmjU--

--WUvMvUvJxcDdjNEVIQ2ogaP0Pru4TIPKG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl83GNsACgkQwj2R86El
/qhYqAf+LydbakATsQlWOLO17tzAgRqlqxRORdyeYwkH4uXRZFB+WY4+9DrPWb3B
LYUOVljTSPHRVfWgo7Rdqb67vBg5ZN1s4B+WFh0ubIJtMBMykWybPVwuCafduu9w
WXLcJO3UWbDj4xF/HDwP16QcthVtHVDxLRrSWrtD8+22xrIabaM/xOiQes2fY76o
OcssWhQgFN+UrPfZEJj1SvH0NhntvnNMg2MvXlqLigoTm3NIj4Omyqgji2F3eWDz
wzbLFAXCTpGjEMJeSk3Mnzbw2DToIrH0ltUOhwztodFpwCj4xKR+k1fX4JhxsEGh
Whtk6+uiWmuZLG14rNzyH/s39a2GLg==
=knSL
-----END PGP SIGNATURE-----

--WUvMvUvJxcDdjNEVIQ2ogaP0Pru4TIPKG--
