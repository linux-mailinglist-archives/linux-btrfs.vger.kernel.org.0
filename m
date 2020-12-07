Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953602D0DE1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 11:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgLGKUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 05:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgLGKUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 05:20:01 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474ADC0613D0;
        Mon,  7 Dec 2020 02:19:21 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l23so7175556pjg.1;
        Mon, 07 Dec 2020 02:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zM0STFNl+TrdSTd3chX6Np3Mz0MyVs/Uw5/fBD2hRf8=;
        b=k+VYtNIXNyPa6NueilNk+uifCqv6GCP49YbSEkv8Vz7Lts8HZ/huCbS86TfBdWt+s8
         A8NdfseJFMgbkPDBz7twpKoBkWbqeJeuv7iGKIWMj/tJw7HWjRhViicJLPNU5/2gJOof
         B2QseL2jpwlbsNKiwwpca6c6qJOkP5f43XCDnWS5v/qVELGjVIFYv1Xj+dY2/T4Hso/V
         QB4WE1Wcas/YaJ3CuJgnVviz2qASOUWENaKKktFhKU9SdG+h5+i/fWxkb+y9H33fzoiE
         h7g3IHgek2FZRCX4YEVG99KVYWu78csofhOOKyar6z3nSoyWOQ+kdGmZcM4RxqwowOWd
         6HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zM0STFNl+TrdSTd3chX6Np3Mz0MyVs/Uw5/fBD2hRf8=;
        b=WSD8vDz4qPXuZUWIZWnOsvMA8a9PMOjs+4FzvX484dgGuBZnO7U1uY5/8Bvyveh8tm
         Ep8JJ2zl3O51C6/LoMErE0i9MWrtuwWwcLasz8kQgP79QQLeGd5LWa5EgpHLL3kckBpP
         KxT1h+nNrjAmvG1f7iGAEZBrki5c86iO1TGRGsaz3dLW0umQsw5UTpYN8HAo/zMz0lFB
         mhKM/3c3BqkxWK5IcFrdi6F69hh9LrZVG3v6jF5VyIfzTUX9oDdjs/AxRGnFyxaGGPSh
         WKN/cAfTbvUnP33PguLULfF+J8/UsRMws9gMxD788PdxYM0EkbjZ7kwYRhT+xc7yPJ9I
         L7pw==
X-Gm-Message-State: AOAM533u1TKzd1YNxTDBgWFZEWwIR5Wy7j4Bv4q+MHO4R0aUFngV8sWe
        nNz/suYZkYsqLl7P+DUt6rQS4tgoL9a7INNDLAQ=
X-Google-Smtp-Source: ABdhPJxqN0C8eJtjYWWAaGRvNFf7aPvHwJVShmU0zhH5Yt1y+Rr111x2dEEUoMr8f71z2josmZs9q9UbCLHQF3BjliQ=
X-Received: by 2002:a17:90b:2285:: with SMTP id kx5mr16248875pjb.104.1607336360625;
 Mon, 07 Dec 2020 02:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20201126105013.246270-1-ethanwu@synology.com> <20201129071904.GO3853@desktop>
 <CACKp3fnZRFsXAZL=WYnBj2L2KcBp1JmnfMZWHNp=XVgRwb56Zw@mail.gmail.com>
 <CAL3q7H5vRorBsz9wEKzfOdHzvdG1Q8KPzZjEzEBT2Gu1-NHxQQ@mail.gmail.com>
 <20201202162108.GQ80581@e18g06458.et15sqa> <CAL3q7H4AS6xdcHLgYKe_XXEm92b8hp6Uod77fm-zA82VG2Wpgw@mail.gmail.com>
In-Reply-To: <CAL3q7H4AS6xdcHLgYKe_XXEm92b8hp6Uod77fm-zA82VG2Wpgw@mail.gmail.com>
From:   tzuchieh wu <ethan198912@gmail.com>
Date:   Mon, 7 Dec 2020 18:19:09 +0800
Message-ID: <CACKp3f=SpJvifiWu+fcgJC_7Cqs_svTJfzKox5gcv3LibK=Gnw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test if rename handles dir item collision correctly
To:     fdmanana@gmail.com
Cc:     Eryu Guan <eguan@linux.alibaba.com>, Eryu Guan <guan@eryu.me>,
        ethanwu <ethanwu@synology.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe Manana <fdmanana@gmail.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=883=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, Dec 2, 2020 at 4:21 PM Eryu Guan <eguan@linux.alibaba.com> wrote:
> >
> > On Wed, Dec 02, 2020 at 10:47:46AM +0000, Filipe Manana wrote:
> > > On Tue, Dec 1, 2020 at 7:00 AM tzuchieh wu <ethan198912@gmail.com> wr=
ote:
> > > >
> > > > Eryu Guan <guan@eryu.me> =E6=96=BC 2020=E5=B9=B411=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=883:22=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > >
> > > > > On Thu, Nov 26, 2020 at 06:50:13PM +0800, ethanwu wrote:
> > > > > > This is a regression test for the issue fixed by the kernel com=
mit titled
> > > > > > "Btrfs: correctly calculate item size used when item key collis=
ion happends"
> > > > > >
> > > > > > In this case, we'll simply rename many forged filename that cau=
se collision
> > > > > > under a directory to see if rename failed and filesystem is for=
ced readonly.
> > > > > >
> > > > > > Signed-off-by: ethanwu <ethanwu@synology.com>
> > > > > > ---
> > > > > >  tests/btrfs/227     | 311 ++++++++++++++++++++++++++++++++++++=
++++++++
> > > > > >  tests/btrfs/227.out |   2 +
> > > > > >  tests/btrfs/group   |   1 +
> > > > > >  3 files changed, 314 insertions(+)
> > > > > >  create mode 100755 tests/btrfs/227
> > > > > >  create mode 100644 tests/btrfs/227.out
> > > > > >
> > > > > > diff --git a/tests/btrfs/227 b/tests/btrfs/227
> > > > > > new file mode 100755
> > > > > > index 00000000..ba1cd359
> > > > > > --- /dev/null
> > > > > > +++ b/tests/btrfs/227
> > > > > > @@ -0,0 +1,311 @@
> > > > > > +#! /bin/bash
> > > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > > +# Copyright (c) 2020 Synology.  All Rights Reserved.
> > > > > > +#
> > > > > > +# FS QA Test 227
> > > > > > +#
> > > > > > +# Test if btrfs rename handle dir item collision correctly
> > > > > > +# Without patch fix, rename will fail with EOVERFLOW, and file=
system
> > > > > > +# is forced readonly.
> > > > > > +#
> > > > > > +# This bug is going to be fxied by a patch for kernel titled
> > > > > > +# "Btrfs: correctly calculate item size used when item key col=
lision happends"
> > > > > > +#
> > > > > > +seq=3D`basename $0`
> > > > > > +seqres=3D$RESULT_DIR/$seq
> > > > > > +echo "QA output created by $seq"
> > > > > > +
> > > > > > +here=3D`pwd`
> > > > > > +tmp=3D/tmp/$$
> > > > > > +status=3D1     # failure is the default!
> > > > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > > > +
> > > > > > +_cleanup()
> > > > > > +{
> > > > > > +    cd /
> > > > > > +    rm -f $tmp.*
> > > > > > +}
> > > > > > +
> > > > > > +# get standard environment, filters and checks
> > > > > > +. ./common/rc
> > > > > > +. ./common/filter
> > > > > > +
> > > > > > +# real QA test starts here
> > > > > > +
> > > > > > +_supported_fs btrfs
> > > > > > +_require_scratch
> > > > > > +
> > > > > > +rm -f $seqres.full
> > > > > > +
> > > > > > +# Currently in btrfs the node/leaf size can not be smaller tha=
n the page
> > > > > > +# size (but it can be greater than the page size). So use the =
largest
> > > > > > +# supported node/leaf size (64Kb) so that the test can run on =
any platform
> > > > > > +# that Linux supports.
> > > > > > +_scratch_mkfs "--nodesize 65536" >>$seqres.full 2>&1
> > > > > > +_scratch_mount
> > > > > > +
> > > > > > +file_name_list=3D(d6d0dIka505ebc681949a25a3f1a4e7464f18bfcdb04=
a103b8ece40cddf61ccc9e690232878008edceecda8633591197bce8c0105891d2717425cb4=
bd04223bb08426de820da732c0e16b8a9fa236bb5b5260e526639780dacd378ca79428f640a=
0300a11a98f4f92719c62d6f7d756fa80f0aa654ae06
> > > > >
> > > > > The file names are too long for the test, I'm wondering how are t=
he
> > > > > names that could cause collisions generated in the first place? I=
s it
> > > > > possible to re-generate them at runtime? Instead of hard-coding t=
hem in
> > > > > the array.
> > > > >
> > > > > Thanks,
> > > > > Eryu
> > > >
> > > > I use the following script to generate the names
> > > > https://raw.githubusercontent.com/wutzuchieh/misc_tools/master/crc3=
2_forge.py
> > > > but skip names with unprintable characters.
> > > >
> > > > The total available spaces could not be divided evenly to have the
> > > > same file length,
> > > > and this script could only be used to generate filename of the same=
 length.
> > > > Different length would result in different crc32, but I haven't fig=
ured out why.
> > > > Therefore, I use btrfs-crc -c <desired crc> -l <length> to generate
> > > > the last 2 names which don't
> > > > have equal length with the previous ones. The last procedure indeed
> > > > took a while to run.
> >
> > How much time does it take for btrfs-crc to generate the last 2 names? =
I
> > think we could live with it if it requires tens of seconds.
> >
> > > > Hard-coded names would make time spent on the test more predictable=
.
> > >
> > > While I don't mind having the hardcoded names in the test, adding a
> > > program to generate them would be perfect.
> > > The python script triggers the issue very fast (it takes only a few
> > > seconds on the box I tested with), but adding a dependency on python
> > > may not please everyone (plus it would be better to convert it to
> > > python 3).
> >
> > We've already have dependency on python in perf tests (please see
> > src/perf, common/perf and tests/perf), so adding another python script
> > is fine. But we depend on python2 for now (PYTHON2_PROG in
> > common/config), I guess leave it as python2 script should be fine too.
>
> Ah, never noticed that before.
> So adding Ethan's python 2 reproducer (with slight changes like taking
> a path as an argument) and calling it from a btrfs specific test case
> is the easiest way.
>
> >
> > > The only alternative is to convert it to a C program and add it to sr=
c/.
> >
> > Yeah, that works too.
>
> In that case I have no strong preference for C vs python script.
> Thanks.
>

OK, then I'll change the test to use the python script and resend patch.

thanks,
ethanwu



> >
> > Thanks,
> > Eryu
> >
> > >
> > > Eryu?
> > >
> > > >
> > > > thanks,
> > > > ethanwu
> > >
> > >
> > >
> > > --
> > > Filipe David Manana,
> > >
> > > =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 =
you're right.=E2=80=9D
>
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D
