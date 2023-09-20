Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623D37A87B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjITO4z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 10:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjITO4y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 10:56:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3CA9E;
        Wed, 20 Sep 2023 07:56:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A34221BAE;
        Wed, 20 Sep 2023 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695221806;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tutVI14zKnNxV2nZaKyZknfxWGAJwT6vaxWMVN+Q2Lg=;
        b=ggcLv5KEBFHcWgMaI6WySC4BhYLRbMAs5xODmDPEeobiLxNgFE7XarR2l/rXyxf6uAfpP9
        9PmWDwSdICt0CjBcV7m+cKRXCJuDCkPz2R1sagKU0K9JKzDIoi4KWRDs9ylkVv/0j0KL2+
        aa3sSosUXPnIZs0Im2UMacsd568aE8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695221806;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tutVI14zKnNxV2nZaKyZknfxWGAJwT6vaxWMVN+Q2Lg=;
        b=T6keeILHL28/ROCPI1+TUf0fb94BUmQuA/83qAXeEy41CNNlVDjV83REgjLxgRCSPfbUTj
        hzcIMMZ5mm/eWOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D782D132C7;
        Wed, 20 Sep 2023 14:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eAO1My0IC2WwMwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Sep 2023 14:56:45 +0000
Date:   Wed, 20 Sep 2023 16:50:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: RAID stripe tree updates
Message-ID: <20230920145011.GB2268@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230920-rst-updates-v2-0-b4dc154a648f@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920-rst-updates-v2-0-b4dc154a648f@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 20, 2023 at 02:31:16AM -0700, Johannes Thumshirn wrote:
> Here is the second batch of updates for the RAID stripe tree patchset in
> for-next which address some of the review comments.
> 
> ---
> - Link to first batch: https://lore.kernel.org/r/20230918-rst-updates-v1-0-17686dc06859@wdc.com
> 
> ---
> Johannes Thumshirn (2):
>       btrfs: check for incompat bit in btrfs_insert_raid_extent
>       btrfs: check for incompat bit in btrfs_need_stripe_tree_update
> 
>  fs/btrfs/raid-stripe-tree.c | 2 +-
>  fs/btrfs/raid-stripe-tree.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Folded, thanks.
