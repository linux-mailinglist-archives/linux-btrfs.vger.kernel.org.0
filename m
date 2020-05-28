Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF41E65A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404244AbgE1PN5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404232AbgE1PNs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 11:13:48 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F3C08C5C6
        for <linux-btrfs@vger.kernel.org>; Thu, 28 May 2020 08:13:48 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id i89so9780381uad.5
        for <linux-btrfs@vger.kernel.org>; Thu, 28 May 2020 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=v+Qfb9ZlSOyjMb8cRJws92QKlhG+Lnr+BndiTX7T1jE=;
        b=cHtwuZ8VKHeTgea6J2aIcQfqggME75t4F4sHyICXaKJIkZeO3W3K5l3zn9HY/p1NjN
         peNBjM07TO/ZLd/Ze+g0Ko58C83i7hnOGBdqJLuH8Ax/pw/55OGZ4kc8YeN21hwju/kk
         8RU09xxmxvNUOGnNm3Cpd2LJZzN5LGXJpWMwqL6shQt+fQSw1KMf9GR6nuyBUcyybRkj
         gEtQ9bIUnoa2oBAbdhowN9vVKiv/QZX7dWjRbwpjP8SzSzH2WYmRhfcbG+47Rhi5wbXy
         J/bFffqk8FYwQggABRKt9egfo8HWkCo45PZa1+NmMjGJUT2xPpRpdWOmMlbIX7rZ72HI
         Ivyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=v+Qfb9ZlSOyjMb8cRJws92QKlhG+Lnr+BndiTX7T1jE=;
        b=ZDuSFVLwQiCC9j6vE51dJJJXHmv9lS1qo4hrEsyMepof+HmctqTT+9ftNwSQL9lq9e
         aayfYUYtS7yVaTcyFOsBv4LMS2MxGUEsUnNjr+dzTmRRXzEHW2D/8DbM/k6v+jeqPzMA
         tv6u19UkSwHO526t/sDi8M6DfSVDpt3i9O7kIRXvxoz8DAtRyxFOlqgK1dg9OH4GgFvq
         6rBaXc3/D/9FHs/9Ka4QkubXleIkJRBehOrkg2H4iCO/C47qpKtDv57nXl5R8IxEt599
         2fLjDhizERxITzx0qIe4oc1A2aVkKL0dEaxDibC5XZ0JGCxo0j52xs21ALCexDGT/WrX
         oVjQ==
X-Gm-Message-State: AOAM530a00Af4VRiCgklmdD/vPQ8k9II1EZetAzWp/qXt8NnizD6nJug
        QhdcYcb/fla1sqRgi+aQIDhJHXFYLKLDWLoJGr4=
X-Google-Smtp-Source: ABdhPJzF7eloourU2OxO2JsYz5sGmsHf8O2W1XsxXwTLLFoFxfBn1VJAqjAxIa0wnbdZEjWbD5xjoLkPKHzcdzKOAvU=
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr2886183uav.0.1590678827630;
 Thu, 28 May 2020 08:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200522123837.1196-1-rgoldwyn@suse.de> <20200522123837.1196-5-rgoldwyn@suse.de>
 <SN4PR0401MB35981C3BAEDA15CC85D13AE79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200526164428.sirhx6yjsghxpnqt@fiona>
In-Reply-To: <20200526164428.sirhx6yjsghxpnqt@fiona>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 28 May 2020 16:13:36 +0100
Message-ID: <CAL3q7H6eVOTggceRgZakmoh8jNRJm5BXwNqE0Mx3By5_GgH5YA@mail.gmail.com>
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

On Tue, May 26, 2020 at 5:47 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> On 15:03 26/05, Johannes Thumshirn wrote:
> > Just as a heads up, this one gives me lot's of Page cache invalidation
> > failure prints from dio_warn_stale_pagecache() on btrfs/004 with
> > current misc-next:
> >
> <snip>
>
> > [   23.696400] Page cache invalidation failure on direct I/O.  Possible=
 data corruption due to collision with buffered I/O!
> > [   23.698115] File: /mnt/scratch/bgnoise/p0/f0 PID: 6562 Comm: fsstres=
s
> >
> > I have no idea yet why but I'm investigating.
>
> This is caused because we are trying to release a page when the extent
> has locked the page and release page returns false.

By "we" you mean what exaclty, a direct IO read, a direct IO write?

And who locked the extent range before?

That seems alarming to me, specially if it's a direct IO write failing
to invalidate the page cache, since a subsequent buffered read could
get stale data (what's in the page cache), and not what the direct IO
write wrote.

Can you elaborate more on all those details?

Thanks.


> To minimize the
> effect, I had proposed a patch [1] in v6. However, this created
> more extent locking issues and so was dropped.
>
> [1] https://patchwork.kernel.org/patch/11275063/
>
> --
> Goldwyn



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
