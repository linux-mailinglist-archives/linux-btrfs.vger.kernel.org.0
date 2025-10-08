Return-Path: <linux-btrfs+bounces-17530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9EEBC573D
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F9A3C767B
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBD32EBBAD;
	Wed,  8 Oct 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6BNUUF9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B82EB870;
	Wed,  8 Oct 2025 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934302; cv=none; b=U4BdGnUH5TcdLG0kDw4I+Ikco8iLKD+ohV8nBYIYQl7orq/B4pTA0hzLOOmgWew/0M9hfRuaYmWIa41+jyG12149j9qIxgTyfNM8qLVVwdLW0xWUZY0Fpmc28Cuu+dwyTe2otFOrGL3kaahoM8TlXOFd55gdx61cDeg70oW5Yrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934302; c=relaxed/simple;
	bh=KhITWjAlDA75Xhrp9d3VApovtbLuRsM6A/ZtwfNF9Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDc9qpCCoFKEmy2sVByi25IdlnK960CEPMICyCTbsMLvTUzlDxaDy5hUtoR6T+hsszgl6EJYmqqxAuwK8S/Q8nhQdzcrzGvgVixHvgWzn1jTw032Yn09Sxvu0SI94E4GdK/GU8RtDpceFYY55k/7ee/ZbkY6WumKcJu5GhCFvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6BNUUF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CDFC4CEE7;
	Wed,  8 Oct 2025 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759934301;
	bh=KhITWjAlDA75Xhrp9d3VApovtbLuRsM6A/ZtwfNF9Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6BNUUF9fzCFgBwA6lWu4AAlZ+c2JdoJfGLIgVlmcYreZgCppWaZW8wWAgGW203T8
	 GkhYJkoBPaxwFtnPMJYUqytosZDu+T4LklF2Is9DSKJDdZUshI+Yy0SPkYKsdzeM/b
	 QMD6wrVc7iypFgJJtlV5Xc58HQjtTCJNJHXjMmDmV08nVnMhOQW1A2kEPUF4piXoBu
	 B1Pj42uCXmZW6U7gXVZpmAg2ivDdE5Aj44C9W0YEATafOdXpM6OOsbmBnR7D0gHZXE
	 Mi2oCTyF0HYZeMmr4g8ozSZnpXYl8Poz2GqZA0LghHFp86wf9umjO0Y+R/0HXJdwgg
	 xO3pYcAGaDOzQ==
Date: Wed, 8 Oct 2025 16:38:16 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] common/zoned: add _create_zloop
Message-ID: <hrht5llavtcgd5bb6sgsluy3vs2m6ddzzshkhwqb4fjgujgrli@6px7vpsk7ek3>
References: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
 <VGGoqK-5ZWJTAAy5zOK2QgRfnghNzWtGFoBwL6Sw9bqE7moL7lyTr43XUUgtMM54gKwCKIpC1Jz9u5ZcnpNATg==@protonmail.internalid>
 <20251007125803.55797-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007125803.55797-3-johannes.thumshirn@wdc.com>

On Tue, Oct 07, 2025 at 02:58:02PM +0200, Johannes Thumshirn wrote:
> Add _create_zloop a helper function for creating a zloop device.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/zoned | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/common/zoned b/common/zoned
> index 41697b08..33d3543b 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -45,3 +45,26 @@ _require_zloop()
>  	    _notrun "This test requires zoned loopback device support"
>      fi
>  }
> +
> +# Create a zloop device
> +# useage: _create_zloop [id] <base_dir> <zone_size> <nr_conv_zones>
> +_create_zloop()
> +{
> +    local id=$1
> +
> +    if [ -n "$2" ]; then
> +        local base_dir=",base_dir=$2"
> +    fi
> +
> +    if [ -n "$3" ]; then
> +        local zone_size=",zone_size_mb=$3"
> +    fi
> +
> +    if [ -n "$4" ]; then
> +        local conv_zones=",conv_zones=$4"
> +    fi
> +
> +    local zloop_args="add id=$id$base_dir$zone_size$conv_zones"
> +
> +    echo "$zloop_args" > /dev/zloop-control
> +}

Looks fine to me, but I'm not sure if some error checking would be
worth here in case setting up the zloop dev fails?

> --
> 2.51.0
> 

