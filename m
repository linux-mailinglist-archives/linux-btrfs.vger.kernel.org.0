Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B012BEC9
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 21:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfL1UD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 15:03:28 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40852 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfL1UD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 15:03:28 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 082E3545997; Sat, 28 Dec 2019 15:03:26 -0500 (EST)
Date:   Sat, 28 Dec 2019 15:03:26 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: KASAN splat during mount on 5.4.5, no reproducer
Message-ID: <20191228200326.GD13306@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mounting the filesystem on a fresh boot...

	[   39.771351][ T4188] BTRFS info (device dm-3): enabling ssd optimizations
	[   39.772749][ T4188] BTRFS info (device dm-3): turning on flush-on-commit
	[   39.773929][ T4188] BTRFS info (device dm-3): turning on discard
	[   39.774888][ T4188] BTRFS info (device dm-3): use zstd compression, lev=
el 3
	[   39.776554][ T4188] BTRFS info (device dm-3): using free space tree
	[   39.777738][ T4188] BTRFS info (device dm-3): has skinny extents
	[  156.831607][ T4188] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[  156.833652][ T4188] BUG: KASAN: use-after-free in __list_del_entry_vali=
d+0x52/0x81
	[  156.835662][ T4188] Read of size 8 at addr ffff8881f34e0a50 by task mou=
nt/4188
	[  156.837026][ T4188]=20
	[  156.837435][ T4188] CPU: 2 PID: 4188 Comm: mount Not tainted 5.4.5-0eec=
f81ee46e+ #1
	[  156.838868][ T4188] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS 1.12.0-1 04/01/2014
	[  156.840490][ T4188] Call Trace:
	[  156.841195][ T4188]  dump_stack+0xc1/0x11a
	[  156.841937][ T4188]  ? __list_del_entry_valid+0x52/0x81
	[  156.842952][ T4188]  print_address_description.constprop.7+0x20/0x200
	[  156.844695][ T4188]  ? __list_del_entry_valid+0x52/0x81
	[  156.845616][ T4188]  ? __list_del_entry_valid+0x52/0x81
	[  156.847673][ T4188]  __kasan_report.cold.10+0x1b/0x39
	[  156.848624][ T4188]  ? __list_del_entry_valid+0x52/0x81
	[  156.849711][ T4188]  kasan_report+0x12/0x20
	[  156.850973][ T4188]  __asan_load8+0x54/0x90
	[  156.852261][ T4188]  __list_del_entry_valid+0x52/0x81
	[  156.853120][ T4188]  clean_dirty_subvols+0x7f/0x200
	[  156.854527][ T4188]  btrfs_recover_relocation+0x73c/0x770
	[  156.855462][ T4188]  ? btrfs_relocate_block_group+0x4f0/0x4f0
	[  156.856446][ T4188]  ? __del_qgroup_relation+0x440/0x440
	[  156.857529][ T4188]  open_ctree+0x2f4e/0x33f8
	[  156.858849][ T4188]  ? close_ctree+0x4e0/0x4e0
	[  156.860678][ T4188]  ? super_setup_bdi_name+0x11e/0x180
	[  156.861770][ T4188]  ? vfs_get_tree+0x150/0x150
	[  156.862653][ T4188]  ? snprintf+0x91/0xc0
	[  156.863479][ T4188]  btrfs_mount_root+0x809/0x990
	[  156.864884][ T4188]  ? btrfs_decode_error+0x40/0x40
	[  156.866954][ T4188]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[  156.869360][ T4188]  ? check_flags.part.42+0x86/0x220
	[  156.870419][ T4188]  ? __kasan_check_read+0x11/0x20
	[  156.871464][ T4188]  ? vfs_parse_fs_string+0xca/0x110
	[  156.872507][ T4188]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[  156.873617][ T4188]  ? rcu_read_lock_bh_held+0xb0/0xb0
	[  156.874731][ T4188]  ? __lookup_constant+0x54/0x90
	[  156.875735][ T4188]  ? debug_lockdep_rcu_enabled.part.18+0x1a/0x30
	[  156.877000][ T4188]  ? kfree+0x1dd/0x210
	[  156.877829][ T4188]  ? btrfs_decode_error+0x40/0x40
	[  156.878878][ T4188]  legacy_get_tree+0x89/0xd0
	[  156.880010][ T4188]  vfs_get_tree+0x52/0x150
	[  156.880926][ T4188]  fc_mount+0x14/0x60
	[  156.881742][ T4188]  vfs_kern_mount.part.35+0x61/0xa0
	[  156.882941][ T4188]  vfs_kern_mount+0x13/0x20
	[  156.883896][ T4188]  btrfs_mount+0x21a/0xbbe
	[  156.884783][ T4188]  ? check_chain_key+0x1e6/0x2e0
	[  156.885768][ T4188]  ? sched_clock_cpu+0x1b/0x120
	[  156.886769][ T4188]  ? btrfs_remount+0x7f0/0x7f0
	[  156.887807][ T4188]  ? check_flags.part.42+0x86/0x220
	[  156.888864][ T4188]  ? __kasan_check_read+0x11/0x20
	[  156.889927][ T4188]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[  156.891051][ T4188]  ? check_flags.part.42+0x86/0x220
	[  156.892100][ T4188]  ? __kasan_check_read+0x11/0x20
	[  156.893140][ T4188]  ? vfs_parse_fs_string+0xca/0x110
	[  156.894831][ T4188]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[  156.896399][ T4188]  ? rcu_read_lock_bh_held+0xb0/0xb0
	[  156.898575][ T4188]  ? __lookup_constant+0x54/0x90
	[  156.899992][ T4188]  ? debug_lockdep_rcu_enabled.part.18+0x1a/0x30
	[  156.901807][ T4188]  ? cap_capable+0xd2/0x110
	[  156.902983][ T4188]  ? btrfs_remount+0x7f0/0x7f0
	[  156.904129][ T4188]  legacy_get_tree+0x89/0xd0
	[  156.905021][ T4188]  ? btrfs_remount+0x7f0/0x7f0
	[  156.905957][ T4188]  ? legacy_get_tree+0x89/0xd0
	[  156.907026][ T4188]  vfs_get_tree+0x52/0x150
	[  156.907902][ T4188]  do_mount+0xe8c/0x10c0
	[  156.908732][ T4188]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[  156.909826][ T4188]  ? copy_mount_string+0x20/0x20
	[  156.911504][ T4188]  ? debug_lockdep_rcu_enabled.part.18+0x1a/0x30
	[  156.913203][ T4188]  ? kmem_cache_alloc_trace+0x5af/0x740
	[  156.914287][ T4188]  ? __kasan_check_write+0x14/0x20
	[  156.915258][ T4188]  ? __kasan_check_read+0x11/0x20
	[  156.916204][ T4188]  ? copy_mount_options+0x120/0x1e0
	[  156.917199][ T4188]  ksys_mount+0xb6/0xd0
	[  156.918362][ T4188]  __x64_sys_mount+0x67/0x80
	[  156.919684][ T4188]  do_syscall_64+0x77/0x2a0
	[  156.920701][ T4188]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[  156.922481][ T4188] RIP: 0033:0x7fe51245ffea
	[  156.923456][ T4188] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 =
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48
	[  156.929628][ T4188] RSP: 002b:00007ffc323252e8 EFLAGS: 00000246 ORIG_RA=
X: 00000000000000a5
	[  156.931386][ T4188] RAX: ffffffffffffffda RBX: 0000559d045b4b40 RCX: 00=
007fe51245ffea
	[  156.933199][ T4188] RDX: 0000559d045bc5e0 RSI: 0000559d045b4d90 RDI: 00=
00559d045b4ed0
	[  156.936309][ T4188] RBP: 00007fe5127ad1c4 R08: 0000559d045b4e20 R09: 00=
00559d045bca20
	[  156.937882][ T4188] R10: 0000000000000400 R11: 0000000000000246 R12: 00=
00000000000000
	[  156.939349][ T4188] R13: 0000000000000400 R14: 0000559d045b4ed0 R15: 00=
00559d045bc5e0
	[  156.940986][ T4188]=20
	[  156.941570][ T4188] Allocated by task 4188:
	[  156.942628][ T4188]  save_stack+0x21/0x90
	[  156.943485][ T4188]  __kasan_kmalloc.constprop.14+0xc1/0xd0
	[  156.944806][ T4188]  kasan_kmalloc+0x9/0x10
	[  156.945843][ T4188]  kmem_cache_alloc_trace+0x134/0x740
	[  156.947091][ T4188]  btrfs_read_tree_root+0x6d/0x1b0
	[  156.948080][ T4188]  btrfs_read_fs_root+0xf/0x60
	[  156.949010][ T4188]  btrfs_recover_relocation+0x205/0x770
	[  156.950080][ T4188]  open_ctree+0x2f4e/0x33f8
	[  156.951163][ T4188]  btrfs_mount_root+0x809/0x990
	[  156.952377][ T4188]  legacy_get_tree+0x89/0xd0
	[  156.953789][ T4188]  vfs_get_tree+0x52/0x150
	[  156.954727][ T4188]  fc_mount+0x14/0x60
	[  156.955785][ T4188]  vfs_kern_mount.part.35+0x61/0xa0
	[  156.957275][ T4188]  vfs_kern_mount+0x13/0x20
	[  156.958498][ T4188]  btrfs_mount+0x21a/0xbbe
	[  156.959413][ T4188]  legacy_get_tree+0x89/0xd0
	[  156.960326][ T4188]  vfs_get_tree+0x52/0x150
	[  156.961804][ T4188]  do_mount+0xe8c/0x10c0
	[  156.963439][ T4188]  ksys_mount+0xb6/0xd0
	[  156.964745][ T4188]  __x64_sys_mount+0x67/0x80
	[  156.965817][ T4188]  do_syscall_64+0x77/0x2a0
	[  156.966888][ T4188]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[  156.968160][ T4188]=20
	[  156.968792][ T4188] Freed by task 4188:
	[  156.970260][ T4188]  save_stack+0x21/0x90
	[  156.971212][ T4188]  __kasan_slab_free+0x118/0x170
	[  156.972610][ T4188]  kasan_slab_free+0xe/0x10
	[  156.973582][ T4188]  kfree+0xd1/0x210
	[  156.974391][ T4188]  btrfs_drop_snapshot+0xd68/0xfa0
	[  156.975424][ T4188]  clean_dirty_subvols+0x1bb/0x200
	[  156.976482][ T4188]  btrfs_recover_relocation+0x73c/0x770
	[  156.977665][ T4188]  open_ctree+0x2f4e/0x33f8
	[  156.978578][ T4188]  btrfs_mount_root+0x809/0x990
	[  156.979620][ T4188]  legacy_get_tree+0x89/0xd0
	[  156.980543][ T4188]  vfs_get_tree+0x52/0x150
	[  156.981433][ T4188]  fc_mount+0x14/0x60
	[  156.982365][ T4188]  vfs_kern_mount.part.35+0x61/0xa0
	[  156.983622][ T4188]  vfs_kern_mount+0x13/0x20
	[  156.984719][ T4188]  btrfs_mount+0x21a/0xbbe
	[  156.985642][ T4188]  legacy_get_tree+0x89/0xd0
	[  156.986614][ T4188]  vfs_get_tree+0x52/0x150
	[  156.987565][ T4188]  do_mount+0xe8c/0x10c0
	[  156.988531][ T4188]  ksys_mount+0xb6/0xd0
	[  156.989418][ T4188]  __x64_sys_mount+0x67/0x80
	[  156.991955][ T4188]  do_syscall_64+0x77/0x2a0
	[  156.993077][ T4188]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[  156.995441][ T4188]=20
	[  156.996116][ T4188] The buggy address belongs to the object at ffff8881=
f34e0000
	[  156.996116][ T4188]  which belongs to the cache kmalloc-4k of size 4096
	[  156.999361][ T4188] The buggy address is located 2640 bytes inside of
	[  156.999361][ T4188]  4096-byte region [ffff8881f34e0000, ffff8881f34e10=
00)
	[  157.002852][ T4188] The buggy address belongs to the page:
	[  157.004697][ T4188] page:ffffea0007cd3800 refcount:1 mapcount:0 mapping=
:ffff888107c028c0 index:0xffff8881f32d0ac0 compound_mapcount: 0
	[  157.007312][ T4188] raw: 017ffe0000010200 ffffea0007d7f188 ffffea00077c=
3488 ffff888107c028c0
	[  157.009094][ T4188] raw: ffff8881f32d0ac0 ffff8881f34e0000 000000010000=
0001 0000000000000000
	[  157.010976][ T4188] page dumped because: kasan: bad access detected
	[  157.012332][ T4188]=20
	[  157.012846][ T4188] Memory state around the buggy address:
	[  157.015055][ T4188]  ffff8881f34e0900: fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb
	[  157.019204][ T4188]  ffff8881f34e0980: fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb
	[  157.022892][ T4188] >ffff8881f34e0a00: fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb
	[  157.025313][ T4188]                                                  ^
	[  157.026785][ T4188]  ffff8881f34e0a80: fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb
	[  157.029435][ T4188]  ffff8881f34e0b00: fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb
	[  157.031585][ T4188] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[  157.033308][ T4188] Disabling lock debugging due to kernel taint
	[  165.881365][ T4188] list_del corruption. prev->next should be ffff8881c=
e3b4a50, but was 0000000000000000
	[  165.883152][ T4188] ------------[ cut here ]------------
	[  165.884214][ T4188] kernel BUG at lib/list_debug.c:53!

[...etc...it dumps the same stacks again in the BUG]

The deepest level of fs/btrfs code is the list_del_init in
clean_dirty_subvols.

After a reboot the next mount (and all subsequent mounts so far)
was successful.  I don't have a reproducer.

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXge1CgAKCRCB+YsaVrMb
nA1GAJ4r7k40Rd0s6Zc1oevO8qSBoohlcgCdGGcGoEoSSJRDfr+HmTH9hfS38/0=
=P0Kt
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
