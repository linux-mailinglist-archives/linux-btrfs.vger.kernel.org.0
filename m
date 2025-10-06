Return-Path: <linux-btrfs+bounces-17468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D7BBEE29
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 20:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E52D134AA3D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F5C27A12B;
	Mon,  6 Oct 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ7IbBb4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E621C179;
	Mon,  6 Oct 2025 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773975; cv=none; b=rqjCgaTxIxgkrV+w2gdvfrtC5GQ9nsEdhaX0TmlkC9stePTEJkApGMhGZO519cTOOvG0JDDkoTYUmci49IBZ5IeVmded7cNjukqOTq04iA1c8xbPmXfb41K/xPywKW+l3OM6vrzbl7CAyFB8enuXw1jX6MQf+7uBOHBIkG3P7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773975; c=relaxed/simple;
	bh=Pxv3iZg49m0IC+hcCN9x6Z5V/0hHaFtPIcUF5Wk6WA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3ZzUqp7vk10aoDOt2dQ7cp2jCj2B14/6d201t2p48cAAWn4jM0Orx/sOI4Zc4w6uXeW2XpIo1hNoqTytvUFMWBLp5O+Bu0w4nLQRR9Rm7AO2rAJBY5jOIfSKPUi2rVBNRL5rEQJPQqvJAr25pthrwMwzYxcW4Q2z7FhcfKWKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ7IbBb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D444C4CEF7;
	Mon,  6 Oct 2025 18:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759773973;
	bh=Pxv3iZg49m0IC+hcCN9x6Z5V/0hHaFtPIcUF5Wk6WA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQ7IbBb4fV9/3GPIWQac34pPZleSKk9WcchuNsmRamxgcAfUieojCKXcTI5dHXU6V
	 EkCgfDnACEqwq3hzxMj0d7cwnz3+8yxhPJDLkq1M0TGdcmq88JCC3dzg1zXimO2JVW
	 dygcSjrfWsQW1ZioURaBZk81vi1ZY9IBwN5ue6vKBoKOo7uQyyIk/020dwjDmlA94B
	 pozbEpy/6irsfj8OJwe+ffOaL9MsQrye49BRcYeePQfZ49QpYV5lz1LuLePkHNjewZ
	 ldbwPVVehOTq8ohoaD2e7w2uWq3nEiwy2LOWPxW7GYLA6lZ33wmYYr+XNN+aGw+d16
	 5Fye7AV13x8RQ==
Date: Mon, 6 Oct 2025 20:06:08 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] common/zoned: add _require_zloop
Message-ID: <j2eh6uops3wcmt54howb7rgfhc24qcrmjgjsxqiikxdlpiyrms@jemtwvwtffls>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
 <osIv2hvb5W6z_q7Pa3R_LBcRb1NGees4OgVMZtTL2oHkHIGdnf9ymZLAqex_Buy_EBJAqwzK14EoCZAq0HkS-w==@protonmail.internalid>
 <20251006132455.140149-2-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006132455.140149-2-johannes.thumshirn@wdc.com>

On Mon, Oct 06, 2025 at 03:24:54PM +0200, Johannes Thumshirn wrote:
> Add _require_zloop() function used by tests that require support for the
> zoned loopback block device.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/zoned | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/common/zoned b/common/zoned
> index eed0082a..41697b08 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -37,3 +37,11 @@ _zone_capacity() {
>  	       grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
>      echo $((size << 9))
>  }
> +
> +_require_zloop()
> +{
> +    modprobe zloop >/dev/null 2>&1
> +    if [ ! -c "/dev/zloop-control" ]; then
> +	    _notrun "This test requires zoned loopback device support"
> +    fi
> +}

Looks good.

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> --
> 2.51.0
> 
> 

