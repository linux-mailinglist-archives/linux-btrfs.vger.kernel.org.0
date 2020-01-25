Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD82149575
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 13:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAYMPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 07:15:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:33863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgAYMPz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 07:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579954553;
        bh=knHhVJSTdR9gZy2frBGmFEWlRJEH5BwW0zjxhmddhaY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SE0sHLCp9riomwA+53W4HhOeJcj7XioEkN17Morsm18uuvrs7DB+xkKkyQyLniAhe
         bdU9v8wTrb2ZIFPCde1HLwxnb01x+Pf9n2TnOffD6g/fjq9eAsBV8Bq0Nm2AzilY/5
         HIpDdfh3fyg/hfAAJkCFRL36ZKGC9UgXg/080hwA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzyuS-1jqAYw3vja-00x5Dc; Sat, 25
 Jan 2020 13:15:53 +0100
Subject: Re: tree first key mismatch detected (reproducible error)
To:     Thorsten Hirsch <t.hirsch@web.de>, linux-btrfs@vger.kernel.org
References: <CAH+WbHxsOEt9Z7t=ubtCmoCb2f4nDpMCCSXnT+-k5oR2pQFpOQ@mail.gmail.com>
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
Message-ID: <87da0616-73ae-4fd2-9b34-ebe88a3dc7b8@gmx.com>
Date:   Sat, 25 Jan 2020 20:15:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAH+WbHxsOEt9Z7t=ubtCmoCb2f4nDpMCCSXnT+-k5oR2pQFpOQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gxoQZo4E7kQmd96s1dAvQCGj7ObsnEA75"
X-Provags-ID: V03:K1:c979gU7EYbDG2sT8z+B5y9MxV+386wZ5dqgm5PW+0UmfC+T8gAO
 1xta3t3EaPRQLJ3PyClVOdgdFgaae4ulyvO2cdf1Co2EW/D/2v00IUbuBL7/JmigUHBnm4r
 rlQO6MMFj5kvu+nRAJ28oTY90FdY3M9h6+qMLN6R67t/Gp/PaXKYhvfh5UGMiFSIebfkzTI
 95Qm29UE+m70yQmLd/x6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rGxGrOSs5pc=:BoGZRhj4H/Dwa0XUv4utSj
 QrVCXd3EkUQdZrHNebqgBd1yiI/8a1cwDOqBM32ccX+E7tJsygQr7lSjOImNVdMNtgPAVs+GE
 Aty7+Ydrmxqc3Lu8ls1JNY8PtnSK0L+jkVtJk3+/vkl7m0xHb87LOMU/lsgcEBHpp4/4Mzh+5
 J3D8ZMTaJJUJtzRIfGXxgm2Wj2znFoDhxoZ7Nb1xGJw1F16DYDzFK0KqEV4cvT9ypHmSW9TZc
 7pe93UQaaAVArD+7qFLzw2RDumYqPsYsfagCcR/21UdOQNz/Rc3UarA55HMunr02J4jBCu1XJ
 ze/M8bhMI+Ab0hZHBdZYo5jkFTDemaOXVOvqrAI0Oqrr9+X8YEtA5o6WckKz1mzcJgizUMrF6
 QPUiQ4aZaaIrE46RdizDQNCu84HG1id03P43LUU8Be4FliwB9I1HXHHjbappfgDA4Yh7PMn+B
 +719YtMmNzV/ZIfKuZl4cI/w2kyouwhqoatWzL6AENx0wHVNzOQSdSJCpXSQ0E+P97Je9AxeL
 kjihslMzmgE8bgatpw9aBJsGwFDm+A+mbfk6j0KeJE+s2h+dSeQMf/jRT8a/FBEddQIwsmUqP
 2FuMBUDCZS1HiejOJGDReMJ9oN7lQ90EKbpVgMdrN0shhWhEZzmCaO1hi3jkfweT04RLCXX2O
 gVcD6Nb184Y1v71YvO1bjocVFan2vr8RY4s/kt0V9vRsGwKSbsGuJRgyOakCImnHkAqo2hhiq
 zjC6Tew6HbHvpJu5QIRBMu5em+Yqfi9pXfmkqvNoWlq+8Fc8UEDwBKugXtpLD+FmdmCn2kW92
 jJf1DWbJYqmXlLVxuHWhJ8bQ34tKJ+ozfLdb8ktb3YBosWxuCXBsXvMIRJr4J8Zo+2MG5wVi1
 fw7223s1nwwE0yJkaOIpy1P/v9j0NnsNFa3KTtJ8YGijBNr5afolA+sBurVjltM63UPusdrDQ
 zaZzSZig3IudigkVV1DJj0E1Qstz0QQnTqvvnoALSm+DCOoPCko/YScijenLHeZiVTf36AZsw
 ykk9sPqEd5czlosm5mddcKZnmcS37YU1DwYBvR/gE9Vi1ATVWCEeflrfDyIJs7v6jxagK/w5a
 guCJs4J8UO9KYlXEWGj9Npc98ScrRPBlGN5ELN6+huH+gogQdv5tbnoQPLKkymo6mab3fanNF
 Xl/sLwlH0n8SZYSEUVpWAYE+f6GtTF6G2AP6zz8nRtHwyBjWMAePRpCQMHT8xZDDcYPcOV1/N
 H5HS64GFciwcBO9kb
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gxoQZo4E7kQmd96s1dAvQCGj7ObsnEA75
Content-Type: multipart/mixed; boundary="NxqeSGVZMOQECY8SuDLpovkwXrmvQXJVt"

--NxqeSGVZMOQECY8SuDLpovkwXrmvQXJVt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/25 =E4=B8=8B=E5=8D=887:37, Thorsten Hirsch wrote:
> Hi, here's a btrfs problem that started happening today on my main comp=
uter:
>=20
> BTRFS error (device nvme0n1p3): tree first key mismatch detected,
> bytenr=3D109690880 parent_transid=3D1329869 key
> expected=3D(48044838912,168,12288) has=3D(48045363200,168,12288)

This means your fs is already corrupted.

The only good news is, that corruption is in extent tree.

Thus you can still salvage your data in RO mode.
>=20
> It always occurs some minutes after booting, sometimes even seconds
> after booting. The partition is then remounted read-only. I already
> tried scrubbing the partition (aborts itself after some seconds) and
> balancing (seems to trigger the error immediately and doesn't even
> start).

Please run `btrfs check` on the unmounted fs. (Since you're already
using Arch, using latest arch iso looks like the best solution if it's
your root fs).

If feel like to have a adventure, you could try `btrfs check
--init-extent-tree` after posting the `btrfs check` result.

It can be very slow, and may not always fix your problem.

>=20
> I attached some more output of dmesg. The distribution is Arch Linux
> and the kernel is the most recent one in Arch's default kernel
> package: 5.4.14-arch1-1 (I upgraded from 5.4.13 to 5.4.14 just
> yesterday).

Arch's kernel is mostly upstream, which is mostly good for btrfs usage,
so is its btrfs-progs version.

Thanks,
Qu

>=20
> Best regards,
> Thorsten
>=20
> [Jan25 12:00] BTRFS error (device nvme0n1p3): tree first key mismatch
> detected, bytenr=3D109690880 parent_transid=3D1329869 key
> expected=3D(48044838912,168,12288) has=3D(48045363200,168,12288)
> [  +0,000003] ------------[ cut here ]------------
> [  +0,000001] BTRFS: Transaction aborted (error -117)
> [  +0,000041] WARNING: CPU: 7 PID: 382 at fs/btrfs/extent-tree.c:3080
> __btrfs_free_extent.isra.0+0x694/0x9e0 [btrfs]
> [  +0,000000] Modules linked in: xt_nat xt_tcpudp veth xt_conntrack
> xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo
> xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc edac_mce_amd
> kvm_amd snd_hda_codec_ca0110 snd_hda_codec_generic wmi_bmof kvm
> ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_nhlt pktcdvd
> irqbypass snd_hda_codec uvcvideo snd_hda_core snd_hwdep
> videobuf2_vmalloc snd_pcm videobuf2_memops nls_iso8859_1
> videobuf2_v4l2 nls_cp437 videobuf2_common snd_timer crct10dif_pclmul
> vfat crc32_pclmul videodev fat snd joydev ghash_clmulni_intel
> input_leds mousedev mc psmouse aesni_intel r8169 crypto_simd realtek
> cryptd ccp glue_helper k10temp i2c_piix4 soundcore libphy rng_core wmi
> gpio_amdpt evdev mac_hid pinctrl_amd acpi_cpufreq fuse vboxnetflt(OE)
> vboxnetadp(OE) vboxdrv(OE) sg crypto_user ip_tables x_tables sr_mod
> cdrom sd_mod hid_generic usbhid hid serio_raw atkbd libps2 ahci
> libahci libata xhci_pci
> [  +0,000018]  xhci_hcd scsi_mod i8042 serio amdgpu gpu_sched
> i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
> fb_sys_fops drm agpgart btrfs libcrc32c crc32c_generic crc32c_intel
> xor raid6_pq
> [  +0,000005] CPU: 7 PID: 382 Comm: btrfs-transacti Tainted: G
>   OE     5.4.14-arch1-1 #1
> [  +0,000001] Hardware name: Gigabyte Technology Co., Ltd.
> AB350M-DS3H/AB350M-DS3H-CF, BIOS F50a 11/27/2019
> [  +0,000010] RIP: 0010:__btrfs_free_extent.isra.0+0x694/0x9e0 [btrfs]
> [  +0,000001] Code: e8 c1 ee 00 00 8b 4c 24 38 85 c9 0f 84 39 fe ff ff
> 48 8b 54 24 48 e9 04 fe ff ff 44 89 fe 48 c7 c7 a0 ce 30 c0 e8 ba 48
> c4 d1 <0f> 0b 48 8b 3c 24 44 89 f9 ba 08 0c 00 00 48 c7 c6 a0 20 30 c0
> e8
> [  +0,000001] RSP: 0018:ffff8fc081363ba0 EFLAGS: 00010286
> [  +0,000001] RAX: 0000000000000000 RBX: 0000000000000192 RCX: 00000000=
00000000
> [  +0,000000] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 00000000=
ffffffff
> [  +0,000001] RBP: 0000000b3090a000 R08: 000000000000049b R09: 00000000=
00000004
> [  +0,000000] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8b95=
8a1c9c40
> [  +0,000001] R13: 0000000000000000 R14: 0000000000000001 R15: 00000000=
ffffff8b
> [  +0,000001] FS:  0000000000000000(0000) GS:ffff8b958e9c0000(0000)
> knlGS:0000000000000000
> [  +0,000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0,000001] CR2: 00007fdcf263d000 CR3: 000000032f11a000 CR4: 00000000=
003406e0
> [  +0,000001] Call Trace:
> [  +0,000012]  ? __btrfs_run_delayed_refs+0xc9f/0xff0 [btrfs]
> [  +0,000009]  __btrfs_run_delayed_refs+0x25e/0xff0 [btrfs]
> [  +0,000011]  btrfs_run_delayed_refs+0x6a/0x180 [btrfs]
> [  +0,000013]  btrfs_start_dirty_block_groups+0x28e/0x470 [btrfs]
> [  +0,000011]  btrfs_commit_transaction+0x116/0x9b0 [btrfs]
> [  +0,000003]  ? _raw_spin_unlock+0x16/0x30
> [  +0,000010]  ? join_transaction+0x108/0x3a0 [btrfs]
> [  +0,000010]  transaction_kthread+0x13a/0x180 [btrfs]
> [  +0,000002]  kthread+0xfb/0x130
> [  +0,000010]  ? btrfs_cleanup_transaction+0x560/0x560 [btrfs]
> [  +0,000001]  ? kthread_park+0x90/0x90
> [  +0,000001]  ret_from_fork+0x1f/0x40
> [  +0,000002] ---[ end trace 51366456523028bd ]---
> [  +0,000001] BTRFS: error (device nvme0n1p3) in
> __btrfs_free_extent:3080: errno=3D-117 unknown
> [  +0,000001] BTRFS info (device nvme0n1p3): forced readonly
> [  +0,000002] BTRFS: error (device nvme0n1p3) in
> btrfs_run_delayed_refs:2188: errno=3D-117 unknown
>=20


--NxqeSGVZMOQECY8SuDLpovkwXrmvQXJVt--

--gxoQZo4E7kQmd96s1dAvQCGj7ObsnEA75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4sMXUACgkQwj2R86El
/qgHHQf/ehHWIybECj/AWYUB1/nhwAnttHxcEVwolTOCVfGxi7lHkFzZvYJeijOz
uGP5hkBvmnS9Y9V0HIhnsVkT0QGiy/rg8JC6unN/dRTCSjfjcp4fOMYkkkHmzCou
BQTRtWgI0v7Rp5N3QdQF2FJYyHTBiQ2GLfeK6SbQG2cAan0fVr5iX9uSqpVqyx0q
yWXFnn0i2Zmwmv38mQhMBU4o/bkChT7NrLzukHcJ9aWQ+zFiP7p7cEFpHxIQe62B
v8xzTXP5YXjxR02HuYm+PDBvTPWmD+A28ycmgtQnfeHKyrByQQrkMubwSZqqM2YR
Cg1NqSugwgVFThM2k3QMVLlZl7XawQ==
=tDVh
-----END PGP SIGNATURE-----

--gxoQZo4E7kQmd96s1dAvQCGj7ObsnEA75--
