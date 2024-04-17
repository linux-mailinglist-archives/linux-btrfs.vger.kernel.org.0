Return-Path: <linux-btrfs+bounces-4356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D664B8A858C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B071F21BEC
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582EB1411D2;
	Wed, 17 Apr 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLZFnS6E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6013D24A;
	Wed, 17 Apr 2024 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362816; cv=none; b=X9vSuxLUMyLN9JZOBJgecSRzIVmi8/IDUfLdMFixXtj12Q/ScN2T7TKMYPIGINnQ3BdQA31J0dtFuqq4YPzreKfTwJA7gqufGu8c0nmBGM5XvwiNLCuIrgOCH4LlI23mkQ9rcmyjcNX6cY84rWqochlgvc/8jOHP+2dAEyvn59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362816; c=relaxed/simple;
	bh=F9inT8sodPLlUjzH+5IMMV+Eojdt2BladyyfZHqIzVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMvJWZ1FSRRn7LNTYXVSHpweBa7CL2tfjGNi3GtJQLKH3xzSB6n4l2pdv5takrqrhnJ6DUGk+UJ4o92jC9WrxRLuMhOrK1JRQm/7vr90p+fkhbJQcSvVEYNKjrWdgEg+WtMAuI1ZUqF5v1Ane2VRGf9xrzMZo8ARZ+eptsxg9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLZFnS6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF16C116B1;
	Wed, 17 Apr 2024 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713362816;
	bh=F9inT8sodPLlUjzH+5IMMV+Eojdt2BladyyfZHqIzVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLZFnS6EUJV4CA5rzn0KutPQZuxYyrB7KkL1oc8GkLXnvtuJo9voOWFFkbXgUIE37
	 CmWkUsV6yvxE0Vk8zZzq6SEvvL7ErBSbWdWPpb3BY0PRCDsCY+eDRdInz44ncd8pVL
	 mmzNXZ7OaCGMQ0t0iQglHbf+IsXaidMqi7xsWlB+BhrULM4V1DhL+7mnI0LF14K3KM
	 tilhzT8a5aug87gnn64pTFCBRiZ5E1QtLnbEEZAub45q6K4i+R0wFYXORmvURpBht9
	 JQeAYh4c11vmAAMIshRS0FNFA/GN+qp4OtmImd1LISP7zIs/y2MJU6QMn2YlU3MrIF
	 815vYHELgz7XA==
Date: Wed, 17 Apr 2024 22:06:48 +0800
From: Zorro Lang <zlang@kernel.org>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>,
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
Message-ID: <20240417140648.k3drgreciyiozkbq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240415112259.21760-1-hans.holmberg@wdc.com>
 <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com>
 <20240416185437.GC11935@frogsfrogsfrogs>
 <20240417124317.lje5w5hgawy4drkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <eddca2b5-0c15-4060-ba7b-89552de4a45d@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eddca2b5-0c15-4060-ba7b-89552de4a45d@wdc.com>

On Wed, Apr 17, 2024 at 01:21:39PM +0000, Hans Holmberg wrote:
> On 2024-04-17 14:43, Zorro Lang wrote:
> > On Tue, Apr 16, 2024 at 11:54:37AM -0700, Darrick J. Wong wrote:
> >> On Tue, Apr 16, 2024 at 09:07:43AM +0000, Hans Holmberg wrote:
> >>> +Zorro (doh!)
> >>>
> >>> On 2024-04-15 13:23, Hans Holmberg wrote:
> >>>> This test stresses garbage collection for file systems by first filling
> >>>> up a scratch mount to a specific usage point with files of random size,
> >>>> then doing overwrites in parallel with deletes to fragment the backing
> >>>> storage, forcing reclaim.
> >>>>
> >>>> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> >>>> ---
> >>>>
> >>>> Test results in my setup (kernel 6.8.0-rc4+)
> >>>> 	f2fs on zoned nullblk: pass (77s)
> >>>> 	f2fs on conventional nvme ssd: pass (13s)
> >>>> 	btrfs on zoned nublk: fails (-ENOSPC)
> >>>> 	btrfs on conventional nvme ssd: fails (-ENOSPC)
> >>>> 	xfs on conventional nvme ssd: pass (8s)
> >>>>
> >>>> Johannes(cc) is working on the btrfs ENOSPC issue.
> >>>> 	
> >>>>    tests/generic/744     | 124 ++++++++++++++++++++++++++++++++++++++++++
> >>>>    tests/generic/744.out |   6 ++
> >>>>    2 files changed, 130 insertions(+)
> >>>>    create mode 100755 tests/generic/744
> >>>>    create mode 100644 tests/generic/744.out
> >>>>
> >>>> diff --git a/tests/generic/744 b/tests/generic/744
> >>>> new file mode 100755
> >>>> index 000000000000..2c7ab76bf8b1
> >>>> --- /dev/null
> >>>> +++ b/tests/generic/744
> >>>> @@ -0,0 +1,124 @@
> >>>> +#! /bin/bash
> >>>> +# SPDX-License-Identifier: GPL-2.0
> >>>> +# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
> >>>> +#
> >>>> +# FS QA Test No. 744
> >>>> +#
> >>>> +# Inspired by btrfs/273 and generic/015
> >>>> +#
> >>>> +# This test stresses garbage collection in file systems
> >>>> +# by first filling up a scratch mount to a specific usage point with
> >>>> +# files of random size, then doing overwrites in parallel with
> >>>> +# deletes to fragment the backing zones, forcing reclaim.
> >>>> +
> >>>> +. ./common/preamble
> >>>> +_begin_fstest auto
> >>>> +
> >>>> +# real QA test starts here
> >>>> +
> >>>> +_require_scratch
> >>>> +
> >>>> +# This test requires specific data space usage, skip if we have compression
> >>>> +# enabled.
> >>>> +_require_no_compress
> >>>> +
> >>>> +M=$((1024 * 1024))
> >>>> +min_fsz=$((1 * ${M}))
> >>>> +max_fsz=$((256 * ${M}))
> >>>> +bs=${M}
> >>>> +fill_percent=95
> >>>> +overwrite_percentage=20
> >>>> +seq=0
> >>>> +
> >>>> +_create_file() {
> >>>> +	local file_name=${SCRATCH_MNT}/data_$1
> >>>> +	local file_sz=$2
> >>>> +	local dd_extra=$3
> >>>> +
> >>>> +	POSIXLY_CORRECT=yes dd if=/dev/zero of=${file_name} \
> >>>> +		bs=${bs} count=$(( $file_sz / ${bs} )) \
> >>>> +		status=none $dd_extra  2>&1
> >>>> +
> >>>> +	status=$?
> >>>> +	if [ $status -ne 0 ]; then
> >>>> +		echo "Failed writing $file_name" >>$seqres.full
> >>>> +		exit
> >>>> +	fi
> >>>> +}
> >>
> >> I wonder, is there a particular reason for doing all these file
> >> operations with shell code instead of using fsstress to create and
> >> delete files to fill the fs and stress all the zone-gc code?  This test
> >> reminds me a lot of generic/476 but with more fork()ing.
> > 
> > /me has the same confusion. Can this test cover more things than using
> > fsstress (to do reclaim test) ? Or does it uncover some known bugs which
> > other cases can't?
> 
> ah, adding some more background is probably useful:
> 
> I've been using this test to stress the crap out the zoned xfs garbage
> collection / write throttling implementation for zoned rt subvolumes
> support in xfs and it has found a number of issues during implementation
> that i did not reproduce by other means.
> 
> I think it also has wider applicability as it triggers bugs in btrfs. 
> f2fs passes without issues, but probably benefits from a quick smoke gc 
> test as well. Discussed this with Bart and Daeho (now in cc) before 
> submitting.
> 
> Using fsstress would be cool, but as far as I can tell it cannot
> be told to operate at a specific file system usage point, which
> is a key thing for this test.

As a random test case, if this case can be transformed to use fsstress to cover
same issues, that would be nice.

But if as a regression test case, it has its particular test coverage, and the
issue it covered can't be reproduced by fsstress way, then let's work on this
bash script one.

Any thoughts?

Thanks,
Zorro

> 
> Thanks,
> Hans
> 
> > 
> > Thanks,
> > Zorro
> > 
> >>
> >> --D
> >>
> >>>> +
> >>>> +_total_M() {
> >>>> +	local total=$(stat -f -c '%b' ${SCRATCH_MNT})
> >>>> +	local bs=$(stat -f -c '%S' ${SCRATCH_MNT})
> >>>> +	echo $(( ${total} * ${bs} / ${M}))
> >>>> +}
> >>>> +
> >>>> +_used_percent() {
> >>>> +	local available=$(stat -f -c '%a' ${SCRATCH_MNT})
> >>>> +	local total=$(stat -f -c '%b' ${SCRATCH_MNT})
> >>>> +	echo $((100 - (100 * ${available}) / ${total} ))
> >>>> +}
> >>>> +
> >>>> +
> >>>> +_delete_random_file() {
> >>>> +	local to_delete=$(find ${SCRATCH_MNT} -type f | shuf | head -1)
> >>>> +	rm $to_delete
> >>>> +	sync ${SCRATCH_MNT}
> >>>> +}
> >>>> +
> >>>> +_get_random_fsz() {
> >>>> +	local r=$RANDOM
> >>>> +	echo $(( ${min_fsz} + (${max_fsz} - ${min_fsz}) * (${r} % 100) / 100 ))
> >>>> +}
> >>>> +
> >>>> +_direct_fillup () {
> >>>> +	while [ $(_used_percent) -lt $fill_percent ]; do
> >>>> +		local fsz=$(_get_random_fsz)
> >>>> +
> >>>> +		_create_file $seq $fsz "oflag=direct conv=fsync"
> >>>> +		seq=$((${seq} + 1))
> >>>> +	done
> >>>> +}
> >>>> +
> >>>> +_mixed_write_delete() {
> >>>> +	local dd_extra=$1
> >>>> +	local total_M=$(_total_M)
> >>>> +	local to_write_M=$(( ${overwrite_percentage} * ${total_M} / 100 ))
> >>>> +	local written_M=0
> >>>> +
> >>>> +	while [ $written_M -lt $to_write_M ]; do
> >>>> +		if [ $(_used_percent) -lt $fill_percent ]; then
> >>>> +			local fsz=$(_get_random_fsz)
> >>>> +
> >>>> +			_create_file $seq $fsz "$dd_extra"
> >>>> +			written_M=$((${written_M} + ${fsz}/${M}))
> >>>> +			seq=$((${seq} + 1))
> >>>> +		else
> >>>> +			_delete_random_file
> >>>> +		fi
> >>>> +	done
> >>>> +}
> >>>> +
> >>>> +seed=$RANDOM
> >>>> +RANDOM=$seed
> >>>> +echo "Running test with seed=$seed" >>$seqres.full
> >>>> +
> >>>> +_scratch_mkfs_sized $((8 * 1024 * 1024 * 1024)) >>$seqres.full
> >>>> +_scratch_mount
> >>>> +
> >>>> +echo "Starting fillup using direct IO"
> >>>> +_direct_fillup
> >>>> +
> >>>> +echo "Starting mixed write/delete test using direct IO"
> >>>> +_mixed_write_delete "oflag=direct"
> >>>> +
> >>>> +echo "Starting mixed write/delete test using buffered IO"
> >>>> +_mixed_write_delete ""
> >>>> +
> >>>> +echo "Syncing"
> >>>> +sync ${SCRATCH_MNT}/*
> >>>> +
> >>>> +echo "Done, all good"
> >>>> +
> >>>> +# success, all done
> >>>> +status=0
> >>>> +exit
> >>>> diff --git a/tests/generic/744.out b/tests/generic/744.out
> >>>> new file mode 100644
> >>>> index 000000000000..b40c2f43108e
> >>>> --- /dev/null
> >>>> +++ b/tests/generic/744.out
> >>>> @@ -0,0 +1,6 @@
> >>>> +QA output created by 744
> >>>> +Starting fillup using direct IO
> >>>> +Starting mixed write/delete test using direct IO
> >>>> +Starting mixed write/delete test using buffered IO
> >>>> +Syncing
> >>>> +Done, all good
> >>>
> >>
> > 
> > 
> 

