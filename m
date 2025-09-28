Return-Path: <linux-btrfs+bounces-17240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E227ABA72B6
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 16:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E2D3BD28D
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132981BEF7E;
	Sun, 28 Sep 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoahNoal"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A4221271
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759071310; cv=none; b=cDf/SDmiXbuTAws/2xyXlbgiNx0ABKZNM4Mnf6/UHCRLu6h4YkbhFGVWAXGQP0pBe/PAyjz+CiliiG0CuViM+2Q8MdQkUK2IGjYDsUY84BfWem+2uuuohPpVeFCAOEchHWowbAh7CzMh/kzPwmPyvH8WWBLyxvZWFNuS7CL1Nuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759071310; c=relaxed/simple;
	bh=faXbKWkSCqgyuZE7zHv7M+wyMfCgrrphjB4x+XER4bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFrnm4ytnBeRuDxSHKGFg+C8wDAIgCdQ/denqEHa3e0VRozD2TeurzwWkV0li0V7T8gQO6rhr4q37yJieXlbPY/UuEn31405uDbX9/N5XmcK7Ca3VjNcgccNy4+IEj0FgqpOcrmEChHJFacDQG0j3qJ+pBVLJYUieIGmhK862Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoahNoal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759071307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VCbcP4jnuJD0yk6auspq17+0DRODrBb74tm3+Qhevr0=;
	b=WoahNoalKwuGkOmNkIAC+m/05qsGadDZWdVJae8VE474+p3qOGQPRkRWqfqViNNchokVgQ
	LKCDURHNiWMLKm0DJCVDMAQ3deWQLt+96nrnHLcixYGlanJnxmJbEr1CBir3C2fAXHNTzk
	B0CNT3LfOo9/xxMeS4QXGseLEYOscyU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-XMqGpVM3Pu67WvZn5uyrhg-1; Sun, 28 Sep 2025 10:55:05 -0400
X-MC-Unique: XMqGpVM3Pu67WvZn5uyrhg-1
X-Mimecast-MFC-AGG-ID: XMqGpVM3Pu67WvZn5uyrhg_1759071303
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befc08so7658731a91.2
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 07:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759071303; x=1759676103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCbcP4jnuJD0yk6auspq17+0DRODrBb74tm3+Qhevr0=;
        b=Sk+PNYPJ789uQp2Vgk1ObQTST0Kt/FU1QfWqKM+w31p4wam3Dba7TvNLNXrCn6+2Pf
         tXa2OVe90EeMXp2QbD3UdkelPaQl4y6eOCtn0XhU1FOfR3c1W0fqNVJWMRQXM8eZn5sM
         23YTxX7KAfLPx8RQU7YzBEyMNi2UD2t6/Qc7XUZSPXesy4RTl07qZKg6j5aQ8cUUs+4A
         5m6o/CZ+i/mHf3xd6hnFX/vMO+7OBGMjq8OgQOMTNpRTbTpkZD58yHXGVY1n99luJIGh
         AUyh2+MP7L/76XxdRN6VwlMEBbEZn8fLBDJwQGLY324Dw6VpJ89oZZEJtvxrJ481rJGk
         YODQ==
X-Gm-Message-State: AOJu0YxCzNRiJXPqFROBlU2fXeOMPqfgUex1niJvOvwvtTOyav/YCH/A
	vDJlp5a/KsOtB0oFVGIFHqE3MY+jpBF55DROLjRpieVeBsMEgAw4b9tLND2ZUrhSFnV7vOmDr0V
	2QRPfnNQfVKkgfsPN8I0XvBXyAgOeGd6cJKIVNdYES0QB2hL94v7bYJhtoyaQA1WyqzwlNGLS
X-Gm-Gg: ASbGncvkN9OWrHI4Z15jPZP98WRtep2LFMpR5UebzauwgL91DBlFxgJjVLHJmg7PE0K
	Fie0GzxDhhIDtlJ3CxYZNISKpNfGi/uAbWoi7slWuyLAOOzbTPeWhipucgXxxBV3wSqoo7BsLWm
	I1u73YjLNuLshLsROn/EhU7Y2DMVayVVG4DcAxLkgBmiu2P9ZmO3GEB3kkSCM9jAJgkR/0VOEBR
	jBnvgiB247mtYqhEMb9jy5yzD7zNn+ojiJFKfwm0BF+ykmXEFcjTAGVaWfHKra2+NnlVzlb6CW+
	4X0uR7PioJK+Aso7oE6+tTRGEL0ZPXMEaEmX2xnLz8MsAgYBuI5S4+Q9xllx2WOWyrZMkFr+QGy
	gl/hY
X-Received: by 2002:a17:902:e54d:b0:266:2e6b:f5a7 with SMTP id d9443c01a7336-27ed4a89b48mr157882745ad.58.1759071302575;
        Sun, 28 Sep 2025 07:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnZJHixwIXPjcp9HWUyz95ng9jKF9JaA/afuk6s64CuGQ4XCLUMKYvsb5zwyBW8bI1FO/YTg==
X-Received: by 2002:a17:902:e54d:b0:266:2e6b:f5a7 with SMTP id d9443c01a7336-27ed4a89b48mr157882555ad.58.1759071302079;
        Sun, 28 Sep 2025 07:55:02 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c5575350sm9022500a12.26.2025.09.28.07.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 07:55:01 -0700 (PDT)
Date: Sun, 28 Sep 2025 22:54:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs/012 btrfs/136: skip the test if ext* doesn't
 support the block size
Message-ID: <20250928145453.wyztv2kvfpgmlw3k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250918224327.12979-1-wqu@suse.com>
 <20250918224327.12979-2-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918224327.12979-2-wqu@suse.com>

On Fri, Sep 19, 2025 at 08:13:25AM +0930, Qu Wenruo wrote:
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
> If not, since the only extra parameter for mkfs is the block size, we
> know it's some block size ext* not yet supported, and skip the test
> case.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/012 | 3 +++
>  tests/btrfs/136 | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index f41d7e4e..665831b9 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -42,6 +42,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
>  	_notrun "Could not create ext4 filesystem"
>  # Manual mount so we don't use -t btrfs or selinux context
>  mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
> +if [ $? -ne 0 ]; then
> +	_notrun "block size $BLOCK_SIZE is not supported by ext4"
> +fi

Hmm... the mount failure maybe not caused by the "$BLOCK_SIZE is not supported",
I'm wondering if this _notrun might ignore real bug. How about check the
"blocksize < pagesize" at least?

>  
>  echo "populating the initial ext fs:" >> $seqres.full
>  mkdir "$SCRATCH_MNT/$BASENAME"
> diff --git a/tests/btrfs/136 b/tests/btrfs/136
> index 65bbcf51..6b4b52e4 100755
> --- a/tests/btrfs/136
> +++ b/tests/btrfs/136
> @@ -45,6 +45,9 @@ $MKFS_EXT4_PROG -F -t ext3 -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
>  
>  # mount and populate non-extent file
>  mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
> +if [ $? -ne 0 ]; then
> +	_notrun "block size $BLOCK_SIZE is not supported by ext3"
> +fi
>  populate_data "$SCRATCH_MNT/ext3_ext4_data/ext3"
>  _scratch_unmount
>  
> -- 
> 2.51.0
> 
> 


