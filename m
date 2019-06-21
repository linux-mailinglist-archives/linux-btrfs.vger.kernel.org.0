Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE2884E669
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2019 12:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFUKtK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jun 2019 06:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfFUKtK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jun 2019 06:49:10 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A50E42084E;
        Fri, 21 Jun 2019 10:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561114149;
        bh=ElGVxNtIXxdBeRnUw73zRSBOgpUV3djClHJKZDNi8jg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l5vnXkAN+Fa7p+jLT/V2f/+AtEL6pqVqKrlQo4A4IWeCncLNBiiXOoGiEb/c9eKfc
         NRSELDo4kKljWRSv/Wf5EbMrwEfdn4+eo51nNhWfcKo/Y3egdYt4vFPQek8KWoL+t+
         jmriIJuAA+ZXMslwxOJK0H2LYVCclTrVjRiGKvZo=
Received: by mail-vs1-f54.google.com with SMTP id l20so3540719vsp.3;
        Fri, 21 Jun 2019 03:49:09 -0700 (PDT)
X-Gm-Message-State: APjAAAVQ4aIEWL9FVWdijVl2ECEsFo2Adb6bYus9XfSdWdSIvzJtVO2L
        1QOcFu/ynN6JCkT7sM9ypboSNtoEj869P7BFPjY=
X-Google-Smtp-Source: APXvYqzt+BRHPJCiTZzYJJOu8mEWk5ssE2M7sCA5TtwTKpTAjBTsI0IM0T22yCKylMidaOblvzE2Cwvn1afbDHjfgPg=
X-Received: by 2002:a67:d990:: with SMTP id u16mr50723782vsj.95.1561114148825;
 Fri, 21 Jun 2019 03:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190619120624.9922-1-fdmanana@kernel.org> <20190621103642.GK15846@desktop>
In-Reply-To: <20190621103642.GK15846@desktop>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 21 Jun 2019 11:48:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4YqSZSdUo5zrFKjmtDEaOKak2YHVf9MR3y9WdXnE2xnw@mail.gmail.com>
Message-ID: <CAL3q7H4YqSZSdUo5zrFKjmtDEaOKak2YHVf9MR3y9WdXnE2xnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] generic/059: also test that the file's mtime and
 ctime are updated
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 21, 2019 at 11:36 AM Eryu Guan <guaneryu@gmail.com> wrote:
>
> On Wed, Jun 19, 2019 at 01:06:24PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test as well that hole punch operations that affect a single file block
> > also update the file's mtime and ctime.
> >
> > This is motivated by a bug a found in btrfs which is fixed by the
> > following patch for the linux kernel:
> >
> >  "Btrfs: add missing inode version, ctime and mtime updates when
> >   punching hole"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/059 | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/tests/generic/059 b/tests/generic/059
> > index e8cb93d8..fd44b2ea 100755
> > --- a/tests/generic/059
> > +++ b/tests/generic/059
> > @@ -18,6 +18,9 @@
> >  #
> >  #  Btrfs: add missing inode update when punching hole
> >  #
> > +# Also test the mtime and ctime properties of the file change after punching
> > +# holes with ranges that operate only on a single block of the file.
> > +#
> >  seq=`basename $0`
> >  seqres=$RESULT_DIR/$seq
> >  echo "QA output created by $seq"
> > @@ -68,6 +71,13 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
> >  # fsync log.
> >  sync
> >
> > +# Sleep for 1 second, because we want to check that the next punch operations we
> > +# do update the file's mtime and ctime.
> > +sleep 1
>
> Is this supposed to be after recording the initial c/mtime? i.e. moving
> it after c/mtime_before?

Either way is fine. Capturing the times right before or right after
the sleep, gives the same values as nothing changed the file.

Btw, I had noticed the other day that the second "echo" has
$mtime_after instead of $ctime_after (copy-paste mistake).
Do you want me to send a v2 fixing that typo, or you can do it
yourself when you pick the patch?

Thanks.
>
> Thanks,
> Eryu
>
> > +
> > +mtime_before=$(stat -c %Y $SCRATCH_MNT/foo)
> > +ctime_before=$(stat -c %Z $SCRATCH_MNT/foo)
> > +
> >  # Punch a hole in our file. This small range affects only 1 page.
> >  # This made the btrfs hole punching implementation write only some zeroes in
> >  # one page, but it did not update the btrfs inode fields used to determine if
> > @@ -94,5 +104,13 @@ _flakey_drop_and_remount
> >  echo "File content after:"
> >  od -t x1 $SCRATCH_MNT/foo
> >
> > +mtime_after=$(stat -c %Y $SCRATCH_MNT/foo)
> > +ctime_after=$(stat -c %Z $SCRATCH_MNT/foo)
> > +
> > +[ $mtime_after -gt $mtime_before ] || \
> > +     echo "mtime did not increase (before: $mtime_before after: $mtime_after"
> > +[ $ctime_after -gt $ctime_before ] || \
> > +     echo "ctime did not increase (before: $ctime_before after: $mtime_after"
> > +
> >  status=0
> >  exit
> > --
> > 2.11.0
> >
