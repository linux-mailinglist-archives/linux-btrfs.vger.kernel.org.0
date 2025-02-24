Return-Path: <linux-btrfs+bounces-11748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E98B7A42FB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 23:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3374917AE7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 22:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145961EBFE6;
	Mon, 24 Feb 2025 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2gPLrVAC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B7EEA9
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2025 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434471; cv=none; b=Ms8byeVpA6siH7UV+75qTduJgwIF6oquMuTLowmnAC47UImSmgyRLpinmqnyW6xGo4ldWGYu0DWOeIX0qKsP+24Ty4b2Nze2QMRLpkgzy4Rd/H3OEdsrJ1S2e/uUDxjaHgifMHNYktsI9zUEe6egGIUYybXZyJmD6rhhL3GGuQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434471; c=relaxed/simple;
	bh=VgX6FFZPaYAj1W5FkcpaJzU///oJoaudWKP2g08Ki8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPn+CXY38KhjjeHQicwcs2/OjAww3BfF91ZTWkm8/CR1rQJT/x5a4BmTgb24jp8fDr/TG+QYy2jtfpKdieC1v9PtfBDbIvKG619nKlqS/7wQvz4pS5cT+mPo3ZTs/cZ2zdqhJmZXqMtHVL9bZt3EaWkWRxdUi+WDj2kXzwx/PP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2gPLrVAC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220c8cf98bbso17351545ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2025 14:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740434469; x=1741039269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9D/keUhUasji7B0tRadggFTdwyGKcKnAASH07BFdtc=;
        b=2gPLrVAC9/qm1lXzRfJG4SJBOj5zzlkU0x9nqGFB4LpIe9aCgfdoTFvRKj8oLnohOu
         yxc8fchTSksHepoOBAj4xqwn4pYf/UTGPlNoH4MjDcehTgI+pxPesTF9bkvUxHtIHeYE
         Uk9CU9EYIHic8sg3NTbWh2CycY+ZpuHNytuZzIqtEsmpVdC+supFVJgfbSxWXEAH/RpP
         lVJQwkSzKF+4crieJgYOL/Tazsa0Qu7OqnAJepXnAh5bf0HspnBHSVdwpycHPHpFSFem
         9XidPaZHkMRnNh/cao6ZTlR+WSjJER0y1Ln7zwLRkeJigDMJ2LRUfaaASmXC3b8NUx98
         FPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434469; x=1741039269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9D/keUhUasji7B0tRadggFTdwyGKcKnAASH07BFdtc=;
        b=nA4Eh5fdOTfmUUuufUu458IL6rve56/xruxK0TUfNCX1nqwDsVS1gUW2e0YJ6+QYeK
         lUoRpPxgg1nzkit0oqlq4x+hcqEcQI5etrixd9O2g6mGpyGrbMgrQtu0Pe4qXyxLqN1b
         DJaKaL8L3N7ERmQVS4Kq7ujnbn7LoBGmnhMnr/BoTajb+vsfZGqJnpmNBBPfpM7LkyVL
         0iGmtc8dA19dbh9XJIq2NBQBrWRhJ2Bp6S2bw/FQXMjamlSwv7Vv8rM3+A3IlEwA0VCn
         BHYGWaasIQyOyzDAjpHgCgXWa9Om3UZywUGg8CkLbQMkgpVyu77DRe3rocLZYL2wIGga
         /wcA==
X-Forwarded-Encrypted: i=1; AJvYcCW8JLAsiYsaNiHkc31pRbk6zYvl/Qla4E//QPYqZy1ueURgMopo3w6jCwuUA/AxdVJWpxA4Dye29nQoCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/Syyt16dO7x+w2CtiiA6HIqdfC/YB8o7Sh2+2XqFbdRBWPvC
	iW7Pjqkq7BeFQrLRftdVGpxWRnyuMOxY5rrp8V54xzAMF9W36BH1OTvXGrA+sjs=
X-Gm-Gg: ASbGncvllEv7C87zGMcZ7WC3IcrQKuLM8a9dtgM1RN7qMEqiDAxcaA6wR+pnYQuBH5p
	1sRATkzo2RKrHfbxO0bUA8c6Hn30OmZpF+Y5iwb5qw4SoiD9hvHulaAH3NBpRecu9HbpkB4mqMu
	X6I6CplR9giimg93Xo7uuDHrAjVzSHuxQZ/0oqRloK8AeZ43S6ymPDQk9fnCsrMHQXLuyJ5rkyG
	Ne8eVHGci40OtHgIljWC2YiUYCDsRND7dAJrecp9T5pLSXHIorz3uGhsldBvr9AbWJ0e0lkF2tS
	31KhcqNoK5zBfdS1aZcRgAGM66NF2hi3ZeFnbXq+GUWd5NHmeyAPEYNAYb/ai6b65vw=
X-Google-Smtp-Source: AGHT+IEWccSnddaSPsUtxThQTMpzKvzsvdDpESUFly2Cqopx0xSQbf+soLUQdHq9+5wEob4s9JSf9A==
X-Received: by 2002:a17:902:e890:b0:21f:1549:a55a with SMTP id d9443c01a7336-221a0ec413amr232606785ad.1.1740434469039;
        Mon, 24 Feb 2025 14:01:09 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0b0ef3sm877195ad.231.2025.02.24.14.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 14:01:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tmgVe-00000005WDK-0sH0;
	Tue, 25 Feb 2025 09:01:06 +1100
Date: Tue, 25 Feb 2025 09:01:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: Daniel Vacek <neelx@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is
 enabled
Message-ID: <Z7zsIkC4SR103m0D@dread.disaster.area>
References: <20250220145723.1526907-1-neelx@suse.com>
 <20250224111014.2276072-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224111014.2276072-1-neelx@suse.com>

On Mon, Feb 24, 2025 at 12:10:14PM +0100, Daniel Vacek wrote:
> When SELinux is enabled this test fails unable to receive a file with
> security label attribute:
> 
>     --- tests/btrfs/314.out
>     +++ results//btrfs/314.out.bad
>     @@ -17,5 +17,6 @@
>      At subvol TEST_DIR/314/tempfsid_mnt/snap1
>      Receive SCRATCH_MNT
>      At subvol snap1
>     +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
>      Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
>     -Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
>     +Recv:	d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
>     ...
> 
> Setting the security label file attribute fails due to the default mount
> option implied by fstests:
> 
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
> 
> See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")
> 
> fstests by default mount test and scratch devices with forced SELinux
> context to get rid of the additional file attributes when SELinux is
> enabled. When a test mounts additional devices from the pool, it may need
> to honor this option to keep on par. Otherwise failures may be expected.
> 
> Moreover this test is perfectly fine labeling the files so let's just
> disable the forced context for this one.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
>  tests/btrfs/314 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> index 76dccc41..29111ece 100755
> --- a/tests/btrfs/314
> +++ b/tests/btrfs/314
> @@ -38,7 +38,7 @@ send_receive_tempfsid()
>  	# Use first 2 devices from the SCRATCH_DEV_POOL
>  	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>  	_scratch_mount
> -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> +	_mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}

I note that there are several similar instances of this in common/,
either as '_mount $(_common_dev_mount_options)' or as '$MOUNT_PROG
-t $FSTYP `_common_dev_mount_options $*`'

That kinda says to me there should be a _mount_dev() wrapper,
similar to the _mkfs_dev() wrapper like this:

_mount_dev()
{
	_mount $(_common_dev_mount_options) $*
}

And all these open coded device mounts be converted to use the
wrapper. That way we don't have this problem of omitting
_common_dev_mount_options when future tests open code specific device
mounts.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

