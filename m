Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3909860BBA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiJXVIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 17:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiJXVHp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 17:07:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5F3BA27E
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 12:15:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BFC9321C5F;
        Mon, 24 Oct 2022 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666621002;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Vne9N0yVSV3rTsID8uImOt/OPW1aDWy5adjrgYmntI=;
        b=Sjg3VY+Hrf/85OrTPDE3jvSV4WwqtgeVVtCtWjCe6+CpEBi8f5krTup42+5UoFbv7DUsPM
        Ao9njFgJwmAad8Q6exrFvVHn3hytAq+5lEqXtmoifon8TFbKO3k3ytTE4FhxVgqd0pURij
        8KSvzzZH+z2a+3UZ0KFKfH2GEIlMyLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666621002;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Vne9N0yVSV3rTsID8uImOt/OPW1aDWy5adjrgYmntI=;
        b=UA/RJTb27LtRc+++ieDZfis7CHVwA5EB0DQzIxXLo2j1ECeg9BXc7xNx0wsYwDQcCp6vxN
        unqPO4/nVuKDNjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9219E13A79;
        Mon, 24 Oct 2022 14:16:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id enxyIkqeVmP7GQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 24 Oct 2022 14:16:42 +0000
Date:   Mon, 24 Oct 2022 16:16:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: WARN_ON in __writeback_inodes_sb_nr when btrfs mounted with
 flushoncommit
Message-ID: <20221024141629.GD5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221024041713.76aeff42@nvm>
 <20221024123746.7a9d9bfd@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024123746.7a9d9bfd@nvm>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 24, 2022 at 12:37:46PM +0500, Roman Mamedov wrote:
> On Mon, 24 Oct 2022 04:17:13 +0500
> Roman Mamedov <rm@romanrm.net> wrote:
> 
> > Hello,
> > 
> > Just wanted to report that I still get the same warning with flushoncommit as
> > someone posted[1][2] back in 2017, also today on kernel 5.10.149. Was that
> > supposed to be fixed? Or maybe fixed in 6.0+?
> > 
> > Thanks
> > 
> > [1] https://www.spinics.net/lists/linux-btrfs/msg72483.html
> > [2] https://marc.info/?l=linux-btrfs&m=151315564008773
> 
> I found that this might have been fixed:
> https://lore.kernel.org/linux-btrfs/20220208224129.GI12643@twin.jikos.cz/

It's mentioned at https://btrfs.readthedocs.io/en/latest/Feature-by-version.html

and "Also backported to 5.15.27 and 5.16.13".

> But not backported to stable series, why not? Seems to be a small and simple
> fix.

5.10 may still be a reasonable target for backport. It does not apply
cleanly and the 5.10 version tries to do some flushing of subvolume
trees, which was removed later on, there may be some dependencies too.
