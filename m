Return-Path: <linux-btrfs+bounces-18461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2444AC23F22
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 09:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5981A207E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 08:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538C3329382;
	Fri, 31 Oct 2025 08:55:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772723176EF;
	Fri, 31 Oct 2025 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900926; cv=none; b=Q0qPqJAiuWBz2LwhrmI5ve1JPn7TOd7K4xyRnka944DIcoBltXInE45zCOxFoGnm+bq3R4t9a/8qjdqNTY9Ot+4Rm8ViJOqbnWKwsLkQcqBl3fyTq0pGLyfhYQrgiG8riht6HciwSAT5Kreu4xIA6M7hTEp6MFBsq1m43xyvNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900926; c=relaxed/simple;
	bh=ZUqkjtoIW3hp8lRoAOI5OGd1VuUEKVnLM6PGV7OsI+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbpoIiQkljo3PH4kPDU146MLP1idc0tbaxwprPCfkGcTcbZLfj7boDieAu3XW7whvdzU2cTKTpnKgfDBGbdsNfHxKoq5+xAO3bbo9okDRWaqpxwSuVQVjtWBrd2Y8GEL5/pALsuaufF48Qf1aC2xpOnG/grzGkyypMZ72gApB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 133DE227A88; Fri, 31 Oct 2025 09:55:22 +0100 (CET)
Date: Fri, 31 Oct 2025 09:55:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 13/13] xfs: use blkdev_report_zones_cached()
Message-ID: <20251031085521.GE9041@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-14-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031061307.185513-14-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(and with a more exhaustive change to remove the callbacks this should
get even better soon).


