Return-Path: <linux-btrfs+bounces-17785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B83BDB58B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 22:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 806E34E627B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 20:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5462877FA;
	Tue, 14 Oct 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrUkVJM+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B33081B1;
	Tue, 14 Oct 2025 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475555; cv=none; b=eBHDlOnIcTElkieBVZO6BTkhlEmUkcvJeYbv6UbwLbSbGh6XbazabseWjCjxQu6F+QQnantumN19fEmL1GGOAFL2ge5FZzD+qRaKRQfAvQzb5YTtB6SsYOgSP2GSIEXkSi4XQhxDjOEgA+7lhy6b1/1uQStSAwbU6uQRhBZWe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475555; c=relaxed/simple;
	bh=XjYyYGgJmt57ka4D8v3npjFk2HJkQ4xCnr786mw4SZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umbouBU2DJNhtfd+9hiCt7SovfhAhduZzptiD7MEbTmcH7XUh5JtSd+BkpmIQdqHmwshgWwOeI8oSMz6u5YehD3wsFY5vzKj6XOgvxdUW9iNc3xchnkXJjv+xPl1+1gQGXBr4w4Q9eY0pWqmCGSkBVhH0flmlZjaQf3G8pgiNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrUkVJM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3570CC4CEE7;
	Tue, 14 Oct 2025 20:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760475554;
	bh=XjYyYGgJmt57ka4D8v3npjFk2HJkQ4xCnr786mw4SZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JrUkVJM+zRwj9ePZh9J4OoyyTjKBDY63DeoU5s2TzJzFn2wuPOy8uOVWZRt7xlGwf
	 ekCvMpHjKeyd6gd1nLokgp8hGQ1PVwI/BboTb75/RICZCbWrKAihfYZybSDvisH6Bn
	 iuwdlqMJ7QczqM0bDE6NKZl7jsK+LmjJliKLUU449tc3L+YGnerRfP/4k9X8ZkLtBs
	 kCgyNjVV+u1dP6rPMB7IhTNPyIP0XEuxfIoQy9Msoa5iy4yu3zv+H3xC4TPllcadWO
	 BI99JnF+ZFYkUfzrtb9dAZb2a1A1MLzlXHqfQm8MfzaVvcl9veHqOoj4kgQeWGu7Dd
	 GRYy1nZAprnsQ==
Date: Tue, 14 Oct 2025 13:59:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH v4 2/3] common/zoned: add _create_zloop
Message-ID: <20251014205913.GB6188@frogsfrogsfrogs>
References: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
 <20251014084625.422974-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014084625.422974-3-johannes.thumshirn@wdc.com>

On Tue, Oct 14, 2025 at 10:46:24AM +0200, Johannes Thumshirn wrote:
> Add _create_zloop a helper function for creating a zloop device.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/zoned | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/common/zoned b/common/zoned
> index 41697b08..55acf120 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -45,3 +45,38 @@ _require_zloop()
>  	    _notrun "This test requires zoned loopback device support"
>      fi
>  }
> +
> +_find_next_zloop()
> +{
> +    local last_id=$(ls /dev/zloop* 2> /dev/null | grep -E "zloop[0-9]+" | wc -l)
> +    echo $last_id

Er... what happens if there are discontiguities in the active zloop
devices?

Let's say you have

# ls /dev/zloop*
/dev/zloop1000
/dev/zloop1000000
/dev/zloop3

That will produce last_id=3, which I don't think is what we want.

> +}
> +
> +# Create a zloop device
> +# useage: _create_zloop <base_dir> <zone_size> <nr_conv_zones>
> +_create_zloop()
> +{
> +    local id="$(_find_next_zloop)"
> +
> +    if [ -n "$1" ]; then
> +        local zloop_base="$1"
> +    else
> +	local zloop_base="/var/local/zloop"

Maybe the default zloop_base should be under $tmp somewhere?

> +    fi
> +
> +    if [ -n "$2" ]; then
> +        local zone_size=",zone_size_mb=$2"
> +    fi
> +
> +    if [ -n "$3" ]; then
> +        local conv_zones=",conv_zones=$3"
> +    fi
> +
> +    mkdir -p "$zloop_base/$id"
> +
> +    local zloop_args="add id=$id,base_dir=$zloop_base$zone_size$conv_zones"
> +
> +    echo "$zloop_args" > /dev/zloop-control

I wonder, if /dev/zloop3 already exists, shouldn't we respect the failed
write?  e.g.

	echo "$zloop_args" > /dev/zloop-control && echo "/dev/zloop$id"

--D

> +
> +    echo "/dev/zloop$id"
> +}
> -- 
> 2.51.0
> 
> 

