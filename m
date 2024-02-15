Return-Path: <linux-btrfs+bounces-2440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A79856E84
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 21:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC37BB27FFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B913AA44;
	Thu, 15 Feb 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C6rSBsOj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602613A89C
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028627; cv=none; b=jmPSgKt2+2GdYgEetJc5ndPGrb1ZyzNkPigULQ073zOIUoIfjR/ALgaw0PuxZhBcjd8eFbt3wSP4A0k8/JJsObeoMO4VEt/6FPJak1udEav8mmK3IeVAb7DC/Jv9pE8aDZKHiemE7NXkQSD7ghhxz+5zKg4ZPUuhiBqyLa/Vp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028627; c=relaxed/simple;
	bh=fOhKNAXC3hzpZdDmfHiWRa5LBh3yh3IL/S9sOEwpwbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCbAOtTnNeSjp8yFbB/QJymF0ZdDR3g0jT5LXCLtjBk+hPF45O0XLTzeqIzkkRqpHqkFPfsHmgV5j0OufDxx9wc9O76647rPG4nfo64LZ9HOUG1KpaMyTGUS4H5atpcgye6+bhs3fxFMIb2e/WL4gecVLSmeyS3VHkA0hGUj9Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C6rSBsOj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uA6wS4HmWNwjlOoNdUFzgYEDZ+JxDznrF23V8MXy3Po=; b=C6rSBsOjaRxOnK/3gMH7s+L7Ix
	QacCOkdAT0wHb6bVPqIBf5/TeWzxDgpYjoq00k5oJlCZhjxG9GIKIJObD0PALZB4XBR8vGnyXYOxy
	7b3wCUj6zLzZke1R2UXZ/OBwi/fdTemNW1ak2ZPSXHox5TCrBKJoPisr3UEpU783cgcBp1bZDv3lu
	Z1EnSG1AzD8VY6Zr6xGyGO4a3MhrxO3j76cYslubPZs636aAOtEtiJbewUNMSaX3gcB9O+yJ0AuUu
	QMyevHTeb76CezD0FPPdcM942vy+OI5C3ADywWgkg5MXApo0OlJuJzLTRzhJfBAZc/gew4UbOzpfo
	8SQfys5w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raiGm-00000002lnT-0jvx;
	Thu, 15 Feb 2024 20:23:44 +0000
Date: Thu, 15 Feb 2024 20:23:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH RFC 2/2] btrfs: defrag: prepare defrag for larger data
 folio size
Message-ID: <Zc5y0IRJdqjmstvp@casper.infradead.org>
References: <cover.1706068026.git.wqu@suse.com>
 <5708df27430cdeaf472266b5c13dc8c4315f539c.1706068026.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5708df27430cdeaf472266b5c13dc8c4315f539c.1706068026.git.wqu@suse.com>

On Wed, Jan 24, 2024 at 02:29:08PM +1030, Qu Wenruo wrote:
> Although we have migrated defrag to use the folio interface, we can
> still further enhance it for the future larger data folio size.

This patch is wrong.  Please drop it.

>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	struct extent_changeset *data_reserved = NULL;
>  	const u64 start = target->start;
>  	const u64 len = target->len;
> -	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
> -	unsigned long start_index = start >> PAGE_SHIFT;
> +	unsigned long last_index = (start + len - 1) >> fs_info->folio_shift;
> +	unsigned long start_index = start >> fs_info->folio_shift;

indices are always in multiples of PAGE_SIZE.

>  	unsigned long first_index = folios[0]->index;

... so if you've shifted a file position by some "folio_shift" and then
subtracted it from folio->index, you have garbage.


