Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432F461716A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 00:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKBXJG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 19:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBXIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 19:08:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A7103A;
        Wed,  2 Nov 2022 16:08:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA36121AE3;
        Wed,  2 Nov 2022 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667430527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lb7v7Z9TgGKj+751PZ6XzDrtwj3FCilA762eWMnVxCc=;
        b=04swrYvudDEonFt9NMIwnG6Lf0Uv+W/dF80G40famkABlTI3RNHve9qllsiSQZbYPAUdYG
        mA98y3H6zshqubmwF8BRTSJ7WQPVkPRRnSV8Vwk7A7yw3fV9xP58E1UYRSrJEexxtbqQQN
        /5oiU6L//DH8KQiOoef2nr3UkrrOJmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667430527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lb7v7Z9TgGKj+751PZ6XzDrtwj3FCilA762eWMnVxCc=;
        b=Vl6+1e736RpApU6pxu7QupaopZDhMpg0rm/lbWtUeELDAj/quFg4Xe9bUWx5x59LHrDcdy
        vUt1MSdQj8Oa4BCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AD31139D3;
        Wed,  2 Nov 2022 23:08:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /+j6HH/4YmNUVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 02 Nov 2022 23:08:47 +0000
Date:   Thu, 3 Nov 2022 00:08:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+031687116258450f9853@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in dev_args_match_device
Message-ID: <20221102230828.GK5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000ef589805ec80b371@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ef589805ec80b371@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 02, 2022 at 11:06:42AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1744c1fc880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
> dashboard link: https://syzkaller.appspot.com/bug?extid=031687116258450f9853
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+031687116258450f9853@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/ctree.h:3710!

This is cut just before the assertion failed message but it's in the
full console log:

[ 1143.555887][ T2686] assertion failed: (args->devid != (u64)-1) || args->missing, in fs/btrfs/volumes.c:6921

6918 static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,                                                                                                                                     
6919                                   const struct btrfs_device *device)                                                                                                                                            
6920 {                                                                                                                                                                                                               
6921         ASSERT((args->devid != (u64)-1) || args->missing);  
