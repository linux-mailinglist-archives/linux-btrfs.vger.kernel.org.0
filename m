Return-Path: <linux-btrfs+bounces-18451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86DFC23E25
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 09:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507CE4046CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8312322C70;
	Fri, 31 Oct 2025 08:45:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A243531352A;
	Fri, 31 Oct 2025 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900317; cv=none; b=YF22K+5GuKZz7FV5Tfx9IChQAjxu7WueH0vDxtxrWZE+MD0ekaSvWbq7N0aSL/uZ7q/EvRSRM6RtNL3OuN5FQYvvpHpSDjZnOjWqmCNC6d+9PEFYt3qp5I/xo+c+nVQSZjj9ufOoLpl+K76SIwUktx//5GC7r3KQTMhN8v2Sv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900317; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjN0s1c8fIQKyqK5vrSVydAMi0c7hv3h7inqKuPOSOp+3f37876BRVTYSgL5ykm5angoBSFLRWbekzHfeBIh3Cf2HTgiZPsWcI1VDdpiG4wNapIArw+GLdViLx+qMw8T/98lpjs2fLIQoWS9UR58Ph1VXarwe2AaV63HFPQ/Vbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4F97227A88; Fri, 31 Oct 2025 09:45:10 +0100 (CET)
Date: Fri, 31 Oct 2025 09:45:10 +0100
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
Subject: Re: [PATCH 02/13] block: cleanup blkdev_report_zones()
Message-ID: <20251031084510.GB8798@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031061307.185513-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


