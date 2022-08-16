Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4EF595C20
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiHPMpn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiHPMou (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 08:44:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618704A133
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 05:44:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 07A5937272;
        Tue, 16 Aug 2022 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660653846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6CXm5eoxAdW3xwg2SUtwr+ojIgrt/8BuO0s4X+Mrd0=;
        b=kc9uDTpO7Jbcv0noURDEEyFlueLkK15dzp/YsMLGqxkUuih3XHQDDRvh864SHM9GwuT3/w
        OmEWt4d3z/JH7OQBGo3sJNpVJLiGXKSxlf2uUv/seLNxZMlLp2ilj3280NEeBQBs19EMrs
        j2ftecXYPwiYQYDbEKvuYFuiEH1lQ8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660653846;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6CXm5eoxAdW3xwg2SUtwr+ojIgrt/8BuO0s4X+Mrd0=;
        b=/5wAp9VtGJez22Pj8jCW21feaFBNswsH8eIhBVVFFKVtfWYxwWYeP0jrBarkdj53OWOp3r
        8+A2FcEtiEiRMOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAAE21345B;
        Tue, 16 Aug 2022 12:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i+wvIRWR+2K+VAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 16 Aug 2022 12:44:05 +0000
Date:   Tue, 16 Aug 2022 07:44:03 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] Check if root is readonly while setting xattr
Message-ID: <20220816124403.ga3mwodttpsbbtm7@fiona>
References: <20220815193402.7fmuwafu3qpalniz@fiona>
 <CAL3q7H4LQ0THXa-1bAa3knvJEKeOHYeLKn8ZMZ669ccTebcj6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4LQ0THXa-1bAa3knvJEKeOHYeLKn8ZMZ669ccTebcj6w@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  9:34 16/08, Filipe Manana wrote:
> On Tue, Aug 16, 2022 at 1:40 AM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> >
> > For a filesystem which has btrfs read-only property set to true, all
> > write operations including xattr should be denied. However, security
> > xattr can still be changed even if btrfs ro property is true.
> 
> Why does that happen only for security xattrs, and not  for xattrs in
> the user.* and btrfs.* namespaces?

xattr_permission() skips checks for security.* and system.*
I will mention it in the next changelog.

> 
> >
> > This patch checks if the root is read-only before performing the set
> > xattr operation.
> >
> > Testcase:
> >
> > #!/bin/bash
> >
> > DEV=/dev/vdb
> > MNT=/mnt
> >
> > mkfs.btrfs -f $DEV
> > mount $DEV $MNT
> > echo "file one" > $MNT/f1
> > setfattr -n "security.one" -v 2 $MNT/f1
> > btrfs property set $MNT ro true
> >
> > # Following statement should fail
> > setfattr -n "security.one" -v 1 $MNT/f1
> >
> > umount $MNT
> 
> A test case only in a changelog isn't super useful to prevent future
> regressions :)
> 
> Can you send a test case for fstests, that also tests user.* and
> btrfs.* namespaces, and creating and deleting xattrs too?

I am merely trying to demonstrate the issue.
I didn't think this warrants a testcase, but if you think so: sure.
However, this case is limited to system.* and security.* tests.

> 
> >
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> >
> > diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> > index 7421abcf325a..5bb8d8c86311 100644
> > --- a/fs/btrfs/xattr.c
> > +++ b/fs/btrfs/xattr.c
> > @@ -371,6 +371,9 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
> >                                    const char *name, const void *buffer,
> >                                    size_t size, int flags)
> >  {
> > +       if (btrfs_root_readonly(BTRFS_I(inode)->root))
> > +               return -EROFS;
> > +
> 
> The same type of check should be done at btrfs_xattr_handler_set_prop() as well.
> Even though trying the same test on a btrfs.compression xattr fails with -EROFS.
> 
> I'm still curious why trying the same on a user.* xattr happens to
> fail with -EROFS,
> but not for a secutiry.* xattr, since both have
> btrfs_xattr_handler_set() as their entry point.
> 
> I think this should be detailed in the changelog, and presume you
> verified why that happens.

See response above.


-- 
Goldwyn
