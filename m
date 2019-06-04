Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA59533C73
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2019 02:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfFDAbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 20:31:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:59821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfFDAbo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 20:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559608295;
        bh=0q2lYGQDaZh1Kp9T3R3uaXbxAn68GgN3v1NtRR7OrSo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=P3Rn3cgqwG7G2YnaEtpnSGLZ2oRk30XwvxGcssXNmmGGrA1VtxPw4wItGMFlL97RF
         SWKxf+or74WZEclXFMjPoq3Fr9gVaSZAS0lkIdrmoXAEfIbDpiM8Di7LiPwm5EzDfM
         7LS+q2tmYJ1QTiiyHqP9KINYGJi7s0Xiw2SjeCCI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MplXz-1gmBoJ2hsD-00q9Ye; Tue, 04
 Jun 2019 02:31:35 +0200
Subject: Re: [PATCH] btrfs: don't end the transaction for delayed refs in
 throttle
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190124143143.8838-1-josef@toxicpanda.com>
 <20190212160351.GD2900@twin.jikos.cz>
 <d10925d5-e036-379b-f68f-bf0f8fa1a5b9@gmx.com>
 <20190603173609.lxt6mejdqwryebzj@MacBook-Pro-91.local>
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
Message-ID: <cdc66832-34a4-5b3b-2180-cd553e7e9124@gmx.com>
Date:   Tue, 4 Jun 2019 08:31:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603173609.lxt6mejdqwryebzj@MacBook-Pro-91.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2UUBrSAROZ5xutU7zBZHyTxV9DdQ4Rs2s"
X-Provags-ID: V03:K1:nRKVFgcq6Y94338XdX1APF1q55TpU+zAqAogIMXQZOmOttEclUj
 s/a/Xuu4sTBWa9IQW/rHaNB+xB+dMADxcEC0Goo99RxVHDnoEqAibn2XvHYekkGbY2ZT/z2
 kQaGITBDbp24FCyCO+t59NO2fC5faXhTSJ7etAQVZ7twBRSKaOl0pf6ehyitA6l5BOHcApb
 k/x1E8iVzjnpjPKfWINlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XGiTiKJaFSk=:savnm0wn2OXj1bAzPgiEwn
 bJqXhvIyazVgNFxER01YwNHf5YDGYMJoHTSttzgz66PRn706UJcLOqgsRHBdw4OJAO6h6+Ql5
 z4q8W2d1xq9I6/y3W3EqiU1AMxBdPAo8yV/862lLjYNqE/aHh1gBzY6P2twPQIhIBiagllamc
 u/ZSzbk6UWDTqJjTqS66yZbmu6fpK2CrZVJvEIGQhb73qs4N8MlH472WrG/O3loe8KFi3eH25
 4vjyWGvIndyIBBo6YHpFfNvWB9kWlr1k6EgfMaGnaVt+q2Sy9GvCIR9XBbDjVacKWd+mo14kf
 BJh3jjRdZm95w9DS7vpn4cJhJoPQakxqSGz0zg+HHMLzVFZaNg/GjWRGnnanWkHoZVHUXYu9w
 02xSSJOGI2Su2DDMxOkttqX7aAWCk8jJfZrpRjHjItIokbzR1Xo6OWxrmsFyvSqP4wBcIlZ5G
 eAu3ODQrDEg+4BNSOiJNQyNpR0b6hqnDC/iBJ7AqV5dCKN7TjiQ9u8FweMfaZnoQJikIUsNPR
 pt09GDVcfH8SZWJvUmBKoY2JhpHTKIj3qpFreGw9mFW7AMVb9TLDdqI5foCNQcO4quAp1hVEF
 v2QPTnrdKKt0ACd3p7BzZYbVUYb4efYA6iXKZg5dbC4Dq9di74Eler2+b57fQLfoUd5hWIH1K
 yVam8rt7Tke9J5Yv0Uipcae7hUDGmlPEe/lRXbLDh0oOhuRR5qmUvjugKet8AOiADN8cVVFJl
 1M23no9Eic+fDVWkyrfkEoYqcaKv330IyrkDKXRMYcW01n7mvWbnlxcym0Fr3DX4DqF+Kjh+x
 /92GfvruuKZ3hppjhUGGSt9oRTdJNWqgsbwkOk9/TvmB4ppFycjWsv7CmXoesdKz7pv1FlSa9
 0VIjjJoqBKClyfyBAYTWSdrVp2Ebuo5DLu/hOX+EpJD+zNzd4VHoCFq2gF6w0FdE11FP3gZIu
 i4mF2WHSpJenCltp7r7u5KFQOJisg3mk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2UUBrSAROZ5xutU7zBZHyTxV9DdQ4Rs2s
Content-Type: multipart/mixed; boundary="emefdkdcEj49GkZQ02NGsT17sQXbPxB26";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <cdc66832-34a4-5b3b-2180-cd553e7e9124@gmx.com>
Subject: Re: [PATCH] btrfs: don't end the transaction for delayed refs in
 throttle
References: <20190124143143.8838-1-josef@toxicpanda.com>
 <20190212160351.GD2900@twin.jikos.cz>
 <d10925d5-e036-379b-f68f-bf0f8fa1a5b9@gmx.com>
 <20190603173609.lxt6mejdqwryebzj@MacBook-Pro-91.local>
In-Reply-To: <20190603173609.lxt6mejdqwryebzj@MacBook-Pro-91.local>

--emefdkdcEj49GkZQ02NGsT17sQXbPxB26
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/4 =E4=B8=8A=E5=8D=881:36, Josef Bacik wrote:
> On Mon, Jun 03, 2019 at 02:53:00PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/2/13 =E4=B8=8A=E5=8D=8812:03, David Sterba wrote:
>>> On Thu, Jan 24, 2019 at 09:31:43AM -0500, Josef Bacik wrote:
>>>> Previously callers to btrfs_end_transaction_throttle() would commit =
the
>>>> transaction if there wasn't enough delayed refs space.  This happens=
 in
>>>> relocation, and if the fs is relatively empty we'll run out of delay=
ed
>>>> refs space basically immediately, so we'll just be stuck in this loo=
p of
>>>> committing the transaction over and over again.
>>>>
>>>> This code existed because we didn't have a good feedback mechanism f=
or
>>>> running delayed refs, but with the delayed refs rsv we do now.  Dele=
te
>>>> this throttling code and let the btrfs_start_transaction() in reloca=
tion
>>>> deal with putting pressure on the delayed refs infrastructure.  With=

>>>> this patch we no longer take 5 minutes to balance a metadata only fs=
=2E
>>>>
>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>
>>> For the record, this has been merged to 5.0-rc5
>>>
>>
>> Bisecting leads me to this patch for strange balance ENOSPC.
>>
>> Can be reproduced by btrfs/156, or the following small script:
>> ------
>> #!/bin/bash
>> dev=3D"/dev/test/test"
>> mnt=3D"/mnt/btrfs"
>>
>> _fail()
>> {
>> 	echo "!!! FAILED: $@ !!!"
>> 	exit 1
>> }
>>
>> do_work()
>> {
>> 	umount $dev &> /dev/null
>> 	umount $mnt &> /dev/null
>>
>> 	mkfs.btrfs -b 1G -m single -d single $dev -f > /dev/null
>>
>> 	mount $dev $mnt
>>
>> 	for i in $(seq -w 0 511); do
>> 	#	xfs_io -f -c "falloc 0 1m" $mnt/file_$i > /dev/null
>> 		xfs_io -f -c "pwrite 0 1m" $mnt/inline_$i > /dev/null
>> 	done
>> 	sync
>>
>> 	btrfs balance start --full $mnt || return 1
>> 	sync
>>
>>
>> 	btrfs balance start --full $mnt || return 1
>> 	umount $mnt
>> }
>>
>> failed=3D0
>> for i in $(seq -w 0 24); do
>> 	echo "=3D=3D=3D run $i =3D=3D=3D"
>> 	do_work
>> 	if [ $? -eq 1 ]; then
>> 		failed=3D$(($failed + 1))
>> 	fi
>> done
>> if [ $failed -ne 0 ]; then
>> 	echo "!!! failed $failed/25 !!!"
>> else
>> 	echo "=3D=3D=3D all passes =3D=3D=3D"
>> fi
>> ------
>>
>> For v4.20, it will fail at the rate around 0/25 ~ 2/25 (very rare).
>> But at that patch (upstream commit
>> 302167c50b32e7fccc98994a91d40ddbbab04e52), the failure rate raise to 2=
5/25.
>>
>> Any idea for that ENOSPC problem?
>> As it looks really wired for the 2nd full balance to fail even we have=

>> enough unallocated space.
>>
>=20
> I've been running this all morning on kdave's misc-next and not had a s=
ingle
> failure.  I ran it a few times on spinning rust and a few times on my n=
vme
> drive.  I wouldn't doubt that it's failing for you, but I can't reprodu=
ce.  It
> would be helpful to know where the ENOSPC was coming from so I can thin=
k of
> where the problem might be.  Thanks,
>=20
> Josef
>=20

Since v5.2-rc2 has a lot of enospc debug output merged, here is the
debug info just by enospc_debug:

BTRFS: device fsid defe70f2-d083-41f0-a4fd-28a0cc03dce7 devid 1 transid
5 /dev/test/test
BTRFS info (device dm-3): disk space caching is enabled
BTRFS info (device dm-3): has skinny extents
BTRFS info (device dm-3): flagging fs with big metadata feature
BTRFS info (device dm-3): checking UUID tree
BTRFS info (device dm-3): balance: start -d -m -s
BTRFS info (device dm-3): relocating block group 726663168 flags metadata=

BTRFS info (device dm-3): relocating block group 609222656 flags data
BTRFS info (device dm-3): found 57 extents
BTRFS info (device dm-3): found 57 extents
BTRFS info (device dm-3): relocating block group 491782144 flags data
BTRFS info (device dm-3): found 112 extents
BTRFS info (device dm-3): found 112 extents
BTRFS info (device dm-3): relocating block group 374341632 flags data
BTRFS info (device dm-3): found 115 extents
BTRFS info (device dm-3): found 114 extents
BTRFS info (device dm-3): relocating block group 256901120 flags data
BTRFS info (device dm-3): found 112 extents
BTRFS info (device dm-3): found 112 extents
BTRFS info (device dm-3): relocating block group 139460608 flags data
BTRFS info (device dm-3): found 112 extents
BTRFS info (device dm-3): found 112 extents
BTRFS info (device dm-3): unable to make block group 22020096 ro
BTRFS info (device dm-3): sinfo_used=3D42909696 bg_num_bytes=3D116293632
min_allocable=3D1048576
BTRFS info (device dm-3): space_info 4 has 82919424 free, is not full
BTRFS info (device dm-3): space_info total=3D125829120, used=3D1015808,
pinned=3D0, reserved=3D81920, may_use=3D41746432, readonly=3D65536
BTRFS info (device dm-3): global_block_rsv: size 16777216 reserved 167444=
48
BTRFS info (device dm-3): trans_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): chunk_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): delayed_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): delayed_refs_rsv: size 61865984 reserved 250019=
84
BTRFS info (device dm-3): relocating block group 22020096 flags metadata
BTRFS info (device dm-3): found 54 extents
BTRFS info (device dm-3): relocating block group 13631488 flags data
BTRFS info (device dm-3): found 8 extents
BTRFS info (device dm-3): found 8 extents
BTRFS info (device dm-3): relocating block group 5242880 flags metadata
BTRFS info (device dm-3): found 56 extents
BTRFS info (device dm-3): unable to make block group 1048576 ro
BTRFS info (device dm-3): sinfo_used=3D32768 bg_num_bytes=3D4161536
min_allocable=3D1048576
BTRFS info (device dm-3): space_info 2 has 4161536 free, is not full
BTRFS info (device dm-3): space_info total=3D4194304, used=3D16384,
pinned=3D0, reserved=3D16384, may_use=3D0, readonly=3D0
BTRFS info (device dm-3): global_block_rsv: size 16777216 reserved 167444=
48
BTRFS info (device dm-3): trans_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): chunk_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): delayed_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): delayed_refs_rsv: size 3145728 reserved 1540096=

BTRFS info (device dm-3): relocating block group 1048576 flags system
BTRFS info (device dm-3): found 1 extents
BTRFS info (device dm-3): balance: ended with status: 0
BTRFS info (device dm-3): balance: start -d -m -s
BTRFS info (device dm-3): unable to make block group 1431306240 ro
BTRFS info (device dm-3): sinfo_used=3D16384 bg_num_bytes=3D33538048
min_allocable=3D1048576
BTRFS info (device dm-3): space_info 2 has 33538048 free, is not full
BTRFS info (device dm-3): space_info total=3D33554432, used=3D16384,
pinned=3D0, reserved=3D0, may_use=3D0, readonly=3D0
BTRFS info (device dm-3): global_block_rsv: size 16777216 reserved 167772=
16
BTRFS info (device dm-3): trans_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): chunk_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): delayed_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): delayed_refs_rsv: size 0 reserved 0
BTRFS info (device dm-3): relocating block group 1431306240 flags system
BTRFS info (device dm-3): unable to make block group 1313865728 ro
BTRFS info (device dm-3): sinfo_used=3D19382272 bg_num_bytes=3D116342784
min_allocable=3D1048576
BTRFS info (device dm-3): space_info 4 has 98058240 free, is not full
BTRFS info (device dm-3): space_info total=3D117440512, used=3D1015808,
pinned=3D0, reserved=3D81920, may_use=3D18284544, readonly=3D0
BTRFS info (device dm-3): global_block_rsv: size 16777216 reserved 167444=
48
BTRFS info (device dm-3): trans_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): chunk_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): delayed_block_rsv: size 0 reserved 0
BTRFS info (device dm-3): delayed_refs_rsv: size 3145728 reserved 1540096=

BTRFS info (device dm-3): relocating block group 1313865728 flags metadat=
a
BTRFS info (device dm-3): found 55 extents
BTRFS info (device dm-3): relocating block group 1196425216 flags data
BTRFS info (device dm-3): found 65 extents
BTRFS info (device dm-3): found 65 extents
BTRFS warning (device dm-3): no space to allocate a new chunk for block
group 1078984704
BTRFS warning (device dm-3): no space to allocate a new chunk for block
group 961544192
BTRFS warning (device dm-3): no space to allocate a new chunk for block
group 844103680
BTRFS warning (device dm-3): no space to allocate a new chunk for block
group 726663168
BTRFS info (device dm-3): 4 enospc errors during balance
BTRFS info (device dm-3): balance: ended with status: -28

The ENOSPC is still from inc_block_group_ro().
For the first data block failure, it still looks like something in
bytes_may_use doesn't look correct.

Although for system block group, it's another story. It has no
reserved/pinned/may_use bytes, it's the min_allocable failing the check.

I can't remember if this is some bug I reported before, but looks a
little similar.

Thanks,
Qu


--emefdkdcEj49GkZQ02NGsT17sQXbPxB26--

--2UUBrSAROZ5xutU7zBZHyTxV9DdQ4Rs2s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlz1u9wACgkQwj2R86El
/qieQAf/fktqu8Uf8kHAy9K7A8eYTeQIrxYICh2MFFTcRXWAubi8yyuYAUd1qkrE
i5o2D4PYKkVvClX/AxQDtfLAEa7C5Yl1VP0Tuv7SrahNF8+z2ThD7OYWMOI7sayK
PiqNldJBKMR4GUG+WWphLAjpTjEiXQDEEn0pYepatnshx6zs3BuGUdzYjZABPJHB
o5J58lpn950kaEsMKOfWXGze/qp/S/s8XKJi4CfTa5U9yhi1L8jgCUhEKBcequqo
RCpaTNObAcSI8KcMz8e9OeMNQMD4TynTsOG3BOykNvp65d8dIwPre7SwV5ttCQ/E
D5GwyeXd6cplJdUhrEMecS8VqocgIg==
=Vsui
-----END PGP SIGNATURE-----

--2UUBrSAROZ5xutU7zBZHyTxV9DdQ4Rs2s--
