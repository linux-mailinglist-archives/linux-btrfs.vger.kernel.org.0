Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A1614B465
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 13:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgA1Moa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 07:44:30 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:43870 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgA1Moa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 07:44:30 -0500
Received: by mail-ua1-f44.google.com with SMTP id o42so4739442uad.10
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2020 04:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=D5VIOGxnqCEtG4yPFN5jY3PSdnzYWVL84Jtx0L/jmmk=;
        b=V582gJWubIjQ+0FvsqfxG+f/+CsINCt62YmPIcYKUY7WlmWi3O/xcQvrdrL2UPzsxU
         KuR1SRiQAEVQXrkUY1b7TegxWUQ0l6e7NkCqFPR1LaIX61p58VK9R3/QDB2xa/5fABGB
         hHSWKzVTbWPwQrIDqJFgoHJ6/mWRuLXKXxAk6vJZ43oE4PXxl3yBtySpQm07kn599t+o
         nMpL/Sjy3ZYttFX3t3RkMV4dg2vU+kyModUkcWgg3LYdhXSPu6uRtoEKxQIOBLGwYdhi
         LGwRORUAqSxjKrEOfsHK6vkLqmEx2fDq2Id0sB8yhf2T+HCq9HIqpjOdFCZsSGGsUTdU
         ITxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=D5VIOGxnqCEtG4yPFN5jY3PSdnzYWVL84Jtx0L/jmmk=;
        b=FQAtIOSis0flNAWp6UZhsokLWCy/S29I6g8765m0993yK7ZwYQXVKy+9mWnRATLymr
         1OyIG8x0DwHfph4IsLIDwZK2U894F9bkQwRVpJ9+XIDg9HjHH6aZet7FevHIesvLVxaG
         VbpfRSITW9cXY+acrsew5dAgdQIgEvmcf7I5T7VEwouXU4SE6TBfOsgOM7CZTiM2Hc0P
         x2DN1ROi53upHb09iRoLzOy01U93tM5YSuo8Sf7/BBMWWeAEOY9zgDwNjHI1lwWshWvS
         vli35RPXxzaV5DZEm6DEfyXOQzHrjAs8ALdnOs4QpnlywkbNxnqMF6NVV8CGqAeTTNn5
         T5TA==
X-Gm-Message-State: APjAAAVdNRO/8HYky1XSt1tpW0y+4OyUntoXFpWICHzGVwx8ZvcLRkH7
        Yt8fEI4YvZkCAa3FHx9ziUmLOb8TUiPfGhBeoQky2JFZXDc=
X-Google-Smtp-Source: APXvYqyopcdTYSUB9bSpLVPF67bxqpttHiUkgGXyNzbpryXKUc0U9Nm4FSAifohBFg9t0p+aO9qAiVWVKG6Nz9Nlj+o=
X-Received: by 2002:ab0:5bc6:: with SMTP id z6mr13079692uae.46.1580215468402;
 Tue, 28 Jan 2020 04:44:28 -0800 (PST)
MIME-Version: 1.0
References: <CACurcBt_M-x=5CYhVUCiJq-yiUQF6-2a9PhWtmjfpJUYtAxt0Q@mail.gmail.com>
 <6c605879-0a52-337d-f467-82c7f0b04d76@suse.com>
In-Reply-To: <6c605879-0a52-337d-f467-82c7f0b04d76@suse.com>
From:   Robbie Smith <zoqaeski@gmail.com>
Date:   Tue, 28 Jan 2020 23:44:17 +1100
Message-ID: <CACurcBsv-D6MtunKrfY7ZKwxebfwGRejjfev7aUTgxwUzOG=Sw@mail.gmail.com>
Subject: Re: Unexpected deletion behaviour between subvolume and normal directory
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It turns out that I made a mistake when deleting the files: I typed
`rm -r /library/Music/*` instead of `rm -r /library/music/*` like I
intended. Substitute "Music" for "newmusic" in the examples above. So
I deleted files from the subvolume by mistake.

Now onto my next problem: `btrfs restore` is only able to recover
files that weren't yet deleted by my monumental stuff-up. It appears
`rm` went in alphabetical order, so I've lost only those artists that
started with A. B, or (some) C. However, systemd in its infinite
wisdom decided to automount my library drive while the restore was in
progress, and I suspect the space_cache mount option kicked in and
wiped the files forever. `btrfs-find-root` wasn't having much success,
but the undelete script here[1] is finding the files I wanted, so now
I'm just gradually working through everything.

I think I'll be able to recover most things.

[1]https://raw.githubusercontent.com/danthem/undelete-btrfs/master/undelete=
.sh

On Tue, 28 Jan 2020 at 22:38, Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 28.01.20 =D0=B3. 12:25 =D1=87., Robbie Smith wrote:
> > I wanted to try to convert my music library from a directory into a
> > subvolume so I could use btrfs send/receive to transfer (changed)
> > files between it and a USB backup. A bit of Googling suggested that
> > the approach would be:
> >
> >> btrfs subvolume create /library/newmusic
> >> cp -ar --reflink=3Dauto /library/music/* /library/newmusic/.
> >> rm -r /library/music
> >
> > After about 30 seconds I realised that it was deleting files from both
> > /library/music and /library/newmusic. It appears I've only lost
> > everything starting with A, B or C, so I unmounted the device, and am
> > currently trying to use `btrfs restore` to get the files back and it
> > doesn't seem to be finding them.
> >
> > I'm pretty sure deleting files from directory A isn't supposed to also
> > delete them from directory B, but that's what it did. Is this a bug?
> >
>
> Can you reproduce the same thing with a simple test directory? I was not
> able to reproduce it here?
>
> > Robbie
> >
