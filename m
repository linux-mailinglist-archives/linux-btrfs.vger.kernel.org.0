Return-Path: <linux-btrfs+bounces-20664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0765D3991E
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 19:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C5F130012CC
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95EA2FFFB2;
	Sun, 18 Jan 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IT9rssoN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+HutaW/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC623EA8A
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768761036; cv=none; b=B8PPxXQLByGPqyZhcPzEqzrqhMvdee64i4WA8AzeyWmOa7IGHkvtQA47Xasok1wmtZdDLRVwDXVn3BrqfFESexRnx/yn0W77L+hKuQKQDk5MnlzJNqd4CPlttXay+5i1+G7QtNePW0fGCAw/HtdithIphHB0PgiCwMY5beWh1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768761036; c=relaxed/simple;
	bh=xctVzUnmDdU0FD4ZskHtiGG5Z8wXby3d7Iwq4zHMwcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKbJvdbds6uN+53I+ww7gXWKXguFbaOrSMdyRZpGWLDyvNGn14R/GImpyJEhlEtAL9kuhZAu58Anw4n2VUjclZZhg1FMqLvmlLfwCDvz3vJafUf/jTYnbNrXXIZCmKI35q2tCotDN0hs2cDrhtPuRMgFgU26aIyMuQBGuzLIOr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IT9rssoN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+HutaW/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768761033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3X1KMouVRDZ7Q+OcTSRArrG6BTYnErN1JRr7rEw9494=;
	b=IT9rssoNIcoZemcsGv2YJkPaMPo3j/BnaoaK5FMzgNxla4wtnsaKM4XRWwrqcu7H2nXI4p
	YJnqjrDux2tcoSl1t72DcQBfgJkpVH5sCs14L3TC4v+7zXSbDfyQBfLcJH617me7ZkA6ML
	nABpgdow2AyCOHYAu4ODsBFDu8spdwc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-Se-udBtnNGaEPqi5slsieQ-1; Sun, 18 Jan 2026 13:30:32 -0500
X-MC-Unique: Se-udBtnNGaEPqi5slsieQ-1
X-Mimecast-MFC-AGG-ID: Se-udBtnNGaEPqi5slsieQ_1768761031
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a089575ab3so30639675ad.0
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 10:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768761031; x=1769365831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3X1KMouVRDZ7Q+OcTSRArrG6BTYnErN1JRr7rEw9494=;
        b=R+HutaW/agAoRkyc+W8rPRG8qJXlnAy/ogdxYAFjX5DRybMTDQOrk+AXB8jdy3arDG
         ZKWB6CnZE96GVySJiCxbIFJiIXqtWOZXbLZ5OeAlyBwMPkjAFDEgKxGipe7GFJF49RdA
         qB5uRIL4EOUx/SPrx39OfY1jzaIAncDD8Mtg63dIQ/MNoP1HRZYmDtYCJMKRybK1XR3C
         MCqzdVoZ7GlmFyHUcnT6pd9QUTdkUmRBipC4j5672zv2+4oPf9QDBMC/sznuKOAaCMlH
         IjTs5c8gTgNfFNRrHV7Qot0NDNA0u4zWqlO5w0ujc46Vf576KZgZAeFW4AxOI3nMkOkQ
         9hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768761031; x=1769365831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3X1KMouVRDZ7Q+OcTSRArrG6BTYnErN1JRr7rEw9494=;
        b=HSY5stVf9ELGrkgXHpgeDLmBeXWkHQFfIpQvJoxHJy4E1E7wWc/m/mx5UqbaAFtlXZ
         qi3TbynqBJxWEP8eNg39FiKqUjYJs5WxPafnEh7xz0R87kBBfBuY/Mu3qLVGH1hAq6Hf
         zVcFUGyrNeVUYDyoSO2uFyxSf/fMCHDc1XfwO+AMHxb0tAvL3sp4T/7q+uJzk6j0MpnL
         B8ml3XkRa8hP6pWTuYn4uVAUYto5wcjb7faYeRCqnEuEgA6RLwNRRoDfuQg4+hPFzsVt
         kZtA65rzRdZFQkGyw4DacHlf/fTfS/sImw8PETIlhkGPY+EaDVPhiRFjGVYYXtcTtsuL
         SDFg==
X-Gm-Message-State: AOJu0Yz60zkZ64b+6C5op5sIFPE9NDI0pT4AIrcGMim91w/1Si2+C/Fa
	HSa7PzRAbff2VvYzGDqkn5QQ7NQaN6vFlGuts+EFkltc1VJq0zMGedPh6ecAnLYficxU3csVfeQ
	kJrbo8ZOExSiB3ki0cbF2MoQgLh254112DpTGJjwXOQH5DJZwpiEefsa5BWkrTXUF
X-Gm-Gg: AY/fxX44vmtF2zrgwFP0bGbvAPkdx6LQvfEADMzRz2bybuj7ym9u+atr1WyZeBdZ5m+
	c5QcFefvGCOPIDqc5BwjMijqjWneR8KfDjDZ7wD3i0ExkrunvrDwzLv4vFWo3HAIwKor9KmSo2d
	bKfwCG0ADJab7pZkv4FQbEOPXSIMBpuRBb58uOthwCnloSdy0Fvmx755FBBFlTxBPE5wgSB2DhM
	5Bdc4ustqg0CMiN/kEJ/Lbc5bj/QTleHzQcotnCedG+bqvXoubx89kZ2MgjfJttNpbeXzYRFKes
	F2enow5NZBFq4uFPFOhoNScTzIjikiEqZUnoiv9xa6bEno1LxdmcgABY9jIPtGWzNJPkPNtL+3c
	sg3bv+zAKhV00i76CY3D9/H+2NuLbfGpL5Fx00CuNX3Z3jFb/Bw==
X-Received: by 2002:a17:903:124f:b0:2a0:d5b0:dd80 with SMTP id d9443c01a7336-2a7177d3737mr85656505ad.54.1768761031311;
        Sun, 18 Jan 2026 10:30:31 -0800 (PST)
X-Received: by 2002:a17:903:124f:b0:2a0:d5b0:dd80 with SMTP id d9443c01a7336-2a7177d3737mr85656385ad.54.1768761030816;
        Sun, 18 Jan 2026 10:30:30 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ab921sm71169075ad.8.2026.01.18.10.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:30:30 -0800 (PST)
Date: Mon, 19 Jan 2026 02:30:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] fstests: btrfs/131: add explicit v1 space cache
 requirement
Message-ID: <20260118183025.og6jq4rczm5hndz4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251225221553.19254-1-wqu@suse.com>
 <20251225221553.19254-2-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225221553.19254-2-wqu@suse.com>

On Fri, Dec 26, 2025 at 08:45:52AM +1030, Qu Wenruo wrote:
> The test case is utilizing v1 space cache, meanwhile v1 space cache
> is already marked deprecated for a while since kernel commit
> 1e7bec1f7d65 ("btrfs: emit a warning about space cache v1 being
> deprecated").
> 
> Furthermore quite some features are not compatible with v1 cache,
> including the soon-to-be-default block-group-tree, and hardware
> dependent zoned features.
> 
> Currently we reject those features for btrfs/131, but what we really
> want is to only run the test case for supported features/kernels.
> The current way to reject will not handle future kernels that completely
> rejects v1 space cache.
> 
> Add a new helper, _require_btrfs_v1_cache() to do the check, which
> checks the following criteria:
> 
> - "space_cache=v1" mount option is supported
>   And to handle default v2 cache behavior, also add "clear_cache".
>   If the kernel has completely dropped v1 cache support, such mount
>   should fail.
> 
> - Check if FREE_SPACE_TREE feature exists after above mount
>   For bs != ps cases, v2 cache is enforced to replace v1 cache, thus
>   we need to double check to make sure above mount didn't result v2
>   cache.
> 
> - Check if cache generation is correct
>   If v1 cache is working, the cache_generation should be some valid
>   value other than 0 nor (u64)-1.
> 
> And replace the existing checks on zoned and block-group-tree with the
> new one.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

This patchset is good to me, if there's not more review points from btrfs
list, I'll merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/btrfs    | 25 +++++++++++++++++++++++++
>  tests/btrfs/131 |  7 +------
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 6a1095ff..c2d616aa 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -630,6 +630,31 @@ _btrfs_no_v1_cache_opt()
>  	echo -n "-onospace_cache"
>  }
>  
> +# v1 space cache is already deprecated and will be removed soon. Furthermore
> +# the soon-to-be-default block-group-tree has dependency on v2 space cache, and
> +# will reject v1 cache mount option.
> +# Make sure v1 space cache is still supported for test cases still utilizing
> +# v1 space cache.
> +_require_btrfs_v1_cache()
> +{
> +	_scratch_mkfs &> /dev/null
> +	_try_scratch_mount -o clear_cache,space_cache=v1 || _notrun "v1 space cache is not supported"
> +	_scratch_unmount
> +
> +	# Make sure no FREE_SPACE_TREE enabled.
> +	if $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
> +	   grep -q "FREE_SPACE_TREE"; then
> +		_notrun "v1 space cache is not supported"
> +	fi
> +
> +	# Make sure the cache generation is not 0 nor -1.
> +	local cache_gen=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
> +			  grep "cache_generation" | $AWK_PROG '{ print $2 }' )
> +	if [ "$cache_gen" -eq 0 -o $(( $test_num + 1 )) -eq 0 ]; then
> +		_notrun "v1 space cache is not supported"
> +	fi
> +}
> +
>  # Require certain sectorsize support
>  _require_btrfs_support_sectorsize()
>  {
> diff --git a/tests/btrfs/131 b/tests/btrfs/131
> index b4756a5f..026d11e6 100755
> --- a/tests/btrfs/131
> +++ b/tests/btrfs/131
> @@ -14,14 +14,9 @@ _begin_fstest auto quick
>  _require_scratch
>  _require_btrfs_command inspect-internal dump-super
>  _require_btrfs_fs_feature free_space_tree
> -# Zoned btrfs does not support space_cache(v1)
> -_require_non_zoned_device "${SCRATCH_DEV}"
> -# Block group tree does not support space_cache(v1)
> -_require_btrfs_no_block_group_tree
> +_require_btrfs_v1_cache
>  
>  _scratch_mkfs >/dev/null 2>&1
> -[ "$(_get_page_size)" -gt "$(_scratch_btrfs_sectorsize)" ] && \
> -	_notrun "cannot run with subpage sectorsize"
>  
>  mkfs_v1()
>  {
> -- 
> 2.51.2
> 
> 


