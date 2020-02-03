Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96FCB1511C7
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 22:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBCV3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 16:29:47 -0500
Received: from mail.as397444.net ([69.59.18.99]:37708 "EHLO mail.as397444.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgBCV3q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 16:29:46 -0500
Received: from [10.233.42.100] (unknown [69.59.18.156])
        by mail.as397444.net (Postfix) with ESMTPSA id AC558192943
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2020 21:29:44 +0000 (UTC)
Subject: Re: btrfs balance start -musage=0 / eats drive space
To:     linux-btrfs@vger.kernel.org
References: <526cb529-770c-9279-aad8-7632f07832b8@bluematt.me>
 <4c85f64f-63f0-b856-68cb-9e5190af94c4@bluematt.me>
From:   Matt Corallo <linux@bluematt.me>
Message-ID: <9160dd48-3a35-bdeb-e250-ba4e178f03c5@bluematt.me>
Date:   Mon, 3 Feb 2020 21:29:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4c85f64f-63f0-b856-68cb-9e5190af94c4@bluematt.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Further, attempting to unmount the filesystem resulted in:

[267309.214453] ------------[ cut here ]------------
[267309.214485] WARNING: CPU: 43 PID: 59578 at fs/btrfs/disk-io.c:3891
btrfs_free_fs_root+0x40/0x130 [btrfs]
[267309.214486] Modules linked in: xt_tcpudp(E) binfmt_misc(E) veth(E)
xt_nat(E) wireguard(OE) essiv(E) authenc(E) ip6_udp_tunnel(E)
udp_tunnel(E) nft_counter(E) nft_chain_nat(E) xt_MASQUERADE(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_compat(E)
nf_tables(E) nfnetlink(E) btrfs(E) zstd_compress(E) zstd_decompress(E)
amdgpu(E) gpu_sched(E) snd_hda_codec_hdmi(E) ast(E) drm_vram_helper(E)
snd_hda_intel(E) ttm(E) ofpart(E) snd_hda_codec(E) drm_kms_helper(E)
powernv_flash(E) sg(E) mtd(E) snd_hda_core(E) uas(E) drm(E) snd_hwdep(E)
snd_pcm(E) tg3(E) mpt3sas(E) snd_timer(E) ipmi_powernv(E)
ipmi_devintf(E) drm_panel_orientation_quirks(E) libphy(E) snd(E)
syscopyarea(E) ipmi_msghandler(E) sysfillrect(E) sysimgblt(E)
fb_sys_fops(E) i2c_algo_bit(E) ptp(E) opal_prd(E) raid_class(E)
pps_core(E) soundcore(E) scsi_transport_sas(E) at24(E) ip_tables(E)
x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sd_mod(E)
raid10(E) raid456(E) crc32c_generic(E) libcrc32c(E)
[267309.214530]  async_raid6_recov(E) async_memcpy(E) async_pq(E)
evdev(E) hid_generic(E) usbhid(E) hid(E) raid6_pq(E) async_xor(E) xor(E)
async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E)
usb_storage(E) dm_crypt(E) dm_mod(E) algif_skcipher(E) af_alg(E)
xhci_pci(E) xhci_hcd(E) vmx_crypto(E) nvme(E) usbcore(E) nvme_core(E)
usb_common(E)
[267309.214551] CPU: 43 PID: 59578 Comm: umount Tainted: G        W  OE
    5.4.0-3-powerpc64le #1 Debian 5.4.16-1
[267309.214553] NIP:  c00800000788b258 LR: c00800000788b248 CTR:
c000000000448530
[267309.214554] REGS: c0000003e74f3750 TRAP: 0700   Tainted: G        W
 OE      (5.4.0-3-powerpc64le Debian 5.4.16-1)
[267309.214555] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
24008824  XER: 20040000
[267309.214559] CFAR: c00000000044870c IRQMASK: 0
                GPR00: c00800000788b248 c0000003e74f39e0
c0080000079e6800 0000000000000000
                GPR04: 0000000000000000 0000000000000000
0000000000000005 0000000000000000
                GPR08: 0000000000000000 0000000000000001
c000000e405ce410 c00800000796c0e0
                GPR12: c000000000448530 c000200fff7f2400
ffffffffffffffff 0000000000000000
                GPR16: 000000012501ba40 00003fffe71ed538
0000000000000000 00003fffe71ed518
                GPR20: 0000000125035014 0000000000000001
0000000000000000 0000000000000000
                GPR24: 0000000000000000 0000000000000000
0000000000000000 c000000229bdad64
                GPR28: c000000fba8d0070 c000000fba8d0000
c0000003e74f3a40 c000000ff41eb800
[267309.214581] NIP [c00800000788b258] btrfs_free_fs_root+0x40/0x130 [btrfs]
[267309.214591] LR [c00800000788b248] btrfs_free_fs_root+0x30/0x130 [btrfs]
[267309.214592] Call Trace:
[267309.214602] [c0000003e74f39e0] [c00800000788b3f8]
btrfs_drop_and_free_fs_root+0xb0/0x190 [btrfs] (unreliable)
[267309.214613] [c0000003e74f3a10] [c00800000788b67c]
btrfs_free_fs_roots+0x1a4/0x240 [btrfs]
[267309.214622] [c0000003e74f3ab0] [c00800000788debc]
close_ctree+0x194/0x410 [btrfs]
[267309.214632] [c0000003e74f3b70] [c00800000785898c]
btrfs_put_super+0x24/0x40 [btrfs]
[267309.214637] [c0000003e74f3b90] [c00000000041b564]
generic_shutdown_super+0xb4/0x1b0
[267309.214639] [c0000003e74f3c00] [c00000000041b8b8]
kill_anon_super+0x28/0x50
[267309.214647] [c0000003e74f3c30] [c00800000785a340]
btrfs_kill_super+0x28/0xf0 [btrfs]
[267309.214650] [c0000003e74f3c60] [c00000000041bff4]
deactivate_locked_super+0x74/0xf0
[267309.214652] [c0000003e74f3c90] [c000000000451738]
cleanup_mnt+0x118/0x1f0
[267309.214655] [c0000003e74f3ce0] [c000000000152724]
task_work_run+0x144/0x1a0
[267309.214658] [c0000003e74f3d30] [c00000000001f484]
do_notify_resume+0x3e4/0x440
[267309.214661] [c0000003e74f3e20] [c00000000000e430]
ret_from_except_lite+0x5c/0x60
[267309.214662] Instruction dump:
[267309.214665] 7c0802a6 fbc1fff0 fbe1fff8 7c7f1b78 f8010010 f821ffd1
e8630290 480e0e9d
[267309.214669] e8410018 e95f03d8 312affff 7d295110 <0b090000> 807f03f0
2c230000 4082009c
[267309.214674] ---[ end trace 39e70c580b2c71e1 ]---
[267326.002378] VFS: Busy inodes after unmount of dm-2. Self-destruct in
5 seconds.  Have a nice day...


On 2/3/20 9:03 PM, Matt Corallo wrote:
> Oops, forgot to mention that a full -mconvert,soft doesn't fix the
> issue, either:
> 
> [255980.528000] BTRFS info (device dm-2): balance: start
> -mconvert=raid1,soft -sconvert=raid1,soft
> .....
> [263341.880115] BTRFS info (device dm-2): 151 enospc errors during balance
> [263341.880119] BTRFS info (device dm-2): balance: ended with status: -28
> 
> On 2/3/20 8:42 PM, Matt Corallo wrote:
>> After giving up on my previous array (see "BUG_ON in btrfs check &
>> fs/btrfs/extent-tree.c:3071"), I copied 11TB of crap (including tons of
>> small files, and a few files up to eg 2TB in size) to a fresh array
>> built on 5.4.16, with a bit of duperemove in between, partially on
>> 5.4.16 and partially on 5.4.16 + "fs: allow deduplication of eof block
>> into the end of the destination file" + "Btrfs: make deduplication with
>> range including the last block work".
>>
>> I then added a second drive to the array (to finish copying), kicked it
>> back on again, and ran btrfs balance -mconvert=raid1 /path, waited for
>> the first one or two block groups, then btrfs balance cancel /path (so
>> that, I though, new metadata would be written with raid1, but old wont
>> convert until I had more IOPS available). This seems to have completely
>> borked my array's ability to balance. I trued running a few more balance
>> -mconvert=raid1,softs but it hits ENOSPC after allocating metadata block
>> groups and copying no data into them. After letting it run for a while,
>> I now have a ton of metadata blocks that are unused and I cant seem to
>> free them. bigraid2 started with around 500G of available unallocated
>> space, and now is rather limited:
>>
>> Overall:
>>     Device size:		  18.19TiB
>>     Device allocated:		  13.25TiB
>>     Device unallocated:		   4.95TiB
>>     Device missing:		     0.00B
>>     Used:			  12.23TiB
>>     Free (estimated):		   4.96TiB	(min: 2.49TiB)
>>     Data ratio:			      1.00
>>     Metadata ratio:		      1.80
>>     Global reserve:		 512.00MiB	(used: 0.00B)
>>
>> Data,single: Size:11.93TiB, Used:11.92TiB
>>    /dev/mapper/bigraid2_crypt	   8.29TiB
>>    /dev/mapper/bigraid42_crypt	   3.64TiB
>>
>> Metadata,single: Size:151.00GiB, Used:149.04GiB
>>    /dev/mapper/bigraid2_crypt	 151.00GiB
>>
>> Metadata,RAID1: Size:596.00GiB, Used:86.13GiB
>>    /dev/mapper/bigraid2_crypt	 596.00GiB
>>    /dev/mapper/bigraid42_crypt	 596.00GiB
>>
>> System,RAID1: Size:32.00MiB, Used:1.38MiB
>>    /dev/mapper/bigraid2_crypt	  32.00MiB
>>    /dev/mapper/bigraid42_crypt	  32.00MiB
>>
>> Unallocated:
>>    /dev/mapper/bigraid2_crypt	  72.97GiB
>>    /dev/mapper/bigraid42_crypt	   4.87TiB
>>
>>
>>
>> Running btrfs balance start -musage=0 /path very quickly eats drive
>> space by allocating more metadata,RAID1 blocks and then hitting enospc:
>>
>> [264158.311333] BTRFS info (device dm-2): balance: start -musage=0 -susage=0
>> [264158.443053] BTRFS info (device dm-2): relocating block group
>> 13821436493824 flags metadata|raid1
>> [264159.103628] BTRFS info (device dm-2): relocating block group
>> 13820362752000 flags metadata|raid1
>> [264160.513106] BTRFS info (device dm-2): relocating block group
>> 13818215268352 flags metadata|raid1
>> [264161.475568] BTRFS info (device dm-2): relocating block group
>> 13816067784704 flags metadata|raid1
>> [264163.174316] BTRFS info (device dm-2): relocating block group
>> 13814994042880 flags metadata|raid1
>> [264164.326509] BTRFS info (device dm-2): relocating block group
>> 13813920301056 flags metadata|raid1
>> [264165.234746] BTRFS info (device dm-2): relocating block group
>> 13812846559232 flags metadata|raid1
>> [264166.237149] BTRFS info (device dm-2): relocating block group
>> 13811772817408 flags metadata|raid1
>> [264167.282200] BTRFS info (device dm-2): relocating block group
>> 13810699075584 flags metadata|raid1
>> [264168.207370] BTRFS info (device dm-2): relocating block group
>> 13808551591936 flags metadata|raid1
>> [264169.167734] BTRFS info (device dm-2): relocating block group
>> 13807477850112 flags metadata|raid1
>> [264170.166969] BTRFS info (device dm-2): relocating block group
>> 13806404108288 flags metadata|raid1
>> [264171.114659] BTRFS info (device dm-2): relocating block group
>> 13805330366464 flags metadata|raid1
>> [264172.985116] BTRFS info (device dm-2): relocating block group
>> 13803182882816 flags metadata|raid1
>> [264174.784420] BTRFS info (device dm-2): relocating block group
>> 13801035399168 flags metadata|raid1
>> [264175.967226] BTRFS info (device dm-2): relocating block group
>> 13799961657344 flags metadata|raid1
>> [264177.252213] BTRFS info (device dm-2): relocating block group
>> 13798887915520 flags metadata|raid1
>> [264178.499955] BTRFS info (device dm-2): relocating block group
>> 13796740431872 flags metadata|raid1
>> [264179.780731] BTRFS info (device dm-2): relocating block group
>> 13795666690048 flags metadata|raid1
>> [264180.885075] BTRFS info (device dm-2): relocating block group
>> 13793519206400 flags metadata|raid1
>> [264182.089885] BTRFS info (device dm-2): relocating block group
>> 13790297980928 flags metadata|raid1
>> [264183.358970] BTRFS info (device dm-2): relocating block group
>> 13786003013632 flags metadata|raid1
>> [264184.462920] BTRFS info (device dm-2): 137 enospc errors during balance
>> [264184.462922] BTRFS info (device dm-2): balance: canceled
>>
>> (the above allocated some 100G or so in Metadata,RAID1).
>>
>>
>> Additionally, and I dont know if this was about this fs or the old,
>> broken, mounted-ro,degraded fs, but I saw this while writing:
>>
>> [245116.074467] ------------[ cut here ]------------
>> [245116.074497] WARNING: CPU: 20 PID: 474 at fs/btrfs/inode.c:9378
>> btrfs_destroy_inode+0x1c/0x288 [btrfs]
>> [245116.074498] Modules linked in: xt_tcpudp(E) binfmt_misc(E) veth(E)
>> xt_nat(E) wireguard(OE) essiv(E) authenc(E) ip6_udp_tunnel(E)
>> udp_tunnel(E) nft_counter(E) nft_chain_nat(E) xt_MASQUERADE(E) nf_nat(E)
>> nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_compat(E)
>> nf_tables(E) nfnetlink(E) btrfs(E) zstd_compress(E) zstd_decompress(E)
>> amdgpu(E) gpu_sched(E) snd_hda_codec_hdmi(E) ast(E) drm_vram_helper(E)
>> snd_hda_intel(E) ttm(E) ofpart(E) snd_hda_codec(E) drm_kms_helper(E)
>> powernv_flash(E) sg(E) mtd(E) snd_hda_core(E) uas(E) drm(E) snd_hwdep(E)
>> snd_pcm(E) tg3(E) mpt3sas(E) snd_timer(E) ipmi_powernv(E)
>> ipmi_devintf(E) drm_panel_orientation_quirks(E) libphy(E) snd(E)
>> syscopyarea(E) ipmi_msghandler(E) sysfillrect(E) sysimgblt(E)
>> fb_sys_fops(E) i2c_algo_bit(E) ptp(E) opal_prd(E) raid_class(E)
>> pps_core(E) soundcore(E) scsi_transport_sas(E) at24(E) ip_tables(E)
>> x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sd_mod(E)
>> raid10(E) raid456(E) crc32c_generic(E) libcrc32c(E)
>> [245116.074545]  async_raid6_recov(E) async_memcpy(E) async_pq(E)
>> evdev(E) hid_generic(E) usbhid(E) hid(E) raid6_pq(E) async_xor(E) xor(E)
>> async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E)
>> usb_storage(E) dm_crypt(E) dm_mod(E) algif_skcipher(E) af_alg(E)
>> xhci_pci(E) xhci_hcd(E) vmx_crypto(E) nvme(E) usbcore(E) nvme_core(E)
>> usb_common(E)
>> [245116.074566] CPU: 20 PID: 474 Comm: kswapd0 Tainted: G        W  OE
>>   5.4.0-3-powerpc64le #1 Debian 5.4.16-1
>> [245116.074568] NIP:  c0080000078aec94 LR: c000000000447bb8 CTR:
>> c0080000078aec78
>> [245116.074569] REGS: c000000ff760f580 TRAP: 0700   Tainted: G        W
>> OE      (5.4.0-3-powerpc64le Debian 5.4.16-1)
>> [245116.074570] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
>> 84048224  XER: 20040000
>> [245116.074575] CFAR: c000000000447bb4 IRQMASK: 0
>>                 GPR00: c000000000447bb8 c000000ff760f810
>> c0080000079e6800 c000000e405ce530
>>                 GPR04: 0000000000000018 0000000000000003
>> 0000000000000009 c00c000025ae0400
>>                 GPR08: 0000000ffed1d000 0000000000000001
>> c000000c6292e830 c00800000796cb30
>>                 GPR12: c0080000078aec78 c000000fffff2800
>> 0000000000000001 0000000000000001
>>                 GPR16: c000000001143be0 c000000001143bf0
>> 0000000000000000 0000000000000260
>>                 GPR20: 0000000000000000 0000000000000502
>> 0000000000000000 0000000000015bdb
>>                 GPR24: 0000000000000000 000000000004c20a
>> 0000000000000000 c000000007fff800
>>                 GPR28: c000000007fffc50 c000000e405ce530
>> c0080000079f2b00 c000000e405ce530
>> [245116.074600] NIP [c0080000078aec94] btrfs_destroy_inode+0x1c/0x288
>> [btrfs]
>> [245116.074605] LR [c000000000447bb8] destroy_inode+0x68/0xc0
>> [245116.074606] Call Trace:
>> [245116.074608] [c000000ff760f810] [c000000000447ba0]
>> destroy_inode+0x50/0xc0 (unreliable)
>> [245116.074612] [c000000ff760f840] [c000000000448290] dispose_list+0x80/0xb0
>> [245116.074614] [c000000ff760f880] [c00000000044a3a0]
>> prune_icache_sb+0x70/0xb0
>> [245116.074618] [c000000ff760f8d0] [c00000000041e6e8]
>> super_cache_scan+0x148/0x210
>> [245116.074621] [c000000ff760f940] [c00000000032f7d8]
>> do_shrink_slab+0x178/0x3b0
>> [245116.074623] [c000000ff760fa10] [c00000000032fd0c]
>> shrink_slab+0x2fc/0x4a0
>> [245116.074626] [c000000ff760faf0] [c0000000003370bc]
>> shrink_node+0x12c/0x600
>> [245116.074629] [c000000ff760fbb0] [c000000000338a84]
>> balance_pgdat+0x344/0x6b0
>> [245116.074631] [c000000ff760fce0] [c000000000339070] kswapd+0x280/0x5c0
>> [245116.074633] [c000000ff760fdb0] [c000000000155668] kthread+0x148/0x1a0
>> [245116.074638] [c000000ff760fe20] [c00000000000bd54]
>> ret_from_kernel_thread+0x5c/0x68
>> [245116.074639] Instruction dump:
>> [245116.074641] 7c0803a6 4e800020 60000000 00137b88 00000000 3c4c0013
>> 38427b88 7c0802a6
>> [245116.074646] 60000000 e9430138 312affff 7d295110 <0b090000> e94301c8
>> 312affff 7d295110
>> [245116.074651] ---[ end trace 39e70c580b2c71e0 ]---
>>
