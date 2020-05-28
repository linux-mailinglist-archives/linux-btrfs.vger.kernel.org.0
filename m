Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8CF1E67A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 18:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405152AbgE1Qph (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405140AbgE1Qpg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 12:45:36 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88488C08C5C6
        for <linux-btrfs@vger.kernel.org>; Thu, 28 May 2020 09:45:36 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id v26so16161933vsa.1
        for <linux-btrfs@vger.kernel.org>; Thu, 28 May 2020 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yJZ35SvOdEXwwGSQ5vjequMy8B2KjA/sq8dnpv63fQI=;
        b=DXNbXDS3VXI1C0XnBpc6g3yAhdCT+7u8Sc33rznwmUyqdRatdhhwwDTvOMm6Ptay3N
         Ud9bv2A8o0NMhaJlWfaWoHy5h/S5LGxNOMisOC50pCqbmVnd2Rngs30CQPbYYMHe6lUX
         PPth5XFel/AIw+6HW6/1rdiO96Cg0He6DQKF7GtIZJiwaix8Qy6MT8IvYF0x2GN+AlEU
         ZP8Wme3tzKgKAc2RJhhtQgfw25BM1Cp3YSNmi+bpws/aX2mkNt2kzVKzhFpnmio5B0eZ
         tHC41IqkLzMYQfiHtz7qLuiG0W6PVR6U+ew1wy8dD1MfWXnh9cEo26aR798QNavllO07
         aYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yJZ35SvOdEXwwGSQ5vjequMy8B2KjA/sq8dnpv63fQI=;
        b=Ohln/coupepLPVLGXHUmD4Lqon/cRCvZ1sR5FlCQeF4K/aj5jUB7VE9b8QlchQu7Oe
         oo+jlNGNBT/WoHJ0AS5njm6dOuTR5NLq4JysZiPCB3eI4EtM2yffLtLDyR1f7I19lTO6
         PZhMsLaRZmBUnea9KOtsmedEwMwtIRv7VhBqcyWosbg6PpI+MO+cCxW0M1wR51W1F4IV
         MJbOYLub29glqBHrXYpj14OQFGm/0lHzK+O2zgR9Lxef9pf8nZsjOUclNtNDsEZdvJXh
         be2mWBCmOAn9pFcqt42Pmf0ZqktTDk0YgA4Z5AFiPq6KA3l8ciBCh5958RHdKUGD16e8
         hkzw==
X-Gm-Message-State: AOAM533WBwfEUSz01E4PrSLph6q3pJMVXCa7LhWjcGVrUmrEgZNH4wjP
        wXnC86y746sg5NPpHffoSSYNT1O8TiNFpBqT8jM3OA==
X-Google-Smtp-Source: ABdhPJxd5e3LoCriI4jRbuDikrBBDH/p0cIc/v3WpfDuayDzvAoVlocXW5gFHNDwfG8V3p9G/vI+w5reqYxcH/NHekM=
X-Received: by 2002:a67:407:: with SMTP id 7mr2669805vse.95.1590684335761;
 Thu, 28 May 2020 09:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200522123837.1196-1-rgoldwyn@suse.de> <20200522123837.1196-5-rgoldwyn@suse.de>
 <SN4PR0401MB35981C3BAEDA15CC85D13AE79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200526164428.sirhx6yjsghxpnqt@fiona> <CAL3q7H6eVOTggceRgZakmoh8jNRJm5BXwNqE0Mx3By5_GgH5YA@mail.gmail.com>
 <20200528163450.uykayisbrn6hfm2z@fiona>
In-Reply-To: <20200528163450.uykayisbrn6hfm2z@fiona>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 28 May 2020 17:45:24 +0100
Message-ID: <CAL3q7H700X4E5-NjTWcWwosBwLuKeFPOPx00f+OVn=2fBfmJbQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] btrfs: Switch to iomap_dio_rw() for dio
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 28, 2020 at 5:34 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> On 16:13 28/05, Filipe Manana wrote:
> > On Tue, May 26, 2020 at 5:47 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wr=
ote:
> > >
> > > On 15:03 26/05, Johannes Thumshirn wrote:
> > > > Just as a heads up, this one gives me lot's of Page cache invalidat=
ion
> > > > failure prints from dio_warn_stale_pagecache() on btrfs/004 with
> > > > current misc-next:
> > > >
> > > <snip>
> > >
> > > > [   23.696400] Page cache invalidation failure on direct I/O.  Poss=
ible data corruption due to collision with buffered I/O!
> > > > [   23.698115] File: /mnt/scratch/bgnoise/p0/f0 PID: 6562 Comm: fss=
tress
> > > >
> > > > I have no idea yet why but I'm investigating.
> > >
> > > This is caused because we are trying to release a page when the exten=
t
> > > has locked the page and release page returns false.
> >
> > By "we" you mean what exaclty, a direct IO read, a direct IO write?
> >
> > And who locked the extent range before?
>
> This is usually locked by a previous buffered write or read.

A previous buffered write/read that has already finished or is still
in progress?

Because if it has finished we're not supposed to have the file range
locked anymore.

>
> >
> > That seems alarming to me, specially if it's a direct IO write failing
> > to invalidate the page cache, since a subsequent buffered read could
> > get stale data (what's in the page cache), and not what the direct IO
> > write wrote.
> >
> > Can you elaborate more on all those details?
>
> The origin of the message is when iomap_dio_rw() tries to invalidate the
> inode pages, but fails and calls dio_warn_stale_pagecache().
>
> In the vanilla code, generic_file_direct_write() aborts direct writes
> and returns 0 so that it may fallback to buffered I/O. Perhaps this
> should be changed in iomap_dio_rw() as well. I will write a patch to
> accomodate that.

On vanilla we have no problems of mixing buffered and direct
operations as long as they are done sequentially at least.
And even if done concurrently we take several measures to ensure that
are no surprises (locking ranges, waiting for any ordered extents in
progress, etc).

Thanks.

>
> --
> Goldwyn



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
