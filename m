Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A46356C9BF
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiGIN7n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jul 2022 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiGIN7m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jul 2022 09:59:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36DA4B493
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Jul 2022 06:59:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e12so1997063lfr.6
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jul 2022 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FbnGyAQkygueQTG8yTqRBFUAJkAZWTZM7hvebeXgPnE=;
        b=KITzBEuDNnjW46CEVEJZNA8meBt/Fl4RIbyaqLtooPoHGb0XQRGK1RHWvap1X0Ujv0
         1Gu/IpE5ptcOh0TaB0+JP05XyZ8/CbWhdBLeFwe+DOYqLdibTdEBb8BaDLfAywuSdEq5
         i4dL3eGPxADb2LHfR9Pjp2q+kXVT1HGMwWsofFg6DZVmA9eiwYsub0kAJyOwhDgN0dVc
         OdPOjUgKXKRqPqGpqzU5W/hRQ9Z2jHBZy6u9U2US8i6pWLyW5R13d00sRPSKXPI2UxYw
         IvkZQ4WTALJGnM/4eDpWBiIVrwxFQI1+pxSnFQew/+0ZTlWMSHQVaTP0d8lx83z4/RD5
         aMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=FbnGyAQkygueQTG8yTqRBFUAJkAZWTZM7hvebeXgPnE=;
        b=fYzJWXCCiavhMqFhz3ePTg+SYulEH2drLn2CBMxEUceeP9MZo6yt6aFYkr8EMDIwTQ
         p68Ifcb53meNP5tS95Y92e3Y0tC8kKLU7nUW6lErxhjb3Vh9whjnneVtFrQNooHzZhAb
         SXu+2b1dBSvOMuIkE2ALVWC2u9DUYYx4GFxxgFRJ2cSrsTMdc1fwLbz2ydf73VlJTbGn
         WauKIbP2n7WgLkk0niuyU9fh0O+VAnheXCRKWLdFprMpxyeY2zmRXDh1NwLoC+p7T516
         /fVVnaub03qE0Eq+9clucTV71B6qzktcZgynmPZih7oTrim3K+ZrEVoHXNd/hpfhPm9c
         OQKw==
X-Gm-Message-State: AJIora+aZyNoZ43Il9MgZ7p/Ik5dNLXvz2vknNMXthN8Hqu2uJ1Y4pql
        WjHy79hVdmbfGZtI4mMTkPXCv5/KXqaqEDIWR/MAy5xi
X-Google-Smtp-Source: AGRyM1sl4tHwUBS9zWCiYvWv3eJ69sWpUQRw+EGeU0vZqO1h37zSqRzR62gIWeHtpPFa4KP5zQ7i+dUucOxowNn2+H8=
X-Received: by 2002:a05:6512:23a4:b0:47f:79df:2ea9 with SMTP id
 c36-20020a05651223a400b0047f79df2ea9mr5842458lfv.498.1657375178326; Sat, 09
 Jul 2022 06:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAGXSV6aseVoQJGOBDC7JoNUpW_8UfBxWgsg6ExPQUWajtUeu=w@mail.gmail.com>
 <98714041-d872-081a-b9fb-174aa17d734a@gmx.com> <CAGXSV6YD55UnkzdXXx8_RzsT=QH7cUXA84w1KRJGswkEZ-0Fsw@mail.gmail.com>
In-Reply-To: <CAGXSV6YD55UnkzdXXx8_RzsT=QH7cUXA84w1KRJGswkEZ-0Fsw@mail.gmail.com>
From:   =?UTF-8?B?xJDhuqF0IE5ndXnhu4Vu?= <snapeandcandy@gmail.com>
Date:   Sat, 9 Jul 2022 20:59:26 +0700
Message-ID: <CAGXSV6bURatOK+iMNgrz+y4B8VgerCChU=xRXjh_XAwaD=YH=w@mail.gmail.com>
Subject: Fwd: Cannot mount
To:     linux-btrfs@vger.kernel.org
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

---------- Forwarded message ---------
From: =C4=90=E1=BA=A1t Nguy=E1=BB=85n <snapeandcandy@gmail.com>
Date: Fri, Jul 8, 2022 at 8:35 PM
Subject: Re: Cannot mount
To: Qu Wenruo <quwenruo.btrfs@gmx.com>


Thank for quick response

I've tried some mount command and here is the outputs.

~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo mount -o compress=3Dzstd /dev/sda1 /mnt/=
data
mount: /mnt/data: wrong fs type, bad option, bad superblock on
/dev/sda1, missing codepage or helper program, or other error.
~ =E2=9D=AF=E2=9D=AF=E2=9D=AF dmesg
[162512.424647] BTRFS info (device sdb1): flagging fs with big metadata fea=
ture
[162512.424654] BTRFS info (device sdb1): setting incompat feature
flag for COMPRESS_ZSTD (0x10)
[162512.424657] BTRFS info (device sdb1): use zstd compression, level 3
[162512.424659] BTRFS info (device sdb1): disk space caching is enabled
[162512.424660] BTRFS info (device sdb1): has skinny extents
[162512.438859] BTRFS error (device sdb1): device total_bytes should
be at most 1963658838016 but found 2000397864960
[162512.438868] BTRFS error (device sdb1): failed to read chunk tree: -22
[162512.461337] BTRFS error (device sdb1): open_ctree failed


~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo mount -o compress=3Dlzo /dev/sda1 /mnt/d=
ata
                  =E2=9C=98 130
mount: /mnt/data: wrong fs type, bad option, bad superblock on
/dev/sda1, missing codepage or helper program, or other error.
~ =E2=9D=AF=E2=9D=AF=E2=9D=AF dmesg
[162650.152219] BTRFS info (device sdb1): flagging fs with big metadata fea=
ture
[162650.152224] BTRFS info (device sdb1): use lzo compression, level 0
[162650.152226] BTRFS info (device sdb1): disk space caching is enabled
[162650.152227] BTRFS info (device sdb1): has skinny extents
[162650.169054] BTRFS error (device sdb1): device total_bytes should
be at most 1963658838016 but found 2000397864960
[162650.169061] BTRFS error (device sdb1): failed to read chunk tree: -22
[162650.191539] BTRFS error (device sdb1): open_ctree failed

~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo mount -o compress=3Dlz4 /dev/sdb1 /mnt/d=
ata
mount: /mnt/data: wrong fs type, bad option, bad superblock on
/dev/sdb1, missing codepage or helper program, or other error.
~ =E2=9D=AF=E2=9D=AF=E2=9D=AF dmesg
[162686.013853] BTRFS info (device sdb1): flagging fs with big metadata fea=
ture
[162686.015764] BTRFS error (device sdb1): open_ctree failed

The lz4 compression seems different to others.

~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo btrfs check  /dev/sda1
Opening filesystem to check...
Checking filesystem on /dev/sda1
UUID: f6abe13d-a8da-4bf4-9a5c-402fec4a2bce
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 704413171712 bytes used, no error found
total csum bytes: 686039184
total tree bytes: 1725284352
total fs tree bytes: 923860992
total extent tree bytes: 68747264
btree space waste bytes: 204372381
file data blocks allocated: 707765252096
 referenced 715583406080

Thanks,
Dat

On Fri, Jul 8, 2022 at 8:10 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/7/8 20:18, =C4=90=E1=BA=A1t Nguy=E1=BB=85n wrote:
> > Hi,
> >
> > I have 2 drives in mirror mode in pc A (ubuntu 18.04 server). A
> > mainboard problem occurred in pc A, then I attached those 2 drivers
> > into pc B (ubuntu 20.04 desktop) but cannot mount them. Here is the
> > information.
> >
> > ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF uname -a
> > Linux pc 5.13.0-52-generic #59~20.04.1-Ubuntu SMP Thu Jun 16 21:21:28
> > UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> > ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF btrfs --version
> > btrfs-progs v5.4.1
> > ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo btrfs fi show
> > Label: 'data'  uuid: f6abe13d-a8da-4bf4-9a5c-402fec4a2bce
> >      Total devices 2 FS bytes used 656.04GiB
> >      devid    1 size 1.82TiB used 701.03GiB path /dev/sdb1
> >      devid    2 size 3.62TiB used 701.03GiB path /dev/sda1
> >
> > The dmesg log is in the attached file. Basically it just tell
> >
> > [111997.422691] BTRFS info (device sdb1): flagging fs with big metadata=
 feature
> > [111997.422716] BTRFS error (device sdb1): open_ctree failed
>
> This no error message looks like some unrecognized mount option, mostly
> for newer compression method (like zstd?)
>
> Could you please provide the mount command to confirm if that's the case?
>
> Another thing can help debugging is "btrfs check" output.
>
> Thanks,
> Qu
> >
> > Please help me recover my data.
> >
> > Thanks and regards.
> > Dat
