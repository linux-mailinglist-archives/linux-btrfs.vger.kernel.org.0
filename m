Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA15792D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 07:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiGSFx1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 01:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiGSFxP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 01:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12F283AB1E
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 22:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658209991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YX4dhiSjuIQpsqN8+PuQTMzdHGy8TjHrt9u5yxYBsp8=;
        b=b4qYPRlrkz6TTWie8fLiIxMbnT4cafS69yE7A5h0s1pIN//kzGLDCQLqye91F0HqP1LM0p
        3xR2C3+gUhi9ql+/tUxdBNw6EKJyFVNJuuNMZVvAiqpe0tJ+f8TRGq7THC8gasMGAX8jPa
        lyvP9HwKzZCkTzoVVEo+c3waXWNFr54=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-M5m9oPr4Pn6SM0oQfYyGxg-1; Tue, 19 Jul 2022 01:53:04 -0400
X-MC-Unique: M5m9oPr4Pn6SM0oQfYyGxg-1
Received: by mail-qk1-f199.google.com with SMTP id i15-20020a05620a404f00b006b55998179bso10965780qko.4
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 22:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YX4dhiSjuIQpsqN8+PuQTMzdHGy8TjHrt9u5yxYBsp8=;
        b=KlzOAwPEzggWH9rCbx8cOaJqHEVt88oIOztZIoGDGYv8dRoSeTgXbPXghJo597K88M
         hiNgznMwUNQERpRGRNNQQr1taI3ndTuyMzoTpOrd2toE1sqZ2y2JNq9kmotOOUuNeoet
         cN/6M7hM1B5yoZ+Q9Vs4jEJV+RdksHj+WOzOIwE+Lt0md/cq5tmzqX6N5Rf4AupGSzPw
         zP/8ucokwAWk7zQecNhpTKmwL4dvnoIkoCkOVyk861dwT3JFCD+Rdvco1TIstHi7MOP7
         myxFyFD1viePOegrD2TJ7Lkl/PytYR06NTJfE/hP03CHt9fpFtJuXCSo/usr4pITDFd/
         evmw==
X-Gm-Message-State: AJIora+hN2Wv3vEelsL+MAIv/nAsBoWXkucEZ3n/egcyeJVlybHwYBn+
        V/lRw48NNFioLypH7374KnwSIffwxYiNYvze/g79nZTjyS1zTmPP9niaSAMu+IgChNseGyt7ksf
        LQf1QRCLRLMVB01Sgk2vBlPo=
X-Received: by 2002:a05:6214:c25:b0:473:2d88:f5ff with SMTP id a5-20020a0562140c2500b004732d88f5ffmr24040192qvd.101.1658209983890;
        Mon, 18 Jul 2022 22:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vCz/ZJA47504eU/7D2RPjMcoJoihY33vdo4zTOrerdhY5Py3rd9I5G2FpmsT1cEx8sE5J1ag==
X-Received: by 2002:a05:6214:c25:b0:473:2d88:f5ff with SMTP id a5-20020a0562140c2500b004732d88f5ffmr24040178qvd.101.1658209983516;
        Mon, 18 Jul 2022 22:53:03 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a288f00b006a5d2eb58b2sm14119150qkp.33.2022.07.18.22.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:53:02 -0700 (PDT)
Date:   Tue, 19 Jul 2022 13:52:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH RFC] fstests: btrfs: add a tests case to make sure btrfs
 can handle certain interleaved free space correctly
Message-ID: <20220719055256.3rkebiphyep3dei5@zlang-mailbox>
References: <20220718061823.26147-1-wqu@suse.com>
 <20220718175912.5mhc7hhkysgadvqd@zlang-mailbox>
 <b8d80f54-1a0e-54eb-3bc2-8b07cbd7edf6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8d80f54-1a0e-54eb-3bc2-8b07cbd7edf6@gmx.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 19, 2022 at 01:16:54PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/7/19 01:59, Zorro Lang wrote:
> > On Mon, Jul 18, 2022 at 02:18:23PM +0800, Qu Wenruo wrote:
> > > This is a future-proof test mostly for future zoned raid-stripe-tree
> > > (RST) and P/Q COW based RAID56 implementation.
> > > 
> > > Unlike regular devices, zoned device can not do overwrite without
> > > resetting (reclaim) a whole zone.
> > > 
> > > And for the RST and P/Q COW based RAID56, the idea is to CoW the parity
> > > stripe to other location.
> > > 
> > > But all above behaviors introduce some limitation, if we fill the fs,
> > > then free half of the space interleaved.
> > > 
> > > - For basic zoned btrfs (aka SINGLE profile for now)
> > >    Normally this means we have no free space at all.
> > > 
> > >    Thankfully zoned btrfs has GC and reserved zones to reclaim those
> > >    half filled zones.
> > >    In theory we should be able to do new writes.
> > > 
> > > - For future RST with P/Q CoW for RAID56, on non-zoned device.
> > >    This is more complex, in this case, we should have the following
> > >    full stripe layout for every full stripe:
> > >            0                           64K
> > >    Disk A  |XXXXXXXXXXXXXXXXXXXXXXXXXXX| (Data 1)
> > >    Disk B  |                           | (Data 2)
> > >    Disk C  |XXXXXXXXXXXXXXXXXXXXXXXXXXX| (P stripe)
> > > 
> > >    Although in theory we can write into Disk B, but we have to find
> > >    a free space for the new Parity.
> > > 
> > >    But all other full stripe are like this, which means we're deadlocking
> > >    to find a pure free space without sub-stripe writing.
> > > 
> > >    This means, even for non-zoned btrfs, we still need GC and reserved
> > >    space to handle P/Q CoW properly.
> > > 
> > > Another thing specific to this test case is, to reduce the runtime, I
> > > use 256M as the mkfs size for each device.
> > > (A full run with KASAN enabled kernel already takes over 700 seconds)
> > > 
> > > So far this can only works for non-zoned disks, as 256M is too small for
> > > zoned devices to have enough zones.
> > > 
> > > Thus need extra advice from zoned device guys.
> > > 
> > > Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > 
> > I think this patch need more review from btrfs list. I just review this patch
> > from fstests side as below ...
> > 
> > >   tests/btrfs/261     | 129 ++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/btrfs/261.out |   2 +
> > >   2 files changed, 131 insertions(+)
> > >   create mode 100755 tests/btrfs/261
> > >   create mode 100644 tests/btrfs/261.out
> > > 
> > > diff --git a/tests/btrfs/261 b/tests/btrfs/261
> > > new file mode 100755
> > > index 00000000..01da4759
> > > --- /dev/null
> > > +++ b/tests/btrfs/261
> > > @@ -0,0 +1,129 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 261
> > > +#
> > > +# Make sure all supported profiles (including future zoned RAID56) have proper
> > > +# way to handle fs with interleaved filled space, and can still write data
> > > +# into the fs.
> > > +#
> > > +# This is mostly inspired by some discussion on P/Q COW for RAID56, even for
> > > +# regular devices, this can be problematic if we fill the fs then delete
> > > +# half of the extents interleavedly. Without proper GC and extra reserved
> > > +# space, such CoW P/Q way should run out of space (even one data stripe is
> > > +# free, there is no place to CoW its P/Q).
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto enospc raid
> > > +
> > > +# Override the default cleanup function.
> > > +# _cleanup()
> > > +# {
> > > +# 	cd /
> > > +# 	rm -r -f $tmp.*
> > > +# }
> > 
> > This _cleanup looks like nothing special, you can remove it, to use the default
> > one.
> 
> It's still commented out, just from the template.
> 
> Or you mean I should delete the unused cleanup function if we don't need?

Sure, please remove those useless comments from template, they're just reminder.

> 
> > 
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +
> > > +# real QA test starts here
> > > +
> > > +# Modify as appropriate.
> >       ^^^
> >     Remove this line please.
> > 
> > > +_supported_fs btrfs
> > > +# we check scratch dev after each loop
> > > +_require_scratch_nocheck
> > > +_require_scratch_dev_pool 4
> > > +
> > > +fill_fs()
> > 
> > There's a help named _fill_fs() in common/populate file. I'm not sure if there
> > are special things in your fill_fs function, better to check if our common
> > helper can help you?
> 
> The fill fs here is to make sure we fill the fs in a specific way
> (always fill the fs using 128KiB, while still being able to delete 64KiB).
> 
> I'll add a comment for the reason.

Sure, if the comment _fill_fs can't help you, feel free to have your own
one (and better to explain what's special in it).

> 
> > 
> > > +{
> > > +	for (( i = 0;; i += 2 )); do
> > > +		$XFS_IO_PROG -f -c "pwrite 0 64K" $SCRATCH_MNT/file_$i \
> > > +			&> /dev/null
> > > +		if [ $? -ne 0 ]; then
> > > +			break
> > > +		fi
> > > +		$XFS_IO_PROG -f -c "pwrite 0 64K" $SCRATCH_MNT/file_$(($i + 1)) \
> > > +			&> /dev/null
> > > +		if [ $? -ne 0 ]; then
> > > +			break
> > > +		fi
> > > +
> > > +		# Only sync after data 1M writes.
> > > +		if [ $(( $i % 8)) -eq 0 ]; then
> > > +			sync
> > > +		fi
> > > +	done
> > > +
> > > +	# Sync what hasn't yet synced.
> > > +	sync
> > > +
> > > +	echo "fs filled with $i full stripe write" >> $seqres.full
> > > +
> > > +	# Delete half of the files created above, which should leave
> > > +	# the fs half empty. For RAID56 this would leave all of its full
> > > +	# stripes to be have one full data stripe, one free data stripe,
> > > +	# and one P/Q stripe still in use.
> > > +	rm -rf -- $SCRATCH_MNT/file_*[02468]
> > > +
> > > +	# Sync to make sure above deleted files really got freed.
> > > +	sync
> > > +}
> > > +
> > > +run_test()
> > > +{
> > > +	local profile=$1
> > > +	local nr_dev=$2
> > > +
> > > +	echo "=== profile=$profile nr_dev=$nr_dev ===" >> $seqres.full
> > > +	_scratch_dev_pool_get $nr_dev
> > > +	# -b is for each device.
> > > +	# Here we use 256M to reduce the runtime.
> > > +	_scratch_pool_mkfs -b 256M -m$profile -d$profile >>$seqres.full 2>&1
> > 
> > Do you need to make sure this mkfs successed at here?
> 
> Yes.
> 
> > 
> > > +	# make sure we created btrfs with desired options
> > > +	if [ $? -ne 0 ]; then
> > > +		echo "mkfs $mkfs_opts failed"
> > > +		return
> > > +	fi
> > > +	_scratch_mount >>$seqres.full 2>&1
> > 
> > If _scratch_mount fails, the testing will exit directly. So generally we don't
> > need to fill out stdout/stderr. Or you actually want to use _try_scratch_mount
> > at here?
> 
> _scratch_mount is exactly what I need, I'll just remove the unnecessary
> redirection.

OK

> 
> > 
> > > +
> > > +	fill_fs
> > > +
> > > +	# Now try to write 4M data, with the fs half empty we should be
> > > +	# able to do that.
> > > +	# For zoned devices, this will test if the GC and reserved zones
> > > +	# can handle such cases properly.
> > > +	$XFS_IO_PROG -f -c "pwrite 0 4M" -c sync $SCRATCH_MNT/final_write \
> > > +		>> $seqres.full 2>&1
> > > +	if [ $? -ne 0 ]; then
> > > +		echo "The final write failed"
> > > +	fi
> > > +
> > > +	_scratch_unmount
> > > +	# we called _require_scratch_nocheck instead of _require_scratch
> > > +	# do check after test for each profile config
> > > +	_check_scratch_fs
> > > +	echo  >> $seqres.full
> > > +	_scratch_dev_pool_put
> > > +}
> > > +
> > > +# Here we don't use _btrfs_profile_configs as that doesn't include
> > > +# the number of devices, but for full stripe writes for RAID56, we
> > > +# need to ensure nr_data must be 2, so here we manually specify
> > > +# the profile and number of devices.
> > > +run_test "single" "1"
> > > +
> > > +# Zoned only support
> > > +if _scratch_btrfs_is_zoned; then
> > > +	exit
> > 
> > I think this "exit" will fail this test directly, due to status=1 currectly.
> > You can use _require_non_zoned_device() to run this case for non-zoned device
> > only. Or
> > 
> >    if ! _scratch_btrfs_is_zoned;then
> > 	run_test "raid0" "2"
> > 	run_test "raid1" "2"
> > 	run_test "raid10" "4"
> > 	run_test "raid5" "3"
> > 	run_test "raid6" "4"
> >    fi
> > 
> > As this case is "Silence is golden".
> > 
> > I'm not sure what do you really need at here, can these help?
> 
> My bad, I forgot to finish the comment, and your example is perfect.
> 
> Thanks for the review.

Np. But before I merge your patch, we still need a RVB from btrfs list at least,
even if I give it my RVB, due to this case is marked as btrfs RFC.

Thanks,
Zorro

> Qu
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > +fi
> > > +
> > > +run_test "raid0" "2"
> > > +run_test "raid1" "2"
> > > +run_test "raid10" "4"
> > > +run_test "raid5" "3"
> > > +run_test "raid6" "4"
> > > +
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
> > > new file mode 100644
> > > index 00000000..679ddc0f
> > > --- /dev/null
> > > +++ b/tests/btrfs/261.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 261
> > > +Silence is golden
> > > --
> > > 2.36.1
> > > 
> > 
> 

