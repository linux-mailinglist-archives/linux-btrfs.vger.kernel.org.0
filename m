Return-Path: <linux-btrfs+bounces-6646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D146E9394B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 22:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5688CB21B09
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB7224EA;
	Mon, 22 Jul 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="kdAjxqDK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A117C8D
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721679787; cv=none; b=Ypep7Rn02O2+LB5/kSUBCUb74Vl2UWP1ZparBHqJX6g5Gc95SLVvfnKauMwa8rhvMcvpQzP798x/1ujHUi32gvqGhMWQu1SGc5AuuIx1kWA4yF4lb4XZzR7DeYEGkuuG6IxxtUjjBjv/xcsLNV2ixRJ0bC4FiAESM3IHmkSOHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721679787; c=relaxed/simple;
	bh=VHUg8U82kSsfric93le/NYObek+cBZorqIDs53wWAM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElFQE5ZYOHqByD6HzGJlLqF65A5c5nrh7QNid8ChE9o7RF5Ho42F0pVgNQw1EtjSnjR+d2VtiPpy+VtH1irNxAghtLSCQNigEyyoUKVz+3hhkvdQPspc4halqQdu4v3IAo2kuBrJsc/Wbra5QrUtyUEMohWX7v7yuecjaDrsMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=kdAjxqDK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d357040dbso595377b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1721679785; x=1722284585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSZlrejlJKn6NwNkAvoHBluGqiv9POvl1yZBuhoSTy4=;
        b=kdAjxqDKubFo2s/rkKmh/mmrFf1Z7DVNE1+lAJCb8MitcZcUK9Et+/fabBlFsRPj4t
         jBYFbHU6hHFTCyJ7ksirWt8iS6Iy4PljCLmm1JjOIoJZuns0iFii3MlorVkA/qJuqNvb
         a2/FSLOMRU7Dq3j839tn4Q32c6YUa7cKi+u0C/FU0fglyAC3IOZroP8KYhw4pwQx7gIN
         2za+7bZynS14KGiSYte07YWtdQzxQqNhDgsiWQRnmehb3GJkne+KdK5lIEMn68VUnP4S
         OxxyMV/EUURXsX6TiLbeIc/UeTV5YFjuNKxMnfITIaqxWqNNfzVF6Y0i4FSeQUfWSV77
         3b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721679785; x=1722284585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSZlrejlJKn6NwNkAvoHBluGqiv9POvl1yZBuhoSTy4=;
        b=tY4KdSHoFbEDegnE6IujFaroHRec7zb7GyVqQwRko/MaMhhPj8tPhwsEteaVoSr/nz
         aVl0b+z16g+0rmULZvqH29F8tLI3usgmjeyTmUfGjpEcw3kAMgtd71ntXtBYDmRzu55E
         ELhKnMtFvbPmJMyIkiIv5E85zPBBiSrCamKPu0LM9oo+TvJ8A9PXN/cnN56RD9VJln9v
         ZqmEUM5+gDG5mtiJuGPWLWQvLOxMgLBig5nJdXIze3d6paKcCsahZZDscMjTyCx4Arjt
         5JOm5T333Z8Tn0BzpOE8MriNjf3ZlTfrntPji4BV7ArFTqSrnJAQRaA5z58PUIjmDx1F
         vRMw==
X-Gm-Message-State: AOJu0Yz3J53rHThC/utOabjeokl6WMeK6zr+cTPRA92ywY99qYVvDH4f
	WideHB+ph5q7Sc3xbLIQWBl5HxS8YF5blo9fw8FVyKJgp2JrI2+wpMh4hMuNywc=
X-Google-Smtp-Source: AGHT+IEGBuSVf+pX83enedLoLNfGAWQDv3jUYP6Dh1NNRwq0F8rowig8a0tOL6uwXSkXRQke3GgEkA==
X-Received: by 2002:a05:6a20:2583:b0:1c2:956a:a909 with SMTP id adf61e73a8af0-1c42857a866mr7224550637.27.1721679785297;
        Mon, 22 Jul 2024 13:23:05 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:400::5:bd9e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28bff7sm59421085ad.74.2024.07.22.13.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 13:23:04 -0700 (PDT)
Date: Mon, 22 Jul 2024 13:23:03 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Neal Gompa <neal@gompa.dev>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
	Victor Stinner <vstinner@redhat.com>,
	Miro Hroncok <mhroncok@redhat.com>, David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: libbtrfsutil Python bindings FTBFS with Python 3.13 on Fedora
 Linux 41
Message-ID: <Zp6_p491AZl-9j5C@telecaster.dhcp.thefacebook.com>
References: <CAEg-Je-tu0DcYvH-mqcv=2xkReYOh9GaeVoJPy0nMD=oqO6stw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je-tu0DcYvH-mqcv=2xkReYOh9GaeVoJPy0nMD=oqO6stw@mail.gmail.com>

On Sat, Jul 20, 2024 at 12:59:33PM -0400, Neal Gompa wrote:
> Hey all,
> 
> Fedora Linux 41 has upgraded to Python 3.13[1], and as part of it, the
> changes to the interpreter API to remove "private" methods have broken
> the build for python-libbtrfsutil. There's a downstream bug about
> this[2], but the gist of it is that _Py_IDENTIFIER and
> _PyObject_LookupSpecial were removed[3], and so the bindings code
> needs adjustments to fix it.
> 
> Anyone know how to help with this? I'm not really sure how to fix this...

Hi, Neal,

I believe that the _Py_IDENTIFIER removal was reverted, but I can send a
patch for _PyObject_LookupSpecial later this week. Thanks for the heads
up.

Omar

