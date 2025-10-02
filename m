Return-Path: <linux-btrfs+bounces-17332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C8BBB2A6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 08:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4197D7B0504
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 06:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF32A2C029B;
	Thu,  2 Oct 2025 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USlOnJl1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8DB2BDC0A
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759388300; cv=none; b=UaIyXpvE4TNoW/SXw51EtqOockAHfWIW8POYMPjhmCEWM0cDFnjlFNQSnED6Mm066BucqJKOD4txhW/VzhP2pZpbWww/mtLk+G0FlpQtCWur9ZAHT5ohP+2lZWNta57IbRuHzDl7NUO9o2vzX01S0cIouTr50hYL7HLlsWIKdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759388300; c=relaxed/simple;
	bh=Mbay8p6OAxhIy4VBUB0Llxal02RTAw3uLQbas9/xcbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAcSDzcR04LKUOlPXBGj5ujSNdGul8JwzMvpTj6Ej0uF4dcLfN4r7CWWiNIDxEmaYWPI2VcF+SAwSBM+Myx3D6aIbdpQAeIiKVu4ddCpj5RBxZgtL4TwDSW9daakLKxejgL6vd2gszBItGa/FAUFUUf2ZRLs8/xgFOdOy8QyBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USlOnJl1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759388296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp3VaLXBhBf7B6czUgI06vrP6mixrXVc+Bnb0mXPHoo=;
	b=USlOnJl1GZYZvQV23pqVSVI3h7UCsRn/rVpNgyYMVJTcpMU/gq5GSFfu1xlJxN/NGrN/uB
	nB6h/3b2Tljlc0zIl5LhaJTECU09SoVxmqclTgKeV/GholvCusCUMUrxa2B/G+Z1x+LTNG
	bzGW2UREAekq+t/W4EiWESbT+Kppiew=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-78vD1mCEMqOhOdVg2HJbTw-1; Thu, 02 Oct 2025 02:58:15 -0400
X-MC-Unique: 78vD1mCEMqOhOdVg2HJbTw-1
X-Mimecast-MFC-AGG-ID: 78vD1mCEMqOhOdVg2HJbTw_1759388294
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-783604212ebso1443782b3a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 23:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759388294; x=1759993094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp3VaLXBhBf7B6czUgI06vrP6mixrXVc+Bnb0mXPHoo=;
        b=l7xeglt1/QaRRoZsjhXwEJnTZZyLPVNmzYq+O6ul52o3xdgp8Ct/0E/SxBlhXxWbXa
         LQDGONOnVKa2fjI8A0n/yXRJpO9Dvyp5sRRwpDZePvb4qmHy9nVOKxSAaH+IxU5x7G4B
         BblwABrpOazKbHF2b4XxXG3wZczZth+wfIbZDlRFWZ1Kcg2TLVZ0DodbrzOMtrTeqcwO
         0HSx86uHTOHF7UP1+dJFIKlHoCde970Y8hfByl/If5Ou8OXy/wWBruiKmrFeDkRKNhEU
         z3eQRubApYj/vM4927vMCpTXk1oLm1MFIE9pwZeFRrQYjTaXExdtZRwTK+8qtgyL4Yv4
         /n0A==
X-Gm-Message-State: AOJu0YwfCl4rESqqtfB9bXZd7hlGX/9L895AMMtMsve0zhY86G280tst
	TQYkrQFAiX+p3N2fSC8bSRkwM5Iw58FBle3CeLWOdAWlx0u9GVT8WYF0WmRU/VGDbG5mv99VIgh
	B/6UF24itcf5bXarM6c0+rWdcQHjqrygiVyXCVZ/onpbbA3e+TopQxzF3szKM/iSrsgbwA6y/
X-Gm-Gg: ASbGncsOH9EoOs4SNYslYuWkG1OwnR30dNSos1R0L5sV6cATcBSZJ4BLkq67trARN6H
	QgLTA6qlRakX1SvHftxQB9aEByZOGqlE6JdpFF1abQNV4ZS8+CtEzbIvWkSjmkRtTzv6G/2NSEN
	McKHFLdoSe3z4ooedbQPiIwYgSH5WgFIibTgUdAET2oZ87bEjoE1rVcLVLBYER92JHJ4Gy9IJ44
	AleM8qxzgI0NTHN5dgkPLja4xdJQcn3xYDZGUv7Sw00//8ku7EIuj/gmaYVHLJ8d8A1kLBVTs3C
	/Fh4M/vTgEdMekgG7B4cTm5lWAbJdCX5cM9H6mECl6u9/wTrvSZTx7zZOcn55BIb2bo1a7xPhrW
	DYC+xda7W9w==
X-Received: by 2002:a05:6a00:1893:b0:781:2624:ed5c with SMTP id d2e1a72fcca58-78af417f373mr7372645b3a.26.1759388293707;
        Wed, 01 Oct 2025 23:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5ImDArdMdVNl0+p2Gw3C2BINhKXT4NpiUZL2yMf2CS0xOzCL2dhRE5V9Gej+wlYNZO+yWNQ==
X-Received: by 2002:a05:6a00:1893:b0:781:2624:ed5c with SMTP id d2e1a72fcca58-78af417f373mr7372616b3a.26.1759388293122;
        Wed, 01 Oct 2025 23:58:13 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb1902sm1527258b3a.31.2025.10.01.23.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 23:58:12 -0700 (PDT)
Date: Thu, 2 Oct 2025 14:58:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs/012 btrfs/136: skip the test if ext*
 doesn't support the block size
Message-ID: <20251002065808.6cxusfy72larui34@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251002005648.47021-1-wqu@suse.com>
 <20251002005648.47021-2-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002005648.47021-2-wqu@suse.com>

On Thu, Oct 02, 2025 at 10:26:46AM +0930, Qu Wenruo wrote:
> [FALSE ALERT]
> When testing btrfs bs > ps support, the test cases btrfs/012 and
> btrfs/136 fail like the following:
> 
>  FSTYP         -- btrfs
>  PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #285 SMP PREEMPT_DYNAMIC Mon Sep 15 14:40:01 ACST 2025
>  MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
>  MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
>  btrfs/012       [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/012.out.bad)
>      --- tests/btrfs/012.out	2024-07-17 16:27:18.790000343 +0930
>      +++ /home/adam/xfstests/results//btrfs/012.out.bad	2025-09-15 16:32:55.185922173 +0930
>      @@ -1,7 +1,11 @@
>       QA output created by 012
>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
>      +       dmesg(1) may have more information after failed mount system call.
>      +mkdir: cannot create directory '/mnt/scratch/stressdir': File exists
>      +umount: /mnt/scratch: not mounted.
>       Checking converted btrfs against the original one:
>      -OK
>      ...
>      (Run 'diff -u /home/adam/xfstests/tests/btrfs/012.out /home/adam/xfstests/results//btrfs/012.out.bad'  to see the entire diff)
> 
>  btrfs/136 3s ... - output mismatch (see /home/adam/xfstests/results//btrfs/136.out.bad)
>      --- tests/btrfs/136.out	2022-05-11 11:25:30.743333331 +0930
>      +++ /home/adam/xfstests/results//btrfs/136.out.bad	2025-09-19 07:00:00.395280850 +0930
>      @@ -1,2 +1,10 @@
>       QA output created by 136
>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
>      +       dmesg(1) may have more information after failed mount system call.
>      +umount: /mnt/scratch: not mounted.
>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
>      +       dmesg(1) may have more information after failed mount system call.
>      +umount: /mnt/scratch: not mounted.
>      ...
>      (Run 'diff -u /home/adam/xfstests/tests/btrfs/136.out /home/adam/xfstests/results//btrfs/136.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Currently ext* doesn't support block size larger than page size, thus
> at mkfs time it will output the following warning:
> 
>  Warning: blocksize 8192 not usable on most systems.
>  mke2fs 1.47.3 (8-Jul-2025)
>  Warning: 8192-byte blocks too big for system (max 4096), forced to continue
> 
> Furthermore at ext* mount time it will fail with the following dmesg:
> 
>  EXT4-fs (loop0): bad block size 8192
> 
> [FIX]
> Check if the mount of the newly created ext* succeeded.
> 
> If not and the block size is larger than page size, we know it's some
> block size ext* not yet supported, and skip the test case.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

This version is good to me, if there're not more review points btrfs list,
I'll merge this patchset in next release. Thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/012 | 3 +++
>  tests/btrfs/136 | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index f41d7e4e..6914fba6 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -42,6 +42,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
>  	_notrun "Could not create ext4 filesystem"
>  # Manual mount so we don't use -t btrfs or selinux context
>  mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
> +if [ $? -ne 0 -a $BLOCK_SIZE -gt $(_get_page_size) ]; then
> +	_notrun "block size $BLOCK_SIZE is not supported by ext4"
> +fi
>  
>  echo "populating the initial ext fs:" >> $seqres.full
>  mkdir "$SCRATCH_MNT/$BASENAME"
> diff --git a/tests/btrfs/136 b/tests/btrfs/136
> index 65bbcf51..fd24d3f8 100755
> --- a/tests/btrfs/136
> +++ b/tests/btrfs/136
> @@ -45,6 +45,9 @@ $MKFS_EXT4_PROG -F -t ext3 -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
>  
>  # mount and populate non-extent file
>  mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
> +if [ $? -ne 0 -a $BLOCK_SIZE -gt $(_get_page_size) ]; then
> +	_notrun "block size $BLOCK_SIZE is not supported by ext3"
> +fi
>  populate_data "$SCRATCH_MNT/ext3_ext4_data/ext3"
>  _scratch_unmount
>  
> -- 
> 2.51.0
> 
> 


