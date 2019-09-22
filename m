Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 356A4BA1B5
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2019 12:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfIVKCc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Sep 2019 06:02:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:59949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbfIVKCc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Sep 2019 06:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569146545;
        bh=n43olt5KwLZ/YljwgTTkd8sJ5x3TMUNXX5Y32CukxSk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KyEfmFt5qyYvXECzpai+iIE+VRVumOUBHFh9CbO8fqo/OqJJBPAoAY6w7MurqqFom
         BcBaT4ZxRNy0qK0XlTuGnpDees0bBzr9Jl/4u8ixS7v99TLW5+lx274oJEeaMpDqtl
         fPB2Oj4r9aSmsZUEcz0f68IWYp+Ak7ZIyie9xjt4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdeX-1iNqn52TaP-00Eb6W; Sun, 22
 Sep 2019 12:02:25 +0200
Subject: Re: btrfs filesystem not mountable after unclear shutdown
To:     Kenneth Topp <toppk@bllue.org>, linux-btrfs@vger.kernel.org
References: <e9073c1dc608dc8d50ee8d131bc86887@bllue.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <aa88fe5f-51f9-cfca-6193-cc2cf0d3ead5@gmx.com>
Date:   Sun, 22 Sep 2019 18:02:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e9073c1dc608dc8d50ee8d131bc86887@bllue.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="srdVFtyFIzfZDrxnAKeMTYPOzNYq2suBJ"
X-Provags-ID: V03:K1:jGRwxLR37KlIuFcDB1ty5EIFCYSzOa+N2wXXc258kHL83xvJ2aZ
 DLVZsi/lIMkR7xnqpQ9DWpI9Ly9RlVMFVf1EtZn2I58F2JyvJNxvy4VfykvQErS6wF0Q68J
 Ue4Vm5HrfUJcKwFGUqr3m75/0NOsTQxIJqXwTmlbeLpH3kFJ89aKq+f4NPr14fLuspFIqId
 UGTB/N8HrPo/CsQ9pjr7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2pSw11zgpxo=:qQqUzVPcyRV0S2AOQjrZhC
 mceRInZufd+quc63kHf4XfE58yB0ITpqNsGQ4M+S0Vu7ZjBsQ3uBVrws3m/rDMxSHj2V+sC9L
 VvGeuEBc610YvF9/7cxLwBWN7eogTLWEGhd0PefPJPFRQnjttgFxPw8sWgJg5uJ70tyWon+6C
 PhpghkMBR7okC0UkQeG0esOffAJPb1zoCVTZ/P8X240/VNkGDvYJk9ma9Rk3g7RbvXE5UOel6
 KpU5+1hHwdsWzTjuc+/JFSZ0KA629Sh4Zm440GNyrmymKLYG3hPtnCtTis7rxeS5+22MBmoyt
 yjg03tvs8vAWGBLIHQYylaY7Qu/TZtWPNqbiFGjWuqMEO9+ICGiPOebAoS8MPVAOy4eX8+0lP
 mcrbFMAuDWRvE1zOTMi8W0XaFm1p56gkUur4bxmP51y+nkICGPDkXd0mUMtDunpNBHmS+p3PE
 1O/xs1UF34Q9n5Raw34GmKU4XPhcOXrwFjj7YtczpVMeDecBsxEUFfQoWY2gPoVzUzH/4o5EJ
 6QsxhzRgSZtYQQUCLl1l8ZjfeQ2/vA4f66Iq36t9XChO0tfPKA37J/WVzfoLodCBDfHmkqIEU
 BQCYi61VTZIuDIgl5WC6vplGUX/vHH6KcUKrPDUNDln15kkt88OEqbLKQ/IlXQjgYL0nkbxCw
 bHSZh5CZjWvrEIqZKBn085rtiDz/yDQz1mwHOGJSU07kgij08Pasylg9cEFYG0/i5Sy/8mz7y
 5pt49Joi59vkaPEGqxwqmCs7Uk6hdZh/5RExuPD5svK6Ru8heqSK0XOaOXAUX1j45xrs7wCcj
 ek0J8BqB6HZbpFrH8IrgEBSPf+CWE73kFNF9u0+j1YQHdY8/f12IN2yTvnnjfxqJ6pD3iKzT/
 mz2XT3H0UDlqr5Wr4DN6d7DMMVw//7pXNTlDOvaZRyb51brto/nb9NFERd/XLXr2LCMam4V+i
 +0G8pUoDLpo7YmwWwY7icPuG2Iw24H8QyNxuP4Ozc4XN4Q8wZ4xYrkTyEjwhAqVGFrASy+1SL
 X1IRPSv1c1PhkJvnYsZe0LT/1m6OD7kHOGAXMzr2FrM6YpoX6Uan4V/vpYiTXukZk+tnI34lV
 kbdqR2fj2GefnGf/HWP/qbb83ILuinSA2lCeE5W9jTZcBg9B4ZkcN75eC6fLGgZJao+VKBnXG
 OwLBhcDAynTZAebxrdnMhZ/+4TjIzSEYRf1+/whm/s0jQJYlldf0cM+kWoItQ358IIAktkBBw
 sKvJnLh5XpLpXfd1znagT3vP0gS9WXkOUy2UfFLDCAaOfa+X816pQL+oX8aE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--srdVFtyFIzfZDrxnAKeMTYPOzNYq2suBJ
Content-Type: multipart/mixed; boundary="j6blXezVSqWcPdJ0R2YjX3eYKDhATZntT"

--j6blXezVSqWcPdJ0R2YjX3eYKDhATZntT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/22 =E4=B8=8A=E5=8D=889:12, Kenneth Topp wrote:
> after a couple unclean reboots, this filesystem became un-mountable.=C2=
=A0
> btrfs check didn't help either.=C2=A0 This should be a raid 1 metadata/=
raid 0
> data volume.=C2=A0 I've had this filesystem for several years, but I th=
ink it
> was after any major on disk options.
>=20
> I tend to run a current kernel.=C2=A0=C2=A0 I got to 5.2.15 quickly aft=
er the
> btrfs bug report, and just was switching to 5.2.17 when things died.=C2=
=A0 I
> still have these disks as they are, but will wipe them out tomorrow and=

> restore from backups unless someone has any further diagnostics they'd
> like me to run.
>=20
> On a related subject, are there any tips for creating a new filesystem,=

> I think I used to specify "-l 16K -n 16K" during mkfs.=C2=A0 I'll be
> switching to 4kn soon, and but currently using 512e, any notes regardin=
g
> using 4kn disks?
>=20
>=20
> here are some diagnostics:
>=20
> [toppk@static ~]$ cat btrfs-failure.txt
> # btrfs filesystem show /dev/mapper/cprt-47
> Label: 'tm'=C2=A0 uuid: 2f8c681b-1973-4fe6-a6b6-0be182944528
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes use=
d 17.16TiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 9.09TiB used 8.65TiB path /dev/mapper/cprt-46
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 si=
ze 9.09TiB used 8.65TiB path /dev/mapper/cprt-47
> # btrfs check /dev/mapper/cprt-46
> Opening filesystem to check...
> parent transid verify failed on 6751397658624 wanted 2012643 found 2012=
295
> parent transid verify failed on 6751397658624 wanted 2012643 found 2012=
295
> parent transid verify failed on 6751397658624 wanted 2012643 found 2012=
295

Well, this transid mismatch looks exactly the bug introduced in v5.2-rc.

Kernel mount dmesg please, it would help us to determine which tree is
causing the problem.

But please keep in mind, we can only salvage data from the fs, not
really fix it to RW mountable status.

Thanks,
Qu

> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D7267733438464 item=3D33 pare=
nt
> level=3D2 child level=3D0
> [root@static ~]# btrfs check -b /dev/mapper/cprt-46
> Opening filesystem to check...
> parent transid verify failed on 6751304908800 wanted 2012643 found 2012=
294
> parent transid verify failed on 6751305105408 wanted 2012643 found 2012=
295
> parent transid verify failed on 6751381258240 wanted 2012643 found 2012=
295
> parent transid verify failed on 6751397658624 wanted 2012643 found 2012=
295
> parent transid verify failed on 6751397658624 wanted 2012643 found 2012=
295
> parent transid verify failed on 6751397658624 wanted 2012643 found 2012=
295
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D6751265570816 item=3D33 pare=
nt
> level=3D2 child level=3D0
> ERROR: cannot open file system
> [root@static ~]#=C2=A0=C2=A0 uname -a
> Linux static.bllue.org 5.2.17-200.fc30.x86_64 #1 SMP Sat Sep 21 16:13:2=
7
> EDT 2019 x86_64 x86_64 x86_64 GNU/Linux
> [root@static ~]#=C2=A0=C2=A0 btrfs --version
> btrfs-progs v5.2.1
>=20
>=20
> Thanks,
>=20
> Ken


--j6blXezVSqWcPdJ0R2YjX3eYKDhATZntT--

--srdVFtyFIzfZDrxnAKeMTYPOzNYq2suBJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2HRqoACgkQwj2R86El
/qh4hgf+OfQ3B6DFD4pBuklIhB+CCdQBxHZP/2lEvNsFy+59JVRpx0NGRRMfb1Gy
VwHfgdTfZYryMJJ2ed+wEo8Kh5zdNTedC24GsS44NxGYhPncq/3egJ1RH6plF6+x
gh7SWTe60yYofyw7lF/zOcbtR1mbbwH5mYNTRYvUy+qfXEGVKkMfiJMYTplFtBxZ
sXEZz47FnM0JXc/vvoQ9DLteM0lEGr8bgAVNs9PKhzjpYXDxH1jz3KP1MYuflI8W
bUMdFZiHPAEhkvgmNN4cukJnnb4ePeLYkPojbx8bMn48MHB6izX7n55+YMjoNKog
6jDiorbR1CxTXTHTj9OmecSUOGQ8ZA==
=vsvf
-----END PGP SIGNATURE-----

--srdVFtyFIzfZDrxnAKeMTYPOzNYq2suBJ--
