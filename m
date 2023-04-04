Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFCF6D6CF6
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjDDTHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 15:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjDDTHt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 15:07:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A433B7
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 12:07:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h25so43637695lfv.6
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680635263; x=1683227263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sy/AKFfQdvQwSrtx4i778S0etg1wj16glAlQy8XyIU8=;
        b=CLTwU0SG+1eq46Nvi+ZvOzB5L4ZzOLODoXQT6dqRzLBt4kjf1neugA5B0ZmFGjexeU
         71gcXa3YnZRprCwCtDUA+4jF0D+KZWa1+Eg3U/wnED/FqQVevzEAx5twCtN+5rLyZT7k
         A5GgSv2xaVUHIe/ERjI2Okejpymd1e06pLZNCY6tjqs23RAPRJm4aDks5NJp4L/7JTr/
         Qbtr2ZV4VDOkdE/v0yvbgg2dt1TQzon5ZMWqHpuePY3G1i5uED/zlBLsVg/bRRkRcABE
         b92O7kuHIpTQHu7Zpk/OZQx3NFKrb7+x6Bvpi3ghlFWhHkImANuO0GCFaabrnooB5fxB
         UQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680635263; x=1683227263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sy/AKFfQdvQwSrtx4i778S0etg1wj16glAlQy8XyIU8=;
        b=7yAaNTsJyOkeeXNMP7g0yWOlh25SGG9RJ5ffJLDvpPi0qsQyfoZ9zRfhTFgCmrlUa9
         Yn0+PLYIf1pyeQE8xaC1faueGEzg6r7MSk9wA/4luOt+4uXIDlga3PS7dIasH5/s2D0y
         Al9ry+QM4WVaq55EfuAynb8vXa3rYD9XGlV+HXK3lktO6DA/AZu3IbeVWe+d0+lJpod3
         zzbY+LEulzFIndHsuA3vYjObUWrX+pKWkRQ9AKH1Hxg1J4b3m3bvMgJlGz+7GsvyFKCe
         b5OeIv5hpw9TsTHI8GFcF3Bi2kpbRMvQr59EGDKpdcSTdcMQdnwbcbPIUUbV62VDeZ7N
         ALxw==
X-Gm-Message-State: AAQBX9cvZCUo59bGkq7ADMfqO+g3OcTaZ9DQAh1i3TqhFBkbM2dUQ+n/
        2oZ+/dbeAi/uxcTKE0NOpvmwLeMQCX8=
X-Google-Smtp-Source: AKy350ZFRYDY4Kd5lK4bgwdj1O3RZWt1smd+nAwwiGWpKztUAhh+9wu1ppNCaPfRNjZ+WGiXud6ZoA==
X-Received: by 2002:ac2:44d5:0:b0:4dd:9da1:befe with SMTP id d21-20020ac244d5000000b004dd9da1befemr143409lfm.2.1680635263228;
        Tue, 04 Apr 2023 12:07:43 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:2677:5fa1:fd88:2600:f604? ([2a00:1370:8182:2677:5fa1:fd88:2600:f604])
        by smtp.gmail.com with ESMTPSA id f6-20020ac251a6000000b004eae6283565sm2445889lfk.299.2023.04.04.12.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 12:07:42 -0700 (PDT)
Message-ID: <f941dacc-89f0-a9bc-a81a-aaf18d4fad47@gmail.com>
Date:   Tue, 4 Apr 2023 22:07:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Scrub errors unable to fixup (regular) error
Content-Language: en-US
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     linux-btrfs@vger.kernel.org
References: <25249f22-7e1b-43bf-9586-91c9803e4c28@email.android.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <25249f22-7e1b-43bf-9586-91c9803e4c28@email.android.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03.04.2023 09:44, Hendrik Friedel wrote:
> Hello,
> 
> thanks.
> Can you Tell ne, how I identify the affected files?
> 

You could try

btrfs inspect-internal logical-resolve NNNNN /btrfs/mount/point

where NNNNN is logical address from kernel message

> Best regards,
> Hendrik
> 
> Am 03.04.2023 08:41 schrieb Andrei Borzenkov <arvidjaar@gmail.com>:
> 
>      On Sun, Apr 2, 2023 at 10:26 PM Hendrik Friedel <hendrik@friedels.name> wrote:
>       >
>       > Hello,
>       >
>       > after a scrub, I had these errors:
>       > [Sa Apr  1 23:23:28 2023] BTRFS info (device sda3): scrub: started on
>       > devid 1
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>       > errs: wr 0, rd 0, flush 0, corrupt 63, gen 0
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>       > (regular) error at logical 2244718592 on dev /dev/sda3
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>       > errs: wr 0, rd 0, flush 0, corrupt 64, gen 0
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>       > (regular) error at logical 2260582400 on dev /dev/sda3
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>       > errs: wr 0, rd 0, flush 0, corrupt 65, gen 0
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>       > errs: wr 0, rd 0, flush 0, corrupt 66, gen 0
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>       > (regular) error at logical 2260054016 on dev /dev/sda3
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>       > (regular) error at logical 2259877888 on dev /dev/sda3
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>       > errs: wr 0, rd 0, flush 0, corrupt 67, gen 0
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>       > (regular) error at logical 2259935232 on dev /dev/sda3
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
>       > errs: wr 0, rd 0, flush 0, corrupt 68, gen 0
>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
>       > (regular) error at logical 2264600576 on dev /dev/sda3
>       >
>       >
>       > root@homeserver:~# btrfs scrub status /dev/sda3
>       > UUID:             c1534c07-d669-4f55-ae50-b87669ecb259
>       > Scrub started:    Sat Apr  1 23:24:01 2023
>       > Status:           finished
>       > Duration:         0:09:03
>       > Total to scrub:   146.79GiB
>       > Rate:             241.40MiB/s
>       > Error summary:    csum=239
>       >    Corrected:      0
>       >    Uncorrectable:  239
>       >    Unverified:     0
>       > root@homeserver:~# btrfs fi show /dev/sda3
>       > Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
>       >          Total devices 1 FS bytes used 146.79GiB
>       >          devid    1 size 198.45GiB used 198.45GiB path /dev/sda3
>       >
>       >
>       > Smartctl tells me:
>       > SMART Attributes Data Structure revision number: 16
>       > Vendor Specific SMART Attributes with Thresholds:
>       > ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
>       > UPDATED  WHEN_FAILED RAW_VALUE
>       >    1 Raw_Read_Error_Rate     0x002f   100   100   000    Pre-fail  Always
>       >        -       2
>       >    5 Reallocate_NAND_Blk_Cnt 0x0032   100   100   010    Old_age   Always
>       >        -       2
>       >    9 Power_On_Hours          0x0032   100   100   000    Old_age   Always
>       >        -       4930
>       >   12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always
>       >        -       1864
>       > 171 Program_Fail_Count      0x0032   100   100   000    Old_age   Always
>       >        -       0
>       > 172 Erase_Fail_Count        0x0032   100   100   000    Old_age   Always
>       >        -       0
>       > 173 Ave_Block-Erase_Count   0x0032   049   049   000    Old_age   Always
>       >        -       769
>       > 174 Unexpect_Power_Loss_Ct  0x0032   100   100   000    Old_age   Always
>       >        -       22
>       > 183 SATA_Interfac_Downshift 0x0032   100   100   000    Old_age   Always
>       >        -       0
>       > 184 Error_Correction_Count  0x0032   100   100   000    Old_age   Always
>       >        -       0
>       > 187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always
>       >        -       0
>       > 194 Temperature_Celsius     0x0022   068   051   000    Old_age   Always
>       >        -       32 (Min/Max 9/49)
>       > 196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always
>       >        -       2
>       > 197 Current_Pending_ECC_Cnt 0x0032   100   100   000    Old_age   Always
>       >        -       0
>       > 198 Offline_Uncorrectable   0x0030   100   100   000    Old_age
>       > Offline      -       0
>       > 199 UDMA_CRC_Error_Count    0x0032   100   100   000    Old_age   Always
>       >        -       0
>       > 202 Percent_Lifetime_Remain 0x0030   049   049   001    Old_age
>       > Offline      -       51
>       > 206 Write_Error_Rate        0x000e   100   100   000    Old_age   Always
>       >        -       0
>       > 246 Total_LBAs_Written      0x0032   100   100   000    Old_age   Always
>       >        -       146837983747
>       > 247 Host_Program_Page_Count 0x0032   100   100   000    Old_age   Always
>       >        -       4592609183
>       > 248 FTL_Program_Page_Count  0x0032   100   100   000    Old_age   Always
>       >        -       4948954393
>       > 180 Unused_Reserve_NAND_Blk 0x0033   000   000   000    Pre-fail  Always
>       >        -       2050
>       > 210 Success_RAIN_Recov_Cnt  0x0032   100   100   000    Old_age   Always
>       >        -       0
>       >
>       > What would you recommend wrt. the health of the drive (ssd) and to fix
>       > these errors?
>       >
> 
>      Scrub errors can only be corrected if the filesystem has redundancy.
>      You have a single device which in the past defaulted to dup for
>      metadata and single for data. If errors are in the data part, then the
>      only way to fix it is to delete files containing these blocks.
> 
>      Scrub error means data written to stable storage is bad. It is
>      unlikely caused by SSD error, could be software bug, could be faulty
>      RAM.
> 
> 

