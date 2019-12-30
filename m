Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F043E12D011
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 13:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfL3Mpm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 07:45:42 -0500
Received: from ocelot.miegl.cz ([195.201.216.236]:34052 "EHLO ocelot.miegl.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfL3Mpl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 07:45:41 -0500
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Dec 2019 07:45:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miegl.cz; s=dkim;
        t=1577709399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=QXN/AJYICPiF6AbeyTnpyJbryfSNDchLtdTvjjr73pI=;
        b=Dea+olJU0NvcdA+IiCcJYyulH5F8ahSOeB3118LajF3nBt1rTXMK8DkSEQb9owRXo9aIcl
        7FBekxJbYrxiTcnkh5IP6t+drjoY3N3Evtgz3tD/TvhLUHsne7gXIVHpiAN895X6R2L0cL
        RO6gDjJ2NHnyxdrYXYBHIPB8IjWbkgLyZZPj2JWpDl+0rp7f7C9Hq0+qOeCtPRpRMhVKGX
        lVXjpB2DAzGY28L2EORa562XBCmv9vJXHQHcmbQvvnRCRoePbgEHckHG/vPRdXvxAtKBVd
        x1Ru3O1q3w3hcT2Pqa8asxkA9qjModEt9RWWWIh1foW1Q0twn/wlnSE3TNtnpQ==
Date:   Mon, 30 Dec 2019 13:36:35 +0100
From:   Josef Miegl <josef@miegl.cz>
To:     linux-btrfs@vger.kernel.org
Subject: 5.4.6 page fault while running btfrs scrub
Message-ID: <20191230123635.bpcei77hntjx4th2@t420>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sttquksx3wii23tw"
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--sttquksx3wii23tw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quick rundown:
	1. made a new luks encrypted partition on an ssd
	2. formatted the volume with btrfs
	3. systemd mounts the fs with discards enabled
	4. filled about 45% of the available space
	5. btrfs reported no free space available
	6. ran btrfs balance start /
	7. balance quit with no space available message, but it fixed
	the free space issue
	8. supposed there was something wrong with the fs and ran
	btrfs scrub start /

# uname -a
Linux t420 5.4.6-arch3-1 #1 SMP PREEMPT Tue, 24 Dec 2019 04:36:53 +0000 x86=
_64 GNU/Linux

# btrfs --version
btrfs-progs v5.4

dmesg:
[  391.487379] BTRFS info (device dm-1): scrub: started on devid 1
[  520.224044] BUG: stack guard page was hit at 00000000e297e985 (stack is =
000000006621d119..000000007c53ae63)
[  520.225356] kernel stack overflow (page fault): 0000 [#1] PREEMPT SMP NO=
PTI
[  520.226858] CPU: 2 PID: 748 Comm: btrfs Not tainted 5.4.6-arch3-1 #1
[  520.228268] Hardware name: LENOVO 4180A21/4180A21, BIOS CBET4000 4.9-217=
6-g2195f7af23 06/22/2019
[  520.229901] RIP: 0010:memcpy_erms+0x6/0x10
[  520.231401] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 =
03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3=
> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[  520.234391] RSP: 0018:ffffb5c5c07478b8 EFLAGS: 00010206
[  520.235797] RAX: ffffb5c5c0747ac8 RBX: ffff9a3b4d6aba90 RCX: fffffffffff=
ffacc
[  520.237256] RDX: 0000000000000004 RSI: ffff9a3b4d6abffc RDI: ffffb5c5c07=
48000
[  520.238716] RBP: 0000000000000009 R08: 0000000000010000 R09: ffff9a3b4d6=
aba80
[  520.240288] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
01000
[  520.241865] R13: dead000000000122 R14: dead000000000100 R15: ffff9a3b62c=
55800
[  520.243466] FS:  00007f4d38999700(0000) GS:ffff9a3b67480000(0000) knlGS:=
0000000000000000
[  520.245105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  520.246767] CR2: ffffb5c5c0748000 CR3: 000000024efa2003 CR4: 00000000001=
606e0
[  520.248476] Call Trace:
[  520.250245]  scrub_find_csum+0xf9/0x150 [btrfs]
[  520.252026]  scrub_stripe+0x8c6/0x1040 [btrfs]
[  520.253803]  ? wait_woken+0x70/0x70
[  520.255604] Modules linked in: ext4 mbcache jbd2 uas usb_storage mousede=
v ccm algif_aead des_generic libdes arc4 algif_skcipher cmac md4 algif_hash=
 af_alg snd_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic int=
el_rapl_msr intel_rapl_common iwldvm i915 mac80211 x86_pkg_temp_thermal int=
el_powerclamp coretemp snd_hda_intel snd_intel_nhlt kvm_intel libarc4 btusb=
 uvcvideo snd_hda_codec btrtl i2c_algo_bit iTCO_wdt iwlwifi btbcm videobuf2=
_vmalloc iTCO_vendor_support drm_kms_helper btintel videobuf2_memops videob=
uf2_v4l2 kvm tpm_tis videobuf2_common bluetooth thinkpad_acpi tpm_tis_core =
irqbypass snd_hda_core intel_cstate tpm videodev intel_uncore drm psmouse p=
cspkr snd_hwdep nvram intel_rapl_perf ecdh_generic ledtrig_audio cfg80211 i=
nput_leds i2c_i801 ecc snd_pcm mc battery ac crc16 rng_core intel_gtt e1000=
e snd_timer evdev agpgart mac_hid syscopyarea sysfillrect snd sysimgblt fb_=
sys_fops coreboot_table soundcore lpc_ich rfkill pkcs8_key_parser ip_tables=
 x_tables btrfs libcrc32c
[  520.255650]  crc32c_generic xor raid6_pq dm_crypt dm_mod sr_mod cdrom sd=
_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ahci se=
rio_raw libahci atkbd libps2 aesni_intel libata sdhci_pci crypto_simd cqhci=
 cryptd sdhci glue_helper scsi_mod mmc_core ehci_pci ehci_hcd i8042 serio
[  520.271062] ---[ end trace 9be44e8a9868703f ]---
[  520.273520] RIP: 0010:memcpy_erms+0x6/0x10
[  520.275994] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 =
03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3=
> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[  520.281108] RSP: 0018:ffffb5c5c07478b8 EFLAGS: 00010206
[  520.283611] RAX: ffffb5c5c0747ac8 RBX: ffff9a3b4d6aba90 RCX: fffffffffff=
ffacc
[  520.286069] RDX: 0000000000000004 RSI: ffff9a3b4d6abffc RDI: ffffb5c5c07=
48000
[  520.288508] RBP: 0000000000000009 R08: 0000000000010000 R09: ffff9a3b4d6=
aba80
[  520.290970] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
01000
[  520.293434] R13: dead000000000122 R14: dead000000000100 R15: ffff9a3b62c=
55800
[  520.295894] FS:  00007f4d38999700(0000) GS:ffff9a3b67480000(0000) knlGS:=
0000000000000000
[  520.298379] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  520.300870] CR2: ffffb5c5c0748000 CR3: 000000024efa2003 CR4: 00000000001=
606e0

The SSD is Samsung EVO 860 500GB. I've never seen this kind of problem
when using btrfs so far. Perhaps it's some rare fs corruption?

Josef Miegl

--sttquksx3wii23tw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEhXfJKsVC4JYTeQttDVyVn2MnXf0FAl4J70wACgkQDVyVn2Mn
Xf3GYwf/WMc96nYvbaWxxaepY4bI8iPt36z5ytuqCRV/GMHMY3ClG2XnIFdq0hSS
XUJOEOnuhArSkeArcinT+X8luFqFRKe3MitWgQLjtEVb8ELt4Tmaht4vF77bWG4b
o2aD0WzMtiYUmLCFFj48zrIp3mlvFMacYQ60kXh1cJkenYnpOQhGLMLUe5owRLNW
EnH+BFqhJcvcIJjOgynU0ReKmFBeWhErGUuiKw1b5jYqT4GpvBykJQQfiIj8GbyL
A0WDHpuyY9Rmpg7UMbrK1MzUXgTE4KN95kzKShOHDCjZ+EoQWX6iX2hRNCIXIv9j
Uu+tbAsQf5dlzTwQW65V/BlObeRArQ==
=gstx
-----END PGP SIGNATURE-----

--sttquksx3wii23tw--
