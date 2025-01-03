Return-Path: <linux-btrfs+bounces-10712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D27A00BE3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AD73A4431
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009631FBCBA;
	Fri,  3 Jan 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QvWqEfCB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390011FBC85
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735920819; cv=none; b=V/u6P0tLHV3BekzxxsqTf4r2Vi8r9H0Ff7PPfOBBSSUiSstUQNg3LtH9+k0rgVDx1oZ5LtrAQtbfSPhT1cXFHYb49AHEr63gxmEoSyohQeoumcg1jj5iDYunljPgPYYAT63P7g5ITf4kOtWQf+A4o7MZeVgx9yUVFgdScU64tYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735920819; c=relaxed/simple;
	bh=g15eqjCApM3awBaszdvsM4zrjdSGgXJfvezTQdJ2M0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qov7lZ6rlDyO/ryUCK4HJwbVv3px8BBI5gPrAqNS8DW1OiOcQzuVKwzUGp+BV/LXJjOK/s/+LpNFT6oIAWNCRHhAtvBXailB2S9EAcOeluGVXdSW8sUiLQbughe50+CumtT1VPKLdMiTTiq9WTuWuX4TCGnH6KOy6+jL6fL3e0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QvWqEfCB; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8e8445219so109492876d6.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2025 08:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1735920816; x=1736525616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LdOTZG7Tw8d/29U3QRa4o5UMi9zXTiDsrTfdQrcCUBE=;
        b=QvWqEfCBp9Kx3Fz6MWFMSoapyz50KY2w0ksG56/v4NFQhi1bVf/txOkZ9jsvkyQub1
         T6m+/BLKENqfmlMOypwd2nGZn4MTsjGZL0RCd3uxf6IIS2ATZshiiHQTzM1WfwWCtLTY
         srVvjVeJ+UlzxeyNRm1CeenYmFYLWks4qyzautYuAV2cXn5BMB4SeF2jw/drupsYYS65
         tKB2HFenoKQmAMhTObG8xGrYFMNzYZ12zKWIsOYaeNrGBGqHrjFJpYGoZIre2VbShy20
         fJuGbKOlSNEso93o7FfLCMe9xuBpWxxa2+4I49pa5gBkgXo3qJNXabicQHgcdjNsHygc
         XojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735920816; x=1736525616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdOTZG7Tw8d/29U3QRa4o5UMi9zXTiDsrTfdQrcCUBE=;
        b=k2dTslcz/+1w2u3IBjOZBBcDkCR/yQmjZvLExW6P2XzJY9irnBE0v7kR4a4M0VO0GK
         TVDOMSTiPRJvUuEAD0ekcMgqcS0MdRvvhUNlGGUOBb33a77BdHyifcK9pZ4loJ2ANWqF
         xEjsJSZZT8asTAg91xI2QNls9155ScD1vYfILXFgjs/I1p85pab3LiLjPTSzNjn0TtOM
         mNZdNwGZVjsjg1Y0SXLNaQr5qyUgElaeypikikrr4mjq5EBWwLPAG7MeieiWJZfLIvO5
         +Pcxh9Q8a4RT6lBaokDcWt7N8pceAiUkLXOqC3bLyOZnUoK6ETeQsSclVfKURkxktJ2s
         HKoA==
X-Forwarded-Encrypted: i=1; AJvYcCUkUIOUd3s2mkN9Jvh8J2KYiS25yAJbBqpPbGIkjmfWF+RQ46s7NXAYrRREVpT/GfScDhiQQJY8WxCmGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvhThZ7/219sHOj3dNX40ldtlvx1c6r5sYvizNHzassC83o4+a
	+QLFnhuRmWryPkXegZPQ/n4uhnmo1Va4yHY3eInbQVnJgQrStAmWnbDH29wCDTw=
X-Gm-Gg: ASbGncsrECVkJ/8VclWfuQ3yrTWgolx3mLxsifpf3MgAq2XeRfjzO74zTspfWfwPbvM
	xrr3YmYXyj41K1Nqw/fwWV0fIaOIagSg1V1Opt/75hqj4nojdIBPp3jzvcGeeCgkLG97d1sO9UZ
	N4ioBFupTg5F2HdyrRtxMlavxpjHERCpvVVYI6KBxBREqHTDVgHE/7Nk5t7krfUqDrX4SIt7THI
	kROxCRU78QPcdx3p7JtT5RKGDn48NCFIo1niJVteQBkO4RirXqFzqAjPo52S9IlijKAT3cguEtH
	/WQKSTWxQULVSXX0NQ==
X-Google-Smtp-Source: AGHT+IH8uelw7Uc0//kY5DxUKJxwFOuf13tv7ESB0TelCE45T8Ktv5yUfaiUQQh5pOxu8nWWpb+QiQ==
X-Received: by 2002:a05:6214:8103:b0:6dd:be2b:c684 with SMTP id 6a1803df08f44-6ddbe2bc6c2mr77257976d6.41.1735920815610;
        Fri, 03 Jan 2025 08:13:35 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d5aabsm142763666d6.108.2025.01.03.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:13:34 -0800 (PST)
Date: Fri, 3 Jan 2025 11:13:33 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, neelx@suse.com,
	Johannes.Thumschirn@wdc.com, anand.jain@oracle.com
Subject: Re: [PATCH v3 1/2] configure: use pkg-config to find liburing
Message-ID: <20250103161333.GB4067957@perftesting>
References: <20241219145608.3925261-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219145608.3925261-1-maharmstone@fb.com>

On Thu, Dec 19, 2024 at 02:55:55PM +0000, Mark Harmstone wrote:
> Change our autoconf macros so that instead of checking for the presence
> of liburing.h, we use pkg-config.
> 
> The benefit of this is that we can then check the version of liburing,
> and do conditional compilation based on this. There's a macro
> IO_URING_CHECK_VERSION already, but it's only in relatively recent
> versions of liburing.h.
> 
> This replaces HAVE_URING_H, defined by AC_CHECK_HEADERS, with
> HAVE_URING. I also had to rename PKG_{MAJOR,MINOR,REVISION,BUILD} to
> start with PACKAGE_, to avoid "possibly undefined macro" errors; it
> looks like pkg-config assumes that anything called PKG_* is for its own
> use.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

