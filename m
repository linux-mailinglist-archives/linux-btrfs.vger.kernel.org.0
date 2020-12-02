Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DE42CBB02
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 11:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgLBKsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 05:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgLBKsj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 05:48:39 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD4AC0613D4;
        Wed,  2 Dec 2020 02:47:58 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id b144so703858qkc.13;
        Wed, 02 Dec 2020 02:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UyP6H58yvmYc8RWZ8S9p07dQSplQDXbNg91d1GIvQv8=;
        b=pZvoOJNA26qoGV2VvO3+xi6OzKhlrs8sKXSapMfw6w/VkE8HTFAYnPq1vvndY3tCfM
         6UKzJVujL1taaU7f9r2HL+hjL0woK2HiWXNJaIr/CT3pKluzxeWptEzgM9T/zffnNCSm
         wtmRd6oLRShihxRlKisW/Luznei1nvvOz8HE/fzHtcTTKyDLqck2O2jRviPtMnSYAD8G
         dzxiiBCaA+OgP26zNrIeqONTeSY4wz2XsjMRRwszuXxtO0DhRk3XGWcbObhQSUxJRAlG
         FvLIe/0PFa4GEgWP8jXPf3qW+Q7ix34QE+Vr/Dodrk8LTMZkYnxhdtD/eLBA9owbkP7g
         LHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UyP6H58yvmYc8RWZ8S9p07dQSplQDXbNg91d1GIvQv8=;
        b=LDUz0sF4mTrCpcxFHX/OUbHmAqovu7bOFppFnSSgM84FcozhSQ+og+O6+V9u9Vvp2i
         KDHqwUGCwl7+JwCdWkdLHy8P/VIaiyxrryoHtmq/4EA5zfK0FqzGVaYSd8hjckVrjb/J
         JhcpAQoQpKNr/jAX92fX5ZLyzxVARIzwl88zNKzoS+65Ba/scHY8vYAWp5sScWvDzvSA
         T0ieq/31Hg08eX0qxl9jbJJE9ZJV+fOO2nk+COG/eHfwGFzLF439Fcrm+1abAr2JomxK
         fR842sbLVmH0QKNRUseSBajMf9vQF6vvb21coQ10B3hxLb4qod47aE8j063qkKR3pnqg
         QO1g==
X-Gm-Message-State: AOAM531brdPHlPpJVrapBh59vJqrDzrZlwXW6brHAE27d347lrT478zB
        FsSZhlZT4brJFN0DM30Z/pAPoU09Ue0K34bshIrX+yRo
X-Google-Smtp-Source: ABdhPJwMNsIVpdwzqAP0k+bSCnUcYXV1b8DApM4Qs5mQn3Tr+Q01jVMwu9/wqLKX1dznzli4z0Yb3KlxjRQjiyg+6B8=
X-Received: by 2002:a05:620a:a90:: with SMTP id v16mr1718776qkg.479.1606906077956;
 Wed, 02 Dec 2020 02:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20201126105013.246270-1-ethanwu@synology.com> <20201129071904.GO3853@desktop>
 <CACKp3fnZRFsXAZL=WYnBj2L2KcBp1JmnfMZWHNp=XVgRwb56Zw@mail.gmail.com>
In-Reply-To: <CACKp3fnZRFsXAZL=WYnBj2L2KcBp1JmnfMZWHNp=XVgRwb56Zw@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 2 Dec 2020 10:47:46 +0000
Message-ID: <CAL3q7H5vRorBsz9wEKzfOdHzvdG1Q8KPzZjEzEBT2Gu1-NHxQQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test if rename handles dir item collision correctly
To:     tzuchieh wu <ethan198912@gmail.com>
Cc:     Eryu Guan <guan@eryu.me>, ethanwu <ethanwu@synology.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 1, 2020 at 7:00 AM tzuchieh wu <ethan198912@gmail.com> wrote:
>
> Eryu Guan <guan@eryu.me> =E6=96=BC 2020=E5=B9=B411=E6=9C=8829=E6=97=A5 =
=E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=883:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> >
> > On Thu, Nov 26, 2020 at 06:50:13PM +0800, ethanwu wrote:
> > > This is a regression test for the issue fixed by the kernel commit ti=
tled
> > > "Btrfs: correctly calculate item size used when item key collision ha=
ppends"
> > >
> > > In this case, we'll simply rename many forged filename that cause col=
lision
> > > under a directory to see if rename failed and filesystem is forced re=
adonly.
> > >
> > > Signed-off-by: ethanwu <ethanwu@synology.com>
> > > ---
> > >  tests/btrfs/227     | 311 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  tests/btrfs/227.out |   2 +
> > >  tests/btrfs/group   |   1 +
> > >  3 files changed, 314 insertions(+)
> > >  create mode 100755 tests/btrfs/227
> > >  create mode 100644 tests/btrfs/227.out
> > >
> > > diff --git a/tests/btrfs/227 b/tests/btrfs/227
> > > new file mode 100755
> > > index 00000000..ba1cd359
> > > --- /dev/null
> > > +++ b/tests/btrfs/227
> > > @@ -0,0 +1,311 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2020 Synology.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 227
> > > +#
> > > +# Test if btrfs rename handle dir item collision correctly
> > > +# Without patch fix, rename will fail with EOVERFLOW, and filesystem
> > > +# is forced readonly.
> > > +#
> > > +# This bug is going to be fxied by a patch for kernel titled
> > > +# "Btrfs: correctly calculate item size used when item key collision=
 happends"
> > > +#
> > > +seq=3D`basename $0`
> > > +seqres=3D$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=3D`pwd`
> > > +tmp=3D/tmp/$$
> > > +status=3D1     # failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +    cd /
> > > +    rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +
> > > +# real QA test starts here
> > > +
> > > +_supported_fs btrfs
> > > +_require_scratch
> > > +
> > > +rm -f $seqres.full
> > > +
> > > +# Currently in btrfs the node/leaf size can not be smaller than the =
page
> > > +# size (but it can be greater than the page size). So use the larges=
t
> > > +# supported node/leaf size (64Kb) so that the test can run on any pl=
atform
> > > +# that Linux supports.
> > > +_scratch_mkfs "--nodesize 65536" >>$seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +file_name_list=3D(d6d0dIka505ebc681949a25a3f1a4e7464f18bfcdb04a103b8=
ece40cddf61ccc9e690232878008edceecda8633591197bce8c0105891d2717425cb4bd0422=
3bb08426de820da732c0e16b8a9fa236bb5b5260e526639780dacd378ca79428f640a0300a1=
1a98f4f92719c62d6f7d756fa80f0aa654ae06
> >
> > The file names are too long for the test, I'm wondering how are the
> > names that could cause collisions generated in the first place? Is it
> > possible to re-generate them at runtime? Instead of hard-coding them in
> > the array.
> >
> > Thanks,
> > Eryu
>
> I use the following script to generate the names
> https://raw.githubusercontent.com/wutzuchieh/misc_tools/master/crc32_forg=
e.py
> but skip names with unprintable characters.
>
> The total available spaces could not be divided evenly to have the
> same file length,
> and this script could only be used to generate filename of the same lengt=
h.
> Different length would result in different crc32, but I haven't figured o=
ut why.
> Therefore, I use btrfs-crc -c <desired crc> -l <length> to generate
> the last 2 names which don't
> have equal length with the previous ones. The last procedure indeed
> took a while to run.
> Hard-coded names would make time spent on the test more predictable.

While I don't mind having the hardcoded names in the test, adding a
program to generate them would be perfect.
The python script triggers the issue very fast (it takes only a few
seconds on the box I tested with), but adding a dependency on python
may not please everyone (plus it would be better to convert it to
python 3).
The only alternative is to convert it to a C program and add it to src/.

Eryu?

>
> thanks,
> ethanwu



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
