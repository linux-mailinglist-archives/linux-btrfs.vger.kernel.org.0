Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E6B267FD9
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Sep 2020 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIMPEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Sep 2020 11:04:04 -0400
Received: from out20-27.mail.aliyun.com ([115.124.20.27]:37945 "EHLO
        out20-27.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgIMPED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Sep 2020 11:04:03 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09061719|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.6934-0.00242062-0.304179;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.IWZn-ZV_1600009437;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IWZn-ZV_1600009437)
          by smtp.aliyun-inc.com(10.147.41.187);
          Sun, 13 Sep 2020 23:03:57 +0800
Date:   Sun, 13 Sep 2020 23:03:57 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH][v4] fstests: add generic/609 to test O_DIRECT|O_DSYNC
Message-ID: <20200913150357.GH3853@desktop>
References: <8e841e0e05934baaf6119363414440b271426a03.1599065695.git.josef@toxicpanda.com>
 <20200902171036.273416-1-josef@toxicpanda.com>
 <CAL3q7H4sZguHFddwAeEFOkdOtbTZ-MHmDPuOR2obHVPro0nkkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4sZguHFddwAeEFOkdOtbTZ-MHmDPuOR2obHVPro0nkkw@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 04, 2020 at 02:12:35PM +0100, Filipe Manana wrote:
> On Wed, Sep 2, 2020 at 6:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > We had a problem recently where btrfs would deadlock with
> > O_DIRECT|O_DSYNC because of an unexpected dependency on ->fsync in
> > iomap.  This was only caught by chance with aiostress, because weirdly
> > we don't actually test this particular configuration anywhere in
> > xfstests.  Fix this by adding a basic test that just does
> > O_DIRECT|O_DSYNC writes.  With this test the box deadlocks right away
> > with Btrfs, which would have been helpful in finding this issue before
> > the patches were merged.
> >
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > v3->v4:
> > - Trying to see how many times I can fuck this thing up.
> > - Simplified the xfs_io command per Darrick's suggestion.
> > - Added it to the rw group.
> >
> >  tests/generic/609     | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/609.out |  3 +++
> >  tests/generic/group   |  1 +
> >  3 files changed, 47 insertions(+)
> >  create mode 100755 tests/generic/609
> >  create mode 100644 tests/generic/609.out
> >
> > diff --git a/tests/generic/609 b/tests/generic/609
> > new file mode 100755
> > index 00000000..6c74ae63
> > --- /dev/null
> > +++ b/tests/generic/609
> > @@ -0,0 +1,43 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2020 Josef Bacik.  All Rights Reserved.
> > +#
> > +# FS QA Test 609
> > +#
> > +# iomap can call generic_write_sync() if we're O_DSYNC, so write a basic test to
> > +# exercise O_DSYNC so any unsuspecting file systems will get lockdep warnings if
> > +# their locking isn't compatible.
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1       # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +       cd /
> > +       rm -f $tmp.*
> > +       rm -rf $TEST_DIR/file
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_test
> > +_require_xfs_io_command "pwrite"
> 
> missing a:
> 
> _require_odirect
> 
> Other than that, it looks good. Perhaps Eryu can add that when picking
> this, so you avoid sending a v5.

Yeah, I've added that on commit.

> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks for the review!

Eryu
