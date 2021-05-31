Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26DF3958F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 12:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhEaKdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 06:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhEaKdv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 06:33:51 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC9CC06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 03:32:11 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o27so10735413qkj.9
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 03:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zh9IO265bie667jVCIBNqCamDa33CHtZDFaDzM5abhY=;
        b=Jc8xXzVxJE3s+/WbL+pQubUsDQ5TAkfs+6Ftd/5j6q/9ysHzjxe/hLn0IEf7gtd0pk
         kgOwgu5eyLgwTeE8tHa0ysLs4JhOh9IHOzTf2aZZDiyDp0UC5QikpSuxQ8I1wyh/fiz9
         osY3QyRQAwsLR9PbhcJ4BbnS1knej4yEjW3Kkox1BQkOcYRAjZ25BPUn2h/YZDdWUf/w
         7WRe5iB9vSVr/nTa4K/7mldSxgtswrb8EQU2opZ/N3Q4TEsixCc5FXJNLDWkGf8VbVx8
         lqUf9/liy4BPjn7XeRUWv+FbdgtAiyTsY0NAOhDH9TOth29Q5eCuTQb+0Lf1FrJLfdAk
         nVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zh9IO265bie667jVCIBNqCamDa33CHtZDFaDzM5abhY=;
        b=snUh6FIWlo9p45qp6btuLbf82jd+c3bLr6Dy0Uj5QzJrW/uEaCNKCemK3Q3ZWRRpDv
         y28YmOElqQ2YzPsWOsRt9YcZkUeTGvMgjg75RX+KLzMABkRrMOPhhYHfiny9vIl+UQPA
         PV1vu6fKT68nIyLg2zzcFh13UD4B00ayI691VwzzdOlTT5IAXHwnErRojIJaCTXQfktH
         tzuk/Dq1QdMX5u76S18tMB+PNkhSzXG43lNhyPDmahXIk0dGnB+SfWCrwgvaH1edhYVp
         d/ydkQ+l8+hnYziFYDE7KUoW1RcNpQA911Ya0aBzjfhj2gzRDWyEuuTqBsKtoTkEh9vp
         vspw==
X-Gm-Message-State: AOAM532c0GWnnOJksteFM9A1ecagJJC1YU5pEgro8DTaHxaFov30yKf3
        dRiobz06bGXGHHg6Wzbbsl2u9vpVbBf3ZGASFTnbJA==
X-Google-Smtp-Source: ABdhPJxvsHbIH3aFgNxYXuc3RHhW/RPNDBluWMG4Zp1PqA2dmIECsKqKJuiMGeycw3Y7V92ETgti/lScWmBTFIBXYXY=
X-Received: by 2002:a37:4694:: with SMTP id t142mr15978446qka.265.1622457130194;
 Mon, 31 May 2021 03:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f9136f05c39b84e4@google.com> <21666193-5ad7-2656-c50f-33637fabb082@suse.com>
 <CACT4Y+bqevMT3cD5sXjSv9QYM_7CwjYmN_Ne5LSj=3-REZ+oTw@mail.gmail.com>
 <224f1e6a-76fa-6356-fe11-af480cee5cf2@suse.com> <CACT4Y+ZJ7Oi9ChXJNuF_+e4FRnN1rJBde4tsjiTtkOV+MM-hgA@mail.gmail.com>
 <fcf25b03-e48e-8cda-3c87-25c2c3332719@suse.com>
In-Reply-To: <fcf25b03-e48e-8cda-3c87-25c2c3332719@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 31 May 2021 12:31:59 +0200
Message-ID: <CACT4Y+YrLLiaKnM3uVHZvRtj-UrDW-cwx4k6Lsh8no12nwvpNw@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in assertfail
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     syzbot <syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 11:27 AM Nikolay Borisov <nborisov@suse.com> wrote:
> >>>>>
> >>>>> syzbot found the following issue on:
> >>>>>
> >>>>> HEAD commit:    1434a312 Merge branch 'for-5.13-fixes' of git://git.kernel..
> >>>>> git tree:       upstream
> >>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=162843f3d00000
> >>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9f3da44a01882e99
> >>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a6bf271c02e4fe66b4e4
> >>>>>
> >>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>
> >>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>>> Reported-by: syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
> >>>>>
> >>>>> assertion failed: !memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid, BTRFS_FSID_SIZE), in fs/btrfs/disk-io.c:3282
> >>>>
> >>>> This means a device contains a btrfs filesystem which has a different
> >>>> FSID in its superblock than the fsid which all devices part of the same
> >>>> fs_devices should have. This can happen in 2 ways - memory corruption
> >>>> where either of the ->fsid member are corrupted or if there was a crash
> >>>> while a filesystem's fsid was being changed. We need more context about
> >>>> what the test did?
> >>>
> >>> Hi Nikolay,
> >>>
> >>> From a semantic point of view we can consider that it just mounts /dev/random.
> >>> If syzbot comes up with a reproducer it will post it, but you seem to
> >>> already figure out what happened, so I assume you can write a unit
> >>> test for this.
> >>>
> >>
> >> Well no, under normal circumstances this shouldn't trigger. So if syzbot
> >> is doing something stupid as mounting /dev/random then I don't see a
> >> problem here. The assert is there to catch inconsistencies during normal
> >> operation which doesn't seem to be the case here.
> >
> >
> > Does this mean that CONFIG_BTRFS_ASSERT needs to be disabled in any testing?
> > What is it intended for? Or it can only be enabled when mounting known
> > good images? But then I assume even btrfs unit tests mount some
> > invalid images, so it would mean it can't be used even  during unit
> > testing?
> >
> > Looking at the output of "grep ASSERT fs/btrfs/*.c" it looks like most
> > of these actually check for something that "must never happen". E.g.
> > some lists/pointers are empty/non-empty in particular states. And
> > "must never happen" checks are for testing scenarios...
> >
> > Taking this particular FSID mismatch assert, should such corrupted
> > images be mounted for end users? Should users be notified? Currently
> > they are mounted and users are not notified, what is the purpose of
> > this assertion?
> >
> > Perhaps CONFIG_BTRFS_ASSERT needs to be split into "must never happen"
> > checks that are enabled during testing and normal if's with pr_err for
> > user notifications?
>
> After going through the code you've convinced me. I just sent a patch
> turning the 2 debugging asserts into full-fledged checks in
> validate_super. So now the correct behavior is to prevent mounting of
> such images.  How can I force syzbot to retest with the given patch applied?

syzbot can test patches for issues with reproducers:
http://bit.do/syzbot#testing-patches
but this issue doesn't have a reproducer unfortunately. But I hope
this change is going to be reasonably straightforward. And if/when
this issue happens again after this report is closed with a fix,
syzbot will notify us again. So an absence of any new reports from
syzbot will implicitly mean that everything is fine.
