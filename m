Return-Path: <linux-btrfs+bounces-15010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FF6AEA7B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 22:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125D01C454E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596762EFDA0;
	Thu, 26 Jun 2025 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dckymd40"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D02063F3
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968348; cv=none; b=YPRhnr7aWCd1Fr+QDfv2dx3Qk8AKKqEJfRmtLilkVqbBy/KWwNnYY+2Mjdrev4VW7rnnq+r1/iAb8SRJVTg2xgUeeu2ri1LMoYm30/JQeQNc8mZh5tSQxlkKJOtuQyzLFhX3s8mi5OiG711+E1QFZx2jRW0q6PR9k2R/vC/tHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968348; c=relaxed/simple;
	bh=TvDGSZSvh3879TYSdRuqN8GByKe+rD13D8ChHA3yz80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwb4r2QPSxmWSMDykTgc3yUzZYlf0y7+5gojYzq5RDzXxjhWNWY4XfSyxrvfyXCha33OOQfshdFJRE+asq6jsj2La6v3x0EnsZlbPjSbG3FIVTIwYxsvsbLI8suYQ0sGEZhL9VTnJ+LAbYYha5mSDeeAd0KIkecYbCKMjzY2Sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dckymd40; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750968345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wMWh8rbintp8UAcpY16jcEK30xjRW0K/vW0loiYEMA=;
	b=dckymd403vx5JILYbgz0hFwa96STXGG2mm7nBg+1Ek31Sq/mEWA14np+6Qv3HO1CvdcLrq
	jQ9602rk1/Nux62t7G1eRVPty63EW4AAvmIcH4CQy04S1NqLnWURGv0+19BHDB+7aJ6y6Z
	bNJQDB37Hzjrd7AA1DjjluKTE8IG96E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-ls90H1CaPpSyWRmn-P0zWA-1; Thu, 26 Jun 2025 16:05:43 -0400
X-MC-Unique: ls90H1CaPpSyWRmn-P0zWA-1
X-Mimecast-MFC-AGG-ID: ls90H1CaPpSyWRmn-P0zWA_1750968342
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313fab41f4bso1908313a91.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 13:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968342; x=1751573142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wMWh8rbintp8UAcpY16jcEK30xjRW0K/vW0loiYEMA=;
        b=K8E9ZajLdRD7WeJvbAuB3mYo0VCtCiPOdPW0DF40do52LYLixn8Qk0GEMcT7CnhoJ7
         Ftt2fwADHrWHeKzbslhrvQL6f+GQ/0G5P405dSrB5ttuwgvnWOsffN9mR2rjF/Jb4HNb
         IwgZRXeCFsf7blgXbnajM+FUw6LmMP9SzUMQscT3DsIFsURIBDzTLVz4hPUUXVj4LjKX
         pfoTCMtxY3afrpRbRmUDrzvwlsGKWfF3vVsUSmFHDPi9tGe2/wGLyAG4JwluYDL9QrE7
         tAgQ7LPMnTorNQ6Dp4xzcdenUmAFugu3Fwu5z+h/dxCF65YdbZYzBxuRa0aqbHiVcbG+
         0Dbw==
X-Gm-Message-State: AOJu0YzGzU7RauQrLl+wi3tskL/8RXzXnPYd8jtJBfS5wpfJYGl2P8jf
	as7tLehaJqAaIaVsJTJzdF29L11jyTXqJNaLlU1Rqcw+A7sZIgKQP+NZWbJ4mJcQMBq3RnSNKeM
	uO7xy2/PubYJMx1c3TYej/u95ySrOilIBpMOt5Q2Av0bkKNWDg3S1MmNzfdSfIfHbCxRThXdqTw
	g=
X-Gm-Gg: ASbGnctcseV9iHs06WZvYyXEHbXbhzT5sV/3tDW6CRxES6Ex9q4vTz1Bw2p/oFt59jB
	Z0zm22AQWJ1m13PzUlvdcmt6sXRagGTsWCjRNaaw6TRbcPPfFZ7olexCLK2CIxtFQ8HIn0B7cgK
	nU1c38jWV42xbzQRNB8aEq8zsXGJdBvRcRQFQG+6swaR5yxaahL/wRhXJsKws07AdGxEfBRr1AD
	elvH172/aL/iNsuMOZ17Q7OVQ/salgb23i+DON6ranwE8/yzxLIvakGZ9oJ+7emGkyNmny0oCVx
	biOa1MdAkodax2uoztRsMGDZZw8CW0szqZC9UXE/7ETtXyVIqXkDIKP7uNA4BFE=
X-Received: by 2002:a17:90b:3890:b0:313:1a8c:c2c6 with SMTP id 98e67ed59e1d1-318c92ec03emr450982a91.16.1750968341862;
        Thu, 26 Jun 2025 13:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqyPAoteVdX367pYrKF1RsNrtPMDsZXBrkPqug9AvpshXmzgDeX3G9SEO3Xtzm+CU+L7SLVA==
X-Received: by 2002:a17:90b:3890:b0:313:1a8c:c2c6 with SMTP id 98e67ed59e1d1-318c92ec03emr450946a91.16.1750968341431;
        Thu, 26 Jun 2025 13:05:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13d4bc3sm494501a91.21.2025.06.26.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:05:41 -0700 (PDT)
Date: Fri, 27 Jun 2025 04:05:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: add btrfs support for _small_fs_size_mb()
Message-ID: <20250626200537.pijg3htihst73sgy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250625232021.69787-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625232021.69787-1-wqu@suse.com>

On Thu, Jun 26, 2025 at 08:50:21AM +0930, Qu Wenruo wrote:
> [FAILURE]
> With the incoming shutdown ioctl and remove_bdev callback support, btrfs
> is able to run the shutdown group.
> 
> However test case like generic/042 fails on btrfs:
> 
> generic/042 9s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//generic/042.out.bad)
>     --- tests/generic/042.out	2022-05-11 11:25:30.763333331 +0930
>     +++ /home/adam/xfstests/results//generic/042.out.bad	2025-06-26 08:43:56.078509452 +0930
>     @@ -1,10 +1 @@
>      QA output created by 042
>     -falloc -k
>     -wrote 65536/65536 bytes at offset 0
>     -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -fpunch
>     -wrote 65536/65536 bytes at offset 0
>     -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/generic/042.out /home/adam/xfstests/results//generic/042.out.bad'  to see the entire diff)
> Ran: generic/042
> Failures: generic/042
> Failed 1 of 1 tests
> 
> [CAUSE]
> The full output shows the reason directly:
> 
>   ERROR: '/mnt/scratch/042.img' is too small to make a usable filesystem
>   ERROR: minimum size for each btrfs device is 114294784
> 
> And the helper _small_fs_size_mb() doesn't support btrfs, thus the small
> 25M file is not large enough to support a btrfs.
> 
> [FIX]
> Fix the false alert by adding btrfs support in _small_fs_size_mb().
> 
> The btrfs minimal size is depending on the profiles even on a single
> device, e.g. DUP data will cost extra space.
> 
> So here we go safe by using 512MiB as the minimal size for btrfs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Makes sense to me, thanks for fixing this test failure.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index d8ee8328..2d8e7167 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1195,6 +1195,11 @@ _small_fs_size_mb()
>  		# it will change again. So just set it 128M.
>  		fs_min_size=128
>  		;;
> +	btrfs)
> +		# Minimal btrfs size depends on the profiles, for single device
> +		# case, 512M should be enough.
> +		fs_min_size=512
> +		;;
>  	esac
>  	(( size < fs_min_size )) && size="$fs_min_size"
>  
> -- 
> 2.49.0
> 
> 


