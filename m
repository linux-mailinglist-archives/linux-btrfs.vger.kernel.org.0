Return-Path: <linux-btrfs+bounces-7575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459EB961888
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 22:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7877D1C2361F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 20:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1328185933;
	Tue, 27 Aug 2024 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lXQYmu+X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE891156C73
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790662; cv=none; b=lPMo8kp9CZkHoJY3Ut4gaNy79+rU/+8yg2sYxpg9UnN/3TWzNGyABB4DjgBZyQTu5lV+0lYtLJu+7AmNQrzXeEeOmX/FNIDeJ167CMtjyuP9nSjQgTLCGSQJwQGy3OE+SuwOhHoQx66i1nHJjMTJBo4HajA9fMh0d5hLo7Pmnrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790662; c=relaxed/simple;
	bh=DDtsP8I4jfBiOdXTS/N031kRUrwQLxZFpvefg5nrKLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDYCDqrRyJ9Avw0FCWUAyOQ8cUjOwW8DUYzBW9zph7dFojcw9194NN2p1JdLiX7lEF99qD02ThNCPEll/mHezcTr1s88EQtxZX+u7HM6Srj6Xyik2yNYn/2nKtJ7M2gyySZdDWtdFp2aJFDoiL045mOlwm8se2VlyOlHwLM18C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lXQYmu+X; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1df0a93eeso354523985a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724790660; x=1725395460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1DofYjofqf9NSr4srMUkp4IOvDsg9xgb0xtRf9FsKrI=;
        b=lXQYmu+XWt5oosXZo1j8qzfZVKPIpRzq1C38hhlfcX9qE/RRi2glDknG1OeOtMmdtk
         JVHbnCT02hD1erFXGSTNDsfQBWnvk9Qw+tsyIBxvcLlS+sqmjlhSP3Um/QQymDp8Bl5G
         u6lkzFhbzGeiv8cl3jeXgT7EmWCR61eGjmUDLA79crx9t+mLQnuMeD56AXu5pUag/Nvd
         VGBPRXaWlx/Y/jl7uPnbNtP0KFjl5ndrulMo45Ab4E0Ur8V85339rTQKgrPrKIfNunQV
         0fx2hjj4M2KZFuuprqURp3WDXa6L5nHpUmqSYIFoc8wjhY7XmOtKPl5l3Y+OKKa/OnId
         vRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724790660; x=1725395460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DofYjofqf9NSr4srMUkp4IOvDsg9xgb0xtRf9FsKrI=;
        b=NdIWd4WJSN/RF0xMavZ+2PIsZeIlqaiVbqnFhIRrCRZd+bEGwcgelcUWk0Od/yMrky
         tvGwAG5m0JILfP3T94s595qqMjY3hjMaGmsRDQ6b3WeZBEL4PMmk00sKC5YYDYZHky5m
         q48maMUzGyvd+JGiAKfDkryhnoBINmUazPx59KsjOHfBlN8kJ1Af6FKpM1Fi72wNGnXu
         aTqEc0cyPdvcF/tbhetWeC46BquQ/BOMR6Q6YYgIAm8MDuJfR+yvEXBRSnGZ4BnXKb7g
         kb/2VR953ciuiKMWUnEsxaNHXCW52htMcN1o646BJG5PCXOkHDo1FWqP5JLNViQIGkvJ
         GXJQ==
X-Gm-Message-State: AOJu0YwyxIYFVj2/rWn2KRaq1I1F028jlA3xnc77m4o7Z3+TKCHVc8q0
	l8uihKYq6iJwehGt7Qf7oUvw2WOgev9q/vNo83FS8bxLscBfdRbz4xHn5MWgrqI=
X-Google-Smtp-Source: AGHT+IEulBTu3OhQ5p3AtHSYrCJEF+NpiDj0aASNj3n4lp73it0XKv6PFjDjuhwrzbeYUYoCf/KYoA==
X-Received: by 2002:a05:620a:24c3:b0:79f:e9a:5ae5 with SMTP id af79cd13be357-7a7e4e63a6amr477005185a.60.1724790659626;
        Tue, 27 Aug 2024 13:30:59 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41a59esm573962785a.131.2024.08.27.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:30:59 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:30:58 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Message-ID: <20240827203058.GA2576577@perftesting>
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>

On Tue, Aug 27, 2024 at 12:08:43PM -0700, Leo Martins wrote:
> Add a DEFINE_FREE for btrfs_free_path. This defines a function that can
> be called using the __free attribute. Defined a macro
> BTRFS_PATH_AUTO_FREE to make the declaration of an auto freeing path
> very clear.
> ---
>  fs/btrfs/ctree.c | 2 +-
>  fs/btrfs/ctree.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 451203055bbfb..f0bdea206d672 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -196,7 +196,7 @@ struct btrfs_path *btrfs_alloc_path(void)
>  /* this also releases the path */
>  void btrfs_free_path(struct btrfs_path *p)
>  {
> -	if (!p)
> +	if (IS_ERR_OR_NULL(p))
>  		return;
>  	btrfs_release_path(p);
>  	kmem_cache_free(btrfs_path_cachep, p);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 75fa563e4cacb..babc86af564a2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -6,6 +6,7 @@
>  #ifndef BTRFS_CTREE_H
>  #define BTRFS_CTREE_H
>  
> +#include "linux/cleanup.h"
>  #include <linux/pagemap.h>
>  #include <linux/spinlock.h>
>  #include <linux/rbtree.h>
> @@ -599,6 +600,9 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
>  void btrfs_release_path(struct btrfs_path *p);
>  struct btrfs_path *btrfs_alloc_path(void);
>  void btrfs_free_path(struct btrfs_path *p);
> +DEFINE_FREE(btrfs_free_path, struct btrfs_path *, if (!IS_ERR_OR_NULL(_T)) btrfs_free_path(_T))

Remember to run "git commit -s" so you get your signed-off-by automatically
added.

You don't need the extra IS_ERR_OR_NULL bit if the free has it, so you can keep
the change above and just have btrfs_free_path(_T) here.  Thanks,

Josef

