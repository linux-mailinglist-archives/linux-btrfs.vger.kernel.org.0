Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC09506CC8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbiDSMw7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 08:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiDSMw6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 08:52:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3C815813
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 05:50:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AE501F74E;
        Tue, 19 Apr 2022 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650372614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0sKOzrWRyERklVfCfXwEn0UJv65Ihj5a5tXN8Iqupso=;
        b=0sFnP/nmZBxsj6hSoWTviC7xx6x7rqFWVs/9VEZOMqIivkeShZ2D3Kmm7nD7XpDgdstp8B
        slJW51dEDUtxzLdV2vQj9qU1cXfnfuvger75Tdi/DDdzzoNGWl336xSeI+obNHg02jY1Cu
        g7JGTHk+kzmS8UnykaPKoYvSg3GOd6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650372614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0sKOzrWRyERklVfCfXwEn0UJv65Ihj5a5tXN8Iqupso=;
        b=3MvrLcpnylk3hDx8Ta1LL4NB9ZvJRFh6SsDu7eLDREtCN2fU13wqwxMPFjNKlM1eCR4v4T
        NQjduLC5arOmthCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 720B3139BE;
        Tue, 19 Apr 2022 12:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uVkPGwawXmJBdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Apr 2022 12:50:14 +0000
Date:   Tue, 19 Apr 2022 14:46:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: avoid some block group rbtree lock contention
Message-ID: <20220419124611.GA2348@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1649862853.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649862853.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 13, 2022 at 04:20:38PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset allows for better concurrency when accessing the red black
> tree of block groups, which is used very frequently and most accesses are
> read-only, as well as avoid some unnecessary searches in the tree during
> NOCOW writes. Details in the changelogs.
> 
> Filipe Manana (5):
>   btrfs: remove search start argument from first_logical_byte()
>   btrfs: use rbtree with leftmost node cached for tracking lowest block group
>   btrfs: use a read/write lock for protecting the block groups tree
>   btrfs: return block group directly at btrfs_next_block_group()
>   btrfs: avoid double search for block group during NOCOW writes

Added to misc-next, thanks.
