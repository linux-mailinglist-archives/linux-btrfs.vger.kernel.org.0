Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3548C34FF42
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhCaLIH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Mar 2021 07:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235121AbhCaLHi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 07:07:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 731DF61957
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 11:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617188858;
        bh=O5XMPuNjwQuIzbNiNQHzLp8E4MnAseYLdgBp3ywE/Fc=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=b3oQqTQZNVipXT7Npk6ABDI6LG9JCEwXMDzFtSadLAFrTPL8cW4pxTHogtObB8T31
         pHXKZPqS9Map6m30QNX0PdBBYMjmNUxKqnhhZtJ2L80eT9C6BLNBWBd3Q3GUdP+whs
         M4uVGwgKJKtmMSUZK4UDW3/z0+pXhpkTmaUdInc56o2f+qBe4Zau+WwojAUeJsGnC9
         gxPe+/vTwKhD3zmnsVRQX/q0r/RyVe5/fLAlx0OlL80QIpJ6Nl7fdXn4sLDYh3RVtr
         xBDzBdPFnJqnpievZ+G543Y/oUPwCnL04hEiJ2tnFnAySmarhJYuCYfuSYrThP+Vbr
         g5x30FUecQ6kw==
Received: by mail-qv1-f49.google.com with SMTP id t16so9645038qvr.12
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 04:07:38 -0700 (PDT)
X-Gm-Message-State: AOAM530til90u9xHlr684c3jlYSq1mrfF6VhPHMQq4tOkr3H8JZwgAWV
        9qDqiLeMNqOwEuPIzb41ThYuv9UuyCYc64NxALs=
X-Google-Smtp-Source: ABdhPJxD6UPUxbbBq4Wjb8OEVqjGdIpsaSEnEPpCJWLkkwdISdjPNQTFc8GSXzLSv8rXkQT4x8GE0xaWOcLk0btV3UI=
X-Received: by 2002:a0c:a1c2:: with SMTP id e60mr2141395qva.41.1617188857558;
 Wed, 31 Mar 2021 04:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <dd702a279373c3b6babdf0d7a69c929e9924bb33.1616523672.git.fdmanana@suse.com>
 <20210329184651.GU7604@twin.jikos.cz>
In-Reply-To: <20210329184651.GU7604@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 31 Mar 2021 11:07:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4fxAsmY9a0QtWGRu1Si6oUgnazctSn=HzjmBvxr0R2zw@mail.gmail.com>
Message-ID: <CAL3q7H4fxAsmY9a0QtWGRu1Si6oUgnazctSn=HzjmBvxr0R2zw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: make reflinks respect O_SYNC O_DSYNC and S_SYNC flags
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 29, 2021 at 7:49 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Mar 23, 2021 at 06:39:49PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we reflink to or from a file opened with O_SYNC/O_DSYNC or to/from a
> > file that has the S_SYNC attribute set, we totally ignore that and do not
> > durably persist the reflink changes. Since a reflink can change the data
> > readable from a file (and mtime/ctime, or a file size), it makes sense to
> > durably persist (fsync) the source and destination files/ranges.
> >
> > This was previously discussed at:
> >
> > https://lore.kernel.org/linux-btrfs/20200903035225.GJ6090@magnolia/
> >
> > The recently introduced test case generic/628, from fstests, exercises
> > these scenarios and currently fails without this change.
> >
> > So make sure we fsync the source and destination files/ranges when either
> > of them was opened with O_SYNC/O_DSYNC or has the S_SYNC attribute set,
> > just like XFS already does.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Added to misc-next, thanks.

Can you squash the following diff into it?

https://pastebin.com/raw/ARSSDDxd

Or if you prefer I send a v2, it's fine as well. Let me know, thanks.
