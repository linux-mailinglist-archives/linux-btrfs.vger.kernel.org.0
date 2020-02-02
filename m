Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594C014FAFF
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 01:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBBAAn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 19:00:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:46267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgBBAAm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Feb 2020 19:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580601640;
        bh=rbxfVLUrLCAGc+Wu+hkLWMU8iT4GUT6RxQ50vYu3BJM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=La4YUiFfc8h5AL5+jztPJgRE2fTY+3lnCG0RL7Rymdgnj4CWplf8SWljm5Mqtw9hF
         FqkFCK+QIZILqxQ2bju9cyucKNTpbDTgaY3Bi61dH3wOMZr+mKkQDueI4wLq5cjU/z
         NJ9Ch5g0QnJBw0EP6rnlyTRd2ExdTyer4kSDoOSI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M89Gj-1itLrf0gUd-005Hs4; Sun, 02
 Feb 2020 01:00:40 +0100
Subject: Re: btrfs wrongly reports 0 space available in 5.4.15
To:     Marc Lehmann <schmorp@schmorp.de>, linux-btrfs@vger.kernel.org
References: <20200201204031.GA4203@schmorp.de>
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
Message-ID: <f12a2aee-f160-e452-cbba-319c8e5d3259@gmx.com>
Date:   Sun, 2 Feb 2020 08:00:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200201204031.GA4203@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Vk4y9i4wrZRl1UwV4vYE8mtzPGt0B4Z9H"
X-Provags-ID: V03:K1:fm3qubsDC7JxdQHhwn50gIdSyxlFoXOuKLiyVANn6L399RIC2we
 kxks+zP6cWeQuJok+Dy8SPaT1AsIyP8WehBjh6HTwWBYSfQBK/uhU1FA4UVg87PAk6mGYrE
 9TeNgbwBw/hPfv9vBgFFyXibGNtZvsSX1PVMRzHNTODDAAHabh6YwXsk36sun36bHMqvKNX
 9OTHspwzMCAwS2HSCkwWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eEfgJRCfQ9Q=:jr/i+2XL7vFWL0MKEEOwlD
 IHj+mxKWZbqmmHZgiAI09L+DDb5yXfKu8+Ts4e0GNNvr3+g5Nx+U1UpcufFQMphoZ0QIk2eW+
 4rpIGDYnDS6waHOJysUryxnHGhL869s3My+s/t8fOXvuIduFRR/zl1HqOjRrJ+iKwAbPK/dUC
 wwZCjs+0sGigijYRfz1utPIkg69BOOQBBrLpsZJoIG75Ltvp8TO6GqiqHYNtwGtGblqs/teXm
 qpW1knNSCOVC8/sbBjbzIo4FhmzBFh+ZEAiMc7bYNqlfha9iRE/+rptL4S+Mp9upKvztcmWca
 Hi0G7QtZFHp/q8SBPRKLqASBHnq/eMsJRFQXlJjv6dKe8bf8QkJKmJZCSud89QFWYr2K7sAMg
 t9etG2Fyeuo1OtTAp4ucyu0pxkayzQ97cDtg+Iio3PaJo6xkspryGf6pfocv+XjoLGgEnamlb
 b5XM3sGprjGVugRajwzoLVgEc/rCJSsKHUon13y4sk7zCPuVRlGtxr3AdN5/NNB/SQCHE4fFL
 c7ZygKv6knT1FqPyNBX+xtU1r5a1IPgk80TXrDXawc9/2Zhz2cMIja4GYC8Stn5x+/S5O0lee
 LgVAwr5YQg8H3Zlgd4xwr7Fgbw67JSm1ugihqHc6k20ZSs7uCp+sQ7g3ythnn5eMcrmTdbUKZ
 8ujqyCDzkencSWxOjHeRQoNnjrWdOX6+7TCl1IH42yaevv6+yQByW7qDZv7b65QmeUqAbYaMF
 B/MIfocRheX4jP6pluRAEwPRcyDdlROovrGukhvDQqrQID9yK4Gs77zfHbTArf7cVr2jUURzx
 he6dEtx1a1SGdsSLqerM5IIAzyLbXE2jIc5H3ashAgcfKSN37sjvqqqeXmyrLCiCHeudAb20c
 8Q/HyrHisfK6PIC1E6NEvV51YHIZYHt94RjEqmTioap/gCszbUgdKz2ULrJrUCc3RkSpSFPJ0
 +2u69Vi+W8/0W/FduajFgpL8B4vWWb4887vZrjNRVn4btQZyxZSkWaL7v4TIeRB9pbEMsZ05K
 41EwwA3Ua1+n9uUZSH2km1RIfvgRCm+9I3/J1u2BOYVPdu4neF0fsTwCh/yyhKcl2ETB77Db/
 CH31bIPEAaXoFBD0Q0YWhxAOufPUPoYahoRdiZWKjwbPdCV22K34pVEYlIuRzmAJgO+T/W5z2
 vEcHmC0d3oWSuaBwGMqZPlRAX2JZT6pE0IXA2B9Ze5//9D7I/7eDC6HBELjb4ysuznLnWpElQ
 rgrKoUbabXdswzlco
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vk4y9i4wrZRl1UwV4vYE8mtzPGt0B4Z9H
Content-Type: multipart/mixed; boundary="Z4Ubd1X6gVANje86qA1T6PcTZ0LEUjeDw"

--Z4Ubd1X6gVANje86qA1T6PcTZ0LEUjeDw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/2 =E4=B8=8A=E5=8D=884:40, Marc Lehmann wrote:
> Hi!
>=20
> I upgraded one machine from 5.2.21 to 5.4.15, and one (freshly-created)=

> btrfs filesystem wrongly shows 0 avail in df after writing a bit of dat=
a:
>=20
>    Filesystem               Size  Used Avail Use% Mounted on
>    /dev/mapper/vg_ssd-data  6.5G  160M     0 100% /ssd
>=20
> When at the same time, the filesystem should claim gobs of free space
> (the df output corresponds to a time a bit earlier when not all data wa=
s
> written yet):
>=20
>    Overall:
>        Device size:                           6.00GiB
>        Device allocated:                      0.63GiB
>        Device unallocated:                    5.37GiB
>        Device missing:                        0.00GiB
>        Used:                                  0.22GiB
>        Free (estimated):                      5.77GiB      (min: 5.77Gi=
B)
>        Data ratio:                               1.00
>        Metadata ratio:                           1.00
>        Global reserve:                        0.00GiB      (used: 0.00G=
iB)
>=20
>    Data,single: Size:0.62GiB, Used:0.22GiB
>       /dev/mapper/vg_ssd-data         0.62GiB
>=20
>    Metadata,single: Size:0.01GiB, Used:0.00GiB
>       /dev/mapper/vg_ssd-data         0.01GiB
>=20
>    System,single: Size:0.00GiB, Used:0.00GiB
>       /dev/mapper/vg_ssd-data         0.00GiB
>=20
>    Unallocated:
>       /dev/mapper/vg_ssd-data         5.37GiB
>=20
> This didn't happen under 5.2.21 for me, obviously.
>=20
> Deleting some files makes the remaining space appear again, creating
> them again changes to 0 free. I retried with a 76G partition but had
> essentially the same results.
>=20
> Only df output seems affected, the fs is still writable (I only realize=
d
> because apt told me the disk was full - the fs only stores apt package
> lists and the apt cache).
>=20
> When writing, this switch to 0 free happens suddenly (example with bigg=
er
> partition):
>=20
>    /dev/mapper/vg_ssd-data   76G  3.9M   76G   1% /ssd
>    /dev/mapper/vg_ssd-data   76G  3.9M   76G   1% /ssd
>    /dev/mapper/vg_ssd-data   76G  122M   76G   1% /ssd
>    /dev/mapper/vg_ssd-data   76G  201M     0 100% /ssd
>    /dev/mapper/vg_ssd-data   76G  244M     0 100% /ssd
>=20
> Mount options are noatime,nossd,discard.
>=20
> I see there were multiple reports for this and some discussion in decem=
ber
> (https://www.spinics.net/lists/linux-btrfs/msg95694.html), but apparent=
ly
> nothing came of it and the bug still persists.
>=20
The discussion on how to fix it has finally settled down.
https://patchwork.kernel.org/patch/11359995/

Will be backported to related stable trees.

Thanks,
Qu


--Z4Ubd1X6gVANje86qA1T6PcTZ0LEUjeDw--

--Vk4y9i4wrZRl1UwV4vYE8mtzPGt0B4Z9H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl42ESUACgkQwj2R86El
/qjaEAf/djoXqNEnYsKtQchfK+6I+Vqxxjun0vuh/uK5lVeT50/7+IpyUxdrcQ+3
oPU2qE5LNP3oavQahxmnz7Q0uH5UN3Om6PVqt/CX/LMeOUoHA8hUGx7s1g4edTIx
x2ftNU5NWhwRND7KzYjvsD52gQZiWpWzyrqz6w+LwfH/5MWUVnwZTp7jpLN7eNZR
E2MYphNoQvGoAC3jKqAWcwJuRHfigFB1cStrZnMJE1PjHmNrRYETiesQlBdfld5b
2xhFZ1mk9AMNfxCfrbgUreVOYefoT3ngWscYckQYrwTtKyoz3DvvZbWy4AOSB8m0
ZCXB+MHecnGVgemUeJANpelloXzjTw==
=iw3A
-----END PGP SIGNATURE-----

--Vk4y9i4wrZRl1UwV4vYE8mtzPGt0B4Z9H--
