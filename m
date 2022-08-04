Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EFF589F2C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiHDQNN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiHDQNM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 12:13:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B927A2AC5F
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 09:13:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BAF3C5BE70;
        Thu,  4 Aug 2022 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659629589;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=meIggM5fASF3lKJyQgg6J8vFb7Qxi8po/VmUJ0CxLqU=;
        b=E77MRRu6HjKQcGWashqtsECH98ys96n9/24q8Ej/t29NcYeHgvkt38RlM0yKomty94i8yZ
        kawbfECKXjlxfG4v4Hx4b34snu2Do4oFu77Rc3EWgNe0Iv6vqa7ZCuZs0a35w7YLWfBNLP
        ikJxvti77hb48OIZRaRD1Y2F0xWWLAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659629589;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=meIggM5fASF3lKJyQgg6J8vFb7Qxi8po/VmUJ0CxLqU=;
        b=zB16TTvgty2k7dmyBycewxmU1zQdYeLyKAmYI7ZU7kpyyyyGMatS0BquLpmI9MddALzDGX
        JR16QMXYPk1OwBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89B2A13434;
        Thu,  4 Aug 2022 16:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t7uwIBXw62IgJAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 Aug 2022 16:13:09 +0000
Date:   Thu, 4 Aug 2022 18:08:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: introduce btrfs_find_inode
Message-ID: <20220804160806.GV13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220721135006.3345302-1-nborisov@suse.com>
 <20220721135006.3345302-2-nborisov@suse.com>
 <20220804152823.GT13489@twin.jikos.cz>
 <20220804155221.GA1840473@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804155221.GA1840473@falcondesktop>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 04, 2022 at 04:52:21PM +0100, Filipe Manana wrote:
> On Thu, Aug 04, 2022 at 05:28:24PM +0200, David Sterba wrote:
> > On Thu, Jul 21, 2022 at 04:50:04PM +0300, Nikolay Borisov wrote:
> > 
> > Please use the simplified format that we have in btrfs.
> > 
> > > + *
> > > + * @root:      root which is going to be searched for an inode
> > > + * @objectid:  ino being searched for, if no exact match can be found the
> > > + *             function returns the first largest inode
> > > + *
> > > + * Returns the rb_node pointing to the specified inode or returns NULL if no
> > > + * match is found.
> > > + *
> > > + */
> > > +struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid)
> > 
> > Const arguments for int types does not make sense.
> 
> It makes sense to me, as much as declaring local variables as const, and I don't
> recall you ever complain about local const variables before (I do it often, and
> I'm not the only one).

The function parameters are supposed to be set by callers and what's in
the prototype is contract. A const pointer says "callee will not change
this, promise", but for integer types it does not make sense because it
does not establish any guarantees to caller.

Local variables completely live inside a function and adding the const
there can in some cases optimize the code so that compiler does not need
to read the memory repeatedly. We've been adding it to the known
constant values like sectorsize, or when there's a feature bit or other
status information that's clearly unchanged during the function.

> Once I read the const part, I can tell for sure that nowhere in the function the
> value of the argument is changed.

> It happens often that large functions use an int argument as if it was a local
> variable and change its value later on, which makes reading the code often a bit
> more time consuming and often leads to mistakest too.

I'd rather make this an exception than a rule, to avoid mistakes and for
clarity that a long function takes certain input, but not for short
functions.
