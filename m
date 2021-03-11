Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3133694B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 01:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhCKAxz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 19:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhCKAx2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 19:53:28 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2A6C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 16:53:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w18so248713edc.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 16:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4/XB1NjVzkcassvGF9k8OOkOtHMefsYgpLIOhbHN44=;
        b=VytBblI4nb9JtqHcpg5PYs38jajnTR0u0JS6jpl3x32VbN+1FmkpQKztC6QGh/owq5
         OKZtrVWvRSAAgZSa52MpRCKaSLrn8M/wS7+lpN3thB2qy4x5ASseSLbpttO55PtkZRcg
         Usu+VKGsxFUTs0UMAmVvtsOBETR54kARgVDHg+jieLrIMe5HoGU7jO+WFaXqB1/Shadj
         acLiBoL+9rXMHYN4h5kBD34GepJ6XoGwLlBU74peSFTH4olLLWwe877BUouMrPF9vqxz
         iTkHZTfI/P5BPtXD8Ih2GVWaZnwQK2AMiro/XIrqqU/ujd/Qp2vrSZYPEp61VpSaQc8f
         2Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4/XB1NjVzkcassvGF9k8OOkOtHMefsYgpLIOhbHN44=;
        b=giLHrXudbuu3Mj6MZhhzPVm62FWzWKlte4EEzfXDEjO85U4LXLZaB2SE0WJsrnoLVs
         j46Fr7gg76N/Hv5VEyRdW6//XHeLwvk6xEVsvn/kMwwy9MplOkkYGI4NhxHYQiPxiZGp
         6lv1tPCTH4bBmMPYjpACZdZUmr1tZ+8wtBXtvRD/fAgaEvPJFg0cTpPOmOHBTJIXNDiz
         +vw4hwtVsKMUZYUPOViZdc4+yZK+fkIwblMls586zKaBLl9euXNdWV/mQKWPMa0TtSzS
         pbKZ9RsCBE6G5VNl5Ku6avmyzDukGd0gNwXp0HGXJIE0x1wwFhWwM13vaDlfhVk8XyHg
         h6Rw==
X-Gm-Message-State: AOAM533gg/3ifBTbRp7KSGuquPoKjodfcPGzwCJQPL6S2i7zFTXgYXdd
        Y8fREWrbRErIUDYzCTJWsxDDIrEOBgZclVH7xxcT8Q==
X-Google-Smtp-Source: ABdhPJypQ8GemOXeRAlB5nBwa/LaXTEzwLO62LM4I6+2OuCpeLVCa5nLj+566PgoZJjKJzgw0+xwotjje7pT9PlLG2A=
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr6011841edv.300.1615424006716;
 Wed, 10 Mar 2021 16:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org> <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org>
In-Reply-To: <20210310142643.GQ3479805@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 10 Mar 2021 16:53:15 -0800
Message-ID: <CAPcyv4i80GXjjoAD9G0AaRDWPbcTSLogJE9NokO4Eqpzt6UMkA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Neal Gompa <ngompa13@gmail.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 10, 2021 at 6:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Mar 10, 2021 at 08:21:59AM -0600, Goldwyn Rodrigues wrote:
> > On 13:02 10/03, Matthew Wilcox wrote:
> > > On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> > > > Forgive my ignorance, but is there a reason why this isn't wired up to
> > > > Btrfs at the same time? It seems weird to me that adding a feature
> > >
> > > btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX support.
> > >
> > > If you think about it, btrfs and DAX are diametrically opposite things.
> > > DAX is about giving raw access to the hardware.  btrfs is about offering
> > > extra value (RAID, checksums, ...), none of which can be done if the
> > > filesystem isn't in the read/write path.
> > >
> > > That's why there's no DAX support in btrfs.  If you want DAX, you have
> > > to give up all the features you like in btrfs.  So you may as well use
> > > a different filesystem.
> >
> > DAX on btrfs has been attempted[1]. Of course, we could not
>
> But why?  A completeness fetish?  I don't understand why you decided
> to do this work.

Isn't DAX useful for pagecache minimization on read even if it is
awkward for a copy-on-write fs?

Seems it would be a useful case to have COW'd VM images on BTRFS that
don't need superfluous page cache allocations.
