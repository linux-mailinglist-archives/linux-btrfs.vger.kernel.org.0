Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B0942878
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 16:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfFLOLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 10:11:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:37885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbfFLOLo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 10:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560348696;
        bh=93bemy39mbwGwaLK+WldgvwsK78R6OJuwvCr3X2LMD4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gL916Ev76DoFBH5HhFInLu8H5Ia5Z/rMi9vjMjtqKDUouuunj98hesLcibwIqJs/G
         rRqL0d/76eLxEqpLpkrLP+ScgzCJiUHClzQ4d0+LZHrQwY/tC/rTEclj7L/D5BZxs/
         sSZulvpyYO4f8bTzEqiqlN0fevgY7mWHLQhVMu94=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Ldq9D-1iJVkC3J5v-00izVi; Wed, 12
 Jun 2019 16:11:36 +0200
Subject: Re: Btrfs progs release 5.1.1
To:     =?UTF-8?Q?Tomasz_K=c5=82oczko?= <kloczko.tomasz@gmail.com>,
        David Sterba <dsterba@suse.com>
Cc:     Linux fs Btrfs <linux-btrfs@vger.kernel.org>
References: <20190611164740.14472-1-dsterba@suse.com>
 <CABB28Cx7UdEmOBOquBd8rHcCnJR4ff4AWP2P1gXnME7G0dLs4w@mail.gmail.com>
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
Message-ID: <66406cde-c497-763a-68d6-9c21673108ac@gmx.com>
Date:   Wed, 12 Jun 2019 22:11:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CABB28Cx7UdEmOBOquBd8rHcCnJR4ff4AWP2P1gXnME7G0dLs4w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tbwzmZXKpy1hnopMjDbXRifdhBAUUZPps"
X-Provags-ID: V03:K1:7GDl49HhDO5GarECN9DkFMk7C+v1RfqtlGE2f+ABDwRSv3SHIh7
 jcQaKiRZS2aINMj8egngylaqmSeqMP1vnaR+HsrtPega/nQZgx6QxOjwGru2l72vGOSQHgt
 wyp7xwbssN3LG/KTsgfPj7uFuYUxg6s/9LPL1LEkAaVQAyPz1sL/5Y14Li348GUz8q0QWof
 b6T3as0hhZ0gQ+FoYAWfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZynH6mdC1eY=:Hc0EKX4V01lih6C9rZ+hqB
 Fs2kNwefLIRxO+74BxHkLpjteOwK8tSqDYDAg0jLV1u5Zd0eBAB8cwk+Reyebi97QrVGMRApW
 xM0L5ziZHsc1Vgr0blPwLzarLzAkK9JovSDz2ksiE1sL745dnIXjGK2u/jv30qfngQuNGIBae
 GAJJE1zDP7GNQit03anEMo5oENAIcg28s3+rDaGXuZ82HhnoGF/KZBI932wn4iiNMy5hEn/H3
 zqbJO+obAXlbqCK+OPPsEEO/hFMEpAQZVY/m6VIK9birOQTUlKubZabKVAHYVjXDCvDwx9rkU
 JmXp5DWDEw3+SCgcrVo2J4+QiYLp5i+ZqqNhQPPtDe4kSM3cJ559Zh5Dt6vWp49v2ltgvTz3p
 EO2010W30e37fUbqKSH1Qpp505YekwweuRMoRonoajIKCautZlvIncRkM7IxjfGCSBIHjx7zn
 vWUJxCmBVm+lqXghN7rURI8bhblujNLgY3rkzoSms/egNJeRuH8DrG8esYsYhvTCVdM55dBgR
 uXg7tvI5MsGBEzOWt2rtNGCnPtzyD7pbhC0N7uLcscv/5MZU3Sl16WFcLlMkaW3GzFYOH5iZp
 XzNs2Ew1pTubn6p3MH21bYfg/bKIeH2RXZsyPk0g51XgsaYAzBf7r4JUxsQSsypa9OU3OJa1a
 eXtDgt9JyG8fZcggm8UWg0150x/HaSXs2zEk1nPBOZ8ljXcfcD64HiQkdnYmxn3em5pNxCph0
 FmLL22+TBwLp/AXscBAD8WOGjgvXeAKh47ZLIdqpKGQw9DU+9A9eDF/CnQW6VemwPxpVU7YHz
 SXO0dxjpjz/9KtvKcbfwQskWYzQbNAgMwaeM+edRKSiDlkintMDFBzZ/ffnyOtcTr86u1roxK
 KxzrZh/4y3gxk/wM6OTAnyqxfgv015IlQKkEq5ywO8bio7G4rEnjwJy6B9UF0Fo7+gFEs2RKG
 dJv5hzSLWJjJhGARY3DW3h/vArB8O6P4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tbwzmZXKpy1hnopMjDbXRifdhBAUUZPps
Content-Type: multipart/mixed; boundary="ijofEZg1LRkmiWTnHj8wUSEKz4MFHOyx6";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: =?UTF-8?Q?Tomasz_K=c5=82oczko?= <kloczko.tomasz@gmail.com>,
 David Sterba <dsterba@suse.com>
Cc: Linux fs Btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <66406cde-c497-763a-68d6-9c21673108ac@gmx.com>
Subject: Re: Btrfs progs release 5.1.1
References: <20190611164740.14472-1-dsterba@suse.com>
 <CABB28Cx7UdEmOBOquBd8rHcCnJR4ff4AWP2P1gXnME7G0dLs4w@mail.gmail.com>
In-Reply-To: <CABB28Cx7UdEmOBOquBd8rHcCnJR4ff4AWP2P1gXnME7G0dLs4w@mail.gmail.com>

--ijofEZg1LRkmiWTnHj8wUSEKz4MFHOyx6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/12 =E4=B8=8B=E5=8D=889:51, Tomasz K=C5=82oczko wrote:
> On Tue, 11 Jun 2019 at 20:02, David Sterba <dsterba@suse.com> wrote:
>> btrfs-progs version 5.1.1 have been released.
>=20
> Still test suite is failing for me.
>=20
> + /usr/bin/make test
>     [TEST]   fsck-tests.sh
>     [TEST/fsck]   001-bad-file-extent-bytenr
>     [TEST/fsck]   002-bad-transid
>     [TEST/fsck]   003-shift-offsets
>     [TEST/fsck]   004-no-dir-index
>     [TEST/fsck]   005-bad-item-offset
>     [TEST/fsck]   006-bad-root-items
>     [TEST/fsck]   007-bad-offset-snapshots
>     [TEST/fsck]   008-bad-dir-index-name
>     [TEST/fsck]   009-no-dir-item-or-index
>     [TEST/fsck]   010-no-rootdir-inode-item
>     [TEST/fsck]   011-no-inode-item
>     [TEST/fsck]   012-leaf-corruption
>     [TEST/fsck]   013-extent-tree-rebuild
>     [TEST/fsck]   014-no-extent-info
>     [TEST/fsck]   016-wrong-inode-nbytes
>     [TEST/fsck]   017-missing-all-file-extent
>     [TEST/fsck]   018-leaf-crossing-stripes
>     [TEST/fsck]   019-non-skinny-false-alert
>     [TEST/fsck]   020-extent-ref-cases
>     [TEST/fsck]   021-partially-dropped-snapshot-case
>     [TEST/fsck]   022-qgroup-rescan-halfway
>     [TEST/fsck]   023-qgroup-stack-overflow
>     [TEST/fsck]   024-clear-space-cache
>     [TEST/fsck]   025-file-extents
>     [TEST/fsck]   026-bad-dir-item-name
>     [TEST/fsck]   027-bad-extent-inline-ref-type
>     [TEST/fsck]   028-unaligned-super-dev-sizes
>     [TEST/fsck]   029-valid-orphan-item
>     [TEST/fsck]   030-reflinked-prealloc-extents
>     [TEST/fsck]   031-metadatadump-check-data-csum
>     [TEST/fsck]   032-corrupted-qgroup
>     [TEST/fsck]   033-lowmem-collission-dir-items
>     [TEST/fsck]   034-bad-inode-flags
>     [TEST/fsck]   035-inline-bad-ram-bytes
>     [TEST/fsck]   036-bad-dev-extents
>     [TEST/fsck]   036-rescan-not-kicked-in
>     [TEST/fsck]   037-freespacetree-repair
> failed: root_helper umount
> /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
> test failed for case 037-freespacetree-repair
> make: *** [Makefile:352: test-fsck] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.3DQ01g (%check)
>=20
> In log line I found:
>=20
> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper mount -t btrfs -o loop
> /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
> /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt
> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper fallocate -l 50m
> /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt/file
> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper umount
> /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
> umount: /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests/mnt:
> target is busy.
> failed: root_helper umount
> /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
>=20
> After test suite fails I'm able to umount it manually.
>=20
> [tkloczko@domek tests]$ sudo umount
> /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
> [tkloczko@domek tests]$
>=20
> So looks like during umount still something is holding umount.

Similar situation here, but if you're using DE or things like udisk,
it's mostly such tools affecting the umount.

For me, inside a minimal VM, without all the GUI things listening on
mounted locations, 037 will pass without problem.

Thanks,
Qu

>=20
> kloczek
>=20


--ijofEZg1LRkmiWTnHj8wUSEKz4MFHOyx6--

--tbwzmZXKpy1hnopMjDbXRifdhBAUUZPps
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0BCBMACgkQwj2R86El
/qhizwf9Gwivflxcl1HD4CAwEV+bfvaJI1r5HQs2W7Da2dO5z05lAkqU8OMdUIkj
4GRx0pboXR75eMgVT9ecsnV1rcxc2YDqXDOOB7lA9KRW+9wVLSo/eu9bLGCpS+dx
oDABlLRnBRolI1XNnkCBuZ4mY21XOb0+BHCJB5ppE5RDYL6rjD953olOxoWcs4Nj
kBmqliwi6IavwSIJTOShxDBQAzkvbgx5TNG3HlYTvLC9AACn/TWu/MOhg62GVycG
yCVkTEWpGEKJY2PEgVTE/SQilhSHkx11aMO8gxJXuy2dRGoadtsoG85FZOntMJCJ
bZDsYWwx2L2z3zVgvCixchWTK6Gr0A==
=8Py6
-----END PGP SIGNATURE-----

--tbwzmZXKpy1hnopMjDbXRifdhBAUUZPps--
