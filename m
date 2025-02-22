Return-Path: <linux-btrfs+bounces-11712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918A6A40668
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 09:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8BD1700C3
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62D62063FE;
	Sat, 22 Feb 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuQKvqs7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62032063EE
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Feb 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213484; cv=none; b=HT2akOi9iJ4zkMVS/PM+Y1oEYxCy3MYS9bwVpLnGh6o5A1fJyYB2MowNYMN33kX2VCT1OIGhUnuagf5tu1q7IljT2ZihkH4FPvWKqrqBDiS12U/MihzZ+l56G4yr3yYn+MUascaVYQWxCjzC/aJgCWSjueq57TL71Pi/cieIvB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213484; c=relaxed/simple;
	bh=gKIikp1nkeutP68ypumD/wQtsQN6cnIA2YiRX2ZrJqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbLwYM/SS9ErghvAlh/jQUDyUvfcIbLA3nHOxMpyFTmUBdAv3kYPq7Y8T1kBe008CMoJAT5yyKEloQG5nKRAPwQ8DIujrsu9IqKQQ4Snyy/J46hPkJ0O8Rz1iw9/TCdgPYSylxymROuDR0ige+c+RE+52J/KRF2kGfo9i9oPlZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuQKvqs7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740213480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywvo3iVMwT805pw8Dw72ePN9++qcn0USaUPpo0W9c9I=;
	b=iuQKvqs7EsGKZQktNk7qJSEPOOmpfgdgBSef6dAahEjqYuy2c4JJdok7py7UngbkFjudFk
	te12PmvsOrU3d2hSkiUfC/bkr9A7bmOTo2eSPA1RU8ruxL5JiFClSBTwazdf9Cd3auL7GH
	KdrljiLWO9CLdEE9XdkQ3kDWdNFAtw4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ZboF7_JeOFmMXSW1T-2eSw-1; Sat, 22 Feb 2025 03:37:58 -0500
X-MC-Unique: ZboF7_JeOFmMXSW1T-2eSw-1
X-Mimecast-MFC-AGG-ID: ZboF7_JeOFmMXSW1T-2eSw_1740213478
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc46431885so9473103a91.2
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Feb 2025 00:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740213478; x=1740818278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywvo3iVMwT805pw8Dw72ePN9++qcn0USaUPpo0W9c9I=;
        b=GzKxZFHP0ncKKqVOS/upWEqvPMEAo2ddV+9jP1rS3JCYdm0HtWyLsoOixUOkxv0PUz
         8zDPlW3bUAtyQKenpZYnV1jZRZ+sfD/lQp3d5ZhuXgEZDCYcctea10yTtenQYY989F9q
         itMN7B3otVDa8lRO89lRUAfNXs6H20AsGbsuxGju+EeO0mjNydgtln/zM8jqD+WG+Qc8
         NhkpwbR5OR1ZEBvsCHvBwmy5+efl8L1eL8ahVmFxlAeV2hP+J0J8vnbWlLhOn5qQzyjO
         i2XRfhUgbuAySyRM7zDpbMYxp+8D8j6/mmIIeL1yj0rylhvGlz3lt5Qhzy03OZbgVd+R
         s1ng==
X-Forwarded-Encrypted: i=1; AJvYcCVqdoOWkwXlmMyutaWYF2Vow5m658iQ4gFiWWSQzmIR8Udo+C7D8wDHpd4TA/ddDOhxYscW8Ku4EN6M2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+ZbtARMNePgHQChbCdGIO3/Zobj42DSvSvLzwuKkMVItaJpO
	kC5nKdRvIpwtNOs7t9FiklQ1lSRHER+mA76tnrqZCBsIZWYMJrEGgvpgt35Mv1rlvLSX+b1JKNa
	zQSOIpnLRhkeoInvOKDe+N7us20ECpZcx8fAxcUZT97dfaosBGy8mPHh56PGv
X-Gm-Gg: ASbGncvgbGfipt2HZ7lu0hHchcxGsWF6lBZeBGIe2vWYQ2JtmTH45L2T4d3hLCwKqtO
	AiHpFO826npt9Mb0A+TLKo7DcVLhogLvWb9FBYdDSGPfQwcGPFpsdwuIpvpQvzkNJnQi/z3NufF
	C2Llr3CFmPkUxSt0mcYiHCfspCK8ttRLItLCz+lcNYIL3qn8zIBqVPNIWrPcpbpuKyXDDCykjWM
	CLmNqiRRQcLV+0umCvhl3VA2CHWkor/3Fl4+KaC64e4raF3NxNMvCRnV/1q4v6p9WMzTF6GdtTs
	lzFaHMu9vKgqVpqbpfJqzH3xUzVndD6B0NEaUnWG7cA/pQCU/AJtjjTN
X-Received: by 2002:a05:6a00:13a4:b0:730:8768:76d1 with SMTP id d2e1a72fcca58-73426d815ccmr10663210b3a.19.1740213477692;
        Sat, 22 Feb 2025 00:37:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIHnCmIVk5lXxDmvm0NE0c2IZpd4cv0ovJ3p6kbDJr3zaOF9kjL7wlqzpzzQLJkJwekp9+ZA==
X-Received: by 2002:a05:6a00:13a4:b0:730:8768:76d1 with SMTP id d2e1a72fcca58-73426d815ccmr10663193b3a.19.1740213477400;
        Sat, 22 Feb 2025 00:37:57 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73269fa358dsm13396189b3a.91.2025.02.22.00.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 00:37:57 -0800 (PST)
Date: Sat, 22 Feb 2025 16:37:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is
 enabled
Message-ID: <20250222083753.wvdw2quokicxdqoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250220145723.1526907-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220145723.1526907-1-neelx@suse.com>

On Thu, Feb 20, 2025 at 03:57:23PM +0100, Daniel Vacek wrote:
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

Take it easy, Thanks for both of you would like to help fstests to get
better :)

Firstly, SELINUX_MOUNT_OPTIONS isn't a parameter to enable or disable
SELinux test. We just use it to avoid tons of ondisk selinux lables to
mess up the testing. So mount with a specified SELINUX_MOUNT_OPTIONS
to avoid new ondisk selinux labels always be created in each file's
extended attributes field.

Secondly, I don't want to attend the argument :) Just for this patch review,
I prefer just doing:

          _scratch_mount
  -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
  +       _mount $SELINUX_MOUNT_OPTIONS ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}

or if you concern MOUNT_OPTIONS and SELINUX_MOUNT_OPTIONS both, maybe:

          _scratch_mount
  -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
  +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}

That's enough to help "_scratch_mount" and later "_mount" use same
SELINUX_MOUNT_OPTIONS, and fix the test failure you hit.

About resetting "SELINUX_MOUNT_OPTIONS", I think btrfs/314 isn't a test case
cares about SELinux labels on-disk or not. So how about don't touch it.

If you'd like to talk about if xfstests cases should test with a specified
SELINUX_MOUNT_OPTIONS mount option or not, you can send another patch to talk
about 3839d299 ("xfstests: mount xfs with a context when selinux is on").

Now let's fix this failure at first :)

Thanks,
Zorro

>  tests/btrfs/314 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> index 76dccc41..cc1a2264 100755
> --- a/tests/btrfs/314
> +++ b/tests/btrfs/314
> @@ -21,6 +21,10 @@ _cleanup()
>  
>  . ./common/filter.btrfs
>  
> +# Disable the forced SELinux context. We are fine testing the
> +# security labels with this test when SELinux is enabled.
> +SELINUX_MOUNT_OPTIONS=
> +
>  _require_scratch_dev_pool 2
>  _require_btrfs_fs_feature temp_fsid
>  
> @@ -38,7 +42,7 @@ send_receive_tempfsid()
>  	# Use first 2 devices from the SCRATCH_DEV_POOL
>  	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>  	_scratch_mount
> -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> +	_mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>  
>  	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>  	_btrfs subvolume snapshot -r ${src} ${src}/snap1
> -- 
> 2.48.1
> 
> 


