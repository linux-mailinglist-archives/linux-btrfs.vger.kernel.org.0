Return-Path: <linux-btrfs+bounces-12220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2875A5D586
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 06:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB00177B10
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 05:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6351DE885;
	Wed, 12 Mar 2025 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKyrSY3f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C211D7E37;
	Wed, 12 Mar 2025 05:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741757259; cv=none; b=HIT2SuKnFk78CxCc52/fZTijziF3ibsVb851PCjhYUnYHCDJ3c7sHZJ2NYZutUT0FMbPovxr9GVrgoiVC4mPAV0tQyposC9nJCspXDV2mK+Yox0kG1LA0cOt8qT2j3VLxDORi/0GtPgyST9pJb+8Y2mJSbWE0E3VNcYd52HZcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741757259; c=relaxed/simple;
	bh=vNnPgSsaAUOEeP41h585OvaC6s/gAY6EhOAQzai+t+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6BOzwXVoRMvao0mnNOzuh+y40HFXahZ8bCo5Cekr9tO4omxctm2jxRX6OHdBMhebjA1xzvb7blHIomG5quC5OURAMXesmEuRbF1FgLXELepQfjSJT+si3ma07aBIcDV7sWHeJGD/I7gU1oD17vYiZDF9WcAzEhcDwKUu3zINVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iKyrSY3f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nfk1qA0i59U20H3kudBMCNE7ig1Uka6Lm4cpvTalGt0=; b=iKyrSY3fdGWab0wNqvHrxGGiiN
	m2vB+ihpHFpfsXSscTdXh0ZHPbsBSnt7lY9Thh1xzqFIoy69qD1Nk5SM24VtVkqGqKp3qV/XrYwfw
	3sgnvzhOuh/Gz/x/y8sARtsOMpCysNWGRJhoWuEARDaCG+gfAbp0H8v9ZTCkzrzOt6G82M6YPaW62
	EdSDktdGlgGOhkqVMV7Z1PT0mt2srByQ8x1P7N6S7ZEVRBRJXn5OUqL5UXVGsx6ZWB+O5U7KplQ5p
	L72BtzqxctiPEuNsE0QK69flHSEZZyNO9nUCNGAfGV83SCjvcH3eMoOXqwxrQSCGnWwTeOMuHswjk
	Dxoi+ZYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEcz-00000007WcD-2UIz;
	Wed, 12 Mar 2025 05:27:37 +0000
Date: Tue, 11 Mar 2025 22:27:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, dlemoal@kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: introduce zone capacity helper
Message-ID: <Z9EbSZh-OtLGttoB@infradead.org>
References: <cover.1741596325.git.naohiro.aota@wdc.com>
 <335b0d7cd8c0e7492332273a330807a8130e213e.1741596325.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335b0d7cd8c0e7492332273a330807a8130e213e.1741596325.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 10:31:03AM +0900, Naohiro Aota wrote:
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static inline unsigned int disk_zone_capacity(struct gendisk *disk, sector_t pos)

Overly long line.

> +{
> +	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
> +
> +	if (pos + zone_sectors >= get_capacity(disk))
> +		return disk->last_zone_capacity;
> +	return disk->zone_capacity;

But I also don't understand how pos plays in here.  Maybe add a
kerneldoc comment describing what the function is supposed to do?


