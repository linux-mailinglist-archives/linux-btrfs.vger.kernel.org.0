Return-Path: <linux-btrfs+bounces-17238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB740BA715F
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 16:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD8E3BA70F
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6BA214A93;
	Sun, 28 Sep 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5vd0pcH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53520C038
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759068566; cv=none; b=RWt85pTv3fHGBluv7edhHfmsdign4D9zgJsqXHej6K+U9Bv7Lo20MynRfUTXgtH0nK/ZE/Uu+jKqeKAisUOV3pVDrHSH3QA71vUiMLvjIHRIU1QO2UCP0s9RPVXr5h39SY+MuHS7fyQ5Zbv/wsRmZu/d4qyo0+u2q9IeAY+JNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759068566; c=relaxed/simple;
	bh=HIv9fxeKoLpkODQ6gx+4GUvWUiSEZp3tB2+TUXxAHmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMzF0vr8nA+khIPcHOzKNFetCcPAS6przlQeJKKdnZTfKhDNn1C+X5M5eDtNjFlO056vq/qk065MfSN2QAsitBejLzoxHRLm83Ii2NU2elry6jx9sUgzbNM3rDe50kp00UVURPMVoOOriETTAImoWi9KhOcUDIYIX1hX6txUNMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5vd0pcH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759068561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7phqQjkQjET3LfaZXC37tPIuWA1DfFBJL3a2NYjcDU=;
	b=T5vd0pcHgFekO4Uez3Q/4AbnVoRxVFtZvPArUYdd78ZOjDJLvHERSzj5zzZeYHh3gvECsj
	fMepyAJVp+Kkm5WfA9j3oFwV6vlbdLymstunmPTr/QOR3qFQj8/lSAEbpBFu1Xp0ZkdfnN
	NPfbbbFhe7z3GYFzNeTiw0LHVlVn29k=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-sb4CzQtGMIq9wJhqQUui4Q-1; Sun, 28 Sep 2025 10:09:20 -0400
X-MC-Unique: sb4CzQtGMIq9wJhqQUui4Q-1
X-Mimecast-MFC-AGG-ID: sb4CzQtGMIq9wJhqQUui4Q_1759068559
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-781269a9049so2301850b3a.2
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 07:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759068559; x=1759673359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7phqQjkQjET3LfaZXC37tPIuWA1DfFBJL3a2NYjcDU=;
        b=V1Xk2rwW3pL6gAm6bbh2Ir86rGsv4+EPFvISOFaUGLXNzyfn6w9oY+uitX2YE2xdsC
         1vo+37dJUMVcMeDs2xV9OCiI2Pa0lEdRAAl1VTtjmS9R7EZ1xt9sbjsAnkduFdCWuP/u
         HhqUPTZOJSkrE3zKiO8JBKefgAKIYqL47DitaET6bBUtnrrCaWuuuBTbPIy29fcQCJ9f
         ueXwEJLLHIiU9cDcdB00QjpUODoWu/KR5U0L+ox0IMXLDIkX2Gc4TCReQL0/SJDf7toQ
         qgCajPGRqpSVu0N2FwBmSTB+Da1WZ8wnq+y4H4tUQUCdzoGvCBuU4p3XabOzSuAOJDMq
         KnSw==
X-Gm-Message-State: AOJu0Yyk5KmKG2UsajzvFXAcykya6Zk5L4tV5JNQrD/urLM+TruM1Wfs
	QFcWn1jaoC3vVAiQ8zhwquqPeT1gkg0f1ivMB2XD8Zxf39TQfGGBW4ysSVWkEd95MrJIv3GjUZL
	THGxtDZZCaikujk/zRAa/J0vVYY/kdI4jN4y4a7ReYzG1jFRcYqNu6vtK6Ss66pQebi7RJV5T
X-Gm-Gg: ASbGncuwWACCdVOgXjo/+mHLC/7CvzGOqJ6NTLoKI+tIoqJibKYNwZKh/6PgIJYyWeC
	qDyLMdXVUp5AZs2ydSIv8B8NHJgGaUg/+3HTLvlBJvImXg1el/8Wa/o0ezm7RnQ1Zz3hG6UFiy6
	713MmDN/dRv5X/dKk7i+ktg+03t/UcKjJQRMnxSAvvfKuzNlrfRf8/9eM3nZB7U+TVnoc4VGa/T
	gYWAdWNCOY4Ds6jCGPlYlPAi1qEX+sjV4HDi9CzNOzGrCn6qm9+v4xhKzah2ohh1BxnpO7IzoK6
	xqeW9LvRhybKnO37k3brk4u26OA3JHp/Eao29t8gBeLyD/riSk1hnEvvGjUaNZf/yuXP9auVKiH
	yjnPe
X-Received: by 2002:a05:6a00:3e27:b0:781:2538:bf95 with SMTP id d2e1a72fcca58-7812538c1afmr5863339b3a.10.1759068559236;
        Sun, 28 Sep 2025 07:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9KwuyyUxEYxrcXGvbZ56lhVKm2MUGHT1tYoWpwyucJ5NEUp+nTy3kb4K12c/ZZMKGd/lvTg==
X-Received: by 2002:a05:6a00:3e27:b0:781:2538:bf95 with SMTP id d2e1a72fcca58-7812538c1afmr5863322b3a.10.1759068558888;
        Sun, 28 Sep 2025 07:09:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-783ad5e99acsm1496423b3a.22.2025.09.28.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 07:09:18 -0700 (PDT)
Date: Sun, 28 Sep 2025 22:09:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs/26[67]: update the stale comments
Message-ID: <20250928140914.xufifxpgz6dpnqmd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250918224327.12979-1-wqu@suse.com>
 <20250918224327.12979-4-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918224327.12979-4-wqu@suse.com>

On Fri, Sep 19, 2025 at 08:13:27AM +0930, Qu Wenruo wrote:
> Test case btrfs/266 is verifying the buffered read repair on RAID1C3,
> and btrfs/267 is verifying the direct IO read repair on RAID1C3.
> 
> However btrfs/267 is using incorrect comments, it says the test case is
> verify buffered read repair, but it's not the case.
> 
> Fix those stale comments by explicitly mention buffered/direct IO for
> each test case. (btrfs/266 for buffered, btrfs/267 for direct)
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Makes sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/266 | 4 ++--
>  tests/btrfs/267 | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/266 b/tests/btrfs/266
> index 3490ecce..f8407c98 100755
> --- a/tests/btrfs/266
> +++ b/tests/btrfs/266
> @@ -5,8 +5,8 @@
>  #
>  # FS QA Test 266
>  #
> -# Test that btrfs raid repair on a raid1c3 profile can repair interleaving
> -# errors on all mirrors.
> +# Test that btrfs buffered read repair on a raid1c3 profile can repair
> +# interleaving errors on all mirrors.
>  #
>  
>  . ./common/preamble
> diff --git a/tests/btrfs/267 b/tests/btrfs/267
> index 66e08d18..22c4aeaa 100755
> --- a/tests/btrfs/267
> +++ b/tests/btrfs/267
> @@ -5,7 +5,7 @@
>  #
>  # FS QA Test 267
>  #
> -# Test that btrfs buffered read repair on a raid1c3 profile can repair
> +# Test that btrfs direct IO read repair on a raid1c3 profile can repair
>  # interleaving errors on all mirrors.
>  #
>  
> -- 
> 2.51.0
> 
> 


