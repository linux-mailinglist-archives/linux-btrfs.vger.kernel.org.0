Return-Path: <linux-btrfs+bounces-2932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A1B86D05E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 18:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BC2286234
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23D6CBFE;
	Thu, 29 Feb 2024 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKsRXX8c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0D692EA
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227118; cv=none; b=KcY2uXssO+wfJmLZQPbCx2+9y5hHFSDJxINwpzeR5FBFmd4HLDb4hLofeKtY2Hj/5o/p3r8fA+lV/QW5GZM4kvMIW20XoKntkJ2FSQT9qtXw6oizZkbb2eA2705a+I1+8zKcHt/wBWzXuAO1SH5q57Lla6jatTkXROsc0QOBl+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227118; c=relaxed/simple;
	bh=MWWRwOma0Xvz79b6rhaLZG5q2Qm38uD50xM8qRIlI58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPulj+Dbp66XuANcMOvVfBV6xsqKaqLSqRMFgf5MLuhfyTS0pJvS7Z0dOvx68p2mJllfCT+VnT2f96rn/jRfSekPRO/bgPVIdyyfYQapxA7vZGfAoxwOAunmpURj5Xwvr9XWZVctCSggTMQq+mHIvIILWUPDHZosV+dN1RA93JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKsRXX8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEB0C433F1;
	Thu, 29 Feb 2024 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227118;
	bh=MWWRwOma0Xvz79b6rhaLZG5q2Qm38uD50xM8qRIlI58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kKsRXX8ctKcbTJDeEP7HaQQayIEcCBBTrlFr5871Phm/7oso0yF4EfqpYhLG1itRS
	 D935yRWjnLSt/AxTFpPKCA/QfwZ7O2Ki+kikEnPBlJFh/L0HP5/KMG2MHKee/VQKK1
	 5XhCOM5SUoqJ1FvQMaZHm2mvog+lWj43Jc/bRxYJAoouDTr4hRLOacKexlKBF5TQnM
	 +M8Vtx28gkyYjXNWEf48WtJdTHNuy+i4hG4IzNl/7dKNqqfWXD2uSyPA7UV0Ougujy
	 82wwZ52w2+N3KotEyyXMA8VemYMQpFlyBjteFhI7qob+JB/jjGy6mnzCyw1c58dT2u
	 R97FTboIrun9g==
Message-ID: <d40c20f1-9e13-439e-9d56-775e861b8650@kernel.org>
Date: Thu, 29 Feb 2024 09:18:36 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: use zone aware sb location for scrub
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 WA AM <waautomata@gmail.com>
References: <933562c5bf37ad3e03f1a6b2ab5a9eb741ee0192.1709206779.git.johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <933562c5bf37ad3e03f1a6b2ab5a9eb741ee0192.1709206779.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/29 3:43, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> At the moment scrub_supers() doesn't grab the super block's location via
> the zoned device aware btrfs_sb_log_location() but via btrfs_sb_offset().
> 
> This leads to checksum errors on 'scrub' as we're not accessing the
> correct location of the super block.
> 
> So use btrfs_sb_log_location() for getting the super blocks location on
> scrub.
> 
> Reported-by: WA AM <waautomata@gmail.com>
> Link: http://lore.kernel.org/linux-btrfs/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Doesn't this need Fixes & CC:stable tags ?

> ---
>  fs/btrfs/scrub.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index c4bd0e60db59..3c8fd9c9fa1d 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2812,7 +2812,10 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>  		gen = btrfs_get_last_trans_committed(fs_info);
>  
>  	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> -		bytenr = btrfs_sb_offset(i);
> +		ret = btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
> +		if (ret)
> +			goto out_free_page;
> +
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>  		    scrub_dev->commit_total_bytes)
>  			break;
> @@ -2828,6 +2831,13 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>  	}
>  	__free_page(page);
>  	return 0;
> +
> +out_free_page:
> +	spin_lock(&sctx->stat_lock);
> +	sctx->stat.malloc_errors++;
> +	spin_unlock(&sctx->stat_lock);
> +	__free_page(page);
> +	return ret;
>  }
>  
>  static void scrub_workers_put(struct btrfs_fs_info *fs_info)

-- 
Damien Le Moal
Western Digital Research


