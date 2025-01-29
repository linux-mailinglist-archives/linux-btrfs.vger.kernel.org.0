Return-Path: <linux-btrfs+bounces-11150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4AEA22040
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC23162301
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50F21DDC34;
	Wed, 29 Jan 2025 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YElx4xGB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEBB15B102;
	Wed, 29 Jan 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164506; cv=none; b=GyZ2yNSiVkT76ctFhUVf6raUVvl0OBA1sWYdaYj75mtwo7ZvM5XE4ct4BEPudkcsTtw6WF4OKgUSQU0G430S3rpdRNTTLwlRaqrAyiTuLQIl0+pt0kTUB1JcJYIktV2/F6xqtw7Cr3kvEgxp5mM3atai1ozuwmnw19UE5+kwVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164506; c=relaxed/simple;
	bh=SeZspGMtd29bXBRJEo6j1b1maNPj6nnM3pShwptmW2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR7H+4Ps8ZIyVUkZdnLMLqrbABznL9MK8XqNm/Af6SJfgAvnFIUeX4OcXm14QObi6xALjbV36Z5/J6LHdUa7Uicz4C4h7GMIszrRQ4UPAP2BZEUJ5A3n6GO73wbT9M8acyJ5iMCh3zjIEbCA9MeJV+Z8YvsnIt11CNE4dgw9yJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YElx4xGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBC6C4CED3;
	Wed, 29 Jan 2025 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738164506;
	bh=SeZspGMtd29bXBRJEo6j1b1maNPj6nnM3pShwptmW2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YElx4xGBKbiZmg/exChiKs++JAtGnxXODnvPFQa5wutbWImPHv1PuvB9WfYDr+97b
	 sWYFohrvpcIW4NN7mJhDA1pW9x2VAfcvXgTDqp0aE/R3S1FsYciLUSbPW9J5lMx0YK
	 uqGjynyy1FQgR+0ho/v3YZLB9MuAwVtMpemx51Ss2OKLcG8H4X4dYXRUqf+8BlulbG
	 RO2k+5l/P+L1tJs4ha5c0BI+Apar/T7EYK9xO9v6ND/BpTVoqv0QuFkKXpNAuuffgo
	 i3yiTcsI3VkziJ4ycdUI2pg5ckG/4PrJaU/Z+LVOXVj2mqu3yAKL7JrfRPTLlWTeq+
	 UlWr5/5QR2Oyw==
Date: Wed, 29 Jan 2025 08:28:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	hch@lst.de, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <Z5pJGHAR7AWCC0T4@kbusch-mbp>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>

On Wed, Jan 29, 2025 at 07:32:04PM +0530, Kanchan Joshi wrote:
> There is value in avoiding Copy-on-write (COW) checksum tree on
> a device that can anyway store checksums inline (as part of PI).
> This would eliminate extra checksum writes/reads, making I/O
> more CPU-efficient.

Another potential benefit: if the device does the checksum, then I think
btrfs could avoid the stable page writeback overhead and let the
contents be changable all the way until it goes out on the wire.

Though I feel the very specific device format constraints that can
support an offload like this are a unfortunate.

