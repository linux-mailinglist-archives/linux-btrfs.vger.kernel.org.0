Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D45E14E46D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 22:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgA3VKE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 16:10:04 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:33113 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbgA3VKE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 16:10:04 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 491ADA9812;
        Thu, 30 Jan 2020 22:10:02 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
Date:   Thu, 30 Jan 2020 22:10:01 +0100
Message-ID: <1887603.ctEADUaVB5@merkaba>
In-Reply-To: <CAJCQCtSgK1f3eG5XzaHmV+_xAgPFhAGvnyxuUOmGRMCZfKaErw@mail.gmail.com>
References: <112911984.cFFYNXyRg4@merkaba> <21104414.nfYVoVUMY0@merkaba> <CAJCQCtSgK1f3eG5XzaHmV+_xAgPFhAGvnyxuUOmGRMCZfKaErw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy - 30.01.20, 21:18:41 CET:
> On Thu, Jan 30, 2020 at 1:02 PM Martin Steigerwald 
<martin@lichtvoll.de> wrote:
> > Chris Murphy - 30.01.20, 17:37:42 CET:
> > > On Thu, Jan 30, 2020 at 3:41 AM Martin Steigerwald
> > 
> > <martin@lichtvoll.de> wrote:
> > > > Chris Murphy - 29.01.20, 23:55:06 CET:
> > > > > On Wed, Jan 29, 2020 at 2:20 PM Martin Steigerwald
> > > > 
> > > > <martin@lichtvoll.de> wrote:
> > > > > > So if its just a cosmetic issue then I can wait for the
> > > > > > patch to
> > > > > > land in linux-stable. Or does it still need testing?
> > > > > 
> > > > > I'm not seeing it in linux-next. A reasonable short term work
> > > > > around
> > > > > is mount option 'metadata_ratio=1' and that's what needs more
> > > > > testing, because it seems decently likely mortal users will
> > > > > need
> > > > > an easy work around until a fix gets backported to stable. And
> > > > > that's gonna be a while, me thinks.
> > > > > 
> > > > > Is that mount option sufficient? Or does it take a filtered
> > > > > balance?
> > > > > What's the most minimal balance needed? I'm hoping -dlimit=1
> > > > 
> > > > Does not make a difference. I did:
> > > > 
> > > > - mount -o remount,metadata_ratio=1 /daten
> > > > - touch /daten/somefile
> > > > - dd if=/dev/zero of=/daten/someotherfile bs=1M count=500
> > > > - sync
> > > > - df still reporting zero space free
> > > > 
> > > > > I can't figure out a way to trigger this though, otherwise I'd
> > > > > be
> > > > > doing more testing.
> > > > 
> > > > Sure.
> > > > 
> > > > I am doing the balance -dlimit=1 thing next. With
> > > > metadata_ratio=0
> > > > again.
> > > > 
> > > > % btrfs balance start -dlimit=1 /daten
> > > > Done, had to relocate 1 out of 312 chunks
> > > > 
> > > > % LANG=en df -hT /daten
> > > > Filesystem             Type   Size  Used Avail Use% Mounted on
> > > > /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
> > > > 
> > > > Okay, doing with metadata_ratio=1:
> > > > 
> > > > % mount -o remount,metadata_ratio=1 /daten
> > > > 
> > > > % btrfs balance start -dlimit=1 /daten
> > > > Done, had to relocate 1 out of 312 chunks
> > > > 
> > > > % LANG=en df -hT /daten
> > > > Filesystem             Type   Size  Used Avail Use% Mounted on
> > > > /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
> > > > 
> > > > 
> > > > Okay, other suggestions? I'd like to avoid shuffling 311 GiB
> > > > data
> > > > around using a full balance.
> > > 
> > > There's earlier anecdotal evidence that -dlimit=10 will work. But
> > > you
> > > can just keep using -dlimit=1 and it'll balance a different block
> > > group each time (you can confirm/deny this with the block group
> > > address and extent count in dmesg for each balance). Count how
> > > many it takes to get df to stop misreporting. It may be a file
> > > system specific value.
> > 
> > Lost the patience after 25 attempts:
> > 
> > date; let I=I+1; echo "Balance $I"; btrfs balance start -dlimit=1
> > /daten ; LANG=en df -hT /daten
> > Do 30. Jan 20:59:17 CET 2020
> > Balance 25
> > Done, had to relocate 1 out of 312 chunks
> > Filesystem             Type   Size  Used Avail Use% Mounted on
> > /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
> > 
> > 
> > Doing the -dlimit=10 balance now:
> > 
> > % btrfs balance start -dlimit=10 /daten ; LANG=en df -hT /daten
> > Done, had to relocate 10 out of 312 chunks
> > Filesystem             Type   Size  Used Avail Use% Mounted on
> > /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
> > 
> > Okay, enough of balancing for today.
> > 
> > I bet I just wait for a proper fix, instead of needlessly shuffling
> > data around.
> 
> What about unmounting and remounting?

Does not help.
 
> There is a proposed patch that David referenced in this thread, but
> it's looking like it papers over the real problem. But even if so,
> that'd get your file system working sooner than a proper fix, which I
> think (?) needs to be demonstrated to at least cause no new
> regressions in 5.6, before it'll be backported to stable.

I am done with re-balancing experiments.

-- 
Martin


