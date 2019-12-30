Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 904F412D4C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 23:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfL3WQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 17:16:44 -0500
Received: from ocelot.miegl.cz ([195.201.216.236]:46914 "EHLO ocelot.miegl.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfL3WQn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 17:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miegl.cz; s=dkim;
        t=1577744201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+KXkchuPV5jq/9o22Nd7rbLimEdUyG4VPQCjHXoQlY=;
        b=B5g0hsuF/pJrgRtUTXz86oV9qLWPECOirxGCqn5LpECYDZWB0bc3dh9gaunOQWqg+x+3vD
        fmRWxJU0FZLUvFwhGZNI/kW/GX6OUPNVuPMpLu0Dbnkloy12EoPXy4dPziY/VG0RY17Xnw
        FZ8E5SiFhRYxXohJ4YW6vG2XEt2gcprJbZjASo5Ye+KikCcyj8HApcn2lNY3TO824lRi2E
        1KTy//xmy//H3rmMu6x+A6PCA9qDY0G9aU3OdDAeopjsoiLrNUnmz9JGK4cYvPpXLTYpUH
        ACIxn0AreitWitrsCyWZA1t1f145xaTT4KxAl+hqxN0+ByU55/kzV7zxywtZMg==
Date:   Mon, 30 Dec 2019 23:16:36 +0100
From:   Josef Miegl <josef@miegl.cz>
To:     linux-btrfs@vger.kernel.org
Subject: Re: 5.4.6 page fault while running btfrs scrub
Message-ID: <20191230221636.y4nde7rlez3e4o7s@t420>
References: <20191230123635.bpcei77hntjx4th2@t420>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lqmcorcctehyqzph"
Content-Disposition: inline
In-Reply-To: <20191230123635.bpcei77hntjx4th2@t420>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--lqmcorcctehyqzph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Update:
I've recreated the btrfs volume and this time I ran scrub with linux
lts.

# uname -a
Linux t420 4.19.91-1-lts #1 SMP Sat, 21 Dec 2019 16:34:46 +0000 x86_64
GNU/Linux

dmesg:
[  134.598508] BUG: stack guard page was hit at 00000000f4d0d811 (stack is 000000002d0d1957..0000000094b2a7c8)
[  134.598518] kernel stack overflow (page fault): 0000 [#1] SMP NOPTI
[  134.598521] CPU: 4 PID: 698 Comm: btrfs Not tainted 4.19.91-1-lts #1
[  134.598523] Hardware name: LENOVO 4180A21/4180A21, BIOS CBET4000 4.9-2176-g2195f7af23 06/22/2019
[  134.598530] RIP: 0010:memcpy_erms+0x6/0x10
[  134.598533] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[  134.598535] RSP: 0018:ffffadbe811af898 EFLAGS: 00010246
[  134.598537] RAX: ffffadbe811afab8 RBX: ffffa3cce5fcca90 RCX: fffffffffffffabc
[  134.598538] RDX: 0000000000000004 RSI: ffffa3cce5fccff8 RDI: ffffadbe811b0000
[  134.598540] RBP: 0000000000000004 R08: 0000000000010000 R09: ffffa3cce5fcca80
[  134.598541] R10: ffffdf66c97eff80 R11: 0000000000000000 R12: 0000000000001000
[  134.598543] R13: dead000000000200 R14: dead000000000100 R15: ffffa3cce582c800
[  134.598545] FS:  00007f1795fb8700(0000) GS:ffffa3cce7500000(0000) knlGS:0000000000000000
[  134.598547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  134.598548] CR2: ffffadbe811b0000 CR3: 000000024e4b4002 CR4: 00000000001606e0
[  134.598550] Call Trace:
[  134.598591]  scrub_find_csum+0xf2/0x150 [btrfs]
[  134.598621]  scrub_stripe+0x8c8/0xfe0 [btrfs]
[  134.598645]  ? btrfs_check_space_for_delayed_refs+0xc7/0x100 [btrfs]
[  134.598649]  ? 0xffffffffc03fb000
[  134.598652]  ? 0xffffffffc0403000
[  134.598679]  ? btrfs_delayed_meta_helper+0x10/0x10 [btrfs]
[  134.598685] Modules linked in: ext4 mbcache jbd2 uas usb_storage ccm algif_aead des_generic algif_skcipher cmac md4 algif_hash af_alg snd_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic intel_rapl mousedev arc4 iwldvm mac80211 x86_pkg_temp_thermal i915 intel_powerclamp iwlwifi coretemp kvm_intel kvmgt vfio_mdev mdev vfio_iommu_type1 vfio i2c_algo_bit drm_kms_helper kvm btusb iTCO_wdt btrtl iTCO_vendor_support btbcm drm pcc_cpufreq btintel snd_hda_intel irqbypass cfg80211 uvcvideo bluetooth snd_hda_codec psmouse intel_cstate videobuf2_vmalloc videobuf2_memops intel_uncore videobuf2_v4l2 videobuf2_common intel_rapl_perf input_leds videodev i2c_i801 pcspkr media intel_gtt snd_hda_core ecdh_generic tpm_tis crc16 tpm_tis_core snd_hwdep thinkpad_acpi tpm snd_pcm rng_core agpgart e1000e battery
[  134.598717]  snd_timer nvram ac snd syscopyarea sysfillrect evdev rfkill sysimgblt mac_hid soundcore fb_sys_fops coreboot_table_acpi lpc_ich coreboot_table ip_tables x_tables btrfs libcrc32c crc32c_generic xor raid6_pq dm_crypt dm_mod sr_mod cdrom sd_mod serio_raw atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel libata aes_x86_64 sdhci_pci crypto_simd cqhci cryptd sdhci glue_helper scsi_mod ehci_pci mmc_core ehci_hcd i8042 serio
[  134.598739] ---[ end trace a21cf6d3169966ee ]---
[  134.598743] RIP: 0010:memcpy_erms+0x6/0x10
[  134.598745] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[  134.598746] RSP: 0018:ffffadbe811af898 EFLAGS: 00010246
[  134.598748] RAX: ffffadbe811afab8 RBX: ffffa3cce5fcca90 RCX: fffffffffffffabc
[  134.598749] RDX: 0000000000000004 RSI: ffffa3cce5fccff8 RDI: ffffadbe811b0000
[  134.598751] RBP: 0000000000000004 R08: 0000000000010000 R09: ffffa3cce5fcca80
[  134.598752] R10: ffffdf66c97eff80 R11: 0000000000000000 R12: 0000000000001000
[  134.598754] R13: dead000000000200 R14: dead000000000100 R15: ffffa3cce582c800
[  134.598756] FS:  00007f1795fb8700(0000) GS:ffffa3cce7500000(0000) knlGS:0000000000000000
[  134.598757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  134.598758] CR2: ffffadbe811b0000 CR3: 000000024e4b4002 CR4: 00000000001606e0

Is there a way to see which file(s) cause btrfs scrub to page fault?

Josef Miegl

--lqmcorcctehyqzph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEhXfJKsVC4JYTeQttDVyVn2MnXf0FAl4Kd0AACgkQDVyVn2Mn
Xf1+aQf/cVvwWzcgAZneqNJszcrrMpFxee25GI1OPk/WTcSQ7NNYE+yN7n99uctK
nOwmk8TnXvzJ+p27jsfQ3QjoSAfo+0xeyIlvXCIY/chX3JoO/44DnsjFRsVQzj24
xJ8ASHnpRDjxzbVcHifIljCsUE0Vbss699KcSfv1NyL9zb/jGXuv3OXf/WSYFrq1
X7w4xA3XB6T7XjMhswqGT5Ca8NWqhP0RrHtbAnwjCBzO08to3upK6v5J9t4e77Mf
XUbJaWiN0GcIi4GEPYf8Cyj5w7IYlu+hZJOqhY/imXII1i4JCPo+H6yRfVzRZ5Pu
VaFsrrLOwQPt6zOIR/LYbqmyCPMmJw==
=paq6
-----END PGP SIGNATURE-----

--lqmcorcctehyqzph--
