Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4306D72E77
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 14:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfGXMKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 08:10:39 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36979 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGXMKj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 08:10:39 -0400
Received: by mail-ua1-f68.google.com with SMTP id z13so18362187uaa.4
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2019 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=s/FmTqS/uJxvqBmgszJaaf+BhB0AprTkDQZ5hy0MzyM=;
        b=KwCgC0SCdR3itCyeOvWIEa+4qg4Fsg+Re5yL2k+0AWo3m+opOuI70/vErHk1Qc3896
         5qJksQ3HVh0x4nckXMS6ouzqv5w2JHK9F7qS1QMVz4qQQxK5QKu2BRociMdKMQJ+pUvK
         BinslBJivz3UOLJnEvMkdO1SHlwDYdehEjNJhZ2awL0IHj8Lx/4t8F5dtDxYTjjt0jaB
         aY/j8pqsTIZymvX8/PASduB5gZB7shClA2LyRHtGJGviwAuMTonxeOOkHNQWXy/bt0Wh
         z9+mr/W1SVzKOVUekgMNuLPXLaLyPXzEJpvwmcamyLBJRlea+90xGA3lt68mShhs2nXw
         neQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=s/FmTqS/uJxvqBmgszJaaf+BhB0AprTkDQZ5hy0MzyM=;
        b=SAxLoriizgqp99iCNZ+Nly9r+U381sNoq8okR7+oP1gtldy6uIVLnixdy3MWihdpj2
         fLE5IF6nbdGHWdEZOwQMxjH8vlpOZocfVu0ktMSfAhp0sNpNA3lP+1MqUhO/Yl7ZHpLj
         odBnXj7Mf1cdrSD4LIgq62/UEGdR+P9gz3eDo3lAuMRDhwhoslo6BsPf4Tx5UtuaEpFZ
         aH7HCJpUflJn508xuoFrD8c10vvn3iS8YSDwrRiltehRttINaefHmeETIEGRNZ3shSmJ
         zTTTajxZP19D8PIr0XlirBKmyTXTPEYJFGGvPMy+Oz8VRYV4IokCZNCm7NDBzbCPh+s7
         /Ztg==
X-Gm-Message-State: APjAAAXK5mxZWT0ekFEtoNSWFu/+mJa13cBGLoLSU/a71khjaxWnxAu2
        4wD/1mkvqEVU4CV48i1iDVmFqivNd/vijeY495Y=
X-Google-Smtp-Source: APXvYqxOeIXib+N3zJTIMZA1HvX3xr5Ipz6H33UgcZUKQ0jCNCBHvNdDeiEIlLaCOhcpG4aDFkYBhb1gOwvpD/27LaI=
X-Received: by 2002:ab0:66:: with SMTP id 93mr26801267uai.135.1563970238067;
 Wed, 24 Jul 2019 05:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563822638.git.osandov@fb.com> <3035988eb320d8582006bbbfa0e872c0c4532889.1563822638.git.osandov@fb.com>
 <20190724112250.GK2868@twin.jikos.cz>
In-Reply-To: <20190724112250.GK2868@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 24 Jul 2019 13:10:27 +0100
Message-ID: <CAL3q7H6Q37XOxn3qkMM-XMW7m+HcVx55AhpZfeogKzaA1AfHhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] btrfs-progs: receive: remove commented out transid checks
To:     dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 24, 2019 at 12:23 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Jul 22, 2019 at 12:15:02PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> >
> > The checks for a subvolume being modified after it was received have
> > been commented out since they were added back in commit f1c24cd80dfd
> > ("Btrfs-progs: add btrfs send/receive commands"). Let's just get rid of
> > the noise.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  cmds/receive.c | 25 -------------------------
> >  1 file changed, 25 deletions(-)
> >
> > diff --git a/cmds/receive.c b/cmds/receive.c
> > index b97850a7..830ed082 100644
> > --- a/cmds/receive.c
> > +++ b/cmds/receive.c
> > @@ -344,15 +344,6 @@ static int process_snapshot(const char *path, cons=
t u8 *uuid, u64 ctransid,
> >                       parent_subvol->path[sub_len - root_len - 1] =3D '=
\0';
> >               }
> >       }
> > -     /*if (rs_args.ctransid > rs_args.rtransid) {
>
> This looks like a (missing) sanity check, don't we want it?

Un-commenting that will cause receive to fail if we deduplicate into
readonly subvolumes and snaphosts and then use them for send
operations, breaking existing use cases.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
