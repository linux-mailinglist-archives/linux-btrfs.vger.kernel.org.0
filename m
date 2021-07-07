Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF753BED49
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhGGRpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 13:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGGRpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 13:45:04 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC4C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jul 2021 10:42:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r132so4415598yba.5
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jul 2021 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m3mOf2vMR54Bvv3Nae24Gox96cAiPldya9cpPN1Y6aU=;
        b=Qe1w/95+Tl5c68P7CXUVRbi331TejdwX+YgNpCS+aJDACcPQVXfs4xWiV06xgPv0sB
         Nfi5wwXe67PiX1m9BdI5xGCBtrGygi77seizCaqt237Xj8tjjAFzzcQ6EtiRX6D1GQj9
         8MiEAZgosxySrjUKjZ4Wh4CG4h43bvpm/u0LvNIoCFfpd4AAqDgd19PzJp1f4pfRQsTU
         7usmw30GvfKDFbs+5x+FA6o/qxpAeAq7DrWo723M4L1hWmctSPLIuqcTpNMqPutyau00
         ZUUG3u5ODXhsrOuC4+yEuR2UCHMwXyOQ5zH2GbVwSmp+m6bykXSQLCRCiLi674N8dHea
         /W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m3mOf2vMR54Bvv3Nae24Gox96cAiPldya9cpPN1Y6aU=;
        b=DrnP3urP0eDTvLlrmh1zC71p3k55dy+8LHP82Wg3x8WAxHSjQofolrLRU2+a7WPrXl
         fH+qj8umpHoERAjw5KKdOCK21oSrRDM2AcA0RNNWv1j2qRKtjjsyMk/cUGkAq2wlptl4
         /pW7+4Lxnr/zqifWiyDkkTe4vutN/5P4WHtVKeN1hZ8JdG4WXG6rL6Om4b/k+MP/2dZG
         HlZjH1k9ts5KSHM9hWWD3H9En34ZVjwo7jn5s9mtVZQPGzWfcY4KVG2MYvbmBs3aNZ7+
         EXITnWUSwcpOqSZnN31VNmc0cRzyVCS70rSCAvrlMZiyo6lj0YCkwsXkyvr2nPhENjyl
         BWQw==
X-Gm-Message-State: AOAM532AcuMaQMwbkqstPrBKJpjtW0s8YwB6ZWdEK6JC4fIVCh+rmY6u
        /IEcfy9U4p31JOzoiY2uf4RUjzyzejrIq0WkOfc=
X-Google-Smtp-Source: ABdhPJwqE8B5OLmyGMYckkKorgcOVtScmhUE+tH2K3HUWQHmgQjocUuKSfq0vzF2rzz+RLmeSqxUZB9LuDlNjAmuxAM=
X-Received: by 2002:a5b:94d:: with SMTP id x13mr4026597ybq.47.1625679741955;
 Wed, 07 Jul 2021 10:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210705020110.89358-1-wqu@suse.com> <5ad76de9-d1df-cafa-f5c3-44e316e0fb23@suse.com>
In-Reply-To: <5ad76de9-d1df-cafa-f5c3-44e316e0fb23@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 7 Jul 2021 13:41:46 -0400
Message-ID: <CAEg-Je8A=d6JOMfAPFcfppuhXvatLqpLb6UK5dOzdLZnfBfq7Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] btrfs: add data write support for subpage
To:     Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 7, 2021 at 4:30 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2021/7/5 =E4=B8=8A=E5=8D=8810:00, Qu Wenruo wrote:
> > This much smaller patchset can be fetched from github:
> > https://github.com/adam900710/linux/tree/subpage
> >
> > And thanks him again for fixing up the small typos and style problem in
> > my old patches. Almost no patch is no untouched, really appreciate the
> > effort.
> >
> > These patchset is targeted at v5.15 merge window.
> > There are 11 patches pending for a while, and not touched, thus they
> > should be pretty stable and safe.
> >
> > While there are 4 new patches, two of them are straightforward small
> > fixes, the remaining 2 are a little scary as they reworked the core cod=
e
> > of compression.
> >
> > But the rework should improve the readabilty thus make reviewing a
> > little easier (as least I hope so).
> >
> > =3D=3D=3D Current stage =3D=3D=3D
> > The tests on x86 pass without new failure, and generic test group on
> > arm64 with 64K page size passes except known failure and defrag group.
> >
> > For btrfs test group, all pass except compression/raid56/defrag.
> >
> > For anyone who is interested in testing, please use btrfs-progs v5.12 t=
o
> > avoid false alert at mkfs time.
> >
> > =3D=3D=3D Limitation =3D=3D=3D
> > There are several limitations introduced just for subpage:
> > - No compressed write support
> >    Read is no problem, but compression write path has more things left =
to
> >    be modified.
>
> Well, without proper testing just for compression read, it turns out
> compression read path has more bugs than I thought.
>
> The latest bug exposed during subpage compression write support is, the
> add_rd_bio_pages().
>
> Obviously it has tons of hard coded PAGE_SIZE, and can easily cause
> ASSERT() for readers accounting.
> As it added locked page without proper subpage::readers account updated.
>
> For this case, I'm already crafting a proper fix for that.
>
> But on the other hand, I'm not sure what's the proper way to introduce a
> fix for v5.15 window.
>
> Should I just disable readahead for compression read (which just needs
> two lines to return 0 for subpage case in add_ra_bio_pages())?
>
> Or should I add the proper fix into the patchset?
>

If this is going into 5.15 instead of 5.14, just add the proper fix
into this patch set. But if we want to land this in 5.14, I would
suggest disabling it for now and then having a separate patch set for
that.

You're already targeting 5.15 (though I kind of want this in 5.14...),
so I suggest going with adding the fix to the patch set.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
