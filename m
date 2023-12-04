Return-Path: <linux-btrfs+bounces-587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2DA803C2F
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 19:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C57C1F2110B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8C2EAF3;
	Mon,  4 Dec 2023 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cd4Rcx5T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC80125
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701712969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S07gFdTvxjBn6TX2Pa+e7GXa6i/QSPHuHd8dR5XTGD0=;
	b=cd4Rcx5TEB0P5gXx62cKoM8t3zgAVKR2e3MfbvDwOT6uHHLZKEhmIRPftD4MplUVz4nSVD
	tfq0WtOWcrqdrjk9wq0lpaMibiyCO3Ju3rKJq2n+n1S/TFAA/Xh2UlJjsrQyGrwGZ4ZXXo
	421byMqLiLVsJMOgSd9ZcAu1WuXeKRQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-mhIKeTUFPfGbUmgiOCZUUA-1; Mon, 04 Dec 2023 13:02:48 -0500
X-MC-Unique: mhIKeTUFPfGbUmgiOCZUUA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c641d55e27so2260122a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Dec 2023 10:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712967; x=1702317767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S07gFdTvxjBn6TX2Pa+e7GXa6i/QSPHuHd8dR5XTGD0=;
        b=CgM7JKBvmhWC8HcJd5WwMSGqX7FeTN/gborhi8AyIVPJNrWb9p2el7xrw7L8WY2GIV
         buX/HBTZ8ntLRn0fL3QMl2bFI9Luhpyn6lPwflP711OC5tsoeJIU17WI8kECY1F9A18O
         emlq91/VwTubCO/l77KSFgTkutaBMA3XZcT4ZFzS4w0r/nKL+T1mmHJGedBDjZWq3toH
         +GNS+xpFKQe4XjF97ky2r0pwCIEijm+bBCCj3TsStgfGkfCLF05u2amj9/xuGtaD1mup
         rvLHx/2A/qCxT/wWab73iA/4zO5LCPElTVOqs6xjMVI2CMgMB7zdvuAAcxgWJiy+m+vY
         sh6A==
X-Gm-Message-State: AOJu0YxoblxqBAoAmHuIPDuIvTelgX3DDBlMRAkH2DFVw++utwiwIrZj
	Jt9mr/H8jM6Lp4YQ1mrdqQlZ5DMzSEgtTXc6L3wZcClcOKKNBVUGMDfnXyysRFj3PJQBUfPGjaO
	9CNfJ64SZJVb6EOVER6hdYxA=
X-Received: by 2002:a17:903:230b:b0:1d0:4759:bb60 with SMTP id d11-20020a170903230b00b001d04759bb60mr149489plh.26.1701712967182;
        Mon, 04 Dec 2023 10:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXz9B6FC1b/LfH3sB1Q1bVeZnMGGU+M5QlJpTmAWV7yePNifpg/xL4KaV2Ekg/rlymbzUgFw==
X-Received: by 2002:a17:903:230b:b0:1d0:4759:bb60 with SMTP id d11-20020a170903230b00b001d04759bb60mr149473plh.26.1701712966773;
        Mon, 04 Dec 2023 10:02:46 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001d060d6cde0sm6034971plb.162.2023.12.04.10.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:02:46 -0800 (PST)
Date: Tue, 5 Dec 2023 02:02:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/2] btrfs: add some tests to the 'compress' group
Message-ID: <20231204180243.3fn6k4vy7v3rt22s@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1701704557.git.fdmanana@suse.com>
 <d3a5bded35e8502cdb609bfb0d950c7160461904.1701704559.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a5bded35e8502cdb609bfb0d950c7160461904.1701704559.git.fdmanana@suse.com>

On Mon, Dec 04, 2023 at 03:45:10PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are several btrfs test that exercise compression in one way or
> another but are not listed as part of the 'compress' group, so add them
> to that group.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Test groups update is warm welcome :) This patch makes sense to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/004 | 2 +-
>  tests/btrfs/005 | 2 +-
>  tests/btrfs/048 | 2 +-
>  tests/btrfs/052 | 2 +-
>  tests/btrfs/056 | 2 +-
>  tests/btrfs/059 | 2 +-
>  tests/btrfs/094 | 2 +-
>  tests/btrfs/112 | 2 +-
>  tests/btrfs/150 | 2 +-
>  tests/btrfs/167 | 2 +-
>  tests/btrfs/173 | 2 +-
>  tests/btrfs/174 | 2 +-
>  tests/btrfs/259 | 2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/btrfs/004 b/tests/btrfs/004
> index 78df6a3a..381ad072 100755
> --- a/tests/btrfs/004
> +++ b/tests/btrfs/004
> @@ -10,7 +10,7 @@
>  # We check to end up back at the original file with the correct offset.
>  #
>  . ./common/preamble
> -_begin_fstest auto rw metadata fiemap logical_resolve
> +_begin_fstest auto rw metadata fiemap logical_resolve compress
>  
>  noise_pid=0
>  
> diff --git a/tests/btrfs/005 b/tests/btrfs/005
> index 878a8c7c..84634770 100755
> --- a/tests/btrfs/005
> +++ b/tests/btrfs/005
> @@ -7,7 +7,7 @@
>  # Btrfs Online defragmentation tests
>  #
>  . ./common/preamble
> -_begin_fstest auto defrag
> +_begin_fstest auto defrag compress
>  cnt=119
>  filesize=48000
>  
> diff --git a/tests/btrfs/048 b/tests/btrfs/048
> index 93d4a171..7816a997 100755
> --- a/tests/btrfs/048
> +++ b/tests/btrfs/048
> @@ -11,7 +11,7 @@
>  #  btrfs: fix zstd compression parameter
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick compress
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/052 b/tests/btrfs/052
> index 4408de21..0d60d413 100755
> --- a/tests/btrfs/052
> +++ b/tests/btrfs/052
> @@ -9,7 +9,7 @@
>  # file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone compress
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/056 b/tests/btrfs/056
> index e5ac516d..e1263983 100755
> --- a/tests/btrfs/056
> +++ b/tests/btrfs/056
> @@ -15,7 +15,7 @@
>  #    Btrfs: make fsync work after cloning into a file
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone log
> +_begin_fstest auto quick clone log compress
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/059 b/tests/btrfs/059
> index d2ced0ae..76a1e76e 100755
> --- a/tests/btrfs/059
> +++ b/tests/btrfs/059
> @@ -11,7 +11,7 @@
>  #     Btrfs: add missing compression property remove in btrfs_ioctl_setflags
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick compress
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/094 b/tests/btrfs/094
> index e94cf17b..75804465 100755
> --- a/tests/btrfs/094
> +++ b/tests/btrfs/094
> @@ -18,7 +18,7 @@
>  #   Btrfs: incremental send, fix clone operations for compressed extents
>  #
>  . ./common/preamble
> -_begin_fstest auto quick send
> +_begin_fstest auto quick send compress
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/112 b/tests/btrfs/112
> index c3f7fe5c..fd7aaad4 100755
> --- a/tests/btrfs/112
> +++ b/tests/btrfs/112
> @@ -8,7 +8,7 @@
>  # corruption or data loss.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone prealloc
> +_begin_fstest auto quick clone prealloc compress
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/150 b/tests/btrfs/150
> index a7d7d9cc..c21e0a66 100755
> --- a/tests/btrfs/150
> +++ b/tests/btrfs/150
> @@ -11,7 +11,7 @@
>  #	Btrfs: fix kernel oops while reading compressed data
>  #
>  . ./common/preamble
> -_begin_fstest auto quick dangerous read_repair
> +_begin_fstest auto quick dangerous read_repair compress
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/167 b/tests/btrfs/167
> index fb271cfa..2cfcf100 100755
> --- a/tests/btrfs/167
> +++ b/tests/btrfs/167
> @@ -11,7 +11,7 @@
>  # ac0b4145d662 ("btrfs: scrub: Don't use inode pages for device replace")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick replace volume
> +_begin_fstest auto quick replace volume compress
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/173 b/tests/btrfs/173
> index 4972a5a7..6e78a826 100755
> --- a/tests/btrfs/173
> +++ b/tests/btrfs/173
> @@ -8,7 +8,7 @@
>  # CoW file nor compressed file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick swap
> +_begin_fstest auto quick swap compress
>  
>  . ./common/filter
>  
> diff --git a/tests/btrfs/174 b/tests/btrfs/174
> index 0acd65f0..16305c18 100755
> --- a/tests/btrfs/174
> +++ b/tests/btrfs/174
> @@ -8,7 +8,7 @@
>  # specific to Btrfs.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick swap
> +_begin_fstest auto quick swap compress
>  
>  . ./common/filter
>  
> diff --git a/tests/btrfs/259 b/tests/btrfs/259
> index 358a4550..7f053ac9 100755
> --- a/tests/btrfs/259
> +++ b/tests/btrfs/259
> @@ -8,7 +8,7 @@
>  # at their max capacity.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick defrag fiemap
> +_begin_fstest auto quick defrag fiemap compress
>  
>  # Import common functions.
>  . ./common/filter
> -- 
> 2.40.1
> 
> 


