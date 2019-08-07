Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2E984268
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 04:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfHGCXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 22:23:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:41637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbfHGCXD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 22:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565144551;
        bh=XzNDeOX88eTcLNsovZOygDYzBMLEhma08r6xkG+cFHU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Qn5Vj7UtB/9nKVYSxFuDc/stPETkr8veW72SpcU+mIOFoLUZsyFjL04vQllSOwTy1
         k5erAI+NXH+a9ftW0iMweeu35voiu231/oJsFwJhFHiq2AU75FPIulRBuoXIcoOehg
         ZELolBCLZSAQBZnf9/QVK9oAk6naUnH98/iBurYU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNKhm-1hfIbs1HwI-00Orl3; Wed, 07
 Aug 2019 04:22:31 +0200
Subject: Re: [PATCH v2 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-4-wqu@suse.com> <20190806135818.GK28208@twin.jikos.cz>
 <1ee4b55b-8453-e07f-70dc-fa56eb15e0ad@gmx.com>
 <20190806174733.GP28208@twin.jikos.cz>
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
Message-ID: <43169162-e57f-234d-a9cd-2d10d9700741@gmx.com>
Date:   Wed, 7 Aug 2019 10:22:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806174733.GP28208@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SS9jm6TYywLLigvBo4v4SIPHZSz3j8ulp"
X-Provags-ID: V03:K1:thu2dXN2vihyxzurin6fF6eav+qB8DkKJzl1D4ITLIf8nCswvnK
 GKlERpBb9sZWuYM8NmwMRX1kWBcMuZHuI0eztWkDxvkqhmDS5TP+kK+UcBCu20wyF0Pde72
 OYvAIhmkjg4L7TSN3qFbgKUl1W2GHjMAw7DlQLir+p+yhtvGeCRJYS3JHcRr/TyUVN8ba5J
 Ih5O8xX6N+n4PJyEZVr0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hzk7UO00DlM=:IBFjYiyOqqRy4Ub7gf6JgK
 HVq4wFPm+NJOsWCzydj3eXuHOVbwjvcOl8mHmpQ30cbgAMAewOHVk0G0dsKCeEWSxgXVQ42S1
 QwtE571DFQGN1UwwZi3Syc7/ee7WAai0Awo3OcTUxA+JAkjtHyP0N7Fo5XJ22zj3WBE0d2vdB
 SegHix3ibpcg9avr7aiING4/wYiOdITqJVKlo1IaAutlLgli7fJCueKwjFFNh3eN9T7BAeaOe
 jaulmsmFqa+yxEC8k5dxVcL+xM+naakkUaR6xFY393Qjhj4zVP6Jzbm0niema6l6fm9twv0oP
 VMDFJ8cFTDUO43/sjUFaQPm6MbdkMrAR7dFQ9+mtks42vl9wgMEKlt1D3r08NuLHQiG4n/FfS
 dGg5qJpuVd5U4PlEPKmHH2HYNQbFfTJ5QcmrB/Qk4V/Se50rlxExEWlQWBGOcIrpTvbZr55V5
 zxlzfiCGNqxCr2kwfJAZxy96mYJJxXYr3IWX+JkYVZhhV4nXk0h+lOyUYsQ+MAYkXwogUkSrT
 4IRTQyLacHe2XvLWoRUj6mD7vEKOnz+Oufu4u+7Y7I5yqCnc9f3kgixWtNdGdP/cLjLDwN3A6
 /uZYGlCut25ocLIzlqhjSpPnqlNmxMJmu3XT1d4zmqTbfY2VGiXMRwdKxe9+DIat0vyoxVzho
 Do7dcLJOAoSZp6qjR0Nnz/cNO9Mto8jtYJVW2XP99pE5CgHCTo441lyR5psmyzC+RFpxXfK5G
 Y/Xb9DocUONgoYcRxKt6bBU6t7odX4mZx5aSGRYmcGN1e7SNPAaSpSGczodFD6qe2lyB0n/Bm
 PpNThWUixF5Rexsva+3HMKYoIQ3bFzprYEmpLS7P28Wc0CotLWTywYyM3sbceSgZ4FIAMKtgl
 ZlUz3VAeIVJXSOhWT35VUfY6CPvyY4NJ1NlRXWJ0E9OPIEQjYt4GpMbUhGx4pf5c6pOLx9lRS
 qU+OEQVMB4REivkf1DwBn2QsefWWrXKMY0Hbi88mgGHw37lZfgc5BGPPxYCUB4LZRL940ip9E
 CfJWpRqPgiIne8poSmhqMK9tVy8WEaiARAD26eTnBBdjS5pOPC1hy4pQIw/OxLjfhk5s+sdK+
 JRE4ob0BsSn02Yg8m4UVrPhhlwksqBwVOkRkTmhCslTaSwW//LXNPWpaQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SS9jm6TYywLLigvBo4v4SIPHZSz3j8ulp
Content-Type: multipart/mixed; boundary="fl3v1MVaRL3TqlHYROiTFIQlpfjPEBlCA";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <43169162-e57f-234d-a9cd-2d10d9700741@gmx.com>
Subject: Re: [PATCH v2 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-4-wqu@suse.com> <20190806135818.GK28208@twin.jikos.cz>
 <1ee4b55b-8453-e07f-70dc-fa56eb15e0ad@gmx.com>
 <20190806174733.GP28208@twin.jikos.cz>
In-Reply-To: <20190806174733.GP28208@twin.jikos.cz>

--fl3v1MVaRL3TqlHYROiTFIQlpfjPEBlCA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/7 =E4=B8=8A=E5=8D=881:47, David Sterba wrote:
> On Tue, Aug 06, 2019 at 10:04:51PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/8/6 =E4=B8=8B=E5=8D=889:58, David Sterba wrote:
>>> On Thu, Jul 25, 2019 at 02:12:20PM +0800, Qu Wenruo wrote:
>>>> =20
>>>>  	if (!first_key)
>>>>  		return 0;
>>>> +	/* We have @first_key, so this @eb must have at least one item */
>>>> +	if (btrfs_header_nritems(eb) =3D=3D 0) {
>>>> +		btrfs_err(fs_info,
>>>> +		"invalid tree nritems, bytenr=3D%llu nritems=3D0 expect >0",
>>>> +			  eb->start);
>>>> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>>>> +		return -EUCLEAN;
>>>> +	}
>>>
>>> generic/015 complains:
>>>
>>> generic/015             [13:51:40][ 5949.416657] run fstests generic/=
015 at 2019-08-06 13:51:40
>>
>> I hit this once, but not this test case.
>> The same backtrace for csum tree.
>>
>> Have you ever hit it again?
>=20
> Yes I found a few more occurences, the last one seems to be interesting=
 so it's
> pasted as-is.
>=20

Thanks for all the traces.

Although they are all btrfs_search_slot(), I'm not sure if it's a
unexposed a race or just false alert.

Please discard that patch for now.

I'll keep digging into the case.

Thanks,
Qu

> generic/449
>=20
> [21423.875017]  read_block_for_search+0x144/0x380 [btrfs]
> [21423.876433]  btrfs_search_slot+0x297/0xfc0 [btrfs]
> [21423.877830]  ? btrfs_update_delayed_refs_rsv+0x59/0x70 [btrfs]
> [21423.880038]  btrfs_lookup_csum+0xa9/0x210 [btrfs]
> [21423.881304]  btrfs_csum_file_blocks+0x205/0x800 [btrfs]
> [21423.882674]  ? unpin_extent_cache+0x27/0xc0 [btrfs]
> [21423.884050]  add_pending_csums+0x50/0x70 [btrfs]
> [21423.885285]  btrfs_finish_ordered_io+0x403/0x7b0 [btrfs]
> [21423.886781]  ? _raw_spin_unlock_bh+0x30/0x40
> [21423.888164]  normal_work_helper+0xe2/0x520 [btrfs]
> [21423.889521]  process_one_work+0x22f/0x5b0
> [21423.890332]  worker_thread+0x50/0x3b0
> [21423.891001]  ? process_one_work+0x5b0/0x5b0
> [21423.892025]  kthread+0x11a/0x130
>=20
> generic/511
>=20
> [45857.582982]  read_block_for_search+0x144/0x380 [btrfs]
> [45857.584197]  btrfs_search_slot+0x297/0xfc0 [btrfs]
> [45857.585363]  ? btrfs_update_delayed_refs_rsv+0x59/0x70 [btrfs]
> [45857.586758]  btrfs_lookup_csum+0xa9/0x210 [btrfs]
> [45857.587919]  btrfs_csum_file_blocks+0x205/0x800 [btrfs]
> [45857.589023]  ? unpin_extent_cache+0x27/0xc0 [btrfs]
> [45857.590311]  add_pending_csums+0x50/0x70 [btrfs]
> [45857.591482]  btrfs_finish_ordered_io+0x403/0x7b0 [btrfs]
> [45857.592671]  ? _raw_spin_unlock_bh+0x30/0x40
> [45857.593759]  normal_work_helper+0xe2/0x520 [btrfs]
> [45857.595274]  process_one_work+0x22f/0x5b0
> [45857.596372]  worker_thread+0x50/0x3b0
> [45857.597221]  ? process_one_work+0x5b0/0x5b0
> [45857.598438]  kthread+0x11a/0x130
>=20
> generic/129
>=20
> [ 7512.874839] BTRFS info (device vda): disk space caching is enabled
> [ 7512.877660] BTRFS info (device vda): has skinny extents
> [ 7512.951947] BTRFS: device fsid 815ae95d-a328-472d-8299-a373d67af54e =
devid 1 transid 5 /dev/vdb
> [ 7512.969169] BTRFS info (device vdb): turning on discard
> [ 7512.971138] BTRFS info (device vdb): disk space caching is enabled
> [ 7512.973506] BTRFS info (device vdb): has skinny extents
> [ 7512.975497] BTRFS info (device vdb): flagging fs with big metadata f=
eature
> [ 7513.005926] BTRFS info (device vdb): checking UUID tree
> [ 7513.395115] ------------[ cut here ]------------
> [ 7513.395120] BTRFS error (device vdb): invalid tree nritems, bytenr=3D=
30736384 nritems=3D0 expect >0
> [ 7513.395122] ------------[ cut here ]------------
> [ 7513.395124] BTRFS error (device vdb): invalid tree nritems, bytenr=3D=
30736384 nritems=3D0 expect >0
> [ 7513.395125] ------------[ cut here ]------------
> [ 7513.395185] WARNING: CPU: 1 PID: 17085 at fs/btrfs/disk-io.c:417 btr=
fs_verify_level_key.cold+0x1e/0x2b [btrfs]
> [ 7513.395186] Modules linked in: dm_snapshot dm_bufio dm_log_writes dm=
_flakey dm_mod btrfs libcrc32c xor zstd_decompress zstd_compress xxhash r=
aid6_pq loop af_packet [last unloaded: scsi_debug]
> [ 7513.395193] CPU: 1 PID: 17085 Comm: kworker/u8:4 Tainted: G        W=
         5.3.0-rc3-next-20190806-default #5
> [ 7513.395194] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
> [ 7513.395212] Workqueue: btrfs-endio-write btrfs_endio_write_helper [b=
trfs]
> [ 7513.395230] RIP: 0010:btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
> [ 7513.395232] Code: ff ff e8 9f c8 ff ff e9 4d 58 f5 ff 48 8b 13 48 c7=
 c6 48 9c 48 c0 48 89 ef e8 88 c8 ff ff 48 c7 c7 c0 95 48 c0 e8 c0 e9 c6 =
df <0f> 0b 41 be 8b ff ff ff e9 dd 5a f5 ff be e9 05 00 00 48 c7 c7 40
> [ 7513.395232] RSP: 0018:ffffab1286483ab8 EFLAGS: 00010246
> [ 7513.395233] RAX: 0000000000000024 RBX: ffff9d4f06a493b0 RCX: 0000000=
000000001
> [ 7513.395234] RDX: 0000000000000000 RSI: 0000000000000001 RDI: fffffff=
fa00d1ca8
> [ 7513.395235] RBP: ffff9d4f069d4000 R08: 0000000000000000 R09: 0000000=
000000000
> [ 7513.395235] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000006
> [ 7513.395247] R13: ffffab1286483b6e R14: ffff9d4f2267aaf0 R15: 0000000=
000000000
> [ 7513.395251] FS:  0000000000000000(0000) GS:ffff9d4f7d800000(0000) kn=
lGS:0000000000000000
> [ 7513.395252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7513.395253] CR2: 00007f5d921edef4 CR3: 0000000014011000 CR4: 0000000=
0000006e0
> [ 7513.395254] Call Trace:
> [ 7513.395277]  read_block_for_search.isra.0+0x13d/0x3d0 [btrfs]
> [ 7513.395300]  btrfs_search_slot+0x25d/0xc10 [btrfs]
> [ 7513.395325]  btrfs_lookup_csum+0x6a/0x160 [btrfs]
> [ 7513.395330]  ? kmem_cache_alloc+0x1f2/0x280
> [ 7513.395354]  btrfs_csum_file_blocks+0x198/0x6f0 [btrfs]
> [ 7513.395378]  add_pending_csums+0x50/0x70 [btrfs]
> [ 7513.395403]  btrfs_finish_ordered_io+0x3cb/0x7f0 [btrfs]
> [ 7513.395432]  normal_work_helper+0xd1/0x540 [btrfs]
> [ 7513.395437]  process_one_work+0x22d/0x580
> [ 7513.395440]  worker_thread+0x50/0x3b0
> [ 7513.395443]  kthread+0xfe/0x140
> [ 7513.395446]  ? process_one_work+0x580/0x580
> [ 7513.395447]  ? kthread_park+0x80/0x80
> [ 7513.395452]  ret_from_fork+0x24/0x30
> [ 7513.395454] irq event stamp: 0
> [ 7513.395457] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 7513.395461] hardirqs last disabled at (0): [<ffffffffa005ff00>] copy=
_process+0x6d0/0x1ac0
> [ 7513.395463] softirqs last  enabled at (0): [<ffffffffa005ff00>] copy=
_process+0x6d0/0x1ac0
> [ 7513.395465] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 7513.395466] ---[ end trace f6f3adf90f4ea411 ]---
> [ 7513.395470] ------------[ cut here ]------------
> [ 7513.395471] BTRFS: Transaction aborted (error -117)
> [ 7513.395528] WARNING: CPU: 1 PID: 17085 at fs/btrfs/inode.c:3175 btrf=
s_finish_ordered_io+0x781/0x7f0 [btrfs]
> [ 7513.395529] Modules linked in: dm_snapshot dm_bufio dm_log_writes dm=
_flakey dm_mod btrfs libcrc32c xor zstd_decompress zstd_compress xxhash r=
aid6_pq loop af_packet [last unloaded: scsi_debug]
> [ 7513.395540] CPU: 1 PID: 17085 Comm: kworker/u8:4 Tainted: G        W=
         5.3.0-rc3-next-20190806-default #5
> [ 7513.395542] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
> [ 7513.395570] Workqueue: btrfs-endio-write btrfs_endio_write_helper [b=
trfs]
> [ 7513.395588] RIP: 0010:btrfs_finish_ordered_io+0x781/0x7f0 [btrfs]
> [ 7513.395590] Code: e9 aa fc ff ff 49 8b 47 50 f0 48 0f ba a8 e8 33 00=
 00 02 72 17 41 83 fd fb 74 5b 44 89 ee 48 c7 c7 08 b4 48 c0 e8 22 55 c9 =
df <0f> 0b 44 89 e9 ba 67 0c 00 00 eb b0 88 5c 24 10 41 89 de 41 bd fb
> [ 7513.395592] RSP: 0018:ffffab1286483d90 EFLAGS: 00010286
> [ 7513.395593] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000=
000000001
> [ 7513.395594] RDX: 0000000000000002 RSI: 0000000000000001 RDI: fffffff=
fa00d1ca8
> [ 7513.395596] RBP: ffff9d4f573d8c80 R08: 0000000000000000 R09: 0000000=
000000000
> [ 7513.395597] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9d4=
f06120e80
> [ 7513.395598] R13: 00000000ffffff8b R14: ffff9d4f03e85000 R15: ffff9d4=
f57763750
> [ 7513.395603] FS:  0000000000000000(0000) GS:ffff9d4f7d800000(0000) kn=
lGS:0000000000000000
> [ 7513.395605] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7513.395606] CR2: 00007f5d921edef4 CR3: 0000000014011000 CR4: 0000000=
0000006e0
> [ 7513.395607] Call Trace:
> [ 7513.395638]  normal_work_helper+0xd1/0x540 [btrfs]
> [ 7513.395642]  process_one_work+0x22d/0x580
> [ 7513.395645]  worker_thread+0x50/0x3b0
> [ 7513.395648]  kthread+0xfe/0x140
> [ 7513.395651]  ? process_one_work+0x580/0x580
> [ 7513.395653]  ? kthread_park+0x80/0x80
> [ 7513.395656]  ret_from_fork+0x24/0x30
> [ 7513.395658] irq event stamp: 0
> [ 7513.395659] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 7513.395662] hardirqs last disabled at (0): [<ffffffffa005ff00>] copy=
_process+0x6d0/0x1ac0
> [ 7513.395665] softirqs last  enabled at (0): [<ffffffffa005ff00>] copy=
_process+0x6d0/0x1ac0
> [ 7513.395666] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 7513.395668] ---[ end trace f6f3adf90f4ea412 ]---
> [ 7513.395671] BTRFS: error (device vdb) in btrfs_finish_ordered_io:317=
5: errno=3D-117 unknown
> [ 7513.395674] BTRFS info (device vdb): forced readonly
> [ 7513.396527] WARNING: CPU: 3 PID: 2709 at fs/btrfs/disk-io.c:417 btrf=
s_verify_level_key.cold+0x1e/0x2b [btrfs]
> [ 7513.399117] WARNING: CPU: 2 PID: 29478 at fs/btrfs/disk-io.c:417 btr=
fs_verify_level_key.cold+0x1e/0x2b [btrfs]
> [ 7513.400326] Modules linked in: dm_snapshot dm_bufio dm_log_writes dm=
_flakey dm_mod btrfs libcrc32c xor zstd_decompress zstd_compress xxhash r=
aid6_pq loop af_packet [last unloaded: scsi_debug]
> [ 7513.402828] Modules linked in: dm_snapshot dm_bufio dm_log_writes dm=
_flakey dm_mod btrfs libcrc32c xor zstd_decompress zstd_compress xxhash r=
aid6_pq loop af_packet [last unloaded: scsi_debug]
> [ 7513.404136] CPU: 3 PID: 2709 Comm: kworker/u8:8 Tainted: G        W =
        5.3.0-rc3-next-20190806-default #5
> [ 7513.406553] CPU: 2 PID: 29478 Comm: kworker/u8:14 Tainted: G        =
W         5.3.0-rc3-next-20190806-default #5
> [ 7513.411174] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
> [ 7513.413441] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
> [ 7513.413464] Workqueue: btrfs-endio-write btrfs_endio_write_helper [b=
trfs]
> [ 7513.415124] Workqueue: btrfs-endio-write btrfs_endio_write_helper [b=
trfs]
> [ 7513.416431] RIP: 0010:btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
> [ 7513.416433] Code: ff ff e8 9f c8 ff ff e9 4d 58 f5 ff 48 8b 13 48 c7=
 c6 48 9c 48 c0 48 89 ef e8 88 c8 ff ff 48 c7 c7 c0 95 48 c0 e8 c0 e9 c6 =
df <0f> 0b 41 be 8b ff ff ff e9 dd 5a f5 ff be e9 05 00 00 48 c7 c7 40
> [ 7513.417412] RIP: 0010:btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
> [ 7513.420742] RSP: 0000:ffffab1283b83ab8 EFLAGS: 00010246
> [ 7513.421912] Code: ff ff e8 9f c8 ff ff e9 4d 58 f5 ff 48 8b 13 48 c7=
 c6 48 9c 48 c0 48 89 ef e8 88 c8 ff ff 48 c7 c7 c0 95 48 c0 e8 c0 e9 c6 =
df <0f> 0b 41 be 8b ff ff ff e9 dd 5a f5 ff be e9 05 00 00 48 c7 c7 40
> [ 7513.423177] RAX: 0000000000000024 RBX: ffff9d4f06a493b0 RCX: 0000000=
000000001
> [ 7513.423178] RDX: 0000000000000000 RSI: 0000000000000001 RDI: fffffff=
fa00d040b
> [ 7513.424570] RSP: 0018:ffffab1287043ab8 EFLAGS: 00010246
> [ 7513.426005] RBP: ffff9d4f069d4000 R08: 0000000000000000 R09: 0000000=
000000000
> [ 7513.427876] RAX: 0000000000000024 RBX: ffff9d4f06a493b0 RCX: 0000000=
000000001
> [ 7513.429411] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000006
> [ 7513.429412] R13: ffffab1283b83b6e R14: ffff9d4f47b27150 R15: 0000000=
000000000
> [ 7513.430963] RDX: 0000000000000000 RSI: 0000000000000001 RDI: fffffff=
fa00d040b
> [ 7513.432092] FS:  0000000000000000(0000) GS:ffff9d4f7da00000(0000) kn=
lGS:0000000000000000
> [ 7513.433535] RBP: ffff9d4f069d4000 R08: 0000000000000000 R09: 0000000=
000000000
> [ 7513.434145] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7513.434146] CR2: 00007f907ab328e0 CR3: 000000007d2cb000 CR4: 0000000=
0000006e0
> [ 7513.435037] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000006
> [ 7513.435038] R13: ffffab1287043b6e R14: ffff9d4f61e75af0 R15: 0000000=
000000000
> [ 7513.436009] Call Trace:
> [ 7513.436973] FS:  0000000000000000(0000) GS:ffff9d4f7dc00000(0000) kn=
lGS:0000000000000000
> [ 7513.437892]  read_block_for_search.isra.0+0x13d/0x3d0 [btrfs]
> [ 7513.438806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7513.439932]  btrfs_search_slot+0x25d/0xc10 [btrfs]
> [ 7513.441229] CR2: 00007f5d91fa7e40 CR3: 000000007d2cb000 CR4: 0000000=
0000006e0
> [ 7513.442323]  btrfs_lookup_csum+0x6a/0x160 [btrfs]
> [ 7513.442994] Call Trace:
> [ 7513.443764]  ? kmem_cache_alloc+0x1f2/0x280
> [ 7513.444346]  read_block_for_search.isra.0+0x13d/0x3d0 [btrfs]
> [ 7513.445182]  btrfs_csum_file_blocks+0x198/0x6f0 [btrfs]
> [ 7513.445815]  btrfs_search_slot+0x25d/0xc10 [btrfs]
> [ 7513.446570]  add_pending_csums+0x50/0x70 [btrfs]
> [ 7513.447126]  btrfs_lookup_csum+0x6a/0x160 [btrfs]
> [ 7513.448462]  btrfs_finish_ordered_io+0x3cb/0x7f0 [btrfs]
> [ 7513.450730]  ? kmem_cache_alloc+0x1f2/0x280
> [ 7513.452643]  normal_work_helper+0xd1/0x540 [btrfs]
> [ 7513.454315]  btrfs_csum_file_blocks+0x198/0x6f0 [btrfs]
> [ 7513.455379]  process_one_work+0x22d/0x580
> [ 7513.456451]  add_pending_csums+0x50/0x70 [btrfs]
> [ 7513.457570]  worker_thread+0x50/0x3b0
> [ 7513.460066]  btrfs_finish_ordered_io+0x3cb/0x7f0 [btrfs]
> [ 7513.463658]  kthread+0xfe/0x140
> [ 7513.465743]  normal_work_helper+0xd1/0x540 [btrfs]
> [ 7513.467701]  ? process_one_work+0x580/0x580
> [ 7513.467703]  ? kthread_park+0x80/0x80
> [ 7513.468978]  process_one_work+0x22d/0x580
> [ 7513.470096]  ret_from_fork+0x24/0x30
> [ 7513.473537]  worker_thread+0x50/0x3b0
> [ 7513.474525] irq event stamp: 0
> [ 7513.475631]  kthread+0xfe/0x140
> [ 7513.477203] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 7513.477207] hardirqs last disabled at (0): [<ffffffffa005ff00>] copy=
_process+0x6d0/0x1ac0
> [ 7513.479011]  ? process_one_work+0x580/0x580
> [ 7513.480541] softirqs last  enabled at (0): [<ffffffffa005ff00>] copy=
_process+0x6d0/0x1ac0
> [ 7513.480542] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 7513.482354]  ? kthread_park+0x80/0x80
> [ 7513.484191] ---[ end trace f6f3adf90f4ea413 ]---
> [ 7513.591444]  ret_from_fork+0x24/0x30
> [ 7513.592257] irq event stamp: 13768774
> [ 7513.592975] hardirqs last  enabled at (13768773): [<ffffffffa06575b9=
>] _raw_spin_unlock_irq+0x29/0x40
> [ 7513.594386] hardirqs last disabled at (13768774): [<ffffffffa064fb7e=
>] __schedule+0xae/0x830
> [ 7513.595732] softirqs last  enabled at (13768770): [<ffffffffa0a0035c=
>] __do_softirq+0x35c/0x45c
> [ 7513.597472] softirqs last disabled at (13768759): [<ffffffffa006a713=
>] irq_exit+0xb3/0xc0
>=20


--fl3v1MVaRL3TqlHYROiTFIQlpfjPEBlCA--

--SS9jm6TYywLLigvBo4v4SIPHZSz3j8ulp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1KNeAACgkQwj2R86El
/qgNOwf8CmQz986muXKw4+syUXifVao5mwpQIzSAvOjwyaWqGAytvSP8JGhsT3+1
zln0dwqnDh+2Ov/G2goCXoPFOqLPvsqFXEYR22xlWIit5zICrYDQFfjOKEZScVjG
qXrFLo/PiLUB8UGnhVW9vAZU83GZa4G6gJw4XRzOeNg/vqmwiKr+50EN+X9aTtaU
N3ebfAdGkg+gM/IHbZVRlnVsAF39ePmqyPVugehG1qJBh7vEk427p1SS49wfXcOB
DIwXWqsiyZzBmtFtPyMgVJh+A/EDfRKPl2zgwTHyOw/bQv5f3tJRbEeCBykx3D5y
9TUMXT73sImCgmEZbmPToRjiuPnqEQ==
=ue1w
-----END PGP SIGNATURE-----

--SS9jm6TYywLLigvBo4v4SIPHZSz3j8ulp--
