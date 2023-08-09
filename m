Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D77767C9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 20:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjHIS74 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 14:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHIS7z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 14:59:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2245BE71
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 11:59:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D19281F74B;
        Wed,  9 Aug 2023 18:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691607593;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6zcTu8rZVnV4PkUU5uc8KCC1L4agb769IuJpQ30Yoo=;
        b=sPwqLJfQWTfn9sL9Fynd7Jg+pE/hQxnS0dyrvCpeMyv75jIyKMhgXh/hd2kIoau3k98E7v
        llnPPisNb5trtPInYZBy9OKUzooDK+Kes+LE4txZ05UKMfyX+foKyBqIi7xNByLVarpR2F
        KfRhrZNMXeLC7hK174w0uWXYmMdip40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691607593;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6zcTu8rZVnV4PkUU5uc8KCC1L4agb769IuJpQ30Yoo=;
        b=RvwEyBgy+xli3eu/lADeT40LEAr/6nduHZRFlbr5wlQluzKpk1vkt4Isk++gjiVyZXN2CE
        ewrLe5uA1LkxzdBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA00A133B5;
        Wed,  9 Aug 2023 18:59:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wedvLCni02TWJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 18:59:53 +0000
Date:   Wed, 9 Aug 2023 20:59:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: handle errors properly in
 update_inline_extent_backref()
Message-ID: <ZNPiKFZ40tjHUQnr@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 09, 2023 at 03:08:21PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> Inside function update_inline_extent_backref(), we have several
> BUG_ON()s along with some ASSERT()s which can be triggered by corrupted
> filesystem.
> 
> [ANAYLYSE]
> Most of those BUG_ON()s and ASSERT()s are just a way of handling
> unexpected on-disk data.
> 
> Although we have tree-checker to rule out obviously incorrect extent
> tree blocks, it's not enough for those ones.
> 
> Thus we need proper error handling for them.
> 
> [FIX]
> Thankfully all the callers of update_inline_extent_backref() would
> eventually handle the errror by aborting the current transaction.
> 
> So this patch would do the proper error handling by:
> 
> - Make update_inline_extent_backref() to return int
>   The return value would be either 0 or -EUCLEAN.
> 
> - Replace BUG_ON()s and ASSERT()s with proper error handling
>   This includes:
>   * Dump the bad extent tree leaf
>   * Output an error message for the cause
>     This would include the extent bytenr, num_bytes (if needed),
>     the bad values and expected good values.
>   * Return -EUCLEAN
> 
>   Note here we remove all the WARN_ON()s, as eventually the transaction
>   would be aborted, thus a backtrace would be triggered anyway.
> 
> - Better comments on why we expect refs == 1 and refs_to_mode == -1 for
>   tree blocks
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 80 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 3cae798499e2..45e325523e81 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -381,11 +381,11 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>  		}
>  	}
>  
> +	WARN_ON(1);
>  	btrfs_print_leaf(eb);
>  	btrfs_err(eb->fs_info,
>  		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
>  		  eb->start, (unsigned long)iref, type);
> -	WARN_ON(1);

Do we even want to print the warning here? There's the whole leaf, error
message, why would we need the stack trace?
