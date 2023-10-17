Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCD57CCC90
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 21:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344385AbjJQTtW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjJQTtW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 15:49:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFE09E;
        Tue, 17 Oct 2023 12:49:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6FA251F8B0;
        Tue, 17 Oct 2023 19:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697572158;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bNd8tVs25f+1D5Zk82Lm7dC1cpiHULfm19EiFqzHTo=;
        b=a7kton5ZFsANcHtkX1el0nXOmudqTq92A0HFIbrXpZ7nCMc2JlZOV+k1pvfs29Y0fwiB36
        JhMMHEGEfdrLLf5+7jFesN2bgN1iB+uLYyngMfMwB1QPqQbXzyATyxNFrk77AezY0cUvPS
        OkTDRtcB4XXb58b2FwlzuQ9PpNCSMLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697572158;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bNd8tVs25f+1D5Zk82Lm7dC1cpiHULfm19EiFqzHTo=;
        b=+IFQe0MzS362qW/vzwqW0JpZsv4YqZ1iFpgH3Iu2bImTy0Vq47aDOMg0eVscQeJBIHTw8l
        VQWexSULkODfh+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E99113597;
        Tue, 17 Oct 2023 19:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fMOYCj7lLmXcOwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Oct 2023 19:49:18 +0000
Date:   Tue, 17 Oct 2023 21:42:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+6aa88a2d31fbec170f8b@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (3)
Message-ID: <20231017194228.GD2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000019171d0607eb8786@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000019171d0607eb8786@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f27cd6e68911e026];
         TAGGED_RCPT(0.00)[6aa88a2d31fbec170f8b];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         BAYES_HAM(-0.00)[31.66%];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         SUBJECT_HAS_EXCLAIM(0.00)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PLING_QUERY,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 17, 2023 at 08:53:45AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c295ba49917a Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=135804fe680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f27cd6e68911e026
> dashboard link: https://syzkaller.appspot.com/bug?extid=6aa88a2d31fbec170f8b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d48d09680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13498275680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/045554f2bee6/disk-c295ba49.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ba2705f8a872/vmlinux-c295ba49.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e36242e95b79/Image-c295ba49.gz.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/39a4eecc45c3/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/3a9106a526c9/mount_1.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6aa88a2d31fbec170f8b@syzkaller.appspotmail.com
> 
> BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

#syz invalid

This is a frequent warning, can be worked around by increasing
CONFIG_LOCKDEP_CHAINS_BITS in config (18 could be a good value but may
still not be enough).
