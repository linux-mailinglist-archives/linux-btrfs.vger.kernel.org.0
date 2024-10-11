Return-Path: <linux-btrfs+bounces-8845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104C8999C2D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 07:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B801C2289B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 05:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9EF1F943C;
	Fri, 11 Oct 2024 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYk18111"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8B1F8F0E
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625345; cv=none; b=m+fVJgncOznADBQUz7z9pVGeyUapB66rHAJbZZtt7rVliqLXdqiJfyXYuCqi8ycwf1vkj6WljvYqsdDQ5SO20qGHnDmJe8Vi1A5CEP6uQtVMWd6zMEiisDG5o0mzI93qjLcZbFDoselG+T1fdeYuEwlQkJxKPE6lb6NjtlJXVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625345; c=relaxed/simple;
	bh=idxDbcbNYVJWrkCpa8ghOudRiV6TRc1L6aXaGXyHN68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFx9dCcyDGoml+wYIfdkxjsqs8T1SJuestNuNFH+NeKgxI/0tZC0/0I8umqv3K2G1iHS+5+zpP5DoeZ/6ptZ8zczsMgT7SPDKdihJ/XNxvxnZyf5u6+yStUbwfS2VTKp5UeP6DGxGM8+MOE+YulY+SQG2ZUZEqdeu4VZVggn5jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYk18111; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728625342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53B97lUdI/DP8jBTRSZLCTzYlhOxeGNND2Fs2ic+Gwc=;
	b=gYk181111QpssippOQLS0xJmzCwZNkn+uC8K0vB7ZR0/Cmr+gIK2qVn1cS5f6Ewy1Ay6mv
	BplGCt1qnFSDuV8yZwpRFD7d/CFZNtn2Ox6kepwIGLPRhe1/eIYzjg77jCXMRSNfQILTZl
	cq05CeWNZauYEFtQwxK+zqqBS3u1u6g=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-EOuhoePnNLeKh3NV3HAY1g-1; Fri, 11 Oct 2024 01:42:20 -0400
X-MC-Unique: EOuhoePnNLeKh3NV3HAY1g-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-206b912491eso27355115ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 22:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728625339; x=1729230139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53B97lUdI/DP8jBTRSZLCTzYlhOxeGNND2Fs2ic+Gwc=;
        b=N7nfeYBGFydeYwCgDTdj4WGTVel293Ah0S5OStb2rhJKFUUOgVoSn1oQihZ3yiZG/U
         KGP60ElrT0UuCMCTBCV/ymGzZw/+5B8ux15XiWnq/OR9qafW/yYBNVBIeT7CIJp8LmHW
         iL+MnRq+MEcFRZOIoFujpi+nqV5g/GB4zSN3kyeTRqSohlOFkgMPFv47zAcgAnPspGVe
         ilkGH6b7poDYwbmTt3CHnWjp1kGFRrlkMg347Q5ZZULf1CMAJNBPQdI6Y+n6wR4fcXo3
         ZQoSZChi+n1kFnKFJ/9Ppm1/Z2xnGjOTGFzdygzcmMIzPMBWnGVHETXzPJ7LWzdx581N
         hkGg==
X-Forwarded-Encrypted: i=1; AJvYcCW4PyT4+R/QpRnaW4HwQnWcDJcGO2yF+h7RYhsIBLyUaaUAKY74HCHQY58Pk7u+UZ7lU0D2RTw+aFbovg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Brp1YpjWK3pRZknsYApC9ZRlIwUP4feVhLq1yVdzfIAiZBgT
	ekv3ZzyjihSXPcPOGSZu8J4wAiW0jtB0g7Q6f3IURj2M02ReEFxmVlsiWZByzu0+zixCTpEHWen
	6C/0LcUtqTXRALeOoB35Ah/yUasnNv4w3iriBqxisX7UblxAj+cBbv/ICkrx8MxvSE1BsDjE=
X-Received: by 2002:a17:902:f54c:b0:207:794c:ef24 with SMTP id d9443c01a7336-20ca017813amr22664595ad.4.1728625339300;
        Thu, 10 Oct 2024 22:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGludFsYvBrB8CYtTLTqINvYVM9TGvZ0bUIQjzfDkPkA1dfAxtuD6O74+4ATekQ/KG03RwSIA==
X-Received: by 2002:a17:902:f54c:b0:207:794c:ef24 with SMTP id d9443c01a7336-20ca017813amr22664455ad.4.1728625338974;
        Thu, 10 Oct 2024 22:42:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc13315sm17658625ad.107.2024.10.10.22.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 22:42:18 -0700 (PDT)
Date: Fri, 11 Oct 2024 13:42:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/318: add _require_loop
Message-ID: <20241011054214.km2yl75ya5zcfl36@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241010153630.1225162-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010153630.1225162-1-maharmstone@fb.com>

On Thu, Oct 10, 2024 at 04:36:25PM +0100, Mark Harmstone wrote:
> btrfs/318 uses loopback devices, but was missing a call to _require_loop
> to print the correct message if CONFIG_LOOP is not set.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  tests/btrfs/318 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/318 b/tests/btrfs/318
> index 79977276..df5a4a07 100755
> --- a/tests/btrfs/318
> +++ b/tests/btrfs/318
> @@ -18,6 +18,7 @@ _fixed_by_kernel_commit 9f7eb8405dcb \
>  _require_test
>  _require_command "$PARTED_PROG" parted
>  _require_batched_discard "$TEST_DIR"
> +_require_loop

Sure, this case need loop device.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  _cleanup() {
>  	cd /
> -- 
> 2.44.2
> 
> 


