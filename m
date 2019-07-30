Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830687ADAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 18:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbfG3QdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 12:33:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727924AbfG3QdP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 12:33:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 992B1B03C;
        Tue, 30 Jul 2019 16:33:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5990ADA808; Tue, 30 Jul 2019 18:33:49 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:33:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.cz,
        quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: Add an assertion to warn incorrct case in
 insert_inline_extent()
Message-ID: <20190730163349.GD28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jia-Ju Bai <baijiaju1990@gmail.com>,
        clm@fb.com, josef@toxicpanda.com, quwenruo.btrfs@gmx.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190727085113.11530-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727085113.11530-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 27, 2019 at 04:51:13PM +0800, Jia-Ju Bai wrote:
> In insert_inline_extent(), the case that compressed_size > 0 
> and compressed_pages = NULL cannot occur, otherwise a null-pointer
> dereference may occur on line 215:
>      cpage = compressed_pages[i];
> 
> To warn this incorrect case, an assertion is added.
> Thank Qu Wenruo and David Sterba for good advice.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/btrfs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1af069a9a0c7..21d6e2dcc25f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -178,6 +178,9 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  	size_t cur_size = size;
>  	unsigned long offset;
>  
> +	ASSERT((compressed_size > 0 && compressed_pages) ||
> +			(compressed_size == 0 && !compressed_pages))

Thanks. I expect that the static checking tools can be instructed to
understand that the condition has been checked and is not missing in the
code below. ASSERT is conditinally a BUG() wrapper, otherwise a no-op.

Btw, it's also good to check that the code compiles, the statement is
missing semicolon.
