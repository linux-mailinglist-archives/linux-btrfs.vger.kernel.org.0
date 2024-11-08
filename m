Return-Path: <linux-btrfs+bounces-9394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDBF9C1FA2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 15:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318E21F21C43
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3E1F4299;
	Fri,  8 Nov 2024 14:49:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3CD1803A;
	Fri,  8 Nov 2024 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077345; cv=none; b=A6FANAEcM8Ub4ypyMjx77cveN7jpuBrhFqtJTKvDZCzGV06VARE9YZWrwInM7b04DH4a451/peKyz7sOTa7/Lk7BeGe4VHbocv+meRfgpofilIwEPRI6iRY5cDQmhTHlylKwCQRgUW0b5rLWQf8sFGbf70iscILOzCqvQUgwgM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077345; c=relaxed/simple;
	bh=StSMC8kSslABLllmeuy32FXp24hkFJW0EBpcXZqf8xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3BSU3aich+sMXB1PBSUwAbyS68Y1aNRmtWPh4cwDNkL7ONJW+AEK0NS20zRRWRSfU8VRafR4zZLmXlXZsA7dJrewjgorf7QHS3rQWH1ZNYq6qiqbWD5rcLdM/RF0aOm1LB6oVcqFrMizETUHhH2zfWS3GZShUjup/wLyp2ej/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DFD468AA6; Fri,  8 Nov 2024 15:48:58 +0100 (CET)
Date: Fri, 8 Nov 2024 15:48:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: fix a few zoned append issues v2 (now with Ccs)
Message-ID: <20241108144857.GA8543@lst.de>
References: <20241104062647.91160-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104062647.91160-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 04, 2024 at 07:26:28AM +0100, Christoph Hellwig wrote:
> Hi Jens, hi Damien, hi btrfs maintainers,

How should we proceed with this?  Should Jens just pick up the block
bits and the btrfs maintainers pick up the btrfs once they are
ready and the block bits made it upstream?


