Return-Path: <linux-btrfs+bounces-15161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DEBAEFC51
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50AE33A96DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8C7275AED;
	Tue,  1 Jul 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtWOHhsL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075BE125B2
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380096; cv=none; b=fxDJ9o/reNxOr5v31P91gSD3Ny0pI7yljd1FnAuR2nsZMrOmByjsfliDmMmai7c/Znf5lF6v8hfNWhGID1il6F9Snr9DNybGTpUsS2sBnpvA6k2eyiERwobhyFozkSp7wTaEifZ4o5Z5mIUZHFa/bE+rGDtmOXp+W0Y6UGLh3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380096; c=relaxed/simple;
	bh=FfWNlt0sTvazmmf8FeKea/5UbR8UES/3TauQo/EeSf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ4yFDa66GZVIeUR7vbyhF874FBHT3s1K86WMYrNUTWOEwJzGp2bPQPg1LNiwABTlK53NTO1mj+9FWXhEycE/eH28IGD4PYMIJBhhbGHzrCQhsgEqVkffrBLSegHs0dnRu+Q/NEehC4Ni3q222oiw0I01dSVm0FT/g6G22Y1XwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtWOHhsL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751380093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aqHNejLTu5OmdI4y6XzLz4N8WLe44NOczvGEBwpMpFg=;
	b=FtWOHhsLK9V2A8ROq9m5IadCu9ZsIdwlC5Nu75gvhXWCGoZI9hKhfopEbpCb0P7432HJsQ
	06a9BKnvXe4V16CB+1QqhJwbUXKCf/+V1BE7dAkZz84z53mmxTpkva2w6oo0e8mggnqMFo
	Qxux8sDVoufPjBdIw96hTvl5ET1CT3Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-TWu9CtmfNGCOI68rBXrCjQ-1; Tue, 01 Jul 2025 10:28:11 -0400
X-MC-Unique: TWu9CtmfNGCOI68rBXrCjQ-1
X-Mimecast-MFC-AGG-ID: TWu9CtmfNGCOI68rBXrCjQ_1751380089
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so5480778a91.3
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jul 2025 07:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751380089; x=1751984889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqHNejLTu5OmdI4y6XzLz4N8WLe44NOczvGEBwpMpFg=;
        b=eT0SfBhqRqskPPh1qARAUjaeks7GXGxjm5h3jDDecGhQiHl33QHyEHBh0fwUnx0ea+
         61oHYSwIkjCIfmaZ7+Ui2I7nIXi8jW/agULCBt2uPkVYgSqQe9hc19DCl4q3FvynDPyc
         OWoBhrXn2hiH8SxgQz+MJ5gZ08Fjbzia6naw3sQC7Wb6/dcYfSQCJMsNCdGBXLJYb6JT
         ApHmrYBJJ4xuAGiZQ5I0i3DBQOWKQLyMqHKGYBJwmZe3AwyWJURXzSwLuvviDfU9LcmZ
         dPLIW1t77NEKfFMqWbZ+dCuwx6PzhLLxVOCbUCNMXu+rJmwdKPoB4PIQJg1VknH/7f6z
         y3yg==
X-Forwarded-Encrypted: i=1; AJvYcCWHgc86T65gShAz3/6lpkfXhnue4VjDr3DgwWv9u8CYpAe/wL8yKUZ5B9ecW85XSHqNdDlYBs1GCj2w6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfpFjBI7+Cr/2UxuEKHTRKqMSUGODM7vAPyhyLrfzr8784ZzFN
	YCTqswaP+rPyMM4smuTzgR12ONFEVOOnwa7NOzmyHy4flD0zypMKw5LNVkwrkhyg0ss2IeNPRnP
	0gLbek2vyoN58vhLzfe2fUOFm8Bd8Xpr3Lcd5lJ8EJZWMlH+YMwj2ujO5/JKXjSh+
X-Gm-Gg: ASbGncvRmDiogp5JhW5tlHeUyr1FqN9jnIKpSJnCZ0H+6v1m09SM78j5GhC6TGohn7B
	xSTjiK6yNI6RMzCWpjZbC7KgXATEHCkRGIkocPPzNZDq7KalY88/+NArL7W7QSaXb4992RQGo4z
	S8pgP2n3NL5NQ7UO3xOp4nXz/nUqB071/1kYRT+0B/OfDolWzv392URERpgnaESoGjavVGGZTme
	3swEMFbntv6KYsl13cr5ZccsC6rjgTjeEThLCfHIkh0xALcliEh6MHthF9RnqNmKp9Qk2GsrrNr
	jG4lACQWtDS/yUW2dRyE8MFriUdxoh+HD/VsrV6InLr2OCC7CB1L1l6YGoFmPrg=
X-Received: by 2002:a17:90b:2e07:b0:313:28e7:af14 with SMTP id 98e67ed59e1d1-318c92a33f1mr21670714a91.19.1751380089240;
        Tue, 01 Jul 2025 07:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJG7AxAZVuPp084miQi4ypOjwn2m18XooM4pwIZ4HD3FB/NDkjhWdSDdcwuAmtqWE8T7BjKw==
X-Received: by 2002:a17:90b:2e07:b0:313:28e7:af14 with SMTP id 98e67ed59e1d1-318c92a33f1mr21670678a91.19.1751380088787;
        Tue, 01 Jul 2025 07:28:08 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5382e7csm16969392a91.2.2025.07.01.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:28:08 -0700 (PDT)
Date: Tue, 1 Jul 2025 22:28:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 2/2] fstests: check: fix unset seqres in run_section()
Message-ID: <20250701142804.pdc4ibftng4qoizc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1748058175.git.anand.jain@oracle.com>
 <8d691171e1bb1b0be98a0ca79e50f9839073d2ac.1748058175.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d691171e1bb1b0be98a0ca79e50f9839073d2ac.1748058175.git.anand.jain@oracle.com>

On Sat, May 24, 2025 at 11:57:14AM +0800, Anand Jain wrote:
> While testing, I saw that ".full" is created by _scratch_unmount(), called here:
> 
>  725 function run_section()
>  ::
>  815         if [ ! -z "$SCRATCH_DEV" ]; then
>  816           _scratch_unmount 2> /dev/null
>  817           # call the overridden mkfs - make sure the FS is built
> 
> Ensure seqres is set early in run_section() as a fix.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

> This patch was sent earlier; it now addresses review comments and includes
> an updated git commit log, no code changes.
>   https://patchwork.kernel.org/project/linux-btrfs/patch/12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com/
> 
>  check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index ede54f6987bc..93d8a6cd3237 100755
> --- a/check
> +++ b/check
> @@ -794,6 +794,7 @@ function run_section()
>  
>  	seq="check.$$"
>  	check="$RESULT_BASE/check"
> +	seqres="$check"
>  
>  	# don't leave old full output behind on a clean run
>  	rm -f $check.full
> @@ -835,7 +836,6 @@ function run_section()
>  	  fi
>  	fi
>  
> -	seqres="$check"
>  	_check_test_fs
>  
>  	loop_status=()	# track rerun-on-failure state
> -- 
> 2.49.0
> 


