Return-Path: <linux-btrfs+bounces-13419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BCAA9C8C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 14:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05AD4E314D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84E242D99;
	Fri, 25 Apr 2025 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKK4S4Uj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E621773D
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583351; cv=none; b=HtBfFCGdT3WioqGBylMncyNp8YpBUt2h/KLpWoPTUC1wNvb4VcyyJ0Kbxa4JeqcFLllbuuUgRU+gBI91fLIEeXAc3OOrc1ZdLVjg3CG0/T8ErKFg18c9dzYczrDUPgtFvUUu4EKl7Cfh94XStIvq24elbGOmduo+j+dtElI8UNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583351; c=relaxed/simple;
	bh=c0fubQ1snPJgd7Kvxe4e5N5UwKvBeiNmczOcJytu4vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWwv+Bcp3rpSff07mKxIqzZwCN7LpKJYUyhQIsEqf+vDZHyd5JlnUmwyKppdObmAuMISGiOne6/K0tX2kgx1I2W+wzougdK6h/xvb+4n2ZQCH6D/CmivYH7p7KLd02GJROEacX3BSPhPI5+YfSXQy6TXQ7LzQnl8yKkjCzeHFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKK4S4Uj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745583348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BFdWNSjqC8Yl6W1s/o0EusBZu4C2kuSHFKd7PouRer8=;
	b=DKK4S4UjIwwTfeqqKazknDoVjSijrtPcgYb57hRL1tOvaaftKL6nlINc85w2j0aNdC+RM+
	YLKqV4UCZcAyy+5w90HmHzhg8yfUGMfzeY8VNOSIA4EZoPx8H/H82sOgIgKjGaYR68ra3R
	Ad7YqMtdJOtHouGsaSY9W1A+mU0KNhA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-lH_hgIASOsWI05tte3rkng-1; Fri, 25 Apr 2025 08:15:45 -0400
X-MC-Unique: lH_hgIASOsWI05tte3rkng-1
X-Mimecast-MFC-AGG-ID: lH_hgIASOsWI05tte3rkng_1745583344
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-73720b253fcso1897055b3a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 05:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745583344; x=1746188144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFdWNSjqC8Yl6W1s/o0EusBZu4C2kuSHFKd7PouRer8=;
        b=k70oXi5w8ALeCJwVffi3SEbwM8OD5+P/W7jSxqoRBJ7sxZSYXMcZQBokcD2Ev858ll
         2aATSXRDD9bm2FA0V8B3I1D/YuvlyBZ+/1iuRTIoBEh2ad57k9z4iDxDn7N01rJuoFMp
         ov7XRkxivsilNZuxtGP62Js7Rz5luh91tvp0qA+ZkvXP4B9L3wAV0OenmMdZVX9ka5e1
         zACD4ltmxUp87qWufAO08yEbimNDMVX7NH30vYTNq++b5MIV4LHGOBBUn0DRBnde4Z1y
         3RBINNOl3scSXVmv8uHXvBJTlCsslwkgr4q9s1YoACzCnG4ydQ0oZJaTO9h00tIQfRny
         gT8Q==
X-Gm-Message-State: AOJu0YxTS3rhEZmFPFGbt+4ziUP8o6c8bJzSKdvwbsKmWdp8rV5xtNCr
	9guqdvT9uJwIDre4tbXptD0S+wazeuNeDCiWHywPwfOF+UnvUiPKUHFACP9P3KZcRsfOv/5BKu0
	v8BEN+4nwemDbDKEtStnLPk8Ll7bioVr85szy4wkmVmvXAAYBU59pSJmJAcuS8tzgefo+DvM=
X-Gm-Gg: ASbGncvtypn6U5rnSmOcmgjnlO5tYL1uUWSqEjsdR62qFYcT0AZuaocbxulf5raEU0m
	qJR3fiHF74wN3cnNLT1vGwC1KbFo/DrullF5nll8FMTKv2mqoBYigPireDBD7S1F8orwaq9o2J4
	MkWpvJuCWBKW7QA5tjbACWqlko7NrisbKpzq6NpBLkwrJr4RG/O7rcYZhcI8RyzehZ2lAN4QAw3
	q4JzppQDCQsp/uFPcCDA+5Qnw2RQsqAUmIXwBnHECB3D+s3hrWnIBTV0ZH8n1XbUSkudSYcThDV
	MggiGev/TYKgPlmOM/KDW2xJYvqCcRPABGwpQADEMhhGCwNnBdM3
X-Received: by 2002:a05:6a00:3e2a:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-73fd896a139mr2462276b3a.15.1745583344035;
        Fri, 25 Apr 2025 05:15:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFESxf06ibdHZcdom6dtC73XV7yUBCleJ9MftcqXrXQ6K6cixRMcJBjkb631qjvYgxjecLX1w==
X-Received: by 2002:a05:6a00:3e2a:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-73fd896a139mr2462251b3a.15.1745583343665;
        Fri, 25 Apr 2025 05:15:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9feb9sm2965593b3a.154.2025.04.25.05.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:15:43 -0700 (PDT)
Date: Fri, 25 Apr 2025 20:15:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs/315: fix golden output mismatch caused
 by newer util-linux
Message-ID: <20250425121539.ptx2v4svljmdprpl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250424072907.256692-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424072907.256692-1-wqu@suse.com>

On Thu, Apr 24, 2025 at 04:59:07PM +0930, Qu Wenruo wrote:
> [BUG]
> With util-linux v2.41.0 and newer, test case btrfs/315 will fail like
> the following:
> 
> btrfs/315 1s ... - output mismatch (see /home/adam/xfstests-dev/results//btrfs/315.out.bad)
>     --- tests/btrfs/315.out	2025-04-24 15:31:28.684112371 +0930
>     +++ /home/adam/xfstests-dev/results//btrfs/315.out.bad	2025-04-24 15:31:31.854883557 +0930
>     @@ -1,7 +1,7 @@
>      QA output created by 315
>      ---- seed_device_must_fail ----
>      mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>     -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
>     +mount: TEST_DIR/315/tempfsid_mnt: () failed: File exists.
>      ---- device_add_must_fail ----
>      wrote 9000/9000 bytes at offset 0
> 
> [CAUSE]
> 
> With util-linux v2.41.0, the mount failure error message changed to the following:
> 
>   mount: /mnt/test/315/tempfsid_mnt: fsconfig() failed: File exists.
> 
> Thus the existing filter only striped the "fsconfig" part, leaving the
> "()" without changing it to " system call".
> 
> [FIX]
> The test case is doomed in day one by using a local filter, which
> requires stupid catch-up game against util-linux.
> 
> Meanwhile we already have a much better filter, _filter_error_mount().
> That helper can already handle the newer v2.41 output.
> 
> Let's use the superior common filter and update the golden output to:
> 
>   mount: File exists.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove the cursed local filter and use the generic one instead

I think this's good to me, although I've forgotten why this case didn't
use the common helper at beginning. If anyone find something wrong,
please feel free to tell me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> ---
>  tests/btrfs/315     | 22 ++--------------------
>  tests/btrfs/315.out |  2 +-
>  2 files changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> index e6589abe..9071e152 100755
> --- a/tests/btrfs/315
> +++ b/tests/btrfs/315
> @@ -19,6 +19,7 @@ _cleanup()
>  }
>  
>  . ./common/filter.btrfs
> +. ./common/filter
>  
>  _require_scratch_dev_pool 3
>  _require_btrfs_fs_feature temp_fsid
> @@ -28,25 +29,6 @@ _scratch_dev_pool_get 3
>  # mount point for the tempfsid device
>  tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
>  
> -_filter_mount_error()
> -{
> -	# There are two different errors that occur at the output when
> -	# mounting fails; as shown below, pick out the common part. And,
> -	# remove the dmesg line.
> -
> -	# mount: <mnt-point>: mount(2) system call failed: File exists.
> -
> -	# mount: <mnt-point>: fsconfig system call failed: File exists.
> -	# dmesg(1) may have more information after failed mount system call.
> -
> -	# For util-linux v2.4 and later:
> -	# mount: <mountpoint>: mount system call failed: File exists.
> -
> -	grep -v dmesg | _filter_test_dir | \
> -		sed -e "s/mount(2)\|fsconfig//g" \
> -		    -e "s/mount\( system call failed:\)/\1/"
> -}
> -
>  seed_device_must_fail()
>  {
>  	echo ---- $FUNCNAME ----
> @@ -57,7 +39,7 @@ seed_device_must_fail()
>  	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
>  
>  	_scratch_mount 2>&1 | _filter_scratch
> -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_mount_error
> +	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_error_mount
>  }
>  
>  device_add_must_fail()
> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> index 3ea7a35a..ae77d4fd 100644
> --- a/tests/btrfs/315.out
> +++ b/tests/btrfs/315.out
> @@ -1,7 +1,7 @@
>  QA output created by 315
>  ---- seed_device_must_fail ----
>  mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
> +mount: File exists
>  ---- device_add_must_fail ----
>  wrote 9000/9000 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -- 
> 2.49.0
> 
> 


