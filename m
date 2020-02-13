Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4922415CA7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 19:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgBMSgR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 13:36:17 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34626 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgBMSgR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 13:36:17 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 99A795C215E; Thu, 13 Feb 2020 13:36:16 -0500 (EST)
Date:   Thu, 13 Feb 2020 13:36:16 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: KASAN splat during mount on 5.4.5...and 5.5.3
Message-ID: <20200213183616.GO13306@hungrycats.org>
References: <20191228200326.GD13306@hungrycats.org>
 <20200120194650.GO3929@twin.jikos.cz>
 <20200203184425.GV13306@hungrycats.org>
 <20200213052050.GN13306@hungrycats.org>
 <cc204493-0730-c2e6-16b8-7356534df236@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yyDlEBSQJ3H1meLT"
Content-Disposition: inline
In-Reply-To: <cc204493-0730-c2e6-16b8-7356534df236@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--yyDlEBSQJ3H1meLT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 01:57:32PM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2020/2/13 =E4=B8=8B=E5=8D=881:20, Zygo Blaxell wrote:
> > On Mon, Feb 03, 2020 at 01:44:25PM -0500, Zygo Blaxell wrote:
> >> On Mon, Jan 20, 2020 at 08:46:50PM +0100, David Sterba wrote:
> >>> On Sat, Dec 28, 2019 at 03:03:26PM -0500, Zygo Blaxell wrote:
> >>>>
> >>>> [...etc...it dumps the same stacks again in the BUG]
> >>>>
> >>>> The deepest level of fs/btrfs code is the list_del_init in
> >>>> clean_dirty_subvols.
> >>>>
> >>>> After a reboot the next mount (and all subsequent mounts so far)
> >>>> was successful.  I don't have a reproducer.
> >>>
> >>> For the record, this and other KASAN reports regarding reloc root, is
> >>> going to be fixed in 5.4.14, "btrfs: relocation: fix reloc_root lifes=
pan
> >>> and access" (6282675e6708ec78). Thanks for the reports and debugging
> >>> help.
> >>
> >> Confirmed:  I have not seen this bug since applying the first versions=
 of
> >> the patch to my test kernels in 5.4.8. =20
> >=20
> > D'oh...maybe not?  Here's 5.5.3:
> >=20
> > 	[   40.692923][ T4088] BTRFS info (device dm-3): enabling ssd optimiza=
tions
> > 	[   40.694158][ T4088] BTRFS info (device dm-3): turning on flush-on-c=
ommit
> > 	[   40.695344][ T4088] BTRFS info (device dm-3): turning on discard
> > 	[   40.696375][ T4088] BTRFS info (device dm-3): use zstd compression,=
 level 3
> > 	[   40.697563][ T4088] BTRFS info (device dm-3): using free space tree
> > 	[   40.698639][ T4088] BTRFS info (device dm-3): has skinny extents
> > 	[   53.675342][ T4088] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > 	[   53.676988][ T4088] BUG: KASAN: use-after-free in __list_del_entry_=
valid+0x52/0x81
> > 	[   53.678199][ T4088] Read of size 8 at addr ffff8881d1f74a50 by task=
 mount/4088
> > 	[   53.679267][ T4088]=20
> > 	[   53.679620][ T4088] CPU: 1 PID: 4088 Comm: mount Not tainted 5.5.3-=
69e958fb39c2+ #6
> > 	[   53.680736][ T4088] Hardware name: QEMU Standard PC (i440FX + PIIX,=
 1996), BIOS 1.12.0-1 04/01/2014
> > 	[   53.682089][ T4088] Call Trace:
> > 	[   53.682587][ T4088]  dump_stack+0xc1/0x11a
> > 	[   53.683372][ T4088]  ? __list_del_entry_valid+0x52/0x81
> > 	[   53.684170][ T4088]  print_address_description.constprop.7+0x20/0x2=
00
> > 	[   53.685163][ T4088]  ? __list_del_entry_valid+0x52/0x81
> > 	[   53.685943][ T4088]  ? __list_del_entry_valid+0x52/0x81
> > 	[   53.686727][ T4088]  __kasan_report.cold.10+0x1b/0x39
> > 	[   53.687490][ T4088]  ? __list_del_entry_valid+0x52/0x81
> > 	[   53.688272][ T4088]  kasan_report+0x12/0x20
> > 	[   53.688906][ T4088]  __asan_load8+0x54/0x90
> > 	[   53.689534][ T4088]  __list_del_entry_valid+0x52/0x81
> > 	[   53.690287][ T4088]  clean_dirty_subvols+0x7f/0x230
> > 	[   53.691034][ T4088]  btrfs_recover_relocation+0x738/0x7c0
>=20
> That's from the mount time recovery path.
>=20
> I guess it's the list_del_init() in clean_dirty_subvols(), which means
> its root->reloc_dirty_list is not properly initialized?
>=20
> That doesn't even make sense.
> As that root is grabbed from list_for_each_entry_safe(), using
> reloc_dirty_list.
>=20
> This doesn't look correct, do you have similar reports with similar
> backtrace?

Only these two so far.  The previous one was on 5.4.5.  I've done about
50 mounts in between on various kernels without incident.

All of these are mounts after a crash while under heavy write load,
either due to a natural kernel bug or forced by resetting the VM.
I don't bother testing clean umounts or crashes while idle--those are
not typical operating conditions in the production environment.  ;)

My guess is that you could reproduce this by setting up a VM to run
continuous write stress workloads, then force-reboot the VM over and
over until this reproduces.  Shouldn't take more than 100 cycles to hit
the stack trace.



> Thanks,
> Qu
>=20
>=20
> > 	[   53.691856][ T4088]  ? btrfs_relocate_block_group+0x4e0/0x4e0
> > 	[   53.692717][ T4088]  ? __del_qgroup_relation+0x440/0x440
> > 	[   53.693513][ T4088]  ? migrate_swap_stop+0x3e0/0x3e0
> > 	[   53.694249][ T4088]  ? _raw_read_unlock+0x22/0x30
> > 	[   53.694982][ T4088]  open_ctree+0x2db1/0x34b0
> > 	[   53.695691][ T4088]  ? close_ctree+0x4a4/0x4a4
> > 	[   53.696380][ T4088]  btrfs_mount_root.cold.69+0xe/0x10e
> > 	[   53.697177][ T4088]  ? btrfs_decode_error+0x40/0x40
> > 	[   53.697935][ T4088]  ? rcu_read_lock_sched_held+0xa1/0xd0
> > 	[   53.698735][ T4088]  ? check_flags.part.42+0x86/0x220
> > 	[   53.699491][ T4088]  ? __kasan_check_read+0x11/0x20
> > 	[   53.700218][ T4088]  ? vfs_parse_fs_string+0xca/0x110
> > 	[   53.700972][ T4088]  ? rcu_read_lock_sched_held+0xa1/0xd0
> > 	[   53.701772][ T4088]  ? rcu_read_lock_bh_held+0xb0/0xb0
> > 	[   53.702532][ T4088]  ? __lookup_constant+0x54/0x90
> > 	[   53.703244][ T4088]  ? debug_lockdep_rcu_enabled.part.18+0x1a/0x30
> > 	[   53.704160][ T4088]  ? kfree+0x1dd/0x210
> > 	[   53.704760][ T4088]  ? btrfs_decode_error+0x40/0x40
> > 	[   53.705486][ T4088]  legacy_get_tree+0x89/0xd0
> > 	[   53.706152][ T4088]  vfs_get_tree+0x52/0x150
> > 	[   53.706814][ T4088]  fc_mount+0x14/0x60
> > 	[   53.707391][ T4088]  vfs_kern_mount.part.36+0x61/0xa0
> > 	[   53.708149][ T4088]  vfs_kern_mount+0x13/0x20
> > 	[   53.708797][ T4088]  btrfs_mount+0x21a/0xbbe
> > 	[   53.709430][ T4088]  ? check_chain_key+0x1e6/0x2e0
> > 	[   53.710142][ T4088]  ? sched_clock_cpu+0x1b/0x120
> > 	[   53.710856][ T4088]  ? btrfs_remount+0x7f0/0x7f0
> > 	[   53.711544][ T4088]  ? check_flags.part.42+0x86/0x220
> > 	[   53.712291][ T4088]  ? __kasan_check_read+0x11/0x20
> > 	[   53.713025][ T4088]  ? rcu_read_lock_sched_held+0xa1/0xd0
> > 	[   53.713825][ T4088]  ? check_flags.part.42+0x86/0x220
> > 	[   53.714575][ T4088]  ? __kasan_check_read+0x11/0x20
> > 	[   53.715304][ T4088]  ? vfs_parse_fs_string+0xca/0x110
> > 	[   53.716056][ T4088]  ? rcu_read_lock_sched_held+0xa1/0xd0
> > 	[   53.716855][ T4088]  ? rcu_read_lock_bh_held+0xb0/0xb0
> > 	[   53.717612][ T4088]  ? __lookup_constant+0x54/0x90
> > 	[   53.718329][ T4088]  ? cap_capable+0xd2/0x110
> > 	[   53.718994][ T4088]  ? btrfs_remount+0x7f0/0x7f0
> > 	[   53.719680][ T4088]  legacy_get_tree+0x89/0xd0
> > 	[   53.720334][ T4088]  ? legacy_get_tree+0x89/0xd0
> > 	[   53.721029][ T4088]  vfs_get_tree+0x52/0x150
> > 	[   53.721675][ T4088]  do_mount+0xe7d/0x10b0
> > 	[   53.722280][ T4088]  ? rcu_read_lock_sched_held+0xa1/0xd0
> > 	[   53.723110][ T4088]  ? copy_mount_string+0x20/0x20
> > 	[   53.723820][ T4088]  ? debug_lockdep_rcu_enabled.part.18+0x1a/0x30
> > 	[   53.724732][ T4088]  ? kmem_cache_alloc_trace+0x5af/0x740
> > 	[   53.725533][ T4088]  ? __kasan_check_write+0x14/0x20
> > 	[   53.726277][ T4088]  ? __kasan_check_read+0x11/0x20
> > 	[   53.727000][ T4088]  ? copy_mount_options+0x120/0x1e0
> > 	[   53.727762][ T4088]  __x64_sys_mount+0x100/0x120
> > 	[   53.728463][ T4088]  do_syscall_64+0x77/0x2c0
> > 	[   53.729118][ T4088]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 	[   53.729962][ T4088] RIP: 0033:0x7fc1d6a4ffea
> > 	[   53.730598][ T4088] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 83=
 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00=
 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 =
48
> > 	[   53.733376][ T4088] RSP: 002b:00007ffcf166ba18 EFLAGS: 00000246 ORI=
G_RAX: 00000000000000a5
> > 	[   53.734579][ T4088] RAX: ffffffffffffffda RBX: 0000558f7d225b40 RCX=
: 00007fc1d6a4ffea
> > 	[   53.735714][ T4088] RDX: 0000558f7d22d5e0 RSI: 0000558f7d225d90 RDI=
: 0000558f7d225ed0
> > 	[   53.736848][ T4088] RBP: 00007fc1d6d9d1c4 R08: 0000558f7d225e20 R09=
: 0000558f7d22da20
> > 	[   53.737984][ T4088] R10: 0000000000000400 R11: 0000000000000246 R12=
: 0000000000000000
> > 	[   53.739120][ T4088] R13: 0000000000000400 R14: 0000558f7d225ed0 R15=
: 0000558f7d22d5e0
> > 	[   53.740636][ T4088] Allocated by task 4088:
> > 	[   53.741254][ T4088]  save_stack+0x21/0x90
> > 	[   53.741850][ T4088]  __kasan_kmalloc.constprop.16+0xc1/0xd0
> > 	[   53.742668][ T4088]  kasan_kmalloc+0x9/0x10
> > 	[   53.743286][ T4088]  kmem_cache_alloc_trace+0x134/0x740
> > 	[   53.744056][ T4088]  btrfs_read_tree_root+0x6d/0x1b0
> > 	[   53.744788][ T4088]  btrfs_read_fs_root+0xf/0x60
> > 	[   53.745473][ T4088]  btrfs_recover_relocation+0x205/0x7c0
> > 	[   53.746261][ T4088]  open_ctree+0x2db1/0x34b0
> > 	[   53.746905][ T4088]  btrfs_mount_root.cold.69+0xe/0x10e
> > 	[   53.747673][ T4088]  legacy_get_tree+0x89/0xd0
> > 	[   53.748326][ T4088]  vfs_get_tree+0x52/0x150
> > 	[   53.748966][ T4088]  fc_mount+0x14/0x60
> > 	[   53.749542][ T4088]  vfs_kern_mount.part.36+0x61/0xa0
> > 	[   53.750287][ T4088]  vfs_kern_mount+0x13/0x20
> > 	[   53.750938][ T4088]  btrfs_mount+0x21a/0xbbe
> > 	[   53.751571][ T4088]  legacy_get_tree+0x89/0xd0
> > 	[   53.752224][ T4088]  vfs_get_tree+0x52/0x150
> > 	[   53.752858][ T4088]  do_mount+0xe7d/0x10b0
> > 	[   53.753467][ T4088]  __x64_sys_mount+0x100/0x120
> > 	[   53.754152][ T4088]  do_syscall_64+0x77/0x2c0
> > 	[   53.754801][ T4088]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 	[   53.755647][ T4088]=20
> > 	[   53.755985][ T4088] Freed by task 4088:
> > 	[   53.756563][ T4088]  save_stack+0x21/0x90
> > 	[   53.757159][ T4088]  __kasan_slab_free+0x118/0x170
> > 	[   53.757872][ T4088]  kasan_slab_free+0xe/0x10
> > 	[   53.758516][ T4088]  kfree+0xd1/0x210
> > 	[   53.759063][ T4088]  btrfs_drop_snapshot+0xde0/0x1010
> > 	[   53.759809][ T4088]  clean_dirty_subvols+0x1d2/0x230
> > 	[   53.760541][ T4088]  btrfs_recover_relocation+0x738/0x7c0
> > 	[   53.761339][ T4088]  open_ctree+0x2db1/0x34b0
> > 	[   53.761996][ T4088]  btrfs_mount_root.cold.69+0xe/0x10e
> > 	[   53.762762][ T4088]  legacy_get_tree+0x89/0xd0
> > 	[   53.763416][ T4088]  vfs_get_tree+0x52/0x150
> > 	[   53.764055][ T4088]  fc_mount+0x14/0x60
> > 	[   53.764632][ T4088]  vfs_kern_mount.part.36+0x61/0xa0
> > 	[   53.765377][ T4088]  vfs_kern_mount+0x13/0x20
> > 	[   53.766024][ T4088]  btrfs_mount+0x21a/0xbbe
> > 	[   53.766660][ T4088]  legacy_get_tree+0x89/0xd0
> > 	[   53.767313][ T4088]  vfs_get_tree+0x52/0x150
> > 	[   53.767952][ T4088]  do_mount+0xe7d/0x10b0
> > 	[   53.768565][ T4088]  __x64_sys_mount+0x100/0x120
> > 	[   53.769240][ T4088]  do_syscall_64+0x77/0x2c0
> > 	[   53.769888][ T4088]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 	[   53.770728][ T4088]=20
> > 	[   53.771066][ T4088] The buggy address belongs to the object at ffff=
8881d1f74000
> > 	[   53.771066][ T4088]  which belongs to the cache kmalloc-4k of size =
4096
> > 	[   53.773068][ T4088] The buggy address is located 2640 bytes inside =
of
> > 	[   53.773068][ T4088]  4096-byte region [ffff8881d1f74000, ffff8881d1=
f75000)
> > 	[   53.774978][ T4088] The buggy address belongs to the page:
> > 	[   53.775786][ T4088] page:ffffea000747dd00 refcount:1 mapcount:0 map=
ping:ffff888107c02c40 index:0xffff8881e4d680c0 compound_mapcount: 0
> > 	[   53.777519][ T4088] raw: 017ffe0000010200 ffffea0007903c08 ffffea00=
078dbe88 ffff888107c02c40
> > 	[   53.778740][ T4088] raw: ffff8881e4d680c0 ffff8881d1f74000 00000001=
00000001 0000000000000000
> > 	[   53.780019][ T4088] page dumped because: kasan: bad access detected
> > 	[   53.780950][ T4088]=20
> > 	[   53.781293][ T4088] Memory state around the buggy address:
> > 	[   53.782138][ T4088]  ffff8881d1f74900: fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb
> > 	[   53.783350][ T4088]  ffff8881d1f74980: fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb
> > 	[   53.784568][ T4088] >ffff8881d1f74a00: fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb
> > 	[   53.785780][ T4088]                                                =
  ^
> > 	[   53.786785][ T4088]  ffff8881d1f74a80: fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb
> > 	[   53.787994][ T4088]  ffff8881d1f74b00: fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb
> > 	[   53.789203][ T4088] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > 	[   53.790409][ T4088] Disabling lock debugging due to kernel taint
> > 	[   53.886422][ T4088] BTRFS info (device dm-3): balance: resume skipp=
ed
> > 	[   53.888140][ T4088] BTRFS info (device dm-3): checking UUID tree
> > 	[   73.938826][ T4293] BTRFS debug (device dm-3): cleaner removing 9497
> >=20
>=20




--yyDlEBSQJ3H1meLT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXkWXHgAKCRCB+YsaVrMb
nI22AJ9QUl7GzpN/jsR16RUI1P+EeVoTjQCgrai+vb76iKMR8PqhwxSFQc2PFLY=
=8iNW
-----END PGP SIGNATURE-----

--yyDlEBSQJ3H1meLT--
