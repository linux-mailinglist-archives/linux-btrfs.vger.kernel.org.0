Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10033591F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 05:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfF1Dcx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 23:32:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43334 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1Dcw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 23:32:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S3TMeZ001617;
        Fri, 28 Jun 2019 03:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=CUU5L5ylfgbiqt+naeh1fy6foJHhkQph8Jq/tfwkxaA=;
 b=a8XbxW4iFcusG+EkKBYruOurZm0b5C9rtalgcLKvLdKBo6IKM2tFxBd+wd4yFs9s7avY
 etTd0JU9rNSfGIoJhL2Nkx5qu/hfrI5maXhRFLN8q0vSneYoFLjhTSdIoao1u6K22amR
 svHPlGtiiSDarF3mJRMWlCD9RM2dkyBNG9Ct/GDFNPJqhdGzwBdnTIyZeIL5l7f1t5Qd
 ZbOJaVaZjvLAbHyQ0OUsBB+sg9KXLSfGWsOzLSJYKFQq0FNFwQB+PMW/Wcq9jU19EQnp
 xLbSIkzlVhr2XlYeRV+O6Ss/GiS0v2UJbvejthAPR5+Ruo2XDSunaFttUZwEP65MC9ma Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brtkct6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 03:32:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S3Vf3V143833;
        Fri, 28 Jun 2019 03:32:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9acdk8nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 03:32:23 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5S3WMpq030364;
        Fri, 28 Jun 2019 03:32:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 20:32:21 -0700
Date:   Thu, 27 Jun 2019 20:32:22 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test cloning large exents to a file with many
 small extents
Message-ID: <20190628033222.GC5167@magnolia>
References: <20190627170030.6149-1-fdmanana@kernel.org>
 <20190627202818.GB5167@magnolia>
 <CAL3q7H7PbZh3SNv+jOm_St03bkq=f2-T8Cna-no6U2+FxxMchA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7PbZh3SNv+jOm_St03bkq=f2-T8Cna-no6U2+FxxMchA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280033
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 27, 2019 at 10:47:31PM +0100, Filipe Manana wrote:
> On Thu, Jun 27, 2019 at 9:28 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Thu, Jun 27, 2019 at 06:00:30PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that if we clone a file with some large extents into a file that has
> > > many small extents, when the fs is nearly full, the clone operation does
> > > not fail and produces the correct result.
> > >
> > > This is motivated by a bug found in btrfs wich is fixed by the following
> > > patches for the linux kernel:
> > >
> > >  [PATCH 1/2] Btrfs: factor out extent dropping code from hole punch handler
> > >  [PATCH 2/2] Btrfs: fix ENOSPC errors, leading to transaction aborts, when
> > >              cloning extents
> > >
> > > The test currently passes on xfs.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  tests/generic/558     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/558.out |  5 ++++
> > >  tests/generic/group   |  1 +
> > >  3 files changed, 81 insertions(+)
> > >  create mode 100755 tests/generic/558
> > >  create mode 100644 tests/generic/558.out
> > >
> > > diff --git a/tests/generic/558 b/tests/generic/558
> > > new file mode 100755
> > > index 00000000..ee16cdf7
> > > --- /dev/null
> > > +++ b/tests/generic/558
> > > @@ -0,0 +1,75 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FSQA Test No. 558
> > > +#
> > > +# Test that if we clone a file with some large extents into a file that has
> > > +# many small extents, when the fs is nearly full, the clone operation does
> > > +# not fail and produces the correct result.
> > > +#
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +tmp=/tmp/$$
> > > +status=1     # failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +     cd /
> > > +     rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +. ./common/reflink
> > > +
> > > +# real QA test starts here
> > > +_supported_fs generic
> > > +_supported_os Linux
> > > +_require_scratch_reflink
> > > +
> > > +rm -f $seqres.full
> > > +
> > > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +file_size=$(( 128 * 1024 * 1024 )) # 128Mb
> > > +extent_size=4096
> >
> > What if the fs block size is 64k?
> 
> Then we get extents of 64Kb instead of 4Kb. Works on btrfs. Is it a
> problem for xfs (or any other fs)?

It shouldn't be; I was merely wondering if 2048 extents was enough to
trigger the enospc on btrfs.

> >
> > > +num_extents=$(( $file_size / $extent_size ))
> > > +
> > > +# Create a file with many small extents.
> > > +for ((i = 0; i < $num_extents; i++)); do
> > > +     offset=$(( $i * $extent_size ))
> > > +     $XFS_IO_PROG -f -s -c "pwrite -S 0xe5 $offset $extent_size" \
> > > +             $SCRATCH_MNT/foo >>/dev/null
> > > +done
> >
> > I wouldn't have thought that this would actually succeed on xfs because
> > you could lay extents down one after the other, but then started seeing
> > this in the filefrag output:
> >
> > File size of /opt/foo is 528384 (129 blocks of 4096 bytes)
> >  ext:     logical_offset:        physical_offset: length:   expected: flags:
> >    3:       17..      17:         52..        52:      1:         37:
> >    4:       18..      18:         67..        67:      1:         53:
> >    5:       19..      19:         81..        81:      1:         68:
> >    6:       20..      20:         94..        94:      1:         82:
> >    7:       21..      21:        106..       106:      1:         95:
> >    8:       22..      22:        117..       117:      1:        107:
> >    9:       23..      23:        127..       127:      1:        118:
> >   10:       24..      24:        136..       136:      1:        128:
> >   11:       25..      25:        144..       144:      1:        137:
> >   12:       26..      26:        151..       151:      1:        145:
> >   13:       27..      27:        157..       157:      1:        152:
> >   14:       28..      28:        162..       162:      1:        158:
> >   15:       29..      29:        166..       166:      1:        163:
> >   16:       30..      30:        169..       169:      1:        167:
> >   17:       31..      32:        171..       172:      2:        170:
> >   18:       33..      33:        188..       188:      1:        173:
> >
> > 52, 67, 81, 94, 106, 117, 127, 136, 44, 151, 157, 162, 166, 169, 171...
> >
> >  +15 +14 +13 +12  +11  +10   +9   +8  +7   +6   +5   +4   +3   +2...
> >
> > Hm, I wonder what quirk of the xfs allocator this might be?
> 
> Don't ask me, I have no idea how it works :)

Ah, it's because xfs frees post-eof allocations every time we close a
file... and I never got the series that fixes this finalized and sent
upstream.

> >
> > > +
> > > +# Create file bar with the same size that file foo has but with large extents.
> > > +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $file_size 0 $file_size" \
> > > +     $SCRATCH_MNT/bar >>/dev/null
> > > +
> > > +# Fill the fs (for btrfs we are interested in filling all unallocated space
> > > +# and most of the existing metadata block group(s), so that after this there
> > > +# will be no unallocated space and metadata space will be mostly full but with
> > > +# more than enough free space for the clone operation below to succeed).
> > > +i=1
> > > +while true; do
> > > +     $XFS_IO_PROG -f -c "pwrite 0 2K" $SCRATCH_MNT/filler_$i &> /dev/null
> > > +     [ $? -ne 0 ] && break
> > > +     i=$(( i + 1 ))
> > > +done
> >
> > _fill_fs?
> 
> No, because that will do fallocate. Writing 2Kb files here is on
> purpose because that will fill the metadata
> block group(s) (on btrfs we inline extents in the btree (metadata) as
> long as they are not bigger than 2Kb, by default).
> Using fallocate, we end up using data block groups.

Ok.

> >
> > > +
> > > +# Now clone file bar into file foo. This is supposed to succeed and not fail
> > > +# with ENOSPC for example.
> > > +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar" $SCRATCH_MNT/foo >>/dev/null
> >
> > _reflink $SCRATCH_MNT/bar $SCRATCH_MNT/foo ?
> 
> Does exactly the same. I don't mind changing it however.

<Nod>

--D

> Thanks.
> 
> >
> > --D
> >
> > > +
> > > +_scratch_remount
> > > +
> > > +echo "File foo data after cloning and remount:"
> > > +od -A d -t x1 $SCRATCH_MNT/foo
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/558.out b/tests/generic/558.out
> > > new file mode 100644
> > > index 00000000..d1e8e70f
> > > --- /dev/null
> > > +++ b/tests/generic/558.out
> > > @@ -0,0 +1,5 @@
> > > +QA output created by 558
> > > +File foo data after cloning and remount:
> > > +0000000 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7
> > > +*
> > > +134217728
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index 543c0627..c06c1cd1 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -560,3 +560,4 @@
> > >  555 auto quick cap
> > >  556 auto quick casefold
> > >  557 auto quick log
> > > +558 auto clone
> > > --
> > > 2.11.0
> > >
