Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827F83B9FAD
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 13:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhGBLWw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 07:22:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55922 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhGBLWw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 07:22:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1A59D22985;
        Fri,  2 Jul 2021 11:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625224819;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=badF2A4qEOZ32Uu+PhlD0CDqgloiQf4kfcO0SCCAJdM=;
        b=mmG8zpRixprVY2svVvl2d+F7FbvbS7Cjl72YOi2Y/QLzJRoV47UJ1/7XTYskXXMvMxlHsj
        ZYV9bD4Jb4VEn5Qp8No1LLypLmbjJ1MY6RHxNAfqTKthzQVYcRTvoH9ICaSCo237/cdSnB
        krqp2+4fq9Ur/txsJxkD+1o5Tuk33Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625224819;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=badF2A4qEOZ32Uu+PhlD0CDqgloiQf4kfcO0SCCAJdM=;
        b=HGKLej9Ipsp5dwAm5vXLy5+ZP3P41NISkuD3pmUqIdW1nanFgZmqUlftgSylKLnQroLLrA
        jJ9wtD1v7ONhHJAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E582EA3B87;
        Fri,  2 Jul 2021 11:20:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9721DA6FD; Fri,  2 Jul 2021 13:17:47 +0200 (CEST)
Date:   Fri, 2 Jul 2021 13:17:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: Fix multiple out-of-bounds warnings
Message-ID: <20210702111747.GF2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210702010653.GA84106@embeddedor>
 <ba89916a-f141-2962-2526-89bd43e75a42@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba89916a-f141-2962-2526-89bd43e75a42@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 02, 2021 at 06:20:33PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/2 上午9:06, Gustavo A. R. Silva wrote:
> > Fix the following out-of-bounds warnings by using a flexible-array
> > member *pages[] at the bottom of struct extent_buffer:
> >
> > fs/btrfs/disk-io.c:225:34: warning: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Warray-bounds]
> 
> The involved code looks like:
> 
> static void csum_tree_block(struct extent_buffer *buf, u8 *result)
> {
>          struct btrfs_fs_info *fs_info = buf->fs_info;
>          const int num_pages = fs_info->nodesize >> PAGE_SHIFT;
> 	...
>          for (i = 1; i < num_pages; i++) {
>                  kaddr = page_address(buf->pages[i]);
>                  crypto_shash_update(shash, kaddr, PAGE_SIZE);
>          }
> 
> For Power case, the page size is 64K and nodesize is at most 64K for
> btrfs, thus num_pages will either be 0 or 1.
> 
> In that case, the for loop should never get reached, thus it's not
> possible to really get beyond the boundary.
> 
> To me, the real problem is we have no way to tell compiler that
> fs_info->nodesize is ensured to be no larger than 64K.
> 
> 
> Although using flex array can mask the problem, but it's really masking
> the problem as now compiler has no idea how large the array can really be.

Agreed, that's the problem, we'd be switching compile-time static
information about the array with dynamic.

> David still has the final say on how to fix it, but I'm really wondering
> is there any way to give compiler some hint about the possible value
> range for things like fs_info->nodesize?

We can add some macros that are also page size dependent and evaluate to
a constant that can be in turn used to optimize the loop to a single
call of the loop body.

Looking at csum_tree_block we should really use the num_extent_pages
helper that does the same thing but handles when nodesize >> PAGE_SIZE
is zero (and returns 1).
