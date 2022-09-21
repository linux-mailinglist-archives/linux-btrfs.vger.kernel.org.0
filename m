Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C540E5BFBBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 11:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiIUJyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 05:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiIUJxT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 05:53:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3BD9412E
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 02:52:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5C3021B2E;
        Wed, 21 Sep 2022 09:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663753922;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKA+Xg4mzHWDsZ4xqnOVTHP8hxUdWU2uVIC8IjWOHLw=;
        b=pMhHmnEb50DUOqWa4FHOr1QU7Ze++vtn31A12eyAYVCP5FalLbzQ1jN+X2xDNuO9sS9NFX
        NFdoXu2GnezDURw7v+G5ADpyKPdd+ucfs9B/geS6hVeVhU0tUcc8rnOld5A3DIw8bie8I1
        KpWOgt4uX19cUFPRA4I6s/4o42gjNyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663753922;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKA+Xg4mzHWDsZ4xqnOVTHP8hxUdWU2uVIC8IjWOHLw=;
        b=8ZsHWmtnEmahXfoXWbNbaE2wj+6lvcu2HJZC6UgFXTQvFGKcVMP94qUMepF+IpLvSqtmCx
        57T+tkA4adQsBtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 893C113A00;
        Wed, 21 Sep 2022 09:52:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3hXBIMLeKmOZUgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Sep 2022 09:52:02 +0000
Date:   Wed, 21 Sep 2022 11:46:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: loosen the block-group-tree feature dependency
 check
Message-ID: <20220921094630.GC32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d43e26ecf12268e8bc75986052cc6021a096db74.1662961395.git.wqu@suse.com>
 <b56c2284-4702-2d61-4b73-f68c21b73b70@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b56c2284-4702-2d61-4b73-f68c21b73b70@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 21, 2022 at 07:40:19AM +0800, Qu Wenruo wrote:
> On 2022/9/12 13:44, Qu Wenruo wrote:
> > [BUG]
> > When one user did a wrong try to clear block group tree, which can not
> > be done through mount option, by using "-o clear_cache,space_cache=v2",
> > it will cause the following error on a fs with block-group-tree feature:
> > 
> >   BTRFS info (device dm-1): force clearing of disk cache
> >   BTRFS info (device dm-1): using free space tree
> >   BTRFS info (device dm-1): clearing free space tree
> >   BTRFS info (device dm-1): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
> >   BTRFS info (device dm-1): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
> >   BTRFS error (device dm-1): block-group-tree feature requires fres-space-tree and no-holes
> >   BTRFS error (device dm-1): super block corruption detected before writing it to disk
> >   BTRFS: error (device dm-1) in write_all_supers:4318: errno=-117 Filesystem corrupted (unexpected superblock corruption detected)
> >   BTRFS warning (device dm-1: state E): Skipping commit of aborted transaction.
> > 
> > [CAUSE]
> > Although the dependency for block-group-tree feature is just an
> > artificial one (to reduce test matrix), we put the dependency check into
> > btrfs_validate_super().
> > 
> > This is too strict, and during space cache clearing, we will have a
> > window where free space tree is cleared, and we need to commit the super
> > block.
> > 
> > In that window, we had block group tree without v2 cache, and triggered
> > the artificial dependency check.
> > 
> > This is not necessary at all, especially for such a soft dependency.
> > 
> > [FIX]
> > Introduce a new helper, btrfs_check_features(), to do all the runtime
> > limitation checks, including:
> > 
> > - Unsupported incompat flags check
> > 
> > - Unsupported compat RO flags check
> > 
> > - Setting missing incompat flags
> > 
> > - Aritifical feature dependency checks
> >    Currently only block group tree will rely on this.
> > 
> > - Subpage runtime check for v1 cache
> > 
> > With this helper, we can move quite some checks from
> > open_ctree()/btrfs_remount() into it, and just call it after
> > btrfs_parse_options().
> > 
> > Now "-o clear_cache,space_cache=v2" will not trigger above error
> > anymore.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Any feedback? I really hope this patch can be merged before we expose 
> the kernel support for block group tree.
> 
> Or clear_space_cache mount option can easily flip the fs to RO.

I'm aware of the patch, as it is technically a regression fix it can go
to any rc, I was processing other patches that must be merged before the
pull request. That was before rc6 and there will be rc7 so there's more
time to add this still to the first batch.
