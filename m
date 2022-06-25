Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B1D55A8D6
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jun 2022 12:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiFYKfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jun 2022 06:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiFYKe7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jun 2022 06:34:59 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E139D13F61
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jun 2022 03:34:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id E03B13F26B;
        Sat, 25 Jun 2022 12:34:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.911
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LSmMqlKipM_W; Sat, 25 Jun 2022 12:34:53 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 98E7C3F225;
        Sat, 25 Jun 2022 12:34:53 +0200 (CEST)
Received: from [192.168.0.134] (port=35242)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1o537r-0004Op-K5; Sat, 25 Jun 2022 12:34:52 +0200
Message-ID: <fff49ead-365a-111d-98a4-21fea92164fb@tnonline.net>
Date:   Sat, 25 Jun 2022 12:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: FSTRIM timeout/errors on WD RED SA500 NAS SSD
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <98c43f5e-2091-b222-edad-632caef9f9e3@tnonline.net>
 <4f9fcd17-8b2c-afaf-b512-c8786320f148@gmx.com>
From:   Forza <forza@tnonline.net>
In-Reply-To: <4f9fcd17-8b2c-afaf-b512-c8786320f148@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/25/22 08:44, Qu Wenruo wrote:
> 
> 
> On 2022/6/24 23:23, Forza wrote:
>> Hi,
>>
>> I have discovered an odd issue where "fstrim" on an Btrfs filesystem
>> consistently fails, while "mkfs.btrfs" always succeeds with full device
>> discard.
>>
>> Hardware:
>> * SuperMicro server
>> * LSI/Broadcom HBA 9500-8i SAS/SATA controller
>> * WD RED SA500 NAS SATA SSD 2TB (WDS200T1R0A-68A4W0)
>>    Drive FW: 411000WR
>> * Alpine Linux kernel 5.15.48
>>
>> * /sys/block/sdf/queue/
>>    discard_granularity:512
>>    discard_max_bytes:134217216
>>    discard_max_hw_bytes:134217216
> 
> Weird, it's 128M - 512, not sure if this is related.

The Kimgston SEDC500R960G SSD has the same values and there is no issue 
with that one.

> 
>>
>> # btrfs fi us -T /mnt/nas_ssd/
>> Overall:
>>      Device size:                   7.13TiB
>>      Device allocated:             90.06GiB
>>      Device unallocated:            7.04TiB
> 
> Btrfs will definitely try to submit a large bio to do discard on all
> those unallocated space.
> 
> Considering EXT4 has its block group headers taking up space, I guess it
> will not submit large enough discard bio to trigger the problem.
> 
>>      Device missing:                  0.00B
>>      Used:                         86.73GiB
>>      Free (estimated):              3.52TiB      (min: 3.52TiB)
>>      Free (statfs, df):             3.52TiB
>>      Data ratio:                       2.00
>>      Metadata ratio:                   2.00
>>      Global reserve:               94.58MiB      (used: 0.00B)
>>      Multiple profiles:                  no
>>
>>               Data     Metadata  System
>> Id Path      RAID1    RAID1     RAID1    Unallocated
>> -- --------- -------- --------- -------- -----------
>>   9 /dev/sdc1 44.00GiB   1.00GiB 32.00MiB     1.77TiB
>> 10 /dev/sdf1 44.00GiB   1.00GiB 32.00MiB     1.77TiB
>> 11 /dev/sdd1        -         -        -   894.25GiB
>> 12 /dev/sde1        -         -        -   894.25GiB
>> 13 /dev/sdg1        -         -        -     1.82TiB
>> 14 /dev/sdh1        -         -        -     1.82TiB
>> -- --------- -------- --------- -------- -----------
>>     Total     44.00GiB   1.00GiB 32.00MiB     8.94TiB
>>     Used      43.23GiB 133.44MiB 16.00KiB
>>
>>
>>
>>
>> The root cause I believe is that the WD drives take 1.5-2.5 minutes to
>> do a full device discard. The Kingston DC500 drives only take 6-7
>> seconds for the same. I have 4 identical WD drives and 2 Kingston
>> drives. All WD drives have the same issue.
>>
>> When issuing 'fstrim -v /mnt/btrfs' I get the following message in dmesg
>> after about 30 seconds:
>>
>> # time fstrim -v /mnt/nas_ssd/
>> /mnt/nas_ssd/: 6.2 TiB (6834839748608 bytes) trimmed
>>
>> real    4m21.356s
>> user    0m0.001s
>> sys     0m0.241s
>>
>> [  +0.000003] scsi target6:0:4: handle(0x0029),
>> sas_address(0x5003048020db4543), phy(3)
>> [  +0.000003] scsi target6:0:4: enclosure logical
>> id(0x5003048020db457f), slot(3)
>> [  +0.000003] scsi target6:0:4: enclosure level(0x0000), connector name(
>> C0.1)
>> [  +0.000003] sd 6:0:4:0: No reference found at driver, assuming
>> scmd(0x00000000eb0d9438) might have completed
>> [  +0.000003] sd 6:0:4:0: task abort: SUCCESS scmd(0x00000000eb0d9438)
>> [  +0.000012] sd 6:0:4:0: attempting task
>> abort!scmd(0x0000000075f63919), outstanding for 30397 ms & timeout 
>> 30000 ms
>> [  +0.000003] sd 6:0:4:0: [sdg] tag#2762 CDB: opcode=0x42 42 00 00 00 00
>> 00 00 00 18 00
>> [  +0.000002] scsi target6:0:4: handle(0x0029),
>> sas_address(0x5003048020db4543), phy(3)
>> [  +0.000004] scsi target6:0:4: enclosure logical
>> id(0x5003048020db457f), slot(3)
>> [  +0.000002] scsi target6:0:4: enclosure level(0x0000), connector name(
>> C0.1)
>> [  +0.000003] sd 6:0:4:0: No reference found at driver, assuming
>> scmd(0x0000000075f63919) might have completed
>> [  +0.000003] sd 6:0:4:0: task abort: SUCCESS scmd(0x0000000075f63919)
>> [  +0.255021] sd 6:0:4:0: Power-on or device reset occurred
> 
> Just want to make sure it's not btrfs screwing up things, mind to use
> blktrace to trace the bio submitted so we can make sure btrfs is doing
> its work correct?

Sure. Not an expert in making dev builds on Alpine but I think I got it 
correct. Output is too large to be attached. See links to download the 
trace files.

1) running blkdiscard /dev/sdf1
https://paste.tnonline.net/files/MYymVOfP4ROQ_blktrace.tar.xz

2) running mkfs.btrfs /dev/sdf1
https://paste.tnonline.net/files/5UUvxYlQD46Q_blktrace_mkfs.tar.xz

3) running fstrim on mounted btrfs
https://paste.tnonline.net/files/gultxaa7OP8P_blktrace_fstrim.tar.xz
https://paste.tnonline.net/files/8Vy7D0uR2Mk5_dmesg_fstrim.txt

Thanks,
Forza

> 
> Thanks,
> Qu
>>
>>
>>
>>
>> An interesting observation is that "fstrim" works on the same device if
>> it is mounted as ext4. There are no errors in dmesg.
>>
>> To sum up:
>>
>> Works:
>> * "mkfs.btrfs"
>> * "btrfs replace"
>> * "btrfs device add"
>> * "fstrim" on ext4 mounted device.
>>
>> Does not work:
>> * "fstrim" on Btrfs mounted device
>> * "blkdiscard" on /dev/sdX
>>
>> The btrfs-progs code seems to do 'BLKDISCARD' on 1GiB chunks. This may
>> explain why "mkfs.btrfs" and "btrfs relace" and "btrfs device add"
>> works, while "fstrim" and "blkdiscard" tools do not.
>> https://github.com/kdave/btrfs-progs/blob/c0ad9bde429196db7e8710ea1abfab7a2bca2e43/common/device-utils.c#L79 
>>
>>
>>
>> Not exactly sure how ext4 handles the "fstrim" case, but it seems to
>> group trim requests in smaller batches, which may explain why the SSD
>> returns status before the 30s timeout of the HBA.
>> https://github.com/torvalds/linux/blob/92f20ff72066d8d7e2ffb655c2236259ac9d1c5d/fs/ext4/mballoc.c#L6467 
>>
>>
>>
>> Can we work around the Btrfs fstrim issue, for example by splitting up
>> fstrim requests in "discard_max_bytes" sized chunks?
>>
>> Thanks,
>> Forza
