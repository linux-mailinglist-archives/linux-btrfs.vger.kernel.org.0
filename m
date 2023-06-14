Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1E7309F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 23:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjFNVrW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjFNVrV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 17:47:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ECA2689
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 14:47:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CCE441FD8F;
        Wed, 14 Jun 2023 21:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686779238;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMz8AF72GI95PsNtShDlFJpGTQplK9cmk0PU6H3ZPkk=;
        b=NsBBEJxHfTflQjt74m1H4voFYLypDEHlQQjHIiYqLT6Iq55cpvKejr7Uv1KiDcfyFGtmi6
        dKZA4+rYZsTmHpMIuHkl9FQ8XOdX3Vw6FZ2Lc1cFiw2D7mOhHpX5fwrVLavog24cj8oW3k
        XVAR2o+U9eR9LqGrq56lYBpfSlev0MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686779238;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMz8AF72GI95PsNtShDlFJpGTQplK9cmk0PU6H3ZPkk=;
        b=gwJyEfN8IebHJtvfqjgGNSnqXW1QDxcQ47YPTIU3+PVQOr9x8/0W9jNtO3pdI63c1K8vUm
        BEbTUcamUh6pSCDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A57D31391E;
        Wed, 14 Jun 2023 21:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VqZ+J2Y1imQ5OAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Jun 2023 21:47:18 +0000
Date:   Wed, 14 Jun 2023 23:40:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not BUG_ON on failure to get dir index for new
 snapshot
Message-ID: <20230614214058.GP13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5563d2c9f143485c62d3ab07446ed1f77f765a2c.1686670878.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5563d2c9f143485c62d3ab07446ed1f77f765a2c.1686670878.git.fdmanana@suse.com>
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

On Tue, Jun 13, 2023 at 04:42:16PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During the transaction commit path, at create_pending_snapshot(), there
> is no need to BUG_ON() in case we fail to get a dir index for the snapshot
> in the parent directory. This should fail very rarely because the parent
> inode should be loaded in memory already, with the respective delayed
> inode created and the parent inode's index_cnt field already initialized.
> 
> However if it fails, it may be -ENOMEM like the comment at
> create_pending_snapshot() says or any error returned by
> btrfs_search_slot() through btrfs_set_inode_index_count(), which can be
> pretty much anything such as -EIO or -EUCLEAN for example. So the comment
> is not correct when it says it can only be -ENOMEM.
> 
> However doing a BUG_ON() here is overkill, since we can instead abort
> the transaction and return the error. Note that any error returned by
> create_pending_snapshot() will eventually result in a transaction
> abort at cleanup_transaction(), called from btrfs_commit_transaction(),
> but we can explicitly abort the transaction at this point instead so that
> we get a stack trace to tell us that the call to btrfs_set_inode_index()
> failed.
> 
> So just abort the transaction and return in case btrfs_set_inode_index()
> returned an error at create_pending_snapshot().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
