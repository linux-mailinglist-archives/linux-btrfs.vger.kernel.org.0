Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ABA28C598
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 02:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgJMARQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 20:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgJMARP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 20:17:15 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2675C0613D0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 17:17:15 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k6so19811934ior.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 17:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=v98cm+EFsY4TrygzqG+tLjR/x8UVL6nNH2eQLoiJCII=;
        b=bRQqGllXpQa+pXDEYsVwNRghp/xWJ/nco/OShPWBgnBJpm+HO2Hyb1nv9S0nMxmoU4
         J1r1vpY9BKTC9ROPb7GGo0+yPuyEPiDs9buDEEIaeKk23IU21A/z380TkZU2BwH9U37T
         D95Bx3aWwOIEjBoq8D/VOwhxcSLdUwzpH+VV0hN2KD3OWfNjp3Bj/o4e1XA4yOjlnf82
         MI7tAuUCeSX38EhQ6rttgm04l4fygUooW60WKo4lpgMWR9k2MXZsDjDJKAsqc7jZXJVb
         cglaEeV+sK79ZjlZ8JEZXcH4qvpHL7kK7JCIynyRLQ0fbqsFRBsfVaTFKIYxk0JSVssP
         OyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=v98cm+EFsY4TrygzqG+tLjR/x8UVL6nNH2eQLoiJCII=;
        b=heAl4gx8gULhlWlhuHm/dBKxHkWKIDAsaPITCqH5fCWjroplDWZ9Yt64+nQbfG402k
         KWJjQjb7i+o5uKEy48+dgOrWX1pEvDDX9xHtXIYrbuonQxa5pqZ9n6LG+BNvp8Z8hC6+
         S1pJwVAU2Cm/ZBlgNJTazvHQXIU5emtgMCBw/7ynGT5Ek9j0MBmyZpMxNv5sbmiq7jAQ
         bjHPD33ujeUtPB/xQRiKM2gCGxwLSG0O5CJCQE/u+fo4fHBzULBiJ1tet8m1oynCty28
         g79AdgT46b/mq/1QU67aeEWAPaCVElmX588OwPya9Y9DdfYUo7OxkswRQQHRTTZFpzVZ
         H6Xw==
X-Gm-Message-State: AOAM531/TYkOCaTloBfRakB7h2EDufXDKp5K6yrxyZof8A/Jzodp9Ajc
        Pi1yihjkchLLHmwJk3dAQPnyaZmV0wwlFRBpuhI=
X-Google-Smtp-Source: ABdhPJzqPrl7NWCAaLQxVzHNwOg4cA6248uJyPqVqI84KgDTgsHxZ8NVnctk14qCZj1JO69id4UvBOMWQR1BS6P7ieE=
X-Received: by 2002:a6b:3fd6:: with SMTP id m205mr17622908ioa.80.1602548233408;
 Mon, 12 Oct 2020 17:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je-VLz9zZOKEVa+x0V+dpyojtRcjBw7maO73zpmowdOyTQ@mail.gmail.com>
 <20201002171824.GY6756@twin.jikos.cz> <CAEg-Je_xvLhuB_UokkX-FYTf3aQcs3q4ewUjuFE4RS3Snc_oTQ@mail.gmail.com>
 <20201012224932.GB6756@twin.jikos.cz>
In-Reply-To: <20201012224932.GB6756@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 12 Oct 2020 20:16:36 -0400
Message-ID: <CAEg-Je_o5qbPBFL-2VsG3Ekm2NQO7jSgsdTpSzeHE0em8sB37w@mail.gmail.com>
Subject: Re: btrfs-progs and libbtrfsutil versioning
To:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 12, 2020 at 6:51 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Oct 02, 2020 at 04:56:24PM -0400, Neal Gompa wrote:
> > On Fri, Oct 2, 2020 at 1:19 PM David Sterba <dsterba@suse.cz> wrote:
> > > On Wed, Sep 23, 2020 at 09:48:44PM -0400, Neal Gompa wrote:
> > > > If not, is there a reason that we
> > > > *can't* synchronize the versions across btrfs-progs, libbtrfs, and
> > > > libbtrfsutil? We could still make sure that the library sonames are
> > > > versioned properly, but having the user-facing versions actually sy=
nc
> > > > up makes life a lot easier...
> > >
> > > I'm a bit lost in which versions are not in sync. The shared library
> > > version is an ABI and that changes only when new symbols appear. The
> > > whole project release versions follow the kernel scheme. So what are =
you
> > > suggesting? Eg. that libbtrfsutil should not be 5.9 but follow the
> > > soname version which is 1.2.0?
> >
> > No, I'm suggesting the other way around. The libbtrfsutil "public
> > version" (that is, not the ABI version) would be synchronized with the
> > kernel version like the rest of btrfs-progs. Right now it's not,
> > evidenced by python-btrfsutil giving me 1.2.0 instead of 5.9.
>
> Oh, so this sounds easier than I thought. If the "main" verions is
> derived from progs, then it's just the python-btrfsutil that needs to be
> fixed:
>
> libbtrfsutil/python/setup.py:
>
>  28 def get_version():
>  29     with open('../btrfsutil.h', 'r') as f:
>  30         btrfsutil_h =3D f.read()
>  31     major =3D re.search(r'^#define BTRFS_UTIL_VERSION_MAJOR ([0-9]+)$=
',
>  32                       btrfsutil_h, flags=3Dre.MULTILINE).group(1)
>  33     minor =3D re.search(r'^#define BTRFS_UTIL_VERSION_MINOR ([0-9]+)$=
',
>  34                       btrfsutil_h, flags=3Dre.MULTILINE).group(1)
>  35     patch =3D re.search(r'^#define BTRFS_UTIL_VERSION_PATCH ([0-9]+)$=
',
>  36                       btrfsutil_h, flags=3Dre.MULTILINE).group(1)
>  37     return major + '.' + minor + '.' + patch
>
> IOW, the python package version is derived from the library .so version.
>
> > Basically, I want to add pkgconfig files and fix the version emitted
> > by the Python metadata to use the project version rather than whatever
> > soname version is used. The soname version would still be preserved
> > and work as a way to track the ABI changes, but everything that reads
> > metadata would get the btrfs-progs parent version consistently.
>
> And with something using the VERSION file instead it should do what you
> expect, right?

Yeah, basically! This issue blocks me from enabling the Python
bindings because version updates get weird and confusing...


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
