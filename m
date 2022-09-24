Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D45E8F7B
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Sep 2022 21:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiIXTMy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Sep 2022 15:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiIXTMx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Sep 2022 15:12:53 -0400
X-Greylist: delayed 1528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Sep 2022 12:12:52 PDT
Received: from campbell-lange.net (campbell-lange.net [178.79.140.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3608C42AE1
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Sep 2022 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=campbell-lange.net; s=it; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DYLXl0HeIu82flgVSoWvMt7hXQbC6XBNgxnqYVfiLVI=; b=ComMVqGuWq9ujTlg7nC78KUEOp
        TF6NXfs0ybSZ3RcOB+2l3m42+7QpI1Ser6FqUQAgOaKhCHflOv/NoiM5FMBstibl5IyL7fwGRjM57
        BLUsvM12A7zVLz1nHzSs/RPaTLd4/vDrGzTv5ZplxpITqklawoRgv1Uz5w+/i/66fUOs=;
Received: from 232.178.125.91.dyn.plus.net ([91.125.178.232] helo=rory-t470s)
        by campbell-lange.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rory@campbell-lange.net>)
        id 1ocABP-00GPjl-6B
        for linux-btrfs@vger.kernel.org; Sat, 24 Sep 2022 18:47:23 +0000
Received: from rory by rory-t470s with local (Exim 4.94.2)
        (envelope-from <rory@rory-t470s>)
        id 1ocABO-005KOF-2t
        for linux-btrfs@vger.kernel.org; Sat, 24 Sep 2022 19:47:22 +0100
Date:   Sat, 24 Sep 2022 19:47:22 +0100
From:   Rory Campbell-Lange <rory@campbell-lange.net>
To:     linux-btrfs@vger.kernel.org
Subject: Failure to run backup on nvme usb disk
Message-ID: <Yy9QuiHB4agnbYuF@campbell-lange.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I periodically run backup to an nvme disk connected to my machine on usb3. =
It just failed twice with the error below.

My machine:
5.10.0-18-amd64 #1 SMP Debian 5.10.140-1 (2022-09-02) x86_64 GNU/Linux

btrfs version etc
ii  btrfs-progs  5.10.1-2   amd64  Checksumming Copy on Write Filesystem ut=
ilities

Any thoughts? I can find a similar "btrfs_assert_delayed_root_empty" error =
in https://bugzilla.redhat.com/show_bug.cgi?id=3D1170905 from 2014.

Rory

Sep 24 19:39:30 rory-t470s kernel: [338264.688534] ------------[ cut here ]=
------------
Sep 24 19:39:30 rory-t470s kernel: [338264.688712] WARNING: CPU: 3 PID: 126=
8625 at fs/btrfs/delayed-inode.c:1397 btrfs_assert_delayed_root_empty+0x70/=
0x90 [btrfs]
Sep 24 19:39:30 rory-t470s kernel: [338264.688718] Modules linked in: tcp_d=
iag udp_diag inet_diag cdc_ether usbnet mii ctr ccm rfcomm nft_chain_nat xt=
_MASQUERADE nf_nat nf_conntrack_netlink xfrm_user xfrm_algo br_netfilter br=
idge stp llc cmac algif_hash algif_skcipher af_alg bnep btusb btrtl btbcm b=
tintel bluetooth uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2=
 jitterentropy_rng videobuf2_common drbg videodev ansi_cprng ecdh_generic m=
c ecc sg overlay snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_gen=
eric intel_rapl_msr intel_rapl_common intel_pmc_core_pltdrv snd_soc_skl int=
el_pmc_core binfmt_misc snd_soc_hdac_hda snd_hda_ext_core snd_soc_sst_ipc s=
nd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi snd_hda_intel snd_inte=
l_dspcfg nls_ascii joydev x86_pkg_temp_thermal intel_powerclamp soundwire_i=
ntel coretemp kvm_intel mei_wdt mei_hdcp nls_cp437 soundwire_generic_alloca=
tion vfat fat kvm snd_soc_core irqbypass iwlmvm ext4 rapl snd_compress soun=
dwire_cadence intel_cstate crc16 mac80211 snd_hda_codec mbcache i915
Sep 24 19:39:30 rory-t470s kernel: [338264.689059]  intel_uncore jbd2 evdev=
 libarc4 snd_hda_core serio_raw efi_pstore iwlwifi pcspkr snd_hwdep soundwi=
re_bus wmi_bmof nf_log_ipv6 iTCO_wdt intel_pmc_bxt snd_pcm intel_wmi_thunde=
rbolt rmi_smbus iTCO_vendor_support ip6t_REJECT rmi_core snd_timer nf_rejec=
t_ipv6 watchdog cfg80211 xt_hl ip6_tables drm_kms_helper mei_me ucsi_acpi t=
ypec_ucsi intel_xhci_usb_role_switch ip6t_rt thinkpad_acpi typec mei roles =
cec intel_pch_thermal nvram ledtrig_audio i2c_algo_bit snd soundcore nf_log=
_ipv4 rfkill nf_log_common ipt_REJECT nf_reject_ipv4 ac xt_LOG acpi_pad nft=
_limit button xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack nf_d=
efrag_ipv6 nf_defrag_ipv4 nft_compat nft_counter drm msr nf_tables parport_=
pc ppdev nfnetlink lp fuse parport sunrpc configfs efivarfs ip_tables x_tab=
les autofs4 btrfs blake2b_generic xor raid6_pq libcrc32c crc32c_generic sd_=
mod uas usb_storage scsi_mod dm_crypt dm_mod crc32_pclmul crc32c_intel xhci=
_pci ghash_clmulni_intel xhci_hcd nvme e1000e usbcore nvme_core
Sep 24 19:39:30 rory-t470s kernel: [338264.689400]  t10_pi crc_t10dif crct1=
0dif_generic aesni_intel i2c_i801 libaes ptp crypto_simd crct10dif_pclmul p=
smouse cryptd glue_helper pps_core i2c_smbus usb_common crct10dif_common wm=
i battery video
Sep 24 19:39:30 rory-t470s kernel: [338264.689481] CPU: 3 PID: 1268625 Comm=
: btrfs-transacti Tainted: G        W         5.10.0-18-amd64 #1 Debian 5.1=
0.140-1
Sep 24 19:39:30 rory-t470s kernel: [338264.689488] Hardware name: LENOVO 20=
HGS6XY01/20HGS6XY01, BIOS N1WET66W (1.45 ) 01/27/2022
Sep 24 19:39:30 rory-t470s kernel: [338264.689650] RIP: 0010:btrfs_assert_d=
elayed_root_empty+0x70/0x90 [btrfs]
Sep 24 19:39:30 rory-t470s kernel: [338264.689663] Code: c2 01 78 1a 48 89 =
ef c6 07 00 0f 1f 40 00 48 85 db 75 17 5b 5d c3 cc cc cc cc 31 db eb e6 be =
01 00 00 00 e8 d2 20 89 dd eb da <0f> 0b 5b 5d c3 cc cc cc cc be 02 00 00 0=
0 e8 bd 20 89 dd eb c5 66
Sep 24 19:39:30 rory-t470s kernel: [338264.689672] RSP: 0018:ffffad1b09263e=
40 EFLAGS: 00010282
Sep 24 19:39:30 rory-t470s kernel: [338264.689683] RAX: ffff9a12c84e63c0 RB=
X: ffff9a12c84e63a8 RCX: 0000000000000000
Sep 24 19:39:30 rory-t470s kernel: [338264.689689] RDX: 000000000000000d RS=
I: ffff9a12f4399018 RDI: ffff9a12f4399000
Sep 24 19:39:30 rory-t470s kernel: [338264.689696] RBP: ffff9a12f4399000 R0=
8: ffff9a12f4399018 R09: ffff9a12f4399018
Sep 24 19:39:30 rory-t470s kernel: [338264.689703] R10: 0000000000000c00 R1=
1: 0000000000000000 R12: ffff9a1303b0a000
Sep 24 19:39:30 rory-t470s kernel: [338264.689730] R13: ffff9a1303b0a520 R1=
4: ffff9a1303b0a550 R15: 0000000000000000
Sep 24 19:39:30 rory-t470s kernel: [338264.689740] FS:  0000000000000000(00=
00) GS:ffff9a1516580000(0000) knlGS:0000000000000000
Sep 24 19:39:30 rory-t470s kernel: [338264.689748] CS:  0010 DS: 0000 ES: 0=
000 CR0: 0000000080050033
Sep 24 19:39:30 rory-t470s kernel: [338264.689756] CR2: 00007fe623dc5000 CR=
3: 00000001d2c0a005 CR4: 00000000003706e0
Sep 24 19:39:30 rory-t470s kernel: [338264.689764] DR0: 0000000000000000 DR=
1: 0000000000000000 DR2: 0000000000000000
Sep 24 19:39:30 rory-t470s kernel: [338264.689770] DR3: 0000000000000000 DR=
6: 00000000fffe0ff0 DR7: 0000000000000400
Sep 24 19:39:30 rory-t470s kernel: [338264.689776] Call Trace:
Sep 24 19:39:30 rory-t470s kernel: [338264.689915]  btrfs_cleanup_transacti=
on.isra.0+0x381/0x590 [btrfs]
Sep 24 19:39:30 rory-t470s kernel: [338264.689935]  ? ttwu_do_wakeup+0x17/0=
x140
Sep 24 19:39:30 rory-t470s kernel: [338264.690062]  transaction_kthread+0x1=
60/0x180 [btrfs]
Sep 24 19:39:30 rory-t470s kernel: [338264.690182]  ? btrfs_cleanup_transac=
tion.isra.0+0x590/0x590 [btrfs]
Sep 24 19:39:30 rory-t470s kernel: [338264.690199]  kthread+0x118/0x140
Sep 24 19:39:30 rory-t470s kernel: [338264.690213]  ? __kthread_bind_mask+0=
x60/0x60
Sep 24 19:39:30 rory-t470s kernel: [338264.690228]  ret_from_fork+0x1f/0x30
Sep 24 19:39:30 rory-t470s kernel: [338264.690249] ---[ end trace 6f9ff3b4a=
0c48a03 ]---

