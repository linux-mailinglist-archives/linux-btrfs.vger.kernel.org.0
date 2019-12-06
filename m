Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E611595D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 23:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFWgR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 17:36:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38964 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfLFWgR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 17:36:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so9425092wrt.6
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 14:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGY9lqYk9R5Oe0mCA3Tolly1DVy1o+fu9gZIfNz0y50=;
        b=CxY1CiqaZTWgbpq25l4Mip0Pv9yy8DZyQaSt6nNnZVgkXmDjUQWqP/21Or0KFg1Kr4
         uf2toqJqEU8SuQQvMI+nsipSFUJXU+BKuGIjN6fKaGzu4U3vQihY2rFf1Dsys/BB/2Aq
         gwp5v36hqk9oRhS5/jvD+x9A3Z30kOSKazz2S4baoAo5UvXw56IE1mHds64ShVrYNd3F
         WSjS5jp87MDTBKarJ3VJXJ+4/rfYjforjL8M3qaGKZv43IUER1Ao58Z9apNrWhoGx04s
         Td945AcFc2PSwV8CGymLkDjvBL8tcGNb9W9+0dWYSxX9/FFfV+Utbf6mbnEymb+QBIJr
         2/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGY9lqYk9R5Oe0mCA3Tolly1DVy1o+fu9gZIfNz0y50=;
        b=CH2sMAGHMtktJyifl6OVLz7oCffyAc2rFXnxcgliXNlQtWmUe/IhgdLZIa+65yuv71
         C4ik957A8XHtTsVFCu7IHrOTmVJL2zkffIS3pPHJyoyIeGCYrdBXJpr//603VD618z1v
         tA5PGXMSMnO0glwNE4Q2nwg2Dot0xG9inwu/q5ZR3vJrXA6yjTaUc+Rgw5CfZKJ8ikLi
         IHJtg106h3DtTlLOxVcOWxE9KKzCit1sXaHhg/5vaBrjQT8Z9VPy64d13klO3ZTuTYzK
         ZarSzq8BIK+p1xyoLvPQNAFqp4EFE4deK4uCKN2HycXUSvqxUyWQSow+LdCLpA0oZghL
         SZrw==
X-Gm-Message-State: APjAAAWJFpUt+8W8N7unc1VFkohJ1dxU6i6XWCV+IrAgR08UNp1/ug1d
        8Lev2tPXxbtCS+7Ufw1B7MdQGYdWibPlSBADrfPcSw==
X-Google-Smtp-Source: APXvYqwHUZvUbGz3/nOeK5DgrQtN1w4puKuvogKdIUhe6Hf8pSjqQK0PSvGSVqm90aNZIqmkE9K+3ALcawYCc6M/XVs=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr18317708wrn.101.1575671775298;
 Fri, 06 Dec 2019 14:36:15 -0800 (PST)
MIME-Version: 1.0
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 6 Dec 2019 15:35:59 -0700
Message-ID: <CAJCQCtTMCQBU98hYdzizMsxajB+6cmxYs5CKmNVDh4D9YZgfEg@mail.gmail.com>
Subject: Re: df shows no available space in 5.4.1
To:     Martin Raiber <martin@urbackup.org>,
        Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 6, 2019 at 2:26 PM Martin Raiber <martin@urbackup.org> wrote:
>
> Hi,
>
> with kernel 5.4.1 I have the problem that df shows 100% space used. I
> can still write to the btrfs volume, but my software looks at the
> available space and starts deleting stuff if statfs() says there is a
> low amount of available space.

This is the second bug like this reported in as many days against 5.4.1.

Does this happen with an older kernel? Any 5.3 kernel or 5.2.15+ or
any 5.1 kernel? Or heck, even 5.4? :P



>
> # df -h
> Filesystem                                            Size  Used Avail
> Use% Mounted on
> ...
> /dev/loop0                                            7.4T  623G     0
> 100% /media/backup
> ...
>
> statfs("/media/backup", {f_type=BTRFS_SUPER_MAGIC, f_bsize=4096,
> f_blocks=1985810876, f_bfree=1822074245, f_bavail=0, f_files=0,
> f_ffree=0, f_fsid={val=[3667078581, 2813298474]}, f_namelen=255,
> f_frsize=4096, f_flags=ST_VALID|ST_NOATIME}) = 0


f_bavail=0 seems wrong to me.

What distro and what version of coreutils?

It's the same questions for Tomasz in yesterday's thread with similar subject.

--
Chris Murphy
