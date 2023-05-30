Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25218716644
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjE3PKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 11:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjE3PKc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 11:10:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1893F9
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 08:10:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A9C4B21A87;
        Tue, 30 May 2023 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685459410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auFc2jksgiFS9ffh2w9t0nV4XbuZ0Nwxm3IxXsQAp3g=;
        b=oVvVEOk/LK4GQPJIPwk1qbZ+/cT4aPtQf885dUX4E3ElvR+Uim+YFLhOmpQ/KpbBDEbaJ5
        E20lhyfGYo5V2IBhFXj9ZvgUjXyBjiIv/nHMmqIIqCW9boBIdI5qdcItDmMWk3jKLBMvNk
        cs/IT2eSvXod/yKRciguhU3X0a5zxoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685459410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auFc2jksgiFS9ffh2w9t0nV4XbuZ0Nwxm3IxXsQAp3g=;
        b=9Cil0DFlttSpOw8tVfyswsMEHmk8XvXwqSqsUYZUcfc+JCS8MQe609SWgciBB0TcwF2yG+
        ZMj0Nt4v3fLNtrBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 867AC13478;
        Tue, 30 May 2023 15:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KvkkINIRdmT4fgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 15:10:10 +0000
Date:   Tue, 30 May 2023 17:03:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/11] btrfs: make btrfs_destroy_delayed_refs() return
 void
Message-ID: <20230530150359.GS575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1685363099.git.fdmanana@suse.com>
 <8f1298da5496557ca89592916cd4a445b6048b8f.1685363099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f1298da5496557ca89592916cd4a445b6048b8f.1685363099.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 29, 2023 at 04:17:07PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs_destroy_delayed_refs() always returns 0 and its single caller does
> not even check its return value, so make it return void.

Function can return void if none of its callees return an error,
directly or indirectly, there are no BUG_ONs left to be turned to
proper error handling or there's no missing error handling.

There's still:

4610                         cache = btrfs_lookup_block_group(fs_info, head->bytenr);
4611                         BUG_ON(!cache);

and calling

btrfs_error_unpin_extent_range
  unpin_extent_range
    cache = btrfs_lookup_block_group()
    BUG_ON(!cache)

If a function like btrfs_cleanup_one_transaction has limited options how
to handle errors then we can ignore them there but at least a comment
would be good that we're doing that intentionally.

This case is a bit special because there's only one caller so we know
the context and btrfs_destroy_delayed_refs() should eventually return
void but I'd rather do that as the last step after the call graph is
audited for proper error handling.
