Return-Path: <linux-btrfs+bounces-11759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D138FA43A90
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 11:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACA6422F47
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6086266B5E;
	Tue, 25 Feb 2025 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCzIhT65"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3318F5E
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477380; cv=none; b=FYo3glBHn42KFkYaZqXcSt6NytNLEI8pk2gTrkdYFyNAGWi+LGIkfKD+PMfgtP1SQQMfn2V7IpqwgMXRoGfGgCCg28lF0yh3Sgex6yeWj8RnhRQAE99OHRHvDSVHC4XUrDxLTxSM7thX+VgWUvdCOJX4X+gD9Zvg14ag9/4H1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477380; c=relaxed/simple;
	bh=F7Ms5IyNWogo0LGDUGPs0GOh5EUEmq+ZYaa6ELV2U/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ectAtLc/+xLRW++d4/Q/skze68BULXibDnMwt5T0IEfE4XQE6zX8qY/34djE6J9kS2vOBkgWh4fkNaqW8o9OT3uI9PfJoE7L/yLbwEotbjvAdvQvHGzOj9vQIZc5AgE6LQbxkbHRwWVOFP2a7lggFHMbvNzunfm0fpDi61QybYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCzIhT65; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740477377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVGqo+himr0vNqUEgygAS/1M4MrwSMcnb2QDQPm3nko=;
	b=gCzIhT65qLtFPgjyDq3X4Pz7WF0L/VCyww+VGwNUDTm4CM30JLlogC4YwzP9PtacoEv5Qh
	z8PwRQ6ACzC19IVTnswhBglOQMDW0zANgnBvY4r4mc2cvwSenhyfVal29+tPYKmog5Wgr6
	7ZpZOPaQxsulCtpqXBWi0y/FMAHVdB8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-9LRcXor_NY-9GOrIoDzcLg-1; Tue, 25 Feb 2025 04:56:15 -0500
X-MC-Unique: 9LRcXor_NY-9GOrIoDzcLg-1
X-Mimecast-MFC-AGG-ID: 9LRcXor_NY-9GOrIoDzcLg_1740477374
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2210121ac27so115778765ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 01:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477374; x=1741082174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVGqo+himr0vNqUEgygAS/1M4MrwSMcnb2QDQPm3nko=;
        b=UBpfMXLQZFss9qkawj/jDTZzkLEkXWZTZb1u6QwKryFwsBrcr3Fd7VWqYug1GBxE/F
         4a5R2axDgc5S4LA3Uc45xmKw9xdTHghU1I34uy4K+AlmOFNuX6XzroUpVGnmXr4n7kQo
         8CpZmLYV+RdTIniZ0claHu6yEueuxNSQW6bbTfntxCOdsyO/NR+0uXidT1Uy/snrPDTq
         TUwrahJyi82Az5pHo/G7bqi7RtUIGUJcpytgBlTww1PV10p1Xn1grgihVXWYhks6c+8D
         5vZPY7angYk+tWaCMd4nur2m1JNFpScmq7Hdnwk9BJShJc9XMH89kc4zpoWYfXZwo16T
         Li8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMuj1RZ7LAsdJfNehHj0JUKSd/u7FhJZ8i/6xpF7WKYMW3xCHjzPwEehmgGroiYxVVtsWQoEqXT0b+og==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzohm9EKYNmXEF15C6tjNh8YytjDp7bOo+VawJNehR8UhU5GRVI
	utryp9oG4nITMvsrbVPz29hlBq+Lb+og+QuUAvutQW1Z5Q1766avIwZwVrIHs1xdV3Yh1a6+mPR
	tLGTIRnsUfSjueVorr6I9bdXauyX/1l1dv0X/npRPwjQaxHEJ2tlAjfsPVLTI
X-Gm-Gg: ASbGnctQfGaNV3tlGrrOfQoGhGN1/NoHPUwoSu5vIZD3EdvC8vR0k0X4V1BRP8Imwfu
	kz3HS3DBkGYnz5xmW2Q/Ur1Z2277cs+6Ji/lr0sEfsxcF2uKPymI0qnjrUVS0kjsHKRzFCLrboe
	92AKhNXrmsmL0XSb4vPwNHuUEOkQzgy9ehnzSzcLYVnr0nctIYbNb3nLksE8AEIz6UqUkXFcoov
	nrMcl8+2jpANsF/Y2PNocuIExJRUR30TN7bsGERDv8U4F7oGa2uzmcm8PPG+NIBVey4zbmmHgRf
	mpgdYXozsO0B9K7ADNSih41ibM8clIkZGaFN2miqHdfS0xJUJIdOME0T
X-Received: by 2002:a05:6a00:2441:b0:732:2170:b69a with SMTP id d2e1a72fcca58-73426d6fcb3mr25975338b3a.18.1740477374125;
        Tue, 25 Feb 2025 01:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgBhJn9ob4Mi17reKJgUYjpYX5Nplvab5C55kV4Ea6VfKfQJ9uUcemCsRNnoY4FLi9xgs0bw==
X-Received: by 2002:a05:6a00:2441:b0:732:2170:b69a with SMTP id d2e1a72fcca58-73426d6fcb3mr25975325b3a.18.1740477373800;
        Tue, 25 Feb 2025 01:56:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f8a7fsm1134152b3a.59.2025.02.25.01.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:56:13 -0800 (PST)
Date: Tue, 25 Feb 2025 17:56:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Daniel Vacek <neelx@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is
 enabled
Message-ID: <20250225095609.mjr2jq7l44md6p6j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

This's good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>  	_btrfs subvolume snapshot -r ${src} ${src}/snap1
> -- 
> 2.48.1
> 


