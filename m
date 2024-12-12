Return-Path: <linux-btrfs+bounces-10276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8369EDDA9
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 03:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C1F1884891
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 02:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD1313B288;
	Thu, 12 Dec 2024 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wW44TnBP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359733CFC
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970668; cv=none; b=KQRFVxNO5uv4YggKt2NsXe5Hjw/1NdepTvLCBpo5W+pm3Pcv0wjW0z9kwD/vhY4oqj+bCl9UNtBMiG/0w/0CD+6OXGoxx4308wsfimAfJHUNg8J+O1ERIxfZ7Erd8Ya5ewVOoQ3NrmU4umIl5cdQf8NbH7acvBvlJx+T5SNoOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970668; c=relaxed/simple;
	bh=L1BVMb1C/FS7GoiWz8CxjSZNukhHSQUput/cvQVf64E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/9qnxuq/B4l1GVw90YyKIk7zflK8XiFsPGMMuBk+5wbcAadxyoNwUMIJVrW5OjhCYXxhj+Cp7ppXV/d/auRUq/gVS5E2xV/fybxHgHrSWHX5JesrjC48HsJ9KUrFvySSs0NdBSAuGRH8n/QLfwh+INxDatUkFS9CDGxipHrP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wW44TnBP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72739105e02so158032b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 18:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733970666; x=1734575466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYXR2B2j1+gf6sNrF7M5invgEFBbpf0YZ82gTY7L5us=;
        b=wW44TnBPdIyKNNiV8WCYJDltsQzu6u2INdlWsl/su2Bb07ihN85gkjFUE4PrrHqYr2
         8MsToJiRH/uIuzx6kisVq7CbZXGlMdtZNQmONNnenv6vhOgmal+rPReXyom8QvePbHqA
         5rScRe/DIm7icvfMXjJqHSUCd2JDW7oosUwMmgCNFXsHHgiOPyWcarnXVGzx+xEEVpy7
         N8EDrZj+888AkRAqtFxqo+kOOB1STuTyeB64O+lP7VPtp/q9RG/+cvtr1apRTfjP2PGO
         sjpo1QvzAzAE7OVFc2dv4BpiGAO6aF3P86+pHuavY4Zl8A48sCF/7DvDDWEULS2ur+xK
         /XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970666; x=1734575466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYXR2B2j1+gf6sNrF7M5invgEFBbpf0YZ82gTY7L5us=;
        b=c2u2CV7fC5Z9Sjf949K2ZU9n/QulrntG2dCUs+mABpX1a7csnhcwL6vWTcHvEFZCgc
         UI4r3XKam00xYkgOduAlgdIhkTqcnYdjAlOjjSh8TUUCCPY2gX+XOKGYIQ16wKuQ9bdw
         ZekEKoId3346OlJ0lsgsJ8zASAhuT4uBnmQ+ImJV75qI9V8myJfxzG+fxmzOTzR5SYxw
         L0xvELLwNl3IFpFIyEk5HQjphSWIm9xX00b5+Wjbbp8mA1rdI1NZ2gD9BUlXFHufkDi3
         nnih3W2Zf2MBuBqCoYhr+TkLPIivfDqLbZP8y2FdbvZldcN+Pafulgv02PltNJcYsK+6
         UXHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqcOYuycLD5uu7TUDIeIVwBXuG1J2YPQ5PeskgqUq8kxmI5cBeewCzXdhNhXP+a9wEoFzb1m80Mu9h4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6d0ty4+4s8IPaZqwpfJB2k6zVVPSkHhU/FBs3U6upU9DTWG6
	a5vZe5b4U1HVWIKZ0X+Bc+9GIRxZoSk+6pxmF9/J5cwwWhSr3jyRY6aa2bOBBv1KmL1GP6l5bFA
	/
X-Gm-Gg: ASbGncs2phuXe3f8y702mkXe37ynjVJDgCtlwZ7a6UO3nVkyYUnz1dhdcIkaFijLuKI
	wVOGgR50fA6HiortLGEbEedu7Sv1xZRL1pvb8gfY13hF6M4Dwhr1FSq6QutPLvZiCFo/DIv704V
	ZMkfl/mbLiV30ZcszSIa3ICyidsXA77kZHw/lbpanN4RLKmpSIB+NtcrV5zjfWvtolysh46KEzM
	AsaW74NylF11xkQWKqY3qQYwZA8lBLnjR607iCcV3fvxHtWGdtpqt68qxgBEV0S6zMFACu2SIHV
	XkBnZBLacyrwEuVHz54fSmJpIbXwhw==
X-Google-Smtp-Source: AGHT+IFmE6fIbUK6tb9WC2d5dwwoPe/m0dx75q5uvLxSBOmGEh+xNmpX1coZJV5HjHsKqkJ3yyKawQ==
X-Received: by 2002:a05:6a20:6a25:b0:1e1:bdae:e045 with SMTP id adf61e73a8af0-1e1ceaed5f0mr2296464637.23.1733970666099;
        Wed, 11 Dec 2024 18:31:06 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ef484c1fsm5955828b3a.75.2024.12.11.18.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:31:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLYyk-00000009dWd-3KfF;
	Thu, 12 Dec 2024 13:31:02 +1100
Date: Thu, 12 Dec 2024 13:31:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	dchinner@redhat.com, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: fix argument passing to _run_fsstress and
 _run_fsstress_bg
Message-ID: <Z1pK5j6A5aJJdilC@dread.disaster.area>
References: <51ccb57553e069946bec983ded52a75640d4fef5.1733851879.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ccb57553e069946bec983ded52a75640d4fef5.1733851879.git.fdmanana@suse.com>

On Tue, Dec 10, 2024 at 05:32:54PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After commit 8973af00ec21 ("fstests: cleanup fsstress process management")
> test cases btrfs/007 and btrfs/284 started to fail. For example:
> 
>   $ ./check btrfs/007
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 SMP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
>   MKFS_OPTIONS  -- /dev/sdc
>   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>   btrfs/007 1s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad)
>       --- tests/btrfs/007.out	2020-06-10 19:29:03.810518987 +0100
>       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad	2024-12-10 16:09:56.345937619 +0000
>       @@ -1,3 +1,4 @@
>        QA output created by 007
>        *** test send / receive
>       -*** done
>       +failed: '2097152000 200'
>       +(see /home/fdmanana/git/hub/xfstests/results//btrfs/007.full for details)
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/007.out /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad'  to see the entire diff)
>   Ran: btrfs/007
> 
> The problem comes from _run_fsstress and _run_fsstress_bg using $*, which
> splits the string argument for the -x command used by btrfs/007, so that
> fsstress gets the argument for -x as simply:
> 
>    "btrfs"
> 
> Instead of:
> 
>    "btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base"
> 
> Fix this by using "$@" instead of $*.
> 
> Fixes: 8973af00ec21 ("fstests: cleanup fsstress process management")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 1b2e4508..f4fff59b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -78,13 +78,13 @@ _kill_fsstress()
>  _run_fsstress_bg()
>  {
>  	cp -f $FSSTRESS_PROG $_FSSTRESS_PROG
> -	$_FSSTRESS_PROG $FSSTRESS_AVOID $* >> $seqres.full 2>&1 &
> +	$_FSSTRESS_PROG $FSSTRESS_AVOID "$@" >> $seqres.full 2>&1 &
>  	_FSSTRESS_PID=$!
>  }
>  
>  _run_fsstress()
>  {
> -	_run_fsstress_bg $*
> +	_run_fsstress_bg "$@"
>  	_wait_for_fsstress
>  	return $?
>  }

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com

