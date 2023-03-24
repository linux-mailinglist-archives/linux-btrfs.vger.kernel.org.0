Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC66C75EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjCXCfU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXCfT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:35:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1E9113C1;
        Thu, 23 Mar 2023 19:35:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 75FCB1FE65;
        Fri, 24 Mar 2023 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679625316;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdIFxlKHqyPQauC3EA1CD6YM6MLgr5BPAenLXoxp8A4=;
        b=UTEBNWwEiVAYDqhzhkGZAYjd0E7bKXT7WR8ZiErR8zbK/ak3DFu+vj+GpzXqNFdUP2PnUs
        nBTzujqkrdSxnbEbvOdB5BYA7DUrijKNBzDYfn7d90g0B7P9k83JzJ7M7iN5ZqyAdW03/h
        o+2rbUH4a0M6kMUG0rCbK88y/StmsIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679625316;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdIFxlKHqyPQauC3EA1CD6YM6MLgr5BPAenLXoxp8A4=;
        b=d35aHSEWmViEqFzHhayXYZ9KWzcDAXvUusXk8N6HMgyczMHcwkValIs17Uhr/i1ZyXiKDQ
        aU7L5JLmTh/SkXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3813C133E5;
        Fri, 24 Mar 2023 02:35:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id roqaDGQMHWQAYwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 24 Mar 2023 02:35:16 +0000
Date:   Fri, 24 Mar 2023 03:29:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Genjian <zhanggenjian123@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] btrfs: fix uninitialized variable warning
Message-ID: <20230324022904.GD10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230324020838.67149-1-zhanggenjian@kylinos.cn>
 <78422b96-52ed-b48a-27d0-1cfaa89a6608@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78422b96-52ed-b48a-27d0-1cfaa89a6608@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 10:24:55AM +0800, Qu Wenruo wrote:
> On 2023/3/24 10:08, Genjian wrote:
> > From: Genjian Zhang <zhanggenjian@kylinos.cn>
> > 
> > compiler warning:
> 
> Compiler version please.
> 
> > 
> > ../fs/btrfs/volumes.c: In function ‘btrfs_init_new_device’:
> > ../fs/btrfs/volumes.c:2703:3: error: ‘seed_devices’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >   2703 |   btrfs_setup_sprout(fs_info, seed_devices);
> >        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > ../fs/btrfs/send.c: In function ‘get_cur_inode_state’:
> > ../include/linux/compiler.h:70:32: error: ‘right_gen’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >     70 |   (__if_trace.miss_hit[1]++,1) :  \
> >        |                                ^
> > ../fs/btrfs/send.c:1878:6: note: ‘right_gen’ was declared here
> >   1878 |  u64 right_gen;
> >        |      ^~~~~~~~~
> > 
> > Initialize the uninitialized variables.
> > 
> > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> > ---
> >   fs/btrfs/send.c    | 2 +-
> >   fs/btrfs/volumes.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index e5c963bb873d..af2e153543a5 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -1875,7 +1875,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
> >   	int left_ret;
> >   	int right_ret;
> >   	u64 left_gen;
> > -	u64 right_gen;
> > +	u64 right_gen = 0;
> 
> IIRC this is not my first time explaining why this is a false alert.
> 
> Thus please report your compiler version first.

This is probably because of the -Wmaybe-uninitialized we enabled, on
some combination of architecture and compiler. While I'm also interested
in the compiler and version we need to fix the warnings before 6.3 final.
We'd be gettting the warnings and reports/patches, which is wasting
peoples' time, it's not a big deal to initialize the variables. But
still I also want to know which version reports that.
