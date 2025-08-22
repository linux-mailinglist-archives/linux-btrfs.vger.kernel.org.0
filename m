Return-Path: <linux-btrfs+bounces-16272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A8B31548
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 12:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AF9A02553
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 10:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247F52EA165;
	Fri, 22 Aug 2025 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO8Xgdex"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB52E9ED3;
	Fri, 22 Aug 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858053; cv=none; b=iBnNUpE9hXv/QdSwEDnagOvwDCFDJEsHYzEtzlNJVFiMKZE7BmcFwshKLRyMPh8hTEjakm/XM9o1fiz9a0ff3N7WIQ/9jj1mQvzpZEiqsy3mx4/s6MBc6Ucmjpd+s/hOmhNwxeiiGc3qzGziKsbR+DIv2aL8/FZY+sJNWnMeFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858053; c=relaxed/simple;
	bh=4IHddfwKA1y7d8aDlpWPT5Y+ReTtWqd4zgfCWKYI+Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=lYPDMPeMtOzpetMeKOtXWOCW/KE4/wcTybhiQEA+sPrFGojEuaJdEm+f4XFnwfwzaGh6fi1+O3TgHuZDxpwyMEnAp5NR4sbj5+JtR0m7fdYh6u9bLcYi3DdHfPA5yZvJZEwLiEdVGlCxMX8b+JXWmg66bk/Std/VoIoiJ4ReYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO8Xgdex; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-323266d0535so173950a91.0;
        Fri, 22 Aug 2025 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755858051; x=1756462851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SU0KZ50AwWe6P9nwMh2oHmnwP/T+FR1p6gQREYEU6CM=;
        b=KO8XgdexH59w6qRA4LmXi3TtgY63gpJbFUpRsP07m+0dOlhugwVBT3gau2NuYI/uL9
         p8l/F5P6JLTy5s9U6FNhm2Bvg/K13QGU35d+D0dS/QNM1gofmr5MxtAglOTTzlWKlCdG
         zBiU4sKmmpfnLeq2jJGg1wm1lH/TlDOElFESZSJAMIiX2dnCsfmqoO1lSRJ0M6EiSeUv
         TbW8ylCygikGhcUKqvg5QUJSu0D/7AqDSqEwZNoa/mHEe7yo2KYgNc0NH8chKO7hA38S
         jhEd5Epf/F5tZ327Gm3yqCrl68izfK4/WTfFjIp16102g4yD2w9DJyKmZqKxwJghCXWk
         hs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858051; x=1756462851;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU0KZ50AwWe6P9nwMh2oHmnwP/T+FR1p6gQREYEU6CM=;
        b=vnpdw0BeLg9SISMuVAZjpNcxIpfSfpJ8gLO/6E1g73UyUQoD1D4yYH9uhg19lYkYwj
         nN26TS3o3OAlvbWclfTnsp4FbhcPlb5vtNXndF3yzM49vr7eY5PV/WIT/hZzKQHBhweK
         3JYDSsNyrsaOJMjAhLKEut5hEg5zRfGXLtY68aOZTXfPdicYIL1kiTfsgLErDgtkcvcN
         l1eZ3PdvoLd8gFbP7mIyQq5J5yzW748TxdFKxdzDgscJs1kIOQ+ApYPGVVrk2PtsBEs6
         K5tr6MqYE3NfRdpWnb+OBorCJriXHBg24feoTAjotJjq2Oetaq1T2xm+oRUVCKRc9Ats
         5KOg==
X-Forwarded-Encrypted: i=1; AJvYcCVWl2yjJ8AiWB4tIawKea1ttnjeGe0jS4GZokQnTdXFBsYhLS7M+XAEDWL8UFJZOke6wEeB+yNtp9lSnH1t@vger.kernel.org, AJvYcCVgMjFIDnpp2z+k+0kzau4Y35l3sRJ14+eIy2D1b8cAhA6p+MUjClAI/hsRpiC8mZtcT3BTWjBdiJdLng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRycLH/mIxzVWTkLcQiM5Ou7XbAoNqVWSZrtBCKxUOS8gOJUfN
	P69XOGabpn209AhtbmpDVt/XNKDGPYk4zR5OB3UuAtO57EzmEpYzWVsl
X-Gm-Gg: ASbGncsIiFrqfrE3g3mvAZA9JOpH8XljgJ8V6Qy/SWmZCaHKQdfiKl9ecExanf71vkl
	v9TmXT/EQK9nVk+10HlKbBq7uf1ZEnHgfhNcP2GRKWKJkWgezbgID4taUu5E3kJjQ3utLz9UNcd
	GG8YTeZzfZ2A2w9AYBDJOEldafKnewGZ9ESAkopkztzxSiDI/KXm3j40k/ZRv+6H0Hx/xc9VYK5
	JzD7yQbkXum2X16TSvAUG4lNDgqpz+l45bp5nF/mIvghd9Z7HeTYnxp0zMk10K8mkC+SGv9ng/j
	vocSwjv6XpGd/pATpprgRQe+jVj/Z7uoGrwcUOEopXtiW06UmZli9BZbQSZ+9uCdonueIqiGf4r
	vTzjsRE6PIr6NdmTdtJJpBtmQItyS36TEIr7T+Rk/0dtD
X-Google-Smtp-Source: AGHT+IE8D6wg9QW+15hCZNLRSVltSPFMHwrIvKQscjy9+bQVTor2hh/kXElCiTn75XyDtkRpAJeXDg==
X-Received: by 2002:a17:90b:4f45:b0:31e:ffd4:ecdc with SMTP id 98e67ed59e1d1-32515ef2adcmr1661330a91.7.1755858051007;
        Fri, 22 Aug 2025 03:20:51 -0700 (PDT)
Received: from saltykitkat.localnet ([156.246.92.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32515451214sm2091157a91.19.2025.08.22.03.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:20:50 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: calvin@wbinvd.org
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, neelx@suse.com,
 quwenruo.btrfs@gmx.com
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Date: Fri, 22 Aug 2025 18:20:44 +0800
Message-ID: <2022221.PYKUYFuaPT@saltykitkat>
In-Reply-To:
 <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> The compression level is meaningless for lzo, but before commit
> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> it was silently ignored if passed.
> 
> After that commit, passing a level with lzo fails to mount:
>     BTRFS error: unrecognized compression value lzo:1
> 
> Restore the old behavior, in case any users were relying on it.
> 
> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
> 
>  fs/btrfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a262b494a89f..7ee35038c7fb 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context
> *ctx,> 
>  		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>  		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>  		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> 
> -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
> 
>  		ctx->compress_type = BTRFS_COMPRESS_LZO;
>  		ctx->compress_level = 0;
>  		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> 
> --
> 2.47.2

A possible improvement would be to emit a warning in
btrfs_match_compress_type() when @may_have_level is false but a
level is still provided. And the warning message can be something like 
"Providing a compression level for {compression_type} is not supported, the 
level is ignored."

This way:
1. users receive a clearer hint about what happened,
2. existing setups relying on this behavior continue to work,
3. the @may_have_level semantics remain consistent.



