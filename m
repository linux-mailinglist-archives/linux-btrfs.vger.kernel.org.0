Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326B2E0E66
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 00:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbfJVW5I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 18:57:08 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:34727 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731850AbfJVW5H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 18:57:07 -0400
Received: by mail-ed1-f52.google.com with SMTP id b72so5225088edf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2019 15:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qULNEcZp6oXlZ8vOZZhgVcEAY6Qwx82k2fTVVKcKjs0=;
        b=QT5K3O/5JOWdC66xYJgkr4SFnbfAh4Tw7Iv/vfhDueCvDL50wJ6sgyzdndhwj5Fl8d
         dIezmiqHjKT2kv8Q3KHztAQy5IRs3wAdKHp9d8hG0XjIZs9tqxpqejETDg2CiJtFGywY
         rbuz9qJ9H4JUe86ineSCQfvZUwzpyghRXdZlkjX+L8mI+qLu76WfbLL+Yd4+0UP1/KOE
         NJ1+HllWaZW4m3Nnob/nkg23qO/9vzdkX8ybzbcK04uEjm/nThJOIBHbTldLeWoaHHY9
         noroeestNiiXLaVyb2brq22z0l1Vt8d8B0OdDkzXNOzlvHtPFCXa2K4xjReneLdFmP7E
         6RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qULNEcZp6oXlZ8vOZZhgVcEAY6Qwx82k2fTVVKcKjs0=;
        b=EcnEPNdaxa019GKh52GJM9X+6zNZT7bHkE68945SKbE2ZSUNdRcJPg7QtWrflOyrRU
         FRRBph2Yp7/fgD3DEIh3VJQhmdUAwGt+xfHge6yqueYfyfRg8JC/cF1CkS+Go7nIm7ud
         lzC17ne10x/qn4tOWMhFmuVTOTtunEUjmWukIHNOOrpeMmCcljgrOhgX0aUkvt2i0Xip
         J3+joB7ANPHzNw/+3HyBcpv8zHejVSnxX/7pZndMoqpcGjNME032bDcr61NK8NVPA1Us
         Dsh7lVBQoyO8fxoLJHvp53Sgf1uoM0hyJ3C8HQ4jywE3y9ovulwoFE5HVhj07+zvKMjx
         6jkQ==
X-Gm-Message-State: APjAAAWPCHBRzOxGOmHSUb2BqDR2rQDL9vENwp7c0VC15XbpuGuzWbr/
        97SjGRypEL8wVxN+ZbL4ZkvMOCQgXSaliZFomTXXjMA=
X-Google-Smtp-Source: APXvYqz+oPmM56tvnyoUq7kB5vAA7h7ngRn9DEY9+7Oyvvl4DBPP2TwNaQdB4O8VYzU4x3rD3R5Vrc19m1BMQqa54dw=
X-Received: by 2002:a17:906:31d4:: with SMTP id f20mr30144561ejf.265.1571785025761;
 Tue, 22 Oct 2019 15:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com> <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com> <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com> <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
In-Reply-To: <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Wed, 23 Oct 2019 00:56:29 +0200
Message-ID: <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Please CC me, I'm not on the list.]

Am Mo., 21. Okt. 2019 um 15:34 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
> [...] just fstrim wiped some old tree blocks. But maybe it's some unfortunate race, that fstrim trimmed some tree blocks still in use.

Forgive me for asking, but assuming that's what happened, why are the
backup blocks "not in use" from fstrim's perspective in the first
place? I'd consider backup (meta)data to be valuable payload data,
something to be stored extra carefully. No use making them if they're
no goo when you need them, after all. In other words, does fstrim by
default trim btrfs metadata (in which case fstrim's broken) or does
btrfs in effect store backup data in "unused" space (in which case
btrfs is broken)?

> [...] One good compromise is, only trim unallocated space.

It had never occurred to me that anything would purposely try to trim
allocated space ...

> As your corruption is only in extent tree. With my patchset, you should be able to mount it, so it's not that screwed up.

To be clear, we're talking data recovery, not (progress towards) fs
repair, even if I manage to boot your rescue patchset?

A few more random observations from playing with the drive image:
$ btrfs check --init-extent-tree patient
Opening filesystem to check...
Checking filesystem on patient
UUID: c2bd83d6-2261-47bb-8d18-5aba949651d7
repair mode will force to clear out log tree, are you sure? [y/N]: y
ERROR: Corrupted fs, no valid METADATA block group found
ERROR: failed to zero log tree: -117
ERROR: attempt to start transaction over already running one
# rollback

$ btrfs rescue zero-log patient
checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
bad tree block 284041084928, bytenr mismatch, want=284041084928, have=0
ERROR: could not open ctree
# rollback

# hm, super 0 has log_root 284056535040, super 1 and 2 have log_root 0 ...
$ btrfs check -s1 --init-extent-tree patient
[...]
ERROR: errors found in fs roots
No device size related problem found
cache and super generation don't match, space cache will be invalidated
found 431478808576 bytes used, error(s) found
total csum bytes: 417926772
total tree bytes: 2203549696
total fs tree bytes: 1754415104
total extent tree bytes: 49152
btree space waste bytes: 382829965
file data blocks allocated: 1591388033024
 referenced 539237134336

That ran a good while, generating a couple of hundred MB of output
(available on request, of course). In any case, it didn't help.

$ ~/local/bin/btrfs check -s1 --repair patient
using SB copy 1, bytenr 67108864
enabling repair mode
Opening filesystem to check...
checksum verify failed on 427311104 found 000000C8 wanted FFFFFF99
checksum verify failed on 427311104 found 000000C8 wanted FFFFFF99
Csum didn't match
ERROR: cannot open file system

I don't suppose the roots found by btrfs-find-root and/or subvolumes
identified by btrfs restore -l would be any help? It's not like the
real fs root contained anything, just @ [/], @home [/home], and the
Timeshift subvolumes. If btrfs restore -D is to be believed, the
casualties under @home, for example, are inconsequential, caches and
the like, stuff that was likely open for writing at the time.

I don't know, it just seems strange that with all the (meta)data
that's obviously still there, it shouldn't be possible to restore the
fs to some sort of consistent state.

Good night,
Christian











>
> But extent tree update is really somehow trickier than I thought.
>
> Thanks,
> Qu
>
> >
> > Will keep you posted.
> >
> > Cheers,
> > C.
> >
>
