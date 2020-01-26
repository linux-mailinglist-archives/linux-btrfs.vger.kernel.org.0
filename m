Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F25149A58
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2020 12:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbgAZLRV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 06:17:21 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46642 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387394AbgAZLRU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 06:17:20 -0500
Received: by mail-oi1-f180.google.com with SMTP id 13so4022915oij.13
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jan 2020 03:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wo2BSjyNgpryq28C9+7dwZc/7kQyyI/sXuw897Foadg=;
        b=TDZ9S6nsFmznkC7+gkTd2eauFbGfHQw3/+fmjuPFLgNBfm3moajO8tAvCGli2wlm/8
         Nc58T7ZMn52hYY+T5JcfiXWC9JXKa9zfhFqyaWDXyD7YR/dcOjEuYovEJGXswVPQmciU
         W1XYgHfpXhwil3GNWv9vEmVtFbiiaURovxqKVRmqI+3fk5e9WX8gSy4VueVSwbGRIWmR
         MoZnHrGv6wncdK+Y7T/tBc7XOcqffbaPQbtBwCtRYHAcye3YFkOzsY5O2HNs8a/xuuE3
         rQIe7xpHnp7/5cdwCrDbTkJPtznaJuyiTk1awN1r8+m3cOf4Fg3Gl8GtH7HRowMuF2S3
         GGUg==
X-Gm-Message-State: APjAAAXqfSABongUuhzWlvIyoTRtreI8C2fxK4BAWEXP/sm1PnOVjA+e
        Zfr4rW9LDADFgk8IRF42uLDMNWtVOwPioyyzBhpnZ/LFRMY=
X-Google-Smtp-Source: APXvYqyV9r9HtAs6bwOsMYan/XkalHM9MGhfkp5Q3UmaMhfOUgwJ26p7VWC+ncncXR3FHSaOAA8xeGaqSwtYuhJ/n58=
X-Received: by 2002:a05:6808:6d6:: with SMTP id m22mr4347580oih.138.1580037439651;
 Sun, 26 Jan 2020 03:17:19 -0800 (PST)
MIME-Version: 1.0
References: <CAH+WbHxsOEt9Z7t=ubtCmoCb2f4nDpMCCSXnT+-k5oR2pQFpOQ@mail.gmail.com>
 <688e0961-c80e-4db0-bf87-dabbfc72adf1@gmail.com> <71251506-88e5-c481-abdf-56dcd625b139@gmx.com>
 <CAH+WbHyYpP0ACzc+USAvwQU5SSaTbMLXbQRsc=mUWdCk23LQQg@mail.gmail.com> <0102016fdd701abe-0f9b4c13-9f43-4b31-af0e-fa115edb3d69-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016fdd701abe-0f9b4c13-9f43-4b31-af0e-fa115edb3d69-000000@eu-west-1.amazonses.com>
From:   Thorsten Hirsch <t.hirsch@web.de>
Date:   Sun, 26 Jan 2020 12:17:08 +0100
Message-ID: <CAH+WbHyR7HC0-S3oaamk+1omON+JrBbq-MYku1k4mxAdhWJTMA@mail.gmail.com>
Subject: Re: tree first key mismatch detected (reproducible error)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you, Martin. So I started memtester yesterday and meanwhile it
has run 90 loops w/o any errors.
Back to btrfs:

- I could restore pretty much all data with "btrfs restore", except
for some virtualbox disk images
- "btrfs check --init-extent-tree" took some hours to finish, but I
still couldn't mount the partition due to multiple "corrupt leaf"
errors
- mounting with "-o backuproot" resulted in the same error
- "btrfs rescue super-recover" said everything was fine
- after "btrfs rescue chunk-recover" or "btrfs check --repair" there
was only 1 "corrupt leaf" error left, but mounting was still not
possible

So basically the mount errors after "btrfs check --init-extent-tree"
and all later commands looked like this:

[64385.439530] BTRFS critical (device nvme0n1p3): corrupt leaf:
block=156450816 slot=30 extent bytenr=51548897280 len=262144 invalid
generation, have 315981823 expect (0, 2265510]
[64385.440779] BTRFS error (device nvme0n1p3): block=156450816 read
time tree block corruption detected
[64385.440785] BTRFS error (device nvme0n1p3): failed to read block groups: -5
[64385.493696] BTRFS error (device nvme0n1p3): open_ctree failed
mount: /mnt/nvme: wrong fs type, bad option, bad superblock on
/dev/nvme0n1p3, missing codepage or helper program, or other error.

Then I gave up and called mkfs.btrfs. Currently the restored data is
on its way back to the device.

-- 
Thorsten

Am Sa., 25. Jan. 2020 um 17:01 Uhr schrieb Martin Raiber <martin@urbackup.org>:
>
> On 25.01.2020 16:44 Thorsten Hirsch wrote:
> > Thanks, guys.
> >
> > However, checking the RAM with memtest86 hasn't revealed any errors.
> > Currently I let it run another pass, but so far everything's good.
> > Here's the output of btrfs check...
>
> just from my experience with non-ECC RAM:
> When I had RAM corruption it only occurred after a few days of uptime
> and only when I ran memtester on Linux. memtest86/memtest86+ didn't show
> any problems even when running for a week (and in multi cpu mode).
>
> > [1/7] checking root items
> > [2/7] checking extents
> > leaf parent key incorrect 109690880
> > bad block 109690880
> > ERROR: errors found in extent allocation tree or chunk allocation
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > root 5 inode 3583162 errors 1040, bad file extent, some csum missing
> > root 5 inode 3767022 errors 1040, bad file extent, some csum missing
> > root 5 inode 3819591 errors 1040, bad file extent, some csum missing
> > root 5 inode 4108194 errors 1040, bad file extent, some csum missing
> > ERROR: errors found in fs roots
> > Opening filesystem to check...
> > Checking filesystem on /dev/nvme0n1p3
> > UUID: 26717c9f-df62-4c57-a482-b9e4880b31e6
> > found 6132469760 bytes used, error(s) found
> > total csum bytes: 0
> > total tree bytes: 4161536
> > total fs tree bytes: 0
> > total extent tree bytes: 3850240
> > btree space waste bytes: 1115823
> > file data blocks allocated: 108003328
> >  referenced 108003328
> >
>
