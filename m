Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21F02CCBE0
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 02:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgLCBv2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 20:51:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:41855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgLCBv1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 20:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606960174;
        bh=UmOaTdzX4uQ9kba4CU/fMg9x6KuE+qdKIPKR1u/JxoU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KqYWRj3gfCoOqwXin489+0gWU5eejCp6tQ5DQiliqO8VLxM6JmLNeFoq+znPKkT2r
         nq6OikVHRsQ0CReWv2BOd8LGtj/B2YWhHMojjIlt57rTNBW7nLq/ePXK/XE5l/FPie
         4X4ocQWzdacscn1sLGHehchjW/+/0o4fTYWsPSUY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mnps0-1kNBxP36Vu-00pJeG; Thu, 03
 Dec 2020 02:49:34 +0100
Subject: Re: [PATCH v3 03/54] btrfs: fix lockdep splat in
 btrfs_recover_relocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <6d8add2cb8a480cb2d7ea3763ea56c83e2aa3358.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <9168fd8d-4f22-0120-0810-b796ec3d0b69@gmx.com>
Date:   Thu, 3 Dec 2020 09:49:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6d8add2cb8a480cb2d7ea3763ea56c83e2aa3358.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NNZljhiC4a8B0Wk901J8ojXp4CFb0VbKI"
X-Provags-ID: V03:K1:ot6QPUOsT35+q0jQeB0lV0PTau7VHKHTsyHYgg7DGMa2Vu5ToF9
 pEtUG+nXnMMq73vnhTh+6oOKafl0A8UHZhWoYgxGGN8FBkywYWn6QzdKaOsAVjyMV1nGycP
 TFafCm7nzyrx4GNG9Dm4Ec+kgUf7bTWONkUvT9TNsf730jCTKpMcZzgW3EmI7mJL6Ur1bFo
 sdtsX+c/ulO6kGD4/ccPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9mC39nxLl6U=:6wX8adrIKww2/UVp1CHGhV
 BgPpFgB5YKKZvEu8Mm1JzIMcp+LysQ7puT6AE1bgv0+3uqIDMcrU/vTmVgOgrYiwLQ9UnxROl
 13ZEg5cGI31wp5Lw2jduuJ/Eaaw8dRbaDMDz3KffYbUxdTPyfrfNasTdJwtjEksGx4Au33wVt
 aZhrR/5Z4SmrG0JWxaWilzNSXo8LT1nIX2yc7PFOvBNptYOW/h6B4fd8nrdRU4rXMcWdb/0Yh
 +tGrx5F0WV8ToJ8k7dJnSZGn2WRW3ck0l0+5aHMtYiwMw3/71E8g61Gc71Oysz7RPD75R7Ydv
 tyughDL3z81DBypwvxf4/CF8wF744bxh7xBPH9VM2SuJAyYeVrvY2KdfuPUKmR5StsR89uQvL
 bXi0c6yg+3f6PPo8MwqsYEUP3Yy4NAM5WJfl+Cbb83/5y29BLnEH5qYfh6VU7Wt5ZpH1deJbK
 toa7ik/wRvJwqIMk8hn2BPEVEAKKCuVQ3yH+CzbBsQ7kLIroxAVOLlUCeFBctD0YNIh7pcpyq
 V+bDWkho4JCD8eGtWhX8yEnHfxmiHbzkGrRR+RqV6i5s/F90uMSC830sCG6YyyG/bhIFqp1bD
 gLjg8Xx1lJFCqQOpXkZCU7F/oC1if3IghWYrVIBYgHi+z66QjVV+D3JSuC75ndn5oDvaODH6i
 /sJN1ZPA/mYbGPkwr8q73SEQtApWbVXJvnwNep6wz1uhVhp8p8T7I7VDQAWAO+rXaK8pyRqTS
 veka6yqfqQPQNszaSMS96WqjcqQEXjctc3Q/g4H7bxfgeaIxudbYSRhiQIJKsmdY50cJCzPDO
 tjbHt+d3AcBQodRGWAtFjB9LV43OGpjV8mSRArooCeoCsW6NF0wkaXjac/+e2OMFuEj05O9u/
 /jDnEnDNuOk2HZgnPN2Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NNZljhiC4a8B0Wk901J8ojXp4CFb0VbKI
Content-Type: multipart/mixed; boundary="Zufgr5dspXeiGtf0t6JrMxSey7AcxHClp"

--Zufgr5dspXeiGtf0t6JrMxSey7AcxHClp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> While testing the error paths of relocation I hit the following lockdep=

> splat
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.10.0-rc6+ #217 Not tainted
> ------------------------------------------------------
> mount/779 is trying to acquire lock:
> ffffa0e676945418 (&fs_info->balance_mutex){+.+.}-{3:3}, at: btrfs_recov=
er_balance+0x2f0/0x340
>=20
> but task is already holding lock:
> ffffa0e60ee31da8 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_loc=
k+0x27/0x100
>=20
> which lock already depends on the new lock.
>=20
> the existing dependency chain (in reverse order) is:
>=20
> -> #2 (btrfs-root-00){++++}-{3:3}:
>        down_read_nested+0x43/0x130
>        __btrfs_tree_read_lock+0x27/0x100
>        btrfs_read_lock_root_node+0x31/0x40
>        btrfs_search_slot+0x462/0x8f0
>        btrfs_update_root+0x55/0x2b0
>        btrfs_drop_snapshot+0x398/0x750
>        clean_dirty_subvols+0xdf/0x120
>        btrfs_recover_relocation+0x534/0x5a0
>        btrfs_start_pre_rw_mount+0xcb/0x170
>        open_ctree+0x151f/0x1726
>        btrfs_mount_root.cold+0x12/0xea
>        legacy_get_tree+0x30/0x50
>        vfs_get_tree+0x28/0xc0
>        vfs_kern_mount.part.0+0x71/0xb0
>        btrfs_mount+0x10d/0x380
>        legacy_get_tree+0x30/0x50
>        vfs_get_tree+0x28/0xc0
>        path_mount+0x433/0xc10
>        __x64_sys_mount+0xe3/0x120
>        do_syscall_64+0x33/0x40
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> -> #1 (sb_internal#2){.+.+}-{0:0}:
>        start_transaction+0x444/0x700
>        insert_balance_item.isra.0+0x37/0x320
>        btrfs_balance+0x354/0xf40
>        btrfs_ioctl_balance+0x2cf/0x380
>        __x64_sys_ioctl+0x83/0xb0
>        do_syscall_64+0x33/0x40
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> -> #0 (&fs_info->balance_mutex){+.+.}-{3:3}:
>        __lock_acquire+0x1120/0x1e10
>        lock_acquire+0x116/0x370
>        __mutex_lock+0x7e/0x7b0
>        btrfs_recover_balance+0x2f0/0x340
>        open_ctree+0x1095/0x1726
>        btrfs_mount_root.cold+0x12/0xea
>        legacy_get_tree+0x30/0x50
>        vfs_get_tree+0x28/0xc0
>        vfs_kern_mount.part.0+0x71/0xb0
>        btrfs_mount+0x10d/0x380
>        legacy_get_tree+0x30/0x50
>        vfs_get_tree+0x28/0xc0
>        path_mount+0x433/0xc10
>        __x64_sys_mount+0xe3/0x120
>        do_syscall_64+0x33/0x40
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> other info that might help us debug this:
>=20
> Chain exists of:
>   &fs_info->balance_mutex --> sb_internal#2 --> btrfs-root-00
>=20
>  Possible unsafe locking scenario:
>=20
>        CPU0                    CPU1
>        ----                    ----
>   lock(btrfs-root-00);
>                                lock(sb_internal#2);
>                                lock(btrfs-root-00);
>   lock(&fs_info->balance_mutex);
>=20
>  *** DEADLOCK ***
>=20
> 2 locks held by mount/779:
>  #0: ffffa0e60dc040e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc=
_super+0xb5/0x380
>  #1: ffffa0e60ee31da8 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_rea=
d_lock+0x27/0x100
>=20
> stack backtrace:
> CPU: 0 PID: 779 Comm: mount Not tainted 5.10.0-rc6+ #217
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 =
04/01/2014
> Call Trace:
>  dump_stack+0x8b/0xb0
>  check_noncircular+0xcf/0xf0
>  ? trace_call_bpf+0x139/0x260
>  __lock_acquire+0x1120/0x1e10
>  lock_acquire+0x116/0x370
>  ? btrfs_recover_balance+0x2f0/0x340
>  __mutex_lock+0x7e/0x7b0
>  ? btrfs_recover_balance+0x2f0/0x340
>  ? btrfs_recover_balance+0x2f0/0x340
>  ? rcu_read_lock_sched_held+0x3f/0x80
>  ? kmem_cache_alloc_trace+0x2c4/0x2f0
>  ? btrfs_get_64+0x5e/0x100
>  btrfs_recover_balance+0x2f0/0x340
>  open_ctree+0x1095/0x1726
>  btrfs_mount_root.cold+0x12/0xea
>  ? rcu_read_lock_sched_held+0x3f/0x80
>  legacy_get_tree+0x30/0x50
>  vfs_get_tree+0x28/0xc0
>  vfs_kern_mount.part.0+0x71/0xb0
>  btrfs_mount+0x10d/0x380
>  ? __kmalloc_track_caller+0x2f2/0x320
>  legacy_get_tree+0x30/0x50
>  vfs_get_tree+0x28/0xc0
>  ? capable+0x3a/0x60
>  path_mount+0x433/0xc10
>  __x64_sys_mount+0xe3/0x120
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> This is thankfully straightforward to fix, simply release the path
> before we setup the reloc_ctl.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/volumes.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7930e1c78c45..49ba941f0314 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4318,6 +4318,8 @@ int btrfs_recover_balance(struct btrfs_fs_info *f=
s_info)
>  		btrfs_warn(fs_info,
>  	"balance: cannot set exclusive op status, resume manually");
> =20
> +	btrfs_release_path(path);
> +
>  	mutex_lock(&fs_info->balance_mutex);
>  	BUG_ON(fs_info->balance_ctl);
>  	spin_lock(&fs_info->balance_lock);
>=20


--Zufgr5dspXeiGtf0t6JrMxSey7AcxHClp--

--NNZljhiC4a8B0Wk901J8ojXp4CFb0VbKI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IRCoACgkQwj2R86El
/qjbsgf/VBpn3SMKUU3mb8Vo/i+6OgLXAkD9MjIRZpilXmBR5AWZ9unheQVz9fPM
EnyRmaSb/CHz6JgeBVkXsbyBImA8kqGUWgZBNo++gKvq49eCkKdlRzznqdgxPksQ
T5bJ5m03FznNIv66cxeN/F+suEYQRYHY9sEwo9whRFAYGL9VDeZO26qAYUQbVpRL
fFF8Wvs0x7Hx0HkFoV02gdYII4BpEtT3B9X54BDOCXjmYHWnWGkdAB5kQTjN2fhK
nyZIF1QQjiAC387QjuyITcZDAy3Oktpn8LIPhBeLkVBaOKTzSb82LfFcUrYdO4E/
gL4r/gxWIzFUczfwg0uTM0y6NGwMVw==
=4cTU
-----END PGP SIGNATURE-----

--NNZljhiC4a8B0Wk901J8ojXp4CFb0VbKI--
