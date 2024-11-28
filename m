Return-Path: <linux-btrfs+bounces-9960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE929DBCE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 21:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7B8B21982
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329361C3035;
	Thu, 28 Nov 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="M5bBp7Q7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E71428F1
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825838; cv=none; b=Ir069iirBzCrRA5jmbJ48Lzq8WhJiTcEB9r2aOZmNEVHk9C7PhIEr4tMvlXGtYKhGGVVmW1f9ou1WXt9eL0lx2S6J0j4b94b1/VxRSGAVUDLbJ63qZCUKFChtNc9djyA0EI2Vri7BynMum1Kb06pwtaM49vY9uienxl1bqFhJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825838; c=relaxed/simple;
	bh=n12ow44lAhdzVwbinu9sZUxhMtOzVoooRBaYpIhnPlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUeMUhWs2U0vQ5MgqFSYEiVELVjJWCZTRgbJpvPzsP6GqkllkugVSZLB20pSlL16rJCklS3mMkwNcAd4zfBCvMxEsETGpD8R6wMM37qB2k+c+wUUj1mvb8I7qf9ellaofqf8KaDPbFOLzT3hvyhpBvuPXtglbrQ1dnkQytvyhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=M5bBp7Q7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720c286bcd6so1038669b3a.3
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 12:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732825836; x=1733430636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeqR/EGgcmggqo0Vk/FFbAdn8P5erKXJ4ShxgvlxqnQ=;
        b=M5bBp7Q7QdQfTpEO4am06nsZKAlRC/8wuSvkuWVWtumWQYKJkRIa7pJTtWCtfqV4B2
         R1Tcxs7vCEMFMnbsTLKy8YDGKhi0/rnVjxqJ1pGdMDAMQvwObwpXXBJK6HpDDQ4KnzEO
         itRcifXZ0y4fKv5oz+HaDJ4EUZk5Y/CjcEqn/m0LrqyoaNn0Kymw9nqODEyqTTWoZVZZ
         sDtys3zUdP/r5ntKc1oiwSn4ip4wOKgZWEd/pQwPaEkFFDVQSUoA1ZLsSt7EPhGDBUPR
         dLRPDVpTqDU0c+c8xopYgyk/7KAMvoEhW7dTaD0faOW7MhxaUN+6N4a5IDElJEL5FJ9v
         76Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732825836; x=1733430636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeqR/EGgcmggqo0Vk/FFbAdn8P5erKXJ4ShxgvlxqnQ=;
        b=JDDkuNiuAcuqTtmWzuJx+cilaA1BinmHY4Lhd6i9oYdAWfXHVPY6e6S3JFgumSsjaz
         XiNRChlsj8o5tFA1Hx2PgtSw8jNIXwMo7kfSqfHNIdurUu7ZfO3CnJJdcpwYD2+U5ZVj
         s2qTF1sk+S+3TKBwrXjWFJ5uG48q0CEJzJPmaTqviqzotUD5faC9m3+cJ0VZWNgcvgVy
         Nhg/uXGKbSB/j5iBY3KZ0x8Tb9OlNWmCek3sWjkgRlWsl43zPGpZThGfAEyC6ETy7CFD
         iXHmXx5pV8u5tfLTQwmhS2GMJwsuYKjz0KALfE97jl2AzHKF69Xj9Ayw0WxATR0aFg0j
         EYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrKZIKdOGl+v2ouOmyh4WUF4r9TAAvfdl0CnlPcSlPjhai9Rjq5AM8nEkasA3Csy1i8MBPXkm7QeUfZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6vfOnuvf8/Om0Vy5nY/rfVdG+rTkoTGxuEHs54Ce5N96qYzl
	1H7g9yawd0FbYEOLfNyMGVKzshZ2fnoC2PHk+oo8dmoR0kfSF//fayutGJVqPzU=
X-Gm-Gg: ASbGncuQ2uRrFp8VYSXkXfeQM9arhh8zWxCqywMkNlWmuvAlTH1tHvLTLGt/yrl5C6B
	FyN7fcgkhaCq6Xk34i877Jv/suMtvgp0L/oBqM6knkXk0YxZGwJGV8lMxoZ/gM6eHMX/xetpIEh
	y3QjnFBx+S4E77pybXEhsxv9MBqdFgDMPKHsXprAC4yDQ/Zm6h2FPGMZUdM88UA/cMP0RzTOjXE
	9UBtF/M+h+LgkF9PlzK8xGIiqHuAhGTttU8IHL9OfiCF/6nxMN9jKZWBQHVRPZtQ4ihImpQJzNQ
	qVlJdRhCTxPUn12rXj607eQrjQ==
X-Google-Smtp-Source: AGHT+IHf0lh3Zz9vS1fG6JvnEgHP58GxgDTAEaTNsbygD81Rtr0PcONJWpLLt8vh3mtJrKR4EmGqtg==
X-Received: by 2002:a17:902:c945:b0:20c:f0dd:c408 with SMTP id d9443c01a7336-2150109b04bmr76782725ad.20.1732825835934;
        Thu, 28 Nov 2024 12:30:35 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219d0909sm17589955ad.278.2024.11.28.12.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 12:30:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tGl9j-00000004F9K-2ms9;
	Fri, 29 Nov 2024 07:30:31 +1100
Date: Fri, 29 Nov 2024 07:30:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/028: kill lingering processes when test is
 interrupted
Message-ID: <Z0jS5zmObJTEWYTY@dread.disaster.area>
References: <7a257c21d2efe2706bac1f2fac8f7faff1d0423f.1732796051.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a257c21d2efe2706bac1f2fac8f7faff1d0423f.1732796051.git.fdmanana@suse.com>

On Thu, Nov 28, 2024 at 12:14:56PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we interrupt the test after it spawned the fsstress and balance
> processes (while it's sleeping for 30 seconds * $TIME_FACTOR), we don't
> kill them and they stay around for a long time, making it impossible to
> unmount the scratch filesystem (failing with -EBUSY).
> 
> Fix this by adding a _cleanup function that kills the processes and
> waits for them to exit.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/028 | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

IIRC there are several btrfs tests that run fsstress that need
similar fixes. I fixed this problem for fsstress across the entire
fstests code base in this patch I recently sent:

https://lore.kernel.org/fstests/20241127045403.3665299-3-david@fromorbit.com/

Avoiding needing to repeated rebase that work by having people
randomly fixing one-off instances like this is why I'd like those
large "fix everything" patches reviewed and merged sooner rather
than later...

Regardless,

> diff --git a/tests/btrfs/028 b/tests/btrfs/028
> index f64fc831..4ef83423 100755
> --- a/tests/btrfs/028
> +++ b/tests/btrfs/028
> @@ -13,6 +13,19 @@
>  . ./common/preamble
>  _begin_fstest auto qgroup balance
>  
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	if [ ! -z "$balance_pid" ]; then

"! -z <var>" is the same as "-n <var>"

> +		_btrfs_kill_stress_balance_pid $balance_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}

This really wants the balance_pid and fsstress_pid variables to be
unset after they are killed in normal execution so we don't try to
kill and wait for them a second time on exit.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

