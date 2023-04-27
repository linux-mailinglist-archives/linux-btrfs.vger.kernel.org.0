Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49196F0E9E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 01:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbjD0XAc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 19:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjD0XAb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 19:00:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28273212F
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 16:00:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD5091FEEE;
        Thu, 27 Apr 2023 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682636428;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jvn8unTEY7j+PGsUc/AF7uKDP2p8rKxLLoOdiguwMig=;
        b=QHxKPphYpKIN8vRaxKbjNzt8/fnOXYNCkvdAR8aJU9YPs5t+MppSSHjvie4R2vXfM1TrFJ
        bcXGQkr4gSwvNK3lCNJ3ApZLh+pYF+zg+bPcS0mx4DTL9vH2vnhVnDcxbAa4lwqvc7W+Et
        dagwv3YB/nmYtxJIs2L2or4g4UkjB7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682636428;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jvn8unTEY7j+PGsUc/AF7uKDP2p8rKxLLoOdiguwMig=;
        b=NyoYjcdl3l5oR+iXUivB9au2OylxIAzV10NwHM1CPxocEWIvlOflFmXF0b83Uq5qM5VfPw
        7/wU23XYNb/Mu4Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DA34138F9;
        Thu, 27 Apr 2023 23:00:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yWYDJYz+SmRYBAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Apr 2023 23:00:28 +0000
Date:   Fri, 28 Apr 2023 01:00:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: print extent buffers when sibling keys check
 fails
Message-ID: <20230427230014.GH19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682505780.git.fdmanana@suse.com>
 <14f4089a9d26606c7a15e398536ca75f9c484c9c.1682505780.git.fdmanana@suse.com>
 <84ed9592-ac1e-8344-c0f6-4e114b2835ec@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ed9592-ac1e-8344-c0f6-4e114b2835ec@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 26, 2023 at 07:20:57PM +0800, Qu Wenruo wrote:
> On 2023/4/26 18:51, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > When trying to move keys from one node/leaf to another sibling node/leaf,
> > if the sibling keys check fails we just print an error message with the
> > last key of the left sibling and the first key of the right sibling.
> > However it's also useful to print all the keys of each sibling, as it
> > may provide some clues to what went wrong, which code path may be
> > inserting keys in an incorrect order. So just do that, print the siblings
> > with btrfs_print_tree(), as it works for both leaves and nodes.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> However my concern is, printing two tree blocks may be a little too large.
> Definitely not something can be capture by one screen.
> 
> Although dumping single tree block is already too large for a single 
> screen, I don't have any better way...

For debugging with full logging we can add what we think would be
useful but for the screenshot debugging we can only choose the last
piece of information which I think is the stack trace.
