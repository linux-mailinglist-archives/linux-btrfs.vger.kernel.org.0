Return-Path: <linux-btrfs+bounces-19450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F04C9A920
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 08:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 347D64E2EF8
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7E3043A5;
	Tue,  2 Dec 2025 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BcCpUYS0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F33019CE;
	Tue,  2 Dec 2025 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662017; cv=none; b=h3UpF9TljYssnGR9mjS7W8VQZoOLn4hOm6qdebEKIw+ySg5F66TvKHTJAgMipWuSJjI9/rYHWHVoQpKWeF8uXo1LuCFe85Cx12jJKnGlS1Bx5nstslAD4PG6/ZYqXw+LYPuyjYKQfIyTWTVgatR/TA+fy5N8cZQI0YQT88uBwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662017; c=relaxed/simple;
	bh=oYntRtURULyVvk3y8bi02nfEyNC+oNoedIPIEKODgkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQzkqq7k68NDF80cf8VpqAC0PrzY286nXT4u4rirqATraOF5liroSEbHOK/9TRCEJLMBmZPauBF/Q6kywVfnaBKNoououcYOhJTClVl9nRDNcu/CwiMm6dRrwdpScHmcVC4LpvAUP9GWrlsA5ZreE2jAAncgpu6t36M/FPcyJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BcCpUYS0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=31o0tKdkWEY8F8m2VulLYy8mOnOxJBFYuBxzUSrK6uM=; b=BcCpUYS0XL4cIFtV3CssFES+GU
	HEGcJuvGccg2Gv0Jqdyc5+e0ReAdOP6GaKy1tRMFk0gllOV4LI8X1JL+S2i836DnLOi3GBIy/PPII
	F+HCmBK5KFMH0EKueans4IWr7lnJcu8CuKLOXR0tHreXft2goqX25P3ejJe+BAUBwbjwv/2sLCIh6
	E0Qa/epIYOOGTZrgqJZ76EO5s4PB2a/nk4L0OZzGH3r5DPmE1XUpD1vIlWrJMIN0eapyCRwl+7DMn
	LHMdAeKCnQUducwfQfc/BbqIIcevs8FSeQ822O3vGs2RdpXDoKzN1RPhhZg2ZdvxrPlQFClIQYzbk
	H5rd00Iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQLCX-000000050EW-2n8z;
	Tue, 02 Dec 2025 07:53:33 +0000
Date: Mon, 1 Dec 2025 23:53:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: clm@fb.comi, dsterba@suse.com, terrelln@fb.com,
	herbert@gondor.apana.org.au, linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org, qat-linux@intel.com, cyan@meta.com,
	brian.will@intel.com, weigang.li@intel.com,
	senozhatsky@chromium.org
Subject: Re: [RFC PATCH 00/16] btrfs: offload compression to hardware
 accelerators
Message-ID: <aS6a_ae64D4MvBpW@infradead.org>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 28, 2025 at 07:04:48PM +0000, Giovanni Cabiddu wrote:
> +---------------------------+---------+---------+---------+---------+
> |                           | QAT-L9  | ZSTD-L3 | ZLIB-L3 | LZO-L1  |
> +---------------------------+---------+---------+---------+---------+
> | Disk Write TPUT (GiB/s)   | 6.5     | 5.2     | 2.2     | 6.5     |
> +---------------------------+---------+---------+---------+---------+
> | CPU utils %age @208 cores | 4.56%   | 15.67%  | 12.79%  | 19.85%  |
> +---------------------------+---------+---------+---------+---------+
> | Compression Ratio         | 34%     | 35%     | 37%     | 58%     |
> +---------------------------+---------+---------+---------+---------+

Is it just me, or do the numbers not look all that great at least
when comparing to ZSTD-L3 and LZO-L1?  What are the decompression
numbers?


