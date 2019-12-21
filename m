Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA2E128A29
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 16:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLUPZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 10:25:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:54871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfLUPZP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 10:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576941911;
        bh=mAdBDzZ503kp4b9jTqp6Bvmf/lRQckAokshZ7BXVTSU=;
        h=X-UI-Sender-Class:Date:From:To:In-Reply-To:References:Subject;
        b=MuYu/hCMg6FGZ+MJt7w/MY+amWNiHnfFOb6UyF7M4mDb4kkHeAwkQ6qJc5AqAWafh
         b6vnWG1+P110obRTUE11HMFe++wvk0PcUSXKFeEagNTOBDljMhn+ekhWIjaBn5khuU
         xxqxkfbRL4y9bp+b8grpd99i7SHNudH6Fho8ipZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.1.10.1] ([91.17.252.101]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1hiiO51LIw-010PLC for
 <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2019 16:25:11 +0100
Date:   Sat, 21 Dec 2019 16:25:10 +0100
From:   jollemeyer@gmx.de
To:     linux-btrfs@vger.kernel.org
Message-ID: <7bad72c2-6591-47d3-a93b-ee32611018bc.maildroid@localhost>
In-Reply-To: <a29a69bd-d3f3-44d2-af62-bb0b7a364ba5.maildroid@localhost>
References: <af9d16c9-2bf5-46fa-a146-84c4f8f6cc31.maildroid@localhost>
 <c14a643b-c2b1-b3f2-01e3-2a51ab14f603@gmx.com>
 <a29a69bd-d3f3-44d2-af62-bb0b7a364ba5.maildroid@localhost>
Subject: Re: Re: read time block corruption on root partition, Not booting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: MailDroid/4.91 (Android 8.0.0)
User-Agent: MailDroid/4.91 (Android 8.0.0)
X-Provags-ID: V03:K1:pzKMlIQguLzPgwdFhXgDi00BoKRvPX/psQvlkJEBwZuvksjlblr
 r39vyKjKuppwQbrheUYwA1QOnUaPyRfGrIRH3gQ1iCoBifL4kwdN6Tmeya1xRFNzwIsJrlD
 Z6halIdMub696+pt8DOl++z2jpnmSb2izSuHChkeN7AJyIS/gQZs0IH/+QwqrCOvV6bTWHa
 ybqNnQP07CmtaMM4r5VAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GWO04/S6JsA=:DFzqcOlIZecqh/N4R1FJE0
 xcbW4h6puOf9ur7ILa/HscVGr8NEf6DLiJ0PdDw1zB1WGhQZOXeq7k9qS9QmEiZvfVmc75s60
 nOioY16LuizYiwmz8rbMqX7/9Zlx50ME+F+oKcjldJuvKFWVEXuFt+U6PRnZFj1YXkMMZah/X
 /2NToXELXxKFnf9L03vsafFJU1rq1uLBcJfP3SlgeeNiHoE6D8EMnEXJSDrCVaUj1Yx46L/OY
 7L/JXE6A699PyKFDUZyVj5pNcIBOaKqnQV0fpCub8jhb4xuqHTeVVeuQDlNkhYivN34NFD9rZ
 w0ieesvWYBaq1Q23jy1Ln3b/hPgU/rhGI/fFsRsFT4HTasgoTqmKZTbWSltPPt02vEgOLeICe
 OlHqwQQ85vbX57gzEAlShn/0YHYhipkNeY/9Uz6dmwPgBTQCWOmbLRohC6Ma9IIoZLX69bvYu
 1Lw6UdPLUqK4S6KLBQ+ikHHs0PjfqUcOtolgTgD1wo27zPiD8czRBvflRh9daiW+364WqVG3c
 fCvYdP+9JVrm8iWgPAA7OzBJx9wLiDWqfcGrxUxxAvbwGC5vb8NOquNSJ0iZSAzDuIyUGuCuj
 BbAgKT0cqayg5JoISzCRbRylZUPqQbviik1h2GlYZlEA8wtoCtG9qW6tQ4GWMkzwMuvUYr94a
 QyHR1JZT1K9RBcBqsC6K/aMLzDQNZIA22JHjpBPf7838ta9WRGFwaVeC2BrVaztYkr4pVwkqR
 LmWuiKwO8uo6W7ouN1XAfLMSMihlN6wuIUsLYPVsvnvAXjP7HFPeVhqaCQSTZQN38KNkiTmnI
 nGorsJRGUbxRvMKxaMVYkSUEDVyNb3HEExG8w3f63N7lRvoK67JSBgz1Z/9zXwQmh9hTYSANl
 b5T4U312obhPX2OV4VMbFdTGQYn6TsEAue7TiG1MboDwGsvwDDaBxsljouNrFyu4Mm3+xrhD0
 YvGmKfGYGjdp1tgAZxQHZpT9xC/V+kj1a3QmlvZb920EGGM+JxC39C0oW3R55uM5B4C5wd6uf
 doX/rdMRjrD8MqO9JNJeYW57CNNOJoOUMGb4TNjDTE0u3SHTiBo01T5RmQYjcBikxrygwQ7fN
 nE6lGHrhaSGticKBktwMRFDTpkjxWQZWOnxcTszZraugEJ1VDwuvw5+lGhVd4pKKvmXCOQu38
 vlN3yU+I+wbUqAUOaIK2lyHXLZMJxy01FY6nmyIPgAw/HMqNrh8hxmiytEYQtqtgxD/IKCnwz
 dxpFXILkmtzv2/vimnW8jvIYmSIs3yvDRePaZjmFiqhmb161acxEYjZ+mcDM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Qu,

the output is as follows:
#btrfs ins dump-tree - b 2089035464704 /dev/sda1
btrfs-progs v5.4
No mapping for 2089035464704 - 2089035481088
Couldn't map the block 2089035464704
Couldn't map the block 2089035464704
Bad tree Block 2089035464704, bytenr mismatch, want 2089035464704, have 0
ERROR: failed to read tree Block 2089035464704

Many thanks.

J=C3=B6rg=20

-----Original Message-----
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: jollemeyer@gmx.de, linux-btrfs@vger.kernel.org
Sent: Sa., 21 Dez. 2019 15:19
Subject: Re: read time block corruption on root partition, Not booting



On 2019/12/21 =E4=B8=8B=E5=8D=8810:06, jollemeyer@gmx.de wrote:
> Dear all,
> =20
> on my BTRFS root partition (/dev/sda), a "read time block corruption" was=
 detected. The system refuses to boot.
> Current kernel is 5.4.2-1-Manjaro.
> =20
> Systemd's journalctl generated the following output:
> =20
> Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt leaf=
: block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4096 =
invalid extent refs, have 1 expect >=3D inline 1048577
> Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D2089035=
464704 read time tree block corruption detected
> Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt leaf=
: block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4096 =
invalid extent refs, have 1 expect >=3D inline 1048577
> Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D2089035=
464704 read time tree block corruption detected
> Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt leaf=
: block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4096 =
invalid extent refs, have 1 expect >=3D inline 1048577
> Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D2089035=
464704 read time tree block corruption detected
> Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt leaf=
: block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4096 =
invalid extent refs, have 1 expect >=3D inline 1048577
> Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D2089035=
464704 read time tree block corruption detected
> Dez 21 10:46:41 Phoenix kernel: BTRFS: error (device sda) in btrfs_replay=
_log:2293: errno=3D-5 IO failure (Failed to recover log tree)

"btrfs ins dump-tree -b 2089035464704 /dev/sda" output please.

Thanks,
Qu

> Dez 21 10:46:41 Phoenix kernel: ------------[ cut here ]------------
> Dez 21 10:46:41 Phoenix kernel: WARNING: CPU: 7 PID: 621 at fs/btrfs/bloc=
k-group.c:132 btrfs_put_block_group+0x42/0x50 [btrfs]
> Dez 21 10:46:41 Phoenix kernel: Modules linked in: usblp snd_hda_codec_hd=
mi intel_rapl_msr snd_hda_codec_realtek intel_rapl_common snd_hda_codec_gen=
eric ext4 ledtrig_audio x86_pkg_temp_thermal intel_powerclamp coretemp crc1=
6 kvm_intel mbcache i915 jbd2 kvm snd_hda_intel snd_intel_nhlt i2c_algo_bit=
 irqbypass drm_kms_helper snd_hda_codec crct10dif_pclmul crc32_pclmul snd_h=
da_core mousedev ghash_clmulni_intel drm snd_hwdep snd_pcm aesni_intel cryp=
to_simd cryptd glue_helper mei_hdcp intel_cstate iTCO_wdt intel_gtt snd_tim=
er iTCO_vendor_support intel_uncore mei_me intel_rapl_perf input_leds agpga=
rt i2c_i801 snd syscopyarea mei sysfillrect lpc_ich r8168(OE) sysimgblt sou=
ndcore fb_sys_fops evdev ie31200_edac mac_hid vboxpci(OE) vboxnetflt(OE) vb=
oxnetadp(OE) vboxdrv(OE) sg crypto_user ip_tables x_tables hid_generic usbh=
id hid btrfs libcrc32c crc32c_generic xor uas usb_storage raid6_pq sr_mod c=
drom sd_mod ahci serio_raw atkbd libahci libps2 libata xhci_pci scsi_mod xh=
ci_hcd ehci_pci crc32c_intel ehci_hcd i8042 serio
> Dez 21 10:46:41 Phoenix kernel: CPU: 7 PID: 621 Comm: mount Tainted: G   =
        OE     5.4.2-1-MANJARO #1
> Dez 21 10:46:41 Phoenix kernel: Hardware name: To Be Filled By O.E.M. To =
Be Filled By O.E.M./H77 Pro4/MVP, BIOS P1.40 09/04/2012
> Dez 21 10:46:41 Phoenix kernel: RIP: 0010:btrfs_put_block_group+0x42/0x50=
 [btrfs]
> Dez 21 10:46:41 Phoenix kernel: Code: 2d 48 83 7d 50 00 75 22 48 8b 85 e8=
 01 00 00 48 85 c0 75 1e 48 8b bd d8 00 00 00 e8 a8 08 66 d9 48 89 ef 5d e9=
 9f 08 66 d9 c3 <0f> 0b eb da 0f 0b eb cf 0f 0b eb de 66 90 0f 1f 44 00 00 =
31 d2 e9
> Dez 21 10:46:41 Phoenix kernel: RSP: 0018:ffffa95900f47ae8 EFLAGS: 000102=
06
> Dez 21 10:46:41 Phoenix kernel: RAX: 0000000000000001 RBX: ffff8a1eb7bfe0=
e0 RCX: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: RDX: 0000000000000001 RSI: ffff8a1ecf5f02=
50 RDI: ffff8a1eb7bfe000
> Dez 21 10:46:41 Phoenix kernel: RBP: ffff8a1eb7bfe000 R08: 00000000000000=
00 R09: 0000000000000001
> Dez 21 10:46:41 Phoenix kernel: R10: 00000000003f6c00 R11: 00000000000000=
00 R12: ffff8a1ec81b0080
> Dez 21 10:46:41 Phoenix kernel: R13: ffff8a1ec81b0090 R14: ffff8a1eb7bfe0=
00 R15: dead000000000100
> Dez 21 10:46:41 Phoenix kernel: FS:  00007f77003d7500(0000) GS:ffff8a1ecf=
5c0000(0000) knlGS:0000000000000000
> Dez 21 10:46:41 Phoenix kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> Dez 21 10:46:41 Phoenix kernel: CR2: 0000559652364460 CR3: 00000003fbaec0=
05 CR4: 00000000001606e0
> Dez 21 10:46:41 Phoenix kernel: Call Trace:
> Dez 21 10:46:41 Phoenix kernel:  btrfs_free_block_groups+0x11c/0x260 [btr=
fs]
> Dez 21 10:46:41 Phoenix kernel:  open_ctree+0x187a/0x1bc0 [btrfs]
> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount_root+0x57b/0x670 [btrfs]
> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
> Dez 21 10:46:41 Phoenix kernel:  fc_mount+0xe/0x30
> Dez 21 10:46:41 Phoenix kernel:  vfs_kern_mount.part.0+0x71/0x90
> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount+0x18e/0x930 [btrfs]
> Dez 21 10:46:41 Phoenix kernel:  ? filename_lookup+0x105/0x190
> Dez 21 10:46:41 Phoenix kernel:  ? legacy_get_tree+0x27/0x40
> Dez 21 10:46:41 Phoenix kernel:  ? btrfs_remount+0x4d0/0x4d0 [btrfs]
> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
> Dez 21 10:46:41 Phoenix kernel:  do_mount+0x77a/0xa30
> Dez 21 10:46:41 Phoenix kernel:  ksys_mount+0x7e/0xc0
> Dez 21 10:46:41 Phoenix kernel:  __x64_sys_mount+0x21/0x30
> Dez 21 10:46:41 Phoenix kernel:  do_syscall_64+0x4e/0x140
> Dez 21 10:46:41 Phoenix kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Dez 21 10:46:41 Phoenix kernel: RIP: 0033:0x7f770055ae4e
> Dez 21 10:46:41 Phoenix kernel: Code: 48 8b 0d 35 00 0c 00 f7 d8 64 89 01=
 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5=
 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 f7 d8 64 =
89 01 48
> Dez 21 10:46:41 Phoenix kernel: RSP: 002b:00007ffedb3135c8 EFLAGS: 000002=
46 ORIG_RAX: 00000000000000a5
> Dez 21 10:46:41 Phoenix kernel: RAX: ffffffffffffffda RBX: 00007f77006812=
04 RCX: 00007f770055ae4e
> Dez 21 10:46:41 Phoenix kernel: RDX: 000055d9705f5650 RSI: 000055d9705f56=
f0 RDI: 000055d9705f73d0
> Dez 21 10:46:41 Phoenix kernel: RBP: 000055d9705f5440 R08: 000055d9705f56=
70 R09: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: R10: 0000000000000000 R11: 00000000000002=
46 R12: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: R13: 000055d9705f73d0 R14: 000055d9705f56=
50 R15: 000055d9705f5440
> Dez 21 10:46:41 Phoenix kernel: ---[ end trace 71465d442bb4c509 ]---
> Dez 21 10:46:41 Phoenix kernel: ------------[ cut here ]------------
> Dez 21 10:46:41 Phoenix kernel: WARNING: CPU: 0 PID: 621 at fs/btrfs/bloc=
k-group.c:3166 btrfs_free_block_groups+0x1ea/0x260 [btrfs]
> Dez 21 10:46:41 Phoenix kernel: Modules linked in: usblp snd_hda_codec_hd=
mi intel_rapl_msr snd_hda_codec_realtek intel_rapl_common snd_hda_codec_gen=
eric ext4 ledtrig_audio x86_pkg_temp_thermal intel_powerclamp coretemp crc1=
6 kvm_intel mbcache i915 jbd2 kvm snd_hda_intel snd_intel_nhlt i2c_algo_bit=
 irqbypass drm_kms_helper snd_hda_codec crct10dif_pclmul crc32_pclmul snd_h=
da_core mousedev ghash_clmulni_intel drm snd_hwdep snd_pcm aesni_intel cryp=
to_simd cryptd glue_helper mei_hdcp intel_cstate iTCO_wdt intel_gtt snd_tim=
er iTCO_vendor_support intel_uncore mei_me intel_rapl_perf input_leds agpga=
rt i2c_i801 snd syscopyarea mei sysfillrect lpc_ich r8168(OE) sysimgblt sou=
ndcore fb_sys_fops evdev ie31200_edac mac_hid vboxpci(OE) vboxnetflt(OE) vb=
oxnetadp(OE) vboxdrv(OE) sg crypto_user ip_tables x_tables hid_generic usbh=
id hid btrfs libcrc32c crc32c_generic xor uas usb_storage raid6_pq sr_mod c=
drom sd_mod ahci serio_raw atkbd libahci libps2 libata xhci_pci scsi_mod xh=
ci_hcd ehci_pci crc32c_intel ehci_hcd i8042 serio
> Dez 21 10:46:41 Phoenix kernel: CPU: 0 PID: 621 Comm: mount Tainted: G   =
     W  OE     5.4.2-1-MANJARO #1
> Dez 21 10:46:41 Phoenix kernel: Hardware name: To Be Filled By O.E.M. To =
Be Filled By O.E.M./H77 Pro4/MVP, BIOS P1.40 09/04/2012
> Dez 21 10:46:41 Phoenix kernel: RIP: 0010:btrfs_free_block_groups+0x1ea/0=
x260 [btrfs]
> Dez 21 10:46:41 Phoenix kernel: Code: 49 bd 22 01 00 00 00 00 ad de e8 51=
 13 d1 d9 e8 0c d3 4e d9 48 89 ef e8 64 9b ff ff 48 8b 85 00 10 00 00 49 39=
 c4 75 3c eb 5f <0f> 0b 31 c9 31 d2 4c 89 fe 48 89 ef e8 55 85 ff ff 48 8b =
43 08 48
> Dez 21 10:46:41 Phoenix kernel: RSP: 0018:ffffa95900f47af8 EFLAGS: 000102=
06
> Dez 21 10:46:41 Phoenix kernel: RAX: ffff8a1eca367488 RBX: ffff8a1eca3674=
88 RCX: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: RDX: 0000000000000001 RSI: ffff8a1eca3642=
00 RDI: 00000000ffffffff
> Dez 21 10:46:41 Phoenix kernel: RBP: ffff8a1ec81b0000 R08: 00000000000000=
00 R09: 0000000020000000
> Dez 21 10:46:41 Phoenix kernel: R10: 0000000000000005 R11: ffffffffffd5ce=
37 R12: ffff8a1ec81b1000
> Dez 21 10:46:41 Phoenix kernel: R13: dead000000000122 R14: dead0000000001=
00 R15: ffff8a1eca367400
> Dez 21 10:46:41 Phoenix kernel: FS:  00007f77003d7500(0000) GS:ffff8a1ecf=
400000(0000) knlGS:0000000000000000
> Dez 21 10:46:41 Phoenix kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> Dez 21 10:46:41 Phoenix kernel: CR2: 0000559006e55d68 CR3: 00000003fbaec0=
06 CR4: 00000000001606f0
> Dez 21 10:46:41 Phoenix kernel: Call Trace:
> Dez 21 10:46:41 Phoenix kernel:  open_ctree+0x187a/0x1bc0 [btrfs]
> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount_root+0x57b/0x670 [btrfs]
> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
> Dez 21 10:46:41 Phoenix kernel:  fc_mount+0xe/0x30
> Dez 21 10:46:41 Phoenix kernel:  vfs_kern_mount.part.0+0x71/0x90
> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount+0x18e/0x930 [btrfs]
> Dez 21 10:46:41 Phoenix kernel:  ? filename_lookup+0x105/0x190
> Dez 21 10:46:41 Phoenix kernel:  ? legacy_get_tree+0x27/0x40
> Dez 21 10:46:41 Phoenix kernel:  ? btrfs_remount+0x4d0/0x4d0 [btrfs]
> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
> Dez 21 10:46:41 Phoenix kernel:  do_mount+0x77a/0xa30
> Dez 21 10:46:41 Phoenix kernel:  ksys_mount+0x7e/0xc0
> Dez 21 10:46:41 Phoenix kernel:  __x64_sys_mount+0x21/0x30
> Dez 21 10:46:41 Phoenix kernel:  do_syscall_64+0x4e/0x140
> Dez 21 10:46:41 Phoenix kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Dez 21 10:46:41 Phoenix kernel: RIP: 0033:0x7f770055ae4e
> Dez 21 10:46:41 Phoenix kernel: Code: 48 8b 0d 35 00 0c 00 f7 d8 64 89 01=
 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5=
 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 f7 d8 64 =
89 01 48
> Dez 21 10:46:41 Phoenix kernel: RSP: 002b:00007ffedb3135c8 EFLAGS: 000002=
46 ORIG_RAX: 00000000000000a5
> Dez 21 10:46:41 Phoenix kernel: RAX: ffffffffffffffda RBX: 00007f77006812=
04 RCX: 00007f770055ae4e
> Dez 21 10:46:41 Phoenix kernel: RDX: 000055d9705f5650 RSI: 000055d9705f56=
f0 RDI: 000055d9705f73d0
> Dez 21 10:46:41 Phoenix kernel: RBP: 000055d9705f5440 R08: 000055d9705f56=
70 R09: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: R10: 0000000000000000 R11: 00000000000002=
46 R12: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: R13: 000055d9705f73d0 R14: 000055d9705f56=
50 R15: 000055d9705f5440
> Dez 21 10:46:41 Phoenix kernel: ---[ end trace 71465d442bb4c50a ]---
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): space_info 1 has=
 733175808 free, is not full
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): space_info total=
=3D1386200694784, used=3D1385467318272, pinned=3D0, reserved=3D4096, may_us=
e=3D0, readonly=3D196608
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): global_block_rsv=
: size 0 reserved 0
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): trans_block_rsv:=
 size 0 reserved 0
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): chunk_block_rsv:=
 size 0 reserved 0
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): delayed_block_rs=
v: size 0 reserved 0
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): delayed_refs_rsv=
: size 0 reserved 0
> Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): open_ctree fail=
ed
> -- Subject: Unit process exited
> -- Defined-By: systemd
> =20
> Btrfs check --readonly /dev/sda also found errors:
> =20
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: 014bdf0a-bcb3-4a7c-b58d-c1fc17281f7e
> found 1386975199232 bytes used, error(s) found
> total csum bytes: 1352697008
> total tree bytes: 1508327424
> total fs tree bytes: 61161472
> total extent tree bytes: 37421056
> btree space waste bytes: 55303865
> file data blocks allocated: 1388605296640
>  referenced 1385670742016
> =20
> Btrfs scrub does not recognize any errors.
> =20
> Kindly help me to recover this error.
> =20
> many thanks,
> =20
> J=C3=B6rg Meyer
> =20
>=20

