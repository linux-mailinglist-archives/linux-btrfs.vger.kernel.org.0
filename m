Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54415892E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 05:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBKEeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 23:34:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:36935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgBKEeG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 23:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581395635;
        bh=Xity79G6FkQOaAt+8CsK3URi2a4M3a31e2hqNmwmGMU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ArZirBsVyyMnRX6Zc2QLZcqbg76HBOPRBpd8eb4xgJ3pLWeauIklOwQHgttGXJc1l
         XI+ezFJgBDUpbRWFxAYvPTC9rDRhg5Ar6C9O3TXLa8x8ugSwdxe+BJ0n6Oo8dLKPLs
         Pi792V5vZXA2tYSa3XP2jgMrtGT9Qe4HMV6OOQAU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7iCW-1jVoBM0bxK-014jgn; Tue, 11
 Feb 2020 05:33:55 +0100
Subject: Re: [PATCH 1/4] btrfs: backref, only collect file extent items
 matching backref offset
To:     ethanwu <ethanwu@synology.com>, dsterba@suse.cz,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-2-ethanwu@synology.com>
 <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com>
 <c0453c3eb7c9b4e56bd66dbe647c5f0a@synology.com>
 <20200210162927.GK2654@twin.jikos.cz>
 <5901b2be7358137e691b319cbad43111@synology.com>
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
Message-ID: <aeb36a34-bc9c-8500-9f36-554729a078fc@gmx.com>
Date:   Tue, 11 Feb 2020 12:33:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <5901b2be7358137e691b319cbad43111@synology.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yHHmPZgJ8Hnt1vaoTFNyMnNFatMZaJE3q"
X-Provags-ID: V03:K1:RfCiDEk7sh1LA+JgXLIsppp1b4Vbf97PiuDrhYyysrC0HYQBidF
 VWw4+lAO0dfDX/a+Euhg6j08S4NgtCK8sCKU+WS8EyP+2BFtZp62aG3oE0k0vueAUaovzB1
 fybXaax7FQNqAwxmd1poPJi7gh04QpV406dlnKhxNBXHN+v5tFW82uUdI0Y4LAqEbAD5XLQ
 t/jR3EseI2RHx16C8i1+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dNzvPSWPs3g=:Waqhmss7CSsSXT38QYYL5g
 PsQxKzVN49Ih3M8YrVRh8yOCytNn2ugNTUMEQH3QLRLUWNpi2ys1e0Kdgf99CGzaGAPSaose+
 OJSz3hACcgJtglvEYS/5pUABKRmJ7IYoe6ZTpkE3yJYYEylAdjmouhiWguwomv5oGYGxwyxu5
 tfdRIxYamMbRyhyHtezCK2FotQ4VyyAMrCBH32WsHFOQ2lFMS3/rPmoBho7U1R3hcGk2gWsqA
 q4MLDgw50ypZihldruOGOh0DrmHIdk+VuN4E8O7uO1vcBTFlN0MhJyZLuPKzkWXPs7m1LwCM/
 kFYosK9LWpEUQD3VKwrXQxTIFuJesLyQvXnn07hFq9YZexfQIgw3Jazu03GbaCkQV536g7tIS
 MHd7L/zpGOou2cDyw0VLKiAmbuAqZva9Oc9tcIpzqa519spg5W7oRtFk8oc+UASXF2+T0nIE/
 2mQv0nIkDexrynfFGZYUrr/lDIiatymr44NS7QvIH2hJfxtv7Ltr8QfD+7mPprA04f21lXi4X
 6FVbBsg1lalyBjt5udoNYwYMUc9cE68IowVdEo4jLgihFAcTnWYbDDYItnXQFDkBdlZ2kXM17
 NqLDmxh965gmPWIcLlNKNsUfGiQZomreuCRfj4b8RqK5izQZamTN57uQqPY059HcRGRQEjnVj
 AFesJXfUjD6s3zBZSEiaLWxLPiV+RUdCG6APi600QDDytWDqps2sUB+5IfYdevgbi8UzZf+GJ
 IQv46mq0Oe0VRuwy2wJuPAd7suwGBpS5QQYkSfaJIhMATNbbH18iO4b5ODJeJp9tad2GxXu7f
 0tcvuemUOThO3tsyxM5f3O29cnj6LfKQZXjHkceuFlndvHZ/mIDP9gEam8/KrSSrPQ7LRC/iA
 NxuL+KfVcPUhDRp3DlO72qKilrSvjzMM//rqFqhykphiAELchPRsCddsIygHbWyOhQJ+Xj7Co
 Z3Kcqm31Nev92lmAAi727uUAacz86+xtALWVNibFX036jYLFPnB9EegynopAsJxS57GBEZEWv
 y6A5+kshDuFnebdkmaLZ8Wh/G2YXYbq6M/han6q1urF1T07hJ6pC2AT++ZRGnOCEjXPcNl0J6
 e7zxnZ6h3qISkmwsxRwKTNrIe1SDfB4lPDXlNvGChFRTY4LhzjtKWlfIqyP9ONzHDP28yn3xQ
 QqJY+fApN7/tZ6wkY4Zmv4M7SGpquwYHNbr3qygeSQoStXocdwiSWZdB4peUYA+dYuD3pId4I
 2sZqQHCUA0IEaZ2OD
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yHHmPZgJ8Hnt1vaoTFNyMnNFatMZaJE3q
Content-Type: multipart/mixed; boundary="I7yBtCbB2MYjc8ScVh8H9t1W43TeYmihY"

--I7yBtCbB2MYjc8ScVh8H9t1W43TeYmihY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/11 =E4=B8=8B=E5=8D=8812:03, ethanwu wrote:
> David Sterba =E6=96=BC 2020-02-11 00:29 =E5=AF=AB=E5=88=B0:
>> On Mon, Feb 10, 2020 at 05:12:48PM +0800, ethanwu wrote:
>>> Josef Bacik =E6=96=BC 2020-02-08 00:26 =E5=AF=AB=E5=88=B0:
>>> > On 2/7/20 4:38 AM, ethanwu wrote:
>>> >> When resolving one backref of type EXTENT_DATA_REF, we collect all=

>>> >> references that simply references the EXTENT_ITEM even though
>>> >> their (file_pos- file_extent_item::offset) are not the same as the=

>>> >> btrfs_extent_data_ref::offset we are searching.
>>> >>
>>> >> This patch add additional check so that we only collect references=

>>> >> whose
>>> >> (file_pos- file_extent_item::offset) =3D=3D
>>> btrfs_extent_data_ref::offset.
>>> >>
>>> >> Signed-off-by: ethanwu <ethanwu@synology.com>
>>> >
>>> > I just want to make sure that btrfs/097 passes still right?=C2=A0 T=
hat's
>>> > what the key_for_search thing was about, so I want to make sure we'=
re
>>> > not regressing.=C2=A0 I assume you've run xfstests but I just want =
to make
>>> > doubly sure we're good here. If you did then you can add
>>> >
>>> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>>> >
>>> > Thanks,
>>> >
>>> > Josef
>>>
>>> Thanks for reviewing.
>>>
>>> I've run the btrfs part of xfstests, 097 passed.
>>> Failed at following tests:
>>> 074 (failed 2 out of 5 runs),
>>> 139, 153, 154,
>>> 197, 198(Patches related to these 2 tests seem to be not merged yet?)=

>>> 201, 202
>>>
>>> My kernel environment is 5.5-rc5, and this branch doesn't contain
>>> fixes for tests 201 and 202.
>>> All these failing tests also failed at the same version without my
>>> patch.
>>
>> I tested the patchset in my environment and besides the above known
>> and unrelated failures, there's one that seems to be new and possibly
>> related to the patches:
>>
>> btrfs/125=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [18:18:14][ 5937.333021] run fstests btrfs/125
>> at 2020-02-07 18:18:14
>> [ 5937.737705] BTRFS info (device vda): disk space caching is enabled
>> [ 5937.741359] BTRFS info (device vda): has skinny extents
>> [ 5938.318881] BTRFS: device fsid e34ea734-aeef-484b-8a5b-d061e3bad8c5=

>> devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (21913)
>> [ 5938.323180] BTRFS: device fsid e34ea734-aeef-484b-8a5b-d061e3bad8c5=

>> devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (21913)
>> [ 5938.327229] BTRFS: device fsid e34ea734-aeef-484b-8a5b-d061e3bad8c5=

>> devid 3 transid 5 /dev/vdd scanned by mkfs.btrfs (21913)
>> [ 5938.344608] BTRFS info (device vdb): disk space caching is enabled
>> [ 5938.347892] BTRFS info (device vdb): has skinny extents
>> [ 5938.350941] BTRFS info (device vdb): flagging fs with big metadata
>> feature
>> [ 5938.360083] BTRFS info (device vdb): checking UUID tree
>> [ 5938.470343] BTRFS: device fsid e34ea734-aeef-484b-8a5b-d061e3bad8c5=

>> devid 2 transid 7 /dev/vdc scanned by mount (21955)
>> [ 5938.476444] BTRFS: device fsid e34ea734-aeef-484b-8a5b-d061e3bad8c5=

>> devid 1 transid 7 /dev/vdb scanned by mount (21955)
>> [ 5938.480289] BTRFS info (device vdb): allowing degraded mounts
>> [ 5938.483738] BTRFS info (device vdb): disk space caching is enabled
>> [ 5938.487557] BTRFS info (device vdb): has skinny extents
>> [ 5938.491416] BTRFS warning (device vdb): devid 3 uuid
>> f86704f4-689c-4677-b5f2-5380cf6be2d3 is missing
>> [ 5938.493879] BTRFS warning (device vdb): devid 3 uuid
>> f86704f4-689c-4677-b5f2-5380cf6be2d3 is missing
>> [ 5939.233288] BTRFS: device fsid 265be525-bf76-447b-8db6-d69b0d3885d1=

>> devid 1 transid 250 /dev/vda scanned by btrfs (21983)
>> [ 5939.250044] BTRFS info (device vdb): disk space caching is enabled
>> [ 5939.253525] BTRFS info (device vdb): has skinny extents
>> [ 5949.283384] BTRFS info (device vdb): balance: start -d -m -s
>> [ 5949.288563] BTRFS info (device vdb): relocating block group
>> 217710592 flags data|raid5
>> [ 5949.322231] BTRFS error (device vdb): bad tree block start, want
>> 39862272 have 30949376
>> [ 5949.328136] repair_io_failure: 22 callbacks suppressed
>> [ 5949.328139] BTRFS info (device vdb): read error corrected: ino 0
>> off 39862272 (dev /dev/vdd sector 19488)
>> [ 5949.333447] BTRFS info (device vdb): read error corrected: ino 0
>> off 39866368 (dev /dev/vdd sector 19496)
>> [ 5949.336875] BTRFS info (device vdb): read error corrected: ino 0
>> off 39870464 (dev /dev/vdd sector 19504)
>> [ 5949.340325] BTRFS info (device vdb): read error corrected: ino 0
>> off 39874560 (dev /dev/vdd sector 19512)
>> [ 5949.409934] BTRFS warning (device vdb): csum failed root -9 ino 257=

>> off 2228224 csum

This looks like an existing bug, IIRC Zygo reported it before.

Btrfs balance just randomly failed at data reloc tree.

Thus I don't believe it's related to Ethan's patches.

Thanks,
Qu

>=20
> Hi,
> I've rebased my kernel environment to the latest for-next branch,
> xfstests is updated to latest as well.
> Test 125 still passes many times without even one failure.
>=20
> here's my local.config
>=20
> export TEST_DEV=3D/dev/sdc
> export TEST_DIR=3D/mnt/test
> export SCRATCH_MNT=3D/mnt/scratch
> export FSTYP=3Dbtrfs
> export SCRATCH_DEV_POOL=3D"/dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh=
"
>=20
> each device has 80GB capacity.
>=20
> Besides, LOGWRITES_DEV is not set and CONFIG_FAULT_INJECTION_DEBUG_FS
> is turned off, but both seems to be unrelated to 125.
>=20
> thanks,
> ethanwu
>=20
>=20
>=20
>=20


--I7yBtCbB2MYjc8ScVh8H9t1W43TeYmihY--

--yHHmPZgJ8Hnt1vaoTFNyMnNFatMZaJE3q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5CLqwACgkQwj2R86El
/qgaiggAnX8USgMgy/ZUtchMc3R37qSWZkKZ0N6sUwrwe8dqIi3qc3VOT+OIl2nu
KGPA4Mydnw3S9F0iVfxcQByLtkyMLNn0olCJ2/cHn351yeT6PG/0Bpjb+2LmS3JM
DfX7bf90mrsIS1j7+rLK9DWaBnirryBz3VKMYG7m/JyJchO0Dk7MUbZY7/MduAGO
59TageRpjrzTwO/nKEOP0omYR14gKtL9a8uOHiu8CogHd6uTuKovXCPpqFSbgdCy
kbOzfUJLFs3zb2/xF/wpdT4+I29KHjrjLb8yMAcqfy37v6OrqmDFrHAJEMSSS3Mn
ir2cxKAzS7kExCcREgSZt1FZ5quKMw==
=Vc/e
-----END PGP SIGNATURE-----

--yHHmPZgJ8Hnt1vaoTFNyMnNFatMZaJE3q--
