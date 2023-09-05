Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277737926C5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjIEQC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354420AbjIEL2x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 07:28:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7621AD
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 04:28:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 107201F8B0;
        Tue,  5 Sep 2023 11:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693913329;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8WUlaQOAhPmaU5wnKu5apjJVuO5EGGmnq/FtrE8DMk=;
        b=HaBjmRoKQ1QBmh19HYnsJAu7bDaqV1PZrketEDcGR0/oXPfcKFgGfIUuvPVVgYdZtfDysS
        vvRkuE7dPawTe9TWyNoesPIXUmxFZQ4FXNK0Tnk0iTkQpGxaZOhr6/ze7D7b4WY+eBS0y1
        xn686jJG1MCXE21YTyns8rXZL5yMoQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693913329;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8WUlaQOAhPmaU5wnKu5apjJVuO5EGGmnq/FtrE8DMk=;
        b=veTGNnptJGj9T9RQHhecQAXBa82meLWmZvZ8BMiJCOxRQQWEi8b50VapJ+T9tbh6ETwXih
        QmGV7VzA9982LuDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DED9E13499;
        Tue,  5 Sep 2023 11:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dfKgNfAQ92SwcQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 11:28:48 +0000
Date:   Tue, 5 Sep 2023 13:22:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a compiling error if DEBUG is defined
Message-ID: <20230905112209.GT14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <14ea9aa0a4d5ac8f2c817978e9fff6ded8777ef9.1692683147.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ea9aa0a4d5ac8f2c817978e9fff6ded8777ef9.1692683147.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 22, 2023 at 01:50:51PM +0800, Qu Wenruo wrote:
> [BUG]
> After commit 72a69cd03082 ("btrfs: subpage: pack all subpage bitmaps
> into a larger bitmap"), the DEBUG section of btree_dirty_folio() would
> no longer compile.
> 
> [CAUSE]
> If DEBUG is defined, we would do extra checks for btree_dirty_folio(),
> mostly to make sure the range we marked dirty has an extent buffer and
> that extent buffer is dirty.
> 
> For subpage, we need to iterate through all the extent buffers covered
> by that page range, and make sure they all matches the criteria.
> 
> However commit 72a69cd03082 ("btrfs: subpage: pack all subpage bitmaps
> into a larger bitmap") changes how we store the bitmap, we pack all the
> 16 bits bitmaps into a larger bitmap, which would save some space.
> 
> This means we no longer have btrfs_subpage::dirty_bitmap, instead the
> dirty bitmap is starting at btrfs_subpage_info::dirty_offset, and has a
> length of btrfs_subpage_info::bitmap_nr_bits.
> 
> [FIX]
> Although I'm not sure if it still makes sense to maintain such code, at
> least let it compile.

I'm not sure either, making it compile again makes sense. I vaguely
remember that the DEBUG macro is set by some option externally and there
are many ifdefs in other code so I assume it's still a valid feature.
There's a reference to -DDEBUG in
Documentation/admin-guide/dynamic-debug-howto.rst .

> This patch would let us test the bits one by one through the bitmaps.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
