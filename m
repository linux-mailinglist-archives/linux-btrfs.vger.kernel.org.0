Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A51D6BBCB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 19:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjCOSvK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCOSvJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 14:51:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A644FA93
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 11:51:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55BB7219DF;
        Wed, 15 Mar 2023 18:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678906267;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79d+p86DzF/2sTHpk9KLpJIjgRPW933XXOLhBhhdRMg=;
        b=LOjggpAQJKQyBlIK7pH1TvKSnyr7sNJX555MsvEWVCdhQC7jbRzAPYaM62z4MXsfIohZAZ
        bUVNy59Sj2oXuXb54FW+Qyj3K4Ew4Uw7+zwB+YQQugnNG1WjttT/bH8HudWpf2gUDAN4l1
        KYVj01XODzPvMAUFA/Bj7uYknIS9DEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678906267;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79d+p86DzF/2sTHpk9KLpJIjgRPW933XXOLhBhhdRMg=;
        b=HZccVi7qzBZYYgpaps35PjbjdLh0P7cQWA0v8yFkQG6UmY7jjEHgefBbAI7pDloTJ34k/n
        EoirDB8QBynCdEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3082913A00;
        Wed, 15 Mar 2023 18:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WYQJC5sTEmQzUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Mar 2023 18:51:07 +0000
Date:   Wed, 15 Mar 2023 19:45:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: cleanup btrfs_add_compressed_bio_pages
Message-ID: <20230315184500.GU10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230314165110.372858-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314165110.372858-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 14, 2023 at 05:51:08PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> when I factored out btrfs_add_compressed_bio_pages from the two duplicate
> copies a while ago I left the code very much as it was then except for
> splitting out the helper.  But this helper is very convoluted for what
> it does, so this tiny series cleans it up a bit.
> 
> Diffstat:
>  compression.c |   45 ++++++++++++---------------------------------
>  1 file changed, 12 insertions(+), 33 deletions(-)

Added to misc-next, thanks.
