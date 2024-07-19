Return-Path: <linux-btrfs+bounces-6599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE84A93781F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48408B216D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 13:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D78013C9A7;
	Fri, 19 Jul 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Rlprb1/+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230265811A
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721394460; cv=none; b=KGB0nV0A4WjD7HgELMBP7kvEp7Z7RWkH24wo+iCbBySLLy0v2kLfQwmAyePSDNGczpvYlAEbizSilXIsynpTBZeDNHjhyHPHQuCwB37Xdz0lpZbp6kpGUQF5JHw4XYMuWTf1wN7h/wBhDE23KuY+4d8hV4ngNm97iqVhP3++o2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721394460; c=relaxed/simple;
	bh=HGmBJV1x6RMK3kDqu06eq9T1j2haPsli+LgM+h9K3/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW6DXw44klUA2sa/7BJ8YGyPaCCh7L/JGHQoqhAmPfQnmDzrElqUBCRZzxTQcgK8T1z7AEJu156P+95aIi1ONrs5XR6x/g4zKGDJcR+7AGacYFwi0+E9Jnw9YGuYttrkwsNSAZH99hCujh/E1bQEN0bTGqEmM9yVBaCFTxV08Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Rlprb1/+; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-447e2d719afso10441481cf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721394458; x=1721999258; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wLF+/XDuXf2Bt+cfynxzoU784gkX5V3gwoPSsjjwYPU=;
        b=Rlprb1/+4jAo7qUfi19lsVfSxeMeSPzonCaqyKthp29fo5HtcgxToi43xK+rKIj2Ym
         ZmwkfnB073pny2kiKLLGY0t0RmFb6YkAqThIP6NkNcGpbeayOFSR5UbkMU4CsggnNXvZ
         lOPuIAu+OCFbk0cHIJvdqe73RkayyGW2MiWI6FF+5Te6G+jAPNBjuZWFWtQw7+Hrcu5V
         FaHyQ7G6tUvygFGLByBcaKZW9v7wHw5ej6iTAh+bwQcR/7oD+kbgV5BPT+BZLYQt2Wtd
         cg0YBAwljFfWoovOicQijtK6J8ZLspvCF4bkoM1cIhOJpJg6gomHYJJ/sznMyBJA1Xha
         9gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721394458; x=1721999258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLF+/XDuXf2Bt+cfynxzoU784gkX5V3gwoPSsjjwYPU=;
        b=C3Y9Rx3PDzI5y8fjoSdA6eWgALqC8qp7Os50FyTorYAgklcRmLmBpPwh9QI7y2Jin/
         B93FNQbf/8+dTiNMp5TYURIfeR3EjiX97DAWWvemEOCORH6jbPchrIAUFAMduOGNSYBq
         cNuhzpY6E7kd4HwwYGYPn0tClEm3CD1kUEWXdYL37WDcu8wvVYdl5iD7RkgsctWXL/1d
         Dkza+jbB12GtbDZ0V6S3LwH+z2AVc1Onc4LqoaqNQRv8Br2JS7l0aaCgcmVRlnyF3biM
         Y4Ug9ESNcgVDF3I0lhQJl1Yhme0M2udGbIU/Lma2iYm0emmI3U2lRzghdp4QaUbUQbvi
         raHQ==
X-Gm-Message-State: AOJu0YwJfX0DDJOZsSv2ng7ku60mD/zxwIMl2WOyZQ+8t+H5uJ3mhDKU
	WuunPOlvZLZdL7yQ28jZ/ToAUgETTcR/ehd/vCVmBPnCp54y3QhOsl0Tb7M8am4=
X-Google-Smtp-Source: AGHT+IGoTYnZRPXwRZFIJuE3GxTZySqzj2S6rNwl6gOl74NtRP2zGecw8nX0Z5faGLOjkQZj1CIg9Q==
X-Received: by 2002:a05:622a:10f:b0:447:d963:ebbf with SMTP id d75a77b69052e-44f96d6676dmr70875421cf.21.1721394457876;
        Fri, 19 Jul 2024 06:07:37 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd04062sm6938871cf.40.2024.07.19.06.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 06:07:37 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:07:36 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH] btrfs: avoid using fixed char array size for tree names
Message-ID: <20240719130736.GB2302873@perftesting>
References: <09fa6dc7de3c7033d92ec7d320a75038f8a94c89.1721364593.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09fa6dc7de3c7033d92ec7d320a75038f8a94c89.1721364593.git.wqu@suse.com>

On Fri, Jul 19, 2024 at 02:20:39PM +0930, Qu Wenruo wrote:
> [BUG]
> There is a bug report that using the latest trunk GCC, btrfs would cause
> unterminated-string-initialization warning:
> 
>   linux-6.6/fs/btrfs/print-tree.c:29:49: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
>    29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_TREE"      },
>       |
>       ^~~~~~~~~~~~~~~~~~
> 
> [CAUSE]
> To print tree names we have an array of root_name_map structure, which
> uses "char name[16];" to store the name string of a tree.
> 
> But the following trees have names exactly at 16 chars length:
> - "BLOCK_GROUP_TREE"
> - "RAID_STRIPE_TREE"
> 
> This means we will have no space for the terminating '\0', and can lead
> to unexpected access when printing the name.
> 
> [FIX]
> Instead of "char name[16];" use "const char *" instead.
> 
> Since the name strings are all read-only data, and are all NULL
> terminated by default, there is not much need to bother the length at
> all.
> 
> Reported-by: Sam James <sam@gentoo.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

