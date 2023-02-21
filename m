Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A2D69E64D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 18:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjBURt5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 12:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjBURt4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 12:49:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FC82DE48
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 09:49:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4A14E5C880;
        Tue, 21 Feb 2023 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677001794;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y967ERXomHlBSoVYZhfCatqPKqeehjiQ/HN4t4TLEHA=;
        b=N+puVBHLwRoVP9BbgAhJjXYjtI/RLMeLR2RhdrfufoC3DJwcYo6rNVOoPrgRNxy8N2GEIu
        AahCUNOZ2zs8Bg6oUTGIIR0NjpCyV4ter4Zh6VzcINhj8Ze+RCNU+aJbQxMChOO7jQXv7t
        jPf8j8r55Jqkbv3wK9PVadB7eCoS3Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677001794;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y967ERXomHlBSoVYZhfCatqPKqeehjiQ/HN4t4TLEHA=;
        b=CZ8h9+VYdKiQvUARCGefUdwJPdYW+PNsA1rgLOxrzdLjH+kucllkIk6eRq69/CXed/pKwS
        gDszD4dz0GBzInCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FFB113481;
        Tue, 21 Feb 2023 17:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sO7QBkIE9WPeRgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Feb 2023 17:49:54 +0000
Date:   Tue, 21 Feb 2023 18:43:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: fsfeatures: remove the EXPERIMENTAL
 flags for block group tree runtime feature
Message-ID: <20230221174358.GN10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <facda201bc63edb92c2cc58339a172479ff4eb95.1676361293.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facda201bc63edb92c2cc58339a172479ff4eb95.1676361293.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 14, 2023 at 03:55:28PM +0800, Qu Wenruo wrote:
> This block group tree support is already in the v6.1 kernel, and I know
> some adventurous users are already recompiling their progs to take
> advantage of the new feature.
> 
> Especially the block group tree feature would reduce the mount time from
> several minutes to several seconds for one of my friend.
> (Of course, he is doing an offline convert using btrfstune)
> 
> I see now reason to hide this feature behind experimental flags.
> 
> This patch would:
> 
> - Remove EXPERIMENTAL tag for "block-group-tree" features
>   This includes both -R and -O
> 
> - Remove EXPERIMENTAL tag for "btrfstune -b" option

Before a feature is promoted from experimental it needs to be finalized,
which means test, polish the user interface and write documentation if
missing.

You did not change the option name and kept the single letter -b, I
think I said that this was fine for the experimental status but not for
the final version.

Also the reverse conversion (bgt -> extent tree) is still missing,
though it's not the important one it would be nice to have it there for
completeness.
