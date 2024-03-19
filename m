Return-Path: <linux-btrfs+bounces-3444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A916D8804B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 19:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9CEB24581
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167C59B6A;
	Tue, 19 Mar 2024 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gn60DEXf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B80057874
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872540; cv=none; b=SqaOR+kafEKlQRcDgPsbIW7UkkKX+Lfma6XJ/2M8qbCxwM6yKh5z7aUBGMBc3n+YNF/MYumj/KMY+n9nFjpTkIKL+GoGEspvAYnmvJQP5vFxpfKx02TETDCeV+u0FDRuHHKp9XN8Oq07RlsN6IjzxWVgkgu7ZxaM2jBPXXPHIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872540; c=relaxed/simple;
	bh=+IYHQVKPUWwc6vbyxDvXLc7ezfJIYyKLlACr7p2rHao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEif9GemykWZPVwfez8GJWPWfiFC0/iKF+8GtumfWIWeiTNBsNNjwfHN5svV7qivkyCyBhwv5BM5CHuOnnCxhDyaj5HKvVBi3B2e5PlNf731no6P3JUXVBVO787ov+qv7ITMjFUoPhMuqbg9n7GAnhQCTLTaZtNj/mf1nozSlbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gn60DEXf; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-789db18e356so299107785a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710872537; x=1711477337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTbjt2kddsc+sP27LgJuzoEC6YEUSVv7lp9O2P1SH1g=;
        b=gn60DEXfmnQaEKPBTtYGAE85xBeq6rvUmJTAdj0HCkBXwIRfbJo5rjQOlzUDIedJ2R
         ZY9raNstOS2jLqdhvBKK9NNXvsH/MBlsEuSbqhCpJw45oNRY6B/uXgMQGJNFH08yiYDi
         U10Lu1WL7rUFIfXW5SXRdEdN6F7xdIUjX1rEI05EHgPkyHuDNBsByop2w00qsTmKhO2V
         K1R+XPKhq/+NJ8ogsWGK2nSCZSL5QlTUlyVcXh+x+YhQqbYU2+1+qMhKr6kAO3fO07ZN
         /6nFVl5hF3QxYru5Tv42biAd2fEJHuyaXp6LTc3aSLHJToZ3fOS0IRqKRchHAe+tnOKh
         D+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710872537; x=1711477337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTbjt2kddsc+sP27LgJuzoEC6YEUSVv7lp9O2P1SH1g=;
        b=cizXNeuUKhUrokmBZoiZQJWNSiOMeQ6wpxM1cHDGhvVEkEnlkHVu0hoAzETNSldSsN
         Ca1dtARN4bVLpR60/OcNGh8G5a+nhxJYFmhtVN1c8cQKn/s5I2Y+AbdJOL3qG416zYBV
         un4wmsfVM95iRrodu0OKGGcVF3VhJz/2ZfxvN7eFou3sGM6vSRUanGJuzZa5JRsfMkxQ
         Hh/dvD+VD0NF3x9PPHU34Z655C8/gKqFsJcrRLo3HYh8TxpuxEJYIM4wwWXqRJKbxCtE
         c4JxphMQtGhnJIv8OivO9y/6IIFkGWz/jxpAO7Cs/I4bt71UEvdNgrOx/JBa/ApkUkSx
         XdtA==
X-Gm-Message-State: AOJu0YyR0HiV4CIu9viAlv/xySxwa3rZqL7wQY8uKeo7vtWBlgdcL92U
	ftTkp3yIBnxF4bItGVMdfXminpfXMa9bOomjrR7eDdvf0dLSvC5Q4d0vovI7z0A=
X-Google-Smtp-Source: AGHT+IFCOLmG0D5x/fwFrxgSifkiHsBHvEFjOUZ5CRoTMetN84JzEGXtRI3u/bIRiXffCvBo71y5Jg==
X-Received: by 2002:a05:6214:4953:b0:696:42f7:142e with SMTP id pe19-20020a056214495300b0069642f7142emr50742qvb.47.1710872537012;
        Tue, 19 Mar 2024 11:22:17 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id jo26-20020a056214501a00b006961d023d2fsm2599137qvb.17.2024.03.19.11.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:22:16 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:22:16 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 25/29] btrfs: btrfs_drop_subtree rename retw to ret2
Message-ID: <20240319182216.GL2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <dd5209c549f11a1e1b85a924cf414258c398b59e.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5209c549f11a1e1b85a924cf414258c398b59e.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:33PM +0530, Anand Jain wrote:
> retw is a helper return variable used to update the actual return value
> ret. Rename it to ret2.
> 
> Additionally, ret2 is used only inside 'while (1)', which could potentially
> be declared inside the loop. I chose not to do that to minimize the number
> of times the 'while' loop has to allocate/deallocate.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/extent-tree.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index acea2a7be4e5..5064cdd55d2f 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6125,7 +6125,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
>  	int level;
>  	int parent_level;
>  	int ret = 0;
> -	int wret;
> +	int ret2;
>  
>  	BUG_ON(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
>  
> @@ -6161,16 +6161,16 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
>  	wc->reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
>  
>  	while (1) {
> -		wret = walk_down_tree(trans, root, path, wc);
> -		if (wret < 0) {
> -			ret = wret;
> +		ret2 = walk_down_tree(trans, root, path, wc);
> +		if (ret2 < 0) {
> +			ret = ret2;
>  			break;
>  		}
>  
> -		wret = walk_up_tree(trans, root, path, wc, parent_level);
> -		if (wret < 0)
> -			ret = wret;
> -		if (wret != 0)
> +		ret2 = walk_up_tree(trans, root, path, wc, parent_level);
> +		if (ret2 < 0)
> +			ret = ret2;
> +		if (ret2 != 0)

This can be reworked to

ret = walk_up_tree();
if (ret) {
	if (ret > 0)
		ret = 0;
	break;
}

and then we don't need ret2.  Thanks,

Josef

