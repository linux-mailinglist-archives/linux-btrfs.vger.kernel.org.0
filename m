Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688AB114086
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 13:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfLEMGg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 07:06:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39352 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfLEMGg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 07:06:36 -0500
Received: by mail-qt1-f193.google.com with SMTP id g1so3284714qtj.6
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 04:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=F6zHO/WCNUOJMFt0div43uU4YpgZXs8QE00GO2bNAOk=;
        b=sq8wL7AJ/+Mo4kdKlEjtVjVm2c/Kq/drIwY4aK59mtehKOQFqbYhnfUPP9a9T7XBP5
         llKuSWKB+Iq09BIfDEE11CvsUde33Jst5tMP8UjZglnByVypwtPnrJv1w2U0ZNjKQfqe
         he5q107St5f2RZEigfpMn9FVtBSs3ngX9ps9lxSUlm9UJIP26lR3KpAiuNHAW8nVBe4V
         xLsa2kAC9b9QL4MV/UKcoCnjOOkTKuTah7l5yb6oGU0YMIRRg+Bq6DnZxp28wHkcIEHs
         jwGCrvjtZU7fUDOXvNu25Tlw59oh9pgV/LwiUB73yMCksXnBt1P8O7shPafOjczJxJ4s
         Fefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=F6zHO/WCNUOJMFt0div43uU4YpgZXs8QE00GO2bNAOk=;
        b=emWRmDRzTPbx413CyAtoRrtnXV/oj3hZiuIOC0Foaag9KRrXzwSg0U3ZDeMXWivnTg
         pWCRTMhgLQNz5TWF3R3j//hNcFi0ZFZqlkKnfpyobjv8/1i1bwaY7WEkN2o6CUyYEYd+
         SFP7G3UeBKju3GOFdLXMO76/hJVFDE/tRsrP9HLdQ7hjcx58jjA8l6ZuPBeB8Qxchzzp
         laueLmvOPDUI5jVBdAw+xinb4Phb6a+sUcvpMgsdNW5A7gfe+3rLY+tLk0hLw6y2YWaV
         4MFq/VZmlVSV6RcJeNWCmgKIbcCYokgzP4hlNkSGGBLnBcSzb0A7AhyeIYSMrfVeHKyq
         ysVA==
X-Gm-Message-State: APjAAAVXErKqkf9wp6veJovhls7Azyn+GBIyTzK3cPW5JXsGUBCIWVl5
        9Ew7k1duvaAEXUcKEV3WoFK+wo1xqNDa3ETLTQNZ2A==
X-Google-Smtp-Source: APXvYqxK7xrHkUmgrCjpi9ygm1HQIqL3Jgeu8IJMBF2nFA4+2cZshObi4EtuL33VHl3sWGSpOux7oC+IFCOGraccxWU=
X-Received: by 2002:ac8:2489:: with SMTP id s9mr7142276qts.257.1575547594783;
 Thu, 05 Dec 2019 04:06:34 -0800 (PST)
MIME-Version: 1.0
References: <00000000000096009b056df92dc1@google.com> <beffba5d-e3d7-8b06-655b-bd04349177ea@kernel.org>
 <20191205100047.GA11438@Johanness-MacBook-Pro.local> <CACT4Y+Z-9g59XTwpfW+3fv1_jhbsskkvt8E8fx5F44BjofZ0ow@mail.gmail.com>
 <20191205113838.GC11438@Johanness-MacBook-Pro.local> <20191205115033.GJ2734@suse.cz>
In-Reply-To: <20191205115033.GJ2734@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Dec 2019 13:06:23 +0100
Message-ID: <CACT4Y+Z9QezPoc-8nASbK0Bi_ihF=knQ2ngeO8ibdRWbdkEH5g@mail.gmail.com>
Subject: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
To:     dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot <syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 5, 2019 at 12:50 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Dec 05, 2019 at 12:38:38PM +0100, Johannes Thumshirn wrote:
> > On Thu, Dec 05, 2019 at 11:07:27AM +0100, Dmitry Vyukov wrote:
> > > The correct syntax would be (no dash + colon):
> > >
> > > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
> > > close_fs_devices
> >
> > Ah ok, thanks.
> >
> > Although syzbot already said it can't test because it has no reproducer.
> > Anyways good to know for future reports.
>
> According to
>
> https://syzkaller.appspot.com/bug?id=d50670eeb21302915bde3f25871dfb7ea43db1e4
>
> there is a way how to test it, many reports and the last one about a
> week old. Is there a way to instruct syzbot to run the same tests on a
> given branch?
>
> (The reproducer is basically setting up environment with limited amount
> of memory available for allocation and this hits the BUG_ON.)

syzkaller does this ("rerun the same tests") for every bug always. If
it succeeds (kernel crashes again), it results in a reproducer, that
can later be used for cause/fix bisection and patch testing. In this
case it does not reproduce, so rerunning the same tests will not lead
to anything useful (only if to false confirmation that a patch fixes
the crash).

There is a large number of reasons why a kernel crash may not
reproduce. It may be global accumulated state, non-hermetic tests,
poor syzkaller btrfs descriptions (most likely true) and others.

Need to take a closer look, on first sight it looks like something
that should be reproduced...
