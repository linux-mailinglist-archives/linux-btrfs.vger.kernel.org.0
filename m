Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8573C1B6E
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 00:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhGHW1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 18:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGHW1f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 18:27:35 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED402C061574
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jul 2021 15:24:52 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y38so11493066ybi.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jul 2021 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Cr0w6+uHJiiLDGehWme7OVhZCJ+jUL5MHdVy/spqKls=;
        b=ABUB4cyt5rcUJTGLzAAeq/nmLX5JRyLhNp3b8PqIBXTp1P3jtrgFr5bnmeFKiWRRTi
         Kphhfenx11k2NZPrYBESfT0OyvUQnboX/JZ5wynxApnYzKVOZPPLNzEK3jwF+AVpakYT
         cD+R2i669C3zvKuLyOW9eZG68e4slIhFz54NPzZu9rB0sdJehe4IpDN/NfDGqZILlL64
         g3Ec2oXIIZoPWhlj9E7paJ/RHMuiAQ6WDGcGgPGczTuGczY6JojIm+A7YsyvydzuTLo4
         KaLc5UaA8BnIIYO8j8POSJ8d06RCHAACzumEQFgWF6Qyfw9RgVvEd7NZNsjhR0MNZ265
         9nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Cr0w6+uHJiiLDGehWme7OVhZCJ+jUL5MHdVy/spqKls=;
        b=ssN09M5ENaqZT+yuGmuw7G/q1ahtI3uU5+W8k0sczLDMqDnbLVobDdIA7AHQY3ka5e
         o6KQ67FTS35iqQXSQnwquhqX9JHiwhJ+J8kcIIXDk3mYIBpOm1Ctn5d15ksimfMjLpAZ
         a1CP+BCHx81U/dMyrW0PoRH/Wousy+2YPW1WZEqMorFtF3KWS5M09VKTL/gC76a74kZD
         41G2TOJngNwzGt1p957bhwIyCqAH4A8joDiFT1EPn+3HxDWWRSiOkfl61k8GZR1DQOJH
         +Zp66Q3Vf6rvnUlWl9Doay/vbi5mLfnHVcGUlBGlmJHlifZeNLBnRMq0EyzCEW4XJFmZ
         VSKw==
X-Gm-Message-State: AOAM530cTUcD0b6gQ6HlAV3JipIj0Q+oPhQDPhrhb5Z9uOxzjp/YW0OB
        K9xjGGlTWCDlyTcA6fhTuEnclfaDr67eDqnPAAc=
X-Google-Smtp-Source: ABdhPJxMrjZ17fmVs8j6TIpFlI6kMLG+3MTheNmzcRiXlIqXJ44qNjPO5SCrovyaNlUpZBH3rOd0EwhOaDVsjxHwx7Y=
X-Received: by 2002:a25:b203:: with SMTP id i3mr42251811ybj.260.1625783091955;
 Thu, 08 Jul 2021 15:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625043706.git.dsterba@suse.com> <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
 <20210708124959.GZ2610@suse.cz>
In-Reply-To: <20210708124959.GZ2610@suse.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 8 Jul 2021 18:24:16 -0400
Message-ID: <CAEg-Je8FJwM6REQPqpyYGES_sCgv4fWY7X7pW5XABAVBvsPjxg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
To:     David Sterba <dsterba@suse.cz>, Neal Gompa <ngompa13@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 8, 2021 at 8:52 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Jul 08, 2021 at 08:45:12AM -0400, Neal Gompa wrote:
> > On Thu, Jul 8, 2021 at 7:48 AM David Sterba <dsterba@suse.com> wrote:
> > >
> > > The highmem was maybe was a good idea long time ago but with 64bit
> > > architectures everywhere I don't think we need to take it into accoun=
t.
> > > This does not mean this 32bit won't work, just that it won't try to u=
se
> > > temporary pages in highmem for compression and raid56. The key word i=
s
> > > temporary. Combining a very fast device (like hundreds of megabytes
> > > throughput) and 32bit machine with reasonable memory (for 32bit, like
> > > 8G), it could become a problem once low memory is scarce.
> > >
> > > David Sterba (6):
> > >   btrfs: drop from __GFP_HIGHMEM all allocations
> > >   btrfs: compression: drop kmap/kunmap from lzo
> > >   btrfs: compression: drop kmap/kunmap from zlib
> > >   btrfs: compression: drop kmap/kunmap from zstd
> > >   btrfs: compression: drop kmap/kunmap from generic helpers
> > >   btrfs: check-integrity: drop kmap/kunmap for block pages
> > >
> > >  fs/btrfs/check-integrity.c | 11 +++-------
> > >  fs/btrfs/compression.c     |  6 ++----
> > >  fs/btrfs/inode.c           |  3 +--
> > >  fs/btrfs/lzo.c             | 42 +++++++++++-------------------------=
--
> > >  fs/btrfs/raid56.c          | 10 ++++-----
> > >  fs/btrfs/zlib.c            | 42 +++++++++++++-----------------------=
--
> > >  fs/btrfs/zstd.c            | 33 +++++++++++-------------------
> > >  7 files changed, 49 insertions(+), 98 deletions(-)
> > >
> >
> > I'd be concerned about the impact of this on SBC devices. All Fedora
> > ARM images have zstd compression applied to them, and it would suck if
> > we had a performance regression here because of this.
>
> How much memory do the SBC devices have?

On average? Probably between 1 to 4 GB of RAM. Usually 2GB of RAM is common=
.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
