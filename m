Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9956C9C3
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiGIOA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jul 2022 10:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiGIOA1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jul 2022 10:00:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F61F4B494
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Jul 2022 07:00:24 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bn33so1421734ljb.13
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jul 2022 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=A+Vv0qEuMteQ70JsJEc+UHw4tHliFdHkzULcheMroaI=;
        b=nma5ZS4R1/TkPAyOjeSCJdCp26I4TPuCR0svD0rGcnNmCuL0PkR729uN1k7DdjC04X
         eWncmgocrZLuJ7/I7KAUItd220kUwTAhLhisQtt10yO9Mb/MC2A6j0YToVggAqO+1wzH
         9SDHPHuiH0cFfdUQb76G+4Lwd21ktaqCG+qcWmaGH5YyOLV9K6RhhnYx+wj21Wz9iNdg
         5cLDTDwQri767//UxU20qQCTF/9omo4/4u8cWWl8xnZV3mgz22hr/zy0aQqBtgvwPA8r
         UXXe7O1oNBnpxoMPv1Og4SZYdGnJMGgU0UjwbXaZgkreJVM7Df+PX6UrhFbyyIOt3ZkE
         QY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=A+Vv0qEuMteQ70JsJEc+UHw4tHliFdHkzULcheMroaI=;
        b=gHlZmLm19d+wdusKaRTXd9JaewQs1gxPHcP8Haks8FCKC6LwHcNXv6GbJXLggSXdLN
         WJoepQ8A8CstqoP4mRYej1Vsnt/C78eeVTOv7ivAr5EbZW+sNs3xFwQFpEEWu9FZf3yZ
         k4BkuaY0iBxAG9Dn1aRqJzDcp+paSaUtMV0IrilEcto2dzhSUrBHOJjpS0UjGq0NB8Sa
         svaFJf+kQtWOp+SaCI26Ze/7CkybuXNQha6UDb7MuTkSNj/SApnsmv3iHQHE4YZ1xvZ3
         wDeS4++XK0OD97hferR6qNr2ZQt3bIkCizq+hNd1CUUgqdfRNlahaCUsgIExnHEE+t9Y
         g/Rw==
X-Gm-Message-State: AJIora+oJrbTD6+DMYtT5geDoJXIMmhRgTmuxHLXcAZp50vWsdrdRemR
        ImDZzm2Aw9cAQPZU6D36sotItyBLw+kojQTGg7O/EPYY
X-Google-Smtp-Source: AGRyM1vGuTQQ11Xu6uhXTLY880zAHu6fRiqsAtArrUWZL/rxSz/SCqP+m+X2A8xYYfkv5DxQ9JSuylNv3Msx204RjP8=
X-Received: by 2002:a2e:a262:0:b0:25d:53b5:6f09 with SMTP id
 k2-20020a2ea262000000b0025d53b56f09mr4639636ljm.265.1657375221812; Sat, 09
 Jul 2022 07:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAGXSV6aseVoQJGOBDC7JoNUpW_8UfBxWgsg6ExPQUWajtUeu=w@mail.gmail.com>
 <98714041-d872-081a-b9fb-174aa17d734a@gmx.com> <CAGXSV6YD55UnkzdXXx8_RzsT=QH7cUXA84w1KRJGswkEZ-0Fsw@mail.gmail.com>
 <2f9c49e6-1730-17ad-15ec-b2ab6f1f9dd8@gmx.com> <CAGXSV6b_rMyV8-GkRcLCGY0ubd+jtmZYgEfR3YTewT4e3hQZ9w@mail.gmail.com>
 <50b43568-93c8-4172-aa2c-e4c65c01b931@gmx.com> <CAGXSV6aJ2hZ2jkiS1QqnP8tg9yQp48kt680SCgoNGDXRR=Ghyw@mail.gmail.com>
In-Reply-To: <CAGXSV6aJ2hZ2jkiS1QqnP8tg9yQp48kt680SCgoNGDXRR=Ghyw@mail.gmail.com>
From:   =?UTF-8?B?xJDhuqF0IE5ndXnhu4Vu?= <snapeandcandy@gmail.com>
Date:   Sat, 9 Jul 2022 21:00:10 +0700
Message-ID: <CAGXSV6ZOzJwEZvc-Qi-YNV5FoT6K0+z17nnu27KFnOvAV2q4rQ@mail.gmail.com>
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
Date: Sat, Jul 9, 2022 at 7:40 PM
Subject: Re: Cannot mount
To: Qu Wenruo <quwenruo.btrfs@gmx.com>


Due to some panic, I'd tried all the `btrfs rescue` commands before
starting this email thread, even tried `btrfs check --repair`.
As I recall I did not change the partition table, because I didn't
know how to do it. And pardon me, I don't know what `enlarge the
partition` really means, is it safe to try?

On Sat, Jul 9, 2022 at 5:51 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/7/8 22:07, =C4=90=E1=BA=A1t Nguy=E1=BB=85n wrote:
> > I'm sorry, it did not work.
> >
> > ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo btrfs rescue fix-device-size /dev/sd=
a1
> > No device size related problem found
> > ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo btrfs rescue fix-device-size /dev/sd=
b1
> > No device size related problem found
>
> OK, that's due to the btrfs device size is larger than real device size.
>
> Did you modified the partition table before?
>
> If so, can you just slightly enlarge the partition to at least
> 2000397864960 bytes?
>
> Thanks,
> Qu
> >
> > dmesg doesn't show any BTRFS record.
> >
> >
> > On Fri, Jul 8, 2022 at 9:03 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2022/7/8 21:35, =C4=90=E1=BA=A1t Nguy=E1=BB=85n wrote:
> >>> Thank for quick response
> >>>
> >>> I've tried some mount command and here is the outputs.
> >>>
> >>> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo mount -o compress=3Dzstd /dev/sda1=
 /mnt/data
> >>> mount: /mnt/data: wrong fs type, bad option, bad superblock on
> >>> /dev/sda1, missing codepage or helper program, or other error.
> >>> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF dmesg
> >>> [162512.424647] BTRFS info (device sdb1): flagging fs with big metada=
ta feature
> >>> [162512.424654] BTRFS info (device sdb1): setting incompat feature
> >>> flag for COMPRESS_ZSTD (0x10)
> >>> [162512.424657] BTRFS info (device sdb1): use zstd compression, level=
 3
> >>> [162512.424659] BTRFS info (device sdb1): disk space caching is enabl=
ed
> >>> [162512.424660] BTRFS info (device sdb1): has skinny extents
> >>> [162512.438859] BTRFS error (device sdb1): device total_bytes should
> >>> be at most 1963658838016 but found 2000397864960
> >>
> >> This is the cause, didn't know why it's not in previous mail.
> >>
> >> This can be resolved by "btrfs rescue fix-device-size <dev>" command.
> >>
> >> This is some newer check in recent kernels, but not in older ones.
> >>
> >> Thanks,
> >> Qu
> >>> [162512.438868] BTRFS error (device sdb1): failed to read chunk tree:=
 -22
> >>> [162512.461337] BTRFS error (device sdb1): open_ctree failed
> >>>
> >>>
> >>> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo mount -o compress=3Dlzo /dev/sda1 =
/mnt/data
> >>>                     =E2=9C=98 130
> >>> mount: /mnt/data: wrong fs type, bad option, bad superblock on
> >>> /dev/sda1, missing codepage or helper program, or other error.
> >>> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF dmesg
> >>> [162650.152219] BTRFS info (device sdb1): flagging fs with big metada=
ta feature
> >>> [162650.152224] BTRFS info (device sdb1): use lzo compression, level =
0
> >>> [162650.152226] BTRFS info (device sdb1): disk space caching is enabl=
ed
> >>> [162650.152227] BTRFS info (device sdb1): has skinny extents
> >>> [162650.169054] BTRFS error (device sdb1): device total_bytes should
> >>> be at most 1963658838016 but found 2000397864960
> >>> [162650.169061] BTRFS error (device sdb1): failed to read chunk tree:=
 -22
> >>> [162650.191539] BTRFS error (device sdb1): open_ctree failed
> >>>
> >>> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo mount -o compress=3Dlz4 /dev/sdb1 =
/mnt/data
> >>> mount: /mnt/data: wrong fs type, bad option, bad superblock on
> >>> /dev/sdb1, missing codepage or helper program, or other error.
> >>> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF dmesg
> >>> [162686.013853] BTRFS info (device sdb1): flagging fs with big metada=
ta feature
> >>> [162686.015764] BTRFS error (device sdb1): open_ctree failed
> >>>
> >>> The lz4 compression seems different to others.
> >>>
> >>> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo btrfs check  /dev/sda1
> >>> Opening filesystem to check...
> >>> Checking filesystem on /dev/sda1
> >>> UUID: f6abe13d-a8da-4bf4-9a5c-402fec4a2bce
> >>> [1/7] checking root items
> >>> [2/7] checking extents
> >>> [3/7] checking free space cache
> >>> cache and super generation don't match, space cache will be invalidat=
ed
> >>> [4/7] checking fs roots
> >>> [5/7] checking only csums items (without verifying data)
> >>> [6/7] checking root refs
> >>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>> found 704413171712 bytes used, no error found
> >>> total csum bytes: 686039184
> >>> total tree bytes: 1725284352
> >>> total fs tree bytes: 923860992
> >>> total extent tree bytes: 68747264
> >>> btree space waste bytes: 204372381
> >>> file data blocks allocated: 707765252096
> >>>    referenced 715583406080
> >>>
> >>> Thanks,
> >>> Dat
> >>>
> >>> On Fri, Jul 8, 2022 at 8:10 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>>>
> >>>>
> >>>>
> >>>> On 2022/7/8 20:18, =C4=90=E1=BA=A1t Nguy=E1=BB=85n wrote:
> >>>>> Hi,
> >>>>>
> >>>>> I have 2 drives in mirror mode in pc A (ubuntu 18.04 server). A
> >>>>> mainboard problem occurred in pc A, then I attached those 2 drivers
> >>>>> into pc B (ubuntu 20.04 desktop) but cannot mount them. Here is the
> >>>>> information.
> >>>>>
> >>>>> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF uname -a
> >>>>> Linux pc 5.13.0-52-generic #59~20.04.1-Ubuntu SMP Thu Jun 16 21:21:=
28
> >>>>> UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> >>>>> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF btrfs --version
> >>>>> btrfs-progs v5.4.1
> >>>>> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo btrfs fi show
> >>>>> Label: 'data'  uuid: f6abe13d-a8da-4bf4-9a5c-402fec4a2bce
> >>>>>        Total devices 2 FS bytes used 656.04GiB
> >>>>>        devid    1 size 1.82TiB used 701.03GiB path /dev/sdb1
> >>>>>        devid    2 size 3.62TiB used 701.03GiB path /dev/sda1
> >>>>>
> >>>>> The dmesg log is in the attached file. Basically it just tell
> >>>>>
> >>>>> [111997.422691] BTRFS info (device sdb1): flagging fs with big meta=
data feature
> >>>>> [111997.422716] BTRFS error (device sdb1): open_ctree failed
> >>>>
> >>>> This no error message looks like some unrecognized mount option, mos=
tly
> >>>> for newer compression method (like zstd?)
> >>>>
> >>>> Could you please provide the mount command to confirm if that's the =
case?
> >>>>
> >>>> Another thing can help debugging is "btrfs check" output.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>>
> >>>>> Please help me recover my data.
> >>>>>
> >>>>> Thanks and regards.
> >>>>> Dat
