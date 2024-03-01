Return-Path: <linux-btrfs+bounces-2967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F281786E2BA
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 14:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A8B222D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8126EB56;
	Fri,  1 Mar 2024 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ys5uP7E9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234C6A34F
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300963; cv=none; b=cO3gbchMqFzlqCPXNrywLGGgUBXWMM4cEpJVTDPbC8Rs2nTy6ijKAnXexWj/Upzs8Wv5v+I7GyhWn/QnlAeVlTCk03CycelSPxXANvzMfHTwd7+p8zG5EbY95Eh1xxXsNvnZnT17FX8/KXWX+OGjixeQo/8+EatXfU3q7x4KzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300963; c=relaxed/simple;
	bh=kt/MYYIYath996sVK77LDTlMApYAUJGsJoWE61kDawQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJzpGnszbhYMUzhHPg8C5IjhDrqzTDsx8zCKF4scOJttp6gQAXbWDp1IO4DjeVzpGVgbSAg1DF9NLKTauo1Q49/1VNMZb0n+hEjFtmyKwLQWtWeBSxyi8R74QKzRhWobWXfJ9WJXJywn5FMS8KWXGi4+B0oywfYwfHc8ovXQbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ys5uP7E9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709300960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98e6wUklDvzqenc0B1oy6bnXiDvTsJRgWDDTG8l16ks=;
	b=Ys5uP7E9sOcDCCdltCP69hRE9jXPiBTsXcKHZO6L61MNtA1hjquTSQTvnq1idMiXEX3XXo
	09Uq0L/Tj/tyV1drVWB956qyWqIYoUmxfaTz2DuZ6YmAWW6Q140PhQl+2lhyhjvQ4zHL2R
	iN8XcoY943XT3RcIIIJvilRd3lSck30=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-HlaK7OyoP7ipWX4zr5HFOg-1; Fri, 01 Mar 2024 08:49:19 -0500
X-MC-Unique: HlaK7OyoP7ipWX4zr5HFOg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6e483b91946so1461202a34.3
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Mar 2024 05:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300958; x=1709905758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98e6wUklDvzqenc0B1oy6bnXiDvTsJRgWDDTG8l16ks=;
        b=vdi36m6o7H/BBD8uH0tYAkFPJEYLUs1CXGb0YTzbT7Qn6WzZaTU4wsI4bd8NXkfy/j
         iHym+BzEwxk0vDse4tcjO3mwpcLwYtuyJM3PvmW/f30NIxyzd8xIJdYHCY3nKkJafDGq
         ABpsv38Zwv0KRfLuMgFJelK0l41Arz4cyXnAyvwvfSsmr+7vjRNa78RWG0PtI0sx71cT
         QfTXjmw7ZRZmed0TlwWO1R5rs01oMH+0zNFamWvgt00s/irob4OK2lNs67hGOKOi6aF2
         dAreBPpvRaXbT8XX/zzTLtOHIb4f6rRH+6HKbvVdXg2k5UcxACOz55+gg9BoHDJ8gcvh
         2Fpg==
X-Forwarded-Encrypted: i=1; AJvYcCVRoIR14YiZETGnIgp7XoZ1RdkaDDNuTpPVl5YpHOmU7l7EFKuhF1daXOoyzwqyBBtrsYDn056Wq1OFuLH5Pwqrl4goFXI84sKnsYM=
X-Gm-Message-State: AOJu0YxYYXmY22Xih+sC5CpDangtqMsgzXISlORqw0gY21zEmuipW9rX
	+k6w/j1EFW7QGj8HagUHNjjWhAO5A4umWBABzcoVFSrYcx69r337T1YU6YMAv2p2n4JlExIm5ie
	Uqocu9hj1GAL02yxDYjdfBuLWhQLo76TZPY2gYg+GmXBJSC/TUAeyilyq1DtV
X-Received: by 2002:a9d:7403:0:b0:6e4:4393:8565 with SMTP id n3-20020a9d7403000000b006e443938565mr1760568otk.25.1709300958394;
        Fri, 01 Mar 2024 05:49:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV0scFE61jnMLvTPZoaIdXZXWbpAhPTKWAGKHw3DYjV4u2Tx4jnhEIr8J0f7KR1NfxFn4pAw==
X-Received: by 2002:a9d:7403:0:b0:6e4:4393:8565 with SMTP id n3-20020a9d7403000000b006e443938565mr1760552otk.25.1709300957998;
        Fri, 01 Mar 2024 05:49:17 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i37-20020a635865000000b005dc5289c4edsm2975181pgm.64.2024.03.01.05.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:49:17 -0800 (PST)
Date: Fri, 1 Mar 2024 21:49:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Su Yue <glass.su@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, l@damenly.org
Subject: Re: [PATCH] btrfs/172,206: call _log_writes_cleanup in _cleanup
Message-ID: <20240301134914.dgcv4vh2jbx2egfp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240215140236.29171-1-l@damenly.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215140236.29171-1-l@damenly.org>

On Thu, Feb 15, 2024 at 10:02:36PM +0800, Su Yue wrote:
> From: Su Yue <glass.su@suse.com>
> 
> Because block group tree requires require no-holes feature,
> _log_writes_mkfs "-O ^no-holes" fails when "-O block-group-tree" is
> given in MKFS_OPTION.
> Without explicit _log_writes_cleanup, the two tests fail with
> logwrites-test device left. And all next tests will fail due to
> SCRATCH DEVICE EBUSY.
> 
> Fix it by overriding _cleanup to call _log_writes_cleanup.
> 
> Signed-off-by: Su Yue <glass.su@suse.com>
> ---
>  tests/btrfs/172 | 6 ++++++
>  tests/btrfs/206 | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/tests/btrfs/172 b/tests/btrfs/172
> index f5acc6982cd7..fceff56c9d37 100755
> --- a/tests/btrfs/172
> +++ b/tests/btrfs/172
> @@ -13,6 +13,12 @@
>  . ./common/preamble
>  _begin_fstest auto quick log replay recoveryloop
>  
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	_log_writes_cleanup &> /dev/null

This _cleanup will override the default one, so better to copy the
default cleanup in this function,

  cd /
  rm -r -f $tmp.*

You can refer to btrfs/196 or generic/482 etc.

> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmlogwrites
> diff --git a/tests/btrfs/206 b/tests/btrfs/206
> index f6571649076f..e05adf75b67e 100755
> --- a/tests/btrfs/206
> +++ b/tests/btrfs/206
> @@ -14,6 +14,12 @@
>  . ./common/preamble
>  _begin_fstest auto quick log replay recoveryloop punch prealloc
>  
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	_log_writes_cleanup &> /dev/null


Same as above.

Thanks,
Zorro

> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmlogwrites
> -- 
> 2.43.0
> 
> 


