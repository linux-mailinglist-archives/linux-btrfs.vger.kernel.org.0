Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832AE6F6446
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 07:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEDFJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 01:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDFJJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 01:09:09 -0400
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6FBB1BEB
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 22:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1683175261; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=1u0jKD4/dmOTweANiAcPil6bITkb57/iSGszJwqZzDc=; b=ES3kMELxDmXTf
        8KmYflUemqPqAiW00X8kmIwux1WUdltmYZcRo1N4s7HOyC50bWr8LPpf2wGBfvAovu0eX2ONc63tK
        04/lrnbzyh7i5moGp57NHHrM3jnm78iQqHXS+atRR8T4jWlEQiR7HRdlUVG14SymoLH3WA68iGkVs
        9i1C5N+ZOpbddYA3D4HD5WKlUC5illfAyxQ94vyjyHbNGPH0rDYpD7MJjFS2XimDkgboPdnKg0N3v
        9gfHRgwBcew/ZtDIje5Tuw6tozzl7AybSPw/CSadCGOKkAMql1kNGUiql4770Qn6dt2NTvgcCZH+y
        Xl+grpxsq8kcTeL/9fRlw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1683175263; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=1u0jKD4/dmOTweANiAcPil6bITkb57/iSGszJwqZzDc=; b=GV4K5AKejGGdKHWNZNHnOyBvel
        RaFl95e5Wh6v0mJdT5s3noV9TSGqB6+zhOwPm00+dfq6SD4s1aygV5hcW66j6DewjDYbzK1rBNp2H
        YnYkMW5PaBSkPo1Jv4lIHLe9p7+IOG9bgFlQrt9WX8BgUTDTUAE+WmYMHbgDdLn7Uk6zDPluFZIj2
        niHgGPCJ+iBah/if7/O3rMMKUnYhq6MBsEwVVb6J1O0qKKVx+esn7H15WVzvvN1Or6M5Edj7unLxQ
        82Q5JqsgIA1FC9sAbIpGYn58klrq6Nydkh0I/LE5E9XYmMTxcQGdKMn/U6kkWs2VcSf3i5gITzc/g
        P6vVn3Hg==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1puRDF-00D65Q-35;
        Thu, 04 May 2023 05:09:06 +0000
Message-ID: <49b00dcd-4902-1bdf-f11e-1ddc04533b8b@bluematt.me>
Date:   Wed, 3 May 2023 22:09:06 -0700
MIME-Version: 1.0
Subject: Re: 6.1 Replacement warnings and papercuts
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <4f31977d-9e32-ae10-64fd-039162874214@bluematt.me>
 <2a832a70-2665-eb9e-5b66-e4a3595567e9@bluematt.me>
 <62b9ea2c-c8a3-375f-ed21-d4a9d537f369@gmx.com>
 <2554e872-91b0-849d-5b24-ccb47498983a@bluematt.me>
 <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/3/23 9:46 PM, Matt Corallo wrote:
> 
> 
> On 5/1/23 8:41 AM, Matt Corallo wrote:
>>
>>
>> On 4/30/23 9:40 PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/5/1 10:24, Matt Corallo wrote:
>>>> Oh, one more replace papercut, its probably worth noting `btrfs scrub status` generally shows 
>>>> gibberish when a replace is running - it appears to show the progress assuming all disks but the 
>>>> one being replaced had already been scrubbed, shows a start date of the last time a scrub was 
>>>> run, etc.
>>>>
>>>> On 4/29/23 11:10 PM, Matt Corallo wrote:
>>>>> Just starting a drive replacement after a disk failure on 6.1.20 (Debian 6.1.20-2~bpo11+1), 
>>>>> immediately after an unrelated power failure, and I got a flood of warnings about free space 
>>>>> tree like the below.
>>>>>
>>>>> Presumably unrelatedly, I can't remount the array, I assume because the device "thats mounted" 
>>>>> is the one being replace:
>>>
>>> When the mount failed, please provide the dmesg of that failure.
>>
>> There's no output in dmesg, only the mount output below. This issue actually persisted after the 
>> replace completed. Scrub seemed fine (can't offline the array atm), but `mount -o remount,noatime 
>> /a/device/in/the/array /bigraid` worked just fine (after replace finished, though I assume it 
>> would have worked prior as well.
>>
>>> And furthermore, btrfs check --readonly output please.
> 
> A scrub completed successfully, so presumably there's no hidden corruption.
> 
> Then went to go run a check as requested and on unmount BTRFS complained ten or twenty times about
> 
> BTRFS warning (device dm-2): folio private not zero on folio .....
> 
> then btrfs check passed at least through the free space tree:
> 
> # btrfs check --readonly --progress /dev/mapper/bigraid21_crypt
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/bigraid21_crypt
> UUID: e2843f83-aadf-418d-b36b-5642f906808f
> [1/7] checking root items                      (1:27:21 elapsed, 435001145 items checked)
> [2/7] checking extents                         (9:00:58 elapsed, 45476517 items checked)
> [3/7] checking free space tree                 (1:32:56 elapsed, 29259 items checked)
> ^C/7] checking fs roots                        (0:01:08 elapsed, 12246 items checked)

Also worth mentioning, since the WARN_ON below is in the subpage code, that this is a subpage mount 
(but I guess you guessed that if you saw its ppc or by looking at the line referenced).

Thanks,
Matt

>>> Thanks,
>>> Qu
>>>
>>>>>
>>>>> $ sudo mount -o remount,noatime /bigraid
>>>>> mount: /bigraid: can't find UUID=bde0d0ab-31e6-47b8-8d7f-eef17af4f37e.
>>>>>
>>>>>
>>>>> [  960.116341] ------------[ cut here ]------------
>>>>> [  960.116343] WARNING: CPU: 52 PID: 6648 at fs/btrfs/extent_io.c:5301 
>>>>> assert_eb_page_uptodate+0x80/0x140 [btrfs]
>>>>> [  960.116364] Modules linked in: xt_tcpudp ipt_REJECT nf_reject_ipv4 veth wireguard 
>>>>> libchacha20poly1305 libcurve25519_generic libchacha libpoly1305 ip6_udp_tunnel udp_tunnel 
>>>>> nft_chain_nat xt_nat nf_nat xt_set xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 
>>>>> nf_defrag_ipv4 nft_compat nf_tables crc32c_generic ip_set_hash_net ip_set_hash_ip essiv authenc 
>>>>> ip_set nfnetlink bridge stp llc ofpart ast drm_vram_helper drm_ttm_helper ipmi_powernv 
>>>>> powernv_flash ipmi_devintf ttm mtd ipmi_msghandler opal_prd sg drm_kms_helper syscopyarea 
>>>>> sysfillrect sysimgblt fb_sys_fops at24 i2c_algo_bit regmap_i2c binfmt_misc drm fuse 
>>>>> drm_panel_orientation_quirks sunrpc configfs ip_tables x_tables autofs4 xxhash_generic btrfs 
>>>>> zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor 
>>>>> raid6_pq libcrc32c raid1 raid0 multipath linear md_mod usb_storage dm_crypt dm_mod 
>>>>> algif_skcipher af_alg sd_mod xhci_pci xts ecb xhci_hcd nvme ctr tg3 vmx_crypto gf128mul 
>>>>> crc32c_vpmsum nvme_core t10_pi
>>>>> [  960.116436]  mpt3sas libphy crc64_rocksoft_generic crc64_rocksoft usbcore crc_t10dif ptp 
>>>>> crct10dif_generic crc64 crct10dif_common raid_class pps_core usb_common scsi_transport_sas
>>>>> [  960.116447] CPU: 52 PID: 6648 Comm: kworker/u128:13 Tainted: G        W 
>>>>> 6.1.0-0.deb11.7-powerpc64le #1  Debian 6.1.20-2~bpo11+1
>>>>> [  960.116450] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
>>>>> [  960.116451] Workqueue: btrfs-cache btrfs_work_helper [btrfs]
>>>>> [  960.116473] NIP:  c00800000f4e0158 LR: c00800000f4e0148 CTR: c000000000d871c0
>>>>> [  960.116474] REGS: c0002001f47036c0 TRAP: 0700   Tainted: G        W 
>>>>> (6.1.0-0.deb11.7-powerpc64le Debian 6.1.20-2~bpo11+1)
>>>>> [  960.116476] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 2800288a  XER: 00000000
>>>>> [  960.116485] CFAR: c00800000f4e01e8 IRQMASK: 0
>>>>>                 GPR00: c00800000f4e0148 c0002001f4703960 c00800000f5fa800 0000000000000001
>>>>>                 GPR04: 0000000000000000 000000000000001c 0000000000000000 0000000000000000
>>>>>                 GPR08: 000000000000001c 0000000000000001 0000000000000000 c00800000f5a6068
>>>>>                 GPR12: c000000000d871c0 c000200fff6e7380 c0000000001705a8 0000000000000000
>>>>>                 GPR16: 000027f9b1d00000 0000000040000000 c00000001821a800 0000000000200000
>>>>>                 GPR20: 0000000000002118 c0000000027391a8 000027f9c14c8000 c00000001a3ec0f0
>>>>>                 GPR24: 0000000000060000 00000000000004f5 c000200011cbf000 c0002000cac1a000
>>>>>                 GPR28: c0002000cac1a000 c000200011cbf000 c00c000000c61880 0000000000000000
>>>>> [  960.116519] NIP [c00800000f4e0158] assert_eb_page_uptodate+0x80/0x140 [btrfs]
>>>>> [  960.116539] LR [c00800000f4e0148] assert_eb_page_uptodate+0x70/0x140 [btrfs]
>>>>> [  960.116558] Call Trace:
>>>>> [  960.116559] [c0002001f4703960] [c00800000f4e0148] assert_eb_page_uptodate+0x70/0x140 [btrfs] 
>>>>> (unreliable)
>>>>> [  960.116579] [c0002001f47039a0] [c00800000f4e8d64] extent_buffer_test_bit+0x5c/0xb0 [btrfs]
>>>>> [  960.116600] [c0002001f47039e0] [c00800000f5732a4] free_space_test_bit+0xac/0x100 [btrfs]
>>>>> [  960.116619] [c0002001f4703a40] [c00800000f5768c4] load_free_space_tree+0x1fc/0x570 [btrfs]
>>>>> [  960.116638] [c0002001f4703b50] [c00800000f5831f4] caching_thread+0x41c/0x690 [btrfs]
>>>>> [  960.116656] [c0002001f4703c20] [c00800000f4fc22c] btrfs_work_helper+0x154/0x518 [btrfs]
>>>>> [  960.116679] [c0002001f4703ca0] [c000000000162d68] process_one_work+0x2a8/0x580
>>>>> [  960.116682] [c0002001f4703d40] [c0000000001630d8] worker_thread+0x98/0x5e0
>>>>> [  960.116686] [c0002001f4703dc0] [c0000000001706c0] kthread+0x120/0x130
>>>>> [  960.116689] [c0002001f4703e10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
>>>>> [  960.116691] Instruction dump:
>>>>> [  960.116693] 60000000 80df0008 e8bf0000 7fc4f378 7c691b78 7fa3eb78 7d3f4b78 480b039d
>>>>> [  960.116702] 60000000 39200000 2c3f0000 4182008c <0b090000> e8010050 ebe10038 38210040
>>>>> [  960.116709] ---[ end trace 0000000000000000 ]---
