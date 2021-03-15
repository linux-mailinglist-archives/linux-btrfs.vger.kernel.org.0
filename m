Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D7233C941
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 23:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhCOWUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 18:20:17 -0400
Received: from smtp26.services.sfr.fr ([93.17.128.197]:61327 "EHLO
        smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhCOWT4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 18:19:56 -0400
Received: from [192.168.1.11] (91-171-27-54.subs.proxad.net [91.171.27.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by msfrf2613.sfr.fr (SMTP Server) with ESMTPS id 61F651C001047;
        Mon, 15 Mar 2021 23:19:48 +0100 (CET)
X-mail-filterd: 1.0.0
X-sfr-mailing: LEGIT
X-sfr-spamrating: 40
X-sfr-spam: not-spam
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=neuf.fr; s=202006;
 t=1615846788; h=Subject:From:To:Cc:Date:In-Reply-To:References; bh=bx/RwsIhL
  lb7mOsewMj9gB70hjEoP18Wp0YUQRhHc7E=; b=mh66iT+/Knj0kco3Zxy0IDMxmO1KaV9xpby8T
  eEEZGkj8FqGOvJqc1YbYd+ZLcE74PFa1Y4IDsEXOJqkaOYDu0eyMz7iIE7C3MmTPvl/tjkhg1Ef+
  euZpRDqaf64i0K+tAcM8yEouGz6HnfXUHDiOte1vX9zLLa9areRAMTpDM8yBgQsJYrJQzku/J/Yo
  e5TErX2AtP0HZ35aqCYq49S4S7j4cfzwyKxuTzrR9Tc32hjtTVV2p9nwARnAzOFc+aNtnkqATWOE
  XcYXhhsGwGngIKDYFbMxWunWX6FFWoGgZ19f4On7M6j8QRzI/ZCHOI96YhTEIkEvFy6tWxOFkt6c
  Q==;
Received: from [192.168.1.11] (91-171-27-54.subs.proxad.net [91.171.27.54])
        by msfrf2613.sfr.fr (SMTP Server) with ESMTP id 3E80A1C001045;
        Mon, 15 Mar 2021 23:19:48 +0100 (CET)
Received: from [192.168.1.11] (91-171-27-54.subs.proxad.net [91.171.27.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pierre.labastie@neuf.fr)
        by msfrf2613.sfr.fr (SMTP Server) with ESMTPSA;
        Mon, 15 Mar 2021 23:19:48 +0100 (CET)
Authentication-Results: sfr.fr; auth=pass (LOGIN) smtp.auth=pierre.labastie@neuf.fr
Message-ID: <26cdac5a09c1f51f04bdea9ca59f1be9fdbb5406.camel@neuf.fr>
Subject: Re: [PATCH v2] btrfs-progs: build system: Fix the test for
 EXT4_EPOCH_MASK
From:   Pierre Labastie <pierre.labastie@neuf.fr>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Date:   Mon, 15 Mar 2021 23:19:47 +0100
In-Reply-To: <20210315145324.GU7604@twin.jikos.cz>
References: <d7b1445f25866bf5c8d5016b7cd7a94e68f67dd8.camel@neuf.fr>
         <20210314184913.5689-1-pierre.labastie@neuf.fr>
         <20210315145324.GU7604@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2021-03-15 at 15:53 +0100, David Sterba wrote:
> On Sun, Mar 14, 2021 at 07:49:13PM +0100, Pierre Labastie wrote:
> > After sending the first version of the patch, I realized that it
> > was flawed, because of some formatting by the MUA. It took me
> > some time to set up an MTA so that git send-email works. Now the
> > patch should apply cleanly. Please remove the present paragraph by using
> > git am -c. Apologies for the inconvenience(s).
> > -- >8 --
> > Commit b3df561fbf has introduced the ability to convert extended
> > inode time precision on ext4, but this breaks builds on older distros,
> > where ext4 does not have the nsec time precision.
> > 
> > Commit c615287cc tried to fix that by testing the availability of
> > the EXT4_EPOCH_MASK macro, but the test is not complete.
> > 
> > This patch aims at fixing the macro test, and changes the
> > name of the associated HAVE_ macro, since the logic is reverted.
> > 
> > This fixes #353 when ext4 has nsec time precision. Note that
> > the test fails when ext4 does not have the nsec time precision.
> > Maybe the test shouldn't be run in that case?
> > 
> > Issue: #353
> > Signed-off-by: Pierre Labastie <pierre.labastie@neuf.fr>
> > ---
> >  configure.ac          | 8 ++++----
> >  convert/source-ext2.c | 6 +++---
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index 612a3f87..dd6a5de7 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -251,10 +251,10 @@ else
> >  AC_DEFINE([HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE], [0], [We did not define
> > FIEMAP_EXTENT_SHARED])
> >  fi
> >  
> > -HAVE_OWN_EXT4_EPOCH_MASK_DEFINE=0
> > -AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK], [],
> > -               [HAVE_OWN_EXT4_EPOCH_MASK_DEFINE=1
> > -                AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found,
> > probably old e2fsprogs, will use own definition, no 64bit time precision of
> > converted images])])
> > +AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK],
> > +                [AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1],
> > +                   [Define to 1 if e2fsprogs defines EXT4_EPOCH_MASK])],
> > +               [AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found,
> > probably old e2fsprogs, will use own definition, no 64bit time precision of
> > converted images])])
> 
> Inlining the AC_DEFINE to the check will skip defining the macro in case
> the EXT4_EPOCH_MASK does not exist and then the C #if won't work.
> 
>         HAVE_EXT4_EPOCH_MASK_DEFINE=0
>         AX_CHECK_DEFINE(...
>                 HAVE_EXT4_EPOCH_MASK_DEFINE=1,...)
> 
>         if x"$HAVE_EXT4_EPOCH_MASK_DEFINE"; then
>                 AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1])
>         else
>                 AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [0])
>         fi

Since autoheader is used, and autoheader uses AC_DEFINE macros to generate
config.h.in, there is a risk that having two AC_DEFINE macros for the same 
identifier generates a conflict. I've not been able to find what it does in
that case in the autoconf doc.

OTOH, an undefined identifier is replaced by a zero when expanding a #if in the
C preprocessor (this is in all the norms I have access to: C89 and C99), that
is:

#if UNDEFINED_IDENTIFIER
is equivalent to
#if 0

Except if a compiler does not respect the norm, what I have proposed works (I
have only tested with gcc, and it does what it is supposed to do).

> 
> This should work, maybe it's not the shortest way to write that but I
> can't find anything better.

Now, I've tested your version, and it works too. So, up to you...

Pierre

