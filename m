Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5946FFD7C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 01:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbjEKXyk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 19:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKXyj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 19:54:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D32119
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 16:54:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EAD31201AF;
        Thu, 11 May 2023 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683849276;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o7j4UeJoKfGexZSC0Ndy0ZBm+kEh70Julyxd4M+viEo=;
        b=wXiR8x8QIgSA3KU+DegStBFzLToUis61TKrWjn5gdUR2DDK5WVl27115DU6vQ6jZzDAKaR
        dFDHzffdeQjZ/SVJ2xXMoSN8uaiGz5LAlCQ1V1OXJhyFka0Wl7dtwynHhbIkgywtxnSHcj
        sdvL1a05Na47Lrzt28uhZHRwIZ9M5DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683849276;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o7j4UeJoKfGexZSC0Ndy0ZBm+kEh70Julyxd4M+viEo=;
        b=b8X5xtIoNXV0mQW+ECGQo/ux+3UsOR9cwzpBIQ2TnMp7N1DBTWSs+/7Dxade3yN6QMmn7a
        dG6r8B8KHlwJIuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5D98138FA;
        Thu, 11 May 2023 23:54:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O1p/LzyAXWQbUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 11 May 2023 23:54:36 +0000
Date:   Fri, 12 May 2023 01:48:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: trigger orphan inodes cleanup during sync
 ioctl
Message-ID: <20230511234836.GB32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <79d32abc0d6c1a3afcf9224bd44875f5594c80b6.1683848508.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d32abc0d6c1a3afcf9224bd44875f5594c80b6.1683848508.git.wqu@suse.com>
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

On Fri, May 12, 2023 at 07:42:05AM +0800, Qu Wenruo wrote:
> There is an internal error report that scrub found an error in an orphan
> inode's data.
> 
> However there are very limited ways to cleanup such orphan inodes:
> 
> - btrfs_start_pre_rw_mount()
>   This happens at either mount, or RO->RW switch.
>   This is not a valiable solution for rootfs which may not be unmounted
>   or RO mounted.
> 
>   Furthermore this doesn't cover every subvolume, it only covers the
>   currently cached subvolumes.
> 
> - btrfs_lookup_dentry()
>   This happens when we first lookup the subvolume dentry.
>   But dentry can be cached thus it's not ensured to be triggered every
>   time.
> 
> - create_snapshot()
>   This only happens for the created snapshot, not the source one.
> 
> This means if we didn't trigger orphan items cleanup, there is really no
> way to manually trigger it.
> 
> Thus this patch would add a manual trigger for sync ioctl.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> Although this patch is very small, it involves a behavior change and
> hugely delay the sync ioctl.

I think this is ok, sync is expected to do all it needs and be
potentially slow. We once extended sync to start subvolume cleanup,
which is not slowing down sync itself but is adding more semantics to
it.

The dentry lookup that starts orphan cleanup is something that I'd
otherwise consider sufficient but if there's a report it is not enough.
Also we can't recommend a workaround to cd into a random directory that
was not used recently, we don't know the state of the dentry cache so
making it explicit in sync() which is a known slow operation is quite
reasonable.
