Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF7ADDAB5
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2019 21:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfJSTaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Oct 2019 15:30:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33207 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfJSTaA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Oct 2019 15:30:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so7141802lfc.0
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Oct 2019 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VOBosncusHRbY1NeezVc+tlHf9pwKK3KLThYao/hupg=;
        b=DhlGD2xpf9MStRllTgMIdUOKOQIx8WNa0/ju5Yy0Zlca0nVkP8WGouIB3iQqPRo2dP
         gg2bgtWa8ynWMfRYtqqadcdKBYmBuqW3Ys2uXpR+XNlfKKa9MfhWTuNFtMamzgD0FSTt
         Jpik/0srTqf+abkkE4X416WooHzVsD77eCS41oKlHGutFCafh4wxVjMAPiSOFmBryUcx
         HcJrZcFUtlBZl38CHcC7VHrzjJOdM9xO5sQ4bfbsFtW0lcsaWJYJrk/MpAu2IT4D3YJd
         DuJ0DnKhJX8ZiSKojY3ojkgvVjauf4GAmq+V7EojYz31/I/Q4cSvSK5RA1b/QyKVCOmW
         NOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VOBosncusHRbY1NeezVc+tlHf9pwKK3KLThYao/hupg=;
        b=j4DQWKHolZXnteg4LbFe5N1lB/RQl2O33+xe3DGQfW62WySNNliZkvFibOonOFgN8D
         yozB7OhPpFH/FgwWLxAwvPRBc8lCPCXRQ5kp0XSeTW3GCBhtXh9WugT1VT6dFYnRdrm9
         PXmCP+BiFNIoPdKO/wxu4diQsyXRr/q8hK0YR15LwTzW67KpipvA0/iVrNQlPwzVLAoh
         27kVDyIUVLFJLytLq5xd7XhO23Z9kG73eCOZ1YMyacsDegt1lYiG3BGX+6bp+J0Rn8Zi
         XrK6yv2G8jT0NU9X5p8xHCeIY/wa89AnfuAM0Z6fI1lO/xkqQk3SZB5Y5gKG0L/s423Y
         NHLw==
X-Gm-Message-State: APjAAAWnr7S+6GIyXnYTvZGpibKqMtZF3NgPOPuoojNSRlUFdYCFiT3/
        91JrxpT/mkGj8P/3JT8xdn4GyjUHDzp9FlhacYz/3b5Nsqw=
X-Google-Smtp-Source: APXvYqzu5ij5jcNNy5rH9wkWIkRRPR084rLiZ7BPA4OlY/tLP/Jea2ZWsTuMlHBMxzNvlv97l055vsi9mF/vftH8npA=
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr9376317lfm.109.1571513397588;
 Sat, 19 Oct 2019 12:29:57 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Hjalmarsson <kanelxake@gmail.com>
Date:   Sat, 19 Oct 2019 21:29:46 +0200
Message-ID: <CALpSwpjVz=F_hb9DbVanECsfWOYog2B7SLY=Dy0NvQx=w9voDA@mail.gmail.com>
Subject: "BUG: kernel NULL pointer dereference," when unmounting filesystem
 hitted by enospc error
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

While trying to reproduce another problem I have seen with BTRFS while
running balance and raid6 I hit an issue resulting in:
BUG: kernel NULL pointer dereference, address: 00000000000002ce

I created a script trying to pinpoint the problem utilizing zram, and
the run goes like this:

1. run the scripts which sets up a "SINGEL" filesystem on two larger
devices, fills it with an adequate amount of data, and then tries to
convert it to raid6
2. the filesystem will fail to convert due to not enough space to
convert all data to raid6 (not enough space on at least 3 devices at
the same time), hitting an enospc-error
* Up until this point stuff still seems to work without crashing, and
the system seems stable, just with two different profiles fot the data
3. issue the umount command which will be "Killed", and a backtrace
will be written to dmesg

This results in a filesystem that cannot be synced, unmounted, and in
all just seems crashed.
I have ran the script 6 times. 1 time it passed, 5 times it has
crashed, and I have rebooted the computer, since that is the only way
it seems to get rid of the filesysem, so the issue seems pretty
reproducable.

The system is a laptop running Fedora 31 Beta with the latest updates,
and the latest kernel (5.3.6-300.fc31.x86_64)

Do you have any input, or any other questions or stuff you want me to test?

The script looks as follow:
-----
$ cat run-btrfs-test
modprobe -iv zram num_devices=8
udevadm trigger
sync
zramctl /dev/zram0 -s 8G && \
zramctl /dev/zram1 -s 8G && \
zramctl /dev/zram2 -s 4G && \
zramctl /dev/zram3 -s 4G && \
zramctl /dev/zram4 -s 4G && \
zramctl /dev/zram5 -s 2G && \
zramctl /dev/zram6 -s 2G && \
zramctl /dev/zram7 -s 4G && \
mkfs.btrfs /dev/zram0 && \
mkdir -p /mnt/btrfs-test && \
mount /dev/zram0 /mnt/btrfs-test && \
echo "FS Mounted" && \
btrfs dev add /dev/zram1 /mnt/btrfs-test && \
echo "Devices added" && \
for int in {1..500} ; do dd if=/dev/zero of=/mnt/btrfs-test/file${int}
bs=32M count=1 && sync ; done
btrfs dev add /dev/zram[2-7] /mnt/btrfs-test && \
btrfs fi sh /mnt/btrfs-test && \
btrfs fi df /mnt/btrfs-test && \
btrfs bal star -mconvert=raid6 /mnt/btrfs-test && \
btrfs bal star -dconvert=raid6 /mnt/btrfs-test
btrfs fi sh /mnt/btrfs-test && \
btrfs fi df /mnt/btrfs-test
=====

The output from the script, I will trim the output down to after the for-loop:
------
Label: none  uuid: 87150918-e487-4f59-994b-ccb13ee05446
Total devices 8 FS bytes used 15.64GiB
devid    1 size 8.00GiB used 8.00GiB path /dev/zram0
devid    2 size 8.00GiB used 8.00GiB path /dev/zram1
devid    3 size 4.00GiB used 0.00B path /dev/zram2
devid    4 size 4.00GiB used 0.00B path /dev/zram3
devid    5 size 4.00GiB used 0.00B path /dev/zram4
devid    6 size 2.00GiB used 0.00B path /dev/zram5
devid    7 size 2.00GiB used 0.00B path /dev/zram6
devid    8 size 4.00GiB used 0.00B path /dev/zram7

Data, single: total=15.74GiB, used=15.63GiB
System, single: total=4.00MiB, used=16.00KiB
Metadata, single: total=264.00MiB, used=17.06MiB
GlobalReserve, single: total=16.70MiB, used=0.00B
Done, had to relocate 3 out of 20 chunks
ERROR: error during balancing '/mnt/btrfs-test': No space left on device
There may be more info in syslog - try dmesg | tail
Label: none  uuid: 87150918-e487-4f59-994b-ccb13ee05446
Total devices 8 FS bytes used 15.65GiB
devid    1 size 8.00GiB used 2.99GiB path /dev/zram0
devid    2 size 8.00GiB used 2.00GiB path /dev/zram1
devid    3 size 4.00GiB used 4.00GiB path /dev/zram2
devid    4 size 4.00GiB used 4.00GiB path /dev/zram3
devid    5 size 4.00GiB used 4.00GiB path /dev/zram4
devid    6 size 2.00GiB used 2.00GiB path /dev/zram5
devid    7 size 2.00GiB used 2.00GiB path /dev/zram6
devid    8 size 4.00GiB used 4.00GiB path /dev/zram7

Data, single: total=2.00GiB, used=1.97GiB
Data, RAID6: total=14.41GiB, used=13.66GiB
System, RAID6: total=80.00MiB, used=16.00KiB
Metadata, RAID6: total=512.00MiB, used=17.52MiB
GlobalReserve, single: total=17.16MiB, used=0.00B
===

Issueing the umount:
----
# umount /mnt/btrfs-test && modprobe -rv zram
Killed
===

And last but not least: the output in dmesg:
---
[  205.960233] BTRFS info (device zram0): 2 enospc errors during balance
[  205.960235] BTRFS info (device zram0): balance: ended with status: -28
[  235.774821] BUG: kernel NULL pointer dereference, address: 00000000000002ce
[  235.774826] #PF: supervisor read access in kernel mode
[  235.774828] #PF: error_code(0x0000) - not-present page
[  235.774830] PGD 0 P4D 0
[  235.774834] Oops: 0000 [#1] SMP PTI
[  235.774838] CPU: 3 PID: 5421 Comm: umount Not tainted
5.3.6-300.fc31.x86_64 #1
[  235.774840] Hardware name: LENOVO 80JV/Lenovo U41-70, BIOS BDCN71WW
08/03/2016
[  235.774847] RIP: 0010:__free_pages+0x5/0x30
[  235.774850] Code: 00 48 89 c3 fa 66 0f 1f 44 00 00 48 89 ef 4c 89
e6 e8 2f ef ff ff 48 89 df 57 9d 0f 1f 44 00 00 5b 5d 41 5c c3 0f 1f
44 00 00 <8b> 47 34 85 c0 74 12 f0 ff 4f 34 75 06 85 f6 75 03 eb 88 c3
e9 82
[  235.774852] RSP: 0018:ffffc3cf0ffb7db0 EFLAGS: 00010046
[  235.774854] RAX: ffffa0ad0ffa0118 RBX: 0000000000000045 RCX: 0000000000000000
[  235.774856] RDX: ffffa0aeceaee2f0 RSI: 0000000000000000 RDI: 000000000000029a
[  235.774858] RBP: ffffa0ad0ffa0000 R08: fffffb06c23fd108 R09: fffffb06c23fd108
[  235.774860] R10: 0000000000068879 R11: fffffb06c02cf820 R12: 0000000000000045
[  235.774861] R13: ffffa0ade5c00010 R14: ffffa0ae0d19e5ac R15: ffffa0ae0d19e578
[  235.774864] FS:  00007f3b40f6cc80(0000) GS:ffffa0aeceac0000(0000)
knlGS:0000000000000000
[  235.774866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  235.774867] CR2: 00000000000002ce CR3: 000000004c1f0004 CR4: 00000000003606e0
[  235.774869] Call Trace:
[  235.774920]  __free_raid_bio+0x72/0xb0 [btrfs]
[  235.774961]  btrfs_free_stripe_hash_table+0x3d/0x70 [btrfs]
[  235.774992]  close_ctree+0x1ea/0x2f0 [btrfs]
[  235.774998]  generic_shutdown_super+0x6c/0x100
[  235.775001]  kill_anon_super+0x14/0x30
[  235.775024]  btrfs_kill_super+0x12/0xa0 [btrfs]
[  235.775029]  deactivate_locked_super+0x36/0x70
[  235.775033]  cleanup_mnt+0x104/0x150
[  235.775038]  task_work_run+0x87/0xa0
[  235.775043]  exit_to_usermode_loop+0xda/0x100
[  235.775047]  do_syscall_64+0x183/0x1a0
[  235.775053]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  235.775056] RIP: 0033:0x7f3b411b767b
[  235.775060] Code: 08 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3
0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 07 0c 00 f7 d8 64 89
01 48
[  235.775062] RSP: 002b:00007fffb57488e8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[  235.775065] RAX: 0000000000000000 RBX: 00007f3b412e11e4 RCX: 00007f3b411b767b
[  235.775066] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055dc3815f730
[  235.775068] RBP: 000055dc3815f520 R08: 0000000000000000 R09: 00007fffb5747660
[  235.775070] R10: 000055dc38160750 R11: 0000000000000246 R12: 000055dc3815f730
[  235.775072] R13: 0000000000000000 R14: 000055dc3815f618 R15: 0000000000000000
[  235.775074] Modules linked in: zram uinput rfcomm ccm xt_CHECKSUM
xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_CT ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter
ipt_REJECT nf_reject_ipv4 xt_conntrack tun bridge stp llc ebtable_nat
ebtable_broute ip6table_nat ip6_udp_tunnel udp_tunnel ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle
iptable_raw iptable_security nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter cmac bnep cachefiles fscache
sunrpc vfat fat iwlmvm intel_rapl_msr intel_rapl_common
x86_pkg_temp_thermal intel_powerclamp coretemp mac80211 kvm_intel
libarc4 iwlwifi kvm uvcvideo videobuf2_vmalloc mei_hdcp
videobuf2_memops videobuf2_v4l2 videobuf2_common cfg80211
snd_hda_codec_realtek irqbypass snd_hda_codec_generic ledtrig_audio
intel_cstate snd_hda_codec_hdmi intel_uncore btusb videodev
snd_hda_intel btrtl btbcm btintel snd_hda_codec
[  235.775113]  mc bluetooth snd_hda_core snd_hwdep intel_rapl_perf
wdat_wdt snd_seq snd_seq_device snd_pcm joydev asus_wmi input_polldev
i2c_i801 intel_wmi_thunderbolt intel_pch_thermal wmi_bmof ecdh_generic
ideapad_laptop ecc snd_timer lpc_ich sparse_keymap mei_me snd mei
soundcore rfkill acpi_pad lz4 lz4_compress binfmt_misc ip_tables btrfs
libcrc32c xor zstd_decompress zstd_compress raid6_pq dm_crypt i915
nouveau mxm_wmi ttm crct10dif_pclmul crc32_pclmul crc32c_intel
i2c_algo_bit drm_kms_helper drm ghash_clmulni_intel serio_raw r8169
wmi video fuse [last unloaded: zram]
[  235.775143] CR2: 00000000000002ce
[  235.775146] ---[ end trace 1ed5f1c3085019fd ]---
[  235.775151] RIP: 0010:__free_pages+0x5/0x30
[  235.775154] Code: 00 48 89 c3 fa 66 0f 1f 44 00 00 48 89 ef 4c 89
e6 e8 2f ef ff ff 48 89 df 57 9d 0f 1f 44 00 00 5b 5d 41 5c c3 0f 1f
44 00 00 <8b> 47 34 85 c0 74 12 f0 ff 4f 34 75 06 85 f6 75 03 eb 88 c3
e9 82
[  235.775156] RSP: 0018:ffffc3cf0ffb7db0 EFLAGS: 00010046
[  235.775158] RAX: ffffa0ad0ffa0118 RBX: 0000000000000045 RCX: 0000000000000000
[  235.775160] RDX: ffffa0aeceaee2f0 RSI: 0000000000000000 RDI: 000000000000029a
[  235.775162] RBP: ffffa0ad0ffa0000 R08: fffffb06c23fd108 R09: fffffb06c23fd108
[  235.775164] R10: 0000000000068879 R11: fffffb06c02cf820 R12: 0000000000000045
[  235.775165] R13: ffffa0ade5c00010 R14: ffffa0ae0d19e5ac R15: ffffa0ae0d19e578
[  235.775168] FS:  00007f3b40f6cc80(0000) GS:ffffa0aeceac0000(0000)
knlGS:0000000000000000
[  235.775170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  235.775172] CR2: 00000000000002ce CR3: 000000004c1f0004 CR4: 00000000003606e0

Best Regards,
Peter Hjalmarsson
