Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ED81C7D9E
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 00:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgEFWu2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 18:50:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:44875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgEFWu2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 18:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588805423;
        bh=+ibddYhvjHajtwJFoS9dQS6RoFTkALpH8zVHTtQcu0g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=B0JnpqyA3t4pIY4VbBsTFsB59WGGTPVf6XwfNVIEWj+Ttm2zIbey4sBYTWjHvIkdE
         CojkBfHmGCLpYQF9WvCH/uigWWD8+69JJ0FBYBhqUCKT4nfTItzJmuzbvJUymF3lnD
         9zB/IRbhBOzDJelRz63SsMMAy5dVrranNvDxznl4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRCK6-1jkoMU3VvY-00NCU4; Thu, 07
 May 2020 00:50:23 +0200
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft895gy-zmDsax14pOgK3JmGxj6+1Z_itn3GhaGREBfDKw@mail.gmail.com>
 <87cb36b6-618d-5005-d832-53cd486084cb@gmx.com>
 <CA+M2ft8oLkTrav1=zW1AFRU+=44Yd6-fXYO5mhre4mi-1PANmw@mail.gmail.com>
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
Message-ID: <585fd229-29fd-1786-e971-8c90c2430218@gmx.com>
Date:   Thu, 7 May 2020 06:50:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CA+M2ft8oLkTrav1=zW1AFRU+=44Yd6-fXYO5mhre4mi-1PANmw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z3MFqYSl8AhjCzVXjNhr063aXIErudOR2"
X-Provags-ID: V03:K1:YOsLzC0Xa52o8dNOw6L0Z0rx/XuCYmct8i8xPJbE2/L8zCYu3xd
 8JLrjOZ8qq5sRE3HWuNQ9XoS1zqWTJq/7zk0Yvm31WKoA61rpMrZJNHzGaNk5KJPqwDgnJQ
 MzkrqElTEVmbuSDJdsBkasJJ2/0v2qcIZh4YRe3QvBrhsFgcnivbhrBbFwJxEE1QNLO/CgN
 Xf4c36SPpxqwxG/mFHCmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M4TDf6zIeN4=:UvCKl+mEmzQjABhPLWc6H0
 1853xR3soXaiOWkO1pwrSB0Zh65xCvscHvZV+0yB4uxDKoe7JdNO0EGd+b8KJKUwe0L8BRu5+
 mqdaEUq/L1xav9VAyVve8dRBKBYDFUUbyj0e9onzmCkirU3gO64cp5Y6rfWwWScBTPOrX9BEO
 D9ppv2H3HZMzeZEHFnTVFg6KIH7xKFsJerNKBq2paJBoVbTtMGFb0copaWL8AVefcCThufY0O
 0tYfP8hR7IMgg4RQ/MFwX+sg8I6xZf1Br8AHlmSdUOTuO7DsG3azCHJ7fW/uIdtsLc05BLiq3
 UxPgcleN1GuJ4a5/6S7SWo0xXOZAkjPgq294YC8aXmOE2ZNRXtG57Fqru1bW9x+lia5fbrwY4
 3FqSY1XXZKUX789C2HFfLMhklfEX9CdMT++BlxyabFCiZGGDNF5cYEaGCE4seoaGTsSvQae6L
 QL65VTrYIu/Cw9Ld7Mmv5NG2CQx344W30b+g7xpchBeaRysPDXpdlkSqUo2H6rTfFPO5F2LYO
 MER/J1eco6zMcdD6e1WMhYEPx9pBHuCQJbQxq7AV+YZnOmkxzi8L2PTIRLOR0/D34MlXJknA5
 HBmYRM9aFpM31nbVFWWVUYXpSpSbDVMSz7UuCJNVglhzl462+CZsD6qXqJ73+dxS5TVqN5xUL
 9mrMxQcjM/6eNIamKZJvDYRS8C8hFxY48IQPmvb/mtwhzgfu6UVlRVwI+irT382gbJ5NWNm8X
 uUNqx6o3VT8cPHf5AeeBUtlffk+Fr8Je3ETitDi9KCc8joiZxv/KhBB2tFIhvEi4dBsz5+9vk
 YDKWzqBBIqOIB0AB8V7zAhawkhFdhzuEHME+4huRfU1dDZQz5oWDse/XV70ecf8eI6tPThkdh
 pD8AGfiqbtEWDbzcdgK68OV0J/r+hLo01BVVGIsIa1OJdPadlM5U3Bvm0dcsjuL5dNMC2foUf
 lLz0WbWq13+gsD3EuToed2XEZHfZmyhUKbJ9HkwEUbBV0sTlcOWeIBkYMPwEYa0sftePb331/
 VGT0M1ZCotFNMvCiXr6+mHgzGCkB8EXfQVqsUFtFurya8nxwo88fOdcy0xvdm5cG6u1AI4Y3t
 N5ugTwpcd/TPZwWhKvMuw/otxYy4mT9HmA9L7yDRvMAOl0TYUZ82a48GTxH7VBL1Ay7cKeP/4
 l3l9q2uxrFOtkTxzXrsmTk+evKRUweJ3BrPVY7zJ3T/t1VVA/NQRRnIEcNRb5S79HfkGt1rKL
 ykKkBA7B0p58/m48S
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z3MFqYSl8AhjCzVXjNhr063aXIErudOR2
Content-Type: multipart/mixed; boundary="FNQ8mMZ6hzyIO2jbmrW9Hzr7mSVyxuELE"

--FNQ8mMZ6hzyIO2jbmrW9Hzr7mSVyxuELE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/6 =E4=B8=8B=E5=8D=8811:29, John Hendy wrote:
> On Wed, May 6, 2020 at 1:13 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/5/6 =E4=B8=8B=E5=8D=8812:37, John Hendy wrote:
>>> Greetings,
>>>
>>>
>>> I'm following up to the below as this just occurred again. I think
>>> there is something odd between btrfs behavior and browsers. Since the=

>>> last time, I was able to recover my drive, and have disabled
>>> continuous trim (and have not manually trimmed for that matter).
>>>
>>> I've switched to firefox almost exclusively (I can think of a handful=

>>> of times using it), but the problem was related chromium cache and th=
e
>>> problem this time was the file:
>>>
>>> .cache/mozilla/firefox/tqxxilph.default-release/cache2/entries/D8FD76=
00C30A3A68D18D98B233F9C5DD3F7DDAD0
>>>
>>> In this particular instance, I suspended my computer, and resumed to
>>> find it read only. I opened it to reboot into windows, finding I
>>> couldn't save my open file in emacs.
>>>
>>> The dmesg is here: https://pastebin.com/B8nUkYzB
>>
>> The reason is write time tree checker, surprised it get triggered:
>>
>> [68515.682152] BTRFS critical (device dm-0): corrupt leaf: root=3D257
>> block=3D156161818624 slot=3D22 ino=3D1312604, name hash mismatch with =
key,
>> have 0x000000007a63c07f expect 0x00000000006820bc
>>
>> In the dump included in the dmesg, unfortunately it doesn't include th=
e
>> file name so I'm not sure which one is the culprit, but it has the ino=
de
>> number, 1312604.
>=20
> Thanks for the input. The inode resolves to this path, but it's the
> same base path as the problematic file for btrfs scrub.
>=20
> $ sudo btrfs inspect-internal inode-resolve 1312604 /home/jwhendy
> /home/jwhendy/.cache/mozilla/firefox/tqxxilph.default-release/cache2/en=
tries
>=20
>> But consider this is from write time tree checker, not from read time
>> tree checker, this means, it's not your on-disk data corrupted from th=
e
>> very beginning, but possibly your RAM (maybe related to suspension?)
>> causing the problem.
>=20
> Interesting. I suspend al the time and have never encountered this,
> but I do recall sending an email (in firefox) and quickly closing my
> computer afterward as the last thing I did.
>=20
>>>
>>> The file above was found uncorrectable via btrfs scrub, but after I
>>> manually deleted it the scrub succeeded on the second try with no
>>> errors.
>>
>> Unfortunately, it may not related to that file, unless that file has t=
he
>> inode number 1312604.
>>
>> That to say, this is a completely different case.
>>
>> Considering your previous csum corruption, have you considered a full
>> memtest?
>=20
> I can certainly do this. At what point could hardware be ruled out and
> something else pursued or troubleshot? Or is this a lost cause to try
> and understand?

If a full memtest run finishes without problem, then we're hitting
something impossible.

As there shouldn't be anything causing write time tree checker error,
especially for name hash.

Thanks,
Qu

>=20
> Many thanks,
> John
>=20
>> Thanks,
>> Qu
>>
>>>
>>> $ btrfs --version
>>> btrfs-progs v5.6
>>>
>>> $ uname -a
>>> Linux voltaur 5.6.10-arch1-1 #1 SMP PREEMPT Sat, 02 May 2020 19:11:54=

>>> +0000 x86_64 GNU/Linux
>>>
>>> I don't know how to reproduce this at all, but it's always been
>>> browser cache related. There are similar issues out there, but no
>>> obvious pattern/solutions.
>>> - https://forum.manjaro.org/t/root-and-home-become-read-only/46944
>>> - https://bbs.archlinux.org/viewtopic.php?id=3D224243
>>>
>>> Anything else to check on why this might occur?
>>>
>>> Best regards,
>>> John
>>>
>>>
>>> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail.com> wrote=
:
>>>>
>>>> Greetings,
>>>>
>>>> I've had this issue occur twice, once ~1mo ago and once a couple of
>>>> weeks ago. Chromium suddenly quit on me, and when trying to start it=

>>>> again, it complained about a lock file in ~. I tried to delete it
>>>> manually and was informed I was on a read-only fs! I ended up biting=

>>>> the bullet and re-installing linux due to the number of dead end
>>>> threads and slow response rates on diagnosing these issues, and the
>>>> issue occurred again shortly after.
>>>>
>>>> $ uname -a
>>>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2020 16:38:40
>>>> +0000 x86_64 GNU/Linux
>>>>
>>>> $ btrfs --version
>>>> btrfs-progs v5.4
>>>>
>>>> $ btrfs fi df /mnt/misc/ # full device; normally would be mounting a=
 subvol on /
>>>> Data, single: total=3D114.01GiB, used=3D80.88GiB
>>>> System, single: total=3D32.00MiB, used=3D16.00KiB
>>>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
>>>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
>>>>
>>>> This is a single device, no RAID, not on a VM. HP Zbook 15.
>>>> nvme0n1                                       259:5    0 232.9G  0 d=
isk
>>>> =E2=94=9C=E2=94=80nvme0n1p1                                   259:6 =
   0   512M  0
>>>> part  (/boot/efi)
>>>> =E2=94=9C=E2=94=80nvme0n1p2                                   259:7 =
   0     1G  0 part  (/boot)
>>>> =E2=94=94=E2=94=80nvme0n1p3                                   259:8 =
   0 231.4G  0 part (btrfs)
>>>>
>>>> I have the following subvols:
>>>> arch: used for / when booting arch
>>>> jwhendy: used for /home/jwhendy on arch
>>>> vault: shared data between distros on /mnt/vault
>>>> bionic: root when booting ubuntu bionic
>>>>
>>>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
>>>>
>>>> dmesg, smartctl, btrfs check, and btrfs dev stats attached.
>>>>
>>>> If these are of interested, here are reddit threads where I posted t=
he
>>>> issue and was referred here.
>>>> 1) https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recove=
ring_from_various_errors_root/
>>>> 2)  https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs=
_root_started_remounting_as_ro/
>>>>
>>>> It has been suggested this is a hardware issue. I've already ordered=
 a
>>>> replacement m2.sata, but for sanity it would be great to know
>>>> definitively this was the case. If anything stands out above that
>>>> could indicate I'm not setup properly re. btrfs, that would also be
>>>> fantastic so I don't repeat the issue!
>>>>
>>>> The only thing I've stumbled on is that I have been mounting with
>>>> rd.luks.options=3Ddiscard and that manually running fstrim is prefer=
red.
>>>>
>>>>
>>>> Many thanks for any input/suggestions,
>>>> John
>>


--FNQ8mMZ6hzyIO2jbmrW9Hzr7mSVyxuELE--

--z3MFqYSl8AhjCzVXjNhr063aXIErudOR2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6zPywACgkQwj2R86El
/qihuAf/dXjRfc8rWzyCy+LPkNQMM3oiF54JLAoWJ2Uf11p94FIPccefNbU0WUW8
DpFjLnRm2F0U64nxph6R/xnMe4YBRaInKJsBnmsRM+VmgJxS60qnLUV6swGdHRPr
FVutNhmMwiQ4apthKZ0ni4clIaSiSu18GchsfzVZD/HPuPBf25wtFaQFOkAUYHNC
yjod8czNu5yJYwfiDtc5vTwqwdIKYOaTu8su6PGrFoEBTRnKsVBXTov0kDaAD5Zl
q/65XIlmtFkJ84+9/0XgkzDrT3sAmh3ShacDl8CX+REqQWWVg9T8shgclESNqjFS
GMwABIZWu2imFxBiVMOFVTAjCAijmg==
=DlnO
-----END PGP SIGNATURE-----

--z3MFqYSl8AhjCzVXjNhr063aXIErudOR2--
