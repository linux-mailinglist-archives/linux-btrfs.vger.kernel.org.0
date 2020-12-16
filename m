Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821322DC087
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 13:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLPMxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 07:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPMxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 07:53:02 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFF4C06179C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 04:52:21 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id n18so7882944ual.9
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 04:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=27R2vdM9sHlOdLxICyRJWLXAp5WbFLxQ+nscC47E4/I=;
        b=Gj2MuQJ+mzvn+qQpCpX9xitpmt1inzT5y9mItkYI7nYEx3sANqgmackQDfvL/Z/KzE
         zjJVDQj6fCFTWCxxv8S2TOdQPZXmCEwCn2d5i1Mhqji/nSijvUDTZL1PsDG/OjLKAcl1
         gymR0Vsv38CYN7Q+e7/jMzRdqxNzUcuGc3ltnwdEk9h87bn3m59pR0NQ5SDYL5B09zqs
         2RN/uV5lgFs66Vh0ywVZMEm0F95gpn9KAGayilGLJkoXhF30W7B8OTDq8yF4PUq823LM
         Vrk1iQPurRfQhCLtz3CmIR0/Q23uEpQxk7VLtfWL+V6qTrI6sgauyca3rcrBPttdtlt5
         VhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=27R2vdM9sHlOdLxICyRJWLXAp5WbFLxQ+nscC47E4/I=;
        b=CPLZd1HJPUsMViMmR1k/2NHYmuSozZvsTwBHRXXi+1FmUQcE7L3ToWiOsapwpjV7FN
         P6s2j3y8Q/iE/BhwW2IPBMlsyOqEzKDTyxTkNQqdYUavrkXe69Mxo30/mGGzAuaQ1uq3
         OEHaUZ+zTuKZTCiGHR9UbSe9WtqUDG47GfjV0QQ1pkQyZNXAqjk5QbW9WtOL47VIqiPV
         FERBT0xLKaVJm4LXxAfjsyci1FgFIr3v89iGKsme/YrQCfAIoG4SXiWAiWPFPsS7pLAM
         6LmbT12//AFqCg/vaOMtIh3fo4tpptOJlywIR24+OWOoLhXfbfGGwFt5mfvY7Ceg1PVx
         Itxw==
X-Gm-Message-State: AOAM532p2uvglzVHyDIRmS0H+Sg8AGv7maTaNdVVZ8f+iWg8O2hJWQ3L
        66Z8Y2gGGbOWPmOXQO8504QjRJZAgCx0rb9s5N5txoOreEVp3g==
X-Google-Smtp-Source: ABdhPJzUXUDaz7cvCH1t6VtoAqAX4h91TGMa3Xp4d2L2od3GNP7q+hCZ4RDZm9mCnna4eth2e8wbIi50tqfk2jK4/5c=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr4685192uam.19.1608123140112;
 Wed, 16 Dec 2020 04:52:20 -0800 (PST)
MIME-Version: 1.0
References: <20201211164812.459012-1-realwakka@gmail.com> <20201211164812.459012-2-realwakka@gmail.com>
 <20201211173025.GO6430@twin.jikos.cz> <20201211174629.GQ6430@twin.jikos.cz>
 <CABnRu57w3aw=jPBbpSNYfyRKxs1z7onwWzqjg+=r6jQjwNYUXw@mail.gmail.com> <20201216105203.GA14127@realwakka>
In-Reply-To: <20201216105203.GA14127@realwakka>
From:   Su Yue <damenly.su@gmail.com>
Date:   Wed, 16 Dec 2020 20:52:08 +0800
Message-ID: <CABnRu55J04cu2sbc_f4gR_bOw3_sSMvu1Bs-sGyFhJ=cCRdMuA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] btrfs-progs: device stats: add json output format
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 6:52 PM Sidong Yang <realwakka@gmail.com> wrote:
>
> On Wed, Dec 16, 2020 at 02:30:04PM +0800, Su Yue wrote:
> > On Sat, Dec 12, 2020 at 3:04 AM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Fri, Dec 11, 2020 at 06:30:25PM +0100, David Sterba wrote:
> > > > On Fri, Dec 11, 2020 at 04:48:12PM +0000, Sidong Yang wrote:
> > > > > Example json format:
> > > > >
> > > > > {
> > > > >   "__header": {
> > > > >     "version": "1"
> > > > >   },
> > > > >   "device-stats": [
> > > > >     {
> > > > >       "device": "/dev/vdb",
> > > > >       "devid": "1",
> > > > >       "write_io_errs": "0",
> > > > >       "read_io_errs": "0",
> > > > >       "flush_io_errs": "0",
> > > > >       "corruption_errs": "0",
> > > > >       "generation_errs": "0"
> > > > >     }
> > > > >   ],
> > > >      ^
> > > >
> > > > I've verified that the comma is really there, it's not a valid json=
 so
> > > > there's a bug in the formatter. To verify that the output is valid =
you
> > > > can use eg. 'jq', simply pipe the output of the commadn there.
> > > >
> > > >   $ ./btrfs --format json dev stats /mnt | jq
> > > >   parse error: Expected another key-value pair at line 16, column 1
> > >
> > > I've pushed the updated plain text formatting to devel, so the only
> > > remaining bug is the above extra comma.
> >
> > Another format bug(one extra newline):
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =E2=9E=9C  btrfs-progs git:(314d96c8)  btrfs device stats /mnt
> > [/dev/mapper/test-1].write_io_errs    0
> > [/dev/mapper/test-1].read_io_errs     0
> > [/dev/mapper/test-1].flush_io_errs    0
> > [/dev/mapper/test-1].corruption_errs  0
> > [/dev/mapper/test-1].generation_errs  0
> >
> > =E2=9E=9C  btrfs-progs git:(314d96c8)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The new line is printed by the change:
> > '+       fmt_end(&fctx);'
> >
> > and fstests/btrfs/006 fails:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > btrfs/006 1s ... - output mismatch (see
> > /root/xfstests-dev/results//btrfs/006.out.bad)
> >     --- tests/btrfs/006.out     2020-12-16 03:40:19.632039261 +0000
> >     +++ /root/xfstests-dev/results//btrfs/006.out.bad   2020-12-16
> > 06:25:56.424424113 +0000
> >     @@ -15,12 +15,14 @@
> >
> >      =3D=3D Sync filesystem
> >      =3D=3D Show device stats by mountpoint
> >     + 1
> >      <NUMDEVS> [SCRATCH_DEV].corruption_errs <NUM>
> >      <NUMDEVS> [SCRATCH_DEV].flush_io_errs <NUM>
> >      <NUMDEVS> [SCRATCH_DEV].generation_errs <NUM>
> >     ...
> >     (Run 'diff -u /root/xfstests-dev/tests/btrfs/006.out
> > /root/xfstests-dev/results//btrfs/006.out.bad'  to see the entire
> > diff)
> > Ran: btrfs/006
> > Failures: btrfs/006
> > Failed 1 of 1 tests
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > The new line made filter produce the '+1'.
>
> Thanks for testing this patch.
> I checked the fmt_end() and there is an additional newline.
> I think that fmt_end() should be used for formatting. so it seems that

Yes, it's for the purpose of formatting.

> the only way to fix this problem is to remove the code that inserts a
> newline in fmt_end(). I searched the code that use the function and
> there is no code that used this function but this patch. Do you have any
> ideas?
>
I'm OK about removing the "putchar('\n');". It's just a tiny format issue s=
o no
bother to do extra works.

David?

> Thanks,
> Sidong
