Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561BA1CDAD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 15:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgEKNLU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 09:11:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:49244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgEKNLU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 09:11:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 92431AC12;
        Mon, 11 May 2020 13:11:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 71F7BDA823; Mon, 11 May 2020 15:10:28 +0200 (CEST)
Date:   Mon, 11 May 2020 15:10:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 19/19] btrfs: update documentation of set/get helpers
Message-ID: <20200511131028.GQ18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1588853772.git.dsterba@suse.com>
 <86176aac59bae7968d271be7477fe8e36becc9fc.1588853772.git.dsterba@suse.com>
 <1cb28f67-1d0f-fe8d-af78-f0ebd3213172@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cb28f67-1d0f-fe8d-af78-f0ebd3213172@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 08, 2020 at 12:33:08AM +0300, Nikolay Borisov wrote:
> On 7.05.20 г. 23:20 ч., David Sterba wrote:
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/struct-funcs.c | 29 ++++++++++++++++-------------
> >  1 file changed, 16 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
> > index 225ef6d7e949..1021b80f70db 100644
> > --- a/fs/btrfs/struct-funcs.c
> > +++ b/fs/btrfs/struct-funcs.c
> > @@ -39,23 +39,26 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
> >  }
> >  
> >  /*
> > - * this is some deeply nasty code.
> > + * Macro templates that define helpers to read/write extent buffer data of a
> > + * given size, that are also used via ctree.h for access to item members via
> > + * specialized helpers.
> >   *
> > - * The end result is that anyone who #includes ctree.h gets a
> > - * declaration for the btrfs_set_foo functions and btrfs_foo functions,
> > - * which are wrappers of btrfs_set_token_#bits functions and
> > - * btrfs_get_token_#bits functions, which are defined in this file.
> > + * Generic helpers:
> > + * - btrfs_set_8 (for 8/16/32/64)
> > + * - btrfs_get_8 (for 8/16/32/64)
> >   *
> > - * These setget functions do all the extent_buffer related mapping
> > - * required to efficiently read and write specific fields in the extent
> > - * buffers.  Every pointer to metadata items in btrfs is really just
> > - * an unsigned long offset into the extent buffer which has been
> > - * cast to a specific type.  This gives us all the gcc type checking.
> > + * Generic helpes with a token, caching last page address:
> 
> nit: missing 'r' in 'helpers'. Without having looked into the code It's
> not obvious what a "token" is in this context, is it worth it perhaps
> documenting? ( I will take a look later and see if it's self-evident).

I could write it as

"Generic helpers with a token (a structure caching the address of most
recently accessed page)"

The use of 'last' is confusing as it's not the last as in the array.

> > + * - btrfs_set_token_8 (for 8/16/32/64)
> > + * - btrfs_get_token_8 (for 8/16/32/64)
> >   *
> > - * The extent buffer api is used to do the page spanning work required to
> > - * have a metadata blocksize different from the page size.
> > + * The set/get functions handle data spanning two pages transparently, in case
> > + * metadata block size is larger than page.  Every pointer to metadata items is
>        ^^^^^
> nit: s/metadata/btree/?

The terms should be interchangeable, but in the previous sentence it's 'metadata'
and this one continues, so I wonder how would 'btree' fit here.

All the structures here are on the higher level, so metadata etc, while
b-tree node is the storage.

> > + * an offset into the extent buffer page array, cast to a specific type.  This
> > + * gives us all the type checking.
> >   *
> > - * There are 2 variants defined, one with a token pointer and one without.
> > + * The extent buffer pages stored in the array pages do not form a contiguous
> > + * range, but the API functions assume the linear offset to the range from
> 
> nit: "contiguous physical range"

Ok.

> > + * 0 to metadata node size.
> >   */
> >  
> >  #define DEFINE_BTRFS_SETGET_BITS(bits)					\
> > 
