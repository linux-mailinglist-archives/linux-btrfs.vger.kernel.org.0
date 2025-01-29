Return-Path: <linux-btrfs+bounces-11157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D60A2238D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 19:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28784188323E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADB1E0DD0;
	Wed, 29 Jan 2025 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBYvsP4a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52348F4A;
	Wed, 29 Jan 2025 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173819; cv=none; b=iJVDO8APsuKLRz9+zaz//9kEWHPjQdR4yJvg01/T/jA0MMJroemlp+ZpvwjnG57D7OAnUPPG35gZ/26zPzk6eflBNjE8ZPVEw3Th+2Nw4nOj9CvKsNaNMy3bcnkoQe+Xc9Lvz0GNZWU9BPdjQnx+YhFLYKBMBgTWF0gQSQjZu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173819; c=relaxed/simple;
	bh=fGp2xaP4mmstBrpG7VZNDHnMwJnBSocGcTWYaJO1KJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE+fqQOUmQYLDKQZgdExf9Aj4BZo1lpBn4xctMmKpTRwAlFFuS9K2863pi4IimDPkI0iKB6NNahg8K7TwV8wSyusPkPB7MCSNB1/w/Q5khKbC+85HKXJ4UX9HQUx9CzlgJkUN4lcZlau/cjUbpgLm5hdUl2kUpCC6In9XPrxf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBYvsP4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0551C4CED1;
	Wed, 29 Jan 2025 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738173819;
	bh=fGp2xaP4mmstBrpG7VZNDHnMwJnBSocGcTWYaJO1KJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBYvsP4apvQaGb4Xg2vfMDOZ/XPXBr88G4C3rEeQPOCRI2VJyLHGyKwb2+5bxXMs2
	 Pewr2CSX167/UwDcMOdO+KWEJr5vE9K5EMZqAA4MbQdpjlM1uaYki+4FfGOl9eoVrF
	 4OCmJmeOXJS6SEzOaWaWZbVhZfwPjRfk6szaisl22/zS8UE/CrFr+SRvuZNoVvp+40
	 ewAm3ooOnzzk4D085+rD7eonV1dMxrAo2ZrbTbKBNdXVWTxrLJcQ9wjYMUiS0f0XbP
	 nlvDAJBOToR8bs6R6FY5sBi5OHnp/GJCUKu2YIRV/vWfITPsaDpp9DYXDRtTfaF5pB
	 3kTKJ1Hjq1HAg==
Date: Wed, 29 Jan 2025 11:03:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com,
	dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <Z5pteC56jYBRDupP@kbusch-mbp>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
 <Z5pJGHAR7AWCC0T4@kbusch-mbp>
 <20250129154025.GA7047@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129154025.GA7047@lst.de>

On Wed, Jan 29, 2025 at 04:40:25PM +0100, Christoph Hellwig wrote:
> > 
> > Another potential benefit: if the device does the checksum, then I think
> > btrfs could avoid the stable page writeback overhead and let the
> > contents be changable all the way until it goes out on the wire.
> 
> If the device generates the checksum (aka DIF insert) that problem goes
> away.  But we also lose integrity protection over the wire, which would
> be unfortunate.

If the "wire" is only PCIe, I don't see why it matters. What kind of
wire corruption gets undetected by the protocol's encoding and LCRC that
would get caught by the host's CRC payload?

