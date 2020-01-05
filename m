Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122CE13059B
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 03:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAEC7e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 21:59:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:51419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgAEC7d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Jan 2020 21:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578193168;
        bh=tbwEJPyLc5CSvF55Mwu0yA9SpKhYDBsbiPvWpF45WLc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WYi9W/F0/ZYKPuB/6/tvYDtl0c8w/I0us2RR4O9mH/+xgKMNBnKX5GESHU+2E1M84
         e1/QL6BqxjoLyxZ620wmBjImN+MWZ6lq9mIH/5ZEZu6JqAgcJK4wbbZdgkYRPbnM5Y
         zDEl8bZaZO5g0gHxJ6lxgyDcR5SYhAaLaKz2z8tk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAfUo-1iyylL3cF6-00B5CN; Sun, 05
 Jan 2020 03:59:28 +0100
Subject: Re: Read time tree block corruption not detected by btrfs check
To:     Vladimir <amigo.elite@gmail.com>, linux-btrfs@vger.kernel.org
References: <CADy2AqZvJHP3YtCvUNNtCY-RopecWiTrBwDO15vTbQMqA3EGeQ@mail.gmail.com>
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
Message-ID: <6ac639e6-c5e9-cddc-dce8-1c32c1a8e507@gmx.com>
Date:   Sun, 5 Jan 2020 10:59:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CADy2AqZvJHP3YtCvUNNtCY-RopecWiTrBwDO15vTbQMqA3EGeQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qcsLsB5VxiAwe4HtdATi4w8ePOZ0QND9G"
X-Provags-ID: V03:K1:QvKmcBH8fBCVvr2oqNPkQ1zYNZaR63aIbGxewK0meYbkurlQlQ/
 nt4cIndqDE/xil+6vI02ff4B/G5eG/fCj61HNfWtGx1kRlMLTrl3trXXd0GP0wuVrrZxP38
 mHzyjHCGVk3Rd6n5rcYuOV/jMhYHf8BTJpBkRmoPZ7UGbt+MW8PBBxDC5b5S7lgbP9Jn5ta
 SR2tqSmJyvnP8wPKhmxzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r4RngJ1X9lA=:2MMpQC8pLjglD6cWbW4gpM
 PwBXKlvF7Dy8zcMS3pdFl3GhB/T25UXmjsxuLlztVsTqcYvH52XsiGqqLqSIfMDzn9b1a/RJq
 wJyLotJIeLsBYOfrnv25YwJnB+CwcoDBfdYDMuZn85Srcva/HznSWjqpn5zrI47YB/nqCdbKF
 3dogDBl6l8Zwzegy1EoCg5w9E37vMzvUUXzKrzEAFEwCxPwm9L0bZ0zhmW4+bHg/wGM23XSJS
 KsnQgiSAHuoebzp0Vr3lqTf3oCZfHU8KqupAgsQKkeeDN9p6RtjTi5XphQgiz3RUqx1jSKIAE
 FVvv7OmMgyNNLBPmXnEJDZHIMCWpmyP9/fnS7FFvFleO/bnJYzpy6Z18Gfq0qvFRpbACuox30
 X5e/1pZQZucnOzKWH9xMECyjHg1mCYrpNcktyzPwMi7n5FdSeYPjHytrh8lXChsR4jA28DnTa
 3+i9PLejgblcRAHLUwz+neaBMbekTKOIqbJKGZp9P7O0XV16e4J+W9hTcMmdegpqu2rK7+8Dy
 BmFUbakMxPuhqu8Glw2HwSA+ZKyJCY7atmoUOIIg6pMkOqCq/8b8vn2e2sNcaTl7jRf6Hxne6
 ZLxHJpbsMl/7MlIoMYmzfvF3vRaNIKMgttLmgt0HSCfZv4dwDW3B8J8iEzI43GelhfyifgeSN
 jqzGt3sHA2lha3ioySThBJA2sMcYi92cAFbawTunap+WzAmxb23AaALeTXtA/wXAVg5N8ZVHq
 jVxEKvYPqvYB0WHo0skuDYmu5iV3JTQAhqtO/sMs18lcNlwPS9ZL61gBKuJuXai9Wec+aL1wk
 oM9lm2k4jyioWgyamabuZrxBsNYzMwSS728EDS2GxbyY4aYqLBVIyip+mCZ306IER1VMVCsoE
 9c+aH9NiF5pk9/nTQbKforxl4msca8Lelv6iAvq0nBCEZ+Zmrif2ahV9V9xc/SzhRAV13V5Oq
 uOh/1v83TOwlN6xeIcs0pi8X34NdQ1Sz7Hj67x2jlvLmZZGZ/zQXwP+FkWRBsmOoqvqLb+9BU
 OTL0Y64vZ6i5N5x9Onkq7wsV6SQXSg5H5b2NN7pWArdD9vOMgFMTT2KvGLW7UgELa8iP5HNB3
 6O2k8UdJW6cmW4i9zLKdw2Jk/TYfEWLwEhnsPJfLFYZLMoH3FVCX3JMsChKpJCxVJSRd6DR/r
 jlz62dYJ2/HYP4OPE4cxbxr51KvXoQVSbV+xBMc/CEBBd4cryUr2n28iqTqMttuOANE6JRAGa
 0QYo0FKOMYR3mQVYunEHFpwdrOBgFp4e56qpTsa9a0SytOh4BugLujGj3xZM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qcsLsB5VxiAwe4HtdATi4w8ePOZ0QND9G
Content-Type: multipart/mixed; boundary="I4bQphwKdqcGYc4xmRQKTvsptFeFSro6q"

--I4bQphwKdqcGYc4xmRQKTvsptFeFSro6q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/5 =E4=B8=8A=E5=8D=889:30, Vladimir wrote:
> Dear BTRFS community,
>=20
> I hit a strange issue: btrfsck unable to detect any errors, but I'm
> also unable to mount this "sane" (by the btrfsck opinion) BTRFS
> partition.
>=20
> Long story short: at some point, I had to forcefully power off my
> laptop due to near-OOM hang with very intensive swapping caused by
> starting the memory-hungry app.
> This happened on 5.4.0-1.el7.elrepo.x86_64 kernel.
>=20
> After reboot I was unable to mount my data partition (/dev/stripe/data)=
:
> [29798.631579] BTRFS info (device dm-11): disk space caching is enabled=

> [29798.631581] BTRFS info (device dm-11): has skinny extents
> [29798.637910] BTRFS info (device dm-11): bdev
> /dev/mapper/stripe-data--snap2 errs: wr 0, rd 11, flush 0, corrupt
> 3452, gen 0
> [29798.677872] BTRFS critical (device dm-11): corrupt leaf:
> block=3D1651991592960 slot=3D16 extent bytenr=3D93983342592 len=3D52428=
8
> invalid generation, have 140287904167864 expect (0, 6389777]

This is the new extent geneartion tree-checker introduced in v5.4.

btrfs-progs doesn't yet support it, but the detect part is already
submitted to btrfs mail list.

The fs can be completely saved without losing anything.
You can fetch the this branch:
https://github.com/kdave/btrfs-progs/tree/devel

Then use --init-extent-tree to fix the problem.

Thanks,
Qu

> [29798.677875] BTRFS error (device dm-11): block=3D1651991592960 read
> time tree block corruption detected
> [29798.677895] BTRFS error (device dm-11): failed to read block groups:=
 -5
> [29798.691723] BTRFS error (device dm-11): open_ctree failed
>=20
> I've created an LVM snapshot of the damaged partition and started to di=
g in:
>=20
> At first, I've updated my kernel to the latest one:
> # cat /proc/version
> Linux version 5.4.7-1.el7.elrepo.x86_64 (mockbuild@Build64R7) (gcc
> version 4.8.5 20150623 (Red Hat 4.8.5-39) (GCC)) #1 SMP Tue Dec 31
> 11:30:50 EST 2019
>=20
> Second, I've updated btrfs-progs to the latest available version:
> # btrfs version
> btrfs-progs v5.4
>=20
> Third, I've attempted to mount this partition again (with no success,
> even if I'm attempting to use subvolid for the most important
> subvolume) and then attempted to run btrfsck --repair:
> # btrfs check -p --repair /dev/stripe/data-snap3
> enabling repair mode
> WARNING:
>=20
> Do not use --repair unless you are advised to do so by a developer
> or an experienced user, and then only after having accepted that no
> fsck can successfully repair all types of filesystem corruption. Eg.
> some software or hardware bugs can fatally damage a volume.
> The operation will start in 10 seconds.
> Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/stripe/data-snap3
> UUID: 51d26840-8d19-4622-a23f-e78431f11196
> [1/7] checking root items                      (0:00:04 elapsed,
> 3025927 items checked)
> Fixed 0 roots.
> No device size related problem found           (0:00:36 elapsed,
> 226080 items checked)
> [2/7] checking extents                         (0:00:36 elapsed,
> 226094 items checked)
> cache and super generation don't match, space cache will be invalidated=

> [3/7] checking free space cache                (0:00:00 elapsed)
> [4/7] checking fs roots                        (0:00:55 elapsed,
> 179338 items checked)
> [5/7] checking csums (without verifying data)  (0:00:01 elapsed,
> 929754 items checked)
> [6/7] checking root refs                       (0:00:00 elapsed, 151
> items checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 329136820224 bytes used, no error found
> total csum bytes: 317705000
> total tree bytes: 3702947840
> total fs tree bytes: 2947874816
> total extent tree bytes: 342605824
> btree space waste bytes: 640513083
> file data blocks allocated: 997170450432
>  referenced 528523653120
>=20
> Currently, I'm waiting for `btrfsck --init-extent-tree` and `btrfs
> restore` to finish runs on snapshots but not sure if btrfsck is going
> to help.
>=20
> Some additional info:
>=20
> # btrfs insp dump-tree -b 1651557531648 --follow /dev/stripe/data-snap3=

> btrfs-progs v5.4
> leaf 1651557531648 items 206 free space 3402 generation 6389777 owner
> EXTENT_TREE
> leaf 1651557531648 flags 0x1(WRITTEN) backref revision 1
> fs uuid 51d26840-8d19-4622-a23f-e78431f11196
> chunk uuid 0de2db9c-a970-40f0-9fdb-c797b13ac0c1
> item 0 key (93981401088 EXTENT_ITEM 126976) itemoff 16204 itemsize 79
> refs 3 gen 3227277 flags DATA
> extent data backref root 2368 objectid 5682 offset 23367835648 count 1
> shared data backref parent 1635492167680 count 1
> shared data backref parent 1601869201408 count 1
> item 1 key (93981528064 EXTENT_ITEM 12288) itemoff 16167 itemsize 37
> refs 1 gen 3691918 flags DATA
> shared data backref parent 1080080089088 count 1
> item 2 key (93981544448 EXTENT_ITEM 49152) itemoff 16130 itemsize 37
> refs 1 gen 3684280 flags DATA
> shared data backref parent 1079417503744 count 1
> item 3 key (93981593600 EXTENT_ITEM 4096) itemoff 16077 itemsize 53
> refs 1 gen 5689421 flags DATA
> extent data backref root 2368 objectid 12305 offset 15963054080 count 1=

> item 4 key (93981597696 EXTENT_ITEM 65536) itemoff 16024 itemsize 53
> refs 1 gen 6349517 flags DATA
> extent data backref root 2368 objectid 261 offset 12687536128 count 1
> item 5 key (93981663232 EXTENT_ITEM 32768) itemoff 15987 itemsize 37
> refs 1 gen 6349520 flags DATA
> shared data backref parent 1609922379776 count 1
> item 6 key (93981696000 EXTENT_ITEM 20480) itemoff 15950 itemsize 37
> refs 1 gen 6375808 flags DATA
> shared data backref parent 1079170285568 count 1
> item 7 key (93981716480 EXTENT_ITEM 24576) itemoff 15913 itemsize 37
> refs 1 gen 6375808 flags DATA
> shared data backref parent 1079170285568 count 1
> item 8 key (93981749248 EXTENT_ITEM 4096) itemoff 15860 itemsize 53
> refs 1 gen 5224843 flags DATA
> extent data backref root 2368 objectid 262 offset 9913962496 count 1
> item 9 key (93981753344 EXTENT_ITEM 4096) itemoff 15807 itemsize 53
> refs 1 gen 5226775 flags DATA
> extent data backref root 2368 objectid 261 offset 5763231744 count 1
> item 10 key (93981757440 EXTENT_ITEM 4096) itemoff 15754 itemsize 53
> refs 1 gen 5689421 flags DATA
> extent data backref root 2368 objectid 12305 offset 15963062272 count 1=

> item 11 key (93981761536 EXTENT_ITEM 8192) itemoff 15717 itemsize 37
> refs 1 gen 3692528 flags DATA
> shared data backref parent 1081437290496 count 1
> item 12 key (93981769728 EXTENT_ITEM 524288) itemoff 15680 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 13 key (93981769728 BLOCK_GROUP_ITEM 1073741824) itemoff 15656 ite=
msize 24
> block group used 1073639424 chunk_objectid 256 flags DATA
> item 14 key (93982294016 EXTENT_ITEM 524288) itemoff 15619 itemsize 37
> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 15 key (93982818304 EXTENT_ITEM 524288) itemoff 15582 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 16 key (93983342592 EXTENT_ITEM 524288) itemoff 15545 itemsize 37
> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 17 key (93983866880 EXTENT_ITEM 524288) itemoff 15508 itemsize 37
> refs 1 gen 16290361 flags DATA
> shared data backref parent 1079186604032 count 1
> item 18 key (93984391168 EXTENT_ITEM 524288) itemoff 15471 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 19 key (93984915456 EXTENT_ITEM 524288) itemoff 15434 itemsize 37
> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 20 key (93985439744 EXTENT_ITEM 524288) itemoff 15397 itemsize 37
> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 21 key (93985964032 EXTENT_ITEM 524288) itemoff 15360 itemsize 37
> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 22 key (93986488320 EXTENT_ITEM 524288) itemoff 15323 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 23 key (93987012608 EXTENT_ITEM 524288) itemoff 15286 itemsize 37
> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 24 key (93987536896 EXTENT_ITEM 524288) itemoff 15249 itemsize 37
> refs 1 gen 11882841 flags DATA
> shared data backref parent 1079186604032 count 1
> item 25 key (93988061184 EXTENT_ITEM 524288) itemoff 15212 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 26 key (93988585472 EXTENT_ITEM 524288) itemoff 15175 itemsize 37
> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 27 key (93989109760 EXTENT_ITEM 524288) itemoff 15138 itemsize 37
> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 28 key (93989634048 EXTENT_ITEM 524288) itemoff 15101 itemsize 37
> refs 1 gen 19201 flags DATA
> shared data backref parent 1079186604032 count 1
> item 29 key (93990158336 EXTENT_ITEM 524288) itemoff 15064 itemsize 37
> refs 1 gen 12693208 flags DATA
> shared data backref parent 1079186604032 count 1
> item 30 key (93990682624 EXTENT_ITEM 524288) itemoff 15027 itemsize 37
> refs 1 gen 75260329984 flags DATA
> shared data backref parent 1079186604032 count 1
> item 31 key (93991206912 EXTENT_ITEM 524288) itemoff 14990 itemsize 37
> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 32 key (93991731200 EXTENT_ITEM 524288) itemoff 14953 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 33 key (93992255488 EXTENT_ITEM 524288) itemoff 14916 itemsize 37
> refs 1 gen 10 flags DATA
> shared data backref parent 1079186604032 count 1
> item 34 key (93992779776 EXTENT_ITEM 524288) itemoff 14879 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 35 key (93993304064 EXTENT_ITEM 524288) itemoff 14842 itemsize 37
> refs 1 gen 16290360 flags DATA
> shared data backref parent 1079186604032 count 1
> item 36 key (93993828352 EXTENT_ITEM 524288) itemoff 14805 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 37 key (93994352640 EXTENT_ITEM 524288) itemoff 14768 itemsize 37
> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 38 key (93994876928 EXTENT_ITEM 524288) itemoff 14731 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 39 key (93995401216 EXTENT_ITEM 524288) itemoff 14694 itemsize 37
> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 40 key (93995925504 EXTENT_ITEM 524288) itemoff 14657 itemsize 37
> refs 1 gen 11882841 flags DATA
> shared data backref parent 1079186604032 count 1
> item 41 key (93996449792 EXTENT_ITEM 524288) itemoff 14620 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 42 key (93996974080 EXTENT_ITEM 524288) itemoff 14583 itemsize 37
> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 43 key (93997498368 EXTENT_ITEM 524288) itemoff 14546 itemsize 37
> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 44 key (93998022656 EXTENT_ITEM 524288) itemoff 14509 itemsize 37
> refs 1 gen 14337 flags DATA
> shared data backref parent 1079186604032 count 1
> item 45 key (93998546944 EXTENT_ITEM 524288) itemoff 14472 itemsize 37
> refs 1 gen 12698072 flags DATA
> shared data backref parent 1079186604032 count 1
> item 46 key (93999071232 EXTENT_ITEM 524288) itemoff 14435 itemsize 37
> refs 1 gen 75260641280 flags DATA
> shared data backref parent 1079186604032 count 1
> item 47 key (93999595520 EXTENT_ITEM 524288) itemoff 14398 itemsize 37
> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 48 key (94000119808 EXTENT_ITEM 524288) itemoff 14361 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 49 key (94000644096 EXTENT_ITEM 524288) itemoff 14324 itemsize 37
> refs 1 gen 10 flags DATA
> shared data backref parent 1079186604032 count 1
> item 50 key (94001168384 EXTENT_ITEM 524288) itemoff 14287 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 51 key (94001692672 EXTENT_ITEM 524288) itemoff 14250 itemsize 37
> refs 1 gen 16290360 flags DATA
> shared data backref parent 1079186604032 count 1
> item 52 key (94002216960 EXTENT_ITEM 524288) itemoff 14213 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 53 key (94002741248 EXTENT_ITEM 524288) itemoff 14176 itemsize 37
> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 54 key (94003265536 EXTENT_ITEM 524288) itemoff 14139 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 55 key (94003789824 EXTENT_ITEM 524288) itemoff 14102 itemsize 37
> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 56 key (94004314112 EXTENT_ITEM 524288) itemoff 14065 itemsize 37
> refs 1 gen 11882841 flags DATA
> shared data backref parent 1079186604032 count 1
> item 57 key (94004838400 EXTENT_ITEM 524288) itemoff 14028 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 58 key (94005362688 EXTENT_ITEM 524288) itemoff 13991 itemsize 37
> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 59 key (94005886976 EXTENT_ITEM 524288) itemoff 13954 itemsize 37
> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 60 key (94006411264 EXTENT_ITEM 524288) itemoff 13917 itemsize 37
> refs 1 gen 9473 flags DATA
> shared data backref parent 1079186604032 count 1
> item 61 key (94006935552 EXTENT_ITEM 524288) itemoff 13880 itemsize 37
> refs 1 gen 12702936 flags DATA
> shared data backref parent 1079186604032 count 1
> item 62 key (94007459840 EXTENT_ITEM 524288) itemoff 13843 itemsize 37
> refs 1 gen 75261067264 flags DATA
> shared data backref parent 1079186604032 count 1
> item 63 key (94007984128 EXTENT_ITEM 524288) itemoff 13806 itemsize 37
> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 64 key (94008508416 EXTENT_ITEM 524288) itemoff 13769 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 65 key (94009032704 EXTENT_ITEM 524288) itemoff 13732 itemsize 37
> refs 1 gen 10 flags DATA
> shared data backref parent 1079186604032 count 1
> item 66 key (94009556992 EXTENT_ITEM 524288) itemoff 13695 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 67 key (94010081280 EXTENT_ITEM 524288) itemoff 13658 itemsize 37
> refs 1 gen 16290360 flags DATA
> shared data backref parent 1079186604032 count 1
> item 68 key (94010605568 EXTENT_ITEM 524288) itemoff 13621 itemsize 37
> refs 1 gen 658013952 flags DATA
> shared data backref parent 1079186604032 count 1
> item 69 key (94011129856 EXTENT_ITEM 524288) itemoff 13584 itemsize 37
> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 70 key (94011654144 EXTENT_ITEM 524288) itemoff 13547 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 71 key (94012178432 EXTENT_ITEM 524288) itemoff 13510 itemsize 37
> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 72 key (94012702720 EXTENT_ITEM 524288) itemoff 13473 itemsize 37
> refs 1 gen 11882841 flags DATA
> shared data backref parent 1079186604032 count 1
> item 73 key (94013227008 EXTENT_ITEM 524288) itemoff 13436 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 74 key (94013751296 EXTENT_ITEM 524288) itemoff 13399 itemsize 37
> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 75 key (94014275584 EXTENT_ITEM 524288) itemoff 13362 itemsize 37
> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 76 key (94014799872 EXTENT_ITEM 524288) itemoff 13325 itemsize 37
> refs 1 gen 4609 flags DATA
> shared data backref parent 1079186604032 count 1
> item 77 key (94015324160 EXTENT_ITEM 524288) itemoff 13288 itemsize 37
> refs 1 gen 12707800 flags DATA
> shared data backref parent 1079186604032 count 1
> item 78 key (94015848448 EXTENT_ITEM 524288) itemoff 13251 itemsize 37
> refs 1 gen 75261378560 flags DATA
> shared data backref parent 1079186604032 count 1
> item 79 key (94016372736 EXTENT_ITEM 524288) itemoff 13214 itemsize 37
> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 80 key (94016897024 EXTENT_ITEM 524288) itemoff 13177 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 81 key (94017421312 EXTENT_ITEM 524288) itemoff 13140 itemsize 37
> refs 1 gen 10 flags DATA
> shared data backref parent 1079186604032 count 1
> item 82 key (94017945600 EXTENT_ITEM 524288) itemoff 13103 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 83 key (94018469888 EXTENT_ITEM 524288) itemoff 13066 itemsize 37
> refs 1 gen 16290360 flags DATA
> shared data backref parent 1079186604032 count 1
> item 84 key (94018994176 EXTENT_ITEM 524288) itemoff 13029 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 85 key (94019518464 EXTENT_ITEM 524288) itemoff 12992 itemsize 37
> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 86 key (94020042752 EXTENT_ITEM 524288) itemoff 12955 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 87 key (94020567040 EXTENT_ITEM 524288) itemoff 12918 itemsize 37
> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 88 key (94021091328 EXTENT_ITEM 524288) itemoff 12881 itemsize 37
> refs 1 gen 11882841 flags DATA
> shared data backref parent 1079186604032 count 1
> item 89 key (94021615616 EXTENT_ITEM 524288) itemoff 12844 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 90 key (94022139904 EXTENT_ITEM 524288) itemoff 12807 itemsize 37
> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 91 key (94022664192 EXTENT_ITEM 524288) itemoff 12770 itemsize 37
> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 92 key (94023188480 EXTENT_ITEM 524288) itemoff 12733 itemsize 37
> refs 1 gen 11445336 flags DATA
> shared data backref parent 1079186604032 count 1
> item 93 key (94023712768 EXTENT_ITEM 524288) itemoff 12696 itemsize 37
> refs 1 gen 75270029312 flags DATA
> shared data backref parent 1079186604032 count 1
> item 94 key (94024237056 EXTENT_ITEM 524288) itemoff 12659 itemsize 37
> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 95 key (94024761344 EXTENT_ITEM 524288) itemoff 12622 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 96 key (94025285632 EXTENT_ITEM 524288) itemoff 12585 itemsize 37
> refs 1 gen 10 flags DATA
> shared data backref parent 1079186604032 count 1
> item 97 key (94025809920 EXTENT_ITEM 524288) itemoff 12548 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 98 key (94026334208 EXTENT_ITEM 524288) itemoff 12511 itemsize 37
> refs 1 gen 16290360 flags DATA
> shared data backref parent 1079186604032 count 1
> item 99 key (94026858496 EXTENT_ITEM 524288) itemoff 12474 itemsize 37
> refs 1 gen 171695243008 flags DATA
> shared data backref parent 1079186604032 count 1
> item 100 key (94027382784 EXTENT_ITEM 524288) itemoff 12437 itemsize 37=

> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 101 key (94027907072 EXTENT_ITEM 524288) itemoff 12400 itemsize 37=

> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 102 key (94028431360 EXTENT_ITEM 524288) itemoff 12363 itemsize 37=

> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 103 key (94028955648 EXTENT_ITEM 524288) itemoff 12326 itemsize 37=

> refs 1 gen 13102073 flags DATA
> shared data backref parent 1079186604032 count 1
> item 104 key (94029479936 EXTENT_ITEM 524288) itemoff 12289 itemsize 37=

> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 105 key (94030004224 EXTENT_ITEM 524288) itemoff 12252 itemsize 37=

> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 106 key (94030528512 EXTENT_ITEM 524288) itemoff 12215 itemsize 37=

> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 107 key (94031052800 EXTENT_ITEM 524288) itemoff 12178 itemsize 37=

> refs 1 gen 17409 flags DATA
> shared data backref parent 1079186604032 count 1
> item 108 key (94031577088 EXTENT_ITEM 524288) itemoff 12141 itemsize 37=

> refs 1 gen 11450200 flags DATA
> shared data backref parent 1079186604032 count 1
> item 109 key (94032101376 EXTENT_ITEM 524288) itemoff 12104 itemsize 37=

> refs 1 gen 75270389760 flags DATA
> shared data backref parent 1079186604032 count 1
> item 110 key (94032625664 EXTENT_ITEM 524288) itemoff 12067 itemsize 37=

> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 111 key (94033149952 EXTENT_ITEM 524288) itemoff 12030 itemsize 37=

> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 112 key (94033674240 EXTENT_ITEM 524288) itemoff 11993 itemsize 37=

> refs 1 gen 10 flags DATA
> shared data backref parent 1079186604032 count 1
> item 113 key (94034198528 EXTENT_ITEM 524288) itemoff 11956 itemsize 37=

> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 114 key (94034722816 EXTENT_ITEM 524288) itemoff 11919 itemsize 37=

> refs 1 gen 16290360 flags DATA
> shared data backref parent 1079186604032 count 1
> item 115 key (94035247104 EXTENT_ITEM 524288) itemoff 11882 itemsize 37=

> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 116 key (94035771392 EXTENT_ITEM 524288) itemoff 11845 itemsize 37=

> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 117 key (94036295680 EXTENT_ITEM 524288) itemoff 11808 itemsize 37=

> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 118 key (94036819968 EXTENT_ITEM 524288) itemoff 11771 itemsize 37=

> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 119 key (94037344256 EXTENT_ITEM 524288) itemoff 11734 itemsize 37=

> refs 1 gen 13102073 flags DATA
> shared data backref parent 1079186604032 count 1
> item 120 key (94037868544 EXTENT_ITEM 524288) itemoff 11697 itemsize 37=

> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 121 key (94038392832 EXTENT_ITEM 524288) itemoff 11660 itemsize 37=

> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 122 key (94038917120 EXTENT_ITEM 524288) itemoff 11623 itemsize 37=

> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 123 key (94039441408 EXTENT_ITEM 524288) itemoff 11586 itemsize 37=

> refs 1 gen 12545 flags DATA
> shared data backref parent 1079186604032 count 1
> item 124 key (94039965696 EXTENT_ITEM 524288) itemoff 11549 itemsize 37=

> refs 1 gen 11455064 flags DATA
> shared data backref parent 1079186604032 count 1
> item 125 key (94040489984 EXTENT_ITEM 524288) itemoff 11512 itemsize 37=

> refs 1 gen 75270766592 flags DATA
> shared data backref parent 1079186604032 count 1
> item 126 key (94041014272 EXTENT_ITEM 524288) itemoff 11475 itemsize 37=

> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 127 key (94041538560 EXTENT_ITEM 524288) itemoff 11438 itemsize 37=

> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 128 key (94042062848 EXTENT_ITEM 524288) itemoff 11401 itemsize 37=

> refs 1 gen 10 flags DATA
> shared data backref parent 1079186604032 count 1
> item 129 key (94042587136 EXTENT_ITEM 524288) itemoff 11364 itemsize 37=

> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 130 key (94043111424 EXTENT_ITEM 524288) itemoff 11327 itemsize 37=

> refs 1 gen 16290360 flags DATA
> shared data backref parent 1079186604032 count 1
> item 131 key (94043635712 EXTENT_ITEM 524288) itemoff 11290 itemsize 37=

> refs 1 gen 256 flags DATA
> shared data backref parent 1079186604032 count 1
> item 132 key (94044160000 EXTENT_ITEM 524288) itemoff 11253 itemsize 37=

> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 133 key (94044684288 EXTENT_ITEM 524288) itemoff 11216 itemsize 37=

> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 134 key (94045208576 EXTENT_ITEM 524288) itemoff 11179 itemsize 37=

> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 135 key (94045732864 EXTENT_ITEM 524288) itemoff 11142 itemsize 37=

> refs 1 gen 13102073 flags DATA
> shared data backref parent 1079186604032 count 1
> item 136 key (94046257152 EXTENT_ITEM 524288) itemoff 11105 itemsize 37=

> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 137 key (94046781440 EXTENT_ITEM 524288) itemoff 11068 itemsize 37=

> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 138 key (94047305728 EXTENT_ITEM 524288) itemoff 11031 itemsize 37=

> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 139 key (94047830016 EXTENT_ITEM 524288) itemoff 10994 itemsize 37=

> refs 1 gen 7681 flags DATA
> shared data backref parent 1079186604032 count 1
> item 140 key (94048354304 EXTENT_ITEM 524288) itemoff 10957 itemsize 37=

> refs 1 gen 11459928 flags DATA
> shared data backref parent 1079186604032 count 1
> item 141 key (94048878592 EXTENT_ITEM 524288) itemoff 10920 itemsize 37=

> refs 1 gen 75271110656 flags DATA
> shared data backref parent 1079186604032 count 1
> item 142 key (94049402880 EXTENT_ITEM 524288) itemoff 10883 itemsize 37=

> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 143 key (94049927168 EXTENT_ITEM 524288) itemoff 10846 itemsize 37=

> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 144 key (94050451456 EXTENT_ITEM 524288) itemoff 10809 itemsize 37=

> refs 1 gen 10 flags DATA
> shared data backref parent 1079186604032 count 1
> item 145 key (94050975744 EXTENT_ITEM 524288) itemoff 10772 itemsize 37=

> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 146 key (94051500032 EXTENT_ITEM 524288) itemoff 10735 itemsize 37=

> refs 1 gen 16290360 flags DATA
> shared data backref parent 1079186604032 count 1
> item 147 key (94052024320 EXTENT_ITEM 524288) itemoff 10698 itemsize 37=

> refs 1 gen 197656320 flags DATA
> shared data backref parent 1079186604032 count 1
> item 148 key (94052548608 EXTENT_ITEM 524288) itemoff 10661 itemsize 37=

> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 149 key (94053072896 EXTENT_ITEM 524288) itemoff 10624 itemsize 37=

> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 150 key (94053597184 EXTENT_ITEM 524288) itemoff 10587 itemsize 37=

> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 151 key (94054121472 EXTENT_ITEM 524288) itemoff 10550 itemsize 37=

> refs 1 gen 13102073 flags DATA
> shared data backref parent 1079186604032 count 1
> item 152 key (94054645760 EXTENT_ITEM 524288) itemoff 10513 itemsize 37=

> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 153 key (94055170048 EXTENT_ITEM 524288) itemoff 10476 itemsize 37=

> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 154 key (94055694336 EXTENT_ITEM 524288) itemoff 10439 itemsize 37=

> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 155 key (94056218624 EXTENT_ITEM 524288) itemoff 10402 itemsize 37=

> refs 1 gen 2817 flags DATA
> shared data backref parent 1079186604032 count 1
> item 156 key (94056742912 EXTENT_ITEM 524288) itemoff 10365 itemsize 37=

> refs 1 gen 11464792 flags DATA
> shared data backref parent 1079186604032 count 1
> item 157 key (94057267200 EXTENT_ITEM 524288) itemoff 10328 itemsize 37=

> refs 1 gen 75271487488 flags DATA
> shared data backref parent 1079186604032 count 1
> item 158 key (94057791488 EXTENT_ITEM 524288) itemoff 10291 itemsize 37=

> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 159 key (94058315776 EXTENT_ITEM 524288) itemoff 10254 itemsize 37=

> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 160 key (94058840064 EXTENT_ITEM 524288) itemoff 10217 itemsize 37=

> refs 1 gen 10 flags DATA
> shared data backref parent 1079186604032 count 1
> item 161 key (94059364352 EXTENT_ITEM 524288) itemoff 10180 itemsize 37=

> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 162 key (94059888640 EXTENT_ITEM 524288) itemoff 10143 itemsize 37=

> refs 1 gen 13839800 flags DATA
> shared data backref parent 1079186604032 count 1
> item 163 key (94060412928 EXTENT_ITEM 524288) itemoff 10106 itemsize 37=

> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 164 key (94060937216 EXTENT_ITEM 524288) itemoff 10069 itemsize 37=

> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 165 key (94061461504 EXTENT_ITEM 524288) itemoff 10032 itemsize 37=

> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 166 key (94061985792 EXTENT_ITEM 524288) itemoff 9995 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 167 key (94062510080 EXTENT_ITEM 524288) itemoff 9958 itemsize 37
> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 168 key (94063034368 EXTENT_ITEM 524288) itemoff 9921 itemsize 37
> refs 1 gen 16290361 flags DATA
> shared data backref parent 1079186604032 count 1
> item 169 key (94063558656 EXTENT_ITEM 524288) itemoff 9884 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 170 key (94064082944 EXTENT_ITEM 524288) itemoff 9847 itemsize 37
> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 171 key (94064607232 EXTENT_ITEM 524288) itemoff 9810 itemsize 37
> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 172 key (94065131520 EXTENT_ITEM 524288) itemoff 9773 itemsize 37
> refs 1 gen 19969 flags DATA
> shared data backref parent 1079186604032 count 1
> item 173 key (94065655808 EXTENT_ITEM 524288) itemoff 9736 itemsize 37
> refs 1 gen 11327176 flags DATA
> shared data backref parent 1079186604032 count 1
> item 174 key (94066180096 EXTENT_ITEM 524288) itemoff 9699 itemsize 37
> refs 1 gen 75263459328 flags DATA
> shared data backref parent 1079186604032 count 1
> item 175 key (94066704384 EXTENT_ITEM 524288) itemoff 9662 itemsize 37
> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 176 key (94067228672 EXTENT_ITEM 524288) itemoff 9625 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 177 key (94067752960 EXTENT_ITEM 524288) itemoff 9588 itemsize 37
> refs 1 gen 10 flags DATA
> shared data backref parent 1079186604032 count 1
> item 178 key (94068277248 EXTENT_ITEM 524288) itemoff 9551 itemsize 37
> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 179 key (94068801536 EXTENT_ITEM 524288) itemoff 9514 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 180 key (94069325824 EXTENT_ITEM 524288) itemoff 9477 itemsize 37
> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 181 key (94069850112 EXTENT_ITEM 524288) itemoff 9440 itemsize 37
> refs 1 gen 14688633 flags DATA
> shared data backref parent 1079186604032 count 1
> item 182 key (94070374400 EXTENT_ITEM 524288) itemoff 9403 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 183 key (94070898688 EXTENT_ITEM 233472) itemoff 9366 itemsize 37
> refs 1 gen 48 flags DATA
> shared data backref parent 1079186604032 count 1
> item 184 key (94071132160 EXTENT_ITEM 69632) itemoff 9329 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186620416 count 1
> item 185 key (94071205888 EXTENT_ITEM 8192) itemoff 9292 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186685952 count 1
> item 186 key (94071214080 EXTENT_ITEM 8192) itemoff 9255 itemsize 37
> refs 1 gen 12746457 flags DATA
> shared data backref parent 1079186685952 count 1
> item 187 key (94071222272 EXTENT_ITEM 4096) itemoff 9218 itemsize 37
> refs 1 gen 10 flags DATA
> shared data backref parent 1079186653184 count 1
> item 188 key (94071226368 EXTENT_ITEM 12288) itemoff 9181 itemsize 37
> refs 1 gen 3691922 flags DATA
> shared data backref parent 1080080089088 count 1
> item 189 key (94071238656 EXTENT_ITEM 524288) itemoff 9144 itemsize 37
> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 190 key (94071762944 EXTENT_ITEM 524288) itemoff 9107 itemsize 37
> refs 1 gen 1537 flags DATA
> shared data backref parent 1079186604032 count 1
> item 191 key (94072287232 EXTENT_ITEM 524288) itemoff 9070 itemsize 37
> refs 1 gen 13726920 flags DATA
> shared data backref parent 1079186604032 count 1
> item 192 key (94072811520 EXTENT_ITEM 524288) itemoff 9033 itemsize 37
> refs 1 gen 75208720384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 193 key (94073335808 EXTENT_ITEM 524288) itemoff 8996 itemsize 37
> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186604032 count 1
> item 194 key (94073860096 EXTENT_ITEM 524288) itemoff 8959 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 195 key (94074384384 EXTENT_ITEM 524288) itemoff 8922 itemsize 37
> refs 1 gen 2108088 flags DATA
> shared data backref parent 1079186604032 count 1
> item 196 key (94074908672 EXTENT_ITEM 524288) itemoff 8885 itemsize 37
> refs 1 gen 0 flags DATA
> shared data backref parent 1079186604032 count 1
> item 197 key (94075432960 EXTENT_ITEM 524288) itemoff 8848 itemsize 37
> refs 1 gen 140287904167864 flags DATA
> shared data backref parent 1079186604032 count 1
> item 198 key (94075957248 EXTENT_ITEM 524288) itemoff 8811 itemsize 37
> refs 1 gen 13722329 flags DATA
> shared data backref parent 1079186604032 count 1
> item 199 key (94076481536 EXTENT_ITEM 524288) itemoff 8774 itemsize 37
> refs 1 gen 18446744073709551606 flags DATA
> shared data backref parent 1079186604032 count 1
> item 200 key (94077005824 EXTENT_ITEM 524288) itemoff 8737 itemsize 37
> refs 1 gen 1 flags DATA
> shared data backref parent 1079186604032 count 1
> item 201 key (94077530112 EXTENT_ITEM 524288) itemoff 8700 itemsize 37
> refs 1 gen 48 flags DATA
> shared data backref parent 1079186620416 count 1
> item 202 key (94078054400 EXTENT_ITEM 524288) itemoff 8663 itemsize 37
> refs 1 gen 6433 flags DATA
> shared data backref parent 1079186620416 count 1
> item 203 key (94078578688 EXTENT_ITEM 524288) itemoff 8626 itemsize 37
> refs 1 gen 13535032 flags DATA
> shared data backref parent 1079186620416 count 1
> item 204 key (94079102976 EXTENT_ITEM 524288) itemoff 8589 itemsize 37
> refs 1 gen 75207835648 flags DATA
> shared data backref parent 1079186620416 count 1
> item 205 key (94079627264 EXTENT_ITEM 364544) itemoff 8552 itemsize 37
> refs 1 gen 16384 flags DATA
> shared data backref parent 1079186620416 count 1
>=20
> I'm kindly asking for help to fix this FS.
> I also would like to know the way to prevent and fix such kind of
> issues (except to never forcefully power off OS during IO-intensive
> operations).
>=20
> Thanks everyone!
>=20


--I4bQphwKdqcGYc4xmRQKTvsptFeFSro6q--

--qcsLsB5VxiAwe4HtdATi4w8ePOZ0QND9G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4RUQ0ACgkQwj2R86El
/qjxWAgApdlMNXfpTVs+hrPL7g2Z3+6TdE93ZKm4oYc7ke+ywY3ObZ2rp9d/BReN
xsccINqG2o8MVlKa9Ay457MBG4YAEGW7jAVwoQYzgr7SBAwZHy67JtTWuaUKnUCP
ZGGrCGJ4yZoppKQ2AMnurRh/qLDkaS8W2jW8WMbpIqFfAApwMZCaXlHtxcBk63O6
vlDQopzytV2Bha31sNeeLywPgtGeQwFVryAGxHQa53Cf9Iu0lRw37pW1yXbGumSZ
s3c1Rxpe++HM/+bSbgh7Ne0Z/IQdeKWr1zNA/vgIqkStmkl3yXhCfTVLtM1yxh5g
Hqng3KC+lVqfuys7m2iEGIz6hVCGOQ==
=hQd9
-----END PGP SIGNATURE-----

--qcsLsB5VxiAwe4HtdATi4w8ePOZ0QND9G--
