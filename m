Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA431F0A25
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 07:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgFGF2B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 01:28:01 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:13440 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgFGF2A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 01:28:00 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49flJt2LpXz2d
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Jun 2020 07:27:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591507678; bh=BkK3PLU4uEXVvBUd4EkCc3WdWOPKZAM5MJ+CjSap6L4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=CKOzvwBZ5eZGk1fgl74rIllEbEgib83EXjbyP+HHdqtR8N31dDfmJ33eNhWWN27By
         JiVdtDkUwstmzI4lnERrUZJkfSM1EXroRmwbAxy29pLw6EuHWwWuImKctr+D+8Tvmy
         4ZzBoa+YqsU/o6SeSHL0F8VWOC7S4LhG9X8Tz4+fLBgtsgCq+y/XEeiqNE/mUI5kyN
         3JRKXy6Jmw9IaohLjaITNniPAPIGIzim4vKcyvOzwIfHWeD7Z2TgdaMDg3+eqsA5Me
         CN4PmNcThabDXZt9VBz2iFAxjSzmmT7u6dNpy+A6YtI1Z3IjbyIPkSQMd0800+1QOS
         6vNCPbyDtsVTw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 7 Jun 2020 07:27:57 +0200
From:   =?iso-8859-2?B?TWljaGGzoE1pcm9zs2F3?= <mirq-linux@rere.qmqm.pl>
To:     linux-btrfs@vger.kernel.org
Subject: Re: balance + ENOFS -> readonly filesystem
Message-ID: <20200607052757.GG12913@qmqm.qmqm.pl>
References: <20200607051217.GE12913@qmqm.qmqm.pl>
 <20200607052303.GF12913@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200607052303.GF12913@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 07, 2020 at 07:23:03AM +0200, Micha=B3=A0Miros=B3aw wrote:
> On Sun, Jun 07, 2020 at 07:12:17AM +0200, Micha=B3=A0Miros=B3aw wrote:
> > Dear btrfs developers,
> >=20
> > I just added a new disk to already almost full filesystem and tried to
> > enable raid1 for metadata (transcript below). The operation failed and
> > left the filesystem in readonly state. Is this expected?
>=20
> This doesn't look good:
>=20
> # btrfs balance start -musage=3D90 .
> Segmentation fault

# umount ...
<hang>

# dmesg | tail ...
[11564.462208] ------------[ cut here ]------------
[11564.462215] WARNING: CPU: 0 PID: 26569 at fs/namespace.c:1093 cleanup_mn=
t+0x11f/0x140
[11564.462216] Modules linked in: uas usb_storage rfcomm fuse cpufreq_power=
save cpufreq_userspace cpufreq_conservative nfc nf_conntrack_netlink overla=
y xfrm_user xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_al=
go cmac vboxnetadp(O) vboxnetflt(O) bridge stp llc bnep vboxdrv(O) binfmt_m=
isc dm_cache_smq dm_cache dm_persistent_data dm_bio_prison dm_bufio usblp x=
fs btrfs blake2b_generic zstd_compress ftdi_sio usbserial joydev squashfs z=
std_decompress btusb btrtl btbcm btintel bluetooth ecdh_generic ecc wmi_bmo=
f mxm_wmi kvm_intel kvm irqbypass ghash_clmulni_intel pcspkr i2c_i801 snd_h=
da_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi iTCO_wdt sg snd_e=
mu10k1 snd_util_mem snd_ac97_codec ac97_bus emu10k1_gp snd_rawmidi gameport=
 snd_hda_intel snd_seq_device snd_intel_dspcfg snd_hda_codec snd_hda_core x=
hci_pci snd_hwdep xhci_hcd snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd =
soundcore nvidia_drm(O) nft_masq wmi drm_kms_helper cfbfillrect syscopyarea=
 cfbimgblt sysfillrect sysimgblt
[11564.462240]  fb_sys_fops cfbcopyarea fb font fbdev drm drm_panel_orienta=
tion_quirks nvidia_modeset(O) nft_redir nvidia(O) i2c_core nf_tables_set nf=
t_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter n=
f_tables nfnetlink nfsd auth_rpcgss nfs_acl lockd grace sunrpc loop firewir=
e_sbp2 firewire_core crc_itu_t ecryptfs autofs4 input_leds raid10 raid456 l=
ibcrc32c async_raid6_recov async_memcpy async_pq raid6_pq async_xor xor asy=
nc_tx raid0 multipath linear e1000e video backlight
[11564.462256] CPU: 0 PID: 26569 Comm: umount Tainted: G      D W  O      5=
=2E6.15mq+ #376
[11564.462258] Hardware name: System manufacturer System Product Name/P8Z68=
-V PRO, BIOS 3603 11/09/2012
[11564.462260] RIP: 0010:cleanup_mnt+0x11f/0x140
[11564.462261] Code: 00 00 8b 87 24 01 00 00 85 c0 74 0a c7 87 24 01 00 00 =
00 00 00 00 e8 80 fa ff ff eb 86 48 89 ef e8 36 bb 01 00 e9 09 ff ff ff <0f=
> 0b e9 f4 fe ff ff c7 87 24 01 00 00 00 00 00 00 e9 52 ff ff ff
[11564.462263] RSP: 0018:ffffc9000f43feb8 EFLAGS: 00010202
[11564.462264] RAX: 0000000000000001 RBX: ffff8883e6839dc0 RCX: 00000000000=
00008
[11564.462265] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffffffff823=
362a8
[11564.462266] RBP: ffff8883b0481e00 R08: 0000000000000000 R09: 00000000000=
00007
[11564.462267] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8883e68=
39700
[11564.462268] R13: ffffffff8277e280 R14: 0000000000000000 R15: ffff8883e68=
39e30
[11564.462270] FS:  00007f8349f51200(0000) GS:ffff88840ec00000(0000) knlGS:=
0000000000000000
[11564.462271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11564.462272] CR2: 00007f834a45e560 CR3: 00000003e7dd2001 CR4: 00000000000=
606f0
[11564.462273] Call Trace:
[11564.462279]  task_work_run+0x8a/0xb0
[11564.462283]  exit_to_usermode_loop+0xd1/0xf0
[11564.462285]  do_syscall_64+0x1a3/0x210
[11564.462288]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[11564.462290] RIP: 0033:0x7f834a37c327
[11564.462291] Code: eb 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 =
00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 eb 0b 00 f7 d8 64 89 01 48
[11564.462293] RSP: 002b:00007fffef4dc528 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a6
[11564.462294] RAX: 0000000000000000 RBX: 0000558d96b2aa40 RCX: 00007f834a3=
7c327
[11564.462295] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000558d96b=
37e10
[11564.462296] RBP: 0000000000000000 R08: 0000558d96b33400 R09: 0000558d96b=
29010
[11564.462297] R10: 00007f834a43bb80 R11: 0000000000000246 R12: 0000558d96b=
37e10
[11564.462298] R13: 00007f834a4a01c4 R14: 0000558d96b2ab38 R15: 0000558d96b=
372e0
[11564.462303] irq event stamp: 0
[11564.462304] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[11564.462307] hardirqs last disabled at (0): [<ffffffff810aff62>] copy_pro=
cess+0xa22/0x1da0
[11564.462309] softirqs last  enabled at (0): [<ffffffff810aff62>] copy_pro=
cess+0xa22/0x1da0
[11564.462310] softirqs last disabled at (0): [<0000000000000000>] 0x0
[11564.462311] ---[ end trace 0d99142474b285fc ]---
