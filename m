Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C4362F9DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 17:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiKRQCG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 11:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiKRQCF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 11:02:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8428CF1D
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 08:02:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF69A1FCF9;
        Fri, 18 Nov 2022 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668787321;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9OyXoRhhDZlEtCePADxswMd485y4O6xjTunDNRyDVY=;
        b=UklMbVUUy0ifdbF/WFEO+TQjEUQ8K7X1TmpOC+EHUmLzvVJb9gL0u5/tEuLykyUcG4B5KU
        LXqdGERLr7c5QcinrzBmL6lKfWMmHAv+tzhZGmb25SqmaHXK2KqCzJeAC8DzlmST/gUrxV
        0wGZS9BaURlXdKQ1N/2Uf9f1bSeNc0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668787321;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9OyXoRhhDZlEtCePADxswMd485y4O6xjTunDNRyDVY=;
        b=IvCT7SHwNxWcIZj0XxTtSZUxGLJKBtFxCiPVJ9q5GQO7TC30R5QiPLnEHl/aP4ernJfklP
        mOIcJSW0AszrN7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A06BC13A66;
        Fri, 18 Nov 2022 16:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cu43Jnmsd2NReQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 18 Nov 2022 16:02:01 +0000
Date:   Fri, 18 Nov 2022 17:01:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: move the low-level btrfs_bio code into a separate file v3
Message-ID: <20221118160133.GQ5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221115094407.1626250-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115094407.1626250-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 10:44:03AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this small series creates a new bio.c file (and a bio.h header for it)
> to contain all the "storage" layer code below btrfs_submit_bio.  The
> amount of code sitting below btrfs_submit_bio will grow a lot with
> the "consolidate btrfs checksumming, repair and bio splitting" series,
> so this pure code move series triest to prepare for that by making
> sure we have a neat file to add it to.
> 
> Changes since v2:
>  - rebased against the rcu_string changes in misc-next
> 
> Changes since v1:
>  - rebased to the latest misc-next branch
>  - added a new patch to move struct btrfs_tree_parent_check into a new
>    header to invoide include hell

Added to misc-next, thanks.
