Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC37F2EF3B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbhAHOIC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 09:08:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:53400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbhAHOIC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Jan 2021 09:08:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8DA8CAD11;
        Fri,  8 Jan 2021 14:07:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 257EFDA6E9; Fri,  8 Jan 2021 15:05:30 +0100 (CET)
Date:   Fri, 8 Jan 2021 15:05:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: KASAN: null-ptr-deref Write in start_transaction
Message-ID: <20210108140529.GX6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org
References: <00000000000053e36405b3c538fc@google.com>
 <0000000000008f60c505b84f2cd0@google.com>
 <CACT4Y+YJCMyTDrUFWXEnZ-raQMos0+1F1O8k5eX998pqNUWKSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YJCMyTDrUFWXEnZ-raQMos0+1F1O8k5eX998pqNUWKSw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 08, 2021 at 10:17:25AM +0100, Dmitry Vyukov wrote:
> On Thu, Jan 7, 2021 at 2:11 PM syzbot
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
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> #syz fix: btrfs: remove unnecessary attempt to drop extent maps after
> adding inline extent

I have looked at the report and suspected fix yestereday and was not
sure that it's really the right fix.  The commit removes some call so it
all looks like an accidental fix and something still might be going on.
So I'm a bit surprised that you mark it as fixed. It will make the
syzbot report go away so from that POV ok and we'll know if it happens
again, but I'd expect at least some analysis before closing the report.
