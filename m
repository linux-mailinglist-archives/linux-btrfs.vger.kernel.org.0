Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24405B58D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 02:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfIRAHt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 20:07:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:50439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfIRAHt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 20:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568765253;
        bh=gqoyxcZyjmgeoMEzSW+8QVdNGw2EwPnraF9s+VVV8VM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CA/9P/+Q2U/1DzBjhwO9lXX6/yCrT1yoYeTyBL9D5Oc+pE/Mtr/uGtZsxIzvyIyKu
         xrWzMKbtnzSzdofmwXy8aUKFZgd2sk1FMudwCBAz9bGazFlwe68/RiU2/ugWW6EeBR
         e1YPf7o1FmbgAny4NpBSJaN1jNoXkhSjPPS9KZFI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTAFh-1ieFlj1SKl-00UavG; Wed, 18
 Sep 2019 02:07:33 +0200
Subject: Re: [PATCH RFC] btrfs: volumes: Check if we're hitting sys chunk
 array size limit before allocating new sys chunks
To:     Lai Wei-Hwa <whlai@robco.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190917065730.28788-1-wqu@suse.com>
 <337881026.86319.1568741259357.JavaMail.zimbra@robco.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <a8b472ff-8681-aa65-41fd-6549d9cba178@gmx.com>
Date:   Wed, 18 Sep 2019 08:07:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <337881026.86319.1568741259357.JavaMail.zimbra@robco.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nDzwVJ2gaVfc9uJdqzwdGdEiDv9unrc1W"
X-Provags-ID: V03:K1:GGswY6mck7EuXndHRkdh0VWBh96+JrK5mSgHqy0ZrZ06TbrfDed
 BQ6uMcNEfz+vENb5EEA1WuWUoSH5/qPrxIGSJ9FHl9/fCMq8gCuBN26GFGwp1g4BJdJmTIN
 ZXmrHiYiTFJDAV8SRxD9f6o7DkDGTCw5As66+9Af1HJM8EuFYOs2SL9F+Z4fkmDqDir0Lrk
 b9BgAiNEK5bE+sHLJP7Sw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mXCLIB+z4Ts=:SpfG7p9P61YQfjLvR3onnc
 eG8WM4QkAnms0Le/hfp3GnKAye1vzoy35SkmNxuVu/s+5GllsttM7YbDXSHeIgq+MqWWFy/Q3
 MdqfRYHdePpc0N6vakQOOihCAcvvvE2GKZJYrZpCGUruqXVPVN5YuTQucHQSEnK3Q4IsZIfwk
 gdJCFeM9NayASIeO7Xlw5OpIN1NuwW56wi8pgM4P6V8w+izwJW7mBWS0+KKmjTZd3ps/gZso2
 p/g6NM+t0SlgxE83I39eLRDbD0lbPe0FoOzIk4rfwFJkELthCbsp39Nj6LUm9oePF4z4pGhSu
 V5dCMXy/VWB/41C3TyNo14Xlrsi/UwmEmX4t1k4/A6HR8SDw5UwfpDZtC9tLdTh6ZwE0Cqa4x
 11uFXHzlu3yDPtar4F6xiwtiD6C3Uyy6QHQKjZYUc9fFtWw0kEbQoh710js6I38HlSPCCg8Lk
 A4KG86Z2b8rGax5JHWmcSiSVsva2xzAKwZrdnqZoEVo3P6sPd4W4nhuEXaCdowzXVSrwcAQ/y
 fwo//oB1HjpUboziw00aPT8Xn5cnYReMLKLqjfH29YJI07eyP3HjCnRt82of0xaMAeade548i
 NqkcXyEKSxghRy4jLC9rHC0gevhyhUacFGb4wFKdm76XjrstAFltIi1dEXAXaDEkwp7G9TZjG
 Ns1gUQzlx44NVhziUFQsCcWeAcwWN37dKIChxLt8tyBi+ul1NZ5JkeV2lv9YwbDmhAbvao4rO
 CQ3ARSGHmP4aQL/2vfMXnDF/8n3D0cf/BNK7+gooN02oyAt2Rl+eLJJEB7/PAwGTI9pV20Cxs
 f04W5LjxBTJwrNtcyFXiJH2i1i9YPS0CQbUjrRNOnkjUUk4atfOknYmILUpNji1+wrUVONilM
 olGAoj0GbSHX4r+m81K7jvCaPoCvOTSqmd7YLLHbggqcG1C8aqZ+amPSZIskZ5qOA+cwejmXG
 CNwK+6xQ2qhEcSNeDPYLCivgNp82ZeJ0lED4Q5ydmO5zwp6+p3a/VcOF6Sb2O1fDGL0Pyje/e
 WX19eXUbzBuWpH9ZVxiqVmFpork0ta9UWY0ju5myGGgSN/PjuXFVXANv3nI/dlh/Wr+Dy28TH
 WCIiHmQVbFjVz8LTM+OYCsiNCMuWVDiz5WZ2mUzKfZ5EWxb+q488d8WsE+NvMR3qeX3ztTtxU
 FKRgIhcj7RxImGyhaa+YyXMcQX7BLmDjj3kDJ8TOwLRoEvBWu9Jq/0EB1//eT1V02cno1FHyu
 Kt3ss+xQBMpNZDL7IkZfxUoC1Gv4FRgunLAopjuv3otO5I60ho9t1rccHL28=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nDzwVJ2gaVfc9uJdqzwdGdEiDv9unrc1W
Content-Type: multipart/mixed; boundary="P3vh8QeAAjBr40eBqD5MYb4KZsRmvdQHj"

--P3vh8QeAAjBr40eBqD5MYb4KZsRmvdQHj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/18 =E4=B8=8A=E5=8D=881:27, Lai Wei-Hwa wrote:
> After upgrading to 18.04 4.15.0-62-generic, the problem disappears.

Aha, that looks like something related to empty block groups auto removal=
=2E

Then at least the patch is less urgent, but still makes some sense.

Thanks,
Qu
>=20
> Thanks!=20
> Lai
>=20
> ----- Original Message -----
> From: "Qu Wenruo" <wqu@suse.com>
> To: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Cc: "Lai Wei-Hwa" <whlai@robco.com>
> Sent: Tuesday, September 17, 2019 2:57:30 AM
> Subject: [PATCH RFC] btrfs: volumes: Check if we're hitting sys chunk a=
rray size limit before allocating new sys chunks
>=20
> [BUG]
> There is a user reporting strange EFBIG error causing transaction to be=

> aborted.
>=20
> [Sep14 20:02] ------------[ cut here ]------------
> [ +0.000042] WARNING: CPU: 18 PID: 28882 at linux-4.4.0/fs/btrfs/extent=
-tree.c:10046 btrfs_create_pending_block_groups+0x144/0x1f0 [btrfs]()
> [ +0.000002] BTRFS: Transaction aborted (error -27)
> [ +0.000002] Call Trace:
> [ +0.000008] [<ffffffff8140c9a1>] dump_stack+0x63/0x82
> [ +0.000007] [<ffffffff810864d2>] warn_slowpath_common+0x82/0xc0
> [ +0.000002] [<ffffffff8108656c>] warn_slowpath_fmt+0x5c/0x80
> [ +0.000014] [<ffffffffc01f31c4>] ? btrfs_finish_chunk_alloc+0x204/0x5a=
0 [btrfs]
> [ +0.000011] [<ffffffffc01b1d24>] btrfs_create_pending_block_groups+0x1=
44/0x1f0 [btrfs]
> [ +0.000012] [<ffffffffc01c7ed3>] __btrfs_end_transaction+0x93/0x340 [b=
trfs]
> [ +0.000013] [<ffffffffc01c8190>] btrfs_end_transaction+0x10/0x20 [btrf=
s]
> [ +0.000010] [<ffffffffc01b5a4d>] btrfs_inc_block_group_ro+0xed/0x1b0 [=
btrfs]
> [ +0.000014] [<ffffffffc02253bf>] scrub_enumerate_chunks+0x21f/0x580 [b=
trfs]
> [ +0.000004] [<ffffffff810cb700>] ? wake_atomic_t_function+0x60/0x60
> [ +0.000013] [<ffffffffc0226d0c>] btrfs_scrub_dev+0x1bc/0x530 [btrfs]
> [ +0.000004] [<ffffffff8123f306>] ? __mnt_want_write+0x56/0x60
> [ +0.000013] [<ffffffffc0202408>] btrfs_ioctl+0x1ac8/0x28c0 [btrfs]
> [ +0.000003] [<ffffffff8119a3b9>] ? unlock_page+0x69/0x70
> [ +0.000002] [<ffffffff8119a654>] ? filemap_map_pages+0x224/0x230
> [ +0.000004] [<ffffffff811cdb77>] ? handle_mm_fault+0x10f7/0x1b80
> [ +0.000002] [<ffffffff811fb77b>] ? kmem_cache_alloc_node+0xbb/0x210
> [ +0.000003] [<ffffffff813e13e3>] ? create_task_io_context+0x23/0x100
> [ +0.000003] [<ffffffff812318ef>] do_vfs_ioctl+0x2af/0x4b0
> [ +0.000002] [<ffffffff813e1510>] ? get_task_io_context+0x50/0x90
> [ +0.000003] [<ffffffff813f0936>] ? set_task_ioprio+0x86/0xa0
> [ +0.000002] [<ffffffff81231b69>] SyS_ioctl+0x79/0x90
> [ +0.000004] [<ffffffff81864f1b>] entry_SYSCALL_64_fastpath+0x22/0xcb
> [ +0.000002] ---[ end trace 13fce4e84d9b6aed ]---
> [ +0.000003] BTRFS: error (device sda1) in btrfs_create_pending_block_g=
roups:10046: errno=3D-27 unknown
> [ +0.003942] BTRFS info (device sda1): forced readonly
>=20
> [CAUSE]
> From the backtrace, the EFBIG is from btrfs_add_system_chunk() where th=
e
> new system chunk is unable to be inserted in super block.
>=20
> Indeed we can't do much to help such problem, but at least we can avoid=

> such situation when allocating new chunk.
>=20
> [FIX]
> At chunk allocation time, we iterate through the new_bgs list which
> records all new chunks allocated in current transaction.
>=20
> And account all new system chunks and its space to be used in super blo=
ck,
> along with the size of the to-be-allocated chunk to see if it exceeds
> the sys chunk size limit.
>=20
> Such early check will make __btrfs_alloc_chunk() return -EFBIG, and
> prevent transaction abort in btrfs_create_pending_block_groups().
>=20
> Reported-by: Lai Wei-Hwa <whlai@robco.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> This patch is only to provide early graceful exit, the root reason for
> the initial report is still not fully discovered.
>=20
> So I keep the RFC tag until the initial report can be solved.
> ---
>  fs/btrfs/volumes.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 52 insertions(+)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a447d3ec48d5..05d328ce229f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4901,6 +4901,51 @@ static void check_raid56_incompat_flag(struct bt=
rfs_fs_info *info, u64 type)
>  	btrfs_set_fs_incompat(info, RAID56);
>  }
> =20
> +static bool check_syschunk_array_size(struct btrfs_trans_handle *trans=
,
> +				      int num_stripes)
> +{
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_block_group_cache *cache;
> +	u32 sb_array_size;
> +	u32 needed =3D 0;
> +
> +	lockdep_assert_held(&fs_info->chunk_mutex);
> +	sb_array_size =3D btrfs_super_sys_array_size(fs_info->super_copy);
> +
> +	/*
> +	 * Check and calculate all existing sys chunks in new_bgs.
> +	 * As new system chunks will take up sys chunk array in super block, =
we
> +	 * want to error out early before we ate up all sys chunk array.
> +	 *
> +	 * This list is only modified by btrfs_make_block_group() and
> +	 * btrfs_create_pending_block_groups().
> +	 *
> +	 * The former is only called in __btrfs_alloc_chunk() and protected
> +	 * by fs_info->chunk_mutex.
> +	 * The later is called when the last trans handle get ended in
> +	 * __btrfs_end_transaction() or btrfs_commit_transaction(), thus ther=
e
> +	 * is no race as long as we hold a trans handle.
> +	 */
> +	list_for_each_entry(cache, &trans->new_bgs, bg_list) {
> +		if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
> +			struct extent_map *em;
> +
> +			em =3D btrfs_get_chunk_map(fs_info, cache->key.objectid,
> +						 1);
> +			/* Can't get a chunk map? It's a problem by all means */
> +			if (IS_ERR(em))
> +				return false;
> +			needed +=3D btrfs_chunk_item_size(
> +					em->map_lookup->num_stripes);
> +			needed +=3D sizeof(struct btrfs_disk_key);
> +			free_extent_map(em);
> +		}
> +	}
> +	if (sb_array_size + needed > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE)
> +		return false;
> +	return true;
> +}
> +
>  static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>  			       u64 start, u64 type)
>  {
> @@ -5071,6 +5116,13 @@ static int __btrfs_alloc_chunk(struct btrfs_tran=
s_handle *trans,
>  	stripe_size =3D div_u64(devices_info[ndevs - 1].max_avail, dev_stripe=
s);
>  	num_stripes =3D ndevs * dev_stripes;
> =20
> +	if (type & BTRFS_BLOCK_GROUP_SYSTEM &&
> +	    !check_syschunk_array_size(trans, num_stripes)) {
> +		/* Use the unique errno to distinguish from ordinary ENOSPC */
> +		ret =3D -EFBIG;
> +		goto error;
> +	}
> +
>  	/*
>  	 * this will have to be fixed for RAID1 and RAID10 over
>  	 * more drives
>=20


--P3vh8QeAAjBr40eBqD5MYb4KZsRmvdQHj--

--nDzwVJ2gaVfc9uJdqzwdGdEiDv9unrc1W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2BdT8ACgkQwj2R86El
/qjifwf/TjA/2uOHdF5/voa5s4UlD2VHpti+G1JJL4YTH3MQZN0YBHnlC3TCqqF6
M89sZ3ZUMjwJh/hdN7AXTEC3da80bGwIj+plmkhZQWyksSbCmQX8/lLQ9nf2CX4U
b0O645jQdmFhmaUjfBbhkQ3Dcf+Z7QT/fEp5o0S/9avFet5TgDAVtBNPFjzmyiId
8yc8y5UwP1mu6+Ps1TkX+otuHoDHcDAkTOxzAlx+5NiQk+QSWP3T3o+OeeWl8It4
YJKOJRazrYdKFoh+FzoX2fHcqQmthFZXuwiD/vC2kRy29cEHaRD1A8iZ6Mtm9GJa
PID5MYQpUPDhebuzSJYW4qtcO7Pd5g==
=u6dY
-----END PGP SIGNATURE-----

--nDzwVJ2gaVfc9uJdqzwdGdEiDv9unrc1W--
