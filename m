Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC011D5F4E
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 May 2020 09:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgEPHBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 May 2020 03:01:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:44095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgEPHBr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 May 2020 03:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589612498;
        bh=AAegJUAvn24DYXyaDlK+DQ83sGHFU5jQYk1U0PBK/yI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kF0Ok85IPptwMbUSgbmVFS/6QTXK/4DE/k0rhtKnuoo7/aSuWLTaJ0uve+4KEe1os
         IOojpIegXdUovlRhHRDv066PM2uMWphOwK/s2KwbUs7KNai46uT5hHUoS9s07c8wBb
         Izz4RASbThI9xQZmqqDyQQVKxuKd+NJEt/1Fj2ZU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mg6e4-1isGf83170-00hbcd; Sat, 16
 May 2020 09:01:38 +0200
Subject: Re: [PATCH v3 0/3] btrfs: REF_COWS bit rework
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200515060142.23609-1-wqu@suse.com>
 <20200515194559.GR18421@twin.jikos.cz>
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
Message-ID: <17637fb6-1b76-32bb-b6ab-468eda982c60@gmx.com>
Date:   Sat, 16 May 2020 15:01:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515194559.GR18421@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tbT09b1pewVJbJM1ZzbUt30G9p3RPT3VK"
X-Provags-ID: V03:K1:Dsn/FmBPxRIbLE7rlfgi6rNheLHiN2ADvAvBGfu7b2SBcV8HQDA
 U3UCAEzYcDgqmkaO+QXFbfR7eFWGgxJsGWm7zzwEorYMV/QLALFMqw8phI6bsnwASV1z5hl
 zf02oQkatDtiPa07mXo9e5cy1CC3mGy4HlFOp/gnuTCLmIabifhiJXvWXP2F6nYPkj766Sw
 cnNHjSjfoTCZwAjp+KDeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eotXcuUa5jA=:L3VLlc86INkRdo1ia0w7zF
 vkj2FzjP/LRsKVXkGdH41DRTJOtVrnJRghLprwFOHZ/mfFPgHJWgTirgOmslSHTV3MBj1J5nG
 OicZA2xbjwnjZlOhL6l8zZSgGNmKm6obtdSpKHEjujDtyjAE+YXB/DjS2O7v6ov1/DyYujebK
 YGSSJUvnwyat4Iox+18BN3BsEW6e5dgEQYGaFvVSrWZme7nCJstYqA7xGF9+Ho42bEcX9MLkB
 +ARymDXo6YW3GWPN8J/qFdcDTj62dKULOdeqh3Jug51dmYnWeTAvUaNGqnQNTjnNF4ym+5TH6
 ReaxMzjHL6gLIiVqNqhN7AcV8Upng7I7hhhUA0bGkLzJEY5wS8YA6uYXnfNZMHsPSFovLiHiq
 KasxvM6+L/bQENli1oFdu0ypkG3vctbyHLO16/4+OqBlak7jHH/RQeZkeKKwELtoVWOGgP2kn
 lyv7pVzOh9tglktic0xN3ZkZ9FQTl1mCrHtVT2dWmwSQ2TAUzl72N5NWDGovmBiKnBguVhO4h
 hQH1mQYTDtOsNymqAv0VSrOjVxqk0PjeDeR0IuUywxM64H1bxHHs99A8rYiKf+O3dUGKr9CBf
 UqKA06m0X3qtGJXDqy2FyLPX3MSjBSvL3sB1Enuqgmcp0bQ+u/QgBc//SV+2DlrIz8rxa0VyG
 ZCEnNUrhO+01qAl7tvUFeMWc6Fg0Y8jDv0yu/dqEJQkfFrEVgO9sfMbbiNxl3ocnSVmtakyvx
 +JgMWIPt602GwBKLXRc25yVmz0K3AoBYkrWPWiJVhQi3QI1UNnI9UWQNXfQKc6rfrQbOI+88P
 alHhCpQvm3ckJRbsaNSeTQAlNYYPSW3kKOmmVPEE6fI2oDOIcUPHUndxGkU/BB5TIeOfUjgQv
 VfTIDyByd2U0xDS4uQjrGqVRbSMg313PGITbci251/lkPrQ0g7yoNPpQ/HcMQ+v1hZ+HH88LW
 1j+J0/mAt+54/AmltsCmMw5gOE47JLRRjmLVbIuwc7oISXyY3oUvlnbWPcfrFqxt9eKbdVH7K
 vlT6hpjTEsFC7Flcuf/Du22NmfcLR8C0M/0AmlFPaNj3nv4OfrwnFxZOmbkzNn5QSxKS5SuZD
 YmAKeoBRPnN1WJXkYkPBEsvTRtMYCyK2YxyeT3/+uy/gSjoI7jH2Jua9iY2pGN0n30YhDRql5
 dmL4EnEg55RKFi1eWQWyrgl8dVkAwES5Ujh64GLqJh0YA9WJ8Nx+OgkPnBWiCuaNPidJD5MSJ
 dnzG6XdqeWQ2aZ6Ks
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tbT09b1pewVJbJM1ZzbUt30G9p3RPT3VK
Content-Type: multipart/mixed; boundary="9St35R1dOjXTpcVuVmCdxyW63McqrkwFl"

--9St35R1dOjXTpcVuVmCdxyW63McqrkwFl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/16 =E4=B8=8A=E5=8D=883:45, David Sterba wrote:
> On Fri, May 15, 2020 at 02:01:39PM +0800, Qu Wenruo wrote:
>> This small patchset reworks the REF_COWS bit, by renaming it, and remo=
ve
>> that bit for data relocation root.
>>
>>
>> The basic idea of such rework is to reduce the confusion caused by the=

>> name REF_COWS.
>>
>> With the new bit called SHAREABLE, it should be clear that no user can=

>> really create snapshot for data reloc tree, thus its tree blocks
>> shouldn't be shareable.
>>
>> This would make data balance for reloc tree a little simpler.
>>
>> Changelog:
>> v2:
>> - Add new patch to address the log tree check in
>>   btrfs_truncate_inode_items()
>>   Thanks for the advice from David, now it's much simpler than origina=
l
>>   check, and data reloc tree no longer needs extra hanlding
>>
>> - Grab data reloc root in create_reloc_inode() and
>>   btrfs_recover_relocation()
>>
>> - Comment update
>>
>> v3:
>> - Remove ALIGN_DOWN() -> round_down() change
>>
>> - Remove the confusing comment on the log tree inode
>=20
> I've added the patches to misc-next, with some fixups. I'll let it also=

> go through fstests, but a quick run has hit this write-time corruption
> very early. I haven't analyzed it and it's possible that it's caused by=

> my fixups.

Passed my local balance group.

And furthermore, the error pattern is exactly what I saw during my
development.

>=20
[...]
> [  119.624572] BTRFS info (device vdb): balance: start -d -m -s
> [  119.630843] BTRFS info (device vdb): relocating block group 30408704=
 flags metadata|dup
> [  119.640113] BTRFS critical (device vdb): corrupt leaf: root=3D184467=
44073709551607 block=3D298909696 slot=3D0, invalid key objectid: has 1 ex=
pect 6 or [256, 18446744073709551360] or 18446744073709551604
> [  119.647511] BTRFS info (device vdb): leaf 298909696 gen 11 total ptr=
s 4 free space 15851 owner 18446744073709551607
> [  119.652214] BTRFS info (device vdb): refs 3 lock (w:0 r:0 bw:0 br:0 =
sw:0 sr:0) lock_owner 0 current 19404
> [  119.656275] 	item 0 key (1 1 0) itemoff 16123 itemsize 160
> [  119.658436] 		inode generation 1 size 0 mode 100600

This is using 1 as ino number, which means root::highest_objectid is not
properly initialized.

This happened when I'm using btrfs_read_tree_root() other than
btrfs_read_fs_root(), which initializes root::highest_objectid.

So I guess there is something wrong happened during the fixup.

Thanks,
Qu

> [  119.660812] 	item 1 key (256 1 0) itemoff 15963 itemsize 160
> [  119.663645] 		inode generation 4 size 0 mode 40755
> [  119.665768] 	item 2 key (256 12 256) itemoff 15951 itemsize 12
> [  119.668146] 	item 3 key (18446744073709551611 48 1) itemoff 15951 it=
emsize 0
> [  119.671438] BTRFS error (device vdb): block=3D298909696 write time t=
ree block corruption detected
> [  119.675319] ------------[ cut here ]------------
> [  119.677789] WARNING: CPU: 1 PID: 19404 at fs/btrfs/disk-io.c:537 btr=
ee_csum_one_bio+0x297/0x2a0 [btrfs]
> [  119.683116] Modules linked in: btrfs blake2b_generic libcrc32c crc32=
c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompr=
ess raid6_pq loop
> [  119.690407] CPU: 1 PID: 19404 Comm: btrfs Not tainted 5.7.0-rc5-defa=
ult+ #1108
> [  119.693724] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [  119.698411] RIP: 0010:btree_csum_one_bio+0x297/0x2a0 [btrfs]
> [  119.700653] Code: bc fd ff ff e8 9a 24 c1 c9 31 f6 48 89 3c 24 e8 ef=
 7b ff ff 48 8b 3c 24 48 c7 c6 f0 45 55 c0 48 8b 17 4c 89 e7 e8 94 cc 0b =
00 <0f> 0b e9 8f fd ff ff 66 90 0f 1f 44 00 00 48 89 f7 e9 53 fd ff ff
> [  119.706847] RSP: 0018:ffff9ec884397778 EFLAGS: 00010292
> [  119.707997] RAX: 0000000000000000 RBX: ffff902c7faf0dc0 RCX: 0000000=
000000006
> [  119.709428] RDX: 0000000000000000 RSI: ffff902c4fcd5dd0 RDI: ffff902=
c4fcd5500
> [  119.711051] RBP: 0000000000000001 R08: 0000001bdd341101 R09: 0000000=
000000000
> [  119.712587] R10: 0000000000000000 R11: 0000000000000000 R12: ffff902=
c74b3c000
> [  119.714957] R13: ffff902c428a16b0 R14: 0000000000000000 R15: 0000000=
0ffffff8b
> [  119.716474] FS:  00007fdc12d658c0(0000) GS:ffff902c7b800000(0000) kn=
lGS:0000000000000000
> [  119.719045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  119.720724] CR2: 000055a44869a2d8 CR3: 00000001367c2003 CR4: 0000000=
000160ee0
> [  119.725194] Call Trace:
> [  119.727333]  btree_submit_bio_hook+0x74/0xc0 [btrfs]
> [  119.730365]  submit_one_bio+0x2b/0x40 [btrfs]
> [  119.732253]  btree_write_cache_pages+0x373/0x440 [btrfs]
> [  119.734909]  do_writepages+0x40/0xe0
> [  119.736667]  ? do_raw_spin_unlock+0x4b/0xc0
> [  119.738667]  ? _raw_spin_unlock+0x1f/0x30
> [  119.740122]  ? wbc_attach_and_unlock_inode+0x194/0x2a0
> [  119.743009]  __filemap_fdatawrite_range+0xce/0x110
> [  119.744446]  btrfs_write_marked_extents+0x68/0x160 [btrfs]
> [  119.746166]  btrfs_write_and_wait_transaction+0x4f/0xd0 [btrfs]
> [  119.748184]  btrfs_commit_transaction+0x76a/0xae0 [btrfs]
> [  119.750072]  ? start_transaction+0xd2/0x5e0 [btrfs]
> [  119.751896]  prepare_to_relocate+0x107/0x130 [btrfs]
> [  119.753666]  relocate_block_group+0x5b/0x600 [btrfs]
> [  119.755321]  btrfs_relocate_block_group+0x15e/0x340 [btrfs]
> [  119.757111]  btrfs_relocate_chunk+0x38/0x110 [btrfs]
> [  119.758833]  __btrfs_balance+0x41c/0xcc0 [btrfs]
> [  119.760526]  btrfs_balance+0x65b/0xbd0 [btrfs]
> [  119.762050]  ? kmem_cache_alloc_trace+0x1a7/0x320
> [  119.763777]  ? btrfs_ioctl_balance+0x21c/0x350 [btrfs]
> [  119.765593]  btrfs_ioctl_balance+0x298/0x350 [btrfs]
> [  119.767444]  ? __handle_mm_fault+0x499/0x740
> [  119.769007]  btrfs_ioctl+0x304/0x2590 [btrfs]
> [  119.770537]  ? do_raw_spin_unlock+0x4b/0xc0
> [  119.772015]  ? _raw_spin_unlock+0x1f/0x30
> [  119.774671]  ? __handle_mm_fault+0x499/0x740
> [  119.777106]  ? do_user_addr_fault+0x1d8/0x3f0
> [  119.779366]  ? kvm_sched_clock_read+0x14/0x30
> [  119.781451]  ? sched_clock+0x5/0x10
> [  119.783584]  ? sched_clock_cpu+0x15/0x130
> [  119.785507]  ? do_user_addr_fault+0x1d8/0x3f0
> [  119.787587]  ? ksys_ioctl+0x68/0xa0
> [  119.789577]  ksys_ioctl+0x68/0xa0
> [  119.790909]  __x64_sys_ioctl+0x16/0x20
> [  119.792361]  do_syscall_64+0x50/0x210
> [  119.793749]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [  119.795547] RIP: 0033:0x7fdc12e5e227
> [  119.796967] Code: 00 00 90 48 8b 05 69 8c 0c 00 64 c7 00 26 00 00 00=
 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 8c 0c 00 f7 d8 64 89 01 48
> [  119.802957] RSP: 002b:00007ffc3c0bf7b8 EFLAGS: 00000206 ORIG_RAX: 00=
00000000000010
> [  119.805509] RAX: ffffffffffffffda RBX: 00007ffc3c0bf860 RCX: 00007fd=
c12e5e227
> [  119.807832] RDX: 00007ffc3c0bf860 RSI: 00000000c4009420 RDI: 0000000=
000000003
> [  119.810088] RBP: 0000000000000003 R08: 000055a4486922a0 R09: 0000000=
000000231
> [  119.812378] R10: 00007fdc13088cf0 R11: 0000000000000206 R12: 0000000=
000000001
> [  119.814654] R13: 00007ffc3c0c2127 R14: 0000000000000002 R15: 0000000=
000000000
> [  119.816912] irq event stamp: 19394
> [  119.818225] hardirqs last  enabled at (19393): [<ffffffff8a10a166>] =
console_unlock+0x436/0x590
> [  119.821106] hardirqs last disabled at (19394): [<ffffffff8a002b5b>] =
trace_hardirqs_off_thunk+0x1a/0x1c
> [  119.824311] softirqs last  enabled at (19390): [<ffffffff8aa0031e>] =
__do_softirq+0x31e/0x55d
> [  119.827257] softirqs last disabled at (19383): [<ffffffff8a08d91d>] =
irq_exit+0x9d/0xb0
> [  119.830080] ---[ end trace 247639532e5b557e ]---
> [  119.832171] BTRFS: error (device vdb) in btrfs_commit_transaction:23=
23: errno=3D-5 IO failure (Error while writing out transaction)
> [  119.836020] BTRFS info (device vdb): forced readonly
> [  119.837888] BTRFS warning (device vdb): Skipping commit of aborted t=
ransaction.
> [  119.841381] BTRFS: error (device vdb) in cleanup_transaction:1894: e=
rrno=3D-5 IO failure
> [  119.845600] BTRFS info (device vdb): balance: ended with status: -30=

> [  120.282656] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 =
devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (19409)
> [  120.287896] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 =
devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (19409)
> [  120.298518] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 =
devid 3 transid 5 /dev/vdd scanned by mkfs.btrfs (19409)
> [  120.303545] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 =
devid 4 transid 5 /dev/vde scanned by mkfs.btrfs (19409)
> [  120.311101] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 =
devid 5 transid 5 /dev/vdf scanned by mkfs.btrfs (19409)
> [  120.314834] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 =
devid 6 transid 5 /dev/vdg scanned by mkfs.btrfs (19409)
> [  120.349393] BTRFS info (device vdb): disk space caching is enabled
> [  120.353340] BTRFS info (device vdb): has skinny extents
> [  120.355944] BTRFS info (device vdb): flagging fs with big metadata f=
eature
> [  120.377592] BTRFS info (device vdb): checking UUID tree
> [  127.395164] BTRFS info (device vdb): relocating block group 11041505=
28 flags data|raid0
> [  127.448678] BTRFS critical (device vdb): corrupt leaf: root=3D184467=
44073709551607 block=3D30769152 slot=3D0, invalid key objectid: has 1 exp=
ect 6 or [256, 18446744073709551360] or 18446744073709551604
> [  127.458117] BTRFS info (device vdb): leaf 30769152 gen 7 total ptrs =
4 free space 15851 owner 18446744073709551607
> [  127.462400] BTRFS info (device vdb): refs 3 lock (w:0 r:0 bw:0 br:0 =
sw:0 sr:0) lock_owner 0 current 21002
> [  127.466146] 	item 0 key (1 1 0) itemoff 16123 itemsize 160
> [  127.468412] 		inode generation 1 size 0 mode 100600
> [  127.470284] 	item 1 key (256 1 0) itemoff 15963 itemsize 160
> [  127.472282] 		inode generation 4 size 0 mode 40755
> [  127.473848] 	item 2 key (256 12 256) itemoff 15951 itemsize 12
> [  127.475601] 	item 3 key (18446744073709551611 48 1) itemoff 15951 it=
emsize 0
> [  127.477585] BTRFS error (device vdb): block=3D30769152 write time tr=
ee block corruption detected
> [  127.480577] ------------[ cut here ]------------
> [  127.482417] WARNING: CPU: 3 PID: 21002 at fs/btrfs/disk-io.c:537 btr=
ee_csum_one_bio+0x297/0x2a0 [btrfs]
> [  127.486001] Modules linked in: btrfs blake2b_generic libcrc32c crc32=
c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompr=
ess raid6_pq loop
> [  127.491491] CPU: 3 PID: 21002 Comm: btrfs Tainted: G        W       =
  5.7.0-rc5-default+ #1108
> [  127.494777] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [  127.498791] RIP: 0010:btree_csum_one_bio+0x297/0x2a0 [btrfs]
> [  127.500882] Code: bc fd ff ff e8 9a 24 c1 c9 31 f6 48 89 3c 24 e8 ef=
 7b ff ff 48 8b 3c 24 48 c7 c6 f0 45 55 c0 48 8b 17 4c 89 e7 e8 94 cc 0b =
00 <0f> 0b e9 8f fd ff ff 66 90 0f 1f 44 00 00 48 89 f7 e9 53 fd ff ff
> [  127.507102] RSP: 0018:ffff9ec8852ff700 EFLAGS: 00010282
> [  127.509172] RAX: 0000000000000000 RBX: ffff902c7f20c680 RCX: 0000000=
000000006
> [  127.511742] RDX: 0000000000000000 RSI: ffff902c4fd28910 RDI: ffff902=
c4fd28040
> [  127.514884] RBP: 0000000000000005 R08: 0000001dae6ee2ba R09: 0000000=
000000000
> [  127.517380] R10: 0000000000000000 R11: 0000000000000000 R12: ffff902=
c4a994000
> [  127.519327] R13: ffff902c428a1ef0 R14: 0000000000000000 R15: 0000000=
0ffffff8b
> [  127.523221] FS:  00007f69ecb3b8c0(0000) GS:ffff902c7bc00000(0000) kn=
lGS:0000000000000000
> [  127.527813] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  127.529913] CR2: 00007f69ecca0af0 CR3: 000000010579c002 CR4: 0000000=
000160ee0
> [  127.531942] Call Trace:
> [  127.533156]  btree_submit_bio_hook+0x74/0xc0 [btrfs]
> [  127.535744]  submit_one_bio+0x2b/0x40 [btrfs]
> [  127.537542]  submit_extent_page+0x104/0x210 [btrfs]
> [  127.540137]  write_one_eb+0x1b1/0x390 [btrfs]
> [  127.542825]  ? find_first_extent_bit_state+0x90/0x90 [btrfs]
> [  127.559976]  btree_write_cache_pages+0x1af/0x440 [btrfs]
> [  127.562025]  do_writepages+0x40/0xe0
> [  127.563813]  ? do_raw_spin_unlock+0x4b/0xc0
> [  127.565541]  ? _raw_spin_unlock+0x1f/0x30
> [  127.567363]  ? wbc_attach_and_unlock_inode+0x194/0x2a0
> [  127.569545]  __filemap_fdatawrite_range+0xce/0x110
> [  127.571519]  btrfs_write_marked_extents+0x68/0x160 [btrfs]
> [  127.574396]  btrfs_write_and_wait_transaction+0x4f/0xd0 [btrfs]
> [  127.576877]  btrfs_commit_transaction+0x76a/0xae0 [btrfs]
> [  127.579328]  ? start_transaction+0xd2/0x5e0 [btrfs]
> [  127.581449]  prepare_to_relocate+0x107/0x130 [btrfs]
> [  127.583958]  relocate_block_group+0x5b/0x600 [btrfs]
> [  127.586867]  btrfs_relocate_block_group+0x15e/0x340 [btrfs]
> [  127.588999]  btrfs_relocate_chunk+0x38/0x110 [btrfs]
> [  127.590844]  btrfs_shrink_device+0x214/0x530 [btrfs]
> [  127.592345]  btrfs_rm_device+0x22e/0x7f0 [btrfs]
> [  127.593913]  ? _copy_from_user+0x6a/0xa0
> [  127.595367]  btrfs_ioctl+0x218f/0x2590 [btrfs]
> [  127.596993]  ? __handle_mm_fault+0x1c1/0x740
> [  127.598537]  ? do_user_addr_fault+0x1d8/0x3f0
> [  127.600139]  ? kvm_sched_clock_read+0x14/0x30
> [  127.601713]  ? sched_clock+0x5/0x10
> [  127.603121]  ? sched_clock_cpu+0x15/0x130
> [  127.604840]  ? do_user_addr_fault+0x1d8/0x3f0
> [  127.606740]  ? ksys_ioctl+0x68/0xa0
> [  127.608092]  ksys_ioctl+0x68/0xa0
> [  127.609434]  __x64_sys_ioctl+0x16/0x20
> [  127.610860]  do_syscall_64+0x50/0x210
> [  127.612294]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [  127.614042] RIP: 0033:0x7f69ecc34227
> [  127.615464] Code: 00 00 90 48 8b 05 69 8c 0c 00 64 c7 00 26 00 00 00=
 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 8c 0c 00 f7 d8 64 89 01 48
> [  127.621798] RSP: 002b:00007ffc4c0a4e08 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000010
> [  127.624742] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6=
9ecc34227
> [  127.627020] RDX: 00007ffc4c0a4e30 RSI: 000000005000943a RDI: 0000000=
000000003
> [  127.629398] RBP: 00007ffc4c0a6fd0 R08: 00007ffc4c0a4e68 R09: 0067647=
62f766564
> [  127.631559] R10: 00007f69ece5ecf0 R11: 0000000000000202 R12: 0000000=
000000000
> [  127.634138] R13: 00007ffc4c0a4e30 R14: 000056046c20be8c R15: 0000000=
000000003
> [  127.635759] irq event stamp: 108944
> [  127.637314] hardirqs last  enabled at (108943): [<ffffffff8a10a166>]=
 console_unlock+0x436/0x590
> [  127.640821] hardirqs last disabled at (108944): [<ffffffff8a002b5b>]=
 trace_hardirqs_off_thunk+0x1a/0x1c
> [  127.644549] softirqs last  enabled at (108940): [<ffffffff8aa0031e>]=
 __do_softirq+0x31e/0x55d
> [  127.647486] softirqs last disabled at (108933): [<ffffffff8a08d91d>]=
 irq_exit+0x9d/0xb0
> [  127.650608] ---[ end trace 247639532e5b557f ]---
> [  127.653165] BTRFS: error (device vdb) in btrfs_commit_transaction:23=
23: errno=3D-5 IO failure (Error while writing out transaction)
> [  127.657655] BTRFS info (device vdb): forced readonly
> [  127.659739] BTRFS warning (device vdb): Skipping commit of aborted t=
ransaction.
> [  127.663588] BTRFS: error (device vdb) in cleanup_transaction:1894: e=
rrno=3D-5 IO failure
> [failed, exit status 1] [19:40:22]- output mismatch (see /tmp/fstests/r=
esults//btrfs/003.out.bad)
>     --- tests/btrfs/003.out	2018-04-12 16:57:00.608225550 +0000
>     +++ /tmp/fstests/results//btrfs/003.out.bad	2020-05-15 19:40:22.176=
000000 +0000
>     @@ -1,2 +1,6 @@
>      QA output created by 003
>     -Silence is golden
>     +ERROR: error during balancing '/tmp/scratch': Read-only file syste=
m
>     +There may be more info in syslog - try dmesg | tail
>     +ERROR: error removing device '/dev/vdg': Read-only file system
>     +btrfs device delete failed
>     +(see /tmp/fstests/results//btrfs/003.full for details)
>     ...
>     (Run 'diff -u /tmp/fstests/tests/btrfs/003.out /tmp/fstests/results=
//btrfs/003.out.bad'  to see the entire diff)
>=20


--9St35R1dOjXTpcVuVmCdxyW63McqrkwFl--

--tbT09b1pewVJbJM1ZzbUt30G9p3RPT3VK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6/j7QACgkQwj2R86El
/qjsIwf7BMxqEoqbitb0/0GB2aWSqsFgSL1jSH+F/RI7iRVCgPqd12ov2VDBUgcO
q4pZwu659U3zWbHIg4PXnQ0+PB/+uO9gRHR65EkzSkXpSN8c6YwpgUMsSJ4vMKkO
HQUhrGeWr9r7LykFEy6DRtMNIsJ8lFHAPM4HDa54NmMXQIrals29LgSG7zzAMMiG
DhzYHUI73dlic8JA4U345/NWifZXtOgczVgBs1cTEHk+TXkvgxiwvSSOATYTu4GA
aM371PmCq08aLzKpdpcrStm5rzDUsThJ8hkchNospTwTU/CI8i1tXl1TTOwJfOAy
jEJpbch9PlpWP/6FVk9Nw+F51ornNQ==
=mfpx
-----END PGP SIGNATURE-----

--tbT09b1pewVJbJM1ZzbUt30G9p3RPT3VK--
