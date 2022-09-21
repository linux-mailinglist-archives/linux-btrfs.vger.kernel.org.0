Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4F25BFAC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 11:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIUJYJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 05:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiIUJXw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 05:23:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B90B874
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 02:23:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D3F31F898;
        Wed, 21 Sep 2022 09:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663752230;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20nBF1cOIDq3q0Jeu7ii/BqFfTUicacUrz3lhCpZMGQ=;
        b=jxxK+Z3DWig6/QEzePNxjX13PhxDq/R7n8yD4o/sJ5CI7t8nZpX6M85dQuWoQRaXUztIle
        nxSuuI1nTQMKDz+Nt09ju4tUxo63Atoev/sboFsAHI1s2APVLoYxCwBoyCrZRcsFVV+Y62
        EIcmeaPVOYuwOT+Id+ksy8xOn7lA7qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663752230;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20nBF1cOIDq3q0Jeu7ii/BqFfTUicacUrz3lhCpZMGQ=;
        b=oDFExaJABTcwe7JOWB7hz9GP7rghDD0lZqrKAM1BRDoSUyvV7F5pYsLm7TIkoWF2bBZNds
        HUywrBO+nrqhWdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1178913A00;
        Wed, 21 Sep 2022 09:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dGhXAybYKmPXRAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Sep 2022 09:23:50 +0000
Date:   Wed, 21 Sep 2022 11:18:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: optimize the argument list for
 submit_extent_page()
Message-ID: <20220921091818.GA32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663046855.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663046855.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 13, 2022 at 01:31:11PM +0800, Qu Wenruo wrote:
> [Changelog]
> v2:
> - Add a patch to remove stale argument from the comments of
>   submit_extent_page()
> 
> - Update the comment of submit_extent_page() to reflect the new arugment
>   list
> 
> The argument list of submit_extent_page() is already a little long.
> 
> Although we have things like page, pg_len, pg_off which can not be saved
> anyway, we can still improve the situation by:
> 
> - Update the stale comment of submit_extent_page()
>   Done by the first patch.
> 
> - Make sure @page, @pg_len, @pg_off are always batched together
>   Just like bio_add_page().
> 
>   This is done by the second page, just switching the position between
>   @page and @disk_bytenr.
> 
> - Move @end_io_func arugment into btrfs_bio_ctrl structure.
> 
> Qu Wenruo (3):
>   btrfs: update the comment for submit_extent_page()
>   btrfs: switch the page and disk_bytenr argument position for
>     submit_extent_page()
>   btrfs: move end_io_func argument to btrfs_bio_ctrl structure

Added to misc-next, thanks.
