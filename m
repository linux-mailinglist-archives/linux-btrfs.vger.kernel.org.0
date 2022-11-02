Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F36617105
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 23:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKBWye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 18:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiKBWyO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 18:54:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC0DDF5E;
        Wed,  2 Nov 2022 15:54:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D75041F38D;
        Wed,  2 Nov 2022 22:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667429651;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NAVI+oJkMUNlaU4LdKhiXMiyJaW5EBhytLHfFbj3i3M=;
        b=w3QuCvDtA/OIEkmNcdCZC2Xjn8+qrxNfLAWK9kyRvAQeDvCVown9RKezyoFxNKIEVnfXAo
        /9MTLIWjWKYe3J3FLdY/3hlhpbGLYEdyKOIq9YtummVYfPfCZfkWRb6dzaZnpMNLvrbngt
        LADV1masVoBtvyIHCF7jZx0HtEKDW1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667429651;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NAVI+oJkMUNlaU4LdKhiXMiyJaW5EBhytLHfFbj3i3M=;
        b=zpKmCOKnO+EBWMQ8Qh7nuKeNqSwI8GmWJbi3XY1W/sf6opY85TmTvMi4J2xBH5sf25TNwW
        figJqgeeMLEA/xAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7371139D3;
        Wed,  2 Nov 2022 22:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cFfEJxP1YmNQTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 02 Nov 2022 22:54:11 +0000
Date:   Wed, 2 Nov 2022 23:53:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+9c37714c07194d816417@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in btrfs_commit_transaction
Message-ID: <20221102225352.GJ5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0000000000000c379205ec806d6e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000c379205ec806d6e@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 02, 2022 at 10:46:53AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12db9c7e880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=9c37714c07194d816417
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17401632880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13176716880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ba5b49fa77de/disk-b229b6ca.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7c061f2ae4dc/vmlinux-b229b6ca.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bc45c1300e9b/bzImage-b229b6ca.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/62077524a72d/mount_0.gz
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e432a6880000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e432a6880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12e432a6880000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9c37714c07194d816417@syzkaller.appspotmail.com
> 
> BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
> BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
> BTRFS info (device loop0): checking UUID tree
> BTRFS warning (device loop0): Skipping commit of aborted transaction.
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -12)

-12 is ENOMEM, so another point for adding it to the list of exceptions
and not reporting the stacktrace. We have other warnings or assertions
to catch bad cleanup after errors.
