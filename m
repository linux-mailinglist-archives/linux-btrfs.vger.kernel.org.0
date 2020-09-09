Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735172629EF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgIIIPg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 04:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgIIIPf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 04:15:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4DAC061573
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Sep 2020 01:15:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w5so1887344wrp.8
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Sep 2020 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=x7jXYKJ6mf1HNX9jX5hJqJ+pAxmHabmztKm7/OmXr9c=;
        b=CKAosnGQJl3Kh4+L6e5/ee0Ic44Q8uI98rFmDZlHPOV0/5dhdRbqa2hyKrT5NqDp8/
         uh+GAbX/3b87xozrGXR8CgskgKk+wps7S1gXykDHLKlSPQkN5i/R95RktgRsVBfDbvPt
         qNroBV+aNhWYboUd2ao3vElCcHMtMQsvSe2tH23IlQbDfcH/8NViNdgZlfpMDttWPhu7
         T9aT4OKeeXZGIERSqn/pZz8xtPcym/+kVmWgG7Pp9GPp94k0flwN61DzJFuWs4qrt9rD
         wvs5noQc9GxhjPsnXr3VdCttp8B2rH+IxWZPPSytlaggxwOSPY5X8v0R71GCaecaf9Kn
         jI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=x7jXYKJ6mf1HNX9jX5hJqJ+pAxmHabmztKm7/OmXr9c=;
        b=QwZau0p/BAKh9Q8yr+/2kxce5tnNE3fFgf2ZFxUSqqW7/S6h5QFUi8J5+ahY6weJL6
         zPrhk52/3ZinVUIkH8mnAVbOz8g7GreNT2fOFNh3UXdn6isHU3WDGp1H8h+1Dsb0griN
         Jvu6NrbPgx5oe5Zwd+Jjp9SjiUbn9OqI9xjQLp/AZcz5bhQjB1O7y0+aCS6tbQ64hqlN
         hagodKi7a7VnmxRJgvH/KI+Vo49rOGTEhPUwbxdSmgaU0M/ND9ZqHQsc6w9JTH5UbPhy
         I8o0n1/yGPdN0caQov4h9C9Y3bDYXW4atE+hXXhem+ByHyQK7q4BvvQObUDY6uCb3+EY
         fG+A==
X-Gm-Message-State: AOAM530KNt18NB3wOF5fJLzuu/+CrqVTNWPxbEBAwSwxtTenHPQL1wP7
        spajIbdXzrWJ6BX7L++A/GZcokL5tBLKcw==
X-Google-Smtp-Source: ABdhPJweQS/W1twlegBBf67d7RsVdpyU/rYlq2h3qRNybpQqEHIkIzkztjcZ2d5fwpdDtMEtO8cUPQ==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr2721591wrs.230.1599639332265;
        Wed, 09 Sep 2020 01:15:32 -0700 (PDT)
Received: from ?IPv6:2001:718:2:119a:147:32:132:32? ([2001:718:2:119a:147:32:132:32])
        by smtp.gmail.com with ESMTPSA id a17sm3035437wra.24.2020.09.09.01.15.31
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 01:15:31 -0700 (PDT)
From:   =?UTF-8?Q?Miloslav_H=c5=afla?= <miloslav.hula@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: No space left after add device and balance
Message-ID: <9224b373-82ee-60c4-4bd1-be359db75ea1@gmail.com>
Date:   Wed, 9 Sep 2020 10:15:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: cs
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

we are using btrfs RAID-10 (/data, 4.7TB) on a physical Supermicro 
server with Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz and 125GB of RAM.

We added two more drives:

btrfs device add /dev/sds /data
btrfs device add /dev/sdt /data

and than we run balance:

btrfs filesystem balance /data


Everything run fine about 15 hours. Then we got error "No space left" 
(dmesg output below) and /data remounted into read-only.

So we unmounted /data and mounted again, everything looks OK in 
read-write. Than we run full balance again:

btrfs filesystem balance /data

After ~15.5 hours finished successfully. Unfortunetally, I have no exact 
free space report before first balance, but it looked roughly like:

Label: 'DATA'  uuid: 5b285a46-e55d-4191-924f-0884fa06edd8
         Total devices 16 FS bytes used 3.49TiB
         devid    1 size 558.41GiB used 448.66GiB path /dev/sda
         devid    2 size 558.41GiB used 448.66GiB path /dev/sdb
         devid    4 size 558.41GiB used 448.66GiB path /dev/sdd
         devid    5 size 558.41GiB used 448.66GiB path /dev/sde
         devid    7 size 558.41GiB used 448.66GiB path /dev/sdg
         devid    8 size 558.41GiB used 448.66GiB path /dev/sdh
         devid    9 size 558.41GiB used 448.66GiB path /dev/sdf
         devid   10 size 558.41GiB used 448.66GiB path /dev/sdi
         devid   11 size 558.41GiB used 448.66GiB path /dev/sdj
         devid   13 size 558.41GiB used 448.66GiB path /dev/sdk
         devid   14 size 558.41GiB used 448.66GiB path /dev/sdc
         devid   15 size 558.41GiB used 448.66GiB path /dev/sdl
         devid   16 size 558.41GiB used 448.66GiB path /dev/sdm
         devid   17 size 558.41GiB used 448.66GiB path /dev/sdn
         devid   18 size 837.84GiB used 448.66GiB path /dev/sdr
         devid   19 size 837.84GiB used 448.66GiB path /dev/sdq
         devid   20 size 837.84GiB used   0.00GiB path /dev/sds
         devid   21 size 837.84GiB used   0.00GiB path /dev/sdt


Are we doing something wrong? I found posts, where problems with balace 
of full filesystem are described. And as a recommendation is "add empty 
device, run balance, remove device".

Are there some requirements on free space for balance even if you add 
new device?

Maybe "fixed" in newer kernel?


Thank you. With kind regards
Milo



# uname -a
Linux imap 4.9.0-12-amd64 #1 SMP Debian 4.9.210-1 (2020-01-20) x86_64 
GNU/Linux


# btrfs --version
btrfs-progs v4.7.3


# btrfs fi show (after successfull balance)
Label: 'DATA'  uuid: 5b285a46-e55d-4191-924f-0884fa06edd8
         Total devices 18 FS bytes used 3.49TiB
         devid    1 size 558.41GiB used 398.27GiB path /dev/sda
         devid    2 size 558.41GiB used 398.27GiB path /dev/sdb
         devid    4 size 558.41GiB used 398.27GiB path /dev/sdd
         devid    5 size 558.41GiB used 398.27GiB path /dev/sde
         devid    7 size 558.41GiB used 398.27GiB path /dev/sdg
         devid    8 size 558.41GiB used 398.27GiB path /dev/sdh
         devid    9 size 558.41GiB used 398.27GiB path /dev/sdf
         devid   10 size 558.41GiB used 398.27GiB path /dev/sdi
         devid   11 size 558.41GiB used 398.27GiB path /dev/sdj
         devid   13 size 558.41GiB used 398.27GiB path /dev/sdk
         devid   14 size 558.41GiB used 398.27GiB path /dev/sdc
         devid   15 size 558.41GiB used 398.27GiB path /dev/sdl
         devid   16 size 558.41GiB used 398.27GiB path /dev/sdm
         devid   17 size 558.41GiB used 398.27GiB path /dev/sdn
         devid   18 size 837.84GiB used 398.27GiB path /dev/sdr
         devid   19 size 837.84GiB used 398.27GiB path /dev/sdq
         devid   20 size 837.84GiB used 398.27GiB path /dev/sds
         devid   21 size 837.84GiB used 398.27GiB path /dev/sdt


# btrfs fi df /data/ (after successfull balance)
ata, RAID10: total=3.48TiB, used=3.48TiB
System, RAID10: total=144.00MiB, used=304.00KiB
Metadata, RAID10: total=20.25GiB, used=17.96GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


# dmesg
[Tue Sep  8 06:45:36 2020] BTRFS info (device sda): relocating block 
group 33991231012864 flags 68
[Tue Sep  8 06:47:56 2020] BTRFS info (device sda): found 63581 extents
[Tue Sep  8 06:47:58 2020] BTRFS info (device sda): relocating block 
group 33990157271040 flags 68
[Tue Sep  8 06:48:34 2020] ------------[ cut here ]------------
[Tue Sep  8 06:48:34 2020] WARNING: CPU: 21 PID: 1342 at 
/build/linux-xZ5nrU/linux-4.9.210/fs/btrfs/extent-tree.c:2967 
btrfs_run_delayed_refs+0x27e/0x2b0 [btrfs]
[Tue Sep  8 06:48:34 2020] BTRFS: Transaction aborted (error -28)
[Tue Sep  8 06:48:34 2020] Modules linked in: fuse ufs qnx4 hfsplus hfs 
minix ntfs vfat msdos fat jfs xfs dm_mod ipt_REJECT nf_reject_ipv4 nfsv3 
nfs_acl nfs lockd grace fscache xt_multiport iptable_filter intel_rapl 
sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp 
kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel intel_cstate iTCO_wdt iTCO_vendor_support mxm_wmi 
intel_uncore ast intel_rapl_perf pcspkr ttm drm_kms_helper drm mei_me 
lpc_ich joydev sg mfd_core mei evdev ioatdma shpchp ipmi_si 
ipmi_msghandler wmi acpi_power_meter acpi_pad button sunrpc ip_tables 
x_tables autofs4 ext4 crc16 jbd2 fscrypto ecb mbcache btrfs raid10 
raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor 
raid6_pq libcrc32c crc32c_generic raid0 multipath linear raid1 md_mod 
ses enclosure
[Tue Sep  8 06:48:34 2020]  scsi_transport_sas sd_mod hid_generic usbhid 
hid crc32c_intel aesni_intel aes_x86_64 glue_helper lrw gf128mul 
ablk_helper cryptd ahci xhci_pci libahci ehci_pci xhci_hcd ehci_hcd igb 
i2c_i801 libata megaraid_sas i2c_smbus i2c_algo_bit usbcore dca ptp 
usb_common pps_core scsi_mod
[Tue Sep  8 06:48:34 2020] CPU: 21 PID: 1342 Comm: btrfs-transacti Not 
tainted 4.9.0-12-amd64 #1 Debian 4.9.210-1
[Tue Sep  8 06:48:34 2020] Hardware name: Supermicro X10DRi/X10DRi, BIOS 
2.1 09/13/2016
[Tue Sep  8 06:48:34 2020]  0000000000000000 ffffffff97936bfe 
ffffb0d54d8a7d68 0000000000000000
[Tue Sep  8 06:48:34 2020]  ffffffff9767b98b ffffffffc04cbc28 
ffffb0d54d8a7dc0 ffff8f09538faa48
[Tue Sep  8 06:48:34 2020]  ffff8f1c38030000 ffff8f1c36f830c0 
000000000023d11a ffffffff9767ba0f
[Tue Sep  8 06:48:34 2020] Call Trace:
[Tue Sep  8 06:48:34 2020]  [<ffffffff97936bfe>] ? dump_stack+0x66/0x88
[Tue Sep  8 06:48:34 2020]  [<ffffffff9767b98b>] ? __warn+0xcb/0xf0
[Tue Sep  8 06:48:34 2020]  [<ffffffff9767ba0f>] ? 
warn_slowpath_fmt+0x5f/0x80
[Tue Sep  8 06:48:34 2020]  [<ffffffffc04295fe>] ? 
btrfs_run_delayed_refs+0x27e/0x2b0 [btrfs]
[Tue Sep  8 06:48:34 2020]  [<ffffffffc043f823>] ? 
btrfs_commit_transaction+0x53/0xa10 [btrfs]
[Tue Sep  8 06:48:34 2020]  [<ffffffffc0440276>] ? 
start_transaction+0x96/0x480 [btrfs]
[Tue Sep  8 06:48:34 2020]  [<ffffffffc043a67c>] ? 
transaction_kthread+0x1dc/0x200 [btrfs]
[Tue Sep  8 06:48:34 2020]  [<ffffffffc043a4a0>] ? 
btrfs_cleanup_transaction+0x590/0x590 [btrfs]
[Tue Sep  8 06:48:34 2020]  [<ffffffff9769bdc9>] ? kthread+0xd9/0xf0
[Tue Sep  8 06:48:34 2020]  [<ffffffff97c1e2f1>] ? __switch_to_asm+0x41/0x70
[Tue Sep  8 06:48:34 2020]  [<ffffffff9769bcf0>] ? kthread_park+0x60/0x60
[Tue Sep  8 06:48:34 2020]  [<ffffffff97c1e377>] ? ret_from_fork+0x57/0x70
[Tue Sep  8 06:48:34 2020] ---[ end trace 7be8e0e64ac370b3 ]---
[Tue Sep  8 06:48:34 2020] BTRFS: error (device sda) in 
btrfs_run_delayed_refs:2967: errno=-28 No space left
[Tue Sep  8 06:48:34 2020] BTRFS info (device sda): forced readonly
[Tue Sep  8 07:31:16 2020] BTRFS info (device sda): disk space caching 
is enabled
[Tue Sep  8 07:31:16 2020] BTRFS error (device sda): Remounting 
read-write after error is not allowed
[Tue Sep  8 07:32:50 2020] BTRFS error (device sda): cleaner transaction 
attach returned -30
[Tue Sep  8 07:33:01 2020] BTRFS info (device sdt): disk space caching 
is enabled
[Tue Sep  8 07:33:01 2020] BTRFS info (device sdt): has skinny extents
[Tue Sep  8 07:35:38 2020] BTRFS info (device sdt): checking UUID tree
[Tue Sep  8 07:35:38 2020] BTRFS info (device sdt): continuing balance
[Tue Sep  8 07:35:38 2020] BTRFS info (device sdt): relocating block 
group 40004587880448 flags 68
[Tue Sep  8 07:38:49 2020] BTRFS info (device sdt): found 32320 extents
[Tue Sep  8 07:38:50 2020] BTRFS info (device sdt): relocating block 
group 39945397862400 flags 68
[Tue Sep  8 07:42:07 2020] BTRFS info (device sdt): found 53227 extents
[Tue Sep  8 07:42:08 2020] BTRFS info (device sdt): relocating block 
group 39944189902848 flags 68
[Tue Sep  8 07:44:29 2020] BTRFS info (device sdt): found 57961 extents
[Tue Sep  8 07:44:30 2020] BTRFS info (device sdt): relocating block 
group 33985728086016 flags 66
[Tue Sep  8 07:44:30 2020] BTRFS info (device sdt): found 20 extents
