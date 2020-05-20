Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0097D1DC259
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 May 2020 00:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgETWux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 18:50:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:40175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728447AbgETWuw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 18:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590015049;
        bh=auVFugyi5uKOUEjndgdEj56FNzRujDdrUEu4uyLobOQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KmFzjCxxsT4POoJ/2YisYCajZ4UkJ15icoVc7elho3pVmMBMiZi7M117ZEpuqjrUt
         +6/JjKNgxOpa/qNq9j1t7OXpFllmqhPTt5c5UIitVBampZLeP/OREMQWNuV2K2TDcG
         fDkrPRxzTSEQjjHWVAJzq/qYyS4RVX+FOJcJ9Qdk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McYCb-1j32H73hOf-00d14h; Thu, 21
 May 2020 00:50:49 +0200
Subject: Re: Tree-Checker-Error on vServer-Directory
To:     joerg.ebertz@gmx.net, linux-btrfs@vger.kernel.org
References: <20200520155428.GA1810@ehud.gomer.local>
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
Message-ID: <f4ef60a7-df8b-71dc-5679-1628c0dda2ea@gmx.com>
Date:   Thu, 21 May 2020 06:50:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520155428.GA1810@ehud.gomer.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cLaHxJhgW4vjT5q9IPiXP8kUCcoiIKXsB"
X-Provags-ID: V03:K1:+cPrhd26zlf18B+z3ByudVpuozoXmFGxus0djW+uB3j5QvTzlAD
 /KHyTN0hh89AmQOZm0RGePiw/dARA79qFoZW4aE9nkSH3vQu9EWlFcKx6WgB2/oNRFo9Wql
 hrO8CO/bnP8eqnPMbsFHYY5oDEPkfNlE7kBO2O+8U8/Xjb1oSJ1YnwMoSFD47Uw86E9C1V4
 Y4QsrwtP4/W0QHk2P7zzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hwu578cFOxA=:kx2y3ys4bcnl7GiQuFlgSn
 JnKQ5ZFeDwsflfxXM15k3nNjQpS9de4RTwBpD5AjvYhjjTYqOVF19JnSNyHrfvB54YMKoA6/a
 zjSrMq0+KAg3DrMN78MFALJ5v/4qpVXn4ZQtdFLhBU7bqBA4WkPfmzzkHeg8r+87ddLaFESGQ
 qImgy0ODTYRnDZAkBdT27dLsTFRZsuvd5TYJD7rSsig4QSiigqoRurzy0tMJpzAEBURKGwHFf
 q+TGAypVQeHFw1e4yzO60V5B7AVjVZAl7cNVURtcLm/+iGaJ49zr6ADS3SqEyOVm93xCxfDdZ
 gyMuh+MShjGmPQif/Atz5HCKKPJjYCn+XkW3RR2SCoqZsjKa2psr0xVmJaB2HkhYz3Nr0JtKb
 AKiuW2QOrHi4UwB0v3Y8kwKgUpYcQMh7OFV3ugh8Iu1/iokYP9ew7KsGhHuGYm8fA8PxD60Ci
 5wBnyuTyM4EtClL0QRea+OPEOTasH7jYevWNtEjgXjgyTHlEeWGfmlKf+eQocS+SCkVppE2XJ
 PO0/jj/cy6vGMIasEV5SsxtyKCBvrUeveZHPbohG67CuqoKsBSL+8g5LZyrp8zvF8Z7nKlmXN
 JpcCyE3pTa11r3/oV5DKo4AfO2OhkueamQ1KhBpY/Eqmpb7k1vmxlmGFC3fF/hEV1HLQbSW57
 QjMXvIz9M+FuB01zCgFtfBkuMaI53Bfizc1W5K3NH8mEhvuTeBJHFBnn6QwB/rlVb8uJJ+rLf
 nIC/KEM/ADnm5WbNhdXERR6W6bt5xyW/+FRzr4i3VchNLwQrkRqvWTE2Y8Mhj0MEUNg4+6qCd
 pPun4QJmy9/P2zUQ6wqGGtuD7pplP3T5RR0KNgnMK/wbIx/KAk/0B2gvJv79gZDaL45EULmGE
 1llchHfg+6Eb8xUnjyydksKhQDCMPop6sNGejfqg8zQy5joHu4JGKiVgcYYnZp0eg32TAzojQ
 cS22RPcwCcyYlehJkG0U5FjsAe8aLpCljs0vmDpWBR2OW7WN0JefVzEXh18CvG5PbewuDuAg6
 aqpP3z+3kknuv4kTpq8n3eK6bqWCvQiGE6QYz5OUa1CVcZJjsppPKWcz4v39+oddiJVYCd6qv
 HLgVJm0KfenEhm7G2TIwr4UH/a8hpE2qImNki8vbSu+t2Ubp0BFXj8sCrCCEaEjI7/fQ3iSyO
 ynMqvRRhl+B9UBQPsTETSTxQZfy4O/S6pWeChb86kfuExorRucy/My2jM/KiEF1FApiydOTnE
 YToaR/d7+UhVuxFwp
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cLaHxJhgW4vjT5q9IPiXP8kUCcoiIKXsB
Content-Type: multipart/mixed; boundary="Gjzlg9U0zz2oX9uKsgna8LEsbOySM9noi"

--Gjzlg9U0zz2oX9uKsgna8LEsbOySM9noi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/20 =E4=B8=8B=E5=8D=8811:54, joerg.ebertz@gmx.net wrote:
> Hallo,
>=20
> https://btrfs.wiki.kernel.org/index.php/Tree-checker suggested that I
> ask here for help.
>=20
> When I run a Linux-Kernel 5.7.0-rc2, compiled with pretty much
> default configuration, and try to run
>=20
>   ls /vservers
>=20
> I get the error message:
>=20
>   ls: cannot access '/vservers': Input/output error
>=20
> From dmesg I get:
>=20
>   [912737.466820] BTRFS critical (device dm-2): corrupt leaf: root=3D5 =
block=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x200000=
0
>   [912737.466825] BTRFS error (device dm-2): block=3D350945280 read tim=
e tree block corruption detected
>   [912737.467190] BTRFS critical (device dm-2): corrupt leaf: root=3D5 =
block=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x200000=
0
>   [912737.467194] BTRFS error (device dm-2): block=3D350945280 read tim=
e tree block corruption detected

The problem is exactly what it said, the flag 0x200000 is not something
registered in btrfs.

In btrfs, valid inode flags mask is 0x800008ff. the 0x20000 is
definitely not the case.

>=20
> With kernel 5.6.9 I get:
>=20
>   [  520.285953] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.285958] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>   [  520.286234] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.286238] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>   [  520.771733] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.771746] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>   [  520.772075] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.772079] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>   [  520.778309] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.778314] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>   [  520.778656] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.778661] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>   [  520.783287] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.783292] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>   [  520.783655] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.783659] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>   [  520.788400] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.788404] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>   [  520.788745] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.788749] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>   [  520.791619] BTRFS critical (device dm-2): corrupt leaf: root=3D5 b=
lock=3D350945280 slot=3D85 ino=3D55495, unknown flags detected: 0x2000000=

>   [  520.791624] BTRFS error (device dm-2): block=3D350945280 read time=
 tree block corruption detected
>=20
> With the default kernel of Debian =E2=80=9CStable=E2=80=9D =3D =E2=80=9C=
10=E2=80=9D =3D =E2=80=9CBuster=E2=80=9D, which is
> presently 4.19.0-9 this works flawlessly.  When I booted my computer
> with grml 2018.12 ( https://grml.org/ ) with a 4.19.8 kernel, I didn_t
> have any problems either, =E2=80=9Cbtrfs check=E2=80=9D and =E2=80=9Cbt=
rfs scrub=E2=80=9D didn't find
> any errors.

Btrfs check hasn't add such restrict check yet, and btrfs scrub doesn't
check the tree contents.

Furthermore, from the bit, it looks like a memory bitflip, and it is
definitely caused in older kernels which doesn't has such comprehensive
check.

If it's a memory bitflip, it's highly recommended to run a full memtest
to ensure your memory is OK.

Such hardware problem is really hard to detect, and would definitely
cause unexpected behavior.

>=20
> Has there been a change to tree-checker, that has a problem with
> something vServer ( http://linux-vserver.org ) does?  I don't use
> vServer any more, since Debian stopped supporting it, I only keep those=

> files for reference.

Yes, in v5.2 tree-checker added extra check on inode item, in commit
496245cac57e ("btrfs: tree-checker: Verify inode item").

>=20
> I don't think that matters, but I have three SSDs in a RAID0 Array,
> on top of which there is a LUKS container which contains a LVM2
> which in turn has the BTRFS file system in one of it's LVs.
>=20
> Is there any other information You need?

No extra info needed. We'll add btrfs check support for it soon.

To recover your data, it can be done by removing the offending inodes
with older kernel.

The inode can be located using the inode number provided in the dmesg.

Thanks,
Qu
>=20
> Greeting,
> Joerg
>=20


--Gjzlg9U0zz2oX9uKsgna8LEsbOySM9noi--

--cLaHxJhgW4vjT5q9IPiXP8kUCcoiIKXsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7FtEYACgkQwj2R86El
/qjtwQf9E7bzR3lXm0pPfzi31ArqiG9AHtSAnxyiRdlttTiQGoSQ0bsTpJbpVCxC
8uGGf0ZugsguAWDGm+tUfrWeRPtT9vIxrwQDMjN046/QLcskHS6kIqfMK/xQI/Fy
4bzzxV3J+hOQACe/YQRVquTZboZGk+M+P5TQ7kfFu2ZKj82beK8nDdihb/8CIxyA
F7d15nSfiERCGiyqlR8f93EdEppHd+2XchQfq/B6GuxSkfO+nnupgPu2xGVj9HrB
sd8cv5BU/R9eQXrW37dO4h92obVNwsBRb8nOd35TBlxGwGdQA+YWPtmaGL/jnSUR
C608VHuRSZXe8CAmhn4u8emoZ0xBsw==
=UBL8
-----END PGP SIGNATURE-----

--cLaHxJhgW4vjT5q9IPiXP8kUCcoiIKXsB--
