Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F2179092
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 13:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbgCDMpt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 07:45:49 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46224 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgCDMpt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 07:45:49 -0500
Received: by mail-yw1-f68.google.com with SMTP id y62so1726777ywd.13
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 04:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YL/bjIcrQJVbGneyJ6kCD6GeELJ2c2+UW8dmeq20SlM=;
        b=uS3oFekqLfSc97TzjfDyj7TCfyOD+kxFeaG+Q0n5O4rjq7wLRn2PseamEWBV2uRObO
         kK+ZYwlXely+BBfCz/yekNWJ3o6psqr02hitdxNybBeQf7ABOa1E1oZX46YDhgNBS4Ml
         g9CzI6LoPnkP1U+21AoDjA8mp0RaqHjkdVVmTa6gW44X175LwvfkjIzE2mhjZUYgfYEO
         Hr/30aCWhmos9zltgaRE8YTaboZj1DVfp+mp4Zc5EGv1pKclHuXkEDq+oUual9NcNfZ6
         UzXu87iOiRC3MORU/MxvvHxhrofOWjFkpCO5sGEFAIsT5zVQn818WWBwxC4f1rSzM0/9
         Yj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YL/bjIcrQJVbGneyJ6kCD6GeELJ2c2+UW8dmeq20SlM=;
        b=Ue06ovOi7J0bPSlxj1N0VfI28WUAlKslaX21LZ+50ioJr8KY4CZ9iGHcjOGnyQAiZf
         2AcG8cLp4ep/beYvwH0lRWFpOtjHatjQnbHJDF6Yigdwyw9ca49qdsY4JwFjOn0QG0rS
         ovB9LpVXecDsLia14FzGmyB2B1c5/36VsXO4O/PuW6O2OFzvPNuxAdGXFzQ60JLsmXYk
         IypIMliVFfoGw2TGBwPkkQKZV9FAzXii0cC4zBeG299jlkagkm3wc5VBDgdF53vBZ0AB
         6irdHL03bI5IEwhhL59Bs0Xcx5nqJ19auj3BJ/DKE96/p+UgC81E7bT0Xe47FAmiu0F2
         p6bQ==
X-Gm-Message-State: ANhLgQ2x2bSBzb2kcvet3cUuqNtOHCRd7j4406WY3+mmrpX1JILTR1n1
        PeRJQhTszZSpzKrzLzUb4bRbB5VhUNYA16d+5Hu16AXR
X-Google-Smtp-Source: ADFU+vsTmmjzc39rO7agnOl8LYotUMPX99CG1DpD19CWG3F9Nl0BdZzd72asXu596dLc/0yESbg14zY4bhaeJghQGdA=
X-Received: by 2002:a0d:c243:: with SMTP id e64mr2841839ywd.12.1583325948102;
 Wed, 04 Mar 2020 04:45:48 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
 <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com>
 <CAG_8rEcXpWUyUqmi3fe8BicZXQODJP2ZS69Z=BBcBPfAQBuSHA@mail.gmail.com>
 <CAJCQCtR7prMai9dYndLZ4Wg4tSL7kHZaLLK8c5p_4fDG2qoYnA@mail.gmail.com>
 <CAG_8rEf-kdju-OPhVUVWF8qNMM=xiUnWuBgODiwzGnRMzJYNpg@mail.gmail.com> <CAJCQCtTz-KW4WLJtcX9NGSPiCmCZ81_bXE+YBhn2_DocvnefZw@mail.gmail.com>
In-Reply-To: <CAJCQCtTz-KW4WLJtcX9NGSPiCmCZ81_bXE+YBhn2_DocvnefZw@mail.gmail.com>
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Wed, 4 Mar 2020 12:45:36 +0000
Message-ID: <CAG_8rEey=ZNbrJYKNiyvt0_g068_Bu=XikCs=gQwd=ROQ2y50w@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Jonathan H <pythonnut@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 4 Mar 2020 at 06:32, Chris Murphy <lists@colorremedies.com> wrote:

> a. the write hole doesn't happen with raid1, and your metadata is
> raid1 so any file system corruption is not related to the write hole

That makes sense and I had no problem moving the metadata blocks from
the failed disk onto the working ones.

> c. to actually be affected by the write hole problem, the stripe with
> mismatching parity strip must have a missing data strip such as a bad
> sector making up one of the strips, or a failed device. If neither of
> those are the case, it's not the write hole, it's something else.

Normally there would not have been any power failures as the machine
is protected by a UPS and auto shuts down when the battery is getting
low.  Certainly there would have been none between the filesystem
being created and the disk failure.  The only exception is that after
the disk failure, and after the device remove had failed I had to turn
the power off because the machine would not shut down.  As the device
remove had moved very little data before failing I had used balance to
move data away from the failed disk, i.e. to restore redundancy and
mitigate the disk of a further disk failure.  That is how I came to
migrate the metadata ahead of the data and then used a range filter to
migrate the data in stages.  That is where I discovered that when
migrating a range of block groups failed all subsequent attempts to
use balance resulted in an infinite loop and that is what lead to the
need to turn the power off.  Subsequently I was able to avoid a repeat
of that by applying a patch from this list to make the balance
cancellable in more places and also discovered that clearing the space
cache avoided the loop anyway.

> d. before there's a device or sector failure, a scrub following a
> crash or power loss will correct the problem resulting from the write
> hole.

Worth knowing for the future.

> It can't fix them when the file system is mounted read only.

I had mounted it r/w by then.

> The most obvious case of corruption is a checksum mismatch (the
> onthefly checksum for a node/leaf/block compared to the recorded
> checksum). Btrfs always reports this.

And it did, but only for the relocation tree that was being built as
part of the balance.  I am sure you or Qu said in a previous e-mail
that this is a temporary structure only built during that operation so
should not have been corrupted by previous problems.  As no media
errors were logged either that must surely mean that either there is a
bug in constructing the tree or corrupted data was being copied from
elsewhere into the tree and only detected after that copy rather than
before.

> So that leaves the less obvious cases of corruption where some
> metadata or data is corrupt in memory, and a valid checksum is
> computed on already corrupt data/metadata, and then written to disk.

But if the relocation tree is constructed during the balance operation
rather than being a permanent structure then the chance of flipped
bits in memory corrupting it on successive attempts is surely very
small indeed.

> At least Btrfs gave you a chance. But that's the gotcha
> of bad RAM or other sources of bit flips in the storage stack.

I am not complaining about checksums - yes it is better to know if
your data has been corrupted, I just want btrfs to be as robust as
possible.

> From six days ago, your dmesg:
>
> Sep 27 15:16:08 meije kernel:       Not tainted 5.1.10-arch1-1-ARCH #1

Sorry for the confusion from having theadjacked.  My kernel history is:

Sep 04 13:53:53 meije kernel: Linux version 5.1.10-arch1-1-ARCH
Oct 14 14:31:56 meije kernel: Linux version 5.3.6-arch1-1-ARCH
Nov 29 12:25:21 meije kernel: Linux version 5.4.0-arch1-1
Dec 30 17:30:49 meije kernel: Linux version 5.4.6-arch3-1
Jan 04 15:54:22 meije kernel: Linux version 5.4.7-arch1-1
Jan 09 15:43:56 meije kernel: Linux version 5.4.8-arch1-1
Jan 22 10:15:30 meije kernel: Linux version 5.4.13-arch1-1
Jan 26 17:23:36 meije kernel: Linux version 5.4.15-arch1-1
Jan 29 22:56:42 meije kernel: Linux version 5.5.0-arch1-1
Feb 10 16:28:52 meije kernel: Linux version 5.5.2-arch2-2
Feb 14 20:23:08 meije kernel: Linux version 5.5.3-arch1-1
Feb 16 16:06:43 meije kernel: Linux version 5.5.3-arch1-1
Feb 18 08:36:49 meije kernel: Linux version 5.5.4-arch1-1
Feb 26 17:11:08 meije kernel: Linux version 5.5.6-arch1-1
Mar 03 20:45:28 meije kernel: Linux version 5.5.7-arch1-1

> Actually what I should have asked is whether you ever ran 5.2 - 5.2.14
> kernels because that series had a known corruption bug in it, fixed in
> 5.2.15

No, I skipped the whole of 5.2 because I saw messages about corruption
on this list.

> I think btrf filesystem usage doesn't completely support raid56 is all
> it's saying.
>
> 'btrfs fi df' and 'btrfs fi show' should show things correctly

They do, and the info for individual devices in the output of btrfs fi
usage also looks completely believable.  It's only the summary at the
top that's obviously incorrect.

> I don't understand the question. The device replace command includes
> 'device add' and 'device remove' in one step, it just lacks the
> implied resize that happens with add and remove.

When i did the add and remove separately, the add succeeded and the
remove failed (initially) having moved very little data.  If that were
to happen with those same steps within a replace would it simply stop
where it found the problem, leaving the new device added and the old
one not yet removed, or would it try to back out the whole operation?

> The free space cache isn't that important. It can be discarded and
> reconstructed. It's an optimization.

Of course, but if it wasn't for Jonathan mentioning that btrfs check
had found his space cache to be corrupt I would never have
hypothesised that the same might be happening for me as there were no
messages in the log about the cache or anything that looked like an
error, only an infinite loop.  I think what was happening was that
moving the block group was failing with an "out of space" error and
the loop simply retries it in the hope that some space has become
available since, and the out of space error was in turn caused by the
corrupt space cache.

So in summary, I believe I was suffering from a situation in which,
for a very small number of data blocks, something went wrong in the
reconstruction process or some associated metadata was bad such that:

1. Building the relocation tree went wrong so that it had a checksum error.
2. The free space cache became corrupt.

Regards,
Steve.
