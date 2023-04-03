Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6473B6D3D7B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Apr 2023 08:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjDCGmZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Apr 2023 02:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjDCGmT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Apr 2023 02:42:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63326CDC4
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Apr 2023 23:42:10 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id b19so20951642oib.7
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Apr 2023 23:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680504129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/lm6JG39lxBHurGQ6v2sqyHQhdN4e5dSd3dGa88oeU=;
        b=b0gmW4ETD00Ic8ct2aQ/Ntft45Eu0AGpFi+E+wgaTFF7o2r9eW/LXgX2V3SNX6h5gx
         HK1kH6ESh9hFqspxSYUnR7POdYlDwqPnaoQldcZaJn0Dpbsebniig5BVXR0qxp1nP+g2
         fm+Hu/6QhKugXWAAJB67eutawqDTkZYNbvPljuv8Z+i8G0daYP6YoHJgydBBYQX/la1R
         HRyQQKJfZAyLg7kdECeeGLwGuUKRlLp6Qv6m/J5oq2ixqWP5ewm+NYwOm1Tvyy+reFmC
         b1+hDLmAfPwAhlcyObLto9dfMlofmXE02ljU/YaKR0s4fOzFWF16nigtvaPZV6Wlo0sE
         5DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680504129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/lm6JG39lxBHurGQ6v2sqyHQhdN4e5dSd3dGa88oeU=;
        b=cpzi/SAX0yFr8YL+6jtFOj3cDaSKhSlsaysQfoCxDClfn/vdRyrVVo3HUi3y+scl4z
         0OqxLIPOd0TKS39RLeiLs+1CzxFmfVj6+KtEBeLoErxSfXr6uP9h1V9EDWFZ+mIDZXzP
         QJ8lU5D8E+xkeSSB/4ebWi6isatyTwFaxTqHKzkCPbOGpOtbFb2/Vz0bJY8OKDuPELGv
         7PsJjrHdWOEPleKDjX7Ew5LSjtANGoHnRpvc5GZqWss5W350eWEvEV+nS8fTxMPI6QEK
         MA7lCYQMNnG93UnTHnHiQCaGFbZG4i3yhOL4LAzlfzhNOOp9likVkq1v0yWGToRNae+n
         RBmQ==
X-Gm-Message-State: AO0yUKVhS9iaPzknCG1X4eSNM72mnvVQkqmRKRvWkAKmpw/FNmDelwnA
        cRXfTec4Q3LOSwIIXzgT4xhGD6Qh4FWqqwhxpw02DZj8
X-Google-Smtp-Source: AK7set++xTf9ApUlIyEwRrnGqQWrNInsi0c6+dcJ8W42wCl9NQeptjWeXbMs5dc4IrFwXaRZhqbW7BQq3aGL84ngpuI=
X-Received: by 2002:aca:1b0a:0:b0:384:893:a924 with SMTP id
 b10-20020aca1b0a000000b003840893a924mr10800745oib.3.1680504129481; Sun, 02
 Apr 2023 23:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <emb76b8ee4-a409-477e-b5f2-1189081e4c8e@59307873.com>
In-Reply-To: <emb76b8ee4-a409-477e-b5f2-1189081e4c8e@59307873.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Mon, 3 Apr 2023 09:41:58 +0300
Message-ID: <CAA91j0XKGcM-02VYSMvcGmVpD=VBbpzR+pJZ+3yss6idav_d+w@mail.gmail.com>
Subject: Re: Scrub errors unable to fixup (regular) error
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 2, 2023 at 10:26=E2=80=AFPM Hendrik Friedel <hendrik@friedels.n=
ame> wrote:
>
> Hello,
>
> after a scrub, I had these errors:
> [Sa Apr  1 23:23:28 2023] BTRFS info (device sda3): scrub: started on
> devid 1
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
> errs: wr 0, rd 0, flush 0, corrupt 63, gen 0
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
> (regular) error at logical 2244718592 on dev /dev/sda3
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
> errs: wr 0, rd 0, flush 0, corrupt 64, gen 0
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
> (regular) error at logical 2260582400 on dev /dev/sda3
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
> errs: wr 0, rd 0, flush 0, corrupt 65, gen 0
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
> errs: wr 0, rd 0, flush 0, corrupt 66, gen 0
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
> (regular) error at logical 2260054016 on dev /dev/sda3
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
> (regular) error at logical 2259877888 on dev /dev/sda3
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
> errs: wr 0, rd 0, flush 0, corrupt 67, gen 0
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
> (regular) error at logical 2259935232 on dev /dev/sda3
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3
> errs: wr 0, rd 0, flush 0, corrupt 68, gen 0
> [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup
> (regular) error at logical 2264600576 on dev /dev/sda3
>
>
> root@homeserver:~# btrfs scrub status /dev/sda3
> UUID:             c1534c07-d669-4f55-ae50-b87669ecb259
> Scrub started:    Sat Apr  1 23:24:01 2023
> Status:           finished
> Duration:         0:09:03
> Total to scrub:   146.79GiB
> Rate:             241.40MiB/s
> Error summary:    csum=3D239
>    Corrected:      0
>    Uncorrectable:  239
>    Unverified:     0
> root@homeserver:~# btrfs fi show /dev/sda3
> Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
>          Total devices 1 FS bytes used 146.79GiB
>          devid    1 size 198.45GiB used 198.45GiB path /dev/sda3
>
>
> Smartctl tells me:
> SMART Attributes Data Structure revision number: 16
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
> UPDATED  WHEN_FAILED RAW_VALUE
>    1 Raw_Read_Error_Rate     0x002f   100   100   000    Pre-fail  Always
>        -       2
>    5 Reallocate_NAND_Blk_Cnt 0x0032   100   100   010    Old_age   Always
>        -       2
>    9 Power_On_Hours          0x0032   100   100   000    Old_age   Always
>        -       4930
>   12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always
>        -       1864
> 171 Program_Fail_Count      0x0032   100   100   000    Old_age   Always
>        -       0
> 172 Erase_Fail_Count        0x0032   100   100   000    Old_age   Always
>        -       0
> 173 Ave_Block-Erase_Count   0x0032   049   049   000    Old_age   Always
>        -       769
> 174 Unexpect_Power_Loss_Ct  0x0032   100   100   000    Old_age   Always
>        -       22
> 183 SATA_Interfac_Downshift 0x0032   100   100   000    Old_age   Always
>        -       0
> 184 Error_Correction_Count  0x0032   100   100   000    Old_age   Always
>        -       0
> 187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always
>        -       0
> 194 Temperature_Celsius     0x0022   068   051   000    Old_age   Always
>        -       32 (Min/Max 9/49)
> 196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always
>        -       2
> 197 Current_Pending_ECC_Cnt 0x0032   100   100   000    Old_age   Always
>        -       0
> 198 Offline_Uncorrectable   0x0030   100   100   000    Old_age
> Offline      -       0
> 199 UDMA_CRC_Error_Count    0x0032   100   100   000    Old_age   Always
>        -       0
> 202 Percent_Lifetime_Remain 0x0030   049   049   001    Old_age
> Offline      -       51
> 206 Write_Error_Rate        0x000e   100   100   000    Old_age   Always
>        -       0
> 246 Total_LBAs_Written      0x0032   100   100   000    Old_age   Always
>        -       146837983747
> 247 Host_Program_Page_Count 0x0032   100   100   000    Old_age   Always
>        -       4592609183
> 248 FTL_Program_Page_Count  0x0032   100   100   000    Old_age   Always
>        -       4948954393
> 180 Unused_Reserve_NAND_Blk 0x0033   000   000   000    Pre-fail  Always
>        -       2050
> 210 Success_RAIN_Recov_Cnt  0x0032   100   100   000    Old_age   Always
>        -       0
>
> What would you recommend wrt. the health of the drive (ssd) and to fix
> these errors?
>

Scrub errors can only be corrected if the filesystem has redundancy.
You have a single device which in the past defaulted to dup for
metadata and single for data. If errors are in the data part, then the
only way to fix it is to delete files containing these blocks.

Scrub error means data written to stable storage is bad. It is
unlikely caused by SSD error, could be software bug, could be faulty
RAM.
