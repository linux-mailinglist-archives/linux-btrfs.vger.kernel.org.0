Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5592B280043
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbgJANhK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 09:37:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732147AbgJANhJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 09:37:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22E8DAC54;
        Thu,  1 Oct 2020 13:37:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DBE3ADA781; Thu,  1 Oct 2020 15:35:46 +0200 (CEST)
Date:   Thu, 1 Oct 2020 15:35:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     dsterba@suse.cz,
        syzbot <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in btrfs_scan_one_device
Message-ID: <20201001133546.GV6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000001fe79005afbf52ea@google.com>
 <20200930165756.GQ6756@twin.jikos.cz>
 <20200930180522.GR6756@twin.jikos.cz>
 <CACT4Y+b6ctH447Hy9JuP1hF5MSV368WAB2tXz8xfi-5ZM-=tOg@mail.gmail.com>
 <CACT4Y+bQdT_eOcE-jOJQQFR_xi14YwBQUosuUTNq1t-k5JSFJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+bQdT_eOcE-jOJQQFR_xi14YwBQUosuUTNq1t-k5JSFJQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 01, 2020 at 03:08:34PM +0200, Dmitry Vyukov wrote:
> On Thu, Oct 1, 2020 at 3:05 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Sep 30, 2020 at 8:06 PM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 06:57:56PM +0200, David Sterba wrote:
> > > > On Sun, Sep 20, 2020 at 07:12:14AM -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    eb5f95f1 Merge tag 's390-5.9-6' of git://git.kernel.org/pu..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=10a0a8bb900000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ffe85b197a57c180
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=582e66e5edf36a22c7b0
> > > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
> > > >
> > > > #syz fix: btrfs: fix overflow when copying corrupt csums for a message
> > >
> > > Johannes spotted that this is not the right fix for this report, I don't
> > > know how to tell syzbot to revert the 'fix:' command, there isn't
> > > 'unfix' (like there's 'undup').
> >
> > Hi David,
> >
> > I've added "unfix" command:
> > https://github.com/google/syzkaller/pull/2156
> >
> > Let's give it a try:
> > #syz unfix
> >
> > Thanks
> 
> Voilà! Unfixed:
> https://syzkaller.appspot.com/bug?extid=582e66e5edf36a22c7b0

Thanks!
