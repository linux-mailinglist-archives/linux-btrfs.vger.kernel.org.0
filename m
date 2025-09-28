Return-Path: <linux-btrfs+bounces-17239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE7CBA7162
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 16:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8153BB31A
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ABC215F4A;
	Sun, 28 Sep 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeB6O9YO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12334BA4E
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759068779; cv=none; b=krFAeAaNP5jG0zVxwfY/rjHeTKyCcAxf+VpTmvd5dxa5ylq5q/ZnE30rW5Oz/KPGRXEhq3GY8z3JiORLY7MiuVneQriwdLtludO4F/LGY042qiJGPGaOUjeCiI8CdZeaLR2o5a0T/lwaD1msDIpGMfA54zAsk5lgztXUR96cDmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759068779; c=relaxed/simple;
	bh=kr0eoCud+NiggYCoVN6Gw1CXhAmpepeAhR6lFqY5rHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjqKqWJZCUvGJ3HWFksOB2SbyjytD8ejru3O5z8IIcMiSMf7cjTsQyS36HRTiU5NnF2MQ/5CJhlupwf96oFnrTV58V/jOjYgg/HtoWHkJw59sDxs9QcQPoYbfVtVWUJuzMs1EcysjaYs9GcC/OVITtgIf04TPsm4dRQkkNGkGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeB6O9YO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759068775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qi/rjaEucLtimn1dq1VxAoX3G7f9Ufds5B/N6AXO5hE=;
	b=VeB6O9YOCHzLBkvji6RR8c8+reniLxe8xbXqCFiR3m3CqpoO1l3LxDS7pJd9Y+Nfct6cp4
	MUp0N7s1t5K01vRLVWpuX7Ups4LrnMEC7elTVunXx0jBGkOx5JE4jgCIVHlGHlRTRdl/gW
	IL7f5TR270jFQd9Ek5UVqk9tRZZWjIY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-gwpF8Km4NUS5ZlO2QshfuQ-1; Sun, 28 Sep 2025 10:12:54 -0400
X-MC-Unique: gwpF8Km4NUS5ZlO2QshfuQ-1
X-Mimecast-MFC-AGG-ID: gwpF8Km4NUS5ZlO2QshfuQ_1759068773
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so3216421a91.1
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 07:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759068773; x=1759673573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi/rjaEucLtimn1dq1VxAoX3G7f9Ufds5B/N6AXO5hE=;
        b=LRmW6LjhTOYGoaelfW8demzGy99tUb68rH+xyVYTDbxLUAzoJZz9H+wlKfvYXjFQD5
         tP2xuovDTLDsY19e5X3k9NcRb81y8O4Rct2jeu291JlaOx37IwV5QEZ6S9AQd1qF1FkM
         b3LzfGQGZ8ANn1kLhzDY3XR0mNFfG030hdbpK2S7MFU1YSvjYaRHueqz7xBH+uvrjoZ8
         a1FPEZIVlHkKn6prc/ecO9hsQ3qqOF3+T+g8jKtYoitI5ebwFLlSrCZ9TX9JnCLoNxj3
         6TuxRwonY6OipU0TtVA2P1RkPqJ1cjRRAHsf5VlEtJBDlXGOgdz0Ihz7dfVJfD1HzKvL
         bYnQ==
X-Gm-Message-State: AOJu0Yzj2hEeDcAfOl+b1WWOB6yOki1TDiCgOo5H1LamF8k/J+fIB6PW
	FQbVHq4WIzw6Nfg6sULQCpDQQgCVg4tHeXFH3asG07Qxgtrjxfaukh0Q42aOU7QpsdUzOMBbCV0
	3W5DEtcvOq30SLc6IN7Y0bHfdx1xRHmXNNYvd2B98R+qvRlMGB++Tjhf3YAHzwsfy
X-Gm-Gg: ASbGncsvKD+w1NgVLqUPCjEoLyFhdM5Zrp7n0jBOWCaoIQlgxCJXMZNzuj2DAx4kRvf
	07l1TsfI/mFPc3qMtiSbETZkHO+/ncnxxOOYgPiNqZ3W11rGZ9/K7zikh5pIR6WAFXEkikKZf7W
	Tg0hoG/dQl/hIJItWDCWEusyFSAQ6OzQ/wBqJd92oJP/3gqxh4FFUnwX30oZz0B5pPc9wpz+EQx
	Rmr5RXHyZjVQVTwClaLkNCj4fUrIh5JlptD3SFxH2vjHskTRnRfhn6XGoFkNbmadGxDm1Ctjil7
	PIgMvSzvu/kEy+Qu9SuHS2mDgRrkF3iu8HmtI4fdDU/M/FsPwFtUSqiENZ7ORddLGtyXPrH64AD
	fdE2W
X-Received: by 2002:a17:90b:3148:b0:31e:c95a:cef8 with SMTP id 98e67ed59e1d1-3342a2e148cmr12089926a91.32.1759068772844;
        Sun, 28 Sep 2025 07:12:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/WrWJV5vC9UeUCgllL425TonGJAqVaawtt08txpJk2KKejUpzKnRPhw6pKZ3xCcrz+jj7UQ==
X-Received: by 2002:a17:90b:3148:b0:31e:c95a:cef8 with SMTP id 98e67ed59e1d1-3342a2e148cmr12089905a91.32.1759068772282;
        Sun, 28 Sep 2025 07:12:52 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3352c6e11d8sm7585193a91.17.2025.09.28.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 07:12:51 -0700 (PDT)
Date: Sun, 28 Sep 2025 22:12:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs/192 btrfs/30[456]: explicitly specify block
 size to avoid false alerts
Message-ID: <20250928141248.jo6tklfl6riomfgu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250918224327.12979-1-wqu@suse.com>
 <20250918224327.12979-3-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918224327.12979-3-wqu@suse.com>

On Fri, Sep 19, 2025 at 08:13:26AM +0930, Qu Wenruo wrote:
> [BUG]
> When running the experimental block size > page support, the test cases
> btrfs/192 and btrfs/30[456] fail with the following error:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMPT_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
> MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> btrfs/192 436s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/192.out.bad)
>     --- tests/btrfs/192.out	2022-05-11 11:25:30.746666664 +0930
>     +++ /home/adam/xfstests/results//btrfs/192.out.bad	2025-09-18 18:34:10.511152624 +0930
>     @@ -1,2 +1,2 @@
>      QA output created by 192
>     -Silence is golden
>     +ERROR: illegal nodesize 4096 (smaller than 8192)
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/192.out /home/adam/xfstests/results//btrfs/192.out.bad'  to see the entire diff)
> 
> btrfs/304 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/304.out.bad)
>     --- tests/btrfs/304.out	2024-07-15 16:17:42.639999997 +0930
>     +++ /home/adam/xfstests/results//btrfs/304.out.bad	2025-09-18 18:44:13.761000000 +0930
>     @@ -10,7 +10,7 @@
>      leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
>      fs uuid <UUID>
>      chunk uuid <UUID>
>     -	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>     +	item 0 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
>      			stripe 0 devid 1 physical XXXXXXXXX
>      total bytes XXXXXXXX
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/304.out /home/adam/xfstests/results//btrfs/304.out.bad'  to see the entire diff)
> 
> btrfs/305 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/305.out.bad)
>     --- tests/btrfs/305.out	2024-07-15 16:17:42.639999997 +0930
>     +++ /home/adam/xfstests/results//btrfs/305.out.bad	2025-09-18 18:44:14.914196231 +0930
>     @@ -12,11 +12,9 @@
>      leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
>      fs uuid <UUID>
>      chunk uuid <UUID>
>     -	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
>     +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>      			stripe 0 devid 1 physical XXXXXXXXX
>     -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/305.out /home/adam/xfstests/results//btrfs/305.out.bad'  to see the entire diff)
> 
> btrfs/306 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/306.out.bad)
>     --- tests/btrfs/306.out	2024-07-15 16:17:42.639999997 +0930
>     +++ /home/adam/xfstests/results//btrfs/306.out.bad	2025-09-18 18:44:16.075000000 +0930
>     @@ -14,7 +14,7 @@
>      chunk uuid <UUID>
>      	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>      			stripe 0 devid 1 physical XXXXXXXXX
>     -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>     +	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
>      			stripe 0 devid 2 physical XXXXXXXXX
>      total bytes XXXXXXXX
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/306.out /home/adam/xfstests/results//btrfs/306.out.bad'  to see the entire diff)
> 
> Please note that, btrfs bs > ps is still under development.
> This is only an early run to expose false alerts.
> 
> [CAUSE]
> The test case btrfs/192 requires 4K nodesize to bump up tree size, and
> btrfs/30[456] all requires 4K block size as the workload is designed
> with that.
> 
> However if the QA runner is specify other block size (8K in this case),
> it will break the 4K block size assumption of those tests, either
> results mkfs failure in btrfs/192, or output difference for
> btrfs/30[456].
> 
> [FIX]
> Just explicitly specify the 4K block size during mkfs.
> 
> And since we're here, remove the out-of-date page size check, as btrfs
> has subpage block size support for a while.
> Instead use a more accurate supported sector size check, this allows the
> test to be run on aarch64 with 64K page size.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Makes sense to me, welcome more review points from btrfs list.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/192 | 8 ++------
>  tests/btrfs/304 | 5 ++---
>  tests/btrfs/305 | 5 ++---
>  tests/btrfs/306 | 5 ++---
>  4 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> index 0a8ab2c1..56ec2b28 100755
> --- a/tests/btrfs/192
> +++ b/tests/btrfs/192
> @@ -33,11 +33,7 @@ _require_btrfs_mkfs_feature "no-holes"
>  _require_log_writes
>  _require_scratch
>  _require_attrs
> -
> -# We require a 4K nodesize to ensure the test isn't too slow
> -if [ $(_get_page_size) -ne 4096 ]; then
> -	_notrun "This test doesn't support non-4K page size yet"
> -fi
> +_require_btrfs_support_sectorsize 4096
>  
>  runtime=30
>  nr_cpus=$("$here/src/feature" -o)
> @@ -55,7 +51,7 @@ $BLKDISCARD_PROG $LOGWRITES_DMDEV > /dev/null 2>&1
>  # Use no-holes to avoid warnings of missing file extent items (expected
>  # for holes due to mix of buffered and direct IO writes).
>  # And use 4K nodesize to bump tree height.
> -_log_writes_mkfs -O no-holes -n 4k >> $seqres.full
> +_log_writes_mkfs -O no-holes -n 4k -s 4k >> $seqres.full
>  _log_writes_mount
>  
>  $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/src > /dev/null
> diff --git a/tests/btrfs/304 b/tests/btrfs/304
> index b7ed66af..18f73590 100755
> --- a/tests/btrfs/304
> +++ b/tests/btrfs/304
> @@ -20,8 +20,7 @@ _require_btrfs_fs_feature "raid_stripe_tree"
>  _require_btrfs_fs_feature "free_space_tree"
>  _require_btrfs_free_space_tree
>  _require_btrfs_no_compress
> -
> -test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
> +_require_btrfs_support_sectorsize 4096
>  
>  test_4k_write()
>  {
> @@ -31,7 +30,7 @@ test_4k_write()
>  	_scratch_dev_pool_get $ndevs
>  
>  	echo "==== Testing $profile ===="
> -	_scratch_pool_mkfs -d $profile -m $profile -O raid-stripe-tree
> +	_scratch_pool_mkfs -s 4k -d $profile -m $profile -O raid-stripe-tree
>  	_scratch_mount
>  
>  	$XFS_IO_PROG -fc "pwrite 0 4k" "$SCRATCH_MNT/foo" | _filter_xfs_io
> diff --git a/tests/btrfs/305 b/tests/btrfs/305
> index ad060853..45747627 100755
> --- a/tests/btrfs/305
> +++ b/tests/btrfs/305
> @@ -21,8 +21,7 @@ _require_btrfs_fs_feature "raid_stripe_tree"
>  _require_btrfs_fs_feature "free_space_tree"
>  _require_btrfs_free_space_tree
>  _require_btrfs_no_compress
> -
> -test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
> +_require_btrfs_support_sectorsize 4096
>  
>  test_8k_new_stripe()
>  {
> @@ -32,7 +31,7 @@ test_8k_new_stripe()
>  	_scratch_dev_pool_get $ndevs
>  
>  	echo "==== Testing $profile ===="
> -	_scratch_pool_mkfs -d $profile -m $profile -O raid-stripe-tree
> +	_scratch_pool_mkfs -s 4k -d $profile -m $profile -O raid-stripe-tree
>  	_scratch_mount
>  
>  	# Fill the first stripe up to 64k - 4k
> diff --git a/tests/btrfs/306 b/tests/btrfs/306
> index b47c446b..db3defc8 100755
> --- a/tests/btrfs/306
> +++ b/tests/btrfs/306
> @@ -21,8 +21,7 @@ _require_btrfs_fs_feature "raid_stripe_tree"
>  _require_btrfs_fs_feature "free_space_tree"
>  _require_btrfs_free_space_tree
>  _require_btrfs_no_compress
> -
> -test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
> +_require_btrfs_support_sectorsize 4096
>  
>  test_4k_write_64koff()
>  {
> @@ -32,7 +31,7 @@ test_4k_write_64koff()
>  	_scratch_dev_pool_get $ndevs
>  
>  	echo "==== Testing $profile ===="
> -	_scratch_pool_mkfs -d $profile -m $profile -O raid-stripe-tree
> +	_scratch_pool_mkfs -s 4k -d $profile -m $profile -O raid-stripe-tree
>  	_scratch_mount
>  
>  	# precondition one stripe
> -- 
> 2.51.0
> 
> 


