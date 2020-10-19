Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BBF292DA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 20:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgJSShV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 14:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgJSShV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 14:37:21 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D314C0613CE
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Oct 2020 11:37:21 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id c129so407553yba.8
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Oct 2020 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OYHSsk3HPuh3FusLU2pNyNidB82I7lSdSa0kBbqS3EM=;
        b=CR3oKSGIyBV6J55ztZ2JvoETLxYTlGIzGa5/XVzxukSDsnCAV8kS0AhFwVVXpQZKvR
         W8ufaTkATwTGA7VU4mbXqJkYcS3sv8aLbTKkroTauh7dbCnp65KKBKeMn/CBs17D0Ayh
         Hhm265rphW6gpMMeg8vd1pXfYjOv4m3debjUwJNbNf2jwSExonBHdKRHdux/OHW4bh1a
         ZLJQDwsir9jkHnBCWYhmzsBeqsbG/JuBZimta1njUvC0evgzD391fen4xXkRb+6jDAnx
         jeY7LmiWbAnHUAwSJ7mSsM7WTFyJMDW6FrIw0hb1UK24sJGsujhIynvz3YgPWyu0Gkom
         tTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=OYHSsk3HPuh3FusLU2pNyNidB82I7lSdSa0kBbqS3EM=;
        b=J0ThI5Hw2Y8pPM1Q/VPhyeAGwgHVZN4tgDyKc4hxyWoYvaKQEWnPc5+lS0DK9PsW4W
         VQEDKnEfCWimcys0I0739dY3t0Bgy8OaOzyS8vN0sfA2c6mQsTOn+s58iGlQCeB+dCs5
         j4RaVFbSmsgpy6fTO6GBn5QI8nfg+cVzf900GQ00jtX+8HMWPx/ZOzVJHJRJpWoYAFeW
         B6hsX5y11njyxzu4fqBwNE7x4o5JKO+liMvnEmfqO579cufCwEBaWLCy76iEPO71891t
         jPJZhcRJQiLVEwWp/g0pAixstOSeuw22N7w2dYDk8Q562BawpzdQ3pcBjiwoiyCmHioP
         Yw4Q==
X-Gm-Message-State: AOAM530ImdnHfGn2O/eVVNQtI2z3la2VQvja6zh+u8sc/t7f4NJBTZ3q
        ELKIz2ST1J0Yit/q7Cvht0ajyZQTwY+kNouW2IRSRh8b+cU=
X-Google-Smtp-Source: ABdhPJwt/Kw1Vr905klxy2axy/GYBr5FCB1/0Rp0mxP0ARp19LwYcqv50BdKqJn5x5D2fexe4cGI8VCdVz2iujZjFfw=
X-Received: by 2002:a25:d794:: with SMTP id o142mr862200ybg.59.1603132640149;
 Mon, 19 Oct 2020 11:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je-VLz9zZOKEVa+x0V+dpyojtRcjBw7maO73zpmowdOyTQ@mail.gmail.com>
 <20201002171824.GY6756@twin.jikos.cz> <CAEg-Je_xvLhuB_UokkX-FYTf3aQcs3q4ewUjuFE4RS3Snc_oTQ@mail.gmail.com>
 <20201012224932.GB6756@twin.jikos.cz> <CAEg-Je_o5qbPBFL-2VsG3Ekm2NQO7jSgsdTpSzeHE0em8sB37w@mail.gmail.com>
 <20201019183242.GY6756@twin.jikos.cz>
In-Reply-To: <20201019183242.GY6756@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 19 Oct 2020 14:36:44 -0400
Message-ID: <CAEg-Je9325_k-Eob37ZqL5C0VhWcgXUJWFLDeeTNPTmShOwQKQ@mail.gmail.com>
Subject: Re: btrfs-progs and libbtrfsutil versioning
To:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 19, 2020 at 2:34 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Oct 12, 2020 at 08:16:36PM -0400, Neal Gompa wrote:
> > On Mon, Oct 12, 2020 at 6:51 PM David Sterba <dsterba@suse.cz> wrote:
> > > On Fri, Oct 02, 2020 at 04:56:24PM -0400, Neal Gompa wrote:
> > > > On Fri, Oct 2, 2020 at 1:19 PM David Sterba <dsterba@suse.cz> wrote=
:
> > > > > On Wed, Sep 23, 2020 at 09:48:44PM -0400, Neal Gompa wrote:
> > >  33     minor =3D re.search(r'^#define BTRFS_UTIL_VERSION_MINOR ([0-9=
]+)$',
> > >  34                       btrfsutil_h, flags=3Dre.MULTILINE).group(1)
> > >  35     patch =3D re.search(r'^#define BTRFS_UTIL_VERSION_PATCH ([0-9=
]+)$',
> > >  36                       btrfsutil_h, flags=3Dre.MULTILINE).group(1)
> > >  37     return major + '.' + minor + '.' + patch
> > >
> > > IOW, the python package version is derived from the library .so versi=
on.
> > >
> > > > Basically, I want to add pkgconfig files and fix the version emitte=
d
> > > > by the Python metadata to use the project version rather than whate=
ver
> > > > soname version is used. The soname version would still be preserved
> > > > and work as a way to track the ABI changes, but everything that rea=
ds
> > > > metadata would get the btrfs-progs parent version consistently.
> > >
> > > And with something using the VERSION file instead it should do what y=
ou
> > > expect, right?
> >
> > Yeah, basically! This issue blocks me from enabling the Python
> > bindings because version updates get weird and confusing...
>
> So the python will now follow the package version. One thing I'm not
> sure about is the pkg-config .pc file for libbtrfsutil: is the Version:
> supposed to be the library ABI or the main package as well? Right now
> it's the ABI.

Main package version too. That's the "user facing" version. Not the ABI ver=
sion.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
