Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF692C97BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Dec 2020 08:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgLAHAq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Dec 2020 02:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgLAHAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Dec 2020 02:00:45 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862A9C0613CF;
        Mon, 30 Nov 2020 23:00:05 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so589799pls.10;
        Mon, 30 Nov 2020 23:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DlSOG26NFBgDoWs2/mFc7EobBO9b7irVfLzFtEl66bI=;
        b=kf4yWLxnHaMAAyKo0DRK9MYcV9e/dgdk26kbgam7fQ6VH8azOqKc5HFRgd2jKD+TWa
         AxMAt0Kz+HBmTCFL3BiBqkjaEzOinrDckGRouu5XeaC9NVVPPPnUAtR33U5rIWycaXdY
         qG448yPAnLv4/HKpoLSBoOSQJ5Jjna5Q33OKPjcdZ7Qcz3VLt17tSrqXMMcsJ/AYXj0+
         f/iLOBzPXfwU2su5T9fOFp/xzXo6gR824bDLF50H6nbJS9yLS4Uc6wF0Jt9OTkHrjgkE
         NOELgSuLx6mLoi6nlNtzq2i0QUGBkwRkb34CjwRPInhozcyY8WX1Dg8yFPrESd3N6lUM
         rlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DlSOG26NFBgDoWs2/mFc7EobBO9b7irVfLzFtEl66bI=;
        b=eDyewOAOuSo2lvCuai9GB/T51OLYJfQ7L1HIauclfw+JQvzPqoDm0NSWz6ALNYWHZA
         8DMu3BL4HmVSzJ2LuVe5Jyc4VVME52wT9G2zrr1JzcPObBVvafYPQz3fdfrDUsyJyTDs
         DQRt407VZ1UizFiqvSHhRkFzU/Tswwk4epyVTILXeY2LuQVc5AyT2d5UxWVT6F1WOnex
         2tAy/g7b8Lvl6f18r9YAp/pe6NEX53CTQpw8wHz+ENoObR+bQOlClslSRaalKT585UyT
         sVvyEgzK56qnJ3VSCeaAS1CKmEECgT7dZSaS8VcjGrlFyzkC97gebHQgsE8rsby6tz9S
         FhNQ==
X-Gm-Message-State: AOAM532g03yhMPYSZAJJaCXLypmqDzTizJ9UrVyxM4jplr97xXGFhZln
        t6xOUOGuklqvyPHksn+GYc8A/69NY/rUiNU/ITM=
X-Google-Smtp-Source: ABdhPJwHT3hNbqXILfDK4HjtJi/rEVddF9IoaJ7kwLmauYSBIEOdJtj2Fbsb5ROIO1uo6Ad0HbR4/IRFA5vP3ckNpvM=
X-Received: by 2002:a17:90a:5518:: with SMTP id b24mr1356841pji.138.1606806004844;
 Mon, 30 Nov 2020 23:00:04 -0800 (PST)
MIME-Version: 1.0
References: <20201126105013.246270-1-ethanwu@synology.com> <20201129071904.GO3853@desktop>
In-Reply-To: <20201129071904.GO3853@desktop>
From:   tzuchieh wu <ethan198912@gmail.com>
Date:   Tue, 1 Dec 2020 14:59:53 +0800
Message-ID: <CACKp3fnZRFsXAZL=WYnBj2L2KcBp1JmnfMZWHNp=XVgRwb56Zw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test if rename handles dir item collision correctly
To:     Eryu Guan <guan@eryu.me>
Cc:     ethanwu <ethanwu@synology.com>, fstests@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>, fdmanana@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Eryu Guan <guan@eryu.me> =E6=96=BC 2020=E5=B9=B411=E6=9C=8829=E6=97=A5 =E9=
=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=883:22=E5=AF=AB=E9=81=93=EF=BC=9A

>
> On Thu, Nov 26, 2020 at 06:50:13PM +0800, ethanwu wrote:
> > This is a regression test for the issue fixed by the kernel commit titl=
ed
> > "Btrfs: correctly calculate item size used when item key collision happ=
ends"
> >
> > In this case, we'll simply rename many forged filename that cause colli=
sion
> > under a directory to see if rename failed and filesystem is forced read=
only.
> >
> > Signed-off-by: ethanwu <ethanwu@synology.com>
> > ---
> >  tests/btrfs/227     | 311 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/227.out |   2 +
> >  tests/btrfs/group   |   1 +
> >  3 files changed, 314 insertions(+)
> >  create mode 100755 tests/btrfs/227
> >  create mode 100644 tests/btrfs/227.out
> >
> > diff --git a/tests/btrfs/227 b/tests/btrfs/227
> > new file mode 100755
> > index 00000000..ba1cd359
> > --- /dev/null
> > +++ b/tests/btrfs/227
> > @@ -0,0 +1,311 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2020 Synology.  All Rights Reserved.
> > +#
> > +# FS QA Test 227
> > +#
> > +# Test if btrfs rename handle dir item collision correctly
> > +# Without patch fix, rename will fail with EOVERFLOW, and filesystem
> > +# is forced readonly.
> > +#
> > +# This bug is going to be fxied by a patch for kernel titled
> > +# "Btrfs: correctly calculate item size used when item key collision h=
appends"
> > +#
> > +seq=3D`basename $0`
> > +seqres=3D$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=3D`pwd`
> > +tmp=3D/tmp/$$
> > +status=3D1     # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +    cd /
> > +    rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs btrfs
> > +_require_scratch
> > +
> > +rm -f $seqres.full
> > +
> > +# Currently in btrfs the node/leaf size can not be smaller than the pa=
ge
> > +# size (but it can be greater than the page size). So use the largest
> > +# supported node/leaf size (64Kb) so that the test can run on any plat=
form
> > +# that Linux supports.
> > +_scratch_mkfs "--nodesize 65536" >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +file_name_list=3D(d6d0dIka505ebc681949a25a3f1a4e7464f18bfcdb04a103b8ec=
e40cddf61ccc9e690232878008edceecda8633591197bce8c0105891d2717425cb4bd04223b=
b08426de820da732c0e16b8a9fa236bb5b5260e526639780dacd378ca79428f640a0300a11a=
98f4f92719c62d6f7d756fa80f0aa654ae06
>
> The file names are too long for the test, I'm wondering how are the
> names that could cause collisions generated in the first place? Is it
> possible to re-generate them at runtime? Instead of hard-coding them in
> the array.
>
> Thanks,
> Eryu

I use the following script to generate the names
https://raw.githubusercontent.com/wutzuchieh/misc_tools/master/crc32_forge.=
py
but skip names with unprintable characters.

The total available spaces could not be divided evenly to have the
same file length,
and this script could only be used to generate filename of the same length.
Different length would result in different crc32, but I haven't figured out=
 why.
Therefore, I use btrfs-crc -c <desired crc> -l <length> to generate
the last 2 names which don't
have equal length with the previous ones. The last procedure indeed
took a while to run.
Hard-coded names would make time spent on the test more predictable.

thanks,
ethanwu
