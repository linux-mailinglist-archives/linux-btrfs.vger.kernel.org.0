Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECB128982
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 15:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLUOT0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 09:19:26 -0500
Received: from mout.gmx.net ([212.227.15.18]:45553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfLUOTZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 09:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576937960;
        bh=YN248ZROe7r6zBMNEDRw7wl2IDx3o8Ugha4oAdUcpuE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=d+r3lFMRTDbdXpOZYNcGjaMKQZk3UPeJBf7A6gLhXEMufGm7HQ3j+yM7C4HfR2ri4
         Ql4orCXtKR0xDq67fb8rxw5mGepUeceTKyiRzVUGzgZoOx+PnbKLAt0JACTB2o+OZ9
         kbYrxop4twAvvGvLoI0Wdc3681zRJBc1xNU4lNnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRk3-1i7ftG3HDt-00bvJO; Sat, 21
 Dec 2019 15:19:20 +0100
Subject: Re: read time block corruption on root partition, Not booting
To:     jollemeyer@gmx.de, linux-btrfs@vger.kernel.org
References: <af9d16c9-2bf5-46fa-a146-84c4f8f6cc31.maildroid@localhost>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <c14a643b-c2b1-b3f2-01e3-2a51ab14f603@gmx.com>
Date:   Sat, 21 Dec 2019 22:19:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <af9d16c9-2bf5-46fa-a146-84c4f8f6cc31.maildroid@localhost>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wp5TyDZAuE9Yd5NJ31ndWeD9Ww0Em5Ktg"
X-Provags-ID: V03:K1:KoXc8EgVcBZjZ0C5SExkaQ1m6/loQqksyviD0bOfoO7kVt1BSR9
 hvFMogqo3wHT+qCcA+BW4UooMAK01d69HZreRGzTPtwdqZf6AmMYRwNlsfNKIlaY/dyVbiv
 +m8wW4b+ZOMqkKTVwL+PFGpm3D97zBdCXfFsbQWF2RhipgiuZoGonbM+XoNzqkjP+rmoS15
 y1hUbrZTvTtYw4Xp7dEqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FXPkotMyYS4=:ulFwlLTC5+5Rai+wruJWRw
 n8KKiLmVOZINofIhcJDM47jETXj1D/qup0avc+V1suzyIFr/V0i2hDys+SKDSNi3aLj2a8VLY
 lutIawpbOYUsqmcFnWRo8gzmkiaEqgPGcO2r9R8BK5dvcZLfRWgZdIVHFqBXo7o/U+b9CZpll
 ANCm23kTb154NICSfhDDqZHV5cBmFe6yjSuxiTCc7vb4stCEjO54D35UieN/aW1nBLqsk/BNZ
 zX7qcBCQhT9oWldeKIHoNGO9mIZvLDTS0sa0VM7Dzq9FsDdkJ719i74r0jc8WIdN86c9FYzkl
 M5pG01eTfd+GGllirNOtfJ/Q0cUx05kgApp5FTInlwva0l/HpcipLo3Bo7lsNp231qfxhELrQ
 ycb6Ls+QGQGC3ZMDCV929YJpEvknchcEmql2mfnuJy7PXo3QCRWs7qbftynDxmr0F1bhrFlnR
 PNK/2cW7k3Kyp6Q4VisggLmykPM7HXhwRoZFf9PvvhOQoVqrpelZmRxby6jw7jfsl04f8hRsg
 yeRtq5N1WYTyuc3Drf/RHIwBPl0SopUfGQyF6o1xYWYK1TduPhv637dAHAPOwVUv/BTmbM/bN
 bSzirC6LGp2PBkI08scms2gV8haGFLKuNjeIEZcj4PUoLvazB/JEx3Ksz/GAlvQ8vD8XgBff1
 /Id2D0qKXwX96o8Y/zLbUb0JsfYYOHH3Wt/J0KQQQQ6ooz1b1nZIk/YbZWkYz27lD98gcstFa
 i/cyaYHEHTs5yBZvKOA6EidLBFRZJG/15d8U9UAEm/gUeBXjSdrVP9VUfTGgBCfpS/HZvbada
 oyyqt27qJgiYdZG061u1oDM2xeAmnVe0HabWhn50vkbuC4oP9k0O5zULkJVR3lhmUPjSIaEfO
 DMjPCsTPHt2RYzYyvSFdCUCy4mncpE0KxTqoMUysxMJTRzAC5Za8izGSycxb6ERhFFpW6NrWd
 +LQpoyDm0iaag/7aH12909FpBeR3ccXOot2IZlA1y7x/hrdIpwh0gRVWVhbw2bJvkONbSIDNo
 keZ5/J8QkzPr9IjWb4jbuaaVNqtUXoO3KZe7nC7L1PSFtGSQHDclszvGPslOpizHSZuHV2qTY
 cNs5+69o3c5wPyDzaJIQCrfN1JGu7YU+pJvuNEpTc0ji42pDvfXzyJAX7FcKdkLuZhLtL6MkM
 eCoPhQxHWOeGXno8iGvMyUqFhPanlEuQigLbSkUpMpJmEtgTIcgtz0GFhP8xmckE/wD32ksUa
 QhGpOLwIzaRaAXjztQ2SW6QLbb4rPD9ghkj25op+Xt5EFysXdarSuyRs+lxw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wp5TyDZAuE9Yd5NJ31ndWeD9Ww0Em5Ktg
Content-Type: multipart/mixed; boundary="DKJrNEHb5UxJ7Ug3T372Nah1w2AAplmyf"

--DKJrNEHb5UxJ7Ug3T372Nah1w2AAplmyf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/21 =E4=B8=8B=E5=8D=8810:06, jollemeyer@gmx.de wrote:
> Dear all,
> =20
> on my BTRFS root partition (/dev/sda), a "read time block corruption" w=
as detected. The system refuses to boot.
> Current kernel is 5.4.2-1-Manjaro.
> =20
> Systemd's journalctl generated the following output:
> =20
> Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt le=
af: block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4=
096 invalid extent refs, have 1 expect >=3D inline 1048577
> Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D20890=
35464704 read time tree block corruption detected
> Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt le=
af: block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4=
096 invalid extent refs, have 1 expect >=3D inline 1048577
> Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D20890=
35464704 read time tree block corruption detected
> Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt le=
af: block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4=
096 invalid extent refs, have 1 expect >=3D inline 1048577
> Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D20890=
35464704 read time tree block corruption detected
> Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt le=
af: block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4=
096 invalid extent refs, have 1 expect >=3D inline 1048577
> Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D20890=
35464704 read time tree block corruption detected
> Dez 21 10:46:41 Phoenix kernel: BTRFS: error (device sda) in btrfs_repl=
ay_log:2293: errno=3D-5 IO failure (Failed to recover log tree)

"btrfs ins dump-tree -b 2089035464704 /dev/sda" output please.

Thanks,
Qu

> Dez 21 10:46:41 Phoenix kernel: ------------[ cut here ]------------
> Dez 21 10:46:41 Phoenix kernel: WARNING: CPU: 7 PID: 621 at fs/btrfs/bl=
ock-group.c:132 btrfs_put_block_group+0x42/0x50 [btrfs]
> Dez 21 10:46:41 Phoenix kernel: Modules linked in: usblp snd_hda_codec_=
hdmi intel_rapl_msr snd_hda_codec_realtek intel_rapl_common snd_hda_codec=
_generic ext4 ledtrig_audio x86_pkg_temp_thermal intel_powerclamp coretem=
p crc16 kvm_intel mbcache i915 jbd2 kvm snd_hda_intel snd_intel_nhlt i2c_=
algo_bit irqbypass drm_kms_helper snd_hda_codec crct10dif_pclmul crc32_pc=
lmul snd_hda_core mousedev ghash_clmulni_intel drm snd_hwdep snd_pcm aesn=
i_intel crypto_simd cryptd glue_helper mei_hdcp intel_cstate iTCO_wdt int=
el_gtt snd_timer iTCO_vendor_support intel_uncore mei_me intel_rapl_perf =
input_leds agpgart i2c_i801 snd syscopyarea mei sysfillrect lpc_ich r8168=
(OE) sysimgblt soundcore fb_sys_fops evdev ie31200_edac mac_hid vboxpci(O=
E) vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) sg crypto_user ip_tables x_t=
ables hid_generic usbhid hid btrfs libcrc32c crc32c_generic xor uas usb_s=
torage raid6_pq sr_mod cdrom sd_mod ahci serio_raw atkbd libahci libps2 l=
ibata xhci_pci scsi_mod xhci_hcd ehci_pci crc32c_intel ehci_hcd i8042 ser=
io
> Dez 21 10:46:41 Phoenix kernel: CPU: 7 PID: 621 Comm: mount Tainted: G =
          OE     5.4.2-1-MANJARO #1
> Dez 21 10:46:41 Phoenix kernel: Hardware name: To Be Filled By O.E.M. T=
o Be Filled By O.E.M./H77 Pro4/MVP, BIOS P1.40 09/04/2012
> Dez 21 10:46:41 Phoenix kernel: RIP: 0010:btrfs_put_block_group+0x42/0x=
50 [btrfs]
> Dez 21 10:46:41 Phoenix kernel: Code: 2d 48 83 7d 50 00 75 22 48 8b 85 =
e8 01 00 00 48 85 c0 75 1e 48 8b bd d8 00 00 00 e8 a8 08 66 d9 48 89 ef 5=
d e9 9f 08 66 d9 c3 <0f> 0b eb da 0f 0b eb cf 0f 0b eb de 66 90 0f 1f 44 =
00 00 31 d2 e9
> Dez 21 10:46:41 Phoenix kernel: RSP: 0018:ffffa95900f47ae8 EFLAGS: 0001=
0206
> Dez 21 10:46:41 Phoenix kernel: RAX: 0000000000000001 RBX: ffff8a1eb7bf=
e0e0 RCX: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: RDX: 0000000000000001 RSI: ffff8a1ecf5f=
0250 RDI: ffff8a1eb7bfe000
> Dez 21 10:46:41 Phoenix kernel: RBP: ffff8a1eb7bfe000 R08: 000000000000=
0000 R09: 0000000000000001
> Dez 21 10:46:41 Phoenix kernel: R10: 00000000003f6c00 R11: 000000000000=
0000 R12: ffff8a1ec81b0080
> Dez 21 10:46:41 Phoenix kernel: R13: ffff8a1ec81b0090 R14: ffff8a1eb7bf=
e000 R15: dead000000000100
> Dez 21 10:46:41 Phoenix kernel: FS:  00007f77003d7500(0000) GS:ffff8a1e=
cf5c0000(0000) knlGS:0000000000000000
> Dez 21 10:46:41 Phoenix kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
> Dez 21 10:46:41 Phoenix kernel: CR2: 0000559652364460 CR3: 00000003fbae=
c005 CR4: 00000000001606e0
> Dez 21 10:46:41 Phoenix kernel: Call Trace:
> Dez 21 10:46:41 Phoenix kernel:  btrfs_free_block_groups+0x11c/0x260 [b=
trfs]
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
> Dez 21 10:46:41 Phoenix kernel:  entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
> Dez 21 10:46:41 Phoenix kernel: RIP: 0033:0x7f770055ae4e
> Dez 21 10:46:41 Phoenix kernel: Code: 48 8b 0d 35 00 0c 00 f7 d8 64 89 =
01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b=
8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 f7 =
d8 64 89 01 48
> Dez 21 10:46:41 Phoenix kernel: RSP: 002b:00007ffedb3135c8 EFLAGS: 0000=
0246 ORIG_RAX: 00000000000000a5
> Dez 21 10:46:41 Phoenix kernel: RAX: ffffffffffffffda RBX: 00007f770068=
1204 RCX: 00007f770055ae4e
> Dez 21 10:46:41 Phoenix kernel: RDX: 000055d9705f5650 RSI: 000055d9705f=
56f0 RDI: 000055d9705f73d0
> Dez 21 10:46:41 Phoenix kernel: RBP: 000055d9705f5440 R08: 000055d9705f=
5670 R09: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: R10: 0000000000000000 R11: 000000000000=
0246 R12: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: R13: 000055d9705f73d0 R14: 000055d9705f=
5650 R15: 000055d9705f5440
> Dez 21 10:46:41 Phoenix kernel: ---[ end trace 71465d442bb4c509 ]---
> Dez 21 10:46:41 Phoenix kernel: ------------[ cut here ]------------
> Dez 21 10:46:41 Phoenix kernel: WARNING: CPU: 0 PID: 621 at fs/btrfs/bl=
ock-group.c:3166 btrfs_free_block_groups+0x1ea/0x260 [btrfs]
> Dez 21 10:46:41 Phoenix kernel: Modules linked in: usblp snd_hda_codec_=
hdmi intel_rapl_msr snd_hda_codec_realtek intel_rapl_common snd_hda_codec=
_generic ext4 ledtrig_audio x86_pkg_temp_thermal intel_powerclamp coretem=
p crc16 kvm_intel mbcache i915 jbd2 kvm snd_hda_intel snd_intel_nhlt i2c_=
algo_bit irqbypass drm_kms_helper snd_hda_codec crct10dif_pclmul crc32_pc=
lmul snd_hda_core mousedev ghash_clmulni_intel drm snd_hwdep snd_pcm aesn=
i_intel crypto_simd cryptd glue_helper mei_hdcp intel_cstate iTCO_wdt int=
el_gtt snd_timer iTCO_vendor_support intel_uncore mei_me intel_rapl_perf =
input_leds agpgart i2c_i801 snd syscopyarea mei sysfillrect lpc_ich r8168=
(OE) sysimgblt soundcore fb_sys_fops evdev ie31200_edac mac_hid vboxpci(O=
E) vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) sg crypto_user ip_tables x_t=
ables hid_generic usbhid hid btrfs libcrc32c crc32c_generic xor uas usb_s=
torage raid6_pq sr_mod cdrom sd_mod ahci serio_raw atkbd libahci libps2 l=
ibata xhci_pci scsi_mod xhci_hcd ehci_pci crc32c_intel ehci_hcd i8042 ser=
io
> Dez 21 10:46:41 Phoenix kernel: CPU: 0 PID: 621 Comm: mount Tainted: G =
       W  OE     5.4.2-1-MANJARO #1
> Dez 21 10:46:41 Phoenix kernel: Hardware name: To Be Filled By O.E.M. T=
o Be Filled By O.E.M./H77 Pro4/MVP, BIOS P1.40 09/04/2012
> Dez 21 10:46:41 Phoenix kernel: RIP: 0010:btrfs_free_block_groups+0x1ea=
/0x260 [btrfs]
> Dez 21 10:46:41 Phoenix kernel: Code: 49 bd 22 01 00 00 00 00 ad de e8 =
51 13 d1 d9 e8 0c d3 4e d9 48 89 ef e8 64 9b ff ff 48 8b 85 00 10 00 00 4=
9 39 c4 75 3c eb 5f <0f> 0b 31 c9 31 d2 4c 89 fe 48 89 ef e8 55 85 ff ff =
48 8b 43 08 48
> Dez 21 10:46:41 Phoenix kernel: RSP: 0018:ffffa95900f47af8 EFLAGS: 0001=
0206
> Dez 21 10:46:41 Phoenix kernel: RAX: ffff8a1eca367488 RBX: ffff8a1eca36=
7488 RCX: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: RDX: 0000000000000001 RSI: ffff8a1eca36=
4200 RDI: 00000000ffffffff
> Dez 21 10:46:41 Phoenix kernel: RBP: ffff8a1ec81b0000 R08: 000000000000=
0000 R09: 0000000020000000
> Dez 21 10:46:41 Phoenix kernel: R10: 0000000000000005 R11: ffffffffffd5=
ce37 R12: ffff8a1ec81b1000
> Dez 21 10:46:41 Phoenix kernel: R13: dead000000000122 R14: dead00000000=
0100 R15: ffff8a1eca367400
> Dez 21 10:46:41 Phoenix kernel: FS:  00007f77003d7500(0000) GS:ffff8a1e=
cf400000(0000) knlGS:0000000000000000
> Dez 21 10:46:41 Phoenix kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
> Dez 21 10:46:41 Phoenix kernel: CR2: 0000559006e55d68 CR3: 00000003fbae=
c006 CR4: 00000000001606f0
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
> Dez 21 10:46:41 Phoenix kernel:  entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
> Dez 21 10:46:41 Phoenix kernel: RIP: 0033:0x7f770055ae4e
> Dez 21 10:46:41 Phoenix kernel: Code: 48 8b 0d 35 00 0c 00 f7 d8 64 89 =
01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b=
8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 f7 =
d8 64 89 01 48
> Dez 21 10:46:41 Phoenix kernel: RSP: 002b:00007ffedb3135c8 EFLAGS: 0000=
0246 ORIG_RAX: 00000000000000a5
> Dez 21 10:46:41 Phoenix kernel: RAX: ffffffffffffffda RBX: 00007f770068=
1204 RCX: 00007f770055ae4e
> Dez 21 10:46:41 Phoenix kernel: RDX: 000055d9705f5650 RSI: 000055d9705f=
56f0 RDI: 000055d9705f73d0
> Dez 21 10:46:41 Phoenix kernel: RBP: 000055d9705f5440 R08: 000055d9705f=
5670 R09: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: R10: 0000000000000000 R11: 000000000000=
0246 R12: 0000000000000000
> Dez 21 10:46:41 Phoenix kernel: R13: 000055d9705f73d0 R14: 000055d9705f=
5650 R15: 000055d9705f5440
> Dez 21 10:46:41 Phoenix kernel: ---[ end trace 71465d442bb4c50a ]---
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): space_info 1 h=
as 733175808 free, is not full
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): space_info tot=
al=3D1386200694784, used=3D1385467318272, pinned=3D0, reserved=3D4096, ma=
y_use=3D0, readonly=3D196608
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): global_block_r=
sv: size 0 reserved 0
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): trans_block_rs=
v: size 0 reserved 0
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): chunk_block_rs=
v: size 0 reserved 0
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): delayed_block_=
rsv: size 0 reserved 0
> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): delayed_refs_r=
sv: size 0 reserved 0
> Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): open_ctree fa=
iled
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


--DKJrNEHb5UxJ7Ug3T372Nah1w2AAplmyf--

--wp5TyDZAuE9Yd5NJ31ndWeD9Ww0Em5Ktg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3+KeUACgkQwj2R86El
/qhJHQf7Bmqanam0Yjb9GvFTjglfUbAkVnUuhaLNEg1Jd/4dM8DQj1nlNvH9JeIc
3N/C+X3YiglbfifqKjKUSNlM9vxY3LngSp6nLvT++IWR9UsZmp0YqubUggZJIkUi
Se4El79fWJ5CJBDQzPYzCeJlf5IJeZq64QYW5GQDtTWXWd2sYVM2H51Cj+ZKpoJQ
YjMMTKb/NXmQsPRlJ47duZt6yI6VE+w7T+4Hgu9fa3pqb6vURrHiDMMgdpUK/hsA
ZCA4cymhl8TLIqJSWlXAyw59LWLZ8SI9fjo5A49uGdSOBwvHSBhxhjxkYSHcytQD
ooCyU4x5/f9U0/1Q2OOZsfTKCgvyTw==
=pBJQ
-----END PGP SIGNATURE-----

--wp5TyDZAuE9Yd5NJ31ndWeD9Ww0Em5Ktg--
