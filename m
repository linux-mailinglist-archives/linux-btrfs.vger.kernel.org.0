Return-Path: <linux-btrfs+bounces-3451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1015488065F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 21:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104911C21D1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 20:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DB83F9D4;
	Tue, 19 Mar 2024 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CzUeB2NO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A053D0BD;
	Tue, 19 Mar 2024 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881956; cv=none; b=jOC8/xXuQpOmgHASju3XyADVib0CBzkidV8jw/AUrjOZWYj92do2CeV0G/HqORirr69fgl73B6Qs285nAdkutxpNQzShmwvjtOrmD+r1RaCEvLbFO5FLkOPjIm87KjX+hKw5HxSCxgjL+lP4VaYvqiiDZBaiEOlmgPROJ4OqsuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881956; c=relaxed/simple;
	bh=nfSIzrgdGDskUnNHb9rZ4G/cGfWKAXa29U+MfoxDyZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiefIuFontgOsgALHsPSc6XD1wb4kJ7/IG3XjraxK4A96osBCKuImjY15xVw3sJTlKsoTyYEzGnJvl4QUzZ2QrRO2GWZ8TrnMsNW4nxh4cX0dosK+AK51vFf9+6PeARNd3OeSIGOeRmy3kPC02ZSAidQZp1vHJ4O7AUxh759VDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CzUeB2NO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dhWvI6xFlBk/gBJivSr8dahpm8uf+c1dxd4oZDJbfUY=; b=CzUeB2NO0+6NVIZDwkpMzOrxmq
	ctG2iOKnYudHgyrPGtW54+xaLmmq5joxsxEHIiaIDArtniaiqG2zTeXsXKb3BLzrv2t1yEMRysLv3
	jFoAIVEh7MrGSJlLm4gZLOYMpifxXosP9PfDaJM7Zmj8m3UYl+fFSwOIuHRCbDVY1QbQ9uO/iksyH
	jv6WaP1aZYrdhiOU0KMWx+mJyTCnqsaMfqh2Z3TNvlJc9VcPnRdz9Y4/aFGJkDajZCx/XrVR2KHlf
	dxqJ7PJTyq89HI6Y5yL5t3CvLp5h8wdsthVqpC5jwqtaaEx9f1A9nNawW2cIGM/73OhYranoqW5ec
	L8goB05Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmgYB-0000000ECm8-46UQ;
	Tue, 19 Mar 2024 20:59:11 +0000
Date: Tue, 19 Mar 2024 13:59:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 1/3] fstests: check btrfs profile configs before allowing
 raid56
Message-ID: <Zfn8n5jmpTAdzBkK@infradead.org>
References: <cover.1710867187.git.josef@toxicpanda.com>
 <65177ca9d943c043f88d8ea034d1e625af3d0e58.1710867187.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65177ca9d943c043f88d8ea034d1e625af3d0e58.1710867187.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 19, 2024 at 12:55:56PM -0400, Josef Bacik wrote:
> +++ b/common/btrfs
> @@ -111,8 +111,12 @@ _require_btrfs_fs_feature()
>  		_notrun "Feature $feat not supported by the available btrfs version"
>  
>  	if [ $feat = "raid56" ]; then
> -		# Zoned btrfs only supports SINGLE profile
> -		_require_non_zoned_device "${SCRATCH_DEV}"
> +		# Make sure it's in our supported configs as well
> +		_btrfs_get_profile_configs
> +		if [[ ! "${_btrfs_profile_configs[@]}" =~ "raid5" ]] ||
> +		   [[ ! "${_btrfs_profile_configs[@]}" =~ "raid6" ]]; then
> +			_notrun "raid56 excluded from profile configs"
> +		fi

Should _require_btrfs_fs_feature check for raid5 and raid6 individually?
Right now it seems like you need both raid5 and raid6 in the profiles
to run checks that probably only exercise either?


