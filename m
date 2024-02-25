Return-Path: <linux-btrfs+bounces-2737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D08862BAC
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 17:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D557281568
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABBF175BE;
	Sun, 25 Feb 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVZ3dhEx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1E101F2
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878144; cv=none; b=mCExdoddBNt6iYYpvW5j+CprYFYJjuROgXEzwIxDBTuDKp889f2X/vRi2iM+JIK53L/+ce4Zb8CtEeiiUwl82vrypugoPcU9NS8Fb5DImWChMVknoC83pjiCuS/7lsPANbtrH6LCT65XEz8OAPuXBJq2zlhKV2vsayWTVuSTSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878144; c=relaxed/simple;
	bh=/lDq9CRjcCluhBqhf4xNQ58eHdjRm+s34XQQWcMgZdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbVgQr/VcdJRh6wWF0ZMIyfI+MmHBv04bU9h1mgOETn8j2jlnK8Nyi/crCnUnvbe/GMPyyc9sbP0KUzfB2V1FIJhXP2wf1EoOWnaPubF9G8zDZYqGyloHklg18rC3Lz6o6cKI4FmFoi+dH7tJLea0ADzUeX8A7WKw9hz4Yl/KtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVZ3dhEx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708878140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbUW9yfzzUofBZpGKvSVueN5wdAewAQZIGdB0vmOcPI=;
	b=JVZ3dhEx/z40Lq2EMeNlX7Xm0ue27GuPQYP7aPaXI5Agu8KEAGMXWi1nEZ+Z17LwFdSXKb
	SRyoTHwJ3phXYM3X2YRJ4cmrsCPCc2DfInibOt2bDu1JeMkevSJdOXp7OJdyjlW0gLN6jh
	l8P8Pp+R24U6BbgnmZPivHUpn4LNE0w=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-pEmxNGFyM0i61u06b3i00g-1; Sun, 25 Feb 2024 11:22:18 -0500
X-MC-Unique: pEmxNGFyM0i61u06b3i00g-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5dc889cb8edso2897918a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 08:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878137; x=1709482937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbUW9yfzzUofBZpGKvSVueN5wdAewAQZIGdB0vmOcPI=;
        b=FPzmVn3b7MIl5mkzJlYkXAxvGbLvz6HrtmUS3IVDlAgnPV7Ee+Bx/RSlzysil/wTlx
         O6Q23QXAbIie1GXLrq7UrebKYUcCVNxrsKutsxa60Jc2uyFjYIPaTWWefSIgnSkBEaRl
         aesRgnRoqicwmLeBaurucJwI6DJkEPmoIOPdmdwssQw4FmRzEiTGeVUGFMUBVETcacjW
         rjev5WaieCNwCW5YU1jIspP38HC8wiN/D6U96nWLOe3J1FtGXBncDG9RpR3jxQyTe9Rv
         B/EpV/jktjHAvi6YaKbPQyI4bRtqF1JRsiE0SzSroPzNICwYsxeTsg5jNUPhb6bmzeaP
         ck3A==
X-Forwarded-Encrypted: i=1; AJvYcCXgktmnWAxqEHHRj+P+g8XnEIosd+0vEhlYZcVjxz3vmSJMe37W9a/wJwGnPoonmtgbzoflAd+8i5AQSZRZnimKXw4McbBVht41HsM=
X-Gm-Message-State: AOJu0YzpXBCeNvcGRJ8tO7q4885XK/Wzn6ZwcMF/H/J1AJ6j0DUCHJtz
	VmfWYP/b9ySAEyqdp8NPh0fi/deiv9I7rmQyYMzURjgJtP+G/jh8GMEvVrqY9WksPD78IrJTne0
	rWJF5VF31es18pqWE9CEjSbarfN3eiw4Gn2qFXIG6oG4Vkt0v43YmiV5XIvF3
X-Received: by 2002:a05:6a20:6f02:b0:1a0:e469:2599 with SMTP id gt2-20020a056a206f0200b001a0e4692599mr7190637pzb.13.1708878137709;
        Sun, 25 Feb 2024 08:22:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk47mQVpV0s+6hiNr6yJRfuqPxIdFC+pCAVvhlJqi6tNUxhi71tJINDK2WSlKlxY8g3i0y/Q==
X-Received: by 2002:a05:6a20:6f02:b0:1a0:e469:2599 with SMTP id gt2-20020a056a206f0200b001a0e4692599mr7190618pzb.13.1708878137378;
        Sun, 25 Feb 2024 08:22:17 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b006e530aca55asm78315pfj.123.2024.02.25.08.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:22:17 -0800 (PST)
Date: Mon, 26 Feb 2024 00:22:12 +0800
From: Zorro Lang <zlang@redhat.com>
To: Su Yue <glass.su@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, l@damenly.org,
	Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs/172,206: call _log_writes_cleanup in _cleanup
Message-ID: <20240225162212.qcidpyb2bhdburl6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240216102550.46210-1-l@damenly.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216102550.46210-1-l@damenly.org>

On Fri, Feb 16, 2024 at 06:25:50PM +0800, Su Yue wrote:
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
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> v2:
>     Remove unneeded comments for _cleanup.
>     Add rvbs.
> ---
>  tests/btrfs/172 | 5 +++++
>  tests/btrfs/206 | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tests/btrfs/172 b/tests/btrfs/172
> index f5acc6982cd7..e5e16681ec21 100755
> --- a/tests/btrfs/172
> +++ b/tests/btrfs/172
> @@ -13,6 +13,11 @@
>  . ./common/preamble
>  _begin_fstest auto quick log replay recoveryloop
>  
> +_cleanup()
> +{
> +	_log_writes_cleanup &> /dev/null

Currently we need to copy the code in default _cleanup into new _cleanup()
function, if you need a override, e.g.

        cd /
        _log_writes_cleanup
        rm -f $tmp.*

> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmlogwrites
> diff --git a/tests/btrfs/206 b/tests/btrfs/206
> index f6571649076f..d9ce33b659e7 100755
> --- a/tests/btrfs/206
> +++ b/tests/btrfs/206
> @@ -14,6 +14,11 @@
>  . ./common/preamble
>  _begin_fstest auto quick log replay recoveryloop punch prealloc
>  
> +_cleanup()
> +{
> +	_log_writes_cleanup &> /dev/null
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmlogwrites
> -- 
> 2.43.0
> 
> 


