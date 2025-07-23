Return-Path: <linux-btrfs+bounces-15638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4E4B0E83C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 03:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C1D16AFE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 01:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585041A83F9;
	Wed, 23 Jul 2025 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbB0SVQZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857611A38F9
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235007; cv=none; b=EuH37iKaDezJQpl2pmyxkQ84/N5UbK7NCkCzi+16P2C9O7DaE82SgfvGyWS/khNzCZPTcTTjGyShgFtWwZ47ky9+QnVeF1YCS3Fly0UWm2ylnnahAvnK5DBBZMY8+anCcWb2B7ZkiuE/L0RxHuYtYyAu2yka/zQ0qTI3v7MD8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235007; c=relaxed/simple;
	bh=1gqOfprt6SAvKeZDufQRa1yUAOjGB5DiD9Qllr7B7NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vv1zMaLwC8RahpmOGok7u+0S+fnbm39n3w0cPSc0wxfuZ1KWpJhMSVBfz2nD5Tz/zRkH5Az68U3gGORCk4RRRamob9t4TvlHoh9sAfRiQ/+I1TXQ8qzSLWPneLCIUc6bP/jowtasFu/V6/LYnEskRRThkz0uRogZ07PsRCT6i2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbB0SVQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183BEC4CEF1;
	Wed, 23 Jul 2025 01:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753235006;
	bh=1gqOfprt6SAvKeZDufQRa1yUAOjGB5DiD9Qllr7B7NM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LbB0SVQZBNvPbtpag2n33IiW4CaMgUlMOqb2ttQeejWRy1MHyGYllc4soJ0wH8dUv
	 ShRCdZM5zgCYtbc0p9uAIVBT8fzXi2Tbn2bydyJcNOomVtikN2GXnLlMFKe1mNiyrG
	 2ihKeE5HkYUFLrBSwZfLnPUzY+SZUw3a65d3GbMrY8rUEtJDsExgS71CWhTM71cDyZ
	 rXF94dc4mfUZ/0ZAHA+1PS/+zE4sjKXRvEu6khdz3wmWQEN5Y+vK/VxIMz+hwwtvPo
	 6aZctESpx30qbeaf39vbdJgwgmN0sDugTGxhEUpK4K5qLNT+xJq2bmuvOIafop2bBo
	 dvy9MIY2MgMpw==
Message-ID: <9f7fec3b-3f39-4cb5-9a88-f5fac5c23a7e@kernel.org>
Date: Wed, 23 Jul 2025 10:40:59 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] btrfs: zoned: directly call do_zone_finish() from
 btrfs_zone_finish_endio_workfn()
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250722113912.16484-1-jth@kernel.org>
 <20250722113912.16484-2-jth@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250722113912.16484-2-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 8:39 PM, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> When btrfs_zone_finish_endio_workfn() is calling btrfs_zone_finish_endio()
> it already has a pointer to the block group. Furthermore
> btrfs_zone_finish_endio() does additional checks if the block group can be
> finished or not.
> 
> But in the context of btrfs_zone_finish_endio_workfn() only the actual
> call to do_zone_finish() is of interest, as the skipping condition when
> there is still room to allocate from the block group cannot be checked.
> 
> Directly call do_zone_finish() on the block group.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

