Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A411E617332
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 01:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKCAE3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 20:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKCAE1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 20:04:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156F640A
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 17:04:25 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdNcG-1pPiX21zZQ-00ZLLu; Thu, 03
 Nov 2022 01:04:09 +0100
Message-ID: <6e07f8d7-a1e2-2125-02ab-0cf3c1da0036@gmx.com>
Date:   Thu, 3 Nov 2022 08:04:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: NULL Ptr Deref on sub-page rw mount with missing device
Content-Language: en-US
To:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <56f5c7a4-8c4f-5bcc-220b-ed51c692598b@bluematt.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <56f5c7a4-8c4f-5bcc-220b-ed51c692598b@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZzNT4Ybkkm98EEFBpfshG0tNQUNSL8pBcKz58bGzXH7XUnLIRTN
 n7Tnkli75R5xj4JEOD12qsA0WDwBLdVqS1+gFzy+Kkgv9BIzF3IfiPREsmzp+/MmnWwpUJU
 fvsSM2awO70k+qRxib2/DSsOtyuhv1yzJ7RFmwDMKBT/ExaU0SH2u0eOiE9AN9ntSldIP+0
 bcKTT2l+JIQkUVDNtUdGg==
UI-OutboundReport: notjunk:1;M01:P0:7+Y6w7p4/Ck=;+j9RHNH7PCr7Mw8NHU3xTKcNvfU
 HzEeKYOqx8OnTQ5rfi9jXNYMoXg5jadfpK2aE6ZE9oOOuQDwJTXHMPOO1q36kVrMvsEFz5+h4
 /+eaawe49gxHGDTsQFYHrZNxHH3t04IVZsJG7devGfWdFdCBLYD+/i9mApAKC/AOzU9kk6T0k
 hU/y+PEJgrB4lnVuyGefMeCFZw+m0+TcrMaHAk0Cc1o1f6yu3f0dpe8A8iIzp+q7SSv7VieCg
 nz/ROPTbfmyKqjjwqVDhfgkvAYBdavqcn7X2fQh3umGqJCSidcxS/HX9cOTOyHijjFsY+gMsp
 PpXq+FvNARNS8x3ft86W6mSAlNL7kDppukJiIgog9FvicdG+jDDR7egwIsjWwq1439AhRcx3p
 ki7AX3NRM0hg01Uw1/UayJbjRWZVuPDs5Z+WX4CTIWX0UQ+9L2M4qsPOCQa6mZoRlV52z0DUk
 RMhunqqR5VLk9CG1tPotI4m5osYX3/jiIuED9XE/xBA7vUCeV8tD9Kh5hREbcq0JBR2s8zs3C
 WMdlQnLLgjv4lTYLGj7M3sQcruBQX6J17IxCW6CUy0mtF6H3qgH4TegId+Ta6O48y3/tuHVPc
 LplwxZhQ327iokEI2NVMOVw5D+iYK2GTD9WB08SF1/DJ2GJo++jbl4h4cegHLqlY1rSmVq7kH
 6y6O+y3gppdibQ2QscBKVFk4hpjTqciab5V4r5xk+XnQmf5//0/Qjwi9gH7M3GzaPSqqHq/Sh
 lTzkXORF6rH2kc/cXNu5EMCHgfkeg9UNplKO/fbnmzuavtIq70wmySRAcbu6P4CglegTkDAfE
 OTVylUUcu7VxBQ8WYbypQcMNytVwGQRmz/gqNcOCHc0v8+QX1t6JQaIk7Bp2x2tF98j1k8ort
 NQ3gDHgeDRsnRrzrXuUoxU4HieF9J4gAXZHgswIJ4sYy6sMtT/hZGgf+1bhx5JdoGlIa3uxSq
 WTbR2XNA/NPCukr6hFCvqByxpzQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/3 00:05, Matt Corallo wrote:
> Basically what the title says. Sadly dmesg is a bit of a mess because 
> multiple threads hit it at the same time so its all interleaved. A full 
> dmesg is available at http://cwillu.com:8080/69.59.18.155/1 with the top 
> of it pasted below.
> 
> Linux BEASTv3 5.19.0-0.deb11.2-powerpc64le #1 SMP Debian 
> 5.19.11-1~bpo11+1 (2022-10-03) ppc64le GNU/Linux
> 
[...]
> [  734.185801] NIP [c00000000015fe30] __queue_work+0x380/0x7a0
> [  734.185817] LR [c0000000001602d4] queue_work_on+0x84/0xb0
> [  734.185832] Call Trace:
> [  734.185839] [c00000002ade79e0] [c0000000001602d4] 
> queue_work_on+0x84/0xb0
> [  734.185857] [c00000002ade7a10] [c0080000102bd1fc] 
> btrfs_queue_work+0xf4/0x180 [btrfs]

This looks like we have some workqueue not allocated at all.

This is a little weird, as at that context, there is nothing subpage 
related at all...


In fact, the more important thing is, there is a missing device way 
before the crash:

   BTRFS error (device dm-1): devid 4 uuid 
a5666cf3-91d2-4902-8d0b-e1ba147c5c9c is missing
   BTRFS error (device dm-1): failed to read chunk tree: -2

I believe there is something wrong with the initialization, as normally 
we shouldn't continue if we failed to read chunk tree.

Mind to test v6.0 kernel to see if the crash still happens on the same 
fs (with a missing device)?

If so, the dmesg please, as this looks like a valid crash that may 
affect non-subpage systems.

Thanks,
Qu

> [  734.185917] [c00000002ade7a70] [c00800001025cc54] 
> end_workqueue_bio+0x9c/0x140 [btrfs]
> [  734.185977] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [  734.185980] [c00000002ade7aa0] [c0000000006eefbc] bio_endio+0x19c/0x230
> [  734.185982] Kernel attempted to read user page (0) - exploit attempt? 
> (uid: 0)
> [  734.185988] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [  734.185991] Faulting instruction address: 0xc00000000015fe30
> [  734.186005] Faulting instruction address: 0xc00000000015fe30
> 
> [  734.186017] Kernel attempted to read user page (0) - exploit attempt? 
> (uid: 0)
> [  734.186022] Kernel attempted to read user page (0) - exploit attempt? 
> (uid: 0)
> [  734.186027] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [  734.186030] Faulting instruction address: 0xc00000000015fe30
> [  734.186018] [c00000002ade7ad0] [c0080000102ad8dc] 
> btrfs_end_bio+0xe4/0x290 [btrfs]
> [  734.186046] BUG: Kernel NULL pointer dereference on read at 0x00000000
> 
> [  734.186055] [c00000002ade7b10] [c0000000006eefbc] bio_endio+0x19c/0x230
> [  734.186060] [c00000002ade7b40] [c00800000f855304] 
> dm_io_complete+0xdc/0x2e0 [dm_mod]
> [  734.186092] Faulting instruction address: 0xc00000000015fe30
> 
> [  734.186119] [c00000002ade7b90] [c00800000f857998] 
> clone_endio+0x100/0x310 [dm_mod]
> [  734.186456] [c00000002ade7c30] [c0000000006eefbc] bio_endio+0x19c/0x230
> [  734.186480] [c00000002ade7c60] [c00800000f282200] 
> crypt_dec_pending+0x138/0x190 [dm_crypt]
> [  734.186518] [c00000002ade7ca0] [c000000000161848] 
> process_one_work+0x2a8/0x580
> [  734.186555] [c00000002ade7d40] [c000000000162228] 
> worker_thread+0x98/0x5e0
> [  734.186562] Kernel attempted to read user page (0) - exploit attempt? 
> (uid: 0)
> [  734.186566] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [  734.186570] Faulting instruction address: 0xc00000000015fe30
> [  734.186591] [c00000002ade7dc0] [c00000000016e920] kthread+0x120/0x130
> [  734.186645] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [  734.186672] Kernel attempted to read user page (0) - exploit attempt? 
> (uid: 0)
> [  734.186677] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [  734.186680] Faulting instruction address: 0xc00000000015fe30
> 
> [  734.186706] [c00000002ade7e10] [c00000000000ce54] 
> ret_from_kernel_thread+0x5c/0x64
> [  734.186789] Faulting instruction address: 0xc00000000015fe30
> 
> [  734.186840] Instruction dump:
> [  734.187346] eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 7c0803a6 
> ebc1fff0 ebe1fff8
> [  734.187438] 7d908120 4e800020 60000000 60420000 <e87e0000> 48bb5955 
> 60000000 813e0018
> [  734.187558] ---[ end trace 0000000000000000 ]---
> 
> [  735.590644] Oops: Kernel access of bad area, sig: 7 [#2]
> [  735.590655] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
> [  735.590669] Modules linked in: xt_mark xt_connmark xt_nat wireguard 
> libchacha20poly1305 libcurve25519_generic libchacha libpoly1305 
> ip6_udp_tunnel udp_tunnel nft_chain_nat xt_MASQUERADE nf_nat 
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables 
> crc32c_generic nfnetlink essiv authenc amdgpu evdev snd_hda_codec_hdmi 
> snd_hda_intel snd_intel_dspcfg snd_hda_codec ofpart gpu_sched ast 
> snd_hda_core powernv_flash ipmi_powernv snd_hwdep drm_display_helper 
> drm_vram_helper ipmi_devintf drm_ttm_helper mtd ttm ipmi_msghandler 
> opal_prd snd_pcm sg snd_timer drm_kms_helper syscopyarea snd sysfillrect 
> sysimgblt at24 fb_sys_fops i2c_algo_bit soundcore regmap_i2c drm sunrpc 
> fuse drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 
> xxhash_generic btrfs zstd_compress raid10 raid456 async_raid6_recov 
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 
> multipath linear
> [  735.590782] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [  735.590784] Faulting instruction address: 0xc00000000015fe30
> [  735.591027]  usb_storage dm_crypt dm_mod algif_skcipher af_alg sd_mod 
> raid1 md_mod xhci_pci xhci_hcd xts ecb nvme ctr vmx_crypto gf128mul 
> crc32c_vpmsum tg3 nvme_core t10_pi usbcore mpt3sas 
> crc64_rocksoft_generic libphy crc64_rocksoft crc_t10dif 
> crct10dif_generic crc64 crct10dif_common raid_class ptp pps_core 
> usb_common scsi_transport_sas
> [  735.591141] CPU: 26 PID: 642 Comm: kworker/u129:6 Tainted: G      D 
> 5.19.0-0.deb11.2-powerpc64le #1  Debian 5.19.11-1~bpo11+1
> [  735.591180] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
> [  735.591213] NIP:  c00000000015fe30 LR: c0000000001602d4 CTR: 
> c000000000160250
> [  735.591247] REGS: c000000011e67650 TRAP: 0300   Tainted: G      D 
> (5.19.0-0.deb11.2-powerpc64le Debian 5.19.11-1~bpo11+1)
> [  735.591293] MSR:  900000000280b033 
> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28002284  XER: 20040000
> [  735.591341] CFAR: c00000000015fc1c DAR: 0000000000000000 DSISR: 
> 00080000 IRQMASK: 1
>                 GPR00: c0000000001602d4 c000000011e678f0 
> c0000000026a7800 0000000000000800
>                 GPR04: 000000007fffffff c00000002983ca40 
> 0000000000000000 c0080000102bc968
>                 GPR08: 0000000fffffffe1 000000007fffffff 
> 0000000000000000 c008000010363be8
>                 GPR12: 0000000000004000 c000000ffffc3900 
> c00000000016e808 c000000008a50ac0
>                 GPR16: 0000000000000000 c000000024f7a000 
> 0000000000000278 c000000000ed73f0
>                 GPR20: 0000000000000001 c0000000027836f8 
> c000000002783700 0000000000000000
>                 GPR24: c00000000250f9c0 c0000000026e3060 
> 000000000000001a 000000007fffffff
>                 GPR28: c0000000021278b0 0000000000000800 
> 0000000000000000 c00000002983ca40
> [  735.591627] NIP [c00000000015fe30] __queue_work+0x380/0x7a0
> [  735.591649] LR [c0000000001602d4] queue_work_on+0x84/0xb0
> [  735.591670] Call Trace:
> [  735.591685] [c000000011e679e0] [c0000000001602d4] 
> queue_work_on+0x84/0xb0
> [  735.591709] [c000000011e67a10] [c0080000102bd1fc] 
> btrfs_queue_work+0xf4/0x180 [btrfs]
> [  735.591768] [c000000011e67a70] [c00800001025cc54] 
> end_workqueue_bio+0x9c/0x140 [btrfs]
> [  735.591816] [c000000011e67aa0] [c0000000006eefbc] bio_endio+0x19c/0x230
> [  735.591840] [c000000011e67ad0] [c0080000102ad8dc] 
> btrfs_end_bio+0xe4/0x290 [btrfs]
> [  735.591898] [c000000011e67b10] [c0000000006eefbc] bio_endio+0x19c/0x230
> [  735.591930] [c000000011e67b40] [c00800000f855304] 
> dm_io_complete+0xdc/0x2e0 [dm_mod]
> [  735.591969] [c000000011e67b90] [c00800000f857998] 
> clone_endio+0x100/0x310 [dm_mod]
> [  735.592008] [c000000011e67c30] [c0000000006eefbc] bio_endio+0x19c/0x230
> [  735.592049] [c000000011e67c60] [c00800000f282200] 
> crypt_dec_pending+0x138/0x190 [dm_crypt]
> [  735.592093] [c000000011e67ca0] [c000000000161848] 
> process_one_work+0x2a8/0x580
> [  735.592118] [c000000011e67d40] [c000000000162228] 
> worker_thread+0x98/0x5e0
> [  735.592160] [c000000011e67dc0] [c00000000016e920] kthread+0x120/0x130
> [  735.592192] [c000000011e67e10] [c00000000000ce54] 
> ret_from_kernel_thread+0x5c/0x64
> [  735.592226] Instruction dump:
> [  735.592243] eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 7c0803a6 
> ebc1fff0 ebe1fff8
> [  735.592274] 7d908120 4e800020 60000000 60420000 <e87e0000> 48bb5955 
> 60000000 813e0018
> [  735.592306] ---[ end trace 0000000000000000 ]---
