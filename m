Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6ED3D935C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhG1Qlk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 12:41:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57904 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1Qlk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 12:41:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 865F122331;
        Wed, 28 Jul 2021 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627490497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igOio8fBSU54FZqogXK4id+AuMVfwQ0wCmqmPqyaiog=;
        b=j+68LfG+aTVK3ha38RZ8L1Z+0s5VC2Mo5paJ8zMl5CQCnkpHQuTlI8dNMDdK2PCdRpM9Om
        XF5lgjSpHOZvx3JGoiOG5XjA+AspxOVwz+kQ2TObShIwFLHqwrdNVhIBHVYQez9/6KRBdE
        CqNQ2/C+Ra+QOXW53my8cPfHxbTxh58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627490497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igOio8fBSU54FZqogXK4id+AuMVfwQ0wCmqmPqyaiog=;
        b=d/+J/FItbj97AqLC2C7zL9AIuAN/Nw/ddBmgu7e+7U65LNjjwqMb+P4uE5sjN122Gnim9f
        rqJMi5NmA0UVffDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0975C13AD4;
        Wed, 28 Jul 2021 16:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u5ASMb+IAWE+CQAAMHmgww
        (envelope-from <mpdesouza@suse.de>); Wed, 28 Jul 2021 16:41:35 +0000
Message-ID: <40bf54d5d706b8fe265cd59f1babcfea0cb13d5a.camel@suse.de>
Subject: Re: [PATCH] btrfs: Introduce btrfs_search_backwards function
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     dsterba@suse.cz, Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Date:   Wed, 28 Jul 2021 13:41:30 -0300
In-Reply-To: <20210728131015.GF5047@twin.jikos.cz>
References: <20210726140317.4907-1-mpdesouza@suse.com>
         <20210728131015.GF5047@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2021-07-28 at 15:10 +0200, David Sterba wrote:
> On Mon, Jul 26, 2021 at 11:03:17AM -0300, Marcos Paulo de Souza
> wrote:
> > It's a common practice to start a search using offset (u64)-1,
> > which is
> > the u64 maximum value, meaning that we want the search_slot
> > function to
> > be set in the last item with the same objectid and type.
> > 
> > Once we are in this position, it's a matter to start a search
> > backwards
> > by calling btrfs_previous_item, which will check if we'll need to
> > go to
> > a previous leaf and other necessary checks, only to be sure that we
> > are
> > in last offset of the same object and type. If the item is found,
> > convert the ondisk structure to the current endianness of the
> > machine
> > running the code.
> > 
> > The new btrfs_search_backwards function does the all these
> > procedures when
> > necessary, and can be used to avoid code duplication.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  fs/btrfs/ctree.c   | 23 +++++++++++++++++++++++
> >  fs/btrfs/ctree.h   |  6 ++++++
> >  fs/btrfs/ioctl.c   | 30 ++++++++----------------------
> >  fs/btrfs/super.c   | 26 ++++++--------------------
> >  fs/btrfs/volumes.c |  7 +------
> >  5 files changed, 44 insertions(+), 48 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 394fec1d3fd9..2991ee845813 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -2100,6 +2100,29 @@ int btrfs_search_slot_for_read(struct
> > btrfs_root *root,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Execute search and call btrfs_previous_item to traverse
> > backwards if the item
> > + * was not found. If found, convert the stored item to the correct
> > endianness.
> > + *
> > + * Return 0 if found, 1 if not found and < 0 if error.
> > + */
> > +int btrfs_search_backwards(struct btrfs_root *root,
> > +				struct btrfs_key *key,
> > +				struct btrfs_key *found_key,
> 
> Is it necessary to have 2 keys? All calls pass the same one, so
> either
> this should be just one or you have other patches that make use of
> two
> distinct keys?

Yes, in these cases yes, but I can see sometimes other places in the
btrfs codebase where the key used convert to cpu is different from the
key used in the search path, so I wanted to make it flexible to future
users.

I believe that we can extent this in the future if needed, so
I'll send a v2 using only one key argument, and use the same argument
to convert to the correct endianness.

Thanks,
  Marcos

> 
> > -		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> > +		ret = btrfs_search_backwards(root, &key, &key, path);
> 
> 						   &key, &key

