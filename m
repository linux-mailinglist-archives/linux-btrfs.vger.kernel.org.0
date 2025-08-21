Return-Path: <linux-btrfs+bounces-16198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E176B3005A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 18:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F00F3B7296
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D392E11DF;
	Thu, 21 Aug 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="fNd0Wlo8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XrvNP6sz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB02E0B5D
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794442; cv=none; b=BlyTzrUwTSDaSYNo7O3OZN9ypbB1F2x0obcwYeTiQet6zEIcPjXA9Da+I3ltJ9Bl3o7xrupgQYEqKDg3EXSzy9J20XpTPaxZaKwlpA8+DHwQ6RD9KdWGVeCWWbCpae7SPSNDgA7/B+5Pq7H5UZHVeP2p3hxyKGqQL8D/dOXQar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794442; c=relaxed/simple;
	bh=4RsM9G7I2GZnvlXBoOYgPd3+n6Lb0InM/pFIDt5Thqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiDG37O1hQnml8lTe9HK2pfmnpu47BMyqVAA4RqY5U8p/0SiwAR0wOMhEaYvj5W++ANac+WvoOPs2tQAHsStIY8wFxsz83Y6KP/3NtKDQL0fz+2kry5SsQ8M+evsntGdfA33M/5OUWFqwXgnYyYJDx523oWGf6+h1fODokzHhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=fNd0Wlo8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XrvNP6sz; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D9FFE1D00181;
	Thu, 21 Aug 2025 12:40:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 12:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755794438; x=1755880838; bh=TGmH4Hh9Sm
	x5P0XfWs059GYIGaPYO5EuQhtcqvpYyvg=; b=fNd0Wlo8u0knpPCetp2XSHqsnZ
	d8lDTglY44fUN6r9CB/FEJcGDnvgzkKQ84EVBNhXLi6Jfqr0SSYYAyKxXc+ZfpAY
	drOuiZgLOEUm2a1qADMm2tTKNQyQMg8KsAA4perkvUsz9P2sKAl+JMTd5kOChwTh
	Go0b0ZbQ0QQavrC0XHr99pnNkJIG7bz2pUkx9YeEuOnbiNglpugkIA8lgpB4u0Tu
	ykuWBY0ROWBYcPEoILkqaN3lDx5a0I0PrIwtqgVpOoUXNswcdgijKjS/KCJYUzvN
	7hiTywnS7HONRzIi5uP1ryWqYTyOKSg1AgTg0D/i0slgkra5Jheciazu6isw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755794438; x=1755880838; bh=TGmH4Hh9Smx5P0XfWs059GYIGaPYO5EuQht
	cqvpYyvg=; b=XrvNP6szqA48gN+XXaedPCLBuPvvxvdk58ZVNt0r4tzW16qC1Ir
	1ktPYDcow6Sn6KxcR90WyZdwZMXkgi2Z4sf3gEvEKQ2+Xe/7z46SAv+zzq6EmK5d
	0d6yWfa5OYuizMo3joBmapS8v9dE81biTiI6Rk2fCUnojjflGzU676EjeGYSK8dW
	PqST2MdQF/Fb+I3s908nyWykqEujbuzeV80FHyqVdq2T7nMxm1nUaFXDvibMcSHr
	QxXEnJ170htfXZghIFHh/D2Du5Ed+MMDcE6k00vuuF9NuR4cILphMHb6em5fc5G2
	AbhDxZ4dGfDWctqPk2axNM/P6Wyi+rbFnTg==
X-ME-Sender: <xms:BkynaBu8DMnV_sS_5H3PBGj9_3SB3xBeeUPzqr4SKzPs5qbHOABJPg>
    <xme:BkynaKpPmRLCO-RuXCcXau5T2fcH3oeS-Qh3Wg3ncdYifssxcaF0VrzSmGHm48mSY
    HQ1mWjy8T8b5CJs9Wk>
X-ME-Received: <xmr:BkynaGnwa63yLS92NYd3mULhmdOY7GBGGoKdnXpAWGRI6NUOqNVcmFgesnhPM6uHjQ8W_nC7b9IUpxDTm6_ivcmdPsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BkynaGwwhmlb1dkyi2W0vOXeQCthYeSyKHfNlrgU2AfLsjkDhDYy-w>
    <xmx:BkynaGmRy2YkOpapJaRa8zMBsvu70fkiZQPtA2j5f0zXvxV4zW6boA>
    <xmx:BkynaHfysZ9HT898KNg4VeUzWb8hhhx0fKGQYfoqDKyxVmY3GGKE3A>
    <xmx:BkynaEoeIUjOVszSOJopbh7s7uWIsTJe7Y2FJIfAeJHsACjZ-RdYwg>
    <xmx:BkynaI8_YJHXL1fK0kp9tFhJTkY5dSKHSh3hNs1Aor45TmzrGA0PpWmn>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 12:40:38 -0400 (EDT)
Date: Thu, 21 Aug 2025 09:41:08 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: docs: update the compatibility about
 compression
Message-ID: <20250821164108.GA84947@zen.localdomain>
References: <bba7c113042d631cf6a787a261d550291e08c6c4.1755582011.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bba7c113042d631cf6a787a261d550291e08c6c4.1755582011.git.wqu@suse.com>

On Tue, Aug 19, 2025 at 03:11:02PM +0930, Qu Wenruo wrote:
> There is a github issue that expressed confusion about the
> "Compatibility" section of "ch-compression.rst".
> 
> The words in the man page is indeed confusing, and some points are no
> longer correct either.
> 
> Considering how complex the direct IO and compression thing is, I didn't
> come up with a correct answer until reading the code.
> 
> So update that section to provide a more straightforward result.
> 
> Issue: #1015

Thanks for taking the time to improve the docs.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/ch-compression.rst | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ch-compression.rst b/Documentation/ch-compression.rst
> index 9174f97c74b3..eb609c70b530 100644
> --- a/Documentation/ch-compression.rst
> +++ b/Documentation/ch-compression.rst
> @@ -167,10 +167,18 @@ pattern detection, byte frequency, Shannon entropy.
>  Compatibility
>  -------------
>  
> -Compression is done using the COW mechanism so it's incompatible with
> -*nodatacow*. Direct IO read works on compressed files but will fall back to
> -buffered writes and leads to no compression even if force compression is set.
> -Currently *nodatasum* and compression don't work together.
> +Compression requires both data checksum and COW, so either *nodatasum* or
> +*nodatasum* mount option/inode flag will result no compression.

result in no compression

> +
> +Direct IO reads on compressed data will always fallback to buffered reads.
> +
> +Direct IO write behavior depends on the inode flag.
> +For inodes with data checksum, direct IO writes always fallback to buffered
> +writes, thus can generate compressed data if the mount option/inode flags allows.

writes. Thus, they can generate

> +
> +For inodes without data checksum, direct IO writes will not populate page cache,
> +and since the inode has no data checksum, no compressed data will be generated
> +anyway.

I would rewrite this to be a bit simpler, and it feels redundant with
the very first statement about nodatasum => no compression.

I like how you broke it down into kind of a matrix, so maybe tune it up
a tiny bit more in that direction? As is, you covered the writes, then
the reads, then went back to the writes for dio and it was a little
confusing.

The important cases:
WRITE
when will writing produce compressed files?:
buffered + checksummed <==> compression possible
therefore nodatasum => no compression
dio + checksums => buffered (unrelated to compression)
so dio write on a checksummed file can still produce compressed extents.

READ
reading compressed files:
dio => fallback to buffered as it must read the whole extent.
rwf_uncached? :)

Thanks,
Boris

>  
>  The compression algorithms have been added over time so the version
>  compatibility should be also considered, together with other tools that may
> -- 
> 2.50.1
> 

