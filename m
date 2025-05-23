Return-Path: <linux-btrfs+bounces-14191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B14CAC2657
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 17:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB23A4E5A98
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EE521B9F6;
	Fri, 23 May 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSAiGMNN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F3625
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013792; cv=none; b=ARwX3sT2E8DD4uDyh3r/eWzwjpDYtAM0aA2he0rmkqd+AYoP+0SjM1fxQ5lp77jIX3u/7hN/nco04yYTT7TmHRxjpRS7ZbwApoidAmOnVhWRw9v03xIJ08VoaZ3VVDdMS21t4jXSzJrOthsDsKclndSVw2+bFn9xGq94ddIhJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013792; c=relaxed/simple;
	bh=nQOeM3Dqtm4mj1C8J0mbhgzHJirdktm91ab8vaFuA+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkGliY9xIt2eHYecCmCdrYyjWSmxTjIuvSdihEj8qSo3xaklm4TBKfW4l8BSijptCWaf5Z2F2F1EloMxqWuD6gRPYGQRknm0Ha99wIwZbxVjbdXl051I2L5I2w9sFh46a6xg4r2NmJBO9rHCJKiAl5lT09o7MNUyricPux/X9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSAiGMNN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748013789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpMQgLc6DIr4rweXgx1gHRZx9KnbfzvdcczU48QjR2g=;
	b=NSAiGMNNnQJ+ysCqnSlZTD6RXY4SQgacg92+mWHIQoIr2qCmC/4iAd2b4qT7xx95eVXYuy
	0153HhKDI0jIJPpYEogpgZXYDUAwODbV8D9Ijfr/4/U7c/UnJxdF5QeeiX2OCfr39mCYyz
	ROHU6MIiQ8lZD+PXlMz1P8t7JbIUFzc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-v02d8OeNNeK2Yu9Q4RB7mg-1; Fri, 23 May 2025 11:23:06 -0400
X-MC-Unique: v02d8OeNNeK2Yu9Q4RB7mg-1
X-Mimecast-MFC-AGG-ID: v02d8OeNNeK2Yu9Q4RB7mg_1748013785
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-232054aa634so60427565ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 08:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748013785; x=1748618585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpMQgLc6DIr4rweXgx1gHRZx9KnbfzvdcczU48QjR2g=;
        b=dqPdHul4jDi2E3Qm/vx9UP9Qhf0lTFUreSMIK+rkhclPebPjiSMVDpHqEXRqGaSYxa
         Lzn3R8S99EfPSh37Ecs3saKQlLgc8P+bpc49x7lE9EqIm1D5MkPJuXk1Oar4oSOusyEB
         8kSW2g3h1uk+bLfySGLrhvT3Jo5eUhg5EprnhT+TeKENHgiOV3hVOIBnRwNNtAkwswgf
         9Aap0c0CfydMqaDVGBSZ3r7IS8ppvebSU67FmInt0rGRNkXyyGikoe1zmtCWL+9UF7eq
         Xe8HLfFc8ow7r87QkfxEMigQeronlPT5cbUX7gA9p3wmLt/yagNuyYNBErO4gjSozeN1
         VkZg==
X-Forwarded-Encrypted: i=1; AJvYcCUfERJpnhxYZ2UCa6sWAnm9IoQSVzbuVcEXIr09yJYErzB7e/maxkXMrr4g/Q11gUTNSt4+gmcW0+ckKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCX+dvaBIIUT9/byOCumFJ7QSDovH5DMakDCWSl0TVbwV6dzrD
	ATjSAI+SOZuyPIjf7ZChrdQRT5Fm41AJrarwkqJJBlHznJasNkdsBEraN70Vp0WNTrg+PQiB+5p
	TULuiQzOaLMhERDwHMVs9+Leq8KkfnT+qHtsHoJPn63fGN8PYTnAx4KiDwSrfk8UP
X-Gm-Gg: ASbGncuaI0NvEPadho6tJQ4OICxtFL9wyeVxMlT3qWI/pPxj3IBTej5kMJ0XboXU5Qq
	AGpu2vfDogtsixC/02xUJC4qo6T9x4WXF/8cpFHBdbsDNklV+G8W81ytw5yUwtUZGUCDjEja6Dp
	cYYDz4NMBXEMCQyWBq0svHDAJu02iNnqAiIw5RyHz31rVebj/PyN017t20R3FA7N5ilUTfMJHMC
	2fCeLDnmf7nrjGpYQQ9iIoNtizghZM8oaxzmoO1i3UIFnL4B3WU7RT1UF2UpJxedr0uyZnpxE1T
	Yuh2j7GRc/hbdkziHcTr9jMGBr5WTzR6dfqZLKkygEJA+9wPHnkP
X-Received: by 2002:a17:902:e54e:b0:224:2175:b0cd with SMTP id d9443c01a7336-231de31b382mr380857855ad.26.1748013785190;
        Fri, 23 May 2025 08:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqf7EnTM457tlCg2ymc3jlcny8oCfPBWNX5s2BmpLj2wZ/UD+l7+zLHAkwrcsiBVnJNrZ1fw==
X-Received: by 2002:a17:902:e54e:b0:224:2175:b0cd with SMTP id d9443c01a7336-231de31b382mr380857635ad.26.1748013784888;
        Fri, 23 May 2025 08:23:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23401ab6c69sm6339945ad.67.2025.05.23.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:23:04 -0700 (PDT)
Date: Fri, 23 May 2025 23:23:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] btrfs/023: add to the quick group
Message-ID: <20250523152300.mnnl65jjsvbwe6j4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747309685.git.fdmanana@suse.com>
 <29bf7308d67eca82e564956f381dfe983696fbf9.1747309685.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29bf7308d67eca82e564956f381dfe983696fbf9.1747309685.git.fdmanana@suse.com>

On Thu, May 15, 2025 at 12:50:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This is a very quick test, so add it to the quick group.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/023 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/023 b/tests/btrfs/023
> index 52fe0dfb..f09d11ed 100755
> --- a/tests/btrfs/023
> +++ b/tests/btrfs/023
> @@ -9,7 +9,7 @@
>  # The test aims to create the raid and verify that its created
>  #
>  . ./common/preamble
> -_begin_fstest auto raid
> +_begin_fstest auto quick raid

Sure it's fast enough:

  btrfs/023        2s

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  . ./common/filter
>  
> -- 
> 2.47.2
> 
> 


