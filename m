Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF81C6829
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 08:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgEFGNf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 02:13:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:58261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgEFGNd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 02:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588745609;
        bh=b8pkvAlx3wsagcMjTM9EeUogF64ia8D1zcQ2mmTjRoQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=j3M8LhlBbmEGwJWfV5fzBfPcEi7bpny7r1ILmi20cKn5y/4eGERbDZaVaFWvANt8U
         1B7dhb2WaRUVuKh8/G3O8jprJZsxxX4XFQtUXVCRtTvtI+5Crl9wA2czX3ZN9Xwd+g
         1Feyf5ULHujIGeFI3cr35Ak8AY/YIJnmF0kJBK/M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3siA-1j5uzu2YtM-00zqN1; Wed, 06
 May 2020 08:13:28 +0200
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft895gy-zmDsax14pOgK3JmGxj6+1Z_itn3GhaGREBfDKw@mail.gmail.com>
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
Message-ID: <87cb36b6-618d-5005-d832-53cd486084cb@gmx.com>
Date:   Wed, 6 May 2020 14:13:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CA+M2ft895gy-zmDsax14pOgK3JmGxj6+1Z_itn3GhaGREBfDKw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tM1neJku5DnPENwCcyVqyz6RjBk7d4GAV"
X-Provags-ID: V03:K1:NBP6Li9+tMzVOqy77KDICh42fD8S6ouNQYZdXBQzNtjJjdO0TKt
 2OXzWnF8/XtxIYCbFFb+FsDWo+QuTHjB9z818AJeG1m9ltAV8C6r9HNoU0RSxdff8K3EL16
 Rl/yFSqTxXONiGD9F3F3ObKRXA/vqeoexlkS+udI4I1xzyyBQ5Ssz1QTqTnv+fz/KF0HHkQ
 RtOpA60Wxr0WAiS+/j2OQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BvEAJhnyNeI=:nbVc1NrcAfqvcghIPkDXSW
 9irAitvjxD6zZzNmvhvrFNRbCd5zvTYbHBY1Ne6/QSpfr//vtyLbARC/q+fv9Ws40fSbSL/uB
 6dXc0JY4SY3jOAR6w9CyxDKN3ns9Og6ytiItnmw2GLS/WxTydc7nQRt528Okd2x6pgk4MHrzV
 WKoF+Oq3B299rPdsOuiuh7enCgbF6ajt72OCDgYEinEFoJZotlavWrgmjAJsA4ZNbwnIySUaf
 zcI3fFviNrWYVajFWH1tG5ZHjEsDJ0A+Z9oY4J93rSbVKc/RENxhY6OrJWafRCkk1ZBtsQcvH
 /yyfZinQWT0nYAKkL+uefMWHeB5TjlVeRvqsdmUSHwBi+Ud8n8ogJJpgL2z7bW2xrKRTmdg4n
 POMT5/HFrfJXc2BA60OGYPV2PIBKr/ynfnosX56z0lqw4mMr9xH8vSJN23rsqEVk6yfZu3k1g
 YO33CJRHfHA5gw9sUDct/0iWhsyF8pV4Powz3lTL0MA7lgIbeGRTaW9KtYRQD2d84L4dbLCTy
 inklj46M+VfUjZohERW9zBGVsJHu+nJSoUypmQRaHocO/MekUUbG6yh+i5IcIYAL3IL4Otlqg
 pwCliB8DBXEJKbbY6eyw05LH8l3Z6gvKCp4sHex5S0gAmdSxHb2xKcc2HY237grPnhq3Ejmz6
 tMYgfOS8Vmom303kOY7SAULwcXENcKe7c3hfmQXuFbges3yY+C3Den+3SxCLc8ZZi5gHZIZBz
 jV54lU4HEcTdmcOugzwPgUmTgyIYIdja7PeTt9uKc1d2uBACXBweIgV/wCEhfCuJCdZzydPfZ
 2T8UZE+Gs9IZ7D6hMNatf13SgVVXfvPkcD1MdlfpZP5Gqp5PRoJEoBn71kmCas+lUZbUjCA8F
 SAoBoEnv/LrzP9Y5Vp1nvhCJf8p05TBC7898SyO5EzJH2PLX08mdG5Wx7rJCYw8ur+D4LUymI
 xz+RwQzcNVgfPIUSxlBszkIA6sjoHfsNvAlMCiJzkrcpayrLf0c37mkG9unNVCZfI2I9CLQ/2
 LhxXreUBbrS4L5UykS3lMffkqpOqgkxnHFAuvJpkVUzLW7zqrs+56w2HLIAS9gAv6BegcuXRM
 AFnrgXuDxUvKBB3EmJCF1LGwUcKu8cIIvjiJonPwDQr6il5TgIEhKAFTsAHCaWXETvKsxckdW
 YpdBZiT5x5SR2ihTz6x/oNqI59l1hZBb7gHxZ90BVsNnVLZjDvNDAJh3pTGW9FV5U+jh4bNlf
 R/yDSZ/W4GuIfuHbt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tM1neJku5DnPENwCcyVqyz6RjBk7d4GAV
Content-Type: multipart/mixed; boundary="JFeCZRhMUXH02W3kf2PNdIG3r1xnpDe5C"

--JFeCZRhMUXH02W3kf2PNdIG3r1xnpDe5C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/6 =E4=B8=8B=E5=8D=8812:37, John Hendy wrote:
> Greetings,
>=20
>=20
> I'm following up to the below as this just occurred again. I think
> there is something odd between btrfs behavior and browsers. Since the
> last time, I was able to recover my drive, and have disabled
> continuous trim (and have not manually trimmed for that matter).
>=20
> I've switched to firefox almost exclusively (I can think of a handful
> of times using it), but the problem was related chromium cache and the
> problem this time was the file:
>=20
> .cache/mozilla/firefox/tqxxilph.default-release/cache2/entries/D8FD7600=
C30A3A68D18D98B233F9C5DD3F7DDAD0
>=20
> In this particular instance, I suspended my computer, and resumed to
> find it read only. I opened it to reboot into windows, finding I
> couldn't save my open file in emacs.
>=20
> The dmesg is here: https://pastebin.com/B8nUkYzB

The reason is write time tree checker, surprised it get triggered:

[68515.682152] BTRFS critical (device dm-0): corrupt leaf: root=3D257
block=3D156161818624 slot=3D22 ino=3D1312604, name hash mismatch with key=
,
have 0x000000007a63c07f expect 0x00000000006820bc

In the dump included in the dmesg, unfortunately it doesn't include the
file name so I'm not sure which one is the culprit, but it has the inode
number, 1312604.


But consider this is from write time tree checker, not from read time
tree checker, this means, it's not your on-disk data corrupted from the
very beginning, but possibly your RAM (maybe related to suspension?)
causing the problem.

>=20
> The file above was found uncorrectable via btrfs scrub, but after I
> manually deleted it the scrub succeeded on the second try with no
> errors.

Unfortunately, it may not related to that file, unless that file has the
inode number 1312604.

That to say, this is a completely different case.

Considering your previous csum corruption, have you considered a full
memtest?

Thanks,
Qu

>=20
> $ btrfs --version
> btrfs-progs v5.6
>=20
> $ uname -a
> Linux voltaur 5.6.10-arch1-1 #1 SMP PREEMPT Sat, 02 May 2020 19:11:54
> +0000 x86_64 GNU/Linux
>=20
> I don't know how to reproduce this at all, but it's always been
> browser cache related. There are similar issues out there, but no
> obvious pattern/solutions.
> - https://forum.manjaro.org/t/root-and-home-become-read-only/46944
> - https://bbs.archlinux.org/viewtopic.php?id=3D224243
>=20
> Anything else to check on why this might occur?
>=20
> Best regards,
> John
>=20
>=20
> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail.com> wrote:
>>
>> Greetings,
>>
>> I've had this issue occur twice, once ~1mo ago and once a couple of
>> weeks ago. Chromium suddenly quit on me, and when trying to start it
>> again, it complained about a lock file in ~. I tried to delete it
>> manually and was informed I was on a read-only fs! I ended up biting
>> the bullet and re-installing linux due to the number of dead end
>> threads and slow response rates on diagnosing these issues, and the
>> issue occurred again shortly after.
>>
>> $ uname -a
>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2020 16:38:40
>> +0000 x86_64 GNU/Linux
>>
>> $ btrfs --version
>> btrfs-progs v5.4
>>
>> $ btrfs fi df /mnt/misc/ # full device; normally would be mounting a s=
ubvol on /
>> Data, single: total=3D114.01GiB, used=3D80.88GiB
>> System, single: total=3D32.00MiB, used=3D16.00KiB
>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
>>
>> This is a single device, no RAID, not on a VM. HP Zbook 15.
>> nvme0n1                                       259:5    0 232.9G  0 dis=
k
>> =E2=94=9C=E2=94=80nvme0n1p1                                   259:6   =
 0   512M  0
>> part  (/boot/efi)
>> =E2=94=9C=E2=94=80nvme0n1p2                                   259:7   =
 0     1G  0 part  (/boot)
>> =E2=94=94=E2=94=80nvme0n1p3                                   259:8   =
 0 231.4G  0 part (btrfs)
>>
>> I have the following subvols:
>> arch: used for / when booting arch
>> jwhendy: used for /home/jwhendy on arch
>> vault: shared data between distros on /mnt/vault
>> bionic: root when booting ubuntu bionic
>>
>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
>>
>> dmesg, smartctl, btrfs check, and btrfs dev stats attached.
>>
>> If these are of interested, here are reddit threads where I posted the=

>> issue and was referred here.
>> 1) https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recoveri=
ng_from_various_errors_root/
>> 2)  https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs_r=
oot_started_remounting_as_ro/
>>
>> It has been suggested this is a hardware issue. I've already ordered a=

>> replacement m2.sata, but for sanity it would be great to know
>> definitively this was the case. If anything stands out above that
>> could indicate I'm not setup properly re. btrfs, that would also be
>> fantastic so I don't repeat the issue!
>>
>> The only thing I've stumbled on is that I have been mounting with
>> rd.luks.options=3Ddiscard and that manually running fstrim is preferre=
d.
>>
>>
>> Many thanks for any input/suggestions,
>> John


--JFeCZRhMUXH02W3kf2PNdIG3r1xnpDe5C--

--tM1neJku5DnPENwCcyVqyz6RjBk7d4GAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6yVYMACgkQwj2R86El
/qhPDQf+KBQVlgBESlvtfzybnecOHJjdIRBRlmWdFobkBCqSZv5dEpRz16/oVwdg
fmMcLoWnh9UioLhCb9EYJEdqay+o4I2w2r78y081vr0dbS3RvWNu9veYbAsI6wEZ
Y/zKbaLvfE6SOnKDHMhblGamiGGPcK6WU2XJFq2NWFtyDk7GGzk2a9XT1Bc5E315
75iWcQC+AciD59ws9AmH+pxeN3axxGHFeU0+PcMEh4q5hlrXMhIJsKShQ5SnRZ7g
c/qkPbbUOJYGd25a5U7QmhDb0uK74NiHSsLvZ4hNUed31DZRNncNSvAZtQqmgS68
MwXme97FHVcZDvm7kranNANjA2XTtQ==
=dDkB
-----END PGP SIGNATURE-----

--tM1neJku5DnPENwCcyVqyz6RjBk7d4GAV--
