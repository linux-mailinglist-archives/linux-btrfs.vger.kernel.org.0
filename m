Return-Path: <linux-btrfs+bounces-14544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2215AD11FA
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Jun 2025 14:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CADA1887350
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Jun 2025 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056A620487E;
	Sun,  8 Jun 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQJQUcUi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB61F12FB
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Jun 2025 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749384845; cv=none; b=MHF1p+CkYEDr5mtjtaRQh8G4c4XnRFwyqFElzCzS8Gwy4Csk7YmCeDl9xsxc/BXsWqkitRTGVYMbfwr0zjq9gaBSvIijWYIZXfSF9clMeV9s3VMs0bzUTDA1lTfWzf0jZd3jS363ti+U0v3WJEy3I0U9da3PZIs/vgy3KCArsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749384845; c=relaxed/simple;
	bh=oVuRnXNqj89eT9fDXrnTTRsoIsCkWPZ0ygTWAyPcnao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDIVlw8Vnz1KYkkeHg2dF8Y55aXvd/bGPYWJouvfbUPbZXpssxlc9SbokZmTE1/vba4wqIR4AkQV8vE9kVwJ0wIyzb3kcmYQU1FFo5BHwH0o83v3fZn5fp2jDzORW9qXsg6EQGJvencSl4+0IVNWxCF+F+1PhsdxbRkjJvUqGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQJQUcUi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749384841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBaXOCUDiP13canSq8dpJc7uc2pQjYPYOxVlcevllo4=;
	b=cQJQUcUi5yOh77dyCFOTIrbDh8rKqXqeHA72B1xDaV2Ff52Cl9/9HWh3Y5t2DlMYipteus
	puWbtEuT0ByKTvohNtJ6TE8h1M05d5UFyIOas+fi12oFe8Ij1qcW75o9VGY0Pw4sXC8rLQ
	NekHBwC/Yo24PEcsZhll084000BVaw0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-3zDZJmGMNjKPICnpULVjuQ-1; Sun, 08 Jun 2025 08:14:00 -0400
X-MC-Unique: 3zDZJmGMNjKPICnpULVjuQ-1
X-Mimecast-MFC-AGG-ID: 3zDZJmGMNjKPICnpULVjuQ_1749384839
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7391d68617cso3279739b3a.0
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Jun 2025 05:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749384839; x=1749989639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBaXOCUDiP13canSq8dpJc7uc2pQjYPYOxVlcevllo4=;
        b=ryROgOz8m7PzHP2sRHogqei0Hk5hcMiHZD0Ckd1rHL9HlDylbhTQSPM5CBocskBN9p
         VXGE/Mfmr9qCaoJtDLcxgZiHVTtudq4qV2uWNKH/FdvEbiDlLseYvshp6OoeFY53qMfy
         fHZMxc3yVFv6iaQdJy8Uhd1ECLnwnJzsDXwF7etpwsiQpT86Ey1L8PJ8bR9hi1yItUA6
         NiQUZJJV3AaXZR/8kyi8uHs/jzTDn2YzUZCtuKnHjn+SE0c0zAcsDo3NkkmklnQnTCix
         QnYboxwc/As0bRGwif6oy0TqNDjZI53BrB9naE8AE0KEGhWK8pDsCUQKEZNLx2GNkcLL
         g5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFOrBvOlX1hxup8B1OVgFQzshLIibQNbzhi9G7cdekszi6V3l+BhsoQoYyrKAFip7s+IDaX5Rg1v0ZDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSb8OX2aQuuSihLMe07UjUS0I5Til1DPgGboa5b4NFbeLfMYh/
	6MAaVU2WaiaCGV2R295nACiC8ZC4jd8t4L2GeD6j0Y2oGAtQ0/t4bYMH8s4XJk4uR42R/q0z7QM
	siP6mb0CvhWAhzfIs4nHjROUOXi/Lov0Pn/I9wu1MfYGI2QzRAmfV0z5sfhJPYkku
X-Gm-Gg: ASbGnctQAU994XbOWJrA1UHUX/B3nPNwUmPPMGqEH8UxWFuIffIRBReO5GgJ3t8Lsn0
	jiQaL0sHBKU9TA83vqTSlKVbDmjokhN8eogl5gmdqk+sIwUzjNVNE/tQzQt5tKgmz5/CBNJMsxh
	O5fdcYYWyGY+aEEA71/Vy+WxMRKuA1HNL7DlUEh0+dn3+paaOrxLPYhHGTCQFWC0LAm3eEAwmI+
	Q72w1Yvpu/WZbai/ZkjueNavIevq8KMLkfxEFCzHDi9KF6kV2D8bKQVesJ0nDb5CTAxnJqkDS2h
	/PeWmI48QUyGNE0l5Dvh1CW9mzC8uTx9SQf5PnFFEkJ/yGBdgVQ+
X-Received: by 2002:a05:6a21:6da0:b0:21f:56d0:65dc with SMTP id adf61e73a8af0-21f56d06839mr3172509637.13.1749384839023;
        Sun, 08 Jun 2025 05:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpNncbX0lV7YcYVl+1NdzBR4pEAqUL4jnqrMJ+X48TmDCPeCrrHuZyreiPVFWLkGqrqhcTZg==
X-Received: by 2002:a05:6a21:6da0:b0:21f:56d0:65dc with SMTP id adf61e73a8af0-21f56d06839mr3172493637.13.1749384838645;
        Sun, 08 Jun 2025 05:13:58 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ee70090sm3712571a12.28.2025.06.08.05.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 05:13:58 -0700 (PDT)
Date: Sun, 8 Jun 2025 20:13:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/741: make cleanup to handle test
 failure properly
Message-ID: <20250608121354.krwybs6scn5ovj7w@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250604235524.26356-1-wqu@suse.com>
 <20250605171047.vl3u6j7yojbw6pfe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <dbf243a2-ac0e-437c-a308-9832f89ca274@gmx.com>
 <20250606010622.imrfexkypzq5zpm6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <c966cbd6-3016-4735-9853-91a75144e429@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c966cbd6-3016-4735-9853-91a75144e429@gmx.com>

On Fri, Jun 06, 2025 at 03:30:58PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/6 10:36, Zorro Lang 写道:
> > On Fri, Jun 06, 2025 at 07:39:56AM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/6/6 02:40, Zorro Lang 写道:
> > > > On Thu, Jun 05, 2025 at 09:25:24AM +0930, Qu Wenruo wrote:
> > > > > [BUG]
> > > > > When I was tinkering the bdev open holder parameter, it caused a bug
> > > > > that it no longer rejects mounting the underlying device of a
> > > > > device-mapper.
> > > > > 
> > > > > And the test case properly detects the regression:
> > > > > 
> > > > > generic/741 1s ... umount: /mnt/test: target is busy.
> > > > > _check_btrfs_filesystem: filesystem on /dev/mapper/test-test is inconsistent
> > > > > (see /home/adam/xfstests/results//generic/741.full for details)
> > > > > Trying to repair broken TEST_DEV file system
> > > > > _check_btrfs_filesystem: filesystem on /dev/mapper/test-scratch1 is inconsistent
> > > > > (see /home/adam/xfstests/results//generic/741.full for details)
> > > > > - output mismatch (see /home/adam/xfstests/results//generic/741.out.bad)
> > > > >       --- tests/generic/741.out	2024-04-06 08:10:44.773333344 +1030
> > > > >       +++ /home/adam/xfstests/results//generic/741.out.bad	2025-06-05 09:18:03.675049206 +0930
> > > > >       @@ -1,3 +1,2 @@
> > > > >        QA output created by 741
> > > > >       -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
> > > > >       -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
> > > > >       +rm: cannot remove '/mnt/test/extra_mnt': Device or resource busy
> > > > >       ...
> > > > >       (Run 'diff -u /home/adam/xfstests/tests/generic/741.out /home/adam/xfstests/results//generic/741.out.bad'  to see the entire diff)
> > > > > 
> > > > > The problem is, all later test will fail, because the $SCRATCH_DEV is
> > > > > still mounted at $extra_mnt:
> > > > > 
> > > > >    TEST_DEV=/dev/mapper/test-test is mounted but not on TEST_DIR=/mnt/test - aborting
> > > > >    Already mounted result:
> > > > >    /dev/mapper/test-test /mnt/test /dev/mapper/test-test /mnt/test
> > > > > 
> > > > > [CAUSE]
> > > > > The test case itself is doing two expected-to-fail mounts, but the
> > > > > cleanup function is only doing unmount once, if the mount succeeded
> > > > > unexpectedly, the $SCRATCH_DEV will be mounted at $extra_mnt forever.
> > > > > 
> > > > > [ENHANCEMENT]
> > > > > To avoid screwing up later test cases, do the $extra_mnt cleanup twice
> > > > > to handle the unexpected mount success.
> > > > > 
> > > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > > > ---
> > > > >    tests/generic/741 | 4 ++++
> > > > >    1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git a/tests/generic/741 b/tests/generic/741
> > > > > index cac7045e..c15dc434 100755
> > > > > --- a/tests/generic/741
> > > > > +++ b/tests/generic/741
> > > > > @@ -13,6 +13,10 @@ _begin_fstest auto quick volume tempfsid
> > > > >    # Override the default cleanup function.
> > > > >    _cleanup()
> > > > >    {
> > > > > +	# If by somehow the fs mounted the underlying device (twice), we have
> > > > > +	# to  make sure $extra_mnt is not mounted, or TEST_DEV can not be
> > > > > +	# unmounted for fsck.
> > > > > +	_unmount $extra_mnt &> /dev/null
> > > > 
> > > > Hmm... I'm not sure a "double" (even treble) umount is good solution for
> > > > temporary "Device or resource busy" after umount. Many other cases might
> > > > hit this problem sometimes.
> > > > Maybe we can have a helper to do a certain umount which make sure the fs
> > > > is truely umounted before returning :)
> > > 
> > > This is not about the umount after EBUSY.
> > > 
> > > The problem is, the test case itself is expecting two mounts to fail.
> > > But if the mount succeeded, it will mount twice and need to be unmounted
> > > twice.
> > > 
> > > It's to make the cleanup to match the test case's worst scenario.
> > 
> > Oh, sorry I didn't get your point. If so, how about _fail the case directly if
> > the first mount (which should be failed) passed, e.g.
> > 
> >    diff --git a/tests/generic/741 b/tests/generic/741
> >    index cac7045eb..5538b3a1b 100755
> >    --- a/tests/generic/741
> >    +++ b/tests/generic/741
> >    @@ -44,6 +44,9 @@ mkdir -p $extra_mnt
> >     # Filters alter the return code of the mount.
> >     _mount $SCRATCH_DEV $extra_mnt 2>&1 | \
> >                            _filter_testdir_and_scratch | _filter_error_mount
> >    +if [ ${PIPESTATUS[0]} -eq 0 ];then
> >    +       _fail "Unexpected mount pass"
> >    +fi
> > 
> > Anyway, I can't say which way is better, both are good to me, depends on your
> > choice :)
> 
> I thought it was recommended to let the test continue and rely on the golden
> output to detect errors.
> 
> I'm fine either way. This is only triggered because I did cause a regression
> during my development.
> 
> There is no real world hit (yet), so it's not that urgent.

OK, this patch is good to me:

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > >    	_unmount $extra_mnt &> /dev/null
> > > > >    	rm -rf $extra_mnt
> > > > >    	_unmount_flakey
> > > > > -- 
> > > > > 2.49.0
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > 
> > 
> 
> 


