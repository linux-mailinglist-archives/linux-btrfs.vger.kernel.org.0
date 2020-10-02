Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AF6281D35
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 22:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJBU5B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 16:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBU5A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Oct 2020 16:57:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09DFC0613D0
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Oct 2020 13:57:00 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k6so3017555ior.2
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Oct 2020 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IBm+kFsTZX+ROpd5N6c8zWDdzb+//YuT+8eyH+RaDR8=;
        b=KpWhhkdM3aPypN735gJpFza8gUR1X/KhSTA9CMMRaUEYfhjNoTBiR0VZK80AvMAVnF
         6Qyv8Vgn/hUGcukhLpH+xgU7SUhuPBfTYNFiU2mYFrHCZJ72R30lEshm7xDoUmBJPtVu
         5CnhOUYvFKQUgabXqZv3f7ZyPDDOuQnEFUH6MPkxUF2acDSQCbD3qG5IFu5gOEXRBaRw
         Hemt8/BieGDlzuAzzswL5BH/f42Ocoj/vVDoG9XHKVZA3oCggH0XxV8h6GJrwJ2Djciw
         q/AhxKD6H27U58xa+0Lzq+0iOmNmCWqtefqAneXJ4goWH9+ua0Sb5mhY9teUOfzqs5GG
         RnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=IBm+kFsTZX+ROpd5N6c8zWDdzb+//YuT+8eyH+RaDR8=;
        b=lYi1cXuCsa5zTsoiWf/lZZFSFJ881/oMMNyILmdFjiENg6I9qu0N8XtZRxX4CumptZ
         GQ1CifOlBiHB4QXvRW1m5I9r+28m2uYJGDd/+RodN+lxIcXQgfCcAfx1YIP5pqnFrFwL
         WFKRh+BLsFz2ySONztQFXu/xDS1J5+70ExmIJSj6v0oVfCBLOtpSe9upeyKjDjf8WFyl
         DIwLM5mjBMcdA/PdEKiX1GJjbGL+qu9hqduoLY2JLYGLZ+SEpQlFPIFljnkjcok+acb8
         n4pqaK7y+8nwuIeE5YLqfxGuVkpNuovhfLDbhy1s2z5/z6zqCla2EqGsFNx1B+OzviHt
         dxyg==
X-Gm-Message-State: AOAM531ga46FXx8oh4Nfdllrd+k4LNzKnFeYcnmlOy6ZMWR4u+q2kuMf
        VCt3uWHT1+SkLb2HSbEYYRscuLsHZeJEFpRLhXfMJXzjGBs=
X-Google-Smtp-Source: ABdhPJyNmxx+rLN6zeI5/m1MDknEFwRZggwXr8hCVFHXuU+RDCcEC25IcQ88rIeNPzdKbLqJcmpvEzpvB5IXwxoiMbY=
X-Received: by 2002:a6b:9243:: with SMTP id u64mr1082580iod.197.1601672219988;
 Fri, 02 Oct 2020 13:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je-VLz9zZOKEVa+x0V+dpyojtRcjBw7maO73zpmowdOyTQ@mail.gmail.com>
 <20201002171824.GY6756@twin.jikos.cz>
In-Reply-To: <20201002171824.GY6756@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 2 Oct 2020 16:56:24 -0400
Message-ID: <CAEg-Je_xvLhuB_UokkX-FYTf3aQcs3q4ewUjuFE4RS3Snc_oTQ@mail.gmail.com>
Subject: Re: btrfs-progs and libbtrfsutil versioning
To:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 2, 2020 at 1:19 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Sep 23, 2020 at 09:48:44PM -0400, Neal Gompa wrote:
> > I've been working on a set of patches to synchronize the version
> > numbers across everything produced by btrfs-progs and add pkgconfig
> > files to make it easier for software to consume the libraries, but as
> > I worked through it, I started realizing that btrfs-progs actually has
> > *two* distinctly separate projects in one package.
>
> Yes, we ended up doing it like that as it makes development easier. The
> util library is there for 3rd party tools to use but otherwise is's
> internally used by btrfs-progs too. Synchronizing btrfs-progs
> development that would need new interfaces from the util library would
> require separate release and deployment.
>
> > This is somewhat problematic since it makes properly representing that
> > versioning in the packages I ship in Fedora rather difficult.
> >
> > Would it be possible to consider splitting libbtrfsutil into its own
> > project with its own releases?
>
> There's probably not a hard reason why to have them both in one project,
> but like it is now is saving my time spent on annoying tasks.
>

That's fine with me.

> > If not, is there a reason that we
> > *can't* synchronize the versions across btrfs-progs, libbtrfs, and
> > libbtrfsutil? We could still make sure that the library sonames are
> > versioned properly, but having the user-facing versions actually sync
> > up makes life a lot easier...
>
> I'm a bit lost in which versions are not in sync. The shared library
> version is an ABI and that changes only when new symbols appear. The
> whole project release versions follow the kernel scheme. So what are you
> suggesting? Eg. that libbtrfsutil should not be 5.9 but follow the
> soname version which is 1.2.0?
>

No, I'm suggesting the other way around. The libbtrfsutil "public
version" (that is, not the ABI version) would be synchronized with the
kernel version like the rest of btrfs-progs. Right now it's not,
evidenced by python-btrfsutil giving me 1.2.0 instead of 5.9.

Basically, I want to add pkgconfig files and fix the version emitted
by the Python metadata to use the project version rather than whatever
soname version is used. The soname version would still be preserved
and work as a way to track the ABI changes, but everything that reads
metadata would get the btrfs-progs parent version consistently.

> Can this be solved on the packaging side by 3 projects that are built
> from the same sources but produce only a subset of all the built files?
> This is slightly inefficient as you'd have 3 copies of btrfs-progs.tar
> but otherwise it's one time job, comparted to me having to update and
> deploy 2 projects just to progress with progs development?

It _could_, but I'd rather avoid that if I can, because it makes
keeping everything up to date painful.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
