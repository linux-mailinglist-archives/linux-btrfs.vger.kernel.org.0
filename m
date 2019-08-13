Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47788BB03
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfHMOBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 10:01:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:37795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfHMOBl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 10:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565704897;
        bh=XeYd49cVuI95LfbXdcO2q6ch7BdlKw3riLTUa3TTqoI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a2Lmkb9d2NHF9QHbaMcvtuAnND3fCqLLm2iH3OF+25HHd/cE7Q2iOAtvNXCsvSFkS
         lx/yi1vKCa2Y9AshMwP7XITeIFQJWta7BHz6qBbtDHjXNxV1LHDhik3JNlcGItWek1
         So9Di5SO02FHw7885YybWY43RI+rhnJvN9BLEFr4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiacR-1iT2gy1zVf-00fhE9; Tue, 13
 Aug 2019 16:01:37 +0200
Subject: Re: btrfs errors
To:     "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <347523577.41.1565689723208.JavaMail.gkos@xpska>
 <8cdacece-32a3-daf7-3ac8-f062179ebbaf@gmx.com>
 <744798339.29.1565703591504.JavaMail.gkos@xpska>
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
Message-ID: <f2899154-3de6-3d8b-706c-539911831d17@gmx.com>
Date:   Tue, 13 Aug 2019 22:01:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <744798339.29.1565703591504.JavaMail.gkos@xpska>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DAJxOYlT7t5xT0zC58mX1JMLADkua8ujn"
X-Provags-ID: V03:K1:P2YsdkxDdqbachcu/onnPEFaZO3D/wcF0uVlFyZjzKyPbn7oKjO
 SgVpevXXa1n0QqCbPEEsB14k2J5yNfMA6ZnDxpyYTNi6hJ1+8/F0nSHljuGgL2HLGfzMraW
 /cEo3HLtTvhsgr7t9aJZ3AZZSMhky6yU2D6E/pooUM0Xz7yBW2a++PVa6Pxw1UmOuwQa7Fi
 FaicYIhHVOGGhOZKkCoUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FmQ1555jrqM=:ztB9B4XhwvrwfEeIV4b+sD
 SSJIE75hm71oH2UCoKEPQ50btPyNRQ+amiR28RR2z+i1hEmbiE5EdLBmojjaCC+HlBQE6cZ3A
 5Zkp2yYxSLjyUxKwuTiUE5Mdz+fxnYjwEjhSfNQLhLNTxzowfmnbN7zBgB8Y5cK6b/SCU7mgg
 P4kQdMW3NNA5ZjG7YFI225Ifp8APMtblvm80/bXjqKMKbYoL4ZURiQ4WVIy7RMHYSnZBmOeFa
 JtSkr1Yc+QlWdpafknhKE+aPeQC9R8vPX2GbP6ODhIyspKXIkf0IFovWe+psGNUbEmBxaykK1
 kXW1S+tbtFCDxO3eR/FoYcEGWcVipQLbh7Fx/fBInXavPOxmXzONlz9xArNo7dt/goSuBYeo+
 CRJkisvsR2pQnY7xEBxSRSAgNDPcMBH1nQ5Ng4f//GWF7qcWxdotHJiB7Y+dYbuhAQbJbv/a4
 KlOcQQolAlPZ5JBXrxSwkQemhFhYZfFIAx5zOirQy/HYn3o5xnJQIgKxD0QmgnLO1Y3usS6wj
 2cMAauJ0EfTQR6zmwvXuJ07kA4vp+8wl0gYsC27aQ81ysnbDfYujaKGeQA3gupDT7FbsB18RX
 O565cJRO88WBDGPbhof8RxZ493LC+RBscPoM28j8p61KQhtTKZyW1TwXU1ml9phKn2cjenwXt
 QuDPjD0YgPOi9/jZeYyzQ8FojdF8vEupp9+ibVFkRF2M+kU3Qugh3MUqDCaiigVTjihIm/fE/
 E02xE3G8vgaXfBuWuI9mqp9A7W4yTJ1bMiJh1SkpRcnct654z3FFyh+LKUiYiPtlArE1IjABx
 OsE3j3lCmuzPnOKtWtf/P3EDwQd7xJOmhKWA4liN82K5zwHZ3KL1K3vyDksGPtoDsOt27Ut3e
 vREj+2ddtVfSP/An5DU+c0bSksf5eU1gEwIBZ6FbJUB5Y+M5GnRCcyUZEdP3K6houIasYxeUJ
 P9YdweqIVsiLuPLzIC1I4yMtFyXV+LtNwjPv/hb2ie698QlbrPo6XEmW8loELYMvjkhB+N7bh
 b9lZmUOJOZ20RZK7VGrAGdfoTY613tNvUGZxGrkrGifZtREQLr5SL7hDdAp/dBn5IXIfUaVmU
 h15z5GBIXNLS9nSNLIIY+ri8l7YzeckjdCa29uR6lSB05edI3JrpQY7YAhaWSuZ8MDTlulLjq
 b6zYbk1Y9w2wk/YSMZfMtb02DMYQOKTQcE/t73s/sHG20Njg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DAJxOYlT7t5xT0zC58mX1JMLADkua8ujn
Content-Type: multipart/mixed; boundary="SLg6L2HPGdkZr9fHpMeCZlSXs3y1Eze4A";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <f2899154-3de6-3d8b-706c-539911831d17@gmx.com>
Subject: Re: btrfs errors
References: <347523577.41.1565689723208.JavaMail.gkos@xpska>
 <8cdacece-32a3-daf7-3ac8-f062179ebbaf@gmx.com>
 <744798339.29.1565703591504.JavaMail.gkos@xpska>
In-Reply-To: <744798339.29.1565703591504.JavaMail.gkos@xpska>

--SLg6L2HPGdkZr9fHpMeCZlSXs3y1Eze4A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/13 =E4=B8=8B=E5=8D=889:40, Konstantin V. Gavrilenko wrote:
>=20
> Hi Qu,
>=20
> thanks for the quick response. so I've booted into the latest Archiso (=
kernel 5.2.xx, btrfs 5.2.xx) and rerun the # btrfs check  and # btrfs scr=
ub. The btrfs check output is rather large and is included as an attachme=
nt to this message.
>=20
> It seems that the problem lies in fs_roots.
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots=20
> root 257 inode 6360900 errors 1000, some csum missing=20
> root 258 inode 364233 errors 1040, bad file extent, some csum missing
> root 258 inode 364234 errors 1040, bad file extent, some csum missing
> ....
> root 258 inode 5074178 errors 100, file extent discount
> Found file extent holes:
> 	start: 0, len: 4096
> root 258 inode 5386921 errors 1040, bad file extent, some csum missing
> ...
> ERROR: errors found in fs roots
>=20
>=20
> Opening filesystem to check...
> Checking filesystem on /dev/kubuntu-vg/lv_root
> UUID: 7b19fb5e-4e16-4b62-b803-f59364fd61a2
> cache and super generation don't match, space cache will be invalidated=

> found 335628447749 bytes used, error(s) found
> total csum bytes: 292272496
> total tree bytes: 5118279680
> total fs tree bytes: 4523163648
> total extent tree bytes: 244498432
> btree space waste bytes: 1186351226
> file data blocks allocated: 536719597568
>  referenced 630181720064

The result indeeds shows some *minor* problem.

One is "bad file extent" normally related to some extent too large for
compressed inlined extent.

Considering you're using lzo compression, it looks like some older
kernel behavior which is no longer considered sane nowadays.

You don't need to panic (never run btrfs check --repair yet), as your fs
is mostly fine, no data loss or whatever.

At least in recent kernel releases, you won't hit a problem.
>=20
>=20
> so I've mounted the FS and run scrub, which resulted in "ALL OK" again.=

> UUID:             7b19fb5e-4e16-4b62-b803-f59364fd61a2
> Scrub started:    Tue Aug 13 13:01:26 2019
> Status:           finished
> Duration:         0:02:44
> Total to scrub:   312.59GiB
> Rate:             1.91GiB/s
> Error summary:    no errors found
>=20
>=20
> I have backed up all the important data on the external disc just now, =
and no errors in the dmesg were reported, so I assume the data is OK.
> I also have snapshots of this system stored on the external disc dating=
 back to Apr'19.

Currently it looks like false alert.

But to be sure, please do me a favor by running lowmem mode check, which
should output more useful info other than "bad file extent".

# btrfs check --mode=3Dlowmem <dev>

It may take a longer time to finish. But should be more useful.

> So I guess the two important questions are=20
> - is it possible to reliable recover FS, or at least find out which fil=
es were affected  at the reported inode location.

If it's a false alert, you don't need to recover anything.

If it's too strict btrfs check, and you want to follow latest btrfs
*too sane* behavior, you can just try copy the old data to a newly
created btrfs.

Thanks,
Qu

> - is it possible to # btrfs check <snapshot> without copying it back on=
 the main disk. maybe loopdevice?
>=20
>=20
> thanks,
> Konstantin
>=20
>=20
> ----- Original Message -----
> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> To: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>, "linux-btrfs"=
 <linux-btrfs@vger.kernel.org>
> Sent: Tuesday, 13 August, 2019 12:55:47 PM
> Subject: Re: btrfs errors
>=20
>=20
>=20
> On 2019/8/13 =E4=B8=8B=E5=8D=885:48, Konstantin V. Gavrilenko wrote:
>> Hi list
>>
>> I have run the btrfs check, and that reported multiple errors on the F=
S.
>>
>> # btrfs check --readonly --force /dev/kubuntu-vg/lv_root
>> <SKIP>
>=20
> Please don't skip the output, especially for btrfs check.
>=20
> The first tree btrfs check checks is extent tree, if we have anything
> wrong in extent tree, it's way serious than the later part.
>=20
> And I understand you want to check your root fs, thus you have to use
> --force, but I'd recommend to go whatever distro you like, use its
> liveCD/USB to check your root fs.
>=20
> It looks like that since your fs is still mounted, the data structure
> changed during the btrfs check run, it's possible to cause false alert.=

>=20
>> root 9214 inode 6850330 errors 2001, no inode item, link count wrong
>>         unresolved ref dir 266982 index 22459 namelen 36 name 96210410=
45a17a475428a26fcfb5982f.png filetype 1 errors 6, no dir index, no inode =
ref
>>         unresolved ref dir 226516 index 9 namelen 28 name GYTSPMxjwCVp=
8kXB7+j91O8kcq4=3D filetype 1 errors 4, no inode ref
>> root 9214 inode 6877070 errors 2001, no inode item, link count wrong
>>         unresolved ref dir 226516 index 11 namelen 28 name VSqlYzl4pFq=
JpvC3GA9bQ0mZK8A=3D filetype 1 errors 4, no inode ref
>> root 9214 inode 6878054 errors 2001, no inode item, link count wrong
>>         unresolved ref dir 266982 index 22460 namelen 36 name 52e74e9d=
2b6f598038486f90f8f911c4.png filetype 1 errors 4, no inode ref
>> root 9214 inode 6888414 errors 2001, no inode item, link count wrong
>>         unresolved ref dir 226391 index 122475 namelen 14 name the-rea=
l-index filetype 1 errors 4, no inode ref
>> root 9214 inode 6889202 errors 100, file extent discount
>> Found file extent holes:
>>         start: 0, len: 4096
>> root 9214 inode 6889203 errors 100, file extent discount
>> Found file extent holes:
>>         start: 0, len: 4096
>> ERROR: errors found in fs roots
>> found 334531551237 bytes used, error(s) found
>> total csum bytes: 291555464
>> total tree bytes: 1004404736
>> total fs tree bytes: 411713536
>> total extent tree bytes: 242974720
>> btree space waste bytes: 186523621
>> file data blocks allocated: 36730163200
>>  referenced 42646511616
>>
>>
>> However, scrub and badblock find no errors.
>>
>> # btrfs scrub status /mnt/
>> scrub status for 7b19fb5e-4e16-4b62-b803-f59364fd61a2
>>         scrub started at Tue Aug 13 07:31:38 2019 and finished after 0=
0:02:47
>>         total bytes scrubbed: 311.15GiB with 0 errors
>=20
> Scrub only checks checksum, doesn't care the content.
> (Kernel newer than v5.0 will care the content, but doesn't do full
> cross-check, unlike btrfs-check)
>=20
>>
>> # badblocks -sv /dev/kubuntu-vg/lv_root=20
>> Checking blocks 0 to 352133119
>> Checking for bad blocks (read-only test):  done                       =
                         =20
>> Pass completed, 0 bad blocks found. (0/0/0 errors)
>>
>> # btrfs dev stats /dev/kubuntu-vg/lv_root                             =
                                                                         =
                                                =20
>> [/dev/mapper/kubuntu--vg-lv_root].write_io_errs    0
>> [/dev/mapper/kubuntu--vg-lv_root].read_io_errs     0
>> [/dev/mapper/kubuntu--vg-lv_root].flush_io_errs    0
>> [/dev/mapper/kubuntu--vg-lv_root].corruption_errs  0
>> [/dev/mapper/kubuntu--vg-lv_root].generation_errs  0
>>
>>
>>
>> FS mount fine, and is operational.
>> would you recommend executing the btrfs check --repair option or is th=
ere something else that I can try.
>=20
> Don't do anything stupid yet.
> Just go LiveCD/USB and check again.
>=20
>>
>> #  uname -a                                                           =
                                                                         =
                                                     Linux xps 5.1.16-050=
116-generic #201907031232 SMP Wed Jul 3 12:35:21 UTC 2019 x86_64 x86_64 x=
86_64 GNU/Linux
>=20
> Since v5.2 introduced a lot of new restrict check, I'd recommend to go
> mount with latest Archiso, btrfs-check first, if no problem, mount and
> scrub again just in case.
>=20
>> # btrfs --version                                                     =
                                                                         =
                                                =20
>> btrfs-progs v4.15.1
>=20
> Big nope. You won't really want to run btrfs check --repair on such old=

> and buggy progs. Unless recent releases (5.2?) btrfs-progs has a bug
> that transaction is not committed correctly, thus if something wrong
> happened like BUG_ON() or transaction aborted, the fs can easily be
> screwed up.
>=20
> Thanks,
> Qu
>=20
>>
>>
>> mount options
>> on / type btrfs (rw,relatime,compress-force=3Dlzo,ssd,discard,space_ca=
che=3Dv2,autodefrag,subvol=3D/@)
>>
>> thanks,
>> Konstantin
>>
>=20


--SLg6L2HPGdkZr9fHpMeCZlSXs3y1Eze4A--

--DAJxOYlT7t5xT0zC58mX1JMLADkua8ujn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1SwroACgkQwj2R86El
/qgenQgApr/XN/EV58BswuOz77EwrCY1XZUYsFxnJtogXeCcT/T0fecVztfWWHOm
qIrJKPxpPCgNMcHaIRakCPgLHaIXJORcvHhwvcFIc4J0ZCsm8JdM5MPgpact2/B0
63Ne0Mco03F+LbnAL6wuIURHiTwoCJg+JH6H6pRmi+JehZmJ0snwYr23YYMMTM4z
AiMUv3DTnZA+e6wm/Edl9mlQDNC/Thf67eLqJs57+Knx2DeGcrlo70uM+LwGvfEr
brqYkLLPEa1hnwrVk0vd2gml+mnP0zqd3YHfPi2WERMTn+54MufgwoVWgo8yslCY
cLUCW6Z/befKgXN6bvLCpiI6aFz7gA==
=iMaM
-----END PGP SIGNATURE-----

--DAJxOYlT7t5xT0zC58mX1JMLADkua8ujn--
