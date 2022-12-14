Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B80E64CEF9
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 18:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLNRt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 12:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLNRt4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 12:49:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5BC267
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 09:49:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25E392015C;
        Wed, 14 Dec 2022 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671040194;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hSZ5koF+TmWlxMtJUvlzpqRw4S1eseUwf10V3lOsKi0=;
        b=3adeKyCLmXoHSbd7SSYyRl/6bfHKyinuUxQIs6mx7cisYC7ehXAMGnP/Dd7goSSqq2qY46
        qvRAK4vpz3RfAEEezgrTQOmD74hBELMs5tlBVoTec9ye1l1BkJMIPzrr0Q6aP5rWPzA0K8
        uXT0HYs++oEsXs9ZsYWINmPt6k5Yof0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671040194;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hSZ5koF+TmWlxMtJUvlzpqRw4S1eseUwf10V3lOsKi0=;
        b=27XVrg9dlFQJ0GmwEUhV0K6qebtl0elWkUYDD+beAZulaa4eF4TkzU0lCw5PhD9kPuLler
        uMhESYF+KVykIRCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC300138F6;
        Wed, 14 Dec 2022 17:49:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SWq8OMEMmmNDFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Dec 2022 17:49:53 +0000
Date:   Wed, 14 Dec 2022 18:49:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8] extent buffer dirty cleanups
Message-ID: <20221214174911.GE10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1670451918.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1670451918.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 07, 2022 at 05:28:03PM -0500, Josef Bacik wrote:
> Hello,
> 
> While sync'ing ctree.c to btrfs-progs I noticed we have some oddities when it
> comes to how we deal with the extent buffer being dirty.  We have
> btrfs_clean_tree_block, which is sort of meant to be run against extent buffers
> we've modified in this transaction.  However we have some other places where
> we've open coded the same work without the generation check.  This makes it kind
> of confusing, and is inconsistent with how we deal with the
> fs_info->dirty_metadata_bytes.
> 
> So clean this stuff up so we have one helper we use for setting the extent
> buffer dirty (btrfs_mark_buffer_dirty) and one for clearing dirty
> (btrfs_clear_buffer_dirty).  This makes everything more consistent and clean
> across the board.  I've additionally cleaned up a random writeback thing we had
> in tree-log that I noticed while doing these cleanups.  Thanks,
> 
> Josef
> 
> Josef Bacik (8):
>   btrfs: always lock the block before calling btrfs_clean_tree_block
>   btrfs: do not check header generation in btrfs_clean_tree_block
>   btrfs: do not set the header generation before btrfs_clean_tree_block
>   btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
>   btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
>   btrfs: rename btrfs_clean_tree_block => btrfs_clear_buffer_dirty
>   btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
>   btrfs: remove btrfs_wait_tree_block_writeback

Added to misc-next, thanks.
