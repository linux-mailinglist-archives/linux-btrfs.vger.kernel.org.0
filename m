Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5515108D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 20:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgBCTwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 14:52:25 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39708 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCTwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 14:52:25 -0500
Received: by mail-ua1-f67.google.com with SMTP id 73so5804691uac.6
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 11:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Bkbgm2thLi+JNJYlczVeMZOY7xGZlhdYCLTevAE3MxQ=;
        b=rKpNUC9+5EwHcQHdKudWEc2TokNOlwSewnmt6rSriVl4K/uypvFGmT01CrriRgKxc9
         ErzWeQxBWu1hsWmcPZt90mKSxdsUCBO/RVFQX2sFXAkdFBgOeg1bVlixPjcF29ETGf1k
         iK5iO3PojoKBuc1rHJ5R4grdLg5lbhUrAUxZZ3K5Vbay6/TkjQPb1Lk3w/lkQD3EiSGw
         Iz+tSgXM6uacnyZJmvKbi7s9hp/4iAo32q4AeKqlOCL99dqPi8wYcT00g60ko0jh62WS
         R7mIopreEh3fcLQGjxBiyuyqEvZfkrfHIJsB/aVuhfvRibzzWJ6YomSOYyjFY8gG3HLE
         kmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=Bkbgm2thLi+JNJYlczVeMZOY7xGZlhdYCLTevAE3MxQ=;
        b=RlmhWxNbHDcxGFaysJVZArNg6tvrDhhBYfemvKP+hWQrDN71k47Z2LGk8n7r3+10Gg
         vU31hwCWACJC7RKMqrPuzwXhdwkqTRXIl5PWQ8pQrH42T45tsvLfPiQGDiOp1qKG2ck2
         D5s24AgDmXTjjn+TICvRuH7EdY4IsjzMKHK4AXewmPAa3nNqd9/oDVaC2DK3fTcRNcjH
         cY+S/f9eQ+XDEGxwLAjnXXZ9TMBd9tJHDNdkaMiXSjV068u5FevYX8FzINsQ8654SLvI
         D/HcjfjnGtm6bxKjZuBl5j/OMoWNbIGUfGLYTEj/Li7tnWaGl84vDiyCuUEwWOH6wira
         IKOg==
X-Gm-Message-State: APjAAAVm36GLqINZZh7QLru461LZJYxhKcgkoKjKmj6L/xmcIOx9FGpL
        0o3cxMAEFcfKA+42EK3n6Vgt+FgTw+I/0U2YYRM=
X-Google-Smtp-Source: APXvYqy/Pg/bMDFGvmoHWjUczGLNcvUnoKGcceZIp84j0XtTnwDb5AnoAg+NSPRsWeWlkShy9Aofju/NYMGKfY979zM=
X-Received: by 2002:ab0:738c:: with SMTP id l12mr14603143uap.135.1580759544445;
 Mon, 03 Feb 2020 11:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20200117140224.42495-1-josef@toxicpanda.com> <20200203175933.GB2654@twin.jikos.cz>
In-Reply-To: <20200203175933.GB2654@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 3 Feb 2020 19:52:13 +0000
Message-ID: <CAL3q7H7y_4-OQrLvEreYbMgu9TVAgxePo6YcMOUo7PrqDSBUJg@mail.gmail.com>
Subject: Re: [PATCH 0/6][v3] btrfs: fix hole corruption issue with !NO_HOLES
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 3, 2020 at 7:11 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Jan 17, 2020 at 09:02:18AM -0500, Josef Bacik wrote:
> > v2->v3:
> > - Rebased onto misc-next.
> > - Added a patch to stop using ->leave_spinning in truncate_inode_items.
> >
> > v1->v2:
> > - fixed a bug in 'btrfs: use the file extent tree infrastructure' that =
would
> >   result in 0 length files because btrfs_truncate_inode_items() was cle=
aring the
> >   file extent map when we fsync'ed multiple times.  Validated this with=
 a
> >   modified fsx and generic/521 that reproduced the problem, those modif=
ications
> >   were sent up as well.
> > - dropped the RFC
> >
> > ----------------- Original Message -----------------------
> > We've historically had this problem where you could flush a targeted se=
ction of
> > an inode and end up with a hole between extents without a hole extent i=
tem.
> > This of course makes fsck complain because this is not ok for a file sy=
stem that
> > doesn't have NO_HOLES set.  Because this is a well understood problem I=
 and
> > others have been ignoring fsck failures during certain xfstests (generi=
c/475 for
> > example) because they would regularly trigger this edge case.
> >
> > However this isn't a great behavior to have, we should really be taking=
 all fsck
> > failures seriously, and we could potentially ignore fsck legitimate fsc=
k errors
> > because we expect it to be this particular failure.
> >
> > In order to fix this we need to keep track of where we have valid exten=
t items,
> > and only update i_size to encompass that area.  This unfortunately mean=
s we need
> > a new per-inode extent_io_tree to keep track of the valid ranges.  This=
 is
> > relatively straightforward in practice, and helpers have been added to =
manage
> > this so that in the case of a NO_HOLES file system we just simply skip =
this work
> > altogether.
> >
> > I've been hammering on this for a week now and I'm pretty sure its ok, =
but I'd
> > really like Filipe to take a look and I still have some longer running =
tests
> > going on the series.  All of our boxes internally are btrfs and the box=
 I was
> > testing on ended up with a weird RPM db corruption that was likely from=
 an
> > earlier, broken version of the patch.  However I cannot be 100% sure th=
at was
> > the case, so I'm giving it a few more days of testing before I'm satisf=
ied
> > there's not some weird thing that RPM does that xfstests doesn't cover.
> >
> > This has gone through several iterations of xfstests already, including=
 many
> > loops of generic/475 for validation to make sure it was no longer faili=
ng.  So
> > far so good, but for something like this wider testing will definitely =
be
> > necessary.  Thanks,
>
> I've reviewed the series and will add it to for-next. The i_size
> tracking seems to be an important part that we want to merge before
> NO_HOLES is default in mkfs.

Can you elaborate a bit? I don't understand why you say this is
important in order to make NO_HOLES a default.
This series fixes a problem that only happens when not using the
NO_HOLES feature.

Thanks.

> It would be good to steer more focus on
> that during testing. If everything goes fine, the mkfs default can
> happen in 5.7. Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
