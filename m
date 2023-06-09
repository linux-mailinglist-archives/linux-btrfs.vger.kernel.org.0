Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462DB72A0C2
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 18:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFIQ6K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjFIQ6H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 12:58:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18A3A8D
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 09:58:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 38F1521A86;
        Fri,  9 Jun 2023 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686329884;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OTLTzmnSPX43SUvtAv/Z9fpiwOMggMce4mErt/NZRGM=;
        b=hConMlS2ez8GohcMBcJfCmnORWRTl9Feexakd9aO90GTkTAGh1A4H0kc+Ks0vtcDcEAH0p
        g4NJfnjIslIUt8qBQCWHae7rIk3h3Gjc9LRUsswPwV7Z9unF0qXOzRkSbPvhW11RzvBLiW
        K4jtyjuvo8WrZTRIesNSHMYYSgs9L80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686329884;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OTLTzmnSPX43SUvtAv/Z9fpiwOMggMce4mErt/NZRGM=;
        b=8ojID/+5aDdtM5sdzpO+VjPyzaXDi7znlZze9OHHSU0oa9yiXYRPsfG7yr0bMFY++ufwZQ
        3BWAnC8LDJiukAAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2BF492C23B;
        Fri,  9 Jun 2023 16:58:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6AF14DA85A; Fri,  9 Jun 2023 18:51:48 +0200 (CEST)
Date:   Fri, 9 Jun 2023 18:51:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/13] btrfs: some fixes and updates around handling
 errors for tree mod log operations
Message-ID: <20230609165148.GA12828@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1686219923.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 08, 2023 at 11:27:36AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This mostly helps avoid some unnecessary enomem failures when logging
> tree mod log operations and replace some BUG_ON()'s when dealing with
> such failures. There's also 2 bug fixes (the first two patches) and
> some cleanups. More details on the changelogs.
> 
> V2: Add explicit error messages in patches 8/13 and 9/13.
>     Add missing unlock and ref count drop of 'right' extent buffer to patch 12/13.
>     Add missing extent buffer ref count drops for right and mid extent buffers in
>     error paths of balance_level() to patch 13/13.
>     Fix subject of patch 2/13 (removed duplicated word).
>     Added Reviewed-by tags where appropriate.
> 
> Filipe Manana (13):
>   btrfs: add missing error handling when logging operation while COWing extent buffer
>   btrfs: fix extent buffer leak after tree mod log failure at split_node()
>   btrfs: avoid tree mod log ENOMEM failures when we don't need to log
>   btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()
>   btrfs: do not BUG_ON() on tree mod log failure at balance_level()
>   btrfs: rename enospc label to out at balance_level()
>   btrfs: avoid unnecessarily setting the fs to RO and error state at balance_level()
>   btrfs: abort transaction at balance_level() when left child is missing
>   btrfs: abort transaction at update_ref_for_cow() when ref count is zero
>   btrfs: do not BUG_ON() on tree mod log failures at push_nodes_for_insert()
>   btrfs: do not BUG_ON() on tree mod log failure at insert_new_root()
>   btrfs: do not BUG_ON() on tree mod log failures at insert_ptr()
>   btrfs: do not BUG_ON() on tree mod log failures at btrfs_del_ptr()

Added to misc-next, thanks.
