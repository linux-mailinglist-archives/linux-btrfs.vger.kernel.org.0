Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E808B3957DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhEaJLG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 05:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhEaJLA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 05:11:00 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E768C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 02:09:19 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id eb9so5210982qvb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IJm6BORftzEWEGVW607YFI9b5KUIuit1QBx1ZBqXYg0=;
        b=CIbw2SDztBV7RW6fGgAXk8TZGbncpGR/9ybFGe2AaQdewLy7mrtwJZo07ZONLlh9rS
         nDEkHkeqnBcKf1J78klzsi5zZydG8B5lI+unt6CN+2/sfiONd/svy6IUZ6TnZ5Q7U2Nk
         OJiBuZup5tD7YE1uMtU848Ou9tLmo7jLdMjNwz7jSaCQWBBpqbvHR8EBQeNpQCvoWwZw
         CFcKHx+EvEAxvGJWK7dpjGMRcAd5PHpgvcbsbxrQAHWpkYg/vvlsTo7q+scyfn+kYs/7
         UDPopY/BS/287eMsjy30OoXYbr8nc6Gl5u7yNIHJ8eVnPAd6Cn1PjBJ1xtBBx9XdHN5N
         Ai5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IJm6BORftzEWEGVW607YFI9b5KUIuit1QBx1ZBqXYg0=;
        b=cQST14rp1iUZlZ3wLYNFY7LdceG9x5e3d6SL/vlAKabKoJ1k6Tjx4Tk1OS34C7H4dd
         dpNpFQ4uQehhoHRJPuG6sJ5fkbcLNKaUFFXymkEu1ww+nw/tWQ+dDfzBY5mm1DHlbRgj
         EYUUmfkQdVnE6s5EuQlVWUveEY9uQvCSMVjxNncDDHq3Mffs4XZ6KYOTjhdvlhfcuzMu
         1xd4dWKdCVf3duRN56/AVhqU8d9u34UgtmclxzKrGnawMlaFnfMLrt7Syy4OlOoCIxgq
         YcxIS1+1ewcOWzDMzUNgTDOwh3eOzBgV18dxrDB2bFF3LGRYeesXvj0npSrYyhDgjkM/
         w8cw==
X-Gm-Message-State: AOAM532cC6aNxs5b/SrbgP9SLF0+rF46bibyzklUhVm5jk/ppDtMA4aL
        +8kU7D7cChvMro04tZ8sVDt0Sp4UK2hJUUj/topP6j3Nt7UUwA==
X-Google-Smtp-Source: ABdhPJx9zcytQeNq3XLgxYCv3FDCseu5tN5+X6rYF44tHjs0FJ7cGnxRAXBrrm9Aecirp85qu4vgIiA5Kqj6n2az/I4=
X-Received: by 2002:a05:6214:12c7:: with SMTP id s7mr10284287qvv.44.1622452157450;
 Mon, 31 May 2021 02:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f9136f05c39b84e4@google.com> <21666193-5ad7-2656-c50f-33637fabb082@suse.com>
 <CACT4Y+bqevMT3cD5sXjSv9QYM_7CwjYmN_Ne5LSj=3-REZ+oTw@mail.gmail.com> <224f1e6a-76fa-6356-fe11-af480cee5cf2@suse.com>
In-Reply-To: <224f1e6a-76fa-6356-fe11-af480cee5cf2@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 31 May 2021 11:09:06 +0200
Message-ID: <CACT4Y+ZJ7Oi9ChXJNuF_+e4FRnN1rJBde4tsjiTtkOV+MM-hgA@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in assertfail
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     syzbot <syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 10:57 AM Nikolay Borisov <nborisov@suse.com> wrote:
> On 31.05.21 =D0=B3. 11:55, Dmitry Vyukov wrote:
> > On Mon, May 31, 2021 at 10:44 AM 'Nikolay Borisov' via syzkaller-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> >> On 31.05.21 =D0=B3. 10:53, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    1434a312 Merge branch 'for-5.13-fixes' of git://git.k=
ernel..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D162843f3d=
00000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9f3da44a0=
1882e99
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da6bf271c02e=
4fe66b4e4
> >>>
> >>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> >>> Reported-by: syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
> >>>
> >>> assertion failed: !memcmp(fs_info->fs_devices->fsid, fs_info->super_c=
opy->fsid, BTRFS_FSID_SIZE), in fs/btrfs/disk-io.c:3282
> >>
> >> This means a device contains a btrfs filesystem which has a different
> >> FSID in its superblock than the fsid which all devices part of the sam=
e
> >> fs_devices should have. This can happen in 2 ways - memory corruption
> >> where either of the ->fsid member are corrupted or if there was a cras=
h
> >> while a filesystem's fsid was being changed. We need more context abou=
t
> >> what the test did?
> >
> > Hi Nikolay,
> >
> > From a semantic point of view we can consider that it just mounts /dev/=
random.
> > If syzbot comes up with a reproducer it will post it, but you seem to
> > already figure out what happened, so I assume you can write a unit
> > test for this.
> >
>
> Well no, under normal circumstances this shouldn't trigger. So if syzbot
> is doing something stupid as mounting /dev/random then I don't see a
> problem here. The assert is there to catch inconsistencies during normal
> operation which doesn't seem to be the case here.


Does this mean that CONFIG_BTRFS_ASSERT needs to be disabled in any testing=
?
What is it intended for? Or it can only be enabled when mounting known
good images? But then I assume even btrfs unit tests mount some
invalid images, so it would mean it can't be used even  during unit
testing?

Looking at the output of "grep ASSERT fs/btrfs/*.c" it looks like most
of these actually check for something that "must never happen". E.g.
some lists/pointers are empty/non-empty in particular states. And
"must never happen" checks are for testing scenarios...

Taking this particular FSID mismatch assert, should such corrupted
images be mounted for end users? Should users be notified? Currently
they are mounted and users are not notified, what is the purpose of
this assertion?

Perhaps CONFIG_BTRFS_ASSERT needs to be split into "must never happen"
checks that are enabled during testing and normal if's with pr_err for
user notifications?
