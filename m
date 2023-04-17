Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4366E46B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 13:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjDQLo4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDQLow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 07:44:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F4E5
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 04:43:51 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDou-1qYmio15z6-00xcdG; Mon, 17
 Apr 2023 13:37:23 +0200
Message-ID: <225b296a-8618-2788-da7b-f629d1d0d343@gmx.com>
Date:   Mon, 17 Apr 2023 19:37:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Otto Strassen <otto@tostr.ch>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <sY9YYJrpztwzxhv_9p28An7hkWNiF8hHF0we0ToIQ69b3lpaeBc7l77Kd4jYdsXA6Rps73Xa3guq3XA8c3mZdxDIvSwO5Cyh2eeO5Aqh3-s=@tostr.ch>
 <c3bf3d9d-9be4-713f-64b8-769d2a014d1a@gmx.com>
 <BWQf5N5kpHk5W540zTSqzDYn2kLi7lwJt-3odaRz1xs751TcwplGjnVGU-ytnar_lcoaKZHghhONSHAdSPtC98yyq52HXIUTCq1x65RWGwU=@tostr.ch>
 <fb3714a3-ab30-30b0-f336-68e2717b20d8@gmx.com>
 <vU62kpQ14yw_mYWcogz5KZy0j0wZ_1bNBQnJvvc-zqlqZAYpjFderRCnigBCG3F2Sv5g9PKexYTf9_dO8H1OxDkQQg1Vlz4UZzMmkwsx7Z0=@tostr.ch>
 <974217d6-0246-3732-0fe5-e443c8158edc@gmx.com>
 <OIBWDuFqZbh7w1v3A2Nxs13HKeULqY96iN3so8KdD5YfpqhzoxglwFYxQj7rS2f2tnz9jMkJFzl4w4jTVSRzw9wuLKCyMv_gkn17caOy1H0=@tostr.ch>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Filesystem ro mode, check shows a lot of missing backrefs, no
 idea on how to proceed
In-Reply-To: <OIBWDuFqZbh7w1v3A2Nxs13HKeULqY96iN3so8KdD5YfpqhzoxglwFYxQj7rS2f2tnz9jMkJFzl4w4jTVSRzw9wuLKCyMv_gkn17caOy1H0=@tostr.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WO4AJycJCD3joQi9zW9tgmV+9Q6jCuRlNQVaaPdPU/0GH1Eu/lc
 KnQG+StccGj8THU2BhGvwiW8IbEHQTvj2+a6159cvy2EmWXI79JI+xusMZzG3/AIHnP3K15
 zk2AEZnUeZAqfS6CitVXqeqdzs4HA3+mICK4+MbQqW9uhkNVAXY9+u6HpIHb4lNms7iwbTS
 ArONcJjYpZ5x2cW91p6Vw==
UI-OutboundReport: notjunk:1;M01:P0:gnz6d+eisrc=;GKQEDyxbRzgwkHXvNTFTIBfT2Jd
 074G10SpdKIntIYgozqPjbeU254wH3cxG8fO2vVfgoGArJZrTlgd4ERIOXVh4uqD75Tctlyfa
 d2ugtPvX+8MdMKLSI9LRmN/ZShCUAcyN6g+ThRkVSKTmdtALD3I25K+IQAOC66iuYiEY6vFk3
 tV6X+LZKpqRtPkFKI7tHGuCX5FgP89ejcqY9x+ohGLgRH6MnFEty0GZuOij+FxJM9Uw7X7VRv
 zy+7gGvSLbgplwkS6Rb4lUQFC43Aiu0Qb9EOIKNAB2Q9tPoX+PpNBaeaKUEgoZA8zGd/eaIkb
 T2aIEiA4H0hiUvyJscUUgb5dj1m1MQL0EqB5o/Q+gnEUoIxpQEsn+DomSV8xCek2+cG87Zu0Q
 zVWTALKy978vsU2Z6PNZeNJfWRQeDVmwn5f9hrJ8FTgvSSLX8ZpiXGWmModmogkbyeeGVPyEQ
 arsLO5OkGv/nx2GNuPl0AXWsIazvHsPY6AfXJtWpyrPgeqOlAIIsaogC5btelIPmTg1JS00JL
 CRD/5U43/ZGAbZVULVp1F5ottC5iFqQ16Zfb3YucLtdubS7g5APBBKKTh94/vCWQCyio9uBCf
 oIkbQQMcaFYB2YTm+n6JkkyjmxORnNaA0ugbwkGMKNyQ0H6MaPOaHLuEZMVtdS3RQj4VB89Po
 xVkO+/AmNxbaohEqV2M9La1lfimihJPo5MY/zbOTXJwTW8DlrpM14fEE0V1swSjLYP+LwG0YY
 q6cvRkmxrzjroKNXnVQaWQVrgFeRLCp518DOgkoN0H1xiEqWZecOw/16zz3ZcQo/NNQVSAgz0
 foQORPK2/GJ4ueXrD+zDYhtqDRAUcMAZrBVVrgjG6zgxfSBWwg5JZo+8U1OFtrD9Bou5OyQTB
 Bv+4RZyaWKdio4KjorbnAHc/jORSpZ78xBTn6dtZANqd7ov+de0Rif8WnfOwJDsZrUP1sdUIg
 DYZWmb+h6gmdmKaa/zr7mOynSdc=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/17 19:16, Otto Strassen wrote:
> ------- Original Message -------
> On Monday, April 17th, 2023 at 12:54, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
[...]
>> What's the dmesg of the RO flipping?
> 
> All logs are filtered 'grep -i btrfs' and limited to today.
> 
> This is the dmesg
> 
> [   34.596250] systemd[1]: Created slice BTRFS Optimization.
> [   34.606240] systemd[1]: Starting BTRFS Optimization.
> [   34.657037] systemd[1]: Created slice BTRFS Space Reclaim.
> [   34.667201] systemd[1]: Starting BTRFS Space Reclaim.
> [   46.361813] Btrfs loaded, crc32c=crc32c-intel
> [   46.366895] BTRFS: device label 2022.05.04-10:06:00 v42218 devid 1 transid 240742 /dev/mapper/cachedev_0
> [   46.376657] BTRFS: device label 2022.05.04-10:06:47 v42218 devid 1 transid 23878 /dev/mapper/cachedev_1
> [   46.386638] BTRFS info (device dm-3): enabling auto syno reclaim space
> [   46.393174] BTRFS info (device dm-3): use ssd allocation scheme
> [   46.399103] BTRFS info (device dm-3): using free block group cache tree
> [   46.405723] BTRFS info (device dm-3): has skinny extents
> [   46.411064] BTRFS info (device dm-4): enabling auto syno reclaim space
> [   46.417592] BTRFS info (device dm-4): use ssd allocation scheme
> [   46.423517] BTRFS info (device dm-4): using free space tree
> [   46.429095] BTRFS info (device dm-4): using free block group cache tree

This is not something upstream supported.


> [   46.435711] BTRFS info (device dm-4): has skinny extents
> [   46.531776] BTRFS info (device dm-4): BTRFS: root of syno feature tree is null

So is the whatever the "syno feature tree".

It looks like most of your fs should already be fine, but Synology has 
implemented something proprietary, and that's blocking the proper mount.

I'm not sure if Synology is properly fixing their trees during "btrfs 
check --repair", but this is already something upstream can not help.

If you can find a way to move the disks to other non-Synology systems, 
we may be able to help (without using whatever Synology special features).

But for now, I don't think upstream can help at all for the proprietary 
downstream features.

Thanks,
Qu
> [   46.564148] WARNING: CPU: 0 PID: 11955 at fs/btrfs/disk-io.c:3314 open_ctree+0x2fc3/0x3350 [btrfs]()
> [   46.573288] Modules linked in: btrfs ecryptfs zstd_decompress zstd_compress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq leds_lp3943 aesni_intel glue_helper lrw gf128mul openvswitch zram gre ablk_helper nf_defrag_ipv6 bnxt_en(O) nf_conntrack v1000_synobios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atlantic_v2(O) atlantic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flashcache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq_performance
> [   46.723067]  [<ffffffffa10fe4d3>] open_ctree+0x2fc3/0x3350 [btrfs]
> [   46.729255]  [<ffffffffa10ca642>] btrfs_mount+0xaf2/0xc60 [btrfs]
> [   46.763310]  [<ffffffffa10c9ce9>] btrfs_mount+0x199/0xc60 [btrfs]
> [   47.621353] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   47.760094] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   48.146261] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   48.166801] WARNING: CPU: 5 PID: 4188 at fs/btrfs/disk-io.c:924 btree_io_failed_hook+0x12d/0x220 [btrfs]()
> [   48.176452] Modules linked in: synoacl_vfs(PO) btrfs ecryptfs zstd_decompress zstd_compress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq leds_lp3943 aesni_intel glue_helper lrw gf128mul openvswitch zram gre ablk_helper nf_defrag_ipv6 bnxt_en(O) nf_conntrack v1000_synobios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atlantic_v2(O) atlantic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flashcache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq_performance
> [   48.286469] Workqueue: btrfs-endio-meta btrfs_endio_meta_helper [btrfs]
> [   48.335031]  [<ffffffffa10f694d>] btree_io_failed_hook+0x12d/0x220 [btrfs]
> [   48.341916]  [<ffffffffa112a5aa>] end_bio_extent_readpage+0x18a/0x910 [btrfs]
> [   48.361353]  [<ffffffffa10f5307>] end_workqueue_fn+0x27/0x40 [btrfs]
> [   48.367720]  [<ffffffffa113a496>] btrfs_worker_helper+0xc6/0x390 [btrfs]
> [   48.380179]  [<ffffffffa113a7c9>] btrfs_endio_meta_helper+0x9/0x10 [btrfs]
> [   48.392638]  [<ffffffffa113a7c0>] ? btrfs_endio_helper+0x10/0x10 [btrfs]
> [   48.453716] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   48.592300] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   48.978477] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   48.994980] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   49.010905] BTRFS error (device dm-3): failed to read block groups: -5
> [   49.034464] BTRFS: open_ctree failed
> [   49.140834] BTRFS info (device dm-3): enabling auto syno reclaim space
> [   49.147366] BTRFS info (device dm-3): use ssd allocation scheme
> [   49.153289] BTRFS info (device dm-3): using free block group cache tree
> [   49.159907] BTRFS info (device dm-3): has skinny extents
> [   49.641488] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   49.780327] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   50.166612] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   50.183130] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   50.321970] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   50.709391] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   50.725846] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   50.741774] BTRFS error (device dm-3): failed to read block groups: -5
> [   50.764722] BTRFS: open_ctree failed
> [   50.788040] BTRFS info (device dm-3): enabling auto syno reclaim space
> [   50.794578] BTRFS info (device dm-3): use ssd allocation scheme
> [   50.800503] BTRFS info (device dm-3): using free block group cache tree
> [   50.807119] BTRFS info (device dm-3): has skinny extents
> [   50.974290] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   51.112924] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   51.500803] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   51.517251] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   51.656495] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   52.042224] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   52.058747] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> [   52.074674] BTRFS error (device dm-3): failed to read block groups: -5
> [   52.096755] BTRFS: open_ctree failed
> [   52.125295] BTRFS info (device dm-3): enabling auto syno reclaim space
> [   52.131839] BTRFS info (device dm-3): use ssd allocation scheme
> [   52.137776] BTRFS info (device dm-3): disabling log replay at mount time
> [   52.144477] BTRFS info (device dm-3): using free block group cache tree
> [   52.151090] BTRFS info (device dm-3): has skinny extents
> [   52.160941] BTRFS error (device dm-3): qgroup generation mismatch, marked as inconsistent
> [   52.169325] BTRFS error (device dm-3): set inconsistent
> [   52.360887] BTRFS info (device dm-3): BTRFS: root of syno feature tree is null
> [   52.368318] BTRFS warning (device dm-3): Failed to generation mismatch for syno usage
> [  241.442261] BTRFS error (device dm-3): no_block_group must be used with ro mount option
> [  280.060783] BTRFS info (device dm-4): using free space tree
> [  280.066365] BTRFS info (device dm-4): using free block group cache tree
> 
> 
> This is the /var/log/kern.log
> 
> 2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.564148] WARNING: CPU: 0 PID: 11955 at fs/btrfs/disk-io.c:3314 open_ctree+0x2fc3/0x3350 [btrfs]()
> 2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.573288] Modules linked in: btrfs ecryptfs zstd_decompress zstd_compress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq leds_lp3943 aesni_intel glue_helper lrw gf128mul openvswitch zram gre ablk_helper nf_defrag_ipv6 bnxt_en(O) nf_conntrack v1000_synobios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atlantic_v2(O) atlantic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flashcache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq_performance
> 2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.723067]  [<ffffffffa10fe4d3>] open_ctree+0x2fc3/0x3350 [btrfs]
> 2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.729255]  [<ffffffffa10ca642>] btrfs_mount+0xaf2/0xc60 [btrfs]
> 2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.763310]  [<ffffffffa10c9ce9>] btrfs_mount+0x199/0xc60 [btrfs]
> 2023-04-17T12:01:06+02:00 Windhoek kernel: [   47.621353] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:06+02:00 Windhoek kernel: [   47.760094] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.146261] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.166801] WARNING: CPU: 5 PID: 4188 at fs/btrfs/disk-io.c:924 btree_io_failed_hook+0x12d/0x220 [btrfs]()
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.176452] Modules linked in: synoacl_vfs(PO) btrfs ecryptfs zstd_decompress zstd_compress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq leds_lp3943 aesni_intel glue_helper lrw gf128mul openvswitch zram gre ablk_helper nf_defrag_ipv6 bnxt_en(O) nf_conntrack v1000_synobios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atlantic_v2(O) atlantic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flashcache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq_performance
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.286469] Workqueue: btrfs-endio-meta btrfs_endio_meta_helper [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.335031]  [<ffffffffa10f694d>] btree_io_failed_hook+0x12d/0x220 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.341916]  [<ffffffffa112a5aa>] end_bio_extent_readpage+0x18a/0x910 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.361353]  [<ffffffffa10f5307>] end_workqueue_fn+0x27/0x40 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.367720]  [<ffffffffa113a496>] btrfs_worker_helper+0xc6/0x390 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.380179]  [<ffffffffa113a7c9>] btrfs_endio_meta_helper+0x9/0x10 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.392638]  [<ffffffffa113a7c0>] ? btrfs_endio_helper+0x10/0x10 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.453716] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.592300] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.978477] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.994980] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   49.010905] BTRFS error (device dm-3): failed to read block groups: -5
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   49.034464] BTRFS: open_ctree failed
> 2023-04-17T12:01:08+02:00 Windhoek kernel: [   49.641488] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:08+02:00 Windhoek kernel: [   49.780327] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.166612] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.183130] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.321970] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.709391] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.725846] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.741774] BTRFS error (device dm-3): failed to read block groups: -5
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.764722] BTRFS: open_ctree failed
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.974290] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.112924] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.500803] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.517251] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.656495] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   52.042224] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   52.058747] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.074674] BTRFS error (device dm-3): failed to read block groups: -5
> 2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.096755] BTRFS: open_ctree failed
> 2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.160941] BTRFS error (device dm-3): qgroup generation mismatch, marked as inconsistent
> 2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.169325] BTRFS error (device dm-3): set inconsistent
> 2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.368318] BTRFS warning (device dm-3): Failed to generation mismatch for syno usage
> 2023-04-17T12:04:21+02:00 Windhoek kernel: [  241.442261] BTRFS error (device dm-3): no_block_group must be used with ro mount option
> 
> And the /var/log/messages
> 
> 2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_eb_miss
> 2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_meta_write_pages
> 2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_data_write_pages
> 2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/write_fua
> 2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_eb_miss
> 2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_meta_write_pages
> 2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_data_write_pages
> 2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/write_fua
> 2023-04-17T11:18:01+02:00 Windhoek synostgd-volume[12576]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_eb_miss
> 2023-04-17T11:18:01+02:00 Windhoek synostgd-volume[12576]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_meta_write_pages
> 2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.564148] WARNING: CPU: 0 PID: 11955 at fs/btrfs/disk-io.c:3314 open_ctree+0x2fc3/0x3350 [btrfs]()
> 2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.573288] Modules linked in: btrfs ecryptfs zstd_decompress zstd_compress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq leds_lp3943 aesni_intel glue_helper lrw gf128mul openvswitch zram gre ablk_helper nf_defrag_ipv6 bnxt_en(O) nf_conntrack v1000_synobios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atlantic_v2(O) atlantic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flashcache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq_performance
> 2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.723067]  [<ffffffffa10fe4d3>] open_ctree+0x2fc3/0x3350 [btrfs]
> 2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.729255]  [<ffffffffa10ca642>] btrfs_mount+0xaf2/0xc60 [btrfs]
> 2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.763310]  [<ffffffffa10c9ce9>] btrfs_mount+0x199/0xc60 [btrfs]
> 2023-04-17T12:01:06+02:00 Windhoek kernel: [   47.621353] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:06+02:00 Windhoek kernel: [   47.760094] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.146261] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.166801] WARNING: CPU: 5 PID: 4188 at fs/btrfs/disk-io.c:924 btree_io_failed_hook+0x12d/0x220 [btrfs]()
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.176452] Modules linked in: synoacl_vfs(PO) btrfs ecryptfs zstd_decompress zstd_compress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq leds_lp3943 aesni_intel glue_helper lrw gf128mul openvswitch zram gre ablk_helper nf_defrag_ipv6 bnxt_en(O) nf_conntrack v1000_synobios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atlantic_v2(O) atlantic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flashcache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq_performance
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.286469] Workqueue: btrfs-endio-meta btrfs_endio_meta_helper [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.335031]  [<ffffffffa10f694d>] btree_io_failed_hook+0x12d/0x220 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.341916]  [<ffffffffa112a5aa>] end_bio_extent_readpage+0x18a/0x910 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.361353]  [<ffffffffa10f5307>] end_workqueue_fn+0x27/0x40 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.367720]  [<ffffffffa113a496>] btrfs_worker_helper+0xc6/0x390 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.380179]  [<ffffffffa113a7c9>] btrfs_endio_meta_helper+0x9/0x10 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.392638]  [<ffffffffa113a7c0>] ? btrfs_endio_helper+0x10/0x10 [btrfs]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.453716] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.592300] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.978477] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.994980] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   49.010905] BTRFS error (device dm-3): failed to read block groups: -5
> 2023-04-17T12:01:07+02:00 Windhoek spacetool[11954]: volume_mount.c:69 Fail to do [/bin/mount -t btrfs -o auto_reclaim_space,ssd,synoacl,relatime,nodev /dev/mapper/cachedev_0 /volume1]
> 2023-04-17T12:01:07+02:00 Windhoek kernel: [   49.034464] BTRFS: open_ctree failed
> 2023-04-17T12:01:08+02:00 Windhoek kernel: [   49.641488] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:08+02:00 Windhoek kernel: [   49.780327] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.166612] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.183130] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.321970] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.709391] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.725846] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.741774] BTRFS error (device dm-3): failed to read block groups: -5
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.764722] BTRFS: open_ctree failed
> 2023-04-17T12:01:09+02:00 Windhoek spacetool[12254]: volume_mount.c:69 Fail to do [/bin/mount -t btrfs -o auto_reclaim_space,ssd,synoacl,relatime,nodev, /dev/mapper/cachedev_0 /volume1]
> 2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.974290] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.112924] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.500803] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.517251] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.656495] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   52.042224] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:10+02:00 Windhoek kernel: [   52.058747] BTRFS critical (device dm-3): corrupt leaf: block=11054295220224 slot=76 extent bytenr=9957296721920 len=589824 invalid generation, have 4306501632 expect (0, 240743]
> 2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.074674] BTRFS error (device dm-3): failed to read block groups: -5
> 2023-04-17T12:01:11+02:00 Windhoek spacetool[12574]: volume_mount.c:69 Fail to do [/bin/mount -t btrfs -o auto_reclaim_space,ssd,synoacl,relatime,nodev,drop_log_tree /dev/mapper/cachedev_0 /volume1]
> 2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.096755] BTRFS: open_ctree failed
> 2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.160941] BTRFS error (device dm-3): qgroup generation mismatch, marked as inconsistent
> 2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.169325] BTRFS error (device dm-3): set inconsistent
> 2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.368318] BTRFS warning (device dm-3): Failed to generation mismatch for syno usage
> 2023-04-17T12:01:12+02:00 Windhoek synobtrfssnap[13112]: fs_btrfs_snapshot_count.c:276 Failed to setxattr on /volume1, name: user.snapcount, value: 1, strerror: Read-only file system
> 2023-04-17T12:01:12+02:00 Windhoek synobtrfssnap[13112]: fs_btrfs_snapshot_count.c:453 Fail to set Btrfs snap count of [/volume1] to 1.[0x0000 volume_mount_vol_info_enum.c:29]
> 2023-04-17T12:04:21+02:00 Windhoek kernel: [  241.442261] BTRFS error (device dm-3): no_block_group must be used with ro mount option
> 2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_eb_miss
> 2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_meta_write_pages
> 2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_data_write_pages
> 2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/write_fua
> 2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_eb_miss
> 2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_meta_write_pages
> 2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_data_write_pages
> 2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/write_fua
> 2023-04-17T12:05:14+02:00 Windhoek synostgd-volume[13227]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_eb_miss
> 2023-04-17T12:05:14+02:00 Windhoek synostgd-volume[13227]: Failed to fopen /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_meta_write_pages
> 
> 
> Thanks and best
> Otto
> 
> 
>>
> 
>> Thanks,
>> Qu
>>
> 
>>> Thanks and best
>>> Otto
>>>
> 
>>>> If it doesn't work, go the rebuild as planned.
>>>> But if it works, you saved a lot of time and should be able to use the
>>>> fs without any problem (as long as btrfs check --readonly returns no error).
>>>> <snip>
