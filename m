Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73747792797
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbjIEQDa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354701AbjIENgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 09:36:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9C4191
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 06:36:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D67D21ACF;
        Tue,  5 Sep 2023 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693920994;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szXHBbUaVaJPcZnxAb1iLDUGnWAhBDvZ6R/GfcCuWFE=;
        b=k07I9x8r9/B5nGsGUBQ/Q6ApU80imCpY4o2UnvbJJvbcASXHkzcmMMsoVDfwAhxNt56CAT
        7q7pTlCdzuIZaaprLaGv/7w1/8vwGLKgm7ak6X9HHDjOofKXAm3K0Gx7uSy7uuu4qU4CBV
        GUGCjIkIHIGHiNIfltdFCbmM5Bn0Smg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693920994;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szXHBbUaVaJPcZnxAb1iLDUGnWAhBDvZ6R/GfcCuWFE=;
        b=oMIw1Ej8eUU+K0UYxnE7XhofhNtRmw9nSlL6ocX+qxIsNcDQlMqSjbC7uxH332peDFS0ih
        MaHs4I2S5iqtAjAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC8AB13499;
        Tue,  5 Sep 2023 13:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FIvYNOEu92S3OgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 13:36:33 +0000
Date:   Tue, 5 Sep 2023 15:29:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not require EXTENT_NOWAIT for
 btrfs_redirty_list_add()
Message-ID: <20230905132954.GZ14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bd9358f329b4574724250f1c0ba1ef2939f1feaa.1693293259.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9358f329b4574724250f1c0ba1ef2939f1feaa.1693293259.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 29, 2023 at 03:14:25PM +0800, Qu Wenruo wrote:
> The flag EXTENT_NOWAIT is a special flag to notify extent-io-tree code
> that this operation should not sleep for the extent state preallocation.
> 
> However for btrfs_redirty_list_add(), all callers are able to sleep:
> 
> - clean_log_buffer()
>   Just 2 lines before, we call btrfs_pin_reserved_extent(), which calls
>   pin_down_extent(), and that function does not require EXTENT_NOWAIT.
>   Thus we're safe to call it without EXTENT_NOWAIT.
> 
> - btrfs_free_tree_block()
>   This function have several call sites which trigger tree read, e.g.
>   walk_up_proc(), thus we're safe to call it without EXTENT_NOWAIT.
> 
> Thus there is no need to require EXTENT_NOWAIT flag.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks. I did some research if we need the
EXTENT_NOWAIT at all, it's obscured by a lot of code refactoring but
it's still needed due to

add_extent_mapping
  extent_map_device_set_bits

done under extent_map_tree::lock (rwlock_t), added in 1c11b63eff2a
("btrfs: replace pending/pinned chunks lists with io tree").
