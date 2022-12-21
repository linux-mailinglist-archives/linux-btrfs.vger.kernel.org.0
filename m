Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338AF652AFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 02:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLUBaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 20:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUB37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 20:29:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35B61006A
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 17:29:57 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGhyc-1p2q7w49wY-00Do4D; Wed, 21
 Dec 2022 02:29:51 +0100
Message-ID: <ddc034c6-655d-c3f1-8d69-544b743b7ac9@gmx.com>
Date:   Wed, 21 Dec 2022 09:29:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: recurring corruption with latest kernels
To:     Oliver Neukum <oneukum@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <148b838a-897a-90d6-7e6b-564238d58eb0@suse.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <148b838a-897a-90d6-7e6b-564238d58eb0@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2HH+9BmnzadIXiBORCub6BCLKWqUgrg84W11Wx7O77rZDTZ8AvO
 UxI2HImf0OJ5hOJgf04vswtMIhtFTAc9mnv3fgM/UHZ+UzcduV+pS/SgXlEo4JZpMjrG7ff
 5otjFtgrfSyQH6/ZdcF1FXGoCQELdcn9cK0eIZxWxEVN3RP3cogBd6X2BsRxZF+c/lm2PHZ
 tuPAe+6RJ4S2HrQGVA0+Q==
UI-OutboundReport: notjunk:1;M01:P0:8GHnBoI1X/A=;WMWi/b/BiF8lt1o4zF46qL+kbPY
 zmEDGRO2O6h/AmutVZPH/W3DV0hXfI/LIfwb0bjrqb6QX7X418a9loS8mb20Lhs9lYTQxbFCa
 N1QzS9269D0dE/r++W02CEBgROfaWv+zGIL4sbm4pBbHzlaQE1Rrjz6DjZ3PT4YrS6KLqbLOA
 MaZ49BEYJPoYM0fmfecbGPZccG9i8oop6C5E7oWBFJYD+M4g2Hqv1SDx1HePQov00D5NMOSAC
 TP2gwhHfrYMljTDqJesGJwg6WF3fiZjPJi8lO5hSFvivrDZdyYvdHp+95rsVqOC0VZZ7p5S8A
 FL0AvOQA0P7XuV/epgK7O3W7//EPwF8iNrcC/MTXDQ7NDCd3w0eVvtOx5GHaC7b4rT1YdUIv6
 yfcLvdHI0+BAJYKbX/aurYn1MIRBJrxM6i3vspCjyIvxekIiaAS3ugPCYNEVvrUghTCYZGfxn
 kLNAdKHIDMuC0GPDBpaIkCl2z/qEINQKTAbJH/iBh+aES/oxQ8XTVmgpsqtTFmrTtCa86U+Tl
 zz4GMfNouivpPEPiY9YYyk20VH++jk8U2do4E7zivwz19rPNghv790ieRtSiQEPmkxJ6R0fOb
 iUiorJulT5pjvHcDsH+17G2MN6+zp8NRIF8hN2zE12tZkdo/YFRFYCHn+CUm4nDJPSaEl2FkH
 jrN1QOGH4vWBrrPttvo2cVlRV0SXEZvV6A5F+IkmXXHKTDbFRmhyvWYdTwrHLdUGsMZqWvrG7
 5DhRCFURCaVWNEMUem8HrfSqZGRSlW4Yga8EgoaLtBsJweu3pQ/D/VdRpyEPIP6f2imMubkHd
 yQLaLKBaPvOaC0JtGscQ3PrfMwHzUizvhonYPuXuV43vBbN45h88iBBlj0Yjpc994VXvR2AFo
 NYPqpG/tTcj/SEXdYnM2cbw4YuHw2I+nOl5vfPMLnTdDzaF0iIx75dy2pwwwvSNWAH8YVDlcI
 VzQaL4Xc3//UHhFDI58HUKJvVds=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/20 22:12, Oliver Neukum wrote:
> Hi,
> 
> every few hours I am getting some corruption in btrfs.
> I got this trace:
> 
> [ 8506.475769] ------------[ cut here ]------------
> [ 8506.475773] WARNING: CPU: 2 PID: 388 at fs/btrfs/transaction.c:145 
> btrfs_put_transaction+0x112/0x140 [btrfs]
> [ 8506.475831] Modules linked in: tun(E) ccm(E) rfcomm(E) cmac(E) 
> algif_hash(E) algif_skcipher(E) af_alg(E) af_packet(E) nft_fib_inet(E) 
> nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) sr_mod(E) cdrom(E) 
> nft_reject_inet(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) 
> snd_usb_audio(E) snd_usbmidi_lib(E) snd_rawmidi(E) snd_seq_device(E) 
> nf_tables(E) ebtable_nat(E) ebtable_broute(E) ip6table_nat(E) 
> ip6table_mangle(E) ip6table_raw(E) ip6table_security(E) iptable_nat(E) 
> nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) 
> iptable_mangle(E) iptable_raw(E) bnep(E) iptable_security(E) 
> cdc_ether(E) usbnet(E) ip_set(E) nfnetlink(E) btusb(E) btrtl(E) btbcm(E) 
> ebtable_filter(E) btintel(E) btmtk(E) ebtables(E) bluetooth(E) 
> ip6table_filter(E) ip6_tables(E) uvcvideo(E) videobuf2_vmalloc(E) 
> videobuf2_memops(E) videobuf2_v4l2(E) iptable_filter(E) videodev(E) 
> ip_tables(E) ecdh_generic(E) r8152(E) videobuf2_common(E) x_tables(E) 
> uas(E) ecc(E) usb_storage(E) cdc_acm(E) mc(E) mii(E) bpfilter(E) crc16(E)
> [ 8506.475880]  amdgpu(E) dmi_sysfs(E) intel_rapl_msr(E) 
> intel_rapl_common(E) snd_ctl_led(E) iommu_v2(E) drm_buddy(E) 
> snd_hda_codec_realtek(E) gpu_sched(E) snd_hda_codec_generic(E) 
> i2c_algo_bit(E) snd_hda_codec_hdmi(E) iwlmvm(E) drm_display_helper(E) 
> snd_hda_intel(E) snd_intel_dspcfg(E) drm_ttm_helper(E) 
> snd_intel_sdw_acpi(E) ttm(E) snd_hda_codec(E) edac_mce_amd(E) cec(E) 
> snd_rn_pci_acp3x(E) rc_core(E) snd_acp_config(E) kvm_amd(E) 
> snd_hda_core(E) snd_soc_acpi(E) mac80211(E) snd_pci_acp3x(E) 
> snd_hwdep(E) libarc4(E) drm_kms_helper(E) kvm(E) snd_pcm(E) 
> syscopyarea(E) sysfillrect(E) irqbypass(E) ccp(E) sysimgblt(E) 
> snd_timer(E) crc32_pclmul(E) nls_iso8859_1(E) nls_cp437(E) 
> ghash_clmulni_intel(E) sha512_ssse3(E) vfat(E) iwlwifi(E) aesni_intel(E) 
> crypto_simd(E) fat(E) xfs(E) cryptd(E) r8169(E) cfg80211(E) 
> ipmi_devintf(E) thinkpad_acpi(E) realtek(E) mdio_devres(E) 
> ledtrig_audio(E) pcspkr(E) ucsi_acpi(E) platform_profile(E) 
> typec_ucsi(E) joydev(E) efi_pstore(E) wmi_bmof(E) typec(E) k10temp(E)
> [ 8506.475929]  i2c_piix4(E) rfkill(E) libphy(E) ipmi_msghandler(E) 
> roles(E) snd(E) ac(E) soundcore(E) i2c_scmi(E) button(E) acpi_cpufreq(E) 
> drm(E) fuse(E) configfs(E) hid_generic(E) usbhid(E) btrfs(E) 
> blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) rtsx_pci_sdmmc(E) 
> mmc_core(E) nvme(E) nvme_core(E) t10_pi(E) xhci_pci(E) ehci_pci(E) 
> xhci_hcd(E) rtsx_pci(E) ehci_hcd(E) crc64_rocksoft(E) crc32c_intel(E) 
> serio_raw(E) mfd_core(E) usbcore(E) crc64(E) battery(E) video(E) wmi(E) 
> backlight(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) 
> efivarfs(E)
> [ 8506.475967] CPU: 2 PID: 388 Comm: btrfs-transacti Tainted: 
> G            E      6.1.0-59.40-default+ #336
> [ 8506.475970] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [ 8506.475971] RIP: 0010:btrfs_put_transaction+0x112/0x140 [btrfs]
> [ 8506.476015] Code: e9 43 52 ed cb 0f 0b 5b 5d 41 5c be 03 00 00 00 48 
> 89 d7 e9 a0 a7 19 cc 0f 0b e9 0d ff ff ff 0f 0b eb d6 0f 0b e9 47 ff ff 
> ff <0f> 0b e9 50 ff ff ff 48 8b bf a0 01 00 00 48 c7 c6 e3 52 8f c0 e8
> [ 8506.476018] RSP: 0018:ffffaf578113fe30 EFLAGS: 00010282
> [ 8506.476020] RAX: ffff8fe3f87c0080 RBX: ffff8fe2f6a3c200 RCX: 
> 0000000000000001
> [ 8506.476022] RDX: ffff8fe2f6a3c228 RSI: 0000000000000246 RDI: 
> ffff8fe2f6a3c200
> [ 8506.476023] RBP: ffff8fe495c0a428 R08: 0000000000000000 R09: 
> ffffaf578113fd70
> [ 8506.476025] R10: ffffaf578113fd00 R11: ffffffffffffc000 R12: 
> ffffaf578113fe70
> [ 8506.476026] R13: ffff8fe495c0a000 R14: ffff8fe495c0a450 R15: 
> ffff8fe2f6a3c228
> [ 8506.476027] FS:  0000000000000000(0000) GS:ffff8fe530a80000(0000) 
> knlGS:0000000000000000
> [ 8506.476029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8506.476030] CR2: 00007fb6b311b000 CR3: 000000010cb30000 CR4: 
> 00000000003506e0
> [ 8506.476032] Call Trace:
> [ 8506.476035]  <TASK>
> [ 8506.476038]  btrfs_cleanup_transaction+0xd6/0x570 [btrfs]
> [ 8506.476082]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [ 8506.476088]  ? try_to_wake_up+0x93/0x580
> [ 8506.476094]  transaction_kthread+0x15e/0x1b0 [btrfs]
> [ 8506.476136]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> [ 8506.476177]  kthread+0xe8/0x110
> [ 8506.476181]  ? __pfx_kthread+0x10/0x10
> [ 8506.476183]  ret_from_fork+0x2c/0x50
> [ 8506.476189]  </TASK>
> [ 8506.476189] ---[ end trace 0000000000000000 ]---
> 
> This is v6.1+ (x86_64) running on NVME. I did not do anything in 
> particular when this happened.
> I cannot actively reproduce it, but it happens often.

Please give a full dmesg, not just the WARNING, which is useless in this 
particular case.

> 
> Upon check I am getting an error in pass 7.

And fulll btrfs check --readonly output.

Thanks,
Qu

> 
>      Regards
>          Oliver
