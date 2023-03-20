Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F066C0883
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 02:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCTBaj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 21:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCTBaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 21:30:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E24EB42
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 18:22:51 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDhlf-1pku6X1bEt-00Aodf; Mon, 20
 Mar 2023 02:21:55 +0100
Message-ID: <ee02ea29-b5c6-492f-89ee-0a363a81e478@gmx.com>
Date:   Mon, 20 Mar 2023 09:21:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Frequent fs/btrfs/backref.c kernel stack traces (warnings)
To:     Jarno Pelkonen <jarno.pelkonen@gmail.com>, fdmanana@gmail.com
Cc:     linux-btrfs@vger.kernel.org
References: <CAKv8qLmDNAGJGCtsevxx_VZ_YOvvs1L83iEJkTgyA4joJertng@mail.gmail.com>
 <CAL3q7H7aFJOm-VR249BhttVUrD0ZcANTmDu9hivZ8pKrwXx=zg@mail.gmail.com>
 <CAKv8qL=u=CJ9XBmF69DAtcc-K4ULbBNDd4M96gRVzsHRY8C8Gw@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAKv8qL=u=CJ9XBmF69DAtcc-K4ULbBNDd4M96gRVzsHRY8C8Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RQEnkLDjvoCFBziWfKWopZqKa0SKSWwXyPz0c28CfayrjQeZWkv
 eR/rnXS9qdcc3hh9YL245Sioso7TSdLnsr9HkGSGJplN3hoO8NrTs6IywlpJlUDStentZLF
 5dK5XTz02yK8+QVJQx/VfEcUGHK0qOndAa2S0lfkUi+WkUAi2T/z0UQzqKTPNgbX7Ox7V0z
 D7vJRqgHqP8vB5AqqnQsg==
UI-OutboundReport: notjunk:1;M01:P0:RaWnoqYuD6I=;OklCqjiZ+dCq1jUVzzuL4dfVQuI
 utcGTMtTtgWv3Yt1N+8wkxz1aOGhOaOcoDDHlmt5ZeL1XmxuZBta9RnKvYGv6PzPxEdmoQjKd
 nbyls4JQvtGN1xlo4ExCGzL9aHMmF6ecLyBW7ivTCAIG5HUYNAY3HuE+faQVnfKjdTyGHoT21
 2GUUh2hb2MKD6G5BqZ+9E/ZDt+6bMH1aaecuUCTjTVe9KEs1xYadx3jTy3ZquNmuwX99lEI7Q
 2f4wNF6tOD73bBSs5Iy8WVtwIDdf101UpXQegqSjXRXwDcHVPiASF38Epzr/rbJLFz6J6bc5S
 pKMCiTJQ75IdfqTotQxFufimGJqT5ocOtcZ/XGyDqgzzthA8pcV0ungaMY96U434fOvYc2nW1
 KuEXx5ghdzOUVROAwExO/n0AZEhNnJcfbUw3G9quFz0Bka+n2qFzyvTN4Lb2m2Twhun6tnEBS
 cwRXEUdBYig3Aok7rzcBTmr/oNryxNFdGgV9LaUqtdFnMPQygn0GZxKecLKdaGUFmw8crmEvB
 9hZ03op1Kx3xsMhWE8PGNdNYZZlnwkRQAqSVoPDBR8CC5G6CLCVV5LnzQLcXEdbdJtI1v7bdc
 Wrd0wiYT9m1ISRPQYMQXV1c+oX097/sZ4r0GPcJS7Syk5wBRQMYoCaal7uzYNc1sgLjBnsSkT
 xc1hfA4Htku2LR/FJFoNwADAl8N8YVRJGjw9dlT1RVqtgk/6v2adAOwmsaiLTBcQ6JJWqJx66
 nnZSNVwMabdbBp2/giAz5hZ3veRj8Pww5ERjlGGMMnKX363qEDwSVP9gwAB7dRc+aamn7ZGcE
 FoVi+asMBE2SlD5PNO0IXWQkVqn5lMZCkjT/rFaZmHFbC1OjNCN6l5k3pd5HB3Co8dvMS07Qz
 VKeSae61FjRmgxfbXyTWmTIMnwax7yBu5T0L1+O7bJ/QwGAAiQq4K3I09sC1Zs7hY5OtD5Jp1
 b10ejnfPP+xqFRwAiTKq/MFcSUA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/20 03:29, Jarno Pelkonen wrote:
> Thank you,
> 
> I also noticed other weird behavior yesterday; I am unable to turn
> space_cache=v2 on the /home file system. I ran ‘btrfs check
> —clear-space-cache --force’

Is the fs still mounted? If so, it's a big problem...

Anyway, recommended to run a proper "btrfs check" on the unmounted fs 
just in case.

Thanks,
Qu

> and mounted with '-o space_cache=v2", but
> both the 'mount' output and 'btrfs inspect-internal dump-super'
> indicated the space_cache was still version v1.
> 
> I think the file system is 12-14 years old and the disks have been
> replaced (thanks to btrfs’ great flexibility). I am not certain if
> this is relevant or not. In any case, I am replacing the file system
> with a newly created one now just to be on the safe side.
> 
> Best regards,
> Jarno
> 
> 
> On Sun, Mar 19, 2023 at 4:22 PM Filipe Manana <fdmanana@gmail.com> wrote:
>>
>> On Sat, Mar 18, 2023 at 12:22 PM Jarno Pelkonen
>> <jarno.pelkonen@gmail.com> wrote:
>>>
>>> Dear btrfs-devs,
>>>
>>> I keep getting kernel stack traces like the pair below
>>> (fs/btrfs/backref.c). These occur about once a day at random times and
>>> always in pairs. I have checked all three btrfs file systems on the
>>> server and 'btrfs check' did not report any. I know these are
>>> "warnings" only, but I do not know what to do about these if anything.
>>
>> It's just a harmless warning in this case.
>> We're getting shared nodes/leaves and not dealing with it properly
>> during fiemap.
>>
>> It does not affect any write path, so you don't risk any sort of corruption.
>>
>> I'll take a look at it.
>> Thanks for the report.
>>
>>>
>>> I ran Ubuntu 22.04 LTS with mainline kernels (Index of
>>> /~kernel-ppa/mainline (ubuntu.com)). The same has happened with
>>> multiple kernels: 6.0.x, 6.1.x and now with 6.2.6.
>>>
>>> Regards,
>>>
>>> Jarno
>>>
>>> PS: I am not a mailing list subscriber
>>>
>>> ---------------- dmesg snip ----------------
>>>
>>> [Sat Mar 18 06:54:04 2023] ------------[ cut here ]------------
>>> [Sat Mar 18 06:54:04 2023] WARNING: CPU: 0 PID: 98251 at
>>> fs/btrfs/backref.c:1260 lookup_backref_shared_cache+0x14d/0x1a0
>>> [btrfs]
>>> [Sat Mar 18 06:54:04 2023] Modules linked in: tls xxhash_generic
>>> binfmt_misc nf_log_syslog nft_log hid_generic nft_ct nf_conntrack
>>> nf_defrag_ipv6 nf_defrag_ipv4 nft_limit intel_rapl_msr ppdev mei_pxp
>>> mei_hdcp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp
>>> snd_hda_codec_realtek kvm_intel snd_hda_codec_generic ledtrig_audio
>>> kvm irqbypass snd_hda_codec_hdmi rapl intel_cstate snd_hda_intel
>>> snd_intel_dspcfg snd_soc_rt5640 snd_soc_rl6231 snd_intel_sdw_acpi
>>> snd_hda_codec input_leds at24 snd_soc_core mei_me snd_compress
>>> serio_raw snd_hda_core ac97_bus snd_pcm_dmaengine snd_hwdep mei
>>> snd_pcm snd_timer parport_pc snd soundcore acpi_pad mac_hid
>>> sch_fq_codel sha256_ssse3 hwmon_vid nf_tables coretemp lp parport
>>> ramoops nfnetlink msr reed_solomon pstore_blk pstore_zone efi_pstore
>>> ip_tables x_tables autofs4 btrfs blake2b_generic usbhid hid dm_crypt
>>> raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
>>> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear i915
>>> drm_buddy i2c_algo_bit ttm
>>> [Sat Mar 18 06:54:04 2023]  drm_display_helper cec rc_core
>>> drm_kms_helper syscopyarea crct10dif_pclmul crc32_pclmul sysfillrect
>>> polyval_clmulni sysimgblt polyval_generic ghash_clmulni_intel
>>> sha512_ssse3 aesni_intel r8169 crypto_simd nvme ahci i2c_i801 cryptd
>>> drm nvme_core libahci i2c_smbus lpc_ich realtek xhci_pci
>>> xhci_pci_renesas nvme_common video wmi
>>> [Sat Mar 18 06:54:04 2023] CPU: 0 PID: 98251 Comm: mandb Not tainted
>>> 6.2.6-060206-generic #202303130630
>>> [Sat Mar 18 06:54:04 2023] Hardware name: Gigabyte Technology Co.,
>>> Ltd. Z97M-D3H/Z97M-D3H, BIOS F8 09/18/2015
>>> [Sat Mar 18 06:54:04 2023] RIP:
>>> 0010:lookup_backref_shared_cache+0x14d/0x1a0 [btrfs]
>>> [Sat Mar 18 06:54:04 2023] Code: eb b8 49 8b 96 08 02 00 00 83 e3 01
>>> 48 8b 8a a0 0d 00 00 4b 8d 14 7f 49 3b 4c d4 38 0f 85 18 ff ff ff 41
>>> 88 18 e9 75 ff ff ff <0f> 0b e9 09 ff ff ff 4c 89 fe 48 c7 c7 80 69 df
>>> c0 4c 89 45 c0 48
>>> [Sat Mar 18 06:54:04 2023] RSP: 0018:ffffac37e039fb78 EFLAGS: 00010202
>>> [Sat Mar 18 06:54:04 2023] RAX: 0000000000000001 RBX: 0000000000000008
>>> RCX: 0000000000000008
>>> [Sat Mar 18 06:54:04 2023] RDX: 0000001017a17000 RSI: ffffa06328404000
>>> RDI: ffffa063e8615c00
>>> [Sat Mar 18 06:54:04 2023] RBP: ffffac37e039fbc0 R08: ffffac37e039fbf7
>>> R09: 0000000000000000
>>> [Sat Mar 18 06:54:04 2023] R10: 0000000000000000 R11: 0000000000000000
>>> R12: ffffa063e8615c00
>>> [Sat Mar 18 06:54:04 2023] R13: 0000000000000008 R14: ffffa06328404000
>>> R15: ffffac37e039fc58
>>> [Sat Mar 18 06:54:04 2023] FS:  00007f3342662740(0000)
>>> GS:ffffa069ffa00000(0000) knlGS:0000000000000000
>>> [Sat Mar 18 06:54:04 2023] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [Sat Mar 18 06:54:04 2023] CR2: 0000561767caa000 CR3: 00000001a7f10002
>>> CR4: 00000000001706f0
>>> [Sat Mar 18 06:54:04 2023] Call Trace:
>>> [Sat Mar 18 06:54:04 2023]  <TASK>
>>> [Sat Mar 18 06:54:04 2023]  btrfs_is_data_extent_shared+0x1a3/0x440 [btrfs]
>>> [Sat Mar 18 06:54:04 2023]  extent_fiemap+0x78b/0x8c0 [btrfs]
>>> [Sat Mar 18 06:54:04 2023]  ? kmem_cache_free+0x1e/0x3b0
>>> [Sat Mar 18 06:54:04 2023]  btrfs_fiemap+0x4c/0xa0 [btrfs]
>>> [Sat Mar 18 06:54:04 2023]  do_vfs_ioctl+0x203/0x900
>>> [Sat Mar 18 06:54:04 2023]  __x64_sys_ioctl+0x7d/0xe0
>>> [Sat Mar 18 06:54:04 2023]  do_syscall_64+0x5b/0x90
>>> [Sat Mar 18 06:54:04 2023]  ? syscall_exit_to_user_mode+0x29/0x50
>>> [Sat Mar 18 06:54:04 2023]  ? do_syscall_64+0x67/0x90
>>> [Sat Mar 18 06:54:04 2023]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>> [Sat Mar 18 06:54:04 2023] RIP: 0033:0x7f334251aaff
>>> [Sat Mar 18 06:54:04 2023] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24
>>> 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10
>>> b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64
>>> 48 2b 04 25 28 00
>>> [Sat Mar 18 06:54:04 2023] RSP: 002b:00007ffd27314fe0 EFLAGS: 00000246
>>> ORIG_RAX: 0000000000000010
>>> [Sat Mar 18 06:54:04 2023] RAX: ffffffffffffffda RBX: 00007ffd27315160
>>> RCX: 00007f334251aaff
>>> [Sat Mar 18 06:54:04 2023] RDX: 00007ffd273151a0 RSI: 00000000c020660b
>>> RDI: 0000000000000006
>>> [Sat Mar 18 06:54:04 2023] RBP: 0000000000000005 R08: 0000000000000001
>>> R09: 0000561767ab3410
>>> [Sat Mar 18 06:54:04 2023] R10: 0000000000000000 R11: 0000000000000246
>>> R12: 0000561767ca4a40
>>> [Sat Mar 18 06:54:04 2023] R13: 00007ffd27315148 R14: 00007ffd27315150
>>> R15: 0000000000000006
>>> [Sat Mar 18 06:54:04 2023]  </TASK>
>>> [Sat Mar 18 06:54:04 2023] ---[ end trace 0000000000000000 ]---
>>> [Sat Mar 18 06:54:04 2023] ------------[ cut here ]------------
>>> [Sat Mar 18 06:54:04 2023] WARNING: CPU: 0 PID: 98251 at
>>> fs/btrfs/backref.c:1327 store_backref_shared_cache+0xef/0x150 [btrfs]
>>> [Sat Mar 18 06:54:04 2023] Modules linked in: tls xxhash_generic
>>> binfmt_misc nf_log_syslog nft_log hid_generic nft_ct nf_conntrack
>>> nf_defrag_ipv6 nf_defrag_ipv4 nft_limit intel_rapl_msr ppdev mei_pxp
>>> mei_hdcp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp
>>> snd_hda_codec_realtek kvm_intel snd_hda_codec_generic ledtrig_audio
>>> kvm irqbypass snd_hda_codec_hdmi rapl intel_cstate snd_hda_intel
>>> snd_intel_dspcfg snd_soc_rt5640 snd_soc_rl6231 snd_intel_sdw_acpi
>>> snd_hda_codec input_leds at24 snd_soc_core mei_me snd_compress
>>> serio_raw snd_hda_core ac97_bus snd_pcm_dmaengine snd_hwdep mei
>>> snd_pcm snd_timer parport_pc snd soundcore acpi_pad mac_hid
>>> sch_fq_codel sha256_ssse3 hwmon_vid nf_tables coretemp lp parport
>>> ramoops nfnetlink msr reed_solomon pstore_blk pstore_zone efi_pstore
>>> ip_tables x_tables autofs4 btrfs blake2b_generic usbhid hid dm_crypt
>>> raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
>>> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear i915
>>> drm_buddy i2c_algo_bit ttm
>>> [Sat Mar 18 06:54:04 2023]  drm_display_helper cec rc_core
>>> drm_kms_helper syscopyarea crct10dif_pclmul crc32_pclmul sysfillrect
>>> polyval_clmulni sysimgblt polyval_generic ghash_clmulni_intel
>>> sha512_ssse3 aesni_intel r8169 crypto_simd nvme ahci i2c_i801 cryptd
>>> drm nvme_core libahci i2c_smbus lpc_ich realtek xhci_pci
>>> xhci_pci_renesas nvme_common video wmi
>>> [Sat Mar 18 06:54:04 2023] CPU: 0 PID: 98251 Comm: mandb Tainted: G
>>>      W          6.2.6-060206-generic #202303130630
>>> [Sat Mar 18 06:54:04 2023] Hardware name: Gigabyte Technology Co.,
>>> Ltd. Z97M-D3H/Z97M-D3H, BIOS F8 09/18/2015
>>> [Sat Mar 18 06:54:04 2023] RIP:
>>> 0010:store_backref_shared_cache+0xef/0x150 [btrfs]
>>> [Sat Mar 18 06:54:04 2023] Code: 04 c4 48 89 50 30 c6 40 40 00 4c 89
>>> 70 38 48 83 c4 10 5b 41 5c 41 5e 5d 31 c0 31 d2 31 c9 31 f6 31 ff 45
>>> 31 c0 c3 cc cc cc cc <0f> 0b eb a0 48 c7 c7 e0 68 df c0 89 4d e0 e8 3e
>>> 77 72 ea 8b 4d e0
>>> [Sat Mar 18 06:54:04 2023] RSP: 0018:ffffac37e039fb98 EFLAGS: 00010202
>>> [Sat Mar 18 06:54:04 2023] RAX: 00000000fffffffb RBX: 0000000000000001
>>> RCX: 0000000000000008
>>> [Sat Mar 18 06:54:04 2023] RDX: 0000001017a17000 RSI: ffffa06328404000
>>> RDI: ffffa063e8615c00
>>> [Sat Mar 18 06:54:04 2023] RBP: ffffac37e039fbc0 R08: 0000000000000000
>>> R09: 0000000000000000
>>> [Sat Mar 18 06:54:04 2023] R10: 0000000000000000 R11: 0000000000000000
>>> R12: ffffa063e8615c00
>>> [Sat Mar 18 06:54:04 2023] R13: ffffa063e8615c00 R14: ffffa06328404000
>>> R15: ffffac37e039fc58
>>> [Sat Mar 18 06:54:04 2023] FS:  00007f3342662740(0000)
>>> GS:ffffa069ffa00000(0000) knlGS:0000000000000000
>>> [Sat Mar 18 06:54:04 2023] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [Sat Mar 18 06:54:04 2023] CR2: 0000561767caa000 CR3: 00000001a7f10002
>>> CR4: 00000000001706f0
>>> [Sat Mar 18 06:54:04 2023] Call Trace:
>>> [Sat Mar 18 06:54:04 2023]  <TASK>
>>> [Sat Mar 18 06:54:04 2023]  btrfs_is_data_extent_shared+0x172/0x440 [btrfs]
>>> [Sat Mar 18 06:54:04 2023]  extent_fiemap+0x78b/0x8c0 [btrfs]
>>> [Sat Mar 18 06:54:04 2023]  ? kmem_cache_free+0x1e/0x3b0
>>> [Sat Mar 18 06:54:04 2023]  btrfs_fiemap+0x4c/0xa0 [btrfs]
>>> [Sat Mar 18 06:54:04 2023]  do_vfs_ioctl+0x203/0x900
>>> [Sat Mar 18 06:54:04 2023]  __x64_sys_ioctl+0x7d/0xe0
>>> [Sat Mar 18 06:54:04 2023]  do_syscall_64+0x5b/0x90
>>> [Sat Mar 18 06:54:04 2023]  ? syscall_exit_to_user_mode+0x29/0x50
>>> [Sat Mar 18 06:54:04 2023]  ? do_syscall_64+0x67/0x90
>>> [Sat Mar 18 06:54:04 2023]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>> [Sat Mar 18 06:54:04 2023] RIP: 0033:0x7f334251aaff
>>> [Sat Mar 18 06:54:04 2023] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24
>>> 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10
>>> b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64
>>> 48 2b 04 25 28 00
>>> [Sat Mar 18 06:54:04 2023] RSP: 002b:00007ffd27314fe0 EFLAGS: 00000246
>>> ORIG_RAX: 0000000000000010
>>> [Sat Mar 18 06:54:04 2023] RAX: ffffffffffffffda RBX: 00007ffd27315160
>>> RCX: 00007f334251aaff
>>> [Sat Mar 18 06:54:04 2023] RDX: 00007ffd273151a0 RSI: 00000000c020660b
>>> RDI: 0000000000000006
>>> [Sat Mar 18 06:54:04 2023] RBP: 0000000000000005 R08: 0000000000000001
>>> R09: 0000561767ab3410
>>> [Sat Mar 18 06:54:04 2023] R10: 0000000000000000 R11: 0000000000000246
>>> R12: 0000561767ca4a40
>>> [Sat Mar 18 06:54:04 2023] R13: 00007ffd27315148 R14: 00007ffd27315150
>>> R15: 0000000000000006
>>> [Sat Mar 18 06:54:04 2023]  </TASK>
>>> [Sat Mar 18 06:54:04 2023] ---[ end trace 0000000000000000 ]---
>>>
>>> ------------------ dmesg snip ends ------------
>>>
>>> ##  Problems with /home filesystem
>>>
>>> * I have had issues with /home filesystem and I do not know if these
>>> are related to the kernel stack traces
>>> * /home filesystem has 330 snapshots. Tens of snapshots are created
>>> daily and trimmed in exponential fashion
>>> * Quotas are NOT in use. I once tried quotas just to realize how bad
>>> an idea it was with hundreds of snapshots
>>> * The /home volume has had issues with extremely slow directory
>>> lookups and I do not know if these kernel warnings relate to these or
>>> even the same volume.
>>> * All the disks are monitored with smartd and tested regularly with
>>> short & long smart tests. The disks are OK
>>> * The /home volume has once had btrfs corruption errors (btrfs device
>>> stats) on one large db dump that was created under extreme system
>>> stress ( load 13, IO load 400%). I removed the related file and since
>>> that there has not been any btrfs corruption errors.
>>> * Besides that, no data has been lost ever
>>> * The /home filesystem has been running since ~2011 (the underlying
>>> disks have been replaced)
>>>
>>> ## Supplementary information
>>>
>>> dmesg.log is attached
>>>
>>> # uname -a
>>> Linux tupajumi 6.2.6-060206-generic #202303130630 SMP PREEMPT_DYNAMIC
>>> Mon Mar 13 11:41:04 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> # btrfs --version
>>> btrfs-progs v5.15.1
>>>
>>> # btrfs fi show
>>> Label: 'ROOT'  uuid: 2bdcb61d-079f-4f3d-b19e-05b15cc58a46
>>>          Total devices 1 FS bytes used 61.98GiB
>>>          devid    2 size 102.55GiB used 65.03GiB path /dev/nvme0n1p4
>>>
>>> Label: 'DATA_SSD'  uuid: 05119d7f-7bb4-46bf-98e9-6aeaaf4a3243
>>>          Total devices 1 FS bytes used 300.47GiB
>>>          devid    1 size 787.23GiB used 331.01GiB path /dev/nvme0n1p5
>>>
>>> Label: 'DATA'  uuid: 225fabac-6f56-48d6-b76e-9a0ed90ded9c
>>>          Total devices 4 FS bytes used 5.03TiB
>>>          devid    4 size 2.73TiB used 1.82TiB path /dev/mapper/sdd
>>>          devid    6 size 3.64TiB used 3.15TiB path /dev/mapper/sdc
>>>          devid    7 size 3.64TiB used 3.19TiB path /dev/mapper/sdb
>>>          devid    8 size 3.64TiB used 1.93TiB path /dev/mapper/sda
>>>
>>> Label: 'BACKUP'  uuid: 41658c57-06ce-4281-a5f5-649207d7d3de
>>>          Total devices 1 FS bytes used 1.98TiB
>>>          devid    1 size 2.73TiB used 1.98TiB path /dev/mapper/sde
>>>
>>> # btrfs fi df /
>>> Data, single: total=62.00GiB, used=60.72GiB
>>> System, single: total=32.00MiB, used=12.00KiB
>>> Metadata, single: total=3.00GiB, used=1.26GiB
>>> GlobalReserve, single: total=173.10MiB, used=0.00B
>>>
>>> # btrfs fi df /mnt/db
>>> Data, single: total=308.01GiB, used=300.05GiB
>>> System, single: total=4.00MiB, used=80.00KiB
>>> Metadata, single: total=23.00GiB, used=428.38MiB
>>> GlobalReserve, single: total=382.97MiB, used=0.00B
>>>
>>> # btrfs fi df /home
>>> Data, RAID1: total=5.02TiB, used=5.01TiB
>>> System, RAID1: total=32.00MiB, used=812.00KiB
>>> Metadata, RAID1: total=27.00GiB, used=13.93GiB
>>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>>
>>> # old kern.log messages
>>>
>>> root@tupajumi (0)# grep 'cut here' -A 1 kern.lo*
>>> kern.log:Mar 15 22:04:58 tupajumi kernel: [  452.078477] ------------[
>>> cut here ]------------
>>> kern.log-Mar 15 22:04:58 tupajumi kernel: [  452.078479] WARNING: CPU:
>>> 0 PID: 3575 at fs/btrfs/backref.c:1560
>>> btrfs_is_data_extent_shared+0x2d9/0x470 [btrfs]
>>> --
>>> kern.log:Mar 15 22:04:58 tupajumi kernel: [  452.078888] ------------[
>>> cut here ]------------
>>> kern.log-Mar 15 22:04:58 tupajumi kernel: [  452.078889] WARNING: CPU:
>>> 0 PID: 3575 at fs/btrfs/backref.c:1627
>>> store_backref_shared_cache+0xed/0x150 [btrfs]
>>> --
>>> kern.log:Mar 16 11:47:48 tupajumi kernel: [10389.067222] ------------[
>>> cut here ]------------
>>> kern.log-Mar 16 11:47:48 tupajumi kernel: [10389.067225] WARNING: CPU:
>>> 3 PID: 6533 at fs/btrfs/backref.c:1560
>>> btrfs_is_data_extent_shared+0x2d9/0x470 [btrfs]
>>> --
>>> kern.log:Mar 16 11:47:48 tupajumi kernel: [10389.067545] ------------[
>>> cut here ]------------
>>> kern.log-Mar 16 11:47:48 tupajumi kernel: [10389.067546] WARNING: CPU:
>>> 3 PID: 6533 at fs/btrfs/backref.c:1627
>>> store_backref_shared_cache+0xed/0x150 [btrfs]
>>> --
>>> kern.log:Mar 18 06:54:03 tupajumi kernel: [70998.139920] ------------[
>>> cut here ]------------
>>> kern.log-Mar 18 06:54:03 tupajumi kernel: [70998.139923] WARNING: CPU:
>>> 0 PID: 98251 at fs/btrfs/backref.c:1260
>>> lookup_backref_shared_cache+0x14d/0x1a0 [btrfs]
>>> --
>>> kern.log:Mar 18 06:54:03 tupajumi kernel: [70998.140377] ------------[
>>> cut here ]------------
>>> kern.log-Mar 18 06:54:03 tupajumi kernel: [70998.140378] WARNING: CPU:
>>> 0 PID: 98251 at fs/btrfs/backref.c:1327
>>> store_backref_shared_cache+0xef/0x150 [btrfs]
>>> --
>>> kern.log.1:Mar  5 23:11:19 tupajumi kernel: [23281.913947]
>>> ------------[ cut here ]------------
>>> kern.log.1-Mar  5 23:11:19 tupajumi kernel: [23281.913951] WARNING:
>>> CPU: 1 PID: 36913 at fs/btrfs/backref.c:1560
>>> btrfs_is_data_extent_shared+0x2d9/0x470 [btrfs]
>>> --
>>> kern.log.1:Mar  5 23:11:19 tupajumi kernel: [23281.914262]
>>> ------------[ cut here ]------------
>>> kern.log.1-Mar  5 23:11:19 tupajumi kernel: [23281.914263] WARNING:
>>> CPU: 1 PID: 36913 at fs/btrfs/backref.c:1627
>>> store_backref_shared_cache+0xed/0x150 [btrfs]
>>>
>>> root@tupajumi (0)# zcat kern.log.*z | grep  'cut here' -A 1
>>> Feb 28 06:15:49 tupajumi kernel: [54466.451755] ------------[ cut here
>>> ]------------
>>> Feb 28 06:15:49 tupajumi kernel: [54466.451758] WARNING: CPU: 4 PID:
>>> 53222 at fs/btrfs/backref.c:1560
>>> btrfs_is_data_extent_shared+0x2d9/0x470 [btrfs]
>>> --
>>> Feb 28 06:15:49 tupajumi kernel: [54466.452086] ------------[ cut here
>>> ]------------
>>> Feb 28 06:15:49 tupajumi kernel: [54466.452087] WARNING: CPU: 4 PID:
>>> 53222 at fs/btrfs/backref.c:1627 store_backref_shared_cache+0xed/0x150
>>> [btrfs]
>>> --
>>> Mar  3 06:54:01 tupajumi kernel: [56673.654009] ------------[ cut here
>>> ]------------
>>> Mar  3 06:54:01 tupajumi kernel: [56673.654013] WARNING: CPU: 6 PID:
>>> 263876 at fs/btrfs/backref.c:1560
>>> btrfs_is_data_extent_shared+0x2d9/0x470 [btrfs]
>>> --
>>> Mar  3 06:54:01 tupajumi kernel: [56673.654402] ------------[ cut here
>>> ]------------
>>> Mar  3 06:54:01 tupajumi kernel: [56673.654402] WARNING: CPU: 6 PID:
>>> 263876 at fs/btrfs/backref.c:1627
>>> store_backref_shared_cache+0xed/0x150 [btrfs]
>>> --
>>> Feb 18 16:08:04 tupajumi kernel: [  413.723823] ------------[ cut here
>>> ]------------
>>> Feb 18 16:08:04 tupajumi kernel: [  413.723826] WARNING: CPU: 7 PID:
>>> 4751 at fs/btrfs/backref.c:1560
>>> btrfs_is_data_extent_shared+0x2d9/0x470 [btrfs]
>>> --
>>> Feb 18 16:08:04 tupajumi kernel: [  413.724139] ------------[ cut here
>>> ]------------
>>> Feb 18 16:08:04 tupajumi kernel: [  413.724140] WARNING: CPU: 7 PID:
>>> 4751 at fs/btrfs/backref.c:1627 store_backref_shared_cache+0xed/0x150
>>> [btrfs]
>>> --
>>> Feb 18 18:44:52 tupajumi kernel: [ 3210.983164] ------------[ cut here
>>> ]------------
>>> Feb 18 18:44:52 tupajumi kernel: [ 3210.983168] WARNING: CPU: 0 PID:
>>> 6941 at fs/btrfs/backref.c:1560
>>> btrfs_is_data_extent_shared+0x2d9/0x470 [btrfs]
>>> --
>>> Feb 18 18:44:52 tupajumi kernel: [ 3210.983490] ------------[ cut here
>>> ]------------
>>> Feb 18 18:44:52 tupajumi kernel: [ 3210.983491] WARNING: CPU: 0 PID:
>>> 6941 at fs/btrfs/backref.c:1627 store_backref_shared_cache+0xed/0x150
>>> [btrfs]
>>
>>
>>
>> --
>> Filipe David Manana,
>>
>> “Whether you think you can, or you think you can't — you're right.”
