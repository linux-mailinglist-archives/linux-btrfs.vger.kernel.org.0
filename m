Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409DC421838
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 22:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhJDUNF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 16:13:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54670 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhJDUNE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 16:13:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F39A1FE0A;
        Mon,  4 Oct 2021 20:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633378274;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fr2KpR/otx9TGXBDAPSfKL+1WXeoyN8TF2nAfNqRm3k=;
        b=DrzrwGjhoI1PGYxNs1OJwpGfMUyeAYJ01TUaoPW5CYzBZ+0RoKDFeWnB0ORKWfk23Ue7ra
        3wc+dBA1SK1+WVucKik4mvUdL9fTLBVqg0nzK2y2IPWRggRHd82X/UDLcPyWtfbMD+Ywv8
        6JwPPhF0BSvobCX4ciH1tqdSLUKGr+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633378274;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fr2KpR/otx9TGXBDAPSfKL+1WXeoyN8TF2nAfNqRm3k=;
        b=Vq2ny2JXzKYs8ZNLNR1BtxMkLo0/HjjalbWYvlAfhq95B+Oq8bFJJVBWHF8lAlXs+o7qYh
        ppoJgyz5glXyqSBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6CCA8A3B83;
        Mon,  4 Oct 2021 20:11:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18091DA7F3; Mon,  4 Oct 2021 22:10:55 +0200 (CEST)
Date:   Mon, 4 Oct 2021 22:10:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 12/26] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Message-ID: <20211004201054.GD9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210927072208.21634-1-wqu@suse.com>
 <20210927072208.21634-13-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927072208.21634-13-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 03:21:54PM +0800, Qu Wenruo wrote:
> Currently btrfs_submit_compressed_read() will check
> btrfs_bio_fits_in_stripe() each time a new page is going to be added.
> 
> Even compressed extent is small, we don't really need to do that for
> every page.
> 
> This patch will align the behavior to extent_io.c, by determining the
> stripe boundary when allocating a bio.
> 
> Unlike extent_io.c, in compressed.c we don't need to bother things like
> different bio flags, thus no need to re-use bio_ctrl.
> 
> Here we just manually introduce new local variable, next_stripe_start,
> and teach alloc_compressed_bio() to calculate the stripe boundary.
> 
> Then each time we add some page range into the bio, we check if we
> reached the boundary.
> And if reached, submit it.
> 
> Also, since we have @cur_disk_byte to determine whether we're the last
> bio, we don't need a explicit last_bio: tag for error handling any more.
> 
> And we can use @cur_disk_byte to track which range has been added to
> bio, we can also use @cur_disk_byte to calculate the wait condition, no
> need for @pending_bios.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 164 +++++++++++++++++++++++------------------
>  1 file changed, 93 insertions(+), 71 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 1b62677cd0f3..319d39fd1afa 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -439,11 +439,18 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
>  
>  /*
>   * To allocate a compressed_bio, which will be used to read/write on-disk data.
> + *
> + * @next_stripe_start:	Disk bytenr of next stripe start

Please send an incremental followup to also document all the remaining
parameters. We're not strict about the kdoc warnings but if the code
gets touched it's better to complete it.

>   */
>  static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
> -					unsigned int opf, bio_end_io_t endio_func)
> +					unsigned int opf, bio_end_io_t endio_func,
> +					u64 *next_stripe_start)
