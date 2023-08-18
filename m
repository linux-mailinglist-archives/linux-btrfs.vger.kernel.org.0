Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE37278103B
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378589AbjHRQXC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 12:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378624AbjHRQWl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 12:22:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B326A4
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 09:22:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DF9921898;
        Fri, 18 Aug 2023 16:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692375758;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuQZRfpweoD6f6kk33VTDDn0SyIYhNjdULDoZV+V9d0=;
        b=NRfVG3r5uW2Lp9zJfq7F5oz0fJ/cR9L4nH6M5MWJ7zmJ3/piqU5HZEy6L6MoCmHCUc5Ibl
        Fms0yEzT2d150kVHqxEnYB7lF0kNCRYqA6DfhhyQjaLsW4ybxrlY/LVE2JpyKZWQZxet+3
        Ur55NVy23GPXZB/0OZU7fhIGR419ezk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692375758;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuQZRfpweoD6f6kk33VTDDn0SyIYhNjdULDoZV+V9d0=;
        b=hpitZ+ySXaMNEqdCSvVvz0fT1PaF+fvXuuO2qGI+xgagMNfFq0hSkbfw8yiNqXYJQS3AnG
        nxpnBKDfEcU4sPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 068C313441;
        Fri, 18 Aug 2023 16:22:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oTaeAM6a32TOeAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 18 Aug 2023 16:22:38 +0000
Date:   Fri, 18 Aug 2023 18:16:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove pointless empty list check when reading
 delayed dir indexes
Message-ID: <20230818161608.GA2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <935cc2c19db41bde25d1ebb2e7d759737678ad51.1691938868.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <935cc2c19db41bde25d1ebb2e7d759737678ad51.1691938868.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 13, 2023 at 04:03:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_readdir_delayed_dir_index(), called when reading a directory, we
> have this check for an empty list to return immediately, but it's not
> needed since list_for_each_entry_safe(), called immediately after, is
> prepared to deal with an empty list, it simply does nothing. So remove
> the empty list check.
> 
> Besides shorter source code, it also slightly reduces the binary text
> size:
> 
>   Before this change:
> 
>     $ size fs/btrfs/btrfs.ko
>        text	   data	    bss	    dec	    hex	filename
>     1609408	 167269	  16864	1793541	 1b5e05	fs/btrfs/btrfs.ko
> 
>   After this change:
> 
>     $ size fs/btrfs/btrfs.ko
>        text	   data	    bss	    dec	    hex	filename
>     1609392	 167269	  16864	1793525	 1b5df5	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

That one has also been in misc-next for some time, thanks.
