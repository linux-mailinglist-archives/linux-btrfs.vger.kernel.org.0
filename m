Return-Path: <linux-btrfs+bounces-8774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B446997EC0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 10:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB2F1C235F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 08:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEB01BC9EE;
	Thu, 10 Oct 2024 07:06:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791E1B5ED4
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543985; cv=none; b=kg8chRL49QodV+yUNdn2cXV4ZVIQIUAXq0XmTGc0hqttywbZBglhDbsh0HT43nkgV9WX7TKUEs9EjSEybl52dQuZWJBn61eTqZg8Njia0WR2M4PlVz+Pr0LQmRKqlkEwimQHj7EpcMkSDqcGyB7OYXFcJ6PbubDzlJvS0IXToAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543985; c=relaxed/simple;
	bh=RrL/dtDkWS575HKZxt/Vfdgfh7CWI74WoyVE7YtArvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6ldE/FedHTbGySI3/ktX0DJAn5ylCt6DNohvOlaq0XDIfCh/SU5HyMElw2V6i5MNVwD8jNrSf340vehw+AFY9WMW+dLsG+e7s1sMxi/Gonci5uIMmGtpiFkmKAkmJslEUvsTRTjUUSVwAPVGfOEpYhe0t2AyguWu2fsch2Mf20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 77FDD227A8E; Thu, 10 Oct 2024 09:06:20 +0200 (CEST)
Date: Thu, 10 Oct 2024 09:06:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	wqu@suse.com, hch@lst.de
Subject: Re: [PATCH] btrfs: fix error propagation of split bios
Message-ID: <20241010070620.GC6674@lst.de>
References: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com> <1865ebe2-ab9b-4db0-84bd-9f4f6309eb7a@gmx.com> <5c363f14-c3d3-4d5d-bc46-8b38d2bcd08e@gmx.com> <8f76a524-aa49-46b2-aa44-33f92fcd00a5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f76a524-aa49-46b2-aa44-33f92fcd00a5@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 10, 2024 at 09:41:04AM +1030, Qu Wenruo wrote:
> My bad, this is not possible.
>
> The original bio will have 1 as __bi_remaining as the initial value.
>
> So even if the cloned one is finished first, the __bi_remaining will
> only stay at 1, not reaching 0, so the original bio will not finish,
> thus impossible to free the original bio.
>
> I need to dig further deeper to find out why the NULL pointer
> dereference happens.

Yes, that was my assumption when writing this code.  So I'd love
to understand what is going on here, as it might indicate deeper
problems with the btrfs_bio lifetime.


