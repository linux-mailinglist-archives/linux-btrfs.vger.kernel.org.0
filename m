Return-Path: <linux-btrfs+bounces-18069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FE0BF230F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 17:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14B2A34DE47
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878D52765F8;
	Mon, 20 Oct 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC16KZfl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A82749D2;
	Mon, 20 Oct 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975165; cv=none; b=qH/+6tG2xS3cJhia0qncScRqvLylYDoh6nWjYbgOYmtSrovJkLW3wDpmmOHh+Bgpb8N6hBmvD88EkKyLV8mYL58wJoOIVNRRp90TuRDWrY76ivro/XrFCPkgLv+1h6XuZlxbSZVW+IqBu8nAuFlxge4rkxswswQKoNaFlHcj99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975165; c=relaxed/simple;
	bh=9PHbj/50TJlL2mJs5KAkblwr3rqPCXHavZ+odHpxDqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7lLde5mM2NSx6bkWp19X1eX1R7srU9yo9F65OiA+eUhQhWe4TV2aIYHrhXvBqF0LF35eR1pn6exWWjIn00j1wagRGcND8POEy6Tr3dDhXYaY8KofI1XBAfL4zgWLEhPo0wzl4LX2SOFjg5FDyqHTHiiBVbd3e0DYuO8kTWDpNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC16KZfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68951C4CEF9;
	Mon, 20 Oct 2025 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975165;
	bh=9PHbj/50TJlL2mJs5KAkblwr3rqPCXHavZ+odHpxDqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lC16KZfliaWyzcZ0gI9+JKtjt/tn0hy7hdoQ/kQvODKYWaGEahgsfZNRar5khjYc3
	 xRWIDP5XHJ9R4T5L4Nu6KgbehOWDD5cTRBmB5vWwQxSUfLgIV6ChVSx/QSXEhe8tDX
	 dys7h8h+1VtCWmQpuJYLqLC7s3kW8SFhtYy83ksmDCUNhIGn0mYzbhoxihHrtMbqVx
	 I/YmfIejuSzM0Tsz34pw2JRa5+ju4dtuxuWQXIEwl5J/k0lTozcmFNAkrLo0da7Ywp
	 1lyRTzYTxOiemUjp9DMaT4jxz2JIlWX78Hpc1wBe+CpetBsqwMCvFRkhsji8TrHeTh
	 5RvxXligNsSEg==
Date: Mon, 20 Oct 2025 08:46:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	fstests@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <Hans.Holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH v6 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
Message-ID: <20251020154604.GJ6178@frogsfrogsfrogs>
References: <20251017055008.672621-1-johannes.thumshirn@wdc.com>
 <20251017055008.672621-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017055008.672621-3-johannes.thumshirn@wdc.com>

On Fri, Oct 17, 2025 at 07:50:07AM +0200, Johannes Thumshirn wrote:
> Add _create_zloop, _destroy_zloop and _find_next_zloop helper functions
> for creating destroying and finding the next free zloop device.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/zoned | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/common/zoned b/common/zoned
> index 41697b08..e2f5969c 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -45,3 +45,56 @@ _require_zloop()
>  	    _notrun "This test requires zoned loopback device support"
>      fi
>  }
> +
> +_find_next_zloop()
> +{
> +    id=0

local id=0

(so the helper won't reassign a variable in the caller's scope)

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +
> +    while true; do
> +        if [[ ! -b "/dev/zloop$id" ]]; then
> +            break
> +        fi
> +        id=$((id + 1))
> +    done
> +
> +    echo "$id"
> +}
> +
> +# Create a zloop device
> +# usage: _create_zloop <base_dir> <zone_size> <nr_conv_zones>
> +_create_zloop()
> +{
> +    local id="$(_find_next_zloop)"
> +
> +    if [ -n "$1" ]; then
> +        local zloop_base="$1"
> +    else
> +        local zloop_base="/var/local/zloop"
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
> +    echo "$zloop_args" > /dev/zloop-control || \
> +        _fail "cannot create zloop device"
> +
> +    echo "/dev/zloop$id"
> +}
> +
> +_destroy_zloop() {
> +    local zloop="$1"
> +
> +    test -b "$zloop" || return
> +    local id=$(echo $zloop | grep -oE '[0-9]+$')
> +
> +    echo "remove id=$id" > /dev/zloop-control
> +}
> -- 
> 2.51.0
> 
> 

