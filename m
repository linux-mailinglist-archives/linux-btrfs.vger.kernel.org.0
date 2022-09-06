Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDD75AF3BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIFSgd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 14:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIFSgI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 14:36:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232861DA8
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 11:36:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F41FE3368B;
        Tue,  6 Sep 2022 18:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662489360;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRvjbPd2ZngFesKmcUGVrBLL37IEmjS348V7c1H+3eM=;
        b=fg/DzpEs3pxfOoqF/tn5LjC42Xh6lSyAA91LgliH/XstsxtO6jd8jDgvngWh/Wa4MnK5RU
        nSjWQAhna+9ilE0BC9zEqf+zY4ZE9vhe0IAJxtYqoiGUoXtAErrdaZpzWn13r+WDHnxhcj
        QWhAyLGcwswHJh1oqeutYvc8SZqr7uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662489360;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRvjbPd2ZngFesKmcUGVrBLL37IEmjS348V7c1H+3eM=;
        b=soPOUCAvHwrAk2awI8Q2U2FW8PJ9TNI8ZxACcEGh6EbEWaY2k0nv+GS6IqAOzegNY5Aasa
        hOI7M09kMUvYjYDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D087413B2B;
        Tue,  6 Sep 2022 18:35:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TZuJMQ+TF2PJbAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Sep 2022 18:35:59 +0000
Date:   Tue, 6 Sep 2022 20:30:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/31] btrfs: move extent_io_tree code and cleanups
Message-ID: <20220906183037.GU13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
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

On Fri, Sep 02, 2022 at 04:16:05PM -0400, Josef Bacik wrote:
> In working on extent tree v2 I got really bogged down in trying to sync work
> between btrfs-progs and the kernel.  It basically takes me 3x as long, because
> there's a lot of different things missing in btrfs-progs, so each patchset has
> to be done from scratch and tested completely differently.
> 
> Additionally there's just a lot of tech-debt in these areas in general.  So
> before tackling the rest of extent-tree-v2 I'm spending some time cleaning up
> things we all know are terrible.  This is the first step in that direction,
> finishing the separation of the extent_io_tree code from extent_io.c.  I started
> this a while ago, but got bogged down in other things.
> 
> This has 3 distinct parts
> 
> 1. Cleanup the io_failure_record code.  This has been tightly integrated into
>    the extent_io_tree code forever without much reason for it.  The first part
>    of this series moves that handling into it's own tree, and uses our existing
>    helpers to reduce the code quite a bit.
> 
> 2. Move the code out of extent_io.c.  This is easier than previous code moves
>    because I did a lot of the prep work earlier.  Unfortunately there is one big
>    patch that copy and pastes all the core code, since it all depends on itself
>    and would be more annoying to move.  However the independent parts were
>    moved piece by piece.
> 
> 3. A wholesale cleanup of the extent_io_tree code.  We have a ton of helpers
>    here, that have all grown a ton of arguments over the years.  I've trimmed
>    down the arguments for our core helpers, and hidden the rest internally
>    inside of extent-io-tree.c.  Additionally I've cleaned up the lock/unlock
>    extent bit helpers so we only have one lock_extent/unlock_extent variant that
>    gets used everywhere.
> 
> I've tested this locally to make sure I didn't break anything.  This isn't a
> simple code move so do please review most of it, the patches that start with
> "move X" are pure code move patches, but the rest do change things.  Thanks,

As this is mostly simple cleanups or straightfowrad changes I think it's
safe to merge before code freeze. I'll send more comments to the
patches, there are some minor issues or missing commit references to
last code that used some structure when it's removed.

As others noted this patchset conflicts with the series from Christoph,
namely the io_failure_tree removal, but that series is more intrusive
and with pending reviews.
