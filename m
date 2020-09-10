Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6B7263B28
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 05:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIJDCL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 23:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgIJDA6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 23:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599706856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQalugFKq465b5k5xiN1MGjI2fh4gdBNAsOArzwMH9o=;
        b=V5TLwRkQX95TCB3SW+dmpQh30CnAdmVwBCuDQ4MlpLFibZEo/XKmjn3d0jIIet2Kwps+uo
        +wEppHmJogvNoYNvECALjDtDWkliZTKAnMsSlLyqVeoJ9bAQGmvyPj0A1kPYLUkDWJS6UY
        OVqytt/pii6R7rnWjxXR08z7t80/lnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-5rWQ1AP0N-KDefoSq5Boeg-1; Wed, 09 Sep 2020 23:00:54 -0400
X-MC-Unique: 5rWQ1AP0N-KDefoSq5Boeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B79E57057;
        Thu, 10 Sep 2020 03:00:53 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D7926FEFE;
        Thu, 10 Sep 2020 03:00:52 +0000 (UTC)
Date:   Thu, 10 Sep 2020 11:14:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: add test for zero range over a file range with
 many small extents
Message-ID: <20200910031439.GF2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <e038bd2419f60f0b4c5ac13da78bfba345f4dba7.1599560067.git.fdmanana@suse.com>
 <20200909190213.GA7943@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909190213.GA7943@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 09, 2020 at 12:02:13PM -0700, Darrick J. Wong wrote:
> On Tue, Sep 08, 2020 at 11:32:02AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Test a fallocate() zero range operation against a large file range for which
> > there are many small extents allocated. Verify the operation does not fail
> > and the respective range return zeroes on subsequent reads.
> 
> LOL, we didn't already have a stress test for fzero? :/

We have lots of test for fzero, but they always test on a file with about 2~2000
blocks, none of them test with so many small extents.

We might need to think about this missing test coverage more, not only fzero
operation :)

Thanks,
Zorro

> 
> > This test is motivated by a bug found on btrfs. The patch that fixes the
> > bug on btrfs has the following subject:
> > 
> >  "btrfs: fix metadata reservation for fallocate that leads to transaction aborts"
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> Looks good to me!
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> --D
> 
> > ---
> >  tests/generic/609     | 61 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/609.out |  5 ++++
> >  tests/generic/group   |  1 +
> >  3 files changed, 67 insertions(+)
> >  create mode 100755 tests/generic/609
> >  create mode 100644 tests/generic/609.out
> > 
> > diff --git a/tests/generic/609 b/tests/generic/609
> > new file mode 100755
> > index 00000000..cda2b3dc
> > --- /dev/null
> > +++ b/tests/generic/609
> > @@ -0,0 +1,61 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test No. 609
> > +#
> > +# Test a fallocate() zero range operation against a large file range for which
> > +# there are many small extents allocated. Verify the operation does not fail
> > +# and the respective range return zeroes on subsequent reads.
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> > +_require_xfs_io_command "fzero"
> > +_require_xfs_io_command "fpunch"
> > +_require_test_program "punch-alternating"
> > +
> > +rm -f $seqres.full
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# Create a file with many small extents. To speed up file creation, do
> > +# buffered writes and then punch a hole on every other block.
> > +$XFS_IO_PROG -f -c "pwrite -S 0xab -b 10M 0 100M" \
> > +	$SCRATCH_MNT/foobar >>$seqres.full
> > +$here/src/punch-alternating $SCRATCH_MNT/foobar >>$seqres.full
> > +
> > +# For btrfs, trigger a transaction commit to force metadata COW for the
> > +# following fallocate zero range operation.
> > +sync
> > +
> > +$XFS_IO_PROG -c "fzero 0 100M" $SCRATCH_MNT/foobar
> > +
> > +# Check the file content after umounting and mounting again the fs, to verify
> > +# everything was persisted.
> > +_scratch_cycle_mount
> > +
> > +echo "File content after zero range operation:"
> > +od -A d -t x1 $SCRATCH_MNT/foobar
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/609.out b/tests/generic/609.out
> > new file mode 100644
> > index 00000000..feb8c211
> > --- /dev/null
> > +++ b/tests/generic/609.out
> > @@ -0,0 +1,5 @@
> > +QA output created by 609
> > +File content after zero range operation:
> > +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > +*
> > +104857600
> > diff --git a/tests/generic/group b/tests/generic/group
> > index aa969bcb..f8eabc0a 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -611,3 +611,4 @@
> >  606 auto attr quick dax
> >  607 auto attr quick dax
> >  608 auto attr quick dax
> > +609 auto quick prealloc zero
> > -- 
> > 2.26.2
> > 
> 

