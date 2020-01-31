Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC7A14F307
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 21:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgAaUGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 15:06:08 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:37137 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgAaUGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 15:06:07 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id D19F3A9D18;
        Fri, 31 Jan 2020 21:06:05 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
Date:   Fri, 31 Jan 2020 21:06:03 +0100
Message-ID: <2687257.pSW7MMRxUZ@merkaba>
In-Reply-To: <20200131143105.52092-1-josef@toxicpanda.com>
References: <20200131143105.52092-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Josef Bacik - 31.01.20, 15:31:05 CET:
> There was some logic added a while ago to clear out f_bavail in
> statfs() if we did not have enough free metadata space to satisfy our
> global reserve.  This was incorrect at the time, however didn't
> really pose a problem for normal file systems because we would often
> allocate chunks if we got this low on free metadata space, and thus
> wouldn't really hit this case unless we were actually full.
> 
> Fast forward to today and now we are much better about not allocating
> metadata chunks all of the time.  Couple this with d792b0f19711 which
> now means we'll easily have a larger global reserve than our free
> space, we are now more likely to trip over this while still having
> plenty of space.
> 
> Fix this by skipping this logic if the global rsv's space_info is not
> full.  space_info->full is 0 unless we've attempted to allocate a
> chunk for that space_info and that has failed.  If this happens then
> the space for the global reserve is definitely sacred and we need to
> report b_avail == 0, but before then we can just use our calculated
> b_avail.

Thank you!

The fix works:

merkaba:~> LANG=en df -hT /daten
Filesystem             Type   Size  Used Avail Use% Mounted on
/dev/mapper/sata-daten btrfs  400G  311G   91G  78% /daten

Tested-By: Martin Steigerwald <martin@lichtvoll.de>

Thanks,
Martin

> 
> There are other cases where df isn't quite right, and Qu is addressing
> them in a more holistic way.  This simply fixes the users that are
> currently experiencing pain because of this problem.
> 
> Fixes: ca8a51b3a979 ("btrfs: statfs: report zero available if metadata
> are exhausted") Reported-by: Martin Steigerwald <martin@lichtvoll.de>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/super.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index d421884f0c23..42433ca822aa 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2143,7 +2143,15 @@ static int btrfs_statfs(struct dentry *dentry,
> struct kstatfs *buf) */
>  	thresh = SZ_4M;
> 
> -	if (!mixed && total_free_meta - thresh < block_rsv->size)
> +	/*
> +	 * We only want to claim there's no available space if we can no
> longer +	 * allocate chunks for our metadata profile and our 
global
> reserve will +	 * not fit in the free metadata space.  If we aren't
> ->full then we +	 * still can allocate chunks and thus are fine using
> the currently +	 * calculated f_bavail.
> +	 */
> +	if (!mixed && block_rsv->space_info->full &&
> +	    total_free_meta - thresh < block_rsv->size)
>  		buf->f_bavail = 0;
> 
>  	buf->f_type = BTRFS_SUPER_MAGIC;


-- 
Martin


