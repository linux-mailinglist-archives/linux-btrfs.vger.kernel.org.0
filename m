Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A139F59EB92
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 20:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiHWSzN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiHWSyw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 14:54:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C736F56A
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 10:20:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5B9B31F8CD;
        Tue, 23 Aug 2022 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661275248;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FL4A9A0O/vgVnjrDOPfbj0FxvKoMXhTWqlK63PkcOaI=;
        b=i+HFKW8OZs53ViQ+XZEwEZaZMX6ZCOU+3ESRgytHPrVuHmTLmf0m43UUcxXPsEeVLY/7sO
        DEhpw2/yPS+eO1hsMx/W3AcMY8jpRqtasKAydbPpXhkviL5SAnEtY3lbDAM4bVtWJRmGGY
        XFhXhGKk+q5gugFmaCFWVjd4ijxxwo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661275248;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FL4A9A0O/vgVnjrDOPfbj0FxvKoMXhTWqlK63PkcOaI=;
        b=4Bp3gMYxi03vlt8VJT1DPFHptPRENlFpXb+pYO3EoUxbODUAST6DoDSaoGzDFcMptNZZ7T
        Pm+GItAMd4IU/hDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E81C13A89;
        Tue, 23 Aug 2022 17:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M5VbCnAMBWOrSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 17:20:48 +0000
Date:   Tue, 23 Aug 2022 19:15:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: fix silent failure when deleting root
 reference
Message-ID: <20220823171534.GH13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1661179270.git.fdmanana@suse.com>
 <f070919ec910b3682dd22742151a60f9e4c95cbf.1661179270.git.fdmanana@suse.com>
 <54b0975b-dd84-7ce1-07bd-4e2839735cbd@gmx.com>
 <CAL3q7H7wkPA_XqGOWBEmKgfZK7LN_0sFjTZKdB8u4Gi9dmU3Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7wkPA_XqGOWBEmKgfZK7LN_0sFjTZKdB8u4Gi9dmU3Kw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 23, 2022 at 09:11:55AM +0100, Filipe Manana wrote:
> On Tue, Aug 23, 2022 at 12:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > ---
> > >   fs/btrfs/root-tree.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > > index a64b26b16904..d647cb2938c0 100644
> > > --- a/fs/btrfs/root-tree.c
> > > +++ b/fs/btrfs/root-tree.c
> > > @@ -349,9 +349,10 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
> > >       key.offset = ref_id;
> > >   again:
> > >       ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
> > > -     if (ret < 0)
> > > +     if (ret < 0) {
> > > +             err = ret;
> > >               goto out;
> > > -     if (ret == 0) {
> >
> > Just a small nitpick here, since above if (ret < 0) branch will call
> > "goto out", we don't need the "else" branch.
> > The old "if (ret == 0) {" should be good enough.
> 
> Yes, it's not about correctness. It's just my preferred style.
> I find it more intuitive to have a single if-else that tests the same
> variable instead
> of having it tested by two distinct if statements.

Agreed with that style.
