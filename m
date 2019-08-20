Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D8A96DE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 01:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfHTXps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 19:45:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:41523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfHTXps (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 19:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566344746;
        bh=jmR8eNNkTRidNwL+pmm3BZhb3nTrCf4rMqrRbhywDPY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KeB0JzJ98z9OoWJfZc+vyMab+r+xUyzLbJfstnhLbUoSmAQVxcMXTgYEAIPzuGA3g
         M/3kcuTvdleuVqtEN9hRZuDmJmFB8ruaC49Gjtm//aim1le/eBc4mksiI7pSvfXVpN
         wvmy3AZcL+nuUG9qiFFR1A1Ts0mRLinP5mn83lGg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2Dx8-1iNq4N0Vd0-013gOu; Wed, 21
 Aug 2019 01:45:45 +0200
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
To:     Peter Chant <pete@petezilla.co.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
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
Message-ID: <dd6a2a4d-1f96-2b87-acee-1348cc73503e@gmx.com>
Date:   Wed, 21 Aug 2019 07:45:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0Ud833rf7D3yuNk1KeFziILV05Dm0zU1D"
X-Provags-ID: V03:K1:EqnWfjIEZ6qamYWczJs5N+4CK1Epupm/UyYrN8dQ8gWITdWBE1F
 V+qCCRNCC5FSao7yy8shsSxdTh5shnVFWdo+N1g5oZE+2aqUuifIPn1RNpNAXYxhh0PvMsw
 8rY8yJ9xrV5ExQan9VAQEf0O2fcxa04WnMblImNV7HEgjee4ptb36BFzbKAbwUQ725HrQ6p
 1jc4ba8oGtgeqapPUS5Sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EjxszmHowAk=:zaxr2sfks1fxaJHy/5lsyK
 lUzIn4n3eS0WhoZ3wLLyGbxiIAOGX65fJeK/PtnfcSUAhQ2V3TdqCdV61Yl8jvmghkLtX2jCC
 UnfJKKIrxvYCULqvCern2c/ARAKmwm9BYwLBw+0O4hhZ0g5YCug+mtvWNKphOxHF6oDQX/jZa
 v6eekFnB7ERhggSx58XzMlQcES+yAptmE5T/G0OSuYEpq0E8R6weg0FWWyej8DjDCDVaR172U
 GUFXEY82QjaTWFdQIIMvlrkAiubGFVH3kIwNewwntrh44945gvK3ZHq4P35NrCnpLM7rXJ0pk
 Fyg/IrOy8HVHE2k9Gyk7igF4RmYDERe/rMddKIxj/nveEqeyv2vVoCzJ36yz+SS4dWycm5Cef
 XLeIRG33I+BzRJO2kjTz4hT3VmiybHlTfr12uKsLjbiYtZhxE2XgMAV8dLFiEQryPejOF1XYM
 FrQzO3Se2ko1Eo2iU7x2nr2tf03256hNaYAOkFW4PbwiFjHxe/NQLiL9ofQjJQLGmN0kv67j9
 96uY5oIN4U89vQhzBowqhQ61FULPVJ5SzG9tl3/BXaG0r21cnrayy9TdQpNceRtgAb0L4Wnpt
 oxu7CZMVu+xQ+uZ9WTM0NE3ukh48gW+Wv+Zr+wzkAdVBn9XDns08Mu4zqljg8d83scOKICuro
 Vdqzu55ArXFOi65yucvqcNZcdHFpXsOuVNnxreW+2+42O+QPi4ntGzen+Yduzh9kIH0hqE7c1
 2hwsABWI5sOSNZ3oTXqpRGHVYaJGKwI3vTiKI1rsR8/eYryRGSZ1EfQSJErREjvKWJLqB1SNW
 4zPVoEH7dndYbUZt2bF/2bBz0tza+PKY1wSH9sN6sJdaVPSKLCazguIz29XgfENjVZHXG0/jk
 Eq/4hRT9r+p4mJxIRRezsKebgbiTVcQq7GeWg/nMrc+41YAB9UfTWuk6AF9xZGP51blrVb0ek
 u5EKQ4Qxyvhca8/QFdLtOsTvacCMXcpsd/ZuIYGmacM9utLioAPBU6rCMnA4OYZU3/AnO4m1p
 BkxhAWVeTBlAOu8pbc4zWVgQQ+D2YqXRvNXBoHLlPAXh6Yw8O3I7MrjXUi1aHEheZ3GHGpHwk
 YB9Qnn5CX+/X+YgkzQhm5QdRIa2rX85jGIrRazdR5JnkcRJiq7L0uXt3Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0Ud833rf7D3yuNk1KeFziILV05Dm0zU1D
Content-Type: multipart/mixed; boundary="iqfIMhILtj921wDt2ox73sBwbTL2A52sq";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Peter Chant <pete@petezilla.co.uk>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <dd6a2a4d-1f96-2b87-acee-1348cc73503e@gmx.com>
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
In-Reply-To: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>

--iqfIMhILtj921wDt2ox73sBwbTL2A52sq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/21 =E4=B8=8A=E5=8D=884:36, Peter Chant wrote:
> Chasing IO errors.  BTRFS: error (device dm-2) in
> btrfs_run_delayed_refs:2907: errno=3D-5 IO failure

Full dmesg please.

This output should include a lot of info, like stack dump and several
different error message.

One single line with least amount of info is not going to help.
>=20
>=20
> I've just had an odd one.
>=20
> Over the last few days I've noticed a file system blocking, if that is
> the correct term, and this morning go read only.  This resulted in a lo=
t
> of checksum errors.
>=20
> Having spotted the file system go read only in the logs and then noted
> the error message in the subject shortly after booting I assumed a
> hardware error and changed the SATA cable.  That had no effect so I
> isolated the disk and mounted the respective file system degraded.
> Shortly after mounting the degraded file system I had the same error
> again. So I unmounted the file system edited fstab and swapped the disk=

> which I though originally had the error with the one now showing an err=
or.
>=20
> The file system is btrfs, kernel 5.2.9, RAID 1 with three WD reds of 3,=

> 3 and 4 TB.  btrfs is on top of luks.
>=20
> The original 'blocking' behaviour seemed to manifest itself as I
> upgraded the kernel to 5.2.5 or 5.2.7 a day or two ago.  So I tried
> 5.1.21 to see if that made a difference when the error was showing.  It=

> did not.  Yesterday I had a backup with rsync, started early in the
> morning that should take minutes to complete still running 8h later wit=
h
> two CPU cores maxed.  Up until I had the file system go read only I had=

> not noticed anything amiss in the logs, but to be honest, I'd not looke=
d
> very hard.

That run delayed refs failure mostly means extent tree corruption, or
some known fixed bug.

Please run btrfs check --readonly on that fs to see if it's corrupted.
If not then it's probably some runtime bug.

Thanks,
Qu

>=20
> smartctl did not show anything amiss with the drives.
>=20
> Does this sound like a hardware error?  I have ordered a replacement
> drive, if it is not needed as a replacement I will put it into a
> homebrew NAS.
>=20
> I've hit the issue again.  Hopefully the system is up long enough to
> post this.
>=20
> I'm a bit worried that trying to track this down disconnecting a disk a=
t
> a time I might hit the btrfs split brain issue.
>=20
>=20
>=20
> Pete
>=20


--iqfIMhILtj921wDt2ox73sBwbTL2A52sq--

--0Ud833rf7D3yuNk1KeFziILV05Dm0zU1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1chiUACgkQwj2R86El
/qh5oAf+N5TXgHL5RV2Xl0VNA0lUMTzI1y13PG0vC4sGgfzSrkHyuTBGhR92Rw3C
D4wh8xor4XWkFtdPAixWv/42mZfEYE32mSUTP/T9YrCtYQTCrA4FF5fsB7tm6QOT
RF+WxWSmfcabqyXjnFkn4ecXYFJb6lybLv2b6pLAMBykzKQ282KSvKrqDqpK74X6
ywKIs4VfEK1vqI2LvervA5SYe7bZpOwM9bcHSJiTIIwtU3Q/EqEaJXS50vRpoPIQ
XA7jZNy1CX0C50R2HKOKEWQpwhE6GULRTo3j5sstm5gPljxwQ4yQnt6bnUJ5k/7T
Xi1hl4WmiOt6wPf+0j+p4ouZoxVRSg==
=pkO+
-----END PGP SIGNATURE-----

--0Ud833rf7D3yuNk1KeFziILV05Dm0zU1D--
