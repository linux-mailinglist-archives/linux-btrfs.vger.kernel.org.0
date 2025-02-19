Return-Path: <linux-btrfs+bounces-11544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4EBA3B12C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 06:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7F91645C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 05:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932DC1B87E4;
	Wed, 19 Feb 2025 05:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5Xh9phD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251201B86CC
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944736; cv=none; b=DL2TlOvmzkwAAXyqzLgeHB/sr5nlOt+i7bre+EpAboG+LPt2QcymToRVjbjoMS9RsOZHBblBr7AJE0cAkdkKlS5GiEkclfgRJKOfRWwvbMIKS7iuOjb5uPZlr0FgMf20txxgX8HiCDErd7RwMEeKYe29/VoqkwznaWP2Hfy01Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944736; c=relaxed/simple;
	bh=cmTtd+5HQcnkZ4IAP31qlBKVt321XEIeEr5PKO4u+a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjH+06ioa9zfPljR/wlHB/GwS0nnqVKciIjbDvggtRjkuKSByX1Jd0lAi2ryJYPAVFOJjYJ2Wkb3GlSnTtVAOb103I/G1tryDX97gtSe2/9zDWicF96Nb5oImE7BUWbDZVx/OuZdXaByoJ2YlUfD+4BWDiA+NOAaSgoCTcPCIxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5Xh9phD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739944733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YokxX3qQWk1mv/VDdALhwh1PAR6A9BWJ//OPV4oLrsc=;
	b=H5Xh9phDQWyJwvBS7C1eRbdFmue8ADlAgiqS6qf7cSyGfTwYsFX1bQMRns9MUYwyxnB74E
	fGrkvf5I2Q3jNeqsw4L0bxx8kAr7uHOTUxAga4reVA+ZVlaEJuMQ5+CbjbyrSgUIt4llCA
	yx6/06Wdp5TRoifSO2izLsBUhWYEayw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-omssydCeNjmL2IxmKZL9qg-1; Wed, 19 Feb 2025 00:58:52 -0500
X-MC-Unique: omssydCeNjmL2IxmKZL9qg-1
X-Mimecast-MFC-AGG-ID: omssydCeNjmL2IxmKZL9qg_1739944731
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc318bd470so9704441a91.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 21:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739944731; x=1740549531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YokxX3qQWk1mv/VDdALhwh1PAR6A9BWJ//OPV4oLrsc=;
        b=G7qdayNl1Oeye5RKPwR3VBiobVPo1JmDQ5RcMvGJylS604oIKTYXPsFQZCjt8yCj/2
         8xZHxABzsR2/fpW3vrwYW5VyXZ6B2hFSOAJpaq1W+UCk96GBwdwOPxn9scErDW5SuzvW
         uu1GYJFXFyNYUsjygl2pqF4F8aNHKKFUhAL10XW7vrvYqqwTBGdbgatIgZTFJRFSIqJr
         s7h0LoBVw9kCFFf4vnex9kSSp7Htxqxe6OAg+hT2krYoPH+NIw9tUfgMe5B9fzWa8/oW
         nonvAx3IeunCypj/IeFpGbR+xjR+yOv8njUjSK90rpmSUu2sF3ArT69SSpP2HdPMe/Im
         rJIw==
X-Forwarded-Encrypted: i=1; AJvYcCX2qbt9VwMGg5+3LsS9IDNC9J5ywGYgrqcjViGI61BwvftYCev13RHqMZZ06A1S2WUzOAByklygCBVdOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWq7VK92h4l0omnie+MRbTpbichDzSMaOvlUeP2aqEhN6ZS94A
	ZBDq9gUn8Lib4jmGiI2w4NN1hRsPo7R7XPBqRIYsy5WRYefrEtecLTY03mi/+YQjDCa42RQEtId
	5joQT4lB5l1P0IgZ3fDj2KCUJkKTLaFrnGfEdTLKQ1nlTyIJ2Q/IuGwnKr8+7
X-Gm-Gg: ASbGncu/Ii6ivakCxmwZPkX2XvR3jDQlja/N/cGOslNzZP0yzlk6A4ajE3TynuODHmn
	gUQUu4xwy9VYtX/bJIwD+RB4jbu/iDCQLI6x7eB5SzxR33uhOtTW8dKkgg5w/gYEkLLtgMl9Cyl
	LIpUodb9Z3GpYg0YZlvQ+ptP2Ucw1JRb9Oa9RVRpgJmxWdH7C7NcSdmWWJH5sRSlnePsH/e+ZNt
	g4NLjfTOJNEniNIxrwBHqbDcGkT+N+dEnjzfBKNC2RUhTzpTj76yrpfy+m5+bhX1hlHC23cHdAp
	0ArR100MGyDaFBrLKabz7wu4FRErHGRfRY5czBfmQEVo+A==
X-Received: by 2002:a17:90b:224d:b0:2ee:accf:9685 with SMTP id 98e67ed59e1d1-2fc40d12d39mr25653844a91.4.1739944731246;
        Tue, 18 Feb 2025 21:58:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJPagFe3FnyteGo6t1av2DMGdt45X9cqSU9aHuSKb3hxn5htsk4qpMRj/P3IafC3sTkfQDnA==
X-Received: by 2002:a17:90b:224d:b0:2ee:accf:9685 with SMTP id 98e67ed59e1d1-2fc40d12d39mr25653826a91.4.1739944730916;
        Tue, 18 Feb 2025 21:58:50 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9ab0233sm13387857a91.44.2025.02.18.21.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:58:50 -0800 (PST)
Date: Wed, 19 Feb 2025 13:58:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/226: fill in missing comments changes
Message-ID: <20250219055846.r6amxpdxubjbtyhd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>

On Wed, Feb 19, 2025 at 06:35:44AM +0800, Anand Jain wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> Update comments that were previously missed.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/226 | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/btrfs/226 b/tests/btrfs/226
> index 359813c4f394..ce53b7d48c49 100755
> --- a/tests/btrfs/226
> +++ b/tests/btrfs/226
> @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  
> -# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
> -# btrfs will fall back to buffered IO unconditionally to prevent data checksum
> -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
> -# So here we have to go with nodatasum mount option.
> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.

As a supplement patch, this is good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _scratch_mount -o nodatasum
>  
>  # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
> -- 
> 2.47.0
> 
> 


