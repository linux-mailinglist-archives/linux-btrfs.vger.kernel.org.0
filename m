Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583E02CCED2
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgLCFt2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:49:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:43541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgLCFt1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606974438;
        bh=dmF6grEfGWKbIVnh3yyJS4toq9+NBCiohznFd9mYTbM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BBOAbpQFuinZd/d0whYg7e9oTHibxVV0mchiLKFvQNojdWKGjXCSlODJroJ80FXXt
         Fjr7GFY7yF7lWEePL/pNjhKLu3suRPIFaAjzC0HabFjQESCeDP8qG3PSZiXGGHb8E+
         TDzdjDlD2ZN6cB6Cn3aN+r2hB+Q/rZeIbzPAA9uQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq2E-1jrlMK1BuK-00tFO5; Thu, 03
 Dec 2020 06:47:18 +0100
Subject: Re: [PATCH v3 54/54] btrfs: splice remaining dirty_bg's onto the
 transaction dirty bg list
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <9d97cc69e823574da0c7586cdfbd49d210b8a246.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <6e593396-d252-455d-b24f-cef373e7901f@gmx.com>
Date:   Thu, 3 Dec 2020 13:47:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9d97cc69e823574da0c7586cdfbd49d210b8a246.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZxoyS1cU0N1PWSbWjh6G1MrpiONi5JQZr"
X-Provags-ID: V03:K1:1TzHvSVkppGZvx6Pu2bl6UMszBleJ6HVkPtDUzPs1LEO0ghlP8M
 W5v+1o/emg4E+t1wUGRzva1sApYqOsLe2Y1FUl7AwtRnG1wGwqExtA1+IhxDGPvYCi0msp3
 blWLOh0St2D8dlQ3t91BfUdTQO8CHf1uzXRn8cP8kAZpufZFqVKnbbHdqGqQ7f2q4UYusAR
 x4nf3lSOLoMklS8EVEAKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sih5yoxMlOk=:mcnN0LiH161TG16bYQ/EVB
 AM92/sGP9sYFh0r90I3vLotkD6eKUdlaRiXnkSC6yWq/rI1ZiLmu/x4TUK6FHWKM5dTxX9IkS
 6vkI4l3qnU5axvD3Vqrzz2bhuF60/Q4gn9DCFzJ+/kV/4aB47MZyEnI6KiexGhUOdZgeFGCdw
 8fUky/lHO8jJq4D7R6sQYHhr+HkdNHCwy45doR7IUMZIHZ4+Oh7kKvnF2s53k/feMfoH/zwss
 Ro89r6bDgSdESFSX6GqfWwpUAC45w0C/XDdY5bAp/Y5YkUc0Rp6qrDH6byj7U1g0OnnpapRWa
 P+VWy1yOeqi3F48jvvzFZBzCaA5nVASeXQBP9qy3qC/NfeIDzObaZz1Pa5ppkOpzbu/Axbt/q
 PVgN9/eGC8HknUDL7kIBd/12YYFkW2Hx7Fvmt8Q9A9Lxk2JIM3svWKHRZU0NO8PYqugExs43X
 Iqh8C2RDKmAz2tSvXorXn2YKDRs0k1FdedDRo6KG09C/4hstBB9mY3TC/x652Fd6Q+N3FLLNP
 EA8TOYzJWWv9llu7K+aeE23Ti9/fYLaS8WEwZgUD6fD3RysN48IsCReE9+rZqxSPNxdsMuWpP
 g8hwra+lD14RozRJwn/l/cnbFM3KP3OpK2zHr1jnrmpOYm9weEvMEI4G47MX8C5HAZuH72syo
 I+2X9oX4wXp/sYW+fljkgiEQy951MiCBiZZz9CAblVdd0akH3K7f1aRCzl5ziDxkfurx7sTab
 e8THvod4yeVjZAoQOyBBLpNvp6bA3FXcxZH6z4FmQyBR2ZudqUhM9er9ynjVWsbNd2TyxduIM
 78xch9ACmzo1kvTUaaDX+RNGTf0WXxiAwzTpoYqYSGu9F4eXgm80wGFTs1SDTf3azL0qmJaq/
 UMu5C946kXa38kChh0RuVRqMOAkvE1nRJLiYLahC8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZxoyS1cU0N1PWSbWjh6G1MrpiONi5JQZr
Content-Type: multipart/mixed; boundary="bTtwgzL0aWUIfcKgTrjZxVw67ZhJ6dPJS"

--bTtwgzL0aWUIfcKgTrjZxVw67ZhJ6dPJS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> While doing error injection testing with my relocation patches I hit th=
e
> following ASSERT()
>=20
> assertion failed: list_empty(&block_group->dirty_list), in fs/btrfs/blo=
ck-group.c:3356
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/ctree.h:3357!
> invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 0 PID: 24351 Comm: umount Tainted: G        W         5.10.0-rc3+ =
#193
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 =
04/01/2014
> RIP: 0010:assertfail.constprop.0+0x18/0x1a
> RSP: 0018:ffffa09b019c7e00 EFLAGS: 00010282
> RAX: 0000000000000056 RBX: ffff8f6492c18000 RCX: 0000000000000000
> RDX: ffff8f64fbc27c60 RSI: ffff8f64fbc19050 RDI: ffff8f64fbc19050
> RBP: ffff8f6483bbdc00 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffa09b019c7c38 R11: ffffffff85d70928 R12: ffff8f6492c18100
> R13: ffff8f6492c18148 R14: ffff8f6483bbdd70 R15: dead000000000100
> FS:  00007fbfda4cdc40(0000) GS:ffff8f64fbc00000(0000) knlGS:00000000000=
00000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbfda666fd0 CR3: 000000013cf66002 CR4: 0000000000370ef0
> Call Trace:
>  btrfs_free_block_groups.cold+0x55/0x55
>  close_ctree+0x2c5/0x306
>  ? fsnotify_destroy_marks+0x14/0x100
>  generic_shutdown_super+0x6c/0x100
>  kill_anon_super+0x14/0x30
>  btrfs_kill_super+0x12/0x20
>  deactivate_locked_super+0x36/0xa0
>  cleanup_mnt+0x12d/0x190
>  task_work_run+0x5c/0xa0
>  exit_to_user_mode_prepare+0x1b1/0x1d0
>  syscall_exit_to_user_mode+0x54/0x280
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> This happened because I injected an error in btrfs_cow_block() while
> running the dirty block groups.  When we run the dirty block groups, we=

> splice the list onto a local list to process.  However if an error
> occurs, we only cleanup the transactions dirty block group list, not an=
y
> pending block groups we have on our locally spliced list.  Fix this by
> splicing the list back onto the transactions dirty block group list, so=

> any remaining block groups are cleaned up.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/block-group.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 0886e81e5540..5cfa52b1a3b8 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2685,6 +2685,9 @@ int btrfs_start_dirty_block_groups(struct btrfs_t=
rans_handle *trans)
>  		}
>  		spin_unlock(&cur_trans->dirty_bgs_lock);
>  	} else if (ret < 0) {
> +		spin_lock(&cur_trans->dirty_bgs_lock);
> +		list_splice_init(&dirty, &cur_trans->dirty_bgs);
> +		spin_unlock(&cur_trans->dirty_bgs_lock);
>  		btrfs_cleanup_dirty_bgs(cur_trans, fs_info);
>  	}
> =20
>=20


--bTtwgzL0aWUIfcKgTrjZxVw67ZhJ6dPJS--

--ZxoyS1cU0N1PWSbWjh6G1MrpiONi5JQZr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/Ie+AACgkQwj2R86El
/qjREgf/R2GszXcycOi9DsI4onM8B08z0pmdD0ghmtwIW3dqQ4PkdVA+JLQWCPhN
TdT5kV/B4DsEKpbu77qX3YGoNxlDvOliolWMcUCHE3NWVTwgRRk7i1h7i1MW37G6
Hdbbwla+IpWGrHDNLuErhmA3cAgva2rzgHwtFND6RYZfXIMyu7U4+RYjPiRjQRLO
vstjPR/2ft5NR7TpXl6Pxva/ghv7ARqaPM1v5n+8owVJxaMWcieh/Kzvc1oXsoUt
9gAs90Fvdv0l32xvWeHpLGUAtkZIZYqlaqNXFhDCB5/MRsGsqy5ah/+8275PD7ob
abC5F4tTQrkmzTaYxrlIl3VYiBbOIg==
=W797
-----END PGP SIGNATURE-----

--ZxoyS1cU0N1PWSbWjh6G1MrpiONi5JQZr--
