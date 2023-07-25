Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82B87615EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjGYLee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 07:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjGYLed (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 07:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4262CF2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690284822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKG5P39AqYQEaMQO+Q/5zPvL5zpS7Hx4YR0bRUcRThI=;
        b=UUVfRU884XK/8HAlHDpMrW42l9KAWwZ+7o0DhYQ8sdlgz8xeDO1M7DErf8bSf0CgPV6Pd3
        bn4K0eIIAbDXGVLeOLqcFlBCK9hjCJgxNI8dCOJ/jfwZs8Oh6X5o0niqYBawBD60nUSviI
        bSCjdFUJLd+Ia2NU6MWf7lNn7cHbt4I=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-roZlh64oPX2UCDfMgJsAtg-1; Tue, 25 Jul 2023 07:33:41 -0400
X-MC-Unique: roZlh64oPX2UCDfMgJsAtg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5633ad8446bso2519783a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 04:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690284820; x=1690889620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKG5P39AqYQEaMQO+Q/5zPvL5zpS7Hx4YR0bRUcRThI=;
        b=L0l06QdYxqFiIMnSAM8iD6DWY2QGliLXT/tZCsZ3MXltDf9g/0qJcgUd3rbwHGBi/B
         F9WhOKfOy3x1EUoafypVdi4aJpAyE+j5L9oQ/aToDcGPGoROhz/SgLb4fCVljaa+xx6A
         CwXD4br6G6NLvY8OqILQo0rITKrsv8FV947/T/gJuC0PKctIq4sCdp7XyJBGhJH0dWii
         fh7BA7drzFzAoPvBt9ecjIrCI6ujH/NsDHu3Ma3MzKcDSNBFgeBdCCSeQLaoNIWDfOtH
         PXA4xHIER+kZJ4tfxfIVxR6n/INRMuqz/i6F7ccMe6NJG1g6Sg01gPYkjnI0Ftoa1kHA
         knVw==
X-Gm-Message-State: ABy/qLalRHQ0XJp5OW98X66i/at7onWUwYuIt/c2WYnovzexiK4CyBPg
        7ncLim4C8M/xKFoHHUe+SLUNC8kkxc9DOt7xFjoRmIbGQ0nR4249s3ih4jy6AFiJFz9DH1N4s0o
        VbuDqYi24B6H8D+JHKTX+zr0Ul8rMh6JIZ2v1
X-Received: by 2002:a05:6a20:9483:b0:130:b19d:ec1f with SMTP id hs3-20020a056a20948300b00130b19dec1fmr9630545pzb.11.1690284819771;
        Tue, 25 Jul 2023 04:33:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6tzJnfcewFsx3jeL+RKk781qeKXcLk0/VBitoDowegxvCtYnlDvN1IaWN/1oBKt8ALmoRTQ==
X-Received: by 2002:a05:6a20:9483:b0:130:b19d:ec1f with SMTP id hs3-20020a056a20948300b00130b19dec1fmr9630531pzb.11.1690284819419;
        Tue, 25 Jul 2023 04:33:39 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r16-20020a170902be1000b001b89c313185sm10809239pls.205.2023.07.25.04.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 04:33:38 -0700 (PDT)
Date:   Tue, 25 Jul 2023 19:33:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add a test case to make sure scrub can repair
 parity corruption
Message-ID: <20230725113335.wbqjhgte2iduajgb@zlang-mailbox>
References: <20230724023606.91107-1-wqu@suse.com>
 <334de8f1-5f7f-5817-9c33-f7fac7b2a24b@oracle.com>
 <20230725103628.bd7sxyjgyit7t7t5@zlang-mailbox>
 <8fe3ada0-60e7-ea69-d64b-1245a1af3d60@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fe3ada0-60e7-ea69-d64b-1245a1af3d60@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 25, 2023 at 07:13:02PM +0800, Anand Jain wrote:
> 
> 
> On 25/07/2023 18:36, Zorro Lang wrote:
> > On Mon, Jul 24, 2023 at 03:48:52PM +0800, Anand Jain wrote:
> > > On 24/7/23 10:36, Qu Wenruo wrote:
> > > > There is a kernel regression caused by commit 75b470332965 ("btrfs:
> > > > raid56: migrate recovery and scrub recovery path to use error_bitmap"),
> > > > which leads to scrub not repairing corrupted parity stripes.
> > > > 
> > > > So here we add a test case to verify the P/Q stripe scrub behavior by:
> > > > 
> > > > - Create a RAID5 or RAID6 btrfs with minimal amount of devices
> > > >     This means 2 devices for RAID5, and 3 devices for RAID6.
> > > >     This would result the parity stripe to be a mirror of the only data
> > > >     stripe.
> > > > 
> > > >     And since we have control of the content of data stripes, the content
> > > >     of the P stripe is also fixed.
> > > > 
> > > > - Create an 64K file
> > > >     The file would cover one data stripe.
> > > > 
> > > > - Corrupt the P stripe
> > > > 
> > > > - Scrub the fs
> > > >     If scrub is working, the P stripe would be repaired.
> > > > 
> > > >     Unfortunately scrub can not report any P/Q corruption, limited by its
> > > >     reporting structure.
> > > >     So we can not use the return value of scrub to determine if we
> > > >     repaired anything.
> > > > 
> > > > - Verify the content of the P stripe
> > > > 
> > > > - Use "btrfs check --check-data-csum" to double check
> > > > 
> > > > By above steps, we can verify if the P stripe is properly fixed.
> > > > 
> > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > > ---
> > > > Changelog:
> > > > v2:
> > > > - Rebase to the latest misc-next
> > > > - Use space_cache=v2 mount option instead of nospace_cache
> > > >     New features like block group tree and extent tree v2 requires v2
> > > >     cache
> > > > - Fix a white space error
> > > > ---
> > > >    tests/btrfs/297     | 85 +++++++++++++++++++++++++++++++++++++++++++++
> > > >    tests/btrfs/297.out |  2 ++
> > > >    2 files changed, 87 insertions(+)
> > > >    create mode 100755 tests/btrfs/297
> > > >    create mode 100644 tests/btrfs/297.out
> > > > 
> > > > diff --git a/tests/btrfs/297 b/tests/btrfs/297
> > > > new file mode 100755
> > > > index 00000000..852c3ace
> > > > --- /dev/null
> > > > +++ b/tests/btrfs/297
> > > > @@ -0,0 +1,85 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > 
> > > > +# Copyright (c) 2023 YOUR NAME HERE.  All Rights Reserved.
> > > 
> > > NIT: Actual name is required here.
> > > 
> > > Rest of the code looks good.
> > 
> > If there's not more review points, I can help to
> >     s/YOUR NAME HERE/SUSE Linux Products GmbH
> > when I merge it.
> > 
> > BTW, do you mean there's a RVB from you?
> 
>   Qu has sent v3 for this patch and there is my RVB as well.
> Thanks.

OK, got it, thanks:)

> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Thanks.
> > > 
> > > > +#
> > > > +# FS QA Test 297
> > > > +#
> > > > +# Make sure btrfs scrub can fix parity stripe corruption
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick raid scrub
> > > > +
> > > > +. ./common/filter
> > > > +
> > > > +_supported_fs btrfs
> > > > +_require_odirect
> > > > +_require_non_zoned_device "${SCRATCH_DEV}"
> > > > +_require_scratch_dev_pool 3
> > > > +_fixed_by_kernel_commit 486c737f7fdc \
> > > > +	"btrfs: raid56: always verify the P/Q contents for scrub"
> > > > +
> > > > +workload()
> > > > +{
> > > > +	local profile=$1
> > > > +	local nr_devs=$2
> > > > +
> > > > +	echo "=== Testing $nr_devs devices $profile ===" >> $seqres.full
> > > > +	_scratch_dev_pool_get $nr_devs
> > > > +
> > > > +	_scratch_pool_mkfs -d $profile -m single >> $seqres.full 2>&1
> > > > +	# Use v2 space cache to prevent v1 space cache affecting
> > > > +	# the result.
> > > > +	_scratch_mount -o space_cache=v2
> > > > +
> > > > +	# Create one 64K extent which would cover one data stripe.
> > > > +	$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 64K 0 64K" \
> > > > +		"$SCRATCH_MNT/foobar" > /dev/null
> > > > +	sync
> > > > +
> > > > +	# Corrupt the P/Q stripe
> > > > +	local logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> > > > +
> > > > +	# The 2nd copy is pointed to P stripe directly.
> > > > +	physical_p=$(_btrfs_get_physical ${logical} 2)
> > > > +	devpath_p=$(_btrfs_get_device_path ${logical} 2)
> > > > +
> > > > +	_scratch_unmount
> > > > +
> > > > +	echo "Corrupt stripe P at devpath $devpath_p physical $physical_p" \
> > > > +		>> $seqres.full
> > > > +	$XFS_IO_PROG -d -c "pwrite -S 0xff -b 64K $physical_p 64K" $devpath_p \
> > > > +		> /dev/null
> > > > +
> > > > +	# Do a scrub to try repair the P stripe.
> > > > +	_scratch_mount -o space_cache=v2
> > > > +	$BTRFS_UTIL_PROG scrub start -BdR $SCRATCH_MNT >> $seqres.full 2>&1
> > > > +	_scratch_unmount
> > > > +
> > > > +	# Verify the repaired content directly
> > > > +	local output=$($XFS_IO_PROG -c "pread -qv $physical_p 16" $devpath_p | _filter_xfs_io_offset)
> > > > +	local expect="XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................"
> > > > +
> > > > +	echo "The first 16 bytes of parity stripe after scrub:" >> $seqres.full
> > > > +	echo $output >> $seqres.full
> > > > +	if [ "$output" != "$expect" ]; then
> > > > +		echo "Unexpected parity content"
> > > > +		echo "has:"
> > > > +		echo "$output"
> > > > +		echo "expect"
> > > > +		echo "$expect"
> > > > +	fi
> > > > +
> > > > +	# Last safenet, let btrfs check --check-data-csum to do an offline scrub.
> > > > +	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
> > > > +	if [ $? -ne 0 ]; then
> > > > +		echo "Error detected after the scrub"
> > > > +	fi
> > > > +	_scratch_dev_pool_put
> > > > +}
> > > > +
> > > > +workload raid5 2
> > > > +workload raid6 3
> > > > +
> > > > +echo "Silence is golden"
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/btrfs/297.out b/tests/btrfs/297.out
> > > > new file mode 100644
> > > > index 00000000..41c373c4
> > > > --- /dev/null
> > > > +++ b/tests/btrfs/297.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 297
> > > > +Silence is golden
> > > 
> > 
> 

