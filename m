Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1361F46F2CA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 19:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbhLISLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 13:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbhLISLj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 13:11:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA6EC061746
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Dec 2021 10:08:05 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n8so4487590plf.4
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Dec 2021 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pE5zMUDjjkrq1kttAXZYbh4uJ8zMkW83Aa6DS95Ku3k=;
        b=eLb/75QmyA0sR4GpXqw/M/CZ1s91kc9drM/PHmWkfeG34dkG2jHD8XEa4z9m7ewV3E
         hDjT9y7DxR71uC9feKqvqOG/UBTlqYnkv46GIzqKAT26hL3xZKaFI0D17rkzwXK3MTI0
         q46RTVxIB2WEIUrjA7ae7qESZASVGt2Q4ts7DrcnQWu6tWgfjdkISXcFUfKWp/4Folra
         zGSnRhHbrGzBfy0VyG+wT2UkXVGZUXmi394HwPA63y6Hgfw9wPWhPB1eDEYFe8HKsBxU
         DzBQt1ZmfSnQzilI8nyWoQn/n/hpFZVsMBsFl+fi7g6YFWi+vzzrsCamg+7ZzOf/L/g0
         geXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pE5zMUDjjkrq1kttAXZYbh4uJ8zMkW83Aa6DS95Ku3k=;
        b=hNKvL4vut3HPE7/wBmgZ0bHqiJeiPSF7V53nPL5dsjO0AsusTGF/IjO5rGqa4iQcx5
         Dpeyj/hX0Vd5/2nuFxZakjNVJlppeDhUeBmlGjjscMhB1MGvoagglj7feXSug+qY2Dv5
         LreNhBH6Ss+oJTMxMso8iwSsH4DNAz3R7tHIxgbhIiQqJBErgUkFYlDoqu6UEQSpf4Mn
         LsOxTgSjs8+i3843Yntd/WVMBWarGoVEl4G7muRj9i7nMPpyYBEVP1GhcPZgamEwzTn/
         FNARDxHs+WUda5HP26QdYPeNbucFUy6pMOIMlqkW7xqZFQAL39oTP2uSYyNMD6CcNwSl
         2D7A==
X-Gm-Message-State: AOAM533X83B0o9iFD3M6N9YRNGGJ/oK1Bz0bfkzNqUqCYTre5KEgS8B3
        CC+J9DOJO/VB+Uw/RZISGfZlUQ==
X-Google-Smtp-Source: ABdhPJzrWa0ES2DlmybxY+dqRGTvrju0zraQgZgokCHY98Mi0YIReWgwZppicJUrJQJVza7iw7Ub6A==
X-Received: by 2002:a17:902:e0d4:b0:142:8897:94e2 with SMTP id e20-20020a170902e0d400b00142889794e2mr69189453pla.58.1639073284789;
        Thu, 09 Dec 2021 10:08:04 -0800 (PST)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::547e])
        by smtp.gmail.com with ESMTPSA id w1sm382785pfg.11.2021.12.09.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 10:08:04 -0800 (PST)
Date:   Thu, 9 Dec 2021 10:08:02 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 12/17] btrfs: send: fix maximum command numbering
Message-ID: <YbJGAtRjYAinr4Ak@relinquished.localdomain>
References: <cover.1637179348.git.osandov@fb.com>
 <bc324fbf99e8a792719da7bb96f5dcf4964904de.1637179348.git.osandov@fb.com>
 <20211118142359.GE28560@twin.jikos.cz>
 <YZahWPMfY5CLXTa6@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZahWPMfY5CLXTa6@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 18, 2021 at 10:54:16AM -0800, Omar Sandoval wrote:
> On Thu, Nov 18, 2021 at 03:23:59PM +0100, David Sterba wrote:
> > On Wed, Nov 17, 2021 at 12:19:22PM -0800, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > Commit e77fbf990316 ("btrfs: send: prepare for v2 protocol") added
> > > _BTRFS_SEND_C_MAX_V* macros equal to the maximum command number for the
> > > version plus 1, but as written this creates gaps in the number space.
> > > The maximum command number is currently 22, and __BTRFS_SEND_C_MAX_V1 is
> > > accordingly 23. But then __BTRFS_SEND_C_MAX_V2 is 24, suggesting that v2
> > > has a command numbered 23, and __BTRFS_SEND_C_MAX is 25, suggesting that
> > > 23 and 24 are valid commands.
> > 
> > The MAX definitions have the __ prefix so they're private and not meant
> > to be used as proper commands, so nothing should suggest there are any
> > commands with numbers 23 to 25 in the example.
> > 
> > > Instead, let's explicitly set BTRFS_SEND_C_MAX_V* to the maximum command
> > > number. This requires repeating the command name, but it has a clearer
> > > meaning and avoids gaps. It also doesn't require updating
> > > __BTRFS_SEND_C_MAX for every new version.
> > 
> > It's probably a matter of taste, I'd intentionally avoid the pattern
> > above, ie. repeating the previous command to define max.
> > 
> > > --- a/fs/btrfs/send.c
> > > +++ b/fs/btrfs/send.c
> > > @@ -316,8 +316,8 @@ __maybe_unused
> > >  static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
> > >  {
> > >  	switch (sctx->proto) {
> > > -	case 1:	 return cmd < __BTRFS_SEND_C_MAX_V1;
> > > -	case 2:	 return cmd < __BTRFS_SEND_C_MAX_V2;
> > > +	case 1:	 return cmd <= BTRFS_SEND_C_MAX_V1;
> > > +	case 2:	 return cmd <= BTRFS_SEND_C_MAX_V2;
> > 
> > This seems to be the only practical difference, < or <= .
> 
> There is another practical difference, which is more significant in my
> opinion: the linear style creates "gaps" in the valid commands. Consider
> this, with explicit values added for clarity:
> 
> enum btrfs_send_cmd {
>         BTRFS_SEND_C_UNSPEC = 0,
> 
>         /* Version 1 */
>         BTRFS_SEND_C_SUBVOL = 1,
>         BTRFS_SEND_C_SNAPSHOT = 2,
> 
>         BTRFS_SEND_C_MKFILE = 3,
>         BTRFS_SEND_C_MKDIR = 4,
>         BTRFS_SEND_C_MKNOD = 5,
>         BTRFS_SEND_C_MKFIFO = 6,
>         BTRFS_SEND_C_MKSOCK = 7,
>         BTRFS_SEND_C_SYMLINK = 8,
> 
>         BTRFS_SEND_C_RENAME = 9,
>         BTRFS_SEND_C_LINK = 10,
>         BTRFS_SEND_C_UNLINK = 11,
>         BTRFS_SEND_C_RMDIR = 12,
> 
>         BTRFS_SEND_C_SET_XATTR = 13,
>         BTRFS_SEND_C_REMOVE_XATTR = 14,
> 
>         BTRFS_SEND_C_WRITE = 15,
>         BTRFS_SEND_C_CLONE = 16,
> 
>         BTRFS_SEND_C_TRUNCATE = 17,
>         BTRFS_SEND_C_CHMOD = 18,
>         BTRFS_SEND_C_CHOWN = 19,
>         BTRFS_SEND_C_UTIMES = 20,
> 
>         BTRFS_SEND_C_END = 21,
>         BTRFS_SEND_C_UPDATE_EXTENT = 22,
>         __BTRFS_SEND_C_MAX_V1 = 23,
> 
>         /* Version 2 */
>         BTRFS_SEND_C_FALLOCATE = 24,
>         BTRFS_SEND_C_SETFLAGS = 25,
>         BTRFS_SEND_C_ENCODED_WRITE = 26,
>         __BTRFS_SEND_C_MAX_V2 = 27,
> 
>         /* End */
>         __BTRFS_SEND_C_MAX = 28,
> };
> #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1) /* 27 */
> 
> Notice that BTRFS_SEND_C_UPDATE_EXTENT is 22 and the next valid command
> is BTRFS_SEND_C_FALLOCATE, which is 24. So 23 does not correspond to an
> actual command; it's a "gap". This is somewhat cosmetic, but it's an
> ugly wart in the protocol.
> 
> Also consider something indexing on the command number, like the
> cmd_send_size thing I got rid of in the previous patch:
> 
> 	u64 cmd_send_size[BTRFS_SEND_C_MAX + 1]
> 
> Indices 23 and 27 are wasted. It's only 16 bytes in this case, which
> doesn't matter practically, but it's unpleasant.
> 
> Maybe you were aware of this and fine with it, in which case we can drop
> this change. But I think the name repetition is less ugly than the gaps.

Ping. Please let me know how you'd like me to proceed on this issue and
my other replies. Thanks!
