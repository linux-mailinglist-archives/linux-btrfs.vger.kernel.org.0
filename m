Return-Path: <linux-btrfs+bounces-774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A513E80B20D
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 05:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AA41C20CE2
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 04:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5FC17CA;
	Sat,  9 Dec 2023 04:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqQiXE+f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02D31AD
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 20:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702096880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mWHZcXaAmj/5u7LgLw6LKkZfHWgV29XQk0gJ0hZWpY=;
	b=VqQiXE+fToQNQl67rB6KED4/wYiH/FYAaJQPotSkhra8fsitFH6B/BVk7COhUzei6NbnVl
	05RcyLCee8BKPtbUupJL7u2Nm+0/5Ke0pl919zyN1EIDm0pkcfs3weEskVNTHi/VmOJvqG
	elej2dvzk34uVl+1qkHdKyjYPgLr+9s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-ACGPDO8PN06FQPOdVwuIMA-1; Fri, 08 Dec 2023 23:41:19 -0500
X-MC-Unique: ACGPDO8PN06FQPOdVwuIMA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2869d112802so2743860a91.1
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Dec 2023 20:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702096878; x=1702701678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mWHZcXaAmj/5u7LgLw6LKkZfHWgV29XQk0gJ0hZWpY=;
        b=sUyhnsTfECXNpRLEERs4QiKZ9bUFWVEJ0IM+AdNVXgHj7n+bHygY+NOwdio2rcA8rF
         gXf+DGbH4Ax1W/25abWFDA6rDsyXj6AsrFkpDSJokeR5m6s0aheH9tJwmqeuonkIEUhV
         ud+3iU13J7UtWkYoyVcgoOSl40QKrWsEo6gS8wO2MKV+WrZZBeSvJQjQYFDAfakIivPz
         jsaX/cMUJvFv1OaJkq+yfHcttmS9RLHBLohf7dcVpuEcpqj+dmg0eBWYr4FagoQdVQ0b
         uWvsz7ndUBsIXSUlP4/SKd+bGW5YOcVzRm0k39EPwS4k0aqTXNDyDGC5aeo6QkhCg6AO
         U+MA==
X-Gm-Message-State: AOJu0YzIUw1AzNNBGp6CVGFVtOvi5fDkltX7aLNcjnNbqyBLQrn7GpMO
	abE4WDtCjuew6fX+uFldfkrXS0+Z9/V01lAWL6HoDRtWsyKS33t3ipumlNVtRkq3fYWOcDe/+c6
	zSxCtkNgqOMNtRXlhkTHJflU=
X-Received: by 2002:a17:90a:246:b0:286:6cd8:ef18 with SMTP id t6-20020a17090a024600b002866cd8ef18mr2075177pje.48.1702096878402;
        Fri, 08 Dec 2023 20:41:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUDHO38yZH4Tnbskvnqzmjd3UyZ0cZQXqt8FyXBuY33QNAIZnR9Duur8L535btVrIc5l2h0Q==
X-Received: by 2002:a17:90a:246:b0:286:6cd8:ef18 with SMTP id t6-20020a17090a024600b002866cd8ef18mr2075171pje.48.1702096878047;
        Fri, 08 Dec 2023 20:41:18 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bv190-20020a632ec7000000b005c2967852c5sm2363820pgb.30.2023.12.08.20.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 20:41:17 -0800 (PST)
Date: Sat, 9 Dec 2023 12:41:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/303: add git commit ID to _fixed_by_kernel_commit
Message-ID: <20231209044114.znk5wbl5fuwgf5hr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <a61891b7afa408c39921c2357d00812292068c9e.1701858258.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61891b7afa408c39921c2357d00812292068c9e.1701858258.git.fdmanana@suse.com>

On Wed, Dec 06, 2023 at 10:24:44AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The kernel patch for this test was merged into 6.7-rc4, so replace the
> "xxxxxxxxxxxx" stub with the commit id.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/303 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> index b9d6c61d..521d49d0 100755
> --- a/tests/btrfs/303
> +++ b/tests/btrfs/303
> @@ -15,7 +15,7 @@ _begin_fstest auto quick snapshot subvol qgroup
>  _supported_fs btrfs
>  _require_scratch
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 8049ba5d0a28 \
>  	"btrfs: do not abort transaction if there is already an existing qgroup"
>  
>  _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> -- 
> 2.40.1
> 
> 


