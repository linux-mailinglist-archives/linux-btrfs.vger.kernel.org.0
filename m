Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8427D664F3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 23:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjAJW7c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 17:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjAJW7R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 17:59:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC8F7653
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:59:12 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSbx3-1pLaiy3RGr-00Sycq; Tue, 10
 Jan 2023 23:59:03 +0100
Message-ID: <507d0831-36d8-edbc-a362-323762b9d7b2@gmx.com>
Date:   Wed, 11 Jan 2023 06:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: recurring corruption with latest kernels
To:     Oliver Neukum <oneukum@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <148b838a-897a-90d6-7e6b-564238d58eb0@suse.com>
 <ddc034c6-655d-c3f1-8d69-544b743b7ac9@gmx.com>
 <3dbe35f1-0815-73d9-f53e-86aacabf13e8@suse.com>
 <4531be20-470e-9984-6535-fd822c6c157e@gmx.com>
 <f6987484-b084-c6f8-31b4-dd2e3f3eb9d5@suse.com>
 <5ce6e59d-6c79-4d15-aa8a-990a299cd20c@gmx.com>
 <8fd4dbff-7d67-00b2-6f2f-7c87efb1da13@suse.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8fd4dbff-7d67-00b2-6f2f-7c87efb1da13@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rfI9vnFUDtNL8oFTX+7gCIYHfsR4AoCnNMWIxBtgCfDd+4abhoK
 4t9xitInbg8GNa/9KVvG5h7sxHoEgMNK4qqIYBkH9QPh6mgnfgPija9b1ui30ou8dynxXse
 6gbssc/vhf+XxRbaRZmNu0bWc+SLfTjYqney9Pynid4EXKt9pAF089IEOOq5ME8fAXU/eIt
 JSJm0EqKxm5lWe7WjuHTg==
UI-OutboundReport: notjunk:1;M01:P0:keOb+OOwfd8=;+UHjHDnqzEdS50jQ1h9mh8xogch
 hcOQS5OPOm+uqVmPPeJIWxsR5zMABwcTFhlHm7kJKBH7iYum2YVXnlBhuPhaz7THuE/I/k3BC
 oEe7aZaLLyF7M7J2WdGSevr8VXO+ZSV6Klu6OqJCGxhX6bDT6bAV7R6XrX2ze11gJ7fs81aEX
 akpLeWmFGLAI5YYThax1mSk/3SsOEchm1QI6jvR6+T0BKFDh7jOIpZYUCxe/c99J4m9rKCQU+
 o2mndA064W6i4TBYjIx+MQAHZ0b6JPr0KbnPrSAOTSAh2axQ2AYtaYZomwIhAv0JXwATGZnUc
 LzUZMZMq82nhcOKX6N+UimK9hyOO4di9wu4Vx373An8TBFm8rhLA7GcCVARVxhutll1dNbm/g
 Y2gPKGrMZEP+C4fWPAnh4VfM681xN591nk529ZQymLRJvhSzcmu0y2QRtnqBD7n9RC6BqFpOA
 dXzkXbIK8flMN9rA5owXA4cn3ziP9Z6j9ONdFKR6vOQLCHz3KjgSuCoHJh++fFkLQgLJRsLxT
 ynH7aJiH9N2mvBbvzgOZbWMCwlXbMJIqtgs0t3veq1Tq8BUCsLqZzkgwx5KIZjghC0+4islkQ
 F5EGzEhqOhpkg41ywgWsaiED3GeHyaHMqa4OWgD/NwRJUillrBEQ25x8CxVuOnGhp3fiQc+3D
 /ffnn7iqgAf2tvm3AOuKJKgIqThvkn/G8TnxvOgg1AMtrX2UR5JJ11DsLRPxql8mkjhlxGJIK
 V9sYByRpMRMhThxdVm0Rdn7zHJhGIjX3jpBlD+MQOqgpSM+GoFL/73tT/tddptyOiPYq05vkW
 K2Y2ShZlWRYLRCdkBFuCYXI59IrX2p4l2NJZQJ2L+gkTfrxBT1uBMLC7FfYRKNYE12LjajqVX
 ijWsgcgAc+hYLyUd2ja5YFhS4COaAe5u7Z1GEMzjdZgs+d94b/er0Cppl91vsILpdn4d6MPCr
 PE+OepUtHQEhM3AvO5m00TtB/44=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/10 22:42, Oliver Neukum wrote:
> On 28.12.22 00:20, Qu Wenruo wrote:
> 
>> --clear-space-cache is an independent option, no need to --repair.
> 
> Hi,
> 
> I tried that with v6.2-rc2 now.
> It does not help. The corruption persists and the fs tends to
> go into read-only.

OK, it looks like you're using RAID0, which can cause false level 
mismatch error (without any error message).

Unfortunately the fix is only merged into v6.2-rc3, not rc2.

Thanks,
Qu
> 
>      Regards
>          Oliver
> 
> 
> [ 5478.760828] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5478.760829] CR2: 00007fd4ce2dd750 CR3: 00000001a49ee000 CR4: 
> 00000000003506e0
> [ 5478.760831] Call Trace:
> [ 5478.760834]  <TASK>
> [ 5478.760838]  btrfs_commit_transaction+0x30d/0xb50 [btrfs]
> [ 5478.760910]  ? start_transaction+0xc5/0x5e0 [btrfs]
> [ 5478.760987]  btrfs_qgroup_rescan+0x46/0xc0 [btrfs]
> [ 5478.761079]  btrfs_ioctl+0x1b6c/0x2580 [btrfs]
> [ 5478.761166]  ? btrfs_release_file+0x3a/0x70 [btrfs]
> [ 5478.761245]  ? __rseq_handle_notify_resume+0xaa/0x4a0
> [ 5478.761250]  ? __seccomp_filter+0x320/0x4f0
> [ 5478.761253]  __x64_sys_ioctl+0x94/0xd0
> [ 5478.761256]  do_syscall_64+0x3e/0x90
> [ 5478.761261]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 5478.761264] RIP: 0033:0x7fd4ce50d9bf
> [ 5478.761266] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
> 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 5478.761267] RSP: 002b:00007fd4cdd2c7e0 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [ 5478.761269] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 
> 00007fd4ce50d9bf
> [ 5478.761271] RDX: 00007fd4cdd2c840 RSI: 000000004040942c RDI: 
> 0000000000000007
> [ 5478.761273] RBP: 00007fd4cdd2c840 R08: 0000000000000000 R09: 
> 0000000000000000
> [ 5478.761274] R10: 0000000000001000 R11: 0000000000000246 R12: 
> 000055e627acdca0
> [ 5478.761278] R13: 00007fd4cdd2ca30 R14: 00007fd4cdd2ca60 R15: 
> 00007fd4cdd2ca1f
> [ 5478.761282]  </TASK>
> [ 5478.761282] ---[ end trace 0000000000000000 ]---
> [ 5478.761331] ------------[ cut here ]------------
> [ 5478.761332] WARNING: CPU: 6 PID: 26187 at fs/btrfs/qgroup.c:2770 
> btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.761418] Modules linked in: tun(E) snd_seq_dummy(E) snd_seq(E) 
> ccm(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) 
> snd_usb_audio(E) snd_usbmidi_lib(E) snd_rawmidi(E) snd_seq_device(E) 
> af_packet(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
> sr_mod(E) cdrom(E) nft_reject_inet(E) nft_reject(E) nft_ct(E) 
> nft_chain_nat(E) cdc_ether(E) usbnet(E) nf_tables(E) ebtable_nat(E) 
> ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) 
> ip6table_security(E) uvcvideo(E) iptable_nat(E) nf_nat(E) 
> videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) 
> nf_conntrack(E) videodev(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) 
> videobuf2_common(E) mc(E) iptable_mangle(E) iptable_raw(E) 
> iptable_security(E) r8152(E) mii(E) bnep(E) ip_set(E) nfnetlink(E) 
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) 
> iptable_filter(E) bpfilter(E) btusb(E) btrtl(E) btbcm(E) btintel(E) 
> btmtk(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) intel_rapl_msr(E)
> [ 5478.761491]  intel_rapl_common(E) iwlmvm(E) nls_iso8859_1(E) 
> snd_ctl_led(E) nls_cp437(E) snd_hda_codec_realtek(E) vfat(E) fat(E) 
> snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) edac_mce_amd(E) 
> snd_hda_intel(E) snd_intel_dspcfg(E) mac80211(E) snd_intel_sdw_acpi(E) 
> kvm_amd(E) libarc4(E) snd_hda_codec(E) snd_hda_core(E) kvm(E) iwlwifi(E) 
> snd_hwdep(E) thinkpad_acpi(E) snd_pcm(E) r8169(E) snd_rn_pci_acp3x(E) 
> ledtrig_audio(E) irqbypass(E) snd_acp_config(E) snd_timer(E) pcspkr(E) 
> efi_pstore(E) platform_profile(E) realtek(E) cfg80211(E) mdio_devres(E) 
> snd_soc_acpi(E) wmi_bmof(E) k10temp(E) i2c_piix4(E) snd_pci_acp3x(E) 
> snd(E) ipmi_devintf(E) xfs(E) rfkill(E) libphy(E) ipmi_msghandler(E) 
> soundcore(E) ac(E) button(E) i2c_scmi(E) acpi_cpufreq(E) joydev(E) 
> fuse(E) configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) uas(E) 
> usb_storage(E) hid_generic(E) usbhid(E) amdgpu(E) crc32_pclmul(E) 
> i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) iommu_v2(E) drm_buddy(E) 
> gpu_sched(E) drm_display_helper(E)
> [ 5478.761557]  ghash_clmulni_intel(E) sha512_ssse3(E) nvme(E) 
> drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme_core(E) 
> sysimgblt(E) rtsx_pci_sdmmc(E) t10_pi(E) mmc_core(E) drm(E) ucsi_acpi(E) 
> xhci_pci(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) ehci_pci(E) 
> xhci_hcd(E) aesni_intel(E) cec(E) rtsx_pci(E) ehci_hcd(E) typec_ucsi(E) 
> crypto_simd(E) cryptd(E) roles(E) ccp(E) rc_core(E) mfd_core(E) 
> usbcore(E) crc64(E) typec(E) battery(E) video(E) wmi(E) backlight(E) 
> serio_raw(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) 
> crc32c_intel(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) 
> efivarfs(E)
> [ 5478.761603] CPU: 6 PID: 26187 Comm: snapperd Tainted: G        W   
> E      6.2.0-rc2-pci_debug-59.40-default+ #356
> [ 5478.761608] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [ 5478.761610] RIP: 0010:btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.761698] Code: 4c 89 c7 31 d2 4c 89 44 24 08 48 89 de e8 5d a0 ff 
> ff 49 8b 7f 38 31 d2 48 89 de e8 4f a0 ff ff 4c 8b 44 24 08 e9 b1 fe ff 
> ff <0f> 0b 31 f6 48 8d 7c 24 10 e8 67 6d ff ff 89 c3 85 c0 0f 88 f6 fe
> [ 5478.761700] RSP: 0018:ffffa55001e37cd8 EFLAGS: 00010246
> [ 5478.761701] RAX: 000000223df00000 RBX: 0000000000000000 RCX: 
> 0000000000000000
> [ 5478.761703] RDX: ffff8c140dffe2c0 RSI: ffffffffa645be6e RDI: 
> ffffa55001e37d58
> [ 5478.761704] RBP: ffff8c1395a6bf60 R08: ffff8c1395a6bf60 R09: 
> ffff8c1388ec1078
> [ 5478.761706] R10: 0000000000000000 R11: ffff8c1383c81800 R12: 
> 000000000000001b
> [ 5478.761707] R13: ffff8c1388ec1000 R14: ffff8c13c0737bc8 R15: 
> ffff8c140dffe2c0
> [ 5478.761709] FS:  00007fd4cdd2d6c0(0000) GS:ffff8c1630900000(0000) 
> knlGS:0000000000000000
> [ 5478.761711] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5478.761712] CR2: 00007fd4ce2dd750 CR3: 00000001a49ee000 CR4: 
> 00000000003506e0
> [ 5478.761713] Call Trace:
> [ 5478.761715]  <TASK>
> [ 5478.761719]  btrfs_commit_transaction+0x30d/0xb50 [btrfs]
> [ 5478.761800]  ? start_transaction+0xc5/0x5e0 [btrfs]
> [ 5478.761877]  btrfs_qgroup_rescan+0x46/0xc0 [btrfs]
> [ 5478.761965]  btrfs_ioctl+0x1b6c/0x2580 [btrfs]
> [ 5478.762048]  ? btrfs_release_file+0x3a/0x70 [btrfs]
> [ 5478.762130]  ? __rseq_handle_notify_resume+0xaa/0x4a0
> [ 5478.762135]  ? __seccomp_filter+0x320/0x4f0
> [ 5478.762139]  __x64_sys_ioctl+0x94/0xd0
> [ 5478.762145]  do_syscall_64+0x3e/0x90
> [ 5478.762149]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 5478.762152] RIP: 0033:0x7fd4ce50d9bf
> [ 5478.762160] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
> 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 5478.762162] RSP: 002b:00007fd4cdd2c7e0 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [ 5478.762164] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 
> 00007fd4ce50d9bf
> [ 5478.762166] RDX: 00007fd4cdd2c840 RSI: 000000004040942c RDI: 
> 0000000000000007
> [ 5478.762167] RBP: 00007fd4cdd2c840 R08: 0000000000000000 R09: 
> 0000000000000000
> [ 5478.762168] R10: 0000000000001000 R11: 0000000000000246 R12: 
> 000055e627acdca0
> [ 5478.762170] R13: 00007fd4cdd2ca30 R14: 00007fd4cdd2ca60 R15: 
> 00007fd4cdd2ca1f
> [ 5478.762174]  </TASK>
> [ 5478.762176] ---[ end trace 0000000000000000 ]---
> [ 5478.762254] ------------[ cut here ]------------
> [ 5478.762256] WARNING: CPU: 6 PID: 26187 at fs/btrfs/qgroup.c:2770 
> btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.762345] Modules linked in: tun(E) snd_seq_dummy(E) snd_seq(E) 
> ccm(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) 
> snd_usb_audio(E) snd_usbmidi_lib(E) snd_rawmidi(E) snd_seq_device(E) 
> af_packet(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
> sr_mod(E) cdrom(E) nft_reject_inet(E) nft_reject(E) nft_ct(E) 
> nft_chain_nat(E) cdc_ether(E) usbnet(E) nf_tables(E) ebtable_nat(E) 
> ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) 
> ip6table_security(E) uvcvideo(E) iptable_nat(E) nf_nat(E) 
> videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) 
> nf_conntrack(E) videodev(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) 
> videobuf2_common(E) mc(E) iptable_mangle(E) iptable_raw(E) 
> iptable_security(E) r8152(E) mii(E) bnep(E) ip_set(E) nfnetlink(E) 
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) 
> iptable_filter(E) bpfilter(E) btusb(E) btrtl(E) btbcm(E) btintel(E) 
> btmtk(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) intel_rapl_msr(E)
> [ 5478.762400]  intel_rapl_common(E) iwlmvm(E) nls_iso8859_1(E) 
> snd_ctl_led(E) nls_cp437(E) snd_hda_codec_realtek(E) vfat(E) fat(E) 
> snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) edac_mce_amd(E) 
> snd_hda_intel(E) snd_intel_dspcfg(E) mac80211(E) snd_intel_sdw_acpi(E) 
> kvm_amd(E) libarc4(E) snd_hda_codec(E) snd_hda_core(E) kvm(E) iwlwifi(E) 
> snd_hwdep(E) thinkpad_acpi(E) snd_pcm(E) r8169(E) snd_rn_pci_acp3x(E) 
> ledtrig_audio(E) irqbypass(E) snd_acp_config(E) snd_timer(E) pcspkr(E) 
> efi_pstore(E) platform_profile(E) realtek(E) cfg80211(E) mdio_devres(E) 
> snd_soc_acpi(E) wmi_bmof(E) k10temp(E) i2c_piix4(E) snd_pci_acp3x(E) 
> snd(E) ipmi_devintf(E) xfs(E) rfkill(E) libphy(E) ipmi_msghandler(E) 
> soundcore(E) ac(E) button(E) i2c_scmi(E) acpi_cpufreq(E) joydev(E) 
> fuse(E) configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) uas(E) 
> usb_storage(E) hid_generic(E) usbhid(E) amdgpu(E) crc32_pclmul(E) 
> i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) iommu_v2(E) drm_buddy(E) 
> gpu_sched(E) drm_display_helper(E)
> [ 5478.762455]  ghash_clmulni_intel(E) sha512_ssse3(E) nvme(E) 
> drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme_core(E) 
> sysimgblt(E) rtsx_pci_sdmmc(E) t10_pi(E) mmc_core(E) drm(E) ucsi_acpi(E) 
> xhci_pci(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) ehci_pci(E) 
> xhci_hcd(E) aesni_intel(E) cec(E) rtsx_pci(E) ehci_hcd(E) typec_ucsi(E) 
> crypto_simd(E) cryptd(E) roles(E) ccp(E) rc_core(E) mfd_core(E) 
> usbcore(E) crc64(E) typec(E) battery(E) video(E) wmi(E) backlight(E) 
> serio_raw(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) 
> crc32c_intel(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) 
> efivarfs(E)
> [ 5478.762500] CPU: 6 PID: 26187 Comm: snapperd Tainted: G        W   
> E      6.2.0-rc2-pci_debug-59.40-default+ #356
> [ 5478.762500] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [ 5478.762501] RIP: 0010:btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.762587] Code: 4c 89 c7 31 d2 4c 89 44 24 08 48 89 de e8 5d a0 ff 
> ff 49 8b 7f 38 31 d2 48 89 de e8 4f a0 ff ff 4c 8b 44 24 08 e9 b1 fe ff 
> ff <0f> 0b 31 f6 48 8d 7c 24 10 e8 67 6d ff ff 89 c3 85 c0 0f 88 f6 fe
> [ 5478.762589] RSP: 0018:ffffa55001e37cd8 EFLAGS: 00010246
> [ 5478.762591] RAX: 000000223df14000 RBX: 0000000000000000 RCX: 
> 0000000000000000
> [ 5478.762596] RDX: ffff8c13a5e69f00 RSI: ffffffffa645be6e RDI: 
> ffffa55001e37d58
> [ 5478.762597] RBP: ffff8c1395a6bf60 R08: ffff8c1395a6bf60 R09: 
> ffff8c1388ec1078
> [ 5478.762598] R10: 0000000000000000 R11: ffff8c1383c81800 R12: 
> 000000000000001c
> [ 5478.762599] R13: ffff8c1388ec1000 R14: ffff8c13c0737bc8 R15: 
> ffff8c13a5e69f00
> [ 5478.762600] FS:  00007fd4cdd2d6c0(0000) GS:ffff8c1630900000(0000) 
> knlGS:0000000000000000
> [ 5478.762602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5478.762604] CR2: 00007fd4ce2dd750 CR3: 00000001a49ee000 CR4: 
> 00000000003506e0
> [ 5478.762606] Call Trace:
> [ 5478.762607]  <TASK>
> [ 5478.762611]  btrfs_commit_transaction+0x30d/0xb50 [btrfs]
> [ 5478.762687]  ? start_transaction+0xc5/0x5e0 [btrfs]
> [ 5478.762770]  btrfs_qgroup_rescan+0x46/0xc0 [btrfs]
> [ 5478.762856]  btrfs_ioctl+0x1b6c/0x2580 [btrfs]
> [ 5478.762947]  ? btrfs_release_file+0x3a/0x70 [btrfs]
> [ 5478.763030]  ? __rseq_handle_notify_resume+0xaa/0x4a0
> [ 5478.763038]  ? __seccomp_filter+0x320/0x4f0
> [ 5478.763041]  __x64_sys_ioctl+0x94/0xd0
> [ 5478.763048]  do_syscall_64+0x3e/0x90
> [ 5478.763050]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 5478.763053] RIP: 0033:0x7fd4ce50d9bf
> [ 5478.763055] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
> 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 5478.763057] RSP: 002b:00007fd4cdd2c7e0 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [ 5478.763063] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 
> 00007fd4ce50d9bf
> [ 5478.763063] RDX: 00007fd4cdd2c840 RSI: 000000004040942c RDI: 
> 0000000000000007
> [ 5478.763063] RBP: 00007fd4cdd2c840 R08: 0000000000000000 R09: 
> 0000000000000000
> [ 5478.763064] R10: 0000000000001000 R11: 0000000000000246 R12: 
> 000055e627acdca0
> [ 5478.763065] R13: 00007fd4cdd2ca30 R14: 00007fd4cdd2ca60 R15: 
> 00007fd4cdd2ca1f
> [ 5478.763069]  </TASK>
> [ 5478.763069] ---[ end trace 0000000000000000 ]---
> [ 5478.763116] ------------[ cut here ]------------
> [ 5478.763119] WARNING: CPU: 6 PID: 26187 at fs/btrfs/qgroup.c:2770 
> btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.763212] Modules linked in: tun(E) snd_seq_dummy(E) snd_seq(E) 
> ccm(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) 
> snd_usb_audio(E) snd_usbmidi_lib(E) snd_rawmidi(E) snd_seq_device(E) 
> af_packet(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
> sr_mod(E) cdrom(E) nft_reject_inet(E) nft_reject(E) nft_ct(E) 
> nft_chain_nat(E) cdc_ether(E) usbnet(E) nf_tables(E) ebtable_nat(E) 
> ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) 
> ip6table_security(E) uvcvideo(E) iptable_nat(E) nf_nat(E) 
> videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) 
> nf_conntrack(E) videodev(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) 
> videobuf2_common(E) mc(E) iptable_mangle(E) iptable_raw(E) 
> iptable_security(E) r8152(E) mii(E) bnep(E) ip_set(E) nfnetlink(E) 
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) 
> iptable_filter(E) bpfilter(E) btusb(E) btrtl(E) btbcm(E) btintel(E) 
> btmtk(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) intel_rapl_msr(E)
> [ 5478.763272]  intel_rapl_common(E) iwlmvm(E) nls_iso8859_1(E) 
> snd_ctl_led(E) nls_cp437(E) snd_hda_codec_realtek(E) vfat(E) fat(E) 
> snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) edac_mce_amd(E) 
> snd_hda_intel(E) snd_intel_dspcfg(E) mac80211(E) snd_intel_sdw_acpi(E) 
> kvm_amd(E) libarc4(E) snd_hda_codec(E) snd_hda_core(E) kvm(E) iwlwifi(E) 
> snd_hwdep(E) thinkpad_acpi(E) snd_pcm(E) r8169(E) snd_rn_pci_acp3x(E) 
> ledtrig_audio(E) irqbypass(E) snd_acp_config(E) snd_timer(E) pcspkr(E) 
> efi_pstore(E) platform_profile(E) realtek(E) cfg80211(E) mdio_devres(E) 
> snd_soc_acpi(E) wmi_bmof(E) k10temp(E) i2c_piix4(E) snd_pci_acp3x(E) 
> snd(E) ipmi_devintf(E) xfs(E) rfkill(E) libphy(E) ipmi_msghandler(E) 
> soundcore(E) ac(E) button(E) i2c_scmi(E) acpi_cpufreq(E) joydev(E) 
> fuse(E) configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) uas(E) 
> usb_storage(E) hid_generic(E) usbhid(E) amdgpu(E) crc32_pclmul(E) 
> i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) iommu_v2(E) drm_buddy(E) 
> gpu_sched(E) drm_display_helper(E)
> [ 5478.763323]  ghash_clmulni_intel(E) sha512_ssse3(E) nvme(E) 
> drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme_core(E) 
> sysimgblt(E) rtsx_pci_sdmmc(E) t10_pi(E) mmc_core(E) drm(E) ucsi_acpi(E) 
> xhci_pci(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) ehci_pci(E) 
> xhci_hcd(E) aesni_intel(E) cec(E) rtsx_pci(E) ehci_hcd(E) typec_ucsi(E) 
> crypto_simd(E) cryptd(E) roles(E) ccp(E) rc_core(E) mfd_core(E) 
> usbcore(E) crc64(E) typec(E) battery(E) video(E) wmi(E) backlight(E) 
> serio_raw(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) 
> crc32c_intel(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) 
> efivarfs(E)
> [ 5478.763363] CPU: 6 PID: 26187 Comm: snapperd Tainted: G        W   
> E      6.2.0-rc2-pci_debug-59.40-default+ #356
> [ 5478.763365] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [ 5478.763366] RIP: 0010:btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.763456] Code: 4c 89 c7 31 d2 4c 89 44 24 08 48 89 de e8 5d a0 ff 
> ff 49 8b 7f 38 31 d2 48 89 de e8 4f a0 ff ff 4c 8b 44 24 08 e9 b1 fe ff 
> ff <0f> 0b 31 f6 48 8d 7c 24 10 e8 67 6d ff ff 89 c3 85 c0 0f 88 f6 fe
> [ 5478.763458] RSP: 0018:ffffa55001e37cd8 EFLAGS: 00010246
> [ 5478.763460] RAX: 000000223df18000 RBX: 0000000000000000 RCX: 
> 0000000000000000
> [ 5478.763461] RDX: ffff8c13a5e69240 RSI: ffffffffa645be6e RDI: 
> ffffa55001e37d58
> [ 5478.763463] RBP: ffff8c1395a6bf60 R08: ffff8c1395a6bf60 R09: 
> ffff8c1388ec1078
> [ 5478.763464] R10: 0000000000000000 R11: ffff8c13d04d4000 R12: 
> 000000000000001d
> [ 5478.763465] R13: ffff8c1388ec1000 R14: ffff8c13c0737bc8 R15: 
> ffff8c13a5e69240
> [ 5478.763471] FS:  00007fd4cdd2d6c0(0000) GS:ffff8c1630900000(0000) 
> knlGS:0000000000000000
> [ 5478.763473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5478.763475] CR2: 00007fd4ce2dd750 CR3: 00000001a49ee000 CR4: 
> 00000000003506e0
> [ 5478.763476] Call Trace:
> [ 5478.763478]  <TASK>
> [ 5478.763481]  btrfs_commit_transaction+0x30d/0xb50 [btrfs]
> [ 5478.763556]  ? start_transaction+0xc5/0x5e0 [btrfs]
> [ 5478.763633]  btrfs_qgroup_rescan+0x46/0xc0 [btrfs]
> [ 5478.763722]  btrfs_ioctl+0x1b6c/0x2580 [btrfs]
> [ 5478.763813]  ? btrfs_release_file+0x3a/0x70 [btrfs]
> [ 5478.763895]  ? __rseq_handle_notify_resume+0xaa/0x4a0
> [ 5478.763899]  ? __seccomp_filter+0x320/0x4f0
> [ 5478.763902]  __x64_sys_ioctl+0x94/0xd0
> [ 5478.763905]  do_syscall_64+0x3e/0x90
> [ 5478.763908]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 5478.763911] RIP: 0033:0x7fd4ce50d9bf
> [ 5478.763913] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
> 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 5478.763915] RSP: 002b:00007fd4cdd2c7e0 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [ 5478.763917] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 
> 00007fd4ce50d9bf
> [ 5478.763924] RDX: 00007fd4cdd2c840 RSI: 000000004040942c RDI: 
> 0000000000000007
> [ 5478.763924] RBP: 00007fd4cdd2c840 R08: 0000000000000000 R09: 
> 0000000000000000
> [ 5478.763926] R10: 0000000000001000 R11: 0000000000000246 R12: 
> 000055e627acdca0
> [ 5478.763930] R13: 00007fd4cdd2ca30 R14: 00007fd4cdd2ca60 R15: 
> 00007fd4cdd2ca1f
> [ 5478.763931]  </TASK>
> [ 5478.763932] ---[ end trace 0000000000000000 ]---
> [ 5478.763982] ------------[ cut here ]------------
> [ 5478.763984] WARNING: CPU: 6 PID: 26187 at fs/btrfs/qgroup.c:2770 
> btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.764075] Modules linked in: tun(E) snd_seq_dummy(E) snd_seq(E) 
> ccm(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) 
> snd_usb_audio(E) snd_usbmidi_lib(E) snd_rawmidi(E) snd_seq_device(E) 
> af_packet(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
> sr_mod(E) cdrom(E) nft_reject_inet(E) nft_reject(E) nft_ct(E) 
> nft_chain_nat(E) cdc_ether(E) usbnet(E) nf_tables(E) ebtable_nat(E) 
> ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) 
> ip6table_security(E) uvcvideo(E) iptable_nat(E) nf_nat(E) 
> videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) 
> nf_conntrack(E) videodev(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) 
> videobuf2_common(E) mc(E) iptable_mangle(E) iptable_raw(E) 
> iptable_security(E) r8152(E) mii(E) bnep(E) ip_set(E) nfnetlink(E) 
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) 
> iptable_filter(E) bpfilter(E) btusb(E) btrtl(E) btbcm(E) btintel(E) 
> btmtk(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) intel_rapl_msr(E)
> [ 5478.764131]  intel_rapl_common(E) iwlmvm(E) nls_iso8859_1(E) 
> snd_ctl_led(E) nls_cp437(E) snd_hda_codec_realtek(E) vfat(E) fat(E) 
> snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) edac_mce_amd(E) 
> snd_hda_intel(E) snd_intel_dspcfg(E) mac80211(E) snd_intel_sdw_acpi(E) 
> kvm_amd(E) libarc4(E) snd_hda_codec(E) snd_hda_core(E) kvm(E) iwlwifi(E) 
> snd_hwdep(E) thinkpad_acpi(E) snd_pcm(E) r8169(E) snd_rn_pci_acp3x(E) 
> ledtrig_audio(E) irqbypass(E) snd_acp_config(E) snd_timer(E) pcspkr(E) 
> efi_pstore(E) platform_profile(E) realtek(E) cfg80211(E) mdio_devres(E) 
> snd_soc_acpi(E) wmi_bmof(E) k10temp(E) i2c_piix4(E) snd_pci_acp3x(E) 
> snd(E) ipmi_devintf(E) xfs(E) rfkill(E) libphy(E) ipmi_msghandler(E) 
> soundcore(E) ac(E) button(E) i2c_scmi(E) acpi_cpufreq(E) joydev(E) 
> fuse(E) configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) uas(E) 
> usb_storage(E) hid_generic(E) usbhid(E) amdgpu(E) crc32_pclmul(E) 
> i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) iommu_v2(E) drm_buddy(E) 
> gpu_sched(E) drm_display_helper(E)
> [ 5478.764188]  ghash_clmulni_intel(E) sha512_ssse3(E) nvme(E) 
> drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme_core(E) 
> sysimgblt(E) rtsx_pci_sdmmc(E) t10_pi(E) mmc_core(E) drm(E) ucsi_acpi(E) 
> xhci_pci(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) ehci_pci(E) 
> xhci_hcd(E) aesni_intel(E) cec(E) rtsx_pci(E) ehci_hcd(E) typec_ucsi(E) 
> crypto_simd(E) cryptd(E) roles(E) ccp(E) rc_core(E) mfd_core(E) 
> usbcore(E) crc64(E) typec(E) battery(E) video(E) wmi(E) backlight(E) 
> serio_raw(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) 
> crc32c_intel(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) 
> efivarfs(E)
> [ 5478.764234] CPU: 6 PID: 26187 Comm: snapperd Tainted: G        W   
> E      6.2.0-rc2-pci_debug-59.40-default+ #356
> [ 5478.764235] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [ 5478.764236] RIP: 0010:btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.764325] Code: 4c 89 c7 31 d2 4c 89 44 24 08 48 89 de e8 5d a0 ff 
> ff 49 8b 7f 38 31 d2 48 89 de e8 4f a0 ff ff 4c 8b 44 24 08 e9 b1 fe ff 
> ff <0f> 0b 31 f6 48 8d 7c 24 10 e8 67 6d ff ff 89 c3 85 c0 0f 88 f6 fe
> [ 5478.764327] RSP: 0018:ffffa55001e37cd8 EFLAGS: 00010246
> [ 5478.764330] RAX: 000000223df1c000 RBX: 0000000000000000 RCX: 
> 0000000000000000
> [ 5478.764331] RDX: ffff8c149fef9100 RSI: ffffffffa645be6e RDI: 
> ffffa55001e37d58
> [ 5478.764332] RBP: ffff8c1395a6bf60 R08: ffff8c1395a6bf60 R09: 
> ffff8c1388ec1078
> [ 5478.764333] R10: 0000000000000000 R11: ffff8c13d04d4000 R12: 
> 000000000000001e
> [ 5478.764334] R13: ffff8c1388ec1000 R14: ffff8c13c0737bc8 R15: 
> ffff8c149fef9100
> [ 5478.764335] FS:  00007fd4cdd2d6c0(0000) GS:ffff8c1630900000(0000) 
> knlGS:0000000000000000
> [ 5478.764337] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5478.764338] CR2: 00007fd4ce2dd750 CR3: 00000001a49ee000 CR4: 
> 00000000003506e0
> [ 5478.764339] Call Trace:
> [ 5478.764342]  <TASK>
> [ 5478.764346]  btrfs_commit_transaction+0x30d/0xb50 [btrfs]
> [ 5478.764426]  ? start_transaction+0xc5/0x5e0 [btrfs]
> [ 5478.764509]  btrfs_qgroup_rescan+0x46/0xc0 [btrfs]
> [ 5478.764595]  btrfs_ioctl+0x1b6c/0x2580 [btrfs]
> [ 5478.764685]  ? btrfs_release_file+0x3a/0x70 [btrfs]
> [ 5478.764759]  ? __rseq_handle_notify_resume+0xaa/0x4a0
> [ 5478.764763]  ? __seccomp_filter+0x320/0x4f0
> [ 5478.764766]  __x64_sys_ioctl+0x94/0xd0
> [ 5478.764771]  do_syscall_64+0x3e/0x90
> [ 5478.764774]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 5478.764776] RIP: 0033:0x7fd4ce50d9bf
> [ 5478.764778] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
> 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 5478.764780] RSP: 002b:00007fd4cdd2c7e0 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [ 5478.764782] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 
> 00007fd4ce50d9bf
> [ 5478.764784] RDX: 00007fd4cdd2c840 RSI: 000000004040942c RDI: 
> 0000000000000007
> [ 5478.764787] RBP: 00007fd4cdd2c840 R08: 0000000000000000 R09: 
> 0000000000000000
> [ 5478.764788] R10: 0000000000001000 R11: 0000000000000246 R12: 
> 000055e627acdca0
> [ 5478.764789] R13: 00007fd4cdd2ca30 R14: 00007fd4cdd2ca60 R15: 
> 00007fd4cdd2ca1f
> [ 5478.764793]  </TASK>
> [ 5478.764794] ---[ end trace 0000000000000000 ]---
> [ 5478.764850] ------------[ cut here ]------------
> [ 5478.764851] WARNING: CPU: 6 PID: 26187 at fs/btrfs/qgroup.c:2770 
> btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.764935] Modules linked in: tun(E) snd_seq_dummy(E) snd_seq(E) 
> ccm(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) 
> snd_usb_audio(E) snd_usbmidi_lib(E) snd_rawmidi(E) snd_seq_device(E) 
> af_packet(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
> sr_mod(E) cdrom(E) nft_reject_inet(E) nft_reject(E) nft_ct(E) 
> nft_chain_nat(E) cdc_ether(E) usbnet(E) nf_tables(E) ebtable_nat(E) 
> ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) 
> ip6table_security(E) uvcvideo(E) iptable_nat(E) nf_nat(E) 
> videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) 
> nf_conntrack(E) videodev(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) 
> videobuf2_common(E) mc(E) iptable_mangle(E) iptable_raw(E) 
> iptable_security(E) r8152(E) mii(E) bnep(E) ip_set(E) nfnetlink(E) 
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) 
> iptable_filter(E) bpfilter(E) btusb(E) btrtl(E) btbcm(E) btintel(E) 
> btmtk(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) intel_rapl_msr(E)
> [ 5478.764991]  intel_rapl_common(E) iwlmvm(E) nls_iso8859_1(E) 
> snd_ctl_led(E) nls_cp437(E) snd_hda_codec_realtek(E) vfat(E) fat(E) 
> snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) edac_mce_amd(E) 
> snd_hda_intel(E) snd_intel_dspcfg(E) mac80211(E) snd_intel_sdw_acpi(E) 
> kvm_amd(E) libarc4(E) snd_hda_codec(E) snd_hda_core(E) kvm(E) iwlwifi(E) 
> snd_hwdep(E) thinkpad_acpi(E) snd_pcm(E) r8169(E) snd_rn_pci_acp3x(E) 
> ledtrig_audio(E) irqbypass(E) snd_acp_config(E) snd_timer(E) pcspkr(E) 
> efi_pstore(E) platform_profile(E) realtek(E) cfg80211(E) mdio_devres(E) 
> snd_soc_acpi(E) wmi_bmof(E) k10temp(E) i2c_piix4(E) snd_pci_acp3x(E) 
> snd(E) ipmi_devintf(E) xfs(E) rfkill(E) libphy(E) ipmi_msghandler(E) 
> soundcore(E) ac(E) button(E) i2c_scmi(E) acpi_cpufreq(E) joydev(E) 
> fuse(E) configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) uas(E) 
> usb_storage(E) hid_generic(E) usbhid(E) amdgpu(E) crc32_pclmul(E) 
> i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) iommu_v2(E) drm_buddy(E) 
> gpu_sched(E) drm_display_helper(E)
> [ 5478.765052]  ghash_clmulni_intel(E) sha512_ssse3(E) nvme(E) 
> drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme_core(E) 
> sysimgblt(E) rtsx_pci_sdmmc(E) t10_pi(E) mmc_core(E) drm(E) ucsi_acpi(E) 
> xhci_pci(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) ehci_pci(E) 
> xhci_hcd(E) aesni_intel(E) cec(E) rtsx_pci(E) ehci_hcd(E) typec_ucsi(E) 
> crypto_simd(E) cryptd(E) roles(E) ccp(E) rc_core(E) mfd_core(E) 
> usbcore(E) crc64(E) typec(E) battery(E) video(E) wmi(E) backlight(E) 
> serio_raw(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) 
> crc32c_intel(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) 
> efivarfs(E)
> [ 5478.765092] CPU: 6 PID: 26187 Comm: snapperd Tainted: G        W   
> E      6.2.0-rc2-pci_debug-59.40-default+ #356
> [ 5478.765095] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [ 5478.765098] RIP: 0010:btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.765183] Code: 4c 89 c7 31 d2 4c 89 44 24 08 48 89 de e8 5d a0 ff 
> ff 49 8b 7f 38 31 d2 48 89 de e8 4f a0 ff ff 4c 8b 44 24 08 e9 b1 fe ff 
> ff <0f> 0b 31 f6 48 8d 7c 24 10 e8 67 6d ff ff 89 c3 85 c0 0f 88 f6 fe
> [ 5478.765185] RSP: 0018:ffffa55001e37cd8 EFLAGS: 00010246
> [ 5478.765188] RAX: 000000223df20000 RBX: 0000000000000000 RCX: 
> 0000000000000000
> [ 5478.765189] RDX: ffff8c138f5db3c0 RSI: ffffffffa645be6e RDI: 
> ffffa55001e37d58
> [ 5478.765191] RBP: ffff8c1395a6bf60 R08: ffff8c1395a6bf60 R09: 
> ffff8c1388ec1078
> [ 5478.765192] R10: 0000000000000000 R11: ffff8c13d04d4000 R12: 
> 000000000000001f
> [ 5478.765199] R13: ffff8c1388ec1000 R14: ffff8c13c0737bc8 R15: 
> ffff8c138f5db3c0
> [ 5478.765201] FS:  00007fd4cdd2d6c0(0000) GS:ffff8c1630900000(0000) 
> knlGS:0000000000000000
> [ 5478.765203] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5478.765204] CR2: 00007fd4ce2dd750 CR3: 00000001a49ee000 CR4: 
> 00000000003506e0
> [ 5478.765206] Call Trace:
> [ 5478.765209]  <TASK>
> [ 5478.765212]  btrfs_commit_transaction+0x30d/0xb50 [btrfs]
> [ 5478.765288]  ? start_transaction+0xc5/0x5e0 [btrfs]
> [ 5478.765365]  btrfs_qgroup_rescan+0x46/0xc0 [btrfs]
> [ 5478.765449]  btrfs_ioctl+0x1b6c/0x2580 [btrfs]
> [ 5478.765578]  ? btrfs_release_file+0x3a/0x70 [btrfs]
> [ 5478.765656]  ? __rseq_handle_notify_resume+0xaa/0x4a0
> [ 5478.765663]  ? __seccomp_filter+0x320/0x4f0
> [ 5478.765667]  __x64_sys_ioctl+0x94/0xd0
> [ 5478.765670]  do_syscall_64+0x3e/0x90
> [ 5478.765676]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 5478.765680] RIP: 0033:0x7fd4ce50d9bf
> [ 5478.765684] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
> 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 5478.765686] RSP: 002b:00007fd4cdd2c7e0 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [ 5478.765688] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 
> 00007fd4ce50d9bf
> [ 5478.765689] RDX: 00007fd4cdd2c840 RSI: 000000004040942c RDI: 
> 0000000000000007
> [ 5478.765690] RBP: 00007fd4cdd2c840 R08: 0000000000000000 R09: 
> 0000000000000000
> [ 5478.765692] R10: 0000000000001000 R11: 0000000000000246 R12: 
> 000055e627acdca0
> [ 5478.765693] R13: 00007fd4cdd2ca30 R14: 00007fd4cdd2ca60 R15: 
> 00007fd4cdd2ca1f
> [ 5478.765699]  </TASK>
> [ 5478.765701] ---[ end trace 0000000000000000 ]---
> [ 5478.765761] ------------[ cut here ]------------
> [ 5478.765762] WARNING: CPU: 6 PID: 26187 at fs/btrfs/qgroup.c:2770 
> btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.765851] Modules linked in: tun(E) snd_seq_dummy(E) snd_seq(E) 
> ccm(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) 
> snd_usb_audio(E) snd_usbmidi_lib(E) snd_rawmidi(E) snd_seq_device(E) 
> af_packet(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
> sr_mod(E) cdrom(E) nft_reject_inet(E) nft_reject(E) nft_ct(E) 
> nft_chain_nat(E) cdc_ether(E) usbnet(E) nf_tables(E) ebtable_nat(E) 
> ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) 
> ip6table_security(E) uvcvideo(E) iptable_nat(E) nf_nat(E) 
> videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) 
> nf_conntrack(E) videodev(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) 
> videobuf2_common(E) mc(E) iptable_mangle(E) iptable_raw(E) 
> iptable_security(E) r8152(E) mii(E) bnep(E) ip_set(E) nfnetlink(E) 
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) 
> iptable_filter(E) bpfilter(E) btusb(E) btrtl(E) btbcm(E) btintel(E) 
> btmtk(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) intel_rapl_msr(E)
> [ 5478.765903]  intel_rapl_common(E) iwlmvm(E) nls_iso8859_1(E) 
> snd_ctl_led(E) nls_cp437(E) snd_hda_codec_realtek(E) vfat(E) fat(E) 
> snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) edac_mce_amd(E) 
> snd_hda_intel(E) snd_intel_dspcfg(E) mac80211(E) snd_intel_sdw_acpi(E) 
> kvm_amd(E) libarc4(E) snd_hda_codec(E) snd_hda_core(E) kvm(E) iwlwifi(E) 
> snd_hwdep(E) thinkpad_acpi(E) snd_pcm(E) r8169(E) snd_rn_pci_acp3x(E) 
> ledtrig_audio(E) irqbypass(E) snd_acp_config(E) snd_timer(E) pcspkr(E) 
> efi_pstore(E) platform_profile(E) realtek(E) cfg80211(E) mdio_devres(E) 
> snd_soc_acpi(E) wmi_bmof(E) k10temp(E) i2c_piix4(E) snd_pci_acp3x(E) 
> snd(E) ipmi_devintf(E) xfs(E) rfkill(E) libphy(E) ipmi_msghandler(E) 
> soundcore(E) ac(E) button(E) i2c_scmi(E) acpi_cpufreq(E) joydev(E) 
> fuse(E) configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) uas(E) 
> usb_storage(E) hid_generic(E) usbhid(E) amdgpu(E) crc32_pclmul(E) 
> i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) iommu_v2(E) drm_buddy(E) 
> gpu_sched(E) drm_display_helper(E)
> [ 5478.765966]  ghash_clmulni_intel(E) sha512_ssse3(E) nvme(E) 
> drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme_core(E) 
> sysimgblt(E) rtsx_pci_sdmmc(E) t10_pi(E) mmc_core(E) drm(E) ucsi_acpi(E) 
> xhci_pci(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) ehci_pci(E) 
> xhci_hcd(E) aesni_intel(E) cec(E) rtsx_pci(E) ehci_hcd(E) typec_ucsi(E) 
> crypto_simd(E) cryptd(E) roles(E) ccp(E) rc_core(E) mfd_core(E) 
> usbcore(E) crc64(E) typec(E) battery(E) video(E) wmi(E) backlight(E) 
> serio_raw(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) 
> crc32c_intel(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) 
> efivarfs(E)
> [ 5478.766010] CPU: 6 PID: 26187 Comm: snapperd Tainted: G        W   
> E      6.2.0-rc2-pci_debug-59.40-default+ #356
> [ 5478.766012] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [ 5478.766014] RIP: 0010:btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.766097] Code: 4c 89 c7 31 d2 4c 89 44 24 08 48 89 de e8 5d a0 ff 
> ff 49 8b 7f 38 31 d2 48 89 de e8 4f a0 ff ff 4c 8b 44 24 08 e9 b1 fe ff 
> ff <0f> 0b 31 f6 48 8d 7c 24 10 e8 67 6d ff ff 89 c3 85 c0 0f 88 f6 fe
> [ 5478.766098] RSP: 0018:ffffa55001e37cd8 EFLAGS: 00010246
> [ 5478.766100] RAX: 000000223df24000 RBX: 0000000000000000 RCX: 
> 0000000000000000
> [ 5478.766101] RDX: ffff8c150f8ce540 RSI: ffffffffa645be6e RDI: 
> ffffa55001e37d58
> [ 5478.766103] RBP: ffff8c1395a6bf60 R08: ffff8c1395a6bf60 R09: 
> ffff8c1388ec1078
> [ 5478.766104] R10: 0000000000000000 R11: ffff8c13d04d4000 R12: 
> 0000000000000020
> [ 5478.766105] R13: ffff8c1388ec1000 R14: ffff8c13c0737bc8 R15: 
> ffff8c150f8ce540
> [ 5478.766107] FS:  00007fd4cdd2d6c0(0000) GS:ffff8c1630900000(0000) 
> knlGS:0000000000000000
> [ 5478.766109] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5478.766110] CR2: 00007fd4ce2dd750 CR3: 00000001a49ee000 CR4: 
> 00000000003506e0
> [ 5478.766111] Call Trace:
> [ 5478.766113]  <TASK>
> [ 5478.766116]  btrfs_commit_transaction+0x30d/0xb50 [btrfs]
> [ 5478.766191]  ? start_transaction+0xc5/0x5e0 [btrfs]
> [ 5478.766267]  btrfs_qgroup_rescan+0x46/0xc0 [btrfs]
> [ 5478.766349]  btrfs_ioctl+0x1b6c/0x2580 [btrfs]
> [ 5478.766439]  ? btrfs_release_file+0x3a/0x70 [btrfs]
> [ 5478.766514]  ? __rseq_handle_notify_resume+0xaa/0x4a0
> [ 5478.766519]  ? __seccomp_filter+0x320/0x4f0
> [ 5478.766522]  __x64_sys_ioctl+0x94/0xd0
> [ 5478.766527]  do_syscall_64+0x3e/0x90
> [ 5478.766530]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 5478.766533] RIP: 0033:0x7fd4ce50d9bf
> [ 5478.766535] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
> 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 5478.766536] RSP: 002b:00007fd4cdd2c7e0 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [ 5478.766538] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 
> 00007fd4ce50d9bf
> [ 5478.766540] RDX: 00007fd4cdd2c840 RSI: 000000004040942c RDI: 
> 0000000000000007
> [ 5478.766541] RBP: 00007fd4cdd2c840 R08: 0000000000000000 R09: 
> 0000000000000000
> [ 5478.766542] R10: 0000000000001000 R11: 0000000000000246 R12: 
> 000055e627acdca0
> [ 5478.766543] R13: 00007fd4cdd2ca30 R14: 00007fd4cdd2ca60 R15: 
> 00007fd4cdd2ca1f
> [ 5478.766547]  </TASK>
> [ 5478.766548] ---[ end trace 0000000000000000 ]---
> [ 5478.766622] ------------[ cut here ]------------
> [ 5478.766622] WARNING: CPU: 6 PID: 26187 at fs/btrfs/qgroup.c:2770 
> btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.766708] Modules linked in: tun(E) snd_seq_dummy(E) snd_seq(E) 
> ccm(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) 
> snd_usb_audio(E) snd_usbmidi_lib(E) snd_rawmidi(E) snd_seq_device(E) 
> af_packet(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
> sr_mod(E) cdrom(E) nft_reject_inet(E) nft_reject(E) nft_ct(E) 
> nft_chain_nat(E) cdc_ether(E) usbnet(E) nf_tables(E) ebtable_nat(E) 
> ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) 
> ip6table_security(E) uvcvideo(E) iptable_nat(E) nf_nat(E) 
> videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) 
> nf_conntrack(E) videodev(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) 
> videobuf2_common(E) mc(E) iptable_mangle(E) iptable_raw(E) 
> iptable_security(E) r8152(E) mii(E) bnep(E) ip_set(E) nfnetlink(E) 
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) 
> iptable_filter(E) bpfilter(E) btusb(E) btrtl(E) btbcm(E) btintel(E) 
> btmtk(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) intel_rapl_msr(E)
> [ 5478.766765]  intel_rapl_common(E) iwlmvm(E) nls_iso8859_1(E) 
> snd_ctl_led(E) nls_cp437(E) snd_hda_codec_realtek(E) vfat(E) fat(E) 
> snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) edac_mce_amd(E) 
> snd_hda_intel(E) snd_intel_dspcfg(E) mac80211(E) snd_intel_sdw_acpi(E) 
> kvm_amd(E) libarc4(E) snd_hda_codec(E) snd_hda_core(E) kvm(E) iwlwifi(E) 
> snd_hwdep(E) thinkpad_acpi(E) snd_pcm(E) r8169(E) snd_rn_pci_acp3x(E) 
> ledtrig_audio(E) irqbypass(E) snd_acp_config(E) snd_timer(E) pcspkr(E) 
> efi_pstore(E) platform_profile(E) realtek(E) cfg80211(E) mdio_devres(E) 
> snd_soc_acpi(E) wmi_bmof(E) k10temp(E) i2c_piix4(E) snd_pci_acp3x(E) 
> snd(E) ipmi_devintf(E) xfs(E) rfkill(E) libphy(E) ipmi_msghandler(E) 
> soundcore(E) ac(E) button(E) i2c_scmi(E) acpi_cpufreq(E) joydev(E) 
> fuse(E) configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) uas(E) 
> usb_storage(E) hid_generic(E) usbhid(E) amdgpu(E) crc32_pclmul(E) 
> i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) iommu_v2(E) drm_buddy(E) 
> gpu_sched(E) drm_display_helper(E)
> [ 5478.766828]  ghash_clmulni_intel(E) sha512_ssse3(E) nvme(E) 
> drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme_core(E) 
> sysimgblt(E) rtsx_pci_sdmmc(E) t10_pi(E) mmc_core(E) drm(E) ucsi_acpi(E) 
> xhci_pci(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) ehci_pci(E) 
> xhci_hcd(E) aesni_intel(E) cec(E) rtsx_pci(E) ehci_hcd(E) typec_ucsi(E) 
> crypto_simd(E) cryptd(E) roles(E) ccp(E) rc_core(E) mfd_core(E) 
> usbcore(E) crc64(E) typec(E) battery(E) video(E) wmi(E) backlight(E) 
> serio_raw(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) 
> crc32c_intel(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) 
> efivarfs(E)
> [ 5478.766866] CPU: 6 PID: 26187 Comm: snapperd Tainted: G        W   
> E      6.2.0-rc2-pci_debug-59.40-default+ #356
> [ 5478.766870] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [ 5478.766872] RIP: 0010:btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.766956] Code: 4c 89 c7 31 d2 4c 89 44 24 08 48 89 de e8 5d a0 ff 
> ff 49 8b 7f 38 31 d2 48 89 de e8 4f a0 ff ff 4c 8b 44 24 08 e9 b1 fe ff 
> ff <0f> 0b 31 f6 48 8d 7c 24 10 e8 67 6d ff ff 89 c3 85 c0 0f 88 f6 fe
> [ 5478.766957] RSP: 0018:ffffa55001e37cd8 EFLAGS: 00010246
> [ 5478.766960] RAX: 000000223df28000 RBX: 0000000000000000 RCX: 
> 0000000000000000
> [ 5478.766961] RDX: ffff8c13e5ca3b00 RSI: ffffffffa645be6e RDI: 
> ffffa55001e37d58
> [ 5478.766963] RBP: ffff8c1395a6bf60 R08: ffff8c1395a6bf60 R09: 
> ffff8c1388ec1078
> [ 5478.766964] R10: 0000000000000000 R11: ffff8c13d04d4000 R12: 
> 0000000000000021
> [ 5478.766966] R13: ffff8c1388ec1000 R14: ffff8c13c0737bc8 R15: 
> ffff8c13e5ca3b00
> [ 5478.766967] FS:  00007fd4cdd2d6c0(0000) GS:ffff8c1630900000(0000) 
> knlGS:0000000000000000
> [ 5478.766969] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5478.766971] CR2: 00007fd4ce2dd750 CR3: 00000001a49ee000 CR4: 
> 00000000003506e0
> [ 5478.766973] Call Trace:
> [ 5478.766976]  <TASK>
> [ 5478.766979]  btrfs_commit_transaction+0x30d/0xb50 [btrfs]
> [ 5478.767053]  ? start_transaction+0xc5/0x5e0 [btrfs]
> [ 5478.767127]  btrfs_qgroup_rescan+0x46/0xc0 [btrfs]
> [ 5478.767216]  btrfs_ioctl+0x1b6c/0x2580 [btrfs]
> [ 5478.767304]  ? btrfs_release_file+0x3a/0x70 [btrfs]
> [ 5478.767386]  ? __rseq_handle_notify_resume+0xaa/0x4a0
> [ 5478.767391]  ? __seccomp_filter+0x320/0x4f0
> [ 5478.767395]  __x64_sys_ioctl+0x94/0xd0
> [ 5478.767399]  do_syscall_64+0x3e/0x90
> [ 5478.767403]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 5478.767408] RIP: 0033:0x7fd4ce50d9bf
> [ 5478.767410] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
> 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 5478.767412] RSP: 002b:00007fd4cdd2c7e0 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [ 5478.767413] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 
> 00007fd4ce50d9bf
> [ 5478.767414] RDX: 00007fd4cdd2c840 RSI: 000000004040942c RDI: 
> 0000000000000007
> [ 5478.767415] RBP: 00007fd4cdd2c840 R08: 0000000000000000 R09: 
> 0000000000000000
> [ 5478.767416] R10: 0000000000001000 R11: 0000000000000246 R12: 
> 000055e627acdca0
> [ 5478.767417] R13: 00007fd4cdd2ca30 R14: 00007fd4cdd2ca60 R15: 
> 00007fd4cdd2ca1f
> [ 5478.767421]  </TASK>
> [ 5478.767422] ---[ end trace 0000000000000000 ]---
> [ 5478.767505] ------------[ cut here ]------------
> [ 5478.767506] WARNING: CPU: 6 PID: 26187 at fs/btrfs/qgroup.c:2770 
> btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.767593] Modules linked in: tun(E) snd_seq_dummy(E) snd_seq(E) 
> ccm(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) 
> snd_usb_audio(E) snd_usbmidi_lib(E) snd_rawmidi(E) snd_seq_device(E) 
> af_packet(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
> sr_mod(E) cdrom(E) nft_reject_inet(E) nft_reject(E) nft_ct(E) 
> nft_chain_nat(E) cdc_ether(E) usbnet(E) nf_tables(E) ebtable_nat(E) 
> ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) 
> ip6table_security(E) uvcvideo(E) iptable_nat(E) nf_nat(E) 
> videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) 
> nf_conntrack(E) videodev(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) 
> videobuf2_common(E) mc(E) iptable_mangle(E) iptable_raw(E) 
> iptable_security(E) r8152(E) mii(E) bnep(E) ip_set(E) nfnetlink(E) 
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) 
> iptable_filter(E) bpfilter(E) btusb(E) btrtl(E) btbcm(E) btintel(E) 
> btmtk(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) intel_rapl_msr(E)
> [ 5478.767654]  intel_rapl_common(E) iwlmvm(E) nls_iso8859_1(E) 
> snd_ctl_led(E) nls_cp437(E) snd_hda_codec_realtek(E) vfat(E) fat(E) 
> snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) edac_mce_amd(E) 
> snd_hda_intel(E) snd_intel_dspcfg(E) mac80211(E) snd_intel_sdw_acpi(E) 
> kvm_amd(E) libarc4(E) snd_hda_codec(E) snd_hda_core(E) kvm(E) iwlwifi(E) 
> snd_hwdep(E) thinkpad_acpi(E) snd_pcm(E) r8169(E) snd_rn_pci_acp3x(E) 
> ledtrig_audio(E) irqbypass(E) snd_acp_config(E) snd_timer(E) pcspkr(E) 
> efi_pstore(E) platform_profile(E) realtek(E) cfg80211(E) mdio_devres(E) 
> snd_soc_acpi(E) wmi_bmof(E) k10temp(E) i2c_piix4(E) snd_pci_acp3x(E) 
> snd(E) ipmi_devintf(E) xfs(E) rfkill(E) libphy(E) ipmi_msghandler(E) 
> soundcore(E) ac(E) button(E) i2c_scmi(E) acpi_cpufreq(E) joydev(E) 
> fuse(E) configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) uas(E) 
> usb_storage(E) hid_generic(E) usbhid(E) amdgpu(E) crc32_pclmul(E) 
> i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) iommu_v2(E) drm_buddy(E) 
> gpu_sched(E) drm_display_helper(E)
> [ 5478.767713]  ghash_clmulni_intel(E) sha512_ssse3(E) nvme(E) 
> drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme_core(E) 
> sysimgblt(E) rtsx_pci_sdmmc(E) t10_pi(E) mmc_core(E) drm(E) ucsi_acpi(E) 
> xhci_pci(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) ehci_pci(E) 
> xhci_hcd(E) aesni_intel(E) cec(E) rtsx_pci(E) ehci_hcd(E) typec_ucsi(E) 
> crypto_simd(E) cryptd(E) roles(E) ccp(E) rc_core(E) mfd_core(E) 
> usbcore(E) crc64(E) typec(E) battery(E) video(E) wmi(E) backlight(E) 
> serio_raw(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) 
> crc32c_intel(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) 
> efivarfs(E)
> [ 5478.767756] CPU: 6 PID: 26187 Comm: snapperd Tainted: G        W   
> E      6.2.0-rc2-pci_debug-59.40-default+ #356
> [ 5478.767759] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [ 5478.767762] RIP: 0010:btrfs_qgroup_account_extents+0x21b/0x250 [btrfs]
> [ 5478.767846] Code: 4c 89 c7 31 d2 4c 89 44 24 08 48 89 de e8 5d a0 ff 
> ff 49 8b 7f 38 31 d2 48 89 de e8 4f a0 ff ff 4c 8b 44 24 08 e9 b1 fe ff 
> ff <0f> 0b 31 f6 48 8d 7c 24 10 e8 67 6d ff ff 89 c3 85 c0 0f 88 f6 fe
> [ 5478.767849] RSP: 0018:ffffa55001e37cd8 EFLAGS: 00010246
> [ 5478.767850] RAX: 000000223df2c000 RBX: 0000000000000000 RCX: 
> 0000000000000000
> [ 5478.767852] RDX: ffff8c1538b42e80 RSI: ffffffffa645be6e RDI: 
> ffffa55001e37d58
> [ 5478.767853] RBP: ffff8c1395a6bf60 R08: ffff8c1395a6bf60 R09: 
> ffff8c1388ec1078
> [ 5478.767855] R10: 0000000000000000 R11: ffff8c1383c81800 R12: 
> 0000000000000022
> [ 5478.767856] R13: ffff8c1388ec1000 R14: ffff8c13c0737bc8 R15: 
> ffff8c1538b42e80
> [ 5478.767857] FS:  00007fd4cdd2d6c0(0000) GS:ffff8c1630900000(0000) 
> knlGS:0000000000000000
> [ 5478.767863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5478.767865] CR2: 00007fd4ce2dd750 CR3: 00000001a49ee000 CR4: 
> 00000000003506e0
> [ 5478.767866] Call Trace:
> [ 5478.767869]  <TASK>
> [ 5478.767872]  btrfs_commit_transaction+0x30d/0xb50 [btrfs]
> [ 5478.767946]  ? start_transaction+0xc5/0x5e0 [btrfs]
> [ 5478.768024]  btrfs_qgroup_rescan+0x46/0xc0 [btrfs]
> [ 5478.768113]  btrfs_ioctl+0x1b6c/0x2580 [btrfs]
> [ 5478.768198]  ? btrfs_release_file+0x3a/0x70 [btrfs]
> [ 5478.768278]  ? __rseq_handle_notify_resume+0xaa/0x4a0
> [ 5478.768285]  ? __seccomp_filter+0x320/0x4f0
> [ 5478.768289]  __x64_sys_ioctl+0x94/0xd0
> [ 5478.768292]  do_syscall_64+0x3e/0x90
> [ 5478.768299]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 5478.768302] RIP: 0033:0x7fd4ce50d9bf
> [ 5478.768305] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
> 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 5478.768306] RSP: 002b:00007fd4cdd2c7e0 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [ 5478.768308] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 
> 00007fd4ce50d9bf
> [ 5478.768310] RDX: 00007fd4cdd2c840 RSI: 000000004040942c RDI: 
> 0000000000000007
> [ 5478.768311] RBP: 00007fd4cdd2c840 R08: 0000000000000000 R09: 
> 0000000000000000
> [ 5478.768312] R10: 0000000000001000 R11: 0000000000000246 R12: 
> 000055e627acdca0
> [ 5478.768314] R13: 00007fd4cdd2ca30 R14: 00007fd4cdd2ca60 R15: 
> 00007fd4cdd2ca1f
> [ 5478.768318]  </TASK>
> [ 5478.768319] ---[ end trace 0000000000000000 ]---
> [ 5478.782308] BTRFS error (device nvme0n1p2): qgroup scan failed with -5
> [ 6237.023729] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x0 (reading 0x15e31022)
> [ 6237.023747] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x4 (reading 0x100406)
> [ 6237.023751] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x8 (reading 0x4030000)
> [ 6237.023754] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0xc (reading 0x800008)
> [ 6237.023757] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x10 (reading 0xd05c0000)
> [ 6237.023760] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x14 (reading 0x0)
> [ 6237.023762] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x18 (reading 0x0)
> [ 6237.023765] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x1c (reading 0x0)
> [ 6237.023767] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x20 (reading 0x0)
> [ 6237.023769] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x24 (reading 0x0)
> [ 6237.023772] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x28 (reading 0x0)
> [ 6237.023774] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x2c (reading 0x512517aa)
> [ 6237.023776] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x30 (reading 0x0)
> [ 6237.023779] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x34 (reading 0x48)
> [ 6237.023781] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x38 (reading 0x0)
> [ 6237.023783] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x3c (reading 0x3ff)
> [ 6237.023808] snd_hda_intel 0000:06:00.6: PME# enabled
> [ 6237.023863] snd_hda_intel 0000:06:00.6: Requested to go to 3
> [ 6237.035891] snd_hda_intel 0000:06:00.6: Gone into state 3
> [ 7685.345598] snd_hda_intel 0000:06:00.6: PME# disabled
> [ 7692.983347] vgaarb: client 0x0000000082859412 called 'target'
> [ 7692.983375] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 7692.983378] vgaarb: vgadev 0000000097683c42
> [ 7752.866127] vgaarb: client 0x0000000082859412 called 'target'
> [ 7752.866166] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 7752.866174] vgaarb: vgadev 0000000097683c42
> [ 7767.075258] vgaarb: client 0x0000000082859412 called 'target'
> [ 7767.075277] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 7767.075280] vgaarb: vgadev 0000000097683c42
> [ 7871.178846] vgaarb: client 0x0000000082859412 called 'target'
> [ 7871.178876] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 7871.178884] vgaarb: vgadev 0000000097683c42
> [ 7951.006130] vgaarb: client 0x0000000082859412 called 'target'
> [ 7951.006151] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 7951.006155] vgaarb: vgadev 0000000097683c42
> [ 8015.003421] vgaarb: client 0x0000000082859412 called 'target'
> [ 8015.003466] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 8015.003470] vgaarb: vgadev 0000000097683c42
> [ 8038.003355] vgaarb: client 0x0000000082859412 called 'target'
> [ 8038.003379] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 8038.003383] vgaarb: vgadev 0000000097683c42
> [ 8140.919096] vgaarb: client 0x0000000082859412 called 'target'
> [ 8140.919121] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 8140.919127] vgaarb: vgadev 0000000097683c42
> [ 8196.007494] vgaarb: client 0x0000000082859412 called 'target'
> [ 8196.007537] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 8196.007545] vgaarb: vgadev 0000000097683c42
> [ 8257.007890] vgaarb: client 0x0000000082859412 called 'target'
> [ 8257.007912] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 8257.007915] vgaarb: vgadev 0000000097683c42
> [ 8499.205732] vgaarb: client 0x0000000082859412 called 'target'
> [ 8499.205763] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 8499.205768] vgaarb: vgadev 0000000097683c42
> [ 8558.869197] vgaarb: client 0x0000000082859412 called 'target'
> [ 8558.869286] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 8558.869298] vgaarb: vgadev 0000000097683c42
> [ 9140.944489] vgaarb: client 0x0000000082859412 called 'target'
> [ 9140.944523] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [ 9140.944530] vgaarb: vgadev 0000000097683c42
> [10660.673628] usb 5-1: USB disconnect, device number 2
> [10660.673643] usb 5-1.1: USB disconnect, device number 4
> [10660.752714] usb 5-1.3: USB disconnect, device number 3
> [10662.453791] usb 5-1: new SuperSpeed Plus Gen 2x1 USB device number 5 
> using xhci_hcd
> [10662.475697] usb 5-1: New USB device found, idVendor=17ef, 
> idProduct=a391, bcdDevice= d.24
> [10662.475708] usb 5-1: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=0
> [10662.475711] usb 5-1: Product: USB3.1 Hub
> [10662.475714] usb 5-1: Manufacturer: VIA Labs, Inc.
> [10662.496766] hub 5-1:1.0: USB hub found
> [10662.496930] hub 5-1:1.0: 4 ports detected
> [10663.045761] usb 5-1.3: new SuperSpeed Plus Gen 2x1 USB device number 
> 6 using xhci_hcd
> [10663.067727] usb 5-1.3: New USB device found, idVendor=17ef, 
> idProduct=a393, bcdDevice= d.23
> [10663.067736] usb 5-1.3: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=0
> [10663.067740] usb 5-1.3: Product: USB3.1 Hub
> [10663.067743] usb 5-1.3: Manufacturer: VIA Labs, Inc.
> [10663.088628] hub 5-1.3:1.0: USB hub found
> [10663.088738] hub 5-1.3:1.0: 4 ports detected
> [10664.329621] usb 5-1.1: new SuperSpeed USB device number 7 using xhci_hcd
> [10664.350124] usb 5-1.1: New USB device found, idVendor=17ef, 
> idProduct=a387, bcdDevice=31.03
> [10664.350131] usb 5-1.1: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=6
> [10664.350134] usb 5-1.1: Product: USB-C Dock Ethernet
> [10664.350135] usb 5-1.1: Manufacturer: Realtek
> [10664.350137] usb 5-1.1: SerialNumber: 301000001
> [10664.496585] usb 5-1.1: reset SuperSpeed USB device number 7 using 
> xhci_hcd
> [10664.530750] r8152 5-1.1:1.0 (unnamed net_device) (uninitialized): 
> Invalid header when reading pass-thru MAC addr
> [10664.552363] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [10664.586128] r8152 5-1.1:1.0 eth2: v1.12.13
> [10665.292868] r8152 5-1.1:1.0 eth3: renamed from eth2
> [11555.183291] vgaarb: client 0x0000000082859412 called 'target'
> [11555.183322] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [11555.183329] vgaarb: vgadev 0000000097683c42
> [11615.003228] vgaarb: client 0x0000000082859412 called 'target'
> [11615.003261] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [11615.003269] vgaarb: vgadev 0000000097683c42
> [11674.240627] vgaarb: client 0x0000000082859412 called 'target'
> [11674.240666] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [11674.240675] vgaarb: vgadev 0000000097683c42
> [11750.935493] vgaarb: client 0x0000000082859412 called 'target'
> [11750.935518] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [11750.935522] vgaarb: vgadev 0000000097683c42
> [11794.005528] vgaarb: client 0x0000000082859412 called 'target'
> [11794.005565] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [11794.005570] vgaarb: vgadev 0000000097683c42
> [11856.004970] vgaarb: client 0x0000000082859412 called 'target'
> [11856.005008] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [11856.005016] vgaarb: vgadev 0000000097683c42
> [11906.178858] vgaarb: client 0x0000000082859412 called 'target'
> [11906.178878] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [11906.178881] vgaarb: vgadev 0000000097683c42
> [11915.931293] vgaarb: client 0x0000000082859412 called 'target'
> [11915.931315] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [11915.931318] vgaarb: vgadev 0000000097683c42
> [11922.126890] vgaarb: client 0x0000000082859412 called 'target'
> [11922.126911] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [11922.126914] vgaarb: vgadev 0000000097683c42
> [11966.004569] vgaarb: client 0x0000000082859412 called 'target'
> [11966.004606] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [11966.004614] vgaarb: vgadev 0000000097683c42
> [12033.007783] vgaarb: client 0x0000000082859412 called 'target'
> [12033.007815] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12033.007820] vgaarb: vgadev 0000000097683c42
> [12070.003938] vgaarb: client 0x0000000082859412 called 'target'
> [12070.003972] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12070.003978] vgaarb: vgadev 0000000097683c42
> [12189.052599] vgaarb: client 0x0000000082859412 called 'target'
> [12189.052629] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12189.052633] vgaarb: vgadev 0000000097683c42
> [12249.039647] vgaarb: client 0x0000000082859412 called 'target'
> [12249.039685] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12249.039692] vgaarb: vgadev 0000000097683c42
> [12309.177279] vgaarb: client 0x0000000082859412 called 'target'
> [12309.177313] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12309.177317] vgaarb: vgadev 0000000097683c42
> [12369.004380] vgaarb: client 0x0000000082859412 called 'target'
> [12369.004417] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12369.004426] vgaarb: vgadev 0000000097683c42
> [12429.004421] vgaarb: client 0x0000000082859412 called 'target'
> [12429.004443] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12429.004447] vgaarb: vgadev 0000000097683c42
> [12489.074452] vgaarb: client 0x0000000082859412 called 'target'
> [12489.074482] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12489.074491] vgaarb: vgadev 0000000097683c42
> [12549.003229] vgaarb: client 0x0000000082859412 called 'target'
> [12549.003281] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12549.003287] vgaarb: vgadev 0000000097683c42
> [12609.018364] vgaarb: client 0x0000000082859412 called 'target'
> [12609.018394] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12609.018401] vgaarb: vgadev 0000000097683c42
> [12669.007279] vgaarb: client 0x0000000082859412 called 'target'
> [12669.007310] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [12669.007318] vgaarb: vgadev 0000000097683c42
> [13168.102496] BTRFS error (device nvme0n1p2): qgroup scan failed with -5
> [14181.006148] vgaarb: client 0x0000000082859412 called 'target'
> [14181.006175] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [14181.006178] vgaarb: vgadev 0000000097683c42
> [14240.883464] vgaarb: client 0x0000000082859412 called 'target'
> [14240.883491] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [14240.883496] vgaarb: vgadev 0000000097683c42
> [14301.007394] vgaarb: client 0x0000000082859412 called 'target'
> [14301.007414] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [14301.007416] vgaarb: vgadev 0000000097683c42
> [14621.008509] vgaarb: client 0x0000000082859412 called 'target'
> [14621.008536] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [14621.008541] vgaarb: vgadev 0000000097683c42
> [14634.003234] vgaarb: client 0x0000000082859412 called 'target'
> [14634.003262] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [14634.003266] vgaarb: vgadev 0000000097683c42
> [15165.005777] vgaarb: client 0x0000000082859412 called 'target'
> [15165.005808] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [15165.005812] vgaarb: vgadev 0000000097683c42
> [15736.006376] vgaarb: client 0x0000000082859412 called 'target'
> [15736.006455] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [15736.006465] vgaarb: vgadev 0000000097683c42
> [16180.933752] vgaarb: client 0x0000000082859412 called 'target'
> [16180.933775] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [16180.933781] vgaarb: vgadev 0000000097683c42
> [16323.224192] vgaarb: client 0x0000000082859412 called 'target'
> [16323.224233] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [16323.224237] vgaarb: vgadev 0000000097683c42
> [16354.015843] vgaarb: client 0x0000000082859412 called 'target'
> [16354.015864] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [16354.015868] vgaarb: vgadev 0000000097683c42
> [16401.876736] vgaarb: client 0x0000000082859412 called 'target'
> [16401.876781] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [16401.876786] vgaarb: vgadev 0000000097683c42
> [16461.007140] vgaarb: client 0x0000000082859412 called 'target'
> [16461.007177] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [16461.007189] vgaarb: vgadev 0000000097683c42
> [16702.800200] vgaarb: client 0x0000000082859412 called 'target'
> [16702.800231] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [16702.800236] vgaarb: vgadev 0000000097683c42
> [16722.916904] vgaarb: client 0x0000000082859412 called 'target'
> [16722.916940] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [16722.916945] vgaarb: vgadev 0000000097683c42
> [16788.926905] vgaarb: client 0x0000000082859412 called 'target'
> [16788.926929] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [16788.926932] vgaarb: vgadev 0000000097683c42
> [17031.004084] vgaarb: client 0x0000000082859412 called 'target'
> [17031.004103] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17031.004107] vgaarb: vgadev 0000000097683c42
> [17049.003523] vgaarb: client 0x0000000082859412 called 'target'
> [17049.003567] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17049.003574] vgaarb: vgadev 0000000097683c42
> [17063.003552] vgaarb: client 0x0000000082859412 called 'target'
> [17063.003576] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17063.003580] vgaarb: vgadev 0000000097683c42
> [17074.758807] vgaarb: client 0x0000000082859412 called 'target'
> [17074.758825] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17074.758829] vgaarb: vgadev 0000000097683c42
> [17105.007310] vgaarb: client 0x0000000082859412 called 'target'
> [17105.007341] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17105.007354] vgaarb: vgadev 0000000097683c42
> [17248.007446] vgaarb: client 0x0000000082859412 called 'target'
> [17248.007469] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17248.007475] vgaarb: vgadev 0000000097683c42
> [17265.007273] vgaarb: client 0x0000000082859412 called 'target'
> [17265.007309] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17265.007314] vgaarb: vgadev 0000000097683c42
> [17277.006619] vgaarb: client 0x0000000082859412 called 'target'
> [17277.006672] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17277.006676] vgaarb: vgadev 0000000097683c42
> [17283.965799] vgaarb: client 0x0000000082859412 called 'target'
> [17283.965829] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17283.965833] vgaarb: vgadev 0000000097683c42
> [17304.006897] vgaarb: client 0x0000000082859412 called 'target'
> [17304.006929] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17304.006937] vgaarb: vgadev 0000000097683c42
> [17367.004470] vgaarb: client 0x0000000082859412 called 'target'
> [17367.004498] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17367.004502] vgaarb: vgadev 0000000097683c42
> [17372.841099] vgaarb: client 0x0000000082859412 called 'target'
> [17372.841119] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17372.841122] vgaarb: vgadev 0000000097683c42
> [17385.004258] vgaarb: client 0x0000000082859412 called 'target'
> [17385.004281] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17385.004285] vgaarb: vgadev 0000000097683c42
> [17423.031289] vgaarb: client 0x0000000082859412 called 'target'
> [17423.031327] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17423.031332] vgaarb: vgadev 0000000097683c42
> [17543.005181] vgaarb: client 0x0000000082859412 called 'target'
> [17543.005212] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17543.005221] vgaarb: vgadev 0000000097683c42
> [17603.782065] vgaarb: client 0x0000000082859412 called 'target'
> [17603.782103] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17603.782108] vgaarb: vgadev 0000000097683c42
> [17663.006416] vgaarb: client 0x0000000082859412 called 'target'
> [17663.006464] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17663.006468] vgaarb: vgadev 0000000097683c42
> [17724.003386] vgaarb: client 0x0000000082859412 called 'target'
> [17724.003419] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17724.003423] vgaarb: vgadev 0000000097683c42
> [17765.005191] vgaarb: client 0x0000000082859412 called 'target'
> [17765.005258] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17765.005268] vgaarb: vgadev 0000000097683c42
> [17823.166604] vgaarb: client 0x0000000082859412 called 'target'
> [17823.166632] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17823.166638] vgaarb: vgadev 0000000097683c42
> [17843.177613] vgaarb: client 0x0000000082859412 called 'target'
> [17843.177673] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17843.177682] vgaarb: vgadev 0000000097683c42
> [17903.006940] vgaarb: client 0x0000000082859412 called 'target'
> [17903.006970] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [17903.006978] vgaarb: vgadev 0000000097683c42
> [18387.007251] vgaarb: client 0x0000000082859412 called 'target'
> [18387.007276] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [18387.007280] vgaarb: vgadev 0000000097683c42
> [18445.004906] vgaarb: client 0x0000000082859412 called 'target'
> [18445.004944] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [18445.004949] vgaarb: vgadev 0000000097683c42
> [19354.171557] vgaarb: client 0x0000000082859412 called 'target'
> [19354.171602] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [19354.171606] vgaarb: vgadev 0000000097683c42
> [19414.014707] vgaarb: client 0x0000000082859412 called 'target'
> [19414.014751] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [19414.014759] vgaarb: vgadev 0000000097683c42
> [19438.828707] vgaarb: client 0x0000000082859412 called 'target'
> [19438.828736] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [19438.828740] vgaarb: vgadev 0000000097683c42
> [19498.048174] vgaarb: client 0x0000000082859412 called 'target'
> [19498.048200] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [19498.048204] vgaarb: vgadev 0000000097683c42
> [19713.864013] vgaarb: client 0x0000000082859412 called 'target'
> [19713.864040] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [19713.864048] vgaarb: vgadev 0000000097683c42
> [19772.004592] vgaarb: client 0x0000000082859412 called 'target'
> [19772.004642] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [19772.004648] vgaarb: vgadev 0000000097683c42
> [19814.964328] vgaarb: client 0x0000000082859412 called 'target'
> [19814.964354] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [19814.964358] vgaarb: vgadev 0000000097683c42
> [20603.004133] vgaarb: client 0x0000000082859412 called 'target'
> [20603.004164] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [20603.004170] vgaarb: vgadev 0000000097683c42
> [20817.035132] vgaarb: client 0x0000000082859412 called 'target'
> [20817.035172] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [20817.035182] vgaarb: vgadev 0000000097683c42
> [21530.230258] vgaarb: client 0x0000000082859412 called 'target'
> [21530.230292] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [21530.230298] vgaarb: vgadev 0000000097683c42
> [22533.733797] vgaarb: client 0x0000000082859412 called 'target'
> [22533.733853] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [22533.733859] vgaarb: vgadev 0000000097683c42
> [23194.959923] vgaarb: client 0x0000000082859412 called 'target'
> [23194.959974] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23194.959979] vgaarb: vgadev 0000000097683c42
> [23305.972222] vgaarb: client 0x0000000082859412 called 'target'
> [23305.972294] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23305.972301] vgaarb: vgadev 0000000097683c42
> [23320.172465] vgaarb: client 0x0000000082859412 called 'target'
> [23320.172530] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23320.172537] vgaarb: vgadev 0000000097683c42
> [23330.023254] vgaarb: client 0x0000000082859412 called 'target'
> [23330.023302] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23330.023312] vgaarb: vgadev 0000000097683c42
> [23452.008265] vgaarb: client 0x0000000082859412 called 'target'
> [23452.008298] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23452.008302] vgaarb: vgadev 0000000097683c42
> [23488.009333] vgaarb: client 0x0000000082859412 called 'target'
> [23488.009401] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23488.009405] vgaarb: vgadev 0000000097683c42
> [23557.007047] vgaarb: client 0x0000000082859412 called 'target'
> [23557.007081] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23557.007085] vgaarb: vgadev 0000000097683c42
> [23671.018139] vgaarb: client 0x0000000082859412 called 'target'
> [23671.018206] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23671.018220] vgaarb: vgadev 0000000097683c42
> [23732.004969] vgaarb: client 0x0000000082859412 called 'target'
> [23732.005032] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23732.005041] vgaarb: vgadev 0000000097683c42
> [23797.004480] vgaarb: client 0x0000000082859412 called 'target'
> [23797.004547] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23797.004557] vgaarb: vgadev 0000000097683c42
> [23853.014474] vgaarb: client 0x0000000082859412 called 'target'
> [23853.014498] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [23853.014508] vgaarb: vgadev 0000000097683c42
> [24085.024753] vgaarb: client 0x0000000082859412 called 'target'
> [24085.024818] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [24085.024823] vgaarb: vgadev 0000000097683c42
> [24143.009161] vgaarb: client 0x0000000082859412 called 'target'
> [24143.009200] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [24143.009209] vgaarb: vgadev 0000000097683c42
> [24204.016556] vgaarb: client 0x0000000082859412 called 'target'
> [24204.016614] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [24204.016623] vgaarb: vgadev 0000000097683c42
> [24214.972812] vgaarb: client 0x0000000082859412 called 'target'
> [24214.972848] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [24214.972855] vgaarb: vgadev 0000000097683c42
> [24270.006078] vgaarb: client 0x0000000082859412 called 'target'
> [24270.006126] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [24270.006132] vgaarb: vgadev 0000000097683c42
> [24284.005801] vgaarb: client 0x0000000082859412 called 'target'
> [24284.005858] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [24284.005868] vgaarb: vgadev 0000000097683c42
> [24318.234565] vgaarb: client 0x0000000082859412 called 'target'
> [24318.234642] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [24318.234651] vgaarb: vgadev 0000000097683c42
> [24591.227526] vgaarb: client 0x0000000082859412 called 'target'
> [24591.227581] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [24591.227585] vgaarb: vgadev 0000000097683c42
> [24615.827354] vgaarb: client 0x0000000082859412 called 'target'
> [24615.827400] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [24615.827404] vgaarb: vgadev 0000000097683c42
> [25713.182761] vgaarb: client 0x0000000082859412 called 'target'
> [25713.182809] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [25713.182816] vgaarb: vgadev 0000000097683c42
> [30970.588428] vgaarb: client 0x0000000082859412 called 'target'
> [30970.588449] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [30970.588453] vgaarb: vgadev 0000000097683c42
> [31518.995550] vgaarb: client 0x0000000082859412 called 'target'
> [31518.995577] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [31518.995581] vgaarb: vgadev 0000000097683c42
> [31571.960704] vgaarb: client 0x0000000082859412 called 'target'
> [31571.960739] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [31571.960747] vgaarb: vgadev 0000000097683c42
> [31629.934168] vgaarb: client 0x0000000082859412 called 'target'
> [31629.934213] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [31629.934222] vgaarb: vgadev 0000000097683c42
> [31726.008540] vgaarb: client 0x0000000082859412 called 'target'
> [31726.008585] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [31726.008594] vgaarb: vgadev 0000000097683c42
> [31772.920734] vgaarb: client 0x0000000082859412 called 'target'
> [31772.920770] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [31772.920776] vgaarb: vgadev 0000000097683c42
> [31812.003907] vgaarb: client 0x0000000082859412 called 'target'
> [31812.003933] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [31812.003937] vgaarb: vgadev 0000000097683c42
> [31876.005152] vgaarb: client 0x0000000082859412 called 'target'
> [31876.005209] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [31876.005214] vgaarb: vgadev 0000000097683c42
> [31933.909629] vgaarb: client 0x0000000082859412 called 'target'
> [31933.909665] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [31933.909674] vgaarb: vgadev 0000000097683c42
> [31992.007755] vgaarb: client 0x0000000082859412 called 'target'
> [31992.007797] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [31992.007805] vgaarb: vgadev 0000000097683c42
> [32052.102946] vgaarb: client 0x0000000082859412 called 'target'
> [32052.102977] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [32052.102984] vgaarb: vgadev 0000000097683c42
> [32113.003508] vgaarb: client 0x0000000082859412 called 'target'
> [32113.003542] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [32113.003547] vgaarb: vgadev 0000000097683c42
> [32550.008147] vgaarb: client 0x0000000082859412 called 'target'
> [32550.008187] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [32550.008193] vgaarb: vgadev 0000000097683c42
> [32609.005347] vgaarb: client 0x0000000082859412 called 'target'
> [32609.005404] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [32609.005413] vgaarb: vgadev 0000000097683c42
> [32669.004813] vgaarb: client 0x0000000082859412 called 'target'
> [32669.004856] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [32669.004864] vgaarb: vgadev 0000000097683c42
> [32729.008037] vgaarb: client 0x0000000082859412 called 'target'
> [32729.008087] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [32729.008095] vgaarb: vgadev 0000000097683c42
> [32789.007217] vgaarb: client 0x0000000082859412 called 'target'
> [32789.007258] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [32789.007262] vgaarb: vgadev 0000000097683c42
> [32825.224063] vgaarb: client 0x0000000082859412 called 'target'
> [32825.224086] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [32825.224090] vgaarb: vgadev 0000000097683c42
> [32885.013426] vgaarb: client 0x0000000082859412 called 'target'
> [32885.013456] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [32885.013484] vgaarb: vgadev 0000000097683c42
> [32945.007909] vgaarb: client 0x0000000082859412 called 'target'
> [32945.007951] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [32945.007958] vgaarb: vgadev 0000000097683c42
> [33005.007345] vgaarb: client 0x0000000082859412 called 'target'
> [33005.007381] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33005.007391] vgaarb: vgadev 0000000097683c42
> [33117.004470] vgaarb: client 0x0000000082859412 called 'target'
> [33117.004546] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33117.004554] vgaarb: vgadev 0000000097683c42
> [33150.006868] vgaarb: client 0x0000000082859412 called 'target'
> [33150.006894] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33150.006898] vgaarb: vgadev 0000000097683c42
> [33185.015748] vgaarb: client 0x0000000082859412 called 'target'
> [33185.015772] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33185.015776] vgaarb: vgadev 0000000097683c42
> [33202.777332] vgaarb: client 0x0000000082859412 called 'target'
> [33202.777374] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33202.777388] vgaarb: vgadev 0000000097683c42
> [33241.004482] vgaarb: client 0x0000000082859412 called 'target'
> [33241.004513] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33241.004517] vgaarb: vgadev 0000000097683c42
> [33270.135622] vgaarb: client 0x0000000082859412 called 'target'
> [33270.135654] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33270.135658] vgaarb: vgadev 0000000097683c42
> [33298.004990] vgaarb: client 0x0000000082859412 called 'target'
> [33298.005034] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33298.005044] vgaarb: vgadev 0000000097683c42
> [33354.760125] vgaarb: client 0x0000000082859412 called 'target'
> [33354.760152] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33354.760158] vgaarb: vgadev 0000000097683c42
> [33440.003660] vgaarb: client 0x0000000082859412 called 'target'
> [33440.003684] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33440.003692] vgaarb: vgadev 0000000097683c42
> [33474.087339] vgaarb: client 0x0000000082859412 called 'target'
> [33474.087374] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [33474.087380] vgaarb: vgadev 0000000097683c42
> [34263.765360] vgaarb: client 0x0000000082859412 called 'target'
> [34263.765403] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [34263.765408] vgaarb: vgadev 0000000097683c42
> [34274.853779] vgaarb: client 0x0000000082859412 called 'target'
> [34274.853803] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [34274.853809] vgaarb: vgadev 0000000097683c42
> [34283.004907] vgaarb: client 0x0000000082859412 called 'target'
> [34283.004952] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [34283.004962] vgaarb: vgadev 0000000097683c42
> [34406.006036] vgaarb: client 0x0000000082859412 called 'target'
> [34406.006071] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [34406.006075] vgaarb: vgadev 0000000097683c42
> [34465.150578] vgaarb: client 0x0000000082859412 called 'target'
> [34465.150619] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [34465.150629] vgaarb: vgadev 0000000097683c42
> [34586.004909] vgaarb: client 0x0000000082859412 called 'target'
> [34586.004946] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [34586.004950] vgaarb: vgadev 0000000097683c42
> [34645.891689] vgaarb: client 0x0000000082859412 called 'target'
> [34645.891724] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [34645.891734] vgaarb: vgadev 0000000097683c42
> [34706.005507] vgaarb: client 0x0000000082859412 called 'target'
> [34706.005532] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [34706.005537] vgaarb: vgadev 0000000097683c42
> [34766.071307] vgaarb: client 0x0000000082859412 called 'target'
> [34766.071341] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [34766.071350] vgaarb: vgadev 0000000097683c42
> [34826.004855] vgaarb: client 0x0000000082859412 called 'target'
> [34826.004879] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [34826.004883] vgaarb: vgadev 0000000097683c42
> [35981.970890] r8169 0000:03:00.0: disabling bus mastering
> [35982.226087] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [35982.671043] r8169 0000:04:00.0 eth1: Link is Down
> [35982.671089] r8169 0000:04:00.0: disabling bus mastering
> [35983.261433] PM: suspend entry (deep)
> [35983.356668] Filesystems sync: 0.095 seconds
> [35983.406253] Freezing user space processes
> [35983.410628] Freezing user space processes completed (elapsed 0.004 
> seconds)
> [35983.410638] OOM killer disabled.
> [35983.410640] Freezing remaining freezable tasks
> [35983.412101] Freezing remaining freezable tasks completed (elapsed 
> 0.001 seconds)
> [35983.412134] printk: Suspending console(s) (use no_console_suspend to 
> debug)
> [35984.175861] iwlwifi 0000:01:00.0: saving config space at offset 0x0 
> (reading 0x25268086)
> [35984.175873] iwlwifi 0000:01:00.0: saving config space at offset 0x4 
> (reading 0x100406)
> [35984.175879] iwlwifi 0000:01:00.0: saving config space at offset 0x8 
> (reading 0x2800029)
> [35984.175885] iwlwifi 0000:01:00.0: saving config space at offset 0xc 
> (reading 0x0)
> [35984.175890] iwlwifi 0000:01:00.0: saving config space at offset 0x10 
> (reading 0xd0a00004)
> [35984.175896] iwlwifi 0000:01:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.175901] iwlwifi 0000:01:00.0: saving config space at offset 0x18 
> (reading 0x0)
> [35984.175906] iwlwifi 0000:01:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.175911] iwlwifi 0000:01:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [35984.175916] iwlwifi 0000:01:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [35984.175921] iwlwifi 0000:01:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.175926] iwlwifi 0000:01:00.0: saving config space at offset 0x2c 
> (reading 0x148086)
> [35984.175931] iwlwifi 0000:01:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.175935] iwlwifi 0000:01:00.0: saving config space at offset 0x34 
> (reading 0xc8)
> [35984.175940] iwlwifi 0000:01:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.175944] iwlwifi 0000:01:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [35984.175991] iwlwifi 0000:01:00.0: Requested to go to 3
> [35984.176250] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x0 (reading 0x15de1002)
> [35984.176255] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x4 (reading 0x100006)
> [35984.176258] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x8 (reading 0x4030000)
> [35984.176260] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0xc (reading 0x800008)
> [35984.176263] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x10 (reading 0xd05c8000)
> [35984.176265] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x14 (reading 0x0)
> [35984.176268] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x18 (reading 0x0)
> [35984.176270] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x1c (reading 0x0)
> [35984.176272] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x20 (reading 0x0)
> [35984.176274] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x24 (reading 0x0)
> [35984.176276] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x28 (reading 0x0)
> [35984.176279] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x2c (reading 0x512517aa)
> [35984.176281] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x30 (reading 0x0)
> [35984.176283] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x34 (reading 0x48)
> [35984.176285] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x38 (reading 0x0)
> [35984.176287] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x3c (reading 0x2ff)
> [35984.176294] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x0 (reading 0x15e31022)
> [35984.176298] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x0 (reading 0x15e21022)
> [35984.176301] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x4 (reading 0x100006)
> [35984.176303] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x4 (reading 0x100006)
> [35984.176305] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x8 (reading 0x4030000)
> [35984.176307] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x8 (reading 0x4800000)
> [35984.176304] snd_hda_intel 0000:06:00.1: Requested to go to 3
> [35984.176307] xhci_hcd 0000:06:00.4: saving config space at offset 0x0 
> (reading 0x15e11022)
> [35984.176309] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0xc (reading 0x800008)
> [35984.176310] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0xc (reading 0x800008)
> [35984.176312] ACPI: EC: interrupt blocked
> [35984.176312] xhci_hcd 0000:06:00.4: saving config space at offset 0x4 
> (reading 0x100403)
> [35984.176314] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x10 (reading 0xd05c0000)
> [35984.176318] xhci_hcd 0000:06:00.3: saving config space at offset 0x0 
> (reading 0x15e01022)
> [35984.176316] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x10 (reading 0xd0580000)
> [35984.176319] xhci_hcd 0000:06:00.4: saving config space at offset 0x8 
> (reading 0xc033000)
> [35984.176320] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x14 (reading 0x0)
> [35984.176321] xhci_hcd 0000:06:00.3: saving config space at offset 0x4 
> (reading 0x100403)
> [35984.176322] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x14 (reading 0x0)
> [35984.176323] xhci_hcd 0000:06:00.4: saving config space at offset 0xc 
> (reading 0x800008)
> [35984.176324] xhci_hcd 0000:06:00.3: saving config space at offset 0x8 
> (reading 0xc033000)
> [35984.176325] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x18 (reading 0x0)
> [35984.176326] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x18 (reading 0x0)
> [35984.176327] ccp 0000:06:00.2: saving config space at offset 0x0 
> (reading 0x15df1022)
> [35984.176328] xhci_hcd 0000:06:00.3: saving config space at offset 0xc 
> (reading 0x800008)
> [35984.176329] xhci_hcd 0000:06:00.4: saving config space at offset 0x10 
> (reading 0xd0300004)
> [35984.176331] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x1c (reading 0x0)
> [35984.176331] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x1c (reading 0x0)
> [35984.176332] ccp 0000:06:00.2: saving config space at offset 0x4 
> (reading 0x8100406)
> [35984.176333] xhci_hcd 0000:06:00.3: saving config space at offset 0x10 
> (reading 0xd0200004)
> [35984.176334] xhci_hcd 0000:06:00.4: saving config space at offset 0x14 
> (reading 0x0)
> [35984.176335] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x20 (reading 0x0)
> [35984.176336] ccp 0000:06:00.2: saving config space at offset 0x8 
> (reading 0x10800000)
> [35984.176337] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x20 (reading 0x0)
> [35984.176338] xhci_hcd 0000:06:00.3: saving config space at offset 0x14 
> (reading 0x0)
> [35984.176339] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x24 (reading 0x0)
> [35984.176340] xhci_hcd 0000:06:00.4: saving config space at offset 0x18 
> (reading 0x0)
> [35984.176341] ccp 0000:06:00.2: saving config space at offset 0xc 
> (reading 0x800008)
> [35984.176343] xhci_hcd 0000:06:00.3: saving config space at offset 0x18 
> (reading 0x0)
> [35984.176343] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x28 (reading 0x0)
> [35984.176548] rtsx_pci 0000:05:00.0: saving config space at offset 0x0 
> (reading 0x522a10ec)
> [35984.176553] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x24 (reading 0x0)
> [35984.176553] ccp 0000:06:00.2: saving config space at offset 0x10 
> (reading 0x0)
> [35984.176555] xhci_hcd 0000:06:00.4: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.176555] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x2c (reading 0x512517aa)
> [35984.176557] xhci_hcd 0000:06:00.3: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.176558] rtsx_pci 0000:05:00.0: saving config space at offset 0x4 
> (reading 0x100406)
> [35984.176560] r8169 0000:04:00.0: saving config space at offset 0x0 
> (reading 0x816810ec)
> [35984.176560] ccp 0000:06:00.2: saving config space at offset 0x14 
> (reading 0x0)
> [35984.176562] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x28 (reading 0x0)
> [35984.176562] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x30 (reading 0x0)
> [35984.176564] xhci_hcd 0000:06:00.3: saving config space at offset 0x20 
> (reading 0x0)
> [35984.176565] xhci_hcd 0000:06:00.4: saving config space at offset 0x20 
> (reading 0x0)
> [35984.176566] rtsx_pci 0000:05:00.0: saving config space at offset 0x8 
> (reading 0xff000001)
> [35984.176568] r8169 0000:04:00.0: saving config space at offset 0x4 
> (reading 0x100403)
> [35984.176568] ccp 0000:06:00.2: saving config space at offset 0x18 
> (reading 0xd0400000)
> [35984.176569] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x34 (reading 0x48)
> [35984.176571] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x2c (reading 0x512517aa)
> [35984.176572] xhci_hcd 0000:06:00.3: saving config space at offset 0x24 
> (reading 0x0)
> [35984.176573] xhci_hcd 0000:06:00.4: saving config space at offset 0x24 
> (reading 0x0)
> [35984.176574] rtsx_pci 0000:05:00.0: saving config space at offset 0xc 
> (reading 0x8)
> [35984.176576] r8169 0000:04:00.0: saving config space at offset 0x8 
> (reading 0x2000010)
> [35984.176576] ccp 0000:06:00.2: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.176578] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x38 (reading 0x0)
> [35984.176579] xhci_hcd 0000:06:00.3: saving config space at offset 0x28 
> (reading 0x0)
> [35984.176580] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x30 (reading 0x0)
> [35984.176583] ehci-pci 0000:03:00.4: saving config space at offset 0x0 
> (reading 0x816d10ec)
> [35984.176582] xhci_hcd 0000:06:00.4: saving config space at offset 0x28 
> (reading 0x0)
> [35984.176584] rtsx_pci 0000:05:00.0: saving config space at offset 0x10 
> (reading 0xd0600000)
> [35984.176585] r8169 0000:04:00.0: saving config space at offset 0xc 
> (reading 0x8)
> [35984.176586] ccp 0000:06:00.2: saving config space at offset 0x20 
> (reading 0x0)
> [35984.176587] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x3c (reading 0x2ff)
> [35984.176588] xhci_hcd 0000:06:00.3: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.176589] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x34 (reading 0x48)
> [35984.176592] ehci-pci 0000:03:00.4: saving config space at offset 0x4 
> (reading 0x100402)
> [35984.176592] xhci_hcd 0000:06:00.4: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.176678] rtsx_pci 0000:05:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.176680] r8169 0000:04:00.0: saving config space at offset 0x10 
> (reading 0x2001)
> [35984.176685] ccp 0000:06:00.2: saving config space at offset 0x24 
> (reading 0xd05cc000)
> [35984.176687] xhci_hcd 0000:06:00.3: saving config space at offset 0x30 
> (reading 0x0)
> [35984.176688] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x38 (reading 0x0)
> [35984.176690] ehci-pci 0000:03:00.4: saving config space at offset 0x8 
> (reading 0xc03200e)
> [35984.176690] xhci_hcd 0000:06:00.4: saving config space at offset 0x30 
> (reading 0x0)
> [35984.176787] rtsx_pci 0000:05:00.0: saving config space at offset 0x18 
> (reading 0x0)
> [35984.176788] r8169 0000:04:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.176794] ccp 0000:06:00.2: saving config space at offset 0x28 
> (reading 0x0)
> [35984.176795] xhci_hcd 0000:06:00.3: saving config space at offset 0x34 
> (reading 0x48)
> [35984.176796] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x3c (reading 0x3ff)
> [35984.176799] ehci-pci 0000:03:00.4: saving config space at offset 0xc 
> (reading 0x800008)
> [35984.176799] xhci_hcd 0000:06:00.4: saving config space at offset 0x34 
> (reading 0x48)
> [35984.176890] rtsx_pci 0000:05:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.176891] r8169 0000:04:00.0: saving config space at offset 0x18 
> (reading 0xd0704004)
> [35984.176897] ccp 0000:06:00.2: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.176898] xhci_hcd 0000:06:00.3: saving config space at offset 0x38 
> (reading 0x0)
> [35984.176902] ehci-pci 0000:03:00.4: saving config space at offset 0x10 
> (reading 0xd0818000)
> [35984.176902] xhci_hcd 0000:06:00.4: saving config space at offset 0x38 
> (reading 0x0)
> [35984.176996] rtsx_pci 0000:05:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [35984.176997] r8169 0000:04:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.177003] ccp 0000:06:00.2: saving config space at offset 0x30 
> (reading 0x0)
> [35984.177005] xhci_hcd 0000:06:00.3: saving config space at offset 0x3c 
> (reading 0x4ff)
> [35984.177008] ehci-pci 0000:03:00.4: saving config space at offset 0x14 
> (reading 0x0)
> [35984.177008] xhci_hcd 0000:06:00.4: saving config space at offset 0x3c 
> (reading 0x1ff)
> [35984.177099] rtsx_pci 0000:05:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [35984.177100] r8169 0000:04:00.0: saving config space at offset 0x20 
> (reading 0xd0700004)
> [35984.177107] ccp 0000:06:00.2: saving config space at offset 0x34 
> (reading 0x48)
> [35984.177111] ehci-pci 0000:03:00.4: saving config space at offset 0x18 
> (reading 0xd0810004)
> [35984.177202] rtsx_pci 0000:05:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.177204] r8169 0000:04:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [35984.177212] ccp 0000:06:00.2: saving config space at offset 0x38 
> (reading 0x0)
> [35984.177216] ehci-pci 0000:03:00.4: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.177306] rtsx_pci 0000:05:00.0: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.177307] r8169 0000:04:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.177316] ccp 0000:06:00.2: saving config space at offset 0x3c 
> (reading 0x3ff)
> [35984.177319] ehci-pci 0000:03:00.4: saving config space at offset 0x20 
> (reading 0x0)
> [35984.177409] rtsx_pci 0000:05:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.177411] r8169 0000:04:00.0: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.177422] ehci-pci 0000:03:00.4: saving config space at offset 0x24 
> (reading 0x0)
> [35984.177535] rtsx_pci 0000:05:00.0: saving config space at offset 0x34 
> (reading 0x40)
> [35984.177536] r8169 0000:04:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.177540] snd_pci_acp3x 0000:06:00.5: Requested to go to 3
> [35984.177545] ehci-pci 0000:03:00.4: saving config space at offset 0x28 
> (reading 0x0)
> [35984.177666] rtsx_pci 0000:05:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.177672] r8169 0000:04:00.0: saving config space at offset 0x34 
> (reading 0x40)
> [35984.177674] snd_hda_intel 0000:06:00.6: Requested to go to 3
> [35984.177678] ehci-pci 0000:03:00.4: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.177772] rtsx_pci 0000:05:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [35984.177779] r8169 0000:04:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.177785] ehci-pci 0000:03:00.4: saving config space at offset 0x30 
> (reading 0x0)
> [35984.177885] r8169 0000:04:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [35984.177889] ehci-pci 0000:03:00.4: saving config space at offset 0x34 
> (reading 0x40)
> [35984.177989] pci 0000:03:00.3: saving config space at offset 0x0 
> (reading 0x816c10ec)
> [35984.177993] ehci-pci 0000:03:00.4: saving config space at offset 0x38 
> (reading 0x0)
> [35984.178098] pci 0000:03:00.3: saving config space at offset 0x4 
> (reading 0x100000)
> [35984.178100] ehci-pci 0000:03:00.4: saving config space at offset 0x3c 
> (reading 0x4ff)
> [35984.178203] pci 0000:03:00.3: saving config space at offset 0x8 
> (reading 0xc07010e)
> [35984.178205] ccp 0000:06:00.2: Requested to go to 3
> [35984.178299] pci 0000:03:00.3: saving config space at offset 0xc 
> (reading 0x800008)
> [35984.178308] xhci_hcd 0000:06:00.3: PME# enabled
> [35984.178408] pci 0000:03:00.3: saving config space at offset 0x10 
> (reading 0x3001)
> [35984.178410] xhci_hcd 0000:06:00.3: Requested to go to 3
> [35984.178414] xhci_hcd 0000:06:00.4: PME# enabled
> [35984.178429] xhci_hcd 0000:06:00.4: Requested to go to 3
> [35984.178512] pci 0000:03:00.3: saving config space at offset 0x14 
> (reading 0x0)
> [35984.178613] pci 0000:03:00.3: saving config space at offset 0x18 
> (reading 0xd0817004)
> [35984.178725] pci 0000:03:00.3: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.178730] serial 0000:03:00.2: saving config space at offset 0x0 
> (reading 0x816b10ec)
> [35984.178733] pci 0000:03:00.3: saving config space at offset 0x20 
> (reading 0xd080c004)
> [35984.178738] serial 0000:03:00.2: saving config space at offset 0x4 
> (reading 0x100003)
> [35984.178741] pci 0000:03:00.3: saving config space at offset 0x24 
> (reading 0x0)
> [35984.178753] serial 0000:03:00.1: saving config space at offset 0x0 
> (reading 0x816a10ec)
> [35984.178751] serial 0000:03:00.2: saving config space at offset 0x8 
> (reading 0x700020e)
> [35984.178755] pci 0000:03:00.3: saving config space at offset 0x28 
> (reading 0x0)
> [35984.178766] serial 0000:03:00.1: saving config space at offset 0x4 
> (reading 0x100003)
> [35984.178763] serial 0000:03:00.2: saving config space at offset 0xc 
> (reading 0x800008)
> [35984.178767] pci 0000:03:00.3: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.178773] r8169 0000:03:00.0: saving config space at offset 0x0 
> (reading 0x816810ec)
> [35984.178781] serial 0000:03:00.1: saving config space at offset 0x8 
> (reading 0x700020e)
> [35984.178774] rtsx_pci 0000:05:00.0: Requested to go to 3
> [35984.178778] serial 0000:03:00.2: saving config space at offset 0x10 
> (reading 0x3101)
> [35984.178781] pci 0000:03:00.3: saving config space at offset 0x30 
> (reading 0x0)
> [35984.178786] r8169 0000:03:00.0: saving config space at offset 0x4 
> (reading 0x100403)
> [35984.178792] serial 0000:03:00.1: saving config space at offset 0xc 
> (reading 0x800008)
> [35984.178795] nvme 0000:02:00.0: saving config space at offset 0x0 
> (reading 0x16391c5c)
> [35984.178881] serial 0000:03:00.2: saving config space at offset 0x14 
> (reading 0x0)
> [35984.178885] pci 0000:03:00.3: saving config space at offset 0x34 
> (reading 0x40)
> [35984.178890] r8169 0000:03:00.0: saving config space at offset 0x8 
> (reading 0x200000e)
> [35984.178896] serial 0000:03:00.1: saving config space at offset 0x10 
> (reading 0x3201)
> [35984.178898] nvme 0000:02:00.0: saving config space at offset 0x4 
> (reading 0x100003)
> [35984.178991] serial 0000:03:00.2: saving config space at offset 0x18 
> (reading 0xd0816004)
> [35984.178995] pci 0000:03:00.3: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179001] r8169 0000:03:00.0: saving config space at offset 0xc 
> (reading 0x800008)
> [35984.179006] serial 0000:03:00.1: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179009] nvme 0000:02:00.0: saving config space at offset 0x8 
> (reading 0x1080200)
> [35984.179005] r8169 0000:04:00.0: Requested to go to 3
> [35984.179006] serial 0000:03:00.2: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179009] pci 0000:03:00.3: saving config space at offset 0x3c 
> (reading 0x4ff)
> [35984.179014] r8169 0000:03:00.0: saving config space at offset 0x10 
> (reading 0x3401)
> [35984.179018] serial 0000:03:00.1: saving config space at offset 0x18 
> (reading 0xd0815004)
> [35984.179013] pci 0000:00:18.7: saving config space at offset 0x0 
> (reading 0x15ef1022)
> [35984.179020] nvme 0000:02:00.0: saving config space at offset 0xc 
> (reading 0x8)
> [35984.179018] serial 0000:03:00.2: saving config space at offset 0x20 
> (reading 0xd0808004)
> [35984.179026] r8169 0000:03:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179030] serial 0000:03:00.1: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179025] pci 0000:00:18.7: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179033] nvme 0000:02:00.0: saving config space at offset 0x10 
> (reading 0xd0900004)
> [35984.179031] serial 0000:03:00.2: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179036] r8169 0000:03:00.0: saving config space at offset 0x18 
> (reading 0xd0814004)
> [35984.179040] serial 0000:03:00.1: saving config space at offset 0x20 
> (reading 0xd0804004)
> [35984.179036] pci 0000:00:18.7: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179043] nvme 0000:02:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179039] ehci-pci 0000:03:00.4: PME# enabled
> [35984.179040] serial 0000:03:00.2: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179045] r8169 0000:03:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179048] serial 0000:03:00.1: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179044] pci 0000:00:18.7: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179052] nvme 0000:02:00.0: saving config space at offset 0x18 
> (reading 0xd0905000)
> [35984.179047] serial 0000:03:00.2: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.179052] r8169 0000:03:00.0: saving config space at offset 0x20 
> (reading 0xd0800004)
> [35984.179056] serial 0000:03:00.1: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179051] ehci-pci 0000:03:00.4: Requested to go to 0
> [35984.179052] pci 0000:00:18.7: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179053] ehci-pci 0000:03:00.4: PCI PM: Suspend power state: D0
> [35984.179059] nvme 0000:02:00.0: saving config space at offset 0x1c 
> (reading 0xd0904000)
> [35984.179058] r8169 0000:03:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179056] serial 0000:03:00.2: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179071] serial 0000:03:00.1: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.179065] pci 0000:00:18.7: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179072] r8169 0000:03:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179075] nvme 0000:02:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179071] serial 0000:03:00.2: saving config space at offset 0x34 
> (reading 0x40)
> [35984.179073] pci 0000:00:18.6: saving config space at offset 0x0 
> (reading 0x15ee1022)
> [35984.179080] serial 0000:03:00.1: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179075] pci 0000:00:18.7: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179080] r8169 0000:03:00.0: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.179083] nvme 0000:02:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179080] pci 0000:00:18.6: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179080] serial 0000:03:00.2: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179088] serial 0000:03:00.1: saving config space at offset 0x34 
> (reading 0x40)
> [35984.179082] pci 0000:00:18.7: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179088] r8169 0000:03:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179087] pci 0000:00:18.6: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179093] nvme 0000:02:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179094] serial 0000:03:00.1: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179090] serial 0000:03:00.2: saving config space at offset 0x3c 
> (reading 0x3ff)
> [35984.179090] pci 0000:00:18.7: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179095] r8169 0000:03:00.0: saving config space at offset 0x34 
> (reading 0x40)
> [35984.179094] pci 0000:00:18.6: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179094] pci 0000:00:18.5: saving config space at offset 0x0 
> (reading 0x15ed1022)
> [35984.179101] nvme 0000:02:00.0: saving config space at offset 0x2c 
> (reading 0x16391c5c)
> [35984.179102] serial 0000:03:00.1: saving config space at offset 0x3c 
> (reading 0x2ff)
> [35984.179098] pci 0000:00:18.7: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179106] r8169 0000:03:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179103] pci 0000:00:18.6: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179103] pci 0000:00:18.5: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179110] nvme 0000:02:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179109] pci 0000:00:18.7: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179114] r8169 0000:03:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [35984.179111] pci 0000:00:18.6: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179111] pci 0000:00:18.5: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179121] nvme 0000:02:00.0: saving config space at offset 0x34 
> (reading 0x80)
> [35984.179117] pci 0000:00:18.6: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179117] pci 0000:00:18.7: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.179121] pci 0000:00:18.5: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179131] nvme 0000:02:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179127] pci 0000:00:18.6: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179127] pci 0000:00:18.7: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179132] pci 0000:00:18.5: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179135] pci 0000:00:18.6: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179141] nvme 0000:02:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [35984.179138] pci 0000:00:18.7: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179142] pci 0000:00:18.6: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179142] pci 0000:00:18.5: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179147] pci 0000:00:18.7: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179154] pci 0000:00:18.6: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179156] pci 0000:00:18.5: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179159] pci 0000:00:18.7: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179163] pci 0000:00:18.4: saving config space at offset 0x0 
> (reading 0x15ec1022)
> [35984.179162] pci 0000:00:18.6: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.179165] pci 0000:00:18.5: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179171] pci 0000:00:18.4: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179170] pci 0000:00:18.6: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179173] pci 0000:00:18.5: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179178] pci 0000:00:18.4: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179179] pci 0000:00:18.6: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179182] pci 0000:00:18.5: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179182] k10temp 0000:00:18.3: saving config space at offset 0x0 
> (reading 0x15eb1022)
> [35984.179186] pci 0000:00:18.4: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179186] pci 0000:00:18.6: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179193] pci 0000:00:18.5: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179195] pci 0000:00:18.4: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179193] pci 0000:00:18.6: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179193] k10temp 0000:00:18.3: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179201] pci 0000:00:18.4: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179201] pci 0000:00:18.5: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.179201] k10temp 0000:00:18.3: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179206] pci 0000:00:18.4: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179206] pci 0000:00:18.5: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179206] k10temp 0000:00:18.3: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179215] pci 0000:00:18.4: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179215] k10temp 0000:00:18.3: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179216] pci 0000:00:18.2: saving config space at offset 0x0 
> (reading 0x15ea1022)
> [35984.179217] pci 0000:00:18.4: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179215] pci 0000:00:18.5: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179218] pci 0000:00:18.2: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179220] pci 0000:00:18.4: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179219] k10temp 0000:00:18.3: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179220] pci 0000:00:18.5: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179220] pci 0000:00:18.2: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179222] pci 0000:00:18.4: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179223] pci 0000:00:18.2: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179223] pci 0000:00:18.5: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179225] pci 0000:00:18.2: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179223] k10temp 0000:00:18.3: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179225] pci 0000:00:18.4: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.179227] pci 0000:00:18.2: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179228] k10temp 0000:00:18.3: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179230] pci 0000:00:18.4: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179229] pci 0000:00:18.2: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179231] pci 0000:00:18.2: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179232] k10temp 0000:00:18.3: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179233] pci 0000:00:18.2: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179232] pci 0000:00:18.4: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179235] pci 0000:00:18.2: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179235] k10temp 0000:00:18.3: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179237] pci 0000:00:18.2: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179237] pci 0000:00:18.4: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179238] k10temp 0000:00:18.3: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179239] pci 0000:00:18.2: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.179242] pci 0000:00:18.2: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179241] k10temp 0000:00:18.3: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.179243] pci 0000:00:18.2: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179245] k10temp 0000:00:18.3: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179246] pci 0000:00:18.2: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179248] pci 0000:00:18.2: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179248] k10temp 0000:00:18.3: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179250] pci 0000:00:18.1: saving config space at offset 0x0 
> (reading 0x15e91022)
> [35984.179251] k10temp 0000:00:18.3: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179253] pci 0000:00:18.4: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179252] serial 0000:03:00.2: Requested to go to 3
> [35984.179254] k10temp 0000:00:18.3: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179255] pci 0000:00:18.1: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179260] pci 0000:00:18.0: saving config space at offset 0x0 
> (reading 0x15e81022)
> [35984.179260] pci 0000:00:18.1: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179266] pci 0000:00:14.3: saving config space at offset 0x0 
> (reading 0x790e1022)
> [35984.179268] pci 0000:00:18.0: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179268] pci 0000:00:18.1: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179273] pci 0000:00:14.3: saving config space at offset 0x4 
> (reading 0x220000f)
> [35984.179281] serial 0000:03:00.1: Requested to go to 3
> [35984.179277] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x0 (reading 0x790b1022)
> [35984.179277] pci 0000:00:18.0: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179278] pci 0000:00:18.1: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179283] pci 0000:00:14.3: saving config space at offset 0x8 
> (reading 0x6010051)
> [35984.179285] pci 0000:00:18.0: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179287] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x4 (reading 0x2200400)
> [35984.179288] pci 0000:00:18.1: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179293] pci 0000:00:14.3: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179295] pci 0000:00:18.0: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179297] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x8 (reading 0xc050061)
> [35984.179298] pci 0000:00:18.1: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179303] pci 0000:00:14.3: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179302] pci 0000:00:18.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179307] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0xc (reading 0x800000)
> [35984.179308] pci 0000:00:18.1: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179313] pci 0000:00:14.3: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179312] pci 0000:00:18.0: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179320] pci 0000:00:08.0: saving config space at offset 0x0 
> (reading 0x14521022)
> [35984.179319] r8169 0000:03:00.0: Requested to go to 3
> [35984.179317] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x10 (reading 0x0)
> [35984.179317] pci 0000:00:18.1: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179320] pci 0000:00:14.3: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179319] pci 0000:00:18.0: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179326] pci 0000:00:08.0: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179323] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x14 (reading 0x0)
> [35984.179326] pci 0000:00:14.3: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179326] pci 0000:00:18.0: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179332] nvme 0000:02:00.0: Requested to go to 3
> [35984.179333] pci 0000:00:08.0: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179327] pci 0000:00:18.1: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179330] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x18 (reading 0x0)
> [35984.179333] pci 0000:00:14.3: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179332] pci 0000:00:18.0: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179340] pci 0000:00:08.0: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179334] pci 0000:00:18.1: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179336] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x1c (reading 0x0)
> [35984.179348] pci 0000:00:14.3: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179347] pci 0000:00:18.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179354] pci 0000:00:08.0: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179349] pci 0000:00:18.1: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.179352] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x20 (reading 0x0)
> [35984.179354] pci 0000:00:14.3: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179353] pci 0000:00:18.0: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.179360] pci 0000:00:08.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179355] pci 0000:00:18.1: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179359] pci 0000:00:14.3: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.179358] pci 0000:00:18.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179360] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x24 (reading 0x0)
> [35984.179366] pci 0000:00:08.0: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179361] pci 0000:00:18.1: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179364] pci 0000:00:14.3: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179363] pci 0000:00:18.0: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179364] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x28 (reading 0x0)
> [35984.179371] pci 0000:00:08.0: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179368] pci 0000:00:14.3: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179367] pci 0000:00:18.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179367] pci 0000:00:18.1: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179369] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x2c (reading 0x512517aa)
> [35984.179375] pci 0000:00:08.0: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179372] pci 0000:00:14.3: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179372] pci 0000:00:18.0: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179379] pci 0000:00:08.0: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179373] pci 0000:00:18.1: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179375] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x30 (reading 0x0)
> [35984.179378] pci 0000:00:14.3: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179384] pci 0000:00:08.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179380] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x34 (reading 0x0)
> [35984.179391] pci 0000:00:08.0: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.179388] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x38 (reading 0x0)
> [35984.179394] pci 0000:00:08.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179397] pci 0000:00:08.0: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179400] pci 0000:00:08.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179394] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x3c (reading 0x0)
> [35984.179402] pci 0000:00:08.0: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179410] pci 0000:00:01.0: saving config space at offset 0x0 
> (reading 0x14521022)
> [35984.179412] pci 0000:00:01.0: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179414] pci 0000:00:01.0: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179416] pci 0000:00:01.0: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179418] pci 0000:00:01.0: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179420] pci 0000:00:01.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179422] pci 0000:00:01.0: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179424] pci 0000:00:01.0: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179426] pci 0000:00:01.0: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179428] pci 0000:00:01.0: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179430] pci 0000:00:01.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179432] pci 0000:00:01.0: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.179433] pci 0000:00:01.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179435] pci 0000:00:01.0: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179437] pci 0000:00:01.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179439] pci 0000:00:01.0: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.179447] pci 0000:00:00.2: saving config space at offset 0x0 
> (reading 0x15d11022)
> [35984.179449] pci 0000:00:00.2: saving config space at offset 0x4 
> (reading 0x100400)
> [35984.179451] pci 0000:00:00.2: saving config space at offset 0x8 
> (reading 0x8060000)
> [35984.179453] pci 0000:00:00.2: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179454] pci 0000:00:00.2: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179456] pci 0000:00:00.2: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179458] pci 0000:00:00.2: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179460] pci 0000:00:00.2: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179462] pci 0000:00:00.2: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179464] pci 0000:00:00.2: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179466] pci 0000:00:00.2: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179468] pci 0000:00:00.2: saving config space at offset 0x2c 
> (reading 0x15d11022)
> [35984.179470] pci 0000:00:00.2: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179472] pci 0000:00:00.2: saving config space at offset 0x34 
> (reading 0x40)
> [35984.179471] pci 0000:00:00.0: saving config space at offset 0x0 
> (reading 0x15d01022)
> [35984.179474] pci 0000:00:00.2: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179473] pci 0000:00:00.0: saving config space at offset 0x4 
> (reading 0x0)
> [35984.179476] pci 0000:00:00.2: saving config space at offset 0x3c 
> (reading 0x1ff)
> [35984.179475] pci 0000:00:00.0: saving config space at offset 0x8 
> (reading 0x6000000)
> [35984.179477] pci 0000:00:00.0: saving config space at offset 0xc 
> (reading 0x800000)
> [35984.179480] pci 0000:00:00.0: saving config space at offset 0x10 
> (reading 0x0)
> [35984.179482] pci 0000:00:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.179484] pci 0000:00:00.0: saving config space at offset 0x18 
> (reading 0x0)
> [35984.179485] pci 0000:00:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.179488] pci 0000:00:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [35984.179489] pci 0000:00:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [35984.179491] pci 0000:00:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.179493] pci 0000:00:00.0: saving config space at offset 0x2c 
> (reading 0x15d01022)
> [35984.179495] pci 0000:00:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.179497] pci 0000:00:00.0: saving config space at offset 0x34 
> (reading 0x0)
> [35984.179499] pci 0000:00:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.179501] pci 0000:00:00.0: saving config space at offset 0x3c 
> (reading 0x0)
> [35984.188078] iwlwifi 0000:01:00.0: Gone into state 3
> [35984.188087] iwlwifi 0000:01:00.0: PCI PM: Suspend power state: D3hot
> [35984.188328] snd_hda_intel 0000:06:00.1: Gone into state 3
> [35984.188329] snd_hda_intel 0000:06:00.1: PCI PM: Suspend power state: 
> D3hot
> [35984.188328] pcieport 0000:00:01.2: saving config space at offset 0x0 
> (reading 0x15d31022)
> [35984.188336] pcieport 0000:00:01.2: saving config space at offset 0x4 
> (reading 0x100407)
> [35984.188340] amdgpu 0000:06:00.0: saving config space at offset 0x0 
> (reading 0x15d81002)
> [35984.188340] pcieport 0000:00:01.2: saving config space at offset 0x8 
> (reading 0x6040000)
> [35984.188343] amdgpu 0000:06:00.0: saving config space at offset 0x4 
> (reading 0x100407)
> [35984.188344] pcieport 0000:00:01.2: saving config space at offset 0xc 
> (reading 0x810008)
> [35984.188346] amdgpu 0000:06:00.0: saving config space at offset 0x8 
> (reading 0x30000d1)
> [35984.188349] amdgpu 0000:06:00.0: saving config space at offset 0xc 
> (reading 0x800008)
> [35984.188348] pcieport 0000:00:01.2: saving config space at offset 0x10 
> (reading 0x0)
> [35984.188351] amdgpu 0000:06:00.0: saving config space at offset 0x10 
> (reading 0xc000000c)
> [35984.188352] pcieport 0000:00:01.2: saving config space at offset 0x14 
> (reading 0x0)
> [35984.188354] amdgpu 0000:06:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.188356] amdgpu 0000:06:00.0: saving config space at offset 0x18 
> (reading 0xd000000c)
> [35984.188356] pcieport 0000:00:01.2: saving config space at offset 0x18 
> (reading 0x10100)
> [35984.188358] amdgpu 0000:06:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [35984.188359] pcieport 0000:00:01.2: saving config space at offset 0x1c 
> (reading 0x20004141)
> [35984.188361] amdgpu 0000:06:00.0: saving config space at offset 0x20 
> (reading 0x1001)
> [35984.188364] amdgpu 0000:06:00.0: saving config space at offset 0x24 
> (reading 0xd0500000)
> [35984.188364] pcieport 0000:00:01.2: saving config space at offset 0x20 
> (reading 0xd0a0d0a0)
> [35984.188366] amdgpu 0000:06:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.188367] pcieport 0000:00:01.2: saving config space at offset 0x24 
> (reading 0xd0c1d0b1)
> [35984.188369] amdgpu 0000:06:00.0: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [35984.188371] amdgpu 0000:06:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.188371] pcieport 0000:00:01.2: saving config space at offset 0x28 
> (reading 0x0)
> [35984.188373] amdgpu 0000:06:00.0: saving config space at offset 0x34 
> (reading 0x48)
> [35984.188374] pcieport 0000:00:01.2: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.188376] amdgpu 0000:06:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.188378] amdgpu 0000:06:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [35984.188378] pcieport 0000:00:01.2: saving config space at offset 0x30 
> (reading 0x0)
> [35984.188382] pcieport 0000:00:01.2: saving config space at offset 0x34 
> (reading 0x50)
> [35984.188385] pcieport 0000:00:01.2: saving config space at offset 0x38 
> (reading 0x0)
> [35984.188389] pcieport 0000:00:01.2: saving config space at offset 0x3c 
> (reading 0x200ff)
> [35984.188428] amdgpu 0000:06:00.0: Requested to go to 3
> [35984.188433] pcieport 0000:00:01.2: PCI PM: Suspend power state: D0
> [35984.189476] r8169 0000:03:00.0: Gone into state 3
> [35984.189478] r8169 0000:03:00.0: PCI PM: Suspend power state: D3hot
> [35984.189534] r8169 0000:04:00.0: Gone into state 3
> [35984.189536] r8169 0000:04:00.0: PCI PM: Suspend power state: D3hot
> [35984.189540] serial 0000:03:00.2: Gone into state 3
> [35984.189543] serial 0000:03:00.2: PCI PM: Suspend power state: D3hot
> [35984.189546] snd_hda_intel 0000:06:00.6: Gone into state 3
> [35984.189554] snd_hda_intel 0000:06:00.6: PCI PM: Suspend power state: 
> D3hot
> [35984.189798] rtsx_pci 0000:05:00.0: Gone into state 3
> [35984.189800] rtsx_pci 0000:05:00.0: PCI PM: Suspend power state: D3hot
> [35984.189808] pcieport 0000:00:01.6: saving config space at offset 0x0 
> (reading 0x15d31022)
> [35984.189803] ccp 0000:06:00.2: Gone into state 3
> [35984.189867] snd_pci_acp3x 0000:06:00.5: Gone into state 3
> [35984.189806] serial 0000:03:00.1: Gone into state 3
> [35984.189807] ccp 0000:06:00.2: PCI PM: Suspend power state: D3hot
> [35984.189808] serial 0000:03:00.1: PCI PM: Suspend power state: D3hot
> [35984.189873] snd_pci_acp3x 0000:06:00.5: PCI PM: Suspend power state: 
> D3hot
> [35984.189877] pcieport 0000:00:01.6: saving config space at offset 0x4 
> (reading 0x100407)
> [35984.189872] nvme 0000:02:00.0: Gone into state 3
> [35984.189873] pcieport 0000:00:01.7: saving config space at offset 0x0 
> (reading 0x15d31022)
> [35984.189880] pcieport 0000:00:01.6: saving config space at offset 0x8 
> (reading 0x6040000)
> [35984.189874] pcieport 0000:00:01.4: saving config space at offset 0x0 
> (reading 0x15d31022)
> [35984.189875] nvme 0000:02:00.0: PCI PM: Suspend power state: D3hot
> [35984.189882] pcieport 0000:00:01.6: saving config space at offset 0xc 
> (reading 0x810008)
> [35984.189878] pcieport 0000:00:01.7: saving config space at offset 0x4 
> (reading 0x100407)
> [35984.189879] pcieport 0000:00:01.4: saving config space at offset 0x4 
> (reading 0x100407)
> [35984.189885] pcieport 0000:00:01.6: saving config space at offset 0x10 
> (reading 0x0)
> [35984.189882] pcieport 0000:00:01.7: saving config space at offset 0x8 
> (reading 0x6040000)
> [35984.189888] pcieport 0000:00:01.6: saving config space at offset 0x14 
> (reading 0x0)
> [35984.189884] pcieport 0000:00:01.4: saving config space at offset 0x8 
> (reading 0x6040000)
> [35984.189891] pcieport 0000:00:01.6: saving config space at offset 0x18 
> (reading 0x40400)
> [35984.189886] pcieport 0000:00:01.7: saving config space at offset 0xc 
> (reading 0x810008)
> [35984.189893] pcieport 0000:00:01.6: saving config space at offset 0x1c 
> (reading 0x2121)
> [35984.189889] pcieport 0000:00:01.4: saving config space at offset 0xc 
> (reading 0x810008)
> [35984.189890] pcieport 0000:00:01.7: saving config space at offset 0x10 
> (reading 0x0)
> [35984.189896] pcieport 0000:00:01.6: saving config space at offset 0x20 
> (reading 0xd070d070)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0x0 
> (reading 0x15d31022)
> [35984.189893] pcieport 0000:00:01.4: saving config space at offset 0x10 
> (reading 0x0)
> [35984.189899] pcieport 0000:00:01.6: saving config space at offset 0x24 
> (reading 0x1fff1)
> [35984.189895] pcieport 0000:00:01.7: saving config space at offset 0x14 
> (reading 0x0)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0x4 
> (reading 0x100407)
> [35984.189902] pcieport 0000:00:01.6: saving config space at offset 0x28 
> (reading 0x0)
> [35984.189898] pcieport 0000:00:01.4: saving config space at offset 0x14 
> (reading 0x0)
> [35984.189899] pcieport 0000:00:01.7: saving config space at offset 0x18 
> (reading 0x50500)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0x8 
> (reading 0x6040000)
> [35984.189906] pcieport 0000:00:01.6: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.189902] pcieport 0000:00:01.4: saving config space at offset 0x18 
> (reading 0x30300)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0xc 
> (reading 0x810008)
> [35984.189904] pcieport 0000:00:01.7: saving config space at offset 0x1c 
> (reading 0x1f1)
> [35984.189911] pcieport 0000:00:01.6: saving config space at offset 0x30 
> (reading 0x0)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0x10 
> (reading 0x0)
> [35984.189907] pcieport 0000:00:01.4: saving config space at offset 0x1c 
> (reading 0x20003131)
> [35984.189914] pcieport 0000:00:01.6: saving config space at offset 0x34 
> (reading 0x50)
> [35984.189909] pcieport 0000:00:01.7: saving config space at offset 0x20 
> (reading 0xd060d060)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0x14 
> (reading 0x0)
> [35984.189917] pcieport 0000:00:01.6: saving config space at offset 0x38 
> (reading 0x0)
> [35984.189913] pcieport 0000:00:01.4: saving config space at offset 0x20 
> (reading 0xd080d080)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0x18 
> (reading 0x20200)
> [35984.189914] pcieport 0000:00:01.7: saving config space at offset 0x24 
> (reading 0x1fff1)
> [35984.189921] pcieport 0000:00:01.6: saving config space at offset 0x3c 
> (reading 0x200ff)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0x1c 
> (reading 0x1f1)
> [35984.189918] pcieport 0000:00:01.4: saving config space at offset 0x24 
> (reading 0x1fff1)
> [35984.189919] pcieport 0000:00:01.7: saving config space at offset 0x28 
> (reading 0x0)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0x20 
> (reading 0xd090d090)
> [35984.189923] pcieport 0000:00:01.4: saving config space at offset 0x28 
> (reading 0x0)
> [35984.189924] pcieport 0000:00:01.7: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0x24 
> (reading 0x1fff1)
> [35984.189928] pcieport 0000:00:01.4: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.189929] pcieport 0000:00:01.7: saving config space at offset 0x30 
> (reading 0x0)
> [35984.189935] pcieport 0000:00:01.3: saving config space at offset 0x28 
> (reading 0x0)
> [35984.189933] pcieport 0000:00:01.4: saving config space at offset 0x30 
> (reading 0x0)
> [35984.189934] pcieport 0000:00:01.7: saving config space at offset 0x34 
> (reading 0x50)
> [35984.189938] pcieport 0000:00:01.3: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.189938] pcieport 0000:00:01.4: saving config space at offset 0x34 
> (reading 0x50)
> [35984.189939] pcieport 0000:00:01.7: saving config space at offset 0x38 
> (reading 0x0)
> [35984.189943] pcieport 0000:00:01.3: saving config space at offset 0x30 
> (reading 0x0)
> [35984.189943] pcieport 0000:00:01.4: saving config space at offset 0x38 
> (reading 0x0)
> [35984.189944] pcieport 0000:00:01.7: saving config space at offset 0x3c 
> (reading 0x200ff)
> [35984.189948] pcieport 0000:00:01.3: saving config space at offset 0x34 
> (reading 0x50)
> [35984.189949] pcieport 0000:00:01.4: saving config space at offset 0x3c 
> (reading 0x200ff)
> [35984.189953] pcieport 0000:00:01.3: saving config space at offset 0x38 
> (reading 0x0)
> [35984.189958] pcieport 0000:00:01.3: saving config space at offset 0x3c 
> (reading 0x200ff)
> [35984.189991] pcieport 0000:00:01.6: PME# enabled
> [35984.189996] pcieport 0000:00:01.6: Requested to go to 3
> [35984.190032] pcieport 0000:00:01.4: PCI PM: Suspend power state: D0
> [35984.190034] pcieport 0000:00:01.7: PME# enabled
> [35984.190045] pcieport 0000:00:01.7: Requested to go to 3
> [35984.190050] pcieport 0000:00:01.3: PME# enabled
> [35984.190060] pcieport 0000:00:01.3: Requested to go to 3
> [35984.200806] amdgpu 0000:06:00.0: Gone into state 3
> [35984.200830] amdgpu 0000:06:00.0: PCI PM: Suspend power state: D3hot
> [35984.201488] pcieport 0000:00:01.6: Gone into state 3
> [35984.201492] pcieport 0000:00:01.6: PCI PM: Suspend power state: D3hot
> [35984.201508] pcieport 0000:00:01.7: Gone into state 3
> [35984.201525] pcieport 0000:00:01.7: PCI PM: Suspend power state: D3hot
> [35984.201526] xhci_hcd 0000:06:00.4: Gone into state 3
> [35984.201527] xhci_hcd 0000:06:00.3: Gone into state 3
> [35984.201545] xhci_hcd 0000:06:00.4: PCI PM: Suspend power state: D3hot
> [35984.202138] pcieport 0000:00:01.3: Gone into state 3
> [35984.202150] pcieport 0000:00:01.3: PCI PM: Suspend power state: D3hot
> [35984.229610] xhci_hcd 0000:06:00.3: power state changed by ACPI to D3hot
> [35984.229633] xhci_hcd 0000:06:00.3: PCI PM: Suspend power state: D3hot
> [35984.229711] pcieport 0000:00:08.1: saving config space at offset 0x0 
> (reading 0x15db1022)
> [35984.229723] pcieport 0000:00:08.1: saving config space at offset 0x4 
> (reading 0x100407)
> [35984.229728] pcieport 0000:00:08.1: saving config space at offset 0x8 
> (reading 0x6040000)
> [35984.229733] pcieport 0000:00:08.1: saving config space at offset 0xc 
> (reading 0x810008)
> [35984.229737] pcieport 0000:00:08.1: saving config space at offset 0x10 
> (reading 0x0)
> [35984.229742] pcieport 0000:00:08.1: saving config space at offset 0x14 
> (reading 0x0)
> [35984.229746] pcieport 0000:00:08.1: saving config space at offset 0x18 
> (reading 0x60600)
> [35984.229750] pcieport 0000:00:08.1: saving config space at offset 0x1c 
> (reading 0x1111)
> [35984.229754] pcieport 0000:00:08.1: saving config space at offset 0x20 
> (reading 0xd050d020)
> [35984.229758] pcieport 0000:00:08.1: saving config space at offset 0x24 
> (reading 0xd011c001)
> [35984.229762] pcieport 0000:00:08.1: saving config space at offset 0x28 
> (reading 0x0)
> [35984.229766] pcieport 0000:00:08.1: saving config space at offset 0x2c 
> (reading 0x0)
> [35984.229770] pcieport 0000:00:08.1: saving config space at offset 0x30 
> (reading 0x0)
> [35984.229773] pcieport 0000:00:08.1: saving config space at offset 0x34 
> (reading 0x50)
> [35984.229777] pcieport 0000:00:08.1: saving config space at offset 0x38 
> (reading 0x0)
> [35984.229781] pcieport 0000:00:08.1: saving config space at offset 0x3c 
> (reading 0x201ff)
> [35984.229818] pcieport 0000:00:08.1: PME# enabled
> [35984.229847] pcieport 0000:00:08.1: Requested to go to 3
> [35984.242255] pcieport 0000:00:08.1: Gone into state 3
> [35984.242279] pcieport 0000:00:08.1: PCI PM: Suspend power state: D3hot
> [35984.242351] ACPI: PM: Preparing to enter system sleep state S3
> [35984.248199] ACPI: EC: event blocked
> [35984.248201] ACPI: EC: EC stopped
> [35984.248202] ACPI: PM: Saving platform NVS memory
> [35984.248567] Disabling non-boot CPUs ...
> [35984.251088] smpboot: CPU 1 is now offline
> [35984.253774] smpboot: CPU 2 is now offline
> [35984.256027] smpboot: CPU 3 is now offline
> [35984.258133] smpboot: CPU 4 is now offline
> [35984.260098] smpboot: CPU 5 is now offline
> [35984.262293] smpboot: CPU 6 is now offline
> [35984.264191] smpboot: CPU 7 is now offline
> [35984.264419] ACPI: PM: Low-level resume complete
> [35984.264419] ACPI: EC: EC started
> [35984.264419] ACPI: PM: Restoring platform NVS memory
> [35984.264419] AMD-Vi: Virtual APIC enabled
> [35984.264419] AMD-Vi: Virtual APIC enabled
> [35984.264419] Enabling non-boot CPUs ...
> [35984.264419] x86: Booting SMP configuration:
> [35984.264419] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [35984.265528] ACPI: \_PR_.C001: Found 2 idle states
> [35984.266372] CPU1 is up
> [35984.266512] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [35984.267181] ACPI: \_PR_.C002: Found 2 idle states
> [35984.267871] CPU2 is up
> [35984.267940] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [35984.268531] ACPI: \_PR_.C003: Found 2 idle states
> [35984.269156] CPU3 is up
> [35984.269225] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [35984.270685] ACPI: \_PR_.C004: Found 2 idle states
> [35984.271486] CPU4 is up
> [35984.271565] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [35984.272126] ACPI: \_PR_.C005: Found 2 idle states
> [35984.272948] CPU5 is up
> [35984.273033] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [35984.273703] ACPI: \_PR_.C006: Found 2 idle states
> [35984.274721] CPU6 is up
> [35984.274819] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [35984.275423] ACPI: \_PR_.C007: Found 2 idle states
> [35984.276373] CPU7 is up
> [35984.278606] ACPI: PM: Waking up from system sleep state S3
> [35984.831780] pci 0000:00:00.2: restoring config space at offset 0x3c 
> (was 0x100, writing 0x1ff)
> [35984.831805] ACPI: EC: interrupt unblocked
> [35984.831825] pci 0000:00:00.2: restoring config space at offset 0x4 
> (was 0x100004, writing 0x100400)
> [35984.831887] pcieport 0000:00:01.2: restoring config space at offset 
> 0x3c (was 0xff, writing 0x200ff)
> [35984.831898] pcieport 0000:00:01.2: restoring config space at offset 
> 0x30 (was 0xffff, writing 0x0)
> [35984.831898] pcieport 0000:00:01.3: restoring config space at offset 
> 0x3c (was 0xff, writing 0x200ff)
> [35984.831906] pcieport 0000:00:01.3: restoring config space at offset 
> 0x30 (was 0xffff, writing 0x0)
> [35984.831907] pcieport 0000:00:01.2: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [35984.831910] pcieport 0000:00:01.3: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [35984.831914] pcieport 0000:00:01.3: restoring config space at offset 
> 0x28 (was 0xffffffff, writing 0x0)
> [35984.831916] pcieport 0000:00:01.2: restoring config space at offset 
> 0x28 (was 0xffffffff, writing 0x0)
> [35984.831918] pcieport 0000:00:01.3: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0x1fff1)
> [35984.831924] pcieport 0000:00:01.2: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0xd0c1d0b1)
> [35984.831925] pcieport 0000:00:01.4: restoring config space at offset 
> 0x3c (was 0xff, writing 0x200ff)
> [35984.831927] pcieport 0000:00:01.3: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [35984.831935] pcieport 0000:00:01.2: restoring config space at offset 
> 0x1c (was 0x1f1, writing 0x20004141)
> [35984.831935] pcieport 0000:00:01.3: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [35984.831940] pcieport 0000:00:01.4: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [35984.831949] pcieport 0000:00:01.4: restoring config space at offset 
> 0x28 (was 0xffffffff, writing 0x0)
> [35984.831951] pcieport 0000:00:01.2: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [35984.831956] pcieport 0000:00:01.4: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0x1fff1)
> [35984.831961] pcieport 0000:00:01.2: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [35984.831966] pcieport 0000:00:01.4: restoring config space at offset 
> 0x1c (was 0x3131, writing 0x20003131)
> [35984.831982] pcieport 0000:00:01.4: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [35984.831997] pcieport 0000:00:01.4: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [35984.832057] pcieport 0000:00:01.6: restoring config space at offset 
> 0x3c (was 0xff, writing 0x200ff)
> [35984.832066] pcieport 0000:00:01.6: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [35984.832071] pcieport 0000:00:01.6: restoring config space at offset 
> 0x28 (was 0xffffffff, writing 0x0)
> [35984.832075] pcieport 0000:00:01.6: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0x1fff1)
> [35984.832093] pcieport 0000:00:01.6: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [35984.832090] pcieport 0000:00:01.7: restoring config space at offset 
> 0x3c (was 0xff, writing 0x200ff)
> [35984.832096] pcieport 0000:00:01.6: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [35984.832112] pcieport 0000:00:01.7: restoring config space at offset 
> 0x30 (was 0xffff, writing 0x0)
> [35984.832121] pcieport 0000:00:01.7: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [35984.832128] pcieport 0000:00:01.7: restoring config space at offset 
> 0x28 (was 0xffffffff, writing 0x0)
> [35984.832136] pcieport 0000:00:08.1: restoring config space at offset 
> 0x3c (was 0x1ff, writing 0x201ff)
> [35984.832138] pcieport 0000:00:01.7: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0x1fff1)
> [35984.832157] pcieport 0000:00:08.1: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [35984.832162] pcieport 0000:00:01.7: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [35984.832166] pcieport 0000:00:08.1: restoring config space at offset 
> 0x28 (was 0x0, writing 0x0)
> [35984.832175] pcieport 0000:00:01.7: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [35984.832176] pcieport 0000:00:08.1: restoring config space at offset 
> 0x24 (was 0xd011c001, writing 0xd011c001)
> [35984.832211] pcieport 0000:00:08.1: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [35984.832213] piix4_smbus 0000:00:14.0: restoring config space at 
> offset 0x4 (was 0x2200403, writing 0x2200400)
> [35984.832222] pcieport 0000:00:08.1: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [35984.832757] r8169 0000:03:00.0: restoring config space at offset 0x20 
> (was 0x4, writing 0xd0800004)
> [35984.832784] serial 0000:03:00.1: restoring config space at offset 
> 0x20 (was 0x4, writing 0xd0804004)
> [35984.832803] serial 0000:03:00.2: restoring config space at offset 
> 0x20 (was 0x4, writing 0xd0808004)
> [35984.832803] r8169 0000:03:00.0: restoring config space at offset 0x18 
> (was 0x4, writing 0xd0814004)
> [35984.832825] nvme 0000:02:00.0: restoring config space at offset 0xc 
> (was 0x0, writing 0x8)
> [35984.832826] pci 0000:03:00.3: restoring config space at offset 0x20 
> (was 0x4, writing 0xd080c004)
> [35984.832836] serial 0000:03:00.1: restoring config space at offset 
> 0x18 (was 0x4, writing 0xd0815004)
> [35984.832849] ehci-pci 0000:03:00.4: restoring config space at offset 
> 0x18 (was 0x4, writing 0xd0810004)
> [35984.832850] serial 0000:03:00.2: restoring config space at offset 
> 0x18 (was 0x4, writing 0xd0816004)
> [35984.832851] r8169 0000:03:00.0: restoring config space at offset 0x10 
> (was 0x1, writing 0x3401)
> [35984.832860] r8169 0000:04:00.0: restoring config space at offset 0x20 
> (was 0x4, writing 0xd0700004)
> [35984.832859] nvme 0000:02:00.0: restoring config space at offset 0x4 
> (was 0x100007, writing 0x100003)
> [35984.832881] pci 0000:03:00.3: restoring config space at offset 0x18 
> (was 0x4, writing 0xd0817004)
> [35984.832883] serial 0000:03:00.1: restoring config space at offset 
> 0x10 (was 0x1, writing 0x3201)
> [35984.832887] r8169 0000:03:00.0: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [35984.832896] serial 0000:03:00.2: restoring config space at offset 
> 0x10 (was 0x1, writing 0x3101)
> [35984.832901] ehci-pci 0000:03:00.4: restoring config space at offset 
> 0x10 (was 0x0, writing 0xd0818000)
> [35984.832905] rtsx_pci 0000:05:00.0: restoring config space at offset 
> 0x10 (was 0x0, writing 0xd0600000)
> [35984.832908] r8169 0000:04:00.0: restoring config space at offset 0x18 
> (was 0x4, writing 0xd0704004)
> [35984.832921] serial 0000:03:00.1: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [35984.832922] r8169 0000:03:00.0: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100403)
> [35984.832930] pci 0000:03:00.3: restoring config space at offset 0x10 
> (was 0x1, writing 0x3001)
> [35984.832933] serial 0000:03:00.2: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [35984.832938] rtsx_pci 0000:05:00.0: restoring config space at offset 
> 0xc (was 0x0, writing 0x8)
> [35984.832940] ehci-pci 0000:03:00.4: restoring config space at offset 
> 0xc (was 0x800000, writing 0x800008)
> [35984.832956] r8169 0000:04:00.0: restoring config space at offset 0x10 
> (was 0x1, writing 0x2001)
> [35984.832966] serial 0000:03:00.1: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100003)
> [35984.832972] pci 0000:03:00.3: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [35984.832977] rtsx_pci 0000:05:00.0: restoring config space at offset 
> 0x4 (was 0x100000, writing 0x100406)
> [35984.832974] serial 0000:03:00.2: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100003)
> [35984.832982] ehci-pci 0000:03:00.4: restoring config space at offset 
> 0x4 (was 0x100000, writing 0x100402)
> [35984.832998] r8169 0000:04:00.0: restoring config space at offset 0xc 
> (was 0x0, writing 0x8)
> [35984.833037] r8169 0000:04:00.0: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100403)
> [35984.833186] amdgpu 0000:06:00.0: restoring config space at offset 
> 0x24 (was 0x0, writing 0xd0500000)
> [35984.833199] ccp 0000:06:00.2: restoring config space at offset 0x3c 
> (was 0x300, writing 0x3ff)
> [35984.833203] xhci_hcd 0000:06:00.4: restoring config space at offset 
> 0x3c (was 0x100, writing 0x1ff)
> [35984.833216] amdgpu 0000:06:00.0: restoring config space at offset 
> 0x20 (was 0x1, writing 0x1001)
> [35984.833243] amdgpu 0000:06:00.0: restoring config space at offset 
> 0x18 (was 0xc, writing 0xd000000c)
> [35984.833245] ccp 0000:06:00.2: restoring config space at offset 0x24 
> (was 0x0, writing 0xd05cc000)
> [35984.833251] snd_pci_acp3x 0000:06:00.5: restoring config space at 
> offset 0x3c (was 0x200, writing 0x2ff)
> [35984.833261] amdgpu 0000:06:00.0: restoring config space at offset 
> 0x10 (was 0xc, writing 0xc000000c)
> [35984.833261] xhci_hcd 0000:06:00.4: restoring config space at offset 
> 0x10 (was 0x4, writing 0xd0300004)
> [35984.833273] ccp 0000:06:00.2: restoring config space at offset 0x18 
> (was 0x0, writing 0xd0400000)
> [35984.833278] xhci_hcd 0000:06:00.4: restoring config space at offset 
> 0xc (was 0x800000, writing 0x800008)
> [35984.833280] amdgpu 0000:06:00.0: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [35984.833300] snd_hda_intel 0000:06:00.6: restoring config space at 
> offset 0x3c (was 0x300, writing 0x3ff)
> [35984.833296] xhci_hcd 0000:06:00.4: restoring config space at offset 
> 0x4 (was 0x100000, writing 0x100403)
> [35984.833301] amdgpu 0000:06:00.0: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100407)
> [35984.833303] ccp 0000:06:00.2: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [35984.833315] snd_pci_acp3x 0000:06:00.5: restoring config space at 
> offset 0x10 (was 0x0, writing 0xd0580000)
> [35984.833324] ccp 0000:06:00.2: restoring config space at offset 0x4 
> (was 0x100000, writing 0x8100406)
> [35984.833334] snd_pci_acp3x 0000:06:00.5: restoring config space at 
> offset 0xc (was 0x800000, writing 0x800008)
> [35984.833355] snd_pci_acp3x 0000:06:00.5: restoring config space at 
> offset 0x4 (was 0x100000, writing 0x100006)
> [35984.833366] snd_hda_intel 0000:06:00.6: restoring config space at 
> offset 0x10 (was 0x0, writing 0xd05c0000)
> [35984.833383] snd_hda_intel 0000:06:00.6: restoring config space at 
> offset 0xc (was 0x800000, writing 0x800008)
> [35984.833401] snd_hda_intel 0000:06:00.6: restoring config space at 
> offset 0x4 (was 0x100000, writing 0x100006)
> [35984.833441] snd_hda_intel 0000:06:00.1: restoring config space at 
> offset 0x10 (was 0x0, writing 0xd05c8000)
> [35984.833448] snd_hda_intel 0000:06:00.1: restoring config space at 
> offset 0xc (was 0x800000, writing 0x800008)
> [35984.833454] snd_hda_intel 0000:06:00.1: restoring config space at 
> offset 0x4 (was 0x100000, writing 0x100006)
> [35984.835020] iwlwifi 0000:01:00.0: restoring config space at offset 
> 0x3c (was 0x100, writing 0x1ff)
> [35984.835041] iwlwifi 0000:01:00.0: restoring config space at offset 
> 0x10 (was 0x4, writing 0xd0a00004)
> [35984.835051] iwlwifi 0000:01:00.0: restoring config space at offset 
> 0x4 (was 0x100000, writing 0x100406)
> [35984.901907] xhci_hcd 0000:06:00.3: power state changed by ACPI to D0
> [35984.901947] xhci_hcd 0000:06:00.3: restoring config space at offset 
> 0x3c (was 0x400, writing 0x4ff)
> [35984.901968] xhci_hcd 0000:06:00.3: restoring config space at offset 
> 0x10 (was 0x4, writing 0xd0200004)
> [35984.901976] xhci_hcd 0000:06:00.3: restoring config space at offset 
> 0xc (was 0x800000, writing 0x800008)
> [35984.901984] xhci_hcd 0000:06:00.3: restoring config space at offset 
> 0x4 (was 0x100000, writing 0x100403)
> [35984.903360] pci 0000:00:00.2: Requested to go to 0
> [35984.903377] pcieport 0000:00:01.3: PME# disabled
> [35984.903385] pcieport 0000:00:01.6: PME# disabled
> [35984.903391] pcieport 0000:00:01.7: PME# disabled
> [35984.903431] ehci-pci 0000:03:00.4: PME# disabled
> [35984.903431] pcieport 0000:00:08.1: PME# disabled
> [35984.903437] ACPI: EC: event unblocked
> [35984.903444] ehci-pci 0000:03:00.4: Requested to go to 0
> [35984.903465] ehci-pci 0000:03:00.4: enabling bus mastering
> [35984.903491] usb usb1: root hub lost power or was reset
> [35984.903513] ehci-pci 0000:03:00.4: enabling Mem-Wr-Inval
> [35984.903530] xhci_hcd 0000:06:00.3: PME# disabled
> [35984.903538] xhci_hcd 0000:06:00.3: Requested to go to 0
> [35984.903548] xhci_hcd 0000:06:00.3: enabling bus mastering
> [35984.903843] xhci_hcd 0000:06:00.4: PME# disabled
> [35984.903851] xhci_hcd 0000:06:00.4: Requested to go to 0
> [35984.903858] xhci_hcd 0000:06:00.4: enabling bus mastering
> [35984.904441] [drm] PCIE GART of 1024M enabled.
> [35984.904444] [drm] PTB located at 0x000000F400A00000
> [35984.904462] [drm] PSP is resuming...
> [35984.905933] nvme 0000:02:00.0: Requested to go to 0
> [35984.905942] nvme 0000:02:00.0: enabling bus mastering
> [35984.906528] nvme 0000:02:00.0: saving config space at offset 0x0 
> (reading 0x16391c5c)
> [35984.906533] nvme 0000:02:00.0: saving config space at offset 0x4 
> (reading 0x100407)
> [35984.906536] nvme 0000:02:00.0: saving config space at offset 0x8 
> (reading 0x1080200)
> [35984.906539] nvme 0000:02:00.0: saving config space at offset 0xc 
> (reading 0x8)
> [35984.906541] nvme 0000:02:00.0: saving config space at offset 0x10 
> (reading 0xd0900004)
> [35984.906544] nvme 0000:02:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [35984.906547] nvme 0000:02:00.0: saving config space at offset 0x18 
> (reading 0xd0905000)
> [35984.906550] nvme 0000:02:00.0: saving config space at offset 0x1c 
> (reading 0xd0904000)
> [35984.906552] nvme 0000:02:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [35984.906555] nvme 0000:02:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [35984.906557] nvme 0000:02:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [35984.906560] nvme 0000:02:00.0: saving config space at offset 0x2c 
> (reading 0x16391c5c)
> [35984.906562] nvme 0000:02:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [35984.906565] nvme 0000:02:00.0: saving config space at offset 0x34 
> (reading 0x80)
> [35984.906567] nvme 0000:02:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [35984.906570] nvme 0000:02:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [35984.924342] [drm] reserve 0x400000 from 0xf401c00000 for PSP TMR
> [35985.024639] amdgpu 0000:06:00.0: amdgpu: RAS: optional ras ta ucode 
> is not available
> [35985.038898] amdgpu 0000:06:00.0: amdgpu: RAP: optional rap ta ucode 
> is not available
> [35985.045321] amdgpu: restore the fine grain parameters
> [35985.192142] usb 2-2: reset high-speed USB device number 3 using xhci_hcd
> [35985.195137] nvme nvme0: 16/0/0 default/read/poll queues
> [35985.383807] usb 4-1.3.3.1: reset full-speed USB device number 7 using 
> xhci_hcd
> [35985.467246] usb 2-1: reset full-speed USB device number 2 using xhci_hcd
> [35985.703943] [drm] kiq ring mec 2 pipe 1 q 0
> [35985.704177] usb 2-2.2: reset full-speed USB device number 5 using 
> xhci_hcd
> [35985.715362] [drm] VCN decode and encode initialized 
> successfully(under SPG Mode).
> [35985.715376] amdgpu 0000:06:00.0: amdgpu: ring gfx uses VM inv eng 0 
> on hub 0
> [35985.715378] amdgpu 0000:06:00.0: amdgpu: ring gfx_low uses VM inv eng 
> 1 on hub 0
> [35985.715380] amdgpu 0000:06:00.0: amdgpu: ring gfx_high uses VM inv 
> eng 4 on hub 0
> [35985.715381] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
> eng 5 on hub 0
> [35985.715383] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
> eng 6 on hub 0
> [35985.715384] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
> eng 7 on hub 0
> [35985.715385] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
> eng 8 on hub 0
> [35985.715386] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
> eng 9 on hub 0
> [35985.715387] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
> eng 10 on hub 0
> [35985.715389] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
> eng 11 on hub 0
> [35985.715390] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
> eng 12 on hub 0
> [35985.715391] amdgpu 0000:06:00.0: amdgpu: ring kiq_2.1.0 uses VM inv 
> eng 13 on hub 0
> [35985.715392] amdgpu 0000:06:00.0: amdgpu: ring sdma0 uses VM inv eng 0 
> on hub 1
> [35985.715394] amdgpu 0000:06:00.0: amdgpu: ring vcn_dec uses VM inv eng 
> 1 on hub 1
> [35985.715395] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc0 uses VM inv 
> eng 4 on hub 1
> [35985.715396] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc1 uses VM inv 
> eng 5 on hub 1
> [35985.715397] amdgpu 0000:06:00.0: amdgpu: ring jpeg_dec uses VM inv 
> eng 6 on hub 1
> [35985.830794] psmouse serio1: synaptics: queried max coordinates: x 
> [..5678], y [..4694]
> [35985.872427] psmouse serio1: synaptics: queried min coordinates: x 
> [1266..], y [1162..]
> [35985.896517] usb 2-2.1: reset high-speed USB device number 4 using 
> xhci_hcd
> [35986.221508] [drm] Fence fallback timer expired on ring gfx
> [35986.270126] OOM killer enabled.
> [35986.270129] Restarting tasks ...
> [35986.270145] pcieport 0000:00:01.2: scanning [bus 01-01] behind 
> bridge, pass 0
> [35986.270155] pci_bus 0000:01: scanning bus
> [35986.270157] pci_bus 0000:01: bus scan returning with max=01
> [35986.270161] pcieport 0000:00:01.3: scanning [bus 02-02] behind 
> bridge, pass 0
> [35986.270167] pci_bus 0000:02: scanning bus
> [35986.270168] pci_bus 0000:02: bus scan returning with max=02
> [35986.270171] pcieport 0000:00:01.4: scanning [bus 03-03] behind 
> bridge, pass 0
> [35986.270177] pci_bus 0000:03: scanning bus
> [35986.270183] pci_bus 0000:03: bus scan returning with max=03
> [35986.270186] pcieport 0000:00:01.6: scanning [bus 04-04] behind 
> bridge, pass 0
> [35986.270192] pci_bus 0000:04: scanning bus
> [35986.270194] pci_bus 0000:04: bus scan returning with max=04
> [35986.270197] pcieport 0000:00:01.7: scanning [bus 05-05] behind 
> bridge, pass 0
> [35986.270203] pci_bus 0000:05: scanning bus
> [35986.270205] pci_bus 0000:05: bus scan returning with max=05
> [35986.270209] pcieport 0000:00:01.2: scanning [bus 01-01] behind 
> bridge, pass 1
> [35986.270216] pci_bus 0000:01: Allocating resources
> [35986.270225] pcieport 0000:00:01.3: scanning [bus 02-02] behind 
> bridge, pass 1
> [35986.270232] pci_bus 0000:02: Allocating resources
> [35986.270236] pcieport 0000:00:01.3: bridge window [io  0x1000-0x0fff] 
> to [bus 02] add_size 1000
> [35986.270241] pcieport 0000:00:01.3: bridge window [mem 
> 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 
> 100000
> [35986.270245] pcieport 0000:00:01.4: scanning [bus 03-03] behind 
> bridge, pass 1
> [35986.270252] pci_bus 0000:03: Allocating resources
> [35986.270268] pcieport 0000:00:01.4: bridge window [mem 
> 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 
> 100000
> [35986.270272] pcieport 0000:00:01.6: scanning [bus 04-04] behind 
> bridge, pass 1
> [35986.270278] pci_bus 0000:04: Allocating resources
> [35986.270283] pcieport 0000:00:01.6: bridge window [mem 
> 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 
> 100000
> [35986.270286] pcieport 0000:00:01.7: scanning [bus 05-05] behind 
> bridge, pass 1
> [35986.270292] pci_bus 0000:05: Allocating resources
> [35986.270298] pcieport 0000:00:01.7: bridge window [io  0x1000-0x0fff] 
> to [bus 05] add_size 1000
> [35986.270301] pcieport 0000:00:01.7: bridge window [mem 
> 0x00100000-0x000fffff 64bit pref] to [bus 05] add_size 200000 add_align 
> 100000
> [35986.270316] pcieport 0000:00:01.3: BAR 15: assigned [mem 
> 0xd0d00000-0xd0efffff 64bit pref]
> [35986.270321] pcieport 0000:00:01.4: BAR 15: assigned [mem 
> 0xd0f00000-0xd10fffff 64bit pref]
> [35986.270325] pcieport 0000:00:01.6: BAR 15: assigned [mem 
> 0xd1100000-0xd12fffff 64bit pref]
> [35986.270329] pcieport 0000:00:01.7: BAR 15: assigned [mem 
> 0xd1300000-0xd14fffff 64bit pref]
> [35986.270335] pcieport 0000:00:01.3: BAR 13: assigned [io  0x5000-0x5fff]
> [35986.270337] pcieport 0000:00:01.7: BAR 13: assigned [io  0x6000-0x6fff]
> [35986.270721] pcieport 0000:00:08.1: scanning [bus 06-06] behind 
> bridge, pass 0
> [35986.270731] pci_bus 0000:06: scanning bus
> [35986.270736] pci_bus 0000:06: bus scan returning with max=06
> [35986.270742] pcieport 0000:00:08.1: scanning [bus 06-06] behind 
> bridge, pass 1
> [35986.270750] pci_bus 0000:06: Allocating resources
> [35986.273108] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 
> 2015
> [35986.276138] Bluetooth: hci0: Device revision is 2
> [35986.276149] Bluetooth: hci0: Secure boot is enabled
> [35986.276151] Bluetooth: hci0: OTP lock is enabled
> [35986.276152] Bluetooth: hci0: API lock is enabled
> [35986.276155] Bluetooth: hci0: Debug lock is disabled
> [35986.276156] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [35986.276165] Bluetooth: hci0: Found device firmware: 
> intel/ibt-18-16-1.sfi
> [35986.276266] Bluetooth: hci0: Boot Address: 0x40800
> [35986.276268] Bluetooth: hci0: Firmware Version: 214-6.22
> [35986.277942] usb 2-2.4: USB disconnect, device number 6
> [35986.291473] done.
> [35986.291581] random: crng reseeded on system resumption
> [35986.357516] usb 2-2.4: new full-speed USB device number 7 using xhci_hcd
> [35986.383283] PM: suspend exit
> [35986.478110] usb 2-2.4: New USB device found, idVendor=06cb, 
> idProduct=00bd, bcdDevice= 0.00
> [35986.478122] usb 2-2.4: New USB device strings: Mfr=0, Product=0, 
> SerialNumber=1
> [35986.478125] usb 2-2.4: SerialNumber: fb17f8614e26
> [35986.566993] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY 
> driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
> [35986.567004] r8169 0000:03:00.0: enabling bus mastering
> [35986.694778] r8169 0000:03:00.0 eth0: Link is Down
> [35986.733598] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY 
> driver (mii_bus:phy_addr=r8169-0-400:00, irq=MAC)
> [35986.733639] r8169 0000:04:00.0: enabling bus mastering
> [35986.925713] r8169 0000:04:00.0 eth1: Link is Down
> [35987.590009] Bluetooth: hci0: Waiting for firmware download to complete
> [35987.590071] Bluetooth: hci0: Firmware loaded in 1283103 usecs
> [35987.590114] Bluetooth: hci0: Waiting for device to boot
> [35987.607110] Bluetooth: hci0: Device booted in 16631 usecs
> [35987.607134] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> [35987.607146] Bluetooth: hci0: Found Intel DDC parameters: 
> intel/ibt-18-16-1.ddc
> [35987.615129] Bluetooth: hci0: Applying Intel DDC parameters completed
> [35987.619156] Bluetooth: hci0: Firmware revision 0.1 build 214 week 6 2022
> [35987.808498] Bluetooth: MGMT ver 1.22
> [35988.559398] r8169 0000:04:00.0 eth1: Link is Up - 100Mbps/Full - flow 
> control rx/tx
> [35988.559430] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> [36142.005371] vgaarb: client 0x0000000082859412 called 'target'
> [36142.005431] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [36142.005438] vgaarb: vgadev 0000000097683c42
> [36201.138526] vgaarb: client 0x0000000082859412 called 'target'
> [36201.138566] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [36201.138576] vgaarb: vgadev 0000000097683c42
> [36242.004155] vgaarb: client 0x0000000082859412 called 'target'
> [36242.004179] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [36242.004185] vgaarb: vgadev 0000000097683c42
> [37190.169972] vgaarb: client 0x0000000082859412 called 'target'
> [37190.170014] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [37190.170019] vgaarb: vgadev 0000000097683c42
> [37250.005277] vgaarb: client 0x0000000082859412 called 'target'
> [37250.005307] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [37250.005313] vgaarb: vgadev 0000000097683c42
> [37310.010855] vgaarb: client 0x0000000082859412 called 'target'
> [37310.010919] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [37310.010927] vgaarb: vgadev 0000000097683c42
> [37431.003995] vgaarb: client 0x0000000082859412 called 'target'
> [37431.004036] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [37431.004045] vgaarb: vgadev 0000000097683c42
> [37504.947106] vgaarb: client 0x0000000082859412 called 'target'
> [37504.947161] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [37504.947170] vgaarb: vgadev 0000000097683c42
> [37610.004377] vgaarb: client 0x0000000082859412 called 'target'
> [37610.004403] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [37610.004410] vgaarb: vgadev 0000000097683c42
> [37670.005139] vgaarb: client 0x0000000082859412 called 'target'
> [37670.005164] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [37670.005168] vgaarb: vgadev 0000000097683c42
> [37731.031582] vgaarb: client 0x0000000082859412 called 'target'
> [37731.031606] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [37731.031610] vgaarb: vgadev 0000000097683c42
> [38587.321259] r8169 0000:03:00.0: disabling bus mastering
> [38587.598015] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [38588.143227] r8169 0000:04:00.0 eth1: Link is Down
> [38588.143273] r8169 0000:04:00.0: disabling bus mastering
> [38589.116167] PM: suspend entry (deep)
> [38589.222715] Filesystems sync: 0.106 seconds
> [38589.313574] Freezing user space processes
> [38589.318013] Freezing user space processes completed (elapsed 0.004 
> seconds)
> [38589.318025] OOM killer disabled.
> [38589.318027] Freezing remaining freezable tasks
> [38589.319480] Freezing remaining freezable tasks completed (elapsed 
> 0.001 seconds)
> [38589.319511] printk: Suspending console(s) (use no_console_suspend to 
> debug)
> [38590.101893] iwlwifi 0000:01:00.0: saving config space at offset 0x0 
> (reading 0x25268086)
> [38590.101905] iwlwifi 0000:01:00.0: saving config space at offset 0x4 
> (reading 0x100406)
> [38590.101914] iwlwifi 0000:01:00.0: saving config space at offset 0x8 
> (reading 0x2800029)
> [38590.101922] iwlwifi 0000:01:00.0: saving config space at offset 0xc 
> (reading 0x0)
> [38590.101928] iwlwifi 0000:01:00.0: saving config space at offset 0x10 
> (reading 0xd0a00004)
> [38590.101936] iwlwifi 0000:01:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.101941] iwlwifi 0000:01:00.0: saving config space at offset 0x18 
> (reading 0x0)
> [38590.101945] iwlwifi 0000:01:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.101950] iwlwifi 0000:01:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [38590.101955] iwlwifi 0000:01:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [38590.101960] iwlwifi 0000:01:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.101965] iwlwifi 0000:01:00.0: saving config space at offset 0x2c 
> (reading 0x148086)
> [38590.101969] iwlwifi 0000:01:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.101972] iwlwifi 0000:01:00.0: saving config space at offset 0x34 
> (reading 0xc8)
> [38590.101976] iwlwifi 0000:01:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.101980] iwlwifi 0000:01:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [38590.102024] iwlwifi 0000:01:00.0: Requested to go to 3
> [38590.102222] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x0 (reading 0x15de1002)
> [38590.102227] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x4 (reading 0x100006)
> [38590.102228] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x0 (reading 0x15e31022)
> [38590.102231] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x8 (reading 0x4030000)
> [38590.102233] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x0 (reading 0x15e21022)
> [38590.102235] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x4 (reading 0x100006)
> [38590.102236] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0xc (reading 0x800008)
> [38590.102239] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x4 (reading 0x100006)
> [38590.102239] xhci_hcd 0000:06:00.4: saving config space at offset 0x0 
> (reading 0x15e11022)
> [38590.102240] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x8 (reading 0x4030000)
> [38590.102242] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x10 (reading 0xd05c8000)
> [38590.102243] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x8 (reading 0x4800000)
> [38590.102244] xhci_hcd 0000:06:00.4: saving config space at offset 0x4 
> (reading 0x100403)
> [38590.102245] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0xc (reading 0x800008)
> [38590.102246] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x14 (reading 0x0)
> [38590.102247] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0xc (reading 0x800008)
> [38590.102249] xhci_hcd 0000:06:00.3: saving config space at offset 0x0 
> (reading 0x15e01022)
> [38590.102252] ACPI: EC: interrupt blocked
> [38590.102250] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x10 (reading 0xd05c0000)
> [38590.102251] xhci_hcd 0000:06:00.4: saving config space at offset 0x8 
> (reading 0xc033000)
> [38590.102252] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x18 (reading 0x0)
> [38590.102252] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x10 (reading 0xd0580000)
> [38590.102254] xhci_hcd 0000:06:00.3: saving config space at offset 0x4 
> (reading 0x100403)
> [38590.102255] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x14 (reading 0x0)
> [38590.102256] xhci_hcd 0000:06:00.4: saving config space at offset 0xc 
> (reading 0x800008)
> [38590.102257] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x14 (reading 0x0)
> [38590.102258] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x1c (reading 0x0)
> [38590.102260] ccp 0000:06:00.2: saving config space at offset 0x0 
> (reading 0x15df1022)
> [38590.102261] xhci_hcd 0000:06:00.3: saving config space at offset 0x8 
> (reading 0xc033000)
> [38590.102261] xhci_hcd 0000:06:00.4: saving config space at offset 0x10 
> (reading 0xd0300004)
> [38590.102262] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x18 (reading 0x0)
> [38590.102264] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x18 (reading 0x0)
> [38590.102264] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x20 (reading 0x0)
> [38590.102266] ccp 0000:06:00.2: saving config space at offset 0x4 
> (reading 0x100406)
> [38590.102266] xhci_hcd 0000:06:00.4: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102268] xhci_hcd 0000:06:00.3: saving config space at offset 0xc 
> (reading 0x800008)
> [38590.102268] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x1c (reading 0x0)
> [38590.102270] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x1c (reading 0x0)
> [38590.102270] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x24 (reading 0x0)
> [38590.102272] ccp 0000:06:00.2: saving config space at offset 0x8 
> (reading 0x10800000)
> [38590.102273] xhci_hcd 0000:06:00.4: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102274] xhci_hcd 0000:06:00.3: saving config space at offset 0x10 
> (reading 0xd0200004)
> [38590.102275] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x20 (reading 0x0)
> [38590.102276] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x20 (reading 0x0)
> [38590.102277] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x28 (reading 0x0)
> [38590.102278] ccp 0000:06:00.2: saving config space at offset 0xc 
> (reading 0x800008)
> [38590.102279] xhci_hcd 0000:06:00.4: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102281] xhci_hcd 0000:06:00.3: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102281] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x24 (reading 0x0)
> [38590.102282] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x24 (reading 0x0)
> [38590.102283] ccp 0000:06:00.2: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102284] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x2c (reading 0x512517aa)
> [38590.102285] xhci_hcd 0000:06:00.4: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102287] xhci_hcd 0000:06:00.3: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102287] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x28 (reading 0x0)
> [38590.102288] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x28 (reading 0x0)
> [38590.102290] ccp 0000:06:00.2: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102290] xhci_hcd 0000:06:00.4: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102291] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x30 (reading 0x0)
> [38590.102293] xhci_hcd 0000:06:00.3: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102293] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x2c (reading 0x512517aa)
> [38590.102295] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x2c (reading 0x512517aa)
> [38590.102296] ccp 0000:06:00.2: saving config space at offset 0x18 
> (reading 0xd0400000)
> [38590.102296] xhci_hcd 0000:06:00.4: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102297] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x34 (reading 0x48)
> [38590.102299] xhci_hcd 0000:06:00.3: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102299] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x30 (reading 0x0)
> [38590.102300] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x30 (reading 0x0)
> [38590.102302] ccp 0000:06:00.2: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102303] xhci_hcd 0000:06:00.4: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102303] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x38 (reading 0x0)
> [38590.102305] xhci_hcd 0000:06:00.3: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102305] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x34 (reading 0x48)
> [38590.102307] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x34 (reading 0x48)
> [38590.102308] ccp 0000:06:00.2: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102309] xhci_hcd 0000:06:00.4: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102309] snd_hda_intel 0000:06:00.1: saving config space at offset 
> 0x3c (reading 0x2ff)
> [38590.102310] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x38 (reading 0x0)
> [38590.102312] xhci_hcd 0000:06:00.3: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102313] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x38 (reading 0x0)
> [38590.102314] ccp 0000:06:00.2: saving config space at offset 0x24 
> (reading 0xd05cc000)
> [38590.102315] xhci_hcd 0000:06:00.4: saving config space at offset 0x34 
> (reading 0x48)
> [38590.102315] snd_pci_acp3x 0000:06:00.5: saving config space at offset 
> 0x3c (reading 0x2ff)
> [38590.102318] xhci_hcd 0000:06:00.3: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102319] snd_hda_intel 0000:06:00.6: saving config space at offset 
> 0x3c (reading 0x3ff)
> [38590.102320] ccp 0000:06:00.2: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102321] xhci_hcd 0000:06:00.4: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102324] xhci_hcd 0000:06:00.3: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102326] ccp 0000:06:00.2: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102328] xhci_hcd 0000:06:00.4: saving config space at offset 0x3c 
> (reading 0x1ff)
> [38590.102332] xhci_hcd 0000:06:00.3: saving config space at offset 0x34 
> (reading 0x48)
> [38590.102334] ccp 0000:06:00.2: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102339] xhci_hcd 0000:06:00.3: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102341] ccp 0000:06:00.2: saving config space at offset 0x34 
> (reading 0x48)
> [38590.102346] xhci_hcd 0000:06:00.3: saving config space at offset 0x3c 
> (reading 0x4ff)
> [38590.102348] ccp 0000:06:00.2: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102355] ccp 0000:06:00.2: saving config space at offset 0x3c 
> (reading 0x3ff)
> [38590.102372] snd_hda_intel 0000:06:00.1: Requested to go to 3
> [38590.102380] snd_pci_acp3x 0000:06:00.5: Requested to go to 3
> [38590.102384] snd_hda_intel 0000:06:00.6: Requested to go to 3
> [38590.102402] rtsx_pci 0000:05:00.0: saving config space at offset 0x0 
> (reading 0x522a10ec)
> [38590.102404] xhci_hcd 0000:06:00.4: PME# enabled
> [38590.102409] rtsx_pci 0000:05:00.0: saving config space at offset 0x4 
> (reading 0x100406)
> [38590.102413] ccp 0000:06:00.2: Requested to go to 3
> [38590.102413] r8169 0000:04:00.0: saving config space at offset 0x0 
> (reading 0x816810ec)
> [38590.102414] rtsx_pci 0000:05:00.0: saving config space at offset 0x8 
> (reading 0xff000001)
> [38590.102418] r8169 0000:04:00.0: saving config space at offset 0x4 
> (reading 0x100403)
> [38590.102421] ehci-pci 0000:03:00.4: saving config space at offset 0x0 
> (reading 0x816d10ec)
> [38590.102421] rtsx_pci 0000:05:00.0: saving config space at offset 0xc 
> (reading 0x8)
> [38590.102423] r8169 0000:04:00.0: saving config space at offset 0x8 
> (reading 0x2000010)
> [38590.102425] ehci-pci 0000:03:00.4: saving config space at offset 0x4 
> (reading 0x100402)
> [38590.102426] rtsx_pci 0000:05:00.0: saving config space at offset 0x10 
> (reading 0xd0600000)
> [38590.102428] r8169 0000:04:00.0: saving config space at offset 0xc 
> (reading 0x8)
> [38590.102429] ehci-pci 0000:03:00.4: saving config space at offset 0x8 
> (reading 0xc03200e)
> [38590.102429] pci 0000:03:00.3: saving config space at offset 0x0 
> (reading 0x816c10ec)
> [38590.102432] r8169 0000:04:00.0: saving config space at offset 0x10 
> (reading 0x2001)
> [38590.102433] rtsx_pci 0000:05:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102435] ehci-pci 0000:03:00.4: saving config space at offset 0xc 
> (reading 0x800008)
> [38590.102436] pci 0000:03:00.3: saving config space at offset 0x4 
> (reading 0x100000)
> [38590.102439] r8169 0000:04:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102440] ehci-pci 0000:03:00.4: saving config space at offset 0x10 
> (reading 0xd0818000)
> [38590.102442] rtsx_pci 0000:05:00.0: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102443] serial 0000:03:00.2: saving config space at offset 0x0 
> (reading 0x816b10ec)
> [38590.102445] r8169 0000:04:00.0: saving config space at offset 0x18 
> (reading 0xd0704004)
> [38590.102448] xhci_hcd 0000:06:00.4: Requested to go to 3
> [38590.102450] ehci-pci 0000:03:00.4: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102446] pci 0000:03:00.3: saving config space at offset 0x8 
> (reading 0xc07010e)
> [38590.102451] rtsx_pci 0000:05:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102453] serial 0000:03:00.2: saving config space at offset 0x4 
> (reading 0x100003)
> [38590.102454] r8169 0000:04:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102457] ehci-pci 0000:03:00.4: saving config space at offset 0x18 
> (reading 0xd0810004)
> [38590.102458] serial 0000:03:00.1: saving config space at offset 0x0 
> (reading 0x816a10ec)
> [38590.102458] pci 0000:03:00.3: saving config space at offset 0xc 
> (reading 0x800008)
> [38590.102461] rtsx_pci 0000:05:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102463] serial 0000:03:00.2: saving config space at offset 0x8 
> (reading 0x700020e)
> [38590.102465] r8169 0000:04:00.0: saving config space at offset 0x20 
> (reading 0xd0700004)
> [38590.102467] ehci-pci 0000:03:00.4: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102468] serial 0000:03:00.1: saving config space at offset 0x4 
> (reading 0x100003)
> [38590.102468] pci 0000:03:00.3: saving config space at offset 0x10 
> (reading 0x3001)
> [38590.102471] rtsx_pci 0000:05:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102474] r8169 0000:04:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102474] serial 0000:03:00.2: saving config space at offset 0xc 
> (reading 0x800008)
> [38590.102476] ehci-pci 0000:03:00.4: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102477] serial 0000:03:00.1: saving config space at offset 0x8 
> (reading 0x700020e)
> [38590.102477] pci 0000:03:00.3: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102479] rtsx_pci 0000:05:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102481] r8169 0000:03:00.0: saving config space at offset 0x0 
> (reading 0x816810ec)
> [38590.102483] r8169 0000:04:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102484] serial 0000:03:00.2: saving config space at offset 0x10 
> (reading 0x3101)
> [38590.102486] ehci-pci 0000:03:00.4: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102488] serial 0000:03:00.1: saving config space at offset 0xc 
> (reading 0x800008)
> [38590.102489] pci 0000:03:00.3: saving config space at offset 0x18 
> (reading 0xd0817004)
> [38590.102491] rtsx_pci 0000:05:00.0: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102492] r8169 0000:03:00.0: saving config space at offset 0x4 
> (reading 0x100403)
> [38590.102494] r8169 0000:04:00.0: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102496] serial 0000:03:00.2: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102497] xhci_hcd 0000:06:00.3: PME# enabled
> [38590.102498] ehci-pci 0000:03:00.4: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102500] serial 0000:03:00.1: saving config space at offset 0x10 
> (reading 0x3201)
> [38590.102500] pci 0000:03:00.3: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102502] rtsx_pci 0000:05:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102504] r8169 0000:03:00.0: saving config space at offset 0x8 
> (reading 0x200000e)
> [38590.102506] r8169 0000:04:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102507] serial 0000:03:00.2: saving config space at offset 0x18 
> (reading 0xd0816004)
> [38590.102507] xhci_hcd 0000:06:00.3: Requested to go to 3
> [38590.102509] ehci-pci 0000:03:00.4: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102510] serial 0000:03:00.1: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102510] pci 0000:03:00.3: saving config space at offset 0x20 
> (reading 0xd080c004)
> [38590.102512] rtsx_pci 0000:05:00.0: saving config space at offset 0x34 
> (reading 0x40)
> [38590.102514] r8169 0000:03:00.0: saving config space at offset 0xc 
> (reading 0x800008)
> [38590.102516] r8169 0000:04:00.0: saving config space at offset 0x34 
> (reading 0x40)
> [38590.102517] serial 0000:03:00.2: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102520] ehci-pci 0000:03:00.4: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102522] serial 0000:03:00.1: saving config space at offset 0x18 
> (reading 0xd0815004)
> [38590.102522] pci 0000:03:00.3: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102524] rtsx_pci 0000:05:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102525] r8169 0000:03:00.0: saving config space at offset 0x10 
> (reading 0x3401)
> [38590.102527] r8169 0000:04:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102530] serial 0000:03:00.2: saving config space at offset 0x20 
> (reading 0xd0808004)
> [38590.102531] ehci-pci 0000:03:00.4: saving config space at offset 0x34 
> (reading 0x40)
> [38590.102533] serial 0000:03:00.1: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102533] pci 0000:03:00.3: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102535] rtsx_pci 0000:05:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [38590.102537] r8169 0000:03:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102539] r8169 0000:04:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [38590.102540] serial 0000:03:00.2: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102542] ehci-pci 0000:03:00.4: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102543] serial 0000:03:00.1: saving config space at offset 0x20 
> (reading 0xd0804004)
> [38590.102543] pci 0000:03:00.3: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102546] r8169 0000:03:00.0: saving config space at offset 0x18 
> (reading 0xd0814004)
> [38590.102550] serial 0000:03:00.2: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102552] ehci-pci 0000:03:00.4: saving config space at offset 0x3c 
> (reading 0x4ff)
> [38590.102553] serial 0000:03:00.1: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102554] pci 0000:03:00.3: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102557] r8169 0000:03:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102561] serial 0000:03:00.2: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102564] serial 0000:03:00.1: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102565] pci 0000:03:00.3: saving config space at offset 0x34 
> (reading 0x40)
> [38590.102568] r8169 0000:03:00.0: saving config space at offset 0x20 
> (reading 0xd0800004)
> [38590.102572] serial 0000:03:00.2: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102576] serial 0000:03:00.1: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102576] pci 0000:03:00.3: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102579] r8169 0000:03:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102583] serial 0000:03:00.2: saving config space at offset 0x34 
> (reading 0x40)
> [38590.102586] serial 0000:03:00.1: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102587] pci 0000:03:00.3: saving config space at offset 0x3c 
> (reading 0x4ff)
> [38590.102591] r8169 0000:03:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102593] serial 0000:03:00.2: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102598] serial 0000:03:00.1: saving config space at offset 0x34 
> (reading 0x40)
> [38590.102602] r8169 0000:03:00.0: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102603] serial 0000:03:00.2: saving config space at offset 0x3c 
> (reading 0x3ff)
> [38590.102609] serial 0000:03:00.1: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102612] r8169 0000:03:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102621] serial 0000:03:00.1: saving config space at offset 0x3c 
> (reading 0x2ff)
> [38590.102623] r8169 0000:03:00.0: saving config space at offset 0x34 
> (reading 0x40)
> [38590.102636] r8169 0000:03:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102648] r8169 0000:03:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [38590.102676] rtsx_pci 0000:05:00.0: Requested to go to 3
> [38590.102748] nvme 0000:02:00.0: saving config space at offset 0x0 
> (reading 0x16391c5c)
> [38590.102753] r8169 0000:04:00.0: Requested to go to 3
> [38590.102765] pci 0000:00:18.7: saving config space at offset 0x0 
> (reading 0x15ef1022)
> [38590.102763] nvme 0000:02:00.0: saving config space at offset 0x4 
> (reading 0x100003)
> [38590.102775] ehci-pci 0000:03:00.4: PME# enabled
> [38590.102779] pci 0000:00:18.7: saving config space at offset 0x4 
> (reading 0x0)
> [38590.102777] nvme 0000:02:00.0: saving config space at offset 0x8 
> (reading 0x1080200)
> [38590.102797] pci 0000:00:18.7: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.102795] ehci-pci 0000:03:00.4: Requested to go to 0
> [38590.102796] nvme 0000:02:00.0: saving config space at offset 0xc 
> (reading 0x8)
> [38590.102797] ehci-pci 0000:03:00.4: PCI PM: Suspend power state: D0
> [38590.102804] pci 0000:00:18.7: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.102808] nvme 0000:02:00.0: saving config space at offset 0x10 
> (reading 0xd0900004)
> [38590.102816] pci 0000:00:18.7: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102814] pci 0000:00:18.6: saving config space at offset 0x0 
> (reading 0x15ee1022)
> [38590.102816] nvme 0000:02:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102818] pci 0000:00:18.5: saving config space at offset 0x0 
> (reading 0x15ed1022)
> [38590.102818] pci 0000:00:18.6: saving config space at offset 0x4 
> (reading 0x0)
> [38590.102821] pci 0000:00:18.7: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102820] pci 0000:00:18.6: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.102821] pci 0000:00:18.5: saving config space at offset 0x4 
> (reading 0x0)
> [38590.102823] nvme 0000:02:00.0: saving config space at offset 0x18 
> (reading 0xd0905000)
> [38590.102823] pci 0000:00:18.4: saving config space at offset 0x0 
> (reading 0x15ec1022)
> [38590.102826] pci 0000:00:18.5: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.102825] pci 0000:00:18.6: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.102828] pci 0000:00:18.7: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102831] pci 0000:00:18.5: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.102830] nvme 0000:02:00.0: saving config space at offset 0x1c 
> (reading 0xd0904000)
> [38590.102832] pci 0000:00:18.6: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102830] pci 0000:00:18.4: saving config space at offset 0x4 
> (reading 0x0)
> [38590.102836] pci 0000:00:18.7: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102833] pci 0000:00:18.5: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102838] pci 0000:00:18.6: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102837] nvme 0000:02:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102839] pci 0000:00:18.5: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102837] pci 0000:00:18.4: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.102840] serial 0000:03:00.2: Requested to go to 3
> [38590.102843] pci 0000:00:18.7: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102840] pci 0000:00:18.6: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102844] pci 0000:00:18.5: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102843] nvme 0000:02:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102847] pci 0000:00:18.6: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102845] pci 0000:00:18.4: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.102851] pci 0000:00:18.7: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102848] pci 0000:00:18.5: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102850] nvme 0000:02:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102853] pci 0000:00:18.6: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102854] pci 0000:00:18.5: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102858] pci 0000:00:18.7: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102853] pci 0000:00:18.4: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102862] pci 0000:00:18.6: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102861] nvme 0000:02:00.0: saving config space at offset 0x2c 
> (reading 0x16391c5c)
> [38590.102862] pci 0000:00:18.5: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102866] pci 0000:00:18.7: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.102862] pci 0000:00:18.4: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102864] pci 0000:00:18.6: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102864] pci 0000:00:18.5: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102865] serial 0000:03:00.1: Requested to go to 3
> [38590.102866] nvme 0000:02:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102867] pci 0000:00:18.6: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.102868] pci 0000:00:18.5: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.102870] pci 0000:00:18.7: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102867] pci 0000:00:18.4: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102870] pci 0000:00:18.6: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102871] nvme 0000:02:00.0: saving config space at offset 0x34 
> (reading 0x80)
> [38590.102874] pci 0000:00:18.5: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102878] pci 0000:00:18.7: saving config space at offset 0x34 
> (reading 0x0)
> [38590.102874] pci 0000:00:18.6: saving config space at offset 0x34 
> (reading 0x0)
> [38590.102874] pci 0000:00:18.4: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102876] k10temp 0000:00:18.3: saving config space at offset 0x0 
> (reading 0x15eb1022)
> [38590.102878] pci 0000:00:18.5: saving config space at offset 0x34 
> (reading 0x0)
> [38590.102878] pci 0000:00:18.6: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102877] nvme 0000:02:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102882] pci 0000:00:18.7: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102879] k10temp 0000:00:18.3: saving config space at offset 0x4 
> (reading 0x0)
> [38590.102880] pci 0000:00:18.5: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102879] pci 0000:00:18.4: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102880] pci 0000:00:18.6: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.102882] nvme 0000:02:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [38590.102884] k10temp 0000:00:18.3: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.102884] pci 0000:00:18.5: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.102887] pci 0000:00:18.7: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.102885] r8169 0000:03:00.0: Requested to go to 3
> [38590.102884] pci 0000:00:18.4: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102886] k10temp 0000:00:18.3: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.102892] k10temp 0000:00:18.3: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102890] pci 0000:00:18.4: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102892] pci 0000:00:18.1: saving config space at offset 0x0 
> (reading 0x15e91022)
> [38590.102893] pci 0000:00:18.2: saving config space at offset 0x0 
> (reading 0x15ea1022)
> [38590.102895] pci 0000:00:18.0: saving config space at offset 0x0 
> (reading 0x15e81022)
> [38590.102898] k10temp 0000:00:18.3: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102898] pci 0000:00:18.1: saving config space at offset 0x4 
> (reading 0x0)
> [38590.102901] pci 0000:00:14.3: saving config space at offset 0x0 
> (reading 0x790e1022)
> [38590.102897] pci 0000:00:18.4: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.102901] pci 0000:00:18.0: saving config space at offset 0x4 
> (reading 0x0)
> [38590.102900] pci 0000:00:18.2: saving config space at offset 0x4 
> (reading 0x0)
> [38590.102901] k10temp 0000:00:18.3: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102902] pci 0000:00:18.1: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.102907] pci 0000:00:14.3: saving config space at offset 0x4 
> (reading 0x220000f)
> [38590.102905] pci 0000:00:18.0: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.102903] pci 0000:00:18.4: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102907] k10temp 0000:00:18.3: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102907] pci 0000:00:18.2: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.102907] pci 0000:00:18.1: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.102909] pci 0000:00:18.0: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.102914] pci 0000:00:14.3: saving config space at offset 0x8 
> (reading 0x6010051)
> [38590.102909] pci 0000:00:18.4: saving config space at offset 0x34 
> (reading 0x0)
> [38590.102913] pci 0000:00:18.1: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102912] k10temp 0000:00:18.3: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102914] pci 0000:00:18.0: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102913] pci 0000:00:18.2: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.102920] pci 0000:00:14.3: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.102915] pci 0000:00:18.4: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102917] pci 0000:00:18.1: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102918] k10temp 0000:00:18.3: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102919] pci 0000:00:18.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102920] pci 0000:00:18.1: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102919] pci 0000:00:18.2: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102919] pci 0000:00:18.4: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.102922] k10temp 0000:00:18.3: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102923] pci 0000:00:18.0: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102923] pci 0000:00:18.1: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102926] pci 0000:00:14.3: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102924] pci 0000:00:18.2: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102925] k10temp 0000:00:18.3: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.102925] pci 0000:00:18.0: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102926] pci 0000:00:18.1: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102931] pci 0000:00:14.3: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102929] k10temp 0000:00:18.3: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102929] pci 0000:00:18.0: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102929] pci 0000:00:18.1: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102928] pci 0000:00:18.2: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102931] k10temp 0000:00:18.3: saving config space at offset 0x34 
> (reading 0x0)
> [38590.102932] pci 0000:00:18.1: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102934] pci 0000:00:18.0: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102937] pci 0000:00:14.3: saving config space at offset 0x18 
> (reading 0x0)
> [38590.102935] pci 0000:00:18.1: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.102935] k10temp 0000:00:18.3: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102936] pci 0000:00:18.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102935] pci 0000:00:18.2: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102939] pci 0000:00:18.1: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102942] pci 0000:00:14.3: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.102940] pci 0000:00:18.0: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.102939] k10temp 0000:00:18.3: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.102942] pci 0000:00:18.1: saving config space at offset 0x34 
> (reading 0x0)
> [38590.102942] pci 0000:00:18.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102940] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x0 (reading 0x790b1022)
> [38590.102942] pci 0000:00:18.2: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102944] pci 0000:00:18.1: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102947] pci 0000:00:14.3: saving config space at offset 0x20 
> (reading 0x0)
> [38590.102945] pci 0000:00:18.0: saving config space at offset 0x34 
> (reading 0x0)
> [38590.102949] pci 0000:00:18.1: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.102949] pci 0000:00:18.2: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102950] pci 0000:00:18.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102948] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x4 (reading 0x2200400)
> [38590.102955] pci 0000:00:14.3: saving config space at offset 0x24 
> (reading 0x0)
> [38590.102952] pci 0000:00:18.0: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.102953] pci 0000:00:18.2: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102955] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x8 (reading 0xc050061)
> [38590.102962] pci 0000:00:14.3: saving config space at offset 0x28 
> (reading 0x0)
> [38590.102959] pci 0000:00:18.2: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.102959] nvme 0000:02:00.0: Requested to go to 3
> [38590.102960] pci 0000:00:08.0: saving config space at offset 0x0 
> (reading 0x14521022)
> [38590.102960] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0xc (reading 0x800000)
> [38590.102967] pci 0000:00:14.3: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.102964] pci 0000:00:18.2: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102965] pci 0000:00:08.0: saving config space at offset 0x4 
> (reading 0x0)
> [38590.102967] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x10 (reading 0x0)
> [38590.102985] pci 0000:00:14.3: saving config space at offset 0x30 
> (reading 0x0)
> [38590.102982] pci 0000:00:18.2: saving config space at offset 0x34 
> (reading 0x0)
> [38590.102983] pci 0000:00:08.0: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.102983] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x14 (reading 0x0)
> [38590.102985] pci 0000:00:08.0: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.102991] pci 0000:00:14.3: saving config space at offset 0x34 
> (reading 0x0)
> [38590.102988] pci 0000:00:18.2: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102989] pci 0000:00:08.0: saving config space at offset 0x10 
> (reading 0x0)
> [38590.102990] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x18 (reading 0x0)
> [38590.102998] pci 0000:00:14.3: saving config space at offset 0x38 
> (reading 0x0)
> [38590.102996] pci 0000:00:08.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.102996] pci 0000:00:18.2: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.102997] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x1c (reading 0x0)
> [38590.102999] pci 0000:00:08.0: saving config space at offset 0x18 
> (reading 0x0)
> [38590.103004] pci 0000:00:14.3: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.103002] pci 0000:00:08.0: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.103002] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x20 (reading 0x0)
> [38590.103005] pci 0000:00:08.0: saving config space at offset 0x20 
> (reading 0x0)
> [38590.103007] pci 0000:00:08.0: saving config space at offset 0x24 
> (reading 0x0)
> [38590.103012] pci 0000:00:08.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.103010] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x24 (reading 0x0)
> [38590.103014] pci 0000:00:08.0: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.103019] pci 0000:00:08.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.103021] pci 0000:00:08.0: saving config space at offset 0x34 
> (reading 0x0)
> [38590.103017] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x28 (reading 0x0)
> [38590.103023] pci 0000:00:08.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.103025] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x2c (reading 0x512517aa)
> [38590.103027] pci 0000:00:08.0: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.103029] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x30 (reading 0x0)
> [38590.103033] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x34 (reading 0x0)
> [38590.103037] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x38 (reading 0x0)
> [38590.103042] piix4_smbus 0000:00:14.0: saving config space at offset 
> 0x3c (reading 0x0)
> [38590.103055] pci 0000:00:01.0: saving config space at offset 0x0 
> (reading 0x14521022)
> [38590.103054] pci 0000:00:00.2: saving config space at offset 0x0 
> (reading 0x15d11022)
> [38590.103057] pci 0000:00:01.0: saving config space at offset 0x4 
> (reading 0x0)
> [38590.103060] pci 0000:00:01.0: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.103058] pci 0000:00:00.2: saving config space at offset 0x4 
> (reading 0x100400)
> [38590.103063] pci 0000:00:01.0: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.103063] pci 0000:00:00.2: saving config space at offset 0x8 
> (reading 0x8060000)
> [38590.103066] pci 0000:00:01.0: saving config space at offset 0x10 
> (reading 0x0)
> [38590.103066] pci 0000:00:00.2: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.103069] pci 0000:00:01.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.103069] pci 0000:00:00.2: saving config space at offset 0x10 
> (reading 0x0)
> [38590.103072] pci 0000:00:01.0: saving config space at offset 0x18 
> (reading 0x0)
> [38590.103072] pci 0000:00:00.2: saving config space at offset 0x14 
> (reading 0x0)
> [38590.103075] pci 0000:00:01.0: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.103075] pci 0000:00:00.2: saving config space at offset 0x18 
> (reading 0x0)
> [38590.103078] pci 0000:00:01.0: saving config space at offset 0x20 
> (reading 0x0)
> [38590.103078] pci 0000:00:00.2: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.103081] pci 0000:00:01.0: saving config space at offset 0x24 
> (reading 0x0)
> [38590.103081] pci 0000:00:00.2: saving config space at offset 0x20 
> (reading 0x0)
> [38590.103084] pci 0000:00:01.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.103084] pci 0000:00:00.2: saving config space at offset 0x24 
> (reading 0x0)
> [38590.103086] pci 0000:00:01.0: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.103087] pci 0000:00:00.2: saving config space at offset 0x28 
> (reading 0x0)
> [38590.103089] pci 0000:00:01.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.103090] pci 0000:00:00.2: saving config space at offset 0x2c 
> (reading 0x15d11022)
> [38590.103092] pci 0000:00:01.0: saving config space at offset 0x34 
> (reading 0x0)
> [38590.103093] pci 0000:00:00.2: saving config space at offset 0x30 
> (reading 0x0)
> [38590.103095] pci 0000:00:01.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.103095] pci 0000:00:00.2: saving config space at offset 0x34 
> (reading 0x40)
> [38590.103098] pci 0000:00:01.0: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.103098] pci 0000:00:00.2: saving config space at offset 0x38 
> (reading 0x0)
> [38590.103102] pci 0000:00:00.2: saving config space at offset 0x3c 
> (reading 0x1ff)
> [38590.103105] pci 0000:00:00.0: saving config space at offset 0x0 
> (reading 0x15d01022)
> [38590.103108] pci 0000:00:00.0: saving config space at offset 0x4 
> (reading 0x0)
> [38590.103112] pci 0000:00:00.0: saving config space at offset 0x8 
> (reading 0x6000000)
> [38590.103115] pci 0000:00:00.0: saving config space at offset 0xc 
> (reading 0x800000)
> [38590.103118] pci 0000:00:00.0: saving config space at offset 0x10 
> (reading 0x0)
> [38590.103121] pci 0000:00:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.103123] pci 0000:00:00.0: saving config space at offset 0x18 
> (reading 0x0)
> [38590.103126] pci 0000:00:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.103129] pci 0000:00:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [38590.103132] pci 0000:00:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [38590.103135] pci 0000:00:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.103138] pci 0000:00:00.0: saving config space at offset 0x2c 
> (reading 0x15d01022)
> [38590.103140] pci 0000:00:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.103143] pci 0000:00:00.0: saving config space at offset 0x34 
> (reading 0x0)
> [38590.103146] pci 0000:00:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.103149] pci 0000:00:00.0: saving config space at offset 0x3c 
> (reading 0x0)
> [38590.113482] snd_pci_acp3x 0000:06:00.5: Gone into state 3
> [38590.113483] ccp 0000:06:00.2: Gone into state 3
> [38590.113485] snd_pci_acp3x 0000:06:00.5: PCI PM: Suspend power state: 
> D3hot
> [38590.113487] ccp 0000:06:00.2: PCI PM: Suspend power state: D3hot
> [38590.113545] r8169 0000:04:00.0: Gone into state 3
> [38590.113550] serial 0000:03:00.2: Gone into state 3
> [38590.113552] r8169 0000:04:00.0: PCI PM: Suspend power state: D3hot
> [38590.113551] serial 0000:03:00.2: PCI PM: Suspend power state: D3hot
> [38590.113563] pcieport 0000:00:01.6: saving config space at offset 0x0 
> (reading 0x15d31022)
> [38590.113565] pcieport 0000:00:01.6: saving config space at offset 0x4 
> (reading 0x100407)
> [38590.113567] pcieport 0000:00:01.6: saving config space at offset 0x8 
> (reading 0x6040000)
> [38590.113569] pcieport 0000:00:01.6: saving config space at offset 0xc 
> (reading 0x810008)
> [38590.113571] pcieport 0000:00:01.6: saving config space at offset 0x10 
> (reading 0x0)
> [38590.113573] pcieport 0000:00:01.6: saving config space at offset 0x14 
> (reading 0x0)
> [38590.113575] pcieport 0000:00:01.6: saving config space at offset 0x18 
> (reading 0x40400)
> [38590.113577] pcieport 0000:00:01.6: saving config space at offset 0x1c 
> (reading 0x2121)
> [38590.113579] pcieport 0000:00:01.6: saving config space at offset 0x20 
> (reading 0xd070d070)
> [38590.113581] pcieport 0000:00:01.6: saving config space at offset 0x24 
> (reading 0x1fff1)
> [38590.113583] pcieport 0000:00:01.6: saving config space at offset 0x28 
> (reading 0x0)
> [38590.113585] pcieport 0000:00:01.6: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.113587] pcieport 0000:00:01.6: saving config space at offset 0x30 
> (reading 0x0)
> [38590.113588] pcieport 0000:00:01.6: saving config space at offset 0x34 
> (reading 0x50)
> [38590.113590] pcieport 0000:00:01.6: saving config space at offset 0x38 
> (reading 0x0)
> [38590.113592] pcieport 0000:00:01.6: saving config space at offset 0x3c 
> (reading 0x200ff)
> [38590.113622] pcieport 0000:00:01.6: PME# enabled
> [38590.113628] pcieport 0000:00:01.6: Requested to go to 3
> [38590.113788] iwlwifi 0000:01:00.0: Gone into state 3
> [38590.113791] iwlwifi 0000:01:00.0: PCI PM: Suspend power state: D3hot
> [38590.113795] serial 0000:03:00.1: Gone into state 3
> [38590.113797] serial 0000:03:00.1: PCI PM: Suspend power state: D3hot
> [38590.113797] r8169 0000:03:00.0: Gone into state 3
> [38590.113803] pcieport 0000:00:01.2: saving config space at offset 0x0 
> (reading 0x15d31022)
> [38590.113805] pcieport 0000:00:01.2: saving config space at offset 0x4 
> (reading 0x100407)
> [38590.113804] r8169 0000:03:00.0: PCI PM: Suspend power state: D3hot
> [38590.113807] pcieport 0000:00:01.2: saving config space at offset 0x8 
> (reading 0x6040000)
> [38590.113810] pcieport 0000:00:01.2: saving config space at offset 0xc 
> (reading 0x810008)
> [38590.113811] pcieport 0000:00:01.2: saving config space at offset 0x10 
> (reading 0x0)
> [38590.113814] pcieport 0000:00:01.2: saving config space at offset 0x14 
> (reading 0x0)
> [38590.113815] pcieport 0000:00:01.2: saving config space at offset 0x18 
> (reading 0x10100)
> [38590.113817] pcieport 0000:00:01.2: saving config space at offset 0x1c 
> (reading 0x4141)
> [38590.113819] pcieport 0000:00:01.2: saving config space at offset 0x20 
> (reading 0xd0a0d0a0)
> [38590.113821] pcieport 0000:00:01.2: saving config space at offset 0x24 
> (reading 0xd0c1d0b1)
> [38590.113823] pcieport 0000:00:01.2: saving config space at offset 0x28 
> (reading 0x0)
> [38590.113825] pcieport 0000:00:01.2: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.113827] pcieport 0000:00:01.2: saving config space at offset 0x30 
> (reading 0x0)
> [38590.113829] pcieport 0000:00:01.2: saving config space at offset 0x34 
> (reading 0x50)
> [38590.113831] pcieport 0000:00:01.2: saving config space at offset 0x38 
> (reading 0x0)
> [38590.113829] pcieport 0000:00:01.4: saving config space at offset 0x0 
> (reading 0x15d31022)
> [38590.113833] pcieport 0000:00:01.2: saving config space at offset 0x3c 
> (reading 0x200ff)
> [38590.113839] pcieport 0000:00:01.4: saving config space at offset 0x4 
> (reading 0x100407)
> [38590.113845] pcieport 0000:00:01.4: saving config space at offset 0x8 
> (reading 0x6040000)
> [38590.113850] pcieport 0000:00:01.4: saving config space at offset 0xc 
> (reading 0x810008)
> [38590.113855] pcieport 0000:00:01.4: saving config space at offset 0x10 
> (reading 0x0)
> [38590.113859] pcieport 0000:00:01.4: saving config space at offset 0x14 
> (reading 0x0)
> [38590.113863] pcieport 0000:00:01.2: PCI PM: Suspend power state: D0
> [38590.113864] pcieport 0000:00:01.4: saving config space at offset 0x18 
> (reading 0x30300)
> [38590.113872] pcieport 0000:00:01.4: saving config space at offset 0x1c 
> (reading 0x20003131)
> [38590.113878] pcieport 0000:00:01.4: saving config space at offset 0x20 
> (reading 0xd080d080)
> [38590.113883] pcieport 0000:00:01.4: saving config space at offset 0x24 
> (reading 0x1fff1)
> [38590.113888] pcieport 0000:00:01.4: saving config space at offset 0x28 
> (reading 0x0)
> [38590.113892] pcieport 0000:00:01.4: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.113896] pcieport 0000:00:01.4: saving config space at offset 0x30 
> (reading 0x0)
> [38590.113900] pcieport 0000:00:01.4: saving config space at offset 0x34 
> (reading 0x50)
> [38590.113904] pcieport 0000:00:01.4: saving config space at offset 0x38 
> (reading 0x0)
> [38590.113908] pcieport 0000:00:01.4: saving config space at offset 0x3c 
> (reading 0x200ff)
> [38590.113945] pcieport 0000:00:01.4: PCI PM: Suspend power state: D0
> [38590.114423] snd_hda_intel 0000:06:00.6: Gone into state 3
> [38590.114429] snd_hda_intel 0000:06:00.1: Gone into state 3
> [38590.114433] snd_hda_intel 0000:06:00.6: PCI PM: Suspend power state: 
> D3hot
> [38590.114433] snd_hda_intel 0000:06:00.1: PCI PM: Suspend power state: 
> D3hot
> [38590.114687] rtsx_pci 0000:05:00.0: Gone into state 3
> [38590.114690] rtsx_pci 0000:05:00.0: PCI PM: Suspend power state: D3hot
> [38590.115010] nvme 0000:02:00.0: Gone into state 3
> [38590.115012] nvme 0000:02:00.0: PCI PM: Suspend power state: D3hot
> [38590.114832] amdgpu 0000:06:00.0: saving config space at offset 0x0 
> (reading 0x15d81002)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x0 
> (reading 0x15d31022)
> [38590.114770] pcieport 0000:00:01.7: saving config space at offset 0x0 
> (reading 0x15d31022)
> [38590.114838] amdgpu 0000:06:00.0: saving config space at offset 0x4 
> (reading 0x100407)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x4 
> (reading 0x100407)
> [38590.114776] pcieport 0000:00:01.7: saving config space at offset 0x4 
> (reading 0x100407)
> [38590.114842] amdgpu 0000:06:00.0: saving config space at offset 0x8 
> (reading 0x30000d1)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x8 
> (reading 0x6040000)
> [38590.114780] pcieport 0000:00:01.7: saving config space at offset 0x8 
> (reading 0x6040000)
> [38590.114846] amdgpu 0000:06:00.0: saving config space at offset 0xc 
> (reading 0x800008)
> [38590.114783] pcieport 0000:00:01.7: saving config space at offset 0xc 
> (reading 0x810008)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0xc 
> (reading 0x810008)
> [38590.114851] amdgpu 0000:06:00.0: saving config space at offset 0x10 
> (reading 0xc000000c)
> [38590.114787] pcieport 0000:00:01.7: saving config space at offset 0x10 
> (reading 0x0)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x10 
> (reading 0x0)
> [38590.114790] pcieport 0000:00:01.7: saving config space at offset 0x14 
> (reading 0x0)
> [38590.114856] amdgpu 0000:06:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x14 
> (reading 0x0)
> [38590.114794] pcieport 0000:00:01.7: saving config space at offset 0x18 
> (reading 0x50500)
> [38590.114860] amdgpu 0000:06:00.0: saving config space at offset 0x18 
> (reading 0xd000000c)
> [38590.114797] pcieport 0000:00:01.7: saving config space at offset 0x1c 
> (reading 0x1f1)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x18 
> (reading 0x20200)
> [38590.114864] amdgpu 0000:06:00.0: saving config space at offset 0x1c 
> (reading 0x0)
> [38590.114801] pcieport 0000:00:01.7: saving config space at offset 0x20 
> (reading 0xd060d060)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x1c 
> (reading 0x1f1)
> [38590.114869] amdgpu 0000:06:00.0: saving config space at offset 0x20 
> (reading 0x1001)
> [38590.114805] pcieport 0000:00:01.7: saving config space at offset 0x24 
> (reading 0x1fff1)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x20 
> (reading 0xd090d090)
> [38590.114808] pcieport 0000:00:01.7: saving config space at offset 0x28 
> (reading 0x0)
> [38590.114874] amdgpu 0000:06:00.0: saving config space at offset 0x24 
> (reading 0xd0500000)
> [38590.114810] pcieport 0000:00:01.7: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x24 
> (reading 0x1fff1)
> [38590.114813] pcieport 0000:00:01.7: saving config space at offset 0x30 
> (reading 0x0)
> [38590.114879] amdgpu 0000:06:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.114815] pcieport 0000:00:01.7: saving config space at offset 0x34 
> (reading 0x50)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x28 
> (reading 0x0)
> [38590.114818] pcieport 0000:00:01.7: saving config space at offset 0x38 
> (reading 0x0)
> [38590.114884] amdgpu 0000:06:00.0: saving config space at offset 0x2c 
> (reading 0x512517aa)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.114821] pcieport 0000:00:01.7: saving config space at offset 0x3c 
> (reading 0x200ff)
> [38590.114888] amdgpu 0000:06:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x30 
> (reading 0x0)
> [38590.114893] amdgpu 0000:06:00.0: saving config space at offset 0x34 
> (reading 0x48)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x34 
> (reading 0x50)
> [38590.114897] amdgpu 0000:06:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x38 
> (reading 0x0)
> [38590.114901] amdgpu 0000:06:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [38590.115015] pcieport 0000:00:01.3: saving config space at offset 0x3c 
> (reading 0x200ff)
> [38590.114892] pcieport 0000:00:01.7: PME# enabled
> [38590.114900] pcieport 0000:00:01.7: Requested to go to 3
> [38590.114979] amdgpu 0000:06:00.0: Requested to go to 3
> [38590.115015] pcieport 0000:00:01.3: PME# enabled
> [38590.115015] pcieport 0000:00:01.3: Requested to go to 3
> [38590.126166] xhci_hcd 0000:06:00.3: Gone into state 3
> [38590.126164] pcieport 0000:00:01.6: Gone into state 3
> [38590.126166] xhci_hcd 0000:06:00.4: Gone into state 3
> [38590.126191] pcieport 0000:00:01.3: Gone into state 3
> [38590.126194] xhci_hcd 0000:06:00.4: PCI PM: Suspend power state: D3hot
> [38590.126199] amdgpu 0000:06:00.0: Gone into state 3
> [38590.126225] pcieport 0000:00:01.6: PCI PM: Suspend power state: D3hot
> [38590.126243] pcieport 0000:00:01.3: PCI PM: Suspend power state: D3hot
> [38590.126274] amdgpu 0000:06:00.0: PCI PM: Suspend power state: D3hot
> [38590.126974] pcieport 0000:00:01.7: Gone into state 3
> [38590.126987] pcieport 0000:00:01.7: PCI PM: Suspend power state: D3hot
> [38590.153924] xhci_hcd 0000:06:00.3: power state changed by ACPI to D3hot
> [38590.153948] xhci_hcd 0000:06:00.3: PCI PM: Suspend power state: D3hot
> [38590.154021] pcieport 0000:00:08.1: saving config space at offset 0x0 
> (reading 0x15db1022)
> [38590.154031] pcieport 0000:00:08.1: saving config space at offset 0x4 
> (reading 0x100407)
> [38590.154037] pcieport 0000:00:08.1: saving config space at offset 0x8 
> (reading 0x6040000)
> [38590.154042] pcieport 0000:00:08.1: saving config space at offset 0xc 
> (reading 0x810008)
> [38590.154046] pcieport 0000:00:08.1: saving config space at offset 0x10 
> (reading 0x0)
> [38590.154051] pcieport 0000:00:08.1: saving config space at offset 0x14 
> (reading 0x0)
> [38590.154055] pcieport 0000:00:08.1: saving config space at offset 0x18 
> (reading 0x60600)
> [38590.154059] pcieport 0000:00:08.1: saving config space at offset 0x1c 
> (reading 0x1111)
> [38590.154063] pcieport 0000:00:08.1: saving config space at offset 0x20 
> (reading 0xd050d020)
> [38590.154067] pcieport 0000:00:08.1: saving config space at offset 0x24 
> (reading 0xd011c001)
> [38590.154071] pcieport 0000:00:08.1: saving config space at offset 0x28 
> (reading 0x0)
> [38590.154075] pcieport 0000:00:08.1: saving config space at offset 0x2c 
> (reading 0x0)
> [38590.154078] pcieport 0000:00:08.1: saving config space at offset 0x30 
> (reading 0x0)
> [38590.154082] pcieport 0000:00:08.1: saving config space at offset 0x34 
> (reading 0x50)
> [38590.154086] pcieport 0000:00:08.1: saving config space at offset 0x38 
> (reading 0x0)
> [38590.154090] pcieport 0000:00:08.1: saving config space at offset 0x3c 
> (reading 0x201ff)
> [38590.154121] pcieport 0000:00:08.1: PME# enabled
> [38590.154147] pcieport 0000:00:08.1: Requested to go to 3
> [38590.166636] pcieport 0000:00:08.1: Gone into state 3
> [38590.166661] pcieport 0000:00:08.1: PCI PM: Suspend power state: D3hot
> [38590.166746] ACPI: PM: Preparing to enter system sleep state S3
> [38590.173801] ACPI: EC: event blocked
> [38590.173803] ACPI: EC: EC stopped
> [38590.173804] ACPI: PM: Saving platform NVS memory
> [38590.174146] Disabling non-boot CPUs ...
> [38590.176864] smpboot: CPU 1 is now offline
> [38590.179487] smpboot: CPU 2 is now offline
> [38590.181816] smpboot: CPU 3 is now offline
> [38590.183949] smpboot: CPU 4 is now offline
> [38590.185895] smpboot: CPU 5 is now offline
> [38590.187894] smpboot: CPU 6 is now offline
> [38590.189916] smpboot: CPU 7 is now offline
> [38590.190174] ACPI: PM: Low-level resume complete
> [38590.190174] ACPI: EC: EC started
> [38590.190174] ACPI: PM: Restoring platform NVS memory
> [38590.190174] AMD-Vi: Virtual APIC enabled
> [38590.190174] AMD-Vi: Virtual APIC enabled
> [38590.190174] Enabling non-boot CPUs ...
> [38590.190174] x86: Booting SMP configuration:
> [38590.190174] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [38590.191175] ACPI: \_PR_.C001: Found 2 idle states
> [38590.191675] CPU1 is up
> [38590.191855] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [38590.192386] ACPI: \_PR_.C002: Found 2 idle states
> [38590.192885] CPU2 is up
> [38590.192948] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [38590.193519] ACPI: \_PR_.C003: Found 2 idle states
> [38590.194101] CPU3 is up
> [38590.194161] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [38590.194671] ACPI: \_PR_.C004: Found 2 idle states
> [38590.195274] CPU4 is up
> [38590.195364] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [38590.195912] ACPI: \_PR_.C005: Found 2 idle states
> [38590.196661] CPU5 is up
> [38590.196736] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [38590.197270] ACPI: \_PR_.C006: Found 2 idle states
> [38590.198126] CPU6 is up
> [38590.198199] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [38590.198763] ACPI: \_PR_.C007: Found 2 idle states
> [38590.199712] CPU7 is up
> [38590.201790] ACPI: PM: Waking up from system sleep state S3
> [38590.753045] pci 0000:00:00.2: restoring config space at offset 0x3c 
> (was 0x100, writing 0x1ff)
> [38590.753079] ACPI: EC: interrupt unblocked
> [38590.753142] pci 0000:00:00.2: restoring config space at offset 0x4 
> (was 0x100004, writing 0x100400)
> [38590.753147] pcieport 0000:00:01.2: restoring config space at offset 
> 0x3c (was 0xff, writing 0x200ff)
> [38590.753165] pcieport 0000:00:01.3: restoring config space at offset 
> 0x3c (was 0xff, writing 0x200ff)
> [38590.753184] pcieport 0000:00:01.2: restoring config space at offset 
> 0x30 (was 0xffff, writing 0x0)
> [38590.753194] pcieport 0000:00:01.4: restoring config space at offset 
> 0x3c (was 0xff, writing 0x200ff)
> [38590.753203] pcieport 0000:00:01.3: restoring config space at offset 
> 0x30 (was 0xffff, writing 0x0)
> [38590.753206] pcieport 0000:00:01.2: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [38590.753213] pcieport 0000:00:08.1: restoring config space at offset 
> 0x3c (was 0x1ff, writing 0x201ff)
> [38590.753221] pcieport 0000:00:01.3: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [38590.753227] pcieport 0000:00:01.2: restoring config space at offset 
> 0x28 (was 0xffffffff, writing 0x0)
> [38590.753227] pcieport 0000:00:01.6: restoring config space at offset 
> 0x3c (was 0xff, writing 0x200ff)
> [38590.753236] pcieport 0000:00:01.7: restoring config space at offset 
> 0x3c (was 0xff, writing 0x200ff)
> [38590.753235] pcieport 0000:00:01.4: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [38590.753237] pcieport 0000:00:01.3: restoring config space at offset 
> 0x28 (was 0xffffffff, writing 0x0)
> [38590.753244] pcieport 0000:00:01.2: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0xd0c1d0b1)
> [38590.753250] pcieport 0000:00:08.1: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [38590.753253] pcieport 0000:00:01.4: restoring config space at offset 
> 0x28 (was 0xffffffff, writing 0x0)
> [38590.753257] pcieport 0000:00:01.3: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0x1fff1)
> [38590.753263] pcieport 0000:00:01.7: restoring config space at offset 
> 0x30 (was 0xffff, writing 0x0)
> [38590.753268] pcieport 0000:00:01.6: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [38590.753272] pcieport 0000:00:08.1: restoring config space at offset 
> 0x28 (was 0x0, writing 0x0)
> [38590.753274] pcieport 0000:00:01.2: restoring config space at offset 
> 0x1c (was 0x1f1, writing 0x4141)
> [38590.753275] pcieport 0000:00:01.4: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0x1fff1)
> [38590.753279] pcieport 0000:00:01.7: restoring config space at offset 
> 0x2c (was 0x0, writing 0x0)
> [38590.753282] pcieport 0000:00:01.6: restoring config space at offset 
> 0x28 (was 0xffffffff, writing 0x0)
> [38590.753286] pcieport 0000:00:08.1: restoring config space at offset 
> 0x24 (was 0xd011c001, writing 0xd011c001)
> [38590.753295] pcieport 0000:00:01.7: restoring config space at offset 
> 0x28 (was 0xffffffff, writing 0x0)
> [38590.753300] pcieport 0000:00:01.6: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0x1fff1)
> [38590.753303] pcieport 0000:00:01.4: restoring config space at offset 
> 0x1c (was 0x3131, writing 0x20003131)
> [38590.753315] pcieport 0000:00:01.7: restoring config space at offset 
> 0x24 (was 0x1fff1, writing 0x1fff1)
> [38590.753321] pcieport 0000:00:01.3: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [38590.753322] pcieport 0000:00:01.2: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [38590.753355] pcieport 0000:00:01.4: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [38590.753356] pcieport 0000:00:01.3: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [38590.753358] pcieport 0000:00:01.2: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [38590.753361] pcieport 0000:00:08.1: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [38590.753369] pcieport 0000:00:01.6: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [38590.753384] pcieport 0000:00:01.7: restoring config space at offset 
> 0xc (was 0x810000, writing 0x810008)
> [38590.753389] pcieport 0000:00:01.4: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [38590.753395] pcieport 0000:00:08.1: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [38590.753400] pcieport 0000:00:01.6: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [38590.753415] pcieport 0000:00:01.7: restoring config space at offset 
> 0x4 (was 0x100007, writing 0x100407)
> [38590.753417] piix4_smbus 0000:00:14.0: restoring config space at 
> offset 0x4 (was 0x2200403, writing 0x2200400)
> [38590.753997] r8169 0000:03:00.0: restoring config space at offset 0x20 
> (was 0x4, writing 0xd0800004)
> [38590.754025] serial 0000:03:00.1: restoring config space at offset 
> 0x20 (was 0x4, writing 0xd0804004)
> [38590.754055] r8169 0000:03:00.0: restoring config space at offset 0x18 
> (was 0x4, writing 0xd0814004)
> [38590.754056] nvme 0000:02:00.0: restoring config space at offset 0xc 
> (was 0x0, writing 0x8)
> [38590.754078] serial 0000:03:00.1: restoring config space at offset 
> 0x18 (was 0x4, writing 0xd0815004)
> [38590.754095] serial 0000:03:00.2: restoring config space at offset 
> 0x20 (was 0x4, writing 0xd0808004)
> [38590.754098] nvme 0000:02:00.0: restoring config space at offset 0x4 
> (was 0x100007, writing 0x100003)
> [38590.754106] r8169 0000:03:00.0: restoring config space at offset 0x10 
> (was 0x1, writing 0x3401)
> [38590.754109] r8169 0000:04:00.0: restoring config space at offset 0x20 
> (was 0x4, writing 0xd0700004)
> [38590.754112] pci 0000:03:00.3: restoring config space at offset 0x20 
> (was 0x4, writing 0xd080c004)
> [38590.754128] serial 0000:03:00.1: restoring config space at offset 
> 0x10 (was 0x1, writing 0x3201)
> [38590.754138] ehci-pci 0000:03:00.4: restoring config space at offset 
> 0x18 (was 0x4, writing 0xd0810004)
> [38590.754144] r8169 0000:03:00.0: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [38590.754145] serial 0000:03:00.2: restoring config space at offset 
> 0x18 (was 0x4, writing 0xd0816004)
> [38590.754155] r8169 0000:04:00.0: restoring config space at offset 0x18 
> (was 0x4, writing 0xd0704004)
> [38590.754160] pci 0000:03:00.3: restoring config space at offset 0x18 
> (was 0x4, writing 0xd0817004)
> [38590.754165] rtsx_pci 0000:05:00.0: restoring config space at offset 
> 0x10 (was 0x0, writing 0xd0600000)
> [38590.754168] serial 0000:03:00.1: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [38590.754183] r8169 0000:03:00.0: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100403)
> [38590.754186] ehci-pci 0000:03:00.4: restoring config space at offset 
> 0x10 (was 0x0, writing 0xd0818000)
> [38590.754199] serial 0000:03:00.2: restoring config space at offset 
> 0x10 (was 0x1, writing 0x3101)
> [38590.754205] r8169 0000:04:00.0: restoring config space at offset 0x10 
> (was 0x1, writing 0x2001)
> [38590.754206] rtsx_pci 0000:05:00.0: restoring config space at offset 
> 0xc (was 0x0, writing 0x8)
> [38590.754209] serial 0000:03:00.1: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100003)
> [38590.754211] pci 0000:03:00.3: restoring config space at offset 0x10 
> (was 0x1, writing 0x3001)
> [38590.754229] ehci-pci 0000:03:00.4: restoring config space at offset 
> 0xc (was 0x800000, writing 0x800008)
> [38590.754240] serial 0000:03:00.2: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [38590.754245] r8169 0000:04:00.0: restoring config space at offset 0xc 
> (was 0x0, writing 0x8)
> [38590.754249] rtsx_pci 0000:05:00.0: restoring config space at offset 
> 0x4 (was 0x100000, writing 0x100406)
> [38590.754252] pci 0000:03:00.3: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [38590.754264] ehci-pci 0000:03:00.4: restoring config space at offset 
> 0x4 (was 0x100000, writing 0x100402)
> [38590.754276] serial 0000:03:00.2: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100003)
> [38590.754280] r8169 0000:04:00.0: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100403)
> [38590.754431] amdgpu 0000:06:00.0: restoring config space at offset 
> 0x24 (was 0x0, writing 0xd0500000)
> [38590.754437] ccp 0000:06:00.2: restoring config space at offset 0x3c 
> (was 0x300, writing 0x3ff)
> [38590.754452] amdgpu 0000:06:00.0: restoring config space at offset 
> 0x20 (was 0x1, writing 0x1001)
> [38590.754479] amdgpu 0000:06:00.0: restoring config space at offset 
> 0x18 (was 0xc, writing 0xd000000c)
> [38590.754481] ccp 0000:06:00.2: restoring config space at offset 0x24 
> (was 0x0, writing 0xd05cc000)
> [38590.754494] amdgpu 0000:06:00.0: restoring config space at offset 
> 0x10 (was 0xc, writing 0xc000000c)
> [38590.754499] ccp 0000:06:00.2: restoring config space at offset 0x18 
> (was 0x0, writing 0xd0400000)
> [38590.754507] amdgpu 0000:06:00.0: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [38590.754517] xhci_hcd 0000:06:00.4: restoring config space at offset 
> 0x3c (was 0x100, writing 0x1ff)
> [38590.754525] ccp 0000:06:00.2: restoring config space at offset 0xc 
> (was 0x800000, writing 0x800008)
> [38590.754525] amdgpu 0000:06:00.0: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100407)
> [38590.754537] snd_pci_acp3x 0000:06:00.5: restoring config space at 
> offset 0x3c (was 0x200, writing 0x2ff)
> [38590.754543] ccp 0000:06:00.2: restoring config space at offset 0x4 
> (was 0x100000, writing 0x100406)
> [38590.754546] snd_hda_intel 0000:06:00.6: restoring config space at 
> offset 0x3c (was 0x300, writing 0x3ff)
> [38590.754590] xhci_hcd 0000:06:00.4: restoring config space at offset 
> 0x10 (was 0x4, writing 0xd0300004)
> [38590.754600] snd_pci_acp3x 0000:06:00.5: restoring config space at 
> offset 0x10 (was 0x0, writing 0xd0580000)
> [38590.754610] xhci_hcd 0000:06:00.4: restoring config space at offset 
> 0xc (was 0x800000, writing 0x800008)
> [38590.754614] snd_hda_intel 0000:06:00.6: restoring config space at 
> offset 0x10 (was 0x0, writing 0xd05c0000)
> [38590.754616] snd_pci_acp3x 0000:06:00.5: restoring config space at 
> offset 0xc (was 0x800000, writing 0x800008)
> [38590.754626] xhci_hcd 0000:06:00.4: restoring config space at offset 
> 0x4 (was 0x100000, writing 0x100403)
> [38590.754631] snd_pci_acp3x 0000:06:00.5: restoring config space at 
> offset 0x4 (was 0x100000, writing 0x100006)
> [38590.754630] snd_hda_intel 0000:06:00.6: restoring config space at 
> offset 0xc (was 0x800000, writing 0x800008)
> [38590.754649] snd_hda_intel 0000:06:00.6: restoring config space at 
> offset 0x4 (was 0x100000, writing 0x100006)
> [38590.754698] snd_hda_intel 0000:06:00.1: restoring config space at 
> offset 0x10 (was 0x0, writing 0xd05c8000)
> [38590.754707] snd_hda_intel 0000:06:00.1: restoring config space at 
> offset 0xc (was 0x800000, writing 0x800008)
> [38590.754714] snd_hda_intel 0000:06:00.1: restoring config space at 
> offset 0x4 (was 0x100000, writing 0x100006)
> [38590.756140] iwlwifi 0000:01:00.0: restoring config space at offset 
> 0x3c (was 0x100, writing 0x1ff)
> [38590.756161] iwlwifi 0000:01:00.0: restoring config space at offset 
> 0x10 (was 0x4, writing 0xd0a00004)
> [38590.756171] iwlwifi 0000:01:00.0: restoring config space at offset 
> 0x4 (was 0x100000, writing 0x100406)
> [38590.825560] xhci_hcd 0000:06:00.3: power state changed by ACPI to D0
> [38590.825592] xhci_hcd 0000:06:00.3: restoring config space at offset 
> 0x3c (was 0x400, writing 0x4ff)
> [38590.825612] xhci_hcd 0000:06:00.3: restoring config space at offset 
> 0x10 (was 0x4, writing 0xd0200004)
> [38590.825621] xhci_hcd 0000:06:00.3: restoring config space at offset 
> 0xc (was 0x800000, writing 0x800008)
> [38590.825629] xhci_hcd 0000:06:00.3: restoring config space at offset 
> 0x4 (was 0x100000, writing 0x100403)
> [38590.827275] pci 0000:00:00.2: Requested to go to 0
> [38590.827289] pcieport 0000:00:01.3: PME# disabled
> [38590.827302] pcieport 0000:00:08.1: PME# disabled
> [38590.827329] pcieport 0000:00:01.7: PME# disabled
> [38590.827329] pcieport 0000:00:01.6: PME# disabled
> [38590.827354] ACPI: EC: event unblocked
> [38590.827375] ehci-pci 0000:03:00.4: PME# disabled
> [38590.827382] xhci_hcd 0000:06:00.3: PME# disabled
> [38590.827393] xhci_hcd 0000:06:00.3: Requested to go to 0
> [38590.827392] ehci-pci 0000:03:00.4: Requested to go to 0
> [38590.827401] xhci_hcd 0000:06:00.3: enabling bus mastering
> [38590.827411] ehci-pci 0000:03:00.4: enabling bus mastering
> [38590.827436] usb usb1: root hub lost power or was reset
> [38590.827457] ehci-pci 0000:03:00.4: enabling Mem-Wr-Inval
> [38590.827624] xhci_hcd 0000:06:00.4: PME# disabled
> [38590.827635] xhci_hcd 0000:06:00.4: Requested to go to 0
> [38590.827656] xhci_hcd 0000:06:00.4: enabling bus mastering
> [38590.828659] [drm] PCIE GART of 1024M enabled.
> [38590.828663] [drm] PTB located at 0x000000F400A00000
> [38590.828682] [drm] PSP is resuming...
> [38590.830105] nvme 0000:02:00.0: Requested to go to 0
> [38590.830114] nvme 0000:02:00.0: enabling bus mastering
> [38590.830721] nvme 0000:02:00.0: saving config space at offset 0x0 
> (reading 0x16391c5c)
> [38590.830725] nvme 0000:02:00.0: saving config space at offset 0x4 
> (reading 0x100407)
> [38590.830729] nvme 0000:02:00.0: saving config space at offset 0x8 
> (reading 0x1080200)
> [38590.830732] nvme 0000:02:00.0: saving config space at offset 0xc 
> (reading 0x8)
> [38590.830735] nvme 0000:02:00.0: saving config space at offset 0x10 
> (reading 0xd0900004)
> [38590.830738] nvme 0000:02:00.0: saving config space at offset 0x14 
> (reading 0x0)
> [38590.830741] nvme 0000:02:00.0: saving config space at offset 0x18 
> (reading 0xd0905000)
> [38590.830744] nvme 0000:02:00.0: saving config space at offset 0x1c 
> (reading 0xd0904000)
> [38590.830748] nvme 0000:02:00.0: saving config space at offset 0x20 
> (reading 0x0)
> [38590.830750] nvme 0000:02:00.0: saving config space at offset 0x24 
> (reading 0x0)
> [38590.830753] nvme 0000:02:00.0: saving config space at offset 0x28 
> (reading 0x0)
> [38590.830756] nvme 0000:02:00.0: saving config space at offset 0x2c 
> (reading 0x16391c5c)
> [38590.830759] nvme 0000:02:00.0: saving config space at offset 0x30 
> (reading 0x0)
> [38590.830762] nvme 0000:02:00.0: saving config space at offset 0x34 
> (reading 0x80)
> [38590.830765] nvme 0000:02:00.0: saving config space at offset 0x38 
> (reading 0x0)
> [38590.830768] nvme 0000:02:00.0: saving config space at offset 0x3c 
> (reading 0x1ff)
> [38590.848549] [drm] reserve 0x400000 from 0xf401c00000 for PSP TMR
> [38590.948754] amdgpu 0000:06:00.0: amdgpu: RAS: optional ras ta ucode 
> is not available
> [38590.963003] amdgpu 0000:06:00.0: amdgpu: RAP: optional rap ta ucode 
> is not available
> [38590.969132] amdgpu: restore the fine grain parameters
> [38591.116291] usb 2-2: reset high-speed USB device number 3 using xhci_hcd
> [38591.120340] nvme nvme0: 16/0/0 default/read/poll queues
> [38591.147808] usb 4-1: reset high-speed USB device number 2 using xhci_hcd
> [38591.391302] usb 2-1: reset full-speed USB device number 2 using xhci_hcd
> [38591.627471] [drm] kiq ring mec 2 pipe 1 q 0
> [38591.628156] usb 2-2.1: reset high-speed USB device number 4 using 
> xhci_hcd
> [38591.639105] [drm] VCN decode and encode initialized 
> successfully(under SPG Mode).
> [38591.639123] amdgpu 0000:06:00.0: amdgpu: ring gfx uses VM inv eng 0 
> on hub 0
> [38591.639126] amdgpu 0000:06:00.0: amdgpu: ring gfx_low uses VM inv eng 
> 1 on hub 0
> [38591.639128] amdgpu 0000:06:00.0: amdgpu: ring gfx_high uses VM inv 
> eng 4 on hub 0
> [38591.639129] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
> eng 5 on hub 0
> [38591.639130] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
> eng 6 on hub 0
> [38591.639132] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
> eng 7 on hub 0
> [38591.639133] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
> eng 8 on hub 0
> [38591.639134] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
> eng 9 on hub 0
> [38591.639136] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
> eng 10 on hub 0
> [38591.639137] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
> eng 11 on hub 0
> [38591.639138] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
> eng 12 on hub 0
> [38591.639139] amdgpu 0000:06:00.0: amdgpu: ring kiq_2.1.0 uses VM inv 
> eng 13 on hub 0
> [38591.639141] amdgpu 0000:06:00.0: amdgpu: ring sdma0 uses VM inv eng 0 
> on hub 1
> [38591.639142] amdgpu 0000:06:00.0: amdgpu: ring vcn_dec uses VM inv eng 
> 1 on hub 1
> [38591.639143] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc0 uses VM inv 
> eng 4 on hub 1
> [38591.639144] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc1 uses VM inv 
> eng 5 on hub 1
> [38591.639146] amdgpu 0000:06:00.0: amdgpu: ring jpeg_dec uses VM inv 
> eng 6 on hub 1
> [38591.696618] psmouse serio1: synaptics: queried max coordinates: x 
> [..5678], y [..4694]
> [38591.733256] psmouse serio1: synaptics: queried min coordinates: x 
> [1266..], y [1162..]
> [38591.820266] usb 2-2.2: reset full-speed USB device number 5 using 
> xhci_hcd
> [38592.107676] usb 4-1.3: reset high-speed USB device number 4 using 
> xhci_hcd
> [38592.173502] [drm] Fence fallback timer expired on ring gfx
> [38593.037658] usb 4-1.3.4: reset high-speed USB device number 6 using 
> xhci_hcd
> [38593.323735] usb 4-1.3.3: reset high-speed USB device number 5 using 
> xhci_hcd
> [38593.803680] usb 4-1.3.3.3: reset full-speed USB device number 9 using 
> xhci_hcd
> [38593.995675] usb 4-1.3.3.1: reset full-speed USB device number 7 using 
> xhci_hcd
> [38594.188063] usb 4-1.3.3.2: reset full-speed USB device number 8 using 
> xhci_hcd
> [38594.575133] OOM killer enabled.
> [38594.575135] Restarting tasks ...
> [38594.575154] pcieport 0000:00:01.2: scanning [bus 01-01] behind 
> bridge, pass 0
> [38594.575166] pci_bus 0000:01: scanning bus
> [38594.575169] pci_bus 0000:01: bus scan returning with max=01
> [38594.575173] pcieport 0000:00:01.3: scanning [bus 02-02] behind 
> bridge, pass 0
> [38594.575179] pci_bus 0000:02: scanning bus
> [38594.575181] pci_bus 0000:02: bus scan returning with max=02
> [38594.575185] pcieport 0000:00:01.4: scanning [bus 03-03] behind 
> bridge, pass 0
> [38594.575191] pci_bus 0000:03: scanning bus
> [38594.575342] pci_bus 0000:03: bus scan returning with max=03
> [38594.575342] pcieport 0000:00:01.6: scanning [bus 04-04] behind 
> bridge, pass 0
> [38594.575342] pci_bus 0000:04: scanning bus
> [38594.575342] pci_bus 0000:04: bus scan returning with max=04
> [38594.575342] pcieport 0000:00:01.7: scanning [bus 05-05] behind 
> bridge, pass 0
> [38594.575342] pci_bus 0000:05: scanning bus
> [38594.575342] pci_bus 0000:05: bus scan returning with max=05
> [38594.575342] pcieport 0000:00:01.2: scanning [bus 01-01] behind 
> bridge, pass 1
> [38594.575342] pci_bus 0000:01: Allocating resources
> [38594.575342] pcieport 0000:00:01.3: scanning [bus 02-02] behind 
> bridge, pass 1
> [38594.575342] pci_bus 0000:02: Allocating resources
> [38594.575342] pcieport 0000:00:01.4: scanning [bus 03-03] behind 
> bridge, pass 1
> [38594.575342] pci_bus 0000:03: Allocating resources
> [38594.575342] pcieport 0000:00:01.6: scanning [bus 04-04] behind 
> bridge, pass 1
> [38594.575342] pci_bus 0000:04: Allocating resources
> [38594.575342] pcieport 0000:00:01.7: scanning [bus 05-05] behind 
> bridge, pass 1
> [38594.575342] pci_bus 0000:05: Allocating resources
> [38594.575678] pcieport 0000:00:08.1: scanning [bus 06-06] behind 
> bridge, pass 0
> [38594.575687] pci_bus 0000:06: scanning bus
> [38594.575692] pci_bus 0000:06: bus scan returning with max=06
> [38594.575696] pcieport 0000:00:08.1: scanning [bus 06-06] behind 
> bridge, pass 1
> [38594.575703] pci_bus 0000:06: Allocating resources
> [38594.580853] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 
> 2015
> [38594.583167] Bluetooth: hci0: Device revision is 2
> [38594.583179] Bluetooth: hci0: Secure boot is enabled
> [38594.583181] Bluetooth: hci0: OTP lock is enabled
> [38594.583183] Bluetooth: hci0: API lock is enabled
> [38594.583184] Bluetooth: hci0: Debug lock is disabled
> [38594.583186] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [38594.592499] done.
> [38594.592587] random: crng reseeded on system resumption
> [38594.597344] usb 2-2.4: USB disconnect, device number 7
> [38594.627613] PM: suspend exit
> [38594.637426] Bluetooth: hci0: Found device firmware: 
> intel/ibt-18-16-1.sfi
> [38594.637542] Bluetooth: hci0: Boot Address: 0x40800
> [38594.637546] Bluetooth: hci0: Firmware Version: 214-6.22
> [38594.729528] usb 2-2.4: new full-speed USB device number 8 using xhci_hcd
> [38594.741553] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY 
> driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
> [38594.741575] r8169 0000:03:00.0: enabling bus mastering
> [38594.846095] usb 2-2.4: New USB device found, idVendor=06cb, 
> idProduct=00bd, bcdDevice= 0.00
> [38594.846104] usb 2-2.4: New USB device strings: Mfr=0, Product=0, 
> SerialNumber=1
> [38594.846107] usb 2-2.4: SerialNumber: fb17f8614e26
> [38594.869901] r8169 0000:03:00.0 eth0: Link is Down
> [38594.905530] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY 
> driver (mii_bus:phy_addr=r8169-0-400:00, irq=MAC)
> [38594.905545] r8169 0000:04:00.0: enabling bus mastering
> [38595.090293] r8169 0000:04:00.0 eth1: Link is Down
> [38595.934277] Bluetooth: hci0: Waiting for firmware download to complete
> [38595.935100] Bluetooth: hci0: Firmware loaded in 1267244 usecs
> [38595.935177] Bluetooth: hci0: Waiting for device to boot
> [38595.952111] Bluetooth: hci0: Device booted in 16571 usecs
> [38595.952116] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> [38595.958693] Bluetooth: hci0: Found Intel DDC parameters: 
> intel/ibt-18-16-1.ddc
> [38595.966133] Bluetooth: hci0: Applying Intel DDC parameters completed
> [38595.970126] Bluetooth: hci0: Firmware revision 0.1 build 214 week 6 2022
> [38596.159525] Bluetooth: MGMT ver 1.22
> [38596.722485] r8169 0000:04:00.0 eth1: Link is Up - 100Mbps/Full - flow 
> control rx/tx
> [38596.722516] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> [40148.978270] vgaarb: client 0x0000000082859412 called 'target'
> [40148.978304] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [40148.978311] vgaarb: vgadev 0000000097683c42
> [40659.894737] vgaarb: client 0x0000000082859412 called 'target'
> [40659.894773] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [40659.894783] vgaarb: vgadev 0000000097683c42
> [42424.213782] usb 4-2: USB disconnect, device number 3
> [42428.717513] usb 4-2: new full-speed USB device number 10 using xhci_hcd
> [42428.886792] usb 4-2: New USB device found, idVendor=096e, 
> idProduct=0858, bcdDevice=32.04
> [42428.886804] usb 4-2: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=0
> [42428.886809] usb 4-2: Product: FIDO
> [42428.886813] usb 4-2: Manufacturer: FT
> [42428.908630] hid-generic 0003:096E:0858.0005: hiddev97,hidraw0: USB 
> HID v1.10 Device [FT FIDO] on usb-0000:06:00.3-2/input0
> [42435.797796] usb 4-2: USB disconnect, device number 10
> [42439.865504] usb 4-2: new low-speed USB device number 11 using xhci_hcd
> [42440.025862] usb 4-2: New USB device found, idVendor=1241, 
> idProduct=1166, bcdDevice= 2.70
> [42440.025878] usb 4-2: New USB device strings: Mfr=0, Product=0, 
> SerialNumber=0
> [42440.051436] input: HID 1241:1166 as 
> /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb4/4-2/4-2:1.0/0003:1241:1166.0006/input/input22
> [42440.052435] hid-generic 0003:1241:1166.0006: input,hidraw0: USB HID 
> v1.10 Mouse [HID 1241:1166] on usb-0000:06:00.3-2/input0
> [42443.928375] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42456.010784] vgaarb: client 0x0000000082859412 called 'target'
> [42456.010888] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [42456.010896] vgaarb: vgadev 0000000097683c42
> [42502.227719] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42597.165504] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42717.271885] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42724.182423] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42727.986486] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42735.294068] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42745.380966] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42759.255754] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42780.398475] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42798.232293] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42808.329422] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42851.161499] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42897.802400] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [42915.194503] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43010.370555] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43130.242837] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43137.893843] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43143.058825] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43150.154928] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43161.306452] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43174.293620] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43194.258537] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43223.228767] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43266.172257] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43281.142452] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43330.114517] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43349.868700] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43375.544263] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43411.127636] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43424.025679] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43454.622159] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43511.853792] BTRFS error (device nvme0n1p2: state A): Transaction 
> aborted (error -5)
> [43511.853817] BTRFS: error (device nvme0n1p2: state A) in 
> __btrfs_update_delayed_inode:1065: errno=-5 IO failure
> [43511.853833] BTRFS info (device nvme0n1p2: state EA): forced readonly
> [43511.853837] BTRFS: error (device nvme0n1p2: state EA) in 
> __btrfs_run_delayed_items:1158: errno=-5 IO failure
> [43511.853851] BTRFS warning (device nvme0n1p2: state EA): Skipping 
> commit of aborted transaction.
> [43511.853855] BTRFS: error (device nvme0n1p2: state EA) in 
> cleanup_transaction:1984: errno=-5 IO failure
> [43511.853959] ------------[ cut here ]------------
> [43511.853962] WARNING: CPU: 1 PID: 527 at fs/btrfs/transaction.c:144 
> btrfs_put_transaction+0x113/0x120 [btrfs]
> [43511.854108] Modules linked in: tun(E) snd_seq_dummy(E) snd_seq(E) 
> ccm(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) 
> snd_usb_audio(E) snd_usbmidi_lib(E) snd_rawmidi(E) snd_seq_device(E) 
> af_packet(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
> sr_mod(E) cdrom(E) nft_reject_inet(E) nft_reject(E) nft_ct(E) 
> nft_chain_nat(E) cdc_ether(E) usbnet(E) nf_tables(E) ebtable_nat(E) 
> ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) 
> ip6table_security(E) uvcvideo(E) iptable_nat(E) nf_nat(E) 
> videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) 
> nf_conntrack(E) videodev(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) 
> videobuf2_common(E) mc(E) iptable_mangle(E) iptable_raw(E) 
> iptable_security(E) r8152(E) mii(E) bnep(E) ip_set(E) nfnetlink(E) 
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) 
> iptable_filter(E) bpfilter(E) btusb(E) btrtl(E) btbcm(E) btintel(E) 
> btmtk(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) intel_rapl_msr(E)
> [43511.854207]  intel_rapl_common(E) iwlmvm(E) nls_iso8859_1(E) 
> snd_ctl_led(E) nls_cp437(E) snd_hda_codec_realtek(E) vfat(E) fat(E) 
> snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) edac_mce_amd(E) 
> snd_hda_intel(E) snd_intel_dspcfg(E) mac80211(E) snd_intel_sdw_acpi(E) 
> kvm_amd(E) libarc4(E) snd_hda_codec(E) snd_hda_core(E) kvm(E) iwlwifi(E) 
> snd_hwdep(E) thinkpad_acpi(E) snd_pcm(E) r8169(E) snd_rn_pci_acp3x(E) 
> ledtrig_audio(E) irqbypass(E) snd_acp_config(E) snd_timer(E) pcspkr(E) 
> efi_pstore(E) platform_profile(E) realtek(E) cfg80211(E) mdio_devres(E) 
> snd_soc_acpi(E) wmi_bmof(E) k10temp(E) i2c_piix4(E) snd_pci_acp3x(E) 
> snd(E) ipmi_devintf(E) xfs(E) rfkill(E) libphy(E) ipmi_msghandler(E) 
> soundcore(E) ac(E) button(E) i2c_scmi(E) acpi_cpufreq(E) joydev(E) 
> fuse(E) configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) uas(E) 
> usb_storage(E) hid_generic(E) usbhid(E) amdgpu(E) crc32_pclmul(E) 
> i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) iommu_v2(E) drm_buddy(E) 
> gpu_sched(E) drm_display_helper(E)
> [43511.854303]  ghash_clmulni_intel(E) sha512_ssse3(E) nvme(E) 
> drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme_core(E) 
> sysimgblt(E) rtsx_pci_sdmmc(E) t10_pi(E) mmc_core(E) drm(E) ucsi_acpi(E) 
> xhci_pci(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) ehci_pci(E) 
> xhci_hcd(E) aesni_intel(E) cec(E) rtsx_pci(E) ehci_hcd(E) typec_ucsi(E) 
> crypto_simd(E) cryptd(E) roles(E) ccp(E) rc_core(E) mfd_core(E) 
> usbcore(E) crc64(E) typec(E) battery(E) video(E) wmi(E) backlight(E) 
> serio_raw(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) 
> crc32c_intel(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) 
> efivarfs(E)
> [43511.854386] CPU: 1 PID: 527 Comm: btrfs-transacti Tainted: G        
> W   E      6.2.0-rc2-pci_debug-59.40-default+ #356
> [43511.854392] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [43511.854395] RIP: 0010:btrfs_put_transaction+0x113/0x120 [btrfs]
> [43511.854540] Code: 5d 41 5c e9 0f b7 db e4 0f 0b 5b be 03 00 00 00 5d 
> 41 5c e9 6f de 07 e5 0f 0b e9 13 ff ff ff 0f 0b eb d9 0f 0b e9 4d ff ff 
> ff <0f> 0b e9 56 ff ff ff 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
> [43511.854546] RSP: 0018:ffffa55000dfbe40 EFLAGS: 00010286
> [43511.854553] RAX: ffff8c13898b0f00 RBX: ffff8c13ab565600 RCX: 
> 0000000000000000
> [43511.854558] RDX: ffff8c13ab565628 RSI: 0000000000000246 RDI: 
> ffff8c13ab565610
> [43511.854562] RBP: ffff8c14519a8000 R08: 0000000000000000 R09: 
> ffffa55000dfbdf8
> [43511.854566] R10: 000000000003d080 R11: ffff8c163efd3d80 R12: 
> ffff8c1388ec1000
> [43511.854569] R13: ffff8c14519a8058 R14: 00000000fffffffb R15: 
> ffff8c1388ec1428
> [43511.854573] FS:  0000000000000000(0000) GS:ffff8c1630680000(0000) 
> knlGS:0000000000000000
> [43511.854579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [43511.854583] CR2: 00007fde9032eaa0 CR3: 000000016a66c000 CR4: 
> 00000000003506e0
> [43511.854588] Call Trace:
> [43511.854596]  <TASK>
> [43511.854604]  btrfs_commit_transaction.cold+0x29f/0x371 [btrfs]
> [43511.854758]  ? start_transaction+0xc5/0x5e0 [btrfs]
> [43511.854893]  transaction_kthread+0x141/0x1b0 [btrfs]
> [43511.855024]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> [43511.855153]  kthread+0xed/0x120
> [43511.855162]  ? __pfx_kthread+0x10/0x10
> [43511.855168]  ret_from_fork+0x2c/0x50
> [43511.855179]  </TASK>
> [43511.855181] ---[ end trace 0000000000000000 ]---
> [43544.278523] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43550.037735] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43555.227976] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43563.294615] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43572.156897] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43586.166480] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43606.136763] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43635.199715] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43679.389366] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43742.318207] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43801.824500] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43837.251590] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43957.277608] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43964.170725] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43968.229515] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43975.214422] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43985.094619] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [43999.278149] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44020.300981] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44048.624178] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44091.159110] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44155.222809] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44250.322311] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44259.889399] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44370.274485] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44377.949200] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44383.260723] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44390.193873] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44401.402055] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44414.344410] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44434.172450] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44463.285860] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44506.245090] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44571.397572] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44665.177784] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44697.212438] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44785.253423] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44790.739047] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44797.168474] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44803.120727] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44813.060913] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44827.238424] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44847.147267] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44877.354320] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44919.147439] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [44983.193996] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45078.226798] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45198.258436] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45205.178595] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45208.970497] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45216.177848] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45226.021332] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45241.386476] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45241.422637] systemd-journald[28439]: Data hash table of 
> /run/log/journal/95eb5f22cf55442db35ca5b3a93f0bec/system.journal has a 
> fill level at 75.0 (47334 of 63111 items, 25165824 file size, 531 bytes 
> per hash table item), suggesting rotation.
> [45241.422650] systemd-journald[28439]: 
> /run/log/journal/95eb5f22cf55442db35ca5b3a93f0bec/system.journal: 
> Journal header limits reached or header out-of-date, rotating.
> [45260.138866] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45277.214385] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45289.270989] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45332.106463] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45396.282406] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45492.187576] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45611.245821] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45616.678436] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45621.905843] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45630.110459] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45639.089105] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45653.173912] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45673.210022] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45702.229712] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45746.226471] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45799.213760] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45809.267506] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [45904.013921] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46024.229326] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46031.085993] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46035.261661] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46042.169923] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46052.058033] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46066.165715] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46087.221982] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46115.109777] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46158.065707] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46222.229703] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46244.628418] vgaarb: client 0x0000000082859412 called 'target'
> [46244.628436] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [46244.628440] vgaarb: vgadev 0000000097683c42
> [46273.221876] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46317.026681] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46437.245977] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46443.911597] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46449.049867] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46455.993980] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46467.109811] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46480.073994] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46497.651957] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46529.133682] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46572.074035] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46637.290015] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46730.994506] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46851.237908] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46856.654529] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46863.057871] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46869.137717] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46879.357898] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46893.054241] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46913.057985] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46943.268853] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [46985.045771] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47024.658088] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47049.226215] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47144.193719] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47264.242391] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47271.070100] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47274.890446] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47281.990179] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47291.898029] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47307.301789] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47326.118477] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47355.185423] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47398.030426] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47462.193989] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47474.718073] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47558.183157] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47677.246062] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47682.673928] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47688.019238] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47696.302294] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47704.994390] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47719.212345] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47739.202557] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47768.334016] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47812.261886] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47875.176083] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47970.046215] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [47997.721834] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48090.244665] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48097.133813] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48100.949962] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48108.052152] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48117.985770] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48132.225834] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48132.232727] systemd-journald[28439]: Data hash table of 
> /run/log/journal/95eb5f22cf55442db35ca5b3a93f0bec/system.journal has a 
> fill level at 75.0 (47334 of 63111 items, 25165824 file size, 531 bytes 
> per hash table item), suggesting rotation.
> [48132.232735] systemd-journald[28439]: 
> /run/log/journal/95eb5f22cf55442db35ca5b3a93f0bec/system.journal: 
> Journal header limits reached or header out-of-date, rotating.
> [48153.258120] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48181.157866] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48224.000573] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48288.070433] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48297.577928] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48383.045875] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48503.246636] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48509.786936] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48514.905557] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48522.097779] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48533.253934] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48546.401926] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48566.029858] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48595.278214] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48638.117832] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48703.349908] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48797.034002] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48879.581923] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48917.237904] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48922.857932] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48929.153817] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48935.053786] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48944.973877] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48959.310273] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [48979.285745] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49009.322409] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49051.098239] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49115.265881] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49210.033984] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49330.241962] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49337.085656] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49341.018181] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49348.022829] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49357.949846] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49373.273888] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49391.995007] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49399.217848] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49421.141725] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49464.141903] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49527.973946] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49624.222598] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49743.229500] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49748.686349] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49753.910214] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49762.266438] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49771.141917] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49785.077659] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49804.968839] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49834.253993] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49878.174527] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49915.230469] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [49941.252069] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50036.106047] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50097.406497] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50156.242439] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50163.081968] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50167.072009] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50174.198491] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50184.017754] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50198.161892] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50219.273956] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50247.210512] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50290.045859] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50354.110470] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50449.251374] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50569.245710] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50575.838005] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50581.158512] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50588.061851] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50596.409962] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50612.154006] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50632.055666] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50661.213704] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50704.214756] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50769.289807] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50863.089770] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50983.245789] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50988.769870] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [50995.170130] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51001.177149] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51011.022216] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51011.057955] systemd-journald[28439]: Data hash table of 
> /run/log/journal/95eb5f22cf55442db35ca5b3a93f0bec/system.journal has a 
> fill level at 75.0 (47334 of 63111 items, 25165824 file size, 531 bytes 
> per hash table item), suggesting rotation.
> [51011.057972] systemd-journald[28439]: 
> /run/log/journal/95eb5f22cf55442db35ca5b3a93f0bec/system.journal: 
> Journal header limits reached or header out-of-date, rotating.
> [51025.149947] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51045.157911] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51055.418011] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51075.276662] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51117.193955] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51181.205710] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51275.957905] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51396.253089] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51403.061761] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51406.941891] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51414.085854] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51424.095740] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51439.389815] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51458.299365] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51487.346000] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51530.202467] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51594.314087] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51635.414508] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51690.266344] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51809.250411] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51814.829923] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51819.922514] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51828.244435] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51837.079233] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51851.297859] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51871.178462] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51897.269935] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [51944.217538] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52007.249706] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52102.318085] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52191.257456] vgaarb: client 0x0000000082859412 called 'target'
> [52191.257505] vgaarb: PCI:0000:06:00.0 ==> 0000:06:00.0 pdev 
> 00000000282393c3
> [52191.257512] vgaarb: vgadev 0000000097683c42
> [52195.756152] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52222.258719] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52229.089925] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52233.253422] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52240.354459] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52250.072024] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52264.197940] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52285.229745] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52313.426466] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52356.153916] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52420.163599] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52515.193798] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52635.229976] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52641.923110] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52647.061892] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52654.269994] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52662.757767] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52677.185544] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52697.474571] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52726.230616] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52769.246394] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> [52834.206440] r8152 5-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
> 
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 6b557439-a722-46c6-b9fa-e3395a5f4d40
> Rescan hasn't been initialzied, a difference in qgroup accounting is 
> expected
> Counts for qgroup id: 0/257 are different
> our:        referenced 27110174720 referenced compressed 27110174720
> disk:        referenced 4665344 referenced compressed 4665344
> diff:        referenced 27105509376 referenced compressed 27105509376
> our:        exclusive 27110174720 exclusive compressed 27110174720
> disk:        exclusive 4665344 exclusive compressed 4665344
> diff:        exclusive 27105509376 exclusive compressed 27105509376
> Counts for qgroup id: 0/258 are different
> our:        referenced 16384 referenced compressed 16384
> disk:        referenced 0 referenced compressed 0
> diff:        referenced 16384 referenced compressed 16384
> our:        exclusive 16384 exclusive compressed 16384
> disk:        exclusive 0 exclusive compressed 0
> diff:        exclusive 16384 exclusive compressed 16384
> Counts for qgroup id: 0/259 are different
> our:        referenced 699535360 referenced compressed 699535360
> disk:        referenced 24576 referenced compressed 24576
> diff:        referenced 699510784 referenced compressed 699510784
> our:        exclusive 699535360 exclusive compressed 699535360
> disk:        exclusive 24576 exclusive compressed 24576
> diff:        exclusive 699510784 exclusive compressed 699510784
> Counts for qgroup id: 0/260 are different
> our:        referenced 16384 referenced compressed 16384
> disk:        referenced 0 referenced compressed 0
> diff:        referenced 16384 referenced compressed 16384
> our:        exclusive 16384 exclusive compressed 16384
> disk:        exclusive 0 exclusive compressed 0
> diff:        exclusive 16384 exclusive compressed 16384
> Counts for qgroup id: 0/261 are different
> our:        referenced 41037824 referenced compressed 41037824
> disk:        referenced 151552 referenced compressed 151552
> diff:        referenced 40886272 referenced compressed 40886272
> our:        exclusive 41033728 exclusive compressed 41033728
> disk:        exclusive 151552 exclusive compressed 151552
> diff:        exclusive 40882176 exclusive compressed 40882176
> Counts for qgroup id: 0/262 are different
> our:        referenced 16384 referenced compressed 16384
> disk:        referenced 0 referenced compressed 0
> diff:        referenced 16384 referenced compressed 16384
> our:        exclusive 16384 exclusive compressed 16384
> disk:        exclusive 0 exclusive compressed 0
> diff:        exclusive 16384 exclusive compressed 16384
> Counts for qgroup id: 0/263 are different
> our:        referenced 4329472 referenced compressed 4329472
> disk:        referenced 0 referenced compressed 0
> diff:        referenced 4329472 referenced compressed 4329472
> our:        exclusive 4329472 exclusive compressed 4329472
> disk:        exclusive 0 exclusive compressed 0
> diff:        exclusive 4329472 exclusive compressed 4329472
> Counts for qgroup id: 0/264 are different
> our:        referenced 16384 referenced compressed 16384
> disk:        referenced 0 referenced compressed 0
> diff:        referenced 16384 referenced compressed 16384
> our:        exclusive 16384 exclusive compressed 16384
> disk:        exclusive 0 exclusive compressed 0
> diff:        exclusive 16384 exclusive compressed 16384
> Counts for qgroup id: 0/265 are different
> our:        referenced 16384 referenced compressed 16384
> disk:        referenced 0 referenced compressed 0
> diff:        referenced 16384 referenced compressed 16384
> our:        exclusive 16384 exclusive compressed 16384
> disk:        exclusive 0 exclusive compressed 0
> diff:        exclusive 16384 exclusive compressed 16384
> Counts for qgroup id: 0/266 are different
> our:        referenced 78879715328 referenced compressed 78879715328
> disk:        referenced 7454720 referenced compressed 7454720
> diff:        referenced 78872260608 referenced compressed 78872260608
> our:        exclusive 78879711232 exclusive compressed 78879711232
> disk:        exclusive 7454720 exclusive compressed 7454720
> diff:        exclusive 78872256512 exclusive compressed 78872256512
> found 106919567360 bytes used, no error found
> total csum bytes: 77296040
> total tree bytes: 767180800
> total fs tree bytes: 613728256
> total extent tree bytes: 51773440
> btree space waste bytes: 175542641
> file data blocks allocated: 106218446848
>   referenced 106148605952
> 
