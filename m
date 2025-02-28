Return-Path: <linux-btrfs+bounces-11923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD90CA490D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 06:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8341F18934E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98A71BD9C7;
	Fri, 28 Feb 2025 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwAeBPde"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758181BCA0C
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740720058; cv=none; b=VeDt3pJZP6q5JyzacKjfi+QIxJWx0PGuxWzNR88DSvCVU3YYuUP4ajrjDME0Zd+KGrBRatMvcJSnyXTH1/8RMWAfanCNg5tOeVxpp83uElll/DSqfZdNUtARmht1UDdXaqW8fNzim44kEOGAb6UA4n9FU4tcoyqXthUQglPipgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740720058; c=relaxed/simple;
	bh=YnCr11+jofyTBBjvZ98dwiUUtYT5Blv0XwzpDzEIzl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi9rftX/jhw3CDLvt7UR3ouH/9J9zt+hTDDH0JuYtlTwXYniFoFVUvZYSpdO/o+nnw3HnXw8RRqSkAk0Fwr3b9Pvvvkxhs70mCjO0L1shD+eQPkOh2P5gfn5hhf1GDjT0dMssrL88eUqurEIKqTk43fa1O02MCdtuZEhAUjmY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwAeBPde; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740720055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RyVg1vM93p2mte050nuhN+tNCQv5kBGlJi1Ovg0GaHs=;
	b=IwAeBPdeFKRdhdye4HXGmAyRNpXzDfBF1bwL9Oft8ALA1lXMJ/Q6ksdM6taOZMX1A/EUQ9
	zyf6PO65JfcfnKcWpCP5t7+OPjOqvdGn7ZX2du3gqgi2UVYWbgsztLoiKe6H5gJBCZU6DN
	IeOIXLV1bbzXx+U5SjWp5WyFFNgTo/A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-yk2Yyf2WP4Gcv6cobsRhwA-1; Fri, 28 Feb 2025 00:20:52 -0500
X-MC-Unique: yk2Yyf2WP4Gcv6cobsRhwA-1
X-Mimecast-MFC-AGG-ID: yk2Yyf2WP4Gcv6cobsRhwA_1740720051
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220ee2e7746so33376255ad.2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 21:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740720051; x=1741324851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyVg1vM93p2mte050nuhN+tNCQv5kBGlJi1Ovg0GaHs=;
        b=AH/WuxeSpb52bVycUj2Q29fryfxX0lwonq7eV2u+TKxll52ZsZcn1IAj30z955VGW0
         0qg5w4906svnz9Rgr1IznBGb5HsmHOdMU9iieXCwNaivYEq1JRsx1FqRm29s55y679op
         Zzz96Ree8IQRptInPU86yRh3mMVIui/pJ0XSTXIf9KPkRyCSki+5tjH+krbzL9P0plfm
         uQQRx6MIMiZ8Q07D+UYYzfw0OPYWsxnfKyLM1KdU0XkKA3ZyxUGomEovsecQD8Ao9g3O
         E4bimSBjhL/0+pZXqDXXN2NZjTYZTtO+gIn6f8F1v+PN5XbFtk56SEnq6NYmEm4cKTxC
         K/sg==
X-Forwarded-Encrypted: i=1; AJvYcCXpKW6rDCQA6O3SHF4wAgvA2vAIVJFzpjeLCUVKKv7DTlaVCVGVi8Aj7Vf9fprRXTC5DzqtmkSUyHBN4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlNojkv3NlvxjBgmS01sKBA/qFOn8ToR19mUB/+Kj+2jMyZYCD
	LUs+tJG18iUu75+3iNUqCMX5wC8pq7mR2ikh+xr8tYUGJ0yuDir0dJS0aPsvDTwMJj55vYW/XRY
	tdta6d91iBgdXTelsnvBvryaxbPeRe6JCzNOohy9i7kJEoqDlEiAr1DQ9ZsqX
X-Gm-Gg: ASbGnct1UIhr0AF2empxOsArOs2ohkiai7oduLsBy7icduvDcUljsIPboIGhUDbfYDU
	3yuXj/zF3ckRbQHN2OTeXIzK9ZnN/5ZPjOV4lR8ckDqI8w/kg9CEh0gEBPU0sklIMdHzvcKwkLB
	nNextg4X4BG8t+YGOVkacwmKqeyZFOsejsOEdgUVQRSuzimwzOZaDjak+0D1GhVhiCtPEulU/B0
	TbwAap3RcSNe4fq15IriE0sgc7i12u1Agtc22nhArAZFJ3z7MQre6Tf8GJ3PrKOXuyZk3kPAfd2
	2H+9glXRRHyio1/Ff9zIR6gmzjPA/UH0syPZ0fURjLCmRf0iVa161QP8
X-Received: by 2002:a17:903:198e:b0:21f:988d:5758 with SMTP id d9443c01a7336-2236924e748mr31732595ad.35.1740720051105;
        Thu, 27 Feb 2025 21:20:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzy49UASObmQ7/nUvx+TWKzEu6dRH9MJ0+SeFJeR4O2daveYepfu9fVUCfCPpIG4lr218RQg==
X-Received: by 2002:a17:903:198e:b0:21f:988d:5758 with SMTP id d9443c01a7336-2236924e748mr31731725ad.35.1740720049534;
        Thu, 27 Feb 2025 21:20:49 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c20sm24914935ad.146.2025.02.27.21.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 21:20:49 -0800 (PST)
Date: Fri, 28 Feb 2025 13:20:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/254: fix test failure due to already unmounted
 scratch device
Message-ID: <20250228052045.usxjsezp5jgadlxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <b470cdee538aab91177f8295fb8886ae79f680db.1740662683.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b470cdee538aab91177f8295fb8886ae79f680db.1740662683.git.fdmanana@suse.com>

On Thu, Feb 27, 2025 at 01:25:18PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If there are no failures in the middle of test while the 3rd scratch
> device is mounted (at $seq_mnt), the unmount call in the _cleanup
> function will result in a test failure since the unmount already
> happened, making the test fail:
> 
>   $ ./check btrfs/254
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1 SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
>   MKFS_OPTIONS  -- /dev/sdc
>   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>   btrfs/254 2s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad)
>       --- tests/btrfs/254.out	2024-10-07 12:36:15.532225987 +0100
>       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad	2025-02-27 12:53:30.848728429 +0000
>       @@ -3,3 +3,4 @@
>        	Total devices <NUM> FS bytes used <SIZE>
>        	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>        	*** Some devices missing
>       +umount: /home/fdmanana/btrfs-tests/dev/254.mnt: not mounted.
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/254.out /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad'  to see the entire diff)
> 
>   HINT: You _MAY_ be missing kernel fix:
>         770c79fb6550 btrfs: harden identification of a stale device
> 
>   Ran: btrfs/254
>   Failures: btrfs/254
>   Failed 1 of 1 tests
> 
> This is a recent regression because the _unmount function used to redirect
> stdout and stderr to $seqres.full, but not anymore since the recent commit
> identified in the Fixes tag below. So redirect stdout and stderr of the
> call to _unmount in the _cleanup function to /dev/null.
> 
> Fixes: f43da58ef936 ("unmount: resume logging of stdout and stderr for filtering")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/254 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/254 b/tests/btrfs/254
> index 33fdf059..e1b4fb01 100755
> --- a/tests/btrfs/254
> +++ b/tests/btrfs/254
> @@ -21,7 +21,7 @@ _cleanup()
>  {
>  	cd /
>  	rm -f $tmp.*
> -	_unmount $seq_mnt

Oh this change was merged with the _unmount update together...

> +	_unmount $seq_mnt > /dev/null 2>&1

Sure, makes sense to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  	rm -rf $seq_mnt > /dev/null 2>&1
>  	cleanup_dmdev
>  }
> -- 
> 2.45.2
> 
> 


