Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8C93FAC25
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhH2OLD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 10:11:03 -0400
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:55122 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbhH2OLC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 10:11:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07598105|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.621035-0.00304223-0.375923;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.LCCfxqt_1630246208;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.LCCfxqt_1630246208)
          by smtp.aliyun-inc.com(10.147.41.158);
          Sun, 29 Aug 2021 22:10:09 +0800
Date:   Sun, 29 Aug 2021 22:10:08 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs/246: add test case to make sure btrfs
 can create compressed inline extent
Message-ID: <YSuVQBEX0WU4NQzv@desktop>
References: <20210826053432.13146-1-wqu@suse.com>
 <YSuOr0XhCgVBcnc8@desktop>
 <e85d5800-8f4a-5bca-a5a6-e537f2fb998a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e85d5800-8f4a-5bca-a5a6-e537f2fb998a@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 29, 2021 at 09:49:05PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/29 下午9:42, Eryu Guan wrote:
> > On Thu, Aug 26, 2021 at 01:34:32PM +0800, Qu Wenruo wrote:
> > > Btrfs has the ability to inline small file extents into its metadata,
> > > and such inlined extents can be further compressed if needed.
> > > 
> > > The new test case is for a regression caused by commit f2165627319f
> > > ("btrfs: compression: don't try to compress if we don't have enough
> > > pages").
> > > 
> > > That commit prevents btrfs from creating compressed inline extents, even
> > > "-o compress,max_inline=2048" is specified, only uncompressed inline
> > > extents can be created.
> > > 
> > > The test case will make sure that the content of the small file is
> > > consistent between cycle mount, then use "btrfs inspect dump-tree" to
> > > verify the created extent is both inlined and compressed.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > Is there a proposed fix available that could be referenced in the commit
> > log?
> 
> The upstream commit is 4e9655763b82 ("Revert "btrfs: compression: don't try
> to compress if we don't have enough pages""), which is merged after I
> submitted the patch.

Ok. It also could be helpful to just include the proposed patch title if
it's not merged yet.

> 
> > 
> > > ---
> > > Changelog:
> > > v2:
> > > - Also output the sha256sum to make sure the content is consistent
> > > ---
> > >   tests/btrfs/246     | 53 +++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/btrfs/246.out |  5 +++++
> > >   2 files changed, 58 insertions(+)
> > >   create mode 100755 tests/btrfs/246
> > >   create mode 100644 tests/btrfs/246.out
> > > 
> > > diff --git a/tests/btrfs/246 b/tests/btrfs/246
> > > new file mode 100755
> > > index 00000000..e0d8016f
> > > --- /dev/null
> > > +++ b/tests/btrfs/246
> > > @@ -0,0 +1,53 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 246
> > > +#
> > > +# Make sure btrfs can create compressed inline extents
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick compress
> > > +
> > > +# Override the default cleanup function.
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -r -f $tmp.*
> > > +}
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +# For __populate_find_inode()
> > > +. ./common/populate
> > 
> > This function starts with double underscore, I take it as a 'private'
> > function in common/populate. But all it does is returning the inode
> > number of the given file, I think we could just open-code it in this
> > test as
> > 
> > ino=$(stat -c %i $SCRATCH_MNT/foobar)
> > 
> > Otherwise test looks fine to me.
> 
> Mind me to send an update to include the fix in commit message and use the
> local ino helper?

You're responding quickly, I haven't finalized this week's update yet,
so I can add the fix commit info and remove __populate_find_inode on
commit :)

Thanks,
Eryu
