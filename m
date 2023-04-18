Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4176E7019
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 01:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDRXzS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 19:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDRXzR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 19:55:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318387AB2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 16:55:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2788219C1;
        Tue, 18 Apr 2023 23:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681862114;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CptEXHeKAfPRzkRrU2i0Si5b37bKRUFGEKBOhdohqTM=;
        b=2rJoEtIIaEe0u60mWNbxenzr8GQFTGKL2g6mVskz1eKmA3M93TBMKqjoM1PpMOGmeIziXv
        giL8gGWODnp/MKteGOs5uqUZ7G+RXY3D/ti1WOzPraX+oR/BSLAnKig4OZQyyKlZ1YN6Gw
        jK915Fnie+15D8/Zz/rZK9opKdJvwUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681862114;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CptEXHeKAfPRzkRrU2i0Si5b37bKRUFGEKBOhdohqTM=;
        b=Pn8y5APcJum9JBpbdJvJjsP+Jg86SqzeO1wC/cirx0teJJCdn6PwdWrP/SmcfySqaocNte
        BydsmoB+0BxMQNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB07613413;
        Tue, 18 Apr 2023 23:55:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RrwxLOItP2SNbgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Apr 2023 23:55:14 +0000
Date:   Wed, 19 Apr 2023 01:55:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Torstein Eide <torsteine@gmail.com>
Subject: Re: [PATCH] btrfs-progs: logical-resolve: fix the subvolume path
 resolution
Message-ID: <20230418235505.GU19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230417094810.42214-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417094810.42214-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 17, 2023 at 05:48:10PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a bug report that "btrfs inspect logical-resolve" can not even
> handle any file inside non-top-level subvolumes:
> 
>  # mkfs.btrfs $dev
>  # mount $dev $mnt
>  # btrfs subvol create $mnt/subv1
>  # xfs_io -f -c "pwrite 0 16k" $mnt/subv1/file
>  # sync
>  # btrfs inspect logical-resolve 13631488 $mnt
>  inode 257 subvol subv1 could not be accessed: not mounted
> 
> This means the command "btrfs inspect logical-resolve" is almost useless
> for resolving logical bytenr to files.
> 
> [CAUSE]
> "btrfs inspect logical-resolve" firstly resolve the logical bytenr to
> root/ino pairs, then call btrfs_subvolid_resolve() to resolve the path
> to the subvolume.
> 
> Then to handle cases where the subvolume is already mounted somewhere
> else, we call find_mount_fsroot().
> 
> But if that target subvolume is not yet mounted, we just error out, even
> if the @path is the top-level subvolume, and we have already know the
> path to the subvolume.
> 
> [FIX]
> Instead of doing unnecessary subvolume mount point check, just require
> the @path to be the mount point of the top-level subvolume.

This is a change in the semantics of the command, can't we make it work
on non-toplevel subvolumes instead? Access to the mounted toplevel
subvolume is not always provided, e.g. on openSUSE the subvolume layout
does not mount 5 and there are likely other distros following that
scheme.
