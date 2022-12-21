Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135CF653677
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiLUSmA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 13:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiLUSl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 13:41:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB3120F45
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 10:41:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8050022AFF;
        Wed, 21 Dec 2022 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671648116;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aR9XyThl+OKyN7ePrr2DkHxWjyW9Bc6dD6X1ky74XCg=;
        b=cXbVK04i07mLmmVmOMwinUIrra5gesOS54BiniE9XJYXQf8CkUng5NzSmnCoxSKdMfd4Gn
        J8M2sNtsNK/iohDJYr+oFmZvj0JX3IfPx304WCET6LEIkPgXE1S9LAXOcX3mp826lpUnkI
        2vnrgyxFdfHYJH91YqcHv1aCmewT25s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671648116;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aR9XyThl+OKyN7ePrr2DkHxWjyW9Bc6dD6X1ky74XCg=;
        b=RAvCBvfVnELka/RatMtp72RUu4Z3eN6q6/HPQvUV0FSywIQNTdii2dvFO57bx9u2hFN7BK
        SrDB7j5hxfIqEeAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5825C1390E;
        Wed, 21 Dec 2022 18:41:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KDajFHRTo2MOBAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Dec 2022 18:41:56 +0000
Date:   Wed, 21 Dec 2022 19:36:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/8] Fixup uninitialized warnings and enable extra checks
Message-ID: <20221221183632.GC2415@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1671221596.git.josef@toxicpanda.com>
 <20221220193706.GS10499@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220193706.GS10499@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 20, 2022 at 08:37:06PM +0100, David Sterba wrote:
> On Fri, Dec 16, 2022 at 03:15:50PM -0500, Josef Bacik wrote:
> > Hello,
> > 
> > We had been failing the raid56 related scrub tests on our overnight tests since
> > November.  Initially I asked Qu to look into these as I didn't have time to dig
> > in, and he was unable to reproduce.  I assumed it was some oddity in my setup,
> > so I ignored it.  However recently I got a report that I regressed some of these
> > tests with an unrelated change.  When debugging it I found it was because of an
> > uninitialized return value, which would have been caught by more modern gcc's
> > with -Wmaybe-uninitialized.
> > 
> > In order to avoid these sort of problems in the future lets fix up all the false
> > positivies that this warning brings, and then enable the option for btrfs so we
> > can avoid this style of failure in the future.  Thanks,
> > 
> > Josef
> > 
> > Josef Bacik (8):
> >   btrfs: fix uninit warning in run_one_async_start
> >   btrfs: fix uninit warning in btrfs_cleanup_ordered_extents
> >   btrfs: fix uninit warning from get_inode_gen usage
> >   btrfs: fix uninit warning in btrfs_update_block_group
> >   btrfs: fix uninit warning in __set_extent_bit and convert_extent_bit
> >   btrfs: extract out zone cache usage into it's own helper
> >   btrfs: fix uninit warning in btrfs_sb_log_location
> >   btrfs: turn on -Wmaybe-uninitialized
> 
> I've applied all except 1, 6 and 8, so there are still 2 reported
> warnings with -Wmaybe-uninitialized that could be fixed in a slightly
> different way.

Fixed versions of patches 1 and 6 have been applied so 8 has been
applied too.
