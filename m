Return-Path: <linux-btrfs+bounces-3341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB6A87DFFA
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Mar 2024 21:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F2D1C20E5D
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Mar 2024 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91102208A4;
	Sun, 17 Mar 2024 20:35:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B5A2A;
	Sun, 17 Mar 2024 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710707716; cv=none; b=WmUHbpNX5ttQY1yw5YazRYic0U5XB3NQpPty3wxuMbhV6n20bDiUWeJAbte5YZTdqbGc2O56rcOX9q6LcdjrmMOVji6Pi0UUmhwizoNF7EiB3w0K72UHH9y+vXiawx1cDFPQwQIb5c9lZ4wzQio6s9uHfIYyHGBXC9i2+GqGpC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710707716; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qscxk6S7wC+kSssNL37fmzXhzJG5IYqdqNPeR66x+lcmgIzBmOBR5ZYNJsBb2DZ5zBhM/kZyXLbfNiaK23E0TU5GD2lgUNG4VsnAwi57H1D3AOSbFG9IN24u8KDFVbRocwp72w25AVcQ9IjMTPYfswzVXSO/GeDHHfPaDkseOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2AE8468BEB; Sun, 17 Mar 2024 21:35:09 +0100 (CET)
Date: Sun, 17 Mar 2024 21:35:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tavian Barnes <tavianator@tavianator.com>
Cc: linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix race in read_extent_buffer_pages()
Message-ID: <20240317203508.GA5975@lst.de>
References: <1ca6e688950ee82b1526bb3098852af99b75e6ba.1710551459.git.tavianator@tavianator.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca6e688950ee82b1526bb3098852af99b75e6ba.1710551459.git.tavianator@tavianator.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


