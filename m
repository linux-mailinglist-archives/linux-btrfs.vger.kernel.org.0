Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 496196F158
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Jul 2019 05:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfGUDR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Jul 2019 23:17:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36520 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfGUDR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Jul 2019 23:17:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so16086913pgm.3
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Jul 2019 20:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zyXnkIi7F7xqnSyYKNN1v5vYpwnsic2ESphyFDreDLQ=;
        b=Pj/oL1HdVv8VT7peoERrdFpwng8sTUVidfqWObuOjJ5aFm8tp25pSaXwp+6SKshsxq
         WPnQW3w1N60RftOCTiMQhujmvE68O+IQBxlxWJC6VTHobrsBCJeYfXCt6QexT+kIM6wY
         k1VKxhw07mb5g2d22m5xvB1qLVNjPSskFlTLR4PQKrxvwf1Vv51lM2vWuJ+fK+M8+KSW
         Egkq+0ANoK2x2oKAUdOTjhrbZYmklyz8MUTwLDOuAimCKt6n6MMq2BIQAimYC21vwI+/
         9hvQGj2PQOJHC/DEKOyAa9dbRl8LGGURoRXkVOHImiYV1G9lvq38HsCGchuAoWkBoAM4
         JcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyXnkIi7F7xqnSyYKNN1v5vYpwnsic2ESphyFDreDLQ=;
        b=Ei46QxBszbK1Et8HLIkdcC2UEjNPFOr9Nc0y9KkXC7XUMQlnf9Wbkc/VcdDbU+7ge1
         fuIxeDKGrQtJT4PxAZp+tPuP9Rp7S8rFKjkd7PiCW6TfsD5eo25zVfRPzytMhJt8QvSw
         +hSXhiVooHNzSKqZ/mvl6jIZrSXzcB7aRxuwB7lNoix5pwZEdUmHQBspfLLdcGnlhNw2
         MmJhqKnfo72N9ZTwCQHb32l6ukvKZjJ6rk2V/THgbddB8W6T1U/+VQxKdqXKSiTxt1gz
         azg5BcN819ytXPBTep/F2MBht79HNZUTnPhQipvk5YuPdoAeZEfmLutWZRXl24t3ZrmE
         WPEw==
X-Gm-Message-State: APjAAAVYW04IFCBGNtzVTSxh02n5voXFa0/euGW1NmG3QLSUcZiutzND
        gMHspWgLqHr9tsTB92OEmMugwA==
X-Google-Smtp-Source: APXvYqxq772kc2IdK/GrgffxvmSYUScwPnGDioRpXIq2Rb5VrTHM7ZmUzEMeTKY2mZdnPdb0O4fAmw==
X-Received: by 2002:a63:1749:: with SMTP id 9mr11076226pgx.0.1563679045263;
        Sat, 20 Jul 2019 20:17:25 -0700 (PDT)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id z13sm27240105pfa.94.2019.07.20.20.17.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 20 Jul 2019 20:17:24 -0700 (PDT)
Date:   Sat, 20 Jul 2019 20:17:21 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Mike Fleetwood <mike.fleetwood@googlemail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs-progs: receive: get rid of unnecessary strdup()
Message-ID: <20190721031721.GA8955@vader>
References: <cover.1563600688.git.osandov@fb.com>
 <f0142166d2059ed0bf319778dd3146d1d0b4523d.1563600688.git.osandov@fb.com>
 <CAMU1PDhmxhtiUVYX7q-04FamEbOTFz2o7NQoQpWcMv-GsaJLLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMU1PDhmxhtiUVYX7q-04FamEbOTFz2o7NQoQpWcMv-GsaJLLw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 20, 2019 at 09:34:24AM +0100, Mike Fleetwood wrote:
> On Sat, 20 Jul 2019 at 06:43, Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > In process_clone(), we're not checking the return value of strdup().
> > But, there's no reason to strdup() in the first place: we just pass the
> > path into path_cat_out(). Get rid of the strdup().
> >
> > Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
> > Signed-off-by: Omar Sandoval <osandov@osandov.com>
> > ---
> >  cmds/receive.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/cmds/receive.c b/cmds/receive.c
> > index b97850a7..a3e62985 100644
> > --- a/cmds/receive.c
> > +++ b/cmds/receive.c
> > @@ -739,7 +739,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
> >         struct btrfs_ioctl_clone_range_args clone_args;
> >         struct subvol_info *si = NULL;
> >         char full_path[PATH_MAX];
> > -       char *subvol_path = NULL;
> > +       char *subvol_path;
> I think that should become const char *.

Yeah, that wouldn't hurt. Dave, can you add that when you apply this or
should I resend?
