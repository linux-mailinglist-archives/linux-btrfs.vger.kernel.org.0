Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A183F1E02A0
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 May 2020 21:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbgEXTvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 May 2020 15:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbgEXTvt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 May 2020 15:51:49 -0400
Received: from mxa2.seznam.cz (mxa2.seznam.cz [IPv6:2a02:598:2::90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19474C061A0E
        for <linux-btrfs@vger.kernel.org>; Sun, 24 May 2020 12:51:48 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc28b.ng.seznam.cz (email-smtpc28b.ng.seznam.cz [10.23.18.41])
        id 3152b8e44ba6d2353152ba93;
        Sun, 24 May 2020 21:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1590349905; bh=QBYO9lN21p/vd4k4XolwPwiFU3F4WFKBugiZ9lPOgZE=;
        h=Received:Message-ID:Subject:From:To:Date:In-Reply-To:References:
         Content-Type:X-Mailer:Mime-Version:Content-Transfer-Encoding;
        b=AUdqUi3GBFPLc3sASk3dM/qD4KewsDgSfff2HsHyX/QMly2pAKFvL55ZMollF2v74
         Cv/IJXKpWamU+phR+/GCO0EJZNhf9Z6dL7XVMfO59X7P6AulgPA+TFaR1bYoAHP0nG
         Z9tAbF6vOl/e0BvPE+I+F40eG+4XS/afC8tkdVB0=
Received: from lisicky.cdnet.czf (82-150-191-10.client.rionet.cz [82.150.191.10])
        by email-relay4.ng.seznam.cz (Seznam SMTPD 1.3.114) with ESMTP;
        Sun, 24 May 2020 21:51:39 +0200 (CEST)  
Message-ID: <4a07e00332bfdcd4ca666724c5c1fabc8ba402f0.camel@seznam.cz>
Subject: Re: I can't mount image
From:   =?UTF-8?Q?Ji=C5=99=C3=AD_Lisick=C3=BD?= <jiri_lisicky@seznam.cz>
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Sun, 24 May 2020 21:51:38 +0200
In-Reply-To: <CAJCQCtQmTan=rrRJ2ALM25DnUt05Xdsuae9GR88L5mB=OR+QVA@mail.gmail.com>
References: <1e6bc0e299901f90613550570446777fbccdc21e.camel@seznam.cz>
         <CAJCQCtSWX0J69SokSOgAhdcQ6qkKHfaPVhbF4anjCtVFACOVnQ@mail.gmail.com>
         <139f40a70cf37da2fef682c5c3d660671d8af88d.camel@seznam.cz>
         <CAJCQCtQXBphGneiHJT_O7VHgZkfqfHaxmkAwFEzGPXY5E7U_cA@mail.gmail.com>
         <3bc39223e567b7a4eca13bc554c74ef0c36fbaf2.camel@seznam.cz>
         <CAJCQCtQmTan=rrRJ2ALM25DnUt05Xdsuae9GR88L5mB=OR+QVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy p=C3=AD=C5=A1e v So 23. 05. 2020 v 17:21 -0600:
> On Sat, May 23, 2020 at 8:38 AM Ji=C5=99=C3=AD Lisick=C3=BD <jiri_lisicky=
@seznam.cz> wrote:
> >=20
> > [root@localhost-live tmp] # btrfs rescue super -v /dev/loop4
> > All Devices:
> >         Device: id =3D 1, name =3D /dev/loop4
> >=20
> > Before Recovering:
> >         [All good supers]:
> >                 device name =3D /dev/loop4
> >                 superblock bytenr =3D 65536
> >=20
> >                 device name =3D /dev/loop4
> >                 superblock bytenr =3D 67108864
> >=20
> >         [All bad supers]:
> >=20
> > All supers are valid, no need to recover
>=20
> OK. So they're good.
>=20
> >=20
> >=20
> >=20
> > [root@localhost-live tmp]# mount -o ro,recovery /dev/loop4 ./mnt
> > mount: /home/jirka/tmp/mnt: can't read superblock on /dev/loop4.
>=20
>=20
> But it can't be read? This doesn't make sense. What kernel messages
> are reported at the time of the mount attempt? When using a newer
> kernel, the recovery command is deprecated but should still work. The
> new command is 'usebackuproot'

[root@localhost-live tmp]# mount -o usebackuproot /dev/loop4 ./mnt
mount: /home/jirka/tmp/mnt: can't read superblock on /dev/loop4.

log:
May 24 15:33:56 localhost-live kernel: BTRFS info (device loop4): trying to=
 use backup root at mount time
May 24 15:33:56 localhost-live kernel: BTRFS info (device loop4): disk spac=
e caching is enabled
May 24 15:33:56 localhost-live kernel: BTRFS critical (device loop4): corru=
pt leaf: root=3D1 block=3D48295936 slot=3D2, invalid root item size, have 2=
39 expect 439
May 24 15:33:56 localhost-live kernel: BTRFS critical (device loop4): corru=
pt leaf: root=3D1 block=3D48295936 slot=3D5, invalid root item size, have 2=
39 expect 439
May 24 15:33:56 localhost-live kernel: BTRFS critical (device loop4): corru=
pt leaf: root=3D1 block=3D48295936 slot=3D7, invalid root item size, have 2=
39 expect 439
May 24 15:33:56 localhost-live kernel: BTRFS warning (device loop4): mismat=
ching generation and generation_v2 found in root item. This root was probab=
ly mounted with an older kernel. Resetting all new fields.
May 24 15:33:56 localhost-live kernel: BTRFS warning (device loop4): mismat=
ching generation and generation_v2 found in root item. This root was probab=
ly mounted with an older kernel. Resetting all new fields.
May 24 15:33:56 localhost-live kernel: BTRFS error (device loop4): qgroup g=
eneration mismatch, marked as inconsistent
May 24 15:33:56 localhost-live kernel: BTRFS info (device loop4): start tre=
e-log replay
May 24 15:33:56 localhost-live kernel: BTRFS critical (device loop4): corru=
pt leaf: root=3D18446744073709551610 block=3D94920704 slot=3D0, invalid roo=
t item size, have 239 expect 439
May 24 15:33:56 localhost-live kernel: ------------[ cut here ]------------
May 24 15:33:56 localhost-live kernel: btrfs bad mapping eb start 94920704 =
len 4096, wanted 3857 439
May 24 15:33:56 localhost-live kernel: WARNING: CPU: 1 PID: 174 at fs/btrfs=
/extent_io.c:5549 read_extent_buffer+0x10f/0x140 [btrfs]
May 24 15:33:56 localhost-live kernel: Modules linked in: nft_fib_inet nft_=
fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6=
 nft_reject nft_ct nf_tables_set nft_chain_nat ip6table_nat ip6table_mangle=
 ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set nf_ta=
bles nfnetlink ip6table_filter ip6_tables iptable_filter snd_hda_codec_hdmi=
 snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio intel_rapl_msr i=
ntel_rapl_common x86_pkg_temp_thermal snd_hda_intel intel_powerclamp snd_in=
tel_dspcfg snd_hda_codec coretemp i915 snd_hda_core kvm_intel snd_hwdep snd=
_seq kvm snd_seq_device joydev snd_pcm irqbypass intel_cstate intel_uncore =
snd_timer intel_rapl_perf snd cec ppdev iTCO_wdt hp_wmi mei_hdcp iTCO_vendo=
r_support mei_wdt parport_pc sparse_keymap soundcore parport rfkill i2c_alg=
o_bit wmi_bmof drm_kms_helper mei_me tpm_infineon mei i2c_i801 lpc_ich pcsp=
kr drm ip_tables nls_utf8 isofs squashfs dm_multipath
May 24 15:33:56 localhost-live kernel:  8021q garp mrp stp llc crct10dif_pc=
lmul crc32_pclmul e1000e ghash_clmulni_intel serio_raw wmi video btrfs blak=
e2b_generic xor zstd_compress raid6_pq libcrc32c crc32c_intel zstd_decompre=
ss sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb4 cxgb3i cxgb3 mdio libcxgbi l=
ibcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi loop fuse s=
csi_transport_iscsi
May 24 15:33:56 localhost-live kernel: CPU: 1 PID: 174 Comm: kworker/u8:3 N=
ot tainted 5.6.6-300.fc32.x86_64 #1
May 24 15:33:56 localhost-live kernel: Hardware name: Hewlett-Packard HP Co=
mpaq Elite 8300 SFF/3397, BIOS K01 v02.05 05/07/2012
May 24 15:33:56 localhost-live kernel: Workqueue: btrfs-endio-meta btrfs_wo=
rk_helper [btrfs]
May 24 15:33:56 localhost-live kernel: RIP: 0010:read_extent_buffer+0x10f/0=
x140 [btrfs]
May 24 15:33:56 localhost-live kernel: Code: c3 8b 0e 89 4d 00 89 c1 8b 74 =
0e fc 89 74 0d fc e9 72 ff ff ff 48 89 d1 4d 89 e0 4c 89 ca 48 c7 c7 e0 91 =
4d c0 e8 38 a4 c8 f9 <0f> 0b 31 f6 4c 89 e2 48 89 ef 5d 41 5c e9 bf 31 5d f=
a 89 c1 0f b7
May 24 15:33:56 localhost-live kernel: RSP: 0018:ffffb49dc026ba40 EFLAGS: 0=
0010286
May 24 15:33:56 localhost-live kernel: RAX: 000000000000003d RBX: ffff9a370=
48b0000 RCX: 0000000000000007
May 24 15:33:56 localhost-live kernel: RDX: 00000000fffffff8 RSI: 000000000=
0000082 RDI: ffff9a37d6a99cc0
May 24 15:33:56 localhost-live kernel: RBP: ffffb49dc026ba59 R08: 000000000=
0000422 R09: ffffb49dc026b8d0
May 24 15:33:56 localhost-live kernel: R10: 0000000000000005 R11: 000000000=
0000000 R12: 00000000000001b7
May 24 15:33:56 localhost-live kernel: R13: 0000000000000065 R14: ffff9a370=
570f5a8 R15: 0000000000000f9b
May 24 15:33:56 localhost-live kernel: FS:  0000000000000000(0000) GS:ffff9=
a37d6a80000(0000) knlGS:0000000000000000
May 24 15:33:56 localhost-live kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
May 24 15:33:56 localhost-live kernel: CR2: 00007ffb02c1f2b8 CR3: 00000000a=
960a005 CR4: 00000000000606e0
May 24 15:33:56 localhost-live kernel: Call Trace:
May 24 15:33:56 localhost-live kernel:  check_root_item+0x8b/0x180 [btrfs]
May 24 15:33:56 localhost-live kernel:  ? crc_42+0x1e/0x1e [crc32c_intel]
May 24 15:33:56 localhost-live kernel:  ? crc32c_pcl_intel_update+0xa4/0xb0=
 [crc32c_intel]
May 24 15:33:56 localhost-live kernel:  ? crc32c_intel_init+0x20/0x20 [crc3=
2c_intel]
May 24 15:33:56 localhost-live kernel:  ? csum_tree_block+0x11f/0x130 [btrf=
s]
May 24 15:33:56 localhost-live kernel:  ? intel_cpufreq_target+0x140/0x140
May 24 15:33:56 localhost-live kernel:  ? update_load_avg+0x7a/0x640
May 24 15:33:56 localhost-live kernel:  ? intel_cpufreq_target+0x140/0x140
May 24 15:33:56 localhost-live kernel:  ? enqueue_entity+0x177/0x770
May 24 15:33:56 localhost-live kernel:  ? btrfs_get_32+0x38/0x80 [btrfs]
May 24 15:33:56 localhost-live kernel:  check_leaf+0x489/0x1530 [btrfs]
May 24 15:33:56 localhost-live kernel:  ? clear_state_bit+0x140/0x1a0 [btrf=
s]
May 24 15:33:56 localhost-live kernel:  ? map_private_extent_buffer+0xd0/0x=
d0 [btrfs]
May 24 15:33:56 localhost-live kernel:  btree_readpage_end_io_hook+0x2de/0x=
320 [btrfs]
May 24 15:33:56 localhost-live kernel:  end_bio_extent_readpage+0x1c0/0x710=
 [btrfs]
May 24 15:33:56 localhost-live kernel:  ? __rq_qos_done_bio+0x24/0x30
May 24 15:33:56 localhost-live kernel:  end_workqueue_fn+0x29/0x40 [btrfs]
May 24 15:33:56 localhost-live kernel:  btrfs_work_helper+0xd6/0x3a0 [btrfs=
]
May 24 15:33:56 localhost-live kernel:  process_one_work+0x1b4/0x380
May 24 15:33:56 localhost-live kernel:  worker_thread+0x53/0x3e0
May 24 15:33:56 localhost-live kernel:  ? process_one_work+0x380/0x380
May 24 15:33:56 localhost-live kernel:  kthread+0x115/0x140
May 24 15:33:56 localhost-live kernel:  ? __kthread_bind_mask+0x60/0x60
May 24 15:33:56 localhost-live kernel:  ret_from_fork+0x35/0x40
May 24 15:33:56 localhost-live kernel: ---[ end trace 013462e0cfd87fc0 ]---
May 24 15:33:56 localhost-live kernel: BTRFS critical (device loop4): corru=
pt leaf: root=3D18446744073709551610 block=3D94920704 slot=3D1, invalid roo=
t item size, have 239 expect 439
May 24 15:33:56 localhost-live kernel: BTRFS error (device loop4): parent t=
ransid verify failed on 94920704 wanted 2727500 found 2727499
May 24 15:33:56 localhost-live kernel: BTRFS critical (device loop4): corru=
pt leaf: root=3D18446744073709551610 block=3D94920704 slot=3D0, invalid roo=
t item size, have 239 expect 439
May 24 15:33:56 localhost-live kernel: ------------[ cut here ]------------
May 24 15:33:56 localhost-live kernel: btrfs bad mapping eb start 94920704 =
len 4096, wanted 3857 439
May 24 15:33:56 localhost-live kernel: WARNING: CPU: 1 PID: 174 at fs/btrfs=
/extent_io.c:5549 read_extent_buffer+0x10f/0x140 [btrfs]
May 24 15:33:56 localhost-live kernel: Modules linked in: nft_fib_inet nft_=
fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6=
 nft_reject nft_ct nf_tables_set nft_chain_nat ip6table_nat ip6table_mangle=
 ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set nf_ta=
bles nfnetlink ip6table_filter ip6_tables iptable_filter snd_hda_codec_hdmi=
 snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio intel_rapl_msr i=
ntel_rapl_common x86_pkg_temp_thermal snd_hda_intel intel_powerclamp snd_in=
tel_dspcfg snd_hda_codec coretemp i915 snd_hda_core kvm_intel snd_hwdep snd=
_seq kvm snd_seq_device joydev snd_pcm irqbypass intel_cstate intel_uncore =
snd_timer intel_rapl_perf snd cec ppdev iTCO_wdt hp_wmi mei_hdcp iTCO_vendo=
r_support mei_wdt parport_pc sparse_keymap soundcore parport rfkill i2c_alg=
o_bit wmi_bmof drm_kms_helper mei_me tpm_infineon mei i2c_i801 lpc_ich pcsp=
kr drm ip_tables nls_utf8 isofs squashfs dm_multipath
May 24 15:33:56 localhost-live kernel:  8021q garp mrp stp llc crct10dif_pc=
lmul crc32_pclmul e1000e ghash_clmulni_intel serio_raw wmi video btrfs blak=
e2b_generic xor zstd_compress raid6_pq libcrc32c crc32c_intel zstd_decompre=
ss sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb4 cxgb3i cxgb3 mdio libcxgbi l=
ibcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi loop fuse s=
csi_transport_iscsi
May 24 15:33:56 localhost-live kernel: CPU: 1 PID: 174 Comm: kworker/u8:3 T=
ainted: G        W         5.6.6-300.fc32.x86_64 #1
May 24 15:33:56 localhost-live kernel: Hardware name: Hewlett-Packard HP Co=
mpaq Elite 8300 SFF/3397, BIOS K01 v02.05 05/07/2012
May 24 15:33:56 localhost-live kernel: Workqueue: btrfs-endio-meta btrfs_wo=
rk_helper [btrfs]
May 24 15:33:56 localhost-live kernel: RIP: 0010:read_extent_buffer+0x10f/0=
x140 [btrfs]
May 24 15:33:56 localhost-live kernel: Code: c3 8b 0e 89 4d 00 89 c1 8b 74 =
0e fc 89 74 0d fc e9 72 ff ff ff 48 89 d1 4d 89 e0 4c 89 ca 48 c7 c7 e0 91 =
4d c0 e8 38 a4 c8 f9 <0f> 0b 31 f6 4c 89 e2 48 89 ef 5d 41 5c e9 bf 31 5d f=
a 89 c1 0f b7
May 24 15:33:56 localhost-live kernel: RSP: 0018:ffffb49dc026ba40 EFLAGS: 0=
0010286
May 24 15:33:56 localhost-live kernel: RAX: 000000000000003d RBX: ffff9a370=
48b0000 RCX: 0000000000000007
May 24 15:33:56 localhost-live kernel: RDX: 00000000fffffff8 RSI: 000000000=
0000082 RDI: ffff9a37d6a99cc0
May 24 15:33:56 localhost-live kernel: RBP: ffffb49dc026ba59 R08: 000000000=
0000452 R09: ffffb49dc026b8d0
May 24 15:33:56 localhost-live kernel: R10: 0000000000000005 R11: 000000000=
0000000 R12: 00000000000001b7
May 24 15:33:56 localhost-live kernel: R13: 0000000000000065 R14: ffff9a370=
570f5a8 R15: 0000000000000f9b
May 24 15:33:56 localhost-live kernel: FS:  0000000000000000(0000) GS:ffff9=
a37d6a80000(0000) knlGS:0000000000000000
May 24 15:33:56 localhost-live kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
May 24 15:33:56 localhost-live kernel: CR2: 00007ffb02c13700 CR3: 00000000a=
960a005 CR4: 00000000000606e0
May 24 15:33:56 localhost-live kernel: Call Trace:
May 24 15:33:56 localhost-live kernel:  check_root_item+0x8b/0x180 [btrfs]
May 24 15:33:56 localhost-live kernel:  ? __find_get_block+0xb6/0x2f0
May 24 15:33:56 localhost-live kernel:  ? crc_42+0x1e/0x1e [crc32c_intel]
May 24 15:33:56 localhost-live kernel:  ? crc32c_pcl_intel_update+0xa4/0xb0=
 [crc32c_intel]
May 24 15:33:56 localhost-live kernel:  ? crc32c_intel_init+0x20/0x20 [crc3=
2c_intel]
May 24 15:33:56 localhost-live kernel:  ? csum_tree_block+0x11f/0x130 [btrf=
s]
May 24 15:33:56 localhost-live kernel:  ? ext4_mark_iloc_dirty+0x61f/0x830
May 24 15:33:56 localhost-live kernel:  ? intel_cpufreq_target+0x140/0x140
May 24 15:33:56 localhost-live kernel:  ? btrfs_get_32+0x38/0x80 [btrfs]
May 24 15:33:56 localhost-live kernel:  check_leaf+0x489/0x1530 [btrfs]
May 24 15:33:56 localhost-live kernel:  ? check_preempt_curr+0x7e/0x90
May 24 15:33:56 localhost-live kernel:  ? ttwu_do_wakeup+0x19/0x140
May 24 15:33:56 localhost-live kernel:  ? map_private_extent_buffer+0xd0/0x=
d0 [btrfs]
May 24 15:33:56 localhost-live kernel:  btree_readpage_end_io_hook+0x2de/0x=
320 [btrfs]
May 24 15:33:56 localhost-live kernel:  end_bio_extent_readpage+0x1c0/0x710=
 [btrfs]
May 24 15:33:56 localhost-live kernel:  ? __rq_qos_done_bio+0x24/0x30
May 24 15:33:56 localhost-live kernel:  end_workqueue_fn+0x29/0x40 [btrfs]
May 24 15:33:56 localhost-live kernel:  btrfs_work_helper+0xd6/0x3a0 [btrfs=
]
May 24 15:33:56 localhost-live kernel:  process_one_work+0x1b4/0x380
May 24 15:33:56 localhost-live kernel:  worker_thread+0x53/0x3e0
May 24 15:33:56 localhost-live kernel:  ? process_one_work+0x380/0x380
May 24 15:33:56 localhost-live kernel:  kthread+0x115/0x140
May 24 15:33:56 localhost-live kernel:  ? __kthread_bind_ma33:56 localhost-=
live kernel:  ret_from_fork+0x35/0x40
May 24 15:33:56 localhost-live kernel: ---[ end trace 013462e0cfd87fc1 ]---
May 24 15:33:56 localhost-live kernel: BTRFS critical (device loop4): corru=
pt leaf: root=3D18446744073709551610 block=3D94920704 slot=3D1, invalid roo=
t item size, have 239 expect 439
May 24 15:33:56 localhost-live kernel: BTRFS error (device loop4): parent t=
ransid verify failed on 94920704 wanted 2727500 found 2727499
May 24 15:33:56 localhost-live kernel: BTRFS warning (device loop4): failed=
 to read log tree
May 24 15:33:57 localhost-live kernel: BTRFS error (device loop4): open_ctr=
ee failed

> What do you get for:
>=20
> # btrfs insp dump-s -fa /dev/
>=20
[root@localhost-live tmp]# btrfs insp dump-s -fa /dev/loop4
superblock: bytenr=3D65536, device=3D/dev/loop4
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xdc2c003a [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			86180ca0-d351-4551-b262-22b49e1adf47
metadata_uuid		86180ca0-d351-4551-b262-22b49e1adf47
label			sailfish
generation		2727499
root			30703616
sys_array_size		226
chunk_root_generation	2342945
root_level		1
chunk_root		20971520
chunk_root_level	0
log_root		94920704
log_root_transid	0
log_root_level		0
total_bytes		14761832448
bytes_used		5075300352
sectorsize		4096
nodesize		4096
leafsize (deprecated)	4096
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x3
			( MIXED_BACKREF |
			  DEFAULT_SUBVOL )
cache_generation	2727498
uuid_tree_generation	0
dev_item.uuid		bb3ff90e-e471-48d6-af4e-add19a0a532d
dev_item.fsid		86180ca0-d351-4551-b262-22b49e1adf47 [match]
dev_item.type		0
dev_item.total_bytes	14761832448
dev_item.bytes_used	14761787392
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 0)
		length 4194304 owner 2 stripe_len 65536 type SYSTEM
		io_align 4096 io_width 4096 sector_size 4096
		num_stripes 1 sub_stripes 0
			stripe 0 devid 1 offset 0
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 20971520)
		length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 1 offset 20971520
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
			stripe 1 devid 1 offset 29360128
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
backup_roots[4]:
	backup 0:
		backup_tree_root:	114339840	gen: 2727497	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	117129216	gen: 2727498	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	116412416	gen: 2727498	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075410944
		backup_num_devices:	1

	backup 1:
		backup_tree_root:	48250880	gen: 2727498	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	89980928	gen: 2727499	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	89243648	gen: 2727499	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075365888
		backup_num_devices:	1

	backup 2:
		backup_tree_root:	90173440	gen: 2727495	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	84922368	gen: 2727495	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	94969856	gen: 2727496	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075275776
		backup_num_devices:	1

	backup 3:
		backup_tree_root:	102043648	gen: 2727496	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	98189312	gen: 2727496	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	97951744	gen: 2727496	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075275776
		backup_num_devices:	1


superblock: bytenr=3D67108864, device=3D/dev/loop4
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x7c4d28f4 [match]
bytenr			67108864
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			86180ca0-d351-4551-b262-22b49e1adf47
metadata_uuid		86180ca0-d351-4551-b262-22b49e1adf47
label			sailfish
generation		2727499
root			30703616
sys_array_size		226
chunk_root_generation	2342945
root_level		1
chunk_root		20971520
chunk_root_level	0
log_root		94920704
log_root_transid	0
log_root_level		0
total_bytes		14761832448
bytes_used		5075300352
sectorsize		4096
nodesize		4096
leafsize (deprecated)	4096
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x3
			( MIXED_BACKREF |
			  DEFAULT_SUBVOL )
cache_generation	2727498
uuid_tree_generation	0
dev_item.uuid		bb3ff90e-e471-48d6-af4e-add19a0a532d
dev_item.fsid		86180ca0-d351-4551-b262-22b49e1adf47 [match]
dev_item.type		0
dev_item.total_bytes	14761832448
dev_item.bytes_used	14761787392
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 0)
		length 4194304 owner 2 stripe_len 65536 type SYSTEM
		io_align 4096 io_width 4096 sector_size 4096
		num_stripes 1 sub_stripes 0
			stripe 0 devid 1 offset 0
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 20971520)
		length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 1 offset 20971520
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
			stripe 1 devid 1 offset 29360128
			dev_uuid bb3ff90e-e471-48d6-af4e-add19a0a532d
backup_roots[4]:
	backup 0:
		backup_tree_root:	114339840	gen: 2727497	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	117129216	gen: 2727498	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	116412416	gen: 2727498	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075410944
		backup_num_devices:	1

	backup 1:
		backup_tree_root:	48250880	gen: 2727498	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	89980928	gen: 2727499	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	89243648	gen: 2727499	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075365888
		backup_num_devices:	1

	backup 2:
		backup_tree_root:	90173440	gen: 2727495	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	84922368	gen: 2727495	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	94969856	gen: 2727496	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075275776
		backup_num_devices:	1

	backup 3:
		backup_tree_root:	102043648	gen: 2727496	level: 1
		backup_chunk_root:	20971520	gen: 2342945	level: 0
		backup_extent_root:	98189312	gen: 2727496	level: 2
		backup_fs_root:		88788992	gen: 1765467	level: 0
		backup_dev_root:	49008640	gen: 2727493	level: 0
		backup_csum_root:	97951744	gen: 2727496	level: 2
		backup_total_bytes:	14761832448
		backup_bytes_used:	5075275776
		backup_num_devices:	1


