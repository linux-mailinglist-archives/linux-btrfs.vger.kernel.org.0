Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5361225AEC
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 01:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfEUXmw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 19:42:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:48205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfEUXmv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 19:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558482169;
        bh=PR11PJy5lng7qDO33aTP0Hvp8A6zHU3PXv4rq6aWSmU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZgZ3TleRDdxmKleImpgkvPMGgYaAywnXEbJ38khhQlW1U/z4H3MBzyEJ7Xfnf82cO
         u/xFiu9eUbTUwRMI0HIJU27+YXXlhGdOq+CWIxk+B0Ba8iLLuTf3gMhCw2DO2l7OVh
         yoCAm7CUTsc23QuNeiCbdqSRyEKiplbIobaksoEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4z6k-1gSUnc1YMG-010w6s; Wed, 22
 May 2019 01:42:49 +0200
Subject: Re: 5.1.3: kernel BUG at fs/btrfs/relocation.c:1413
 (create_reloc_root)
To:     "C. Cebtenzzre" <cebtenzzre@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHk_K8bjAofDftLuFXB=60wcDchxFhuK79=OETEQDV_f-c0s-A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <45a89b3a-1ae6-e365-2b92-ab84b184d8c9@gmx.com>
Date:   Wed, 22 May 2019 07:42:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk_K8bjAofDftLuFXB=60wcDchxFhuK79=OETEQDV_f-c0s-A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JlIybJ7CB1U5NhbIIASBHXJk3P1xJr0dW"
X-Provags-ID: V03:K1:B38w3TLrU5qMde4t/nJS+HDdeVMOvcNlVloji0WEfdryqZq7wFW
 QAClvDSmEmoqvRLicnXH4W2NfDff8cBUbvSkxSJCxcbHM6aDYKAni2zpWjJ4a147SMPW8TK
 po2qaaR6cPmC8t1ugSp/3DaCrEhA1SVbk1vJAWCush89azlO/nabSJf5cESAFaIUVLa8xaG
 CQ3FBaSNY9btshKdl8WIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Bjf2lxEXnU=:sKerFWydfH0BkF4y3exeE2
 5T8HcbwHJxjyjsBQdEibMaIE6pRo4W+cwnkiGckvNjVS7pnCFu6dAiz6nGtJAw4JQG1rQY7Xu
 3SKkkT4AYzIGeGSFvbuIqLqEWIQFK6pu9BInam1EIq8vaNI4P3YztA1wnsP1/ex19vKqGhKb8
 V+zJ6m4jzV1i2BuaGAdg37Pe1cfyPSXPZf4t+3JMu5Hov1xvGAKu3BQNpn0SC/COKr7eL8/lB
 B6CaQ6bE1plPSnO5uS2cuSpDZAE7bIzk2HEI4RwNriL5D580g7YmDjQ6dnMaJs7d/48h1Jg2G
 pXoPN1x2I2G6Zbqm6Bp2vyw5HVVvSpGeGMHrkh2Qb/wWbZP8pKbBSjvGXzkqdk9luneeGBVWr
 dTDBGPsWwjvYsSdGTEycNfCqQhmgZwCO9Al6E/nvCpq/QAXDBqV2IQS9We9kHy5dCiO+64eFA
 JbuRA4kATJKNijTYx3Fs19VZPyADfi7DLETpT6Kty4YrJfL8HhWGP3FWHf3EY/hc5v12LsJZd
 uKR+dBsEj6/82bbbf+ecLBmMK+kapNla1Ng4g+RvJ6JLNP66tEm6IbfNxp/sbybRWGiRdlNbI
 D6dDP180em7CKptdugV+VCVUZNErWVw8ie+DwotDhGwMZfybgeIZq+gCK5c/PGo0EZUhkSMId
 JXOWB2U92t3h1x9oLPy3AlGAsyA3bRoR2DvTDGRNjEfQVaLLxM9zwIC696/jUmuizV1DWhD3c
 ktIm0zq3zWUd/Qpe/jjNOsJaVNwCOucATBKg0ttYJsPwQp7phoETfJziKevGAF1uHr8QnpyYV
 bG4X0rFakyWT2vfnsJ0Jx/i3bu0QAiIuwleTuBIfAyiy4GmE+qbAUjNawNpckZNjZiKMsqyR9
 UAytvHJnpkq+pD8H7MpY5z2M8x1DQNTZoJ4GfVGMmIvqQNcdjqYwz6KYozcddfUNWbduxketl
 jHQij43J3qbMga5mJR+zMqzzdtfmPHzQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JlIybJ7CB1U5NhbIIASBHXJk3P1xJr0dW
Content-Type: multipart/mixed; boundary="NV8riRAOzHCt9Bp4OqVxiy9zwPpmAOH4f";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "C. Cebtenzzre" <cebtenzzre@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <45a89b3a-1ae6-e365-2b92-ab84b184d8c9@gmx.com>
Subject: Re: 5.1.3: kernel BUG at fs/btrfs/relocation.c:1413
 (create_reloc_root)
References: <CAHk_K8bjAofDftLuFXB=60wcDchxFhuK79=OETEQDV_f-c0s-A@mail.gmail.com>
In-Reply-To: <CAHk_K8bjAofDftLuFXB=60wcDchxFhuK79=OETEQDV_f-c0s-A@mail.gmail.com>

--NV8riRAOzHCt9Bp4OqVxiy9zwPpmAOH4f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/22 =E4=B8=8A=E5=8D=886:28, C. Cebtenzzre wrote:
> I attempted to start a balance on Linux 5.1.3.  The process crashed
> and I got this in dmesg:

Just plain balance? And reproducibility?

Although I also hit such BUG_ON() but using dm-log-writes.
The BUG_ON() I hit is just after mount, triggered by automatic
background balance.

Thanks,
Qu
>=20
> [  600.078204] kernel BUG at fs/btrfs/relocation.c:1413!
> [  600.078215] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [  600.078220] CPU: 5 PID: 4010 Comm: btrfs Tainted: P           OE
>  5.1.3-arch1-1-ARCH #1
> [  600.078222] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./X99 Extreme4, BIOS P3.80 04/06/2018
> [  600.078285] RIP: 0010:create_reloc_root+0x1e9/0x200 [btrfs]
> [  600.078288] Code: 15 5c 12 d4 ea 48 8b 80 98 00 00 00 4c 29 c0 48
> c1 f8 06 48 c1 e0 0c 48 8b 44 10 50 49 89 86 f0 00 00 00 e9 b6 fe ff
> ff 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b e8 ea 15 c8 e9 66 2e 0f 1f 84 00 00
> 00 00
> [  600.078291] RSP: 0018:ffffa9e9031a7878 EFLAGS: 00010282
> [  600.078294] RAX: 00000000ffffffef RBX: ffff9065986f6c00 RCX: 0000000=
000000000
> [  600.078297] RDX: 000000005aee9205 RSI: ffff90660796cb60 RDI: ffffee0=
d88144b00
> [  600.078299] RBP: ffff9065faf47a28 R08: 000000000002cb60 R09: fffffff=
fc198cd4e
> [  600.078301] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000005
> [  600.078303] R13: ffff9065eb41a000 R14: ffff9065ce41c000 R15: ffff906=
40b5b8100
> [  600.078307] FS:  00007fc6540a68c0(0000) GS:ffff906607940000(0000)
> knlGS:0000000000000000
> [  600.078309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  600.078311] CR2: 00003608585ea008 CR3: 0000000222ff6006 CR4: 0000000=
0001606e0
> [  600.078313] Call Trace:
> [  600.078361]  btrfs_init_reloc_root+0x8f/0xa0 [btrfs]
> [  600.078398]  record_root_in_trans+0xae/0xd0 [btrfs]
> [  600.078435]  btrfs_record_root_in_trans+0x4e/0x60 [btrfs]
> [  600.078476]  select_reloc_root+0x7c/0x230 [btrfs]
> [  600.078518]  do_relocation+0x9f/0x540 [btrfs]
> [  600.078560]  ? select_one_root+0x37/0x110 [btrfs]
> [  600.078565]  ? preempt_count_add+0x79/0xb0
> [  600.078570]  ? _raw_spin_lock+0x13/0x30
> [  600.078573]  ? _raw_spin_unlock+0x16/0x30
> [  600.078614]  relocate_tree_blocks+0x4ce/0x640 [btrfs]
> [  600.078620]  ? kmem_cache_alloc_trace+0x169/0x1c0
> [  600.078662]  relocate_block_group+0x433/0x5b0 [btrfs]
> [  600.078704]  btrfs_relocate_block_group+0x18b/0x210 [btrfs]
> [  600.078748]  btrfs_relocate_chunk+0x31/0xa0 [btrfs]
> [  600.078791]  btrfs_balance+0x7bc/0xf00 [btrfs]
> [  600.078830]  ? btrfs_opendir+0x3e/0x70 [btrfs]
> [  600.078872]  btrfs_ioctl_balance+0x2d3/0x370 [btrfs]
> [  600.078916]  btrfs_ioctl+0x13c3/0x2e10 [btrfs]
> [  600.078923]  ? mem_cgroup_commit_charge+0x7a/0x470
> [  600.078929]  ? __mod_node_page_state+0x69/0xa0
> [  600.078936]  ? __lru_cache_add+0x75/0xa0
> [  600.078939]  ? _raw_spin_unlock+0x16/0x30
> [  600.078943]  ? __handle_mm_fault+0x947/0x15c0
> [  600.078948]  ? do_vfs_ioctl+0xa4/0x630
> [  600.078950]  do_vfs_ioctl+0xa4/0x630
> [  600.078954]  ? handle_mm_fault+0x10a/0x250
> [  600.078959]  ? syscall_trace_enter+0x1d3/0x2d0
> [  600.078962]  ksys_ioctl+0x60/0x90
> [  600.078966]  __x64_sys_ioctl+0x16/0x20
> [  600.078970]  do_syscall_64+0x5b/0x180
> [  600.078974]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  600.078978] RIP: 0033:0x7fc65419acbb
> [  600.078981] Code: 0f 1e fa 48 8b 05 a5 d1 0c 00 64 c7 00 26 00 00
> 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 d1 0c 00 f7 d8 64 89
> 01 48
> [  600.078983] RSP: 002b:00007fffb4681988 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  600.078987] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fc=
65419acbb
> [  600.078989] RDX: 00007fffb4681a20 RSI: 00000000c4009420 RDI: 0000000=
000000003
> [  600.078991] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000=
000000003
> [  600.078993] R10: 000055a6d9248010 R11: 0000000000000246 R12: 00007ff=
fb46823b8
> [  600.078994] R13: 0000000000000001 R14: 00007fffb4681a20 R15: 00007ff=
fb468278f
> [  600.078998] Modules linked in: cfg80211 xt_recent xt_tcpudp rfkill
> 8021q xt_state xt_conntrack garp mrp nf_conntrack stp llc
> nf_defrag_ipv6 vmnet(OE) nf_defrag_ipv4 iptable_filter nct6775
> hwmon_vid nls_iso8859_1 nls_cp437 vfat fat snd_usb_audio
> snd_usbmidi_lib snd_rawmidi snd_seq_device intel_rapl
> snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp coretemp
> kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel input_leds snd_hda_codec_realtek
> snd_hda_codec_generic ledtrig_audio snd_hda_intel aesni_intel
> snd_hda_codec usblp iTCO_wdt joydev aes_x86_64 iTCO_vendor_support
> mousedev snd_hda_core crypto_simd cryptd snd_hwdep glue_helper snd_pcm
> intel_cstate snd_timer mei_me snd intel_uncore intel_rapl_perf
> intel_wmi_thunderbolt pcspkr i2c_i801 mxm_wmi e1000e mei lpc_ich
> soundcore evdev mac_hid pcc_cpufreq fuse vmmon(OE) vmw_vmci
> vboxnetflt(OE) vboxnetadp(OE) vboxpci(OE) vboxdrv(OE) sg crypto_user
> ip_tables x_tables btrfs libcrc32c crc32c_generic xor usbhid uas
> [  600.079039]  usb_storage raid6_pq sd_mod ahci libahci libata
> xhci_pci ehci_pci crc32c_intel scsi_mod xhci_hcd ehci_hcd wmi
> nvidia_drm(POE) drm_kms_helper syscopyarea sysfillrect sysimgblt
> fb_sys_fops drm agpgart nvidia_uvm(OE) nvidia_modeset(POE) nvidia(POE)
> ipmi_devintf ipmi_msghandler hid_generic hid
> [  600.079061] ---[ end trace ccdf8b30014d6c1d ]---
> [  600.079104] RIP: 0010:create_reloc_root+0x1e9/0x200 [btrfs]
> [  600.079107] Code: 15 5c 12 d4 ea 48 8b 80 98 00 00 00 4c 29 c0 48
> c1 f8 06 48 c1 e0 0c 48 8b 44 10 50 49 89 86 f0 00 00 00 e9 b6 fe ff
> ff 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b e8 ea 15 c8 e9 66 2e 0f 1f 84 00 00
> 00 00
> [  600.079109] RSP: 0018:ffffa9e9031a7878 EFLAGS: 00010282
> [  600.079112] RAX: 00000000ffffffef RBX: ffff9065986f6c00 RCX: 0000000=
000000000
> [  600.079114] RDX: 000000005aee9205 RSI: ffff90660796cb60 RDI: ffffee0=
d88144b00
> [  600.079116] RBP: ffff9065faf47a28 R08: 000000000002cb60 R09: fffffff=
fc198cd4e
> [  600.079118] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000005
> [  600.079120] R13: ffff9065eb41a000 R14: ffff9065ce41c000 R15: ffff906=
40b5b8100
> [  600.079123] FS:  00007fc6540a68c0(0000) GS:ffff906607940000(0000)
> knlGS:0000000000000000
> [  600.079125] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  600.079127] CR2: 00003608585ea008 CR3: 0000000222ff6006 CR4: 0000000=
0001606e0
>=20
> After downgrading to Linux 5.0.9 and rebooting, btrfs check found these=
 errors:
> root 1306 inode 712 errors 1040, bad file extent, some csum missing
> root 1306 inode 725 errors 1040, bad file extent, some csum missing
>=20
> The only files in root 1306 are some unimportant virtual machines, but
> how do I deal with these errors?
>=20


--NV8riRAOzHCt9Bp4OqVxiy9zwPpmAOH4f--

--JlIybJ7CB1U5NhbIIASBHXJk3P1xJr0dW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzkjPAACgkQwj2R86El
/qhDOAf/UILX0TuCXgSXC2mdpa5fEOUDqiZt3w59MX0cZhcV6psz5664FHW4OUB5
9PsV+TZhA1O8ySaOstdIjDuHtu4LJlOAUB9c1wOH8C3CBOkEBxLRS9ZC2MN0ClP2
J33uEAZ31/O7yFrYGJLgDQHa0vPUEsyG0nfJJjJlj3omQt67/bacG1diM8JBUFBQ
MwK79+4j3oVHi+9fL6MGeQVRpqYBaT6yrZUcFQwVm5aXn2HD8Pmmlla+fmDxy5ZR
QnysPnO9NNQ8/ZmLBjiW57ei4Y3moQnbr6zcHCplwXen3y8TFyd3osGAF/GO1dlu
9HUQZfSbJmoVhBaYG5y7eavzqcCObw==
=pOOo
-----END PGP SIGNATURE-----

--JlIybJ7CB1U5NhbIIASBHXJk3P1xJr0dW--
