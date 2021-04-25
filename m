Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F056836A4E7
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Apr 2021 07:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhDYFOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Apr 2021 01:14:49 -0400
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:43079 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDYFOt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Apr 2021 01:14:49 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07534295|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.109334-0.0016002-0.889066;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.K3grzdV_1619327647;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.K3grzdV_1619327647)
          by smtp.aliyun-inc.com(10.147.42.16);
          Sun, 25 Apr 2021 13:14:08 +0800
Date:   Sun, 25 Apr 2021 13:14:07 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Boris Burkov <boris@bur.io>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic: test fiemap offsets and < 512 byte ranges
Message-ID: <YIT6n8Y2pmQb5Y5t@desktop>
References: <20210407161046.GY1670408@magnolia>
 <c2f49fdead29fd7eb979b83028eb9fcf56d2457c.1617826068.git.boris@bur.io>
 <YHMBzw/9tUVMS66G@desktop>
 <YIB5XbY2PX4J5dlN@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIB5XbY2PX4J5dlN@zen>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 21, 2021 at 12:13:33PM -0700, Boris Burkov wrote:
> On Sun, Apr 11, 2021 at 10:03:59PM +0800, Eryu Guan wrote:
> > On Wed, Apr 07, 2021 at 01:13:26PM -0700, Boris Burkov wrote:
> > > btrfs trims fiemap extents to the inputted offset, which leads to
> > > inconsistent results for most inputs, and downright bizarre outputs like
> > > [7..6] when the trimmed extent is at the end of an extent and shorter
> > > than 512 bytes.
> > > 
> > > The test writes out one extent of the file system's block size and tries
> > > fiemaps at various offsets. It expects that all the fiemaps return the
> > > full single extent.
> > > 
> > > I ran it under the following fs, block size combinations:
> > > ext2: 1024, 2048, 4096
> > > ext3: 1024, 2048, 4096
> > > ext4: 1024, 2048, 4096
> > > xfs: 512, 1024, 2048, 4096
> > > f2fs: 4096
> > > btrfs: 4096
> > > 
> > > This test is fixed for btrfs by:
> > > btrfs: return whole extents in fiemap
> > > (https://lore.kernel.org/linux-btrfs/274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io/)
> > > 
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > 
> > generic/473, which tests fiemap, has been marked as broken, as fiemap
> > behavior is not consistent across filesystems, and the specific behavior
> > tested by generic/473 is not defined and filesystems could have
> > different implementations.
> > 
> > I'm not sure if this test fits into the undefined-behavior fiemap
> > categary. I think it's fine if it tests a well-defined & consistent
> > behavior.
> > 
> 
> Interesting, I didn't know about that test being marked as broken.
> 
> I was worried about this problem to some extent and attempted to
> mitigate it by only requiring that all the output be the same, rather
> than matching some specific standard.
> 
> Thinking about it further, I think this test is portable only so long as
> the step where it writes a file with one extent is portable.
> 
> If "pwrite 0 block-size" ends up as a file with multiple extents, then
> it is possible one of the partial fiemaps will only intersect with a
> subset of the extents and rightly return those. In fact, that was broken
> in the original version of the test which explicitly used 4096 instead of
> being detecting the block size.
> 
> I do think it is nice to have this as a regression test for btrfs, since
> we have pretty complicated logic for fiemap and it was so broken in this
> case. If you prefer, I can make this a btrfs specific test.

Yeah, a btrfs specific test seems safer, and we could move it to generic
later if the behavior is well defined.

Thanks,
Eryu
