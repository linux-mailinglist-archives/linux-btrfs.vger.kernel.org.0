Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEA4403E64
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352494AbhIHRdu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 13:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350194AbhIHRdt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 13:33:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 570FC60F5E
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631122361;
        bh=VpP8jtds6pMtov9pXmEzNqsAxUi6HobJTkO5H2AovPo=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=Bje4ifSDNTcpBLz6Mj2y778JWQ/91tmbop4cBeuvUbpvUUr4Q3taYNnvvrrRNzJHe
         Mu6mvK8HjL8Gwri18sLTsDT+cuxNe8jZn3X5l16nc04s/tQNCaUMDJplEXpbkiI4Yg
         8WgA2ce/LUvZGH9grRErcbl+bzorlxE+N2aAE/k8z+lWn7On28O73z0wsdIpXu/gxJ
         lUVXhocHpl6gpmpyBhtOf5sztS0ZpRaM3+9PCLgOMCkeojrwXB07XpR6cu9DsuW9NA
         D8HwZTokQ+FUxAPtoKknOmLsaBnU5ZBOj/D76ua9VrYSzQPnQx9tO0BPlH999H/Lcy
         0sdhWM4zIiTzg==
Received: by mail-qv1-f54.google.com with SMTP id s16so1770396qvt.13
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Sep 2021 10:32:41 -0700 (PDT)
X-Gm-Message-State: AOAM533yOaX9MIayVT/bxNy7JCpVy86Tuf/yGGCItmyAxImtZ46rnSEo
        oxS7H5yblfhNB02o35aJZAqJiXebXT4HWVy8VtQ=
X-Google-Smtp-Source: ABdhPJxwjntBOAcBZFSNDzajTooH4+vUKBovget1xwuaOqLTFFTkXfJXK1SMrYESoK6rPXuqCUCNjmdC0nef2BqtUwI=
X-Received: by 2002:a0c:a88a:: with SMTP id x10mr5213983qva.66.1631122360528;
 Wed, 08 Sep 2021 10:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631026981.git.fdmanana@suse.com> <dcf9de78faa6ec5cef443d031a987c87301805b1.1631026981.git.fdmanana@suse.com>
 <89c736d1-2e8c-b9ef-40a0-298b94fcebde@oracle.com> <CAL3q7H4B76EqcUY2Ynb1T4d16LqRvyS-41tf8Ze=gfg6ZqGdFg@mail.gmail.com>
 <20210908163039.GT3379@twin.jikos.cz>
In-Reply-To: <20210908163039.GT3379@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 8 Sep 2021 18:32:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7++M2P6vOC4fzXg5zovd_pQ3DWxHwNVs5Z3RcGGZ2ypg@mail.gmail.com>
Message-ID: <CAL3q7H7++M2P6vOC4fzXg5zovd_pQ3DWxHwNVs5Z3RcGGZ2ypg@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix mount failure due to past and transient
 device flush error
To:     David Sterba <dsterba@suse.cz>,
        Filipe Manana <fdmanana@kernel.org>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 8, 2021 at 5:30 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Sep 08, 2021 at 03:26:55PM +0100, Filipe Manana wrote:
> > On Wed, Sep 8, 2021 at 3:20 PM Anand Jain <anand.jain@oracle.com> wrote:
> > >
> > > On 07/09/2021 23:15, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > When we get an error flushing one device, during a super block commit, we
> > > > record the error in the device structure, in the field 'last_flush_error'.
> > > > This is used to later check if we should error out the super block commit,
> > > > depending on whether the number of flush errors is greater than or equals
> > > > to the maximum tolerated device failures for a raid profile.
> > >
> > >
> > > > However if we get a transient device flush error, unmount the filesystem
> > > > and later try to mount it, we can fail the mount because we treat that
> > > > past error as critical and consider the device is missing.
> > >
> > > > Even if it's
> > > > very likely that the error will happen again, as it's probably due to a
> > > > hardware related problem, there may be cases where the error might not
> > > > happen again.
> > >
> > >   But is there an impact due to flush error, like storage cache lost few
> > > block? If so, then the current design is correct. No?
> >
> > If there was a flush error, then we aborted the current transaction
> > and set the filesystem to error state.
> > We only write the super block if we are able to do the device flushes.
>
> Should the last_flush_error be reset in btrfs_close_one_device once the
> filesystem is unmounted? I wonder if we should allow leaking the status
> past the mount and care in the next one.

Yes, that's a simpler and more logical approach.
Will send a new version doing it that way. Thanks.
