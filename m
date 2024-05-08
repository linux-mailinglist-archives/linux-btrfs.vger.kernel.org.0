Return-Path: <linux-btrfs+bounces-4823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49258BF909
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 10:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76396286237
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32497535DD;
	Wed,  8 May 2024 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6kqMn8D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2032BB00
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158308; cv=none; b=IRJwi7nMZCCyLobRdfjYHcSZyKhMrF81CSS/JKvPs/3Na2T8sdljBl2a1aKXgTSJQnWSeZLw9KLdARb4Z3Na2hcXMuJymgcfBAXlhqZT89c/5AhFZtUb6SL07BHQx7WecuubxwJbhuqjBbYfgYkiZ6gjzM8Ddty8VmtP9VdeIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158308; c=relaxed/simple;
	bh=a+OgEertKtvRCfL2e85wQyTcp7b8HXKhm8WcTIjS+VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scUPtw38DiKT1Q5CWMTP9VUJb7p7Du5+sQwa1o0I89nZmJg1/FIha4/VNKBENJoqXitmlYOBWm2uhJQvK54NbhP7ywKmddltx8h69Daa1tRhCRfVY8IvMy2IlXQERLBmQ2VT9iLQTWii97a4WjKKAsDjBnaXUV2UQ0badVThWYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6kqMn8D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715158305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjxdfJgLWjXggpnaSpLR36Zpyo7w5wqaq2uIAdWvqsg=;
	b=S6kqMn8DienjsXTLJJSt4+ZQvJABLI3NDijrr3dpuhoy3wd0YHkH8t6M3DecVj21QUwUoY
	n+0iyPHJ675PrtCX+xlARZE+yyn3Wj98I+mobiZoztg1UU/n3GfkVXtCWSsbAD0+RKLi3s
	hhU1VRvaGJyyg3g++LefrIMULAZK0EI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-Mat9_IobPZy-O-jSxlG7SA-1; Wed, 08 May 2024 04:51:44 -0400
X-MC-Unique: Mat9_IobPZy-O-jSxlG7SA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6f44ff14c17so1905269b3a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 08 May 2024 01:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715158303; x=1715763103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjxdfJgLWjXggpnaSpLR36Zpyo7w5wqaq2uIAdWvqsg=;
        b=R3zyEybhaxWH0o9ubSJtKQK8t2zpIbiHzO3tfHprPwp5MtDb6vVkdEYSkQNDGw85SU
         Seg/r5KUwwNizcJFbLhoGfiDrrSX77nibHl0zCtU7ljw+C0RJCphp5Jzks9kmrZbEJjM
         G3gD68pfxwYB8wT8oOkJKJfV0/tM54jWq5pzWpW5yWrXvNTeak0Aup73cm/QsE6mPjBc
         jU52MvS9HQ8FW/uy9OItEcORAdt7Fe89npBDa6SujCN7xp7bu3tS58kJl15YAMJTvY9k
         yaBQVQUYbhmfWnW7kNVC5D7jKkRW/iY3PA+/Pm6tbUYCNMOATyQZOsfmi51I9gXYRkDF
         6kAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOQe320Ho8Mw3N+DYwE+2D48baM0DB7yXEO1tx1TQH76mxAiNje9Col6jID4QVBBlNLg355opha2nh26BIhllCMvoXkdEA9H5Ty8c=
X-Gm-Message-State: AOJu0YxC+TPwkCwYAwpjom+wpx7VvhFEj8DvX4suDGw7pBNhsmNKWUR/
	q+0roV5ihxJKx6CFByCN0BiUbFFWOAuGOq1YV0Lu/3odiwMhAhs2KSJov2SPe28D/r9MuNcBLE+
	iwIXYGaVR1IqZq5M830prvMeOKPtGPm0FVKoAL+1k+GugVcxXAdFT7MI1r9xw
X-Received: by 2002:a05:6a00:6307:b0:6f4:714d:fb43 with SMTP id d2e1a72fcca58-6f49c2ad3b8mr1813469b3a.29.1715158302664;
        Wed, 08 May 2024 01:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ7y0D6gyIQElSDjcfeE0ICr42/pSqo0oXmXWSqW603TLFmZCsAHLTsyfh8W9UGWLh6AeZjQ==
X-Received: by 2002:a05:6a00:6307:b0:6f4:714d:fb43 with SMTP id d2e1a72fcca58-6f49c2ad3b8mr1813450b3a.29.1715158302021;
        Wed, 08 May 2024 01:51:42 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gp9-20020a056a003b8900b006ea8cc9250bsm10699127pfb.44.2024.05.08.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:51:41 -0700 (PDT)
Date: Wed, 8 May 2024 16:51:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@lst.de" <hch@lst.de>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"daeho43@gmail.com" <daeho43@gmail.com>
Subject: Re: [PATCH] generic: add gc stress test
Message-ID: <20240508085135.gwo3wiaqwhptdkju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240415112259.21760-1-hans.holmberg@wdc.com>
 <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com>
 <20240416185437.GC11935@frogsfrogsfrogs>
 <20240417124317.lje5w5hgawy4drkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <eddca2b5-0c15-4060-ba7b-89552de4a45d@wdc.com>
 <20240417140648.k3drgreciyiozkbq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <edcb31e0-cddb-4458-b45e-34518fbb828d@wdc.com>
 <20b38963-2994-401c-88f8-0a9d0729a101@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20b38963-2994-401c-88f8-0a9d0729a101@wdc.com>

On Wed, May 08, 2024 at 07:08:01AM +0000, Hans Holmberg wrote:
> On 2024-04-17 16:50, Hans Holmberg wrote:
> > On 2024-04-17 16:07, Zorro Lang wrote:
> >> On Wed, Apr 17, 2024 at 01:21:39PM +0000, Hans Holmberg wrote:
> >>> On 2024-04-17 14:43, Zorro Lang wrote:
> >>>> On Tue, Apr 16, 2024 at 11:54:37AM -0700, Darrick J. Wong wrote:
> >>>>> On Tue, Apr 16, 2024 at 09:07:43AM +0000, Hans Holmberg wrote:
> >>>>>> +Zorro (doh!)
> >>>>>>
> >>>>>> On 2024-04-15 13:23, Hans Holmberg wrote:
> >>>>>>> This test stresses garbage collection for file systems by first filling
> >>>>>>> up a scratch mount to a specific usage point with files of random size,
> >>>>>>> then doing overwrites in parallel with deletes to fragment the backing
> >>>>>>> storage, forcing reclaim.
> >>>>>>>
> >>>>>>> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> Test results in my setup (kernel 6.8.0-rc4+)
> >>>>>>> 	f2fs on zoned nullblk: pass (77s)
> >>>>>>> 	f2fs on conventional nvme ssd: pass (13s)
> >>>>>>> 	btrfs on zoned nublk: fails (-ENOSPC)
> >>>>>>> 	btrfs on conventional nvme ssd: fails (-ENOSPC)
> >>>>>>> 	xfs on conventional nvme ssd: pass (8s)
> >>>>>>>
> >>>>>>> Johannes(cc) is working on the btrfs ENOSPC issue.
> >>>>>>> 	
> >>>>>>>      tests/generic/744     | 124 ++++++++++++++++++++++++++++++++++++++++++
> >>>>>>>      tests/generic/744.out |   6 ++
> >>>>>>>      2 files changed, 130 insertions(+)
> >>>>>>>      create mode 100755 tests/generic/744
> >>>>>>>      create mode 100644 tests/generic/744.out
> >>>>>>>
> >>>>>>> diff --git a/tests/generic/744 b/tests/generic/744
> >>>>>>> new file mode 100755
> >>>>>>> index 000000000000..2c7ab76bf8b1
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/tests/generic/744
> >>>>>>> @@ -0,0 +1,124 @@
> >>>>>>> +#! /bin/bash
> >>>>>>> +# SPDX-License-Identifier: GPL-2.0
> >>>>>>> +# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
> >>>>>>> +#
> >>>>>>> +# FS QA Test No. 744
> >>>>>>> +#
> >>>>>>> +# Inspired by btrfs/273 and generic/015
> >>>>>>> +#
> >>>>>>> +# This test stresses garbage collection in file systems
> >>>>>>> +# by first filling up a scratch mount to a specific usage point with
> >>>>>>> +# files of random size, then doing overwrites in parallel with
> >>>>>>> +# deletes to fragment the backing zones, forcing reclaim.
> >>>>>>> +
> >>>>>>> +. ./common/preamble
> >>>>>>> +_begin_fstest auto
> >>>>>>> +
> >>>>>>> +# real QA test starts here
> >>>>>>> +
> >>>>>>> +_require_scratch
> >>>>>>> +
> >>>>>>> +# This test requires specific data space usage, skip if we have compression
> >>>>>>> +# enabled.
> >>>>>>> +_require_no_compress
> >>>>>>> +
> >>>>>>> +M=$((1024 * 1024))
> >>>>>>> +min_fsz=$((1 * ${M}))
> >>>>>>> +max_fsz=$((256 * ${M}))
> >>>>>>> +bs=${M}
> >>>>>>> +fill_percent=95
> >>>>>>> +overwrite_percentage=20
> >>>>>>> +seq=0
> >>>>>>> +
> >>>>>>> +_create_file() {
> >>>>>>> +	local file_name=${SCRATCH_MNT}/data_$1
> >>>>>>> +	local file_sz=$2
> >>>>>>> +	local dd_extra=$3
> >>>>>>> +
> >>>>>>> +	POSIXLY_CORRECT=yes dd if=/dev/zero of=${file_name} \
> >>>>>>> +		bs=${bs} count=$(( $file_sz / ${bs} )) \
> >>>>>>> +		status=none $dd_extra  2>&1
> >>>>>>> +
> >>>>>>> +	status=$?
> >>>>>>> +	if [ $status -ne 0 ]; then
> >>>>>>> +		echo "Failed writing $file_name" >>$seqres.full
> >>>>>>> +		exit
> >>>>>>> +	fi
> >>>>>>> +}
> >>>>>
> >>>>> I wonder, is there a particular reason for doing all these file
> >>>>> operations with shell code instead of using fsstress to create and
> >>>>> delete files to fill the fs and stress all the zone-gc code?  This test
> >>>>> reminds me a lot of generic/476 but with more fork()ing.
> >>>>
> >>>> /me has the same confusion. Can this test cover more things than using
> >>>> fsstress (to do reclaim test) ? Or does it uncover some known bugs which
> >>>> other cases can't?
> >>>
> >>> ah, adding some more background is probably useful:
> >>>
> >>> I've been using this test to stress the crap out the zoned xfs garbage
> >>> collection / write throttling implementation for zoned rt subvolumes
> >>> support in xfs and it has found a number of issues during implementation
> >>> that i did not reproduce by other means.
> >>>
> >>> I think it also has wider applicability as it triggers bugs in btrfs.
> >>> f2fs passes without issues, but probably benefits from a quick smoke gc
> >>> test as well. Discussed this with Bart and Daeho (now in cc) before
> >>> submitting.
> >>>
> >>> Using fsstress would be cool, but as far as I can tell it cannot
> >>> be told to operate at a specific file system usage point, which
> >>> is a key thing for this test.
> >>
> >> As a random test case, if this case can be transformed to use fsstress to cover
> >> same issues, that would be nice.
> >>
> >> But if as a regression test case, it has its particular test coverage, and the
> >> issue it covered can't be reproduced by fsstress way, then let's work on this
> >> bash script one.
> >>
> >> Any thoughts?
> > 
> > Yeah, I think bash is preferable for this particular test case.
> > Bash also makes it easy to hack for people's private uses.
> > 
> > I use longer versions of this test (increasing overwrite_percentage)
> > for weekly testing.
> > 
> > If we need fsstress for reproducing any future gc bug we can add
> > whats missing to it then.
> > 
> > Does that make sense?
> > 
> 
> Hey Zorro,
> 
> Any remaining concerns for adding this test? I could run it across
> more file systems(bcachefs could be interesting) and share the results 
> if needed be.

Hi,

I remembered you metioned btrfs fails on this test, and I can reproduce it
on btrfs [1] with general disk. Have you figured out the reason? I don't
want to give btrfs a test failure suddently without a proper explanation :)
If it's a case issue, better to fix it for btrfs.

Thanks,
Zorro

# ./check generic/744
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 6.9.0-0.rc5.20240425gite88c4cfcb7b8.47.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 25 14:21:52 UTC 2024
MKFS_OPTIONS  -- /dev/sda4
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/scratch

generic/744 115s ... [failed, exit status 1]- output mismatch (see /root/git/xfstests/results//generic/744.out.bad)
    --- tests/generic/744.out   2024-05-08 16:11:14.476635417 +0800
    +++ /root/git/xfstests/results//generic/744.out.bad 2024-05-08 16:46:03.617194377 +0800
    @@ -2,5 +2,4 @@
     Starting fillup using direct IO
     Starting mixed write/delete test using direct IO
     Starting mixed write/delete test using buffered IO
    -Syncing
    -Done, all good
    +dd: error writing '/mnt/scratch/data_82': No space left on device
    ...
    (Run 'diff -u /root/git/xfstests/tests/generic/744.out /root/git/xfstests/results//generic/744.out.bad'  to see the entire diff)
Ran: generic/744
Failures: generic/744
Failed 1 of 1 tests

> 
> Thanks,
> Hans


