Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DD0797FF2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 03:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjIHBCp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 21:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbjIHBCn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 21:02:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0E31BC1
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 18:02:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31A9D218DF;
        Fri,  8 Sep 2023 01:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694134957;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6cHxI3E0zjPtVwupfYCe8kSzJ2zqzsDP+fM51vKnYA=;
        b=Rikl36JA/aKbBQqFoNGJEgvqEDFrkk8uCoEeOt7bh46PKg3KVY4RE9fEmXX7fG4UxCzcYz
        XTFjtf0GAzua5BTNUSLHnubsJ+fpszzyc1V2KNlQjQvsoP0ZaHK71fQ5VFRxlkEesoCJCu
        T32cpEa963Ajr0+Xo0Vag65dBDLB840=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694134957;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6cHxI3E0zjPtVwupfYCe8kSzJ2zqzsDP+fM51vKnYA=;
        b=HvULRNYczj71sOaIyRVaPX1chC1OHYgbPMiL4WsmcawqtIicGxZ1BtDJ4duVgs3QbHTAZ4
        +zt9qQ5VnimBaTDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1192E13588;
        Fri,  8 Sep 2023 01:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ast6A61y+mSMcwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Sep 2023 01:02:37 +0000
Date:   Fri, 8 Sep 2023 02:56:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/10] btrfs: move extent_buffer::lock_owner to debug
 section
Message-ID: <20230908005605.GV3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694126893.git.dsterba@suse.com>
 <3f96e9c3d06ed846b19b63cd9001cb0c66bd8a00.1694126893.git.dsterba@suse.com>
 <f941ac57-3daa-4246-bdeb-b12ab37ee26b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f941ac57-3daa-4246-bdeb-b12ab37ee26b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 08:11:43AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/9/8 07:09, David Sterba wrote:
> > The lock_owner is used for a rare corruption case and we haven't seen
> > any reports in years. Move it to the debugging section of eb.  To close
> > the holes also move log_index so the final layout looks like:
> 
> Just found some extra space we can squish out:

Yeah I have a few more patches to reduce extent buffer size.

> > struct extent_buffer {
> >          u64                        start;                /*     0     8 */
> >          long unsigned int          len;                  /*     8     8 */
> 
> u32 is definitely enough.
> (u16 is not enough for 64K nodesize, unfortunately)

One idea is to store the bit shift and then calculate the length on each
use but then we can simply not store the length in extent buffer at all
because it's always fs_info->nodesize. In some functions it can be
directly replaced by that, elsewhere it's needed to do
eb->fs_info->nodesize. One more pointer dereference but from likely a
cached memory, gaining 8 bytes.

> 
> >          long unsigned int          bflags;               /*    16     8 */
> 
> For now we don't need 64bit for bflags, 32bit is enough, but
> unfortunately that's what the existing test/set/clear_bit() requires...

Indeed, and it's not just here, in the inode or some other structures
taht store a few flags an u32 would suffice. I have a prototype to add
atomic bit manipulations for a u32 type, but this requires manually
written assembly so for now it's just x86. This could be useful outside
of btrfs so I'd need to make it a proper API and get some feedback from
wider audience.

> >          struct btrfs_fs_info *     fs_info;              /*    24     8 */
> >          spinlock_t                 refs_lock;            /*    32     4 */
> >          atomic_t                   refs;                 /*    36     4 */
> >          int                        read_mirror;          /*    40     4 */
> 
> We don't really need int for read_mirror, but that would be another
> patch(set) to change them.

Yeah that's another potential space saved, I tried to track down all the
use of mirror values but it's passed around to bios and back.

> >          s8                         log_index;            /*    44     1 */

And log_index takes 3 values, this can be encoded into the flags, also a
prototype but the code becomes ugly.
