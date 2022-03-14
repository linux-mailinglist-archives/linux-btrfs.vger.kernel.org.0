Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492964D8CAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 20:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbiCNTqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 15:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiCNTqn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 15:46:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73413DA79
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 12:45:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 77C3E1F37E;
        Mon, 14 Mar 2022 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647287131;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8oSAoaxOHoC6t3F5EZUJYgs173tyQGM/7+0UAwayM9s=;
        b=L1i8apUql9+jxiPA9vLwTWPykBNkdhdtLt5yqS565dKMV27uzEwBw8YoKBNk5xw7GZxj01
        /6rJA/nqPRn6G0pDsNagut0JDXttdG6lPKGUwi72tfXJIPB4xczkH3OAujBJKPt3Ue8njU
        qWKlQbyuHRt+ijr4/VV9VHhIhP3mhWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647287131;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8oSAoaxOHoC6t3F5EZUJYgs173tyQGM/7+0UAwayM9s=;
        b=3ZGQcnwfJVzbeu4xhuDh+T8bKYWXPF1Jm+BO3fgxdGKDRviq1RXuJxMqtFvCCAuZwWgR8t
        qRgCcpORsd+/D0Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6F3D2A3B89;
        Mon, 14 Mar 2022 19:45:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 20569DA7E1; Mon, 14 Mar 2022 20:41:32 +0100 (CET)
Date:   Mon, 14 Mar 2022 20:41:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: scrub: make scrub uses less memory for
 metadata scrub
Message-ID: <20220314194132.GR12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1646210051.git.wqu@suse.com>
 <20220307163645.GJ12643@twin.jikos.cz>
 <d8a6c90e-ca77-dcc7-9312-23f175101788@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8a6c90e-ca77-dcc7-9312-23f175101788@gmx.com>
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

On Tue, Mar 08, 2022 at 11:49:08AM +0800, Qu Wenruo wrote:
> >> The patchset requires the rename patchset.
> >> (https://lore.kernel.org/linux-btrfs/cover.1645530899.git.wqu@suse.com/)
> >>
> >> If David is not happy with the big change again, at least first 3
> >> patches can be considered as some cleanup.
> >>
> >> Qu Wenruo (5):
> >>    btrfs: scrub: use pointer array to replace @sblocks_for_recheck
> >>    btrfs: extract the initialization of scrub_block into a helper
> >>      function
> >>    btrfs: extract the allocation and initialization of scrub_sector into
> >>      a helper
> >>    btrfs: scrub: introduce scrub_block::pages for more efficient memory
> >>      usage for subpage
> >>    btrfs: scrub: remove scrub_sector::page and use scrub_block::pages
> >>      instead
> >
> > Added to for-next as topic branch for now.
> 
> I guess you replied to the wrong patch?

Yeah.

> The for-next branch only contains the scrub entrance refactor v3.
> 
> No the renaming nor the subpage optimization.

The scrub renaming is in misc-next, please refresh this patchset,
thanks.
