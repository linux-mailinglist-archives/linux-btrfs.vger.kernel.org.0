Return-Path: <linux-btrfs+bounces-9774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6084F9D3AA8
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 13:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76922B2D358
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3991A4F09;
	Wed, 20 Nov 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vHwCl2oX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA7199FC9;
	Wed, 20 Nov 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732105060; cv=none; b=RUl8dCGdg30tfoRoZ2noalyyBlerKbDxmjV7IBbQipCY78NHXoILUyvFGw9ZuQfVPHebfUQixi0InAeJORRl/wJV316WTzucghNDchAhA7Dr8W6szUvUxuXbO/HF+nwWS0IWYCsT2RD4qTUQmxsPk6N/GbWU9Cp14Q26sE+768I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732105060; c=relaxed/simple;
	bh=x2Ukdpp30t7PTPSTLiOTDOfcknLAQqmkcfZ7ab5hDEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwZnvZ2R2CXcQZ2etVB3gEnF1E8eHi6KghSjN7qj/F6/pmdy0/4qUO4b5xDc8+rpXia7eYP6jeQVzSL8tYQrM3HTuVH6O52OS6EAF2GvXeI59aCF9BdJ7HjTpGM4PGtJO/X5IpYMOTmURAhihmc6dRGUNQGlyfjVnhjraN9H9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vHwCl2oX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854FAC4CECD;
	Wed, 20 Nov 2024 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732105059;
	bh=x2Ukdpp30t7PTPSTLiOTDOfcknLAQqmkcfZ7ab5hDEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHwCl2oXYv08aJWwlxvRxnb2bkvIlQ+ydhh+LpBjLoJuZ9WDZm/LK1EvUZvxnU6lF
	 njupnQndR2irMVIRJ9p8UYBCIz14vMFVgVJB9LW/7Jd4gqj3ByGX3KDup2yJOyFais
	 kun9jQp1E8kqWbDSSrpUyGehbohEKqXHLe0GGwm4=
Date: Wed, 20 Nov 2024 13:17:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Atemu <git@atemu.net>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] btrfs: Don't block system suspend during fstrim
Message-ID: <2024112033-booted-kinswoman-6cb5@gregkh>
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
 <20240917203346.9670-3-luca.stefani.ge1@gmail.com>
 <SICOALIt6xFGz_7VCBwGpUxENKZz_3Em604Vvgvh8Pi79wpvimQFBQNkDxa1kE5lwfkOU0ZSYRaiIugTDLAfM1j3HMUgM25s1rgpmmRQ9TI=@atemu.net>
 <2024111923-capsize-resonant-eed6@gregkh>
 <wnPVOgJfpl_-T0Kmx_rLagKGYDUVPe2v9-dL75Pn8evLxtS0h1PY3OGUSihwcMAJ4Q5A3heeKnYQZcPaX81_ieEwyKirOcV2ZdutRF8JgrI=@atemu.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wnPVOgJfpl_-T0Kmx_rLagKGYDUVPe2v9-dL75Pn8evLxtS0h1PY3OGUSihwcMAJ4Q5A3heeKnYQZcPaX81_ieEwyKirOcV2ZdutRF8JgrI=@atemu.net>

On Wed, Nov 20, 2024 at 07:41:32AM +0000, Atemu wrote:
> Hi, 
> 
> 
> > What is the git commit id in LInus's tree you are referring to here?
> 
> It's 69313850dce33ce8c24b38576a279421f4c60996. Apparently marked for backport to 5.15+.

Please see the FAILED emails about why this was not applied, here is
one:
	https://lore.kernel.org/r/2024101412-diaphragm-sly-ea40@gregkh

Have you tested and tried this commit out in these older kernels?  If
so, can you please send a working version so that we can apply them?

thanks,

greg k-h

