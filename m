Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D677975EAAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGXEyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXEyT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05994E42
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690174412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsHlX/n7W4m6UrgFt8MF5EoQoXZ4oFaCMhkv/WslBXA=;
        b=U7aY28SWO0idhXL8vUcAmwMiQB6ZXzXHADtuxc67FT9U0m7D6jO5zqxih1ysxFIFHxCR6B
        Prn9OKFzwmzOaRCxBUyf0Mgq75GYIDYsS3xPVT6Y+VTVs5+kQLrD1GFhqvJ+la3I9FOHpT
        jP2aRu68SLovAvTirJ4kCIdPrtg8L10=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-wpXTpQzaM1GiIKwft5unQA-1; Mon, 24 Jul 2023 00:53:27 -0400
X-MC-Unique: wpXTpQzaM1GiIKwft5unQA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4039e119f40so57827161cf.0
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690174406; x=1690779206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsHlX/n7W4m6UrgFt8MF5EoQoXZ4oFaCMhkv/WslBXA=;
        b=R1BNQLKoolRD5N6h5quYGdAK9wmDzkD9V885/uNVswjzkuiSYpfwGWTXU7d2ZObRIM
         iiHAT7yqptK6Mo3+3VIz+suEi57KxHNEo8PEr/GS79g4I90rE4yNlFfanlDM7rnMmHZC
         GMZw/qJfGJxtrlm3kZFBGi/CgPcmBqDRwEplrDXn211HhAExa+uHYsB1n/Icyk7o8qHF
         bLx2FwrkuEowqFbo/mQD5mkjpo6nrR8jYcc7+Tr/TFcPY58FkV/LQE7Y6FDbK1AuR4hd
         Rkwl4rbgLiOO3l/u0R+ndwc0+L5amPTtyGJDd18Qm+8/91EJON4lvydbUgsSOG9so8+2
         va6g==
X-Gm-Message-State: ABy/qLaroWQioge0HhB7f18NOQi0SAi/BT90d2vFUwZ9LtpbtIPs6IdK
        ZMvmxtMq0Z7/L6qNXDYkaG3WZSRkGEaruqBwKFJaO0fRHipKb3WR5efwRbk1lnAF/9oE+LiAr1I
        kcoiYMTDJ+voZlV4GlZE456ZHXuIdkmiseZly
X-Received: by 2002:a05:622a:14d:b0:403:a701:1ac3 with SMTP id v13-20020a05622a014d00b00403a7011ac3mr7037997qtw.46.1690174406491;
        Sun, 23 Jul 2023 21:53:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJXGtR8qre80qJv7FtxuUg85C9Fv9opJRtabOWwNM+k8D6RyGbQubiAXoYimAyAA5QLlSADA==
X-Received: by 2002:a05:622a:14d:b0:403:a701:1ac3 with SMTP id v13-20020a05622a014d00b00403a7011ac3mr7037984qtw.46.1690174406222;
        Sun, 23 Jul 2023 21:53:26 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001b8a00d4f7asm7751595plf.9.2023.07.23.21.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 21:53:25 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:53:22 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add a test case to verify the write behavior of
 large RAID5 data chunks
Message-ID: <20230724045322.nifh2um32gnk7ovw@zlang-mailbox>
References: <20230622065438.86402-1-wqu@suse.com>
 <f7hsga77yx3zoh27yoji7yaziaw6dkgxnmdnaf44kowtfvqass@2fk3424qvnyu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7hsga77yx3zoh27yoji7yaziaw6dkgxnmdnaf44kowtfvqass@2fk3424qvnyu>
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

On Mon, Jul 24, 2023 at 01:23:06AM +0000, Naohiro Aota wrote:
> On Thu, Jun 22, 2023 at 02:54:38PM +0800, Qu Wenruo wrote:
> > There is a recent regression during v6.4 merge window, that a u32 left
> > shift overflow can cause problems with large data chunks (over 4G)
> > sized.
> > 
> > This is especially nasty for RAID56, which can lead to ASSERT() during
> > regular writes, or corrupt memory if CONFIG_BTRFS_ASSERT is not enabled.
> > 
> > This is the regression test case for it.
> > 
> > Unlike btrfs/292, btrfs doesn't support trim inside RAID56 chunks, thus
> > the workflow is simplified:
> > 
> > - Create a RAID5 or RAID6 data chunk during mkfs
> > 
> > - Fill the fs with 5G data and sync
> >   For unpatched kernel, the sync would crash the kernel.
> > 
> > - Make sure everything is fine
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  tests/btrfs/293     | 72 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/293.out |  2 ++
> >  2 files changed, 74 insertions(+)
> >  create mode 100755 tests/btrfs/293
> >  create mode 100644 tests/btrfs/293.out
> > 
> > diff --git a/tests/btrfs/293 b/tests/btrfs/293
> > new file mode 100755
> > index 00000000..68312682
> > --- /dev/null
> > +++ b/tests/btrfs/293
> > @@ -0,0 +1,72 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 293
> > +#
> > +# Test btrfs write behavior with large RAID56 chunks (size beyond 4G).
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto raid volume
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_require_scratch_dev_pool 8
> 
> Could you add following lines?
> 
> # RAID5/6 not working on zoned mode.
> _require_non_zoned_device "${SCRATCH_DEV}"
> 
> With that, looks good to me.

Hi Naohiro,

This patch has been merged last weekend. If you feel this line is needed, please
send another patch to 'fix' it.

Thanks,
Zorro

> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> > +_fixed_by_kernel_commit a7299a18a179 \
> > +	"btrfs: fix u32 overflows when left shifting @stripe_nr"
> > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +	"btrfs: use a dedicated helper to convert stripe_nr to offset"
> > +
> > +_scratch_dev_pool_get 8
> > +
> > +datasize=$((5 * 1024 * 1024 * 1024))
> > +
> > +
> > +workload()
> > +{
> > +	local data_profile=$1
> > +
> > +	_scratch_pool_mkfs -m raid1 -d $data_profile >> $seqres.full 2>&1
> > +	_scratch_mount
> > +	$XFS_IO_PROG -f -c "pwrite -b 1m 0 $datasize" $SCRATCH_MNT/foobar > /dev/null
> > +
> > +	# Unpatched kernel would trigger an ASSERT() or crash at writeback.
> > +	sync
> > +
> > +	echo "=== With initial 5G data written ($data_profile) ===" >> $seqres.full
> > +	$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
> > +	_scratch_unmount
> > +
> > +	# Make sure we haven't corrupted anything.
> > +	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
> > +	if [ $? -ne 0 ]; then
> > +		_scratch_dev_pool_put
> > +		_fail "data corruption detected after initial data filling"
> > +	fi
> > +}
> > +
> > +# Make sure each device has at least 2G.
> > +# Btrfs has a limits on per-device stripe length of 1G.
> > +# Double that so that we can ensure a RAID6 data chunk with 6G size.
> > +for i in $SCRATCH_DEV_POOL; do
> > +	devsize=$(blockdev --getsize64 "$i")
> > +	if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; then
> > +		_scratch_dev_pool_put
> > +		_notrun "device $i is too small, need at least 2G"
> > +	fi
> > +done
> > +
> > +workload raid5
> > +workload raid6
> > +
> > +_scratch_dev_pool_put
> > +echo "Silence is golden"
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
> > new file mode 100644
> > index 00000000..076fc056
> > --- /dev/null
> > +++ b/tests/btrfs/293.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 293
> > +Silence is golden
> > -- 
> > 2.39.0
> > 
> 

