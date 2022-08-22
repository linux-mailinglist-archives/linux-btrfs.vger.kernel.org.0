Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1AF59C17E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiHVOQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 10:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiHVOPh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 10:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D406E00F
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 07:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA5B611C5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 14:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5966C433D6;
        Mon, 22 Aug 2022 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661177735;
        bh=vpRswsAEOcdzoR+9IzaOZjS3JPZy8bX900StZTAXOAs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=FWtExO/EU73FSJs66r3tfjdShHxS7A+eVsyzsegCreS3fzNCUmBv4pWmHoF3/QBAj
         JvSXyRtLk01FQV/tHEpkuEeQdc7V0lxsG2nd6G0DM8xpdcfQTVwMfzqIg8ztr0XsIw
         Xlsl2q68YdLfSc5ptvj0CATWaVE5zwe4Dhep0crTDvDYlWMfrEBeL9YRiEdkEhph6p
         smI5z33IAQ3r38YZfQHxGUbY9BduVcR6G3Ly2E8T6p6cvd0Zu3R0I3J24g7DtTTIxe
         ySDa0+0mCJHFFK1avKEJi8w5KLNgYCPo0zamZDGzb3a9PTh0kZdsOctpx4fexENe14
         Zb142/RuVoLiA==
Date:   Mon, 22 Aug 2022 15:15:32 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/15] btrfs: shrink the size of struct btrfs_delayed_item
Message-ID: <20220822141532.GA3129988@falcondesktop>
References: <cover.1660735024.git.fdmanana@suse.com>
 <bd1d34e39a5fe9d226da167f8b970527f980846d.1660735025.git.fdmanana@suse.com>
 <20220822134326.GX13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822134326.GX13489@twin.jikos.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 22, 2022 at 03:43:26PM +0200, David Sterba wrote:
> On Wed, Aug 17, 2022 at 12:22:42PM +0100, fdmanana@kernel.org wrote:
> >  	}
> >  
> >  	item->index = index;
> > -	item->ins_or_del = BTRFS_DELAYED_DELETION_ITEM;
> >  
> >  	ret = btrfs_delayed_item_reserve_metadata(trans, item);
> >  	/*
> > diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
> > index fd6fe785f748..729d352ca8a1 100644
> > --- a/fs/btrfs/delayed-inode.h
> > +++ b/fs/btrfs/delayed-inode.h
> > @@ -16,9 +16,10 @@
> >  #include <linux/refcount.h>
> >  #include "ctree.h"
> >  
> > -/* types of the delayed item */
> > -#define BTRFS_DELAYED_INSERTION_ITEM	1
> > -#define BTRFS_DELAYED_DELETION_ITEM	2
> > +enum btrfs_delayed_item_type {
> > +	BTRFS_DELAYED_INSERTION_ITEM,
> > +	BTRFS_DELAYED_DELETION_ITEM
> > +};
> >  
> >  struct btrfs_delayed_root {
> >  	spinlock_t lock;
> > @@ -80,8 +81,9 @@ struct btrfs_delayed_item {
> >  	u64 bytes_reserved;
> >  	struct btrfs_delayed_node *delayed_node;
> >  	refcount_t refs;
> > -	int ins_or_del;
> > -	u32 data_len;
> > +	enum btrfs_delayed_item_type type:1;
> 
> Bit fields next to atomicly accessed variables could be problemantic on
> architectures without safe unaligned access. Either this can be :8 or
> moved after 'key' where's a 7 byte hole.

Yep, I forgot that.

The 'key' doesn't exist anymore, it was removed in a previous patch of
the series, so the 7 bytes holes is not there anymore.

I don't see any other place in the structure where I can move the fields
and still reduce its size. If switching from :1 to :8 is enough to
guarantee safety, I guess it's the only solution.

Do you me to send a new version just to switch :1 to :8 or will you do
that change?

Thanks.
