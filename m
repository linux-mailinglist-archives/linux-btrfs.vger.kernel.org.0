Return-Path: <linux-btrfs+bounces-12908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386FAA82174
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C457C1760D2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AC225D53C;
	Wed,  9 Apr 2025 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eO+jJmF7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFCF2459FF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192654; cv=none; b=t+N694hXoI6lZRUURq2Vq2gelQ/4giIn1d7vD7oSCBwNsRFbW1fRl1yVZ2+pigKfKAg9sIVeRKk1A5IJ/kptVN+MXYmqSzblx9eSdqremH2qptoxP5lmhaeKpXgaGv7E0JO7NNkYPIaR/5/aS5x3hCnflxJNOpptb97uW/cAQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192654; c=relaxed/simple;
	bh=f2YFhv/ay2EqQEIbM88ALqTA/Zc3CAZO57aacN3cWzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK4Y2bZJLoT25qOV+b7qkSSDc8RjGbM6ej3IwSVq5zqAIisgttQ9ZGYJtaQTsOmsFVhofaGKrxWOhtPNPAR3CjOzywDYMQpkotu4VrwzI5/tTYc4xjHfiSW/zkg+XxdsUbs5ryiZhwyme4fFiMD/prIIA+ESbQON7HuFpSe0yqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eO+jJmF7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744192651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6W1d2djr/RGcRIDDdM1RhDN/5g3ZrQRAfMmDhaVSk=;
	b=eO+jJmF7Uqa3A5wBBPwQc6Jszao7JYfYs220xriiQOyDCAglyYJXQbl6mnKE55pFD7lZ5G
	XFw+XRav0ZW42rWMFGM3jdvgVsYaMPl92wpo/fI2nCXMAi//D5KtYs7SCL4YG+0Yck9p3v
	VOZS+X1E+HB1HowQ5AXdoBVG5PebzGg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-B96FlI7PMZ-C79QKDJ6nJA-1; Wed, 09 Apr 2025 05:57:30 -0400
X-MC-Unique: B96FlI7PMZ-C79QKDJ6nJA-1
X-Mimecast-MFC-AGG-ID: B96FlI7PMZ-C79QKDJ6nJA_1744192649
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso8387108a91.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Apr 2025 02:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744192649; x=1744797449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO6W1d2djr/RGcRIDDdM1RhDN/5g3ZrQRAfMmDhaVSk=;
        b=TiKdaJ2Vn04Yzfp4FdFbLfojuC+GHfhlTfGSgvAbUpP4xdSR159y/rH03eZF50Lp4B
         fKAWlZU43Axj4tM0hAb7PCfxDDL/Sesqx62UdmisnNBGvuyODJiijUCcMR/ltvzX5jB/
         Wgt/O2C+yBWcLO5la88M43Ijs521ObcAeh5qvCEHDMn8f9NZSsuErGTAPIpaqcrMzMZ0
         MLUMU8uyWq01aFc32b9K+Y7BLDd3sGuKgzPix6hes9XCgswov6FpUSMPp5XCqPjd3S+d
         z2aGDAgGY02Tun2nY07OtcTM80rW+3x36HhIkHcKZFAcEswb5hgOU1MTkUc5hN0BZLgK
         L4+g==
X-Forwarded-Encrypted: i=1; AJvYcCVKj9jNP0Mt24PxbREzUZp106Fp4zvAsLb6yuLz3v2hWJSH0sYDXMXlQypx24QllolmNr+5nI89HBcXzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWk7Ilot56uKOWLAd8mWrUo0YoiD1JFcx3G1UVSFYc76uyyKOO
	7No92rkgzamK5IcqyUv1MfjUfHVxrfasP4fDE143Pm0UU8N6nQ68r5Sx/z4BjeCbcXXpWY/ZXZa
	uyvZ4V9v/831pIjdQjDMJsiq8ztDdWi0mxX0Bd2GhLjnE4/J+E500/Z0WNHE0
X-Gm-Gg: ASbGncuBLGPpSk3Nkj+6aRbiSBcuBaCL2wDD9N+crOeJcvVPOA+2beFBbGXEpd53IEC
	FmrZG+eDd9ZNPHvZDuTFXHuXB+umx1GE3SpcW8yCUC/fUl9n5zg6pzsZ7ThCVOxTaqSji5T4DLw
	8Yzv3+Iw+PoG6ywE2ksigcpIJ47cyEVYPF/n29v9PpaRP9ydTHfOnax1ou1hkRoVFd+gBnX2P4S
	Kp773Zm63F0RTJOKME/f1zGUbm7scbXsbX0rYgNTbbp9qosYUxT0gDMAaKQmIzKqefdLd+KqJC2
	4AyZjTj3GuWcUUy+W/EcdpYdJiOfFfjRINaL8+kJTqd0Ek5ZToR7
X-Received: by 2002:a17:90b:5252:b0:2ee:fa0c:cebc with SMTP id 98e67ed59e1d1-306dbbb366bmr3398413a91.20.1744192649123;
        Wed, 09 Apr 2025 02:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeejyU4fN7LUlJTruuiNultjp6mPjR1EWLUt8OgHgRdXRC+qeoifN/IyA2JHuU3AgxDAb3IQ==
X-Received: by 2002:a17:90b:5252:b0:2ee:fa0c:cebc with SMTP id 98e67ed59e1d1-306dbbb366bmr3398401a91.20.1744192648886;
        Wed, 09 Apr 2025 02:57:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df401ab2sm1070707a91.48.2025.04.09.02.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:57:28 -0700 (PDT)
Date: Wed, 9 Apr 2025 17:57:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 2/6] fstests: check: fix unset seqres in run_section()
Message-ID: <20250409095725.xumxhw54igwapuue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
 <12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com>

On Wed, Apr 09, 2025 at 03:43:14PM +0800, Anand Jain wrote:
> Ensure seqres is set early in run_section().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 32890470a020..16f695e9d75c 100755
> --- a/check
> +++ b/check
> @@ -804,6 +804,7 @@ function run_section()
>  
>  	seq="check.$$"
>  	check="$RESULT_BASE/check"
> +	seqres="$check"

The "seqres" even might be used earlier than that. If your rootfs is readonly,
you'll see that.

Thanks,
Zorro

>  
>  	# don't leave old full output behind on a clean run
>  	rm -f $check.full
> @@ -849,7 +850,6 @@ function run_section()
>  	  fi
>  	fi
>  
> -	seqres="$check"
>  	_check_test_fs
>  
>  	loop_status=()	# track rerun-on-failure state
> -- 
> 2.47.0
> 


