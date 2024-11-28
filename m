Return-Path: <linux-btrfs+bounces-9953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CA49DB89A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CB1B238CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87171A9B40;
	Thu, 28 Nov 2024 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHnk/0Z/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDC1A3BC0
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800474; cv=none; b=EuFRb5RBgkONVXjzGbAFJfCsObFHnBbFZ9xCwp5F+pDoRD4kUjgvp0pdB7NIvGwaPkqduDsNzhthv4DXii7TYTD+Ex/JfJcuTRZPaj8jaGIlBiGW02EFSDwvZtvYXsT0eIat57jKQDPOd+fUA2r3vynGago1vUGyrj9CBHnr/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800474; c=relaxed/simple;
	bh=0s+yPItt2IrnjpQXbpel93eG29xJ3JXukb8NY6yCfIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXQCgth2BSnY5JbmANCyx0RW8/6dJa4XkI/OpJjcgd5z19C9tB2WIm0I2L8FefnxjD1W6hkwxpI05sJ2Ln2p2xnnGU05WrWSg8X3WPgrCqN0fwcZZTgMvRjDgRlU91ZJbBys8b8gINKxT+Eudygf1YxEoSDTY8+PjudJ7YxjH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHnk/0Z/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732800471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iTZ4q6mzizq8FBezBiN/RuDqSjRE18Wk055DMNaJqk=;
	b=YHnk/0Z/g4lXvRvVd0GsCT21AJSkNDLUtY1v7KQ+GkaguGTFeGBaDkQ6YqPS7yU8oPPLkD
	2QDG3BxtpdsgjalqwwmzU1ePc6gFBIYb1wo+0Vv86US/GIKIC6BNCh/hqlBUVvQrr/Itx2
	0q+a9mZdESH0AVfhkJYGfZWi6M55e/Q=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-xPbNCm1eN_m1yrj8uxn23A-1; Thu, 28 Nov 2024 08:27:50 -0500
X-MC-Unique: xPbNCm1eN_m1yrj8uxn23A-1
X-Mimecast-MFC-AGG-ID: xPbNCm1eN_m1yrj8uxn23A
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-724efa5d35bso781028b3a.3
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 05:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800469; x=1733405269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iTZ4q6mzizq8FBezBiN/RuDqSjRE18Wk055DMNaJqk=;
        b=LGn/VQVfrbHd07FYnPYYz08Jo15KbMUdVGGsDOEXWbfvWAin2/99iXcJBbEDKVOjMA
         voS6iNmpzTg0szSIS4VraczEAWYDIg2vZ6RwVboNNTvLHD9ZFL6gSlO7foAYp8YIQuTS
         cAnAmtY+GQv2YJEYjlVketAOudfP+5AoDEQcD4pF6xAN556YN+iuqAZm8G3PxbhKhOt9
         nHvx5QpY/mu2LNm7QHdUQ6UH26CmdQekIhPd2g8RU3d5vGtAKJOk4EFJzYhBBdsAjN0i
         jo8Ci69DXswWrnU94MJdmA95IBJ6J3Zi6ugOH31gvdSkYh8LCePFx9n/UAKwWkHTi9ER
         yx/g==
X-Forwarded-Encrypted: i=1; AJvYcCVWGbT8G8+4EE0m2/gN69h30FfnHnqAo11RioxMYCFfxskMKXOCjqnpmzvr+Luu3CCw0h59XSFekvOmnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Ot6fGDzSvCbDt0JZ2FHVabfHcEEbn7K+qC0jKlSi4oqgo/k8
	y4ACMsijdrqbLRR2/ePeHnu+Hqok+smQnnsDgmVULtA+4EKpB0Qmkf0TwEdI/cVoRJo5UPn+H4K
	SrYXsCByBcFgagz+aFvKVNXS9DAA+bFCmZt7fiLYJyke5PQqtwi0JmVyAxXPY
X-Gm-Gg: ASbGncvMzuM+wqtPlCEPQysz7FbZNQiQEruDpj/c5IHsraEfNA1n/NxxzMBm//5bKQD
	SirU8708C2kz5xS3wq/scti/pMN/MqT9YcaLiqQEs0yVwRGpNeR3r5bnfgvXu3wm/IFmbwaqJ20
	+aoQvydVkMcq/3Cy+pT50DesJxK/M6jPJoan7VyucXDdfPAERLDzjhUj6q/RfrvQ1wxsdf3pspe
	K5kDq/2qNKwaJyGuViniShyjcGvfeRKqqzoEwTlm+iWfQyukn3hkIWQBAQlKRW+l8RGiA3Mzg2i
	oQt5XZnwajQbDdw=
X-Received: by 2002:aa7:88c3:0:b0:724:5815:62c1 with SMTP id d2e1a72fcca58-72530133103mr10355859b3a.19.1732800469032;
        Thu, 28 Nov 2024 05:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvxPzHHwe3CTbSVYUKhipTOHl9LrWX8JcWHdp6FLY3nKR68fErJvX10PPr4XgWQ3xD6wEocg==
X-Received: by 2002:aa7:88c3:0:b0:724:5815:62c1 with SMTP id d2e1a72fcca58-72530133103mr10355835b3a.19.1732800468655;
        Thu, 28 Nov 2024 05:27:48 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbab6sm1528891b3a.106.2024.11.28.05.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:27:48 -0800 (PST)
Date: Thu, 28 Nov 2024 21:27:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/028: kill lingering processes when test is
 interrupted
Message-ID: <20241128132744.n4mryf5cw2bqojuy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <7a257c21d2efe2706bac1f2fac8f7faff1d0423f.1732796051.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a257c21d2efe2706bac1f2fac8f7faff1d0423f.1732796051.git.fdmanana@suse.com>

On Thu, Nov 28, 2024 at 12:14:56PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we interrupt the test after it spawned the fsstress and balance
> processes (while it's sleeping for 30 seconds * $TIME_FACTOR), we don't
> kill them and they stay around for a long time, making it impossible to
> unmount the scratch filesystem (failing with -EBUSY).
> 
> Fix this by adding a _cleanup function that kills the processes and
> waits for them to exit.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me, I think I can help to unset balance_pid and fsstress_pid
if these processes have been killed before doing _cleanup.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/028 | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tests/btrfs/028 b/tests/btrfs/028
> index f64fc831..4ef83423 100755
> --- a/tests/btrfs/028
> +++ b/tests/btrfs/028
> @@ -13,6 +13,19 @@
>  . ./common/preamble
>  _begin_fstest auto qgroup balance
>  
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	if [ ! -z "$balance_pid" ]; then
> +		_btrfs_kill_stress_balance_pid $balance_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>  . ./common/filter
>  
>  _require_scratch
> -- 
> 2.45.2
> 
> 


