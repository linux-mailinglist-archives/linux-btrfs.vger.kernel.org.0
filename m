Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF641316D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAFRcW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 12:32:22 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:39739 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFRcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 12:32:22 -0500
Received: by mail-qv1-f50.google.com with SMTP id y8so19353123qvk.6
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5jsa2UJgYT8k0V0oZReDY5BJSVN4GGWgbnrvt3dc54=;
        b=oFVJS250m6GUCIgEoO0JjMrTWGX8Oic0z7eg5CTBWF1QXHM/dq3NDfBXkfehpiH6Dp
         MdbA0savav9CaNMQ5f53PaY1IvNSjGWyk/DjHR30DfoM99nXakYq4fqylqH+S7UTNxsZ
         Ik52e1e+hmGeJqMIU4ntOp78xCJ8+srUA0aVCZkf1bTkrdkSTjL+taooRI2xp7GhMrHe
         2hzxiYsP/OJpGWV5By4RpH72ckgkoAqL2Ak7+0aiCug3UZUwiLbFDpsD4zxb2pFRIvPr
         pGdiTmCnaPla/CM/4vaH0pvwtelIPGemCO/GfwHMIySjRN2V6Pz+jY2794sngkLBV3Gp
         C88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5jsa2UJgYT8k0V0oZReDY5BJSVN4GGWgbnrvt3dc54=;
        b=NdV+0MHy5bQR/gojZ9X+uQTVY9ncGgEY2ig4kdMarfsF/rqEfqJGmZYiXEpTRlJxSG
         jHgTUAetU/xJl4liKdmOK5026+6X8NMbsoSdC/7/2Z7OA5NQJvWFDda5tXqs+lq1VL5a
         opMcATuKrHTRQxR8WnEEQY0oeHjlQdwxRM53IiPCM3gyXBDPfJ/OL64OSW3BKN6mbwdM
         o6n0703A67BBLFRGE8mquJIqZ/+rWV0zGhyHO9KIrmEKi2HQDUnVwyA9SQy9GDTtczyx
         El56iaWYwbH6rt//gMVee03HpkXfJ4iPHXRkNXpgOCsSoJ8ekH/c/uyUsbinLArEq+do
         4d7w==
X-Gm-Message-State: APjAAAWLVj9WKUgQJm+XxLkM8rTxMZ3mJycmaO/aG7f9W81W8IWjF/v6
        IyXDEo4GLP94UZwWD0l5t2VdaAJa
X-Google-Smtp-Source: APXvYqw1/f53TzaeVQEibngO6lcW2pBFkiERYMFMSDWKTldQBboPhdTCgk77U8frPb7Gvni4NQcz9g==
X-Received: by 2002:a0c:aacb:: with SMTP id g11mr80666930qvb.108.1578331939993;
        Mon, 06 Jan 2020 09:32:19 -0800 (PST)
Received: from paca.localnet (c-98-229-166-121.hsd1.ma.comcast.net. [98.229.166.121])
        by smtp.gmail.com with ESMTPSA id i28sm24173575qtc.57.2020.01.06.09.32.18
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 09:32:18 -0800 (PST)
From:   Stephen Conrad <conradsd@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Errors after SATA hard resets: parent transid verify failed, csum mismatch on free space cache
Date:   Mon, 06 Jan 2020 12:32:17 -0500
Message-ID: <1794842.PFUSC7HjHz@paca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2937021.njBEhWVQiJ"
Content-Transfer-Encoding: 7Bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2937021.njBEhWVQiJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,

I have a pair of identical drives that I set up with btrfs for the purpose of 
redundancy for a 24x7 network attached storage application.  The pair of 
drives reside in an external enclosure and are each connected to the servers 
with a dedicated eSATA cable.  I set up the array in Fall of 2017 and had 
about a year of operation without noticing any issues.

In January 2019 the file system remounted read-only.  I have retained the dmesg 
logs and notes on the actions I took at that time.  Summary is that I saw a 
bunch of SATA "link is slow to respond" and "hard resetting link" messages 
followed by BTRFS errors, "BTRFS: Transaction aborted (error -5)", and a stack 
trace.  I tried a few things (unsuccessfully) and had to power down the 
hardware.  After a power cycle the file system mounted R/W as normal.   I then 
ran a btrfs check and btrfs scrub which showed no errors.  

# btrfs check -p /dev/disk/by-uuid/X
Checking filesystem on /dev/disk/by-uuid/X
UUID: X
checking extents [o]
checking free space cache [.]
checking fs roots [o]
checking csums
checking root refs
found 2953419067392 bytes used err is 0
total csum bytes: 2880319844
total tree bytes: 3249602560
total fs tree bytes: 153665536
total extent tree bytes: 30392320
btree space waste bytes: 162811208
file data blocks allocated: 2950169763840
 referenced 2950168137728

# btrfs scrub start -B /dev/disk/by-uuid/X
scrub done for X
        scrub started at Thu Jan 24 21:18:33 2019 and finished after 03:58:21
        total bytes scrubbed: 2.69TiB with 0 errors

I also swapped out my long eSATA cables (6 foot) for shorter cables (20 inch) 
to try to address the link issues... Thought everything was good, but this 
episode may be related to subsequent events...

<10 Months Later>

In October 2019 I had a similar event.  Logs show SATA "hard resetting link" 
for both drives as well as BTRFS "lost page write due to IO error" messages.  
The logs show "forced readonly", "BTRFS: Transaction aborted (error -5)" and a 
stack trace.  After hard power cycle I ran a "btrfs check -p" which resulted 
in a stream messages like "parent transid verify failed on 2418006753280 
wanted 34457 found 30647" and then the following:
parent transid verify failed on 2417279598592 wanted 35322 found 29823
checking root refs
found 3066087231488 bytes used err is 0
total csum bytes: 2990197476
total tree bytes: 3376070656
total fs tree bytes: 158498816
total extent tree bytes: 31932416
btree space waste bytes: 171614389
file data blocks allocated: 3062711459840
 referenced 3062709796864

I re-ran the check and captured all output to file just in case. File is 315000 
lines long...

After some internet research I decided to mount the file system and run a 
scrub.  File system mounts read/write successfully, but I was seeing patterns 
of log entries like: "BTRFS error (device dm-1): parent transid verify failed 
on 2176843776 wanted 34455 found 27114" and then "BTRFS info (device dm-1): 
read error corrected: ino 1 off 2176843776 (dev /dev/mapper/K1JG82AD sector 
4251648)"

# btrfs scrub start -B /dev/disk/by-uuid/X
After starting the scrub the logs were showing several patterns
verify_parent_transid: 89 callbacks suppressed
repair_io_failure: 386 callbacks suppressed
BTRFS error (device dm-1): csum mismatch on free space cache
BTRFS warning (device dm-1): failed to load free space cache for block group 
1131786797056, rebuilding it now
BTRFS error (device dm-1): parent transid verify failed on 2417279385600 
wanted 35322 found 29823
BTRFS info (device dm-1): read error corrected: ino 1 off 2417279385600 (dev /
dev/mapper/K1JG82AD sector 4719086112)

But the summary output looked OK...
scrub done for X
        scrub started at Thu Oct 31 00:27:29 2019 and finished after 04:07:45
        total bytes scrubbed: 2.79TiB with 0 errors

# date
Sun Dec  8 11:56:29 EST 2019
# btrfs fi show
Label: none  uuid: X
        Total devices 2 FS bytes used 2.80TiB
        devid    1 size 5.46TiB used 2.80TiB path /dev/mapper/K1JG82AD
        devid    2 size 5.46TiB used 2.80TiB path /dev/mapper/K1JGYJJD

# btrfs dev stat /mnt/raid
[/dev/mapper/K1JG82AD].write_io_errs   15799831
[/dev/mapper/K1JG82AD].read_io_errs    15764242
[/dev/mapper/K1JG82AD].flush_io_errs   4385
[/dev/mapper/K1JG82AD].corruption_errs 0
[/dev/mapper/K1JG82AD].generation_errs 0
[/dev/mapper/K1JGYJJD].write_io_errs   0
[/dev/mapper/K1JGYJJD].read_io_errs    0
[/dev/mapper/K1JGYJJD].flush_io_errs   0
[/dev/mapper/K1JGYJJD].corruption_errs 0
[/dev/mapper/K1JGYJJD].generation_errs 0

At this point I was still seeing occasional log entries for "parent transid 
verify failed" and "read error corrected" so I decided to upgrade from Debian9 
to Debian10 to get more current tools.  Running a scrub with Debian10 tools I 
saw errors detected and corrected... I also saw sata link issues during the 
scrub...

# date
Mon 09 Dec 2019 10:29:05 PM EST
# btrfs scrub start -B -d /dev/disk/by-uuid/X
scrub device /dev/mapper/K1JG82AD (id 1) done
        scrub started at Sun Dec  8 23:06:59 2019 and finished after 05:46:26
        total bytes scrubbed: 2.80TiB with 9490467 errors
        error details: verify=1349 csum=9489118
        corrected errors: 9490467, uncorrectable errors: 0, unverified errors: 
0
WARNING: errors detected during scrubbing, corrected

# btrfs dev stat /mnt/raid
[/dev/mapper/K1JG82AD].write_io_errs    15799831
[/dev/mapper/K1JG82AD].read_io_errs     15764242
[/dev/mapper/K1JG82AD].flush_io_errs    4385
[/dev/mapper/K1JG82AD].corruption_errs  9489118
[/dev/mapper/K1JG82AD].generation_errs  1349
[/dev/mapper/K1JGYJJD].write_io_errs    0
[/dev/mapper/K1JGYJJD].read_io_errs     0
[/dev/mapper/K1JGYJJD].flush_io_errs    0
[/dev/mapper/K1JGYJJD].corruption_errs  0
[/dev/mapper/K1JGYJJD].generation_errs  0

At this point I want to separate the file system debug from the hardware debug.  
I would like to offload all data to a different disk (if possible) to maintain 
availability while I work with the hardware, then return to this hardware once 
I am certain it is rock solid...

Questions:
1) How should I interpret these errors?  Seems that btrfs messages are telling 
me that there are an abundance of errors everywhere, but that they are all 
correctable...  Should I panic?  Should I proceed?

2) Is my file system broken? Is my data corrupted?  Should I be able to scrub 
etc to get back to operation without scary log messages? Can I trust data that 
I copy out now, or need to fall back on old/incomplete backups?

3) What steps are recommended to backup/offload/recover data?  I am considering 
installing the disks into a different machine, then mounting the array read-
only, and then pulling a full copy of the data...

4) What steps should I take to clean up the file system errors/messages?  Start 
fresh after full backup, (though I hate the idea of migrating off a redundant 
array onto a single disk in the process)?  Scrub etc?  Evaluate each disk 
independently and rebuild one from the other?

Regards,
Stephen

 - System Information - 
2017 - 2019/12/8 (Debian 9)
linux-4.9.110
Package: btrfs-progs (4.7.3-1)

2019/12/8 - present (Debian 10)
# uname -a
Linux 4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11) x86_64 GNU/
Linux
# btrfs --version
btrfs-progs v4.20.1
# btrfs fi show
<See above>

- dmesg / stack traces - 
Attached




--nextPart2937021.njBEhWVQiJ
Content-Disposition: attachment; filename="20190121_dmesg_trace.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="20190121_dmesg_trace.txt"

...
[13940826.679535] ata4: link is slow to respond, please be patient (ready=0)
[13940826.715588] ata3: link is slow to respond, please be patient (ready=0)
[13940830.855320] ata3: COMRESET failed (errno=-16)
[13940830.857487] ata3: hard resetting link
[13940830.879305] ata4: COMRESET failed (errno=-16)
[13940830.881402] ata4: hard resetting link
[13940831.567340] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[13940831.591337] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[13940831.842762] ata4.00: configured for UDMA/133
[13940831.842774] ata4: EH complete
[13940831.895485] ata3.00: configured for UDMA/133
[13940831.895495] ata3: EH complete
[13942645.785185] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action 0xe frozen
[13942645.787579] ata4: irq_stat 0x00400040, connection status changed
[13942645.789981] ata4: SError: { PHYRdyChg 10B8B DevExch }
[13942645.792035] ata4: hard resetting link
[13942645.792053] ata3: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action 0xe frozen
[13942645.794225] ata3: irq_stat 0x00400040, connection status changed
[13942645.796163] ata3: SError: { PHYRdyChg 10B8B DevExch }
[13942645.798122] ata3: hard resetting link
[13942651.692129] ata3: link is slow to respond, please be patient (ready=0)
[13942651.692141] ata4: link is slow to respond, please be patient (ready=0)
[13942654.932049] ata3: SATA link down (SStatus 0 SControl 310)
[13942654.932064] ata3.00: link offline, clearing class 1 to NONE
[13942655.076201] ata3: hard resetting link
[13942655.076288] ata4: SATA link down (SStatus 0 SControl 310)
[13942655.076297] ata4.00: link offline, clearing class 1 to NONE
[13942655.082787] ata4: hard resetting link
[13942660.431729] ata3: link is slow to respond, please be patient (ready=0)
[13942660.439653] ata4: link is slow to respond, please be patient (ready=0)
[13942663.859531] ata4: SATA link down (SStatus 0 SControl 310)
[13942663.859540] ata4.00: link offline, clearing class 1 to NONE
[13942663.998391] ata4: hard resetting link
[13942663.998462] ata3: SATA link down (SStatus 0 SControl 310)
[13942663.998471] ata3.00: link offline, clearing class 1 to NONE
[13942664.042066] ata3: hard resetting link
[13942669.391142] ata4: link is slow to respond, please be patient (ready=0)
[13942669.391156] ata3: link is slow to respond, please be patient (ready=0)
[13942672.811032] ata4: SATA link down (SStatus 0 SControl 310)
[13942672.811043] ata4.00: link offline, clearing class 1 to NONE
[13942672.811052] ata4.00: disabled
[13942672.811085] ata4: EH complete
[13942672.811094] ata3: SATA link down (SStatus 0 SControl 310)
[13942672.811105] ata3.00: link offline, clearing class 1 to NONE
[13942672.811115] ata3.00: disabled
[13942672.811118] ata4.00: detaching (SCSI 3:0:0:0)
[13942672.811143] ata3: EH complete
[13942672.811165] ata3.00: detaching (SCSI 2:0:0:0)
[13942672.812676] sd 3:0:0:0: [sdc] Stopping disk
[13942672.812751] sd 2:0:0:0: [sdb] Stopping disk
[13942672.812777] sd 3:0:0:0: [sdc] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[13942672.812803] sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[13942672.927959] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen
[13942672.931572] ata4: irq_stat 0x00000040, connection status changed
[13942672.934757] ata4: SError: { CommWake DevExch }
[13942672.937431] ata4: hard resetting link
[13942672.983564] ata3: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen
[13942672.986278] ata3: irq_stat 0x00000040, connection status changed
[13942672.989031] ata3: SError: { CommWake DevExch }
[13942672.992316] ata3: hard resetting link
[13942678.686710] ata4: link is slow to respond, please be patient (ready=0)
[13942678.742705] ata3: link is slow to respond, please be patient (ready=0)
[13942682.946487] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[13942683.002426] ata3: COMRESET failed (errno=-16)
[13942683.005434] ata3: hard resetting link
[13942683.284655] ata4.00: ATA-9: WDC WD6002FFWX-68TZ4N0, 83.H0A83, max UDMA/133
[13942683.284662] ata4.00: 11721045168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[13942683.292587] ata4.00: configured for UDMA/133
[13942683.292606] ata4: EH complete
[13942683.293066] scsi 3:0:0:0: Direct-Access     ATA      WDC WD6002FFWX-6 0A83 PQ: 0 ANSI: 5
[13942683.335331] sd 3:0:0:0: [sdf] 11721045168 512-byte logical blocks: (6.00 TB/5.46 TiB)
[13942683.335341] sd 3:0:0:0: [sdf] 4096-byte physical blocks
[13942683.335470] sd 3:0:0:0: Attached scsi generic sg1 type 0
[13942683.335706] sd 3:0:0:0: [sdf] Write Protect is off
[13942683.335720] sd 3:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[13942683.335856] sd 3:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[13942683.352758] sd 3:0:0:0: [sdf] Attached SCSI removable disk
[13942683.722409] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[13942683.726180] ata3.00: ATA-9: WDC WD6002FFWX-68TZ4N0, 83.H0A83, max UDMA/133
[13942683.726188] ata3.00: 11721045168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[13942683.734444] ata3.00: configured for UDMA/133
[13942683.734462] ata3: EH complete
[13942683.734971] scsi 2:0:0:0: Direct-Access     ATA      WDC WD6002FFWX-6 0A83 PQ: 0 ANSI: 5
[13942683.779103] sd 2:0:0:0: [sdg] 11721045168 512-byte logical blocks: (6.00 TB/5.46 TiB)
[13942683.779111] sd 2:0:0:0: [sdg] 4096-byte physical blocks
[13942683.779282] sd 2:0:0:0: Attached scsi generic sg2 type 0
[13942683.779483] sd 2:0:0:0: [sdg] Write Protect is off
[13942683.779498] sd 2:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[13942683.779664] sd 2:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[13942683.796395] sd 2:0:0:0: [sdg] Attached SCSI removable disk
[13942886.397293] BTRFS error (device dm-1): bdev /dev/mapper/K1JGYJJD errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
[13942886.397515] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
[13942886.398349] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
[13942886.399066] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
[13942886.399834] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
[13942886.402749] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
[13942886.402763] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
[13942886.402786] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
[13942886.402801] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
[13942886.404401] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
[13942886.427753] ------------[ cut here ]------------
[13942886.427801] WARNING: CPU: 2 PID: 3344 at /build/linux-iyqref/linux-4.9.110/fs/btrfs/extent-tree.c:6959 __btrfs_free_extent.isra.69+0x821/0xd40 [btrfs]
[13942886.427803] BTRFS: Transaction aborted (error -5)
[13942886.427804] Modules linked in: ses enclosure scsi_transport_sas uas usb_storage cpuid dm_crypt algif_skcipher af_alg fuse ufs qnx4 hfsplus hfs minix ntfs vfat msdos fat jfs xfs libcrc32c dm_mod snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device ir_lirc_codec ir_rc5_decoder lirc_dev rc_hauppauge au8522_dig xc5000 tuner au8522_decoder au8522_common ip6t_REJECT nf_reject_ipv6 xt_hl ip6t_rt nf_conntrack_ipv6 nf_defrag_ipv6 iTCO_wdt iTCO_vendor_support intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul snd_hda_codec_hdmi ipt_REJECT ghash_clmulni_intel nf_reject_ipv4 intel_cstate arc4 intel_uncore snd_hda_codec_realtek intel_rapl_perf snd_hda_codec_generic pcspkr evdev serio_raw rtl8723ae btcoexist snd_hda_intel rtl8723_common rtl_pci rtlwifi
[13942886.427884]  snd_hda_codec i915 mac80211 snd_hda_core snd_hwdep au0828 btusb btrtl btbcm tveeprom btintel snd_pcm drm_kms_helper xt_limit dvb_core rc_core cfg80211 v4l2_common bluetooth videobuf2_vmalloc xt_tcpudp videobuf2_memops drm videobuf2_v4l2 rfkill snd_timer videobuf2_core snd videodev mei_me i2c_algo_bit soundcore sg media mei lpc_ich shpchp mfd_core xt_addrtype video ac button nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack ip6table_filter ip6_tables nf_conntrack_netbios_ns nf_conntrack_broadcast nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack iptable_filter ip_tables x_tables autofs4 ext4 crc16 jbd2 fscrypto ecb mbcache btrfs crc32c_generic xor raid6_pq sd_mod hid_generic usbhid hid crc32c_intel aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd psmouse i2c_i801 i2c_smbus
[13942886.427969]  ahci libahci r8169 mii libata xhci_pci ehci_pci xhci_hcd ehci_hcd scsi_mod e1000e usbcore ptp usb_common pps_core fan thermal
[13942886.427991] CPU: 2 PID: 3344 Comm: btrfs-transacti Not tainted 4.9.0-7-amd64 #1 Debian 4.9.110-3+deb9u1
[13942886.427993] Hardware name: CompuLab Intense-PC/Intense-PC, BIOS CR_2.2.0.346 X64 11/25/2012
[13942886.427996]  0000000000000000 ffffffffa5530694 ffffaf9c03443af8 0000000000000000
[13942886.428002]  ffffffffa5278d6e 0000000008eb0000 ffffaf9c03443b50 00000000fffffffb
[13942886.428007]  ffff9114141aa8c0 ffff9117891e6000 0000000000000000 ffffffffa5278def
[13942886.428012] Call Trace:
[13942886.428022]  [<ffffffffa5530694>] ? dump_stack+0x5c/0x78
[13942886.428030]  [<ffffffffa5278d6e>] ? __warn+0xbe/0xe0
[13942886.428035]  [<ffffffffa5278def>] ? warn_slowpath_fmt+0x5f/0x80
[13942886.428067]  [<ffffffffc04e81a1>] ? __btrfs_free_extent.isra.69+0x821/0xd40 [btrfs]
[13942886.428074]  [<ffffffffa538ea01>] ? __set_page_dirty_nobuffers+0xa1/0x140
[13942886.428108]  [<ffffffffc0558af9>] ? btrfs_merge_delayed_refs+0x69/0x570 [btrfs]
[13942886.428136]  [<ffffffffc04ec99b>] ? __btrfs_run_delayed_refs+0xb9b/0x13a0 [btrfs]
[13942886.428163]  [<ffffffffc04f013d>] ? btrfs_run_delayed_refs+0x9d/0x2b0 [btrfs]
[13942886.428193]  [<ffffffffc05045f3>] ? commit_cowonly_roots+0x113/0x2e0 [btrfs]
[13942886.428219]  [<ffffffffc04f02a4>] ? btrfs_run_delayed_refs+0x204/0x2b0 [btrfs]
[13942886.428251]  [<ffffffffc05744b5>] ? btrfs_qgroup_account_extents+0x85/0x180 [btrfs]
[13942886.428280]  [<ffffffffc050707c>] ? btrfs_commit_transaction+0x4dc/0xa10 [btrfs]
[13942886.428306]  [<ffffffffc0507646>] ? start_transaction+0x96/0x480 [btrfs]
[13942886.428333]  [<ffffffffc0501a4c>] ? transaction_kthread+0x1dc/0x200 [btrfs]
[13942886.428358]  [<ffffffffc0501870>] ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
[13942886.428363]  [<ffffffffa52988e9>] ? kthread+0xd9/0xf0
[13942886.428368]  [<ffffffffa5298810>] ? kthread_park+0x60/0x60
[13942886.428372]  [<ffffffffa5814df7>] ? ret_from_fork+0x57/0x70
[13942886.428375] ---[ end trace 5167b44ab18fee6a ]---
[13942886.428379] BTRFS: error (device dm-1) in __btrfs_free_extent:6959: errno=-5 IO failure
[13942886.430140] BTRFS info (device dm-1): forced readonly
[13942886.430144] BTRFS: error (device dm-1) in btrfs_run_delayed_refs:2967: errno=-5 IO failure
[13942886.431954] BTRFS warning (device dm-1): Skipping commit of aborted transaction.
[13942886.431958] BTRFS: error (device dm-1) in cleanup_transaction:1850: errno=-5 IO failure
[13942886.433953] BTRFS error (device dm-1): pending csums is 1048576
[13943151.748688] btrfs_dev_stat_print_on_error: 32 callbacks suppressed
[13943151.748700] BTRFS error (device dm-1): bdev /dev/mapper/K1JGYJJD errs: wr 20, rd 2, flush 0, corrupt 0, gen 0
[13943151.750963] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 20, rd 2, flush 0, corrupt 0, gen 0

--nextPart2937021.njBEhWVQiJ
Content-Disposition: attachment; filename="20191028_syslog_trace.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="20191028_syslog_trace.txt"

Oct 28 21:07:35 kernel: [22575699.639844] btrfs_dev_stat_print_on_error: 151 callbacks suppressed
Oct 28 21:07:35 kernel: [22575699.639859] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798124, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.448265] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798125, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.456928] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798126, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.464365] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798127, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.470414] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798128, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.476524] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798129, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.482249] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798130, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.487931] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798131, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.493286] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798132, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.498637] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798133, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.503710] BTRFS error (device dm-1): bdev /dev/mapper/K1JG82AD errs: wr 15798134, rd 15764237, flush 4361, corrupt 0, gen 0
Oct 28 21:07:50 kernel: [22575714.532609] BTRFS warning (device dm-1): lost page write due to IO error on /dev/mapper/K1JG82AD
Oct 28 21:07:50 kernel: [22575714.686683] BTRFS warning (device dm-1): lost page write due to IO error on /dev/mapper/K1JG82AD
Oct 28 21:07:50 kernel: [22575714.686694] BTRFS warning (device dm-1): lost page write due to IO error on /dev/mapper/K1JG82AD
Oct 28 21:07:50 kernel: [22575714.686734] BTRFS warning (device dm-1): lost page write due to IO error on /dev/mapper/K1JG82AD
Oct 28 21:07:50 kernel: [22575714.693146] BTRFS warning (device dm-1): lost page write due to IO error on /dev/mapper/K1JG82AD
Oct 28 21:08:11 kernel: [22575735.017883] btrfs_dev_stat_print_on_error: 167 callbacks suppressed
...
Oct 28 21:10:58 kernel: [22575902.412741] BTRFS warning (device dm-1): lost page write due to IO error on /dev/mapper/K1JG82AD
Oct 28 21:10:58 kernel: [22575902.412753] BTRFS warning (device dm-1): lost page write due to IO error on /dev/mapper/K1JG82AD
Oct 28 21:10:58 kernel: [22575902.412761] BTRFS warning (device dm-1): lost page write due to IO error on /dev/mapper/K1JG82AD
Oct 28 22:14:56 kernel: [22579740.894360] ata3: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action 0xe frozen
Oct 28 22:14:56 kernel: [22579740.900000] ata3: irq_stat 0x00400040, connection status changed
Oct 28 22:14:56 kernel: [22579740.905262] ata3: SError: { PHYRdyChg 10B8B DevExch }
Oct 28 22:14:56 kernel: [22579740.910205] ata3: hard resetting link
Oct 28 22:14:56 kernel: [22579740.910251] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action 0xe frozen
Oct 28 22:14:56 kernel: [22579740.915268] ata4: irq_stat 0x00400040, connection status changed
Oct 28 22:14:56 kernel: [22579740.919644] ata4: SError: { PHYRdyChg 10B8B DevExch }
Oct 28 22:14:56 kernel: [22579740.924090] ata4: hard resetting link
Oct 28 22:15:02 kernel: [22579746.747303] ata3: link is slow to respond, please be patient (ready=0)
Oct 28 22:15:02 kernel: [22579746.783228] ata4: link is slow to respond, please be patient (ready=0)
Oct 28 22:15:05 kernel: [22579749.987500] ata3: SATA link down (SStatus 0 SControl 310)
Oct 28 22:15:05 kernel: [22579749.987509] ata3.00: link offline, clearing class 1 to NONE
Oct 28 22:15:06 kernel: [22579750.102050] ata3: hard resetting link
Oct 28 22:15:06 kernel: [22579750.939545] ata4: COMRESET failed (errno=-16)
Oct 28 22:15:06 kernel: [22579750.944784] ata4: hard resetting link
Oct 28 22:15:11 kernel: [22579755.451791] ata3: link is slow to respond, please be patient (ready=0)
Oct 28 22:15:12 kernel: [22579756.695842] ata4: link is slow to respond, please be patient (ready=0)
Oct 28 22:15:15 kernel: [22579759.096054] ata4: SATA link down (SStatus 0 SControl 310)
Oct 28 22:15:15 kernel: [22579759.096064] ata4.00: link offline, clearing class 1 to NONE
Oct 28 22:15:15 kernel: [22579759.184120] ata4: hard resetting link
Oct 28 22:15:15 kernel: [22579759.244021] ata3: SATA link down (SStatus 0 SControl 310)
Oct 28 22:15:15 kernel: [22579759.244031] ata3.00: link offline, clearing class 1 to NONE
Oct 28 22:15:15 kernel: [22579759.302538] ata3: hard resetting link
Oct 28 22:15:20 kernel: [22579764.536373] ata4: link is slow to respond, please be patient (ready=0)
Oct 28 22:15:20 kernel: [22579764.652375] ata3: link is slow to respond, please be patient (ready=0)
Oct 28 22:15:24 kernel: [22579768.432584] ata3: SATA link down (SStatus 0 SControl 310)
Oct 28 22:15:24 kernel: [22579768.432594] ata3.00: link offline, clearing class 1 to NONE
Oct 28 22:15:24 kernel: [22579768.432600] ata3.00: disabled
Oct 28 22:15:24 kernel: [22579768.432620] ata3: EH complete
Oct 28 22:15:24 kernel: [22579768.432681] ata3.00: detaching (SCSI 2:0:0:0)
Oct 28 22:15:24 kernel: [22579768.433252] sd 2:0:0:0: [sdb] Stopping disk
Oct 28 22:15:24 kernel: [22579768.433323] sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
...
Oct 28 23:03:58 kernel: [22582682.521731] BTRFS info (device dm-1): forced readonly
Oct 28 23:03:58 kernel: [22582682.521732] BTRFS warning (device dm-1): Skipping commit of aborted transaction.
Oct 28 23:03:58 kernel: [22582682.521733] ------------[ cut here ]------------
Oct 28 23:03:58 kernel: [22582682.521755] WARNING: CPU: 0 PID: 1659 at /build/linux-EbeuWA/linux-4.9.130/fs/btrfs/transaction.c:1850 cleanup_transaction+0x1f3/0x2e0 [btrfs]
Oct 28 23:03:58 kernel: [22582682.521756] BTRFS: Transaction aborted (error -5)
Oct 28 23:03:58 kernel: [22582682.521756] Modules linked in: fuse ufs qnx4 hfsplus hfs minix ntfs vfat msdos fat jfs xfs libcrc32c cpuid dm_crypt algif_skcipher af_alg dm_mod snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device ir_lirc_codec ir_rc5_decoder lirc_dev rc_hauppauge au8522_dig xc5000 tuner au8522_decoder au8522_common iTCO_wdt iTCO_vendor_support ip6t_REJECT nf_reject_ipv6 intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_hda_codec_hdmi kvm irqbypass arc4 crct10dif_pclmul crc32_pclmul xt_hl snd_hda_codec_realtek snd_hda_codec_generic ip6t_rt ghash_clmulni_intel rtl8723ae intel_cstate btcoexist rtl8723_common rtl_pci intel_uncore intel_rapl_perf rtlwifi i915 evdev serio_raw pcspkr snd_hda_intel mac80211 nf_conntrack_ipv6 nf_defrag_ipv6 snd_hda_codec au0828 btusb cfg80211 drm_kms_helper tveeprom
Oct 28 23:03:58 kernel: [22582682.521797]  snd_hda_core btrtl sg btbcm snd_hwdep btintel dvb_core snd_pcm rc_core v4l2_common bluetooth videobuf2_vmalloc snd_timer videobuf2_memops videobuf2_v4l2 videobuf2_core drm mei_me snd videodev rfkill i2c_algo_bit lpc_ich soundcore ipt_REJECT media shpchp mei mfd_core nf_reject_ipv4 xt_limit xt_tcpudp xt_addrtype video button ac nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack ip6table_filter ip6_tables nf_conntrack_netbios_ns nf_conntrack_broadcast nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack iptable_filter ip_tables x_tables autofs4 ext4 crc16 jbd2 fscrypto ecb mbcache btrfs crc32c_generic xor raid6_pq sd_mod hid_generic usbhid hid crc32c_intel aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd psmouse ahci libahci libata i2c_i801 scsi_mod i2c_smbus r8169 mii xhci_pci ehci_pci xhci_hcd e1000e ehci_hcd ptp pps_core usbcore usb_common fan thermal
Oct 28 23:03:58 kernel: [22582682.521846] CPU: 0 PID: 1659 Comm: btrfs-transacti Not tainted 4.9.0-8-amd64 #1 Debian 4.9.130-2
Oct 28 23:03:58 kernel: [22582682.521847] Hardware name: CompuLab Intense-PC/Intense-PC, BIOS CR_2.2.0.346 X64 11/25/2012
Oct 28 23:03:58 kernel: [22582682.521849]  0000000000000000 ffffffff9bd33d74 ffffb3d04273fd50 0000000000000000
Oct 28 23:03:58 kernel: [22582682.521851]  ffffffff9ba7a59e ffff94e6732621b8 ffffb3d04273fda8 ffff94e573994460
Oct 28 23:03:58 kernel: [22582682.521853]  00000000fffffffb ffff94e7c78f40c0 0000000000000000 ffffffff9ba7a61f
Oct 28 23:03:58 kernel: [22582682.521855] Call Trace:
Oct 28 23:03:58 kernel: [22582682.521861]  [<ffffffff9bd33d74>] ? dump_stack+0x5c/0x78
Oct 28 23:03:58 kernel: [22582682.521863]  [<ffffffff9ba7a59e>] ? __warn+0xbe/0xe0
Oct 28 23:03:58 kernel: [22582682.521865]  [<ffffffff9ba7a61f>] ? warn_slowpath_fmt+0x5f/0x80
Oct 28 23:03:58 kernel: [22582682.521878]  [<ffffffffc0346423>] ? cleanup_transaction+0x1f3/0x2e0 [btrfs]
Oct 28 23:03:58 kernel: [22582682.521880]  [<ffffffff9babd210>] ? prepare_to_wait_event+0xf0/0xf0
Oct 28 23:03:58 kernel: [22582682.521892]  [<ffffffffc0347e78>] ? btrfs_commit_transaction+0x298/0xa10 [btrfs]
Oct 28 23:03:58 kernel: [22582682.521903]  [<ffffffffc0348686>] ? start_transaction+0x96/0x480 [btrfs]
Oct 28 23:03:58 kernel: [22582682.521914]  [<ffffffffc0342a8c>] ? transaction_kthread+0x1dc/0x200 [btrfs]
Oct 28 23:03:58 kernel: [22582682.521924]  [<ffffffffc03428b0>] ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
Oct 28 23:03:58 kernel: [22582682.521926]  [<ffffffff9ba9a569>] ? kthread+0xd9/0xf0
Oct 28 23:03:58 kernel: [22582682.521928]  [<ffffffff9c0190a4>] ? __switch_to_asm+0x34/0x70
Oct 28 23:03:58 kernel: [22582682.521930]  [<ffffffff9ba9a490>] ? kthread_park+0x60/0x60
Oct 28 23:03:58 kernel: [22582682.521932]  [<ffffffff9c019137>] ? ret_from_fork+0x57/0x70
Oct 28 23:03:58 kernel: [22582682.521933] ---[ end trace 4d239283ca8f1b47 ]---
Oct 28 23:03:58 kernel: [22582682.521934] BTRFS: error (device dm-1) in cleanup_transaction:1850: errno=-5 IO failure
Oct 28 23:03:58 kernel: [22582682.523013] BTRFS info (device dm-1): delayed_refs has NO entry

--nextPart2937021.njBEhWVQiJ--



