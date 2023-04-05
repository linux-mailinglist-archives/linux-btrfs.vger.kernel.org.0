Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944386D7721
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 10:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbjDEIlW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 04:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjDEIlV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 04:41:21 -0400
Received: from sm-r-006-dus.org-dns.com (sm-r-006-dus.org-dns.com [84.19.1.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC342713
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 01:41:19 -0700 (PDT)
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
        by smarthost-dus.org-dns.com (Postfix) with ESMTP id E97CEA1D74
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 10:41:16 +0200 (CEST)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
        id DC8FDA1E45; Wed,  5 Apr 2023 10:41:16 +0200 (CEST)
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smarthost-dus.org-dns.com (Postfix) with ESMTPS id EAA6FA1D25;
        Wed,  5 Apr 2023 10:41:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=friedels.name;
        s=default; t=1680684167;
        bh=E0I/5PkdHvkokmrlHqRCo5MeQ79CHAq0yOu3qkIzn2o=; h=From:To:Subject;
        b=WJaYBavACayiL3AU7sRXyURhkesj0Z+0zuEsSd+pIZNNS6+zOrbGRUvIG2l2oP7s6
         h+dW7GDth4IY6ouhLoMBG3l1B6cD6JNmbWWsbbkqCbMmRlGBvFwQc9yKUcQB1xHsWB
         HkE35ZqOT9TSpi3b638Bq6AK33dYZK+S0Goq8Ua4=
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 94.31.96.101) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.41]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Andrei Borzenkov" <arvidjaar@gmail.com>
Subject: Re[2]: Scrub errors unable to fixup (regular) error
Cc:     linux-btrfs@vger.kernel.org
Date:   Wed, 05 Apr 2023 08:41:13 +0000
Message-Id: <em3a7de55d-2b2b-45f6-9ecd-0725bd9bbace@59307873.com>
In-Reply-To: <f941dacc-89f0-a9bc-a81a-aaf18d4fad47@gmail.com>
References: <25249f22-7e1b-43bf-9586-91c9803e4c28@email.android.com>
 <f941dacc-89f0-a9bc-a81a-aaf18d4fad47@gmail.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: <168068416706.18041.14331304367788433314@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Andrei,

this partially works:
root@homeserver:/home/henfri# btrfs inspect-internal logical-resolve=20
254530580480=20
/srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
inode 22214605 subvol dockerconfig/.snapshots/582/snapshot could not be=20
accessed: not mounted
inode 22214605 subvol dockerconfig/.snapshots/586/snapshot could not be=20
accessed: not mounted
inode 22214605 subvol dockerconfig/.snapshots/583/snapshot could not be=20
accessed: not mounted
inode 22214605 subvol dockerconfig/.snapshots/584/snapshot could not be=20
accessed: not mounted
inode 22214605 subvol dockerconfig/.snapshots/581/snapshot could not be=20
accessed: not mounted
inode 22214605 subvol dockerconfig/.snapshots/585/snapshot could not be=20
accessed: not mounted
root@homeserver:/home/henfri# btrfs inspect-internal logical-resolve=20
224457719808=20
/srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
root@homeserver:/home/henfri# btrfs inspect-internal logical-resolve=20
196921389056=20
/srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
root@homeserver:/home/henfri# btrfs inspect-internal logical-resolve=20
254530899968=20
/srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/

I do not quite understand, why it complains of the subvol not being=20
mounted, as I have mounted the root-volume...

However, it already shows that some of the files (all that I found) are=20
in snapshots, which are read only...

I am not sure, what the best way would be to get rid of the errors. Do=20
you have any suggestion?

Best regards,
Hendrik

------ Originalnachricht ------
Von "Andrei Borzenkov" <arvidjaar@gmail.com>
An "Hendrik Friedel" <hendrik@friedels.name>
Cc linux-btrfs@vger.kernel.org
Datum 04.04.2023 21:07:42
Betreff Re: Scrub errors unable to fixup (regular) error

>On 03.04.2023 09:44, Hendrik Friedel wrote:
>>Hello,
>>
>>thanks.
>>Can you Tell ne, how I identify the affected files?
>>
>
>You could try
>
>btrfs inspect-internal logical-resolve NNNNN /btrfs/mount/point
>
>where NNNNN is logical address from kernel message
>
>>Best regards,
>>Hendrik
>>
>>Am 03.04.2023 08:41 schrieb Andrei Borzenkov <arvidjaar@gmail.com>:
>>
>>      On Sun, Apr 2, 2023 at 10:26=E2=80=AFPM Hendrik Friedel <hendrik@fr=
iedels.name> wrote:
>>       >
>>       > Hello,
>>       >
>>       > after a scrub, I had these errors:
>>       > [Sa Apr  1 23:23:28 2023] BTRFS info (device sda3): scrub: start=
ed on
>>       > devid 1
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/s=
da3
>>       > errs: wr 0, rd 0, flush 0, corrupt 63, gen 0
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to f=
ixup
>>       > (regular) error at logical 2244718592 on dev /dev/sda3
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/s=
da3
>>       > errs: wr 0, rd 0, flush 0, corrupt 64, gen 0
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to f=
ixup
>>       > (regular) error at logical 2260582400 on dev /dev/sda3
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/s=
da3
>>       > errs: wr 0, rd 0, flush 0, corrupt 65, gen 0
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/s=
da3
>>       > errs: wr 0, rd 0, flush 0, corrupt 66, gen 0
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to f=
ixup
>>       > (regular) error at logical 2260054016 on dev /dev/sda3
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to f=
ixup
>>       > (regular) error at logical 2259877888 on dev /dev/sda3
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/s=
da3
>>       > errs: wr 0, rd 0, flush 0, corrupt 67, gen 0
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to f=
ixup
>>       > (regular) error at logical 2259935232 on dev /dev/sda3
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/s=
da3
>>       > errs: wr 0, rd 0, flush 0, corrupt 68, gen 0
>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to f=
ixup
>>       > (regular) error at logical 2264600576 on dev /dev/sda3
>>       >
>>       >
>>       > root@homeserver:~# btrfs scrub status /dev/sda3
>>       > UUID:             c1534c07-d669-4f55-ae50-b87669ecb259
>>       > Scrub started:    Sat Apr  1 23:24:01 2023
>>       > Status:           finished
>>       > Duration:         0:09:03
>>       > Total to scrub:   146.79GiB
>>       > Rate:             241.40MiB/s
>>       > Error summary:    csum=3D239
>>       >    Corrected:      0
>>       >    Uncorrectable:  239
>>       >    Unverified:     0
>>       > root@homeserver:~# btrfs fi show /dev/sda3
>>       > Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
>>       >          Total devices 1 FS bytes used 146.79GiB
>>       >          devid    1 size 198.45GiB used 198.45GiB path /dev/sda3
>>       >
>>       >
>>       > Smartctl tells me:
>>       > SMART Attributes Data Structure revision number: 16
>>       > Vendor Specific SMART Attributes with Thresholds:
>>       > ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
>>       > UPDATED  WHEN_FAILED RAW_VALUE
>>       >    1 Raw_Read_Error_Rate     0x002f   100   100   000    Pre-fai=
l  Always
>>       >        -       2
>>       >    5 Reallocate_NAND_Blk_Cnt 0x0032   100   100   010    Old_age=
   Always
>>       >        -       2
>>       >    9 Power_On_Hours          0x0032   100   100   000    Old_age=
   Always
>>       >        -       4930
>>       >   12 Power_Cycle_Count       0x0032   100   100   000    Old_age=
   Always
>>       >        -       1864
>>       > 171 Program_Fail_Count      0x0032   100   100   000    Old_age =
  Always
>>       >        -       0
>>       > 172 Erase_Fail_Count        0x0032   100   100   000    Old_age =
  Always
>>       >        -       0
>>       > 173 Ave_Block-Erase_Count   0x0032   049   049   000    Old_age =
  Always
>>       >        -       769
>>       > 174 Unexpect_Power_Loss_Ct  0x0032   100   100   000    Old_age =
  Always
>>       >        -       22
>>       > 183 SATA_Interfac_Downshift 0x0032   100   100   000    Old_age =
  Always
>>       >        -       0
>>       > 184 Error_Correction_Count  0x0032   100   100   000    Old_age =
  Always
>>       >        -       0
>>       > 187 Reported_Uncorrect      0x0032   100   100   000    Old_age =
  Always
>>       >        -       0
>>       > 194 Temperature_Celsius     0x0022   068   051   000    Old_age =
  Always
>>       >        -       32 (Min/Max 9/49)
>>       > 196 Reallocated_Event_Count 0x0032   100   100   000    Old_age =
  Always
>>       >        -       2
>>       > 197 Current_Pending_ECC_Cnt 0x0032   100   100   000    Old_age =
  Always
>>       >        -       0
>>       > 198 Offline_Uncorrectable   0x0030   100   100   000    Old_age
>>       > Offline      -       0
>>       > 199 UDMA_CRC_Error_Count    0x0032   100   100   000    Old_age =
  Always
>>       >        -       0
>>       > 202 Percent_Lifetime_Remain 0x0030   049   049   001    Old_age
>>       > Offline      -       51
>>       > 206 Write_Error_Rate        0x000e   100   100   000    Old_age =
  Always
>>       >        -       0
>>       > 246 Total_LBAs_Written      0x0032   100   100   000    Old_age =
  Always
>>       >        -       146837983747
>>       > 247 Host_Program_Page_Count 0x0032   100   100   000    Old_age =
  Always
>>       >        -       4592609183
>>       > 248 FTL_Program_Page_Count  0x0032   100   100   000    Old_age =
  Always
>>       >        -       4948954393
>>       > 180 Unused_Reserve_NAND_Blk 0x0033   000   000   000    Pre-fail=
  Always
>>       >        -       2050
>>       > 210 Success_RAIN_Recov_Cnt  0x0032   100   100   000    Old_age =
  Always
>>       >        -       0
>>       >
>>       > What would you recommend wrt. the health of the drive (ssd) and=
 to fix
>>       > these errors?
>>       >
>>
>>      Scrub errors can only be corrected if the filesystem has redundancy=
.
>>      You have a single device which in the past defaulted to dup for
>>      metadata and single for data. If errors are in the data part, then=
 the
>>      only way to fix it is to delete files containing these blocks.
>>
>>      Scrub error means data written to stable storage is bad. It is
>>      unlikely caused by SSD error, could be software bug, could be fault=
y
>>      RAM.
>>
>>
>

