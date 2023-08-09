Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF9776785
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjHISiy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHISix (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 14:38:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C6212A
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 11:38:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64D761F460;
        Wed,  9 Aug 2023 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691606328;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFsTDx4SO/ZI1Gqk6QKrWvlKXiVonR859GbIt36k5U4=;
        b=jf0VLCaMBtYmMXP/U5vgTerPWIjbm0OO/sZMmHVV4djauC7VICcao6f10NnutiqQOzgwZF
        S21L3kCfPp8dba43BusPtE9BCh+0MnGtxIFManLcjsoVV5Y0pM6F8gj72v8+PfCTyB1oYA
        +QTmX9T+AXabk8hlDhEEtrhFdS1F0JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691606328;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFsTDx4SO/ZI1Gqk6QKrWvlKXiVonR859GbIt36k5U4=;
        b=PDac+rsAlLEjyh765xiW1DYwM8Ws47R7Zc9XAP4Qjnk2ln5d7O+DJFC6C+pRcZK9bfzECH
        3pmkiaj2UMsBY4CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 465D3133B5;
        Wed,  9 Aug 2023 18:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9pxFEDjd02SHHQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 18:38:48 +0000
Date:   Wed, 9 Aug 2023 20:38:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: handle errors properly in
 update_inline_extent_backref()
Message-ID: <ZNPdN6zV2oWooJFb@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
 <ZNN2muT7ONRWvn1c@twin.jikos.cz>
 <82f89f3c-78b0-4c7f-a426-7fde89bf490a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f89f3c-78b0-4c7f-a426-7fde89bf490a@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 09, 2023 at 07:29:20PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/8/9 19:20, David Sterba wrote:
> > On Wed, Aug 09, 2023 at 03:08:21PM +0800, Qu Wenruo wrote:
> > > [PROBLEM]
> > > Inside function update_inline_extent_backref(), we have several
> > > BUG_ON()s along with some ASSERT()s which can be triggered by corrupted
> > > filesystem.
> > > 
> > > [ANAYLYSE]
> > > Most of those BUG_ON()s and ASSERT()s are just a way of handling
> > > unexpected on-disk data.
> > > 
> > > Although we have tree-checker to rule out obviously incorrect extent
> > > tree blocks, it's not enough for those ones.
> > > 
> > > Thus we need proper error handling for them.
> > > 
> > > [FIX]
> > > Thankfully all the callers of update_inline_extent_backref() would
> > > eventually handle the errror by aborting the current transaction.
> > > 
> > > So this patch would do the proper error handling by:
> > > 
> > > - Make update_inline_extent_backref() to return int
> > >    The return value would be either 0 or -EUCLEAN.
> > > 
> > > - Replace BUG_ON()s and ASSERT()s with proper error handling
> > >    This includes:
> > >    * Dump the bad extent tree leaf
> > >    * Output an error message for the cause
> > >      This would include the extent bytenr, num_bytes (if needed),
> > >      the bad values and expected good values.
> > >    * Return -EUCLEAN
> > > 
> > >    Note here we remove all the WARN_ON()s, as eventually the transaction
> > >    would be aborted, thus a backtrace would be triggered anyway.
> > > 
> > > - Better comments on why we expect refs == 1 and refs_to_mode == -1 for
> > >    tree blocks
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > Is this fix for syzbot report
> > https://lore.kernel.org/linux-btrfs/000000000000287928060275b914@google.com/
> > ?
> 
> Unfortunately, I don't think this is the proper fix.
> 
> Since there is no reproducer, I'm not sure if it's really corrupted fs
> causing the bug.
> 
> If it's something else, then the patch won't help at all, except a
> little better debug output.

Ok, thanks. Adding more error handling instead of BUG_ON or ASSERT that
could be possibly hit by corrupted images is good on its own.
