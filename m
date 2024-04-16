Return-Path: <linux-btrfs+bounces-4317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB48A73E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 20:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE3CB23E0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E5013791E;
	Tue, 16 Apr 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHbFDiEm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFA137777;
	Tue, 16 Apr 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293678; cv=none; b=I7WmiopufYAaG6npum2vIAtq7pdiyj0188KVIDCv0yGzAeVHXqhsceKjX8We99nAgy1jaYvuSDg8UEs84FXgdLrP06u99a56cSTJ3LW191i+Htiqf+YUKGGaiyIelNSyG/XM21Ura5dmjm8bMYE1yE3LDrEhQAF8fZOMAxE6c6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293678; c=relaxed/simple;
	bh=xJ3ftGNzRS7dJYoIVM3ZHP3r4xo+Wd1ulNlCQl45kc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kgg8olNRhP/mwOTynzedS0ozq+T0dBkiIUX2m8Tr+FreKRFwSE7SW2FySMHZdMBIyFae+LnFvEXfLBCUtAyqpuPDszZ+5Fdr+GNu7peEY2Md0XJ88bGpd4vqMFLihgvsVm5gSZi2Xt3CxfA3egPFp2AOU0hxwGIyCwp5WSlYoqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHbFDiEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F9DC113CE;
	Tue, 16 Apr 2024 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713293677;
	bh=xJ3ftGNzRS7dJYoIVM3ZHP3r4xo+Wd1ulNlCQl45kc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHbFDiEmyK94B/DlFB9XUUXHA5ZV2RZLCjsG/Y3GIKTP/okcXqwPVQwpaCSob8QBL
	 1UT1fXQPB70laIUyvuCJ+CdTxGk4EiM+723TXnuQfYPoGPYJnm1/H2N4SSq0+i7/5a
	 RKiBe3Uat/89YPEkuGLh/8j2txTbOfcVn8gCZdgIGyKPF8J7LbGjBn/UvVe0e5Rlb5
	 fdkaB9rW91owt8Jb8wRQNW0uid9mI4VBauGEn7p466zlCANXqrUwStXQlWXc9lqKFg
	 17fUG2T2lrZv8QU3FuLpoUz69MAAWwLYun9TODJpp9p5ro2NeDKOw6wT9+2M/nVYsO
	 8WBy2xvtT40UQ==
Date: Tue, 16 Apr 2024 11:54:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@lst.de" <hch@lst.de>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic: add gc stress test
Message-ID: <20240416185437.GC11935@frogsfrogsfrogs>
References: <20240415112259.21760-1-hans.holmberg@wdc.com>
 <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com>

On Tue, Apr 16, 2024 at 09:07:43AM +0000, Hans Holmberg wrote:
> +Zorro (doh!)
> 
> On 2024-04-15 13:23, Hans Holmberg wrote:
> > This test stresses garbage collection for file systems by first filling
> > up a scratch mount to a specific usage point with files of random size,
> > then doing overwrites in parallel with deletes to fragment the backing
> > storage, forcing reclaim.
> > 
> > Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> > ---
> > 
> > Test results in my setup (kernel 6.8.0-rc4+)
> > 	f2fs on zoned nullblk: pass (77s)
> > 	f2fs on conventional nvme ssd: pass (13s)
> > 	btrfs on zoned nublk: fails (-ENOSPC)
> > 	btrfs on conventional nvme ssd: fails (-ENOSPC)
> > 	xfs on conventional nvme ssd: pass (8s)
> > 
> > Johannes(cc) is working on the btrfs ENOSPC issue.
> > 	
> >   tests/generic/744     | 124 ++++++++++++++++++++++++++++++++++++++++++
> >   tests/generic/744.out |   6 ++
> >   2 files changed, 130 insertions(+)
> >   create mode 100755 tests/generic/744
> >   create mode 100644 tests/generic/744.out
> > 
> > diff --git a/tests/generic/744 b/tests/generic/744
> > new file mode 100755
> > index 000000000000..2c7ab76bf8b1
> > --- /dev/null
> > +++ b/tests/generic/744
> > @@ -0,0 +1,124 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 744
> > +#
> > +# Inspired by btrfs/273 and generic/015
> > +#
> > +# This test stresses garbage collection in file systems
> > +# by first filling up a scratch mount to a specific usage point with
> > +# files of random size, then doing overwrites in parallel with
> > +# deletes to fragment the backing zones, forcing reclaim.
> > +
> > +. ./common/preamble
> > +_begin_fstest auto
> > +
> > +# real QA test starts here
> > +
> > +_require_scratch
> > +
> > +# This test requires specific data space usage, skip if we have compression
> > +# enabled.
> > +_require_no_compress
> > +
> > +M=$((1024 * 1024))
> > +min_fsz=$((1 * ${M}))
> > +max_fsz=$((256 * ${M}))
> > +bs=${M}
> > +fill_percent=95
> > +overwrite_percentage=20
> > +seq=0
> > +
> > +_create_file() {
> > +	local file_name=${SCRATCH_MNT}/data_$1
> > +	local file_sz=$2
> > +	local dd_extra=$3
> > +
> > +	POSIXLY_CORRECT=yes dd if=/dev/zero of=${file_name} \
> > +		bs=${bs} count=$(( $file_sz / ${bs} )) \
> > +		status=none $dd_extra  2>&1
> > +
> > +	status=$?
> > +	if [ $status -ne 0 ]; then
> > +		echo "Failed writing $file_name" >>$seqres.full
> > +		exit
> > +	fi
> > +}

I wonder, is there a particular reason for doing all these file
operations with shell code instead of using fsstress to create and
delete files to fill the fs and stress all the zone-gc code?  This test
reminds me a lot of generic/476 but with more fork()ing.

--D

> > +
> > +_total_M() {
> > +	local total=$(stat -f -c '%b' ${SCRATCH_MNT})
> > +	local bs=$(stat -f -c '%S' ${SCRATCH_MNT})
> > +	echo $(( ${total} * ${bs} / ${M}))
> > +}
> > +
> > +_used_percent() {
> > +	local available=$(stat -f -c '%a' ${SCRATCH_MNT})
> > +	local total=$(stat -f -c '%b' ${SCRATCH_MNT})
> > +	echo $((100 - (100 * ${available}) / ${total} ))
> > +}
> > +
> > +
> > +_delete_random_file() {
> > +	local to_delete=$(find ${SCRATCH_MNT} -type f | shuf | head -1)
> > +	rm $to_delete
> > +	sync ${SCRATCH_MNT}
> > +}
> > +
> > +_get_random_fsz() {
> > +	local r=$RANDOM
> > +	echo $(( ${min_fsz} + (${max_fsz} - ${min_fsz}) * (${r} % 100) / 100 ))
> > +}
> > +
> > +_direct_fillup () {
> > +	while [ $(_used_percent) -lt $fill_percent ]; do
> > +		local fsz=$(_get_random_fsz)
> > +
> > +		_create_file $seq $fsz "oflag=direct conv=fsync"
> > +		seq=$((${seq} + 1))
> > +	done
> > +}
> > +
> > +_mixed_write_delete() {
> > +	local dd_extra=$1
> > +	local total_M=$(_total_M)
> > +	local to_write_M=$(( ${overwrite_percentage} * ${total_M} / 100 ))
> > +	local written_M=0
> > +
> > +	while [ $written_M -lt $to_write_M ]; do
> > +		if [ $(_used_percent) -lt $fill_percent ]; then
> > +			local fsz=$(_get_random_fsz)
> > +
> > +			_create_file $seq $fsz "$dd_extra"
> > +			written_M=$((${written_M} + ${fsz}/${M}))
> > +			seq=$((${seq} + 1))
> > +		else
> > +			_delete_random_file
> > +		fi
> > +	done
> > +}
> > +
> > +seed=$RANDOM
> > +RANDOM=$seed
> > +echo "Running test with seed=$seed" >>$seqres.full
> > +
> > +_scratch_mkfs_sized $((8 * 1024 * 1024 * 1024)) >>$seqres.full
> > +_scratch_mount
> > +
> > +echo "Starting fillup using direct IO"
> > +_direct_fillup
> > +
> > +echo "Starting mixed write/delete test using direct IO"
> > +_mixed_write_delete "oflag=direct"
> > +
> > +echo "Starting mixed write/delete test using buffered IO"
> > +_mixed_write_delete ""
> > +
> > +echo "Syncing"
> > +sync ${SCRATCH_MNT}/*
> > +
> > +echo "Done, all good"
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/744.out b/tests/generic/744.out
> > new file mode 100644
> > index 000000000000..b40c2f43108e
> > --- /dev/null
> > +++ b/tests/generic/744.out
> > @@ -0,0 +1,6 @@
> > +QA output created by 744
> > +Starting fillup using direct IO
> > +Starting mixed write/delete test using direct IO
> > +Starting mixed write/delete test using buffered IO
> > +Syncing
> > +Done, all good
> 

