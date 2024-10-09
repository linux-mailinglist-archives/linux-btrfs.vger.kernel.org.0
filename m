Return-Path: <linux-btrfs+bounces-8739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D3A9971E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E214E282AC0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C491E1047;
	Wed,  9 Oct 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNYkArCa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B751DEFCE;
	Wed,  9 Oct 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491881; cv=none; b=PHbOCJnZAI/O67om06ho74R+svbkiagmx6j7kmhZLWjytG0yxEVkwKPgVslu3goGCYpbT2T8sY7G0RcYWlahy20J05IeVOPJj2lnFKD/Jo2X8zhJZ0FkYRUrRF1O/wHWIi8T0bD+PhWFH24e04sqzBXMAJpB1HBvdkasyg1KUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491881; c=relaxed/simple;
	bh=NjXrBYIKJI3h+TXV1jZ1SdAD4cZgTQYlT3u4UbmIRSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSBdh6upxhXw8w1ngQaENX9VCFUqCTs23qZV9sQaVePE+vH2gs8yrsI2xVgwOQRk7gpEr5c1FKamBNJvV60L0z7jSEab0d+QsY0f836iRWXv9dqfAE2csSGufWRHF7gfSA+pQgOUA8XA1ZO3Rh3/cQWZ5d8oC8JfOeVTJDj+vLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNYkArCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41475C4CEC3;
	Wed,  9 Oct 2024 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728491881;
	bh=NjXrBYIKJI3h+TXV1jZ1SdAD4cZgTQYlT3u4UbmIRSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNYkArCaDf6FzTW+vdsKEqaMZmy/flVccmKxyi6x5Q98dX1lYRZgqZ6Ot0wl2g60Q
	 vLwJpVDFHBYZqbMb3eCSpOszi6whwg1xLLaGkRt7ZVptOqn51cBWxZLLKoGCz7/Vy/
	 RTUQlupSl7uHDThNTU556ag1J3TfXohzhtcW36LSfTnQKwXygLCmAuQwIKiwVHmFXN
	 oyN22MwUUTSsLGCjOPsQl8fVHTTFqesXO5EGVnfV73Xbs7X/R4hK7DjvfQKBHeBJve
	 WlySlEycI9lKbc/h8iryk8Yn4fzr2SnFnVGu5PY6C7fUs2th/tSKsTpQJvnDNUKuTK
	 Xln81rP4FgXcw==
Date: Wed, 9 Oct 2024 09:38:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: An Long <lan@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] generic/746: install two necessary files
Message-ID: <20241009163800.GM21840@frogsfrogsfrogs>
References: <878d46618e9851f7a019f675716630f9517f4e02.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878d46618e9851f7a019f675716630f9517f4e02.camel@suse.com>

On Wed, Oct 09, 2024 at 11:56:16PM +0800, An Long wrote:
> parse-dev-tree.awk and parse-extent-tree.awk are used by generic/746.
> We need to make sure them are installed, otherwise generic/746 will
> have problems if fstests is installed via "make install".
> ---

Needs a SoB tag.

--D

>  src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/Makefile b/src/Makefile
> index 3097c29e..a0396332 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -38,7 +38,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> 
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>               btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> -             soak_duration.awk
> +             soak_duration.awk parse-dev-tree.awk parse-extent-tree.awk
> 
>  SUBDIRS = log-writes perf
> 
> -- 
> 2.43.0
> 
> 

