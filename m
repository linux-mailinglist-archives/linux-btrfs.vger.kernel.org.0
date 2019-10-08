Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62ECF5F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfJHJ0U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 05:26:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:51221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbfJHJ0U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 05:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570526771;
        bh=WQViOtFalGoVclgq5WNQFCZzEcMyad8SULWbvJuqrOg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=b7/Ej5VNviIdPUTTEC2YSF/LH8BFwFYf7+kLJ//B0lLSJ26C+aGNOjlPrXSB2WDG5
         56FeYR5Jdqm3+nmjXGf6csCw3pr9TwjFP0qxMm+3GtQ8rlr+6MHEV+pBusvV7KnQYh
         9x03XIbXLuGLPaMgGQg8sfCkWqv6P8vEpgDAY5y4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsEx-1hzxYa0Etz-00swyj; Tue, 08
 Oct 2019 11:26:11 +0200
Subject: Re: [PATCH v2 0/3] btrfs: Introduce new incompat feature BG_TREE to
 hugely reduce mount time
To:     Johannes Thumshirn <jthumshirn@suse.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     felix@feldspaten.org
References: <20191008044909.157750-1-wqu@suse.com>
 <c47049af-d034-0228-c61c-65187d07e6b4@suse.de>
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
Message-ID: <80fafbd5-b459-26de-6ebb-98eeb41f2064@gmx.com>
Date:   Tue, 8 Oct 2019 17:26:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c47049af-d034-0228-c61c-65187d07e6b4@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CRduSenE77YxYfD4j0XqWVvYHAYl0iuYr"
X-Provags-ID: V03:K1:c6t0IsZC2fN8050jRDcmQfd/KArt8dceDAM+h3+FoSU3pPbclHR
 0MEQU3k9Sp1GvC5aNweAR7gAKBlk8aZZbeX8SqpwguZ2W0gaTWnUOvegX2w/o1zPFbuVBXY
 NeQ4BeSmCpCIznKACOhuEWrym/+Qqs+8FaVwzt+HgH/lm9Z9JRvOTk4NGUcsZeWTYKeyKEb
 Gz5VFLDYodTN7+R5y/ZEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tI610/eZXBI=:0+GlxutLnM69gU8vXLJl4N
 Wn6g/upmrJO05ATR5U0KqW8Tbd87cRr0SQJkfARkfeROAqt96wyQHw1ogER7XYCd7PUovMWSt
 FPO1w8jMwxFqa2cW4cWxtNJtr58SEjKzlBjSMAbxZfxBsh3Va0JLdrMhqmL8itBUzrBbkJPn6
 FXBqxo51ncYB+YGOdo+yGC9VQdfyx+JwFOcKWwepySe+jirU/KPRTxbasxl3uByz0BiSydSsk
 E5PD9LXIHP2PVOBmuT+0Hax1YCIRQku12mYW2IAgcJOoY0ZauBotlU1I+iiBAJ51z2g1lo1Ah
 XyQj7NjUtf+SC7NRMSv4edIUO7L4GeI/B4pC29m2BrHLpskv2MmRLFzTpPPZyMD9nBmxMMqCZ
 K2cxE+Nh6ITXKghZnv6UmEALu95TRbI0tAWHo7Wk0EbFqUCWJ7DAuTMijIt6nqoc1ijT/+PwJ
 y7jeCGsS5TL1TwnInKIVeTegIiWUUrP3m9+9+aG48NfIHYfpc+KSldH2AT2ggarLvPEaCYL/p
 XzBuX3eBOZsr7IzufOGD8vmn7RgxntIBa0nBZ8sbtZBoOtTq86xk2mXywIO3wFMjX/pVtY+iY
 Bim4NaNGK7lEO3VQKPcr8AOjHBjFGirePrfWP4AmaNEVKYUPBW76b7YS+svUoVtzexODMkBv1
 ibelmwNhtSKpgLi3qTQaKh1aPJsX1oe8vWYhSBoD0ZGw+SCInGkwXBFgMcP83r3jb6XyiHp/b
 ol4dw8NbTmMZbRlKilTyLqjLV+0cteBBuYh+tMMU29BtfsAd900X6kQqN/7yXxxQQRMCps6jt
 G6WpOGXe0d839aOpz1Ym4UX+Z5jXu4jz+Mw7+awyXi+IM+nqOCFKrN25i55qN1a9NPOhuPCjm
 xJ2gAuh0u/a1/Oqt5PZz9Mx9AHV3HY4rTM/nfnZUOc/nQUrFn8UQdpmkKNVDuTrH8PAcFKX2F
 ALn5wm2WJyrCtcZNd5mJMZ1Log+i40ynA42Sz8GHEnfGreyuMRU2QGXF7bjlVERQrAqPuKcfs
 FMdbgyKL0gfBUypcIzgmK3toXiAFTaigITLGHgPwaQCrcD7ppcDxzEChfMSWDGCa5f8vDbq2r
 q+dpD+dIjFEid6jMHrO7vyHIPWtbHGCP8qN7hcsrr9CN2B+0nCUclxkGniIjjuBAAQVUg9gwY
 LreDqAhDDbKVfXCa0EXNlpLh/6ll/uhvUvzYGxmA4KhH2nEdf327nrUAQv93AVHcxxBr3Osjm
 p3j3uCkvhSOwxbrhNhP+ZGZ+PKfpvz/X78RVcRUofIjo0wpcC7j50ggsk/cw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CRduSenE77YxYfD4j0XqWVvYHAYl0iuYr
Content-Type: multipart/mixed; boundary="dM1STkcWAkSrEa4uvx4meDgHCJFhk4uf7"

--dM1STkcWAkSrEa4uvx4meDgHCJFhk4uf7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/8 =E4=B8=8B=E5=8D=885:14, Johannes Thumshirn wrote:
>> [[Benchmark]]
>> Since I have upgraded my rig to all NVME storage, there is no HDD
>> test result.
>>
>> Physical device:	NVMe SSD
>> VM device:		VirtIO block device, backup by sparse file
>> Nodesize:		4K  (to bump up tree height)
>> Extent data size:	4M
>> Fs size used:		1T
>>
>> All file extents on disk is in 4M size, preallocated to reduce space u=
sage
>> (as the VM uses loopback block device backed by sparse file)
>=20
> Do you have a some additional details about the test setup? I tried to
> do the same (testing) for a bug Felix (added to Cc) reported to my at
> the ALPSS Conference and I couldn't reproduce the issue.
>=20
> My testing was a 100TB sparse file passed into a VM and running this
> script to touch all blockgroups:

Here is my test scripts:
---
#!/bin/bash

dev=3D"/dev/vdb"
mnt=3D"/mnt/btrfs"

nr_subv=3D16
nr_extents=3D16384
extent_size=3D$((4 * 1024 * 1024)) # 4M

_fail()
{
        echo "!!! FAILED: $@ !!!"
        exit 1
}

fill_one_subv()
{
        path=3D$1
        if [ -z $path ]; then
                _fail "wrong parameter for fill_one_subv"
        fi
        btrfs subv create $path || _fail "create subv"

        for i in $(seq 0 $((nr_extents - 1))); do
                fallocate -o $((i * $extent_size)) -l $extent_size
$path/file || _fail "fallocate"
        done
}

declare -a pids
umount $mnt &> /dev/null
umount $dev &> /dev/null

#~/btrfs-progs/mkfs.btrfs -f -n 4k $dev -O bg-tree
mkfs.btrfs -f -n 4k $dev
mount $dev $mnt -o nospace_cache

for i in $(seq 1 $nr_subv); do
        fill_one_subv $mnt/subv_${i} &
        pids[$i]=3D$!
done

for i in $(seq 1 $nr_subv); do
        wait ${pids[$i]}
done
sync
umount $dev

---

>=20
> #!/bin/sh
>=20
> FILE=3D/mnt/test
>=20
> add_dirty_bg() {
>         off=3D"$1"
>         len=3D"$2"
>         touch $FILE
>         xfs_io -c "falloc $off $len" $FILE
>         rm $FILE
> }
>=20
> mkfs.btrfs /dev/vda
> mount /dev/vda /mnt
>=20
> for ((i =3D 1; i < 100000; i++)); do
>         add_dirty_bg $i"G" "1G"
> done

This wont really build a good enough extent tree layout.

1G fallocate will only cause 8 128M file extents, thus 8 EXTENT_ITEMs.

Thus a leaf (16K by default) can still contain a lot of BLOCK_GROUPS all
together.

To build a case to really show the problem, you'll need a lot of
EXTENT_ITEM/METADATA_ITEMS to fill the gaps between BLOCK_GROUPS.

My test scripts did that, but may still not represent the real world, as
real world can cause even smaller extents due to snapshots.

Thanks,
Qu

>=20
> umount /mnt
>=20
>=20
>=20


--dM1STkcWAkSrEa4uvx4meDgHCJFhk4uf7--

--CRduSenE77YxYfD4j0XqWVvYHAYl0iuYr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cVi4ACgkQwj2R86El
/qjacQgAhpH8XVF/XAL3fMOtYd01Knreroe1+5meI4PBTRgml/YgaHK0qhibX/vk
KeI0eokw+ILJk96zZl2nd841TrAUMz+x9LRPlWfoW9+WIp+QHykWWzltupjtq6I5
8+3tvJxvZReR/TdEvQAKUWpHbkqzMU2VDwxIgZ59i212jRT8puooCaAAK/5PLCWh
+J1Z6tF0ivGFkL4SEluhDARAAMS24NuCUq3E68n58Z6+VzsyvVQohMFX3lbK0dTu
kAEoklMqxnXfA7mBn8b5r1pai2YlFOYOTezsrbbI1eF9sXhn1lvGvlVwfhDL2EPH
Ca7HkFnhoSQhit5CfHBQBnSJ5EfoyA==
=CQ25
-----END PGP SIGNATURE-----

--CRduSenE77YxYfD4j0XqWVvYHAYl0iuYr--
