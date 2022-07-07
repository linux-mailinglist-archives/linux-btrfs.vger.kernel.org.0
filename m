Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD0056A823
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 18:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiGGQb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiGGQbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 12:31:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344B02A414
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 09:31:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D43EE21FF0;
        Thu,  7 Jul 2022 16:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657211483;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHMKhlp7/eLV3yGHGYvVRC/zpkChY7dKLOB5w0yBH0s=;
        b=qfnOyU0l2s2smAgIDprHXDyS0z4uj0l4OqXWoX3BEKSNiysgIiPS99Kpsh7CNhC36M2MCm
        DZoLmwMHp/OQXiBvfQySczEb/76A4wcHD4NV6ksbJ21i9146O65Wsl82t8ofb5lp5Hgu4x
        KIJ8yubi/zquLIGJ4GvpkH4oJDI2NFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657211483;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHMKhlp7/eLV3yGHGYvVRC/zpkChY7dKLOB5w0yBH0s=;
        b=bByIKGfWtCWxGXLEqL3znHoR51Pyb0LBH+ZuBzh3XOgWsZXKdSvpW/mSaGS8/guHVwt+KQ
        Sx3sYY/tM0Txy0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABE8313A33;
        Thu,  7 Jul 2022 16:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vLgVKVsKx2LxZgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 16:31:23 +0000
Date:   Thu, 7 Jul 2022 18:26:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove the inode cache check at
 btrfs_is_free_space_inode()
Message-ID: <20220707162637.GF15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <41a45a354624cbe3bc1ccfb100af7699e73090d3.1657102391.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a45a354624cbe3bc1ccfb100af7699e73090d3.1657102391.git.fdmanana@suse.com>
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

On Wed, Jul 06, 2022 at 11:14:23AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The inode cache feature was removed in kernel 5.11, and we no longer have
> any code that reads from or writes to inode caches. We may still mount a
> filesystem that has inode caches, but they are ignored.
> 
> Remove the check for an inode cache from btrfs_is_free_space_inode(),
> since we no longer have code to trigger reads from an inode cache or
> writes to an inode cache. The check at send.c is still needed, because
> in case we find a filesystem with an inode cache, we must ignore it.
> Also leave the checks at tree-checker.c, as they are sanity checks.
> 
> This eliminates a dead branch and reduces the amount of code since it's
> in an inline function.
> 
> Before:
> 
> $ size fs/btrfs/btrfs.ko
>    text	   data	    bss	    dec	    hex	filename
> 1620662	 189240	  29032	1838934	 1c0f56	fs/btrfs/btrfs.ko
> 
> After:
> 
> $ size fs/btrfs/btrfs.ko
>    text	   data	    bss	    dec	    hex	filename
> 1620502	 189240	  29032	1838774	 1c0eb6	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
