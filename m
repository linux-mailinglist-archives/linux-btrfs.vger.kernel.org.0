Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9121B2C1B86
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 03:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKXCm6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Nov 2020 21:42:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:44161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgKXCm5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Nov 2020 21:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606185769;
        bh=X2BRwyvbi3RV7HhzhkudubrPU4sbgQhX+TQ3pG9ETe4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RDzGPv4ddMpHj4Vn2Wp68MEdGL++9A36gyJpuuveZbY031W1jcnlhCR3OzdWqpKB/
         OW46KXYGFVas5NBZ6PN18081h1gf1j51qcVYQBeYt0W+SaQERi5wSPKNuDl44lIvt2
         Z7VFz5o1kS9iR1HHDR1rM6Gesv9mNgEH+LgmCNNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQj7-1kR7w53nVF-00GnzP; Tue, 24
 Nov 2020 03:42:49 +0100
Subject: Re: [PATCH] btrfs: fix lockdep splat when reading qgroup config on
 mount
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <0343c1f0b12747805d837106ada99e10468363b6.1606141632.git.fdmanana@suse.com>
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
Message-ID: <0f3ac26c-fdf4-4b5b-8b68-0bc48fe62826@gmx.com>
Date:   Tue, 24 Nov 2020 10:42:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0343c1f0b12747805d837106ada99e10468363b6.1606141632.git.fdmanana@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DhqbbkehEJ5bq8ZfosRU7oowa4ra1jydK"
X-Provags-ID: V03:K1:6mQcKyooJxGGzFOqZPU4E35YuJyEEmNUccpTJv/nHCFB9FmBTjP
 ZdZAX68aZ1EmVVC7Cj3CwxPdhuZMwBbQ0UK65tdP/7GZzoMv+X8OKZXrV+OeMzdk1xRXvWk
 y9n7peJiVSP+hxtlmgB6kz4VRuk5Gv4PLI5svHoa8GUzHGjlLhYpbdv9r4Jx0Si63+nVunm
 xDcsL7tA3/MJUwolxThCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GZNPBSc+YVk=:n1YnlI5j4a1Hpbd/R12smN
 OrKmpZilsrcI2nmeVQqmX6wZwTixDQ+wxIVTIjGHQ9nKMp9VRTs+ExF+4q+HMg3lL5c6416lD
 7wd1iPZTEOq1o0aUWBlWRhShRKaL//C2edWOxM8ppAtGEbARpdtTdmjvAf7JCpBTfS5C2j8I1
 c6h0aCCHVWmq7ntTZGSk05u8JQFeu2OjSUBpk6KqnuCSjEB7F7GM7qR0UXyghjCrEJ5yfbMWP
 hogh2vXK4hEKZTfIGYpxi1nd1gK4GP7HW7g2or2BH7yYLCjjy9AOU+/iNQa29t8JDNhaxM6wC
 yLHl7bR767W5SJQCblHbceTC5kGFGD4Eh+PCA7ZeI9QyNYdu0amDDEYA4dca81heOxxP4N1kF
 ldz5f2SHsBC7oX0HLF1VQhCViqEmjQs0DjYcjyow5VAz7o7GIzNOt58K/tMch7yMoTlkt4hNm
 KNwuLGpAcmdmNWbJB2sUX5ZEhbEevNIWOsBcLTmSBgcZABnTlDl9k3vJQzvCjVfwHzlAOIaKb
 rV1T5nWR6DJ4DSQcPTeiNVQgaQ+pkYuFK6mwqweQYvk95ue2V4dKKoCFHYw7yhU+ocTOK7gnm
 TrpivnTD9RagbG4boCiY6xWTprrBpNZNNyWchH6GSrNuU4f5OQXL9tu4S6uuJu5Ln90KR6/Qa
 z6WQtnwuay1yjz4tZi3pZHrOkAi1mVjLKzfmNNqG8heUfO50WeHWhex5tWUJ9KnwfCIHy+qq0
 YqzPAyoZYXU8Tl8BfRhoAOfhsmXruUkhsGFRg/Q7d0RIRVt55kx6AGaq2KjVRkPDyg56hZPOK
 mQ/gm6MtrIzJsWlgABjjfLXDCNrSt0TwUR4KHwrXOPRP6pVueHxuf8O2f+WpuT2ea4bLVF60J
 oXufKqwRI8g5qDGS0wNw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DhqbbkehEJ5bq8ZfosRU7oowa4ra1jydK
Content-Type: multipart/mixed; boundary="zZwHFv8EwYZ8jqZ3WdXac6OYu0Kr6tvF0"

--zZwHFv8EwYZ8jqZ3WdXac6OYu0Kr6tvF0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/23 =E4=B8=8B=E5=8D=8810:28, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Lockdep reported the following splat when running test btrfs/190 from
> fstests:
>=20
> [ 9482.126098] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 9482.126184] WARNING: possible circular locking dependency detected
> [ 9482.126281] 5.10.0-rc4-btrfs-next-73 #1 Not tainted
> [ 9482.126365] ------------------------------------------------------
> [ 9482.126456] mount/24187 is trying to acquire lock:
> [ 9482.126534] ffffa0c869a7dac0 (&fs_info->qgroup_rescan_lock){+.+.}-{3=
:3}, at: qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.126647]
>                but task is already holding lock:
> [ 9482.126777] ffffa0c892ebd3a0 (btrfs-quota-00){++++}-{3:3}, at: __btr=
fs_tree_read_lock+0x27/0x120 [btrfs]
> [ 9482.126886]
>                which lock already depends on the new lock.
>=20
> [ 9482.127078]
>                the existing dependency chain (in reverse order) is:
> [ 9482.127213]
>                -> #1 (btrfs-quota-00){++++}-{3:3}:
> [ 9482.127366]        lock_acquire+0xd8/0x490
> [ 9482.127436]        down_read_nested+0x45/0x220
> [ 9482.127528]        __btrfs_tree_read_lock+0x27/0x120 [btrfs]
> [ 9482.127613]        btrfs_read_lock_root_node+0x41/0x130 [btrfs]
> [ 9482.127702]        btrfs_search_slot+0x514/0xc30 [btrfs]
> [ 9482.127788]        update_qgroup_status_item+0x72/0x140 [btrfs]
> [ 9482.127877]        btrfs_qgroup_rescan_worker+0xde/0x680 [btrfs]
> [ 9482.127964]        btrfs_work_helper+0xf1/0x600 [btrfs]
> [ 9482.128039]        process_one_work+0x24e/0x5e0
> [ 9482.128110]        worker_thread+0x50/0x3b0
> [ 9482.128181]        kthread+0x153/0x170
> [ 9482.128256]        ret_from_fork+0x22/0x30
> [ 9482.128327]
>                -> #0 (&fs_info->qgroup_rescan_lock){+.+.}-{3:3}:
> [ 9482.128464]        check_prev_add+0x91/0xc60
> [ 9482.128551]        __lock_acquire+0x1740/0x3110
> [ 9482.128623]        lock_acquire+0xd8/0x490
> [ 9482.130029]        __mutex_lock+0xa3/0xb30
> [ 9482.130590]        qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.131577]        btrfs_read_qgroup_config+0x43a/0x550 [btrfs]
> [ 9482.132175]        open_ctree+0x1228/0x18a0 [btrfs]
> [ 9482.132756]        btrfs_mount_root.cold+0x13/0xed [btrfs]
> [ 9482.133325]        legacy_get_tree+0x30/0x60
> [ 9482.133866]        vfs_get_tree+0x28/0xe0
> [ 9482.134392]        fc_mount+0xe/0x40
> [ 9482.134908]        vfs_kern_mount.part.0+0x71/0x90
> [ 9482.135428]        btrfs_mount+0x13b/0x3e0 [btrfs]
> [ 9482.135942]        legacy_get_tree+0x30/0x60
> [ 9482.136444]        vfs_get_tree+0x28/0xe0
> [ 9482.136949]        path_mount+0x2d7/0xa70
> [ 9482.137438]        do_mount+0x75/0x90
> [ 9482.137923]        __x64_sys_mount+0x8e/0xd0
> [ 9482.138400]        do_syscall_64+0x33/0x80
> [ 9482.138873]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 9482.139346]
>                other info that might help us debug this:
>=20
> [ 9482.140735]  Possible unsafe locking scenario:
>=20
> [ 9482.141594]        CPU0                    CPU1
> [ 9482.142011]        ----                    ----
> [ 9482.142411]   lock(btrfs-quota-00);
> [ 9482.142806]                                lock(&fs_info->qgroup_res=
can_lock);
> [ 9482.143216]                                lock(btrfs-quota-00);
> [ 9482.143629]   lock(&fs_info->qgroup_rescan_lock);
> [ 9482.144056]
>                 *** DEADLOCK ***
>=20
> [ 9482.145242] 2 locks held by mount/24187:
> [ 9482.145637]  #0: ffffa0c8411c40e8 (&type->s_umount_key#44/1){+.+.}-{=
3:3}, at: alloc_super+0xb9/0x400
> [ 9482.146061]  #1: ffffa0c892ebd3a0 (btrfs-quota-00){++++}-{3:3}, at: =
__btrfs_tree_read_lock+0x27/0x120 [btrfs]
> [ 9482.146509]
>                stack backtrace:
> [ 9482.147350] CPU: 1 PID: 24187 Comm: mount Not tainted 5.10.0-rc4-btr=
fs-next-73 #1
> [ 9482.147788] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [ 9482.148709] Call Trace:
> [ 9482.149169]  dump_stack+0x8d/0xb5
> [ 9482.149628]  check_noncircular+0xff/0x110
> [ 9482.150090]  check_prev_add+0x91/0xc60
> [ 9482.150561]  ? kvm_clock_read+0x14/0x30
> [ 9482.151017]  ? kvm_sched_clock_read+0x5/0x10
> [ 9482.151470]  __lock_acquire+0x1740/0x3110
> [ 9482.151941]  ? __btrfs_tree_read_lock+0x27/0x120 [btrfs]
> [ 9482.152402]  lock_acquire+0xd8/0x490
> [ 9482.152887]  ? qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.153354]  __mutex_lock+0xa3/0xb30
> [ 9482.153826]  ? qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.154301]  ? qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.154768]  ? qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.155226]  qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.155690]  btrfs_read_qgroup_config+0x43a/0x550 [btrfs]
> [ 9482.156160]  open_ctree+0x1228/0x18a0 [btrfs]
> [ 9482.156643]  btrfs_mount_root.cold+0x13/0xed [btrfs]
> [ 9482.157108]  ? rcu_read_lock_sched_held+0x5d/0x90
> [ 9482.157567]  ? kfree+0x31f/0x3e0
> [ 9482.158030]  legacy_get_tree+0x30/0x60
> [ 9482.158489]  vfs_get_tree+0x28/0xe0
> [ 9482.158947]  fc_mount+0xe/0x40
> [ 9482.159403]  vfs_kern_mount.part.0+0x71/0x90
> [ 9482.159875]  btrfs_mount+0x13b/0x3e0 [btrfs]
> [ 9482.160335]  ? rcu_read_lock_sched_held+0x5d/0x90
> [ 9482.160805]  ? kfree+0x31f/0x3e0
> [ 9482.161260]  ? legacy_get_tree+0x30/0x60
> [ 9482.161714]  legacy_get_tree+0x30/0x60
> [ 9482.162166]  vfs_get_tree+0x28/0xe0
> [ 9482.162616]  path_mount+0x2d7/0xa70
> [ 9482.163070]  do_mount+0x75/0x90
> [ 9482.163525]  __x64_sys_mount+0x8e/0xd0
> [ 9482.163986]  do_syscall_64+0x33/0x80
> [ 9482.164437]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 9482.164902] RIP: 0033:0x7f51e907caaa
>=20
> This happens because at btrfs_read_qgroup_config() we can call
> qgroup_rescan_init() while holding a read lock on a quota btree leaf,
> acquired by the previous call to btrfs_search_slot_for_read(), and
> qgroup_rescan_init() acquires the mutex qgroup_rescan_lock.
>=20
> A qgroup rescan worker does the opposite: it acquires the mutex
> qgroup_rescan_lock, at btrfs_qgroup_rescan_worker(), and then tries to
> update the qgroup status item in the quota btree through the call to
> update_qgroup_status_item(). This inversion of locking order
> between the qgroup_rescan_lock mutex and quota btree locks causes the
> splat.
>=20
> Fix this simply by releasing and freeing the path before calling
> qgroup_rescan_init() at btrfs_read_qgroup_config().
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/qgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index da9b313819d5..25c07ea5c8b5 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -497,13 +497,13 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info=
 *fs_info)
>  			break;
>  	}
>  out:
> +	btrfs_free_path(path);
>  	fs_info->qgroup_flags |=3D flags;
>  	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON))
>  		clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
>  	else if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN &&
>  		 ret >=3D 0)
>  		ret =3D qgroup_rescan_init(fs_info, rescan_progress, 0);
> -	btrfs_free_path(path);
> =20
>  	if (ret < 0) {
>  		ulist_free(fs_info->qgroup_ulist);
>=20


--zZwHFv8EwYZ8jqZ3WdXac6OYu0Kr6tvF0--

--DhqbbkehEJ5bq8ZfosRU7oowa4ra1jydK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+8cyUACgkQwj2R86El
/qgI5AgAmHnBOXckZ3wNrOlpooRJ+YoUy5W/T2etajOFXawge56T7HSgHs/QoAe/
HwAZJKardrh8Tsxp8E/QDjvoUWdPh2Lhnn5KaubIB65tv5Jb/AcsK3nS74VO7qMI
v0zpw0OvxrbITkosa9+ZxvcPsl2aBTqszyO59VyydqorXYN1LBxjMcXcyYkecjjN
6/nYL4500geizAPRNiS9K0ALKxwqbwBviS7If0bFdFwvjsGXJWreC8+mXcsSgrh+
xdI0hTmQeursFlnnBnOqXQv/AL7vzOnolW9if80x8qJsD6kfWOl5Na1aeLRNafOg
kGqBSKZ4/+JICuFt1B4IowkDJZFh8g==
=Ll31
-----END PGP SIGNATURE-----

--DhqbbkehEJ5bq8ZfosRU7oowa4ra1jydK--
