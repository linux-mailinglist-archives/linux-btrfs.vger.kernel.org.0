Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50A77308A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjFNToA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjFNTn5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 15:43:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658DE26AB
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 12:43:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04775222C3;
        Wed, 14 Jun 2023 19:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686771810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQmdn9qKF3BF98v3vQpLrCHSlZYfoDo/yGCWRo1Qe6U=;
        b=tq5Dp2/mr9Ji4hxqE2xc4JmSsyIFqfprk3PnxAU4YamJ+F4hdmgmfX/ag4zXq3lRmdaIAX
        GMxUGxh18yJgnaTSDEBcBb+ohJeKHdTBs9y/dzN8atON4rgY13ZWR6rSqfA2ilMmMCpUMf
        uIGfrOuo8DN9EWdqCy9u+Hz9C4DJ8pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686771810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQmdn9qKF3BF98v3vQpLrCHSlZYfoDo/yGCWRo1Qe6U=;
        b=K2ktOqVxpmQFRawDaD0KIFqx30ZLxnIVESBgrOVUOjR6I5t5mmKNur8rOoc8dLJIJ6LkV3
        pK75O3vu319raOBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEE5B1391E;
        Wed, 14 Jun 2023 19:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yrFuMWEYimQICwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Jun 2023 19:43:29 +0000
Date:   Wed, 14 Jun 2023 21:37:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: fix accessors for big endian systems
Message-ID: <20230614193710.GO13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <55b1841a271b69b8047f1195eeb26fb23f893f71.1686738215.git.wqu@suse.com>
 <c268fb1a-3c51-3609-920e-47a0c2286181@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c268fb1a-3c51-3609-920e-47a0c2286181@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 14, 2023 at 05:50:32PM +0000, Johannes Thumshirn wrote:
> On 14.06.23 12:26, Qu Wenruo wrote:
> > ---
> >  kernel-shared/accessors.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
> > index 625acfbe8ca7..06ab6e7e9f12 100644
> > --- a/kernel-shared/accessors.h
> > +++ b/kernel-shared/accessors.h
> > @@ -7,6 +7,8 @@
> >  #define _static_assert(expr)   _Static_assert(expr, #expr)
> >  #endif
> >  
> > +#include <bits/endian.h>
> > +
> >  struct btrfs_map_token {
> >  	struct extent_buffer *eb;
> >  	char *kaddr;
> > @@ -579,7 +581,7 @@ BTRFS_SETGET_STACK_FUNCS(disk_key_objectid, struct btrfs_disk_key, objectid, 64)
> >  BTRFS_SETGET_STACK_FUNCS(disk_key_offset, struct btrfs_disk_key, offset, 64);
> >  BTRFS_SETGET_STACK_FUNCS(disk_key_type, struct btrfs_disk_key, type, 8);
> >  
> > -#ifdef __LITTLE_ENDIAN
> > +#if __BYTE_ORDER == __LITTLE_ENDIAN
> >  
> >  /*
> >   * Optimized helpers for little-endian architectures where CPU and on-disk
> 
> Hmm but with a change like that we can't just copy over the
> kernel files into user-space.
> 
> Just something we need to keep in mind.

There are more changes in all synced files, it can't be a direct copy
yet.
