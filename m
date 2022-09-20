Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFEB5BE4F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiITLuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 07:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiITLuR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 07:50:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6C86526F
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 04:50:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2032221C2A;
        Tue, 20 Sep 2022 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663674614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYBt32bEadw/gkOo4p8Ej1+37FLDtJOhZQbmOjB4I1o=;
        b=sxCjFJercnIETxUMcnvcXrLHW7JcGPYsLtmjCtkUrs8oTbrZ2/3AxXx/SgJ4TMRRR9co9z
        Ix/3XYEXbX4dVfBnO+7UQHSINcWMy9X3IUQ2AzCP+XnTcnYmxZDOlDvO+sTjjLQwHg0B0c
        AyGmfzLph5tLB0qPj6Pli/FysN7kSRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663674614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYBt32bEadw/gkOo4p8Ej1+37FLDtJOhZQbmOjB4I1o=;
        b=qAK8GekPEqserwAunmyUN10GoX45zBS6mvjJT1XCo35A7891BUfKrPspwS1qcZ0cvNGYHP
        nIPaZYTodu7ObeDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 026D11346B;
        Tue, 20 Sep 2022 11:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n5ZNO/WoKWPWRgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Sep 2022 11:50:13 +0000
Date:   Tue, 20 Sep 2022 13:44:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/15] btrfs: strip out btrfs_fs_info dependencies
Message-ID: <20220920114443.GW32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663196541.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 07:04:36PM -0400, Josef Bacik wrote:
> Part of the cleaning up of ctree.h is being able to move btrfs_fs_info out of
> it.  This is actually pretty difficult because we essentially rely on ctree.h
> being included before everything else, so all other header files have fs_info
> defined for their helpers.
> 
> This series starts this work.  There are a variety of other small moves as well,
> but the bulk is trying to pull any helpers that access fs_info members inside of
> their header files into their respective c files, or alternatively reworking the
> code to drop the dependency.  Thanks,
> 
> Josef
> 
> Josef Bacik (15):
>   btrfs: move btrfs_caching_type to block-group.h
>   btrfs: move btrfs_full_stripe_locks_tree into block-group.h
>   btrfs: move btrfs_init_async_reclaim_work prototype to space-info.h
>   btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h
>   btrfs: remove temporary btrfs_map_token declaration in ctree.h
>   btrfs: move static_assert() for btrfs_super_block into fs.c
>   btrfs: move btrfs_swapfile_pin into volumes.h
>   btrfs: move fs_info struct declarations to the top of ctree.h
>   btrfs: move btrfs_csum_ptr to inode.c
>   btrfs: move the fs_info related helpers closer to fs_info in ctree.h
>   btrfs: move btrfs_ordered_sum_size into file-item.c
>   btrfs: delete btrfs_inode_sectorsize helper
>   btrfs: delete btrfs_insert_inode_hash helper
>   btrfs: use a runtime flag to indicate an inode is a free space inode
>   btrfs: add struct declarations in dev-replace.h

All are safe changes, I've added it to misc-next, except the
static_assert patch (6/15) that would need to be slightly changed.
