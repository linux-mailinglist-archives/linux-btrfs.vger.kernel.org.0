Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD8A9413
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 22:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfIDUso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 16:48:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32961 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIDUso (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 16:48:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so3386896wme.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=q000UqLfLO13JClMleJOjv7ZSefyKSkN+q2KexWL+Us=;
        b=ANSEnXx0Xqy2AUEnsNTMiNpdHiStNKklkurSmv99EWjGMuPN24YmLlbM+7Hm2wzGTc
         jbWpSx5OAyZ/eS932FwR1TIAFBx+VEtNCW3fkQzCGC0dlUwi30/6m7iESqaqoyjK8MDJ
         8R0RilMjCnqSJxnOY+YHfRXzxy8PUyTvhCUMlagy/JDb7zA0tsxPn60D+t9UIjkN1Ilg
         2kHLrY2VogjAq7IHau3Ti7OuGuHUBmdPvCwyTc8hw2lUMkn5QFKw0NQUME3fUbuTdl2N
         IXn4Nx3GOQTaekbneNBRTecSawRjQQwTXL2Hxk1XaUMjynY3gzWXhM8DgWYjRo8uo2gU
         EiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=q000UqLfLO13JClMleJOjv7ZSefyKSkN+q2KexWL+Us=;
        b=Z61yPYJqgrvzwKy4vMGPNueVL8XiDirqIEH5aq0cff7wdnFXlTwOtNMiGyjxYq5LBJ
         Vh0jhl+C9CzN96q1Rua7t9Ee9PlWdvDVTPGtmOq0lz0jsO90kB3gO6UafsfJINbpMbeB
         N7qo/5j20Zi5QECYvYC++bo0L2EhiGG46m9q2NUe0htNPNtTGj4anDHfMzC+xOd+aicy
         BXMPg7MRuiixoNGjOQfAA8cMg+/6UtwOCOphOoQeytNfj9FE5xiEIhjUXA8f96meM1ah
         yXuGNPQh1+YntJPCZGp6U7XFAjEo/CYPb6I8mEIgvpstjdVmiTbsnmKWDfbvXpVtjFKl
         h8BA==
X-Gm-Message-State: APjAAAXLwum+9r0K9+OU9hREl8F12mr4kuZ6tu7PVroSUlYc2Z5uD/qG
        HfSylYr/BRYnSs/MJJ2w2Pm1FeCJbQA3rmEhMjD78g==
X-Google-Smtp-Source: APXvYqz+WFreqNwXK8YkyH8EEdRnnuRBP7Y3jW91zzL8iiC7izbVfyebqdTIhtXOKvggybrg1EK8j4bPeC/QLK92H4w=
X-Received: by 2002:a1c:e709:: with SMTP id e9mr136340wmh.65.1567630122380;
 Wed, 04 Sep 2019 13:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
 <CAA91j0VLnOB1pZAbi-Gr2sNUJMj56LbBU7=NLYGfrPs7T_GpNA@mail.gmail.com>
 <20190904140444.GH31890@pontus.sran> <20190904202012.GF2488@savella.carfax.org.uk>
In-Reply-To: <20190904202012.GF2488@savella.carfax.org.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Sep 2019 14:48:31 -0600
Message-ID: <CAJCQCtQoKOL68yMWSBfeDKsp4qCci1WQiv4YwCpf15JWF++upg@mail.gmail.com>
Subject: Re: Cloning / getting a full backup of a BTRFS filesystem
To:     Hugo Mills <hugo@carfax.org.uk>,
        Piotr Szymaniak <szarpaj@grubelek.pl>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Michel Bouissou <michel@bouissou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 4, 2019 at 2:20 PM Hugo Mills <hugo@carfax.org.uk> wrote:
>
> On Wed, Sep 04, 2019 at 04:04:44PM +0200, Piotr Szymaniak wrote:
> > On Wed, Sep 04, 2019 at 12:03:10PM +0300, Andrei Borzenkov wrote:
> > > On Wed, Sep 4, 2019 at 9:16 AM Sw=C3=A2mi Petaramesh <swami@petarames=
h.org> wrote:
> > > >
> > > > Hi list,
> > > >
> > > > Is there an advised way to completely =E2=80=9Cclone=E2=80=9D a com=
plete BTRFS
> > > > filesystem, I mean to get an exact copy of a BTRFS filesystem inclu=
ding
> > > > subvolumes (even readonly snapshots) and complete file attributes
> > > > including extended attributes, ACLs and so, to another storage pool=
,
> > > > possibly defined with a different RAID geometry or compression ?
> > > >
> > >
> > > As long as you do not use top level subvolume directly (all data is
> > > located in subolumes), send/receive should work.
> > >
> > > > The question boils down to getting an exact backup replica of a giv=
en
> > > > BTRFS filesystem that could be restored to something logically
> > > > absolutely identical.
> > > >
> > > > The usual backup tools have no clue about share extents, snapshots =
and
> > > > the like, and using btrfs send/receive for individual subvols is a =
real
> > > > pain in a BTRFS filesystem that may contain hundreds of snapshots o=
f
> > > > different BTRFS subvols plus deduplication etc.
> > > >
> > >
> > > Shared extents could be challenging. You can provide this information
> > > to "btrfs send", but for one, there is no direct visibility into whic=
h
> > > subvolumes share extents with given subvolume, so no way to build
> > > corresponding list for "btrfs send". I do not even know if this
> > > information can be obtained without exhaustive search over all
> > > extents. Second, btrfs send/receive only allows sharing of full
> > > extents which means there is no guarantee of identical structure on
> > > receiving side.
> >
> > So right now the only answer is: use good old dd?
>
>    If you want an exact copy, including all of the exact UUIDs, yes.
>
>    Be aware of the problems of making block-level copies of btrfs
> filesystems, though:
> https://btrfs.wiki.kernel.org/index.php/Gotchas#Block-level_copies_of_dev=
ices


This might be fixed now. Anyone want to test it? With a recent kernel of co=
urse.

*runs away fast in case it isn't*


--=20
Chris Murphy
