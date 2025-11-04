Return-Path: <linux-btrfs+bounces-18674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863ACC32324
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 18:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDBF18C3E45
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD53385B3;
	Tue,  4 Nov 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avXZX9aA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993043321DF
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275647; cv=none; b=iawAzCMHED2e3Q2G3r8RJs+wq7WgZ6XDpwgaK2aPu2jmHcpWRcmB+jyi9a6XLquJDNelwbdIYUUMm9KMHl5WUVjpLi7N2Av5YCBBdz1N92gbXxMRgsEh2ta7XIrhDkum/jMztjzENNNrFwaX3Kt/BOpDIsTCqfSp8A8XMpvxQY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275647; c=relaxed/simple;
	bh=Vrr/uSwlry0nKvIcHU9NJV1yfDPOHC8rt2Mzqj3YkMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al29iecUn6NhSzMF+NGx9ZWrKYcCLZvjxpZfqQxrXKfYXp9PpQExT7YKe9mqYynj9MUptCTKK72vXYxt87BnuDG558oKPN68eiMeglsmRO/0mMn4hPvLIz+yreXS/rLd1FjRtlUrGWZL9YE9NSzr/nEfuZOtbiWXc/LPyPFgAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avXZX9aA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775638d819so4804485e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Nov 2025 09:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762275644; x=1762880444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Yfb6FFNpXCK7ISYxIM3MD/neK2yEBhzq7eFojyB94A=;
        b=avXZX9aAcpzUa9I1hrWCfY1uDIXVzvsm96b3e989zv9xRnpG2QiR04Zf8+svaSVG4X
         D22/wjc4aF3fyhqIz/AUWEX0+KmQogEsA33WUtv55SVWftTftxAdOg+4Ou0C8oxZE/zG
         9+MJMucOkLaNRx/5CPeHKlp14RB1zmqzmuTPe4F5RZ3FwdXwEA959Mjaauht8Uolql6g
         I8E23kYw0E4Uyvk18VEv5K7/qkr8UVZ/0kFbpJaiQ2YozPLNrl2tYSzuN1iZnuhmrBtE
         tbWcjckPkkWCTyI0NH5C9h7ghn68WiQsV7CyludR/889SrWK1viNfIwJNKXnRIslOXfR
         OnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275644; x=1762880444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Yfb6FFNpXCK7ISYxIM3MD/neK2yEBhzq7eFojyB94A=;
        b=rqExhJjOOZExV3C1tVS/j7CB2RPhPAeGaF6a96L6GPmvsgDXUGpgO6uD9TeNlVubqf
         Ge+McUoVb/hW2q7yvja1hOGLzAq7M9f51fooza7j2UMZZ8geA1/uqG21yeUw70doNxjk
         QacKckhserU6A7m6PbMjWxdFh3JdE6E2T/xpRUAWZlWT2vNcwzCLvEnW/psnpfkUwtUI
         sDL9h3MboONy59OMwgvrb7cIr0FBdRair+g2xVlFJ4B120wDjG3rjckKr3zjSTBvvpbA
         PrXB72RmO+P21XN9SB48qCgWiEsFDAEla00ECPMD+ZkPa+L2/mgFZ+9YFc3zL7LcAWfR
         pI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVl/y+rsI3mskC+w1YRYZTEkX+7gQzRWkRXvKeiPfWnN6GY6FA4rjg1YSSfAPDOmWorpq6nQni84aUYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxO70KUxkRv98PMOcBCPhOK9mDM5lu6tkuwpPpT+Vv2Rmg42BY
	X/wlLVfmt4+2noUwiyjMjp4RMSAG7PSD/XVF0uP7xEWYlSE70fqjCE+/
X-Gm-Gg: ASbGncsFpPwXXeVJZnDd4WU2oJhU24YzNdz1C8cEpWAzkrQ8DraBhfBeBHo2dTMZJvd
	c4P5geVbXXEg98fXJgilTW6BJLfPHhsgmptGyt+b/NFGaArFYM2wWGSXm7K7MquvElsNLah+23H
	vUn5AqvAuzcCydfrrAO2Y8FZjw3ZvcJ4cDF2AGygO8805J66lBPpS8l8cPkIcHlBYAaP7ru/nth
	DJBHjHvecFBuctFuZ5jzR8PKUAV9MokQi/L9pRXIE8gCt10OYqUpi/ypljhHUC3M2BtN1uT3Tsw
	ntRqv4UG6LfMfExBs6qk+ONOJfbYwNXAdpTY4igKV465QzTIeH7X4mreY9hSwxzin0eoWWoENfw
	AaA3YvSMLUL4Gh6a/fWHS2dhLSPWm28Lnx5wTINon298liuB9nz89gzh99PVe3+WND1Rabj1aNZ
	tKiR0giXTNJTmslcAOS/irt/IxGzzu220G6/irjk/GZ+i++A==
X-Google-Smtp-Source: AGHT+IH5aMD7dan6U5/w/UZRzVLH80Ar+ql1ErXcMyhqQ50Z13gZ06dshwL9yRzd5Se8p4waVSOTRA==
X-Received: by 2002:a05:600c:8b88:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-4775cdf54d6mr106665e9.21.1762275643762;
        Tue, 04 Nov 2025 09:00:43 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm685245e9.0.2025.11.04.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:00:42 -0800 (PST)
Date: Tue, 4 Nov 2025 18:00:29 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] btrfs: use super write guard in sb_start_write()
Message-ID: <cxrp3a7wu5lz5o6fiwleqiqwqm6xyevdjiega77mwxy5aekeab@522tt37vnwip>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-4-5108ac78a171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104-work-guards-v1-4-5108ac78a171@kernel.org>

On Tue, Nov 04, 2025 at 01:12:33PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/btrfs/volumes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 2bec544d8ba3..4152b0a5537a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4660,7 +4660,8 @@ static int balance_kthread(void *data)
>  	struct btrfs_fs_info *fs_info = data;
>  	int ret = 0;
>  
> -	sb_start_write(fs_info->sb);
> +	guard(super_write)(fs_info->sb);
> +
>  	mutex_lock(&fs_info->balance_mutex);
>  	if (fs_info->balance_ctl)
>  		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
> 

this missed sb_end_write call removal

