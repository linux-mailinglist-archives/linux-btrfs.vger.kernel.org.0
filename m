Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7559C2F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 17:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiHVPeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiHVPek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 11:34:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6828E193F2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 08:34:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1205B34F52;
        Mon, 22 Aug 2022 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661182476;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ojqeceB9rE21DfFirWrlG93i08P9HGIWMX7jfgCOWJA=;
        b=CJbML9peEParU6xDdi2B4VmB8mefftvq3nMA6mRWFoi5VDGEzHWzNX/JjT5VC/i6ISO4K5
        L1qY7bqxJ/A/E4nlCRa+4oXK7UCvPO+VFlSw3RnZEpKmBCXc3sOuRiPs3p5k7KwTzzDq83
        dmMXHIV5ocgRiGigsIfSB/FsGaq5CZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661182476;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ojqeceB9rE21DfFirWrlG93i08P9HGIWMX7jfgCOWJA=;
        b=jCbbmSP+DTXRJ4ptj51mDZObAcpB9r05UDi4MN7YpswBTBunzrRn4luPp8+TmvJPCePzdR
        m7rsQGeRR8cAU+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D70E51332D;
        Mon, 22 Aug 2022 15:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5f8yMwuiA2N7GwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 15:34:35 +0000
Date:   Mon, 22 Aug 2022 17:29:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/15] btrfs: shrink the size of struct btrfs_delayed_item
Message-ID: <20220822152921.GY13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs@vger.kernel.org
References: <cover.1660735024.git.fdmanana@suse.com>
 <bd1d34e39a5fe9d226da167f8b970527f980846d.1660735025.git.fdmanana@suse.com>
 <20220822134326.GX13489@twin.jikos.cz>
 <20220822141532.GA3129988@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822141532.GA3129988@falcondesktop>
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

On Mon, Aug 22, 2022 at 03:15:32PM +0100, Filipe Manana wrote:
> On Mon, Aug 22, 2022 at 03:43:26PM +0200, David Sterba wrote:
> > On Wed, Aug 17, 2022 at 12:22:42PM +0100, fdmanana@kernel.org wrote:
> > >  	}
> > >  
> > >  	item->index = index;
> > > -	item->ins_or_del = BTRFS_DELAYED_DELETION_ITEM;
> > >  
> > >  	ret = btrfs_delayed_item_reserve_metadata(trans, item);
> > >  	/*
> > > diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
> > > index fd6fe785f748..729d352ca8a1 100644
> > > --- a/fs/btrfs/delayed-inode.h
> > > +++ b/fs/btrfs/delayed-inode.h
> > > @@ -16,9 +16,10 @@
> > >  #include <linux/refcount.h>
> > >  #include "ctree.h"
> > >  
> > > -/* types of the delayed item */
> > > -#define BTRFS_DELAYED_INSERTION_ITEM	1
> > > -#define BTRFS_DELAYED_DELETION_ITEM	2
> > > +enum btrfs_delayed_item_type {
> > > +	BTRFS_DELAYED_INSERTION_ITEM,
> > > +	BTRFS_DELAYED_DELETION_ITEM
> > > +};
> > >  
> > >  struct btrfs_delayed_root {
> > >  	spinlock_t lock;
> > > @@ -80,8 +81,9 @@ struct btrfs_delayed_item {
> > >  	u64 bytes_reserved;
> > >  	struct btrfs_delayed_node *delayed_node;
> > >  	refcount_t refs;
> > > -	int ins_or_del;
> > > -	u32 data_len;
> > > +	enum btrfs_delayed_item_type type:1;
> > 
> > Bit fields next to atomicly accessed variables could be problemantic on
> > architectures without safe unaligned access. Either this can be :8 or
> > moved after 'key' where's a 7 byte hole.
> 
> Yep, I forgot that.
> 
> The 'key' doesn't exist anymore, it was removed in a previous patch of
> the series, so the 7 bytes holes is not there anymore.

Right, I did not check on the exact commit first.

> I don't see any other place in the structure where I can move the fields
> and still reduce its size. If switching from :1 to :8 is enough to
> guarantee safety, I guess it's the only solution.

Yeah that's find and there's only one byte unused, leaving the char
data[] aligned to 8 bytes:

struct btrfs_delayed_item {
        struct rb_node             rb_node __attribute__((__aligned__(8))); /*     0    24 */
        u64                        index;                /*    24     8 */
        struct list_head           tree_list;            /*    32    16 */
        struct list_head           readdir_list;         /*    48    16 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        bytes_reserved;       /*    64     8 */
        struct btrfs_delayed_node * delayed_node;        /*    72     8 */
        refcount_t                 refs;                 /*    80     4 */
        enum btrfs_delayed_item_type type:8;             /*    84: 0  4 */

        /* XXX 8 bits hole, try to pack */
        /* Bitfield combined with next fields */

        u16                        data_len;             /*    86     2 */
        char                       data[];               /*    88     0 */

        /* size: 88, cachelines: 2, members: 10 */
        /* sum members: 86 */
        /* sum bitfield members: 8 bits, bit holes: 1, sum bit holes: 8 bits */
        /* forced alignments: 1 */
        /* last cacheline: 24 bytes */
} __attribute__((__aligned__(8)));

> Do you me to send a new version just to switch :1 to :8 or will you do
> that change?

I'll do that, it's a simple change but I wanted to let you know about
that.
