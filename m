Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8782D63AE1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 17:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiK1QyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 11:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiK1QyU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 11:54:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F481CFFF
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:54:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E43B1FDCA;
        Mon, 28 Nov 2022 16:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669654458;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VE3SuhVspHi1pS0pVWATTUo7ozIDUUg9uaPxMkirVhg=;
        b=J8jBPbXtKYsfRwtPxqQylSop9s4NxfKplQZRY3vIagIZInD15XZ/gKoQugOiY2lC88GoOp
        vy9DXqyfVmm83wJtU30y0pRAJBC07Zwzhgdi67bTI5ymDYuCjdY9nXHvFve7qY/Z5NOENI
        46qHrqmjzDsLj+Q64ji49LbfnkosLVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669654458;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VE3SuhVspHi1pS0pVWATTUo7ozIDUUg9uaPxMkirVhg=;
        b=QyOW3fpe2fqLil0B/wJcX+HYscr3UmlK+hkoy/TIsrqgRuEDQTOyf6dqFgKBERE1adG2qX
        yegzM6fwe+DdwZAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23FF91326E;
        Mon, 28 Nov 2022 16:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iz7AB7rnhGOjcwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Nov 2022 16:54:18 +0000
Date:   Mon, 28 Nov 2022 17:53:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not BUG_ON() on ENOMEM when dropping extent
 items for a range
Message-ID: <20221128165344.GQ5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <59ccc7b41be79e5c3b0f39ad5da6591554927af7.1669647978.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ccc7b41be79e5c3b0f39ad5da6591554927af7.1669647978.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 28, 2022 at 03:07:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we get -ENOMEM while dropping file extent items in a given range, at
> btrfs_drop_extents(), due to failure to allocate memory when attempting to
> increment the reference count for an extent or drop the reference count,
> we handle it with a BUG_ON(). This is excessive, instead we can simply
> abort the transaction and return the error to the caller. In fact most
> callers of btrfs_drop_extents(), directly or indirectly, already abort
> the transaction if btrfs_drop_extents() returns any error.
> 
> Also, we already have error paths at btrfs_drop_extents() that may return
> -ENOMEM and in those cases we abort the transaction, like for example
> anything that changes the b+tree may return -ENOMEM due to a failure to
> allocate a new extent buffer when COWing an existing extent buffer, such
> as a call to btrfs_duplicate_item() for example.
> 
> So replace the BUG_ON() calls with proper logic to abort the transaction
> and return the error.
> 
> Reported-by: syzbot+0b1fb6b0108c27419f9f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/00000000000089773e05ee4b9cb4@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
