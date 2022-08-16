Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C1595CBE
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiHPNEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 09:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiHPNET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 09:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAD07D7B6
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 06:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50DFF61367
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 13:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB27DC433D6
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660655034;
        bh=2f7Z0TwqL2R9UAGKkbuPLl1cVFxnp8ku/jI6P0fPFZc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Af1j32yaWBS17yWsf1PfU5cxY9XV59tnbjosahoChIOBUG5s4JB5iQ2efNYAr8kfZ
         N2z2VMP5EadtgQF1nXCZfQM/3pd+7KKe2uYWNDPJLA1XxBUNy/CJhAHD5RFcYOO6Fj
         NyEeZC1FIDtCdjxrlyp50a5yufwMEmXDOw9gIAO+sc73WQvH+W2QovDHToFe1CiCLA
         x8zKM/3ylPOypyafdEWFvNogHN2IT8ZBTByNShDLGi5IkggAIYVVrwfyVaX6t6767P
         ZBGCULjlon1Ln54xhy1LtrBBLHXVmTuLkHHpg7Ykni7bZugVB7+05eQ21ib+9ZWydv
         JNbLOBOrzBKjg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-10ec41637b3so11521468fac.4
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 06:03:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo0KvI1fTfpXbZCDux0z2baRZ503sy0xp6XKrYTmoT912euv+pfU
        q1pPnVFdB/MYj5m9FW+zmju3fjBV5KJ5ycPfNoM=
X-Google-Smtp-Source: AA6agR6j7W2iwPnNrYwFrLVPpt2SU4sQC6rgRRozKktUNwZLW9Ka3W6WgtBzXKfFOnK7biWfBAex9KYZ6AN4Vr8GnLc=
X-Received: by 2002:a05:6870:42cb:b0:10f:530:308 with SMTP id
 z11-20020a05687042cb00b0010f05300308mr9328249oah.294.1660655033758; Tue, 16
 Aug 2022 06:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220815193402.7fmuwafu3qpalniz@fiona> <CAL3q7H4LQ0THXa-1bAa3knvJEKeOHYeLKn8ZMZ669ccTebcj6w@mail.gmail.com>
 <20220816124403.ga3mwodttpsbbtm7@fiona>
In-Reply-To: <20220816124403.ga3mwodttpsbbtm7@fiona>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 16 Aug 2022 14:03:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5TR=ONwiqfZCe7g1zjMj-qYbc6YNfemSxB9WqXM3BUJw@mail.gmail.com>
Message-ID: <CAL3q7H5TR=ONwiqfZCe7g1zjMj-qYbc6YNfemSxB9WqXM3BUJw@mail.gmail.com>
Subject: Re: [PATCH] Check if root is readonly while setting xattr
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 16, 2022 at 1:44 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> On  9:34 16/08, Filipe Manana wrote:
> > On Tue, Aug 16, 2022 at 1:40 AM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> > >
> > > For a filesystem which has btrfs read-only property set to true, all
> > > write operations including xattr should be denied. However, security
> > > xattr can still be changed even if btrfs ro property is true.
> >
> > Why does that happen only for security xattrs, and not  for xattrs in
> > the user.* and btrfs.* namespaces?
>
> xattr_permission() skips checks for security.* and system.*
> I will mention it in the next changelog.

Great.
Also, the subject should have a prefix: "btrfs: check if root..."

>
> >
> > >
> > > This patch checks if the root is read-only before performing the set
> > > xattr operation.
> > >
> > > Testcase:
> > >
> > > #!/bin/bash
> > >
> > > DEV=/dev/vdb
> > > MNT=/mnt
> > >
> > > mkfs.btrfs -f $DEV
> > > mount $DEV $MNT
> > > echo "file one" > $MNT/f1
> > > setfattr -n "security.one" -v 2 $MNT/f1
> > > btrfs property set $MNT ro true
> > >
> > > # Following statement should fail
> > > setfattr -n "security.one" -v 1 $MNT/f1
> > >
> > > umount $MNT
> >
> > A test case only in a changelog isn't super useful to prevent future
> > regressions :)
> >
> > Can you send a test case for fstests, that also tests user.* and
> > btrfs.* namespaces, and creating and deleting xattrs too?
>
> I am merely trying to demonstrate the issue.
> I didn't think this warrants a testcase, but if you think so: sure.

Any bug should have a test case (if possible).
I don't expect anyone to keep running this test manually every now and
then to verify if we have a regression :)

> However, this case is limited to system.* and security.* tests.

That doesn't mean we should not have a test case that tests all xattr namespaces
and all xattrs operations (insert, update, delete).

Thanks.

>
> >
> > >
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > >
> > >
> > > diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> > > index 7421abcf325a..5bb8d8c86311 100644
> > > --- a/fs/btrfs/xattr.c
> > > +++ b/fs/btrfs/xattr.c
> > > @@ -371,6 +371,9 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
> > >                                    const char *name, const void *buffer,
> > >                                    size_t size, int flags)
> > >  {
> > > +       if (btrfs_root_readonly(BTRFS_I(inode)->root))
> > > +               return -EROFS;
> > > +
> >
> > The same type of check should be done at btrfs_xattr_handler_set_prop() as well.
> > Even though trying the same test on a btrfs.compression xattr fails with -EROFS.
> >
> > I'm still curious why trying the same on a user.* xattr happens to
> > fail with -EROFS,
> > but not for a secutiry.* xattr, since both have
> > btrfs_xattr_handler_set() as their entry point.
> >
> > I think this should be detailed in the changelog, and presume you
> > verified why that happens.
>
> See response above.
>
>
> --
> Goldwyn
