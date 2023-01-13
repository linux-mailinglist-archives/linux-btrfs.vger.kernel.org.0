Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD7966987F
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 14:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbjAMN3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 08:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241138AbjAMN2c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 08:28:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96EC186DB
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 05:20:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 723B36B287;
        Fri, 13 Jan 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673616034;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQ0ciKEpZUooPnEEaYEWKwbzAwNyU3dhbzcEtJWkLoI=;
        b=Nwb7rqWmdQcXb0gMhZmMVw9Nh/prNWaOrEVinXK0FmwwF6i+NpUs7AYnkrw2ECcbh51xF0
        9/eNMFoYVn834P2JmwCNgxo3Wn38X2UhZ2LBeMB6xLM8K0IqgCHGxqTiwoCtVQ/VBokUKJ
        1BRrmQTAliZ/WDOoT0ki88UmQ5xDJaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673616034;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQ0ciKEpZUooPnEEaYEWKwbzAwNyU3dhbzcEtJWkLoI=;
        b=wQGXbzLii7twsEYqMPG/Aza5rVByNvwVOA8reZ/Lynfua4l1MAA3J5iUh6c9NjRq7cXQlL
        khxaaTb3qrKMDfAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5525F13913;
        Fri, 13 Jan 2023 13:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ld/fE6JawWOHcgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Jan 2023 13:20:34 +0000
Date:   Fri, 13 Jan 2023 14:14:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
Subject: Re: how to check commit of deletion of subvolumes
Message-ID: <20230113131458.GU11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <368973486.82613591.1673613848596.JavaMail.zimbra@helmholtz-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <368973486.82613591.1673613848596.JavaMail.zimbra@helmholtz-muenchen.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 13, 2023 at 01:44:08PM +0100, Lentes, Bernd wrote:
> Hi,
> 
> yesterday, about 20 hours ago, i deleted 9 snapshots from a BTRFS volume.
> I know that the space is not available immediately, because BTRFS commits in the background.
> But currently, 20 hours later, i just have 1GB more space available.
> Is there a way to check the commit of BTRFS ? To see if it's done or still running ?
> I know about btrfs subvolume sync, but i am unsure about the syntax.
> 
> This is what i deleted:
>   513  2023-01-12 17:37:05 btrfs sub delete /.snapshots/1/snapshot/
>   514  2023-01-12 17:37:22 btrfs sub delete /.snapshots/2/snapshot/
>   515  2023-01-12 17:37:39 btrfs sub delete /.snapshots/15/snapshot/
>   519  2023-01-12 17:39:51 btrfs sub delete /.snapshots/16/snapshot/
>   520  2023-01-12 17:39:57 btrfs sub delete /.snapshots/17/snapshot/
>   521  2023-01-12 17:40:04 btrfs sub delete /.snapshots/18/snapshot/
>   522  2023-01-12 17:40:10 btrfs sub delete /.snapshots/19/snapshot/
>   523  2023-01-12 17:40:21 btrfs sub delete /.snapshots/20/snapshot/
>   524  2023-01-12 17:40:30 btrfs sub delete /.snapshots/21/snapshot/
>   525  2023-01-12 17:40:35 btrfs sub delete /.snapshots/22/snapshot/
> 
> When i now invoke a sync:
> su084632:~ # btrfs subvolume sync /
> su084632:~ # btrfs subvolume sync /.snapshots
> su084632:~ # btrfs subvolume sync /.snapshots/
> su084632:~ # btrfs subvolume sync /.snapshots/15/
> su084632:~ #
> 
> the command is executed immediately and the prompt returns so too.
> 
> Does that mean the commit is done or do i missunderstood the syntax from sync ?

The original path is lost once the subvolume is deleted so you need to
compare the ids and cannot use the path for 'subvolume sync'.  You can
check if the deleted subvolumes are listed in 'btrfs subvolume list -d'.

If the 'subvolume sync' command returns it means there are no remaining
subvolumes to clean, so by that I'd assume all the related data have
been deleted.

If space is not reclaimed after deletion it's usually because there's
some open file left. This applies to subvolumes too, so you may need to
check 'lsof'.
