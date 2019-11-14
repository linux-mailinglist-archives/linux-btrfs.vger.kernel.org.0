Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAFFBD3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 01:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNA7Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 19:59:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:46401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfKNA7Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 19:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573693077;
        bh=Myscu2DzNrAlyfZFnB1WC8FEGMZwq1pa16tSes6vlbU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ToITZoyNGXzmFYUCU7v23xdbzlDB5bHWzEWunlveeerZ8IIinPidDoOpO+B2vfpnA
         D57sD+0pQFvOsIkzZNFcFBV+raLqVd0Ks9gmVybTnOAd0gN2qDId5GtnPWv7nd3dv2
         ymh36bAzzIhOY+cvsqOGsC0ub55UzGZ2e/HJIRBM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XPn-1hreBp0dcX-014SFf; Thu, 14
 Nov 2019 01:57:57 +0100
Subject: Re: [PATCH 1/2] btrfs: block-group: Fix two rebase errors where
 assignment for cache is missing
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191105013535.14239-1-wqu@suse.com>
 <20191105013535.14239-2-wqu@suse.com> <20191113143143.GA3001@twin.jikos.cz>
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
Message-ID: <5804867d-d3dc-3fb5-f152-10b9e35b8278@gmx.com>
Date:   Thu, 14 Nov 2019 08:57:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191113143143.GA3001@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9kzBTn5z4ItDDPbrlnIT94BKarZ8ZXKt8"
X-Provags-ID: V03:K1:RZRF0tczzFjxwsefrxG11ez6f6tex3iU0YdnW9fe8F5yq096yc9
 RO4rVYR90aT1zH+LjRjIR3LesP0IvHVp8fN1uVGn3AFTYgAm9wZoud81QghXsTis5rNBkyj
 FGGVop7ulHA6MuVFfK1N4MCnIKktyWoeEcHe4EWcMa4evn1PjY5k6A7+SXi0lLz3x6kzKf2
 XUZeBX94ChkN1ovHbey8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xfBG7XelUio=:nsIG1rOwjXjVj60nUW823p
 U+eC6W9xeBRD8xewQ2fKtsgNH2pl3DBftiPmGnaxVYd+ji22KzjCiGq0dRj6JqCfVCewMG/TD
 H5DkmGkqd6BNDzG1fCk4NYQk384C6HMP4zC71Tuk9bBn30HfMsmFzUISWxgLeMPUulTktLlV+
 Y2FKytCXT36g45plVkJdwRSeCIVYug+jRDxwyrkHR1ZI7HXgsA05pRJFuDYCnr8Ppp+uyoRJX
 SB1AVmHaMH8z9AQy/lvw/5RLDXEhmF44xNRRkAzLwGVExpCM61utkN19Pdy777tCbXMgaoYWK
 zqnrUeB5xU14RZeRwpy2aegZUzJPVwHXXCnszEuenHD49Tz+jxdUuS8SO5lcWFdQwZiLbDmce
 heAVgAsLzaLy3/sj9/Aau9wpydgjisUtXnF6/Vt1PYt1/3EevWCyVEAPSXgBeMChtUzQZpUgO
 xSgY5M18Xuttyo7z/ms0g4GKelKjf6V3Ca2NTydTfYa2A9CxkYUAnW0LxBjXCI8LQCWoxTpY6
 6KZP30QHtv1wtpFn3ox/GmDZK3ip5OFJzVW9tBMl6SdHwNBiisSOXF1qAY2bYge2T4nPx0BZx
 mBAtn+6NzJs1Q5xWQwAILm5R6m2ZHs2SBhTVJM/qXpLffdSi31JsW+SRyg9qYPjWuJ3NIzGO9
 FFpXoGE1uLReCJANR3ewM7494WeG0TU2aVWJIp11TNYRn9+DFQbYFN7bkECUnP7yS5Sy+T0rI
 Z/x8TEvOSRHa+KM2WBf2E8VQQq0Za4/7KceAftC8mFPXzXYTH5kg9+ZJiMMgfEl3yAOJBG6F+
 Zhp0kkokKbIO3Q/BhW2LjUEejdKK0q1jcricgCbt/6zHdBqnpNJYZsX13vhJK+SzKtqWvJzEl
 4n1yl9jI78KvGLb8Z0FM1hInk/USSbbvTRCBrBwb7oIqF9hJ4YiMW6FWQARpi6RsH6UmeyDFd
 A80w6EFFeeeqgUdhR49i8KkzC5TTTeMDTmTdXS0WJnEFNVVzFaFioBuRC8uK1Q94ofArdViG4
 bivCfrf5UTuMgB1hwWb9AHZDKu5UjPDlQ/6VWZuR6Fb1asD+g06IAyz898adMuSF2Wr1NXARu
 0OB/HqnUD7vdpRitB5IBHrBBzuaLdzRl7mI3KJrRgX+2bEVuv1aHB7w31tBb2YDOdsXpB656H
 eOKQeRdHDR/zcqI0ftDTpzYSgWw+7gV8NEFTJXVzBePuWdkAGsxniSJWC8sLmv/y1kQkQh4d8
 SAxo0J0Od2sE+5osG6W5iIxqOiAB0aWAvBGfA8VznWW2iIC6mg2QH8jgbfKg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9kzBTn5z4ItDDPbrlnIT94BKarZ8ZXKt8
Content-Type: multipart/mixed; boundary="W4OljSvyG6Ez3h73NxMINIVLmBHne5exd"

--W4OljSvyG6Ez3h73NxMINIVLmBHne5exd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/13 =E4=B8=8B=E5=8D=8810:31, David Sterba wrote:
> On Tue, Nov 05, 2019 at 09:35:34AM +0800, Qu Wenruo wrote:
>> Without proper cache->flags, btrfs space info will be screwed up and
>> report error at mount time.
>>
>> And without proper cache->used, commit transaction will report -EEXIST=

>> when running delayed refs.
>>
>> Please fold this into the original patch "btrfs: block-group: Refactor=
 btrfs_read_block_groups()".
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/block-group.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index b5eededaa750..c2bd85d29070 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -1713,6 +1713,8 @@ static int read_one_block_group(struct btrfs_fs_=
info *info,
>>  	}
>>  	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
>>  			   sizeof(bgi));
>> +	cache->used =3D btrfs_stack_block_group_used(&bgi);
>> +	cache->flags =3D btrfs_stack_block_group_flags(&bgi);
>>  	if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
>>  	    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
>>  			btrfs_err(info,
>=20
> Is it possible that there's another missing bit that got lost during my=

> rebase? VM testing is fine but I get a reproducible crash on a physical=

> machine with the following stacktrace:
>=20
>  113 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags=
,
>  114                              u64 total_bytes, u64 bytes_used,
>  115                              u64 bytes_readonly,
>  116                              struct btrfs_space_info **space_info)=

>  117 {
>  118         struct btrfs_space_info *found;
>  119         int factor;
>  120
>  121         factor =3D btrfs_bg_type_to_factor(flags);
>  122
>  123         found =3D btrfs_find_space_info(info, flags);
>  124         ASSERT(found);

It looks like space info is not properly initialized, I'll double check
to ensure no other location lacks the flags/used assignment.

THanks,
Qu

> [ 1570.447326] assertion failed: found, in fs/btrfs/space-info.c:124
> [ 1570.453862] ------------[ cut here ]------------
> [ 1570.458629] kernel BUG at fs/btrfs/ctree.h:3117!
> [ 1570.463445] invalid opcode: 0000 [#1] PREEMPT SMP
> [ 1570.468310] CPU: 3 PID: 2189 Comm: mount Not tainted 5.4.0-rc7-1.ge1=
95904-vanilla+ #509
> [ 1570.468312] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/20=
08
> [ 1570.468388] RIP: 0010:assfail.constprop.14+0x18/0x26 [btrfs]
> [ 1570.508150] RSP: 0018:ffff9f9c40f7fa20 EFLAGS: 00010282
> [ 1570.508153] RAX: 0000000000000035 RBX: 0000000000000000 RCX: 0000000=
000000000
> [ 1570.508157] RDX: 0000000000000000 RSI: ffff918ae73d9208 RDI: ffff918=
ae73d9208
> [ 1570.528092] RBP: 0000000000000001 R08: 0000000000000002 R09: 0000000=
000000000
> [ 1570.528093] R10: ffff9f9c40f7f978 R11: 0000000000000000 R12: ffff918=
ab37c0000
> [ 1570.528095] R13: 0000000000000000 R14: 0000000000400000 R15: 0000000=
000000000
> [ 1570.528097] FS:  00007f0d3f937840(0000) GS:ffff918ae7200000(0000) kn=
lGS:0000000000000000
> [ 1570.528098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1570.528100] CR2: 00007f9559f4c000 CR3: 000000021bdb9000 CR4: 0000000=
0000006e0
> [ 1570.528101] Call Trace:
> [ 1570.528149]  btrfs_update_space_info+0xb7/0xc0 [btrfs]
> [ 1570.579229]  btrfs_read_block_groups+0x5b2/0x8e0 [btrfs]
> [ 1570.579283]  open_ctree+0x1bd5/0x2323 [btrfs]
> [ 1570.589311]  ? btrfs_mount_root+0x648/0x770 [btrfs]
> [ 1570.589351]  btrfs_mount_root+0x648/0x770 [btrfs]
> [ 1570.599226]  ? sched_clock+0x5/0x10
> [ 1570.599233]  ? sched_clock_cpu+0x15/0x130
> [ 1570.607049]  ? rcu_read_lock_sched_held+0x59/0xa0
> [ 1570.607058]  ? legacy_get_tree+0x30/0x60
> [ 1570.616042]  legacy_get_tree+0x30/0x60
> [ 1570.616045]  vfs_get_tree+0x28/0xe0
> [ 1570.616052]  fc_mount+0xe/0x40
> [ 1570.626809]  vfs_kern_mount.part.5+0x6f/0x80
> [ 1570.626842]  btrfs_mount+0x179/0x940 [btrfs]
> [ 1570.626855]  ? sched_clock+0x5/0x10
> [ 1570.639359]  ? sched_clock+0x5/0x10
> [ 1570.639361]  ? sched_clock_cpu+0x15/0x130
> [ 1570.639369]  ? rcu_read_lock_sched_held+0x59/0xa0
> [ 1570.652054]  ? legacy_get_tree+0x30/0x60
> [ 1570.652056]  legacy_get_tree+0x30/0x60
> [ 1570.652058]  vfs_get_tree+0x28/0xe0
> [ 1570.652062]  do_mount+0x828/0xa50
> [ 1570.652068]  ? memdup_user+0x4b/0x70
> [ 1570.670815]  ksys_mount+0x80/0xd0
> [ 1570.670819]  __x64_sys_mount+0x21/0x30
> [ 1570.670825]  do_syscall_64+0x56/0x220
> [ 1570.682011]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 1570.682014] RIP: 0033:0x7f0d3f22b5ea
> [ 1570.682018] RSP: 002b:00007ffd2cf30e38 EFLAGS: 00000246 ORIG_RAX: 00=
000000000000a5
> [ 1570.682020] RAX: ffffffffffffffda RBX: 000055d29414c060 RCX: 00007f0=
d3f22b5ea
> [ 1570.682021] RDX: 000055d29414c2c0 RSI: 000055d29414c300 RDI: 000055d=
29414c2e0
> [ 1570.682023] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f0=
d3f4dd698
> [ 1570.682024] R10: 00000000c0ed0000 R11: 0000000000000246 R12: 000055d=
29414c2e0
> [ 1570.682025] R13: 000055d29414c2c0 R14: 000055d293a02160 R15: 000055d=
29414c060
> [ 1570.682035] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns=
_resolver nfs lockd grace sunrpc fscache af_packet btrfs bridge stp llc i=
scsi_ibft iscsi_boot_sysfs xor kvm_amd zstd_decompress kvm zstd_compress =
xxhash raid6_pq tpm_infineon tpm_tis tpm_tis_core libcrc32c tg3 tpm libph=
y mptctl acpi_cpufreq serio_raw irqbypass pcspkr k10temp i2c_piix4 button=
 ext4 mbcache jbd2 sr_mod cdrom ohci_pci i2c_algo_bit ehci_pci drm_kms_he=
lper ohci_hcd mptsas ata_generic scsi_transport_sas syscopyarea sysfillre=
ct ehci_hcd sysimgblt mptscsih fb_sys_fops ttm mptbase drm usbcore sata_s=
vw pata_serverworks sg scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [ 1570.810782] ---[ end trace ceba6fe68d860cea ]---
>=20


--W4OljSvyG6Ez3h73NxMINIVLmBHne5exd--

--9kzBTn5z4ItDDPbrlnIT94BKarZ8ZXKt8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3Mpo8ACgkQwj2R86El
/qhu3Af/Xb/Fgi1Vp2IBzVH5oVpauMtvpWawXjBEj4fybLDYgrbWbFQltPWqDBUQ
N8B/NbUS2ujFKv2/gyLqw19QQgvc6q7pg1vFwzscBfwrFPygJVIo6HqNFm/g/dLI
uFS4dCwicGB8LgrM4ubDKgSm/G3376RNQhHTNIG/YpLuIhsXrb5FrFnzJcs+xJZj
0f40aSm6+SgR4dYL5XEWIfCyIV8I5+kxDeRswoeHTQArhFKstddZ8jtdzzYZ70ae
ymb46Oz9eE1I+I3sv7n/61zDCfZdmM+U6M3b2FBRSjk0rFqD4yDYkub3kmzLntX+
jWqlbONF3IlPV+DbLkdlPj6NS1gNHw==
=KTId
-----END PGP SIGNATURE-----

--9kzBTn5z4ItDDPbrlnIT94BKarZ8ZXKt8--
