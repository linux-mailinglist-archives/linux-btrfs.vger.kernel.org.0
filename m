Return-Path: <linux-btrfs+bounces-14517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C840ACFA97
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 03:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C50174963
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 01:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05D2629F;
	Fri,  6 Jun 2025 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tt9mH5Ka"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803CCA6B
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749172003; cv=none; b=bb23wRZT7/9JJvKQPiTc0wCk7HPFKouypNrcgENWPVD+moxet3EbScwQZGLmaRJICgSDyEXz1WlKdn10PIdsh3XeReCx4cvD8qqhzn4ex8ZsXLc92JC/iFHDmPR1vS0H+dzY+4Okmfek+lz9MfBb82/STVb9BWJ2EgkiHyGY5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749172003; c=relaxed/simple;
	bh=WHiRYQVzpF/lN2vRCzWbGZycny0BE1b7Qf7hG/Pz0lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFltbG4PFPA2qocrif60YvOS/cAWcv19D4e6Ts2lilmqiLybwf0oBrZDIo3X93HXRyzHIHK8jFk8S5dfzjSZxSARS5JgehJ8veWJgqbH2/BYfuPqiIo4lzFRFy+dmi2DUMhdN2T5vNkRKKB5qi1cM1r2A3a2EUlqRfRp+3ZThz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tt9mH5Ka; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749172000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMqwuMMmnYZ789XHUBu0zSaDdKty5JzMfz62cv6P90Q=;
	b=Tt9mH5Ka6CRAh61uMgwEL0XB/MXxSOy20xmAUYBDDfkvJ5LU7o+5soOz88aIzlLKOWJkmV
	PWMSeuJoHH0lNejOF57qoJVXTxj78IOawfjTeRvspAzBSOWdNDGIBTcByNjzZd8NaE43AJ
	hjkB03T1j4CWYD/DXdw72ZZ/NZgjxLY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-5zKPyLCaMe2W1x6rUcVFmg-1; Thu, 05 Jun 2025 21:06:39 -0400
X-MC-Unique: 5zKPyLCaMe2W1x6rUcVFmg-1
X-Mimecast-MFC-AGG-ID: 5zKPyLCaMe2W1x6rUcVFmg_1749171999
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6face1d593bso26654936d6.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 18:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749171998; x=1749776798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMqwuMMmnYZ789XHUBu0zSaDdKty5JzMfz62cv6P90Q=;
        b=hoqaw2u1GSXWRkCvDoG1L8/P9D5Cd6Ynif+WnMuT0il75Tv8YL2Ao9bZlYpWa8JK26
         7ehqBDK44yZlXTrSIOKh4h7Eo3/0ta1T90Tbf/lj2IPPIDLdrpgCRmknqxK86d4ZxwCu
         IrnHMLKXqQRcSArckfYNbdx6XFtp2ePqF6nPHVCNHlWaosSAfTSRS1xZoEA6h9nzJqWx
         eLuFnKo7Xds45lTsPF+aE/DBxcnrqxIyWIVZraJuMVp/Faxk7/LcS1l1YFtqqL1Ph3EL
         KzZhMEoYl/6rghf7EEvNj1CW18W/wo2+RcEcO9nZNTHMLSTVZBZrKJNnd9/VJlXmdFfh
         d4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuE9KVx+6hd3ltE9GHoUmBEQyT+rWn359FxrIAiSHfAusZLm3ewmywHfUqr4oPqKgyeeBa2JRehRzMeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQs7NkjpJ8wMExwlCM9VXIk6KQMjrDozbzjsVgc9CK7qd8elFu
	ZWDgJ8gG5Pm+Vbp3NP+dGQSbkCKVH9E/pFwG5yerZO+YaCeh4Gqc9MuYDVNwXNjBwbQFmdkIKFZ
	LN8dOPsmmtKn20BT4cQM9QH+XwG0AyeH8CC69AI9vA6kD7OXULEPPRF1eErUL4JEBS1sXllrW
X-Gm-Gg: ASbGncseNWfSjQEq4np5ijKevdbB9Kg3IL14Y+Lsj+flzScnzKeWNG98rJF7aRgq5ZV
	n/pZsop7Y5Hs6HwkLW/SuQsMT3X8Me9Q3ZVf0YNuV4g51Us4vSMQS3DewnbGFZEembYdZwr2/h2
	tiX3rIRveueE0XzCQvmKSn3rjaiZEuwf8YCzRvxq+YFCMleCRmqWN+p+butL42GDjZdTtH8p00k
	OiH3WVmwlKEI0EIHvvgqp9SbwxnL6R/uMcgWkSGsWJXc5T0bkYRzkAf4RIP3RfbGGZwk73HIlhF
	W6OyuqX2NDUxnB60aXhIVr6xxNJ7K/aDMiDKiJldiVQPa3w83MCu
X-Received: by 2002:a05:6214:b6b:b0:6fa:b42b:2bd9 with SMTP id 6a1803df08f44-6fb08fe37eamr30931356d6.37.1749171998634;
        Thu, 05 Jun 2025 18:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUhlY4zDEpsR++g5fzNRPqdPHGUK1mUpVUReGtVIuRYAak2rp1JJRU3qVIYCO4Dn59JG1SPg==
X-Received: by 2002:a05:6a21:999c:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-21ee68c8addmr1690400637.20.1749171987254;
        Thu, 05 Jun 2025 18:06:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0eaa1csm260243b3a.162.2025.06.05.18.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 18:06:26 -0700 (PDT)
Date: Fri, 6 Jun 2025 09:06:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/741: make cleanup to handle test
 failure properly
Message-ID: <20250606010622.imrfexkypzq5zpm6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250604235524.26356-1-wqu@suse.com>
 <20250605171047.vl3u6j7yojbw6pfe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <dbf243a2-ac0e-437c-a308-9832f89ca274@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbf243a2-ac0e-437c-a308-9832f89ca274@gmx.com>

On Fri, Jun 06, 2025 at 07:39:56AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/6 02:40, Zorro Lang 写道:
> > On Thu, Jun 05, 2025 at 09:25:24AM +0930, Qu Wenruo wrote:
> > > [BUG]
> > > When I was tinkering the bdev open holder parameter, it caused a bug
> > > that it no longer rejects mounting the underlying device of a
> > > device-mapper.
> > > 
> > > And the test case properly detects the regression:
> > > 
> > > generic/741 1s ... umount: /mnt/test: target is busy.
> > > _check_btrfs_filesystem: filesystem on /dev/mapper/test-test is inconsistent
> > > (see /home/adam/xfstests/results//generic/741.full for details)
> > > Trying to repair broken TEST_DEV file system
> > > _check_btrfs_filesystem: filesystem on /dev/mapper/test-scratch1 is inconsistent
> > > (see /home/adam/xfstests/results//generic/741.full for details)
> > > - output mismatch (see /home/adam/xfstests/results//generic/741.out.bad)
> > >      --- tests/generic/741.out	2024-04-06 08:10:44.773333344 +1030
> > >      +++ /home/adam/xfstests/results//generic/741.out.bad	2025-06-05 09:18:03.675049206 +0930
> > >      @@ -1,3 +1,2 @@
> > >       QA output created by 741
> > >      -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
> > >      -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
> > >      +rm: cannot remove '/mnt/test/extra_mnt': Device or resource busy
> > >      ...
> > >      (Run 'diff -u /home/adam/xfstests/tests/generic/741.out /home/adam/xfstests/results//generic/741.out.bad'  to see the entire diff)
> > > 
> > > The problem is, all later test will fail, because the $SCRATCH_DEV is
> > > still mounted at $extra_mnt:
> > > 
> > >   TEST_DEV=/dev/mapper/test-test is mounted but not on TEST_DIR=/mnt/test - aborting
> > >   Already mounted result:
> > >   /dev/mapper/test-test /mnt/test /dev/mapper/test-test /mnt/test
> > > 
> > > [CAUSE]
> > > The test case itself is doing two expected-to-fail mounts, but the
> > > cleanup function is only doing unmount once, if the mount succeeded
> > > unexpectedly, the $SCRATCH_DEV will be mounted at $extra_mnt forever.
> > > 
> > > [ENHANCEMENT]
> > > To avoid screwing up later test cases, do the $extra_mnt cleanup twice
> > > to handle the unexpected mount success.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/generic/741 | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/tests/generic/741 b/tests/generic/741
> > > index cac7045e..c15dc434 100755
> > > --- a/tests/generic/741
> > > +++ b/tests/generic/741
> > > @@ -13,6 +13,10 @@ _begin_fstest auto quick volume tempfsid
> > >   # Override the default cleanup function.
> > >   _cleanup()
> > >   {
> > > +	# If by somehow the fs mounted the underlying device (twice), we have
> > > +	# to  make sure $extra_mnt is not mounted, or TEST_DEV can not be
> > > +	# unmounted for fsck.
> > > +	_unmount $extra_mnt &> /dev/null
> > 
> > Hmm... I'm not sure a "double" (even treble) umount is good solution for
> > temporary "Device or resource busy" after umount. Many other cases might
> > hit this problem sometimes.
> > Maybe we can have a helper to do a certain umount which make sure the fs
> > is truely umounted before returning :)
> 
> This is not about the umount after EBUSY.
> 
> The problem is, the test case itself is expecting two mounts to fail.
> But if the mount succeeded, it will mount twice and need to be unmounted
> twice.
> 
> It's to make the cleanup to match the test case's worst scenario.

Oh, sorry I didn't get your point. If so, how about _fail the case directly if
the first mount (which should be failed) passed, e.g.

  diff --git a/tests/generic/741 b/tests/generic/741
  index cac7045eb..5538b3a1b 100755
  --- a/tests/generic/741
  +++ b/tests/generic/741
  @@ -44,6 +44,9 @@ mkdir -p $extra_mnt
   # Filters alter the return code of the mount.
   _mount $SCRATCH_DEV $extra_mnt 2>&1 | \
                          _filter_testdir_and_scratch | _filter_error_mount
  +if [ ${PIPESTATUS[0]} -eq 0 ];then
  +       _fail "Unexpected mount pass"
  +fi

Anyway, I can't say which way is better, both are good to me, depends on your
choice :)

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Zorro
> > 
> > >   	_unmount $extra_mnt &> /dev/null
> > >   	rm -rf $extra_mnt
> > >   	_unmount_flakey
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > 
> > 
> 


