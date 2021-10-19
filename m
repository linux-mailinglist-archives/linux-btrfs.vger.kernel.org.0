Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416E7433B06
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 17:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhJSPtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 11:49:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57428 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSPtP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 11:49:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5EED921973;
        Tue, 19 Oct 2021 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634658422;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4KUePrfjrBb9iZO9tPu/0sz9PU3/HCAebwgfg+T3IOU=;
        b=X14/3TJELUaiEmTZYkrE4wgpqw/yGh8JqXs38GfSwc8QmTfpv6KUMn8JMjcuDQl1sbkZOB
        ruonn1iFju8Ltz9Foa7edosfWR09ccaK1DPn+acVMG97svsFmUbxmYMhl1CRZu5lVcFMzJ
        JsOyNYdyitA4CONYtc5sr26S0sS67vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634658422;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4KUePrfjrBb9iZO9tPu/0sz9PU3/HCAebwgfg+T3IOU=;
        b=8b/W+n8uzyiyGjCKkWzEFZhYv/OCMMNgn48sA4y23r7ru572dPgRZwQlMbq7dGL3zrbIBH
        XFMV04LjekMpzzDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 53810A3B91;
        Tue, 19 Oct 2021 15:47:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9E0DDA7A3; Tue, 19 Oct 2021 17:46:34 +0200 (CEST)
Date:   Tue, 19 Oct 2021 17:46:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: make sizeof(struct btrfs_super_block) to
 match BTRFS_SUPER_INFO_SIZE
Message-ID: <20211019154634.GU30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211019112925.71920-1-wqu@suse.com>
 <20211019112925.71920-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019112925.71920-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 07:29:24PM +0800, Qu Wenruo wrote:
> It's a common practice to avoid use sizeof(struct btrfs_super_block)
> (3531), but to use BTRFS_SUPER_INFO_SIZE (4096).
> 
> The problem is that, sizeof(struct btrfs_super_block) doesn't match
> BTRFS_SUPER_INFO_SIZE from the very beginning.
> 
> Furthermore, for all call sites except selftest, we always allocate
> BTRFS_SUPER_INFO_SIZE space for btrfs super block, there isn't any real
> reason to use the smaller value, and it doesn't really save any space.

Right, due to the size it would end up in the 4K slab anyway.

> So let's get rid of such confusing behavior, and unify those two values.
> 
> This patch will also add a BUILD_BUG_ON() to verify the value at build
> time.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h | 3 +++
>  fs/btrfs/super.c | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 140126898577..e05098ac0337 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -270,6 +270,9 @@ struct btrfs_super_block {
>  	__le64 reserved[28];
>  	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
>  	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
> +
> +	/* Padded to 4096 bytes */
> +	u8 padding[565];
>  } __attribute__ ((__packed__));

Please use static_assert, it can be used in a header and also is self
documenting and right in the place where we care about it.
