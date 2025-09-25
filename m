Return-Path: <linux-btrfs+bounces-17189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA219BA0D40
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603A32A8490
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC5530CDBA;
	Thu, 25 Sep 2025 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="IrdpUtEP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n1sUQdGV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9A2FB093;
	Thu, 25 Sep 2025 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821135; cv=none; b=uWYMNNJdYW2jyiu3LifdnFOzoMHkrQOQnRCtbujSt+cOR3PUCwxhSIqii7INmBI+FgNrZ9wcem5TdiRWmKV8XQW7BKBGtn4Yrc/BwnUT8JWDkCx7PtBlMZd8xkM9qH4vabacYZG2bCyBR7q2E7cE0e4UicW6XwxZEx8Yv1UJTOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821135; c=relaxed/simple;
	bh=mtM78JOQ6ROlRs1Ma4a5ZzcL2NDe8ybfSG67rptFN4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig7EiNJAEZ0ZAabQcpFv9JMyNLrI9wrwe+q6oh9wbC4B/ypc1DwPurEpXa04BZA6jwPUTpqZiDmopRNf3MwyEOIBLxhuJj128eCLVFgSy4Xl8mLgS1/CceL6S2THlkCQToj1SrdbkVI0zAiT+zGEgKR7g8FoWa2XPLxX8lpAfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=IrdpUtEP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n1sUQdGV; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 302B47A00AF;
	Thu, 25 Sep 2025 13:25:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 25 Sep 2025 13:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758821132;
	 x=1758907532; bh=1D7TXx7ThMnUjckHRJyBsZj/LvEl7UqvpB3P6P8WLVs=; b=
	IrdpUtEPyh+K/0+kdwsRrzt8+tlsZGkWKH9ftLoeucvUbZgoxLRSrmdCr25RsDXF
	Jr5Ppj/UaSbdNbmxxMM8jO/TtAL1qK9WwIftK0D+qnH0NC/IbLPVcER0O1gmO+0Y
	EEkiFIgxBFs/1hQJJ8UBkCV3260Zd49EHoy/gbr8nhNsHztgXHnfTZocFEsFlOj5
	+DYLVGfC2JZaOLbSOvKrZsPpMyq2t/8s9GSRIWwsnxKL6G+EwK2Px6NKFi/w+cbS
	1fAzhWTf0G2TzU1XYhIY4xeLEYHYmPKp1cFrtiLejW6In/trOJ1Uhllc9mBI9pXD
	2etrwSqE+kKlukJSVWxrXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758821132; x=
	1758907532; bh=1D7TXx7ThMnUjckHRJyBsZj/LvEl7UqvpB3P6P8WLVs=; b=n
	1sUQdGVY/WMEluTxqXBDELk3XxWrQPaGAk2kN0qNFaTQN5K5wbOFcopluJ8q5UEZ
	rhc+mCAaD6jANifivFcm35pt7IozEWAPdP8DjoJ58VCqUOAPqK5wS4GRHh7sxElR
	h8Xzs2KIJjGHnT0hR1nXmbwdJesTm1C7YOYaMbHZdxwWBbz5cBZE3kMHHN320gLj
	oV8OHCE1Li8OzjPJTq/1j32bRKy6C7n5a2O6zFacmk6Ft6A3FRvBG+uitFg9uH4C
	WvIeb/UlE1+rZdE/shJu9AGKEx+0WsksMR+PGzzu2IGsTVRZP9AHCJ9OfwgQtkRb
	lFpMma9PbGYnxmhPkLnTg==
X-ME-Sender: <xms:C3vVaP4Gu9baeWQoudrKD_jJHwsLxMTab1_QCM9kVtrtjj5p3Vzvpw>
    <xme:C3vVaGZYs7EirWEKQxnEwzNVCjrv298tgqD5Ckf1XQNy3kIQBp7eSgCKjnr3bQ_At
    evNdST9U-0c_2QiGE6IBFZsbBby0CwRB3ts_imy1wFJQNbtDJZiYBOF>
X-ME-Received: <xmr:C3vVaGgE5vEOvQjz2Q4d69VEbIov_YN74KeeJxzuOHsnRRd_P5HdAM7Gw5h8CLvCNrUjEp1l2wDP4Jm-Y7Z6BLR2GqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeegle
    ehheejgeduhfetteelheeiffeghfejffethfehkeelueejtdekueegteffhfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhsshholhgrsehmshhsohhlrgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsth
    hrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghlmhesfhgsrdgt
    ohhmpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:C3vVaP-pwep7C8z_swzl27seGbVRpMqSXKGhqV3BTWTx6FR1tCwGpQ>
    <xmx:C3vVaJrDfSLxNhhj-GZYPEhgCtOxnoV_1j5RzCf6L4wipXJtMudPLQ>
    <xmx:C3vVaPXlsYJkamikE1mmE4U5s48YizvNv-J2NXiSSnweAuHBkew40Q>
    <xmx:C3vVaABi-DbvYJceBWq5cXqKyNiTN_7UW_hXwEQRowFXs-Gm7BdXAg>
    <xmx:DHvVaLPXz4HKFmMRRL7eHSKiUBNOUULKh7U5hpMBIax8A6dZvTXdCmr->
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 13:25:31 -0400 (EDT)
Date: Thu, 25 Sep 2025 10:25:29 -0700
From: Boris Burkov <boris@bur.io>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: ioctl: Fix memory leak on duplicated memory
Message-ID: <20250925172529.GA1937085@zen.localdomain>
References: <20250925145331.357022-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925145331.357022-1-mssola@mssola.com>

On Thu, Sep 25, 2025 at 04:53:31PM +0200, Miquel Sabaté Solà wrote:
> On 'btrfs_ioctl_qgroup_assign' we first duplicate the argument as
> provided by the user, which is kfree'd in the end. But this was not the
> case when allocating memory for 'prealloc'. In this case, if it somehow
> failed, then the previous code would go directly into calling
> 'mnt_drop_write_file', without freeing the string duplicated from the
> user space.
> 
> Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>

LGTM, thanks for the fix!

One thing though: I don't like the label names. I think with multiple
cleanups the best way is to name each label with the cleanup it is for.
Once you have some named ones, "out" feels unspecific, and encoding
every single action like "out_sa_drop_write" doesn't scale as you add
more cleanups, so it's just not a useful pattern. It's already quite
clunky with just two.

If you fixup the names, you can add:

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/ioctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 185bef0df1c2..00381fdbff9d 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3740,7 +3740,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
>  		prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
>  		if (!prealloc) {
>  			ret = -ENOMEM;
> -			goto drop_write;
> +			goto out_sa_drop_write;
>  		}
>  	}
>  
> @@ -3775,6 +3775,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
>  
>  out:

call this free_prealloc

>  	kfree(prealloc);
> +out_sa_drop_write:

and this one free_args

>  	kfree(sa);
>  drop_write:
>  	mnt_drop_write_file(file);
> -- 
> 2.51.0
> 

