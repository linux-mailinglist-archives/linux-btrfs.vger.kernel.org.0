Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAFE660E3E
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jan 2023 12:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjAGLQU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Jan 2023 06:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAGLQR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Jan 2023 06:16:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67F9133
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Jan 2023 03:16:15 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlXK-1oXwCI2zuo-00jp1D; Sat, 07
 Jan 2023 12:16:13 +0100
Message-ID: <f7f3a0cd-04bd-b3fd-059a-05a5de4fc1d0@gmx.com>
Date:   Sat, 7 Jan 2023 19:16:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Btrfs qgroup warning
Content-Language: en-US
To:     HanatoK <summersnow9403@gmail.com>, linux-btrfs@vger.kernel.org
References: <2403c697-ddaf-58ad-3829-0335fc89df09@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2403c697-ddaf-58ad-3829-0335fc89df09@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+NOEcKJKcNtFATD/mc0QOf6zrJVoa4FuRIf8hROE9WCvfhEcXOU
 m7oXmqgm/L0U2J/v9n1R1DgKhHseSgH4vdOdpyQ3HEuRoUzwtAM6lRvRhf4M/HgKh8E/Hnl
 paKl6FbsVtTkianQLHvd4IgZ+QYLFQ/v0I8TNQ1H+oOqDUS3wkcFy3IS38Lvrghv/OBSrGf
 jWYTRXVr3dBJ2VXxyzcNQ==
UI-OutboundReport: notjunk:1;M01:P0:VnUZG5z4qZ8=;GEJlG4KXwMiJAyjvxrmND5mNtDW
 btqxMPT0s+hMLsCGf1BG8SldQVh1OL0WMKlcI8pvdaGePh10QvlNWeHu7Dan22wylfsYs4zds
 YzF5xlIp34acCujFrm1MxO1zoj+/KmZb+RKLd+n2xKdfDM2VZGiAOZfVKg6KZ4JbLJ469xkCx
 b4D8yJlrqhatXnycNxQXp05OsAHhkfmQOupSCIUKZO/v2C0O14FTH7adAIM096BqO4jpGvDVt
 unnA+5kspRguMcuTBjtULdY7rdB3dkr3LPi2Co55dm7d+lWIprHNAKw2uYDjAu+fMMCAm36uj
 pVc5r1Yp7LggsXYzp4+JaROIedZcsuOKAJmtBled9SR5fyoczJTb2AVBQw5hoYUKI/eIqoeJ6
 d/SvBR6YwUB061d5tGUiyA3HEzlKCd3SDgOXe6EeSKKysosFyDWhYhGHJYjSOs/6Wujwh3Gfy
 Xs/oQOD49YZguera51+cZSX/ap6jPe41Dm9mkvIpPI6gDbhwXBHCwgTtkgopBX8U8ElL/x8Gg
 xOKaaKaQcvnuoIeZOkyIojYsu5UlhVC28ErpnFb2jB9evN/3L63sSB9pzABqU5psNEiP7Sb41
 1zb77FArmLlYdLFSKgoFaVbEzrFACZaX4pGl2Iy1qfGEbe/73a2T2vTn4ZLQ/06tVki7gJae1
 vsY1x33e/S43QZ2q/CKK5hi/t0KYlBX3D3vd786qvvcG8XB3dy1Ez8zJD+wP0QkaE1VWIw+Ov
 hDke7XbWomQ8qJ8y03rbq02zht7Rsg49j7vuVJkDWwwjK7M2otCeD6Y24j5IwCiJ1NBW764eY
 cA8nFHuYo5PQfk7ugJ/+Rfbi13MvSVFv6vCfliEFuLW4TJio1+6HoiGLxgLXVoUfFV+bMpGMJ
 CPSGVQZR0g9E1+SWEwobyYZybg5GmExyDpsi3+VJjlOePrilPHz0Txm+kEB3LQryww85M368J
 ecZ5/ZB0VgmW33weroRUCAPNXsA=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/7 18:42, HanatoK wrote:
> Hello everyone,
> 
> I encounter the same issue as described in 
> https://lore.kernel.org/linux-btrfs/3d13bfc7-294a-9385-2a52-735c1a738a50@gmx.com/T/#ma875602083ef78db18478815a71cfcbf9bc3fd65
> 
> Here is the relevant log in my systemd journal:

Is there any log from the boot?

> 
> Jan 07 03:16:54 summersnow dbus-daemon[2651]: [system] Activating via 
> systemd: service name='org.opensuse.Snapper' unit='snapperd.service' 
> requested by ':1.114' (uid=0 pid=6422 
> comm="/usr/lib/snapper/systemd-helper --cleanup")
> Jan 07 03:16:54 summersnow systemd[1]: Starting DBus interface for 
> snapper...
> Jan 07 03:16:54 summersnow dbus-daemon[2651]: [system] Successfully 
> activated service 'org.opensuse.Snapper'
> Jan 07 03:16:54 summersnow systemd[1]: Started DBus interface for snapper.
> Jan 07 03:16:54 summersnow systemd-helper[6422]: running cleanup for 
> 'root'.
> Jan 07 03:16:54 summersnow systemd-helper[6422]: running number cleanup 
> for 'root'.
> Jan 07 03:16:54 summersnow kernel: ------------[ cut here ]------------
> Jan 07 03:16:54 summersnow kernel: WARNING: CPU: 3 PID: 6424 at 
> fs/btrfs/qgroup.c:2756 btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
> Jan 07 03:16:54 summersnow kernel: Modules linked in: tcp_bbr sch_fq 
> rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nft_masq 
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib af_packet nft_reject_inet 
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat vmnet(OE) 
> ppdev nf_tables parport_pc parport vmw_vsock_vmci_transport ip6table_nat 
> vsock ip6table_mangle ip6table_raw vmw_vmci ip6table_security 
> iptable_nat nf_nat vmmon(OE) nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
> iptable_mangle iptable_raw iptable_security nfnetlink qrtr vboxnetadp(O) 
> vboxnetflt(O) cmac algif_hash algif_skcipher af_alg ip6table_filter 
> ip6_tables iptable_filter bpfilter vboxdrv(O) bnep btusb btrtl btbcm 
> btintel btmtk bluetooth uvcvideo videobuf2_vmalloc videobuf2_memops 
> videobuf2_v4l2 videobuf2_common videodev mc ecdh_generic intel_rapl_msr 
> intel_rapl_common iwlmvm snd_sof_amd_rembrandt nls_iso8859_1 
> snd_sof_amd_renoir nls_cp437 snd_sof_amd_acp snd_sof_pci vfat 
> snd_hda_codec_realtek mac80211 fat snd_sof
> Jan 07 03:16:54 summersnow kernel:  snd_hda_codec_generic libarc4 
> edac_mce_amd snd_sof_utils ledtrig_audio snd_hda_codec_hdmi ext4 
> snd_soc_core snd_compress snd_hda_intel snd_pcm_dmaengine kvm_amd 
> snd_intel_dspcfg snd_intel_sdw_acpi iwlwifi snd_pci_ps mbcache 
> snd_hda_codec snd_rpl_pci_acp6x kvm jbd2 snd_acp_pci irqbypass wmi_bmof 
> snd_pci_acp6x efi_pstore snd_hda_core snd_pci_acp5x cfg80211 r8169 
> snd_hwdep snd_pcm snd_rn_pci_acp3x realtek snd_acp_config mdio_devres 
> snd_timer snd_soc_acpi i2c_piix4 k10temp libphy snd_pci_acp3x snd rfkill 
> soundcore tiny_power_button ac acpi_cpufreq button joydev fuse configfs 
> dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted asn1_encoder 
> tee nvidia_drm(POE) usbhid nvidia_modeset(POE) amdgpu crct10dif_pclmul 
> crc32_pclmul polyval_clmulni polyval_generic gf128mul drm_ttm_helper 
> nvidia_uvm(POE) ttm iommu_v2 ghash_clmulni_intel xhci_pci gpu_sched 
> xhci_pci_renesas sha512_ssse3 drm_buddy nvidia(POE) drm_display_helper 
> xhci_hcd aesni_intel ucsi_acpi cec nvme
> Jan 07 03:16:54 summersnow kernel:  typec_ucsi hid_multitouch 
> hid_generic crypto_simd cryptd usbcore wdat_wdt roles ccp nvme_core 
> sp5100_tco rc_core typec video battery wmi i2c_hid_acpi i2c_hid 
> serio_raw btrfs blake2b_generic libcrc32c crc32c_intel xor raid6_pq 
> l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel pppox 
> ppp_generic slhc sg br_netfilter bridge stp llc dm_multipath dm_mod 
> scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr efivarfs
> Jan 07 03:16:54 summersnow kernel: CPU: 3 PID: 6424 Comm: snapperd 
> Tainted: P           OE      6.1.2-1-default #1 openSUSE Tumbleweed 
> 05c7a1b1b61d5627475528f71f50444637b5aad7
> Jan 07 03:16:54 summersnow kernel: Hardware name: LENOVO 
> 82JQ/LNVNB161216, BIOS GKCN59WW 11/21/2022
> Jan 07 03:16:54 summersnow kernel: RIP: 
> 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
> Jan 07 03:16:54 summersnow kernel: Code: 85 c0 74 0f 48 8b 78 08 4c 89 
> fa 4c 89 ee e8 59 54 f5 ff 65 ff 0d 52 1d ab 3f 0f 85 b8 fe ff ff 0f 1f 
> 44 00 00 e9 ae fe ff ff <0f> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 
> 4c 89 ee e8 1b 71 ff
> Jan 07 03:16:54 summersnow kernel: RSP: 0018:ffffb00f8a597d08 EFLAGS: 
> 00010246
> Jan 07 03:16:54 summersnow kernel: RAX: ffff8bf5b19a1780 RBX: 
> 0000000000000000 RCX: 0000000000400038
> Jan 07 03:16:54 summersnow kernel: RDX: ffff8bf5b19a1780 RSI: 
> fffff8bc4672e900 RDI: 0000000000000000
> Jan 07 03:16:54 summersnow kernel: RBP: ffff8bf6be003360 R08: 
> 0000000000000000 R09: 0000000000400038
> Jan 07 03:16:54 summersnow kernel: R10: 0000000000000000 R11: 
> ffff8bf50a17a000 R12: 000000000000005c
> Jan 07 03:16:54 summersnow kernel: R13: ffff8bf580103000 R14: 
> ffff8bf715404548 R15: ffff8bf5b19a1780
> Jan 07 03:16:54 summersnow kernel: FS:  00007fd9b71e26c0(0000) 
> GS:ffff8bfb11ec0000(0000) knlGS:0000000000000000
> Jan 07 03:16:54 summersnow kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
> 0000000080050033
> Jan 07 03:16:54 summersnow kernel: CR2: 0000559b70061428 CR3: 
> 00000002fe47c000 CR4: 0000000000750ee0
> Jan 07 03:16:54 summersnow kernel: PKRU: 55555554
> Jan 07 03:16:54 summersnow kernel: Call Trace:
> Jan 07 03:16:54 summersnow kernel:  <TASK>
> Jan 07 03:16:54 summersnow kernel: btrfs_commit_transaction+0x30c/0xb40 
> [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
> Jan 07 03:16:54 summersnow kernel:  ? start_transaction+0xc3/0x5b0 
> [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
> Jan 07 03:16:54 summersnow kernel: btrfs_qgroup_rescan+0x42/0xc0 [btrfs 
> c39c9c546c241c593f03bd6d5f39ea1b676250f6]
> Jan 07 03:16:54 summersnow kernel:  btrfs_ioctl+0x1ab9/0x25c0 [btrfs 
> c39c9c546c241c593f03bd6d5f39ea1b676250f6]
> Jan 07 03:16:54 summersnow kernel:  ? 
> __rseq_handle_notify_resume+0xa9/0x4a0
> Jan 07 03:16:54 summersnow kernel:  ? mntput_no_expire+0x4a/0x240
> Jan 07 03:16:54 summersnow kernel:  ? __seccomp_filter+0x319/0x4d0
> Jan 07 03:16:54 summersnow kernel:  __x64_sys_ioctl+0x90/0xd0
> Jan 07 03:16:54 summersnow kernel:  do_syscall_64+0x5b/0x80
> Jan 07 03:16:54 summersnow kernel:  ? syscall_exit_to_user_mode+0x17/0x40
> Jan 07 03:16:54 summersnow kernel:  ? do_syscall_64+0x67/0x80
> Jan 07 03:16:54 summersnow kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Jan 07 03:16:54 summersnow kernel: RIP: 0033:0x7fd9b790d9bf
> Jan 07 03:16:54 summersnow kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 
> 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 
> 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 
> 48 2b 04 25 28 00 00
> Jan 07 03:16:54 summersnow kernel: RSP: 002b:00007fd9b71e1760 EFLAGS: 
> 00000246 ORIG_RAX: 0000000000000010
> Jan 07 03:16:54 summersnow kernel: RAX: ffffffffffffffda RBX: 
> 0000000000000007 RCX: 00007fd9b790d9bf
> Jan 07 03:16:54 summersnow kernel: RDX: 00007fd9b71e17c0 RSI: 
> 000000004040942c RDI: 0000000000000007
> Jan 07 03:16:54 summersnow kernel: RBP: 00007fd9b71e17c0 R08: 
> 0000000000000000 R09: 0000000000000000
> Jan 07 03:16:54 summersnow kernel: R10: 0000000000001000 R11: 
> 0000000000000246 R12: 00007fd9b71e18e0
> Jan 07 03:16:54 summersnow kernel: R13: 00007fd9b7e3cfd0 R14: 
> 00007fd9b71e1a30 R15: 00007fd9b71e1a60
> Jan 07 03:16:54 summersnow kernel:  </TASK>
> Jan 07 03:16:54 summersnow kernel: ---[ end trace 0000000000000000 ]---
> 
> I can also trigger the kernel error manually by running "systemctl 
> restart snapper-cleanup.service".

That's interesting, I can try it with snapper, and if it can be 
reproduced, it seems to be something wrong with the enable/rescan routine.

Thanks,
Qu

> 
> Any ideas?
> 
> Thanks,
> 
