Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F91D6E07DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 09:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDMHgr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMHgq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 03:36:46 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306A5FFE
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 00:36:43 -0700 (PDT)
Date:   Thu, 13 Apr 2023 07:36:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=fn74wxisubh7rloeucqmoe4hvi.protonmail; t=1681371398; x=1681630598;
        bh=RBg09xlWTw/8rJUj0izsN8IK0K+lMdAA93cTP/Fpons=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=MfxadxDi/3NVsfapOKPO757bRc20b3Rg4wsl6bf3gnYP6+AlAgDDdRssF0ZPZKUK3
         rXmPbqHxh+5HV+dnQvmAMGALu03aB0ubm4YfgmVJUJO5cIDMGHdIMm+dQg5EwdlDWu
         oTZWOxIhBvhH1uVGj9oAVl65AWYJcrVgXFQgZQ7xMN34D/EEtOK52FhmXbZ6zSULfA
         x46l9YEK3Eh86hhFfK4rm5nKQEldRXRlS+WcMT83EJDTR7RxkJXT3V3z3o/+kembD2
         rBKdQQbN0IOFpqbPPCeBqOzX4X0UKgitVYxEtqySVEKSUwOsFCjIoTveWp55ULVDnf
         iImtouCEj14iQ==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   broetchenrackete <broetchenrackete@proton.me>
Subject: Replacing missing disk failed and btrfs check segfault
Message-ID: <du-jaadAoKpS7xY4d18VMXdy9RxcG4rBRfO0RxC8bIcfIQLQTZv0xa1LBU5BsJSEKvZrVMvyftfo07AMo3eRytpSL6qE3uFvqIfyaaviT8s=@proton.me>
Feedback-ID: 71840784:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,
I have the feeling that my Mails from my Gmail account get flagged as spam.=
 If not I apologies for the duplicate message.

Anyway, forgot to mention kernel and btrfs-progs versions:

[bluemond@BlueQ ~]$ uname -aLinux BlueQ 6.2.10-arch1-1 #1 SMP PREEMPT_DYNAM=
IC Fri, 07 Apr 2023 02:10:43 +0000 x86_64 GNU/Linux
[bluemond@BlueQ ~]$ btrfs --version
btrfs-progs v6.2.2

And here are my original messages:

Hi all,

I have a raid5 array where one disk failed completely so I wanted to replac=
e it with btrfs replace. After ~50% and ~24h it failed. I tried it twice al=
ready, the first time i got a Kernel warning, the second time it failed wit=
hout a Kernel warning.

I used the following to replace the missing disk:
sudo btrfs replace start 5 /dev/sdf1 /mnt/btrfsrepair/

This is the kernel log from the first try (there are quiet a bit of more er=
rors preceeding this for both log-snippets):

Apr 10 11:32:58 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14921002348544 for dev <missing disk>
Apr 10 11:32:59 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14921110454272 for dev <missing disk>
Apr 10 11:33:00 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14921191104512 for dev <missing disk>
Apr 10 11:33:01 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14921375891456 for dev <missing disk>
Apr 10 11:33:03 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14921493860352 for dev <missing disk>
Apr 10 11:33:05 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14921741586432 for dev <missing disk>
Apr 10 11:33:37 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14926675795968 for dev <missing disk>
Apr 10 11:33:44 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14927684403200 for dev <missing disk>
Apr 10 11:33:46 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14928193597440 for dev <missing disk>
Apr 10 11:33:53 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14929553514496 for dev <missing disk>
Apr 10 11:34:12 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14932636286976 for dev <missing disk>
Apr 10 11:34:13 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14933068861440 for dev <missing disk>
Apr 10 11:34:13 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14933090471936 for dev <missing disk>
Apr 10 11:34:15 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14933359788032 for dev <missing disk>
Apr 10 11:34:16 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14933477769216 for dev <missing disk>
Apr 10 11:34:17 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14933715648512 for dev <missing disk>
Apr 10 11:34:20 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14934220931072 for dev <missing disk>
Apr 10 11:34:26 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14935264264192 for dev <missing disk>
Apr 10 11:34:39 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild =
valid logical 14937330614272 for dev <missing disk>
Apr 10 11:53:20 BlueQ kernel: BTRFS error (device sdf1): parent transid ver=
ify failed on logical 20295892680704 mirror 2 wanted 668185 found 666739
Apr 10 11:53:20 BlueQ kernel: BTRFS error (device sdf1): level verify faile=
d on logical 20295892713472 mirror 2 wanted 0 found 1
Apr 10 11:53:36 BlueQ kernel: BTRFS error (device sdf1): level verify faile=
d on logical 20295892713472 mirror 2 wanted 0 found 1
Apr 10 11:53:36 BlueQ kernel: BTRFS error (device sdf1): bad tree block sta=
rt, mirror 3 want 20295892713472 have 0
Apr 10 11:53:36 BlueQ kernel: BTRFS error (device sdf1): btrfs_scrub_dev(<m=
issing disk>, 5, /dev/sdf1) failed -5
Apr 10 11:53:36 BlueQ kernel: ------------[ cut here ]------------
Apr 10 11:53:36 BlueQ kernel: WARNING: CPU: 3 PID: 20126 at fs/btrfs/dev-re=
place.c:1239 btrfs_dev_replace_kthread+0x16f/0x190 [btrfs]
Apr 10 11:53:36 BlueQ kernel: Modules linked in: tls tcp_diag udp_diag inet=
_diag xt_nat xt_tcpudp veth nf_conntrack_netlink nfnetlink xt_addrtype wire=
guard curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64 l=
ibcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel tun overlay xt_MAS=
QUERADE iptable_nat nf_nat xt_conntrack zram nf_conntrack nf_defrag_ipv6 nc=
t6775 nf_defrag_ipv4 nct6775_core iptable_filter hwmon_vid iwlmvm intel_rap=
l_msr xxhash_generic intel_rapl_common mac80211 edac_mce_amd kvm_amd libarc=
4 kvm btusb irqbypass crct10dif_pclmul btrtl crc32_pclmul btbcm polyval_clm=
ulni iwlwifi polyval_generic nls_iso8859_1 btintel gf128mul ghash_clmulni_i=
ntel vfat btmtk sha512_ssse3 fat r8169 aesni_intel eeprom bluetooth cfg8021=
1 realtek crypto_simd cryptd mdio_devres sp5100_tco ecdh_generic wmi_bmof b=
trfs ccp rapl pcspkr i2c_piix4 libphy rfkill blake2b_generic xor wmi gpio_a=
mdpt raid6_pq ryzen_smu(OE) libcrc32c gpio_generic acpi_cpufreq mac_hid zen=
power(OE) dm_multipath hfsplus hfs cdrom
Apr 10 11:53:36 BlueQ kernel: =C2=A0drivetemp sg br_netfilter bridge stp ll=
c crypto_user fuse loop dm_mod bpf_preload ip_tables x_tables ext4 crc32c_g=
eneric crc16 mbcache jbd2 mpt3sas nvme raid_class nvme_core crc32c_intel xh=
ci_pci scsi_transport_sas xhci_pci_renesas nvme_common bcache
Apr 10 11:53:36 BlueQ kernel: CPU: 3 PID: 20126 Comm: btrfs-devrepl Tainted=
: G =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OE =C2=A0 =C2=A0 =C2=A06.2.10-arch1-=
1 #1 3b64a9154b84a23b8badf9e10678249884a952c6
Apr 10 11:53:36 BlueQ kernel: Hardware name: Micro-Star International Co., =
Ltd. MS-7A40/B450I GAMING PLUS MAX WIFI (MS-7A40), BIOS B.40 02/08/2021
Apr 10 11:53:36 BlueQ kernel: RIP: 0010:btrfs_dev_replace_kthread+0x16f/0x1=
90 [btrfs]
Apr 10 11:53:36 BlueQ kernel: Code: 0a 00 00 48 89 d1 31 d2 48 c1 e9 04 48 =
f7 f1 48 ba cd cc cc cc cc cc cc cc 48 f7 e2 48 89 d0 48 c1 e8 03 89 c5 e9 =
c7 fe ff ff <0f> 0b 48 89 df e8 67 11 fb ff 31 c0 5b 5d e9 32 3e 4c f6 49 c=
7 c0
Apr 10 11:53:36 BlueQ kernel: RSP: 0018:ffffbc589f987f08 EFLAGS: 00010206
Apr 10 11:53:36 BlueQ kernel: RAX: 00000000fffffffb RBX: ffff9bf63d7c1000 R=
CX: 0000000000000000
Apr 10 11:53:36 BlueQ kernel: RDX: 0000000000000001 RSI: 0000000000000246 R=
DI: ffff9bf63d7c1ab0
Apr 10 11:53:36 BlueQ kernel: RBP: 000000000000000f R08: ffff9bf63d7c1b88 R=
09: ffffbc589f987df8
Apr 10 11:53:36 BlueQ kernel: R10: 0000000000000001 R11: 0000000000000110 R=
12: ffff9bf680d7a040
Apr 10 11:53:36 BlueQ kernel: R13: ffff9bf6a30e6900 R14: ffff9bf63d7c1000 R=
15: ffffffffc0a8ef10
Apr 10 11:53:36 BlueQ kernel: FS: =C2=A00000000000000000(0000) GS:ffff9bf8a=
eec0000(0000) knlGS:0000000000000000
Apr 10 11:53:36 BlueQ kernel: CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Apr 10 11:53:36 BlueQ kernel: CR2: 00007f66c8b9fef4 CR3: 00000002dec10000 C=
R4: 00000000003506e0
Apr 10 11:53:36 BlueQ kernel: Call Trace:
Apr 10 11:53:36 BlueQ kernel: =C2=A0<TASK>
Apr 10 11:53:36 BlueQ kernel: =C2=A0kthread+0xde/0x110
Apr 10 11:53:36 BlueQ kernel: =C2=A0? __pfx_kthread+0x10/0x10
Apr 10 11:53:36 BlueQ kernel: =C2=A0ret_from_fork+0x2c/0x50
Apr 10 11:53:36 BlueQ kernel: =C2=A0</TASK>
Apr 10 11:53:36 BlueQ kernel: ---[ end trace 0000000000000000 ]---


And this from the second try:

Apr 11 16:20:57 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14921375891456 for dev <missing disk>
Apr 11 16:20:59 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14921493860352 for dev <missing disk>
Apr 11 16:21:00 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14921741586432 for dev <missing disk>
Apr 11 16:21:35 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14926675795968 for dev <missing disk>
Apr 11 16:21:41 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14927684403200 for dev <missing disk>
Apr 11 16:21:42 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14928193597440 for dev <missing disk>
Apr 11 16:21:52 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14929553514496 for dev <missing disk>
Apr 11 16:22:16 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14932636286976 for dev <missing disk>
Apr 11 16:22:17 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14933359788032 for dev <missing disk>
Apr 11 16:22:19 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14933715648512 for dev <missing disk>
Apr 11 16:22:21 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14934220931072 for dev <missing disk>
Apr 11 16:22:23 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14933477769216 for dev <missing disk>
Apr 11 16:22:23 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14933068861440 for dev <missing disk>
Apr 11 16:22:23 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14933090471936 for dev <missing disk>
Apr 11 16:22:29 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14935264264192 for dev <missing disk>
Apr 11 16:22:42 BlueQ kernel: BTRFS error (device sde1): failed to rebuild =
valid logical 14937330614272 for dev <missing disk>
Apr 11 16:41:13 BlueQ kernel: BTRFS error (device sde1): parent transid ver=
ify failed on logical 20295892680704 mirror 2 wanted 668185 found 666739
Apr 11 16:41:13 BlueQ kernel: BTRFS error (device sde1): level verify faile=
d on logical 20295892713472 mirror 2 wanted 0 found 1
Apr 11 16:41:32 BlueQ kernel: BTRFS error (device sde1): level verify faile=
d on logical 20295892713472 mirror 2 wanted 0 found 1
Apr 11 16:41:32 BlueQ kernel: BTRFS error (device sde1): bad tree block sta=
rt, mirror 3 want 20295892713472 have 0
Apr 11 16:41:32 BlueQ kernel: BTRFS error (device sde1): btrfs_scrub_dev(<m=
issing disk>, 5, /dev/sdf1) failed -5



Some info about the array:

[bluemond@BlueQ ~]$ sudo btrfs fi us /mnt/btrfsrepair/
Overall:
=C2=A0 =C2=A0 Device size: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A054.58TiB
=C2=A0 =C2=A0 Device allocated: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 34.66TiB
=C2=A0 =C2=A0 Device unallocated: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 19.92T=
iB
=C2=A0 =C2=A0 Device missing: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A07.28TiB
=C2=A0 =C2=A0 Device slack: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 10.50KiB
=C2=A0 =C2=A0 Used: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 34.49TiB
=C2=A0 =C2=A0 Free (estimated): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 15.79TiB =C2=A0 =C2=A0 =C2=A0(min: 10.09TiB)
=C2=A0 =C2=A0 Free (statfs, df): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 9.92TiB
=C2=A0 =C2=A0 Data ratio: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.27
=C2=A0 =C2=A0 Metadata ratio: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 2.00
=C2=A0 =C2=A0 Global reserve: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0512.00MiB =C2=A0 =C2=A0 =C2=A0(used: 0.00B)
=C2=A0 =C2=A0 Multiple profiles: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0no

Data,RAID5: Size:26.85TiB, Used:26.72TiB (99.52%)
=C2=A0 =C2=A0/dev/sde1 =C2=A0 =C2=A0 =C2=A0 7.12TiB
=C2=A0 =C2=A0/dev/sda1 =C2=A0 =C2=A0 =C2=A0 7.12TiB
=C2=A0 =C2=A0/dev/sdb1 =C2=A0 =C2=A0 =C2=A0 2.94TiB
=C2=A0 =C2=A0/dev/sdd1 =C2=A0 =C2=A0 =C2=A0 2.94TiB
=C2=A0 =C2=A0missing =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.86TiB
=C2=A0 =C2=A0/dev/sdg1 =C2=A0 =C2=A0 =C2=A0 7.18TiB

Metadata,RAID1: Size:259.00GiB, Used:257.92GiB (99.58%)
=C2=A0 =C2=A0/dev/sde1 =C2=A0 =C2=A0 163.00GiB
=C2=A0 =C2=A0/dev/sda1 =C2=A0 =C2=A0 164.00GiB
=C2=A0 =C2=A0/dev/sdb1 =C2=A0 =C2=A0 =C2=A0 5.00GiB
=C2=A0 =C2=A0/dev/sdd1 =C2=A0 =C2=A0 =C2=A0 5.00GiB
=C2=A0 =C2=A0missing =C2=A0 =C2=A0 =C2=A0 =C2=A086.00GiB
=C2=A0 =C2=A0/dev/sdg1 =C2=A0 =C2=A0 =C2=A095.00GiB

System,RAID1: Size:40.00MiB, Used:1.75MiB (4.38%)
=C2=A0 =C2=A0/dev/sdb1 =C2=A0 =C2=A0 =C2=A032.00MiB
=C2=A0 =C2=A0/dev/sdd1 =C2=A0 =C2=A0 =C2=A032.00MiB
=C2=A0 =C2=A0missing =C2=A0 =C2=A0 =C2=A0 =C2=A0 8.00MiB
=C2=A0 =C2=A0/dev/sdg1 =C2=A0 =C2=A0 =C2=A0 8.00MiB

Unallocated:
=C2=A0 =C2=A0/dev/sde1 =C2=A0 =C2=A0 =C2=A0 1.00MiB
=C2=A0 =C2=A0/dev/sda1 =C2=A0 =C2=A0 =C2=A0 1.00MiB
=C2=A0 =C2=A0/dev/sdb1 =C2=A0 =C2=A0 =C2=A0 9.79TiB
=C2=A0 =C2=A0/dev/sdd1 =C2=A0 =C2=A0 =C2=A0 9.79TiB
=C2=A0 =C2=A0missing =C2=A0 =C2=A0 =C2=A0 342.00GiB
=C2=A0 =C2=A0/dev/sdg1 =C2=A0 =C2=A0 =C2=A0 1.00MiB
[bluemond@BlueQ ~]$ sudo btrfs fi sh
Label: 'BlueButter' =C2=A0uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 6 FS bytes used 26.97TiB
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 7.28TiB used 7.28TiB =
path /dev/sde1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A02 size 7.28TiB used 7.28TiB =
path /dev/sda1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A03 size 12.73TiB used 2.94TiB=
 path /dev/sdb1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A04 size 12.73TiB used 2.94TiB=
 path /dev/sdd1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A05 size 0 used 0 path =C2=
=A0MISSING
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A06 size 7.28TiB used 7.28TiB =
path /dev/sdg1


I don't care if I have to delete a few files (all really important stuff is=
 backed up already) but I would hate to lose the whole array. What should I=
 do?








So I tried to find the files responsible for the last errors in the log wit=
h inspect-internal but no avail...

I then tried to run a btrfs check (readonly) and it segfaulted...

This is the end of the btrfs check log:
parent transid verify failed on 15959631003648 wanted 671918 found 671864
extent back ref already exists for 20295519666176 parent 0 root 4220
extent back ref already exists for 20295519682560 parent 0 root 4220
extent back ref already exists for 20295519698944 parent 0 root 4220
extent back ref already exists for 20295520452608 parent 0 root 4636
extent back ref already exists for 20295520468992 parent 0 root 4636
extent back ref already exists for 20295521206272 parent 30423438540800 roo=
t 0
extent back ref already exists for 20295521222656 parent 30423438540800 roo=
t 0
extent back ref already exists for 20295521828864 parent 0 root 4636
extent back ref already exists for 20295522369536 parent 0 root 4220
parent transid verify failed on 16079759130624 wanted 671918 found 671896 i=
tems checked)
parent transid verify failed on 16200175910912 wanted 671918 found 671896
parent transid verify failed on 16325838782464 wanted 671918 found 671896
extent back ref already exists for 16569929728000 parent 0 root 463688657 i=
tems checked)
extent back ref already exists for 363828461568 parent 0 root 46361788780 i=
tems checked)
extent back ref already exists for 363828936704 parent 0 root 4636
extent back ref already exists for 466136793088 parent 0 root 4636
extent back ref already exists for 466136809472 parent 0 root 4636
Segmentation fault
[bluemond@BlueQ ~]$


And this the dmesg log:
[Wed Apr 12 16:34:35 2023] btrfs[205859]: segfault at 10 ip 0000563e56d478f=
d sp 00007ffff78fc130 error 4 in btrfs[563e56ce4000+a3000] likely on CPU 5 =
(core 5, socket 0)
[Wed Apr 12 16:34:35 2023] Code: 00 4c 8d 47 01 0f 1f 84 00 00 00 00 00 48 =
8b 43 20 48 8b 4b 28 48 01 c1 48 39 cf 0f 83 bc 00 00 00 4c 39 c0 0f 83 e3 =
00 00 00 <48> 8b 42 10 48 3d ff 00 00 00 0f 86 e3 00 00 00 48 3b 7a 18 0f 8=
4


Not sure what to try next tbh.... Any suggestions?

