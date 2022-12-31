Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB265A862
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jan 2023 00:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiLaX64 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 18:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiLaX6y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 18:58:54 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7076D2BCE
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 15:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672531127; bh=ch0QSBwcMxXED1Lmo/5Wvb8kROEJEZxL8F70mTJVOq4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=OX7a41kAPNMoXUEI5ogOpPLjRGJpCC3jCIjDmoTLQ91VYSiTF4h1hXmHM5MP+uqlE
         eAY8vFCDvSDXqYyqrpxdgXkFBOV3vvAZeRog5HmTuuOyTTCkX9tyAXRNq99X4Jt1KQ
         8lvz8T+V0ZaThBmqBG+aY6di5Y+oso2vbYobrDtseWn5qLc0pJsEcT+CrammSG2n4C
         9WUl3clalH0n/XOxAODPt5cy1gCAvfGu5YE5JLhxxhLPEol/1s72n12pAkmtDP25N8
         tkeIqBla7gswcTnA4iwmndNqFvvLlPyishKXSECHri0NAIMq2mkaXzKPSdHCBgltDI
         uqcdcVKVg7O2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from gecko.fritz.box ([82.207.254.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M604t-1pAPEb3ysl-0079TN; Sun, 01
 Jan 2023 00:58:47 +0100
Date:   Sat, 31 Dec 2022 23:58:45 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Btrfs <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: btrfs qgroup warning
Message-ID: <20221231235845.21877393@gecko.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FO9KcyRm+w5iCiMciGRXHR2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:Zfaa9N/Qy3xbWZOVpz94eD/iljKbxKuxE9mcXYeAINWVeXBVrnq
 XJ5L27mPYmz/40EELz/WTP6bpaTATBTbCtGTZHXBxWKfiUqHSczadweSaSG1Kx8zRWVmtHb
 AgMYZN/PqtIGmEs2IASqCe8ENe3PYKRRP2bY64EjaEcjGX835xhGkx1UZHTK3x/umnG4ZFl
 AlfiAR7sRHTuyXkZ3ug9Q==
UI-OutboundReport: notjunk:1;M01:P0:ubQ+J2ysTW4=;d81B/kUK1UmasiTFZidKZNocC3A
 OnkOCCGhv8QIDlPPg7GWjYKeLd6hr6KrAA3hRUUMtAbtDpX37qRJIo8E4hxpVuVEBDWgNxJyp
 CRprJVQfz9oWzKIch5UUc7lD6jOgjE243eqrUlFC5vOou5oOvV+Rq830SH3xyYNY5ckxhx6pF
 FFFX9X4TXLBWqEl9s2esjrCddj19ySzWdEMkbNtIerYiWjYAAtMyjV1V2ceZJK6UlcWHdm21X
 GnCDZPIKQKB2f+GhL+e2dygMEI8MGTErTeGInfaDrGczqE9NHgGN1Et0g0Dgv9QSTwB24S3P9
 l+EocIMP46fDooRIQKd2iSs+ikB3FhWI3Fal7xes/I9vXGL0GRKhdJOAeLN3vBCg9YVsnDexQ
 sZjqGjDcWfsp11KlZXJ/kRUSd2wtBio/0/rVzhQTJvtqmFsoSmZSaYExQRPlVChf25pgxJ6TD
 07FHdVoaXKLdP4RRBnTU/ftdkutUOrioWHn5+jN0Jzbdrf2YT4Mzm0fJSMmyNRWkymlgUI5sH
 Hqq4MMfR7pCdnPyCGPlipuVmacc7DZMGLmEYrgUzopkhN/jLJSQwul5p7xMIvg2rGCfYtGIlx
 1grX+qi5T6VL60GFEYa4Qhti/F8a0EJF04X71ie95BDiRAGA8V1hpjlVkjooTkf+CLmohAO0m
 HwtDciqxInzBNe5QeaES2VYefjP99iz+bCjLSL4D+SrUyqAZ1cl+KX82Z1EF49eUsXbwgQYpA
 +B49COmqbHF2voMg6nlOtHiM0Ivy4zJ9fa8H2ZAYX2O6lvDmB5BjxR5z0XGOZoPIEi6mY1t7J
 sYN2rr3wmXh0eeHmqdi33ztn/7E1Rl6MSaFs1MbThl0mV27CLS3+TibVrz3NMiyM7jPX5gEh0
 bAlLP9I68PfANpMLr6Ec+cIJPR6FVfWXdVoCprq5hnoUyTV2zz0fWr+j3H18HwCa23FSOQ+NG
 GkWXt9SMzciYf167o2sv/8mwr78=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/FO9KcyRm+w5iCiMciGRXHR2
Content-Type: multipart/mixed; boundary="MP_/o0mP.bKZvjMaQaJAj+s_ruX"

--MP_/o0mP.bKZvjMaQaJAj+s_ruX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Everyone,
I found a couple of weird warnings in dmesg.

This is opensuse thumbleweed, looks like snapper already makes use of
the delayed qgroup scanning?

Linux gecko 6.1.1-1-default #1 SMP PREEMPT_DYNAMIC Thu Dec 22 15:37:40 UTC =
2022 (e71748d) x86_64 x86_64 x86_64 GNU/Linux

dmesg attached.

....


--=20


--MP_/o0mP.bKZvjMaQaJAj+s_ruX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=qgroup-warning.txt

[86841.097930] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[86841.100686] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[86841.101070] ata5.00: supports DRM functions and may not be fully accessi=
ble
[86841.104889] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[86841.105183] ata5.00: supports DRM functions and may not be fully accessi=
ble
[86841.108345] ata5.00: configured for UDMA/133
[86841.118641] sd 4:0:0:0: [sda] Starting disk
[86841.119303] ata5.00: Enabling discard_zeroes_data
[86889.954307] sd 4:0:0:0: [sda] Synchronizing SCSI cache
[86889.957514] sd 4:0:0:0: [sda] Stopping disk
[86905.354236] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[86905.356917] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[86905.357313] ata5.00: supports DRM functions and may not be fully accessi=
ble
[86905.360643] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[86905.360943] ata5.00: supports DRM functions and may not be fully accessi=
ble
[86905.363804] ata5.00: configured for UDMA/133
[86905.373998] sd 4:0:0:0: [sda] Starting disk
[86905.374391] ata5.00: Enabling discard_zeroes_data
[86935.079535] sd 4:0:0:0: [sda] Synchronizing SCSI cache
[86935.082765] sd 4:0:0:0: [sda] Stopping disk
[86935.561561] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[86935.564256] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[86935.564676] ata5.00: supports DRM functions and may not be fully accessi=
ble
[86935.568535] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[86935.568836] ata5.00: supports DRM functions and may not be fully accessi=
ble
[86935.572000] ata5.00: configured for UDMA/133
[86935.582261] sd 4:0:0:0: [sda] Starting disk
[86935.582860] ata5.00: Enabling discard_zeroes_data
[87046.991640] ------------[ cut here ]------------
[87046.991643] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.991729] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.991779]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.991821]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.991850] Unloaded tainted modules: bbswitch(O):2
[87046.991853] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.991856] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.991857] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.991922] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.991923] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.991925] RAX: ffff9d342834e280 RBX: 0000000000000000 RCX: 00000000000=
0001b
[87046.991927] RDX: ffff9d342834e280 RSI: 0000000000000000 RDI: 00000000000=
00000
[87046.991928] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: ffff9d34000=
00000
[87046.991929] R10: 0000000000000010 R11: 0000000000000010 R12: 00000000000=
00001
[87046.991930] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d34283=
4e280
[87046.991932] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.991933] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.991934] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.991936] Call Trace:
[87046.991938]  <TASK>
[87046.991941]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.991997]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.992052]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.992118]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.992180]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.992184]  ? __seccomp_filter+0x319/0x4d0
[87046.992187]  ? call_rcu+0xd5/0xa10
[87046.992192]  __x64_sys_ioctl+0x8d/0xd0
[87046.992201]  do_syscall_64+0x58/0x80
[87046.992205]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.992208]  ? do_syscall_64+0x67/0x80
[87046.992210]  ? do_syscall_64+0x67/0x80
[87046.992212]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.992215] RIP: 0033:0x7f250750d9bf
[87046.992217] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.992219] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.992221] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.992222] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.992223] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.992224] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.992226] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.992228]  </TASK>
[87046.992229] ---[ end trace 0000000000000000 ]---
[87046.992270] ------------[ cut here ]------------
[87046.992270] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.992337] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.992370]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.992409]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.992434] Unloaded tainted modules: bbswitch(O):2
[87046.992436] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.992439] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.992440] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.992505] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.992506] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.992508] RAX: ffff9d350278b7c0 RBX: 0000000000000000 RCX: 00000000804=
00031
[87046.992509] RDX: ffff9d350278b7c0 RSI: ffffe84e80a0d380 RDI: 00000000000=
00000
[87046.992510] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00031
[87046.992511] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00002
[87046.992512] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35027=
8b7c0
[87046.992513] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.992515] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.992516] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.992517] Call Trace:
[87046.992518]  <TASK>
[87046.992520]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.992574]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.992629]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.992695]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.992757]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.992759]  ? __seccomp_filter+0x319/0x4d0
[87046.992761]  ? call_rcu+0xd5/0xa10
[87046.992764]  __x64_sys_ioctl+0x8d/0xd0
[87046.992768]  do_syscall_64+0x58/0x80
[87046.992770]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.992773]  ? do_syscall_64+0x67/0x80
[87046.992775]  ? do_syscall_64+0x67/0x80
[87046.992777]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.992779] RIP: 0033:0x7f250750d9bf
[87046.992780] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.992782] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.992784] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.992785] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.992795] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.992796] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.992797] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.992798]  </TASK>
[87046.992799] ---[ end trace 0000000000000000 ]---
[87046.993123] ------------[ cut here ]------------
[87046.993124] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.993178] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.993206]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.993239]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.993261] Unloaded tainted modules: bbswitch(O):2
[87046.993263] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.993265] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.993266] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.993321] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.993323] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.993324] RAX: ffff9d350278b640 RBX: 0000000000000000 RCX: 00000000804=
00029
[87046.993325] RDX: ffff9d350278b640 RSI: ffffe84e8409e2c0 RDI: 00000000000=
00000
[87046.993326] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00029
[87046.993327] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00003
[87046.993327] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35027=
8b640
[87046.993329] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.993330] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.993331] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.993332] Call Trace:
[87046.993333]  <TASK>
[87046.993334]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.993381]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.993427]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.993482]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.993535]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.993537]  ? __seccomp_filter+0x319/0x4d0
[87046.993539]  ? call_rcu+0xd5/0xa10
[87046.993542]  __x64_sys_ioctl+0x8d/0xd0
[87046.993544]  do_syscall_64+0x58/0x80
[87046.993547]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.993549]  ? do_syscall_64+0x67/0x80
[87046.993551]  ? do_syscall_64+0x67/0x80
[87046.993552]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.993554] RIP: 0033:0x7f250750d9bf
[87046.993555] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.993557] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.993558] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.993559] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.993560] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.993561] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.993562] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.993564]  </TASK>
[87046.993565] ---[ end trace 0000000000000000 ]---
[87046.993852] ------------[ cut here ]------------
[87046.993853] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.993925] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.993961]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.994003]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.994030] Unloaded tainted modules: bbswitch(O):2
[87046.994033] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.994035] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.994036] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.994107] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.994108] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.994110] RAX: ffff9d35ac1f9740 RBX: 0000000000000000 RCX: 00000000804=
00028
[87046.994111] RDX: ffff9d35ac1f9740 RSI: ffffe84e8409e2c0 RDI: 00000000000=
00000
[87046.994112] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00028
[87046.994114] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00004
[87046.994114] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35ac1=
f9740
[87046.994116] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.994117] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.994119] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.994120] Call Trace:
[87046.994121]  <TASK>
[87046.994123]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.994182]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.994241]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.994312]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.994379]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.994381]  ? __seccomp_filter+0x319/0x4d0
[87046.994383]  ? call_rcu+0xd5/0xa10
[87046.994387]  __x64_sys_ioctl+0x8d/0xd0
[87046.994390]  do_syscall_64+0x58/0x80
[87046.994393]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.994396]  ? do_syscall_64+0x67/0x80
[87046.994398]  ? do_syscall_64+0x67/0x80
[87046.994400]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.994402] RIP: 0033:0x7f250750d9bf
[87046.994404] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.994406] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.994408] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.994409] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.994410] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.994411] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.994412] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.994415]  </TASK>
[87046.994415] ---[ end trace 0000000000000000 ]---
[87046.994452] ------------[ cut here ]------------
[87046.994452] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.994524] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.994571]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.994610]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.994636] Unloaded tainted modules: bbswitch(O):2
[87046.994638] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.994641] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.994641] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.994710] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.994712] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.994714] RAX: ffff9d342834ef00 RBX: 0000000000000000 RCX: 000001332a0=
7a002
[87046.994715] RDX: ffff9d342834ef00 RSI: 664706bceee5fd89 RDI: 00000000000=
00000
[87046.994716] RBP: ffff9d34b0b4e960 R08: ffff9d34b0b4e960 R09: 0000001428b=
5c000
[87046.994717] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00005
[87046.994718] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d34283=
4ef00
[87046.994719] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.994721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.994722] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.994724] Call Trace:
[87046.994724]  <TASK>
[87046.994726]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.994785]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.994843]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.994899]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.994954]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.994956]  ? __seccomp_filter+0x319/0x4d0
[87046.994957]  ? call_rcu+0xd5/0xa10
[87046.994960]  __x64_sys_ioctl+0x8d/0xd0
[87046.994963]  do_syscall_64+0x58/0x80
[87046.994966]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.994968]  ? do_syscall_64+0x67/0x80
[87046.994969]  ? do_syscall_64+0x67/0x80
[87046.994971]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.994973] RIP: 0033:0x7f250750d9bf
[87046.994974] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.994975] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.994977] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.994978] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.994979] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.994980] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.994981] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.994983]  </TASK>
[87046.994983] ---[ end trace 0000000000000000 ]---
[87046.995010] ------------[ cut here ]------------
[87046.995010] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.995068] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.995098]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.995131]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.995154] Unloaded tainted modules: bbswitch(O):2
[87046.995155] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.995157] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.995158] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.995215] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.995216] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.995218] RAX: ffff9d35dd221a00 RBX: 0000000000000000 RCX: 00000000804=
0002f
[87046.995219] RDX: ffff9d35dd221a00 RSI: ffffe84e80a0d380 RDI: 00000000000=
00000
[87046.995220] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0002f
[87046.995221] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00006
[87046.995221] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35dd2=
21a00
[87046.995223] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.995224] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.995225] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.995226] Call Trace:
[87046.995226]  <TASK>
[87046.995228]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.995275]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.995323]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.995381]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.995436]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.995437]  ? __seccomp_filter+0x319/0x4d0
[87046.995439]  ? call_rcu+0xd5/0xa10
[87046.995442]  __x64_sys_ioctl+0x8d/0xd0
[87046.995445]  do_syscall_64+0x58/0x80
[87046.995447]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.995450]  ? do_syscall_64+0x67/0x80
[87046.995451]  ? do_syscall_64+0x67/0x80
[87046.995453]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.995455] RIP: 0033:0x7f250750d9bf
[87046.995456] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.995457] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.995459] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.995460] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.995461] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.995462] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.995463] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.995465]  </TASK>
[87046.995465] ---[ end trace 0000000000000000 ]---
[87046.995483] ------------[ cut here ]------------
[87046.995484] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.995541] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.995571]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.995605]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.995628] Unloaded tainted modules: bbswitch(O):2
[87046.995629] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.995631] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.995632] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.995690] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.995691] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.995692] RAX: ffff9d35ac1f9a80 RBX: 0000000000000000 RCX: 00000000804=
0001e
[87046.995693] RDX: ffff9d35ac1f9a80 RSI: ffffe84e87748840 RDI: 00000000000=
00000
[87046.995694] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0001e
[87046.995695] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00007
[87046.995696] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35ac1=
f9a80
[87046.995697] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.995698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.995699] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.995700] Call Trace:
[87046.995701]  <TASK>
[87046.995702]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.995750]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.995798]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.995861]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.995911]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.995913]  ? __seccomp_filter+0x319/0x4d0
[87046.995914]  ? call_rcu+0xd5/0xa10
[87046.995917]  __x64_sys_ioctl+0x8d/0xd0
[87046.995920]  do_syscall_64+0x58/0x80
[87046.995922]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.995924]  ? do_syscall_64+0x67/0x80
[87046.995926]  ? do_syscall_64+0x67/0x80
[87046.995927]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.995929] RIP: 0033:0x7f250750d9bf
[87046.995930] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.995931] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.995933] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.995934] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.995935] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.995936] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.995937] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.995938]  </TASK>
[87046.995939] ---[ end trace 0000000000000000 ]---
[87046.995969] ------------[ cut here ]------------
[87046.995969] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.996025] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.996053]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.996086]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.996108] Unloaded tainted modules: bbswitch(O):2
[87046.996110] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.996112] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.996112] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.996168] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.996169] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.996170] RAX: ffff9d35ac1f97c0 RBX: 0000000000000000 RCX: 000001332a0=
96002
[87046.996171] RDX: ffff9d35ac1f97c0 RSI: a64a06bceee5f449 RDI: 00000000000=
00000
[87046.996172] RBP: ffff9d34b0b4e960 R08: ffff9d34b0b4e960 R09: 0000000eefb=
f0000
[87046.996173] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00008
[87046.996174] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35ac1=
f97c0
[87046.996175] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.996176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.996177] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.996178] Call Trace:
[87046.996179]  <TASK>
[87046.996180]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.996226]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.996273]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.996328]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.996381]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.996383]  ? __seccomp_filter+0x319/0x4d0
[87046.996384]  ? call_rcu+0xd5/0xa10
[87046.996387]  __x64_sys_ioctl+0x8d/0xd0
[87046.996390]  do_syscall_64+0x58/0x80
[87046.996392]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.996395]  ? do_syscall_64+0x67/0x80
[87046.996396]  ? do_syscall_64+0x67/0x80
[87046.996398]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.996399] RIP: 0033:0x7f250750d9bf
[87046.996401] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.996402] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.996403] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.996404] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.996405] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.996406] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.996407] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.996409]  </TASK>
[87046.996409] ---[ end trace 0000000000000000 ]---
[87046.996455] ------------[ cut here ]------------
[87046.996456] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.996512] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.996540]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.996573]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.996595] Unloaded tainted modules: bbswitch(O):2
[87046.996596] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.996598] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.996599] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.996655] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.996656] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.996657] RAX: ffff9d35f8a68c80 RBX: 0000000000000000 RCX: 000001332a0=
cc002
[87046.996658] RDX: ffff9d35f8a68c80 RSI: e64706bceee5f449 RDI: 00000000000=
00000
[87046.996659] RBP: ffff9d34b0b4e960 R08: ffff9d34b0b4e960 R09: ffff9d35089=
5c078
[87046.996660] R10: 0000000000000000 R11: ffff9d363c822800 R12: 00000000000=
00009
[87046.996661] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35f8a=
68c80
[87046.996662] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.996663] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.996664] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.996665] Call Trace:
[87046.996665]  <TASK>
[87046.996667]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.996713]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.996760]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.996815]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.996868]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.996870]  ? __seccomp_filter+0x319/0x4d0
[87046.996871]  ? call_rcu+0xd5/0xa10
[87046.996874]  __x64_sys_ioctl+0x8d/0xd0
[87046.996877]  do_syscall_64+0x58/0x80
[87046.996879]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.996882]  ? do_syscall_64+0x67/0x80
[87046.996883]  ? do_syscall_64+0x67/0x80
[87046.996885]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.996886] RIP: 0033:0x7f250750d9bf
[87046.996887] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.996889] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.996890] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.996891] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.996892] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.996893] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.996894] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.996895]  </TASK>
[87046.996896] ---[ end trace 0000000000000000 ]---
[87046.997496] ------------[ cut here ]------------
[87046.997497] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.997553] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.997582]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.997615]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.997637] Unloaded tainted modules: bbswitch(O):2
[87046.997639] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.997641] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.997642] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.997698] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.997699] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.997701] RAX: ffff9d360590eac0 RBX: 0000000000000000 RCX: 00000000804=
00036
[87046.997701] RDX: ffff9d360590eac0 RSI: ffffe84e87e29a00 RDI: 00000000000=
00000
[87046.997702] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00036
[87046.997703] R10: 0000000000000000 R11: ffff9d363c822800 R12: 00000000000=
0000a
[87046.997704] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0eac0
[87046.997705] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.997707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.997707] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.997709] Call Trace:
[87046.997710]  <TASK>
[87046.997711]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.997758]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.997804]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.997870]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.997931]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.997933]  ? __seccomp_filter+0x319/0x4d0
[87046.997935]  ? call_rcu+0xd5/0xa10
[87046.997939]  __x64_sys_ioctl+0x8d/0xd0
[87046.997942]  do_syscall_64+0x58/0x80
[87046.997945]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.997948]  ? do_syscall_64+0x67/0x80
[87046.997949]  ? do_syscall_64+0x67/0x80
[87046.997951]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.997953] RIP: 0033:0x7f250750d9bf
[87046.997955] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.997956] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.997958] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.997960] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.997961] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.997962] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.997963] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.997965]  </TASK>
[87046.997966] ---[ end trace 0000000000000000 ]---
[87046.998012] ------------[ cut here ]------------
[87046.998013] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.998078] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.998111]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.998150]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.998176] Unloaded tainted modules: bbswitch(O):2
[87046.998178] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.998180] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.998181] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.998247] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.998248] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.998250] RAX: ffff9d360590e780 RBX: 0000000000000000 RCX: 00000000004=
0003e
[87046.998251] RDX: ffff9d360590e780 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87046.998252] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
0003e
[87046.998254] R10: 0000000000000000 R11: ffff9d35050ef000 R12: 00000000000=
0000b
[87046.998255] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0e780
[87046.998256] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.998258] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.998259] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.998260] Call Trace:
[87046.998261]  <TASK>
[87046.998262]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.998321]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.998380]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.998451]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.998517]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.998520]  ? __seccomp_filter+0x319/0x4d0
[87046.998521]  ? call_rcu+0xd5/0xa10
[87046.998525]  __x64_sys_ioctl+0x8d/0xd0
[87046.998529]  do_syscall_64+0x58/0x80
[87046.998532]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.998535]  ? do_syscall_64+0x67/0x80
[87046.998536]  ? do_syscall_64+0x67/0x80
[87046.998538]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.998540] RIP: 0033:0x7f250750d9bf
[87046.998542] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.998543] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.998545] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.998546] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.998548] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.998549] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.998560] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.998564]  </TASK>
[87046.998565] ---[ end trace 0000000000000000 ]---
[87046.998602] ------------[ cut here ]------------
[87046.998603] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.998674] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.998710]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.998752]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.998779] Unloaded tainted modules: bbswitch(O):2
[87046.998782] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.998784] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.998785] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.998856] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.998857] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.998859] RAX: ffff9d342834e4c0 RBX: 0000000000000000 RCX: 00000000004=
0003d
[87046.998869] RDX: ffff9d342834e4c0 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87046.998869] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
0003d
[87046.998870] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
0000c
[87046.998871] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d34283=
4e4c0
[87046.998872] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.998873] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.998874] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.998875] Call Trace:
[87046.998876]  <TASK>
[87046.998877]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.998921]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.998967]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.999023]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.999076]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.999078]  ? __seccomp_filter+0x319/0x4d0
[87046.999079]  ? call_rcu+0xd5/0xa10
[87046.999082]  __x64_sys_ioctl+0x8d/0xd0
[87046.999085]  do_syscall_64+0x58/0x80
[87046.999087]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.999089]  ? do_syscall_64+0x67/0x80
[87046.999091]  ? do_syscall_64+0x67/0x80
[87046.999092]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.999094] RIP: 0033:0x7f250750d9bf
[87046.999095] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.999097] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.999098] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.999099] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.999100] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.999101] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.999102] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.999104]  </TASK>
[87046.999104] ---[ end trace 0000000000000000 ]---
[87046.999131] ------------[ cut here ]------------
[87046.999131] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.999188] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.999216]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.999249]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.999271] Unloaded tainted modules: bbswitch(O):2
[87046.999273] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.999275] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.999276] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.999331] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.999333] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.999334] RAX: ffff9d35157c2080 RBX: 0000000000000000 RCX: 00000000804=
0002e
[87046.999335] RDX: ffff9d35157c2080 RSI: ffffe84e80a0d380 RDI: 00000000000=
00000
[87046.999336] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0002e
[87046.999337] R10: 0000000000000000 R11: ffff9d35050ea800 R12: 00000000000=
0000d
[87046.999338] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35157=
c2080
[87046.999339] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.999340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.999341] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.999342] Call Trace:
[87046.999342]  <TASK>
[87046.999343]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.999390]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.999436]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.999492]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87046.999545]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87046.999547]  ? __seccomp_filter+0x319/0x4d0
[87046.999548]  ? call_rcu+0xd5/0xa10
[87046.999551]  __x64_sys_ioctl+0x8d/0xd0
[87046.999554]  do_syscall_64+0x58/0x80
[87046.999556]  ? syscall_exit_to_user_mode+0x17/0x40
[87046.999559]  ? do_syscall_64+0x67/0x80
[87046.999560]  ? do_syscall_64+0x67/0x80
[87046.999562]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87046.999563] RIP: 0033:0x7f250750d9bf
[87046.999564] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87046.999565] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87046.999567] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87046.999568] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87046.999569] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87046.999570] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87046.999570] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87046.999572]  </TASK>
[87046.999573] ---[ end trace 0000000000000000 ]---
[87046.999601] ------------[ cut here ]------------
[87046.999601] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87046.999657] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87046.999685]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87046.999718]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87046.999740] Unloaded tainted modules: bbswitch(O):2
[87046.999742] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87046.999744] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87046.999744] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87046.999800] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87046.999801] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87046.999802] RAX: ffff9d360590e100 RBX: 0000000000000000 RCX: ffff9d35000=
41150
[87046.999803] RDX: ffff9d360590e100 RSI: 0000000000000246 RDI: 00000000000=
00000
[87046.999804] RBP: ffff9d34b0b4e960 R08: 0000000000000282 R09: 00000000804=
0003f
[87046.999805] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
0000e
[87046.999806] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0e100
[87046.999807] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87046.999808] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87046.999809] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87046.999810] Call Trace:
[87046.999811]  <TASK>
[87046.999812]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87046.999859]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87046.999905]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87046.999961]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.000014]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.000015]  ? __seccomp_filter+0x319/0x4d0
[87047.000017]  ? call_rcu+0xd5/0xa10
[87047.000020]  __x64_sys_ioctl+0x8d/0xd0
[87047.000022]  do_syscall_64+0x58/0x80
[87047.000025]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.000027]  ? do_syscall_64+0x67/0x80
[87047.000029]  ? do_syscall_64+0x67/0x80
[87047.000030]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.000032] RIP: 0033:0x7f250750d9bf
[87047.000033] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.000034] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.000036] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.000037] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.000038] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.000038] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.000039] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.000041]  </TASK>
[87047.000042] ---[ end trace 0000000000000000 ]---
[87047.000059] ------------[ cut here ]------------
[87047.000059] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.000115] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.000143]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.000177]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.000198] Unloaded tainted modules: bbswitch(O):2
[87047.000200] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.000202] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.000202] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.000258] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.000259] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.000260] RAX: ffff9d35157c2b00 RBX: 0000000000000000 RCX: 00000000004=
0003c
[87047.000261] RDX: ffff9d35157c2b00 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.000262] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
0003c
[87047.000263] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
0000f
[87047.000264] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35157=
c2b00
[87047.000265] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.000266] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.000267] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.000268] Call Trace:
[87047.000269]  <TASK>
[87047.000270]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.000316]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.000363]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.000419]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.000471]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.000473]  ? __seccomp_filter+0x319/0x4d0
[87047.000474]  ? call_rcu+0xd5/0xa10
[87047.000478]  __x64_sys_ioctl+0x8d/0xd0
[87047.000480]  do_syscall_64+0x58/0x80
[87047.000483]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.000485]  ? do_syscall_64+0x67/0x80
[87047.000486]  ? do_syscall_64+0x67/0x80
[87047.000488]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.000490] RIP: 0033:0x7f250750d9bf
[87047.000491] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.000492] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.000494] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.000495] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.000495] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.000496] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.000497] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.000499]  </TASK>
[87047.000499] ---[ end trace 0000000000000000 ]---
[87047.000518] ------------[ cut here ]------------
[87047.000519] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.000575] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.000603]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.000636]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.000657] Unloaded tainted modules: bbswitch(O):2
[87047.000659] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.000661] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.000662] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.000717] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.000719] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.000720] RAX: ffff9d35de125200 RBX: 0000000000000000 RCX: 00000000804=
0003e
[87047.000721] RDX: ffff9d35de125200 RSI: ffffe84e8455f080 RDI: 00000000000=
00000
[87047.000722] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0003e
[87047.000723] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00010
[87047.000724] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35de1=
25200
[87047.000725] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.000726] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.000727] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.000728] Call Trace:
[87047.000729]  <TASK>
[87047.000730]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.000776]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.000822]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.000878]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.000931]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.000932]  ? __seccomp_filter+0x319/0x4d0
[87047.000934]  ? call_rcu+0xd5/0xa10
[87047.000937]  __x64_sys_ioctl+0x8d/0xd0
[87047.000939]  do_syscall_64+0x58/0x80
[87047.000942]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.000944]  ? do_syscall_64+0x67/0x80
[87047.000945]  ? do_syscall_64+0x67/0x80
[87047.000947]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.000949] RIP: 0033:0x7f250750d9bf
[87047.000950] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.000951] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.000953] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.000954] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.000955] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.000956] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.000956] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.000958]  </TASK>
[87047.000959] ---[ end trace 0000000000000000 ]---
[87047.000980] ------------[ cut here ]------------
[87047.000981] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.001037] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.001065]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.001098]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.001119] Unloaded tainted modules: bbswitch(O):2
[87047.001121] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.001123] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.001124] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.001179] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.001180] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.001181] RAX: ffff9d35157c2480 RBX: 0000000000000000 RCX: 00000000000=
00000
[87047.001182] RDX: ffff9d35157c2480 RSI: ffffe84e87784940 RDI: 00000000000=
00000
[87047.001183] RBP: ffff9d34b0b4e960 R08: 0000000000000282 R09: 00000000804=
0003f
[87047.001184] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00011
[87047.001185] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35157=
c2480
[87047.001186] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.001187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.001188] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.001189] Call Trace:
[87047.001190]  <TASK>
[87047.001191]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.001238]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.001284]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.001339]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.001392]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.001394]  ? __seccomp_filter+0x319/0x4d0
[87047.001395]  ? call_rcu+0xd5/0xa10
[87047.001398]  __x64_sys_ioctl+0x8d/0xd0
[87047.001401]  do_syscall_64+0x58/0x80
[87047.001403]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.001406]  ? do_syscall_64+0x67/0x80
[87047.001407]  ? do_syscall_64+0x67/0x80
[87047.001409]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.001410] RIP: 0033:0x7f250750d9bf
[87047.001412] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.001413] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.001414] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.001415] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.001416] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.001417] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.001418] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.001420]  </TASK>
[87047.001420] ---[ end trace 0000000000000000 ]---
[87047.001442] ------------[ cut here ]------------
[87047.001443] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.001499] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.001527]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.001560]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.001582] Unloaded tainted modules: bbswitch(O):2
[87047.001583] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.001585] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.001586] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.001641] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.001642] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.001644] RAX: ffff9d342834e980 RBX: 0000000000000000 RCX: 00000000804=
0003d
[87047.001645] RDX: ffff9d342834e980 RSI: ffffe84e8455f080 RDI: 00000000000=
00000
[87047.001645] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0003d
[87047.001646] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00012
[87047.001647] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d34283=
4e980
[87047.001648] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.001649] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.001650] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.001651] Call Trace:
[87047.001652]  <TASK>
[87047.001653]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.001700]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.001746]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.001802]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.001855]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.001856]  ? __seccomp_filter+0x319/0x4d0
[87047.001858]  ? call_rcu+0xd5/0xa10
[87047.001861]  __x64_sys_ioctl+0x8d/0xd0
[87047.001863]  do_syscall_64+0x58/0x80
[87047.001866]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.001868]  ? do_syscall_64+0x67/0x80
[87047.001869]  ? do_syscall_64+0x67/0x80
[87047.001871]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.001873] RIP: 0033:0x7f250750d9bf
[87047.001874] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.001875] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.001877] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.001878] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.001879] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.001880] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.001881] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.001882]  </TASK>
[87047.001883] ---[ end trace 0000000000000000 ]---
[87047.001909] ------------[ cut here ]------------
[87047.001910] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.001966] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.001994]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.002026]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.002048] Unloaded tainted modules: bbswitch(O):2
[87047.002050] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.002051] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.002052] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.002108] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.002109] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.002110] RAX: ffff9d360590e8c0 RBX: 0000000000000000 RCX: 000001332a1=
a8002
[87047.002111] RDX: ffff9d360590e8c0 RSI: 664d06bceee5fa49 RDI: 00000000000=
00000
[87047.002112] RBP: ffff9d34b0b4e960 R08: ffff9d34b0b4e960 R09: 0000000ef25=
28000
[87047.002113] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00014
[87047.002114] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0e8c0
[87047.002115] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.002116] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.002117] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.002118] Call Trace:
[87047.002119]  <TASK>
[87047.002120]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.002166]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.002212]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.002267]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.002320]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.002322]  ? __seccomp_filter+0x319/0x4d0
[87047.002323]  ? call_rcu+0xd5/0xa10
[87047.002326]  __x64_sys_ioctl+0x8d/0xd0
[87047.002329]  do_syscall_64+0x58/0x80
[87047.002331]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.002334]  ? do_syscall_64+0x67/0x80
[87047.002335]  ? do_syscall_64+0x67/0x80
[87047.002337]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.002338] RIP: 0033:0x7f250750d9bf
[87047.002340] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.002341] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.002342] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.002343] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.002344] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.002345] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.002346] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.002348]  </TASK>
[87047.002349] ---[ end trace 0000000000000000 ]---
[87047.002366] ------------[ cut here ]------------
[87047.002367] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.002422] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.002451]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.002483]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.002505] Unloaded tainted modules: bbswitch(O):2
[87047.002506] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.002508] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.002509] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.002607] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.002608] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.002609] RAX: ffff9d360590e9c0 RBX: 0000000000000000 RCX: 00000000004=
0003b
[87047.002610] RDX: ffff9d360590e9c0 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.002611] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
0003b
[87047.002612] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00015
[87047.002613] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0e9c0
[87047.002614] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.002615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.002616] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.002617] Call Trace:
[87047.002618]  <TASK>
[87047.002619]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.002660]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.002700]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.002752]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.002805]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.002807]  ? __seccomp_filter+0x319/0x4d0
[87047.002808]  ? call_rcu+0xd5/0xa10
[87047.002811]  __x64_sys_ioctl+0x8d/0xd0
[87047.002814]  do_syscall_64+0x58/0x80
[87047.002816]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.002818]  ? do_syscall_64+0x67/0x80
[87047.002820]  ? do_syscall_64+0x67/0x80
[87047.002822]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.002823] RIP: 0033:0x7f250750d9bf
[87047.002825] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.002826] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.002828] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.002829] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.002830] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.002830] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.002831] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.002833]  </TASK>
[87047.002834] ---[ end trace 0000000000000000 ]---
[87047.002854] ------------[ cut here ]------------
[87047.002854] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.002911] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.002939]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.002972]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.002994] Unloaded tainted modules: bbswitch(O):2
[87047.002995] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.002997] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.002998] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.003053] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.003054] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.003055] RAX: ffff9d360590e440 RBX: 0000000000000000 RCX: 00000000004=
0003a
[87047.003056] RDX: ffff9d360590e440 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.003057] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
0003a
[87047.003058] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00016
[87047.003059] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0e440
[87047.003060] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.003061] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.003062] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.003063] Call Trace:
[87047.003064]  <TASK>
[87047.003065]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.003111]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.003158]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.003213]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.003266]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.003268]  ? __seccomp_filter+0x319/0x4d0
[87047.003269]  ? call_rcu+0xd5/0xa10
[87047.003272]  __x64_sys_ioctl+0x8d/0xd0
[87047.003275]  do_syscall_64+0x58/0x80
[87047.003277]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.003280]  ? do_syscall_64+0x67/0x80
[87047.003281]  ? do_syscall_64+0x67/0x80
[87047.003283]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.003284] RIP: 0033:0x7f250750d9bf
[87047.003286] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.003287] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.003288] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.003289] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.003290] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.003291] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.003292] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.003294]  </TASK>
[87047.003295] ---[ end trace 0000000000000000 ]---
[87047.003315] ------------[ cut here ]------------
[87047.003316] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.003371] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.003400]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.003433]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.003454] Unloaded tainted modules: bbswitch(O):2
[87047.003456] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.003458] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.003459] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.003514] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.003515] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.003516] RAX: ffff9d360590e600 RBX: 0000000000000000 RCX: 00000000004=
00039
[87047.003517] RDX: ffff9d360590e600 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.003518] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
00039
[87047.003519] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00017
[87047.003520] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0e600
[87047.003521] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.003522] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.003523] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.003524] Call Trace:
[87047.003525]  <TASK>
[87047.003526]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.003572]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.003619]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.003674]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.003727]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.003729]  ? __seccomp_filter+0x319/0x4d0
[87047.003730]  ? call_rcu+0xd5/0xa10
[87047.003733]  __x64_sys_ioctl+0x8d/0xd0
[87047.003736]  do_syscall_64+0x58/0x80
[87047.003738]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.003741]  ? do_syscall_64+0x67/0x80
[87047.003742]  ? do_syscall_64+0x67/0x80
[87047.003744]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.003745] RIP: 0033:0x7f250750d9bf
[87047.003746] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.003748] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.003749] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.003750] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.003751] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.003752] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.003753] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.003755]  </TASK>
[87047.003755] ---[ end trace 0000000000000000 ]---
[87047.003772] ------------[ cut here ]------------
[87047.003773] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.003829] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.003858]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.003891]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.003912] Unloaded tainted modules: bbswitch(O):2
[87047.003914] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.003916] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.003916] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.003972] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.003973] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.003974] RAX: ffff9d360590edc0 RBX: 0000000000000000 RCX: 00000000004=
00038
[87047.003975] RDX: ffff9d360590edc0 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.003976] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
00038
[87047.003977] R10: 0000000000000000 R11: ffff9d35050ea800 R12: 00000000000=
00018
[87047.003978] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0edc0
[87047.003979] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.003980] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.003981] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.003982] Call Trace:
[87047.003983]  <TASK>
[87047.003984]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.004030]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.004076]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.004132]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.004185]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.004187]  ? __seccomp_filter+0x319/0x4d0
[87047.004188]  ? call_rcu+0xd5/0xa10
[87047.004191]  __x64_sys_ioctl+0x8d/0xd0
[87047.004194]  do_syscall_64+0x58/0x80
[87047.004196]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.004198]  ? do_syscall_64+0x67/0x80
[87047.004200]  ? do_syscall_64+0x67/0x80
[87047.004201]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.004203] RIP: 0033:0x7f250750d9bf
[87047.004204] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.004206] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.004207] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.004208] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.004209] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.004210] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.004211] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.004212]  </TASK>
[87047.004213] ---[ end trace 0000000000000000 ]---
[87047.004231] ------------[ cut here ]------------
[87047.004231] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.004287] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.004316]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.004349]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.004370] Unloaded tainted modules: bbswitch(O):2
[87047.004372] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.004373] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.004374] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.004430] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.004431] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.004432] RAX: ffff9d360590ea40 RBX: 0000000000000000 RCX: 00000000004=
00037
[87047.004433] RDX: ffff9d360590ea40 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.004434] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
00037
[87047.004435] R10: 0000000000000000 R11: ffff9d35050ea800 R12: 00000000000=
00019
[87047.004436] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0ea40
[87047.004437] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.004438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.004439] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.004440] Call Trace:
[87047.004440]  <TASK>
[87047.004441]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.004488]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.004534]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.004590]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.004643]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.004645]  ? __seccomp_filter+0x319/0x4d0
[87047.004646]  ? call_rcu+0xd5/0xa10
[87047.004649]  __x64_sys_ioctl+0x8d/0xd0
[87047.004652]  do_syscall_64+0x58/0x80
[87047.004654]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.004656]  ? do_syscall_64+0x67/0x80
[87047.004658]  ? do_syscall_64+0x67/0x80
[87047.004659]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.004661] RIP: 0033:0x7f250750d9bf
[87047.004662] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.004663] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.004665] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.004666] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.004667] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.004668] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.004668] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.004670]  </TASK>
[87047.004671] ---[ end trace 0000000000000000 ]---
[87047.004690] ------------[ cut here ]------------
[87047.004691] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.004747] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.004775]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.004808]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.004830] Unloaded tainted modules: bbswitch(O):2
[87047.004831] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.004833] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.004834] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.004890] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.004891] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.004892] RAX: ffff9d342834ed80 RBX: 0000000000000000 RCX: 00000000004=
00036
[87047.004893] RDX: ffff9d342834ed80 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.004894] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
00036
[87047.004895] R10: 0000000000000000 R11: ffff9d35050ea800 R12: 00000000000=
0001a
[87047.004896] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d34283=
4ed80
[87047.004897] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.004898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.004899] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.004900] Call Trace:
[87047.004900]  <TASK>
[87047.004901]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.004948]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.004994]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.005050]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.005103]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.005104]  ? __seccomp_filter+0x319/0x4d0
[87047.005106]  ? call_rcu+0xd5/0xa10
[87047.005109]  __x64_sys_ioctl+0x8d/0xd0
[87047.005111]  do_syscall_64+0x58/0x80
[87047.005114]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.005116]  ? do_syscall_64+0x67/0x80
[87047.005117]  ? do_syscall_64+0x67/0x80
[87047.005119]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.005121] RIP: 0033:0x7f250750d9bf
[87047.005122] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.005123] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.005124] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.005125] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.005126] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.005127] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.005128] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.005130]  </TASK>
[87047.005130] ---[ end trace 0000000000000000 ]---
[87047.005149] ------------[ cut here ]------------
[87047.005150] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.005206] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.005234]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.005267]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.005289] Unloaded tainted modules: bbswitch(O):2
[87047.005291] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.005293] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.005293] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.005349] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.005350] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.005351] RAX: ffff9d342918e5c0 RBX: 0000000000000000 RCX: 00000000804=
0002c
[87047.005352] RDX: ffff9d342918e5c0 RSI: ffffe84e80a0d380 RDI: 00000000000=
00000
[87047.005353] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0002c
[87047.005354] R10: 0000000000000000 R11: ffff9d35050ea800 R12: 00000000000=
0001b
[87047.005355] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d34291=
8e5c0
[87047.005356] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.005357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.005358] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.005359] Call Trace:
[87047.005360]  <TASK>
[87047.005361]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.005407]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.005454]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.005511]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.005564]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.005565]  ? __seccomp_filter+0x319/0x4d0
[87047.005567]  ? call_rcu+0xd5/0xa10
[87047.005570]  __x64_sys_ioctl+0x8d/0xd0
[87047.005572]  do_syscall_64+0x58/0x80
[87047.005575]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.005577]  ? do_syscall_64+0x67/0x80
[87047.005578]  ? do_syscall_64+0x67/0x80
[87047.005580]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.005582] RIP: 0033:0x7f250750d9bf
[87047.005583] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.005584] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.005586] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.005587] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.005588] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.005588] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.005589] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.005591]  </TASK>
[87047.005592] ---[ end trace 0000000000000000 ]---
[87047.005612] ------------[ cut here ]------------
[87047.005612] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.005669] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.005697]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.005730]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.005752] Unloaded tainted modules: bbswitch(O):2
[87047.005753] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.005755] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.005756] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.005811] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.005813] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.005814] RAX: ffff9d360590ef80 RBX: 0000000000000000 RCX: 00000000804=
0003c
[87047.005815] RDX: ffff9d360590ef80 RSI: ffffe84e80a46380 RDI: 00000000000=
00000
[87047.005816] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0003c
[87047.005817] R10: 0000000000000000 R11: ffff9d35050ea800 R12: 00000000000=
0001c
[87047.005818] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0ef80
[87047.005819] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.005820] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.005821] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.005822] Call Trace:
[87047.005823]  <TASK>
[87047.005824]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.005870]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.005917]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.005972]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.006025]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.006027]  ? __seccomp_filter+0x319/0x4d0
[87047.006028]  ? call_rcu+0xd5/0xa10
[87047.006031]  __x64_sys_ioctl+0x8d/0xd0
[87047.006034]  do_syscall_64+0x58/0x80
[87047.006036]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.006039]  ? do_syscall_64+0x67/0x80
[87047.006040]  ? do_syscall_64+0x67/0x80
[87047.006042]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.006043] RIP: 0033:0x7f250750d9bf
[87047.006045] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.006046] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.006047] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.006048] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.006049] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.006050] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.006051] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.006052]  </TASK>
[87047.006053] ---[ end trace 0000000000000000 ]---
[87047.006069] ------------[ cut here ]------------
[87047.006070] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.006126] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.006154]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.006187]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.006209] Unloaded tainted modules: bbswitch(O):2
[87047.006211] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.006213] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.006214] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.006269] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.006270] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.006271] RAX: ffff9d360590ecc0 RBX: 0000000000000000 RCX: 00000000004=
00035
[87047.006272] RDX: ffff9d360590ecc0 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.006273] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
00035
[87047.006274] R10: 0000000000000000 R11: ffff9d35050ef000 R12: 00000000000=
0001d
[87047.006275] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0ecc0
[87047.006276] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.006277] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.006278] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.006279] Call Trace:
[87047.006280]  <TASK>
[87047.006281]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.006327]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.006374]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.006430]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.006483]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.006484]  ? __seccomp_filter+0x319/0x4d0
[87047.006486]  ? call_rcu+0xd5/0xa10
[87047.006489]  __x64_sys_ioctl+0x8d/0xd0
[87047.006491]  do_syscall_64+0x58/0x80
[87047.006494]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.006496]  ? do_syscall_64+0x67/0x80
[87047.006497]  ? do_syscall_64+0x67/0x80
[87047.006499]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.006501] RIP: 0033:0x7f250750d9bf
[87047.006502] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.006503] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.006505] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.006505] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.006506] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.006507] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.006508] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.006510]  </TASK>
[87047.006510] ---[ end trace 0000000000000000 ]---
[87047.006530] ------------[ cut here ]------------
[87047.006530] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.006612] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.006658]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.006689]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.006709] Unloaded tainted modules: bbswitch(O):2
[87047.006711] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.006713] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.006714] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.006765] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.006767] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.006768] RAX: ffff9d360590ea00 RBX: 0000000000000000 RCX: 00000000004=
00034
[87047.006769] RDX: ffff9d360590ea00 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.006770] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
00034
[87047.006771] R10: 0000000000000000 R11: ffff9d35050ef000 R12: 00000000000=
0001e
[87047.006771] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0ea00
[87047.006772] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.006774] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.006774] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.006776] Call Trace:
[87047.006776]  <TASK>
[87047.006777]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.006818]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.006858]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.006909]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.006956]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.006958]  ? __seccomp_filter+0x319/0x4d0
[87047.006959]  ? call_rcu+0xd5/0xa10
[87047.006962]  __x64_sys_ioctl+0x8d/0xd0
[87047.006964]  do_syscall_64+0x58/0x80
[87047.006967]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.006969]  ? do_syscall_64+0x67/0x80
[87047.006970]  ? do_syscall_64+0x67/0x80
[87047.006972]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.006973] RIP: 0033:0x7f250750d9bf
[87047.006974] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.006975] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.006977] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.006978] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.006979] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.006979] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.006980] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.006982]  </TASK>
[87047.006982] ---[ end trace 0000000000000000 ]---
[87047.007002] ------------[ cut here ]------------
[87047.007003] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.007053] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.007079]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.007110]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.007130] Unloaded tainted modules: bbswitch(O):2
[87047.007131] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.007133] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.007134] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.007186] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.007187] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.007188] RAX: ffff9d360590ec80 RBX: 0000000000000000 RCX: 00000000004=
00033
[87047.007190] RDX: ffff9d360590ec80 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.007190] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
00033
[87047.007191] R10: 0000000000000000 R11: ffff9d35050ef000 R12: 00000000000=
0001f
[87047.007192] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0ec80
[87047.007193] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.007194] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.007195] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.007196] Call Trace:
[87047.007197]  <TASK>
[87047.007198]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.007244]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.007291]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.007346]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.007399]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.007401]  ? __seccomp_filter+0x319/0x4d0
[87047.007402]  ? call_rcu+0xd5/0xa10
[87047.007405]  __x64_sys_ioctl+0x8d/0xd0
[87047.007408]  do_syscall_64+0x58/0x80
[87047.007411]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.007413]  ? do_syscall_64+0x67/0x80
[87047.007414]  ? do_syscall_64+0x67/0x80
[87047.007416]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.007418] RIP: 0033:0x7f250750d9bf
[87047.007419] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.007420] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.007421] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.007422] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.007423] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.007424] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.007425] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.007427]  </TASK>
[87047.007427] ---[ end trace 0000000000000000 ]---
[87047.007444] ------------[ cut here ]------------
[87047.007445] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.007501] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.007529]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.007562]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.007584] Unloaded tainted modules: bbswitch(O):2
[87047.007585] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.007587] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.007588] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.007644] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.007645] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.007646] RAX: ffff9d360590e180 RBX: 0000000000000000 RCX: 00000000004=
00032
[87047.007647] RDX: ffff9d360590e180 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.007648] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
00032
[87047.007649] R10: 0000000000000000 R11: ffff9d35ee794800 R12: 00000000000=
00020
[87047.007650] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0e180
[87047.007651] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.007652] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.007653] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.007654] Call Trace:
[87047.007655]  <TASK>
[87047.007656]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.007702]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.007748]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.007804]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.007857]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.007859]  ? __seccomp_filter+0x319/0x4d0
[87047.007860]  ? call_rcu+0xd5/0xa10
[87047.007863]  __x64_sys_ioctl+0x8d/0xd0
[87047.007866]  do_syscall_64+0x58/0x80
[87047.007868]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.007870]  ? do_syscall_64+0x67/0x80
[87047.007872]  ? do_syscall_64+0x67/0x80
[87047.007873]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.007875] RIP: 0033:0x7f250750d9bf
[87047.007876] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.007877] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.007879] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.007880] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.007881] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.007882] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.007882] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.007884]  </TASK>
[87047.007885] ---[ end trace 0000000000000000 ]---
[87047.007902] ------------[ cut here ]------------
[87047.007903] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.007959] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.007987]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.008020]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.008042] Unloaded tainted modules: bbswitch(O):2
[87047.008043] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.008045] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.008046] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.008102] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.008103] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.008104] RAX: ffff9d358a8d1a80 RBX: 0000000000000000 RCX: 00000000004=
00031
[87047.008105] RDX: ffff9d358a8d1a80 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.008106] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
00031
[87047.008107] R10: 0000000000000000 R11: ffff9d35ee794800 R12: 00000000000=
00021
[87047.008108] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d358a8=
d1a80
[87047.008109] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.008110] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.008111] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.008112] Call Trace:
[87047.008113]  <TASK>
[87047.008114]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.008160]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.008207]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.008262]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.008316]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.008317]  ? __seccomp_filter+0x319/0x4d0
[87047.008319]  ? call_rcu+0xd5/0xa10
[87047.008322]  __x64_sys_ioctl+0x8d/0xd0
[87047.008324]  do_syscall_64+0x58/0x80
[87047.008327]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.008329]  ? do_syscall_64+0x67/0x80
[87047.008330]  ? do_syscall_64+0x67/0x80
[87047.008332]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.008334] RIP: 0033:0x7f250750d9bf
[87047.008335] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.008336] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.008338] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.008339] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.008340] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.008341] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.008342] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.008344]  </TASK>
[87047.008344] ---[ end trace 0000000000000000 ]---
[87047.008363] ------------[ cut here ]------------
[87047.008363] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.008419] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.008447]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.008480]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.008501] Unloaded tainted modules: bbswitch(O):2
[87047.008503] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.008505] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.008505] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.008561] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.008562] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.008563] RAX: ffff9d35157c2d80 RBX: 0000000000000000 RCX: 00000000804=
00039
[87047.008564] RDX: ffff9d35157c2d80 RSI: ffffe84e862a3440 RDI: 00000000000=
00000
[87047.008565] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00039
[87047.008566] R10: 0000000000000000 R11: ffff9d35ee794800 R12: 00000000000=
00022
[87047.008567] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35157=
c2d80
[87047.008568] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.008569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.008570] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.008571] Call Trace:
[87047.008572]  <TASK>
[87047.008573]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.008619]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.008666]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.008722]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.008774]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.008776]  ? __seccomp_filter+0x319/0x4d0
[87047.008778]  ? call_rcu+0xd5/0xa10
[87047.008781]  __x64_sys_ioctl+0x8d/0xd0
[87047.008783]  do_syscall_64+0x58/0x80
[87047.008786]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.008788]  ? do_syscall_64+0x67/0x80
[87047.008790]  ? do_syscall_64+0x67/0x80
[87047.008791]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.008793] RIP: 0033:0x7f250750d9bf
[87047.008794] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.008795] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.008797] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.008798] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.008799] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.008800] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.008801] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.008802]  </TASK>
[87047.008803] ---[ end trace 0000000000000000 ]---
[87047.008821] ------------[ cut here ]------------
[87047.008821] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.008877] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.008905]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.008938]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.008959] Unloaded tainted modules: bbswitch(O):2
[87047.008961] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.008963] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.008963] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.009019] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.009020] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.009021] RAX: ffff9d35157c22c0 RBX: 0000000000000000 RCX: 00000000804=
0003c
[87047.009022] RDX: ffff9d35157c22c0 RSI: ffffe84e8455f080 RDI: 00000000000=
00000
[87047.009023] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0003c
[87047.009024] R10: 0000000000000000 R11: ffff9d35ee794800 R12: 00000000000=
00023
[87047.009025] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35157=
c22c0
[87047.009026] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.009027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.009028] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.009029] Call Trace:
[87047.009030]  <TASK>
[87047.009031]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.009077]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.009124]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.009179]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.009232]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.009233]  ? __seccomp_filter+0x319/0x4d0
[87047.009235]  ? call_rcu+0xd5/0xa10
[87047.009238]  __x64_sys_ioctl+0x8d/0xd0
[87047.009240]  do_syscall_64+0x58/0x80
[87047.009243]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.009245]  ? do_syscall_64+0x67/0x80
[87047.009247]  ? do_syscall_64+0x67/0x80
[87047.009248]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.009250] RIP: 0033:0x7f250750d9bf
[87047.009251] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.009252] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.009254] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.009255] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.009256] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.009257] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.009258] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.009259]  </TASK>
[87047.009260] ---[ end trace 0000000000000000 ]---
[87047.009281] ------------[ cut here ]------------
[87047.009282] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.009338] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.009366]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.009398]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.009420] Unloaded tainted modules: bbswitch(O):2
[87047.009422] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.009423] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.009424] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.009480] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.009481] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.009482] RAX: ffff9d35157c2500 RBX: 0000000000000000 RCX: 00000000804=
0003b
[87047.009483] RDX: ffff9d35157c2500 RSI: ffffe84e8455f080 RDI: 00000000000=
00000
[87047.009484] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0003b
[87047.009485] R10: 0000000000000000 R11: ffff9d3508a12800 R12: 00000000000=
00024
[87047.009486] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35157=
c2500
[87047.009487] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.009488] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.009489] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.009490] Call Trace:
[87047.009490]  <TASK>
[87047.009491]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.009538]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.009584]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.009640]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.009693]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.009695]  ? __seccomp_filter+0x319/0x4d0
[87047.009696]  ? call_rcu+0xd5/0xa10
[87047.009699]  __x64_sys_ioctl+0x8d/0xd0
[87047.009702]  do_syscall_64+0x58/0x80
[87047.009704]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.009706]  ? do_syscall_64+0x67/0x80
[87047.009708]  ? do_syscall_64+0x67/0x80
[87047.009709]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.009711] RIP: 0033:0x7f250750d9bf
[87047.009712] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.009714] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.009715] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.009716] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.009717] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.009718] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.009719] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.009721]  </TASK>
[87047.009721] ---[ end trace 0000000000000000 ]---
[87047.009741] ------------[ cut here ]------------
[87047.009741] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.009797] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.009826]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.009858]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.009879] Unloaded tainted modules: bbswitch(O):2
[87047.009881] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.009883] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.009884] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.009939] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.009940] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.009942] RAX: ffff9d35157c2ec0 RBX: 0000000000000000 RCX: 00000000804=
0003a
[87047.009943] RDX: ffff9d35157c2ec0 RSI: ffffe84e8455f080 RDI: 00000000000=
00000
[87047.009943] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0003a
[87047.009944] R10: 0000000000000000 R11: ffff9d3520578000 R12: 00000000000=
00025
[87047.009945] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35157=
c2ec0
[87047.009946] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.009947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.009948] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.009949] Call Trace:
[87047.009950]  <TASK>
[87047.009951]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.009998]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.010044]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.010100]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.010152]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.010154]  ? __seccomp_filter+0x319/0x4d0
[87047.010155]  ? call_rcu+0xd5/0xa10
[87047.010159]  __x64_sys_ioctl+0x8d/0xd0
[87047.010161]  do_syscall_64+0x58/0x80
[87047.010163]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.010166]  ? do_syscall_64+0x67/0x80
[87047.010167]  ? do_syscall_64+0x67/0x80
[87047.010169]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.010171] RIP: 0033:0x7f250750d9bf
[87047.010172] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.010173] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.010174] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.010175] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.010176] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.010177] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.010178] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.010180]  </TASK>
[87047.010181] ---[ end trace 0000000000000000 ]---
[87047.010199] ------------[ cut here ]------------
[87047.010199] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.010256] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.010284]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.010316]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.010338] Unloaded tainted modules: bbswitch(O):2
[87047.010339] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.010341] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.010342] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.010397] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.010399] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.010400] RAX: ffff9d35f8a68a00 RBX: 0000000000000000 RCX: 00000000804=
00039
[87047.010401] RDX: ffff9d35f8a68a00 RSI: ffffe84e8455f080 RDI: 00000000000=
00000
[87047.010402] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00039
[87047.010403] R10: 0000000000000000 R11: ffff9d3520578000 R12: 00000000000=
00026
[87047.010403] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35f8a=
68a00
[87047.010405] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.010406] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.010407] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.010408] Call Trace:
[87047.010408]  <TASK>
[87047.010409]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.010456]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.010502]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.010590]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.010650]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.010652]  ? __seccomp_filter+0x319/0x4d0
[87047.010653]  ? call_rcu+0xd5/0xa10
[87047.010656]  __x64_sys_ioctl+0x8d/0xd0
[87047.010659]  do_syscall_64+0x58/0x80
[87047.010661]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.010664]  ? do_syscall_64+0x67/0x80
[87047.010665]  ? do_syscall_64+0x67/0x80
[87047.010667]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.010668] RIP: 0033:0x7f250750d9bf
[87047.010670] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.010671] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.010673] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.010674] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.010675] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.010676] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.010677] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.010678]  </TASK>
[87047.010679] ---[ end trace 0000000000000000 ]---
[87047.010699] ------------[ cut here ]------------
[87047.010700] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.010756] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.010785]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.010817]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.010839] Unloaded tainted modules: bbswitch(O):2
[87047.010841] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.010842] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.010843] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.010899] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.010900] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.010901] RAX: ffff9d35f8a68d40 RBX: 0000000000000000 RCX: 00000000804=
00035
[87047.010902] RDX: ffff9d35f8a68d40 RSI: ffffe84e87e29a00 RDI: 00000000000=
00000
[87047.010903] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00035
[87047.010904] R10: 0000000000000000 R11: ffff9d3520578000 R12: 00000000000=
00027
[87047.010905] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35f8a=
68d40
[87047.010906] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.010907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.010908] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.010909] Call Trace:
[87047.010909]  <TASK>
[87047.010910]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.010957]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.011003]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.011059]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.011112]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.011114]  ? __seccomp_filter+0x319/0x4d0
[87047.011115]  ? call_rcu+0xd5/0xa10
[87047.011118]  __x64_sys_ioctl+0x8d/0xd0
[87047.011121]  do_syscall_64+0x58/0x80
[87047.011123]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.011125]  ? do_syscall_64+0x67/0x80
[87047.011127]  ? do_syscall_64+0x67/0x80
[87047.011128]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.011130] RIP: 0033:0x7f250750d9bf
[87047.011131] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.011132] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.011134] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.011135] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.011136] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.011137] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.011138] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.011139]  </TASK>
[87047.011140] ---[ end trace 0000000000000000 ]---
[87047.011158] ------------[ cut here ]------------
[87047.011159] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.011215] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.011243]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.011276]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.011297] Unloaded tainted modules: bbswitch(O):2
[87047.011299] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.011301] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.011301] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.011357] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.011358] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.011359] RAX: ffff9d350312af80 RBX: 0000000000000000 RCX: 00000000804=
00034
[87047.011360] RDX: ffff9d350312af80 RSI: ffffe84e87e29a00 RDI: 00000000000=
00000
[87047.011361] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00034
[87047.011362] R10: 0000000000000000 R11: ffff9d3520578000 R12: 00000000000=
00028
[87047.011363] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35031=
2af80
[87047.011364] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.011365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.011366] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.011367] Call Trace:
[87047.011368]  <TASK>
[87047.011369]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.011415]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.011462]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.011517]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.011570]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.011572]  ? __seccomp_filter+0x319/0x4d0
[87047.011573]  ? call_rcu+0xd5/0xa10
[87047.011576]  __x64_sys_ioctl+0x8d/0xd0
[87047.011579]  do_syscall_64+0x58/0x80
[87047.011581]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.011584]  ? do_syscall_64+0x67/0x80
[87047.011585]  ? do_syscall_64+0x67/0x80
[87047.011587]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.011588] RIP: 0033:0x7f250750d9bf
[87047.011589] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.011591] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.011592] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.011593] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.011594] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.011595] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.011596] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.011598]  </TASK>
[87047.011598] ---[ end trace 0000000000000000 ]---
[87047.011616] ------------[ cut here ]------------
[87047.011617] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.011673] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.011701]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.011734]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.011756] Unloaded tainted modules: bbswitch(O):2
[87047.011757] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.011759] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.011760] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.011815] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.011817] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.011818] RAX: ffff9d360590e6c0 RBX: 0000000000000000 RCX: 00000000804=
0003c
[87047.011819] RDX: ffff9d360590e6c0 RSI: ffffe84e840c4a80 RDI: 00000000000=
00000
[87047.011820] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0003c
[87047.011821] R10: 0000000000000000 R11: ffff9d3520578000 R12: 00000000000=
00029
[87047.011821] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0e6c0
[87047.011822] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.011824] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.011825] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.011826] Call Trace:
[87047.011826]  <TASK>
[87047.011827]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.011874]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.011920]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.011976]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.012029]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.012031]  ? __seccomp_filter+0x319/0x4d0
[87047.012032]  ? call_rcu+0xd5/0xa10
[87047.012035]  __x64_sys_ioctl+0x8d/0xd0
[87047.012038]  do_syscall_64+0x58/0x80
[87047.012040]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.012042]  ? do_syscall_64+0x67/0x80
[87047.012044]  ? do_syscall_64+0x67/0x80
[87047.012045]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.012047] RIP: 0033:0x7f250750d9bf
[87047.012048] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.012049] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.012051] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.012052] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.012053] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.012053] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.012054] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.012056]  </TASK>
[87047.012057] ---[ end trace 0000000000000000 ]---
[87047.012074] ------------[ cut here ]------------
[87047.012075] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.012131] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.012159]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.012193]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.012214] Unloaded tainted modules: bbswitch(O):2
[87047.012215] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.012217] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.012218] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.012273] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.012275] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.012276] RAX: ffff9d360590e140 RBX: 0000000000000000 RCX: 00000000004=
00030
[87047.012277] RDX: ffff9d360590e140 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.012278] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
00030
[87047.012279] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
0002a
[87047.012279] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0e140
[87047.012280] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.012282] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.012283] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.012284] Call Trace:
[87047.012284]  <TASK>
[87047.012285]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.012332]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.012378]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.012434]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.012487]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.012489]  ? __seccomp_filter+0x319/0x4d0
[87047.012490]  ? call_rcu+0xd5/0xa10
[87047.012493]  __x64_sys_ioctl+0x8d/0xd0
[87047.012496]  do_syscall_64+0x58/0x80
[87047.012498]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.012500]  ? do_syscall_64+0x67/0x80
[87047.012502]  ? do_syscall_64+0x67/0x80
[87047.012503]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.012505] RIP: 0033:0x7f250750d9bf
[87047.012506] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.012507] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.012509] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.012510] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.012510] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.012511] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.012512] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.012514]  </TASK>
[87047.012514] ---[ end trace 0000000000000000 ]---
[87047.012532] ------------[ cut here ]------------
[87047.012533] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.012589] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.012617]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.012651]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.012673] Unloaded tainted modules: bbswitch(O):2
[87047.012674] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.012676] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.012677] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.012733] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.012734] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.012735] RAX: ffff9d360590ed40 RBX: 0000000000000000 RCX: 00000000004=
0002f
[87047.012736] RDX: ffff9d360590ed40 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.012737] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
0002f
[87047.012738] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
0002b
[87047.012738] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0ed40
[87047.012740] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.012741] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.012742] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.012743] Call Trace:
[87047.012743]  <TASK>
[87047.012744]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.012791]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.012837]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.012893]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.012946]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.012947]  ? __seccomp_filter+0x319/0x4d0
[87047.012949]  ? call_rcu+0xd5/0xa10
[87047.012952]  __x64_sys_ioctl+0x8d/0xd0
[87047.012954]  do_syscall_64+0x58/0x80
[87047.012957]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.012959]  ? do_syscall_64+0x67/0x80
[87047.012960]  ? do_syscall_64+0x67/0x80
[87047.012962]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.012964] RIP: 0033:0x7f250750d9bf
[87047.012965] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.012966] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.012967] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.012968] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.012969] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.012970] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.012971] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.012973]  </TASK>
[87047.012973] ---[ end trace 0000000000000000 ]---
[87047.012994] ------------[ cut here ]------------
[87047.012995] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.013051] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.013079]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.013112]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.013134] Unloaded tainted modules: bbswitch(O):2
[87047.013136] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.013138] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.013138] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.013194] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.013195] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.013196] RAX: ffff9d342918e200 RBX: 0000000000000000 RCX: 00000000004=
0002e
[87047.013197] RDX: ffff9d342918e200 RSI: ffffe84e88164380 RDI: 00000000000=
00000
[87047.013198] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000004=
0002e
[87047.013199] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
0002c
[87047.013200] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d34291=
8e200
[87047.013201] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.013202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.013203] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.013204] Call Trace:
[87047.013204]  <TASK>
[87047.013205]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.013252]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.013298]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.013354]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.013407]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.013409]  ? __seccomp_filter+0x319/0x4d0
[87047.013410]  ? call_rcu+0xd5/0xa10
[87047.013413]  __x64_sys_ioctl+0x8d/0xd0
[87047.013416]  do_syscall_64+0x58/0x80
[87047.013418]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.013420]  ? do_syscall_64+0x67/0x80
[87047.013422]  ? do_syscall_64+0x67/0x80
[87047.013423]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.013425] RIP: 0033:0x7f250750d9bf
[87047.013426] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.013427] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.013429] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.013430] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.013431] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.013431] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.013432] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.013434]  </TASK>
[87047.013435] ---[ end trace 0000000000000000 ]---
[87047.013467] ------------[ cut here ]------------
[87047.013468] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.013524] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.013552]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.013585]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.013606] Unloaded tainted modules: bbswitch(O):2
[87047.013608] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.013610] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.013611] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.013666] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.013667] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.013669] RAX: ffff9d35157c23c0 RBX: 0000000000000000 RCX: 000001332a3=
0c002
[87047.013670] RDX: ffff9d35157c23c0 RSI: 264406bceee5f789 RDI: 00000000000=
00000
[87047.013670] RBP: ffff9d34b0b4e960 R08: ffff9d34b0b4e960 R09: ffff9d35089=
5c078
[87047.013671] R10: 0000000000000000 R11: ffff9d35050ea800 R12: 00000000000=
00030
[87047.013672] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35157=
c23c0
[87047.013673] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.013674] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.013675] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.013676] Call Trace:
[87047.013677]  <TASK>
[87047.013678]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.013725]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.013771]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.013827]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.013880]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.013881]  ? __seccomp_filter+0x319/0x4d0
[87047.013883]  ? call_rcu+0xd5/0xa10
[87047.013886]  __x64_sys_ioctl+0x8d/0xd0
[87047.013888]  do_syscall_64+0x58/0x80
[87047.013891]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.013893]  ? do_syscall_64+0x67/0x80
[87047.013895]  ? do_syscall_64+0x67/0x80
[87047.013896]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.013898] RIP: 0033:0x7f250750d9bf
[87047.013899] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.013900] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.013902] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.013902] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.013903] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.013904] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.013905] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.013907]  </TASK>
[87047.013907] ---[ end trace 0000000000000000 ]---
[87047.013925] ------------[ cut here ]------------
[87047.013926] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.013982] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.014010]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.014043]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.014064] Unloaded tainted modules: bbswitch(O):2
[87047.014066] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.014068] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.014069] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.014124] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.014125] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.014127] RAX: ffff9d35f8a68b80 RBX: 0000000000000000 RCX: 00000000804=
00038
[87047.014128] RDX: ffff9d35f8a68b80 RSI: ffffe84e8455f080 RDI: 00000000000=
00000
[87047.014129] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00038
[87047.014129] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00031
[87047.014130] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35f8a=
68b80
[87047.014131] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.014133] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.014134] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.014135] Call Trace:
[87047.014135]  <TASK>
[87047.014136]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.014183]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.014229]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.014285]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.014338]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.014339]  ? __seccomp_filter+0x319/0x4d0
[87047.014341]  ? call_rcu+0xd5/0xa10
[87047.014344]  __x64_sys_ioctl+0x8d/0xd0
[87047.014346]  do_syscall_64+0x58/0x80
[87047.014349]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.014351]  ? do_syscall_64+0x67/0x80
[87047.014352]  ? do_syscall_64+0x67/0x80
[87047.014354]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.014355] RIP: 0033:0x7f250750d9bf
[87047.014357] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.014358] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.014359] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.014360] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.014361] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.014362] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.014363] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.014364]  </TASK>
[87047.014365] ---[ end trace 0000000000000000 ]---
[87047.014383] ------------[ cut here ]------------
[87047.014383] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.014440] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.014468]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.014501]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.014522] Unloaded tainted modules: bbswitch(O):2
[87047.014524] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.014526] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.014527] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.014609] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.014610] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.014611] RAX: ffff9d342918e740 RBX: 0000000000000000 RCX: 00000000804=
00033
[87047.014612] RDX: ffff9d342918e740 RSI: ffffe84e87e29a00 RDI: 00000000000=
00000
[87047.014613] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00033
[87047.014614] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00032
[87047.014615] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d34291=
8e740
[87047.014626] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.014627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.014629] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.014630] Call Trace:
[87047.014630]  <TASK>
[87047.014631]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.014682]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.014722]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.014773]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.014820]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.014822]  ? __seccomp_filter+0x319/0x4d0
[87047.014823]  ? call_rcu+0xd5/0xa10
[87047.014826]  __x64_sys_ioctl+0x8d/0xd0
[87047.014828]  do_syscall_64+0x58/0x80
[87047.014831]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.014833]  ? do_syscall_64+0x67/0x80
[87047.014834]  ? do_syscall_64+0x67/0x80
[87047.014836]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.014837] RIP: 0033:0x7f250750d9bf
[87047.014838] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.014840] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.014841] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.014842] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.014843] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.014844] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.014844] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.014846]  </TASK>
[87047.014847] ---[ end trace 0000000000000000 ]---
[87047.014870] ------------[ cut here ]------------
[87047.014871] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.014922] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.014950]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.014983]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.015005] Unloaded tainted modules: bbswitch(O):2
[87047.015006] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.015008] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.015009] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.015064] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.015066] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.015067] RAX: ffff9d35f8a68640 RBX: 0000000000000000 RCX: 00000000804=
0003a
[87047.015068] RDX: ffff9d35f8a68640 RSI: ffffe84e80a46380 RDI: 00000000000=
00000
[87047.015069] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
0003a
[87047.015070] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00033
[87047.015070] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35f8a=
68640
[87047.015071] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.015073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.015074] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.015075] Call Trace:
[87047.015075]  <TASK>
[87047.015076]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.015123]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.015169]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.015225]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.015278]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.015280]  ? __seccomp_filter+0x319/0x4d0
[87047.015281]  ? call_rcu+0xd5/0xa10
[87047.015284]  __x64_sys_ioctl+0x8d/0xd0
[87047.015287]  do_syscall_64+0x58/0x80
[87047.015289]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.015292]  ? do_syscall_64+0x67/0x80
[87047.015293]  ? do_syscall_64+0x67/0x80
[87047.015295]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.015296] RIP: 0033:0x7f250750d9bf
[87047.015297] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.015299] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.015300] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.015301] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.015302] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.015303] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.015303] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.015305]  </TASK>
[87047.015306] ---[ end trace 0000000000000000 ]---
[87047.015324] ------------[ cut here ]------------
[87047.015324] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.015381] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.015409]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.015442]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.015463] Unloaded tainted modules: bbswitch(O):2
[87047.015464] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.015466] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.015467] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.015522] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.015524] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.015525] RAX: ffff9d35f8a68ec0 RBX: 0000000000000000 RCX: 00000000804=
00032
[87047.015526] RDX: ffff9d35f8a68ec0 RSI: ffffe84e87e29a00 RDI: 00000000000=
00000
[87047.015527] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00032
[87047.015528] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00034
[87047.015529] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d35f8a=
68ec0
[87047.015530] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.015531] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.015532] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.015533] Call Trace:
[87047.015534]  <TASK>
[87047.015535]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.015584]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.015641]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.015702]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.015752]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.015753]  ? __seccomp_filter+0x319/0x4d0
[87047.015755]  ? call_rcu+0xd5/0xa10
[87047.015758]  __x64_sys_ioctl+0x8d/0xd0
[87047.015761]  do_syscall_64+0x58/0x80
[87047.015763]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.015765]  ? do_syscall_64+0x67/0x80
[87047.015767]  ? do_syscall_64+0x67/0x80
[87047.015769]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.015770] RIP: 0033:0x7f250750d9bf
[87047.015772] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.015773] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.015775] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.015776] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.015777] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.015778] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.015779] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.015780]  </TASK>
[87047.015781] ---[ end trace 0000000000000000 ]---
[87047.015805] ------------[ cut here ]------------
[87047.015806] WARNING: CPU: 2 PID: 1262 at fs/btrfs/qgroup.c:2756 btrfs_qg=
roup_account_extents+0x1ae/0x260 [btrfs]
[87047.015862] Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfco=
mm overlay nft_reject_ipv4 nft_masq nf_nat_h323 nf_conntrack_h323 nf_nat_pp=
tp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_=
sip nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6=
table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw ipta=
ble_security xfrm_user xfrm_algo af_packet ip_set nfnetlink twofish_generic=
 ebtable_filter twofish_avx_x86_64 ebtables twofish_x86_64_3way twofish_x86=
_64 twofish_common ip6table_filter ip6_tables serpent_avx2 iptable_filter s=
erpent_avx_x86_64 bpfilter serpent_sse2_x86_64 serpent_generic blowfish_gen=
eric blowfish_x86_64 blowfish_common cast5_avx_x86_64 qrtr cast5_generic ca=
st_common ecb
[87047.015890]  des_generic libdes camellia_generic camellia_aesni_avx2 cam=
ellia_aesni_avx_x86_64 cmac camellia_x86_64 algif_skcipher bnep xcbc md4 al=
gif_hash af_alg msr btusb btrtl btbcm btintel cdc_ether btmtk usbnet blueto=
oth mii uvcvideo ecdh_generic rmi_smbus rmi_core videobuf2_vmalloc videobuf=
2_memops videobuf2_v4l2 videobuf2_common videodev mc intel_rapl_msr intel_r=
apl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_ctl=
_led spi_nor mtd snd_hda_codec_realtek at24 snd_hda_codec_hdmi snd_hda_code=
c_generic iTCO_wdt spi_intel_platform mei_wdt mei_pxp intel_pmc_bxt mei_hdc=
p kvm iTCO_vendor_support spi_intel snd_hda_intel snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hda_codec irqbypass think_lmi i2c_i801 snd_hda_core pcspkr s=
nd_hwdep wmi_bmof firmware_attributes_class i2c_smbus lpc_ich mei_me pktcdv=
d snd_pcm mei thinkpad_acpi snd_timer ledtrig_audio i2c_dev platform_profil=
e rfkill thermal snd soundcore tiny_power_button button ac joydev fuse conf=
igfs
[87047.015923]  dmi_sysfs ip_tables x_tables dm_crypt essiv authenc trusted=
 asn1_encoder tee uas usb_storage crct10dif_pclmul crc32_pclmul polyval_clm=
ulni polyval_generic gf128mul i915 ghash_clmulni_intel sha512_ssse3 rtsx_pc=
i_sdmmc mmc_core xhci_pci xhci_pci_renesas xhci_hcd ehci_pci ehci_hcd aesni=
_intel drm_buddy crypto_simd cryptd drm_display_helper sr_mod cdrom usbcore=
 cec rc_core rtsx_pci ttm battery video wmi serio_raw btrfs blake2b_generic=
 libcrc32c crc32c_intel xor raid6_pq sg br_netfilter bridge stp llc dm_mult=
ipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[87047.015945] Unloaded tainted modules: bbswitch(O):2
[87047.015947] CPU: 2 PID: 1262 Comm: snapperd Tainted: G        W  O      =
 6.1.1-1-default #1 openSUSE Tumbleweed 03bfc877ed75e631266fff751b862a3c4fd=
1490e
[87047.015949] Hardware name: LENOVO 20AUS2JN00/20AUS2JN00, BIOS J4ET64WW(1=
.64) 05/29/2014
[87047.015950] RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
[87047.016005] Code: 85 c0 74 0f 48 8b 78 08 4c 89 fa 4c 89 ee e8 d9 54 f5 =
ff 65 ff 0d d2 0d 89 3f 0f 85 b8 fe ff ff 0f 1f 44 00 00 e9 ae fe ff ff <0f=
> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 1b 71 ff
[87047.016006] RSP: 0018:ffffbebb4da27ca0 EFLAGS: 00010246
[87047.016008] RAX: ffff9d360590e900 RBX: 0000000000000000 RCX: 00000000804=
00031
[87047.016009] RDX: ffff9d360590e900 RSI: ffffe84e87e29a00 RDI: 00000000000=
00000
[87047.016010] RBP: ffff9d34b0b4e960 R08: 0000000000000000 R09: 00000000804=
00031
[87047.016011] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00035
[87047.016011] R13: ffff9d350895c000 R14: ffff9d35107119c0 R15: ffff9d36059=
0e900
[87047.016013] FS:  00007f2506d4b6c0(0000) GS:ffff9d3694880000(0000) knlGS:=
0000000000000000
[87047.016014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87047.016015] CR2: 00007fc614101d74 CR3: 0000000103176004 CR4: 00000000001=
706e0
[87047.016016] Call Trace:
[87047.016017]  <TASK>
[87047.016018]  btrfs_commit_transaction+0x30c/0xb40 [btrfs c8c8418dedbc5b3=
28d9ff38d6a65c4e4e45be0e5]
[87047.016064]  ? start_transaction+0xc3/0x5b0 [btrfs c8c8418dedbc5b328d9ff=
38d6a65c4e4e45be0e5]
[87047.016111]  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c8c8418dedbc5b328d9ff3=
8d6a65c4e4e45be0e5]
[87047.016166]  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[87047.016219]  ? __rseq_handle_notify_resume+0xa9/0x4a0
[87047.016221]  ? __seccomp_filter+0x319/0x4d0
[87047.016222]  ? call_rcu+0xd5/0xa10
[87047.016226]  __x64_sys_ioctl+0x8d/0xd0
[87047.016228]  do_syscall_64+0x58/0x80
[87047.016230]  ? syscall_exit_to_user_mode+0x17/0x40
[87047.016233]  ? do_syscall_64+0x67/0x80
[87047.016234]  ? do_syscall_64+0x67/0x80
[87047.016236]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[87047.016237] RIP: 0033:0x7f250750d9bf
[87047.016239] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[87047.016240] RSP: 002b:00007f2506d4a760 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[87047.016242] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f25075=
0d9bf
[87047.016243] RDX: 00007f2506d4a7c0 RSI: 000000004040942c RDI: 00000000000=
00007
[87047.016244] RBP: 00007f2506d4a7c0 R08: 0000000000000000 R09: 00000000000=
00000
[87047.016244] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f2506d=
4a8e0
[87047.016245] R13: 00007f25079d4fd0 R14: 00007f2506d4aa30 R15: 00007f2506d=
4aa60
[87047.016247]  </TASK>
[87047.016248] ---[ end trace 0000000000000000 ]---
[87099.561186] BTRFS info (device dm-0): qgroup scan paused
[87153.471176] sd 4:0:0:0: [sda] Synchronizing SCSI cache
[87153.474337] sd 4:0:0:0: [sda] Stopping disk
[87160.329904] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[87160.332375] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[87160.332699] ata5.00: supports DRM functions and may not be fully accessi=
ble
[87160.335731] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[87160.335996] ata5.00: supports DRM functions and may not be fully accessi=
ble
[87160.338731] ata5.00: configured for UDMA/133
[87160.348900] sd 4:0:0:0: [sda] Starting disk
[87160.349136] ata5.00: Enabling discard_zeroes_data
[87163.034542] systemd-journald[619]: Data hash table of /var/log/journal/7=
f882ab05c7f4c0d9bdef2f824867aff/system.journal has a fill level at 75.1 (27=
32 of 3640 items, 2097152 file size, 767 bytes per hash table item), sugges=
ting rotation.
[87163.034550] systemd-journald[619]: /var/log/journal/7f882ab05c7f4c0d9bde=
f2f824867aff/system.journal: Journal header limits reached or header out-of=
-date, rotating.
[87261.958017] sd 4:0:0:0: [sda] Synchronizing SCSI cache
[87261.961278] sd 4:0:0:0: [sda] Stopping disk
[87267.852160] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[87267.854931] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[87267.855372] ata5.00: supports DRM functions and may not be fully accessi=
ble
[87267.859246] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK)=
 filtered out
[87267.859568] ata5.00: supports DRM functions and may not be fully accessi=
ble
[87267.863160] ata5.00: configured for UDMA/133

--MP_/o0mP.bKZvjMaQaJAj+s_ruX--

--Sig_/FO9KcyRm+w5iCiMciGRXHR2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmOwzLUACgkQNasLKJxd
slj61hAAq29yR08i4q6tR+5DUd7yJ6iGzK//zf5Onv9i5gnQIimH0V+B3bmati50
xyEIhLrPKcotk9GsPKBT9h3HU8v1VS+8SDDnoXe4uyNNAATeSBxDMANF3e8V53Vg
OZcvNEHSlnxnhdRcDA8rVkyLzq3pW21Hyfz38aphZW9xaKQo3/STap0Q7hVjJeO5
YCXZ3dqK3Dqs9yRD0ObmgO+ag8ujTsk91/9SdaGXpQW1wdgYd2RUPcs0UAo2aORK
cwHixshftOH8Qm66H16xMAKCok3SsVTenzCIxdcHs7DZyEBRWurnPYstwBCgOBvO
i/qvcYL0xa2qk+COd/xO0Bik6kvCxQBcAXHPNWczX+y974FRJIRQtCed+lklHuze
SJQcWZ6VsEd7pTQS/PRoWKgN8XNBKczOIwLfIkQpYlijIx4tgYBineHT6QdCKbrh
y1xKTv5lvsne+c5bcHJpJ4YjMMEIy0h9U4teXGvkoYVmgF4TV+ry6IDzF9F+iItt
iaFoXgyOb4RJoCZtcMZFsKD5b1eEjlec0HtnVbq4YQGySuxNvB4hu1Z5dcMfbj/Y
0EDwoKxGyGpwHBJ3sVDAp0/tTNbeQmG2mu7PSo5RZGALN/QYlCXjMbeu1un4UcWR
sFM2/C6IPaNRckmmVOFFYdDhb/s+UhXHSHlx1vOV3coMUpYJg0Q=
=smXp
-----END PGP SIGNATURE-----

--Sig_/FO9KcyRm+w5iCiMciGRXHR2--
