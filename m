Return-Path: <linux-btrfs+bounces-8167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42DB97EC47
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200CFB21AE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0126C19755A;
	Mon, 23 Sep 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hep4hS+a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A010197A9B
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098227; cv=none; b=VOchuMHa/Gov1hdAcJOq1hmOgkCjtvOxiu4CAXaBx0gEEI13vJ0+E4AmdjlnNq9skDScocvaBQEUwGEDIuQLe+vBIzQQeJ4/zvLhQiJcBhB0gIxf1vCpCxlR+VmqyH1HyqcWp8R/p8yJ3237fu3T4Db7lTAqcCqtQ9YkkwZMLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098227; c=relaxed/simple;
	bh=jlHg7C6osFR4OMf68Q0LoZCjJz2eDOJRWr26Zdry48o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6O0ks8LCAGPAlZPAjHWanrLspE+LaDv+XDyMBCXOXjq581P+dycEehuT38IOinvVtk0TVpKAQmdAct+ZNFQjZzFsqQKdSUG6nSLE4Urpi2YDiw/hMK1MWRH6WaPvYyyO1Mji9wXCGrU33RO6warwUPH1ul5fJDEZm85OEEaKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hep4hS+a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727098224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoW3ECQhmKIKRtGGfW8NIg/GCv2sq72PchHA3Pte/6M=;
	b=Hep4hS+adrjmWjTHpfcnpgcb+rSmatU0r7vefsVz6DtNCqBIRsJayPZGnoKUMq14KeRbit
	UomjaQrbfxLuGFeHLNEYU3wfpC3EtZSwz/6uFLmte9Op5Ghs3LSLEaZbn2k9EEIwS7tGEp
	OeMmZ3dvzTniWmUfU/5QE3RCc8aVl7E=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-ccqPP-rcORy03JJsMEE1Ig-1; Mon, 23 Sep 2024 09:30:21 -0400
X-MC-Unique: ccqPP-rcORy03JJsMEE1Ig-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-718d5737df6so6274568b3a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 06:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098216; x=1727703016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoW3ECQhmKIKRtGGfW8NIg/GCv2sq72PchHA3Pte/6M=;
        b=gJ1QkUJ/B/p97rFgeaHNgQPrRbauqhM6Dbl3r4QQJPKtTHWLLq55L43gHu4mF7x9ol
         Nxe/AvcK6vXaH5YPD07OV51m9GiF5+NaTpzUJ0JRLgLrowMU43hD9ua9djrTveUX4hoe
         b7NAHfeI9sETqA5LAdPO9tWbDcqhortAShCqQwCgfTav4nayJVLgjNET7e1MGT/XUD3N
         1PO4j6W5vBi/gdiYrAMF2eP0WYsQxN0Ne6+H5BzW+SJi+koJq6a406yNq10PMRL2jcAa
         M70+eG8YbNW81Yo3yljVDEOGlPuwhUqtZasFbYJK3GwRPSw1Hj1G7D6lUnCfAoYlftY1
         HTCw==
X-Forwarded-Encrypted: i=1; AJvYcCXHttSgsqh7Kh8MTloixJ/99l17sUdBPBGMEkWsTyZAqBBnEjQp/doD0X55Ux2QaEns0V2dky+KZwc6TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGldHkadFKdh7wASoj+YOkRmKcvePSmlNwUTXun44/cVWNsnW3
	TPI+07iHnQrwOuxVzzr5nrK+WZqMJm/HHMU+wQ8w/RwdtREBi6SuBYaYpL6dqEuGuzccrsUn2yo
	Mjq3u4+aUVr0PXPv81YuCAgz8tPFR3769y5e7qt5GbyceLP/NBoiyUnAkSSkOV9jUc2MG
X-Received: by 2002:a05:6a00:1702:b0:717:8f0d:ec37 with SMTP id d2e1a72fcca58-7199ca03e66mr16716090b3a.25.1727098215525;
        Mon, 23 Sep 2024 06:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErVRf6hr6pQAgmn7XFwNRwdykt6E6ZHAIbGQwgTdEo5blfg4/H8XTnVq4ucHrHY2fCOLTFgQ==
X-Received: by 2002:a05:6a00:1702:b0:717:8f0d:ec37 with SMTP id d2e1a72fcca58-7199ca03e66mr16716059b3a.25.1727098215170;
        Mon, 23 Sep 2024 06:30:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc1554sm13871107b3a.185.2024.09.23.06.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:30:14 -0700 (PDT)
Date: Mon, 23 Sep 2024 21:30:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: An Long <lan@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/315: update filter to match mount cmd
Message-ID: <20240923133011.cmv63zpd3yg37yw2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <29dc7fdf9dd8cfb05ece7d5eb07858529517022f.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29dc7fdf9dd8cfb05ece7d5eb07858529517022f.camel@suse.com>

On Mon, Sep 23, 2024 at 03:57:13PM +0800, An Long wrote:
> Mount error info changed since util-linux v2.40
> (91ea38e libmount: report failed syscall name).
> So update _filter_mount_error() to match it.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  tests/btrfs/315 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> index 5852afad..5101a9a3 100755
> --- a/tests/btrfs/315
> +++ b/tests/btrfs/315
> @@ -39,7 +39,11 @@ _filter_mount_error()
>         # mount: <mnt-point>: fsconfig system call failed: File exists.
>         # dmesg(1) may have more information after failed mount system
> call.
> 
> -       grep -v dmesg | _filter_test_dir | sed -e
> "s/mount(2)\|fsconfig//g"
> +       # For util-linux v2.4 and later:
> +       # mount: <mountpoint>: mount system call failed: File exists.
> +
> +       grep -v dmesg | _filter_test_dir | sed -e
> "s/mount(2)\|fsconfig//g" | \
> +        sed -E "s/mount( system call failed:)/\1/"

Oh, there's a local _filter_mount_error() in btrfs/315. I thought you can
change the common helper _filter_error_mount() in common/filter. So maybe
you can merge this _filter_mount_error into that common helper in another
patch, then other test cases can use it.

Thanks,
Zorro


>  }
> 
>  seed_device_must_fail()
> -- 
> 2.43.0
> 
> 


