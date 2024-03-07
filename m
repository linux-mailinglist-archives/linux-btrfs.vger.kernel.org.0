Return-Path: <linux-btrfs+bounces-3068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171BD8752E7
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 16:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05EE1F28983
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8582012EBEA;
	Thu,  7 Mar 2024 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bng/0x1L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4763121
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824591; cv=none; b=BZP12ksUrGf6kmAm9uXEMToe9IfmCsz/b1nbRpDDbacmJBnFw0UWXQdH+rab0L3T6KyaWf8banF06lZrdbtw3eWomxpb5+TU/QUxclByljbdQN7PEtdT74XyWergHNyCMD4b1fOUqhXMa7yxYvX5b8msSoANuwwNpS1P8fblZ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824591; c=relaxed/simple;
	bh=fmB/2fYDC523eDr7fhnoE0bYTJ4w/9VUvVJotNmRj6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4Xr/axs4esdWV65h9mD4vp61Q8BoUiaGecaWcEh0YJuR+r1dX05LRu2ygT67hG2nO0k0Np4jQEWOSJjHoMp4iv5UETMklwafHbwrv3wP4jyUurkGGRl7VpEOIi/mEiBLPG7IavjVC7ZlLf3Z9PBUfn/t8ePZgfnzVdgyrQQlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bng/0x1L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709824589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XgGCF6Ao6NnaPFHwjjrVnnOgsuHOgFMm7iHKQvatCo=;
	b=bng/0x1LLxAZZ4BqntIHaTWY8mmIqGCV78L/1nrbO0Dglr8Q2Go34dsMcsi1Gw/veOoRnm
	F/blII24Gu3rXgyysqMzTu28ZWSK32z9CL/4Af34j93cyuDvqTbqbEaLJ0gGLTD5fOO2Xd
	7eUJRZl39dJuLnPtzv/4zzbUBFgG/m0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-8flXwIdTO4mDCS7KVB7zdg-1; Thu, 07 Mar 2024 10:16:27 -0500
X-MC-Unique: 8flXwIdTO4mDCS7KVB7zdg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dc4f385c16so10962755ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Mar 2024 07:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709824586; x=1710429386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XgGCF6Ao6NnaPFHwjjrVnnOgsuHOgFMm7iHKQvatCo=;
        b=Yi7D5h0d7WDZJcxo3lxr4gbmj2NyfxWHUPL4LRri2NBjGhdfekr0/6Ab4qdLGEc2BM
         73TXRa0tpDkdB48Y0v9K8N3XHniV6wlmu2V514DAL0ND8L1OYezIWbXY3gKDXglecYHy
         lWVysbQJty0higAXCtNlIgNDUDAIrWolPU+XriAxsaVZRtYy8h2W5s13jcNrKnFgNHOi
         5eiFxssa0KJP4s+lZPQghSg9UnTaN3C7wbZ4+1WMWSBqB9u8wEawyBMOFOIt6vRpiDpl
         0IpnR8Yf0fJ2h/bF6LtwtLYi1TdMGrhA5bQ2mL68msnZjjbR2FHtbaLQU0Id2iWyr/BQ
         SLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVthYXZK7tK7swS5wdbkv8WZyai+tggojXvA9sv4ChKPNBSYQIlcxsh3vQmqxnE/u4BA7gGZ/LSHneXHJteCylje/G73uBKIGPKfWc=
X-Gm-Message-State: AOJu0YwJAIVSftxcvlgsfwER5dBEEKXCOzrqYxYHkwqF7K/UHnFCk8vG
	0mK3jAlErzFOON2F+NBuIEPHMFpIlU+pcKb+YeuC/P9ezRK9Q8UdwJLZLuBb881qcGz2aGcklwn
	Aio6HDIPfC0QqlOcJqqMOPlqVT7Mf7wpXD6Emkd7uLc3Y7kBHdN+Z+uuJ0sSLFMkg+VO6/WY=
X-Received: by 2002:a17:902:ecc4:b0:1dd:8f6:69ee with SMTP id a4-20020a170902ecc400b001dd08f669eemr12105089plh.20.1709824586283;
        Thu, 07 Mar 2024 07:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFeqqO13RNZOBuElM9XVsP4yRu2BZGZcUUvMyWoakciyNzXFKfBQCybZBmZT2MgZNewLWW9w==
X-Received: by 2002:a17:902:ecc4:b0:1dd:8f6:69ee with SMTP id a4-20020a170902ecc400b001dd08f669eemr12105058plh.20.1709824585829;
        Thu, 07 Mar 2024 07:16:25 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001da15580ca8sm14715056plh.52.2024.03.07.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:16:25 -0800 (PST)
Date: Thu, 7 Mar 2024 23:16:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] common/rc: specify required device size
Message-ID: <20240307151622.warzurzdxovxh2gn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1709806478.git.anand.jain@oracle.com>
 <c74dc3a6f1dc8d45bc54ef6ac087e5e92a778509.1709806478.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c74dc3a6f1dc8d45bc54ef6ac087e5e92a778509.1709806478.git.anand.jain@oracle.com>

On Thu, Mar 07, 2024 at 06:20:23PM +0530, Anand Jain wrote:
> The current _notrun call states that the scratch device is too small but
> does not specify the required size. Simply update the _notrun messages.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

OK, I think that makes sense to me.

>  common/rc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 50dde313b851..5680995b2366 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1834,7 +1834,8 @@ _require_scratch_size()
>  
>  	_require_scratch
>  	local devsize=`_get_device_size $SCRATCH_DEV`
> -	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
> +	[ $devsize -lt $1 ] && \
> +_notrun "scratch device $SCRATCH_DEV should be minimum $1, currently $devsize"


>  }
>  
>  # require a scratch dev of a minimum size (in kb) and should not be checked
> @@ -1845,7 +1846,8 @@ _require_scratch_size_nocheck()
>  
>  	_require_scratch_nocheck
>  	local devsize=`_get_device_size $SCRATCH_DEV`
> -	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
> +	[ $devsize -lt $1 ] && \
> +_notrun "require scratch device $SCRATCH_DEV atleast $1, currently $devsize"

"at least"

Why don't output same message with above ? And why not have indentation at here?


I think the message is long enough, so the $SCRATCH_DEV maybe not necessary,
how about

	[ $devsize -lt $1 ] && \
		_notrun "scratch device too small, $devsize < $1"

(same above)

With this change:
Reviewed-by: Zorro Lang <zlang@redhat.com>

As I've given review points to patch 3/3, so I suppose you can change this
patch with the 3rd one together :)

Thanks,
Zorro


>  }
>  
>  # Require scratch fs which supports >16T of filesystem size.
> -- 
> 2.39.3
> 
> 


