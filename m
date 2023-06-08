Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95150728017
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjFHMdP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjFHMdL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:33:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1C42D66
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 05:33:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB50F1FDCC;
        Thu,  8 Jun 2023 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686227585;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4JtZ/emWfYUGn4x0F2n74f2LwBaXFVxCBXrMEbkUsw=;
        b=RE5BMCw4aHlwQSsT9Q4Q6f3v86dp4Sm9W1ud93AngcCXccQTh1jI45IMmlACwyS4iP4mSk
        90jN0+x7Jw6UBl1owIU9kEiTz0XcGbNpkmH9foA+PYuF2QNi2PkBzGiYsg7MIqewLYJaCb
        Sd5XiKSlCZtktmm9d4gvqhmoDo+zHWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686227585;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4JtZ/emWfYUGn4x0F2n74f2LwBaXFVxCBXrMEbkUsw=;
        b=Uu4z4reePO8YXeeWPXbKFxkyBRKMuRh+Pd4cfthIhtcHEbzUqU0kEm69qY1AG2Et9QCRca
        tLtieT84WMltEfAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BABC8138E6;
        Thu,  8 Jun 2023 12:33:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a2PdLIHKgWRAQwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Jun 2023 12:33:05 +0000
Date:   Thu, 8 Jun 2023 14:26:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/13] btrfs: abort transaction at balance_level() when
 left child is missing
Message-ID: <20230608122649.GE28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1686164789.git.fdmanana@suse.com>
 <91e588216500d2aaa7e119e5ac4be927c71bf066.1686164817.git.fdmanana@suse.com>
 <f90ee8a8-65f0-b96b-296c-1720cd9acfe6@gmx.com>
 <CAL3q7H7astYWHBX2pWL2PqPmSsOArbNMb_CYXfzoXz2L3rKf-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7astYWHBX2pWL2PqPmSsOArbNMb_CYXfzoXz2L3rKf-w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 08, 2023 at 10:47:49AM +0100, Filipe Manana wrote:
> On Thu, Jun 8, 2023 at 9:58 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2023/6/8 03:24, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > At balance_level() we are calling btrfs_handle_fs_error() when the middle
> > > child only has 1 item and the left child is missing, however we can simply
> > > use btrfs_abort_transaction(), which achieves the same purposes: to turn
> > > the fs to error state, abort the current transaction and turn the fs to
> > > RO mode. Besides that, btrfs_abort_transaction() also prints a stack trace
> > > which makes it more useful.
> > >
> > > Also, as this is an highly unexpected case and it's about a b+tree
> > > inconsistency, change the error code from -EROFS to -EUCLEAN and tag the
> > > if branch as 'unlikely'.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >   fs/btrfs/ctree.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > > index 4dcdcf25c3fe..e2943047b01d 100644
> > > --- a/fs/btrfs/ctree.c
> > > +++ b/fs/btrfs/ctree.c
> > > @@ -1164,9 +1164,9 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
> > >                * otherwise we would have pulled some pointers from the
> > >                * right
> > >                */
> > > -             if (!left) {
> > > -                     ret = -EROFS;
> > > -                     btrfs_handle_fs_error(fs_info, ret, NULL);
> > > +             if (unlikely(!left)) {
> > > +                     ret = -EUCLEAN;
> >
> > I'd prefer to have an message every time we return -EUCLEAN.
> 
> Sure... I didn't see a strong need for that because the transaction
> abort's stack
> trace will be obvious. But I can add it in v2.

The error messages are a nice to have description of what happened, it
would be logged and may help to recognize the problem without reading
the stack trace or source. Also the message itself can print the values
for the failed conditions so this can give some clue as well.
