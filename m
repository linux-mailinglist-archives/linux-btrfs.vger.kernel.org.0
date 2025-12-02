Return-Path: <linux-btrfs+bounces-19455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 637F4C9B985
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 14:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D77DA3480D0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BE314D36;
	Tue,  2 Dec 2025 13:29:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7263148D5
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682191; cv=none; b=U0o1SHCqo4tIAGwqaZF3e/VsG8Hi6jfy8Cts7EBrOSm/N+r/QjsvGtTDsl43zBrf+vGuBzbwJs99QKjNlWMl4MN1IasWoRSRFQ//ByiQJkpt9wTEt09p9MH45ateCGv8M3HQUm9uu4qO2sdBJV1uobAEnS01T++egZcBX3wEHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682191; c=relaxed/simple;
	bh=zHfrWFfjH+IbOAnVzmD6GJQMA9sfv+5gsr0bt0RUEwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwL0m3pk+MQeOicVOU0wID05EpKbhiPxxnEyqfPTG6e22Kxi06G854qUB3rrqIFTuI51TJ9f40fBKdgSzVyqRRvR4x5gY3LLqtivegkU6Z4lFDIHWWuxXRPB9lc9JW+qRYJmfMl+q013I9ADc2mZQHk3WGYCgV5zs9pWhCPTeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1CE4E6732A; Tue,  2 Dec 2025 14:29:44 +0100 (CET)
Date: Tue, 2 Dec 2025 14:29:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] btrfs: zoned: don't zone append to conventional zone
Message-ID: <20251202132943.GA25391@lst.de>
References: <20251202101631.155235-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202101631.155235-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 02, 2025 at 11:16:31AM +0100, Johannes Thumshirn wrote:
> In case of a zoned RAID, it can happen that a data write is targeting a
> sequential write required zone and a conventional zone. In this case the
> bio will be marked as REQ_OP_ZONE_APPEND but for the conventional zone,
> this needs to be REQ_OP_WRITE.
> 
> This is a partial revert of commit d5e4377d5051 ("btrfs: split zone append
> bios in btrfs_submit_bio") which was introduced before zoned RAID.

Hmm, how does the BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE flag used by
btrfs_use_zone_append actually work for the raid code?

Either way, this is a bit ugly as we now special case zone append in
multiple places.  Can we just pass the use_append flag down to
btrfs_submit_dev_bio and only set REQ_OP_ZONE_APPEND there to keep it
all tidy?


