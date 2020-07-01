Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831E52109A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgGAKsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 06:48:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:39683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbgGAKsu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 06:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593600528;
        bh=LpGFXkHFnEhuZEcxO5TOG6r1pl68b0bKa+07OH47uBU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ifatpk6MxBp5SfYzw6S83mWUq1E9fMo3zJKpCCOGg0eyKalfcLftDXLlEXMjusqP7
         XD8egBkGw1raV/+SMiMBSzKJvSzUrUE7fKUWr9p20/7cq5PwVz/AUQtOFfFqtXW6D+
         NP6PGlDztiXOnIA3v/kvEvHyF7XmdLnegY/Uh6z8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0XD2-1iuNZa3a5c-00wXaA; Wed, 01
 Jul 2020 12:48:48 +0200
Subject: Re: "parent transid verify failed" and mount usebackuproot does not
 seem to work
To:     Illia Bobyr <illia.bobyr@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHzXa9XOa1bppK44pKrqbSq50Xdsm63D_698gvo2G-JDWrNeLg@mail.gmail.com>
 <45900280-c948-05d2-2cd8-67480baaedae@gmx.com>
 <2f22bd0a-aa48-d0f1-04d0-cb130897249d@gmail.com>
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
Message-ID: <39558ad7-dfb3-05f7-1583-181f76f2a93d@gmx.com>
Date:   Wed, 1 Jul 2020 18:48:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2f22bd0a-aa48-d0f1-04d0-cb130897249d@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4C5O9o7lJvRwXSBvxbytAEzFoYnuvkKM0"
X-Provags-ID: V03:K1:1S3cNUT6q09Hbxk4fZph+PHb3PuF6caDP9xqMSEimw0eH02b3uv
 7QDyl/i/x0cCea/ks11+2BbRJmKOj0T1Ip5YyRAk5ehFQjUJmWZAt1FZftWtPt8YIieMi3C
 wCA8iVGyKKmrS+u5JKcJl6LDXrJjfVxMk8LBAP2Ez/6kUo+rZNOLAEYMDCm5ngV3JKiQjtx
 Dcxb/kedYCeHCxRsEFYsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMqetdv2qRU=:kkq2CfB/ZLgUNyJk5zDh3N
 xpO4AwvlmwiWIoLeAf3Yf8GoW1nIsFUsUPjAq62Om3Fv1oFhx8j3r5EAsoh7AiyE1BgWWJ1Um
 S/THzTxAN04OvXsiHXgGuX7+Hs1Qk0sT66lEaU7x7B0Z3n3XMc9DvaKCPSWmWE/zaScu5SO6q
 aRo5XsfxKfFlcwQ4RwfEvRMbHIBIjfkXOTmbRm+/fXe4o7O2U5f6HN39DJc/CYsGdw14CBF4b
 6IHS9lIiiKmTTg00/A2Z+jzl4I8QJ0/Q/6vw1l/xMe8pnL3MjETQKGmD15ITOn9jQ4DqMUKa+
 X00glZpl8Ur3cgtMKoPGTjEdSbfavH96aEJYc8E+1mgVQwHyniCtAbJP6Ou6KFak2wJe6tEpk
 QntftLGrkU4Wy14EXobjQX7X62bh2g4cO9kwbQw5E0DWTU74/SielboFFbfSZsDQxDS61v+pu
 eevORbZDU3jpgc2Ka5sn27/ENJRY3FrGeiIdsBGN6sMBK6UAMJrByKMzfETDPk3EPIoID2y8F
 DwfVGRfkjRgeuFb1RRxuGGeagAN2KGM3TGFL1Abw1Zbe3A6VzmO3Hxlk1RNCOtatHutVMNpcG
 8x6WwSaOhGxr6z38Re2lrysZ6qnFd2JX0oUMYF2MY2YxpFB/SUxK8WsJpRNvwgmyRDxR5cxkS
 8PC+UyLE6jKwXkxlF5IYhh0PJwm/WCmsqmPRwT7uwTuobFo6YntcLGtcvAnSnl3jBWoH5QMPn
 S+qwgeONfQ5Ao5jMVTkhzuJDiyDHN8kNTG8jBZQqDRnYXVdREPXAR+cH/rCID4gFCIjT/k0Z+
 Nt7YL473jP+TmJhlHKz6r1MCqUlBUjiuhKxQ4snPIOKkk8XZSysVENZMyEWdQcfb+rqnWge+p
 T7SKUZ2K4yi6GG0zEbfQDjLm5O1tjC7PYVtbJSkUqPZV+S3je+ZtmJPWjOoG3ea0qSr0ANCzD
 KJ2hY1qG8SKHvcfl0KAYUiPUTowjHtab9jrJS80icuxo1/2QBJw5+tjiMZ6NArZT96xS1ceGi
 6UV9E4mLkFPWg3h7MR8NRspwgpgJ5FGVmwsCsQQjHxairYZevRqfEk7L/kUkXG+uVzwS1H3Ng
 uWF2LgFlRKzwo16UhoPq6S3BS5UhYD6hrhRuJL7V3vys3bvR+vYAjYQQ8/HK/LgviL6uZXR5P
 571PJLonMa1Dx6OXPORXWRst7shCnRpS8RqWWPtl45m2eK4RXKlD7C60sglDSd50BiIFX7FTW
 lMjLOxx3rO3mEnQvR
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4C5O9o7lJvRwXSBvxbytAEzFoYnuvkKM0
Content-Type: multipart/mixed; boundary="45BJWFAghDqNZyFcG58Td1Ki2QvRngO64"

--45BJWFAghDqNZyFcG58Td1Ki2QvRngO64
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/1 =E4=B8=8B=E5=8D=886:16, Illia Bobyr wrote:
> On 6/30/2020 6:36 PM, Qu Wenruo wrote:
>> On 2020/7/1 =E4=B8=8A=E5=8D=883:41, Illia Bobyr wrote:
>>> Hi,
>>>
>>> I have a btrfs with bcache setup that failed during a boot yesterday.=

>>> There is one SSD with bcache that is used as a cache for 3 btrfs HDDs=
=2E
>>>
>>> Reading through a number of discussions, I've decided to ask for advi=
ce here.
>>> Should I be running "btrfs check --recover"?
>>>
>>> The last message in the dmesg log is this one:
>>>
>>> Btrfs loaded, crc32c=3Dcrc32c-intel
>>> BTRFS: device label root devid 3 transid 138434 /dev/bcache2 scanned
>>> by btrfs (341)
>>> BTRFS: device label root devid 2 transid 138434 /dev/bcache1 scanned
>>> by btrfs (341)
>>> BTRFS: device label root devid 1 transid 138434 /dev/bcache0 scanned
>>> by btrfs (341)
>>> BTRFS info (device bcache0): disk space caching is enabled
>>> BTRFS info (device bcache0): has skinny extents
>>> BTRFS error (device bcache0): parent transid verify failed on
>>> 16984159518720 wanted 138414 found 138207
>>> BTRFS error (device bcache0): parent transid verify failed on
>>> 16984159518720 wanted 138414 found 138207
>>> BTRFS error (device bcache0): open_ctree failed
>> Looks like some tree blocks not written back correctly.
>>
>> Considering we don't have known write back related bugs with 5.6, I
>> guess bcache may be involved again?
>=20
> A bit more details: the system started to misbehave.
> Interactive session was saying that the main file system became read/on=
ly.

Any dmesg of that RO event?
That would be the most valuable info to help us to locate the bug and
fix it.

I guess there is something wrong before that, and by somehow it
corrupted the extent tree, breaking the life keeping COW of metadata and
screwed up everything.

> And then the SSH disconnected and did not reconnect any more.
> It did not seem to reboot correctly after I've pressed the reboot
> button, so I did a hard rebooted.
> And now it could not mount the root partition any more.
>>> Trying to mount it in the recovery mode does not seem to work:
>>>
>>> [...]
>>>
>>> I have tried booting using a live ISO with 5.8.0 kernel and btrfs v5.=
6.1
>>> from http://defender.exton.net/.
>>> After booting tried mounting the bcache using the same command as abo=
ve.
>>> The only message in the console was "Killed".
>>> /dev/kmsg on the other hand lists messages very similar to the ones I=
've
>>> seen in the initramfs environment: https://pastebin.com/Vhy072Mx
>> It looks like there is a chance to recover, as there is a rootbackup
>> with newer generation.
>>
>> While tree-checker is rejecting the newer generation one.
>>
>> The kernel panic is caused by some corner error handling with root
>> backups cleanups.
>> We need to fix it anyway.
>>
>> In this case, I guess "btrfs ins dump-super -fFa" output would help to=

>> show if it's possible to recover.
>=20
> Here is the output: https://pastebin.com/raw/DtJd813y

OK, the backup root is fine.

So this means, metadata COW is corrupted, which caused the transid mismat=
ch.

>=20
>> Anyway, something looks strange.
>>
>> The backup roots have a newer generation while the super block is stil=
l
>> old doesn't look correct at all.
>=20
> Just in case, here is the output of "btrfs check", as suggested by "A L=

> <mail@lechevalier.se>".=C2=A0 It does not seem to contain any new infor=
mation.
>=20
> parent transid verify failed on 16984014372864 wanted 138350 found 1311=
17
> parent transid verify failed on 16984014405632 wanted 138350 found 1311=
27
> parent transid verify failed on 16984013406208 wanted 138350 found 1311=
12
> parent transid verify failed on 16984075436032 wanted 138384 found 1311=
36
> parent transid verify failed on 16984075436032 wanted 138384 found 1311=
36
> parent transid verify failed on 16984075436032 wanted 138384 found 1311=
36
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D16984175853568 item=3D8 pare=
nt
> level=3D2 child level=3D0
> ERROR: failed to read block groups: Input/output error

Extent tree is completely screwed up, no wonder the transid error happens=
=2E

I don't believe it's reasonable possible to restore the fs to RW status.
The only remaining method left is btrfs-restore then.

> ERROR: cannot open file system
> Opening filesystem to check...
>=20
> As I was running the commands I have accidentally run the following com=
mand:
>=20
> =C2=A0=C2=A0=C2=A0 btrfs inspect-internal dump-super -fFa >/dev/bcache0=
 2>&1
>=20
> Effectively overwriting the first 10kb of the partition :(

That's not a problem at all.
Btrfs reserves the first 0~1M space, so as long as you don't screw up
the super block at [64K, 68K) you're completely fine.

Thanks,
Qu
>=20
> Seems like the superblock starts at 64kb.=C2=A0 So, I hope, this would =
not
> cause any more damage.
>=20
> P.S. Thanks a lot for your reply Qu Wenruo!
>=20
> Thank you,
> Illia
>=20


--45BJWFAghDqNZyFcG58Td1Ki2QvRngO64--

--4C5O9o7lJvRwXSBvxbytAEzFoYnuvkKM0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl78agkACgkQwj2R86El
/qglPQgAqhfw2Ro8U1Iivsg0cS6TJnGOnGX/jDHwpHgMXEpqWvH8+m73XbBHbdqz
Aqb8TBGa4zcqZdrzUStyJeHHdVxS4bQSUl1jGmq+hG57wM9Cl8b08d45eIPtW5Ou
GGOH2QpW2HAveyyar7WsGXVVOQh7uNM+6Pu3Wlq6cGZkW8cUoeRbAJ2laWuAMMFP
ABtppAlo+fg/oB2JD/CqAdLrXO9CutfDgP0j01V8yi92yeUqUjR+7VkzVLj2Ok27
Yi7AmAVK5d4iIddwWhKwyLQkElV+Zo1xT/Wc85F/s4oAXJjR6ORo2F3HwbC1e4gW
RleoAmDRog9acp45JodSXMavxGeUlA==
=x5Jf
-----END PGP SIGNATURE-----

--4C5O9o7lJvRwXSBvxbytAEzFoYnuvkKM0--
