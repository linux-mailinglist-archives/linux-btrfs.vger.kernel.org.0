Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F7154F8C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiFQOAW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiFQOAV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 10:00:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5024926B
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 07:00:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9282621B01;
        Fri, 17 Jun 2022 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655474419;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZCcCm+3Ua08WIIhmOGldCwDdUjujTGkB3ikCwMa65Vo=;
        b=NMWIglmnS5pDLT3tpgrKW1P5te/mbDRCx2TgJbIlbldgXkztDyC9HZ6x+JSWjlAoGewQyB
        Hb2BgTK+07WWVMlWyGp0q10kfzeEGgSocZBho6M3+QwSRBq0VC7jRwwukP9XlklqDgzCsb
        UDTmjjfhDxOIGmvQDaxdwWBhRaW3ot4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655474419;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZCcCm+3Ua08WIIhmOGldCwDdUjujTGkB3ikCwMa65Vo=;
        b=E/3A3dcK7nebN7OrT8cOoNe8DcTIb4OcOBtJKg4YrR9u6rkkeD9np+XU3jdv+FTqzMLrl4
        ySaAGC04en/zxwCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 651EF13458;
        Fri, 17 Jun 2022 14:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XP+xF/OIrGLFIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 17 Jun 2022 14:00:19 +0000
Date:   Fri, 17 Jun 2022 15:55:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/9] btrfs: add fast path for extent_state insertion
Message-ID: <20220617135544.GH20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1654706034.git.dsterba@suse.com>
 <85ad4b193c5c4dcc803449feff008f06bd61808f.1654706034.git.dsterba@suse.com>
 <5dd42610-7f3e-2fe0-ce5d-4a4ee896702c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dd42610-7f3e-2fe0-ce5d-4a4ee896702c@suse.com>
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

On Wed, Jun 15, 2022 at 05:19:31PM +0300, Nikolay Borisov wrote:
> 
> 
> On 8.06.22 г. 19:43 ч., David Sterba wrote:
> > In two cases the exact location where to insert the extent state is
> > known at the call time so we don't need to pass it to insert_state that
> > takes the fast path.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/extent_io.c | 24 +++++++++++++++++-------
> >   1 file changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 9b1dfe4363c9..00a6a2d0b112 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -569,6 +569,21 @@ static int insert_state(struct extent_io_tree *tree,
> >   	return 0;
> >   }
> >   
> > +/*
> > + * Insert state to the tree to a location given by @p_
> 
> that @p_ seems incomplete?

That's a typo and the variable got renamed to 'node', fixed.
