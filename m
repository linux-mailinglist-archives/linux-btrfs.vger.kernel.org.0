Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFC23B46
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 16:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfETOxz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 20 May 2019 10:53:55 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:45880 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbfETOxy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 10:53:54 -0400
Received: by mail-qk1-f176.google.com with SMTP id j1so8946430qkk.12
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 07:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bq4OPRoHR/GdFYsXHFmXQHeqWsJVDzg1YcPCT6uMfzg=;
        b=mJpnkqFes1keR1l0Jv/XZTZnjKZQPCDcIZcnx5EUvv7wS/T2E1ttC8XPWh5uE4KNyl
         qDsBrN3jHzOrF6QGyZc7zZsfXzRxsqDaN5exbOpS1tIgkYbYWFFzXu9ezqcYbe/EFsqm
         GW7WyJnXCT2FwMQZA6HSXqMcXHzPkiMWO38M8Z/9/o9+jhZhEdS0X1XaRJSZ1GZ66Mg3
         CK+7lmPF9sj+hSklb73xTxs+Vx4Nk92XzscxJSuzLK+YgvtcYRONcd4iyAnC41jY1cj8
         pHQE5hVDcTARPI7yiIynjdkXxcr2UEbPtVJRmL2osddEfyNadw2kbquFZ6UV1GzXApSr
         naNg==
X-Gm-Message-State: APjAAAXGIvSiUZYKoIM9HINiZxROGzUTh1os3k1B0nhO5FT9vsgrYSzl
        WG5kqJL9iWMU3lfPsoi6wf2TmCdykAp9dH9dJMM=
X-Google-Smtp-Source: APXvYqynd+yxRaUTA7GoFj1jsz2MKZhynhBX/B1O2uzQ87uwQ87bcClPZ/fJeJKcdzKXjODCH9PvH46aSXRlGrM9xRk=
X-Received: by 2002:a37:e301:: with SMTP id y1mr58177011qki.176.1558364033181;
 Mon, 20 May 2019 07:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <297da4cbe20235080205719805b08810@bi-co.net> <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net> <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net> <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
 <C1CD4646-E75D-4AAF-9CD6-B3AC32495FD3@bi-co.net> <CAK-xaQYPs62v971zm1McXw_FGzDmh_vpz3KLEbxzkmrsSgTfXw@mail.gmail.com>
 <9D4ECE0B-C9DD-4BAD-A764-9DE2FF2A10C7@bi-co.net>
In-Reply-To: <9D4ECE0B-C9DD-4BAD-A764-9DE2FF2A10C7@bi-co.net>
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
Date:   Mon, 20 May 2019 16:53:41 +0200
Message-ID: <CAK-xaQYakXcAbhfiH_VbqWkh+HBJD5N69ktnnA7OnWdhL6fDLA@mail.gmail.com>
Subject: Re: fstrim discarding too many or wrong blocks on Linux 5.1, leading
 to data loss
To:     =?UTF-8?B?TWljaGFlbCBMYcOf?= <bevan@bi-co.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno lun 20 mag 2019 alle ore 15:58 Michael Laß <bevan@bi-co.net>
ha scritto:
>
>
> > Am 20.05.2019 um 15:53 schrieb Andrea Gelmini <andrea.gelmini@gmail.com>:
> >
> > Had same issue on a similar (well,  quite exactly same setup), on a machine in production.
> > But It Is more than 4 tera of data, so in the end I re-dd the image and restarted, sticking to 5.0.y branch never had problem.
> > I was able to replicate it. SSD Samsung, more recent version.
> > Not with btrfs but ext4, by the way.
>
> Thanks for the info, that eliminates one variable. So you also used dm-crypt on top of LVM?

root@glet:~# lsblk |grep -v loop
NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda              8:0    0   3,7T  0 disk
├─sda1           8:1    0   260M  0 part  /boot/efi
├─sda2           8:2    0    16M  0 part
├─sda3           8:3    0  67,6G  0 part
├─sda4           8:4    0   883M  0 part
├─sda5           8:5    0   1,9G  0 part  /boot
└─sda6           8:6    0   3,5T  0 part
 └─sda6_crypt 254:0    0   3,5T  0 crypt
   ├─cry-root 254:1    0    28G  0 lvm   /
   ├─cry-swap 254:2    0    70G  0 lvm   [SWAP]
   └─cry-home 254:3    0   2,7T  0 lvm   /home
nvme0n1        259:0    0 119,2G  0 disk
├─nvme0n1p1    259:1    0  97,8G  0 part  /mnt/nvme
└─nvme0n1p2    259:2    0  21,5G  0 part  [SWAP]
root@glet:~#

Booting with kernel > 5.0, it discard cry-home, for the first big part.

root@glet:~# lvdisplay  -vv
     devices/global_filter not found in config: defaulting to
global_filter = [ "a|.*/|" ]
     Setting global/locking_type to 1
     Setting global/use_lvmetad to 1
     global/lvmetad_update_wait_time not found in config: defaulting to 10
     Setting response to OK
     Setting protocol to lvmetad
     Setting version to 1
     Setting global/use_lvmpolld to 1
     Setting devices/sysfs_scan to 1
     Setting devices/multipath_component_detection to 1
     Setting devices/md_component_detection to 1
     Setting devices/fw_raid_component_detection to 0
     Setting devices/ignore_suspended_devices to 0
     Setting devices/ignore_lvm_mirrors to 1
     devices/filter not found in config: defaulting to filter = [ "a|.*/|" ]
     Setting devices/cache_dir to /run/lvm
     Setting devices/cache_file_prefix to
     devices/cache not found in config: defaulting to /run/lvm/.cache
     Setting devices/write_cache_state to 1
     Setting global/use_lvmetad to 1
     Setting activation/activation_mode to degraded
     metadata/record_lvs_history not found in config: defaulting to 0
     Setting activation/monitoring to 1
     Setting global/locking_type to 1
     Setting global/wait_for_locks to 1
     File-based locking selected.
     Setting global/prioritise_write_locks to 1
     Setting global/locking_dir to /run/lock/lvm
     Setting global/use_lvmlockd to 0
     Setting response to OK
     Setting token to filter:3239235440
     Setting daemon_pid to 650
     Setting response to OK
     Setting global_disable to 0
     report/output_format not found in config: defaulting to basic
     log/report_command_log not found in config: defaulting to 0
     Setting response to OK
     Setting response to OK
     Setting response to OK
     Setting name to cry
     Processing VG cry Orkwof-zq16-e1qM-rUMt-vKV1-Lc13-CgiKYp
     Locking /run/lock/lvm/V_cry RB
     Reading VG cry Orkwofzq16e1qMrUMtvKV1Lc13CgiKYp
     Setting response to OK
     Setting response to OK
     Setting response to OK
     Setting name to cry
     Setting metadata/format to lvm2
     Setting id to OtoEfX-bpWN-l9gd-kLJW-1xca-PaHR-ARrSKr
     Setting format to lvm2
     Setting device to 65024
     Setting dev_size to 7465840640
     Setting label_sector to 1
     Setting ext_flags to 1
     Setting ext_version to 2
     Setting size to 1044480
     Setting start to 4096
     Setting ignore to 0
     Setting response to OK
     Setting response to OK
     Setting response to OK
     /dev/mapper/sda6_crypt: size is 7465842688 sectors
     Adding cry/root to the list of LVs to be processed.
     Adding cry/swap to the list of LVs to be processed.
     Adding cry/home to the list of LVs to be processed.
     Processing LV root in VG cry.
 --- Logical volume ---
     global/lvdisplay_shows_full_device_path not found in config:
defaulting to 0
 LV Path                /dev/cry/root
 LV Name                root
 VG Name                cry
 LV UUID                J0vJ5D-Rzyt-9fOm-cJVU-bwjc-6pc1-jGqIhc
 LV Write Access        read/write
 LV Creation host, time glet, 2018-11-02 17:51:35 +0100
 LV Status              available
 # open                 1
 LV Size                <27,94 GiB
 Current LE             7152
 Segments               1
 Allocation             inherit
 Read ahead sectors     auto
 - currently set to     256
 Block device           254:1

     Processing LV swap in VG cry.
 --- Logical volume ---
     global/lvdisplay_shows_full_device_path not found in config:
defaulting to 0
 LV Path                /dev/cry/swap
 LV Name                swap
 VG Name                cry
 LV UUID                c4iLex-xxMu-Quyr-4qkt-hFk2-uOb5-BDF5ls
 LV Write Access        read/write
 LV Creation host, time glet, 2018-11-02 17:51:43 +0100
 LV Status              available
 # open                 2
 LV Size                70,00 GiB
 Current LE             17920
 Segments               2
 Allocation             inherit
 Read ahead sectors     auto
 - currently set to     256
 Block device           254:2

     Processing LV home in VG cry.
 --- Logical volume ---
     global/lvdisplay_shows_full_device_path not found in config:
defaulting to 0
 LV Path                /dev/cry/home
 LV Name                home
 VG Name                cry
 LV UUID                jycl7w-59lN-F3Ne-DBDa-G21g-CAmb-ROvIaX
 LV Write Access        read/write
 LV Creation host, time glet, 2018-11-02 17:51:50 +0100
 LV Status              available
 # open                 1
 LV Size                <2,71 TiB
 Current LE             709591
 Segments               2
 Allocation             inherit
 Read ahead sectors     auto
 - currently set to     256
 Block device           254:3

     Unlocking /run/lock/lvm/V_cry
     Setting global/notify_dbus to 1

Also, changing crypttab:
root@glet:~# cat /etc/crypttab
sda6_crypt UUID=fe03e2e6-b8b1-4672-8a3e-b536ac4e1539 none luks,discard

removing discard didn't solve the issue.

In my setup it was enough to boot the system, so having complain about
/home mounting
impossible (no filesystem found).

Well, keep in mind that at boot I have a few things, like:
root@glet:~# grep -i swap /etc/fstab
/dev/mapper/cry-swap none       swap    sw,discard=once,pri=0
    0       0
/dev/nvme0n1p2       none       swap    sw,discard=once,pri=1

And other stuff in cron and so on.

So I can trigger the problem at boot (ubuntu 19.04), by my changes.

Hope it helps.

Uhm, by the way, my SSD (latest firmware):

root@glet:~# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
       Model Number:       Samsung SSD 860 EVO 4TB
       Serial Number:      S3YPNWAK101163T
       Firmware Revision:  RVT02B6Q
       Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II
Extensions, SATA Rev 2.5, SATA Rev 2.6, SATA Rev 3.0
Standards:
       Used: unknown (minor revision code 0x005e)
       Supported: 11 8 7 6 5
       Likely used: 11
Configuration:
       Logical         max     current
       cylinders       16383   16383
       heads           16      16
       sectors/track   63      63
       --
       CHS current addressable sectors:    16514064
       LBA    user addressable sectors:   268435455
       LBA48  user addressable sectors:  7814037168
       Logical  Sector size:                   512 bytes
       Physical Sector size:                   512 bytes
       Logical Sector-0 offset:                  0 bytes
       device size with M = 1024*1024:     3815447 MBytes
       device size with M = 1000*1000:     4000787 MBytes (4000 GB)
       cache/buffer size  = unknown
       Form Factor: 2.5 inch
       Nominal Media Rotation Rate: Solid State Device
Capabilities:
       LBA, IORDY(can be disabled)
       Queue depth: 32
       Standby timer values: spec'd by Standard, no device specific minimum
       R/W multiple sector transfer: Max = 1   Current = 1
       DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
            Cycle time: min=120ns recommended=120ns
       PIO: pio0 pio1 pio2 pio3 pio4
            Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
       Enabled Supported:
          *    SMART feature set
               Security Mode feature set
          *    Power Management feature set
          *    Write cache
          *    Look-ahead
          *    Host Protected Area feature set
          *    WRITE_BUFFER command
          *    READ_BUFFER command
          *    NOP cmd
          *    DOWNLOAD_MICROCODE
               SET_MAX security extension
          *    48-bit Address feature set
          *    Device Configuration Overlay feature set
          *    Mandatory FLUSH_CACHE
          *    FLUSH_CACHE_EXT
          *    SMART error logging
          *    SMART self-test
          *    General Purpose Logging feature set
          *    WRITE_{DMA|MULTIPLE}_FUA_EXT
          *    64-bit World wide name
               Write-Read-Verify feature set
          *    WRITE_UNCORRECTABLE_EXT command
          *    {READ,WRITE}_DMA_EXT_GPL commands
          *    Segmented DOWNLOAD_MICROCODE
          *    Gen1 signaling speed (1.5Gb/s)
          *    Gen2 signaling speed (3.0Gb/s)
          *    Gen3 signaling speed (6.0Gb/s)
          *    Native Command Queueing (NCQ)
          *    Phy event counters
          *    READ_LOG_DMA_EXT equivalent to READ_LOG_EXT
          *    DMA Setup Auto-Activate optimization
          *    Device-initiated interface power management
          *    Asynchronous notification (eg. media change)
          *    Software settings preservation
          *    Device Sleep (DEVSLP)
          *    SMART Command Transport (SCT) feature set
          *    SCT Write Same (AC2)
          *    SCT Error Recovery Control (AC3)
          *    SCT Features Control (AC4)
          *    SCT Data Tables (AC5)
          *    reserved 69[4]
          *    DOWNLOAD MICROCODE DMA command
          *    SET MAX SETPASSWORD/UNLOCK DMA commands
          *    WRITE BUFFER DMA command
          *    READ BUFFER DMA command
          *    Data Set Management TRIM supported (limit 8 blocks)
          *    Deterministic read ZEROs after TRIM
Security:
       Master password revision code = 65534
               supported
       not     enabled
       not     locked
       not     frozen
       not     expired: security count
               supported: enhanced erase
       4min for SECURITY ERASE UNIT. 8min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 5002538e7001e8a7
       NAA             : 5
       IEEE OUI        : 002538
       Unique ID       : e7001e8a7
Device Sleep:
       DEVSLP Exit Timeout (DETO): 50 ms (drive)
       Minimum DEVSLP Assertion Time (MDAT): 30 ms (drive)
Checksum: correct
