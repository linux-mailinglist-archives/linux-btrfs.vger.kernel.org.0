Return-Path: <linux-btrfs+bounces-3490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB7C8854F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 08:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8448C1F221DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688F56457;
	Thu, 21 Mar 2024 07:34:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE88C153
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711006490; cv=none; b=rSuBlbqaBjRO0Vz6EltmPpIgpei1/+0ZXtfhIq+lXXc6aNkAy+TRL/uhHYeZWFbwg54ktxoaKVQ0u0JZmJBZADK/PX2PsiUf3c5fD4c5QNIRc5UtZMCkKyXH1jhAFD8/DJ57qp2LUsA6WgEPxlKUzADjV3lCee9p7hJa0gGQFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711006490; c=relaxed/simple;
	bh=24MWQAUzROaPbqdelASvz+/frQdh9QaoZ8QORdgKv3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQ5QZfZYlv3j/2UdA9SwYl6yQqiFNgvdEQg/awyPmsvBUlJnTHUhRAQWgm4ltITiR6+0bEXiQPeKWljjPxuBUN0GyvmIMP5wmEEYwbenjTkC4H3Sm7DwSvVpa+QZtzS0FEL576+oUAb68RfpuzNrd96bhR4aiifhbuwh2ik9sG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
	by shin.romanrm.net (Postfix) with SMTP id 1C5573F720;
	Thu, 21 Mar 2024 07:34:34 +0000 (UTC)
Date: Thu, 21 Mar 2024 12:34:27 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: reflink: disable cross-subvolume
 clone/dedupe for simple quota
Message-ID: <20240321123427.73cab342@nvm>
In-Reply-To: <74730c411b0fd87484c8d894878c5cd8bac1d434.1710992258.git.wqu@suse.com>
References: <74730c411b0fd87484c8d894878c5cd8bac1d434.1710992258.git.wqu@suse.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 14:09:38 +1030
Qu Wenruo <wqu@suse.com> wrote:

> Unlike the full qgroup, simple quota no longer makes backref walk to
> properly make accurate accounting for each subvolume.
> 
> Instead it goes a much faster and much simpler way, anything modified by
> the subvolume would be accounted to that subvolume.
> 
> Although it brings some small accuracy problem, mostly related to shared
> extents between different subvolumes, the reduced overhead is more than
> good enough.
> 
> Considering there are only 2 ways to share extents between subvolumes:
> 
> - Snapshotting
> - Cross-subvolume clone/dedupe
> 
> And since snapshotting is the core functionality of btrfs, we will never
> disable that.
> 
> But on the other hand, cross-subvolume snapshotting is not so critical,

I think you meant cross-subvolume clone/dedupe in this case ^

> and disabling that for simple quota would improve the accuracy of it,
> I'd say it's worthy to do that.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/reflink.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> ---
> [REASON FOR RFC]
> I'm not sure how important the cross-subvolume clone functionality is in
> real-world.
> 
> But considering squota is mostly designed for container usage, in that
> case disabling cross-subvolume clone should be completely fine.

Use case that comes to mind, create multiple LXC guests as snapshots from the
template container. They run for a few months, and then you upgrade OS and
software in each, using "apt dist-upgrade", to the latest releases.

Now it would be neat to be able to run dedupe on them to bring disk usage back
to about that of a single container, since the OS and newly installed files
would be mostly the same in all of them.

It also could be that the containers are managed by different users or
customers, in which case recreating them from template on every new OS releases
would not be feasible, and upgrading each separately is the only option.

> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 08d0fb46ceec..906cb6166b67 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -15,6 +15,7 @@
>  #include "file-item.h"
>  #include "file.h"
>  #include "super.h"
> +#include "qgroup.h"
>  
>  #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
>  
> @@ -350,6 +351,19 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
>  	u64 last_dest_end = destoff;
>  	u64 prev_extent_end = off;
>  
> +	/*
> +	 * If squota is enabled, disable cloning between different subvolumes.
> +	 *
> +	 * As clone/reflink/dedupe is the only other way to share data between
> +	 * different subvolumes other than snapshotting.
> +	 * With it disabled, squota can be way more accurate.
> +	 */
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE) {
> +		if (BTRFS_I(src)->root->root_key.objectid !=
> +		    BTRFS_I(inode)->root->root_key.objectid)
> +			return -EXDEV;
> +	}
> +
>  	ret = -ENOMEM;
>  	buf = kvmalloc(fs_info->nodesize, GFP_KERNEL);
>  	if (!buf)


-- 
With respect,
Roman

