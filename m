Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD636714240
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 05:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjE2DRe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 May 2023 23:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjE2DRc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 May 2023 23:17:32 -0400
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96D0DB1
        for <linux-btrfs@vger.kernel.org>; Sun, 28 May 2023 20:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1685328061; h=Subject:From:To:From:Subject:To:Cc:Cc:Reply-To:In-Reply-To:
        References; bh=4d7BoKpm02tPBThL71EIIJX3l05fi0eymKXrbCOXExc=; b=aIIECFA5+egOP/
        mPpF1cyL4FieFQlcOvq+0GzbLl6O7jkJ5fwEd/LG4dz8FzmXBqsemh9qIDhb3CvtRgfWou1W4zbLn
        TNOTkxHnyRPh6DSe6M5a7rw8eMRIfvJPKOwq0UtjgXeP/mjPQxeBBHar88VGMYpVI552rYkrHbeQn
        civUjaRWSUqukyr0GPUEo7KoiTF5O29LIw3/Zo6j53wtnoqKj9lh6YPtns0uD7SI1yYOAat0zwFKZ
        Hx93q5YiSHuDE2+c19avfZ4RTq+C0mazt6f/YJrZAfGIFs9ChF9MVBwT1lMKBDzwOqiY77k1vKhcF
        o7Awu/Nw3XmMOEuqxqXw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1685328062; h=Subject:From:To:From:Subject:To:
        Cc:Cc:Reply-To:In-Reply-To:References;
        bh=4d7BoKpm02tPBThL71EIIJX3l05fi0eymKXrbCOXExc=; b=dF/1xemW4Vox+fMizRc/qclGWe
        znTheRM7y25p0EZxkDkEbHaX2rH0a/Qx42akFpe8AbfC1qVn3UODBsf15SjjaufuPWYUuGFjeP/dB
        EcT7BjeoTzCt3e+dyy+pE+ErjfS1KScgu5l0oWkJA9Q20s3tHcIXIqTl7pmTZez/ScfR3KASXw6kO
        7msfikUaVI32AGPFmF5W2abCGQGylkIzWPgsspRoTOBQrYAxADYF8ix0/flhDwd38ldH0ZHHLtvtx
        ycV8m5GeqgdYnl+6Dd36GtE/JYnhACij4DDsXIVGJ9VthhFcXjE8wurn+lmyN01nlJifPRShuFIvh
        we797cUQ==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q3TNy-002kz5-0P for linux-btrfs@vger.kernel.org;
        Mon, 29 May 2023 03:17:30 +0000
Message-ID: <bc26e2b2-dcb1-d4a2-771e-82c1dbf4f197@bluematt.me>
Date:   Sun, 28 May 2023 20:17:30 -0700
MIME-Version: 1.0
Content-Language: en-US
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Matt Corallo <blnxfsl@bluematt.me>
Subject: [6.1] Transaction Aborted cancelling a metadata balance
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On a subpage, ppc64el 6.1.20 spinning-rust filesystem (which was (mostly) btrfs check'ed not too 
long ago and passed scrub):


....
[1158664.424471] BTRFS info (device dm-2): relocating block group 52117042626560 flags metadata|raid1c3
[1158744.142005] BTRFS info (device dm-2): found 7188 extents, stage: move data extents
[1158769.675743] BTRFS info (device dm-2): relocating block group 52115968884736 flags metadata|raid1c3
[1158770.648131] BTRFS info (device dm-2): balance: canceled
[1158770.648155] ------------[ cut here ]------------
[1158770.648157] BTRFS: Transaction aborted (error -22)
[1158770.648205] WARNING: CPU: 43 PID: 1159593 at fs/btrfs/extent-tree.c:4122 
find_free_extent+0x1d94/0x1e00 [btrfs]
[1158770.648242] Modules linked in: xt_tcpudp wireguard libchacha20poly1305 libcurve25519_generic 
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
[1158770.648328]  crc32c_vpmsum tg3 mpt3sas nvme_core t10_pi usbcore libphy crc64_rocksoft_generic 
crc64_rocksoft crc_t10dif crct10dif_generic raid_class crc64 crct10dif_common ptp pps_core 
usb_common scsi_transport_sas
[1158770.648348] CPU: 43 PID: 1159593 Comm: btrfs Tainted: G        W 
6.1.0-0.deb11.7-powerpc64le #1  Debian 6.1.20-2~bpo11+1a~test
[1158770.648353] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[1158770.648354] NIP:  c00800000f6784fc LR: c00800000f6784f8 CTR: c000000000d746c0
[1158770.648357] REGS: c000200089afe9a0 TRAP: 0700   Tainted: G        W 
(6.1.0-0.deb11.7-powerpc64le Debian 6.1.20-2~bpo11+1a~test)
[1158770.648359] MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 28848282  XER: 20040000
[1158770.648370] CFAR: c000000000135110 IRQMASK: 0
                  GPR00: c00800000f6784f8 c000200089afec40 c00800000f7ea800 0000000000000026
                  GPR04: 00000001004820c2 c000200089afea00 c000200089afe9f8 0000000000000027
                  GPR08: c000200ffbfe7f98 c000000002127f90 ffffffffffffffd8 0000000026d6a6e8
                  GPR12: 0000000028848282 c000200fff7f3800 5deadbeef0000122 c00000002269d000
                  GPR16: c0002008c7797c40 c000200089afef17 0000000000000000 0000000000000000
                  GPR20: 0000000000000000 0000000000000001 c000200008bc5a98 0000000000000001
                  GPR24: 0000000000000000 c0000003c73088d0 c000200089afef17 c000000016d3a800
                  GPR28: c0000003c7308800 c00000002269d000 ffffffffffffffea 0000000000000001
[1158770.648404] NIP [c00800000f6784fc] find_free_extent+0x1d94/0x1e00 [btrfs]
[1158770.648422] LR [c00800000f6784f8] find_free_extent+0x1d90/0x1e00 [btrfs]
[1158770.648438] Call Trace:
[1158770.648440] [c000200089afec40] [c00800000f6784f8] find_free_extent+0x1d90/0x1e00 [btrfs] 
(unreliable)
[1158770.648457] [c000200089afed30] [c00800000f681398] btrfs_reserve_extent+0x1a0/0x2f0 [btrfs]
[1158770.648476] [c000200089afeea0] [c00800000f681bf0] btrfs_alloc_tree_block+0x108/0x670 [btrfs]
[1158770.648493] [c000200089afeff0] [c00800000f66bd68] __btrfs_cow_block+0x170/0x850 [btrfs]
[1158770.648510] [c000200089aff100] [c00800000f66c58c] btrfs_cow_block+0x144/0x288 [btrfs]
[1158770.648526] [c000200089aff1b0] [c00800000f67113c] btrfs_search_slot+0x6b4/0xcb0 [btrfs]
[1158770.648542] [c000200089aff2a0] [c00800000f679f60] lookup_inline_extent_backref+0x128/0x7c0 [btrfs]
[1158770.648559] [c000200089aff3b0] [c00800000f67b338] lookup_extent_backref+0x70/0x190 [btrfs]
[1158770.648575] [c000200089aff470] [c00800000f67b54c] __btrfs_free_extent+0xf4/0x1490 [btrfs]
[1158770.648592] [c000200089aff5a0] [c00800000f67d770] __btrfs_run_delayed_refs+0x328/0x1530 [btrfs]
[1158770.648608] [c000200089aff740] [c00800000f67ea2c] btrfs_run_delayed_refs+0xb4/0x3e0 [btrfs]
[1158770.648625] [c000200089aff800] [c00800000f699aa4] btrfs_commit_transaction+0x8c/0x12b0 [btrfs]
[1158770.648645] [c000200089aff8f0] [c00800000f6dc628] reset_balance_state+0x1c0/0x290 [btrfs]
[1158770.648667] [c000200089aff9a0] [c00800000f6e2f7c] btrfs_balance+0x1164/0x1500 [btrfs]
[1158770.648688] [c000200089affb40] [c00800000f6f8e4c] btrfs_ioctl+0x2b54/0x3100 [btrfs]
[1158770.648710] [c000200089affc80] [c00000000053be14] sys_ioctl+0x794/0x1310
[1158770.648717] [c000200089affd70] [c00000000002af98] system_call_exception+0x138/0x250
[1158770.648723] [c000200089affe10] [c00000000000c654] system_call_common+0xf4/0x258
[1158770.648728] --- interrupt: c00 at 0x7fff94126800
[1158770.648731] NIP:  00007fff94126800 LR: 0000000107e0b594 CTR: 0000000000000000
[1158770.648733] REGS: c000200089affe80 TRAP: 0c00   Tainted: G        W 
(6.1.0-0.deb11.7-powerpc64le Debian 6.1.20-2~bpo11+1a~test)
[1158770.648735] MSR:  900000000000d033 <SF,HV,EE,PR,ME,IR,DR,RI,LE>  CR: 24002848  XER: 00000000
[1158770.648744] IRQMASK: 0
                  GPR00: 0000000000000036 00007fffc9439da0 00007fff94217100 0000000000000003
                  GPR04: 00000000c4009420 00007fffc9439ee8 0000000000000000 0000000000000000
                  GPR08: 00000000803c7416 0000000000000000 0000000000000000 0000000000000000
                  GPR12: 0000000000000000 00007fff9467d120 0000000107e64c9c 0000000107e64d0a
                  GPR16: 0000000107e64d06 0000000107e64cf1 0000000107e64cc4 0000000107e64c73
                  GPR20: 0000000107e64c31 0000000107e64bf1 0000000107e64be7 0000000000000000
                  GPR24: 0000000000000000 00007fffc9439ee0 0000000000000003 0000000000000001
                  GPR28: 00007fffc943f713 0000000000000000 00007fffc9439ee8 0000000000000000
[1158770.648777] NIP [00007fff94126800] 0x7fff94126800
[1158770.648779] LR [0000000107e0b594] 0x107e0b594
[1158770.648780] --- interrupt: c00
[1158770.648782] Instruction dump:
[1158770.648784] 3b00ffe4 e8898828 481175f5 60000000 4bfff4fc 3be00000 4bfff570 3d220000
[1158770.648791] 7fc4f378 e8698830 4811cd95 e8410018 <0fe00000> f9c10060 f9e10068 fa010070
[1158770.648798] ---[ end trace 0000000000000000 ]---
[1158770.648804] BTRFS: error (device dm-2: state A) in find_free_extent_update_loop:4122: errno=-22 
unknown
[1158770.648830] BTRFS info (device dm-2: state EA): forced readonly
[1158770.648833] BTRFS: error (device dm-2: state EA) in __btrfs_free_extent:3070: errno=-22 unknown
[1158770.648869] BTRFS error (device dm-2: state EA): failed to run delayed ref for logical 
17838685708288 num_bytes 24576 type 184 action 2 ref_mod 1: -22
[1158770.648888] BTRFS: error (device dm-2: state EA) in btrfs_run_delayed_refs:2144: errno=-22 unknown
[1158770.648904] BTRFS: error (device dm-2: state EA) in reset_balance_state:3599: errno=-22 unknown
