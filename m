Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C418589F53
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiHDQWK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiHDQWI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 12:22:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDBB67145
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 09:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410F36145E
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 16:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FED0C433D6;
        Thu,  4 Aug 2022 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659630126;
        bh=3k+jL8oU8yqoxo/DhGN8xfSbeqZsmA1mpYQXzJP9olo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=XCnApdBg4Y9KGQ+3zO9Rc4zS1Gh/rQsTBNp5CxQidX2eagVHEiWtlRiOzjeKpStqz
         I41YzHFuXAjlv14oLkYQIH+otUPAUIIEtauSQZC7GZvoTED9YUmFPEmszmuRyCDfGn
         TJS9L6Kn+0410nO21P2tn2dzsvqcCwU0ldme+fLoSD+87wzEin9YhXsgNKr6f3QsK1
         AFmzsAwk6NbC6rzlzIMb8mI6QQHAF2t2eZH2XBvnyNoCMtR5KyVQcD+zhnEkhrS2h+
         sXU6cbUCSIgu6GM0ePQJyezZAdfiVDBXDBWIpvuVUKXhEf0/JgCaYsA9uxZLyTZDdi
         vN2gZ+2+dhhGQ==
Date:   Thu, 4 Aug 2022 17:22:03 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: introduce btrfs_find_inode
Message-ID: <20220804162203.GA1844331@falcondesktop>
References: <20220721135006.3345302-1-nborisov@suse.com>
 <20220721135006.3345302-2-nborisov@suse.com>
 <20220804152823.GT13489@twin.jikos.cz>
 <20220804155221.GA1840473@falcondesktop>
 <20220804160806.GV13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804160806.GV13489@twin.jikos.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 04, 2022 at 06:08:06PM +0200, David Sterba wrote:
> On Thu, Aug 04, 2022 at 04:52:21PM +0100, Filipe Manana wrote:
> > On Thu, Aug 04, 2022 at 05:28:24PM +0200, David Sterba wrote:
> > > On Thu, Jul 21, 2022 at 04:50:04PM +0300, Nikolay Borisov wrote:
> > > 
> > > Please use the simplified format that we have in btrfs.
> > > 
> > > > + *
> > > > + * @root:      root which is going to be searched for an inode
> > > > + * @objectid:  ino being searched for, if no exact match can be found the
> > > > + *             function returns the first largest inode
> > > > + *
> > > > + * Returns the rb_node pointing to the specified inode or returns NULL if no
> > > > + * match is found.
> > > > + *
> > > > + */
> > > > +struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid)
> > > 
> > > Const arguments for int types does not make sense.
> > 
> > It makes sense to me, as much as declaring local variables as const, and I don't
> > recall you ever complain about local const variables before (I do it often, and
> > I'm not the only one).
> 
> The function parameters are supposed to be set by callers and what's in
> the prototype is contract. A const pointer says "callee will not change
> this, promise", but for integer types it does not make sense because it
> does not establish any guarantees to caller.

Sure, but my point was not about giving guarantees to the caller.
It was all about readability for someone reading and changing code.

> 
> Local variables completely live inside a function and adding the const
> there can in some cases optimize the code so that compiler does not need
> to read the memory repeatedly. We've been adding it to the known
> constant values like sectorsize, or when there's a feature bit or other
> status information that's clearly unchanged during the function.
> 
> > Once I read the const part, I can tell for sure that nowhere in the function the
> > value of the argument is changed.
> 
> > It happens often that large functions use an int argument as if it was a local
> > variable and change its value later on, which makes reading the code often a bit
> > more time consuming and often leads to mistakest too.
> 
> I'd rather make this an exception than a rule, to avoid mistakes and for
> clarity that a long function takes certain input, but not for short
> functions.

Not sure if I understood that correctly.
You mean it's ok to add the const qualifier only if the function is long?
