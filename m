Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8627AF4D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 22:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjIZUJa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 16:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjIZUJ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 16:09:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13278F3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 13:09:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBF9C21832;
        Tue, 26 Sep 2023 20:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695758961;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juXHE8mJjSOAG74vGjUXf9R4Qa9HY8Lcys//OZAM6LE=;
        b=U3o5BJncLwnZkGJP3zOMSPkkIBJJ1/XmOZC8SVxwd601g7uav5vidFskUmVQuC4Jbvn0UP
        QlHzOAu0V7TO4v8VyKrEg/sni+1a7wDzWoW7cLkbHM4F4U2FE6upj8M0AUoencZascCMAC
        eMUeDGFeL1xOGMAPncp+o/0/Qd513Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695758961;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juXHE8mJjSOAG74vGjUXf9R4Qa9HY8Lcys//OZAM6LE=;
        b=2TcteOa9CV549Prb0Wt2i9pIYFiljyR8WTKrZYUi5Dj/SQKiud9R9n6fnCPdxjzFmg6L0g
        YcuKYIrtwnTthzAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C96413434;
        Tue, 26 Sep 2023 20:09:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Mqt2JXE6E2XpDQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Sep 2023 20:09:21 +0000
Date:   Tue, 26 Sep 2023 22:02:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] btrfs: fix some maybe uninitialized warnings in ioctl.c
Message-ID: <20230926200243.GW13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0e16cb17a51ba2542986de951a61bd1362360eb9.1695757597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e16cb17a51ba2542986de951a61bd1362360eb9.1695757597.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 26, 2023 at 03:47:27PM -0400, Josef Bacik wrote:
> Jens reported the following warnings from -Wmaybe-uninitialized recent
> linus.
> 
> In file included from ./include/asm-generic/rwonce.h:26,
>                  from ./arch/arm64/include/asm/rwonce.h:71,
>                  from ./include/linux/compiler.h:246,
>                  from ./include/linux/export.h:5,
>                  from ./include/linux/linkage.h:7,
>                  from ./include/linux/kernel.h:17,
>                  from fs/btrfs/ioctl.c:6:
> In function ‘instrument_copy_from_user_before’,
>     inlined from ‘_copy_from_user’ at ./include/linux/uaccess.h:148:3,
>     inlined from ‘copy_from_user’ at ./include/linux/uaccess.h:183:7,
>     inlined from ‘btrfs_ioctl_space_info’ at fs/btrfs/ioctl.c:2999:6,
>     inlined from ‘btrfs_ioctl’ at fs/btrfs/ioctl.c:4616:10:
> ./include/linux/kasan-checks.h:38:27: warning: ‘space_args’ may be used
> uninitialized [-Wmaybe-uninitialized]
>    38 | #define kasan_check_write __kasan_check_write
> ./include/linux/instrumented.h:129:9: note: in expansion of macro
> ‘kasan_check_write’
>   129 |         kasan_check_write(to, n);
>       |         ^~~~~~~~~~~~~~~~~
> ./include/linux/kasan-checks.h: In function ‘btrfs_ioctl’:
> ./include/linux/kasan-checks.h:20:6: note: by argument 1 of type ‘const
> volatile void *’ to ‘__kasan_check_write’ declared here
>    20 | bool __kasan_check_write(const volatile void *p, unsigned int
>       size);
>       |      ^~~~~~~~~~~~~~~~~~~
> fs/btrfs/ioctl.c:2981:39: note: ‘space_args’ declared here
>  2981 |         struct btrfs_ioctl_space_args space_args;
>       |                                       ^~~~~~~~~~
> In function ‘instrument_copy_from_user_before’,
>     inlined from ‘_copy_from_user’ at ./include/linux/uaccess.h:148:3,
>     inlined from ‘copy_from_user’ at ./include/linux/uaccess.h:183:7,
>     inlined from ‘_btrfs_ioctl_send’ at fs/btrfs/ioctl.c:4343:9,
>     inlined from ‘btrfs_ioctl’ at fs/btrfs/ioctl.c:4658:10:
> ./include/linux/kasan-checks.h:38:27: warning: ‘args32’ may be used
> uninitialized [-Wmaybe-uninitialized]
>    38 | #define kasan_check_write __kasan_check_write
> ./include/linux/instrumented.h:129:9: note: in expansion of macro
> ‘kasan_check_write’
>   129 |         kasan_check_write(to, n);
>       |         ^~~~~~~~~~~~~~~~~
> ./include/linux/kasan-checks.h: In function ‘btrfs_ioctl’:
> ./include/linux/kasan-checks.h:20:6: note: by argument 1 of type ‘const
> volatile void *’ to ‘__kasan_check_write’ declared here
>    20 | bool __kasan_check_write(const volatile void *p, unsigned int
>       size);
>       |      ^~~~~~~~~~~~~~~~~~~
> fs/btrfs/ioctl.c:4341:49: note: ‘args32’ declared here
>  4341 |                 struct btrfs_ioctl_send_args_32 args32;
>       |                                                 ^~~~~~
> 
> This was due to his config options and having KASAN turned on,
> which adds some extra checks around copy_from_user(), which then
> triggered the -Wmaybe-uninitialized checker for these cases.
> 
> Fix the warnings by initializing the different structs we're copying
> into.
> 
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
