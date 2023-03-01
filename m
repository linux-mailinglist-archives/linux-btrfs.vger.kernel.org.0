Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEEF6A7377
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 19:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjCASbu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 13:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCASbs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 13:31:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C84BE87
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 10:31:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C76021AC6;
        Wed,  1 Mar 2023 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677695505;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9EzAEnKt5gkmTAe81Tz0pZEm4eaAJzOD6qY8FlKZE5A=;
        b=BTxg9tz9fRaxPSLGHBy+a5QUnaXi54v0omm02deVy5P/ZfjEczzYftRv8InStIl1iA1fC8
        bz9fL6C28UtykvJ6NEHcw6U3jh2vqdRnJKD9KVZClATQns+ZcExqeZkITnAkH8/pSALqtm
        P6rDhxUjFNJ/OaR/hduMjF7ZLNvNGo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677695505;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9EzAEnKt5gkmTAe81Tz0pZEm4eaAJzOD6qY8FlKZE5A=;
        b=R0xIjcBE78809NwcNJYp9QeAbKMfdOk4m7DsZVOFCIM1kBIy6qf78DH4YPvatux1DMA5Pp
        jP1q6aUqUGMjbqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F82313A63;
        Wed,  1 Mar 2023 18:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tf7XDBGa/2OAQQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Mar 2023 18:31:45 +0000
Date:   Wed, 1 Mar 2023 19:25:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 6.2
Message-ID: <20230301182545.GW10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230228192335.12451-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228192335.12451-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 28, 2023 at 08:23:35PM +0100, David Sterba wrote:
> Hi,
> 
> btrfs-progs version 6.2 have been released.
> 
> Changelog:
>    * receive: fix a corruption when decompressing zstd extents
>    * subvol sync: print total number and deletion progress
>    * accelerated hash algorithm implementations in fallback mode on x86_64
>    * fi mkswapfile: new option --uuid
>    * new global option --log=level to set the verbosity level directly
>    * other:
>       * experimental: update checksum conversion (not usable yet)
>       * build actually requires -std=gnu11
>       * refactor help option formatting, auto wrap long lines
> 
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Fixed version is in devel, I did some more checks on the CI images and
the OBS build on different arches also pass so it should be fine. Bugfix
release will be in a day.
