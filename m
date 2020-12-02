Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1822CC21D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 17:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbgLBQV6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 11:21:58 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33099 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbgLBQV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 11:21:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UHL5o.3_1606926068;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UHL5o.3_1606926068)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Dec 2020 00:21:09 +0800
Date:   Thu, 3 Dec 2020 00:21:08 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     tzuchieh wu <ethan198912@gmail.com>, Eryu Guan <guan@eryu.me>,
        ethanwu <ethanwu@synology.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: test if rename handles dir item collision
 correctly
Message-ID: <20201202162108.GQ80581@e18g06458.et15sqa>
References: <20201126105013.246270-1-ethanwu@synology.com>
 <20201129071904.GO3853@desktop>
 <CACKp3fnZRFsXAZL=WYnBj2L2KcBp1JmnfMZWHNp=XVgRwb56Zw@mail.gmail.com>
 <CAL3q7H5vRorBsz9wEKzfOdHzvdG1Q8KPzZjEzEBT2Gu1-NHxQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5vRorBsz9wEKzfOdHzvdG1Q8KPzZjEzEBT2Gu1-NHxQQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 02, 2020 at 10:47:46AM +0000, Filipe Manana wrote:
> On Tue, Dec 1, 2020 at 7:00 AM tzuchieh wu <ethan198912@gmail.com> wrote:
> >
> > Eryu Guan <guan@eryu.me> 於 2020年11月29日 週日 下午3:22寫道：
> >
> > >
> > > On Thu, Nov 26, 2020 at 06:50:13PM +0800, ethanwu wrote:
> > > > This is a regression test for the issue fixed by the kernel commit titled
> > > > "Btrfs: correctly calculate item size used when item key collision happends"
> > > >
> > > > In this case, we'll simply rename many forged filename that cause collision
> > > > under a directory to see if rename failed and filesystem is forced readonly.
> > > >
> > > > Signed-off-by: ethanwu <ethanwu@synology.com>
> > > > ---
> > > >  tests/btrfs/227     | 311 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/btrfs/227.out |   2 +
> > > >  tests/btrfs/group   |   1 +
> > > >  3 files changed, 314 insertions(+)
> > > >  create mode 100755 tests/btrfs/227
> > > >  create mode 100644 tests/btrfs/227.out
> > > >
> > > > diff --git a/tests/btrfs/227 b/tests/btrfs/227
> > > > new file mode 100755
> > > > index 00000000..ba1cd359
> > > > --- /dev/null
> > > > +++ b/tests/btrfs/227
> > > > @@ -0,0 +1,311 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2020 Synology.  All Rights Reserved.
> > > > +#
> > > > +# FS QA Test 227
> > > > +#
> > > > +# Test if btrfs rename handle dir item collision correctly
> > > > +# Without patch fix, rename will fail with EOVERFLOW, and filesystem
> > > > +# is forced readonly.
> > > > +#
> > > > +# This bug is going to be fxied by a patch for kernel titled
> > > > +# "Btrfs: correctly calculate item size used when item key collision happends"
> > > > +#
> > > > +seq=`basename $0`
> > > > +seqres=$RESULT_DIR/$seq
> > > > +echo "QA output created by $seq"
> > > > +
> > > > +here=`pwd`
> > > > +tmp=/tmp/$$
> > > > +status=1     # failure is the default!
> > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > +
> > > > +_cleanup()
> > > > +{
> > > > +    cd /
> > > > +    rm -f $tmp.*
> > > > +}
> > > > +
> > > > +# get standard environment, filters and checks
> > > > +. ./common/rc
> > > > +. ./common/filter
> > > > +
> > > > +# real QA test starts here
> > > > +
> > > > +_supported_fs btrfs
> > > > +_require_scratch
> > > > +
> > > > +rm -f $seqres.full
> > > > +
> > > > +# Currently in btrfs the node/leaf size can not be smaller than the page
> > > > +# size (but it can be greater than the page size). So use the largest
> > > > +# supported node/leaf size (64Kb) so that the test can run on any platform
> > > > +# that Linux supports.
> > > > +_scratch_mkfs "--nodesize 65536" >>$seqres.full 2>&1
> > > > +_scratch_mount
> > > > +
> > > > +file_name_list=(d6d0dIka505ebc681949a25a3f1a4e7464f18bfcdb04a103b8ece40cddf61ccc9e690232878008edceecda8633591197bce8c0105891d2717425cb4bd04223bb08426de820da732c0e16b8a9fa236bb5b5260e526639780dacd378ca79428f640a0300a11a98f4f92719c62d6f7d756fa80f0aa654ae06
> > >
> > > The file names are too long for the test, I'm wondering how are the
> > > names that could cause collisions generated in the first place? Is it
> > > possible to re-generate them at runtime? Instead of hard-coding them in
> > > the array.
> > >
> > > Thanks,
> > > Eryu
> >
> > I use the following script to generate the names
> > https://raw.githubusercontent.com/wutzuchieh/misc_tools/master/crc32_forge.py
> > but skip names with unprintable characters.
> >
> > The total available spaces could not be divided evenly to have the
> > same file length,
> > and this script could only be used to generate filename of the same length.
> > Different length would result in different crc32, but I haven't figured out why.
> > Therefore, I use btrfs-crc -c <desired crc> -l <length> to generate
> > the last 2 names which don't
> > have equal length with the previous ones. The last procedure indeed
> > took a while to run.

How much time does it take for btrfs-crc to generate the last 2 names? I
think we could live with it if it requires tens of seconds.

> > Hard-coded names would make time spent on the test more predictable.
> 
> While I don't mind having the hardcoded names in the test, adding a
> program to generate them would be perfect.
> The python script triggers the issue very fast (it takes only a few
> seconds on the box I tested with), but adding a dependency on python
> may not please everyone (plus it would be better to convert it to
> python 3).

We've already have dependency on python in perf tests (please see
src/perf, common/perf and tests/perf), so adding another python script
is fine. But we depend on python2 for now (PYTHON2_PROG in
common/config), I guess leave it as python2 script should be fine too.

> The only alternative is to convert it to a C program and add it to src/.

Yeah, that works too.

Thanks,
Eryu

> 
> Eryu?
> 
> >
> > thanks,
> > ethanwu
> 
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
