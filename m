Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4183B35FC72
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347647AbhDNUSt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhDNUSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 16:18:48 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB6C061574;
        Wed, 14 Apr 2021 13:18:26 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v72so2836935ybe.11;
        Wed, 14 Apr 2021 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UG8735pzi/e9l1ZDZAEDgiio/ANWXateqqwK2vC/qMU=;
        b=WOfcpWAhNcfvW+6AgEJE2nL5D05401ZkMXNqaPIlIHvaQxs+JRSH0hJTrVb4v1lQvL
         Iu52ljiPnD+Th8uOLIL94h1kDXuXjXtQ4EzdG/UUWHsJAnDATVrYCORsG+t0BOIfFnQJ
         4a0Isri564YbTGRgfutepJm3XOGJlX7XW+6and4twEu8JZFQwLaqn/W5hEYxsWMbIRsB
         fkO4QhgTtcTSS5uU87LXAgPPm/nSQ3j/CRqr5/8tw7RZpa0VKTxtH4ztAhKyDZKM01vB
         xWt6J+nkHPSBL57ABZmwXd1YkUnspCfFOuGgV/ZpxN4uyNdjxbP1SlEQli9eLwefh8kp
         XPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UG8735pzi/e9l1ZDZAEDgiio/ANWXateqqwK2vC/qMU=;
        b=hQ25CGWm/S9kFMLidVDXlRSiHOGX0Xmxy8xFGurCml74k32fVjOuRIbwUY6ilBuCG1
         cJ5w37tosyiVmIS2xi5H13KVIS56WhPX5dtNTmIxcga/16X4hSwcTeXW5vuwIHC1IxPI
         3gEExZFtdSskA35vJ4JP8oKd5D92c/fZyDgpndcm3qNVbh75luIsygfwWcRHxUN64cbh
         hkuBiNqE1JGJRVgXhpiE+VzcySnxUKcbr51u9VSTU2i9UrHKixDQM+770cTemLklh+GV
         YubmkwnqtdVrSOnV/M+4IEBg62qvT80fyXuuIWVmHiKjuo4hdZbZvnZLlrB00dKykw4G
         pCWg==
X-Gm-Message-State: AOAM531l5LrHcSsZGTTAH66ojAq6q7LCamSqRfB+qTk2QNxA2J23+Mlq
        GWAloDc9dX5BKsH6nI34Ln9TVATyqZU6F4dChCo=
X-Google-Smtp-Source: ABdhPJyose+gbonWMUZzbaW7vn6s/J4rN/R6C9yCnWMC3DCn3oypaR8mD/4T/wS/REILgWBcuJRKd++ZXEmbFRpRhcI=
X-Received: by 2002:a25:3056:: with SMTP id w83mr56777350ybw.381.1618431504003;
 Wed, 14 Apr 2021 13:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210330225112.496213-1-nickrterrell@gmail.com>
 <CANr2DbfL2B5Tx+k1AwVh-5dQZ+fNpucJKu9QVQat7QVvK-5AbQ@mail.gmail.com>
 <CANr2DbfZ+fV+GN7CfDi1AFmfsdnX+kGnTA6kayEchtGwfoAE-A@mail.gmail.com>
 <YHc16rz4Y/PkzNH1@gmail.com> <CANr2Dbc+2rS7seuXGtU6Y+x0Qv+hrtwz71r+akKeQUXECZaJZA@mail.gmail.com>
 <YHc8xtmzKaazC6kP@gmail.com>
In-Reply-To: <YHc8xtmzKaazC6kP@gmail.com>
From:   Nick Terrell <nickrterrell@gmail.com>
Date:   Wed, 14 Apr 2021 13:18:13 -0700
Message-ID: <CANr2Dbfo09KCK7iAEEbOyPXHBtzB39s+QjUxKW_DbCHYJj+0sg@mail.gmail.com>
Subject: Re: [GIT PULL][PATCH v9 0/3] Update to zstd-1.4.10
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        squashfs-devel@lists.sourceforge.net,
        Johannes Weiner <jweiner@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Yann Collet <cyan@fb.com>, David Sterba <dsterba@suse.cz>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, Petr Malat <oss@malat.biz>,
        Chris Mason <clm@fb.com>, Nick Terrell <terrelln@fb.com>,
        linux-crypto@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Kernel Team <Kernel-team@fb.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Niket Agarwal <niketa@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 14, 2021 at 12:04 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Apr 14, 2021 at 11:53:51AM -0700, Nick Terrell wrote:
> > On Wed, Apr 14, 2021 at 11:35 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Wed, Apr 14, 2021 at 11:01:29AM -0700, Nick Terrell wrote:
> > > > Hi all,
> > > >
> > > > I would really like to make some progress on this and get it merged.
> > > > This patchset offsers:
> > > > * 15-30% better decompression speed
> > > > * 3 years of zstd bug fixes and code improvements
> > > > * Allows us to import zstd directly from upstream so we don't fall 3
> > > > years out of date again
> > > >
> > > > Thanks,
> > > > Nick
> > > >
> > >
> > > I think it would help get it merged if someone actually volunteered to maintain
> > > it.  As-is there is no entry in MAINTAINERS for this code.
> >
> > I was discussing with Chris Mason about volunteering to maintain the
> > code myself.
> > We wanted to wait until this series got merged before going that
> > route, because there
> > was already a lot of comments about it, and I didn't want to appear to
> > be trying to bypass
> > any review or criticisms. But, please let me know what you think.
> >
>
> I expect that most people would like to see a commitment to maintain this code
> before merging.  The usual way to do that is to add a MAINTAINERS entry.
>
> Otherwise it is 27000 lines of code dumped on other people to maintain.

I will add a 4th patch in the series to update the MAINTAINERS.

> - Eric
