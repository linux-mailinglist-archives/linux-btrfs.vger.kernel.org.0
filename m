Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273C86A7535
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 21:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCAUWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 15:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCAUWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 15:22:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACDC10C3
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 12:22:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1CDE11FE49;
        Wed,  1 Mar 2023 20:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677702158;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCYg9SjMC+ImM8+vjx4N1GPQjwVO/ybHZNPydz73IB8=;
        b=Ng01PHfzFynCA74KO6l4ETjfXn892MFQhjgX+C+Z2+CBT75/NzK9GRmt4DrP/OjP7bIwpi
        8uz0R04Dl57WgRoe+BUfW7Zw8SNEuMRKuZE09syOsItTuUYvGO1kgXPTP9C9SMgTEy/4we
        Vcs6kBYKzugVpV7YpkvlGTcFEOEnL9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677702158;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCYg9SjMC+ImM8+vjx4N1GPQjwVO/ybHZNPydz73IB8=;
        b=eTzYgrJHlPtYAP625PGvyP2J/mKMheo55Wc5fyeLonl4X3X6uaZavS2jRB6bo8KAnRS4/D
        fAyfTx7Qsv0joDBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEA8613A3E;
        Wed,  1 Mar 2023 20:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0qewLQ20/2MQcgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Mar 2023 20:22:37 +0000
Date:   Wed, 1 Mar 2023 21:16:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: handle missing chunk mapping more gracefully
Message-ID: <20230301201637.GA10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7ff90508841683ca3aaeb5c84e27d7d823218146.1670389796.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff90508841683ca3aaeb5c84e27d7d823218146.1670389796.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 07, 2022 at 01:09:59PM +0800, Qu Wenruo wrote:
> [BUG]
> During my scrub rework, I did a stupid thing like this:
> 
>         bio->bi_iter.bi_sector = stripe->logical;
>         btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
> 
> Above bi_sector assignment is using logical address directly, which
> lacks ">> SECTOR_SHIFT".
> 
> This results a read on a range which has no chunk mapping.
> 
> This results the following crash:
> 
>  BTRFS critical (device dm-1): unable to find logical 11274289152 length 65536
>  assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
>  ------------[ cut here ]------------
> 
> Sure this is all my fault, but this shows a possible problem in real
> world, that some bitflip in file extents/tree block can point to
> unmapped ranges, and trigger above ASSERT().
> 
> [PROBLEMS]
> In above call chain, there are 2 locations not properly handling the
> errors:
> 
> - __btrfs_map_block()
>   If btrfs_get_chunk_map() returned error, we just trigger an ASSERT().
> 
> - btrfs_submit_bio()
>   If the returned mapped length is smaller than expected, we just BUG().
> 
> [FIX]
> This patch will fix the problems by:
> 
> - Add extra WARN_ON() if btrfs_get_chunk_map() failed
>   I know syzbot will complain, but it's better noisy for fstests.
> 
> - Replace the ASSERT()
>   By returning the error.
> 
> - Handle the error when mapped length is smaller than expected length
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This does not apply since the recent bio and checksum rework, please
resend, thanks.
