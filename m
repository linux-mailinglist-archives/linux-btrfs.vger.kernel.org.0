Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED3B83388
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 16:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbfHFOF1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 10:05:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:52013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbfHFOF1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 10:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565100297;
        bh=pTfUz/LjmAufFmooCxqZ3LpqysaFxqmJhoIvFevPSR4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EFIdJ3eY4kWV5mtMjnGk6xZjIQLwT5w81iKSq5+mkk99GiYKZV1SePgSFsVSZzaag
         m8XrbSFlo3VeDdttopKL6WbNowh/dkf9qvU0EqmYXK5W8uRql8Ivab8newMtAx3PIq
         NLmqPCixKHH0roFB5BiFy3g7uDU8AjtV5WSL4IdI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MTfZc-1hmIw42k76-00QPEA; Tue, 06
 Aug 2019 16:04:57 +0200
Subject: Re: [PATCH v2 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-4-wqu@suse.com> <20190806135818.GK28208@twin.jikos.cz>
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
Message-ID: <1ee4b55b-8453-e07f-70dc-fa56eb15e0ad@gmx.com>
Date:   Tue, 6 Aug 2019 22:04:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806135818.GK28208@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CuNSWDEVHBBiVY9hdjy9uUXgLo4g54Hfj"
X-Provags-ID: V03:K1:blvaG6LFkORT9MZqbVdU0HttMfYc20VPlYimBg2lcsqc3j6i+BN
 S219whgRI+BscL6XH7Sjx+8s86I56UdEvNZWgqEFAuducO98o6WeZRPsX8fwQZ43j5ljFkS
 JPT7BjIniS2b6I6xk1BzzLhjN2HY6LIPwTH9bCdpaEi854bfK7B0O/4KTL3m4EemSrz982m
 YcPVbsNuQeJ4NGMWDghNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kx+MOASiarU=:+hBOaX/RiutSUAAT/uVcny
 N7/CbEvNJoawjJ61S3sP9K6PDdOs4RGkePgtuHApnZhyuiWz5s+DozzAt3qNLCVyzqfxjvtPk
 Z0efOLa9U35NTuf15PLekDViIQbtdJ20P2b3IWjJ1Hdkm4f2nqYVt1ZYf70LTRigsqKdMfzDY
 fCxWybJjSfcGJC8Ae7afCYq98O0Cv9vPUwhAD6m3fyEsQxxux0WxAB+LX1oPqpfWTgvDF86ec
 jm6kTqZvbC/eFhFE0mxoiHzBeiV1glnTPaz82czhSTXiS8jn1jO4XfT/ZuLpd2iA8vA+TpjMN
 h+TJR1Rq+OZDGXf5mm6YTx6XtZr1Axy+HFzmjKEgHAnbqEzv0f1HWxaOmKhiOFfX7uSks0LMG
 8Dds/kzYDRvNhe89glNXdixBfVGRFK/p3KcIMPDtZn06VbKEwICU8+jZL3DRq5wsYOfDbAhLg
 qRLmEUWFyKdkBCWCyzBZiqPY+2uli4FYFN0Inzgqz45HU3XZ4472ljlFAaj/4buw7mU81hLNz
 yHrt3aR9szF7SYHh5Zc1mafYI9h65Ld5zXCLAUlvmTwqtliuCW4XYcrcKhIjcLldin6qdcpza
 gs9W5TaIDGi6SGs1QdXsHaWYT19o5T2CpkT2I/WOpO3IP3WfDq+l/4wP5MpA0VLiUazZYT/VC
 wrhkC5IBYBHbVTi72DeHAIF5dlqfHZk+jHScLgJa5JaAoHH3sxu79kiTa1IbPAjzYJhVWLXVf
 mLK5mSf4jQuJJ9l5whIDlHUY3PioZ2Gy7QUKtncUmNQeQrz9LT7F8HS+DUUnXSCpuBe2ZGtAj
 fxJ4ONuMSrPsv97hxk+euLlU3xGz2NS/k35saFvBjYxCR3w7WUz49QI+YEaa+xuLc1wo89Ov4
 juWZeT1wo6WQEIiwV03/AtVvALuiWGs53m1R1LP8hV9oYanOx6XrUZCAV7TuSv1y9wzHysU1D
 4BJtKyLeEry55dxs096d6Cwg4LYfr6vldurhIhw7UrFhUJQYorWEvwAuUoloIC+2YZGrwkisz
 XeD1RLXmWA9XpmgSjr1AVFElB+ihV+s48x/2DzM7mxcaDqff61RnL4re9OxUMmwbTwxeCd68L
 iGwVJpGwbBAokoYZCbwEoI3hBfjlfCs5WiT23AAMaHpBk0qvRckbYD6vA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CuNSWDEVHBBiVY9hdjy9uUXgLo4g54Hfj
Content-Type: multipart/mixed; boundary="TS8Teh5ufgeXXBLUDndX5mmOfHyjNvuOW";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <1ee4b55b-8453-e07f-70dc-fa56eb15e0ad@gmx.com>
Subject: Re: [PATCH v2 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-4-wqu@suse.com> <20190806135818.GK28208@twin.jikos.cz>
In-Reply-To: <20190806135818.GK28208@twin.jikos.cz>

--TS8Teh5ufgeXXBLUDndX5mmOfHyjNvuOW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/6 =E4=B8=8B=E5=8D=889:58, David Sterba wrote:
> On Thu, Jul 25, 2019 at 02:12:20PM +0800, Qu Wenruo wrote:
>> =20
>>  	if (!first_key)
>>  		return 0;
>> +	/* We have @first_key, so this @eb must have at least one item */
>> +	if (btrfs_header_nritems(eb) =3D=3D 0) {
>> +		btrfs_err(fs_info,
>> +		"invalid tree nritems, bytenr=3D%llu nritems=3D0 expect >0",
>> +			  eb->start);
>> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +		return -EUCLEAN;
>> +	}
>=20
> generic/015 complains:
>=20
> generic/015             [13:51:40][ 5949.416657] run fstests generic/01=
5 at 2019-08-06 13:51:40

I hit this once, but not this test case.
The same backtrace for csum tree.

Have you ever hit it again?

Thanks,
Qu

> [ 5949.603473] BTRFS: device fsid 6a7e1bd0-42d2-4bab-9d9e-791635466751 =
devid 1 transid 5 /dev/vdb
> [ 5949.616969] BTRFS info (device vdb): turning on discard
> [ 5949.619414] BTRFS info (device vdb): disk space caching is enabled
> [ 5949.622493] BTRFS info (device vdb): has skinny extents
> [ 5949.624694] BTRFS info (device vdb): flagging fs with big metadata f=
eature
> [ 5949.629003] BTRFS info (device vdb): checking UUID tree
> [ 5949.802548] BTRFS error (device vdb): invalid tree nritems, bytenr=3D=
30736384 nritems=3D0 expect >0
> [ 5949.806259] ------------[ cut here ]------------
> [ 5949.808127] WARNING: CPU: 1 PID: 27019 at fs/btrfs/disk-io.c:417 btr=
fs_verify_level_key.cold+0x1e/0x2b [btrfs]
> [ 5949.811946] Modules linked in: dm_log_writes dm_flakey dm_mod btrfs =
libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop af_packe=
t
> [ 5949.816321] CPU: 1 PID: 27019 Comm: kworker/u8:10 Tainted: G        =
W         5.3.0-rc3-next-20190806-default #5
> [ 5949.819269] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
> [ 5949.822202] Workqueue: btrfs-endio-write btrfs_endio_write_helper [b=
trfs]
> [ 5949.824231] RIP: 0010:btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
> [ 5949.825348] Code: ff ff e8 9f c8 ff ff e9 4d 58 f5 ff 48 8b 13 48 c7=
 c6 48 9c 48 c0 48 89 ef e8 88 c8 ff ff 48 c7 c7 c0 95 48 c0 e8 c0 e9 c6 =
df <0f> 0b 41 be 8b ff ff ff e9 dd 5a f5 ff be e9 05 00 00 48 c7
>  c7 40
> [ 5949.828251] RSP: 0018:ffffab1288803ab8 EFLAGS: 00010246
> [ 5949.829759] RAX: 0000000000000024 RBX: ffff9d4f6ed47b10 RCX: 0000000=
000000001
> [ 5949.830961] RDX: 0000000000000000 RSI: 0000000000000001 RDI: fffffff=
fa00d02ca
> [ 5949.832107] RBP: ffff9d4f60568000 R08: 0000000000000000 R09: 0000000=
000000000
> [ 5949.833414] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000006
> [ 5949.834508] R13: ffffab1288803b6e R14: ffff9d4f3325e850 R15: 0000000=
000000000
> [ 5949.835572] FS:  0000000000000000(0000) GS:ffff9d4f7d800000(0000) kn=
lGS:0000000000000000
> [ 5949.837190] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5949.838135] CR2: 00005645c3a0c078 CR3: 0000000014011000 CR4: 0000000=
0000006e0
> [ 5949.839197] Call Trace:
> [ 5949.839729]  read_block_for_search.isra.0+0x13d/0x3d0 [btrfs]
> [ 5949.840909]  btrfs_search_slot+0x25d/0xc10 [btrfs]
> [ 5949.841796]  btrfs_lookup_csum+0x6a/0x160 [btrfs]
> [ 5949.842561]  ? kmem_cache_alloc+0x1f2/0x280
> [ 5949.843268]  btrfs_csum_file_blocks+0x198/0x6f0 [btrfs]
> [ 5949.844305]  add_pending_csums+0x50/0x70 [btrfs]
> [ 5949.845553]  btrfs_finish_ordered_io+0x3cb/0x7f0 [btrfs]
> [ 5949.846963]  normal_work_helper+0xd1/0x540 [btrfs]
> [ 5949.848258]  process_one_work+0x22d/0x580
> [ 5949.849337]  worker_thread+0x50/0x3b0
> [ 5949.850361]  kthread+0xfe/0x140
> [ 5949.851267]  ? process_one_work+0x580/0x580
> [ 5949.852405]  ? kthread_park+0x80/0x80
> [ 5949.853429]  ret_from_fork+0x24/0x30
> [ 5949.854422] irq event stamp: 0
> [ 5949.855341] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 5949.856688] hardirqs last disabled at (0): [<ffffffffa005ff00>] copy=
_process+0x6d0/0x1ac0
> [ 5949.858104] softirqs last  enabled at (0): [<ffffffffa005ff00>] copy=
_process+0x6d0/0x1ac0
> [ 5949.859400] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 5949.860611] ---[ end trace f6f3adf90f4ea40f ]---
> [ 5949.862745] ------------[ cut here ]------------
> [ 5949.864103] BTRFS: Transaction aborted (error -117)
> [ 5949.865577] WARNING: CPU: 1 PID: 27019 at fs/btrfs/inode.c:3175 btrf=
s_finish_ordered_io+0x781/0x7f0 [btrfs]
> [ 5949.868267] Modules linked in: dm_log_writes dm_flakey dm_mod btrfs =
libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop af_packe=
t
> [ 5949.872781] CPU: 1 PID: 27019 Comm: kworker/u8:10 Tainted: G        =
W         5.3.0-rc3-next-20190806-default #5
> [ 5949.875535] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
> [ 5949.878428] Workqueue: btrfs-endio-write btrfs_endio_write_helper [b=
trfs]
> [ 5949.880211] RIP: 0010:btrfs_finish_ordered_io+0x781/0x7f0 [btrfs]
> [ 5949.881317] Code: e9 aa fc ff ff 49 8b 47 50 f0 48 0f ba a8 e8 33 00=
 00 02 72 17 41 83 fd fb 74 5b 44 89 ee 48 c7 c7 08 b4 48 c0 e8 22 55 c9 =
df <0f> 0b 44 89 e9 ba 67 0c 00 00 eb b0 88 5c 24 10 41 89 de 41
>  bd fb
>=20


--TS8Teh5ufgeXXBLUDndX5mmOfHyjNvuOW--

--CuNSWDEVHBBiVY9hdjy9uUXgLo4g54Hfj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1JiQMACgkQwj2R86El
/qjfVAf/aR9GrxO5TGjlU969YN5xbGzi5jOoifZIaLyLWW9KsnVP75d+gy+HRXOU
KHdlQgSc/bBYDyNE+99Vv3KBVgWQoNqcoQFbykyeL1+b+B8Fvvodsr9Y/nqx8Oz/
0xs1W1UAdna5/tSdMoFH3F4dNAe5xF3QEbI8IFLGkdionns26poKIH7XdzuuY0LS
1UZrnzh3jjMb+CS+vcIWXA7gGGksk+sJOEpoVGRhW9TeUBTFrzN32K3qC8kE6rZD
j0h6wgE1smvsLGbM+XZIyUVU5yXj6s9TrUjY9NWOZH+IzkDK0Zmk/0VGm7ODYmMW
3yLuz0nnqpbvttrtPpZZh9vMmKZRuQ==
=V0jW
-----END PGP SIGNATURE-----

--CuNSWDEVHBBiVY9hdjy9uUXgLo4g54Hfj--
