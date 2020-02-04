Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8EAB1514F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 05:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBDE1l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 23:27:41 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:32992 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgBDE1l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 23:27:41 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 857F55A84A9; Mon,  3 Feb 2020 23:27:40 -0500 (EST)
Date:   Mon, 3 Feb 2020 23:27:40 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Spurious "ghost" "parent transid verify failed" messages on
 5.0.21 - with call traces - Fixed in 47c8495d358b (5.4.18/5.5.2?)
Message-ID: <20200204042740.GY13306@hungrycats.org>
References: <20190312040024.GI9995@hungrycats.org>
 <20190403144716.GA15312@hungrycats.org>
 <20190701033925.GH11831@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YG0IFkGWIt6MbjRk"
Content-Disposition: inline
In-Reply-To: <20190701033925.GH11831@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--YG0IFkGWIt6MbjRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2019 at 11:39:25PM -0400, Zygo Blaxell wrote:
> On Wed, Apr 03, 2019 at 10:47:16AM -0400, Zygo Blaxell wrote:
> > On Tue, Mar 12, 2019 at 12:00:25AM -0400, Zygo Blaxell wrote:
> > > On 4.14.x and 4.20.14 kernels (probably all the ones in between too,
> > > but I haven't tested those), I get what I call "ghost parent transid
> > > verify failed" errors.  Here's an unedited recent example from dmesg:
> > >=20
> > > 	[16180.649285] BTRFS error (device dm-3): parent transid verify fail=
ed on 1218181971968 wanted 9698 found 9744
> >=20
> > These happen much less often on 5.0.x, but they still happen from time
> > to time.
>=20
> I put this patch in 5.0.21:
>=20
> 	commit 5abbed1af5570f1317f31736e3862e8b7df1ca8b
> 	Author: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> 	Date:   Sat May 18 17:48:59 2019 -0400
>=20
> 	    btrfs: get a call trace when we hit ghost parent transid verify fail=
ures
>=20
> 	diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> 	index 6fe9197f6ee4..ed961d2915a1 100644
> 	--- a/fs/btrfs/disk-io.c
> 	+++ b/fs/btrfs/disk-io.c
> 	@@ -356,6 +356,7 @@ static int verify_parent_transid(struct extent_io_tr=
ee *io_tree,
> 			"parent transid verify failed on %llu wanted %llu found %llu",
> 				eb->start,
> 				parent_transid, btrfs_header_generation(eb));
> 	+               WARN_ON(1);
> 		ret =3D 1;
> 	=20
> 		/*
>=20
> and eventually (six weeks later!) got another reproduction of this bug
> on 5.0.21:
>=20
> 	[Sat Jun 29 16:03:51 2019] BTRFS error (device dm-24): parent transid ve=
rify failed on 192792461312 wanted 425102 found 425088
> 	[Sat Jun 29 16:03:51 2019] WARNING: CPU: 1 PID: 308 at fs/btrfs/disk-io.=
c:359 verify_parent_transid+0xf7/0x1e0
> 	[Sat Jun 29 16:03:51 2019] Modules linked in: isofs cpuid nfsv3 nfs fsca=
che algif_skcipher af_alg mq_deadline softdog nfsd auth_rpcgss nfs_acl lock=
d grace sunrpc bnep cpufreq_userspace cpufreq_powersave cpufreq_conservativ=
e nfnetlink_queue nfnetlink_log nfnetlink bluetooth ecdh_generic rfkill snd=
_seq_dummy snd_hrtimer snd_seq_midi snd_seq_oss snd_seq_midi_event snd_rawm=
idi snd_seq snd_seq_device binfmt_misc fuse nbd xt_REDIRECT ipt_REJECT nf_r=
eject_ipv4 xt_nat xt_conntrack xt_tcpudp nf_log_ipv4 nf_log_common xt_LOG i=
p6table_nat nf_nat_ipv6 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defr=
ag_ipv6 nf_defrag_ipv4 ip6table_mangle iptable_mangle ip6table_filter ip6_t=
ables iptable_filter ip_tables x_tables bpfilter tcp_cubic dummy ib_iser rd=
ma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_is=
csi lp dm_crypt ppdev edac_mce_amd kvm_amd ccp kvm irqbypass crct10dif_pclm=
ul crc32_pclmul ghash_clmulni_intel snd_hda_codec_via snd_hda_codec_generic=
 ledtrig_audio snd_hda_codec_hdmi aesni_intel
> 	[Sat Jun 29 16:03:51 2019]  aes_x86_64 crypto_simd cryptd glue_helper wm=
i_bmof serio_raw pcspkr k10temp fam15h_power usbnet input_leds mii joydev s=
nd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_pcm_oss radeon parpor=
t_pc snd_mixer_oss asus_atk0110 parport rtc_cmos snd_pcm snd_timer pcc_cpuf=
req snd soundcore evdev acpi_cpufreq sg sp5100_tco af_packet ipv6 crc_ccitt=
 raid10 raid0 multipath linear hid_generic dm_raid raid456 async_raid6_reco=
v async_memcpy async_pq async_xor async_tx dm_mod crc32c_intel ohci_pci rai=
d1 psmouse sr_mod md_mod cdrom pdc202xx_new ide_pci_generic atiixp ide_core=
 i2c_piix4 ohci_hcd ehci_pci ehci_hcd r8169 xhci_pci realtek xhci_hcd wmi [=
last unloaded: ax88179_178a]
> 	[Sat Jun 29 16:03:51 2019] CPU: 1 PID: 308 Comm: crawl_257 Tainted: G   =
     W         5.0.21-zb64-45132582ab2c+ #1
> 	[Sat Jun 29 16:03:51 2019] Hardware name: System manufacturer System Pro=
duct Name/M5A78L-M/USB3, BIOS 2101    12/02/2014
> 	[Sat Jun 29 16:03:51 2019] RIP: 0010:verify_parent_transid+0xf7/0x1e0
> 	[Sat Jun 29 16:03:51 2019] Code: 48 c1 f8 06 48 c1 e0 0c 4c 3b 74 10 50 =
74 2f 48 c7 c6 b0 5c 25 89 48 c7 c7 60 5d 90 89 e8 d1 5a 8f 00 85 c0 0f 85 =
a8 00 00 00 <0f> 0b 48 89 df 41 bc 01 00 00 00 e8 69 3f 03 00 85 c0 74 59 4=
8 8b
> 	[Sat Jun 29 16:03:51 2019] RSP: 0018:ffffaf3c8d047730 EFLAGS: 00010296
> 	[Sat Jun 29 16:03:51 2019] RAX: 0000000000000000 RBX: ffff9c7ab0654ae0 R=
CX: 0000000000000000
> 	[Sat Jun 29 16:03:51 2019] RDX: 0000000000000000 RSI: ffff9c7fbc5e7cb8 R=
DI: ffff9c7fbc5e7cb8
> 	[Sat Jun 29 16:03:51 2019] RBP: ffffaf3c8d047770 R08: ffffffff8812a25f R=
09: 0000000000000001
> 	[Sat Jun 29 16:03:51 2019] R10: ffffaf3c8d047670 R11: 0000000000000000 R=
12: 0000000000000000
> 	[Sat Jun 29 16:03:51 2019] R13: ffff9c7f5b4ac450 R14: 0000000000067c8e R=
15: ffffaf3c8d047738
> 	[Sat Jun 29 16:03:51 2019] FS:  00007f53e7b74700(0000) GS:ffff9c7fbc4000=
00(0000) knlGS:0000000000000000
> 	[Sat Jun 29 16:03:51 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> 	[Sat Jun 29 16:03:51 2019] CR2: 000001df74da3000 CR3: 000000021bf52000 C=
R4: 00000000000406e0
> 	[Sat Jun 29 16:03:51 2019] Call Trace:
> 	[Sat Jun 29 16:03:51 2019]  btree_read_extent_buffer_pages+0xbe/0x120
> 	[Sat Jun 29 16:03:51 2019]  read_tree_block+0x42/0x70
> 	[Sat Jun 29 16:03:51 2019]  read_block_for_search.isra.11+0x1ae/0x370
> 	[Sat Jun 29 16:03:51 2019]  btrfs_next_old_leaf+0x236/0x420
> 	[Sat Jun 29 16:03:51 2019]  resolve_indirect_refs+0x486/0x910
> 	[Sat Jun 29 16:03:51 2019]  find_parent_nodes+0x443/0x1340
> 	[Sat Jun 29 16:03:51 2019]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
> 	[Sat Jun 29 16:03:51 2019]  iterate_extent_inodes+0xfb/0x3e0
> 	[Sat Jun 29 16:03:51 2019]  ? _raw_spin_unlock+0x27/0x40
> 	[Sat Jun 29 16:03:51 2019]  iterate_inodes_from_logical+0xa1/0xd0
> 	[Sat Jun 29 16:03:51 2019]  ? iterate_inodes_from_logical+0xa1/0xd0
> 	[Sat Jun 29 16:03:51 2019]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
> 	[Sat Jun 29 16:03:51 2019]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
> 	[Sat Jun 29 16:03:51 2019]  btrfs_ioctl+0xcf7/0x2cb0
> 	[Sat Jun 29 16:03:51 2019]  ? lock_acquire+0xbd/0x1c0
> 	[Sat Jun 29 16:03:51 2019]  ? lock_acquire+0xbd/0x1c0
> 	[Sat Jun 29 16:03:51 2019]  do_vfs_ioctl+0xa6/0x6e0
> 	[Sat Jun 29 16:03:51 2019]  ? do_vfs_ioctl+0xa6/0x6e0
> 	[Sat Jun 29 16:03:51 2019]  ? __fget+0x119/0x200
> 	[Sat Jun 29 16:03:51 2019]  ksys_ioctl+0x75/0x80
> 	[Sat Jun 29 16:03:51 2019]  __x64_sys_ioctl+0x1a/0x20
> 	[Sat Jun 29 16:03:51 2019]  do_syscall_64+0x65/0x1a0
> 	[Sat Jun 29 16:03:51 2019]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 	[Sat Jun 29 16:03:51 2019] RIP: 0033:0x7f53e9468427
> 	[Sat Jun 29 16:03:51 2019] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 =
26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 =
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 0=
1 48
> 	[Sat Jun 29 16:03:51 2019] RSP: 002b:00007f53e7b707c8 EFLAGS: 00000246 O=
RIG_RAX: 0000000000000010
> 	[Sat Jun 29 16:03:51 2019] RAX: ffffffffffffffda RBX: 00007f53e7b70af0 R=
CX: 00007f53e9468427
> 	[Sat Jun 29 16:03:51 2019] RDX: 00007f53e7b70af8 RSI: 00000000c038943b R=
DI: 0000000000000004
> 	[Sat Jun 29 16:03:51 2019] RBP: 0000000001000000 R08: 0000000000000000 R=
09: 00007f53e7b70cd0
> 	[Sat Jun 29 16:03:51 2019] R10: 0000559f3bf9cc40 R11: 0000000000000246 R=
12: 0000000000000004
> 	[Sat Jun 29 16:03:51 2019] R13: 00007f53e7b70af8 R14: 00007f53e7b709d8 R=
15: 00007f53e7b70c00
> 	[Sat Jun 29 16:03:51 2019] irq event stamp: 1551156398
> 	[Sat Jun 29 16:03:51 2019] hardirqs last  enabled at (1551156397): [<fff=
fffff880037da>] trace_hardirqs_on_thunk+0x1a/0x1c
> 	[Sat Jun 29 16:03:51 2019] hardirqs last disabled at (1551156398): [<fff=
fffff88dc51f9>] __schedule+0xd9/0xb70
> 	[Sat Jun 29 16:03:51 2019] softirqs last  enabled at (1551156396): [<fff=
fffff890003a0>] __do_softirq+0x3a0/0x45a
> 	[Sat Jun 29 16:03:51 2019] softirqs last disabled at (1551156389): [<fff=
fffff880a99a9>] irq_exit+0xe9/0xf0
> 	[Sat Jun 29 16:03:51 2019] ---[ end trace d600eda2e1469b36 ]---
> 	[Sat Jun 29 16:03:51 2019] BTRFS error (device dm-24): parent transid ve=
rify failed on 192792461312 wanted 425102 found 425088
> 	[Sat Jun 29 16:03:51 2019] WARNING: CPU: 2 PID: 308 at fs/btrfs/disk-io.=
c:359 verify_parent_transid+0xf7/0x1e0
> 	[Sat Jun 29 16:03:51 2019] Modules linked in: isofs cpuid nfsv3 nfs fsca=
che algif_skcipher af_alg mq_deadline softdog nfsd auth_rpcgss nfs_acl lock=
d grace sunrpc bnep cpufreq_userspace cpufreq_powersave cpufreq_conservativ=
e nfnetlink_queue nfnetlink_log nfnetlink bluetooth ecdh_generic rfkill snd=
_seq_dummy snd_hrtimer snd_seq_midi snd_seq_oss snd_seq_midi_event snd_rawm=
idi snd_seq snd_seq_device binfmt_misc fuse nbd xt_REDIRECT ipt_REJECT nf_r=
eject_ipv4 xt_nat xt_conntrack xt_tcpudp nf_log_ipv4 nf_log_common xt_LOG i=
p6table_nat nf_nat_ipv6 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defr=
ag_ipv6 nf_defrag_ipv4 ip6table_mangle iptable_mangle ip6table_filter ip6_t=
ables iptable_filter ip_tables x_tables bpfilter tcp_cubic dummy ib_iser rd=
ma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_is=
csi lp dm_crypt ppdev edac_mce_amd kvm_amd ccp kvm irqbypass crct10dif_pclm=
ul crc32_pclmul ghash_clmulni_intel snd_hda_codec_via snd_hda_codec_generic=
 ledtrig_audio snd_hda_codec_hdmi aesni_intel
> 	[Sat Jun 29 16:03:51 2019]  aes_x86_64 crypto_simd cryptd glue_helper wm=
i_bmof serio_raw pcspkr k10temp fam15h_power usbnet input_leds mii joydev s=
nd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_pcm_oss radeon parpor=
t_pc snd_mixer_oss asus_atk0110 parport rtc_cmos snd_pcm snd_timer pcc_cpuf=
req snd soundcore evdev acpi_cpufreq sg sp5100_tco af_packet ipv6 crc_ccitt=
 raid10 raid0 multipath linear hid_generic dm_raid raid456 async_raid6_reco=
v async_memcpy async_pq async_xor async_tx dm_mod crc32c_intel ohci_pci rai=
d1 psmouse sr_mod md_mod cdrom pdc202xx_new ide_pci_generic atiixp ide_core=
 i2c_piix4 ohci_hcd ehci_pci ehci_hcd r8169 xhci_pci realtek xhci_hcd wmi [=
last unloaded: ax88179_178a]
> 	[Sat Jun 29 16:03:51 2019] CPU: 2 PID: 308 Comm: crawl_257 Tainted: G   =
     W         5.0.21-zb64-45132582ab2c+ #1
> 	[Sat Jun 29 16:03:52 2019] Hardware name: System manufacturer System Pro=
duct Name/M5A78L-M/USB3, BIOS 2101    12/02/2014
> 	[Sat Jun 29 16:03:52 2019] RIP: 0010:verify_parent_transid+0xf7/0x1e0
> 	[Sat Jun 29 16:03:52 2019] Code: 48 c1 f8 06 48 c1 e0 0c 4c 3b 74 10 50 =
74 2f 48 c7 c6 b0 5c 25 89 48 c7 c7 60 5d 90 89 e8 d1 5a 8f 00 85 c0 0f 85 =
a8 00 00 00 <0f> 0b 48 89 df 41 bc 01 00 00 00 e8 69 3f 03 00 85 c0 74 59 4=
8 8b
> 	[Sat Jun 29 16:03:52 2019] RSP: 0018:ffffaf3c8d047730 EFLAGS: 00010296
> 	[Sat Jun 29 16:03:52 2019] RAX: 0000000000000000 RBX: ffff9c7ab0654ae0 R=
CX: 0000000000000000
> 	[Sat Jun 29 16:03:52 2019] RDX: 0000000000000000 RSI: ffff9c7fbc9e7cb8 R=
DI: ffff9c7fbc9e7cb8
> 	[Sat Jun 29 16:03:52 2019] RBP: ffffaf3c8d047770 R08: ffffffff8812a25f R=
09: 0000000000000001
> 	[Sat Jun 29 16:03:52 2019] R10: ffffaf3c8d047670 R11: 0000000000000000 R=
12: 0000000000000000
> 	[Sat Jun 29 16:03:52 2019] R13: ffff9c7f5b4ac450 R14: 0000000000067c8e R=
15: ffffaf3c8d047738
> 	[Sat Jun 29 16:03:52 2019] FS:  00007f53e7b74700(0000) GS:ffff9c7fbc8000=
00(0000) knlGS:0000000000000000
> 	[Sat Jun 29 16:03:52 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> 	[Sat Jun 29 16:03:52 2019] CR2: 00000000f7e262c0 CR3: 000000021bf52000 C=
R4: 00000000000406e0
> 	[Sat Jun 29 16:03:52 2019] Call Trace:
> 	[Sat Jun 29 16:03:52 2019]  btree_read_extent_buffer_pages+0xbe/0x120
> 	[Sat Jun 29 16:03:52 2019]  read_tree_block+0x42/0x70
> 	[Sat Jun 29 16:03:52 2019]  read_block_for_search.isra.11+0x1ae/0x370
> 	[Sat Jun 29 16:03:52 2019]  btrfs_next_old_leaf+0x236/0x420
> 	[Sat Jun 29 16:03:52 2019]  resolve_indirect_refs+0x486/0x910
> 	[Sat Jun 29 16:03:52 2019]  find_parent_nodes+0x443/0x1340
> 	[Sat Jun 29 16:03:52 2019]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
> 	[Sat Jun 29 16:03:52 2019]  iterate_extent_inodes+0xfb/0x3e0
> 	[Sat Jun 29 16:03:52 2019]  ? _raw_spin_unlock+0x27/0x40
> 	[Sat Jun 29 16:03:52 2019]  iterate_inodes_from_logical+0xa1/0xd0
> 	[Sat Jun 29 16:03:52 2019]  ? iterate_inodes_from_logical+0xa1/0xd0
> 	[Sat Jun 29 16:03:52 2019]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
> 	[Sat Jun 29 16:03:52 2019]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
> 	[Sat Jun 29 16:03:52 2019]  btrfs_ioctl+0xcf7/0x2cb0
> 	[Sat Jun 29 16:03:52 2019]  ? lock_acquire+0xbd/0x1c0
> 	[Sat Jun 29 16:03:52 2019]  ? lock_acquire+0xbd/0x1c0
> 	[Sat Jun 29 16:03:52 2019]  do_vfs_ioctl+0xa6/0x6e0
> 	[Sat Jun 29 16:03:52 2019]  ? do_vfs_ioctl+0xa6/0x6e0
> 	[Sat Jun 29 16:03:52 2019]  ? __fget+0x119/0x200
> 	[Sat Jun 29 16:03:52 2019]  ksys_ioctl+0x75/0x80
> 	[Sat Jun 29 16:03:52 2019]  __x64_sys_ioctl+0x1a/0x20
> 	[Sat Jun 29 16:03:52 2019]  do_syscall_64+0x65/0x1a0
> 	[Sat Jun 29 16:03:52 2019]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 	[Sat Jun 29 16:03:52 2019] RIP: 0033:0x7f53e9468427
> 	[Sat Jun 29 16:03:52 2019] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 =
26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 =
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 0=
1 48
> 	[Sat Jun 29 16:03:52 2019] RSP: 002b:00007f53e7b707c8 EFLAGS: 00000246 O=
RIG_RAX: 0000000000000010
> 	[Sat Jun 29 16:03:52 2019] RAX: ffffffffffffffda RBX: 00007f53e7b70af0 R=
CX: 00007f53e9468427
> 	[Sat Jun 29 16:03:52 2019] RDX: 00007f53e7b70af8 RSI: 00000000c038943b R=
DI: 0000000000000004
> 	[Sat Jun 29 16:03:52 2019] RBP: 0000000001000000 R08: 0000000000000000 R=
09: 00007f53e7b70cd0
> 	[Sat Jun 29 16:03:52 2019] R10: 0000559f3bf9cc40 R11: 0000000000000246 R=
12: 0000000000000004
> 	[Sat Jun 29 16:03:52 2019] R13: 00007f53e7b70af8 R14: 00007f53e7b709d8 R=
15: 00007f53e7b70c00
> 	[Sat Jun 29 16:03:52 2019] irq event stamp: 1551156398
> 	[Sat Jun 29 16:03:52 2019] hardirqs last  enabled at (1551156397): [<fff=
fffff880037da>] trace_hardirqs_on_thunk+0x1a/0x1c
> 	[Sat Jun 29 16:03:52 2019] hardirqs last disabled at (1551156398): [<fff=
fffff88dc51f9>] __schedule+0xd9/0xb70
> 	[Sat Jun 29 16:03:52 2019] softirqs last  enabled at (1551156396): [<fff=
fffff890003a0>] __do_softirq+0x3a0/0x45a
> 	[Sat Jun 29 16:03:52 2019] softirqs last disabled at (1551156389): [<fff=
fffff880a99a9>] irq_exit+0xe9/0xf0
> 	[Sat Jun 29 16:03:52 2019] ---[ end trace d600eda2e1469b37 ]---
>=20
> which confirms the event comes from the LOGICAL_INO ioctl, at least.
> I had suspected that before based on timing and event log correlations,
> but now I have stack traces.
>=20
> It looks like insufficient locking, i.e. the eb got modified while
> LOGICAL_INO was looking at it.
>=20
> As usual for the "ghost" parent transid verify failure, there's no
> persistent failure, no error reported to applications, and error counts
> in 'btrfs dev stats' are not incremented.

I'm pretty sure this is fixed by the third tree mod log patch, although
it's difficult to test without also applying the first two:

	6609fee8897a Btrfs: fix removal logic of the tree mod log that leads to us=
e-after-free issues
	efad8a853ad2 Btrfs: fix use-after-free when using the tree modification log
	47c8495d358b Btrfs: fix race between adding and putting tree mod seq eleme=
nts and nodes

The third patch fixes insufficient locking in LOGICAL_INO, FIEMAP,
balance, resize, scrub error reporting, and anything else that iterates
over extent references.

With all three patches applied I can no longer produce ghost PTV
failures on any kernel 4.20..5.5 under my usual stress test (rsync,
bees, snapshots, scrub, balance).  Without the third patch, I get a few
PTV failures per hour on the most recent version of my stress test,
as well as other usually-fatal errors like "unable to find logical 0
length 4096" and even the occasional "bad tree block", all of which have
no apparent effect other than emitting the kernel log messages.

Also, the affected kernel range checks out:  I've observed the ghost
PTV failures on kernels older than 4.14, and the tree mod log patches
fix bugs introduced in 3.10.

Thanks Filipe for all three patches.

--YG0IFkGWIt6MbjRk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjjyugAKCRCB+YsaVrMb
nOfdAKCrMwmgKkXMxLX1SPQS5HKCsi1u1ACgzLl5pelBUK9v8kMdE5Q3YpOOYXU=
=UcT6
-----END PGP SIGNATURE-----

--YG0IFkGWIt6MbjRk--
