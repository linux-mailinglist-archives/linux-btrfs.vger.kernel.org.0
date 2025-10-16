Return-Path: <linux-btrfs+bounces-17894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD9BE4573
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFF6034E01D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B73570C6;
	Thu, 16 Oct 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBl4g0ey"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A420E011;
	Thu, 16 Oct 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629715; cv=none; b=tNGnyQieLV+4pqaPvG1dCKolwt3EbDYObTIxqguwbAeuTfd41nMB0HUgueoIuPOrVsgFjqS9nBOGY68NCpd+9nHjETHg8spAuj4Sc+G5CPiEgnz2ua0KmVIqs/fpJiK7T2uaLW4Z5pPTpij063Bf3qFU9nKt1kRUvInY6Typc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629715; c=relaxed/simple;
	bh=m8KGPY3P3vdwzKOdFyfQKOkPoC72pD1aHK18meJPp84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb4LUlMa+JMuGdmGEdxgjfFdcsieBIXeVBdYk6Zqj3Ttc753eZtYXoaUwmCgyLqTBhFxTgQB00JsDC3JfkZEr0CRn/eIAFPd3DHyMmXT6L4sMQu4p5+EE+NZZByAOVvdT+DFAjDDGLlGMoDfu5ToCg38Z9TfpIzfFS7d0QzRiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBl4g0ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB01FC4CEF1;
	Thu, 16 Oct 2025 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629714;
	bh=m8KGPY3P3vdwzKOdFyfQKOkPoC72pD1aHK18meJPp84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBl4g0eytFqbOcc7k0boDP5SDXvBET0qeZZpTj3MKTVWNZEit0w5ojeEnAcYFiGz4
	 4P4SHY1fMWakQ9qqTwdZcBLBW9EXhw2WafXyjsv7Q28OnC9C3snjaKctx/HTiMWhVW
	 RsL/0Fh2Y97+d1O+jyk80KxTUYUlyB+EyN98bp3kZBqSokjDKYtuSSLeDsPdT1dTxp
	 YQqjobsYbw4sPVeJOSn37YRVbSHL93R1E+Uz/hsjHOvux9zsDT81UqU8qa2DBcz4p5
	 4LSH+AaAWspMinP5dsJQ/cnnphEMp/LXBb36G0UHHkGVkBssCYgPA305rDTZfJRm1+
	 aZ/ngCV2aMtWQ==
Date: Thu, 16 Oct 2025 08:48:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH v5 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
Message-ID: <20251016154834.GN2591640@frogsfrogsfrogs>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016152032.654284-3-johannes.thumshirn@wdc.com>

On Thu, Oct 16, 2025 at 05:20:31PM +0200, Johannes Thumshirn wrote:
> Add _create_zloop, _destroy_zloop and _find_next_zloop helper functions
> for creating destroying and finding the next free zloop device.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/zoned | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/common/zoned b/common/zoned
> index 41697b08..313e755e 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -45,3 +45,55 @@ _require_zloop()
>  	    _notrun "This test requires zoned loopback device support"
>      fi
>  }
> +
> +_find_next_zloop()
> +{
> +    id=0
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
> +	local zloop_base="/var/local/zloop"

Inconsistent indenting (tab here, everywhere else in this function uses
four spaces)

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
> +
> +    echo "/dev/zloop$id"

Same question as last time: shouldn't we only echo this if the
zloop-control write succeeds?

--D

> +}
> +
> +_destroy_zloop() {
> +	local zloop="$1"
> +
> +	test -b "$zloop" || return
> +	local id=$(echo $zloop | grep -oE '[0-9]+$')
> +
> +	echo "remove id=$id" > /dev/zloop-control
> +}
> -- 
> 2.51.0
> 
> 

