Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973B5144915
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAVArj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 19:47:39 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40039 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgAVAri (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 19:47:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id c77so4514281oib.7
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 16:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgc0iX5jWDK/scHdhoA8juXPQoQsUvfVwrRbravpzos=;
        b=lMiwjQRp/U79c5YbiXWzA+yz9MA/57nZ6SfTX7AXP0jP4JKhu4Gmm1jPcgi6IQHH0J
         xONW4QJCFrqmP6bzDRwog2IQXvYn2/NqxWVP9nEjb5NaqnFzEQ2wVJBtruUh1xLP1oDL
         +kL99B4XRgZYviSaQMzRwQ0I3hLZ2vqpH835kEbCTj7d2vlZKuJ5HtK7I8MTdPrks+WT
         arRknCy0wHpQ2U0urVAE+uB/TPj2meaaax/55rTlx1e7rWgF+q0vmW+FihOQc0jmZ7+N
         3IKG8qHRQwxm82ts/XGbq85SP7wcnOGflBZr6rHTEbPYUw8CEsirDBSGhFwMCoZd6C4y
         PDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgc0iX5jWDK/scHdhoA8juXPQoQsUvfVwrRbravpzos=;
        b=dh1dzMaMZOlOFCz7aTDn5UKs5O4+F7zPZewDvt2oWguJLlKQ/raLqI2hjkHjTmjFtm
         D9eKBbk9OH6gfdjvfktXSFGvFnsxHmU1FaOCY5c+/BygmWYBLYwdA22CvOWT1mzr2EDO
         I4QIiqEkmtRqa9kXIATHnB9+N1Gh+R3KZT2pMpmR2WqJsceve+conOmiKA23MW1gfeJD
         9A/YB301IjxWu692Y25ZZICfswLWiVGLu8F/QFjBGAaCCH4b0L2h1VrDJoPYv4ryHARp
         Ksfq4HuWRM8YEaBQe68GKZWWWGUAxcIU2eToPeIVAGmDI5CGdGa2K5MiqIF4p5h7SVeE
         2C0w==
X-Gm-Message-State: APjAAAUDJg6HGyRe+C0HgX/CVaZoFcBZgF3YKUoljYxcMq3Q2/tiQ54b
        +x7rKiYsJKAXMcsMsqfvkKf9pJLXihlTWcqh4tVSSg==
X-Google-Smtp-Source: APXvYqwPmge4gr4m0egcJLU8saT19SQnmehCQslKhVWRpVaoiJpETtrJCyR6KZeUzd6Mpf0AhBpQIKo1KZvVbaSv5gg=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr5321168oie.105.1579654058213;
 Tue, 21 Jan 2020 16:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20160210191715.GB6339@birch.djwong.org> <20160210191848.GC6346@birch.djwong.org>
 <CAH2r5mtM2nCicTKGFAjYtOG92TKKQdTbZxaD-_-RsWYL=Tn2Nw@mail.gmail.com>
 <0089aff3-c4d3-214e-30d7-012abf70623a@gmx.com> <CAOQ4uxjd-YWe5uHqfSW9iSdw-hQyFCwo84cK8ebJVJSY_vda3Q@mail.gmail.com>
 <20200121161840.GA8236@magnolia> <20200121220112.GB14467@bombadil.infradead.org>
In-Reply-To: <20200121220112.GB14467@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 21 Jan 2020 16:47:27 -0800
Message-ID: <CAPcyv4iPX4fDZGFwCkJxMDc-+1DjOMVZYVqnE=XTZpis6ZLFww@mail.gmail.com>
Subject: Re: [Lsf-pc] [LFS/MM TOPIC] fs reflink issues, fs online scrub/check, etc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        xfs <xfs@e29208.dscx.akamaiedge.net>,
        Steve French <smfrench@gmail.com>, ocfs2-devel@oss.oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 21, 2020 at 2:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jan 21, 2020 at 08:18:40AM -0800, Darrick J. Wong wrote:
> > On Tue, Jan 21, 2020 at 09:35:22AM +0200, Amir Goldstein wrote:
> > > On Tue, Jan 21, 2020 at 3:19 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > >
> > > > Didn't see the original mail, so reply here.
> > >
> > > Heh! Original email was from 2016, but most of Darrick's wish list is
> > > still relevant in 2020 :)
> >
> > Grumble grumble stable behavior of clonerange/deduperange ioctls across
> > filesystems grumble grumble.
> >
> > > I for one would be very interested in getting an update on the
> > > progress of pagecache
> > > page sharing if there is anyone working on it.
> >
> > Me too.  I guess it's the 21st, I should really send in a proposal for
> > *this year's* LSFMMBPFLOLBBQ.
>
> I still have Strong Opinions on how pagecache page sharing should be done
> ... and half a dozen more important projects ahead of it in my queue.
> So I have no update on this.

We should plan to huddle on this especially if I don't get an RFC for
dax-reflink support out before the summit.
