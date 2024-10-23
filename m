Return-Path: <linux-btrfs+bounces-9081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 642049ABBFE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 05:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65531F2462A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 03:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9458615A;
	Wed, 23 Oct 2024 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUPkfmW0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958B208CA
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653009; cv=none; b=da3CTxgzDFbG8evIWG7jG3pXkk507Camz48BgKVhBmvR4rjqS0Q38sn0zb5xDp1bOVTqaZUPnS5azzBMVECK3CWc5rI+zDBsQQx0ukiv68SlBAI/hY+2GYBniMXFXKWwBBYJRCq2aG7tX0gzKftlU6q37namNszfsRt4E0gaXLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653009; c=relaxed/simple;
	bh=cdVYzxA9V0mqTvdRL5WzspOt0khZ+4J6SlntaCXK0nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3k27ux0gtZ8YAf1gRp1sbAjbmI8KxnXRByvPpbPB3buNtwERBmuMULtBpszI7MywtcApOuZXSMl2Zo4WbdIjW667wJukW10M4+uMx7gP+y6nQJPkKe+eB9lwwwzwMAhVD/r0eN34JVeUG8zEVXjkFNFCI+VDiIweHJ4ma9QP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUPkfmW0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729653006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ChFLDrze5/mqU1OQW4F/3+zfzN2ESjZs15mIH13gjY8=;
	b=gUPkfmW0tDlEmXJgpp6cLIZMeYQs7lK9Lh3hzv53k9I7W95FANyy2lWgIYTRGEw5eKHEuc
	RSFN3rZc21AlW4H9ImeooQBezmRnwolACCkNeK2z2KcMOtcYD3p1WxQ7RGmJTknIgR1v+1
	lgBrwAQBDNrOPOgrEm2aJwCTSNMfkYc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-3FSafz_4NjuV69F2hUXDTw-1; Tue, 22 Oct 2024 23:10:05 -0400
X-MC-Unique: 3FSafz_4NjuV69F2hUXDTw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-20c3d9a0eb2so88804415ad.0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 20:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729653004; x=1730257804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChFLDrze5/mqU1OQW4F/3+zfzN2ESjZs15mIH13gjY8=;
        b=a6vOBciiZmhjXTxUuEgyxv5soF+GowCxgtdVOgJ6S7t7rEdEsVS94JiUMqESWMnL3W
         OwnDWG7+9dMC7l2fjYA0ACCbGpoR4cokClsR4hY+kiVu32Dt2eD77ci7rv6HPWMZFAdU
         zuMWL2czsgYbfMmFDmAmpLASpxE1aq83Nq3P6XbYwQJ5+kp8wcgR1gKOWz2PomH8ssMt
         kZuqL6+MkL2B6roYoLXuaQtzhuCDlcBBnIWhWlv6d44ksidda9o1AD5djYvdCot9M6iI
         lScCGWQLFMS/ca28jldldqVv9y3AX2hsSGA4dRx70nOZhe3BhgXxcGoKGs/r065mtrpF
         R5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYUz76P8K/wDxGxOrZ8QGPoPvNqY/6LyMylLHH1oDMZ8Lkul+uiouWPYfFrwjbuZP+x7gNsMQdWcfTMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJT6sBqT1sdR618d10p67epuHPESTrOgDn+CFrpUgkp9qoKuN
	rnFdNOeQtNW5hy3ZuO2ixBJ3x5uH+nG0vFZshHi6uQ5/KocLkk/MbvI2Np6MrFzav4YKRYZksTs
	XOFzSknqHGS10G46S2FlUP+5OzYIdChXti9pXawAENnSyk7N98mS1bBxZ54GrbxrzkX0YCvA=
X-Received: by 2002:a17:902:ce88:b0:20c:a44b:3221 with SMTP id d9443c01a7336-20fa9dfebdbmr20107145ad.15.1729653004084;
        Tue, 22 Oct 2024 20:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqwBzYOQQDsSCIZb3ftnY/93Ymddn4E8R4OUmogkkBqai5duRoFN+bqyo9b7IHOnmD6WF4mQ==
X-Received: by 2002:a17:902:ce88:b0:20c:a44b:3221 with SMTP id d9443c01a7336-20fa9dfebdbmr20106995ad.15.1729653003735;
        Tue, 22 Oct 2024 20:10:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd367sm49175955ad.146.2024.10.22.20.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 20:10:03 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:09:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: add test for cleaner thread under seed-sprout
Message-ID: <20241023030958.c5beiy5uwzpn62l7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20ebca40c55ed9207b6ea77aa50e93f3baf698ad.1729101127.git.boris@bur.io>
 <ef523540-c7b3-4827-ae9f-ea55130f5060@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef523540-c7b3-4827-ae9f-ea55130f5060@oracle.com>

On Sat, Oct 19, 2024 at 06:19:20AM +0800, Anand Jain wrote:
> On 17/10/24 01:54, Boris Burkov wrote:
> > We have a longstanding bug that creating a seed sprout fs with the
> > ro->rw transition done with
> > 
> > mount -o remount,rw $mnt
> > 
> > instead of
> > 
> > umount $mnt
> > mount $sprout_dev $mnt
> > 
> > results in an fs without BTRFS_FS_OPEN set, which fails to ever run the
> > critical btrfs cleaner thread.
> > 
> > This test reproduces that bug and detects it by creating and deleting a
> > subvolume, then triggering the cleaner thread. The expected behavior is
> > for the cleaner thread to delete the stale subvolume and for the list to
> > show no entries. Without the fix, we see a DELETED entry for the subvol.
> > 
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v3:
> > - add volume group
> > - switch to SCRATCH_DEV/SPARE_DEV
> > - filter scratch devs from mount/findmnt output instead of suppressing.
> >    This adds the expected read only message that comes with mounting seed
> >    devices to the golden output, and makes the ro/rw check more natural.
> > v2:
> > - update to real copyright info
> > - add extra rw->ro transition checks
> > - remove unnecessary _require_test
> > ---
> >   tests/btrfs/323     | 47 +++++++++++++++++++++++++++++++++++++++++++++
> >   tests/btrfs/323.out |  4 ++++
> >   2 files changed, 51 insertions(+)
> >   create mode 100755 tests/btrfs/323
> >   create mode 100644 tests/btrfs/323.out
> > 
> > diff --git a/tests/btrfs/323 b/tests/btrfs/323
> > new file mode 100755
> > index 000000000..4e389d66a
> > --- /dev/null
> > +++ b/tests/btrfs/323
> > @@ -0,0 +1,47 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 323
> > +#
> > +# Test that remounted seed/sprout device FS is fully functional. For example, that it can purge stale subvolumes.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick seed remount
> 
> volume
> 
> Zorro, can you pls add it while merging.

Sure, thanks Anand!

> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Thanks
> Anand
> 
> 
> > +
> > +. ./common/filter
> > +_require_command "$BTRFS_TUNE_PROG" btrfstune
> > +_require_scratch_dev_pool 2
> > +
> > +_fixed_by_kernel_commit XXXXXXXX \
> > +	"btrfs: do not clear read-only when adding sprout device"
> > +
> > +_scratch_dev_pool_get 1
> > +_spare_dev_get
> > +
> > +# create a read-only fs based off a read-only seed device
> > +_scratch_mkfs >>$seqres.full
> > +$BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV
> > +_scratch_mount 2>&1 | _filter_scratch
> > +_btrfs device add -f $SPARE_DEV $SCRATCH_MNT >>$seqres.full
> > +
> > +# switch ro to rw, checking that it was ro before and rw after
> > +findmnt -n -O ro -o TARGET $SCRATCH_MNT | _filter_scratch
> > +_mount -o remount,rw $SCRATCH_MNT
> > +findmnt -n -O rw -o TARGET $SCRATCH_MNT | _filter_scratch
> > +
> > +# do stuff in the seed/sprout fs
> > +_btrfs subvolume create $SCRATCH_MNT/subv
> > +_btrfs subvolume delete $SCRATCH_MNT/subv
> > +
> > +# trigger cleaner thread without remounting
> > +_btrfs filesystem sync $SCRATCH_MNT
> > +
> > +# expect no deleted subvolumes remaining
> > +$BTRFS_UTIL_PROG subvolume list -d $SCRATCH_MNT
> > +
> > +_spare_dev_put
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
> > new file mode 100644
> > index 000000000..1ca2e4b13
> > --- /dev/null
> > +++ b/tests/btrfs/323.out
> > @@ -0,0 +1,4 @@
> > +QA output created by 323
> > +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> > +SCRATCH_MNT
> > +SCRATCH_MNT
> 
> 


