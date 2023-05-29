Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1858071509A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 22:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjE2Ug7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 16:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Ug6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 16:36:58 -0400
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DEFCB7
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1685390461; h=In-Reply-To:From:References:Cc:To:Subject:From:Subject:To:
        Cc:Reply-To; bh=qFY0FZPAkMCkjZruKeLnd6mV6V3HUhzQf975biXOggg=; b=SmAmE9Rg5RXzq
        txT8zq7q20SrdBeCdFgN+mjFk3dm4oj3dLzJcCKwFqlJpLknS/GJDgEoZI+ThyOkHR5gBV0xgYT1g
        STAO9HwnoYEqYd5HetTAeZj4xfjMtWeBibhD6hjpsdnGfn4JO7zaTTA8fUKJyzPBCXQSRLIm5Feih
        GDg9VPlLNhDIBgokGQDEBCt9Y4eYA98ULt3MZAmBzhVaKRjVDWxhsRNWmJ5uJeQO4I2GqARoex43b
        hL1ZWwrD0dcnW61NwKSWousLEHwzO29rcWz8SBusX5fTjjFUkYnpDFZyGs7t4k49Be+bZnio7voTI
        Qd7eT5lMB4jSG7kbNyTZA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1685390462; h=In-Reply-To:From:References:Cc:
        To:Subject:From:Subject:To:Cc:Reply-To;
        bh=qFY0FZPAkMCkjZruKeLnd6mV6V3HUhzQf975biXOggg=; b=jhLWjk1MmCamLbyPqMCwDAQ0By
        V3H5vLwxM7+uBJrxupErpaNhJsIS2fXCvMerLtM5pn0seElT8x1s87Bt0TXWFicZx2cjmvmUNR21q
        VOSiP0p/ehLuB33v9q1Ip+y+yDhgh5nPTMmUdcrxP/iC6JdvO7e3rBAyt5D02N7digr9RL2f3tDsr
        UGrmEZonPp+FXt6HbsDgRaCOFibRDjn5e1+gVqgqZttfmUJcXRmj1nwnz+MZWhK4pdtmgZut0j8BU
        DYYlqyTyCX3YU/+FWroLl8Wo7lcsFFZqlApyDGSYUayvsUZyauKRJGSE+75tuDkwt9U0bYXpUwolc
        qOUAHFFQ==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q3jbk-002vBl-0H;
        Mon, 29 May 2023 20:36:48 +0000
Message-ID: <1ce06018-3fb5-50b1-813d-5b6d9f2cdcdf@bluematt.me>
Date:   Mon, 29 May 2023 13:36:47 -0700
MIME-Version: 1.0
Subject: Re: [6.1] Transaction Aborted cancelling a metadata balance
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <bc26e2b2-dcb1-d4a2-771e-82c1dbf4f197@bluematt.me>
 <20230529141933.GH575@twin.jikos.cz>
 <f555f213-f839-445f-7b00-cbf1952d64eb@bluematt.me>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <f555f213-f839-445f-7b00-cbf1952d64eb@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/29/23 1:23 PM, Matt Corallo wrote:
> FWIW, after the read-only I unmounted and checked and it came back fine:
> 
> # btrfs check --readonly --progress /dev/mapper/bigraid21_crypt
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/bigraid21_crypt
> UUID: e2843f83-aadf-418d-b36b-5642f906808f
> [1/7] checking root items                      (0:09:17 elapsed, 42551370 items checked)
> [1/7] checking root items                      (0:33:21 elapsed, 144002052 items checked)
> [2/7] checking extents                         (4:19:44 elapsed, 8488584 items checked)
> [3/7] checking free space tree                 (0:36:19 elapsed, 31540 items checked)
> [4/7] checking fs roots                        (9:30:14 elapsed, 5429485 items checked)
> [5/7] checking csums (without verifying data)  (2:01:44 elapsed, 37437367 items checked)
> [6/7] checking root refs                       (0:00:00 elapsed, 4344 items checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 31304846272026 bytes used, no error found
> total csum bytes: 30413242320
> total tree bytes: 139005657088
> total fs tree bytes: 89334448128
> total extent tree bytes: 14987935744
> btree space waste bytes: 22197358915
> file data blocks allocated: 227202548510720
>   referenced 43568236474368

Hmm, so it seems I cannot cancel the balance at all. I remounted after the check came back good, the 
balance resumed and then I tried to cancel and hit the assert_eb_page_uptodate issue again:


May 29 20:25:23 BEASTv3 kernel: BTRFS info (device dm-2): start tree-log replay
May 29 20:25:27 BEASTv3 kernel: BTRFS info (device dm-2): checking UUID tree
May 29 20:25:28 BEASTv3 kernel: BTRFS info (device dm-2): balance: resume -mconvert=raid1c4,soft 
-sconvert=raid1c4,soft
...
May 29 20:30:52 BEASTv3 kernel: BTRFS info (device dm-2): found 8487 extents, stage: move data extents
May 29 20:30:53 BEASTv3 kernel: ------------[ cut here ]------------
May 29 20:30:53 BEASTv3 kernel: WARNING: CPU: 37 PID: 1135142 at fs/btrfs/extent_io.c:5301 
assert_eb_page_uptodate+0x88/0x160 [btrfs]
May 29 20:30:53 BEASTv3 kernel: Modules linked in: xt_tcpudp wireguard libchacha20poly1305 
libcurve25519_generic libchacha libpoly1305 ip6_udp_tunnel udp_tunn>
May 29 20:30:53 BEASTv3 kernel:  crc32c_vpmsum tg3 mpt3sas nvme_core t10_pi usbcore libphy 
crc64_rocksoft_generic crc64_rocksoft crc_t10dif crct10dif_generic >
May 29 20:30:53 BEASTv3 kernel: CPU: 37 PID: 1135142 Comm: kworker/u128:0 Tainted: G        W 
   6.1.0-0.deb11.7-powerpc64le #1  Debian 6.1.20-2~bpo11+1>
May 29 20:30:53 BEASTv3 kernel: Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 
PowerNV
May 29 20:30:53 BEASTv3 kernel: Workqueue: btrfs-cache btrfs_work_helper [btrfs]
May 29 20:30:53 BEASTv3 kernel: NIP:  c00800000f6d0160 LR: c00800000f6d0148 CTR: c000000000d871c0
May 29 20:30:53 BEASTv3 kernel: REGS: c0000000621f36c0 TRAP: 0700   Tainted: G        W 
(6.1.0-0.deb11.7-powerpc64le Debian 6.1.20-2~bpo11+1a~test)
May 29 20:30:53 BEASTv3 kernel: MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 2800228e  XER: 
20040000
May 29 20:30:53 BEASTv3 kernel: CFAR: c00800000f7805c8 IRQMASK: 0
                                 GPR00: c00800000f6d0148 c0000000621f3960 c00800000f7ea800 
0000000000000001
                                 GPR04: 0000000000000000 0000000000000018 0000000000000000 
0000000000000000
                                 GPR08: 0000000000000018 0000000000000001 0000000000000000 
c00800000f7961d8
                                 GPR12: c000000000d871c0 c000200fff7f8600 c0000000001705a8 
00000000000030f8
                                 GPR16: 0000267371d00000 0000000040000000 c00020018e253000 
0000000000200000
                                 GPR20: 0000000000000700 c0000000027391a8 0000000000000000 
c0002001e9aff870
                                 GPR24: 0000000000000000 0000000000000000 c000000ab5575000 
c00020002593b000
                                 GPR28: 0000000000000000 c000000ab5575000 c00c00000100f980 
c0002008ad7a9dc8
May 29 20:30:53 BEASTv3 kernel: NIP [c00800000f6d0160] assert_eb_page_uptodate+0x88/0x160 [btrfs]
May 29 20:30:53 BEASTv3 kernel: LR [c00800000f6d0148] assert_eb_page_uptodate+0x70/0x160 [btrfs]
May 29 20:30:53 BEASTv3 kernel: Call Trace:
May 29 20:30:53 BEASTv3 kernel: [c0000000621f3960] [c00800000f6d0148] 
assert_eb_page_uptodate+0x70/0x160 [btrfs] (unreliable)
May 29 20:30:53 BEASTv3 kernel: [c0000000621f39a0] [c00800000f6d8d84] 
extent_buffer_test_bit+0x5c/0xb0 [btrfs]
May 29 20:30:53 BEASTv3 kernel: [c0000000621f39e0] [c00800000f7632c4] free_space_test_bit+0xac/0x100 
[btrfs]
May 29 20:30:53 BEASTv3 kernel: [c0000000621f3a40] [c00800000f7668e4] 
load_free_space_tree+0x1fc/0x570 [btrfs]
May 29 20:30:53 BEASTv3 kernel: [c0000000621f3b50] [c00800000f773214] caching_thread+0x41c/0x690 [btrfs]
May 29 20:30:53 BEASTv3 kernel: [c0000000621f3c20] [c00800000f6ec24c] btrfs_work_helper+0x154/0x518 
[btrfs]
May 29 20:30:53 BEASTv3 kernel: [c0000000621f3ca0] [c000000000162d68] process_one_work+0x2a8/0x580
May 29 20:30:53 BEASTv3 kernel: [c0000000621f3d40] [c0000000001630d8] worker_thread+0x98/0x5e0
May 29 20:30:53 BEASTv3 kernel: [c0000000621f3dc0] [c0000000001706c0] kthread+0x120/0x130
May 29 20:30:53 BEASTv3 kernel: [c0000000621f3e10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
May 29 20:30:53 BEASTv3 kernel: Instruction dump:
May 29 20:30:53 BEASTv3 kernel: 80df0008 e8bf0000 7fc4f378 7c7c1b78 7fa3eb78 480b03bd 60000000 2c3c0000
May 29 20:30:53 BEASTv3 kernel: 39200000 4082000c 68630001 5469063e <0b090000> e8010050 eb810020 
ebe10038
May 29 20:30:53 BEASTv3 kernel: ---[ end trace 0000000000000000 ]---
May 29 20:30:53 BEASTv3 kernel: page=73825584873472 uptodate=1 error=0 dirty=0 start=73825584906240 
len=16384 bitmaps=
May 29 20:30:53 BEASTv3 kernel: subpage offsets: uptodate=0 error=16 dirty=32 writeback=48

the last bit there is from Qu's patch in "6.1 Replacement warnings and papercuts". I got a similar 
flood of these kinds of WARN_ONs (a few thousand or more) and then finally hit the same EINVALID 
issue as this thread described:


......

[1221122.410745] ------------[ cut here ]------------
[1221122.410747] WARNING: CPU: 37 PID: 1135142 at fs/btrfs/extent_io.c:5301 
assert_eb_page_uptodate+0x88/0x160 [btrfs]
[1221122.410768] Modules linked in: xt_tcpudp wireguard libchacha20poly1305 libcurve25519_generic 
libchacha libpoly1305 ip6_udp_tunnel udp_tunnel ipt_REJECT nf_reject_ipv4 veth nft_chain_nat xt_nat 
nf_nat xt_set xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables 
crc32c_generic ip_set_hash_net ip_set_hash_ip ip_set nfnetlink bridge stp llc essiv authenc ast 
drm_vram_helper drm_ttm_helper ttm ofpart ipmi_powernv powernv_flash ipmi_devintf drm_kms_helper 
ipmi_msghandler mtd opal_prd syscopyarea sysfillrect sysimgblt fb_sys_fops i2c_algo_bit sg at24 
regmap_i2c binfmt_misc drm fuse sunrpc drm_panel_orientation_quirks configfs ip_tables x_tables 
autofs4 xxhash_generic btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq 
async_xor async_tx xor hid_generic usbhid hid raid6_pq libcrc32c raid1 raid0 multipath linear md_mod 
usb_storage dm_crypt dm_mod algif_skcipher af_alg sd_mod xhci_pci xhci_hcd xts ecb ctr nvme 
vmx_crypto gf128mul
[1221122.410840]  crc32c_vpmsum tg3 mpt3sas nvme_core t10_pi usbcore libphy crc64_rocksoft_generic 
crc64_rocksoft crc_t10dif crct10dif_generic raid_class crc64 crct10dif_common ptp pps_core 
usb_common scsi_transport_sas
[1221122.410854] CPU: 37 PID: 1135142 Comm: kworker/u128:0 Tainted: G        W 
6.1.0-0.deb11.7-powerpc64le #1  Debian 6.1.20-2~bpo11+1a~test
[1221122.410857] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[1221122.410858] Workqueue: btrfs-cache btrfs_work_helper [btrfs]
[1221122.410879] NIP:  c00800000f6d0160 LR: c00800000f6d0148 CTR: c000000000d871c0
[1221122.410881] REGS: c0000000621f36c0 TRAP: 0700   Tainted: G        W 
(6.1.0-0.deb11.7-powerpc64le Debian 6.1.20-2~bpo11+1a~test)
[1221122.410883] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 2800228e  XER: 00000000
[1221122.410893] CFAR: c00800000f7805c8 IRQMASK: 0
                  GPR00: c00800000f6d0148 c0000000621f3960 c00800000f7ea800 0000000000000001
                  GPR04: 0000000000000000 0000000000000014 0000000000000000 0000000000000000
                  GPR08: 0000000000000014 0000000000000001 0000000000000000 c00800000f7961d8
                  GPR12: c000000000d871c0 c000200fff7f8600 c0000000001705a8 0000000000000000
                  GPR16: 0000267371d00000 0000000040000000 c00020018e253000 0000000000200000
                  GPR20: 0000000000000700 c0000000027391a8 00002673a347c000 c0002001e9aff870
                  GPR24: 0000000000000000 00000000000006b9 c000000ab5575000 c00020002593b000
                  GPR28: 0000000000000000 c000000ab5575000 c00c00000100f980 c0002008ad7ac848
[1221122.410926] NIP [c00800000f6d0160] assert_eb_page_uptodate+0x88/0x160 [btrfs]
[1221122.410947] LR [c00800000f6d0148] assert_eb_page_uptodate+0x70/0x160 [btrfs]
[1221122.410967] Call Trace:
[1221122.410968] [c0000000621f3960] [c00800000f6d0148] assert_eb_page_uptodate+0x70/0x160 [btrfs] 
(unreliable)
[1221122.410989] [c0000000621f39a0] [c00800000f6d8d84] extent_buffer_test_bit+0x5c/0xb0 [btrfs]
[1221122.411010] [c0000000621f39e0] [c00800000f7632c4] free_space_test_bit+0xac/0x100 [btrfs]
[1221122.411030] [c0000000621f3a40] [c00800000f7668e4] load_free_space_tree+0x1fc/0x570 [btrfs]
[1221122.411049] [c0000000621f3b50] [c00800000f773214] caching_thread+0x41c/0x690 [btrfs]
[1221122.411068] [c0000000621f3c20] [c00800000f6ec24c] btrfs_work_helper+0x154/0x518 [btrfs]
[1221122.411089] [c0000000621f3ca0] [c000000000162d68] process_one_work+0x2a8/0x580
[1221122.411093] [c0000000621f3d40] [c0000000001630d8] worker_thread+0x98/0x5e0
[1221122.411096] [c0000000621f3dc0] [c0000000001706c0] kthread+0x120/0x130
[1221122.411099] [c0000000621f3e10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
[1221122.411102] Instruction dump:
[1221122.411103] 80df0008 e8bf0000 7fc4f378 7c7c1b78 7fa3eb78 480b03bd 60000000 2c3c0000
[1221122.411110] 39200000 4082000c 68630001 5469063e <0b090000> e8010050 eb810020 ebe10038
[1221122.411118] ---[ end trace 0000000000000000 ]---
[1221122.411123] page=73825584873472 uptodate=1 error=0 dirty=0 start=73825584889856 len=16384 bitmaps=
[1221122.411126] subpage offsets: uptodate=0 error=16 dirty=32 writeback=48
[1221158.734218] BTRFS info (device dm-2): balance: canceled
[1221158.734238] ------------[ cut here ]------------
[1221158.734240] BTRFS: Transaction aborted (error -22)
[1221158.734299] WARNING: CPU: 34 PID: 1181127 at fs/btrfs/extent-tree.c:4122 
find_free_extent+0x1d94/0x1e00 [btrfs]
[1221158.734349] Modules linked in: xt_tcpudp wireguard libchacha20poly1305 libcurve25519_generic 
libchacha libpoly1305 ip6_udp_tunnel udp_tunnel ipt_REJECT nf_reject_ipv4 veth nft_chain_nat xt_nat 
nf_nat xt_set xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables 
crc32c_generic ip_set_hash_net ip_set_hash_ip ip_set nfnetlink bridge stp llc essiv authenc ast 
drm_vram_helper drm_ttm_helper ttm ofpart ipmi_powernv powernv_flash ipmi_devintf drm_kms_helper 
ipmi_msghandler mtd opal_prd syscopyarea sysfillrect sysimgblt fb_sys_fops i2c_algo_bit sg at24 
regmap_i2c binfmt_misc drm fuse sunrpc drm_panel_orientation_quirks configfs ip_tables x_tables 
autofs4 xxhash_generic btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq 
async_xor async_tx xor hid_generic usbhid hid raid6_pq libcrc32c raid1 raid0 multipath linear md_mod 
usb_storage dm_crypt dm_mod algif_skcipher af_alg sd_mod xhci_pci xhci_hcd xts ecb ctr nvme 
vmx_crypto gf128mul
[1221158.734483]  crc32c_vpmsum tg3 mpt3sas nvme_core t10_pi usbcore libphy crc64_rocksoft_generic 
crc64_rocksoft crc_t10dif crct10dif_generic raid_class crc64 crct10dif_common ptp pps_core 
usb_common scsi_transport_sas
[1221158.734512] CPU: 34 PID: 1181127 Comm: btrfs-balance Tainted: G        W 
6.1.0-0.deb11.7-powerpc64le #1  Debian 6.1.20-2~bpo11+1a~test
[1221158.734519] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[1221158.734522] NIP:  c00800000f6784fc LR: c00800000f6784f8 CTR: c000000000d746c0
[1221158.734525] REGS: c0000000051bf230 TRAP: 0700   Tainted: G        W 
(6.1.0-0.deb11.7-powerpc64le Debian 6.1.20-2~bpo11+1a~test)
[1221158.734530] MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 28848282  XER: 20040000
[1221158.734546] CFAR: c000000000135110 IRQMASK: 0
                  GPR00: c00800000f6784f8 c0000000051bf4d0 c00800000f7ea800 0000000000000026
                  GPR04: 0000000100a50864 c0000000051bf290 c0000000051bf288 0000000000000027
                  GPR08: c000200ffba47f98 c000000002127f90 ffffffffffffffd8 0000000058e032e8
                  GPR12: 0000000028848282 c000200fff7fd900 0000000000000000 c000000ab5575000
                  GPR16: c0002000129db050 c0000000051bf7a7 0000000000000000 0000000000000000
                  GPR20: 0000000000000000 0000000000000001 c0002000088a99f8 0000000000000001
                  GPR24: 0000000000000000 c000000023d6b0d0 c0000000051bf7a7 c00020018e252000
                  GPR28: c000000023d6b000 c000000ab5575000 ffffffffffffffea 0000000000000001
[1221158.734605] NIP [c00800000f6784fc] find_free_extent+0x1d94/0x1e00 [btrfs]
[1221158.734635] LR [c00800000f6784f8] find_free_extent+0x1d90/0x1e00 [btrfs]
[1221158.734664] Call Trace:
[1221158.734666] [c0000000051bf4d0] [c00800000f6784f8] find_free_extent+0x1d90/0x1e00 [btrfs] 
(unreliable)
[1221158.734698] [c0000000051bf5c0] [c00800000f681398] btrfs_reserve_extent+0x1a0/0x2f0 [btrfs]
[1221158.734730] [c0000000051bf730] [c00800000f681bf0] btrfs_alloc_tree_block+0x108/0x670 [btrfs]
[1221158.734761] [c0000000051bf880] [c00800000f66bd68] __btrfs_cow_block+0x170/0x850 [btrfs]
[1221158.734792] [c0000000051bf990] [c00800000f66c58c] btrfs_cow_block+0x144/0x288 [btrfs]
[1221158.734822] [c0000000051bfa40] [c00800000f67113c] btrfs_search_slot+0x6b4/0xcb0 [btrfs]
[1221158.734852] [c0000000051bfb30] [c00800000f6dc570] reset_balance_state+0x108/0x290 [btrfs]
[1221158.734890] [c0000000051bfbe0] [c00800000f6e2f7c] btrfs_balance+0x1164/0x1500 [btrfs]
[1221158.734928] [c0000000051bfd80] [c00800000f6e33b0] balance_kthread+0x98/0x190 [btrfs]
[1221158.734966] [c0000000051bfdc0] [c0000000001706c0] kthread+0x120/0x130
[1221158.734975] [c0000000051bfe10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
[1221158.734981] Instruction dump:
[1221158.734984] 3b00ffe4 e8898828 481175f5 60000000 4bfff4fc 3be00000 4bfff570 3d220000
[1221158.734996] 7fc4f378 e8698830 4811cd95 e8410018 <0fe00000> f9c10060 f9e10068 fa010070
[1221158.735008] ---[ end trace 0000000000000000 ]---
[1221158.735017] BTRFS: error (device dm-2: state A) in find_free_extent_update_loop:4122: errno=-22 
unknown
[1221158.735048] BTRFS info (device dm-2: state EA): forced readonly
[1221158.735055] BTRFS: error (device dm-2: state EA) in reset_balance_state:3599: errno=-22 unknown
