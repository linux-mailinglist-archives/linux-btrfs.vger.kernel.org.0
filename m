Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9411A5E68DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiIVQzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIVQzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 12:55:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FC7EB139
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 09:55:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59C041F91F;
        Thu, 22 Sep 2022 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663865739;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4NUKlsGcrlFyvYHtP9dZOsFT9dvWM1kmxOsEdvZTh1k=;
        b=obcRT4YrJXfwfL/oeOMrt8RG1iCc9fEy0lIVYAG0t9l8NHX2rtmdsk0UmLW0Pu0hpI9JsT
        Hn5pOncPvMv0H3XZYdFQkgJTp/wSjC9xzA7SkqRyAzyR++3V9vZ8kwFyYCL/cH7OSCirqF
        NIW4R3gTAwFmCSZjLRzMKexr/PHPOXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663865739;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4NUKlsGcrlFyvYHtP9dZOsFT9dvWM1kmxOsEdvZTh1k=;
        b=B/vZmyKzjAUgZ8TTFOq9o4YK30AVDEM+H1e9EhzO6Rj9lcl8NbKK4HO/sivGMGFjjkb/Mv
        HEol4/6Zf69lveAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D46113AF0;
        Thu, 22 Sep 2022 16:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U2Z3BYuTLGMwUwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 22 Sep 2022 16:55:39 +0000
Date:   Thu, 22 Sep 2022 18:50:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        syzbot <syzbot+fba8e2116a12609b6c59@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2] btrfs: Call btrfs_set_header_generation() before
 btrfs_clean_tree_block()
Message-ID: <20220922165007.GN32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000a4618905d1361d3e@google.com>
 <062d63c8-39bf-62d8-4562-625184e97b6c@I-love.SAKURA.ne.jp>
 <PH0PR04MB74161B62751B7D8EDB3965719B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <112cdf17-374f-fdc5-58ae-d8db3f695ac4@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112cdf17-374f-fdc5-58ae-d8db3f695ac4@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 20, 2022 at 10:43:51PM +0900, Tetsuo Handa wrote:
> syzbot is reporting uninit-value in btrfs_clean_tree_block() [1], for
> commit bc877d285ca3dba2 ("btrfs: Deduplicate extent_buffer init code")
> missed that btrfs_set_header_generation() in btrfs_init_new_buffer() must
> not be moved to after clean_tree_block() because clean_tree_block() is
> calling btrfs_header_generation() since commit 55c69072d6bd5be1 ("Btrfs:
> Fix extent_buffer usage when nodesize != leafsize").
> 
> Since memzero_extent_buffer() will reset "struct btrfs_header" part, we
> can't move btrfs_set_header_generation() to before memzero_extent_buffer().
> Just re-add btrfs_set_header_generation() before btrfs_clean_tree_block().
> 
> Link: https://syzkaller.appspot.com/bug?extid=fba8e2116a12609b6c59 [1]
> Reported-by: syzbot <syzbot+fba8e2116a12609b6c59@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: bc877d285ca3dba2 ("btrfs: Deduplicate extent_buffer init code")

Added to misc-next, thanks.
