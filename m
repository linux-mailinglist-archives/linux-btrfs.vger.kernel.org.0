Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1294C570729
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 17:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiGKPe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiGKPe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 11:34:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3F46113C;
        Mon, 11 Jul 2022 08:34:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C13EC203A0;
        Mon, 11 Jul 2022 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657553694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibgfxck5aA+CZ8n/I3QasCKRlyOnnCdyT/M8j1pRBNI=;
        b=mZxWhYRUcjf1M7Gk9lTlPfnaYdhUuBuG3WLL8byEwJdh5K05OHxnZKGe7Hyiyf+yRyNQzm
        sf0Z5DLKezRvxqv0rJxAJhOTCJx6ll6uMWz363kFYBIr5RpJNyiqM+PSK/+X6fUL/J4pO4
        74LOMGnOMb0wbqOjCWnGOHS3n3q2OvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657553694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibgfxck5aA+CZ8n/I3QasCKRlyOnnCdyT/M8j1pRBNI=;
        b=PnFmZKyZiNQSna10gPjmonoLB1i/QSlPNArYvasIMjyqsgyWqOlsWvr67m8JPRVDeB+gos
        KjzbGYJSt8aOprDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9260213322;
        Mon, 11 Jul 2022 15:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i020Ih5DzGJ0ZQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Jul 2022 15:34:54 +0000
Date:   Mon, 11 Jul 2022 17:30:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 03/13] btrfs: replace BTRFS_MAX_EXTENT_SIZE with
 fs_info->max_extent_size
Message-ID: <20220711153005.GZ15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
 <f5c4db672fc1862b1cec6fc3ee75c5aab85f75f1.1657321126.git.naohiro.aota@wdc.com>
 <PH0PR04MB7416D26D6BC98BC13EBD09309B859@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416D26D6BC98BC13EBD09309B859@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 09, 2022 at 11:36:45AM +0000, Johannes Thumshirn wrote:
> On 09.07.22 01:21, Naohiro Aota wrote:
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 3194eca41635..cedc94a7d5b2 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2021,10 +2021,16 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
> >  				    struct page *locked_page, u64 *start,
> >  				    u64 *end)
> >  {
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >  	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
> >  	const u64 orig_start = *start;
> >  	const u64 orig_end = *end;
> > -	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
> > +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> > +	/* The sanity tests may not set a valid fs_info. */
> > +	u64 max_bytes = fs_info ? fs_info->max_extent_size : BTRFS_MAX_EXTENT_SIZE;
> > +#else
> > +	u64 max_bytes = fs_info->max_extent_size;
> > +#endif
> 
> Do we really need the ifdef here? I don't think there will be a lot
> of performance penalty from the 1 compare that we safe with the ifdef.

You're right that performce-wise it does not make much improvement
however with the explicit ifdef it's clear that it's there for tests,
otherwise finding the conditional fs_info check would be hard to spot. A
search for CONFIG_BTRFS_FS_RUN_SANITY_TESTS would find it. On the other
hand the whole function is EXPORT_FOR_TESTS so we can expect exceptions
for tests. So this could be the pattern to follow should we need it in
the future (ie. no ifdef).
