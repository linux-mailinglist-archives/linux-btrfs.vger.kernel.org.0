Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A69C2EF3FF
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 15:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbhAHOgQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 09:36:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:45906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbhAHOgQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Jan 2021 09:36:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E531AD11;
        Fri,  8 Jan 2021 14:35:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C73F0DA6E9; Fri,  8 Jan 2021 15:33:43 +0100 (CET)
Date:   Fri, 8 Jan 2021 15:33:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     syzbot <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Filipe David Borba Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Subject: Re: KASAN: null-ptr-deref Write in start_transaction
Message-ID: <20210108143343.GY6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        syzbot <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Filipe David Borba Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
References: <00000000000053e36405b3c538fc@google.com>
 <0000000000008f60c505b84f2cd0@google.com>
 <CAL3q7H63XwdxmHgTRZthh6xYtg1uyqAK3apbrwxobRQ660U+JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H63XwdxmHgTRZthh6xYtg1uyqAK3apbrwxobRQ660U+JA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 08, 2021 at 02:22:00PM +0000, Filipe Manana wrote:
> On Thu, Jan 7, 2021 at 1:13 PM syzbot
> <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com> wrote:
> >
> > syzbot suspects this issue was fixed by commit:
> >
> > commit f30bed83426c5cb9fce6cabb3f7cc5a9d5428fcc
> > Author: Filipe Manana <fdmanana@suse.com>
> > Date:   Fri Nov 13 11:24:17 2020 +0000
> >
> >     btrfs: remove unnecessary attempt to drop extent maps after adding inline extent
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ddc30b500000
> > start commit:   521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6700bca07dff187809c4
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a07ab2500000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fe69c6500000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
> >
> > #syz fix: btrfs: remove unnecessary attempt to drop extent maps after adding inline extent
> 
> Nop, it can't be this change.
> 
> What should fix it should be the following commit:
> 
> commit ecfdc08b8cc65d737eebc26a1ee1875a097fd6a0
> Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Date:   Thu Sep 24 11:39:21 2020 -0500
> 
>     btrfs: remove dio iomap DSYNC workaround

Thanks!

#syz unfix
