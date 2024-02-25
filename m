Return-Path: <linux-btrfs+bounces-2734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E22862B43
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF8DB20E01
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7E2175A5;
	Sun, 25 Feb 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnI5NULc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6835814280
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708875696; cv=none; b=fQmQlFlGP+nyXig4HmxXmaowx9Q7XBTAsLq3TlHR8gfZR5nd6zrz9mLftSR1qOEpzaVejyGwYlFEc7m8Z8qvgPW7FenhJqOlwCIP5HN6Eldn82BwDOzQZEPcQJR9LlCmXGuodCt2J1TXtPWlWY1Dp1tzrHhtmE8/UbCRn4wksS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708875696; c=relaxed/simple;
	bh=7v7db/JNN0EXDSBfGzIGKFxeQUgobasoqFt45WxellU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovyi58ESighvtjc6+X42bXvlQjoYc9/Nqb/ZxIWQShNiC2OdZ0ba4a0yTnV8/IMMnIpI5z0tOk/NHp95QlpULuXxvj7F8dfnXAd6iSlJPH0UIc7l8TBNnDIaAH4RMVd12PXE9Zb8pL5ZqsZTgbyNyAPaR5Q9V007B1ZWqtlvIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnI5NULc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708875692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATVNc9fNDwtTwgTZk/LuN2EPr9bg2I/iUG+7ebh1HZw=;
	b=YnI5NULcgnZmbpJTWMBvr6H3ocCGqMn04UPqZzR0VRYstpZGaCP0EsBp8pJ8j3201oKCHs
	eBFvN8BoQXDdfyee8cjeLfc6Brp+YLiM8XZNj627I+1LzLw/UJop8KtlZNr1J8AX4eG0Mb
	6TSJyBzJv8U5giEr3QJTyb/P0IqDfHQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-D0fkHXA_PG2nqrXxWGNR2g-1; Sun, 25 Feb 2024 10:41:29 -0500
X-MC-Unique: D0fkHXA_PG2nqrXxWGNR2g-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e4886c978bso1209888b3a.1
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 07:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708875688; x=1709480488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATVNc9fNDwtTwgTZk/LuN2EPr9bg2I/iUG+7ebh1HZw=;
        b=rnCbjH9jm8bqTLso7vyjhBhhtMrsXtrdEjnvb05PlK/+XaEj7t6+ajrfP5LqM++W9V
         oJelKiXo4LkWf2yZ8A2WBmmfFpfmY7pefqXu59R9uR18LukDp4ygXTIdIDXez06e6GUT
         rY9ilz3IlkjwM3MgLDND9r+BbguPSstFcnZI3HGyFni44BGys9/f/1eIYm2qPVc039r7
         nblVpZQbkmyNz7XwnRM8Jwjja4RYd54/0OADg6qXGs7QB+Ppk4lXSIexA7SgC4BP7bj1
         qkosYE/hbfVQP9ZYI8p3X0gaY+2yEstcluvCaFajcGMTQc6SDe93pozIYFsGP+DEWigf
         uuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTMeuNxmfi8/MWLWvly/KdNa9ZsUC49Mrq4L7cFd9Ei1JFiIF//zN8dkMRsf3f/pdIZOLHnK+k3DZN1cVIHoI/psyAKRrUuvYyB+0=
X-Gm-Message-State: AOJu0YwvBmSmzZZJDHB8XKhE9XcDLHK/wZMnQukVzS1GwrcMzsYzhfjP
	gLjPd2CYL4OL29noJ9phoUNxVP4VHAIKO4B2yzu/hrTDYCValKwBSkpyvpONlSEf5LjsPX5PvJY
	fFRRSiMZgKMd2/hQ9Uu3dgVYLuQtW6H7NJwejz6A2LzcW1HWPDgygqqD90n2B
X-Received: by 2002:a05:6a21:1014:b0:1a0:d956:5590 with SMTP id nk20-20020a056a21101400b001a0d9565590mr3349444pzb.20.1708875688494;
        Sun, 25 Feb 2024 07:41:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIhB90RtmLPRMccW7nL5Uc/9prciuKDb0bGcBFUuoVUuWU/PKpIui+JCDIEA2+0e7OsfE+ug==
X-Received: by 2002:a05:6a21:1014:b0:1a0:d956:5590 with SMTP id nk20-20020a056a21101400b001a0d9565590mr3349436pzb.20.1708875688158;
        Sun, 25 Feb 2024 07:41:28 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e2-20020a63e002000000b005dc87643cc3sm2487253pgh.27.2024.02.25.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:41:27 -0800 (PST)
Date: Sun, 25 Feb 2024 23:41:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] generic/733: disable for btrfs
Message-ID: <20240225154123.pswx5nznphszonns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240222095048.14211-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222095048.14211-1-dsterba@suse.com>

On Thu, Feb 22, 2024 at 10:50:48AM +0100, David Sterba wrote:
> This tests if a clone source can be read but in btrfs there's an
> exclusive lock and the test always fails. The functionality might be
> implemented in btrfs in the future but for now disable the test.
> 
> CC: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  tests/generic/733 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/733 b/tests/generic/733
> index d88d92a4705add..b26fa47dad776f 100755
> --- a/tests/generic/733
> +++ b/tests/generic/733
> @@ -18,7 +18,7 @@ _begin_fstest auto clone punch
>  . ./common/reflink
>  
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs generic ^btrfs

If only need a blacklist, you can write "^btrfs" directly, e.g.

  _supported_fs ^btrfs

then others (except btrfs) are in whitelist, don't need the "generic".

Thanks,
Zorro

>  _require_scratch_reflink
>  _require_cp_reflink
>  _require_xfs_io_command "fpunch"
> -- 
> 2.42.1
> 
> 


