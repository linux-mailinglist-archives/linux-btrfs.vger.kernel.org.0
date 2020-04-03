Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2D19D812
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbgDCN5D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 3 Apr 2020 09:57:03 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:36164 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390883AbgDCN5D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Apr 2020 09:57:03 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id C1ACC5FF9E;
        Fri,  3 Apr 2020 13:57:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id nzvGUdDl1q3E; Fri,  3 Apr 2020 13:56:58 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-46-244-252-139.dynamic.mnet-online.de [46.244.252.139])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Fri,  3 Apr 2020 13:56:58 +0000 (UTC)
Message-ID: <8a6a94ea37db805426575fdbec6df342dc00ff03.camel@scientia.net>
Subject: Re: Btrfs transid corruption (and a possible bug when doing scrub
 on ro device)
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Date:   Fri, 03 Apr 2020 15:56:57 +0200
In-Reply-To: <96081d73-5426-0b4e-0fd8-9eac83b06b1b@toxicpanda.com>
References: <800B6BF0-64AA-45F5-A539-9D2868C2835C@scientia.net>
         <a8a1e614-d5f0-d4b6-2f0b-626a34761758@toxicpanda.com>
         <2FA13CAC-C259-41BF-BA9E-F9032DFA185C@scientia.net>
         <c0e5cc1b-ddfa-270e-2934-a6470584193e@toxicpanda.com>
         <360ca434f26ced5eca6821294719c463a2dcd910.camel@scientia.net>
         <96081d73-5426-0b4e-0fd8-9eac83b06b1b@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Josef.

Thanks for your explanations.

On Thu, 2020-04-02 at 14:28 -0400, Josef Bacik wrote:
> This was just a corruption of the log tree, so it won't affect your
> actual data 
> thankfully.
> 
> As for how this happened, well we had a very long standing problem
> that I fixed 
> in 5.4 where we could mistakenly update the tree log with the wrong
> block and 
> thus get transid mismatches.  But if this happened while on a 5.5
> kernel then I 
> don't know what went wrong.  I'll go poke around and see if there's
> any other 
> related ways we could make the same mistake.

Well it seemed to have happened during the --clear-space-cache v1 ...
so maybe something is fishy there.




Also during the "recovery" works I found another possible bug... what I
did was:
1) Create an image of the SSD with the corrupted fs via dd onto an
external HDD with btrfs as fs.

2) rw-mounted the external HDD's btrfs
3) btrfs rescue zero-log <the image file>

4) ro-mounted the external HDD's btrfs
5) Set up a loop device for the SSD image file, mounted the btrfs on
the loop device's partition (actually there's a layer of dm-crypt in
between, but I guess that shouldn't matter).

6) Run btrfs scrub -rB on that mountpoint (i.e. scrub the recovered
btrfs fs within the image file on the external HDD)

7) This seemed to have actually ran for a while but then:

[  266.870236] BTRFS info (device sdb5): disk space caching is enabled
[  310.896296] usb 2-3.4: new SuperSpeed Gen 1 USB device number 4 using xhci_hcd
[  310.917580] usb 2-3.4: New USB device found, idVendor=174c, idProduct=55aa, bcdDevice= 1.00
[  310.917752] usb 2-3.4: New USB device strings: Mfr=2, Product=3, SerialNumber=1
[  310.917889] usb 2-3.4: Product: ASMT1053
[  310.917969] usb 2-3.4: Manufacturer: asmedia
[  310.918054] usb 2-3.4: SerialNumber: 123456789012
[  310.920834] usb-storage 2-3.4:1.0: USB Mass Storage device detected
[  310.921336] usb-storage 2-3.4:1.0: Quirks match for vid 174c pid 55aa: 400000
[  310.921701] scsi host4: usb-storage 2-3.4:1.0
[  311.949066] scsi 4:0:0:0: Direct-Access     ASMT     2105             0    PQ: 0 ANSI: 6
[  311.950470] sd 4:0:0:0: Attached scsi generic sg2 type 0
[  311.951786] sd 4:0:0:0: [sdc] Spinning up disk...
[  312.972204] ..................ready
[  330.382251] sd 4:0:0:0: [sdc] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
[  330.382420] sd 4:0:0:0: [sdc] 4096-byte physical blocks
[  330.382868] sd 4:0:0:0: [sdc] Write Protect is off
[  330.382979] sd 4:0:0:0: [sdc] Mode Sense: 43 00 00 00
[  330.383293] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  330.446814]  sdc: sdc1 sdc2
[  330.449601] sd 4:0:0:0: [sdc] Attached SCSI disk
[  330.665639] BTRFS: device label data-e1-meta devid 1 transid 6 /dev/sdc2 scanned by systemd-udevd (937)
[  437.752822] device-mapper: uevent: version 1.0.3
[  437.753367] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16) initialised: dm-devel@redhat.com
[  505.673435] BTRFS: device label data-e1 devid 1 transid 1399 /dev/dm-0 scanned by systemd-udevd (998)
[  558.913428] loop: module loaded
[  657.260808] BTRFS info (device dm-0): disk space caching is enabled
[  657.261047] BTRFS info (device dm-0): has skinny extents
[  772.280239]  loop0: p1 p2
[  805.426119] BTRFS info (device sdb3): disk space caching is enabled
[  805.426347] BTRFS info (device sdb3): has skinny extents
[  884.549544] BTRFS: device label system devid 1 transid 1453259 /dev/dm-1 scanned by systemd-udevd (1265)
[ 1237.467710] BTRFS info (device dm-0): disk space caching is enabled
[ 1237.484092] BTRFS info (device dm-0): has skinny extents
[ 1260.227007]  loop0: p1 p2
[ 1285.470611] BTRFS info (device sdb3): disk space caching is enabled
[ 1285.476850] BTRFS info (device sdb3): has skinny extents
[ 3103.000947] BTRFS info (device dm-1): disk space caching is enabled
[ 3103.000973] BTRFS info (device dm-1): has skinny extents
[ 3103.053189] BTRFS info (device dm-1): enabling ssd optimizations
[ 3209.105586] BTRFS info (device dm-1): disk space caching is enabled
[ 3209.105638] BTRFS info (device dm-1): has skinny extents
[ 3209.152815] BTRFS info (device dm-1): enabling ssd optimizations
[ 3230.518528] BTRFS info (device dm-1): scrub: started on devid 1
[ 3269.170542] BTRFS warning (device dm-1): Skipping commit of aborted transaction.
[ 3269.175985] ------------[ cut here ]------------
[ 3269.181325] BTRFS: Transaction aborted (error -28)
[ 3269.181519] WARNING: CPU: 2 PID: 1583 at fs/btrfs/transaction.c:1894 cleanup_transaction+0x61/0xc0 [btrfs]
[ 3269.186947] Modules linked in: loop(E) dm_crypt(E) dm_mod(E) snd_hda_codec_hdmi(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) ledtrig_audio(E) snd_soc_skl(E) snd_soc_hdac_hda(E) snd_hda_ext_core(E) i915(E) snd_soc_sst_ipc(E) intel_rapl_msr(E) intel_rapl_common(E) snd_soc_sst_dsp(E) snd_soc_acpi_intel_match(E) x86_pkg_temp_thermal(E) snd_soc_acpi(E) intel_powerclamp(E) snd_soc_core(E) btusb(E) coretemp(E) btrtl(E) btbcm(E) snd_compress(E) kvm_intel(E) btintel(E) snd_hda_intel(E) kvm(E) bluetooth(E) snd_intel_dspcfg(E) iwlwifi(E) snd_usb_audio(E) snd_hda_codec(E) uvcvideo(E) videobuf2_vmalloc(E) snd_usbmidi_lib(E) cdc_mbim(E) cdc_wdm(E) snd_hda_core(E) cfg80211(E) videobuf2_memops(E) videobuf2_v4l2(E) drbg(E) mei_wdt(E) irqbypass(E) snd_rawmidi(E) drm_kms_helper(E) intel_cstate(E) snd_seq_device(E) ansi_cprng(E) snd_hwdep(E) cdc_ncm(E) videobuf2_common(E) intel_uncore(E) videodev(E) ecdh_generic(E) usbnet(E) snd_pcm(E) iTCO_wdt(E) ecc(E) drm(E) mii(E) snd_timer(E)
[ 3269.187012]  iTCO_vendor_support(E) serio_raw(E) intel_rapl_perf(E) rfkill(E) crc16(E) snd(E) pcspkr(E) watchdog(E) sg(E) mc(E) mei_me(E) joydev(E) intel_wmi_thunderbolt(E) tpm_crb(E) evdev(E) soundcore(E) mei(E) tpm_tis(E) i2c_algo_bit(E) tpm_tis_core(E) fujitsu_laptop(E) tpm(E) sparse_keymap(E) rng_core(E) button(E) acpi_pad(E) ac(E) ip_tables(E) x_tables(E) autofs4(E) hid_generic(E) usbhid(E) hid(E) btrfs(E) blake2b_generic(E) zstd_decompress(E) zstd_compress(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_generic(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) uas(E) usb_storage(E) sd_mod(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) i2c_designware_platform(E) i2c_designware_core(E) aesni_intel(E) crypto_simd(E) cryptd(E) glue_helper(E) psmouse(E) sdhci_pci(E) e1000e(E) ahci(E) cqhci(E) libahci(E) ptp(E) sdhci(E) i2c_i801(E) pps_core(E) mmc_core(E) xhci_pci(E)
[ 3269.206367]  libata(E) xhci_hcd(E) scsi_mod(E) intel_lpss_pci(E) intel_lpss(E) idma64(E) usbcore(E) mfd_core(E) usb_common(E) wmi(E) battery(E) video(E)
[ 3269.221661] CPU: 2 PID: 1583 Comm: btrfs-transacti Tainted: G            E     5.5.0-1-amd64 #1 Debian 5.5.13-2
[ 3269.224261] Hardware name: FUJITSU LIFEBOOK U757/FJNB2A5, BIOS Version 1.21 03/19/2018
[ 3269.226812] RIP: 0010:cleanup_transaction+0x61/0xc0 [btrfs]
[ 3269.228920] Code: 77 66 f0 49 0f ba ad 28 17 00 00 02 72 1e 41 83 fc fb 75 07 0f 1f 44 00 00 eb 11 44 89 e6 48 c7 c7 88 2d 79 c0 e8 31 0b 3a f4 <0f> 0b 44 89 e1 ba 66 07 00 00 49 8d 5e 28 48 89 ef 48 c7 c6 50 65
[ 3269.231126] RSP: 0018:ffffa713c05ebde8 EFLAGS: 00010282
[ 3269.233061] RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: 0000000000000007
[ 3269.234932] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff9332fdd19a40
[ 3269.236769] RBP: ffff9332f0c99ea0 R08: 00000000000003fa R09: 0000000000000007
[ 3269.238495] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000ffffffe4
[ 3269.240217] R13: ffff9330b0b74000 R14: ffff9330d981ae00 R15: ffff9332f0c99df0
[ 3269.241920] FS:  0000000000000000(0000) GS:ffff9332fdd00000(0000) knlGS:0000000000000000
[ 3269.243654] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3269.245381] CR2: 00007f70da503070 CR3: 000000066cc0a006 CR4: 00000000003606e0
[ 3269.247091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3269.248800] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3269.250519] Call Trace:
[ 3269.252243]  btrfs_commit_transaction+0x2a8/0xa20 [btrfs]
[ 3269.253945]  ? start_transaction+0xbb/0x4c0 [btrfs]
[ 3269.255637]  transaction_kthread+0x13c/0x180 [btrfs]
[ 3269.257298]  kthread+0xf9/0x130
[ 3269.258962]  ? btrfs_cleanup_transaction+0x5c0/0x5c0 [btrfs]
[ 3269.260613]  ? kthread_park+0x90/0x90
[ 3269.262278]  ret_from_fork+0x35/0x40
[ 3269.263931] ---[ end trace 7995a24b0c8fd82a ]---
[ 3269.265580] BTRFS: error (device dm-1) in cleanup_transaction:1894: errno=-28 No space left
[ 3269.268117] BTRFS info (device dm-1): delayed_refs has NO entry
[ 3270.142115] BTRFS info (device dm-1): scrub: not finished on devid 1 with status: -125


In the past there used to be several similar bugs wrt to read-only
block devices (e.g. send from a ro-device caused a kernel trace).
So maybe another one of these bugs?


Also, the foreground btrfs-scrub seemed to not properly detect the
failure.
While it showed that only some GB or so where actually checked, it said
"Error summary:    no errors found"
which is strictly speaking correct, but obviously misleading.

It should say something like "scrub not finished, no errors found in
what was checked".

Unfortunately I've missed to check for the exit status, whether it was
non-zero.


Cheers,
Chris

