Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85311508AE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379618AbiDTOnQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 10:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379687AbiDTOnO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 10:43:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC9226AD4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 07:40:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9A64210F3;
        Wed, 20 Apr 2022 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650465626;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=waWr+fmI8UrE7ZXiiIlwNFACwUDncLE+EYmZAdRshSs=;
        b=MCb4a6cjUuHkoWTcp4fSN20w4h+L6VptBD1b1BmJQrxV4gFomvq7eRJSSy4qkxan4c9DmT
        SeXPIgtMd7Qfi5iQ5YBn9NCXGgq5T4KN8IUA8qJ5ucM+eleA7ln8cqf1mojt1cXJv0dIeJ
        3/0Fz7Miun6N5jdfa6XuKkCOmwEogLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650465626;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=waWr+fmI8UrE7ZXiiIlwNFACwUDncLE+EYmZAdRshSs=;
        b=xeG9oz2Okx8jmoTJUzoaUgelFMH+a9gTFgiDJX+eiSryNkNYIwgqAQOG7NM3cd80Q/hN+0
        nJjR9/8Zz36S+XAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C926B13A30;
        Wed, 20 Apr 2022 14:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EaQiMFobYGL6IAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Apr 2022 14:40:26 +0000
Date:   Wed, 20 Apr 2022 16:36:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix assertion failure during scrub due to block
 group reallocation
Message-ID: <20220420143622.GC1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <e39beae941fdde3176fe75c35e273e39e0661f4b.1650374396.git.fdmanana@suse.com>
 <d3490e45-da8d-7c02-4a2e-c580cf673338@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3490e45-da8d-7c02-4a2e-c580cf673338@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 20, 2022 at 10:24:13AM +0800, Qu Wenruo wrote:
> > So make scrub skip any block group with a start offset that is less than
> > the value we expect, as that means it's a new block group that was created
> > in the current transaction. It's pointless to continue and try to scrub
> > its extents, because scrub searches for extents using the commit root, so
> > it won't find any. For a device replace, skip it as well for the same
> > reasons, and we don't need to worry about the possibility of extents of
> > the new block group not being to the new device, because we have the write
> > duplication setup done through btrfs_map_block().
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> The offending commit is relatively new, do we need to Cc to stable just
> for v5.17 kernel?

If a patch already comes with a stable it's a plus but otherwise I do a
check namely for fixes, they typically go to the next rc and based on
severity of the fix get a stable tag. No big deal if it's not in the
patch, a note under the -- "this may go to stable" is also ok if you're
not sure about the exact stable version.
