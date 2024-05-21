Return-Path: <linux-btrfs+bounces-5136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66D38CA5AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 03:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616FC281F9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 01:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D598C1A;
	Tue, 21 May 2024 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="m2a/uHaD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIGN/IMp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FE4A09;
	Tue, 21 May 2024 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716254237; cv=none; b=r9QjWLpB9VRCwE1lKHOpI07+FwaBODbepqUxpueLlcGTSpOZMZTpLyRF+8iccHVBeELI04rE2qcimA7E8+S0WOTAKZrJ+GtpiD5TrnVod2tykbTDfJ94QAF3AhnYglRxyDY8UN9cf0VaPkrMzzuC3dXv3cqQIryr2y4mRM51vV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716254237; c=relaxed/simple;
	bh=4+Vh0ysn4OLjzpyY20xVlQbJAvMB9VCACx6lyWAFEIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjQve1E4Fpr1EeHJqq2oUII/JA9dqqWs7bW8GAs00s27VZNaXHs4omMB57sNCpGHxeL7U6xIuZiIKu3VSBlgBanc4JskNf/WnYvyRbhk+WmZvNcG25dLZIXLW7ye0yCTOWSSlxc6bsoS9jMUH9dwBFh8x5BZ7uhXG/cACgmON7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=m2a/uHaD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oIGN/IMp; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 3417A1C0009A;
	Mon, 20 May 2024 21:17:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 20 May 2024 21:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1716254233; x=1716340633; bh=Wh+Rt4kDp1
	vWoSPUJJ1Pj7uBJFi66PlqEsO+fjH/VbQ=; b=m2a/uHaDINC2fSlYC5Pxmy3Qkf
	zByoGhIZAbt1VYsUG66FVYm6RI4e/ub2SEj4h0N1m9bikGeg4haTfd5Y4Fzgg8bL
	Y8ZwKnZF2rLRKd9wlBeDihrAB47U4FjUJhjwuN6cpRx53SrIjgnXu5Rt/8cio6te
	5tO83pG9eY2p+3scbz5SsJDza/wxNNxZNdcpPC3Rf9b9SyWYz/HlB8PAHB83QGnH
	bgZin8WmlD3/VjVlq8HKk4LSIxuIAFBfTQGIO98lzfZn3ABQ+dLos9CNHTxSOQnT
	lW3Zcl0yd9hMC8gJ2YVvQ4Ggnto1/2Z0ZKfLgCkLbbcHLJTY6CwBrfMVwYpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716254233; x=1716340633; bh=Wh+Rt4kDp1vWoSPUJJ1Pj7uBJFi6
	6PlqEsO+fjH/VbQ=; b=oIGN/IMpAHWZXLxjXGy7p46JAslsasE+mcass5HjSjPh
	OLI6VcOhSN74HTZMUpsEz27eVM6++C2B9Wx768sScOsmTO1KBJOtj8rnodguQ1jH
	p9cL0HLUMQayEJXBfOyB69NI2rVlBcSQ7gJIEWqZJJjlOZmO202UEp+FLclJq9Gv
	AFCylAvm1yo+76e6UyMe7Vahdopt7Cs8OQ2jdwG4of/U5iOzYqdMNCWKpX+qDicV
	WYlDwSehWcn+zlzoHOmNRm/aCP/SxAvVCKpJA03alD011j9vYhMjKrmO87YJY/wf
	UrqdSG+OyG/XqmSf44HSJXGCU8p5jwpArlT8ZPtmlg==
X-ME-Sender: <xms:GfZLZpeXxOsiI30R9bVVpeKI3-VjNuoHYIxVxi4IxDuQz3eDDnSUmg>
    <xme:GfZLZnNREPxjpvY2sVq4RyS3fKVPtvmj-U7r6XTkpqFmnC5pFsJcmCnFf9guBAXm7
    tVlnBjjVPlc-dKSQu0>
X-ME-Received: <xmr:GfZLZihYhMPkxl7exCAKgA1XYLC4XFqXiej3xzeqiq7swVCOmevJw2n0GnQYDSyKfBLBgnOXYghK4zU18IKj-UMJMy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:GfZLZi_lUGD8BBlD1tiHddnWcwF0c7nxMWxnjqv2rsro_UX-BJSZEA>
    <xmx:GfZLZluT8fVYM8lALtaAXTRw4XeK7-hnJsFYMU2fwtSfCrB_0MM_fA>
    <xmx:GfZLZhEcCgUIbQ_AVfEFovZQIjiAkeX2proZUCDLZELUR1vDwqZC9g>
    <xmx:GfZLZsPKzko89Q_pEHglllTrfrybeNgF4ybGD5MJ84_dfsaYarlFhw>
    <xmx:GfZLZtKS2XCcQxAD9z4JzspHFEWbPepC6xZODMVYfca97uVRNDdn-ZHq>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 May 2024 21:17:13 -0400 (EDT)
Date: Mon, 20 May 2024 18:19:11 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/301: handle auto-removed qgroups
Message-ID: <20240521011911.GA1837452@zen.localdomain>
References: <20240507070606.64126-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507070606.64126-1-wqu@suse.com>

On Tue, May 07, 2024 at 04:36:06PM +0930, Qu Wenruo wrote:
> There are always attempts to auto-remove empty qgroups after dropping a
> subvolume.
> 
> For squota mode, not all qgroups can or should be dropped, as there are
> common cases where the dropped subvolume are still referred by other
> snapshots.
> In that case, the numbers can only be freed when the last referencer
> got dropped.
> 
> The latest kernel attempt would only try to drop empty qgroups for
> squota mode.
> But even with such safe change, the test case still needs to handle
> auto-removed qgroups, by explicitly echoing "0", or later calculation
> would break bash grammar.
> 
> This patch would add extra handling for such removed qgroups, to be
> future proof for qgroup auto-removal behavior change.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good, thanks!
Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  tests/btrfs/301 | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index db469724..bb18ab04 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -51,9 +51,17 @@ _require_fio $fio_config
>  get_qgroup_usage()
>  {
>  	local qgroupid=$1
> +	local output
>  
> -	$BTRFS_UTIL_PROG qgroup show --sync --raw $SCRATCH_MNT | \
> -				grep "$qgroupid" | $AWK_PROG '{print $3}'
> +	output=$($BTRFS_UTIL_PROG qgroup show --sync --raw $SCRATCH_MNT | \
> +		 grep "$qgroupid" | $AWK_PROG '{print $3}')
> +	# The qgroup is auto-removed, this can only happen if its numbers are
> +	# already all zeros, so here we only need to explicitly echo "0".
> +	if [ -z "$output" ]; then
> +		echo "0"
> +	else
> +		echo "$output"
> +	fi
>  }
>  
>  get_subvol_usage()
> -- 
> 2.44.0
> 

