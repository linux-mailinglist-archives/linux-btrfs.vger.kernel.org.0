Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE61D76AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 14:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfJOMiq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 08:38:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:50511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfJOMiq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 08:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571143121;
        bh=FCJgmf6RJHWH6QWHKo2s68kDID9WLeO2G3acXlXKSMQ=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=VvdsZWhUN90K1tRE0/hh3F/wNSdmmlJi8pMJE1RJxwEb0wYtK3bt2k0rOMQ9XSmQL
         V+gVjm8RgmEYs9xzUJazjgxbv/dlRdkiJ0DDV/XNPYWwgqkWABIjI8CzMdKH9ZTtMo
         AaGW0pYLKvvVEuXYwreD9Z9fnBqKLXE9v//DzdLQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0JM-1heNS43vFw-00kT9S; Tue, 15
 Oct 2019 14:38:41 +0200
Subject: Re: kernel 5.2 read time tree block corruption
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     =?UTF-8?Q?Jos=c3=a9_Luis?= <parajoseluis@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
 <66e27fee-7f64-6466-866d-42464fca130f@gmx.com>
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
Message-ID: <a6d7a4c6-4295-e081-1bfc-74e9d13fd22d@gmx.com>
Date:   Tue, 15 Oct 2019 20:38:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <66e27fee-7f64-6466-866d-42464fca130f@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gZCgUPBJrI7GpG31Dmt7aC50OdipAOMF4"
X-Provags-ID: V03:K1:TFx9ndIcfSJL/vIn6RI5tgtruN6/OJFZzipbek9rNi3soL4h37/
 LFW5CfSWzihvTqYtaFbbny9UguJK4Y5t/cleASr/ZMKDS2fItBUCalwz83TYiLa3EkaygK0
 +4SvjyriXRJ3uj9fwO6pKKby9BjbVNZ73mJlxFQuKUH6UT1bJtWYCLOrr7SkTMQxyq0Fxye
 hK/yd4fa9/2A4dIQHJJ6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ubXwhK1xqXY=:m9FVg1xKGAInhp2xQjVYrB
 EE2A8oNguFVMlv8qXV2p5qwGiOpWy7EijKBcirBcFm8MRj76GXTjuCEV1s5oycM+Nt51O5yzC
 yezZQYd6Fy6gkqzLqxwPiklIxO4W0At1TroW2xObZpBH4NFuGjKNjjvcwOK2+yijk1u9Ms/Um
 RN9lngqhfXrgaVHaWqbxEWYGSbbt6LBC4Gdjb4iRH8o4cKBaI4ad3kdcgmaaeAwLmhaiis31B
 PPHNesl4hLU1X3vmQioT8f9eC3EXTQrn5GtgDx3Gn07oI0LpGPaZlfiZa6Qtminx1V67dNvdQ
 eB2hYuV5KokzV882qwcKAM3j0DcRlnibAsF5Y65k0QafVmBNIcb8ProaVNXOy+PW1v28Ed2Zs
 bxlLZ46hVYUXg6J6LgZLPvywb5cFUpnXJsPzjkpOIXwuUxTycC4u3hYVvn/ry3KgXuJR6PFvJ
 1FLethGYWb1wsAN4tBaBHwCCknLLzecLrg1Wz85MA47TarFOPD3FiXRz/yhDSjlm6576ovdAr
 FZ95Zf7PPPKzzIlEb0PShoAqorYBkwN0lyJ2jNyLzdf+UvmlUqY1wPtFKlNyf8yQOdwQoIEda
 1jwK9dn74kKuVq3vItwKBhZAc/qidK1DLkCRQSTOANOQut1e67qZU0AIkDFh4LituKL7IEDpl
 FxCgsNHTFcL1l0/+31/GL4lHDd5XPE/BOP7E5c2oVYUM8QD4wCNL4jRDr/k8Egciu3EG1szk8
 lQPLU1MM77Od6n7BBfPLxM8xykCIiPqSpkRyA++wVbM/GQRhG0uWCEIbU5hB5OOfFtbN7etua
 W0Rk28F+3nmSwsTs+8eWtehcfrxSdXZ5tYqIjJFwPXRVawcvN0sDBKo03gI/QG7o7Z23F9yW4
 bGDeR6hlYZKoNjERckbasiutliKHduKeUC2pUjlO+5+QVCqqrQG+acF7NyJZArcRGSY3J3RwJ
 NtS2Ui/BdtYqVZIoz3upjFAQb4cJEI184anLqm6TXgbjVHuBvKPiyhRxxL2caX7HAOBMMCdUr
 jM+S/1LGYKXnGg4zlEvNQEoMCDtcpsVQ2cEMcqtrEl432QPilg2Teomnrli2saUlIG+EbQ8+p
 xaaQvSujncZloTdADBw5nfabr9831qm44rfXDVtmlN8D/ELoenthocYLr9OwfVleyL4r3wZbt
 GA0mntFeHi0wM3CEbAop760znsKL6KvW0Uroq3pqJdJyrrQm4JCQQYlDvOd92llot51wo2pHc
 qufkaNRA560N5DsbqL60kyssdj4gjGImpqGRQAre0XIJEK4bttkirM4M1eOA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gZCgUPBJrI7GpG31Dmt7aC50OdipAOMF4
Content-Type: multipart/mixed; boundary="bGwsepqIVsQO9h8CSj8gAI3rrxqAGu5y8"

--bGwsepqIVsQO9h8CSj8gAI3rrxqAGu5y8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/15 =E4=B8=8B=E5=8D=888:24, Qu Wenruo wrote:
>=20
>=20
> On 2019/10/15 =E4=B8=8B=E5=8D=886:15, Jos=C3=A9 Luis wrote:
>> Dear devs,
>>
>> I cannot use kernel >=3D 5.2, They cannot mount sdb2 nor sb3 both btrf=
s
>> filesystems. I can work as intended on 4.19 which is an LTS version,
>> previously using 5.1 but Manjaro removed it from their repositories.
>>
>> More info:
>> =C2=B7 dmesg:
>>> [oct15 13:47] BTRFS info (device sdb2): disk space caching is enabled=

>>> [  +0,009974] BTRFS info (device sdb2): enabling ssd optimizations
>>> [  +0,000481] BTRFS critical (device sdb2): corrupt leaf: root=3D5 bl=
ock=3D30622793728 slot=3D115, invalid key objectid: has 18446744073709551=
605 expect 6 or [256, 18446744073709551360] or 18446744073709551604
>=20
> In fs tree, you are hitting a free space cache inode?
> That doesn't sound good.
>=20
> Please provide the following dump:
>=20
> # btrfs ins dump-tree -b 30622793728 /dev/sdb2
>=20
> The output may contain filename, feel free to remove filenames.
>=20
>>> [  +0,000002] BTRFS error (device sdb2): block=3D30622793728 read tim=
e tree block corruption detected
>>> [  +0,000021] BTRFS warning (device sdb2): failed to read fs tree: -5=

>>> [  +0,044643] BTRFS error (device sdb2): open_ctree failed
>>
>>
>>
>> =C2=B7 sudo mount  /dev/sdb2 /mnt/
>>> mount: /mnt: no se puede leer el superbloque en /dev/sdb2.
>>
>> (cannot read superblock on /dev...)
>>
>> =C2=B7 sudo btrfs rescue super-recover /dev/sdb2
>>> All supers are valid, no need to recover
>>
>>
>> =C2=B7 sudo btrfs check /dev/sdb2
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/sdb2
>>> UUID: ff559c37-bc38-491c-9edc-fa6bb0874942
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> cache and super generation don't match, space cache will be invalidat=
ed
>>> [4/7] checking fs roots
>>> root 5 inode 431 errors 1040, bad file extent, some csum missing
>>> root 5 inode 755 errors 1040, bad file extent, some csum missing
>>> root 5 inode 2379 errors 1040, bad file extent, some csum missing
>>> root 5 inode 11721 errors 1040, bad file extent, some csum missing
>>> root 5 inode 12211 errors 1040, bad file extent, some csum missing
>>> root 5 inode 15368 errors 1040, bad file extent, some csum missing
>>> root 5 inode 35329 errors 1040, bad file extent, some csum missing
>>> root 5 inode 960427 errors 1040, bad file extent, some csum missing
>>> root 5 inode 18446744073709551605 errors 2001, no inode item, link co=
unt wrong
>>>         unresolved ref dir 256 index 0 namelen 12 name $RECYCLE.BIN f=
iletype 2 errors 6, no dir index, no inode ref
>=20
> Check is reporting the same problem of the inode.
>=20
> We need to make sure what's going wrong on that leaf, based on the
> mentioned dump.
>=20
> For the csum missing error and bad file extent, it should be a big prob=
lem.

s/should/should not/

> if you want to make sure what's going wrong, please provide the
> following dump:
>=20
> # btrfs ins dump-tree -t 5 /dev/sdb2 | grep -A 7
>=20
> Also feel free the censor the filenames.
>=20
> Thanks,
> Qu
>=20
>>> root 388 inode 1245 errors 1040, bad file extent, some csum missing
>>> root 388 inode 1288 errors 1040, bad file extent, some csum missing
>>> root 388 inode 1292 errors 1040, bad file extent, some csum missing
>>> root 388 inode 1313 errors 1040, bad file extent, some csum missing
>>> root 388 inode 11870 errors 1040, bad file extent, some csum missing
>>> root 388 inode 68126 errors 1040, bad file extent, some csum missing
>>> root 388 inode 88051 errors 1040, bad file extent, some csum missing
>>> root 388 inode 88255 errors 1040, bad file extent, some csum missing
>>> root 388 inode 88455 errors 1040, bad file extent, some csum missing
>>> root 388 inode 88588 errors 1040, bad file extent, some csum missing
>>> root 388 inode 88784 errors 1040, bad file extent, some csum missing
>>> root 388 inode 88916 errors 1040, bad file extent, some csum missing
>>> ERROR: errors found in fs roots
>>> found 37167415296 bytes used, error(s) found
>>> total csum bytes: 33793568
>>> total tree bytes: 1676722176
>>> total fs tree bytes: 1540243456
>>> total extent tree bytes: 81510400
>>> btree space waste bytes: 306327457
>>> file data blocks allocated: 42200928256
>>>  referenced 52868354048
>>
>>
>>
>>
>> ---
>>
>> Regards,
>> Jos=C3=A9 Luis.
>>
>=20


--bGwsepqIVsQO9h8CSj8gAI3rrxqAGu5y8--

--gZCgUPBJrI7GpG31Dmt7aC50OdipAOMF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2lvcsACgkQwj2R86El
/qh+dgf/bAJZwscqKq/FILcmpNcEdB0d9GGjd9tNBEqD/f3biIcFsn4shSDL7vdF
zVBC+AgrSFMzPNKmhafxo7aU7hUzhHDg0a1AFcWcikxbbUXJh97Mj+kTZXyVIErQ
88UCXldRlYRV9zBOpd/zsWW0jn1PP5v4nwYi6yRJwJFfzY9U6n/eO6nBpoUXujr0
NkCYYVzGrgokVR3SjCLzjm4kb5u2LxoC8ngOz7X4qSV/FLq8dkV0gaLK+CGKF/8V
Vx7aXpc/KoOeuXyFt30SmLEDrQ1ndfQwqzAID+EMQsFIFbBvSENgggLwLUV22hPw
BFva8ASxOUP3Z/N5oxoJY4EP+LeVyg==
=vqkS
-----END PGP SIGNATURE-----

--gZCgUPBJrI7GpG31Dmt7aC50OdipAOMF4--
