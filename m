Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5681A583E3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiG1MCf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 08:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiG1MCd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 08:02:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4023C24F1B
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 05:02:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA7E434B0C;
        Thu, 28 Jul 2022 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659009751;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=13JVE6IqITi5qpBmgxqZeNhg3aGGNF5563zjoRP39BQ=;
        b=QwLrLQAnGolYa0mLbSnnjunZ2OW8tVFlSD4X/jgOn3SNRiYgiRmlNd4FsYG4O/LoNHFgym
        pdyTYgPZCiykBCdI6qr03g5WmHUUgJabZqpOmRNV3QtH8UVlqX4ypAVr7x6e0Pj9RubjWs
        LlhuSx86xlGy7xtlM8ucGUeLuGFK6xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659009751;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=13JVE6IqITi5qpBmgxqZeNhg3aGGNF5563zjoRP39BQ=;
        b=U1xROsDBN53zWVR6eJcyF7v6DcWka0+i4CRUkjGoBcBKygFgMiBWkZ5w7ujiH1JlMQAdg/
        cD7BK+RoxXW0rkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C05E913A7E;
        Thu, 28 Jul 2022 12:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X0PzLdd64mLbHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 28 Jul 2022 12:02:31 +0000
Date:   Thu, 28 Jul 2022 13:57:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: auto enable discard=async when possible
Message-ID: <20220728115733.GD13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Roman Mamedov <rm@romanrm.net>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220727150158.GT13489@suse.cz>
 <20220727234758.33232508@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727234758.33232508@nvm>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 11:47:58PM +0500, Roman Mamedov wrote:
> On Wed, 27 Jul 2022 17:01:58 +0200
> David Sterba <dsterba@suse.com> wrote:
> 
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -1503,6 +1503,7 @@ enum {
> >  	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
> >  	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
> >  	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
> > +	BTRFS_MOUNT_NODISCARD			= (1UL << 31),
> >  };
> >  
> >  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 3fac429cf8a4..8f8e33219d4d 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3767,6 +3767,20 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >  		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
> >  	}
> >  
> > +	/*
> > +	 * For devices supporting discard turn on discard=async automatically,
> > +	 * unless it's already set or disabled. This could be turned off by
> > +	 * nodiscard for the same mount.
> > +	 */
> > +	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
> > +	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
> > +	      btrfs_test_opt(fs_info, NODISCARD)) &&
> > +	    fs_info->fs_devices->discardable) {
> > +		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
> > +				"auto enabling discard=async");
> > +	      btrfs_clear_opt(fs_info->mount_opt, NODISCARD);
> 
> Spaces are used in the above line instead of a 2nd TAB.
> 
> Also I am probably clueless, but it seems the condition just checked that
> NODISCARD was not set, so what is the purpose of also clearing it?

I think it's out of habit and consistency with other option handling to
make it clear what's the new state (compression and datacow/datasum), but
you're right that here it's a bit redundant.
