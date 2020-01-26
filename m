Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF46E149BD3
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2020 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAZQJo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 11:09:44 -0500
Received: from mail-40132.protonmail.ch ([185.70.40.132]:24944 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZQJo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 11:09:44 -0500
Date:   Sun, 26 Jan 2020 16:09:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1580054981;
        bh=AuIN17E1G24kfDPNpkIhi98RThlY6qYqiavIO4rREjY=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=f98qWD1XGWajJsbfzBqKPtni7Z+S81Ue1mDNGjL8Y/F9GEVa1VZXRQrQiF6xjQjbx
         Ak54srHKzL72PuKeypdp6/5NozWbNTF2xj046WRtaYoY0OhomqSVQVKuIpJZAxm/He
         PhB+Yrp1Llvp96Hx+pb8Jmp+5S28Wnv6zc1XNY1g=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Raviu <raviu@protonmail.com>
Reply-To: Raviu <raviu@protonmail.com>
Subject: Re: fstrim segmentation fault and btrfs crash on vanilla 5.4.14
Message-ID: <7tcxgXvMR83f-yW7IN3dKq8NWJETNoAMGo_0GShBJMjR_p_N4vE3nDMPkECoqBiOFDCEFsBM4IZ08Lkk0yT5-H81FkHAV-xEThPkbey0Z40=@protonmail.com>
In-Reply-To: <izW2WNyvy1dEDweBICizKnd2KDwDiDyY2EYQr4YCwk7pkuIpthx-JRn65MPBde00ND6V0_Lh8mW0kZwzDiLDv25pUYWxkskWNJnVP0kgdMA=@protonmail.com>
References: <izW2WNyvy1dEDweBICizKnd2KDwDiDyY2EYQr4YCwk7pkuIpthx-JRn65MPBde00ND6V0_Lh8mW0kZwzDiLDv25pUYWxkskWNJnVP0kgdMA=@protonmail.com>
Feedback-ID: s2UDJFOuCQB5skd1w8rqWlDOlD5NAbNnTyErhCdMqDC7lQ_PsWqTjpdH2pOmUWgBaEipj53UTbJWo1jzNMb12A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM
        shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is dmesg output:

[  237.525947] assertion failed: prev, in ../fs/btrfs/extent_io.c:1595
[  237.525984] ------------[ cut here ]------------
[  237.525985] kernel BUG at ../fs/btrfs/ctree.h:3117!
[  237.525992] invalid opcode: 0000 [#1] SMP PTI
[  237.525998] CPU: 4 PID: 4423 Comm: fstrim Tainted: G     U     OE     5.=
4.14-8-vanilla #1
[  237.526001] Hardware name: ASUSTeK COMPUTER INC.
[  237.526044] RIP: 0010:assfail.constprop.58+0x18/0x1a [btrfs]
[  237.526048] Code: 0b 0f 1f 44 00 00 48 8b 3d 15 9e 07 00 e9 70 20 ce e2 =
89 f1 48 c7 c2 ae 27 77 c0 48 89 fe 48 c7 c7 20 87 77 c0 e8 56 c5 ba e2 <0f=
> 0b 0f 1f 44 00 00 e8 9c 1b bc e2 48 8b 3d 7d 9f 07 00 e8 40 20
[  237.526053] RSP: 0018:ffffae2cc2befc20 EFLAGS: 00010282
[  237.526056] RAX: 0000000000000037 RBX: 0000000000000021 RCX: 00000000000=
00000
[  237.526059] RDX: 0000000000000000 RSI: ffff94221eb19a18 RDI: ffff94221eb=
19a18
[  237.526062] RBP: ffff942216ce6e00 R08: 0000000000000403 R09: 00000000000=
00001
[  237.526064] R10: ffffae2cc2befc38 R11: 0000000000000001 R12: ffffae2cc2b=
efca0
[  237.526067] R13: ffff942216ce6e24 R14: ffffae2cc2befc98 R15: 00000000001=
00000
[  237.526071] FS:  00007fa1b8087fc0(0000) GS:ffff94221eb00000(0000) knlGS:=
0000000000000000
[  237.526074] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  237.526076] CR2: 000032eed3b5a000 CR3: 00000007c33bc002 CR4: 00000000003=
606e0
[  237.526079] Call Trace:
[  237.526120]  find_first_clear_extent_bit+0x13d/0x150 [btrfs]
[  237.526148]  btrfs_trim_fs+0x211/0x3f0 [btrfs]
[  237.526184]  btrfs_ioctl_fitrim+0x103/0x170 [btrfs]
[  237.526219]  btrfs_ioctl+0x129a/0x2ed0 [btrfs]
[  237.526227]  ? filemap_map_pages+0x190/0x3d0
[  237.526232]  ? do_filp_open+0xaf/0x110
[  237.526238]  ? _copy_to_user+0x22/0x30
[  237.526242]  ? cp_new_stat+0x150/0x180
[  237.526247]  ? do_vfs_ioctl+0xa4/0x640
[  237.526278]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
[  237.526283]  do_vfs_ioctl+0xa4/0x640
[  237.526288]  ? __do_sys_newfstat+0x3c/0x60
[  237.526292]  ksys_ioctl+0x70/0x80
[  237.526297]  __x64_sys_ioctl+0x16/0x20
[  237.526303]  do_syscall_64+0x5a/0x1c0
[  237.526310]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  237.526315] RIP: 0033:0x7fa1b797d587
[  237.526319] Code: b3 66 90 48 8b 05 11 49 2c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 48 2c 00 f7 d8 64 89 01 48
[  237.526325] RSP: 002b:00007ffc4b977f98 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[  237.526330] RAX: ffffffffffffffda RBX: 00007ffc4b978100 RCX: 00007fa1b79=
7d587
[  237.526333] RDX: 00007ffc4b977fa0 RSI: 00000000c0185879 RDI: 00000000000=
00003
[  237.526337] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000000=
00000
[  237.526340] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc4b9=
78ede
[  237.526344] R13: 00007ffc4b978ede R14: 0000000000000000 R15: 00007fa1b80=
87f38
[  237.526348] Modules linked in: loop tun ccm fuse af_packet vboxnetadp(OE=
) vboxnetflt(OE) scsi_transport_iscsi vboxdrv(OE) dmi_sysfs snd_hda_codec_h=
dmi snd_hda_codec_realtek intel_rapl_msr snd_hda_codec_generic intel_rapl_c=
ommon ledtrig_audio snd_hda_intel snd_intel_nhlt ip6t_REJECT nf_reject_ipv6=
 iwlmvm snd_hda_codec ip6t_rt snd_hda_core snd_hwdep msr mac80211 ipt_REJEC=
T nf_reject_ipv4 iTCO_wdt x86_pkg_temp_thermal intel_powerclamp libarc4 snd=
_pcm xt_multiport mei_hdcp hid_multitouch iTCO_vendor_support coretemp nls_=
iso8859_1 kvm_intel nls_cp437 snd_timer vfat kvm iwlwifi pcspkr irqbypass s=
nd asus_nb_wmi wmi_bmof fat xt_limit r8169 soundcore i2c_i801 mei_me realte=
k rtsx_pci_ms joydev xt_hl cfg80211 libphy memstick intel_lpss_pci intel_pc=
h_thermal intel_lpss mei idma64 xt_tcpudp thermal xt_addrtype xt_conntrack =
ac asus_wireless acpi_pad ip6table_filter ip6_tables nf_conntrack_netbios_n=
s nf_conntrack_broadcast nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack nf=
_defrag_ipv6 nf_defrag_ipv4
[  237.526378]  iptable_filter ip_tables x_tables bpfilter btrfs libcrc32c =
xor raid6_pq dm_crypt algif_skcipher af_alg hid_asus asus_wmi sparse_keymap=
 rfkill hid_generic usbhid crct10dif_pclmul crc32_pclmul i915 crc32c_intel =
ghash_clmulni_intel rtsx_pci_sdmmc mmc_core mxm_wmi xhci_pci xhci_hcd i2c_a=
lgo_bit aesni_intel drm_kms_helper glue_helper syscopyarea sysfillrect sysi=
mgblt crypto_simd fb_sys_fops cryptd drm serio_raw rtsx_pci usbcore i2c_hid=
 wmi battery video button sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc s=
csi_dh_alua efivarfs
[  237.526431] ---[ end trace c78dad92fa11be80 ]---
[  237.526467] RIP: 0010:assfail.constprop.58+0x18/0x1a [btrfs]
[  237.526472] Code: 0b 0f 1f 44 00 00 48 8b 3d 15 9e 07 00 e9 70 20 ce e2 =
89 f1 48 c7 c2 ae 27 77 c0 48 89 fe 48 c7 c7 20 87 77 c0 e8 56 c5 ba e2 <0f=
> 0b 0f 1f 44 00 00 e8 9c 1b bc e2 48 8b 3d 7d 9f 07 00 e8 40 20
[  237.526477] RSP: 0018:ffffae2cc2befc20 EFLAGS: 00010282
[  237.526481] RAX: 0000000000000037 RBX: 0000000000000021 RCX: 00000000000=
00000
[  237.526485] RDX: 0000000000000000 RSI: ffff94221eb19a18 RDI: ffff94221eb=
19a18
[  237.526489] RBP: ffff942216ce6e00 R08: 0000000000000403 R09: 00000000000=
00001
[  237.526492] R10: ffffae2cc2befc38 R11: 0000000000000001 R12: ffffae2cc2b=
efca0
[  237.526496] R13: ffff942216ce6e24 R14: ffffae2cc2befc98 R15: 00000000001=
00000
[  237.526500] FS:  00007fa1b8087fc0(0000) GS:ffff94221eb00000(0000) knlGS:=
0000000000000000
[  237.526504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  237.526507] CR2: 000032eed3b5a000 CR3: 00000007c33bc002 CR4: 00000000003=
606e0


Here is the btrfs check --readonly output:
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 434638807040 bytes used, no error found
total csum bytes: 327446132
total tree bytes: 1604894720
total fs tree bytes: 1104494592
total extent tree bytes: 144556032
btree space waste bytes: 237406069
file data blocks allocated: 5616596910080
 referenced 823187898368


Posted for archiving as recommended.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Sunday, January 26, 2020 5:54 PM, Raviu <raviu@protonmail.com> wrote:

> Hi,
> I've two btrfs filesystems on the same nvme disk / and /home.
> I'm running fstrim -va as cronjob daily.
> Today, once fstrim run, apps writing to /home got frozen. Reviewing dmesg=
 show a bug message related to fstrim and btrfs.
> Rebooting the system- actually forcibly as it couldn't umount /home - and=
 running fstrim manualy on each filesystem; on / it worked fine, on /home I=
 got the same error.
> Here are the dmesg errors:
>
> http://cwillu.com:8080/38.132.118.66/1
>
> Here is the output of btrfs check --readonly with home unmounted:
>
> http://cwillu.com:8080/38.132.118.66/2
>
> I've run scrub whith home mounted it said, `Error summary: no errors foun=
d`
>
> The fstrim kernel error is reproducible on my machine, it occurs every ti=
me I run it on my home. So I can test a fix, just hope it doesn't cause dat=
a loss.


