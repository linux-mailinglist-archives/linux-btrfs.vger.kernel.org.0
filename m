Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B432390521
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 17:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEYPWT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 11:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhEYPWS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 11:22:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53BAD6141C
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621956048;
        bh=XodFRa/dYm/86KxIgTffmzMJXKdeO3CwvbyVwELCXl8=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=pjxW+O/KbXe/ry3D7ZmW1VJIraksNfa9DgEQQQMYb+BSW7qruSLeyw3K9naxR5vdg
         tTzpsXzNhlud78lUsD5yobnHZvQeAhUV0utqBPx8C3H6zm5yoHXLKYNmgzDn43DcqX
         xil+VvSAvVy64xha/TbD4sHn4IR/CzVNFpNGdzvLiOkVChiirAE2nb/mpf1ouXGrVe
         aOTvdYp4BjH327SAlHuOZ2IvTkjrMqwqJYtTaGEgulPf8RSgjWjx/ymQlFWnzqjtEx
         J1HXVjVjW8kUx6s3M8SSKZajUxFHnNe5tIyOKaa7c9VQQ8c0H2HrkeRHNOs9siOn8A
         PJLAGDGIE6New==
Received: by mail-qk1-f182.google.com with SMTP id i5so23517210qkf.12
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 08:20:48 -0700 (PDT)
X-Gm-Message-State: AOAM533+UDckslSr4k7VY2oMUR9pMiw4bhgCwjLhuCEqWOe4XBdeDcWS
        U413Rdq1wcS5AWZvNRRQp4RIFJlCNkLbdLjLa2Y=
X-Google-Smtp-Source: ABdhPJw1ewNjLBdWv/SHVi3kYFLyx+Y9+OLHz2cetoqLFVXa7kyswcI8wr297V7fBcS1lRJIN1qj+gtRvml6Nsx90NY=
X-Received: by 2002:ae9:dfc4:: with SMTP id t187mr33901388qkf.0.1621956047510;
 Tue, 25 May 2021 08:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621851896.git.fdmanana@suse.com> <20210525150220.GX7604@twin.jikos.cz>
In-Reply-To: <20210525150220.GX7604@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 25 May 2021 16:20:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4mro4sBffLB7AnPM2QVVHcpcpJsJdwk74iL_gLe093EA@mail.gmail.com>
Message-ID: <CAL3q7H4mro4sBffLB7AnPM2QVVHcpcpJsJdwk74iL_gLe093EA@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs: fix fsync failure with SQL Server workload
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 25, 2021 at 4:05 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, May 24, 2021 at 11:35:52AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > This patchset fixes a fsync failure (-EIO) and transaction abort during
> > a workload for Microsoft's SQL Server running in a Docker container as
> > reported at:
> >
> > https://lore.kernel.org/linux-btrfs/93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de/
> >
> > It also adds an optimization for the workload, by removing lots of fsyncs
> > that trigger the slow code path and replacing them with ones that use the
> > fast path, reducing the workload's runtime by about -12% on my test box.
> >
> > Filipe Manana (3):
> >   btrfs: fix fsync failure and transaction abort after writes to
> >     prealloc extents
> >   btrfs: fix misleading and incomplete comment of btrfs_truncate()
> >   btrfs: don't set the full sync flag when truncation does not touch
> >     extents
>
> Added to misc-next, thanks. I've marked the first patch for 5.4+. It
> applies cleanly up to 4.4 but I'm not sure if this is safe given the
> amount of other fixes that are mentioned in the patch and other fsync
> related fixes that have been applied.

Should work on any 4.4+ kernel.
It's independent of the other mentioned fixes, as those were mostly
related to shared extents, except for one which was for the checksums
tree and unrelated to fsyncs.
I didn't add a Fixes tag because it's a really old thing, either
introduced when the fast fsync path was first added or when fallocate
was added, or somewhere in between.
The fsync failure and transaction abort only happen since the tree
checker was changed to detect overlapping checksum items (5.10, commit
ad1d8c439978ede77cbf73cbdd11bafe810421a5),
before that any issue would only happen at log replay time. 5.4+
sounds very reasonable to me. Thanks.
