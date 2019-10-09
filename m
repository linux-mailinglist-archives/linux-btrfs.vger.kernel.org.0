Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FC7D08A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 09:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfJIHn1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 03:43:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:45371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJIHn0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 03:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570606998;
        bh=ehI/t48zCKwfASXOAIx/wMFnPUojsNYTfG+yGzpw5r8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=GYfG8sopRp2cv/0zlGxocjdq0yzCyvT0j3akXpgDvHqI2dYxgtvxROZu51JG538NW
         BQ117vpqvq5SyzX0hetSGSeUpDcwAwxinLd33NFyHMU0Wvce4+Lg0zNZj1vwhbWiKx
         AgyCaVmO/oZsqtjj8wCWuH1Ar8kI3rmx1A8VjaUc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MatVh-1hgpji08l9-00cTVk; Wed, 09
 Oct 2019 09:43:17 +0200
Subject: Re: [PATCH v2 0/3] btrfs: Introduce new incompat feature BG_TREE to
 hugely reduce mount time
To:     Felix Niederwanger <felix@feldspaten.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008044909.157750-1-wqu@suse.com>
 <c47049af-d034-0228-c61c-65187d07e6b4@suse.de>
 <80fafbd5-b459-26de-6ebb-98eeb41f2064@gmx.com>
 <23af48db-c28b-3406-b136-c5da30884a88@suse.de>
 <b4821d86-eeb9-f21c-66aa-480df2d3a13d@feldspaten.org>
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
Message-ID: <6f17fcd6-c576-adad-fb20-defcfde4efb5@gmx.com>
Date:   Wed, 9 Oct 2019 15:43:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b4821d86-eeb9-f21c-66aa-480df2d3a13d@feldspaten.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mu579u7lKcL5w2HzK4KlUwI8XJp7tJCe6"
X-Provags-ID: V03:K1:D7eccro7md0IRrqihPa+5iiIt7psx51uTcX8/5BfQMm2L3IZR0s
 5Prr5qYyL6PFel3jcgTULMKYoAo3EfMtoCHUe/Ny915nqLOj7f37rUNlJ/FaPgeYej5bT8a
 q1e3w/1wUNpNLakLC4BziPrM8vbWsKL+rtYtIIUGbmyPDi9vMBxS0IvG/JUyC/uXfWwkHFC
 mOJDhtXFKGWB63PBjmggA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NFkIlJacujM=:eDwRjSA0Tjh8/voqOWAGqE
 w9wFTSg+VmMf/Cu7KUUvYU0+36KdUKMaGdUMNyN00Ot+dVgjq7SGlbcga6RVyAWjg2hvwCbyZ
 5wl/gTeyt+jjIEdF0iSELAqCHBwyFWDiEt8jlavqdwBGpaw8hgkuqOx5Gw2Zf9EZaO+b8HS4V
 PDXxZWKkwXK9Z0U4D7Mgrt/9z4SbrdM2LTOCBTLUh7mooAqFggqAER4I3FnpXml3zK7Stsk46
 TrADES+LM5egT+Y9r3s5I8hrFJL1uBvuslAeSLT0Q5FphK1Pnfz8Sq2n2uwFZgwb+gOiSv0M/
 ymsDuZBtZE5M8vywaI7FukjZli04sK95bJE6A9xYrpx/Nm8W6VmIcjNtELrtO47/4o+iy54Iu
 gi9BaxJILsi42rGoOdmB0hBI2m9jqLUKLQIOQlCQwUsI8ZBstzrut0/RAeBR8Q7nHWXLUh/6e
 T4BVgqwO6ArnmGOKau3LHdc2kEnpIOmJ+ewoD/QAaPx9/IujMyefjhQsJ1nqmCb+6aKy0STog
 8CQVYLL/v9ZB2mwK4n+7tC+6/8+ucgLqFE6Cmv0nvpJTklCzVNQlfHEBt/E9lXiLaKW4QimMG
 hIuOstVdalDtPW1T3k/j/C24WkKiaXAa5FWrOtyPhXdOwQtKKag4AIGkrC+cwEylPpDSzNXm+
 a0UAd6vUtUPnmLpL+2o0tG/B6PyCdLEIhINQhT9HZWn9YUUWhZ/h/42XmjstV7TxykiquYnRp
 iPrOSI9Qh8sF4C0QOJA9tKI9XCOj1jjIzp2AxI/wm6iQweOrhN2Z9lnLU8CWD8giPe0hqdb+Q
 S8LG1dmKhyGamZqb9V/Hu+wrNDvMggLg74xQTsXc0GUQSoF7AKQPSOk415DgKv0/AAND189Pu
 sMVD0y1Stma6A8F3+SVnRPk0OiD03YXNKi63aZlArWIDXtBk1YfwJP5WdFnoi7oTw+WhlSKZ/
 D926cKppkJ1ld4nbTLg9q+o4nEyGjO8MCN+ASggGVDADP0r9RiEOKdIsO5nzWmSGifnYOVdlZ
 lJ2dPOFfyvs33u0VHXMGEPl3etJ+bRPFAoGYAnyuEA1ysPd45fedZKDjCCiCATaKOt7cHy6q6
 Uy731KU8ECNVih9CO5juaWXG++zPYqbB9+VMoATdtWu1tONhlJXheYBf6ZrIx8+HUh3PYpCUf
 jKXq7fI68lA39FJbZDa1vIOQnSxvoIEh7pM/yd0JvL2qeAIg079UBTBCRxxPaOrsDL+pxtMrM
 siBuSjrB3P60tmFpbHs0x54+g3z03goVQs1nG5nVbXe7lj1QIIyd0nTyS0hI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mu579u7lKcL5w2HzK4KlUwI8XJp7tJCe6
Content-Type: multipart/mixed; boundary="r5bP8y8RvuKYPJRhIh8vZ33Zp15a8oR4d"

--r5bP8y8RvuKYPJRhIh8vZ33Zp15a8oR4d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/9 =E4=B8=8B=E5=8D=883:07, Felix Niederwanger wrote:
> Hey Johannes,
>=20
> glad to hear back from you :-)
>=20
> As discussed I try to elaborate the setup where we experienced the
> issue, that btrfs mount takes more than 5 minutes. The initial bug
> report is at https://bugzilla.opensuse.org/show_bug.cgi?id=3D1143865
>=20
> Physical device:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Hardware RAID controller ARECA-1883 PCIe 3.0 to SAS/SATA =
12Gb RAID Controller
>                              Hardware RAID6+HotSpare, 8 TB Seagate Iron=
Wolf NAS HDD
> Installed System:            OPENSUSE LEAP 15.1
> Disks:                       / is on a separate DOM
>                              /dev/sda1 is the affected btrfs volume
>=20
> Disk layout
>=20
> sda      8:0    0 98.2T  0 disk=20
> =E2=94=94=E2=94=80sda1   8:1    0 81.9T  0 part /ESO-RAID

How much space is used?

With enough space used (especially your tens of TB used), it's pretty
easy to have too many block groups items to overload the extent tree.

There is a better tool to explore the problem easier:
https://github.com/adam900710/btrfs-progs/tree/account_bgs

You can compile the btrfs-corrupt-block tool, and then:
# ./btrfs-corrupt-block -X /dev/sda1

It's recommended to call it with fs unmounted.

Then it should output something like:
extent_tree: total=3D1080 leaves=3D1025

Then please post that line to surprise us.

It shows how many unique tree blocks are needed to be read from disk,
just for iterating the block group items.

You could consider it as how many random IO needs to be done in nodesize
(normally 16K).

> sdb      8:16   0   59G  0 disk=20
> =E2=94=9C=E2=94=80sdb1   8:17   0    1G  0 part /boot
> =E2=94=9C=E2=94=80sdb2   8:18   0  5.9G  0 part [SWAP]
> =E2=94=94=E2=94=80sdb3   8:19   0 52.1G  0 part /
>=20
> System configuration : Opensuse LEAP 15.1 with "Server" configuration,
> installed NFS server.
>=20
> I copied data from the old NAS (separate server, xfs volume) to the new=

> btrfs volume using rsync.

If you are willing to/have enough spare space to test, you could try
that my latest bg-tree feature, to see if it would solve the problem.

My not-so-optimized guess that feature would reduce mount time to around
1min.
My average guess is, around 30s.

Thanks,
Qu

> Then I performed a system update with zypper, rebooted and run into the=

> problems described in
> https://bugzilla.opensuse.org/show_bug.cgi?id=3D1143865. In short: Boot=

> failed, because mounting /ESO-RAID run into a 5 minutes timeout. Manual=

> mount worked fine (but took up to 6 minutes) and the filesystem was
> completely unresponsive. See the bug report for more details about what=

> became unresponsive.
>=20
> A movie of the failing boot process is still on my webserver:
> ftp://feldspaten.org/dump/20190803_btrfs_balance_issue/btrfs_openctree_=
failed.mp4
>=20
>=20
> I hope this contributes to reproduce the issue. Feel free to contact me=

> if you need further details,
>=20
> Greetings,
> Felix :-)
>=20
>=20
> On 10/8/19 11:47 AM, Johannes Thumshirn wrote:
>> On 08/10/2019 11:26, Qu Wenruo wrote:
>>> On 2019/10/8 =E4=B8=8B=E5=8D=885:14, Johannes Thumshirn wrote:
>>>>> [[Benchmark]]
>>>>> Since I have upgraded my rig to all NVME storage, there is no HDD
>>>>> test result.
>>>>>
>>>>> Physical device:	NVMe SSD
>>>>> VM device:		VirtIO block device, backup by sparse file
>>>>> Nodesize:		4K  (to bump up tree height)
>>>>> Extent data size:	4M
>>>>> Fs size used:		1T
>>>>>
>>>>> All file extents on disk is in 4M size, preallocated to reduce spac=
e usage
>>>>> (as the VM uses loopback block device backed by sparse file)
>>>> Do you have a some additional details about the test setup? I tried =
to
>>>> do the same (testing) for a bug Felix (added to Cc) reported to my a=
t
>>>> the ALPSS Conference and I couldn't reproduce the issue.
>>>>
>>>> My testing was a 100TB sparse file passed into a VM and running this=

>>>> script to touch all blockgroups:
>>> Here is my test scripts:
>>> ---
>>> #!/bin/bash
>>>
>>> dev=3D"/dev/vdb"
>>> mnt=3D"/mnt/btrfs"
>>>
>>> nr_subv=3D16
>>> nr_extents=3D16384
>>> extent_size=3D$((4 * 1024 * 1024)) # 4M
>>>
>>> _fail()
>>> {
>>>         echo "!!! FAILED: $@ !!!"
>>>         exit 1
>>> }
>>>
>>> fill_one_subv()
>>> {
>>>         path=3D$1
>>>         if [ -z $path ]; then
>>>                 _fail "wrong parameter for fill_one_subv"
>>>         fi
>>>         btrfs subv create $path || _fail "create subv"
>>>
>>>         for i in $(seq 0 $((nr_extents - 1))); do
>>>                 fallocate -o $((i * $extent_size)) -l $extent_size
>>> $path/file || _fail "fallocate"
>>>         done
>>> }
>>>
>>> declare -a pids
>>> umount $mnt &> /dev/null
>>> umount $dev &> /dev/null
>>>
>>> #~/btrfs-progs/mkfs.btrfs -f -n 4k $dev -O bg-tree
>>> mkfs.btrfs -f -n 4k $dev
>>> mount $dev $mnt -o nospace_cache
>>>
>>> for i in $(seq 1 $nr_subv); do
>>>         fill_one_subv $mnt/subv_${i} &
>>>         pids[$i]=3D$!
>>> done
>>>
>>> for i in $(seq 1 $nr_subv); do
>>>         wait ${pids[$i]}
>>> done
>>> sync
>>> umount $dev
>>>
>>> ---
>>>
>>>> #!/bin/sh
>>>>
>>>> FILE=3D/mnt/test
>>>>
>>>> add_dirty_bg() {
>>>>         off=3D"$1"
>>>>         len=3D"$2"
>>>>         touch $FILE
>>>>         xfs_io -c "falloc $off $len" $FILE
>>>>         rm $FILE
>>>> }
>>>>
>>>> mkfs.btrfs /dev/vda
>>>> mount /dev/vda /mnt
>>>>
>>>> for ((i =3D 1; i < 100000; i++)); do
>>>>         add_dirty_bg $i"G" "1G"
>>>> done
>>> This wont really build a good enough extent tree layout.
>>>
>>> 1G fallocate will only cause 8 128M file extents, thus 8 EXTENT_ITEMs=
=2E
>>>
>>> Thus a leaf (16K by default) can still contain a lot of BLOCK_GROUPS =
all
>>> together.
>>>
>>> To build a case to really show the problem, you'll need a lot of
>>> EXTENT_ITEM/METADATA_ITEMS to fill the gaps between BLOCK_GROUPS.
>>>
>>> My test scripts did that, but may still not represent the real world,=
 as
>>> real world can cause even smaller extents due to snapshots.
>>>
>> Ah thanks for the explanation. I'll give your testscript a try.
>>
>>


--r5bP8y8RvuKYPJRhIh8vZ33Zp15a8oR4d--

--Mu579u7lKcL5w2HzK4KlUwI8XJp7tJCe6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2dj5AACgkQwj2R86El
/qjdVQgAmWkA00HOsBWRCUtCcHMctz/Asjf4t/23oMD1aowQtA+CRwdclev/DXc1
9ItWR8ZYX7oGEpuwvfbHPHBYJGw9FVkViTAThw7H4Z9VUvv6sGrr0m48BFbTAn7D
fVemJfplLmC0wLOv5YiqjTSuuSYlAA+tjbjyFynQ2J4FvC9OBlRUM+X9yzhyYmAP
Jo7pmlYebHjN4AuI1XzeokCwo6gjUwAF97jZHhC6rivRFNNN8ZfDHeDIc5yFavIY
9HgVweIpGrTdPWT36XjN2kQXOZ7fiLFgoeSnMs5xeHbM6wrEI2m5zp5PKp31wSgR
UkfnoYHvHaNuTcub6b0hiDk4KzoDFw==
=6jG8
-----END PGP SIGNATURE-----

--Mu579u7lKcL5w2HzK4KlUwI8XJp7tJCe6--
