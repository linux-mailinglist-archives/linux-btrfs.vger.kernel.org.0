Return-Path: <linux-btrfs+bounces-7138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E894F21A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 17:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F621C2133B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3153F186295;
	Mon, 12 Aug 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S5lt6eeX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B03189BB8;
	Mon, 12 Aug 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477778; cv=none; b=HNCwvhTpAa+Nf/EGORpSGe4nOL/+Q4avwZlTJK3HKxAzgloX2+oJthzKeR3IgQ9Y+dtEncZgCyrc/mV0swB6UQPkSJEPCvcblaMCESenZgkkNo+FcQNJUFFBAZBm8qK1NcMh27Us7TUZf45IUSMtPSoQ7sBYUOzGQ7zBjLUv05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477778; c=relaxed/simple;
	bh=nzR06YyvGvtd80JHGGq3C1hZ8fbhBI409yPPHQfBWwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWnx6cMwv6o5htxkZ2q8GwhVpti992k/dDVA938SAyDtmqQ8gyGV7LzCdZAcPf14Ur3tbUyv/inmm39GZICOltQhMarTHM3O+poDVvLy4ASaiYvnrgOwKCuDpyuNhVKnik8kFMxLDtDAHRo5r/wN70OmG6IyfFw+taMqMxAsljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S5lt6eeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E33FC4AF0D;
	Mon, 12 Aug 2024 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723477777;
	bh=nzR06YyvGvtd80JHGGq3C1hZ8fbhBI409yPPHQfBWwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5lt6eeXniZJxVrYt7RmQek0MlW9PQYBS2zQmBxS2yUTrPVgaYi+GNiLu1WB4i66w
	 a10UpQv1uZ1zgN01Lfw66gbfn33G/sj1dv4o9deseE1jWaaeM2MJ7TCdHRKOIn6B4G
	 nzI7zY7H3rUbqtplRjDZjb0wr37MhJzWc3A6Izjo=
Date: Mon, 12 Aug 2024 17:49:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: fdmanana@kernel.org
Cc: stable@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH for 5.15 stable] btrfs: fix double inode unlock for
 direct IO sync writes
Message-ID: <2024081227-sister-matcher-73a2@gregkh>
References: <cover.1723046461.git.fdmanana@suse.com>
 <363aee7827c9d6ff034b7e3ea2a5bf4959ff4905.1723046461.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363aee7827c9d6ff034b7e3ea2a5bf4959ff4905.1723046461.git.fdmanana@suse.com>

On Mon, Aug 12, 2024 at 04:27:33PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit e0391e92f9ab4fb3dbdeb139c967dcfa7ac4b115 upstream.
> 
> If we do a direct IO sync write, at btrfs_sync_file(), and we need to skip
> inode logging or we get an error starting a transaction or an error when
> flushing delalloc, we end up unlocking the inode when we shouldn't under
> the 'out_release_extents' label, and then unlock it again at
> btrfs_direct_write().
> 
> Fix that by checking if we have to skip inode unlocking under that label.
> 
> Reported-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/000000000000dfd631061eaeb4bc@google.com/
> Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

All now queued up, thanks.

greg k-h

