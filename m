Return-Path: <linux-btrfs+bounces-14501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637CAACF50C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 19:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20AB1883B11
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5AB27604E;
	Thu,  5 Jun 2025 17:10:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780942750E3
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143457; cv=none; b=kjpObywEu9pv03S8P1/T/9Wb1P3xxZrnIeFHJMg34JXl1tc5qixQ4x+Uw+wyH2BxmeASQUbCSQ+/t9i0t7GC4NeYc3ARmTe3onieprFgnwN8nSR42OlUmqqDDhZ1vr9fCvfoFhF/kZKDmQMKVQCBOqoRgsVhQAiif5mI39n605U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143457; c=relaxed/simple;
	bh=9hwaIyiwubXp1KD6FvqOFtrw25kXv5+SNhuX4PHyhnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVYliQm1rzb0N+9guEntbtW1S1fL5yvUkdhXZJvY7YpMuWjeu/A53h6elURBxNWTLUq/Ar5gg915hHu7dQZQS9GDyZ5RjYMK1KhPS37xB3WCtdcfqU4WGtxRPZxgYs7ofKkDagZhNlGX2g9H7vhkfNTh459Ua0ECeqFHRa2ckxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-E8p6CRu7NOasstP7RLTjxQ-1; Thu, 05 Jun 2025 13:10:53 -0400
X-MC-Unique: E8p6CRu7NOasstP7RLTjxQ-1
X-Mimecast-MFC-AGG-ID: E8p6CRu7NOasstP7RLTjxQ_1749143452
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7370e73f690so1616803b3a.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 10:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143452; x=1749748252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEdrsXnDxNlF+G9Y39zkaNGpxQnvHyZVOYLvk3avuds=;
        b=J0IYaDBtfwFNbC1t4zUXgMroe1ruipDq32OebwdAdzgd/ScgePJtLjncxIykeOuu1g
         A5v5pysmdLGGDbPDP+mvvMHYFmUl0/R8cZ/v8UtU2NLDHZNGk92VJrBOtwaqCQHtEuWz
         2KN6H37J3gR0XzqJczT2L30KFFeISVPsaaCXnsVKkegjk+srNEhPwf+ipez7F9QVhLVx
         X/A0Ny8xHLo7oVtxxj85VI+GETSfTTebkRye72682f3A/VwzUzmo7JNwyF9wzUQ3MeV0
         Dui4w2bQYg+bmi2BXF/CiSWBCHOo70W6E/7swaV5+iLcA44+QcplcF4kmbkWWkHzifZw
         qvfw==
X-Gm-Message-State: AOJu0YwgSQGsiurav54/FkvnSCsrkUvrhiNRoih15tLd+M97QJ7Uptvu
	C718uWqZM+YIrwTBywK5e30/LVNXIyjir3alWFIppe5VxMlXiv6YVjiTU2lb7vf+czerFZ016VE
	G0MQRe5TzmWLurqc5lfyscArmzIjrklxjP9WWR6/O2buiWXYB95P5guMkd9m+pYBOw7nhiStu
X-Gm-Gg: ASbGncumBbLIGB5hy/Ti38iKVC8sWyYPzllj3d58J0UbiGAw33d17dGZHs9P18ZjaCR
	w3zsy65jg7849Ynz+FZbd16agognRswCpGFlrgQ01bFk1ubw92tYr4O/zvsi4MRd877gaPGLIiJ
	Qc+h67BkgGyjE7C+sieHySo5ku7h2b0JV01wlBaLw8BhecZrTGrkM7gxRc3RRDWu4wctbSNTF57
	YLC4/3tS9ijIYsT0pN8SjXzWssXTmgbaP6hdPikiiIMRg5jE8lopeggXmGspClkEcHvM3sEjfgA
	HEtlLlb30GaSHUXiHX42KYR/X9Vy8gGGgEkO+JaxRcYg2sti7XAq
X-Received: by 2002:a05:6a00:14d1:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-74827e7e8f7mr691805b3a.6.1749143451946;
        Thu, 05 Jun 2025 10:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6ccaqhIYWyEadJ5C5U4dlILO+cQvFurvtNQvya77WdPeaJ0IbnOTOwAeFUC8TyVspIclYlA==
X-Received: by 2002:a05:6a00:14d1:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-74827e7e8f7mr691778b3a.6.1749143451542;
        Thu, 05 Jun 2025 10:10:51 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7388sm13461455b3a.171.2025.06.05.10.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:10:51 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:10:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/741: make cleanup to handle test
 failure properly
Message-ID: <20250605171047.vl3u6j7yojbw6pfe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250604235524.26356-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604235524.26356-1-wqu@suse.com>

On Thu, Jun 05, 2025 at 09:25:24AM +0930, Qu Wenruo wrote:
> [BUG]
> When I was tinkering the bdev open holder parameter, it caused a bug
> that it no longer rejects mounting the underlying device of a
> device-mapper.
> 
> And the test case properly detects the regression:
> 
> generic/741 1s ... umount: /mnt/test: target is busy.
> _check_btrfs_filesystem: filesystem on /dev/mapper/test-test is inconsistent
> (see /home/adam/xfstests/results//generic/741.full for details)
> Trying to repair broken TEST_DEV file system
> _check_btrfs_filesystem: filesystem on /dev/mapper/test-scratch1 is inconsistent
> (see /home/adam/xfstests/results//generic/741.full for details)
> - output mismatch (see /home/adam/xfstests/results//generic/741.out.bad)
>     --- tests/generic/741.out	2024-04-06 08:10:44.773333344 +1030
>     +++ /home/adam/xfstests/results//generic/741.out.bad	2025-06-05 09:18:03.675049206 +0930
>     @@ -1,3 +1,2 @@
>      QA output created by 741
>     -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
>     -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
>     +rm: cannot remove '/mnt/test/extra_mnt': Device or resource busy
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/generic/741.out /home/adam/xfstests/results//generic/741.out.bad'  to see the entire diff)
> 
> The problem is, all later test will fail, because the $SCRATCH_DEV is
> still mounted at $extra_mnt:
> 
>  TEST_DEV=/dev/mapper/test-test is mounted but not on TEST_DIR=/mnt/test - aborting
>  Already mounted result:
>  /dev/mapper/test-test /mnt/test /dev/mapper/test-test /mnt/test
> 
> [CAUSE]
> The test case itself is doing two expected-to-fail mounts, but the
> cleanup function is only doing unmount once, if the mount succeeded
> unexpectedly, the $SCRATCH_DEV will be mounted at $extra_mnt forever.
> 
> [ENHANCEMENT]
> To avoid screwing up later test cases, do the $extra_mnt cleanup twice
> to handle the unexpected mount success.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/generic/741 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/741 b/tests/generic/741
> index cac7045e..c15dc434 100755
> --- a/tests/generic/741
> +++ b/tests/generic/741
> @@ -13,6 +13,10 @@ _begin_fstest auto quick volume tempfsid
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	# If by somehow the fs mounted the underlying device (twice), we have
> +	# to  make sure $extra_mnt is not mounted, or TEST_DEV can not be
> +	# unmounted for fsck.
> +	_unmount $extra_mnt &> /dev/null

Hmm... I'm not sure a "double" (even treble) umount is good solution for
temporary "Device or resource busy" after umount. Many other cases might
hit this problem sometimes.
Maybe we can have a helper to do a certain umount which make sure the fs
is truely umounted before returning :)

Thanks,
Zorro

>  	_unmount $extra_mnt &> /dev/null
>  	rm -rf $extra_mnt
>  	_unmount_flakey
> -- 
> 2.49.0
> 
> 


