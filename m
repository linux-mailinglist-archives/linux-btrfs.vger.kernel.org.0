Return-Path: <linux-btrfs+bounces-16936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D38A2B85EF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 18:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09A73BCCB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D13081D4;
	Thu, 18 Sep 2025 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djP6DNQy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D1220F5C
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212154; cv=none; b=IbY7ATmAEJih9tleGTypDPMaD40J9G7orZqvUj66R8JnKPoEG5vpYryerjuo32+yCvZCtKLO6DnDEpSVa0VZ9A+MPpOT7QwKwpIbTid9TQVWtu+dAez1j6gfeED3kDX2G5EbxcGdvOc+pVgdSdUIcf+KFp+Ff53VPNpbUwWGOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212154; c=relaxed/simple;
	bh=BBcXkF218h/n+sjdRsmTt/qgF2tdpx7WgyO2AZNvKaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Y3Qs4sLMeHn8Dj0y9i7/4JWDBrSVZietqAjJEklEkLMYt9oPcp11OypxN1XX5GJmA0/17Pr+EDvW1RVUXtUVP9q+ODEEIq8wVmd3RhcquXmRGK5DNj93kgQ+8rX/4uBLl9E6o6Ca7V87M3pJjd89htU2S7I5mGtt187Kuxvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djP6DNQy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758212151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHi0Djn9pjoeuw2kAszNHnpCYY5ix2jYe9lxD0wWsrY=;
	b=djP6DNQyT1UuTOmVp5EGS9xbSQJjfadZD9iO2+VctiO/fI8eR2XvDmPRGHluwuvf8PzjoX
	lAQh5Y1V7AamwdqYVemCXVj0x4KfB4ZPPtsCHFPmXpwy96XpMbdyEsNeia6lGFHH2PWsp1
	xVCEsZR+AvdXdeNaIryuIGjKo6dH1NY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-le5oOT7jMqmPCtKXk7Zf2w-1; Thu, 18 Sep 2025 12:15:48 -0400
X-MC-Unique: le5oOT7jMqmPCtKXk7Zf2w-1
X-Mimecast-MFC-AGG-ID: le5oOT7jMqmPCtKXk7Zf2w_1758212147
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2699ed6d43dso6459165ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 09:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212147; x=1758816947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHi0Djn9pjoeuw2kAszNHnpCYY5ix2jYe9lxD0wWsrY=;
        b=MMggXi58pZALkXKz1fmr8ktgZoUEzMXuCyYV0eTIrUOdOAd7yJmDTDIiXdQAVX+dMh
         012l0LbiODHyyS8gO7aYfAkf7MSZMuHYkTl3J77LXYX/6tvklk3QDUktJjTVfP4R6aYR
         VBy+nGGfLvthu7WlB5N8NRuX7q1B7s4Tm25Ebs0GDwUuoN5ClWENCUw0KqruhWqqrFCJ
         1A3Lmz7ZnjQ3Q+K+j8hNS1RAXikSlA7BI+6WP2FGiGlNTA9GVyyhc2F9NXMu/+y4Np/u
         N6tegFkMzgtNpuI+2tCcuAF4ytULNh3wSsSZmu/hru2LPrKw2NJVDoHO70C8hHANSo0M
         q0rw==
X-Gm-Message-State: AOJu0YykGNb9xFtSmOKvmGhzzJ20QWoNQ8wFssN4H0KhK1ARx4zhkd+9
	G4/R2UGQSiOwo/DMhdstsGKfS69y1RCx3yJTuCAN+gG4PFP/gKY1BSsmyoyHEUs+mgG2yyo8oHj
	qInL+EgRuPeJD/MLrarnOhUx9PRf5Zk94JckpW/br3q7Utg6d8eNCuUIXDM1373IxrdoX5Kty
X-Gm-Gg: ASbGncuctgZHbK07HGJQfrTdNGcWTpOYLbog7IaReBr2/vxUImCMi+LhBQra/FUq2X8
	EiKoXmIUfPVLKyUm6Tk8qqWAPymsK1dZ96lTR6XZvgRL2E+6+8d5orRIVUGqKzqpcbfC6ODd0RM
	Fqy8Bi5vOdXnU7OCpWMAEcfCR0Y6lFYqXfU1Ttrh0nv0sMz+kNl9rCc2EEyvmX5CM5nWX0AJMjD
	XKyI8GkD+nPOgzrsCZe0h1+hrnys5Eqzngn7q8cR7zqWw7DIlRMeYMV9ABMiLK6FZcqmdGXRTtd
	QSJ4/xc7JVPHKgM4EAQq5/IlewyRTT8f2l2xiaBYc8yfDWAHRlynfKHQSm2etOt5dotjgyD0dEC
	W9aet
X-Received: by 2002:a17:902:ef48:b0:248:6d1a:4304 with SMTP id d9443c01a7336-269ba50119amr1725415ad.38.1758212147234;
        Thu, 18 Sep 2025 09:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLU7pgjoAnL3Ri3kP/kIOmI3SEhjxxYClOXShBU7Aiqq9kw1kyHDtTZrQxJqAji3pow1cQGQ==
X-Received: by 2002:a17:902:ef48:b0:248:6d1a:4304 with SMTP id d9443c01a7336-269ba50119amr1724915ad.38.1758212146704;
        Thu, 18 Sep 2025 09:15:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980331eccsm29776065ad.123.2025.09.18.09.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:15:46 -0700 (PDT)
Date: Fri, 19 Sep 2025 00:15:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: reject fs block size larger than 4K
Message-ID: <20250918161542.a432gwgfzzbxz4rc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250918103226.99091-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918103226.99091-1-wqu@suse.com>

On Thu, Sep 18, 2025 at 08:02:26PM +0930, Qu Wenruo wrote:
> [BUG]
> When running the experimental block size > page support, the test case
> btrfs/192 fails with the following error:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMPT_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
> MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> btrfs/192 436s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/192.out.bad)
>     --- tests/btrfs/192.out	2022-05-11 11:25:30.746666664 +0930
>     +++ /home/adam/xfstests/results//btrfs/192.out.bad	2025-09-18 18:34:10.511152624 +0930
>     @@ -1,2 +1,2 @@
>      QA output created by 192
>     -Silence is golden
>     +ERROR: illegal nodesize 4096 (smaller than 8192)
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/192.out /home/adam/xfstests/results//btrfs/192.out.bad'  to see the entire diff)
> 
> Please note that, btrfs bs > ps is still under development.
> This is only an early run to expose false alerts.
> 
> [CAUSE]
> The test case explicitly requires 4K nodesize to bump up tree size.
> 
> However if we use fs block size larger than 4K, the node size 4K will be
> smaller than a block, causing mkfs failure, as block size is the minimal
> unit for both data and metadata, thus node size smaller than block size
> is illege.
> 
> [FIX]
> Before calling mkfs on the log-writes dm device, do a simple mkfs and
> mount of the scratch device, to verify the block size.
> 
> If the block size is larger than 4k, skip the test case.
> 
> And since we're here, remove the out-of-date page size check, as btrfs
> has subpage block size support for a while.
> Instead use a more accurate supported sector size check.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add the commit message on why we can remove the page size check
> 
> - Use _scratch_btrfs_sectorsize() so we do not need to mount/unmount
>   scratch device
> 
> - Add the missing _require_btrfs_support_sectorsize call
> ---

Hi Qu,

As this patch only changes btrfs/192, so the subject is better to be
"btrfs/192: ....", due to "btrfs: ..." makes me think it changes lots
of btrfs cases, or it's a new btrfs case :)

Thanks for you fix many issues about "btrfs 4k sector and block size",
I saw you keep sending more patches about that, I think you're working
on this thing recently. Could you please put this patch and others
"btrfs/304~306" patches or more if you have in one patcheset. Then I'll
know you've done all you want, and I can merge them together :)

Thanks,
Zorro



>  tests/btrfs/192 | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> index 0a8ab2c1..a9a43cfe 100755
> --- a/tests/btrfs/192
> +++ b/tests/btrfs/192
> @@ -33,10 +33,15 @@ _require_btrfs_mkfs_feature "no-holes"
>  _require_log_writes
>  _require_scratch
>  _require_attrs
> +_require_btrfs_support_sectorsize 4096
>  
> -# We require a 4K nodesize to ensure the test isn't too slow
> -if [ $(_get_page_size) -ne 4096 ]; then
> -	_notrun "This test doesn't support non-4K page size yet"
> +_scratch_mkfs > /dev/null
> +blksz=$(_scratch_btrfs_sectorsize $SCRATCH_MNT)
> +
> +# We need 4K nodesize, and if block size is larger than that mkfs will
> +# fail. So reject any block size larger than 4K.
> +if [ $blksz -gt 4096 ]; then
> +	_notrun "This test requires block size 4096, has $blksz"
>  fi
>  
>  runtime=30
> -- 
> 2.51.0
> 
> 


