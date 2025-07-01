Return-Path: <linux-btrfs+bounces-15160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE850AEFC09
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8014432B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7282277C95;
	Tue,  1 Jul 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bo5xc0ry"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6B277C84
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379336; cv=none; b=bRdH9Y7+aRXs8OhWZ3Lb06VOkyfIzO4yGwk4pTOgrR0icb6bc6J2VKmt5+rPjjXs2nbFowLvfZwk14CcnQphuFTZfXiz1/WkkZilTFXGSJhkIJSWsrVhKtkgtFaezkjm5fMZMb0t3wI5eiuK6pX0Dm8oGn0jdFVNsOCUU+7JVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379336; c=relaxed/simple;
	bh=JUHji7UujZqlO7w3tuePIlD7pcqYDmKrXssbri1stvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYSdrBGQYm9zjYCuAdnQ4E4Lc3I+1iY3+WG4QjpbfLeu6xqg+MHaUIPONqPGfHKFlMSu8iNKNlSy2esVFUs06uBH3UKKOZnIaSj4LQQ8A3LuLIOXJR2Dtj3xM+02BFNydY3XQORITRR+oeVaCdrFgLebPLEJNxVr24lFmJOFb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bo5xc0ry; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751379333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WB0WRDy9FRZayc1U1MzG8GUWJDmiN9dk9GtzK6cuSOw=;
	b=bo5xc0ryZ7X2eRo24BzbNR+Om7i5ZGLtvGtbzHk0wAqa7yxzy80hefmNJCU4ATTolGDRXl
	Tc2Hdb+QFKUwRR5bWeu14NCyOUYeSFPEA1IrFuRDKGbr0yKiwKUgV7gUw9t77vYNfTd5Hu
	zY17LBWnaiEWjKL59IbJS7LVKeLVouw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-8c36U-u_MI6_j_JWDGHLdQ-1; Tue, 01 Jul 2025 10:15:32 -0400
X-MC-Unique: 8c36U-u_MI6_j_JWDGHLdQ-1
X-Mimecast-MFC-AGG-ID: 8c36U-u_MI6_j_JWDGHLdQ_1751379331
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b00e4358a34so2375116a12.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jul 2025 07:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379331; x=1751984131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WB0WRDy9FRZayc1U1MzG8GUWJDmiN9dk9GtzK6cuSOw=;
        b=m9YsWiCr4m04PVlefuQbdy6IlBNYKLefP3JwWSkppuISmulkDWJYpzi+pR8YplxP5g
         skisMVS5tojQvTAmxDNKoKyz1lT6YoSdBxxdYiqP96+009jSOO7XGVnlD3H7rwB1e2EP
         LZ9TBCLTzBX3EGDcfiW36B6UZ/ohxEMHd35ZpeooRDrknJ04yV3mfoG+UNEw+ntNtQle
         yRtGxl+qTCRDKI7RtOc+Nzbn/irEeyHp9JhorgjtY7rOZxRiX9zAe45gWbVARAgn0iD/
         WmBa3m49hIvgKFGHfdAv+uB7tv1TypOzGp5QafG6BhK/5YO138oDfYjgflwufickSjUi
         /gvw==
X-Forwarded-Encrypted: i=1; AJvYcCUuVEd3oggVLT3plUrqTFNJu6UiQeJsusswGGbCBqldREjqmPvGMiW8YonP7qDa7bkXQUo20PQIUiGIFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNTG0n7/yZ35GbNYRCB+Nn/QZCYT3wDQPD6/6lMA1nyWPtRKxA
	2+dvDGYaDvUSCvSznJMN41LAQaVC876IwXBu2s+tRGMBvNyXsStAQjQ6INwfNDAhz3zdLSXg1f1
	BBcMXeXm8zWLZi77a7T3tStNGuqGE3IGTlrFb/MwEj9YpbdTrvpU/HFYn8a9VoUb2
X-Gm-Gg: ASbGncv4tgizK5LcYG/Y2CxyomvvGgTStL2Ov8ojOeZEYNIpjDeRL70gW8S0d3d4i+b
	sow0FxZHt3LAEOGyKmF4BfDrtQBgT1OtIk3H4kDXDnZ5ifzheBJtfyTFJB+lbavJB7xGMePz3+M
	ZCvpDpccjhD3cpbgXeZMZ360oHXTn5M0QbRijmZNdKBG6HwoYqom3eZDaEsCqoxJ7IX6T2Xv3cR
	hCaluQ67Euhr0YpOL0oFuqY9hNAa9oZ8fKEaYR6TfRFtrA12Mem8dOLIrnMApqpPkMsyORMe3nG
	VUNrFb8Bdgv+pMhhYoKi1zzRrVT1jq+hpq3SQDd5IsP/bXyr6vBaXLnWswsAJDo=
X-Received: by 2002:a05:6a21:329c:b0:21f:bdcc:843e with SMTP id adf61e73a8af0-220a12a7bdfmr25950519637.11.1751379330736;
        Tue, 01 Jul 2025 07:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAqqjmvMONRgF28Ze2pDlWlSW3k73ymZXX0NrkVI1QPI0pM4v+y9MA2CCJ1Re2hZc2Ab4Nkg==
X-Received: by 2002:a05:6a21:329c:b0:21f:bdcc:843e with SMTP id adf61e73a8af0-220a12a7bdfmr25950462637.11.1751379330167;
        Tue, 01 Jul 2025 07:15:30 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3008e2esm10726566a12.16.2025.07.01.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:15:29 -0700 (PDT)
Date: Tue, 1 Jul 2025 22:15:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 1/2] fstests: remove duplicate initialization in the
 testcase
Message-ID: <20250701141525.iwjz5y3lawy3olk7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1748058175.git.anand.jain@oracle.com>
 <ef4d2dbb8d82020bc3eac655d03650bfbd77f9ff.1748058175.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef4d2dbb8d82020bc3eac655d03650bfbd77f9ff.1748058175.git.anand.jain@oracle.com>

On Sat, May 24, 2025 at 11:57:13AM +0800, Anand Jain wrote:
> _begin_fstest() already initializes several variables, including `seq` and
> `seqres`, so remove those redundant initializations from the testcase.
> 
> Also, ext4/053 unnecessarily re-initializes `here`, `tmp`, and `status`,
> which `_begin_fstest` already handles. Remove those as well.
> 
> and remove template comment.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Thanks for cleaning up these redundant codes,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/253 |  3 ---
>  tests/ext4/053  | 10 ----------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/tests/btrfs/253 b/tests/btrfs/253
> index 96ab140f1780..a0cc9b55de69 100755
> --- a/tests/btrfs/253
> +++ b/tests/btrfs/253
> @@ -28,9 +28,6 @@
>  . ./common/sysfs
>  _begin_fstest auto
>  
> -seq=`basename $0`
> -seqres="${RESULT_DIR}/${seq}"
> -
>  # Parse a size string which is in the format "XX.XXMib".
>  #
>  # Parameters:
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 77b3ac8171f0..55f337b48355 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -9,12 +9,6 @@
>  . ./common/preamble
>  _begin_fstest auto mount
>  
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -
> -here=`pwd`
> -tmp=/tmp/$$
> -status=1	# failure is the default!
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  _cleanup()
> @@ -27,13 +21,9 @@ _cleanup()
>  	rm -f $tmp.*
>  }
>  
> -# get standard environment, filters and checks
>  . ./common/filter
>  . ./common/quota
>  
> -# remove previous $seqres.full before test
> -rm -f $seqres.full
> -
>  echo "Silence is golden."
>  
>  SIZE=$((1024 * 1024))	# 1GB in KB
> -- 
> 2.49.0
> 


