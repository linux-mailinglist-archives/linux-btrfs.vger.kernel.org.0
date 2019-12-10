Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F03F6118C28
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 16:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLJPMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 10:12:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41216 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJPMI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 10:12:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id l124so4732097qkf.8
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 07:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DqJ7eGZMr1qeqh+aIXxS2c2AcIbcPXeu9bzyHF9Ax44=;
        b=DYtJmv6nYnCFMrqz7yj7vRcbzCofqG0i3za6QMJp02W+m73MNzloxjFVx83RicwfP2
         o9DyiFkodPq3CTBMeNFscRZY04HWm3PB1S8jMePSSWj+CNym71N9Zmb9AGNTFTiwaW49
         n/fqbqtX39bewtOuJDctXSswjFyZFdh3iB/U3MNV+nOxv+vk/8bUQCZegmAZTLEpCIRQ
         p9mibYCYITZ+SEYPDadSeKr0+pmD96/+QeQBd2T2SopXXzv6o3UejRjp/HmZx/E5R0Xi
         eWQc0GWrlFI+dEUfZpm+BvV8jLBFy7f4fOvkKVHB/FYRYRJG+nrNz4RL2pFjT6GE9Sfa
         7ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DqJ7eGZMr1qeqh+aIXxS2c2AcIbcPXeu9bzyHF9Ax44=;
        b=PObujVLqTRRa89R81ehWLD3XSPq3srzweBuQ/ZCGwqyXHhjXt+QccRLj4P6YOKMm4a
         a35e/exrTEfEZNNhHbDaFc004Qmvlr9tVcvaLASS2KND0YQggVa9mCOT8o1/eDOEi83+
         wXmsLw2JdaK4mWX7Wo2dZxHXnroBIqRr8RIYAHwAPLyRPfcxH6HfZsSkW8VtFZGSf95i
         xndf2l0LjZJA/4HPhxKUkMVkGNUXURvDdOYjChborqswv2H4/hyw9M0qBbeaHJK2t1Zv
         9TP0uSDU8DeZYufaQStdbKwrbypPbrrXd+50Y6810rC3vaz8c2cykMJAjWOlJyTu4o88
         epSw==
X-Gm-Message-State: APjAAAVlwUAR9Fe3wttdhhCI5eariuJl7+z8XsQrgclFWwwWQCVBj6cc
        YuwbuoZM/y7sLc2DOdHhHf8+BwS1KWLrIa5E2fJ60A==
X-Google-Smtp-Source: APXvYqz42MGesULJvAZKpybp705MD/l+eR9isKEXXoyZQjybjJ6bkgrJCAv90qChWLOnSEzlJZPoVFtV3AsEPJ9BgD0=
X-Received: by 2002:ae9:e50c:: with SMTP id w12mr28795896qkf.407.1575990726561;
 Tue, 10 Dec 2019 07:12:06 -0800 (PST)
MIME-Version: 1.0
References: <00000000000096009b056df92dc1@google.com> <beffba5d-e3d7-8b06-655b-bd04349177ea@kernel.org>
 <20191205100047.GA11438@Johanness-MacBook-Pro.local> <CACT4Y+Z-9g59XTwpfW+3fv1_jhbsskkvt8E8fx5F44BjofZ0ow@mail.gmail.com>
 <20191205113838.GC11438@Johanness-MacBook-Pro.local> <20191205115033.GJ2734@suse.cz>
 <CACT4Y+Z9QezPoc-8nASbK0Bi_ihF=knQ2ngeO8ibdRWbdkEH5g@mail.gmail.com>
In-Reply-To: <CACT4Y+Z9QezPoc-8nASbK0Bi_ihF=knQ2ngeO8ibdRWbdkEH5g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Dec 2019 16:11:55 +0100
Message-ID: <CACT4Y+Zv3xJ5bDbHfUbPxC=Xwb06VB31A2rLo+f2fhBaB4g=sw@mail.gmail.com>
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

On Thu, Dec 5, 2019 at 1:06 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > The correct syntax would be (no dash + colon):
> > > >
> > > > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
> > > > close_fs_devices
> > >
> > > Ah ok, thanks.
> > >
> > > Although syzbot already said it can't test because it has no reproducer.
> > > Anyways good to know for future reports.
> >
> > According to
> >
> > https://syzkaller.appspot.com/bug?id=d50670eeb21302915bde3f25871dfb7ea43db1e4
> >
> > there is a way how to test it, many reports and the last one about a
> > week old. Is there a way to instruct syzbot to run the same tests on a
> > given branch?
> >
> > (The reproducer is basically setting up environment with limited amount
> > of memory available for allocation and this hits the BUG_ON.)
>
> syzkaller does this ("rerun the same tests") for every bug always. If
> it succeeds (kernel crashes again), it results in a reproducer, that
> can later be used for cause/fix bisection and patch testing. In this
> case it does not reproduce, so rerunning the same tests will not lead
> to anything useful (only if to false confirmation that a patch fixes
> the crash).
>
> There is a large number of reasons why a kernel crash may not
> reproduce. It may be global accumulated state, non-hermetic tests,
> poor syzkaller btrfs descriptions (most likely true) and others.
>
> Need to take a closer look, on first sight it looks like something
> that should be reproduced...

Yes, there was a bug around image mount reproduction. Should be fixed
now by https://github.com/google/syzkaller/commit/cb704a294c54aed90281c016a6dc0c40ae295601
