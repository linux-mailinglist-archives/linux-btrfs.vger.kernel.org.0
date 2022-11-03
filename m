Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3491E617DAB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 14:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKCNQr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 09:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKCNQq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 09:16:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFD9282
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 06:16:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 513471F88F;
        Thu,  3 Nov 2022 13:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667481404;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EUhDTCZY8oJAoZFRgg4MDVomJoYLfLwP2hXXyVa5pHM=;
        b=wbosH/Zx6kXTkjqVK5e1MYrgbUv3um8XcwGC3HQoADTqrzK/8ALsSW8y2CezT6cFKAe5+H
        uuJED6uBbjIMcXXR4QXTqINGCwEkIBNgUYRcae292iU4ZTwjG/5zveEtXBiX4YwKFBTRSs
        hLfx99THd/uK4bqOv9nJVbZlPwLiVCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667481404;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EUhDTCZY8oJAoZFRgg4MDVomJoYLfLwP2hXXyVa5pHM=;
        b=tkSmLurwZOvWt+kf7aA7l32ygs8YuMs8AWKtYY+kRmtamqAzlrWxafjca9hVTPp09k3o5G
        ggfY/Rf4gXVGDhCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E7EA13480;
        Thu,  3 Nov 2022 13:16:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bqM3Cjy/Y2NqVwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 03 Nov 2022 13:16:44 +0000
Date:   Thu, 3 Nov 2022 14:16:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Minor cleanups
Message-ID: <20221103131625.GM5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667244567.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667244567.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 31, 2022 at 08:33:37PM +0100, David Sterba wrote:
> A few random cleanups or fixups.
> 
> David Sterba (4):
>   btrfs: zlib: use copy_page for full page copy
>   btrfs: zoned: use helper to check a power of two zone size
>   btrfs: convert btrfs_block_group::needs_free_space to runtime flag
>   btrfs: convert btrfs_block_group::seq_zone to runtime flag

Added to msic-next.
