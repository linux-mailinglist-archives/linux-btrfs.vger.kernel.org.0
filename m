Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00F16526B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 20:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiLTS61 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 13:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiLTS6K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 13:58:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2511DDEB
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 10:58:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A872E2279D;
        Tue, 20 Dec 2022 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671562680;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XysRUlihlgTAWDhGJ3H0xft4Y8vNOVl9hSB0EKVg3E=;
        b=kYbge2nXirc/AYzgQrNrEiaCAPU3KJRTjcy+BC6NfIKmOS0LK0weQKZEf98dwcXOq1sKRl
        YnIGpZrFKLBg3kWhqQ1SiPR0h1V6/UY3UQwLKTLxkeDESUZauV4ZJy4BLcRTUgZPQ9bnEA
        qphDYJBeAo3AXveQQRGcrq0fktRJ6aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671562680;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XysRUlihlgTAWDhGJ3H0xft4Y8vNOVl9hSB0EKVg3E=;
        b=CmxTnBO7pgR0TVizTLiFkY3jIFw72SUVUxPlzLeWrpYZMKZBDvkHrnf8Y6hMtScfoDNElI
        ZMFT3Oz2okHD3RAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75C881390E;
        Tue, 20 Dec 2022 18:58:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9J3KG7gFomMhMgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Dec 2022 18:58:00 +0000
Date:   Tue, 20 Dec 2022 19:57:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't clear EXTENT_BUFFER_DIRTY bit if the tree
 block is not dirtied in our transaction
Message-ID: <20221220185714.GO10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ed62dbe7094fb5e80cb5b6df8590ff621b218ae5.1671252987.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed62dbe7094fb5e80cb5b6df8590ff621b218ae5.1671252987.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 17, 2022 at 12:57:10PM +0800, Qu Wenruo wrote:
> [BUG]
> Since patch "btrfs: do not check header generation in
> btrfs_clean_tree_block", a lot of scrub tests will report errors like
> btrfs/072:
> 
>   QA output created by 072
>   Silence is golden
>   Scrub find errors in "-m single -d single" test
> 
> With newer scrub metadata error reports, we can see the bad tree blocks
> are having older fsid from previous runs:
> 
>  BTRFS warning (device dm-2): tree block 24117248 mirror 1 has bad fsid, has b77cd862-f150-4c71-90ec-7baf0544d83f want 17df6abf-23cd-445f-b350-5b3e40bfd2fc
>  BTRFS warning (device dm-2): tree block 24117248 mirror 0 has bad fsid, has b77cd862-f150-4c71-90ec-7baf0544d83f want 17df6abf-23cd-445f-b350-5b3e40bfd2fc
>  BTRFS error (device dm-2): bdev /dev/mapper/test-scratch2 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> 
> This means, some tree blocks of commit roots are not properly written
> back to disks.
> 
> [CAUSE]
> Patch "btrfs: do not check header generation in btrfs_clean_tree_block"
> will unconditionally clear the DIRTY flag, but there is a race that we
> can clear the DIRTY flag for extent buffers which is under writeback:
> 
>             Transaction A             |   Transaction A + 1
> --------------------------------------+----------------------------------
>  btrfs_cow_block()                    |
>  |- __btrfs_cow_block()               |
>     |- btrfs_alloc_tree_block()       |
>     |  Tree block X get allocated     |
>     |  Generation is A, and marked    |
>     |  dirty.                         |
>                                       |
>  btrfs_commit_transaction()           |
>  | Tree block X should be written     |
>  | back. As it's dirtied in           |
>  | transaction A.                     |
>  |                                    |
>  |- cur_trans->state =                |
>  |  TRANS_STATE_UNBLOCKED             |
>  |  Now new transaction can be        |
>  |  started.                          |
>  |                                    | Transaction A + 1 started
>  |                                    |
>  |                                    | btrfs_cow_block()
>  |                                    | |- __btrfs_cow_block()
>  |                                    |    |- update_ref_for_cow()
>  |                                    |    |- btrfs_clear_buffer_dirty()
>  |                                    |    |  Tree block X get freed, thus
>  |                                    |       its DIRTY flag get cleared.
>  |                                    |       And its pages are no
>  |                                    |       longer dirty.
>  |                                    |
>  |- btrfs_write_and_wait_transaction()|
>     |- btrfs_write_marked_extents()   |
>        Here we will only writeback    |
>        dirty pages, and tree block X  |
>        no longer has its pages dirty, |
>        it will no be written back.    |
> 
> Thus those tree blocks don't get written back and cause above fsid
> mismatch during scrub.
> 
> [FIX]
> Just bring back the check of the old code, with added commt on why we
> should not clear dirty flag unconditionally.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This patch should just be used for testing.
> 
> The proper fix would be an update of the series "extent buffer dirty
> cleanups", which should remove the patch "btrfs: do not check header
> generation in btrfs_clean_tree_block" completely.

I've removed the sereis from misc-next and will add it to for-next later
so we have fewer errors in the testing runs until the end of the year.
