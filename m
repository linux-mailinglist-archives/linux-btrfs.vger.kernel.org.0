Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FDF6D3E2E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Apr 2023 09:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjDCHjE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Apr 2023 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDCHjD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Apr 2023 03:39:03 -0400
Received: from sm-r-008-dus.org-dns.com (sm-r-008-dus.org-dns.com [84.19.1.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315392694
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 00:39:01 -0700 (PDT)
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
        by smarthost-dus.org-dns.com (Postfix) with ESMTP id 2EF59A0F59
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 09:33:05 +0200 (CEST)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
        id 223ACA2570; Mon,  3 Apr 2023 09:33:05 +0200 (CEST)
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smarthost-dus.org-dns.com (Postfix) with ESMTPS id 51CC9A0F59;
        Mon,  3 Apr 2023 09:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=friedels.name;
        s=default; t=1680507269;
        bh=S6CtpSTDQCp4qBHPH3ghulzKdE/2tmXJy8uFWnGUzEk=; h=From:To:Subject;
        b=FpSVSfGTuYtT4AoUWE8nNBxkE6YpoEW9U9ArTW7zF1udyvrTmaKmaEuG0+hjWm04t
         nSVdkd5Y1a+s1WgRMrZLgaHXf15++LXJ01R53V6kAwwytvaOPG6PkPkcCuPPzMqOFd
         mD/sJZHJDhQxEA2fNa7APKm8vNL7t2erTn4yKLv8=
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 94.31.96.101) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.41]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Andrei Borzenkov" <arvidjaar@gmail.com>
Subject: Re[2]: Scrub errors unable to fixup (regular) error
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Mon, 03 Apr 2023 07:33:02 +0000
Message-Id: <em0be440de-68a1-406c-9df9-9f18ceb57fb2@59307873.com>
In-Reply-To: <CAA91j0XKGcM-02VYSMvcGmVpD=VBbpzR+pJZ+3yss6idav_d+w@mail.gmail.com>
References: <emb76b8ee4-a409-477e-b5f2-1189081e4c8e@59307873.com>
 <CAA91j0XKGcM-02VYSMvcGmVpD=VBbpzR+pJZ+3yss6idav_d+w@mail.gmail.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: <168050726940.17419.13572603436821877516@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

thanks. I understand
Can you tell me, how I identify the affected files?

Best regards,
Hendrik

------ Originalnachricht ------
Von "Andrei Borzenkov" <arvidjaar@gmail.com>
An "Hendrik Friedel" <hendrik@friedels.name>
Cc "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Datum 03.04.2023 08:41:58
Betreff Re: Scrub errors unable to fixup (regular) error

>On Sun, Apr 2, 2023 at 10:26=E2=80=AFPM Hendrik Friedel <hendrik@friedels.=
name> wrote:
>>
>>Hello,
>>
>>after a scrub, I had these errors:
>>[Sa Apr  1 23:23:28 2023] BTRFS info (device sda3): scrub: started on
>>devid 1
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>>errs: wr 0, rd 0, flush 0, corrupt 63, gen 0
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>>(regular) error at logical 2244718592 on dev /dev/sda3
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>>errs: wr 0, rd 0, flush 0, corrupt 64, gen 0
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>>(regular) error at logical 2260582400 on dev /dev/sda3
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>>errs: wr 0, rd 0, flush 0, corrupt 65, gen 0
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>>errs: wr 0, rd 0, flush 0, corrupt 66, gen 0
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>>(regular) error at logical 2260054016 on dev /dev/sda3
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>>(regular) error at logical 2259877888 on dev /dev/sda3
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>>errs: wr 0, rd 0, flush 0, corrupt 67, gen 0
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>>(regular) error at logical 2259935232 on dev /dev/sda3
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>>errs: wr 0, rd 0, flush 0, corrupt 68, gen 0
>>[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>>(regular) error at logical 2264600576 on dev /dev/sda3
>>
>>
>>root@homeserver:~# btrfs scrub status /dev/sda3
>>UUID:             c1534c07-d669-4f55-ae50-b87669ecb259
>>Scrub started:    Sat Apr  1 23:24:01 2023
>>Status:           finished
>>Duration:         0:09:03
>>Total to scrub:   146.79GiB
>>Rate:             241.40MiB/s
>>Error summary:    csum=3D239
>>    Corrected:      0
>>    Uncorrectable:  239
>>    Unverified:     0
>>root@homeserver:~# btrfs fi show /dev/sda3
>>Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
>>          Total devices 1 FS bytes used 146.79GiB
>>          devid    1 size 198.45GiB used 198.45GiB path /dev/sda3
>>
>>
>>Smartctl tells me:
>>SMART Attributes Data Structure revision number: 16
>>Vendor Specific SMART Attributes with Thresholds:
>>ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
>>UPDATED  WHEN_FAILED RAW_VALUE
>>    1 Raw_Read_Error_Rate     0x002f   100   100   000    Pre-fail  Alway=
s
>>        -       2
>>    5 Reallocate_NAND_Blk_Cnt 0x0032   100   100   010    Old_age   Alway=
s
>>        -       2
>>    9 Power_On_Hours          0x0032   100   100   000    Old_age   Alway=
s
>>        -       4930
>>   12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Alway=
s
>>        -       1864
>>171 Program_Fail_Count      0x0032   100   100   000    Old_age   Always
>>        -       0
>>172 Erase_Fail_Count        0x0032   100   100   000    Old_age   Always
>>        -       0
>>173 Ave_Block-Erase_Count   0x0032   049   049   000    Old_age   Always
>>        -       769
>>174 Unexpect_Power_Loss_Ct  0x0032   100   100   000    Old_age   Always
>>        -       22
>>183 SATA_Interfac_Downshift 0x0032   100   100   000    Old_age   Always
>>        -       0
>>184 Error_Correction_Count  0x0032   100   100   000    Old_age   Always
>>        -       0
>>187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always
>>        -       0
>>194 Temperature_Celsius     0x0022   068   051   000    Old_age   Always
>>        -       32 (Min/Max 9/49)
>>196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always
>>        -       2
>>197 Current_Pending_ECC_Cnt 0x0032   100   100   000    Old_age   Always
>>        -       0
>>198 Offline_Uncorrectable   0x0030   100   100   000    Old_age
>>Offline      -       0
>>199 UDMA_CRC_Error_Count    0x0032   100   100   000    Old_age   Always
>>        -       0
>>202 Percent_Lifetime_Remain 0x0030   049   049   001    Old_age
>>Offline      -       51
>>206 Write_Error_Rate        0x000e   100   100   000    Old_age   Always
>>        -       0
>>246 Total_LBAs_Written      0x0032   100   100   000    Old_age   Always
>>        -       146837983747
>>247 Host_Program_Page_Count 0x0032   100   100   000    Old_age   Always
>>        -       4592609183
>>248 FTL_Program_Page_Count  0x0032   100   100   000    Old_age   Always
>>        -       4948954393
>>180 Unused_Reserve_NAND_Blk 0x0033   000   000   000    Pre-fail  Always
>>        -       2050
>>210 Success_RAIN_Recov_Cnt  0x0032   100   100   000    Old_age   Always
>>        -       0
>>
>>What would you recommend wrt. the health of the drive (ssd) and to fix
>>these errors?
>>
>
>Scrub errors can only be corrected if the filesystem has redundancy.
>You have a single device which in the past defaulted to dup for
>metadata and single for data. If errors are in the data part, then the
>only way to fix it is to delete files containing these blocks.
>
>Scrub error means data written to stable storage is bad. It is
>unlikely caused by SSD error, could be software bug, could be faulty
>RAM.

