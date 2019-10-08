Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D2FCF667
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 11:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfJHJrj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 05:47:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728866AbfJHJrj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 05:47:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8305AAC49;
        Tue,  8 Oct 2019 09:47:36 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] btrfs: Introduce new incompat feature BG_TREE to
 hugely reduce mount time
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     felix@feldspaten.org
References: <20191008044909.157750-1-wqu@suse.com>
 <c47049af-d034-0228-c61c-65187d07e6b4@suse.de>
 <80fafbd5-b459-26de-6ebb-98eeb41f2064@gmx.com>
From:   Johannes Thumshirn <jthumshirn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=jthumshirn@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <23af48db-c28b-3406-b136-c5da30884a88@suse.de>
Date:   Tue, 8 Oct 2019 11:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <80fafbd5-b459-26de-6ebb-98eeb41f2064@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SVwWnMv8QZhZOVhsDwNdrJlhtY9rmcvxJ"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SVwWnMv8QZhZOVhsDwNdrJlhtY9rmcvxJ
Content-Type: multipart/mixed; boundary="wAvvVLV6qv6R1Dg6Hu8K5bVwH7Csx86CT";
 protected-headers="v1"
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
Cc: felix@feldspaten.org
Message-ID: <23af48db-c28b-3406-b136-c5da30884a88@suse.de>
Subject: Re: [PATCH v2 0/3] btrfs: Introduce new incompat feature BG_TREE to
 hugely reduce mount time
References: <20191008044909.157750-1-wqu@suse.com>
 <c47049af-d034-0228-c61c-65187d07e6b4@suse.de>
 <80fafbd5-b459-26de-6ebb-98eeb41f2064@gmx.com>
In-Reply-To: <80fafbd5-b459-26de-6ebb-98eeb41f2064@gmx.com>

--wAvvVLV6qv6R1Dg6Hu8K5bVwH7Csx86CT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/10/2019 11:26, Qu Wenruo wrote:
>=20
>=20
> On 2019/10/8 =E4=B8=8B=E5=8D=885:14, Johannes Thumshirn wrote:
>>> [[Benchmark]]
>>> Since I have upgraded my rig to all NVME storage, there is no HDD
>>> test result.
>>>
>>> Physical device:	NVMe SSD
>>> VM device:		VirtIO block device, backup by sparse file
>>> Nodesize:		4K  (to bump up tree height)
>>> Extent data size:	4M
>>> Fs size used:		1T
>>>
>>> All file extents on disk is in 4M size, preallocated to reduce space =
usage
>>> (as the VM uses loopback block device backed by sparse file)
>>
>> Do you have a some additional details about the test setup? I tried to=

>> do the same (testing) for a bug Felix (added to Cc) reported to my at
>> the ALPSS Conference and I couldn't reproduce the issue.
>>
>> My testing was a 100TB sparse file passed into a VM and running this
>> script to touch all blockgroups:
>=20
> Here is my test scripts:
> ---
> #!/bin/bash
>=20
> dev=3D"/dev/vdb"
> mnt=3D"/mnt/btrfs"
>=20
> nr_subv=3D16
> nr_extents=3D16384
> extent_size=3D$((4 * 1024 * 1024)) # 4M
>=20
> _fail()
> {
>         echo "!!! FAILED: $@ !!!"
>         exit 1
> }
>=20
> fill_one_subv()
> {
>         path=3D$1
>         if [ -z $path ]; then
>                 _fail "wrong parameter for fill_one_subv"
>         fi
>         btrfs subv create $path || _fail "create subv"
>=20
>         for i in $(seq 0 $((nr_extents - 1))); do
>                 fallocate -o $((i * $extent_size)) -l $extent_size
> $path/file || _fail "fallocate"
>         done
> }
>=20
> declare -a pids
> umount $mnt &> /dev/null
> umount $dev &> /dev/null
>=20
> #~/btrfs-progs/mkfs.btrfs -f -n 4k $dev -O bg-tree
> mkfs.btrfs -f -n 4k $dev
> mount $dev $mnt -o nospace_cache
>=20
> for i in $(seq 1 $nr_subv); do
>         fill_one_subv $mnt/subv_${i} &
>         pids[$i]=3D$!
> done
>=20
> for i in $(seq 1 $nr_subv); do
>         wait ${pids[$i]}
> done
> sync
> umount $dev
>=20
> ---
>=20
>>
>> #!/bin/sh
>>
>> FILE=3D/mnt/test
>>
>> add_dirty_bg() {
>>         off=3D"$1"
>>         len=3D"$2"
>>         touch $FILE
>>         xfs_io -c "falloc $off $len" $FILE
>>         rm $FILE
>> }
>>
>> mkfs.btrfs /dev/vda
>> mount /dev/vda /mnt
>>
>> for ((i =3D 1; i < 100000; i++)); do
>>         add_dirty_bg $i"G" "1G"
>> done
>=20
> This wont really build a good enough extent tree layout.
>=20
> 1G fallocate will only cause 8 128M file extents, thus 8 EXTENT_ITEMs.
>=20
> Thus a leaf (16K by default) can still contain a lot of BLOCK_GROUPS al=
l
> together.
>=20
> To build a case to really show the problem, you'll need a lot of
> EXTENT_ITEM/METADATA_ITEMS to fill the gaps between BLOCK_GROUPS.
>=20
> My test scripts did that, but may still not represent the real world, a=
s
> real world can cause even smaller extents due to snapshots.
>=20

Ah thanks for the explanation. I'll give your testscript a try.


--=20
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N=C3=BCrnberg
Germany
(HRB 247165, AG M=C3=BCnchen)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850


--wAvvVLV6qv6R1Dg6Hu8K5bVwH7Csx86CT--

--SVwWnMv8QZhZOVhsDwNdrJlhtY9rmcvxJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTHVT2/GDXEB5TC6zbSnvIir4od7gUCXZxbOAAKCRDSnvIir4od
7gGGAQDBm/evDR3hH1Yk2S2q4YbA/XMaBSEc2YoeY5Afukwr/gD/XXleAiRmoRRZ
aDAXASK/Uy7djjliIONCrizKljP7tgk=
=9ycg
-----END PGP SIGNATURE-----

--SVwWnMv8QZhZOVhsDwNdrJlhtY9rmcvxJ--
