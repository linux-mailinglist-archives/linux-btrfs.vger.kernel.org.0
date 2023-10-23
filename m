Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB137D3A22
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjJWO55 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 10:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjJWOow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 10:44:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49717269D;
        Mon, 23 Oct 2023 07:43:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 731642188D;
        Mon, 23 Oct 2023 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698072211;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mWnimA+rB45DdXIO//K0LJL74BS6+rPPoMNkuJC8w4=;
        b=C6qrs4g0jsDTg/6TjxWrP2fI0tkZUezsEVX5EraDP83B9ZInndNT3opR3YA/aF4lTpEF6N
        aGY2OpJHJMZmRIZqm1tdh1N+DEk53L7NbXtq5gbPrRMEfDKLYg2euxd8RXJ/Dyn8OFmrMF
        q5cV+n9DAXfJ455zH4C3YdIs/XEXqkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698072211;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mWnimA+rB45DdXIO//K0LJL74BS6+rPPoMNkuJC8w4=;
        b=IVdZCgiSzyXjHkb8KY2QiZabkPJ/NYpnPHJVjtkdaw5LEgBoTmgi3WGlOittza//ekkulb
        CrAHXdpfja+VplDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E00A139C2;
        Mon, 23 Oct 2023 14:43:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OyF7DpOGNmVLdwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 23 Oct 2023 14:43:31 +0000
Date:   Mon, 23 Oct 2023 16:36:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+b2869947e0c9467a41b6@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (4)
Message-ID: <20231023143637.GI26353@suse.cz>
Reply-To: dsterba@suse.cz
References: <000000000000d005440608450810@google.com>
 <20231023130830.GG26353@twin.jikos.cz>
 <CANp29Y4VNqAX0oPiGy557ubwQKjhWVbwjT7xdCBGLricJPJ5Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y4VNqAX0oPiGy557ubwQKjhWVbwjT7xdCBGLricJPJ5Yg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f27cd6e68911e026];
         TAGGED_RCPT(0.00)[b2869947e0c9467a41b6];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         REPLY(-4.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BAYES_HAM(-3.00)[100.00%];
         SUBJECT_HAS_QUESTION(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         SUBJECT_HAS_EXCLAIM(0.00)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[10];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PLING_QUERY,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 23, 2023 at 03:30:16PM +0200, Aleksandr Nogikh wrote:
> On Mon, Oct 23, 2023 at 3:15 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Sat, Oct 21, 2023 at 07:40:53PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    78124b0c1d10 Merge branch 'for-next/core' into for-kernelci
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1557da89680000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f27cd6e68911e026
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b2869947e0c9467a41b6
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > userspace arch: arm64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137ac45d680000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e4640b680000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/bd512de820ae/disk-78124b0c.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/a47a437b1d4f/vmlinux-78124b0c.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/3ae8b966bcd7/Image-78124b0c.gz.xz
> > > mounted in repro: https://storage.googleapis.com/syzbot-assets/d5d514495f15/mount_0.gz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+b2869947e0c9467a41b6@syzkaller.appspotmail.com
> > >
> > > BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> >
> > #syz invalid
> >
> > This is a frequent warning, can be worked around by increasing
> > CONFIG_LOCKDEP_CHAINS_BITS in config (18 could be a good value but may
> > still not be enough).
> 
> By invalidating a frequently occurring issue we only cause syzbot to
> report it once again, so it's better to keep the report open until the
> root cause is resolved. There'll likely be a report (5) soon.

The root cause is somewhere in lockdep and not easy to fix so we'll have
to see the duplicate reports or

> We keep CONFIG_LOCKDEP_CHAINS_BITS at 16 for arm64 because (at least
> in 2022) the kernel used not to boot on GCE arm64 VMs with
> CONFIG_LOCKDEP_CHAINS_BITS=18. Maybe it's time to try it once more.

yeah, you can increase the config value.
