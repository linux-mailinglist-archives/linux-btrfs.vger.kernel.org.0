Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775C65B3C89
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 18:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiIIQBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIIQBg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 12:01:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B854EE6B9F
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 09:01:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60B30225B2;
        Fri,  9 Sep 2022 16:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662739292;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZg94j1LIJLNQR/znkr5Mojqvxcynk2ZxqZjnHlvOcI=;
        b=k+xr45i9YXf7cSHjCDCq34GvWXJlvtv8rhIMjC8UMKTgqNWwADPsxUCHt3ARgQamV43DyX
        pc55vC0VrWKfvJfulJrAdUwiaGyitnjpZ76X6taFZABXJg0SOCoEP9fNBaAh74TAxTHNkI
        yr8LkNAvC6tMNVvzIjy6OaxirwRr3CU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662739292;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZg94j1LIJLNQR/znkr5Mojqvxcynk2ZxqZjnHlvOcI=;
        b=1M9WP4ek325zke36OAp8M8KvbG28bJXE+56YOKTywU5Ve4VgWwJTgRxikU6ZB4habPdE/6
        SfoQY/p5dsc1eRAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C99813A93;
        Fri,  9 Sep 2022 16:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sUHcDVxjG2M4fAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 09 Sep 2022 16:01:32 +0000
Date:   Fri, 9 Sep 2022 17:56:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: receive: fix a segfault that free() an
 err value
Message-ID: <20220909155607.GE32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220901083554.40166-1-wangyugui@e16-tech.com>
 <20220902161327.45283-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902161327.45283-1-wangyugui@e16-tech.com>
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

On Sat, Sep 03, 2022 at 12:13:27AM +0800, Wang Yugui wrote:
> I noticed a segfault of 'btrfs receive'.
> $ gdb
>  #0  process_clone (path=0x23829d0 "after.s1.txt", offset=0, len=2097152, clone_uuid=<optimized out>,
>     clone_ctransid=<optimized out>, clone_path=0x2382920 "after.s1.txt", clone_offset=0, user=0x7ffe21985ba0)
>     at cmds/receive.c:793
> 793                     free(si->path);
> (gdb) p si
> $1 = (struct subvol_info *) 0xfffffffffffffffe
> 
> 'si' was an ERR value. so add the check of '!IS_ERR_OR_NULL()' before 'free()'
> just similar to process_snapshot().
> 
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

Added to devel, thanks.
