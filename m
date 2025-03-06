Return-Path: <linux-btrfs+bounces-12054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC4A54C0B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 14:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E22189400E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A9F20E315;
	Thu,  6 Mar 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWfSQOeX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65120CCEF
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267477; cv=none; b=F3l46rZ/08h+IcluUKBI64Y3UrwELKwpN6BsrmVG4KDR8log4Qv4TzXMyJQs7Fih6LkQ+2rRGKkF0B8VWQGb5wqxDq6bBejvNhJ13cDuI1XItRP8DZwLC5WVO0CCgndSjjj4k7UPOb3+TgpqKy9uhG3N1LCQhGrYuGq+AHLdeCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267477; c=relaxed/simple;
	bh=M6kq4gC+/WeG97ua0Fjmeo3ncgKSiNJEB5Xz3BStp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDxcI54dgi4p0PfhDadi8CC2oANmkw9zj0iHsoME6nAoGn8ul2guSXifMusOQnMQVMBi1VHjupXjRdQUD1s1Ah2c3DdKi/Upy/fzbcROixCroAV9Eigp2d4CXrctcUMMrVb6rpNxj6l/CJmmt+Cc5r/Folm08bdpiFd5lKu/oW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWfSQOeX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741267475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVryRIoP7Fmgk9OzPI4cGzgx7a6+rL8H/iTP/uYMo3E=;
	b=aWfSQOeXTvjFcG+iVHLHNjs12nVlX2+3Q4EgTVAeAnmI0gbjrn1LmcyVP4swzhkzaJpeOe
	QZM3fyCvyz0psno9hpzRcGCsMxIFtTVDP63h1Oc4OFVALrdZjJfqavcVVGsixRDTVKrsm2
	ZHTZdwEjhPZnssqg95Zi6VUPSlNghMM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Mh0tZIoqO6ScjeN5H9vZOg-1; Thu, 06 Mar 2025 08:24:29 -0500
X-MC-Unique: Mh0tZIoqO6ScjeN5H9vZOg-1
X-Mimecast-MFC-AGG-ID: Mh0tZIoqO6ScjeN5H9vZOg_1741267468
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so1471023a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Mar 2025 05:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267468; x=1741872268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVryRIoP7Fmgk9OzPI4cGzgx7a6+rL8H/iTP/uYMo3E=;
        b=MqQ0JJ4Z+M51+vUAL68zDCQUtAP09aFQgJ+0IYHsxDF5RK/78YBBWwGWIS4AEvxMvh
         ij2NXw18+k4F5lbFEk1XxM2Otr6XUW8thpj+lPLMgPDcFRRDSu4Obf0llRTTp2Kbt7nT
         xJXcS1wqmcviP+ot+VEhSyWo0lSc72noS0GMbNPSDLw7zyeF8Hh0WzoQlt3UKGGoPX4z
         rVfTAXyRngyo6OkpEEZarR7R4qswnmRfF0GidTbtTHhkgKSY333QLGm0zqjK0EKwVW3i
         fy13rCEdWj0VYMNybVkwl3ZvUHSeQNysQNhgCjO5yQjMYUJcrpT3YGk5ALI+tWukENDl
         wDpw==
X-Forwarded-Encrypted: i=1; AJvYcCUTKUr/z4se4D7Bf9KML0GGEZRSfjnak9YGdoHolYwr8gnc65Ufrf96uWhNHBnmQ01MgRZr6Yu569StVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWw3gp7huZsNwmE8mS7HrGESkmnAgX62T6Q+yzmeqc8SwK+2Rv
	xTscxHyXtqD5VJQyL0Sp6lX8Ee5pCUF8Kxu42Kh1MqWJ39sgcZRy1yhdyxtflc1snePKho+ir71
	NbMoLFVSm/iimU79Q+N1K/qiqMYZW+fdZtaG8nGjxYYrqT7i23iFNpAvE8lFY
X-Gm-Gg: ASbGncv0cXn4qqts1kQDF9pFbrsyYK39fK8yZBEStypLcsTXwIzYFjrJPd1aZex/HMc
	iDaYnajWLcH+ngif1lQWGV5d1QubJaFKzJsg3pXgFtQSBKiByHJ0Ha+0UDqWjiK+5grlHPuqxc6
	8IUP47y+ZlDwWFpjAc/4IO+RzrhajjBb6GjmgMCHXKuSvGkgxvXhff0rVFzHgxQJRbxGriLnP18
	whTUPZUPJfRT/SHW+wB3Mo7az6FXycyT+kPAWLeU4Leh96qSALIRU5EnFnNHxQRpnwqxYmcc3/L
	3nIrepl0lGszbbZ7nx4boJry7ojtZaxFC8Rl5HbB9Nynag2TD2DdLtFd
X-Received: by 2002:a05:6a21:9988:b0:1f3:20aa:4224 with SMTP id adf61e73a8af0-1f3494784d3mr12855207637.15.1741267468210;
        Thu, 06 Mar 2025 05:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoC/Egylhs0uLJZFPsbhfjNLGfUXu4ZZ38wmN6fH0nQSl/62/dUZsK6rwFCfONf3+zket1Zw==
X-Received: by 2002:a05:6a21:9988:b0:1f3:20aa:4224 with SMTP id adf61e73a8af0-1f3494784d3mr12855178637.15.1741267467935;
        Thu, 06 Mar 2025 05:24:27 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28109a4b4sm1174133a12.32.2025.03.06.05.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:24:27 -0800 (PST)
Date: Thu, 6 Mar 2025 21:24:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/363: add annotation for btrfs kernel commit
Message-ID: <20250306132424.aufbif5u2svaoohr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c0d7592ed3a4f8d39245359b55948c1cd60b87bf.1741171979.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d7592ed3a4f8d39245359b55948c1cd60b87bf.1741171979.git.fdmanana@suse.com>

On Wed, Mar 05, 2025 at 10:53:12AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This test exposed a bug in btrfs for which a fix landed in the 6.14-rc3
> kernel, so add a _fixed_by_kernel_commit annotation.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/363 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/363 b/tests/generic/363
> index 74226a45..79b1ff89 100755
> --- a/tests/generic/363
> +++ b/tests/generic/363
> @@ -13,6 +13,9 @@ _begin_fstest rw auto
>  
>  _require_test
>  
> +[ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit da2dccd7451d \
> +	"btrfs: fix hole expansion when writing at an offset beyond EOF"
> +
>  # on failure, replace -q with -d to see post-eof writes in the dump output
>  run_fsx "-q -S 0 -e 1 -N 100000"
>  
> -- 
> 2.45.2
> 
> 


