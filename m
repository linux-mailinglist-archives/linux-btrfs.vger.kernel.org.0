Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208656D7E0D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbjDENu3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbjDENu2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 09:50:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE46A9
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 06:50:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9945322968;
        Wed,  5 Apr 2023 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680702625;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ArEuz0Z3KTqtnM+fjypv9SUbm8LJyTk88SDSdN4eTzM=;
        b=oL80Q9N4MhpXpyAPvsHr1bzU1wanMxm91Qs+s7nG6LpVYCw8nP9m9P8GVingLclxFcIOM/
        HDw73fQn5zF3sX69QU6b8/6hmIuYPYCiwCZHh4hyMCkHgcuJwPg2yAJbOKc8my3sY+l9vE
        6jVu3T4xTc5cGD/z93aFxvo1FUJuphQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680702625;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ArEuz0Z3KTqtnM+fjypv9SUbm8LJyTk88SDSdN4eTzM=;
        b=7/yN6fwESP00vufOrLTAfHveg2ofkzWRjcd+GxVlGnLrh/Shl5YjYDKY9GHRPqk9uwCZIk
        fagI8sUbCM2/UWAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70AEB13A31;
        Wed,  5 Apr 2023 13:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N1u2GqF8LWRsdQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 05 Apr 2023 13:50:25 +0000
Date:   Wed, 5 Apr 2023 15:50:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: remove the sync_writers field in struct
 btrfs_inode
Message-ID: <20230405135023.GH19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230329001308.1275299-1-hch@lst.de>
 <20230329001308.1275299-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329001308.1275299-3-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 29, 2023 at 09:13:06AM +0900, Christoph Hellwig wrote:
> The sync_writers field communicates if an inode has outstanding
> synchronous writeback.  The better way is to look at the REQ_SYNC
> flag in the bio, which is set by the writeback code for WB_SYNC_ALL
> writeback and can communicate the need for sync writeback without
> an inode field.

This does not go into much detail why it is 'better'. Tracking the
status from the outside as sync_writers applies to the whole inode and
not just the submission context of the individual bios so there's a
difference.

Also the subject should say something about changing the decision logic,
removal of sync_writes is just a side effect.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/bio.c         | 7 +++----
>  fs/btrfs/btrfs_inode.h | 3 ---
>  fs/btrfs/file.c        | 9 ---------
>  fs/btrfs/inode.c       | 1 -
>  fs/btrfs/transaction.c | 2 --
>  5 files changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index cf09c6271edbee..c851a3526911f6 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -552,11 +552,10 @@ static void run_one_async_free(struct btrfs_work *work)
>  static bool should_async_write(struct btrfs_bio *bbio)
>  {
>  	/*
> -	 * If the I/O is not issued by fsync and friends, (->sync_writers != 0),
> -	 * then try to defer the submission to a workqueue to parallelize the
> -	 * checksum calculation.
> +	 * Try to defer the submission to a workqueue to parallelize the
> +	 * checksum calculation unless the I/O is issued synchronously.
>  	 */
> -	if (atomic_read(&bbio->inode->sync_writers))
> +	if (op_is_sync(bbio->bio.bi_opf))

So if there's sync_writers set from any of

- btrfs_do_write_iter
- start_ordered_ops
- btrfs_write_marked_extents

then should_async_write would always return false. The change in
behaviour looks like "write everything for this inode synchronously" vs
"write some bios synchronously". I don't see the 1:1 correspondence.

>  		return false;
