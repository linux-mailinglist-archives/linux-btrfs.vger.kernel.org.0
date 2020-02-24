Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A110316B0C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 21:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXUJo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 15:09:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBXUJo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 15:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SFdn4yz22kuGRVQ3/mkOHo6hMcbfn3RggaH/0YWQaWk=; b=mAiw6CwtOIXi/iWekYQR9urYq6
        mJooIhbLgxaXykMbxDxhZvYa88Us8HhXoWB+GyCo5bXdApi3YffRNU5j9+cgAYeUxZ/mNuJWgYT3g
        g7GPlnw/y8PSDmxDAXThxCjNeIPMU68K4BjFasC+XlBP+06mqLLGxzL7XgwhtvLPgsoO3JCG5B73j
        955kTO8O683aGYaw807OHLIbcd5TQ8JogZybbDS89CzejqF4ljje8/hjdSTxtp5TWFsTfWItVfdJi
        MV+b8X4+js0B5hZzIQ0kSz7ODeVODe05vFcB5e+V11F3am2x8XyMVENbTD3GL2LvqJPP9CQcAhkiG
        0h77BjmA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6K2x-0002IF-F1; Mon, 24 Feb 2020 20:09:43 +0000
Date:   Mon, 24 Feb 2020 12:09:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/11] btrfs: replace u_long type cast with unsigned long
Message-ID: <20200224200943.GA8523@infradead.org>
References: <cover.1582302545.git.dsterba@suse.com>
 <f21f18a03a86c32c44e60f9b08d67cc7ff0ea272.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21f18a03a86c32c44e60f9b08d67cc7ff0ea272.1582302545.git.dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 05:31:17PM +0100, David Sterba wrote:
> We don't use the u_XX types anywhere, though they're defined.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/volumes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 945b89e2104f..fe1f609c736b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6269,8 +6269,8 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
>  	btrfs_debug_in_rcu(fs_info,
>  	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
>  		bio_op(bio), bio->bi_opf, (u64)bio->bi_iter.bi_sector,
> -		(u_long)dev->bdev->bd_dev, rcu_str_deref(dev->name), dev->devid,
> -		bio->bi_iter.bi_size);
> +		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
> +		dev->devid, bio->bi_iter.bi_size);

Mostly we just print major and minor separately, which would remove the
cast entirely.
