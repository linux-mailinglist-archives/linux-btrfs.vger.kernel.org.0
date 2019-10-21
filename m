Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F98DEA20
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfJUK4B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:56:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:49291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfJUK4B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571655355;
        bh=7NPBlZhBL57ZZNUMvjT9vjPJN8wcNB4QgW96vY86yx4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=heRLMrYBAuSqP465DJafVefKlgKt6n17ccBdTHkhe3y9NJMA/WSgCAb4yh1f6PURj
         X4wY51g9VLkGzwV8jT2KpsSOSAVUaKwLGhBjZmN+4YS6svXG7AtkROFI4hjaU2idcS
         fOBAcDtcjm9WACQtceUKpJabCmeaY4JWkwE6GFoU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzhjF-1i8ynz3xGT-00vk0z; Mon, 21
 Oct 2019 12:55:55 +0200
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
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
Message-ID: <5b1e98d5-ed56-efbf-e52e-cc6808ed6ba7@gmx.com>
Date:   Mon, 21 Oct 2019 18:55:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nCELHWhO0sjX4IKiC1b3mDaaohDjOHH04"
X-Provags-ID: V03:K1:u6VQm4AS/kAYL6rwdFCHXDda11/fu//pLg14wJpgBWoiB7uhxZJ
 12AsNtnACjodf/qKKtMfparun1e96LG+ls3AQAZE7ijMEFHdeGihUbfjFofwbw+LV7k+KqI
 TcnOpjOuNH94Qf9Y1pfSx5xB04SV5f0nydKDvHo58Wze5rFnUgGY5PPp49cuqqHniPWm2cO
 ZFdir2qCqLfNFrLLx5mvA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XQEubTiGf7E=:3oN0s38EiLrHrEqvSuKkZR
 jWPflEfZNZlYSRfMINt0WeCMQU2weAbUC54mlJGubXCNlgjGxh1nB24v0YQYQm5TOod26EoKN
 95N/nEJ+r0rs+iiU86Zl1Ea56lBxyDlETFptJdFsk6/VUQknnIsMTXbDdwSOS39BiRmSxl39r
 tKQ/tFUB1mKMVJAm0gjtoMiQPkMriEkfuagULNK47kv1YKhmjiOBJjSrKDFJDMf5PzLMD6Du6
 lFVwcj+ZqmhnydMk57qh/g4dNxl2gBKfB6WDSNUUPx5QUina8cDFeMRCE9kOymAD003tfRY+F
 nwKrnKuH6IqQ4Yc0r1cwsQc1yJ5/HZ7gQp496Rkg0rLtQqJpNqjeXGuSdjtx7fFbUmSg+I2J1
 OR/IPHa4rMVH4zPbZnlCVTpgKCIGVPosygplbndwhXkqDQSPcT/cz7mc+vdknXluyFO1qNWuB
 CZJ6+3nhsseaeUD3xFfqp42FYaKFgfI7g8mdlQ6MS002XMdZf9Mx4cK91ZA6qRrkQKU9K9BJh
 f4wznZ/tupyUDbXupgIWPZ/GiDmKEc/vhdXUQ4Eb8s+oXtmURxl2hxEFPe2i1pTyOPVJGQ3Jq
 1vUUMh3m4g7mABFdhZpW3RCbMbYBycGxgISrrDPwNWcj942mXkqAE2buUI/syl4J0f7gM1ms0
 BwDZPf7IZeIy5mICT4PiaHewRqyz6YBpjdu6reRGx9U9nCbQMYeMHllo1uqhdxdWtTpuFDK9z
 xFIMX8tpag/95gsLzvopguaA28ko6EEZUJK2bvhP/qTCZ5nSIju1WMO5bpcFO2MZzASColoMj
 6HtJlbk0//EQei2GatR4VKlEUuDCzlsj+ArkkS9txQxP3alFJDyJK7P7ijQhi6fyUFQN+hw0G
 YQUYN/Ym8KoYd6NZIjFsyq8EdZskmzqAtUJ9vZFqM75DUsYvIIZWOmNaIXU5p2xXgTsHCFMlp
 IKBlcP7L0JVPI33DZ5qbDZE4juZhzgnpTiOKXYajCYNl7bkNla1YI/qogb3v6gY2u/yK6F2AP
 ZBBkheaCBpM2yaGZ6z5ftAcfEtFgmNCsRVdPDebcddWeTZE6cWkGRRUSWbUw9j7sWe+2STdxw
 CyOrUfkq4n3XjS8XqVBGs7284oF1xbTYY+dIm/exVAPf1zIGzqe1P8vngexrk6bJNMUAuwmx8
 UVQoMbJZKzmrvVUBjjR7bAUJRYYHY3ogu0ek1rI2i6Zjr4/IXH00lIARXGQos7QHiJQ0UBAfy
 XVb9moMBU54T0+b24JmVCnP2dJqEeAUd+Qxb3Fzd+7pL5M9JSdK0oznBBW+w=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nCELHWhO0sjX4IKiC1b3mDaaohDjOHH04
Content-Type: multipart/mixed; boundary="yUUkQaitqT81QfcBEl980HSpJunNATlVr"

--yUUkQaitqT81QfcBEl980HSpJunNATlVr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/21 =E4=B8=8B=E5=8D=886:47, Christian Pernegger wrote:
> [Please CC me, I'm not on the list.]
>=20
> Am So., 20. Okt. 2019 um 12:28 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
>>> Question: Can I work with the mounted backup image on the machine tha=
t
>>> also contains the original disc? I vaguely recall something about
>>> btrfs really not liking clones.
>>
>> If your fs only contains one device (single fs on single device), then=

>> you should be mostly fine. [...] mostly OK.
>=20
> Should? Mostly? What a nightmare-inducing, yet pleasantly Adams-esqe
> way of putting things ... :-)
>=20
> Anyway, I have an image of the whole disk on a server now and am
> feeling all the more adventurous for it. (The first try failed a
> couple of MB from completion due to spurious network issues, which is
> why I've taken so long to reply.)
>=20
>>> You wouldn't happen to know of a [suitable] bootable rescue image [..=
=2E]?
>>
>> Archlinux iso at least has the latest btrfs-progs.
>=20
> I'm on the Ubuntu 19.10 live CD (btrfs-progs 5.2.1, kernel 5.3.0)
> until further notice. Exploring other options (incl. running your
> rescue kernel on another machine and serving the disk via nbd) in
> parallel.
>=20
>> I'd recommend the following safer methods before trying --init-extent-=
tree:
>>
>> - Dump backup roots first:
>>   # btrfs ins dump-super -f <dev> | grep backup_treee_root
>>   Then grab all big numbers.
>=20
> # btrfs inspect-internal dump-super -f /dev/nvme0n1p2 | grep backup_tre=
e_root
> backup_tree_root:    284041969664    gen: 58600    level: 1
> backup_tree_root:    284041953280    gen: 58601    level: 1
> backup_tree_root:    284042706944    gen: 58602    level: 1
> backup_tree_root:    284045410304    gen: 58603    level: 1
>=20
>> - Try backup_extent_root numbers in btrfs check first
>>   # btrfs check -r <above big number> <dev>
>>   Use the number with highest generation first.
>=20
> Assuming backup_extent_root =3D=3D backup_tree_root ...
>=20
> # btrfs check --tree-root 284045410304 /dev/nvme0n1p2
> Opening filesystem to check...
> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> bad tree block 284041084928, bytenr mismatch, want=3D284041084928, have=
=3D0
> ERROR: cannot open file system
>=20
> # btrfs check --tree-root 284042706944 /dev/nvme0n1p2
> Opening filesystem to check...
> checksum verify failed on 284042706944 found E4E3BDB6 wanted 00000000
> checksum verify failed on 284042706944 found E4E3BDB6 wanted 00000000
> bad tree block 284042706944, bytenr mismatch, want=3D284042706944, have=
=3D0
> Couldn't read tree root
> ERROR: cannot open file system
>=20
> # btrfs check --tree-root 284041953280 /dev/nvme0n1p2
> Opening filesystem to check...
> checksum verify failed on 284041953280 found E4E3BDB6 wanted 00000000
> checksum verify failed on 284041953280 found E4E3BDB6 wanted 00000000
> bad tree block 284041953280, bytenr mismatch, want=3D284041953280, have=
=3D0
> Couldn't read tree root
> ERROR: cannot open file system
>=20
> # btrfs check --tree-root 284041969664 /dev/nvme0n1p2
> Opening filesystem to check...
> checksum verify failed on 284041969664 found E4E3BDB6 wanted 00000000
> checksum verify failed on 284041969664 found E4E3BDB6 wanted 00000000
> bad tree block 284041969664, bytenr mismatch, want=3D284041969664, have=
=3D0
> Couldn't read tree root
> ERROR: cannot open file system

This doesn't look good at all.

All 4 copies are wiped out, so it doesn't look like a bug in btrfs, but
some other problem wiping out a full range of tree blocks.

>=20
>>   If all backup fails to pass basic btrfs check, and all happen to hav=
e
>>   the same "wanted 00000000" then it means a big range of tree blocks
>>   get wiped out, not really related to btrfs but some hardware wipe.
>=20
> Doesn't look good, does it? Any further ideas at all or is this the
> end of the line? TBH, at this point, I don't mind having to re-install
> the box so much as the idea that the same thing might happen again --

I don't have good idea. The result looks like something have wiped part
of your tree blocks (not a single one, but a range).

> either to this one, or to my work machine, which is very similar. If
> nothing else, I'd really appreciate knowing what exactly happened here
> and why -- a bug in the GPU and/or its driver shouldn't cause this --;
> and an avoidance strategy that goes beyond-upgrade-and-pray.

At this stage, I'm sorry that I have no idea at all.

If you're 100% sure that you haven't enabled discard for a while, then I
guess it doesn't look like btrfs at least.
Btrfs shouldn't cause so many tree blocks wiped at all, even for v5.0
kernel.

Thanks,
Qu

>=20
> Cheers,
> Christian
>=20


--yUUkQaitqT81QfcBEl980HSpJunNATlVr--

--nCELHWhO0sjX4IKiC1b3mDaaohDjOHH04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2tjrcACgkQwj2R86El
/qi+YAf9GvInurVNaYpiDk/zN5181q/aH41Ku0RfeJ3LJNHowXSy0aT2s/VXwVpW
BxncIQ36IfbW+Ol4Ar1jM2MS8HeaKrLHfH648f9VBo6CoRa7uCF6FZ2uCf5dCBB4
YgBMGBNRsR/20JtDKietoTNlrnPEr07mFWrcJTL85Pa7fbpBOp2vmnOqcfOtt9j8
z6+mcovQsUXc3dPsjLJgwvqXX515LRSn9KogkXATxggFQ5+DKjJAW2Wtqz00zxzC
+zx8R/Z0tAtqUU4SD7yg85NvH+B1zeqBGedY3Y/5TJ7lu7feZA1PMXx4Ik42vA8z
SC2nIvE6bGx6v3f976f0CiXjJRApQw==
=+aEt
-----END PGP SIGNATURE-----

--nCELHWhO0sjX4IKiC1b3mDaaohDjOHH04--
