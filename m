Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C72F3CC67
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 15:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389765AbfFKNCn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 09:02:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:40157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388131AbfFKNCm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 09:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560258159;
        bh=1trd7g2904ZDJrb3V0Sk1/GVo8UziirTzRV2uSEPOnU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WybriPHBrZpcSwmu/2eNRDWtZcDK63glzMeivCzJ3RY1k9A2ITqrEga4+gVzo/r6U
         hFPmxVw2BXIcLEFTvzw68qCeZj+Tk7gbWKtEpOtBsT16d62q1fAps8dCXKHkBNwaIJ
         BCNMy0/guMUi1BYtthGUUWXXI9AdJ0QeDl3wEkVo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp9Y-1h2dnO0bG8-00Y9tU; Tue, 11
 Jun 2019 15:02:39 +0200
Subject: Re: BTRFS recovery not possible
To:     claudius@winca.de, linux-btrfs@vger.kernel.org
References: <75a6f0280fb5829b0701f42c24a2356e@winca.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <6a72487a-4f21-2c58-df50-b0f5c3aef856@gmx.com>
Date:   Tue, 11 Jun 2019 21:02:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <75a6f0280fb5829b0701f42c24a2356e@winca.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ogbgzhd3pq58urGMeRsD89x62Rf55UxDV"
X-Provags-ID: V03:K1:Dc9CQ3aqMgo9EOVthHhcUr8kP3YDZcktmYisJxAtIfUzW6Velzz
 7gkHzvAQsbYb3ZiujCaJYiOQLx7NJ8tcOwHUSALDCR6xa1vsm8dQrG9PEclrSWchrMbFHvt
 rMpN7CvEvQv8tW7Ud4nKlAr8Qup/wY2DOZn9yb6vcAFbDjASk9BX4OEmyRcEBSxY2vfYjv4
 Eotlb84PIl6cs7mw12tWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GAPIvFzDooU=:nmhgkDnRDE96Yzk+Ohg3Sa
 Xm6Cs4g3fJiSDulZNLt1jAGeQcMuGuwL68LR9YLUh8RlR7r6E87NrAVql8J5zWbpWF2sLuk6Q
 d0zF4BB31iby6Bs82CRint3b5Mk4XHaVx2daCou/a0efAhuyQCe4uFBQzSTNvdRAOFCFOlOVI
 DBDAj1k6mOuY4vsOQJYHkOUBCAAIpsq2FiIzBYR3j5e9x9doSddzmhYWWj/ruAs8WvAMGDxMo
 5ljoFiSuvu0Hwdf9KyxKofOLfTmspGgxbGjnAqhzVB8Kf0Jvgu1jVoxCVilHyzphpYKKEH1ea
 zOIQg/Er5v2fcldLkm0cZwtOAjs+lDN7hanAXYCJcGuddKQlXvmsIFz6SnxugYiOC3kFQOXr8
 uFOtaNiFYqD3U7CAWrS/bDy/pDgxHfOMeAocR919QEe/01T3BbHEKpBjncSnezJZQy+c8na7J
 GqaFNjxOhQqefTR/RcixECC1YHwoMc53q/+F57Ie5Zvce72U6CsIZjlla2R6H/Poo/HIeJxLH
 7wGJbZ10BmZRi5y3gFCbDqNx8nwP1xxpCHizlf6M76fnbpTzhKatbNfyO2NDJQjBPA5/oy3RR
 3XSRUcsqU2Dp1GQU1sJhlfj3gbhBCh84/v7m4hf4qLwmwyefBA28fZgYp/6BhfzHzs+g9lDn2
 E74u1ONzf31uAa/3f7U/0NhjdNp38HTsIKD2dA8E3m7Do4BimTEdas7mpkkwRaaLjSGABR/HP
 LjjmlFLATWBflmKWNaFr5XgB2bUYqnB+0JXtqXwo2x5CyuUdY0g6iGS8PcC5Ry6Wx67EWPo8D
 q/cey7dTwCqGX1bhp2U/tiImwJp4ZLvKlWsKLXlBlAQfOMR4Nkv1NLGIY281v/5BrqcZoocGK
 0cqyngWGNgl3IgGigeTb5rgwAE8Srp55R3buyUPYdMmHxm8bSwIV1FcKJsDtQewp6hBMF1QD3
 CHTH0B5iAPDvJIFbYHyRwcVyITwe3/a8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ogbgzhd3pq58urGMeRsD89x62Rf55UxDV
Content-Type: multipart/mixed; boundary="gOj5nHG6e0Tf7sMnJrVDRVTMcfQ5IDpiH";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: claudius@winca.de, linux-btrfs@vger.kernel.org
Message-ID: <6a72487a-4f21-2c58-df50-b0f5c3aef856@gmx.com>
Subject: Re: BTRFS recovery not possible
References: <75a6f0280fb5829b0701f42c24a2356e@winca.de>
In-Reply-To: <75a6f0280fb5829b0701f42c24a2356e@winca.de>

--gOj5nHG6e0Tf7sMnJrVDRVTMcfQ5IDpiH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/11 =E4=B8=8B=E5=8D=886:53, claudius@winca.de wrote:
> HI Guys,
>=20
> you are my last try. I was so happy to use BTRFS but now i really hate
> it....
>=20
>=20
> Linux CIA 4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC 2019=

> x86_64 x86_64 x86_64 GNU/Linux
> btrfs-progs v4.15.1

So old kernel and old progs.

>=20
> btrfs fi show
> Label: none=C2=A0 uuid: 9622fd5c-5f7a-4e72-8efa-3d56a462ba85
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes use=
d 4.58TiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 7.28TiB used 4.59TiB path /dev/mapper/volume1
>=20
>=20
> dmesg
>=20
> [57501.267526] BTRFS info (device dm-5): trying to use backup root at
> mount time
> [57501.267528] BTRFS info (device dm-5): disk space caching is enabled
> [57501.267529] BTRFS info (device dm-5): has skinny extents
> [57507.511830] BTRFS error (device dm-5): parent transid verify failed
> on 2069131051008 wanted 4240 found 5115

Some metadata CoW is not recorded correctly.

Hopes you didn't every try any btrfs check --repair|--init-* or anything
other than --readonly.
As there is a long exiting bug in btrfs-progs which could cause similar
corruption.



> [57507.518764] BTRFS error (device dm-5): parent transid verify failed
> on 2069131051008 wanted 4240 found 5115
> [57507.519265] BTRFS error (device dm-5): failed to read block groups: =
-5
> [57507.605939] BTRFS error (device dm-5): open_ctree failed
>=20
>=20
> btrfs check /dev/mapper/volume1
> parent transid verify failed on 2069131051008 wanted 4240 found 5115
> parent transid verify failed on 2069131051008 wanted 4240 found 5115
> parent transid verify failed on 2069131051008 wanted 4240 found 5115
> parent transid verify failed on 2069131051008 wanted 4240 found 5115
> Ignoring transid failure
> extent buffer leak: start 2024985772032 len 16384
> ERROR: cannot open file system
>=20
>=20
>=20
> im not able to mount it anymore.
>=20
>=20
> I found the drive in RO the other day and realized somthing was wrong
> ... i did a reboot and now i cant mount anmyore

Btrfs extent tree must has been corrupted at that time.

Full recovery back to fully RW mountable fs doesn't look possible.
As metadata CoW is completely screwed up in this case.

Either you could use btrfs-restore to try to restore the data into
another location.

Or try my kernel branch:
https://github.com/adam900710/linux/tree/rescue_options

It's an older branch based on v5.1-rc4.
But it has some extra new mount options.
For your case, you need to compile the kernel, then mount it with "-o
ro,rescue=3Dskip_bg,rescue=3Dno_log_replay".

If it mounts (as RO), then do all your salvage.
It should be a faster than btrfs-restore, and you can use all your
regular tool to backup.

Thanks,
Qu

>=20
>=20
> any help


--gOj5nHG6e0Tf7sMnJrVDRVTMcfQ5IDpiH--

--Ogbgzhd3pq58urGMeRsD89x62Rf55UxDV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlz/pmgACgkQwj2R86El
/qgsiQf9FjWt7mleNMXGz8fFGPtkr04TL4SlMfSYL/eH00pAQuyUuyzpsGa6dIaB
aMyJrKqhpDZ1vq7hNYJwqj0ck532HJq/6kRXpqXsiSWWFB/0HCN/hiHtK4SoBCwB
dIuhEdefVAISLkVmkJYV62t4e70ob7ZHa6JvWDp4ymLRy/t/kiKwj2FxWwKnDKHk
GRrevwwhlbwGVSc7T1Qyd2aZ3t4Xv8n9KoV/V5IpzWvEmypKG+b1PKorLS9mlUT2
hCysWQs2ZWMYKt38VE+c+PMyLaPayYyo6e3zIXwzPVrhZIT4ZN81LnYPenS1bB7r
YKkSi9GD4iwErfqL3U0OzxEMqcl99Q==
=fFtI
-----END PGP SIGNATURE-----

--Ogbgzhd3pq58urGMeRsD89x62Rf55UxDV--
