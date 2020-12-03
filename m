Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC46B2CD8AF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgLCONK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 09:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgLCONK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 09:13:10 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E4DC061A4E;
        Thu,  3 Dec 2020 06:12:30 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id ek7so961056qvb.6;
        Thu, 03 Dec 2020 06:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=C2TT9Rg5U0V79FAF17Svrr2UwZCasmhZhTsumkMI0FI=;
        b=jIouUNhZKEJ3Al7g0qQhT3YXwCIA0tXDw9glcJqBpplFtM2+aombh0O4Sh2n628qff
         qDzxomsg7z72Vj2LT0p0L9ZYqdFP9NNppdpurcc+6rhothOES14oqdOL2zXNKnAUnrhm
         xPqL0l/KNUx8bcBh/YQ+eWOaBuB8MBcfzB6U78LHT3hJBuLYV26QksyG145ppOVx+y31
         pyQ8Yd2mZ6Cpb2KNJZ6ocytm714gktLUFi0cSmcDfp/sJon6RBAxkbOuN8MTk6Eq8erO
         ahc2O0FT8aSFP80yqQFP8BNa92OFaQgtOt3axLgDatGPwjsnHJyw/pHpizzvxwQSJi/B
         HLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=C2TT9Rg5U0V79FAF17Svrr2UwZCasmhZhTsumkMI0FI=;
        b=gYzEL9TCKcP4Ee+ezVuXOTjbEmkENM3+dfjcBJrmrI6zVgW6ezY7WRRRtM9KcS0Xjq
         KHmQhPs0hmD2p6IRndUPfTW4cz+WrPH20cH4RTip2LgBZXLMCLqaMKMFYoo94RNgNrAn
         39cWrv4NUVShZ1L6aHzZpHpZ8PTO20OOFjAmEc7jaFDRmN9pGQIB3d5JcSnTWHzcg4YD
         NRAc6gClsHp4uQc3qL2w3aougzelywraLUB+0Jwyct24veg6YRnfozIRbJ8vxIxlq6sD
         0dOYZKaHVieZN4Kchcl1V4spE9CGeortd+/5W9tNGsJbcyi+TB9Q9ZA2kF/bwt+7DO/F
         iMxA==
X-Gm-Message-State: AOAM531RmcAGFWefJ7jsyF8+ZRE/aXolBZpqbqSQMAlvH8ZjGzR9gpv4
        ytvF+9nl/ks/9fCjv9ScrUaYyJVZPnbJBdgGqcxSZUK4ZWA=
X-Google-Smtp-Source: ABdhPJxsX7XPkBP+YlgfdKAKC+0mXECwNQjqVv9Up2V3ZruQoFL5iiVGxVcIa3QH43s1q6K9y8HTiUhluLTmab+NLOw=
X-Received: by 2002:a0c:9003:: with SMTP id o3mr3363707qvo.62.1607004749272;
 Thu, 03 Dec 2020 06:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20201126105013.246270-1-ethanwu@synology.com> <20201129071904.GO3853@desktop>
 <CACKp3fnZRFsXAZL=WYnBj2L2KcBp1JmnfMZWHNp=XVgRwb56Zw@mail.gmail.com>
 <CAL3q7H5vRorBsz9wEKzfOdHzvdG1Q8KPzZjEzEBT2Gu1-NHxQQ@mail.gmail.com> <20201202162108.GQ80581@e18g06458.et15sqa>
In-Reply-To: <20201202162108.GQ80581@e18g06458.et15sqa>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 3 Dec 2020 14:12:18 +0000
Message-ID: <CAL3q7H4AS6xdcHLgYKe_XXEm92b8hp6Uod77fm-zA82VG2Wpgw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test if rename handles dir item collision correctly
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     tzuchieh wu <ethan198912@gmail.com>, Eryu Guan <guan@eryu.me>,
        ethanwu <ethanwu@synology.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 2, 2020 at 4:21 PM Eryu Guan <eguan@linux.alibaba.com> wrote:
>
> On Wed, Dec 02, 2020 at 10:47:46AM +0000, Filipe Manana wrote:
> > On Tue, Dec 1, 2020 at 7:00 AM tzuchieh wu <ethan198912@gmail.com> wrot=
e:
> > >
> > > Eryu Guan <guan@eryu.me> =E6=96=BC 2020=E5=B9=B411=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=883:22=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > >
> > > > On Thu, Nov 26, 2020 at 06:50:13PM +0800, ethanwu wrote:
> > > > > This is a regression test for the issue fixed by the kernel commi=
t titled
> > > > > "Btrfs: correctly calculate item size used when item key collisio=
n happends"
> > > > >
> > > > > In this case, we'll simply rename many forged filename that cause=
 collision
> > > > > under a directory to see if rename failed and filesystem is force=
d readonly.
> > > > >
> > > > > Signed-off-by: ethanwu <ethanwu@synology.com>
> > > > > ---
> > > > >  tests/btrfs/227     | 311 ++++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  tests/btrfs/227.out |   2 +
> > > > >  tests/btrfs/group   |   1 +
> > > > >  3 files changed, 314 insertions(+)
> > > > >  create mode 100755 tests/btrfs/227
> > > > >  create mode 100644 tests/btrfs/227.out
> > > > >
> > > > > diff --git a/tests/btrfs/227 b/tests/btrfs/227
> > > > > new file mode 100755
> > > > > index 00000000..ba1cd359
> > > > > --- /dev/null
> > > > > +++ b/tests/btrfs/227
> > > > > @@ -0,0 +1,311 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) 2020 Synology.  All Rights Reserved.
> > > > > +#
> > > > > +# FS QA Test 227
> > > > > +#
> > > > > +# Test if btrfs rename handle dir item collision correctly
> > > > > +# Without patch fix, rename will fail with EOVERFLOW, and filesy=
stem
> > > > > +# is forced readonly.
> > > > > +#
> > > > > +# This bug is going to be fxied by a patch for kernel titled
> > > > > +# "Btrfs: correctly calculate item size used when item key colli=
sion happends"
> > > > > +#
> > > > > +seq=3D`basename $0`
> > > > > +seqres=3D$RESULT_DIR/$seq
> > > > > +echo "QA output created by $seq"
> > > > > +
> > > > > +here=3D`pwd`
> > > > > +tmp=3D/tmp/$$
> > > > > +status=3D1     # failure is the default!
> > > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > > +
> > > > > +_cleanup()
> > > > > +{
> > > > > +    cd /
> > > > > +    rm -f $tmp.*
> > > > > +}
> > > > > +
> > > > > +# get standard environment, filters and checks
> > > > > +. ./common/rc
> > > > > +. ./common/filter
> > > > > +
> > > > > +# real QA test starts here
> > > > > +
> > > > > +_supported_fs btrfs
> > > > > +_require_scratch
> > > > > +
> > > > > +rm -f $seqres.full
> > > > > +
> > > > > +# Currently in btrfs the node/leaf size can not be smaller than =
the page
> > > > > +# size (but it can be greater than the page size). So use the la=
rgest
> > > > > +# supported node/leaf size (64Kb) so that the test can run on an=
y platform
> > > > > +# that Linux supports.
> > > > > +_scratch_mkfs "--nodesize 65536" >>$seqres.full 2>&1
> > > > > +_scratch_mount
> > > > > +
> > > > > +file_name_list=3D(d6d0dIka505ebc681949a25a3f1a4e7464f18bfcdb04a1=
03b8ece40cddf61ccc9e690232878008edceecda8633591197bce8c0105891d2717425cb4bd=
04223bb08426de820da732c0e16b8a9fa236bb5b5260e526639780dacd378ca79428f640a03=
00a11a98f4f92719c62d6f7d756fa80f0aa654ae06
> > > >
> > > > The file names are too long for the test, I'm wondering how are the
> > > > names that could cause collisions generated in the first place? Is =
it
> > > > possible to re-generate them at runtime? Instead of hard-coding the=
m in
> > > > the array.
> > > >
> > > > Thanks,
> > > > Eryu
> > >
> > > I use the following script to generate the names
> > > https://raw.githubusercontent.com/wutzuchieh/misc_tools/master/crc32_=
forge.py
> > > but skip names with unprintable characters.
> > >
> > > The total available spaces could not be divided evenly to have the
> > > same file length,
> > > and this script could only be used to generate filename of the same l=
ength.
> > > Different length would result in different crc32, but I haven't figur=
ed out why.
> > > Therefore, I use btrfs-crc -c <desired crc> -l <length> to generate
> > > the last 2 names which don't
> > > have equal length with the previous ones. The last procedure indeed
> > > took a while to run.
>
> How much time does it take for btrfs-crc to generate the last 2 names? I
> think we could live with it if it requires tens of seconds.
>
> > > Hard-coded names would make time spent on the test more predictable.
> >
> > While I don't mind having the hardcoded names in the test, adding a
> > program to generate them would be perfect.
> > The python script triggers the issue very fast (it takes only a few
> > seconds on the box I tested with), but adding a dependency on python
> > may not please everyone (plus it would be better to convert it to
> > python 3).
>
> We've already have dependency on python in perf tests (please see
> src/perf, common/perf and tests/perf), so adding another python script
> is fine. But we depend on python2 for now (PYTHON2_PROG in
> common/config), I guess leave it as python2 script should be fine too.

Ah, never noticed that before.
So adding Ethan's python 2 reproducer (with slight changes like taking
a path as an argument) and calling it from a btrfs specific test case
is the easiest way.

>
> > The only alternative is to convert it to a C program and add it to src/=
.
>
> Yeah, that works too.

In that case I have no strong preference for C vs python script.
Thanks.

>
> Thanks,
> Eryu
>
> >
> > Eryu?
> >
> > >
> > > thanks,
> > > ethanwu
> >
> >
> >
> > --
> > Filipe David Manana,
> >
> > =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 yo=
u're right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
