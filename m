Return-Path: <linux-btrfs+bounces-2400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D08559EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F681C223E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 05:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2DD8F61;
	Thu, 15 Feb 2024 05:04:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA54A15;
	Thu, 15 Feb 2024 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707973469; cv=none; b=GPD8dTd6W+A8lDLR2FBpsEwjx+qvKEf66Mxr7LRKZB32Yoag24tjttEAe/cku0RDpbpEeJ+mbDixyg7b0Oew0cuVQgWE1oQHJrlDic2RxWVSIfH9ejQ4o4rEhgXAzo03+FsyD0vYTHOvIXWhsooy8jZabilpIHoD4/fFjwH+3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707973469; c=relaxed/simple;
	bh=cGf7TpIfbkx9umpzOKhjzms2aWQfdmHY8BiotpuNv/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNPQGSn4SZkAHawvbGIsDYntoE4LFzeW5BJH/uiC7J6hdKfFRXgQIN/huSwrtuc2GTnlYioa7Hl1UCoyxwiSJ3Mx8mYTXdiwex6yXozlTmr4LNF00RqppzKMkfnNKs5RSN/mTDlyK0zZtPlA+yym9l2NayoXnxVTbyrCHm0wPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9752B67373; Thu, 15 Feb 2024 06:04:20 +0100 (CET)
Date: Thu, 15 Feb 2024 06:04:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: use the super_block as bdev holder
Message-ID: <20240215050420.GA4826@lst.de>
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 14, 2024 at 08:42:11AM -0800, Johannes Thumshirn wrote:
> This is a series I've picked up from Christoph, it changes the
> block_device's bdev holder from fs_type to the super block.

Thanks Johannes,

from a quick look the rebase looks good to me.

