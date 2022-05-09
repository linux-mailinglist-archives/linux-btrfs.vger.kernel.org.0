Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F04752059D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 22:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiEIUEa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbiEIUE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 16:04:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41401ACF90
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 13:00:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8552321C27;
        Mon,  9 May 2022 20:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652126430;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwmOEgcv1Y0x5qip+gcljeyy3TFOmZNzEsASDrMDDPY=;
        b=r95SaTcdL0lNqvNyPP43UMWyBlN+U7fyKqHJ0jsAoiSlfsl6K+Q16jkfX2EmtZwShNNsD4
        kohJu+x4muDB9bHQe7JCmoy7dPeD9eplDkVZ62howEr3ZuvoPK5WjQ6Rr5nNooHitsf15b
        tCM6HntOY5KE+lRedG5uDJCbifPpY70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652126430;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwmOEgcv1Y0x5qip+gcljeyy3TFOmZNzEsASDrMDDPY=;
        b=yMJG2qqNKd7YQXlEDO5herbk8K9pJjP7Kcz9Y2p96bLnR7i8Y7GMRrfu+/B1p8eXQgcXRd
        HxHKTsZO6Zj+7VAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5734E132C0;
        Mon,  9 May 2022 20:00:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Uv1SFN5yeWJ2CwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 May 2022 20:00:30 +0000
Date:   Mon, 9 May 2022 21:56:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9] Structre and parameter cleanups
Message-ID: <20220509195616.GI18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1651255990.git.dsterba@suse.com>
 <88811bd1-9a08-ae1b-8140-3e354c118792@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88811bd1-9a08-ae1b-8140-3e354c118792@suse.com>
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

On Tue, May 03, 2022 at 10:57:19AM +0300, Nikolay Borisov wrote:
> 
> 
> On 29.04.22 г. 21:27 ч., David Sterba wrote:
> > Simplify some argument passing, remove too-trivial helpers or unused
> > structure members.
> > 
> > David Sterba (9):
> >    btrfs: sink parameter is_data to btrfs_set_disk_extent_flags
> >    btrfs: remove btrfs_delayed_extent_op::is_data
> >    btrfs: remove unused parameter bio_flags from btrfs_wq_submit_bio
> >    btrfs: remove trivial helper update_nr_written
> >    btrfs: simplify handling of bio_ctrl::bio_flags
> >    btrfs: open code extent_set_compress_type helpers
> >    btrfs: rename io_failure_record::bio_flags to compress_type
> >    btrfs: rename bio_flags in parameters and switch type
> >    btrfs: rename bio_ctrl::bio_flags to compress_type
> > 
> >   fs/btrfs/ctree.c       |  2 +-
> >   fs/btrfs/ctree.h       |  5 ++-
> >   fs/btrfs/delayed-ref.c |  4 +--
> >   fs/btrfs/delayed-ref.h |  1 -
> >   fs/btrfs/disk-io.c     |  5 ++-
> >   fs/btrfs/disk-io.h     |  3 +-
> >   fs/btrfs/extent-tree.c | 10 +++---
> >   fs/btrfs/extent_io.c   | 73 ++++++++++++++++++------------------------
> >   fs/btrfs/extent_io.h   | 22 ++-----------
> >   fs/btrfs/inode.c       | 10 +++---
> >   10 files changed, 50 insertions(+), 85 deletions(-)
> > 
> 
> 
> FWIW:
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> (I did look at the patches that have been merged into misc-next with the 
> compression type fixed up) .

Thanks, commits updated.
