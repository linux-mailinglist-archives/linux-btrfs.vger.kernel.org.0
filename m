Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94075FA78
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 17:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjGXPMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGXPM3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 11:12:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C7110CE
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pljxc8exOqYPGQ1wFe+VDkHdbN71bDcV82CR96f55eY=; b=wfUG89qRT1wbjTwsWbx+benakO
        wJz7uJgXT/D4YYuVqUdU4VnpmU3h0vPzHAJ8ELIuCAsofREb+k2vYuqorSKYkGzvw+iECJHnd7KxI
        ClE7ITrt0ujZeW1KLHU3c+u0BG69ho1uczPKFSycNXjaYRhI8JnzmgfYY5hLljvZ0C5Dpq709GHIK
        NnyDJtI+gtNWWkR5z1+vYsMtBh32gTTLtwbQqWtl+U7LyrDg96WvELAigPVZvpn/x9Gl/UOvYJFXZ
        Gy3CaNFyZQUpD4OOoT2XKo/Pc57IsicvTtwhsOZMYPv7cck03k7eGrQDzV5p9EDwfhX8oeCeQvh7E
        OOyzeM2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNxEa-004hfR-0y;
        Mon, 24 Jul 2023 15:12:28 +0000
Date:   Mon, 24 Jul 2023 08:12:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/8] btrfs: zoned: activate metadata block group on write
 time
Message-ID: <ZL6U3DYVw9JHLUC6@infradead.org>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <2f8e30f966cfd9e06b0745a691bd1a5566aab780.1690171333.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8e30f966cfd9e06b0745a691bd1a5566aab780.1690171333.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 01:18:34PM +0900, Naohiro Aota wrote:
> Since metadata write-out is always allocated sequentially, when we need to
> write to a non-active block group, we can wait for the ongoing IOs to
> complete, activate a new block group, and then proceed with writing to the
> new block group.

Somewhat unrelated, but isn't the same true for data as well, and maybe
in a follow on the same activation policy should apply there as well?
I guess it won't quite work without much work as reservations are tied
to a BG, but it would seem like the better scheme.

> +	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags)) {

Just a more or less cosmetic nit:  there is a lot of code in this
branch, and I wonder if the active zone tracking code would benefit
from being split out into one or more helpers.

> +		bool is_system = cache->flags & BTRFS_BLOCK_GROUP_SYSTEM;
> +
> +		spin_lock(&cache->lock);
> +		if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> +			     &cache->runtime_flags)) {
> +			spin_unlock(&cache->lock);
> +			return true;
> +		}
> +
> +		spin_unlock(&cache->lock);

What is the point of the cache->lock crticial section here?  The
information can be out of date as soon as you drop the lock, so it
looks superflous to me.

> +		if (fs_info->treelog_bg == cache->start) {
> +			if (!btrfs_zone_activate(cache)) {
> +				int ret_fin = btrfs_zone_finish_one_bg(fs_info);
> +
> +				if (ret_fin != 1 || !btrfs_zone_activate(cache))
> +					return false;

The ret_fin variable here doesn't seem to be actually needed.

> +			}
> +		} else if ((!is_system && fs_info->active_meta_bg != cache) ||
> +			   (is_system && fs_info->active_system_bg != cache)) {
> +			struct btrfs_block_group *tgt = is_system ?
> +				fs_info->active_system_bg : fs_info->active_meta_bg;

There's a lot of checks for is_system here and later on in the
logic.  If we had a helper for this, you could just pass in a bg double
pointer argument that the callers sets to &fs_info->active_system_bg or
&fs_info->active_meta_bg and simplify a lot of the logic.

