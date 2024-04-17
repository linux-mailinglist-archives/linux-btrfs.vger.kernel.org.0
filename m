Return-Path: <linux-btrfs+bounces-4348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B15D8A8350
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3CB286410
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01413CF94;
	Wed, 17 Apr 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnLVbS+G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA312C80B
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357809; cv=none; b=b69uuwUJNm0CP6+uW9hkItWOfp++rHOYaV3o3QgYAB/vDxl7wQ5cWMXWm/c4ROFHMhyNOvosgb5tVYx5CZRQz4EyL09XiARrA7y9IJ+sdoUU7c/Xs99tM3xGbH2Rvy5uhQ3h0cxEp5dPRHG75SN/lRv2GVH7P0SNfFbT4+g2iDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357809; c=relaxed/simple;
	bh=BB4busvcVoi4T96zjKX8SM2EO5+oa0uNorRb2gHxi1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCGozTurDK/wbJMd0Mq3XSty6MWuDxo5K6vi9cyVpCxQxFpP5P7dzyzCUL3YmjHqHz2N5/gXKIBOybNoOhll8T8pdWq+u+HP5CD0UPmP5jETS13I3U6l4cOeLsTZNeHjgK2vN2EhpWer+lX9zz5MMvePd2otnZcP1Rpl95oKeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnLVbS+G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713357806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9LjbpfzKnmmd9QFgHl5uwGiaL0jc3hFvBc6FeYRCc88=;
	b=VnLVbS+G3DEp7d+SJcRJIHjqla3MVv2WsFy8hC6aAVcPsN++GngBdj4v17l+5rjZAXggF1
	AiUDGRC2hSDhGlHyBAlw/b86GivyRBy82SNhbHdukvh5HVC8/pa+yPrwVdf1MgxXCITZEA
	+bHW7TJLc6pQTb0/UVFUBBhK20pLgJw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-TxZr7IuVO-mt2-NbIqPWpQ-1; Wed, 17 Apr 2024 08:43:25 -0400
X-MC-Unique: TxZr7IuVO-mt2-NbIqPWpQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6eb86b1deb1so2879996a34.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 05:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713357804; x=1713962604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LjbpfzKnmmd9QFgHl5uwGiaL0jc3hFvBc6FeYRCc88=;
        b=l43td0al5HAU50mB/EcfySlMo8dbPT8c86vycTjg+nrpCbRwxE8br/LHMOm4bKjqk7
         Z8kop7NGcdcQMFBIGO9q7d9OL1JCoNeLfwFCFIKTyJJg+Gmrsus+29QCUha4muSQvSrW
         t5XD7yWxj1p0yW2R9H2eJrzOFXKDfB7bHVu2MBBK3L2kZwFFenmn597N6lrkIl5ROrOg
         X3wspkSQh7HKfYSRL6VVwA3+WwQGEYs1RAfuWx6WFiBpALPFhxpt7NGoBg6NXgnSCrZc
         rpiey+eXVQEH8Mt6Us4K+gqjkNo8xdsoEapYNWackwag+etqpoTZehfXno2pMzZ3WF+N
         EL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7BxpQR6ewWBKgXyrwNjZ73Tk+tG0U/gckJ9VvBsQFSBy0MblwmXerf96etQ1XTmFyCm2V0/rDm5V7wuIiR/gqWcGtFVftbdMYJgY=
X-Gm-Message-State: AOJu0Yy9aoFlhEW2usJGxqCFQ89Aqmzivj/PjnF+XBREHZXeDlAahaKy
	9AjJRgQr8bN9EQCrHbvdraHvScycNbngWk+x/R2V4bowzJ/MTd6ykNZ4aJ+Dptz5aMTMMluBwRs
	sqdOw8dNGox7YnCh4vszTzG0nS/NE/5aaPIHf7UqhCGJcOgbo4nXrqxECpcCchYjBxPyp
X-Received: by 2002:a9d:624b:0:b0:6ea:2d0c:6140 with SMTP id i11-20020a9d624b000000b006ea2d0c6140mr16544796otk.29.1713357804348;
        Wed, 17 Apr 2024 05:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3Vk8IXEgwGvvM7EiHYNmj94OxFf/2Pbr90Y9Q8sQ8UOhUz9exqy6BOK3H5GiUv7YpQ5Bq4g==
X-Received: by 2002:a9d:624b:0:b0:6ea:2d0c:6140 with SMTP id i11-20020a9d624b000000b006ea2d0c6140mr16544768otk.29.1713357803940;
        Wed, 17 Apr 2024 05:43:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w9-20020a63f509000000b005b458aa0541sm10352488pgh.15.2024.04.17.05.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:43:23 -0700 (PDT)
Date: Wed, 17 Apr 2024 20:43:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@lst.de" <hch@lst.de>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic: add gc stress test
Message-ID: <20240417124317.lje5w5hgawy4drkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240415112259.21760-1-hans.holmberg@wdc.com>
 <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com>
 <20240416185437.GC11935@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416185437.GC11935@frogsfrogsfrogs>

On Tue, Apr 16, 2024 at 11:54:37AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 16, 2024 at 09:07:43AM +0000, Hans Holmberg wrote:
> > +Zorro (doh!)
> > 
> > On 2024-04-15 13:23, Hans Holmberg wrote:
> > > This test stresses garbage collection for file systems by first filling
> > > up a scratch mount to a specific usage point with files of random size,
> > > then doing overwrites in parallel with deletes to fragment the backing
> > > storage, forcing reclaim.
> > > 
> > > Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> > > ---
> > > 
> > > Test results in my setup (kernel 6.8.0-rc4+)
> > > 	f2fs on zoned nullblk: pass (77s)
> > > 	f2fs on conventional nvme ssd: pass (13s)
> > > 	btrfs on zoned nublk: fails (-ENOSPC)
> > > 	btrfs on conventional nvme ssd: fails (-ENOSPC)
> > > 	xfs on conventional nvme ssd: pass (8s)
> > > 
> > > Johannes(cc) is working on the btrfs ENOSPC issue.
> > > 	
> > >   tests/generic/744     | 124 ++++++++++++++++++++++++++++++++++++++++++
> > >   tests/generic/744.out |   6 ++
> > >   2 files changed, 130 insertions(+)
> > >   create mode 100755 tests/generic/744
> > >   create mode 100644 tests/generic/744.out
> > > 
> > > diff --git a/tests/generic/744 b/tests/generic/744
> > > new file mode 100755
> > > index 000000000000..2c7ab76bf8b1
> > > --- /dev/null
> > > +++ b/tests/generic/744
> > > @@ -0,0 +1,124 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. 744
> > > +#
> > > +# Inspired by btrfs/273 and generic/015
> > > +#
> > > +# This test stresses garbage collection in file systems
> > > +# by first filling up a scratch mount to a specific usage point with
> > > +# files of random size, then doing overwrites in parallel with
> > > +# deletes to fragment the backing zones, forcing reclaim.
> > > +
> > > +. ./common/preamble
> > > +_begin_fstest auto
> > > +
> > > +# real QA test starts here
> > > +
> > > +_require_scratch
> > > +
> > > +# This test requires specific data space usage, skip if we have compression
> > > +# enabled.
> > > +_require_no_compress
> > > +
> > > +M=$((1024 * 1024))
> > > +min_fsz=$((1 * ${M}))
> > > +max_fsz=$((256 * ${M}))
> > > +bs=${M}
> > > +fill_percent=95
> > > +overwrite_percentage=20
> > > +seq=0
> > > +
> > > +_create_file() {
> > > +	local file_name=${SCRATCH_MNT}/data_$1
> > > +	local file_sz=$2
> > > +	local dd_extra=$3
> > > +
> > > +	POSIXLY_CORRECT=yes dd if=/dev/zero of=${file_name} \
> > > +		bs=${bs} count=$(( $file_sz / ${bs} )) \
> > > +		status=none $dd_extra  2>&1
> > > +
> > > +	status=$?
> > > +	if [ $status -ne 0 ]; then
> > > +		echo "Failed writing $file_name" >>$seqres.full
> > > +		exit
> > > +	fi
> > > +}
> 
> I wonder, is there a particular reason for doing all these file
> operations with shell code instead of using fsstress to create and
> delete files to fill the fs and stress all the zone-gc code?  This test
> reminds me a lot of generic/476 but with more fork()ing.

/me has the same confusion. Can this test cover more things than using
fsstress (to do reclaim test) ? Or does it uncover some known bugs which
other cases can't?

Thanks,
Zorro

> 
> --D
> 
> > > +
> > > +_total_M() {
> > > +	local total=$(stat -f -c '%b' ${SCRATCH_MNT})
> > > +	local bs=$(stat -f -c '%S' ${SCRATCH_MNT})
> > > +	echo $(( ${total} * ${bs} / ${M}))
> > > +}
> > > +
> > > +_used_percent() {
> > > +	local available=$(stat -f -c '%a' ${SCRATCH_MNT})
> > > +	local total=$(stat -f -c '%b' ${SCRATCH_MNT})
> > > +	echo $((100 - (100 * ${available}) / ${total} ))
> > > +}
> > > +
> > > +
> > > +_delete_random_file() {
> > > +	local to_delete=$(find ${SCRATCH_MNT} -type f | shuf | head -1)
> > > +	rm $to_delete
> > > +	sync ${SCRATCH_MNT}
> > > +}
> > > +
> > > +_get_random_fsz() {
> > > +	local r=$RANDOM
> > > +	echo $(( ${min_fsz} + (${max_fsz} - ${min_fsz}) * (${r} % 100) / 100 ))
> > > +}
> > > +
> > > +_direct_fillup () {
> > > +	while [ $(_used_percent) -lt $fill_percent ]; do
> > > +		local fsz=$(_get_random_fsz)
> > > +
> > > +		_create_file $seq $fsz "oflag=direct conv=fsync"
> > > +		seq=$((${seq} + 1))
> > > +	done
> > > +}
> > > +
> > > +_mixed_write_delete() {
> > > +	local dd_extra=$1
> > > +	local total_M=$(_total_M)
> > > +	local to_write_M=$(( ${overwrite_percentage} * ${total_M} / 100 ))
> > > +	local written_M=0
> > > +
> > > +	while [ $written_M -lt $to_write_M ]; do
> > > +		if [ $(_used_percent) -lt $fill_percent ]; then
> > > +			local fsz=$(_get_random_fsz)
> > > +
> > > +			_create_file $seq $fsz "$dd_extra"
> > > +			written_M=$((${written_M} + ${fsz}/${M}))
> > > +			seq=$((${seq} + 1))
> > > +		else
> > > +			_delete_random_file
> > > +		fi
> > > +	done
> > > +}
> > > +
> > > +seed=$RANDOM
> > > +RANDOM=$seed
> > > +echo "Running test with seed=$seed" >>$seqres.full
> > > +
> > > +_scratch_mkfs_sized $((8 * 1024 * 1024 * 1024)) >>$seqres.full
> > > +_scratch_mount
> > > +
> > > +echo "Starting fillup using direct IO"
> > > +_direct_fillup
> > > +
> > > +echo "Starting mixed write/delete test using direct IO"
> > > +_mixed_write_delete "oflag=direct"
> > > +
> > > +echo "Starting mixed write/delete test using buffered IO"
> > > +_mixed_write_delete ""
> > > +
> > > +echo "Syncing"
> > > +sync ${SCRATCH_MNT}/*
> > > +
> > > +echo "Done, all good"
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/744.out b/tests/generic/744.out
> > > new file mode 100644
> > > index 000000000000..b40c2f43108e
> > > --- /dev/null
> > > +++ b/tests/generic/744.out
> > > @@ -0,0 +1,6 @@
> > > +QA output created by 744
> > > +Starting fillup using direct IO
> > > +Starting mixed write/delete test using direct IO
> > > +Starting mixed write/delete test using buffered IO
> > > +Syncing
> > > +Done, all good
> > 
> 


