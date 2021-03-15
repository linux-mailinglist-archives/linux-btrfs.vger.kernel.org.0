Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DF33C9D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 00:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhCOXUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 19:20:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:43822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhCOXUZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 19:20:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07CE9AC1D;
        Mon, 15 Mar 2021 23:20:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0DFEDA6E2; Tue, 16 Mar 2021 00:18:22 +0100 (CET)
Date:   Tue, 16 Mar 2021 00:18:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Pierre Labastie <pierre.labastie@neuf.fr>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: build system: Fix the test for
 EXT4_EPOCH_MASK
Message-ID: <20210315231822.GC7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Pierre Labastie <pierre.labastie@neuf.fr>,
        linux-btrfs@vger.kernel.org
References: <d7b1445f25866bf5c8d5016b7cd7a94e68f67dd8.camel@neuf.fr>
 <20210314184913.5689-1-pierre.labastie@neuf.fr>
 <20210315145324.GU7604@twin.jikos.cz>
 <26cdac5a09c1f51f04bdea9ca59f1be9fdbb5406.camel@neuf.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26cdac5a09c1f51f04bdea9ca59f1be9fdbb5406.camel@neuf.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 15, 2021 at 11:19:47PM +0100, Pierre Labastie wrote:
> On Mon, 2021-03-15 at 15:53 +0100, David Sterba wrote:
> > On Sun, Mar 14, 2021 at 07:49:13PM +0100, Pierre Labastie wrote:
> > > +AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK],
> > > +                [AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1],
> > > +                   [Define to 1 if e2fsprogs defines EXT4_EPOCH_MASK])],
> > > +               [AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found,
> > > probably old e2fsprogs, will use own definition, no 64bit time precision of
> > > converted images])])
> > 
> > Inlining the AC_DEFINE to the check will skip defining the macro in case
> > the EXT4_EPOCH_MASK does not exist and then the C #if won't work.
> > 
> >         HAVE_EXT4_EPOCH_MASK_DEFINE=0
> >         AX_CHECK_DEFINE(...
> >                 HAVE_EXT4_EPOCH_MASK_DEFINE=1,...)
> > 
> >         if x"$HAVE_EXT4_EPOCH_MASK_DEFINE"; then
> >                 AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1])
> >         else
> >                 AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [0])
> >         fi
> 
> Since autoheader is used, and autoheader uses AC_DEFINE macros to generate
> config.h.in, there is a risk that having two AC_DEFINE macros for the same 
> identifier generates a conflict. I've not been able to find what it does in
> that case in the autoconf doc.
> 
> OTOH, an undefined identifier is replaced by a zero when expanding a #if in the
> C preprocessor (this is in all the norms I have access to: C89 and C99), that
> is:
> 
> #if UNDEFINED_IDENTIFIER
> is equivalent to
> #if 0
> 
> Except if a compiler does not respect the norm, what I have proposed works (I
> have only tested with gcc, and it does what it is supposed to do).

I'll change it back to what you did as it sounds safer. The "#if
undefined" works for all compilers we currently care about (gcc, clang)
and would avoid potential problems with autoheader.

> > This should work, maybe it's not the shortest way to write that but I
> > can't find anything better.
> 
> Now, I've tested your version, and it works too. So, up to you...

I take yours, thanks. Feel free to send a fix to AC_DEFINE of
HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE that does the double definition.
There were no problems reported so far but for consistency it would be
better to unify them.
