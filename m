Return-Path: <linux-btrfs+bounces-3069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB69787531E
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 16:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E421F22F72
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFACD12F370;
	Thu,  7 Mar 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiKDIUZm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5A12EBF5
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825173; cv=none; b=WmrW1yI2BVfJ7wasGZ5TqMl8nmSF3FdvERFduJ6WGhVH7TCexTfVQ7yBzWY8hD8pA+Gwx+0zqDHyOFOxhRwyLd/rSQ/ah7/G86XFdFuHBPkiJCBu7ou02FF/WiH35X0mRCUKXtwkxECuLX+C6Z0EkshZDExzNINX41CW0GoOW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825173; c=relaxed/simple;
	bh=EU3XylEJitVrbCrOCmqX9RnYwePjWmiJLehkxf0rIpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9BNwVaGs+RNaLykj1l3ny1+RVJcQt6klkDTLzrwrkIJcX2kq0ZztYZhgBlaK2eaeolT4B0qdPlFLxNBwLj93aUTw/nhKdZkKX01mS9utb2/G6AkuoMFPuD85tgC0c4syBOTYHqB6Qb1TNMdZDYTTHOcuF6m4AS6ylFnYAYb76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WiKDIUZm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709825170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeioKZMX4TixT/w6JyLkmYdoiWIJWk4jwuG27h1QRMU=;
	b=WiKDIUZmrZ0r2jqYyhiJfxR+7UXTmpnvKCCt04WqD30lyE0X2f1axqLaW7P43Js6dmxB2E
	+4HwDeVTq5opzHKrK1sMIK7v9aMjqZGXN07OOQVPAHQ1SDGRHRsS4cV6B5Q3KRC/p67Vl1
	qE8sQDRmAzHMO5dTFPF0vbTAUoj2nvs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-OafEoLLROJKfb32qYX_idw-1; Thu, 07 Mar 2024 10:26:08 -0500
X-MC-Unique: OafEoLLROJKfb32qYX_idw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dd6198c570so1588395ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Mar 2024 07:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709825168; x=1710429968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeioKZMX4TixT/w6JyLkmYdoiWIJWk4jwuG27h1QRMU=;
        b=uTmpGFJxADeHlJqfGnuts+k84ReHLLWEOzMeYBvKD56bVyFFuMwtBsc8w7cgU5Kw3G
         UDcixyJfaOK7DnUv4UHL0Z4DMHU5Y+butq9BaUyj5A/PopL9IDLG7YrRUMXzPDV9+3rb
         8yaeAnTzBDRC/KXxkALY/ak5hbcf1loBiXzXYfnxON5y6SjnzteUMuaRTzhaSkVO/A9E
         iR9+IbgJa8s3rhsua7AY49aSn3YiVBhHtxG+LGCDgUPyzvy9R5IvfeFBYxT7p4GXevu0
         EEG7e84agR3fbe7hmZWhtTKcBAzBCALA2A9Z8EMuoLZnPoFhO5T/KN+IMFZheanIEBhy
         VM7A==
X-Forwarded-Encrypted: i=1; AJvYcCWPnkH4NyQc+yCTx/pQD17F1oMSlliwxmxCj6/btpSqyXIrgxSicMMi2O640tsynMXHktpg/OmYr61yqpNe7E+nnHC/hR1jsdLOqzQ=
X-Gm-Message-State: AOJu0YxCs84i2cpCYqB7svHyolAVN8VleomDCxFovh8KY59Waqq1nuYG
	rnV7XgN3HrUpqwymAQ8hXMn1MnKZjEk9XfszLASfODyQiLRLJWMyv/WbVbLsLC/eyMBPBliX/dB
	LTtco7aKkIDGXFo1pkQiX04ffyR1YK/99Qnei2F9CqiQQklUWzMIQ7lnTWZjJ
X-Received: by 2002:a17:902:d2c8:b0:1dc:fefe:8050 with SMTP id n8-20020a170902d2c800b001dcfefe8050mr2153707plc.29.1709825167619;
        Thu, 07 Mar 2024 07:26:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPTXpUz69hW1V/pb3qoEh1hQD9k5bkrW+3pVjGmcSg7DCVL18CiPM+Ve9O+H6lFCDSMocb4w==
X-Received: by 2002:a17:902:d2c8:b0:1dc:fefe:8050 with SMTP id n8-20020a170902d2c800b001dcfefe8050mr2153676plc.29.1709825167074;
        Thu, 07 Mar 2024 07:26:07 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bg1-20020a056a02010100b005dc9ab425c2sm11297574pgb.35.2024.03.07.07.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:26:06 -0800 (PST)
Date: Thu, 7 Mar 2024 23:26:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] .gitignore: add src/fcntl_lock_corner_tests
Message-ID: <20240307152603.7wclj65j6lfejicj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1709806478.git.anand.jain@oracle.com>
 <d81464d8af573126efcc0551f80bd9968a38ab40.1709806478.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d81464d8af573126efcc0551f80bd9968a38ab40.1709806478.git.anand.jain@oracle.com>

On Thu, Mar 07, 2024 at 06:20:22PM +0530, Anand Jain wrote:
> git status reports a stray src/fcntl_lock_corner_tests; bring it under the
> ignore.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 3b160209ac03..574aa9e8c1d1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -93,6 +93,7 @@ tags
>  /src/fsync-err
>  /src/fsync-tester
>  /src/ftrunc
> +/src/fcntl_lock_corner_tests

I haven't merged this test[1], the author is still looking into it,
due to some issues on cifs side. So this's an invalid patch.

But you remind me that patch forgot to do this change :) You can
reply to it as a review point :)

Thanks,
Zorro

[1]
https://lore.kernel.org/fstests/20240303050853.f7wslqfkkgdfv37i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

>  /src/genhashnames
>  /src/getdevicesize
>  /src/getpagesize
> -- 
> 2.39.3
> 
> 


