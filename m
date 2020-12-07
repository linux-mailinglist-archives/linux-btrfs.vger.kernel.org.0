Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBB2D08BD
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 02:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgLGBNK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Dec 2020 20:13:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:37201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgLGBNJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 6 Dec 2020 20:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607303487;
        bh=vuvpQI1j3wnFet/zTeOtjfsUGHV12qFkaWPpzXtyZj0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PDsCY1PTAgdK1uKWQ6/XGVgnkKDVYoreU3ALGaHKQBzzsg+nzuVH6j6+/xmpcZHXQ
         ygEtZcaNWjOr5yvwDz41QxePA7Fhq0YKRo8jMdIZBvckxU8QY9eunHuOAf6WYkGqz0
         Yao0f55n81YeVlj/BUgTTu9p+6bPqaJobxpvzyk8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbkp-1kX3J72OXD-00P1ZH; Mon, 07
 Dec 2020 02:11:27 +0100
Subject: Re: [PATCH v4 48/53] btrfs: do proper error handling in
 merge_reloc_roots
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
 <9ad2a3b417b1f54d75231b1c1a3b6531b9746f79.1607019557.git.josef@toxicpanda.com>
 <20201206221013.GF31381@hungrycats.org>
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
Message-ID: <d124ea1b-750a-142b-e2c5-5e4a53f5ed2e@gmx.com>
Date:   Mon, 7 Dec 2020 09:11:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201206221013.GF31381@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zNEd55bpHG1oyfTMKmJBihCnaOAPynYC4"
X-Provags-ID: V03:K1:nYuVgYVDUwxkK2Y7AyaOUpSIgoKrkfwR52eRp9e3grqYrFTZ21z
 uicAdhtvVsb+bzhrJEK/xpMs8rVXZXnZFhDxOFFZx4O3L1+WgXuaG55fFs6zZ1uhGvk8jbq
 qKv3SO2T1b8A7pdFegc1Hzp+aYp8lZEysjlgc7ZJ6sb9qEYOysD0QwUoHUUsem4wqxvStD3
 Ew99gWk8P3YoVZT76xSJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T3F7kwJ5D+c=:8NrVvbf0UlpoFAWKJnoxSm
 hSM26lfCUVh3L5jdZMBFmd1wV2Wd5NuVuFcExbKc1QuDCHwOqdUUVSUj5oI3E2sCzSxU0xhGX
 ij9kAGUiUtPJt45Exky2hljC8YI6GmXPWsMfnws4BSxe0jb5/Fv1T+wGnJahsdSktlYIpSbJg
 eNg+/yDio6kksxFAmRLU5JuWHUt8vq+RGr8DHQTq4DctgGaFhTg+oYwh68AOGistpNr8uddA2
 0VOMqpmiM7AvH9GIi2FO1m369CLjL9DQOvpEw4Gr5qjXjGA3wb0OeZphR9/QZI5wEYinyUJaM
 QDpXNXYjwwHfzpmNayMJuQad/ZqPjrXp8eBvTE+7jk3mw7XZz0yvS4SxXi0/Sz7hLdNMTFRNj
 DZqBPnU+PHT/6Tgc/4AFdAgJqyI6r5oJbFyCtEWYpQfGUDPQpHmx7aEPWg61UduWyv8iHfLJv
 r3ksY3iFsXbt0rnuNH61e9jhzqpJ6jeUCQYA+CBikgMuAihZ8ZOBoj2kX+8TApnO9XDvwiy4t
 8TUvn6ZaI5NeWQAeEkauo9nsLW12EazdbG47gJxjpL8FeqVeJAlVPoqdXb8tMXzENxRRV13sx
 xIzboEq7JyOohX41S4nGCSuluOHy2An++3Z4XpzS/Pz8Iq4YXMjqJdp6iBWP60PDnlVBFCgzR
 xSyj+VNtVAFB1weUU3vo1NJoC7EdIYuAAd25LT0P0DOP+xWhLfXXhq6Ee6N7YzFB4GOxt7uu2
 ltGgT2KmAfY0BalH3xsJqMBW0GyatiUWE5oPCRKhsEMMXzdJpFy2ooWRs5Ifvnv9cEzuOj7SO
 uXTfwuLkba07JFpbsvCvcQsJwQCny1Ucc3/EnOTO8TE3DJdsz2o+LdsNSfQkuoSYCI8Y1Nlos
 /yChQjZmwKkYz2ioLuuQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zNEd55bpHG1oyfTMKmJBihCnaOAPynYC4
Content-Type: multipart/mixed; boundary="u55v7schoVggwZlz3AZ8OnXgemVERmBRI"

--u55v7schoVggwZlz3AZ8OnXgemVERmBRI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/7 =E4=B8=8A=E5=8D=886:10, Zygo Blaxell wrote:
> On Thu, Dec 03, 2020 at 01:22:54PM -0500, Josef Bacik wrote:
>> We have a BUG_ON() if we get an error back from btrfs_get_fs_root().
>> This honestly should never fail, as at this point we have a solid
>> coordination of fs root to reloc root, and these roots will all be in
>> memory.  But in the name of killing BUG_ON()'s remove this one and
>> handle the error properly.  Change the remaining BUG_ON() to an
>> ASSERT().
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>  fs/btrfs/relocation.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 511cb7c31328..737fc5902901 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -1949,9 +1949,19 @@ void merge_reloc_roots(struct reloc_control *rc=
)
>> =20
>>  		root =3D btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
>>  					 false);
>> +		if (IS_ERR(root)) {
>> +			/*
>> +			 * This likely won't happen, since we would have failed
>> +			 * at a higher level.  However for correctness sake
>> +			 * handle the error anyway.
>> +			 */
>> +			ASSERT(0);
>=20
> After a few days of running for-next + these patches on a test VM,
> I am hitting this assert at mount:

Do you still have that fs causing the mounting problem?

If so, would you please provide the btrfs-image -c9 dump?

THanks,
Qu
>=20
>  	[   37.413799][ T3628] BTRFS info (device dm-0): enabling ssd optimiz=
ations
>  	[   37.415985][ T3628] BTRFS info (device dm-0): turning on flush-on-=
commit
>  	[   37.417712][ T3628] BTRFS info (device dm-0): turning on async dis=
card
>  	[   37.419402][ T3628] BTRFS info (device dm-0): use zstd compression=
, level 3
>  	[   37.421153][ T3628] BTRFS info (device dm-0): using free space tre=
e
>  	[   37.422807][ T3628] BTRFS info (device dm-0): has skinny extents
>  	[   75.372451][ T3628] assertion failed: 0, in fs/btrfs/relocation.c:=
1956
>  	[   75.374184][ T3628] ------------[ cut here ]------------
>  	[   75.375558][ T3628] kernel BUG at fs/btrfs/ctree.h:3367!
>  	[   75.377551][ T3628] invalid opcode: 0000 [#1] SMP KASAN PTI
>  	[   75.379303][ T3628] CPU: 2 PID: 3628 Comm: mount Not tainted 5.10.=
0-0ef9ce393ff3-misc-next+ #83
>  	[   75.382778][ T3628] Hardware name: QEMU Standard PC (i440FX + PIIX=
, 1996), BIOS 1.12.0-1 04/01/2014
>  	[   75.385315][ T3628] RIP: 0010:assertfail+0x18/0x1a
>  	[   75.386627][ T3628] Code: 0f 35 aa fe 48 8b 3d 18 ac fd 02 e8 03 3=
5 aa fe 5d c3 55 89 d1 48 89 f2 48 89 fe 48 c7 c7 60 1d 24 9d 48 89 e5 e8=
 e3 34 fe ff <0f> 0b 48 89 df e8 6f 19 b4 fe 48 8b 85 a8 fe ff ff 44 89 e=
a 48 c7
>  	[   75.393562][ T3628] RSP: 0018:ffffc900008274c0 EFLAGS: 00010282
>  	[   75.395637][ T3628] RAX: 0000000000000032 RBX: ffff8881213b6590 RC=
X: ffffffff9b265ba2
>  	[   75.398385][ T3628] RDX: 0000000000000000 RSI: 0000000000000008 RD=
I: ffff8881f5bff28c
>  	[   75.401189][ T3628] RBP: ffffc900008274c0 R08: ffffed103eb815b5 R0=
9: ffffed103eb815b5
>  	[   75.404282][ T3628] R10: ffff8881f5c0ada7 R11: ffffed103eb815b4 R1=
2: ffff88810ab20000
>  	[   75.407136][ T3628] R13: ffff8881213b6000 R14: fffffffffffffffe R1=
5: ffff88810ab20648
>  	[   75.409792][ T3628] FS:  00007faff8004100(0000) GS:ffff8881f5a0000=
0(0000) knlGS:0000000000000000
>  	[   75.412870][ T3628] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
>  	[   75.415193][ T3628] CR2: 000055d217ae2f48 CR3: 0000000107c84005 CR=
4: 0000000000170ee0
>  	[   75.418040][ T3628] Call Trace:
>  	[   75.419284][ T3628]  merge_reloc_roots.cold.60+0x3a/0xd8
>  	[   75.420663][ T3628]  ? merge_reloc_root+0xc10/0xc10
>  	[   75.421856][ T3628]  btrfs_recover_relocation+0x5c6/0x940
>  	[   75.423181][ T3628]  ? btrfs_relocate_block_group+0x4c0/0x4c0
>  	[   75.424444][ T3628]  ? __kasan_check_write+0x14/0x20
>  	[   75.425534][ T3628]  ? up_read+0x176/0x4f0
>  	[   75.426379][ T3628]  ? down_write_nested+0x2d0/0x2d0
>  	[   75.427542][ T3628]  btrfs_start_pre_rw_mount+0x12e/0x200
>  	[   75.429467][ T3628]  open_ctree+0x2191/0x254f
>  	[   75.431474][ T3628]  ? btrfs_get_root_ref.cold.76+0x2c/0x2c
>  	[   75.434053][ T3628]  ? snprintf+0x91/0xc0
>  	[   75.435904][ T3628]  btrfs_mount_root.cold.74+0xe/0xea
>  	[   75.438177][ T3628]  ? parse_rescue_options+0x240/0x240
>  	[   75.440582][ T3628]  ? rcu_read_lock_sched_held+0xa1/0xd0
>  	[   75.443018][ T3628]  ? rcu_read_lock_bh_held+0xb0/0xb0
>  	[   75.445324][ T3628]  ? legacy_parse_param+0x73/0x450
>  	[   75.447483][ T3628]  ? vfs_parse_fs_string+0xa7/0x120
>  	[   75.449773][ T3628]  ? kfree+0x1c1/0x200
>  	[   75.451504][ T3628]  ? parse_rescue_options+0x240/0x240
>  	[   75.453938][ T3628]  legacy_get_tree+0x89/0xd0
>  	[   75.455915][ T3628]  vfs_get_tree+0x52/0x150
>  	[   75.457829][ T3628]  fc_mount+0x14/0x60
>  	[   75.459703][ T3628]  vfs_kern_mount.part.38+0x61/0xa0
>  	[   75.461989][ T3628]  vfs_kern_mount+0x13/0x20
>  	[   75.463979][ T3628]  btrfs_mount+0x1f0/0x5d0
>  	[   75.465844][ T3628]  ? btrfs_show_options+0x8c0/0x8c0
>  	[   75.468146][ T3628]  ? rcu_read_lock_sched_held+0xa1/0xd0
>  	[   75.470603][ T3628]  ? check_flags+0x26/0x30
>  	[   75.472539][ T3628]  ? lock_is_held_type+0xc3/0xf0
>  	[   75.474632][ T3628]  ? rcu_read_lock_sched_held+0xa1/0xd0
>  	[   75.476960][ T3628]  ? rcu_read_lock_bh_held+0xb0/0xb0
>  	[   75.479202][ T3628]  ? legacy_parse_param+0x73/0x450
>  	[   75.481013][ T3628]  ? vfs_parse_fs_string+0xa7/0x120
>  	[   75.482712][ T3628]  ? cap_capable+0xd2/0x110
>  	[   75.484118][ T3628]  ? btrfs_show_options+0x8c0/0x8c0
>  	[   75.485749][ T3628]  legacy_get_tree+0x89/0xd0
>  	[   75.487689][ T3628]  ? btrfs_show_options+0x8c0/0x8c0
>  	[   75.489907][ T3628]  ? legacy_get_tree+0x89/0xd0
>  	[   75.491911][ T3628]  vfs_get_tree+0x52/0x150
>  	[   75.493788][ T3628]  path_mount+0xa53/0xf00
>  	[   75.495500][ T3628]  ? __check_object_size+0x17e/0x220
>  	[   75.497042][ T3628]  ? finish_automount+0x430/0x430
>  	[   75.498312][ T3628]  ? getname_flags+0xfd/0x2b0
>  	[   75.499443][ T3628]  do_mount+0xd2/0xf0
>  	[   75.500409][ T3628]  ? path_mount+0xf00/0xf00
>  	[   75.501524][ T3628]  ? __kasan_check_write+0x14/0x20
>  	[   75.502736][ T3628]  __x64_sys_mount+0x100/0x120
>  	[   75.505056][ T3628]  do_syscall_64+0x37/0x80
>  	[   75.506986][ T3628]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  	[   75.508426][ T3628] RIP: 0033:0x7faff8202fea
>  	[   75.509476][ T3628] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 8=
3 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00=
 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 8=
9 01 48
>  	[   75.514323][ T3628] RSP: 002b:00007ffe9b44e6c8 EFLAGS: 00000246 OR=
IG_RAX: 00000000000000a5
>  	[   75.517413][ T3628] RAX: ffffffffffffffda RBX: 000055a3e65d6b40 RC=
X: 00007faff8202fea
>  	[   75.520839][ T3628] RDX: 000055a3e65de650 RSI: 000055a3e65d6d90 RD=
I: 000055a3e65d6ef0
>  	[   75.524350][ T3628] RBP: 00007faff85501c4 R08: 000055a3e65d6e30 R0=
9: 000055a3e65dea90
>  	[   75.527798][ T3628] R10: 0000000000000400 R11: 0000000000000246 R1=
2: 0000000000000000
>  	[   75.531273][ T3628] R13: 0000000000000400 R14: 000055a3e65d6ef0 R1=
5: 000055a3e65de650
>  	[   75.534685][ T3628] Modules linked in:
>  	[   75.536431][ T3628] ---[ end trace d5a13ffc3f4ddc24 ]---
>  	[   75.538742][ T3628] RIP: 0010:assertfail+0x18/0x1a
>  	[   75.540855][ T3628] Code: 0f 35 aa fe 48 8b 3d 18 ac fd 02 e8 03 3=
5 aa fe 5d c3 55 89 d1 48 89 f2 48 89 fe 48 c7 c7 60 1d 24 9d 48 89 e5 e8=
 e3 34 fe ff <0f> 0b 48 89 df e8 6f 19 b4 fe 48 8b 85 a8 fe ff ff 44 89 e=
a 48 c7
>  	[   75.548258][ T3628] RSP: 0018:ffffc900008274c0 EFLAGS: 00010282
>  	[   75.551045][ T3628] RAX: 0000000000000032 RBX: ffff8881213b6590 RC=
X: ffffffff9b265ba2
>  	[   75.554619][ T3628] RDX: 0000000000000000 RSI: 0000000000000008 RD=
I: ffff8881f5bff28c
>  	[   75.557391][ T3628] RBP: ffffc900008274c0 R08: ffffed103eb815b5 R0=
9: ffffed103eb815b5
>  	[   75.559640][ T3628] R10: ffff8881f5c0ada7 R11: ffffed103eb815b4 R1=
2: ffff88810ab20000
>  	[   75.562663][ T3628] R13: ffff8881213b6000 R14: fffffffffffffffe R1=
5: ffff88810ab20648
>  	[   75.565276][ T3628] FS:  00007faff8004100(0000) GS:ffff8881f5a0000=
0(0000) knlGS:0000000000000000
>  	[   75.568147][ T3628] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
>  	[   75.570715][ T3628] CR2: 000055d217ae2f48 CR3: 0000000107c84005 CR=
4: 0000000000170ee0
>=20
>> +			ret =3D PTR_ERR(root);
>> +			goto out;
>> +		}
>> +
>>  		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
>> -			BUG_ON(IS_ERR(root));
>> -			BUG_ON(root->reloc_root !=3D reloc_root);
>> +			ASSERT(root->reloc_root =3D=3D reloc_root);
>>  			ret =3D merge_reloc_root(rc, root);
>>  			btrfs_put_root(root);
>>  			if (ret) {
>> --=20
>> 2.26.2
>>


--u55v7schoVggwZlz3AZ8OnXgemVERmBRI--

--zNEd55bpHG1oyfTMKmJBihCnaOAPynYC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/NgToACgkQwj2R86El
/qh+WAgAlrTwQGfcft+6JbV9nOZOxFR9DwHrKJcnddGxxzfZ4VR/v9Uq3/+S4LIk
0fF5sAgngw6nlGwtFh93P4SU0YuybTeQchkjL+fiijfY/zte/eqwHaCRxxSLvC9L
bNAKT+WQMcA3cN2iQcqjM9E5MMsQHXnnoTLTqNCtlGWXquR52kNPfW08M3oxy9VP
UNbsGwYEZNI/CLoJPcXebSeL43MnlZlb0WP1cN3B6uEJaQx+cX7OYSgfKNBnmJvk
79tqy7TNxMrmg2nm4STMrdXWQO3GE12qUacSxuj408nCc2hKHGj1o4OrPxeLodee
QBOVlNNdwG0npxw6GSp3DFpxqPI2rA==
=5oS0
-----END PGP SIGNATURE-----

--zNEd55bpHG1oyfTMKmJBihCnaOAPynYC4--
