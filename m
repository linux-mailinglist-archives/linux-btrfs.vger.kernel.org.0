Return-Path: <linux-btrfs+bounces-18062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C06BF1E77
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0098B18A7EC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E4191F92;
	Mon, 20 Oct 2025 14:45:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58F22301;
	Mon, 20 Oct 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971530; cv=none; b=hX0CG0krxIqk4sI8VxB5IVtfxFkXhPmrLTXyPI8eB9Ial4rSYpc9XDhheMKIyKJ8BhaYS1b2d6qOkR50XEDDNPvtaJkS/jX6L29qHel1bJuXCyIN6pVpfjy5yn8ekkrh1u0YVJyD84AXKfTrqH7psMssWsJ+x+iDhEUWFk6hwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971530; c=relaxed/simple;
	bh=UGTgbidDThUjJWLJ4/sZtUhHLnWyT0vgbgJDQnK2PqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MinUBHBoBzZZvl8fXxYB9Ri3PZqSbISWrTn2Nbva+geWqFNBrbYNCBnYEc4jyA3lF6ePV4T4gyvmLv1etYh2OTDIe19dQDB02DqfNEH63y1NT43vbXOPINOqhJy3MnOp8/CY6RWTaOeHQZ+HJH3FGG2qpS1wmeKMFcp/XYujzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A866E227A87; Mon, 20 Oct 2025 16:45:22 +0200 (CEST)
Date: Mon, 20 Oct 2025 16:45:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: dsterba@suse.com, cem@kernel.org, linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, Chris Mason <clm@fb.com>
Subject: Re: [PATCH 1/2] xfs: handle bio split errors during gc
Message-ID: <20251020144522.GB30487@lst.de>
References: <20251020144356.693288-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020144356.693288-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 20, 2025 at 07:43:55AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> bio_split_rw_at may return a negative error value if the bio can not be
> split into anything that adheres to the block device's queue limits.
> Check for that condition and fail the bio accordingly.

Ugg, how?  If that actually happens we're toast, so we should find a
way to ensure it does not happen.


