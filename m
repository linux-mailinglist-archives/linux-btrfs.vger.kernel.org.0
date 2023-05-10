Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA266FE15E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbjEJPOU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 11:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbjEJPOT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 11:14:19 -0400
Received: from sm-r-016-dus.org-dns.com (sm-r-016-dus.org-dns.com [89.107.70.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506ED1BD3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 08:14:14 -0700 (PDT)
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
        by smarthost-dus.org-dns.com (Postfix) with ESMTP id 54DB1A1DAC
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 17:14:12 +0200 (CEST)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
        id 40931A05A6; Wed, 10 May 2023 17:14:12 +0200 (CEST)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smarthost-dus.org-dns.com (Postfix) with ESMTPS id 98FD7A0556;
        Wed, 10 May 2023 17:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=friedels.name;
        s=default; t=1683731654;
        bh=iQhhD4Zv129RZsspOTDSD5oiGw2N8ycp2HpWlOcT2lo=;
        h=Received:From:To:Subject;
        b=r5Z4yS4xmZCg1LCES/qmRHFDyjmHVIzePHNeEPzDXtmTfk5zeYIovH8U2/JmQ5xvT
         XIfBL2736AMNKmoA/XvfX2nMjdTQ2ZRJzKsK+ViczkmwSFjQGkLKtonzI0e9GkomHS
         rzDSgrOp5nS2imuX4xo6JkfqH3Ro8PcUZYeFoLdA=
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 127.0.0.1) smtp.mailfrom=hendrik@friedels.name smtp.helo=ha01s030.org-dns.com
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
Received: from [94.31.96.101] ([94.31.96.101]) by webmail.friedels.name
 (Horde Framework) with HTTPS; Wed, 10 May 2023 17:14:13 +0200
Date:   Wed, 10 May 2023 17:14:13 +0200
Message-ID: <20230510171413.Horde.Hni1DVgjm4BqVg4XdHnLRsT@webmail.friedels.name>
From:   hendrik@friedels.name
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Scrub errors unable to fixup (regular) error
References: <25249f22-7e1b-43bf-9586-91c9803e4c28@email.android.com>
 <f941dacc-89f0-a9bc-a81a-aaf18d4fad47@gmail.com>
 <em3a7de55d-2b2b-45f6-9ecd-0725bd9bbace@59307873.com>
 <760e7198-4360-d68f-83fd-5ff27be57db5@gmx.com>
 <20230508205117.Horde.RK1QaW1dK8JHObLzII7D9cs@webmail.friedels.name>
 <6528e2b3-cc84-2faa-29e5-9a26fe1685a7@gmx.com>
 <20230509192639.Horde.QxWaLhyEPB3pLQHuBQtufoy@webmail.friedels.name>
 <6a175825-67a5-89f5-8456-6ffcf492ee9f@suse.com>
In-Reply-To: <6a175825-67a5-89f5-8456-6ffcf492ee9f@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <168373165399.19412.18313356656235316384@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks Qu,

compiling (and make install) worked.
However, I still get no list of the affected files:
root@homeserver:/home/henfri# btrfs inspect-internal logical-resolve  
256655245312 /mnt/temp/
/dev/sda3 on /mnt/temp type btrfs  
(rw,relatime,ssd,space_cache,subvolid=5,subvol=/)

Are the NNNNNNN (here 256655245312) changing after reboot?
I did in the meantime reboot, so currently the dmesg does not have any  
errors...
Do I need to run scrub again?

Greetings,
Hendrik


Quoting Qu Wenruo <wqu@suse.com>:

> On 2023/5/10 01:26, hendrik@friedels.name wrote:
>> Hi Qu,
>>
>> thanks for your reply.
>>
>> I feel a bit helpless:
>> wget  
>> https://github.com/kdave/btrfs-progs/archive/16f9a8f43a4ed6984349b502151049212838e6a0.zip
>> unpack, change into dir
>> patch --dry-run -ruN --strip 1 < ../patch
>>
>> checking file Documentation/btrfs-inspect-internal.rst
>> checking file cmds/inspect.c
>> Hunk #1 FAILED at 167.
>> Hunk #2 FAILED at 216.
>> Hunk #3 FAILED at 258.
>> 3 out of 3 hunks FAILED
>> checking file common/utils.c
>> Hunk #1 FAILED at 424.
>> Hunk #2 succeeded at 528 with fuzz 1.
>> 1 out of 2 hunks FAILED
>> checking file tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>> Hunk #1 FAILED at 51.
>> 1 out of 1 hunk FAILED
>>
>> What am I doing wrong?
>
> Please grab this branch directly:
>
> https://github.com/adam900710/btrfs-progs/tree/logic_resolve
>
> You can go git command to fetch that branch or through the webUI to  
> download the zip.
>
> Thanks,
> Qu
>>
>> Best regards,
>> Hendrik
>>
>>
>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>> On 2023/5/9 02:51, hendrik@friedels.name wrote:
>>>> Dear Qu,
>>>>
>>>> great, thank you!
>>>> Can you tell me, where to find the basis for this patch?
>>>>
>>>> I tried to patch against master of  
>>>> https://github.com/kdave/btrfs-progs, but that seems wrong:
>>>>
>>>> checking file Documentation/btrfs-inspect-internal.rst
>>>> checking file cmds/inspect.c
>>>> Hunk #1 FAILED at 167.
>>>> Hunk #2 FAILED at 216.
>>>> Hunk #3 FAILED at 258.
>>>> 3 out of 3 hunks FAILED
>>>> checking file common/utils.c
>>>> Hunk #1 FAILED at 424.
>>>> Hunk #2 succeeded at 528 with fuzz 1.
>>>> 1 out of 2 hunks FAILED
>>>> checking file  
>>>> tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>>>> Hunk #1 FAILED at 51.
>>>> 1 out of 1 hunk FAILED
>>>>
>>>> I have also tried to patch against v6.3 also with failed Hunks.
>>>
>>> It needs to be applied to David's devel branch.
>>>
>>> I applied against 16f9a8f43a4ed6984349b502151049212838e6a0  
>>> btrfs-progs: build: enable -Wmissing-prototypes, and it works as  
>>> expected.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Best regards,
>>>> Hendrik
>>>>
>>>>
>>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>
>>>>> On 2023/4/5 16:41, Hendrik Friedel wrote:
>>>>>> Hello Andrei,
>>>>>>
>>>>>> this partially works:
>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal  
>>>>>> logical-resolve 254530580480
>>>>>
>>>>> The user interface of logical-resolve is a total mess, it  
>>>>> requires every subvolume to be mounted.
>>>>>
>>>>> You can apply this patch, and mount the subvolid 5, then  
>>>>> logical-resolve would properly handle all the path lookup:
>>>>>
>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/7ccf52d35fdcdf743a254f3c93065f9334d878f8.1681971385.git.wqu@suse.com/
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>> inode 22214605 subvol dockerconfig/.snapshots/582/snapshot  
>>>>>> could not be accessed: not mounted
>>>>>> inode 22214605 subvol dockerconfig/.snapshots/586/snapshot  
>>>>>> could not be accessed: not mounted
>>>>>> inode 22214605 subvol dockerconfig/.snapshots/583/snapshot  
>>>>>> could not be accessed: not mounted
>>>>>> inode 22214605 subvol dockerconfig/.snapshots/584/snapshot  
>>>>>> could not be accessed: not mounted
>>>>>> inode 22214605 subvol dockerconfig/.snapshots/581/snapshot  
>>>>>> could not be accessed: not mounted
>>>>>> inode 22214605 subvol dockerconfig/.snapshots/585/snapshot  
>>>>>> could not be accessed: not mounted
>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal  
>>>>>> logical-resolve 224457719808  
>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal  
>>>>>> logical-resolve 196921389056  
>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal  
>>>>>> logical-resolve 254530899968  
>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>>
>>>>>> I do not quite understand, why it complains of the subvol not  
>>>>>> being mounted, as I have mounted the root-volume...
>>>>>>
>>>>>> However, it already shows that some of the files (all that I  
>>>>>> found) are in snapshots, which are read only...
>>>>>>
>>>>>> I am not sure, what the best way would be to get rid of the  
>>>>>> errors. Do you have any suggestion?
>>>>>>
>>>>>> Best regards,
>>>>>> Hendrik
>>>>>>
>>>>>> ------ Originalnachricht ------
>>>>>> Von "Andrei Borzenkov" <arvidjaar@gmail.com>
>>>>>> An "Hendrik Friedel" <hendrik@friedels.name>
>>>>>> Cc linux-btrfs@vger.kernel.org
>>>>>> Datum 04.04.2023 21:07:42
>>>>>> Betreff Re: Scrub errors unable to fixup (regular) error
>>>>>>
>>>>>>> On 03.04.2023 09:44, Hendrik Friedel wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> thanks.
>>>>>>>> Can you Tell ne, how I identify the affected files?
>>>>>>>>
>>>>>>>
>>>>>>> You could try
>>>>>>>
>>>>>>> btrfs inspect-internal logical-resolve NNNNN /btrfs/mount/point
>>>>>>>
>>>>>>> where NNNNN is logical address from kernel message
>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> Hendrik
>>>>>>>>
>>>>>>>> Am 03.04.2023 08:41 schrieb Andrei Borzenkov <arvidjaar@gmail.com>:
>>>>>>>>
>>>>>>>>      On Sun, Apr 2, 2023 at 10:26 PM Hendrik Friedel  
>>>>>>>> <hendrik@friedels.name> wrote:
>>>>>>>>       >
>>>>>>>>       > Hello,
>>>>>>>>       >
>>>>>>>>       > after a scrub, I had these errors:
>>>>>>>>       > [Sa Apr  1 23:23:28 2023] BTRFS info (device sda3):  
>>>>>>>> scrub: started on
>>>>>>>>       > devid 1
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> bdev /dev/sda3
>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 63, gen 0
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> unable to fixup
>>>>>>>>       > (regular) error at logical 2244718592 on dev /dev/sda3
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> bdev /dev/sda3
>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 64, gen 0
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> unable to fixup
>>>>>>>>       > (regular) error at logical 2260582400 on dev /dev/sda3
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> bdev /dev/sda3
>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 65, gen 0
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> bdev /dev/sda3
>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 66, gen 0
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> unable to fixup
>>>>>>>>       > (regular) error at logical 2260054016 on dev /dev/sda3
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> unable to fixup
>>>>>>>>       > (regular) error at logical 2259877888 on dev /dev/sda3
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> bdev /dev/sda3
>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 67, gen 0
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> unable to fixup
>>>>>>>>       > (regular) error at logical 2259935232 on dev /dev/sda3
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> bdev /dev/sda3
>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 68, gen 0
>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3):  
>>>>>>>> unable to fixup
>>>>>>>>       > (regular) error at logical 2264600576 on dev /dev/sda3
>>>>>>>>       >
>>>>>>>>       >
>>>>>>>>       > root@homeserver:~# btrfs scrub status /dev/sda3
>>>>>>>>       > UUID:             c1534c07-d669-4f55-ae50-b87669ecb259
>>>>>>>>       > Scrub started:    Sat Apr  1 23:24:01 2023
>>>>>>>>       > Status:           finished
>>>>>>>>       > Duration:         0:09:03
>>>>>>>>       > Total to scrub:   146.79GiB
>>>>>>>>       > Rate:             241.40MiB/s
>>>>>>>>       > Error summary:    csum=239
>>>>>>>>       >    Corrected:      0
>>>>>>>>       >    Uncorrectable:  239
>>>>>>>>       >    Unverified:     0
>>>>>>>>       > root@homeserver:~# btrfs fi show /dev/sda3
>>>>>>>>       > Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
>>>>>>>>       >          Total devices 1 FS bytes used 146.79GiB
>>>>>>>>       >          devid    1 size 198.45GiB used 198.45GiB  
>>>>>>>> path /dev/sda3
>>>>>>>>       >
>>>>>>>>       >
>>>>>>>>       > Smartctl tells me:
>>>>>>>>       > SMART Attributes Data Structure revision number: 16
>>>>>>>>       > Vendor Specific SMART Attributes with Thresholds:
>>>>>>>>       > ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
>>>>>>>>       > UPDATED  WHEN_FAILED RAW_VALUE
>>>>>>>>       >    1 Raw_Read_Error_Rate     0x002f   100   100   000  
>>>>>>>>    Pre-fail  Always
>>>>>>>>       >        -       2
>>>>>>>>       >    5 Reallocate_NAND_Blk_Cnt 0x0032   100   100   010  
>>>>>>>>    Old_age   Always
>>>>>>>>       >        -       2
>>>>>>>>       >    9 Power_On_Hours          0x0032   100   100   000  
>>>>>>>>    Old_age   Always
>>>>>>>>       >        -       4930
>>>>>>>>       >   12 Power_Cycle_Count       0x0032   100   100   000  
>>>>>>>>    Old_age   Always
>>>>>>>>       >        -       1864
>>>>>>>>       > 171 Program_Fail_Count      0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       0
>>>>>>>>       > 172 Erase_Fail_Count        0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       0
>>>>>>>>       > 173 Ave_Block-Erase_Count   0x0032   049   049   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       769
>>>>>>>>       > 174 Unexpect_Power_Loss_Ct  0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       22
>>>>>>>>       > 183 SATA_Interfac_Downshift 0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       0
>>>>>>>>       > 184 Error_Correction_Count  0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       0
>>>>>>>>       > 187 Reported_Uncorrect      0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       0
>>>>>>>>       > 194 Temperature_Celsius     0x0022   068   051   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       32 (Min/Max 9/49)
>>>>>>>>       > 196 Reallocated_Event_Count 0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       2
>>>>>>>>       > 197 Current_Pending_ECC_Cnt 0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       0
>>>>>>>>       > 198 Offline_Uncorrectable   0x0030   100   100   000   
>>>>>>>>   Old_age
>>>>>>>>       > Offline      -       0
>>>>>>>>       > 199 UDMA_CRC_Error_Count    0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       0
>>>>>>>>       > 202 Percent_Lifetime_Remain 0x0030   049   049   001   
>>>>>>>>   Old_age
>>>>>>>>       > Offline      -       51
>>>>>>>>       > 206 Write_Error_Rate        0x000e   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       0
>>>>>>>>       > 246 Total_LBAs_Written      0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       146837983747
>>>>>>>>       > 247 Host_Program_Page_Count 0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       4592609183
>>>>>>>>       > 248 FTL_Program_Page_Count  0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       4948954393
>>>>>>>>       > 180 Unused_Reserve_NAND_Blk 0x0033   000   000   000   
>>>>>>>>   Pre-fail  Always
>>>>>>>>       >        -       2050
>>>>>>>>       > 210 Success_RAIN_Recov_Cnt  0x0032   100   100   000   
>>>>>>>>   Old_age   Always
>>>>>>>>       >        -       0
>>>>>>>>       >
>>>>>>>>       > What would you recommend wrt. the health of the drive  
>>>>>>>> (ssd) and to fix
>>>>>>>>       > these errors?
>>>>>>>>       >
>>>>>>>>
>>>>>>>>      Scrub errors can only be corrected if the filesystem has  
>>>>>>>> redundancy.
>>>>>>>>      You have a single device which in the past defaulted to dup for
>>>>>>>>      metadata and single for data. If errors are in the data  
>>>>>>>> part, then the
>>>>>>>>      only way to fix it is to delete files containing these blocks.
>>>>>>>>
>>>>>>>>      Scrub error means data written to stable storage is bad. It is
>>>>>>>>      unlikely caused by SSD error, could be software bug,  
>>>>>>>> could be faulty
>>>>>>>>      RAM.
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>>>
>>>>
>>
>>
>>



