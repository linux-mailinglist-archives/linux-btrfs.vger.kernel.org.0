Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB69E56C9CD
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 16:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiGIOGD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jul 2022 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiGIOGC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jul 2022 10:06:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8501208A
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Jul 2022 07:06:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so1987720lfk.11
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jul 2022 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IKg193W9IdCj4Sl+tETnvJIEyiekDeKv4haXKi6YwbA=;
        b=qHxVVc8sO8QVfGD1pY8o901qlu2powqR0/Xz8BaSYKOSLjHI43tgoZX6obq8h/lBPu
         ULiOzf9UDge5yuhLCkgoigD9gVNvMoOrVVYqiT+feIopOaAmW+PeIIwFbmeV9WSySBug
         8m3CmIFt6JJYSHy2egmpWcQBlMzFUUwrkK2SfIUnao6h9YYi2ClrJfUO9qiRZH/NnYGq
         jRw46gYrPkO52F54lKJ4bLmdEWhKgCUVeHlY8eyA8nWEJp8LrYtRIsWvWUKV8d3ha79O
         mAYV8AP9W+GEbKGZBJRtjJwpQ9LEIBUNrCRq+9aGjOM72zlkwTD3h61M2rgrFDCT6Hix
         PGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=IKg193W9IdCj4Sl+tETnvJIEyiekDeKv4haXKi6YwbA=;
        b=qz5bt1Qg6MLY/xB9kNS4w5p+QEhm8OAfFfy9IuWp5ccGqRrTqVX6xCumx1UczD4ERH
         e2DbNm36U3zdB1axf7kyigcIn3YhoZI4MTWT3eL1QIyMqsrSw0R1VUxGt63YS0tiVowF
         Hel5PyJ07OxQJERBtKa39IBLitOHnFCXYq5BhAiYZ/Gc/hxEDDuJQ++fnQF/PE53+M6Q
         89m+06N0/3s6NW4W37CickWZ0a0D4N/TtTCGAV4yHRRPMGAsfMSc+Mu2WW9O+WtnOsl0
         8yRGqSp3nTUq5EFKvUtPey3DMcxV7o7HYiPs5+AQiWRe64M/HVB5+q1mk4su/u82tIlI
         DGFA==
X-Gm-Message-State: AJIora/nqn6DTy6WRYdb6rvxyh6PyWVHQbnWC8kTp5f2iqMcuYsfVoE2
        uC88BkID0mmw79sewPupS0ymXvuJWIJwKerXzYVtsJ1oH/nB0w==
X-Google-Smtp-Source: AGRyM1sduHMpkoNJg7btXhEM/UH88g7F3V693mIBkigC7tjUmOdABJz+wwuGxIDaMa4+z9lwC05LdhSmBaAiyRpwioo=
X-Received: by 2002:a05:6512:e89:b0:485:ba55:a74 with SMTP id
 bi9-20020a0565120e8900b00485ba550a74mr5520246lfb.247.1657375560179; Sat, 09
 Jul 2022 07:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAGXSV6aseVoQJGOBDC7JoNUpW_8UfBxWgsg6ExPQUWajtUeu=w@mail.gmail.com>
 <4e7b28c9-ad39-19cb-202e-f0efa1d501b5@tnonline.net> <CAGXSV6YisBQW-gmEgU2X0Rsq51U7SFe7Vsyw4x231DsDzDoR4Q@mail.gmail.com>
 <c539e06.6901844a.181e33e9d5a@tnonline.net>
In-Reply-To: <c539e06.6901844a.181e33e9d5a@tnonline.net>
From:   =?UTF-8?B?xJDhuqF0IE5ndXnhu4Vu?= <snapeandcandy@gmail.com>
Date:   Sat, 9 Jul 2022 21:05:48 +0700
Message-ID: <CAGXSV6Zt6tr+8eU8RzC_qvaxHdjARrheqPp8RZmnmTwd73s4Ew@mail.gmail.com>
Subject: Re: Cannot mount
To:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I'm sorry, this is the first time I use a mailing list.

I have never tried to resize the partition. I only used mkfs.btrfs
once using the tutorial from
https://linuxhint.com/install-and-use-btrfs-on-ubuntu-lts/ in pc A,
and it did work fine.

I have to admit that although I'm working in the tech area and have
some knowledge of CS, filesystems are not my things. If the problem
persists on sdb only, could I remove sdb and recover datas from sda?

On Sat, Jul 9, 2022 at 8:55 PM Forza <forza@tnonline.net> wrote:
>
> Hi,
>
> I see you didn't email the mailing list? Can you resend the message there=
? It is useful for others to see the problems and if there are solutions.
>
> Basically Btrfs thinks that sdb1 is much larger than it is. In fact it is=
 thinking that sdb1 is just 2088 sectors smaller than the whole sdb. Since =
sdb1 starts at 2048 sectors, it means that the entire disk except for the l=
ast 40 sectors.
>
> How did this happen?
>
> Did you try to resize the partition at some point? Did you 'mkfs.btrfs' o=
r do 'btrfs device add' /dev/sdb instead of /dev/sdb1?
>
> Thanks,
> Forza
>
> ---- From: "=C4=90=E1=BA=A1t Nguy=E1=BB=85n" <snapeandcandy@gmail.com> --=
 Sent: 2022-07-08 - 17:52 ----
>
> > ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo fdisk -l --bytes /dev/sdb
> > Disk /dev/sdb: 1,84 TiB, 2000398934016 bytes, 3907029168 sectors
> > Disk model: WDC WD20EFAX-68F
> > Units: sectors of 1 * 512 =3D 512 bytes
> > Sector size (logical/physical): 512 bytes / 4096 bytes
> > I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> > Disklabel type: gpt
> > Disk identifier: 6FD408DC-62C6-4C42-B960-0079D9793A69
> >
> > Device          Start        End    Sectors          Size Type
> > /dev/sdb1        2048 3835273215 3835271168 1963658838016 Linux filesys=
tem
> > /dev/sdb2  3835273216 3907029134   71755919   36739030528 Linux filesys=
tem
> >
> > ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo fdisk -l --bytes /dev/sda
> > Disk /dev/sda: 3,65 TiB, 4000787030016 bytes, 7814037168 sectors
> > Disk model: WDC WD40EFAX-68J
> > Units: sectors of 1 * 512 =3D 512 bytes
> > Sector size (logical/physical): 512 bytes / 4096 bytes
> > I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> > Disklabel type: gpt
> > Disk identifier: C637A86C-4D63-564B-B087-9FD4BEE18A18
> >
> > Device          Start        End    Sectors          Size Type
> > /dev/sda1        2048 7784630271 7784628224 3985729650688 Linux filesys=
tem
> > /dev/sda3  7784630272 7814037134   29406863   15056313856 Linux filesys=
tem
> >
> > Thanks,
> >
> > On Fri, Jul 8, 2022 at 10:03 PM Forza <forza@tnonline.net> wrote:
> >>
> >>
> >>
> >> On 2022-07-08 14:18, =C4=90=E1=BA=A1t Nguy=E1=BB=85n wrote:
> >> > Hi,
> >> >
> >> > I have 2 drives in mirror mode in pc A (ubuntu 18.04 server). A
> >> > mainboard problem occurred in pc A, then I attached those 2 drivers
> >> > into pc B (ubuntu 20.04 desktop) but cannot mount them. Here is the
> >> > information.
> >> >
> >> > ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF uname -a
> >> > Linux pc 5.13.0-52-generic #59~20.04.1-Ubuntu SMP Thu Jun 16 21:21:2=
8
> >> > UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> >> > ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF btrfs --version
> >> > btrfs-progs v5.4.1
> >> > ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo btrfs fi show
> >> > Label: 'data'  uuid: f6abe13d-a8da-4bf4-9a5c-402fec4a2bce
> >> >      Total devices 2 FS bytes used 656.04GiB
> >> >      devid    1 size 1.82TiB used 701.03GiB path /dev/sdb1
> >> >      devid    2 size 3.62TiB used 701.03GiB path /dev/sda1
> >> >
> >> > The dmesg log is in the attached file. Basically it just tell
> >> >
> >> > [111997.422691] BTRFS info (device sdb1): flagging fs with big metad=
ata feature
> >> > [111997.422716] BTRFS error (device sdb1): open_ctree failed
> >> >
> >>
> >> An important line was omitted:
> >>
> >> [  576.780013] BTRFS error (device sdb1): device total_bytes should be
> >> at most 1963658838016 but found 2000397864960
> >>
> >> What does `fdisk -l --bytes /dev/sdb` show?
> >>
> >>
> >> > Please help me recover my data.
> >> >
> >> > Thanks and regards.
> >> > Dat
>
>
