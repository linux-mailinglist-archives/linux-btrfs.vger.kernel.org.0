Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04258CB8B6
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 12:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJDK4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 06:56:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfJDK4b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Oct 2019 06:56:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC4DCABC6;
        Fri,  4 Oct 2019 10:56:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09192DA7D7; Fri,  4 Oct 2019 12:56:45 +0200 (CEST)
Date:   Fri, 4 Oct 2019 12:56:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: add __cold attribute to more functions
Message-ID: <20191004105644.GW2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1569587835.git.dsterba@suse.com>
 <244616cd0a823e44fcca051a569ff68e0c7dc29e.1569587835.git.dsterba@suse.com>
 <cc58a307-c3af-f2e1-b309-016c5bed5088@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc58a307-c3af-f2e1-b309-016c5bed5088@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 01:52:16PM +0300, Nikolay Borisov wrote:
> On 1.10.19 г. 20:57 ч., David Sterba wrote:
> > The attribute can mark functions supposed to be called rarely if at all
> > and the text can be moved to sections far from the other code. The
> > attribute has been added to several functions already, this patch is
> > based on hints given by gcc -Wsuggest-attribute=cold.
> > 
> > The net effect of this patch is decrease of btrfs.ko by 1000-1300,
> > depending on the config options.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/disk-io.c | 4 ++--
> >  fs/btrfs/disk-io.h | 4 ++--
> >  fs/btrfs/super.c   | 2 +-
> >  fs/btrfs/volumes.c | 2 +-
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index e335fa4c4d1d..04d86e11117b 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2583,7 +2583,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
> >  	return ret;
> >  }
> >  
> > -int open_ctree(struct super_block *sb,
> > +int __cold open_ctree(struct super_block *sb,
> 
> According to the documentation
> (https://gcc.gnu.org/onlinedocs/gcc/Function-Attributes.html) of gcc
> attributes are placed in the declaration of a function (3rd paragraph):
> 
> 
> "Function attributes are introduced by the __attribute__ keyword in the
> declaration of a function, ..."

I'd rather keep the attributes to declaration and definition so it's in
sync and looks consistent without further questions.

> > +void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
> >  {
> 
> Is printk really cold though? It's used in the various print helpers,
> even for info level print which might not be rare once the fs is
> mounted? What's a possible negative effect of this size optimisation -
> runtime cost?

Messages are printed rarely under normal circumstances, ie. a message
once in a few minutes maybe. The penalty of loading the code into caches
is IMO justified here, there's not much chance of reusing the cache hot
code. And that it also involves all other helpers is kind of
intentional.

A very frequent pattern:

	x = find_some_structure();
	if (!x) {
		btrfs_err("there is a problem");
		ret = -EUCLEAN;
		goto out_error;
	}

In this case the cold attribute is another hint to the compiler that the
whole code block following the 'if' is cold and can be rearranged out of
the way.

If you have counter examples for printk-related functions that are on a
hot path in btrfs, I'd like to hear about them. To move them out of the
that hot path :)
