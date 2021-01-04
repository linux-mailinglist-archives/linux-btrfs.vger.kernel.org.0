Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE422E9409
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 12:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhADLWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 06:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhADLWe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 06:22:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE79C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 03:21:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c5so31784174wrp.6
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Jan 2021 03:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uBbM4TOBymAJjeuT+tTYDeJYOQSUlG8rJ3ivdMG+KXE=;
        b=Y2kWeYY+qOkVKsSZgSRwCbxyLU5wibyeX0KpHqapr2LqtmPl6NSLsR38CRXD5y4m4J
         O6U8WGYyOLEtdT8uXX3cjq1y3qu81F0qompzmD6vvWZopngQbrAh2ILpnoTEh3CD0yDn
         t8B4WbFigPXACvxLIMQewq/DOw51iKbG7/JFqPDnV5+1gk6SXNCIi4g7BG21NbDdHroI
         XPvnk95zfB63CvqjYxNrU8OXGnyn6UnD0hAPP5id/rgfECGvSsKQdNh/+agbiKGcBdit
         doqb62ySFwagr8miBZa2O3u0RPOnDGz6t6ce30m/ehhyeyUrcdRoebwl3ZhMW0F7AuhL
         XYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uBbM4TOBymAJjeuT+tTYDeJYOQSUlG8rJ3ivdMG+KXE=;
        b=QXfme/jRxR2nBjVhcSfGsgzM2uddlfH3B3OLuN7aDzFty2pUKBT7xVKdc/MbBaOs+z
         mbTTeRWBT4THbZjVT8Jpbi40ROxDhgWeZ8jMUWLwASsAatAvoCxLtSlUPB68oyKZv75z
         w3GMe9VbOt4DPc5YB2OqtkjY9D2wrELNAR5EWTtizjgbv6/Eou04O75NVJQLU6OE7kem
         4D7sOCJNjyla3Brn6fA8AbWh5+sTbUBKoiUgIZQO65BAdsFwyJwrjCI/fMwwPvLenbKP
         kudk8FSRmaJaAcgltWgtsWTZQdoyNCPiNre6R1seCZWzLmuGs2XuqvljWAJEZlsCmr5/
         UDFg==
X-Gm-Message-State: AOAM531KzugUgsjWZ1B4fuc7FmDB/QPH5TGNSPDTJXpKTtn8e/h4+Q8G
        Ro8ZEehBmBkmqZdGU4CXrBQoAY+nCaM03aG5
X-Google-Smtp-Source: ABdhPJzbB2pfy7C0DrNR36xGzu0ayqvSUlTNS22oUj0cnbO3I45s7aIZ1niF4AFT2zIWThiL40mFeg==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr78902020wrq.358.1609759312408;
        Mon, 04 Jan 2021 03:21:52 -0800 (PST)
Received: from ?IPv6:2001:718:2:119a:147:32:132:32? ([2001:718:2:119a:147:32:132:32])
        by smtp.gmail.com with ESMTPSA id w13sm87548291wrt.52.2021.01.04.03.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 03:21:51 -0800 (PST)
Subject: Re: scrub and Transaction aborted (error -27)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <8d6ba4a6-3677-d5da-6323-599459febdc4@gmail.com>
 <2e41e8f9-bec2-dfd7-4912-59ed616ca9e1@gmx.com>
From:   =?UTF-8?Q?Miloslav_H=c5=afla?= <miloslav.hula@gmail.com>
Message-ID: <377513b6-e6ea-d94c-4b1f-90911e190b8f@gmail.com>
Date:   Mon, 4 Jan 2021 12:21:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2e41e8f9-bec2-dfd7-4912-59ed616ca9e1@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: cs
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dne 04.01.2021 v 11:36 Qu Wenruo napsal(a):
> On 2021/1/4 下午5:38, Miloslav Hůla wrote:
>> Hi,
>>
>> I run scrub every Sunday at 3 PM on a btrfs RAID-10 with e-mails. Last 
>> run failed resulting to a read-only filesystem. Then I found "BTRFS: 
>> Transaction aborted (error -27)" in kernel log. All I had to do was 
>> umount and mount filesystem and it was read-write again.
>>
>> This already happend once on November 15th (7 weeks ago) but I have no 
>> logs, I had to reboot the server.
>>
>> I cannot find any hint for error -27, only messages that's quite rare. 
>> Please, could someone tell what's wrong?
>>
>> Attached logs were made when filesystem was mounted read-only.
>>
>> Kind regards
>> Milo
>>
>>
>> # uname -a
>> Linux epsilon 4.19.0-12-amd64 #1 SMP Debian 4.19.152-1 (2020-10-18) 
>> x86_64 GNU/Linux
>>
>>
>> # dmesg
>> [3598202.069498] ------------[ cut here ]------------
>> [3598202.069501] BTRFS: Transaction aborted (error -27)
>> [3598202.069580] WARNING: CPU: 5 PID: 13266 at 
>> fs/btrfs/extent-tree.c:10132 
>> btrfs_create_pending_block_groups+0x1d2/0x200 [btrfs]
>> [3598202.069582] Modules linked in: xt_tcpudp xt_state xt_conntrack 
>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nfsv3 nfs_acl nfs lockd 
>> grace fscache ipt_REJECT nf_reject_ipv4 xt_multiport nft_compat 
>> nft_counter nf_tables nfnetlink intel_rapl sb_edac 
>> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipmi_ssif kvm 
>> irqbypass ast crct10dif_pclmul crc32_pclmul ttm ghash_clmulni_intel 
>> intel_cstate drm_kms_helper intel_uncore mxm_wmi intel_rapl_perf drm 
>> pcspkr joydev iTCO_wdt evdev iTCO_vendor_support mei_me mei sg 
>> pcc_cpufreq ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi 
>> acpi_power_meter acpi_pad button sunrpc ip_tables x_tables autofs4 
>> ext4 crc16 mbcache jbd2 fscrypto ecb btrfs zstd_decompress 
>> zstd_compress xxhash hid_generic usbhid hid raid10 raid456 
>> async_raid6_recov async_memcpy async_pq async_xor
>> [3598202.069619]  async_tx xor raid6_pq libcrc32c crc32c_generic raid1 
>> raid0 multipath ses linear enclosure md_mod sd_mod scsi_transport_sas 
>> crc32c_intel ahci libahci libata xhci_pci aesni_intel megaraid_sas 
>> xhci_hcd ehci_pci aes_x86_64 crypto_simd ehci_hcd igb cryptd scsi_mod 
>> glue_helper usbcore lpc_ich i2c_algo_bit i2c_i801 mfd_core dca usb_common
>> [3598202.069641] CPU: 5 PID: 13266 Comm: btrfs Not tainted 
>> 4.19.0-12-amd64 #1 Debian 4.19.152-1
>> [3598202.069642] Hardware name: Supermicro X10DRi/X10DRi, BIOS 2.1 
>> 09/13/2016
>> [3598202.069671] RIP: 
>> 0010:btrfs_create_pending_block_groups+0x1d2/0x200 [btrfs]
>> [3598202.069674] Code: ff 48 8b 45 50 f0 48 0f ba a8 00 17 00 00 02 72 
>> 1b 41 83 fc fb 0f 84 01 86 09 00 44 89 e6 48 c7 c7 08 b2 7c c0 e8 b8 
>> 4f 96 f9 <0f> 0b 44 89 e1 ba 94 27 00 00 48 c7 c6 60 09 7c c0 48 89 ef 
>> e8 cb
>> [3598202.069676] RSP: 0018:ffffa62d0854bb10 EFLAGS: 00010282
>> [3598202.069678] RAX: 0000000000000000 RBX: ffff9b18ac890520 RCX: 
>> 0000000000000006
>> [3598202.069679] RDX: 0000000000000007 RSI: 0000000000000082 RDI: 
>> ffff9b247f9566b0
>> [3598202.069681] RBP: ffff9b18c87b03a8 R08: 000000000000055c R09: 
>> 0000000000000004
>> [3598202.069682] R10: 0000000000000000 R11: 0000000000000001 R12: 
>> 00000000ffffffe5
>> [3598202.069683] R13: ffff9b18c87b0400 R14: ffff9b247b85e800 R15: 
>> ffff9b18c87b03a8
>> [3598202.069686] FS:  00007fbac28ec700(0000) GS:ffff9b247f940000(0000) 
>> knlGS:0000000000000000
>> [3598202.069687] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [3598202.069689] CR2: 0000561d53359f40 CR3: 000000137cf7c006 CR4: 
>> 00000000003606e0
>> [3598202.069691] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>> 0000000000000000
>> [3598202.069692] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>> 0000000000000400
>> [3598202.069693] Call Trace:
>> [3598202.069726]  do_chunk_alloc+0x22c/0x2d0 [btrfs]
>> [3598202.069754]  btrfs_inc_block_group_ro+0x103/0x150 [btrfs]
> 
> The back trace is exactly the same as the one described in upstream 
> commit b12de52896c0 ("btrfs: scrub: Don't check free space before 
> marking a block group RO").
> 
> So I guess you can run a newer kernel or backport it to your distro to 
> fix it.
> 
> Thanks,
> Qu

If I read kernel Git history correctly, commit is present since v5.5.

Thank you for the swift response.

Kind regards,
Milo


>> [3598202.069792]  scrub_enumerate_chunks+0x194/0x570 [btrfs]
>> [3598202.069838]  btrfs_scrub_dev+0x1f1/0x580 [btrfs]
>> [3598202.069889]  btrfs_ioctl+0xff4/0x2da0 [btrfs]
>> [3598202.069907]  do_vfs_ioctl+0xa4/0x630
>> [3598202.069912]  ? get_task_io_context+0x43/0x80
>> [3598202.069914]  ksys_ioctl+0x60/0x90
>> [3598202.069918]  ? __switch_to+0x115/0x440
>> [3598202.069920]  __x64_sys_ioctl+0x16/0x20
>> [3598202.069924]  do_syscall_64+0x53/0x110
>> [3598202.069928]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [3598202.069930] RIP: 0033:0x7fbac91ed427
>> [3598202.069933] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 
>> 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 
>> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 
>> 01 48
>> [3598202.069935] RSP: 002b:00007fbac28ebd38 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000010
>> [3598202.069937] RAX: ffffffffffffffda RBX: 00005591ef0b2ff0 RCX: 
>> 00007fbac91ed427
>> [3598202.069938] RDX: 00005591ef0b2ff0 RSI: 00000000c400941b RDI: 
>> 0000000000000003
>> [3598202.069939] RBP: 0000000000000000 R08: 00007fbac28ec700 R09: 
>> 0000000000000000
>> [3598202.069941] R10: 00007fbac28ec700 R11: 0000000000000246 R12: 
>> 00007ffdffc554ee
>> [3598202.069942] R13: 00007ffdffc554ef R14: 00007fbac28ec700 R15: 
>> 0000000000000000
>> [3598202.069945] ---[ end trace d195b72c12bda784 ]---
>> [3598202.069949] BTRFS: error (device sdb) in 
>> btrfs_create_pending_block_groups:10132: errno=-27 unknown
>> [3598202.070016] BTRFS info (device sdb): forced readonly
>> [3598202.075551] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598202.142927] imap[13399]: segfault at 20 ip 00007f5b98e60bd0 sp 
>> 00007fffca39cbf0 error 4 in 
>> libdovecot-storage.so.0.0.0[7f5b98e3e000+d1000]
>> [3598202.142939] Code: 00 00 48 89 44 24 18 48 8d 44 24 30 c7 44 24 14 
>> 30 00 00 00 48 89 44 24 20 e8 bc 44 fe ff 48 8d 74 24 10 48 89 ef 89 
>> 44 24 0c <f6> 43 20 02 74 4a e8 d5 2d fe ff 48 8b 3b 48 8d 35 22 04 0b 
>> 00 48
>> [3598202.697828] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598202.828602] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598202.924812] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598202.955959] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598202.968930] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598203.034119] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598203.188842] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598204.040988] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598204.056966] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598204.092814] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598205.617636] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598205.646359] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598206.406710] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598206.451829] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598206.571043] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598210.137727] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>> [3598210.143199] BTRFS warning (device sdb): failed setting block 
>> group ro: -30
>>
>>
>> # umount & mount
>> [3610958.483613] BTRFS info (device sdb): disk space caching is enabled
>> [3610958.483616] BTRFS info (device sdb): has skinny extents
>>
>>
>> # mount options
>> UUID=5b285a46-e55d-4191-924f-0884fa06edd8  /data  btrfs  noatime  0  2
>>
>>
>> # device stats
>> (all zeroes)
>>
>>
>> # fi df
>> Data, RAID10: total=3.88TiB, used=3.87TiB
>> System, RAID10: total=576.00MiB, used=336.00KiB
>> Metadata, RAID10: total=24.75GiB, used=19.63GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>
>>
>> # fi show
>> Label: 'DATA'  uuid: 5b285a46-e55d-4191-924f-0884fa06edd8
>>          Total devices 18 FS bytes used 3.89TiB
>>          devid    1 size 558.41GiB used 444.81GiB path /dev/sdb
>>          devid    2 size 558.41GiB used 444.81GiB path /dev/sdc
>>          devid    4 size 558.41GiB used 444.81GiB path /dev/sde
>>          devid    5 size 558.41GiB used 444.81GiB path /dev/sdf
>>          devid    7 size 558.41GiB used 444.81GiB path /dev/sdh
>>          devid    8 size 558.41GiB used 444.81GiB path /dev/sdi
>>          devid    9 size 558.41GiB used 444.81GiB path /dev/sdg
>>          devid   10 size 558.41GiB used 444.81GiB path /dev/sdj
>>          devid   11 size 558.41GiB used 444.81GiB path /dev/sdk
>>          devid   13 size 558.41GiB used 444.81GiB path /dev/sdl
>>          devid   14 size 558.41GiB used 444.81GiB path /dev/sdd
>>          devid   15 size 558.41GiB used 444.81GiB path /dev/sdm
>>          devid   16 size 558.41GiB used 444.81GiB path /dev/sdn
>>          devid   17 size 558.41GiB used 444.81GiB path /dev/sdo
>>          devid   18 size 837.84GiB used 444.81GiB path /dev/sdp
>>          devid   19 size 837.84GiB used 444.81GiB path /dev/sda
>>          devid   20 size 837.84GiB used 444.81GiB path /dev/sdq
>>          devid   21 size 837.84GiB used 444.81GiB path /dev/sdr
>>
>>
>> # fi usage
>> Overall:
>>      Device size:                  10.91TiB
>>      Device allocated:              7.82TiB
>>      Device unallocated:            3.09TiB
>>      Device missing:                  0.00B
>>      Used:                          7.78TiB
>>      Free (estimated):              1.56TiB      (min: 1.56TiB)
>>      Data ratio:                       2.00
>>      Metadata ratio:                   2.00
>>      Global reserve:              512.00MiB      (used: 0.00B)
>>
>> Data,RAID10: Size:3.88TiB, Used:3.87TiB
>>     /dev/sda      442.00GiB
>>     /dev/sdb      442.00GiB
>>     /dev/sdc      442.00GiB
>>     /dev/sdd      442.00GiB
>>     /dev/sde      442.00GiB
>>     /dev/sdf      442.00GiB
>>     /dev/sdg      442.00GiB
>>     /dev/sdh      442.00GiB
>>     /dev/sdi      442.00GiB
>>     /dev/sdj      442.00GiB
>>     /dev/sdk      442.00GiB
>>     /dev/sdl      442.00GiB
>>     /dev/sdm      442.00GiB
>>     /dev/sdn      442.00GiB
>>     /dev/sdo      442.00GiB
>>     /dev/sdp      442.00GiB
>>     /dev/sdq      442.00GiB
>>     /dev/sdr      442.00GiB
>>
>> Metadata,RAID10: Size:24.75GiB, Used:19.63GiB
>>     /dev/sda        2.75GiB
>>     /dev/sdb        2.75GiB
>>     /dev/sdc        2.75GiB
>>     /dev/sdd        2.75GiB
>>     /dev/sde        2.75GiB
>>     /dev/sdf        2.75GiB
>>     /dev/sdg        2.75GiB
>>     /dev/sdh        2.75GiB
>>     /dev/sdi        2.75GiB
>>     /dev/sdj        2.75GiB
>>     /dev/sdk        2.75GiB
>>     /dev/sdl        2.75GiB
>>     /dev/sdm        2.75GiB
>>     /dev/sdn        2.75GiB
>>     /dev/sdo        2.75GiB
>>     /dev/sdp        2.75GiB
>>     /dev/sdq        2.75GiB
>>     /dev/sdr        2.75GiB
>>
>> System,RAID10: Size:576.00MiB, Used:336.00KiB
>>     /dev/sda       64.00MiB
>>     /dev/sdb       64.00MiB
>>     /dev/sdc       64.00MiB
>>     /dev/sdd       64.00MiB
>>     /dev/sde       64.00MiB
>>     /dev/sdf       64.00MiB
>>     /dev/sdg       64.00MiB
>>     /dev/sdh       64.00MiB
>>     /dev/sdi       64.00MiB
>>     /dev/sdj       64.00MiB
>>     /dev/sdk       64.00MiB
>>     /dev/sdl       64.00MiB
>>     /dev/sdm       64.00MiB
>>     /dev/sdn       64.00MiB
>>     /dev/sdo       64.00MiB
>>     /dev/sdp       64.00MiB
>>     /dev/sdq       64.00MiB
>>     /dev/sdr       64.00MiB
>>
>> Unallocated:
>>     /dev/sda      393.03GiB
>>     /dev/sdb      113.59GiB
>>     /dev/sdc      113.59GiB
>>     /dev/sdd      113.59GiB
>>     /dev/sde      113.59GiB
>>     /dev/sdf      113.59GiB
>>     /dev/sdg      113.59GiB
>>     /dev/sdh      113.59GiB
>>     /dev/sdi      113.59GiB
>>     /dev/sdj      113.59GiB
>>     /dev/sdk      113.59GiB
>>     /dev/sdl      113.59GiB
>>     /dev/sdm      113.59GiB
>>     /dev/sdn      113.59GiB
>>     /dev/sdo      113.59GiB
>>     /dev/sdp      393.03GiB
>>     /dev/sdq      393.03GiB
>>     /dev/sdr      393.03GiB
>>
>>
>> # scrub status -d
>> scrub status for 5b285a46-e55d-4191-924f-0884fa06edd8
>> scrub device /dev/sdb (id 1) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:08
>>          total bytes scrubbed: 1023.94MiB with 0 errors
>> scrub device /dev/sdc (id 2) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:08
>>          total bytes scrubbed: 1023.94MiB with 0 errors
>> scrub device /dev/sde (id 4) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:08
>>          total bytes scrubbed: 1023.94MiB with 0 errors
>> scrub device /dev/sdf (id 5) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:08
>>          total bytes scrubbed: 1023.94MiB with 0 errors
>> scrub device /dev/sdh (id 7) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:09
>>          total bytes scrubbed: 1023.94MiB with 0 errors
>> scrub device /dev/sdi (id 8) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:07
>>          total bytes scrubbed: 1023.94MiB with 0 errors
>> scrub device /dev/sdg (id 9) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:08
>>          total bytes scrubbed: 1023.94MiB with 0 errors
>> scrub device /dev/sdj (id 10) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:12
>>          total bytes scrubbed: 1.99GiB with 0 errors
>> scrub device /dev/sdk (id 11) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:12
>>          total bytes scrubbed: 1.99GiB with 0 errors
>> scrub device /dev/sdl (id 13) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:12
>>          total bytes scrubbed: 2.00GiB with 0 errors
>> scrub device /dev/sdd (id 14) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:08
>>          total bytes scrubbed: 1023.94MiB with 0 errors
>> scrub device /dev/sdm (id 15) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:11
>>          total bytes scrubbed: 2.00GiB with 0 errors
>> scrub device /dev/sdn (id 16) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:11
>>          total bytes scrubbed: 2.00GiB with 0 errors
>> scrub device /dev/sdo (id 17) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:08
>>          total bytes scrubbed: 1021.71MiB with 0 errors
>> scrub device /dev/sdp (id 18) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:15
>>          total bytes scrubbed: 2.00GiB with 0 errors
>> scrub device /dev/sda (id 19) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:15
>>          total bytes scrubbed: 2.00GiB with 0 errors
>> scrub device /dev/sdq (id 20) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:09
>>          total bytes scrubbed: 1.10GiB with 0 errors
>> scrub device /dev/sdr (id 21) history
>>          scrub started at Sun Jan  3 15:00:01 2021 and was aborted 
>> after 00:00:09
>>          total bytes scrubbed: 1.10GiB with 0 errors
>>
>>
>> # device usage
>> /dev/sda, ID: 19
>>     Device size:           837.84GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           393.03GiB
>>
>> /dev/sdb, ID: 1
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdc, ID: 2
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdd, ID: 14
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sde, ID: 4
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdf, ID: 5
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdf, ID: 5
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdg, ID: 9
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdh, ID: 7
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdi, ID: 8
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdj, ID: 10
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdk, ID: 11
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdl, ID: 13
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdm, ID: 15
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdn, ID: 16
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdo, ID: 17
>>     Device size:           558.41GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           113.59GiB
>>
>> /dev/sdp, ID: 18
>>     Device size:           837.84GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           393.03GiB
>>
>> /dev/sdq, ID: 20
>>     Device size:           837.84GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           393.03GiB
>>
>> /dev/sdr, ID: 21
>>     Device size:           837.84GiB
>>     Device slack:              0.00B
>>     Data,RAID10:           442.00GiB
>>     Metadata,RAID10:         2.75GiB
>>     System,RAID10:          64.00MiB
>>     Unallocated:           393.03GiB
>>
>>
>> # megaclisas-status
>> -- Controller information --
>> -- ID | H/W Model                  | RAM    | Temp | BBU    | Firmware
>> c0    | AVAGO MegaRAID SAS 9361-8i | 1024MB | 70C  | Good   | FW: 
>> 24.16.0-0082
>>
>> -- Array information --
>> -- ID | Type   |    Size |  Strpsz | Flags | DskCache |   Status |  OS 
>> Path | CacheCade |InProgress
>> c0u0  | RAID-0 |    838G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sda | None      |None
>> c0u1  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdb | None      |None
>> c0u2  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdc | None      |None
>> c0u3  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdd | None      |None
>> c0u4  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sde | None      |None
>> c0u5  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdf | None      |None
>> c0u6  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdg | None      |None
>> c0u7  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdh | None      |None
>> c0u8  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdi | None      |None
>> c0u9  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdj | None      |None
>> c0u10 | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdk | None      |None
>> c0u11 | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdl | None      |None
>> c0u12 | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdm | None      |None
>> c0u13 | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdn | None      |None
>> c0u14 | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdo | None      |None
>> c0u15 | RAID-0 |    838G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdp | None      |None
>> c0u16 | RAID-0 |    838G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdq | None      |None
>> c0u17 | RAID-0 |    838G |  256 KB | RA,WB |  Enabled |  Optimal | 
>> /dev/sdr | None      |None
>>
>> -- Disk information --
>> -- ID   | Type | Drive Model                                     | 
>> Size     | Status          | Speed    | Temp | Slot ID  | LSI ID
>> c0u0p0  | HDD  | SEAGATE ST900MP0006 N003WAG0Q3S3                | 
>> 837.8 Gb | Online, Spun Up | 12.0Gb/s | 55C  | [8:14]   | 32
>> c0u1p0  | HDD  | HGST HUC156060CSS200 A3800XV250TJ               | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 35C  | [8:0]    | 12
>> c0u2p0  | HDD  | HGST HUC156060CSS200 A3800XV3XT4J               | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 40C  | [8:1]    | 11
>> c0u3p0  | HDD  | HGST HUC156060CSS200 ADB05ZG4XLZU               | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 43C  | [8:2]    | 25
>> c0u4p0  | HDD  | HGST HUC156060CSS200 A3800XV3DWRL               | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 45C  | [8:3]    | 14
>> c0u5p0  | HDD  | HGST HUC156060CSS200 A3800XV3XZTL               | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 49C  | [8:4]    | 18
>> c0u6p0  | HDD  | HGST HUC156060CSS200 A3800XV3VSKJ               | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 52C  | [8:5]    | 15
>> c0u7p0  | HDD  | SEAGATE ST600MP0006 N003WAF1LWKE                | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 54C  | [8:6]    | 28
>> c0u8p0  | HDD  | HGST HUC156060CSS200 A3800XV3XTDJ               | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 53C  | [8:7]    | 20
>> c0u9p0  | HDD  | HGST HUC156060CSS200 A3800XV3T8XL               | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 54C  | [8:8]    | 19
>> c0u10p0 | HDD  | HGST HUC156060CSS200 A7030XHL0ZYP               | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 58C  | [8:9]    | 23
>> c0u11p0 | HDD  | HGST HUC156060CSS200 ADB05ZG4VR3P               | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 56C  | [8:10]   | 24
>> c0u12p0 | HDD  | SEAGATE ST600MP0006 N003WAF195KA                | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 55C  | [8:11]   | 29
>> c0u13p0 | HDD  | SEAGATE ST600MP0006 N003WAF1LTZW                | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 53C  | [8:12]   | 26
>> c0u14p0 | HDD  | SEAGATE ST600MP0006 N003WAF1LWH6                | 
>> 558.4 Gb | Online, Spun Up | 12.0Gb/s | 54C  | [8:13]   | 27
>> c0u15p0 | HDD  | SEAGATE ST900MP0006 N003WAG0Q414                | 
>> 837.8 Gb | Online, Spun Up | 12.0Gb/s | 52C  | [8:15]   | 33
>> c0u16p0 | HDD  | SEAGATE ST900MP0006 N003WAG0Q3LX                | 
>> 837.8 Gb | Online, Spun Up | 12.0Gb/s | 48C  | [8:16]   | 34
>> c0u17p0 | HDD  | SEAGATE ST900MP0006 N003WAG0QVN9                | 
>> 837.8 Gb | Online, Spun Up | 12.0Gb/s | 44C  | [8:17]   | 30
