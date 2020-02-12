Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581E2159E70
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 02:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgBLBAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 20:00:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:54497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgBLBAz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 20:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581469248;
        bh=2tH4UNDagdrt3C7uvCpMe0rzgi8xGjGfMuQLARzs1bk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PZRWdSBDjb/ncaLdhuOctI1XDxSr2uG1/RT57n1Ww/d+vo3Pc14+++1H1lYUqP5Pa
         nq0dz7lnZFNDzrleIyLxuSmHYAPOZc+pNzByIEEj7817iHN2cP6y2+jj01kg1L+ZDm
         f4Gv9PRYu0gh4kx4VcQmrhRbaE3AOThY4Q15LlSo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsEx-1jJcYF1Tgl-00swIj; Wed, 12
 Feb 2020 02:00:48 +0100
Subject: Re: [PATCH 4/4] btrfs: fix bytes_may_use underflow in prealloc error
 condtition
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200211214042.4645-1-josef@toxicpanda.com>
 <20200211214042.4645-5-josef@toxicpanda.com>
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
Message-ID: <cc66bbe1-b54e-53d2-569b-9e931068d737@gmx.com>
Date:   Wed, 12 Feb 2020 09:00:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211214042.4645-5-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eHxp9INvNW099br74SKiZaqHSgauDNiea"
X-Provags-ID: V03:K1:RwOsKjgy8gItBtLogknLlbVfDpiaVePAFcGlAGC4EUrpGXN+BbL
 Ix7ibaU9T5uF0JTauf4bZXhiWXmEtr4ZJ0KtXqXo+IdKz+/vI6FW6+YGjfFUyXFFIHmXZzD
 i0pj2UwhNZsgsQ0iu5lCYrcA171tgKBzPlo6Wo2uLzxCe69Gy1A5vT66TAi1kxZzW+WLfoK
 Wu+NK8LDU8uEgs3vh4fLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WurIPmC8CdU=:7PIyvL8+ef5qFioKnKWVUh
 Am0HMckHF2soXM4aloSQcpw2SERQD0u1WmlTMkDjXrR1hZohYcZ8SzejSDaVhnYuxi/Oy8whp
 pKsxbp1axXRYWJKb5u+VhGx2QVuU2V6ha9261vRzcCDjjkppLHGawPj/Yd7LkfFkXhQDdKfkw
 q9Nmuw/RbJ6J0DOQISabdkYr/qaUtPrRcrHyiVdG+eMgTLWAoBj48dTaMDXaF6nv+VrZIw4hR
 8gWs6UIGKtGmdoQDm9BVRXqIhKBX3qBez4eeIoR+A+GzZQZQEUX/+9eYkxwpRVWlk6XKMmnUZ
 Bl04oldO6fnMC5/WYETI+fWs6iDQlXcRt/8Z7Z2lF4jqI+LPNqIo4hWWvYj2NbKdPHEtWqa+o
 Au6x0VfVmxIgrUpu3aNFlypLQnRVO8tSC/LjWKMNRqSFWVpLjKpLnorounZ/aoBM16bFRxtu+
 KQ/QZxOB6KUT7Dwa+oo64KedodRf5WuJPwzV70mffuR40LxL2h/iSurCyy1GmcXI4/EgvH5o/
 6lpDfPHCK6UALRuaL1H6nTmtpAvpbEIUBVMVHTkFBbBH/um9uaj2ob+imCqfSz4e+WMuH70ut
 RaTUpb6LDsKhmGOROFryaEQvaocAJ75xA5WiP6sIGEDDI42//yd2G/2NjVSrSUvjbZYWok7u5
 1aWlarxFTO0iJ1N7AkWDKNKIAS4ffHSQnqLz2i8y4KtRR6cDpJUrBq+O6h2ql+ODa+7xZSnR9
 X84vDJ5JOKSOmI1ODk66GqSzdRcZCNj7noGfgphYziQe78quosVvnlFOHk89tEJ0URkvPQ2UE
 GAWPMzgFDxWjJyTTUK/7mztzIo2gtE/Yy+OJsq5fSQprTJEMIbfFfchmcSLyY3uvk65NYNExG
 EGRkxXCmeo/Baw40rl3WkGB5GXMYPHi6SWt8K1JEDydff8RZQk8J9P6qPCsJWNIVgtfnsfqld
 ozdlRPO54/Ajy1oKHTxshBz3Lx5UQqF8iySTrR3EFCMGwZKZv9K7/oTRBaZgpRauPYciGmD0+
 6OqaoVDsnV8C++h+5Zm9CjziY1gG3HR4hk0UsNvUHLZLS1cdvGK/wDl0zbhSOCDe79rb9cv4k
 H+qaDLRgEodEXq4OyXgyXrB7LnZ3KuUUWnz1MymIFWI3NuKtHaYN2+gKd6mB+4C4N5VD90gik
 RqqhHoyV7qW/hbZg6LRN1mD9CDxPFT9dFu1IOMQeIzy4AWegtoYyu4O2JsCDocmi7vTeNV2s5
 iG4ug5QRpqpeQzJl3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eHxp9INvNW099br74SKiZaqHSgauDNiea
Content-Type: multipart/mixed; boundary="9n6vCk5rgAf3O1NwxT4ufLYgumPJv7H6V"

--9n6vCk5rgAf3O1NwxT4ufLYgumPJv7H6V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/12 =E4=B8=8A=E5=8D=885:40, Josef Bacik wrote:
> I hit the following warning while running my error injection stress tes=
ting
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 1453 at fs/btrfs/space-info.h:108 btrfs_free_reser=
ved_data_space_noquota+0xfd/0x160 [btrfs]
> RIP: 0010:btrfs_free_reserved_data_space_noquota+0xfd/0x160 [btrfs]
> Call Trace:
> btrfs_free_reserved_data_space+0x4f/0x70 [btrfs]
> __btrfs_prealloc_file_range+0x378/0x470 [btrfs]
> elfcorehdr_read+0x40/0x40
> ? elfcorehdr_read+0x40/0x40
> ? btrfs_commit_transaction+0xca/0xa50 [btrfs]
> ? dput+0xb4/0x2a0
> ? btrfs_log_dentry_safe+0x55/0x70 [btrfs]
> ? btrfs_sync_file+0x30e/0x420 [btrfs]
> ? do_fsync+0x38/0x70
> ? __x64_sys_fdatasync+0x13/0x20
> ? do_syscall_64+0x5b/0x1b0
> ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> ---[ end trace 70ccb5d0fe51151c ]---
>=20
> This happens if we fail to insert our reserved file extent.  At this
> point we've already converted our reservation from ->bytes_may_use to
> ->bytes_reserved.  However once we break we will attempt to free
> everything from [cur_offset, end] from ->bytes_may_use, but our extent
> reservation will overlap part of this.
>=20
> Fix this problem by adding ins.offset (our extent allocation size) to
> cur_offset so we remove the actual remaining part from ->bytes_may_use.=

>=20
> I validated this fix using my inject-error.py script
>=20
> python inject-error.py -o should_fail_bio -t cache_save_setup -t \
> 	__btrfs_prealloc_file_range \
> 	-t insert_reserved_file_extent.constprop.0 \
> 	-r "-5" ./run-fsstress.sh
>=20
> where run-fsstress.sh simply mounts and runs fsstress on a disk.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 84e649724549..747d860aedf6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9919,6 +9919,14 @@ static int __btrfs_prealloc_file_range(struct in=
ode *inode, int mode,
>  						  ins.offset, 0, 0, 0,
>  						  BTRFS_FILE_EXTENT_PREALLOC);
>  		if (ret) {
> +			/*
> +			 * We've reserved this space, and thus converted it from
> +			 * ->bytes_may_use to ->bytes_reserved, which we cleanup
> +			 * here.  We need to adjust cur_offset so that we only
> +			 * drop the ->bytes_may_use for the area we still have
> +			 * remaining in ->>bytes_may_use.
> +			 */
> +			cur_offset +=3D ins.objectid;
>  			btrfs_free_reserved_extent(fs_info, ins.objectid,
>  						   ins.offset, 0);
>  			btrfs_abort_transaction(trans, ret);
>=20


--9n6vCk5rgAf3O1NwxT4ufLYgumPJv7H6V--

--eHxp9INvNW099br74SKiZaqHSgauDNiea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5DTjcACgkQwj2R86El
/qgnOAf+Mhxe7vcK75on8GnjfYT5HOIf9MJBtuYXI6n17pYggesUcfERdNXmgOxc
vewp8VfRKT8dsdZloyPVYcQ42HIjcZPd6XykKx89+MIg0bh3yk3JSM2EQ6GzNXly
QD+17gkbElbwr9iaYG/JNT953YWLOOs9Srjbb94xHdyQD9dLeeuHptM8vg5Ffes+
UUmmseeqN+ZZBCok/v1kqc3H7ItJEWXnwiToXZf7ArAnsaAWb3G763daqFzYTXjY
6XHbSjS5Gy1C6sl+utAkBo3z7PN9ZJzhafx+KJAI1WmPDWthZ5+nPVQMuVEokUJ3
qYHiBjDeeps1Ilc74zu/TOgGbgFUVg==
=QhUz
-----END PGP SIGNATURE-----

--eHxp9INvNW099br74SKiZaqHSgauDNiea--
