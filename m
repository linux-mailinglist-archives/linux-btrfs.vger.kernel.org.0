Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA98625F1E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKKQIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 11:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKQHo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 11:07:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D74F01F
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 08:07:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E2E402020A;
        Fri, 11 Nov 2022 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668182861;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXgzxMvUFch41TUPdQaWizaiIo98nAUw1k4kzr00ehc=;
        b=zq3MrO2pNPFY2QjQWYpIrDftmOroFqSxS4MaLE0oYPHzmnpr7PkSSo/OcE2u89GIDrgpdN
        skiFfGxV4zVY6l7z6Bu1T6ROpoxDE1q0scRSrsYNb9shrNimEonOUBvKLtEx83FkkgAjk6
        55lvgTDFLrofk85cMwYcyX9ueHEQd50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668182861;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXgzxMvUFch41TUPdQaWizaiIo98nAUw1k4kzr00ehc=;
        b=BrTUBxw4jcJLJCQWT1lPTF6naKfYv0E3G7fQdjvjIpVIu9C74l9Gyqt4QbjeLNb36OJREV
        WRYJguDYqhmwZCDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF35A13273;
        Fri, 11 Nov 2022 16:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xLqkLU1zbmOiSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 16:07:41 +0000
Date:   Fri, 11 Nov 2022 17:07:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: do most metadata parentnesss check at endio
 time
Message-ID: <20221111160718.GT5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663133223.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663133223.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 01:32:49PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> 
> Btrfs metadata and data verification are both done at endio time.
> 
> But metadata has its own extra verifiaction, mostly related to
> parentness check, done at btrfs_read_extent_buffer() and
> read_tree_block().
> 
> This is not a big deal, but if we want to make metadata read-repair to
> share the same code base with data, we may want the metadata parentness
> check also to happen at endio time.
> 
> [ENHANCEMENT]
> 
> This patchset will move all the parentness check code into
> btrfs_validate_metadata_buffer().
> 
> As the first step, the first patch will concentrate all the existing
> parentness check into one structure.
> 
> Then the second patch will pass all the parentness info into btrfs_bio,
> using the shared space of data csum, so at endio time we can grab all
> the metadata parentness info and do the verification.
> 
> This means the following mismatch at read time would be rejected
> directly:
> 
> - First key mismatch
> - Transid mismatch
> - Level mismatch
> - Owner root mismatch
> 
> Since all the read-time parentness check is all done at endio now,
> btrfs_read_extent_buffer() can do less verification work for new extent
> buffers which is going to be read from disk.
> 
> But please note that, we still do parentness check for cached extent
> buffer, to avoid some cached/stale extent buffer read by other parent
> tree blocks to cause problems.
> 
> Thankfully that part will not trigger read repair thus won't affect us
> for now.
> 
> [TODO]
> Make metadata and data share the same code base to do read-repair.
> 
> The main blockage here is, we have a lot of pending patches changing
> the read-repair code, thus it's going to cause conflicts for the already
> lengthy pending patches.
> 
> Thus the refactor part is sent out first, then after read-repair is
> settled down, I can work on the unified read-repair code.
> 
> Qu Wenruo (2):
>   btrfs: concentrate all tree block parentness check parameters into one
>     structure
>   btrfs: move tree block parentness check into validate_extent_buffer()

As this is only 2 patches and they apply with minimal conflicts I've
added it to misc-next, thanks.
