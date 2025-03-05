Return-Path: <linux-btrfs+bounces-12021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92330A4FCBC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 11:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AEE3A04EA
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D1222759C;
	Wed,  5 Mar 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W2Y+v4T6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B221CC4B
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171658; cv=none; b=CgtcGMjJhG6ekc2YvNjgyUrAjT4RbebBSefVDM50tjca/IpvT6O7msWKM69JsIvnqgPGteLZJoa+ScqepOxF/WTLc1cBsykeGohrHKk5oErkNF3wmbqIOAUwZsJ3tdT2gON+we1StlFdRPuOKBT9uFu2fZ/1zktDrtYa5H2zvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171658; c=relaxed/simple;
	bh=t4u6WKPRKH2yfEnORaR1a+tLv9v74WBw8C0p6nyJUm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCGvRgqXX+VGJ9OekUZ19EroSihNNkduM+BU4r8OKMQxdyxFO8tDHi4uXtIWVqhraK4KSyNNkp6nuQLgmTKC1u0l8a7QxhRDCRAjZ8H3cqdxFBE3KVrzcU0BfLXlxnDblaVHXz4/DEQTniCWT3/jIho0PvQGr7a4dZNu6BKIs+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W2Y+v4T6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso8960304a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Mar 2025 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741171655; x=1741776455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c683FXgJRo4NsVKQbVNw1bopCDyxsKJraoigFNHCJw=;
        b=W2Y+v4T6A540q4N97HiaRrzkfecjt7Ee0irhcbTZe/2fj3ayn4gBWTzYyG13nga4Rf
         TN31ykOofRli86a0T9aO3OZTKSH6uyoaUJyX2P0AaKcloxQ314hwxo3XRyVOZ/XML2df
         OvrJVjNZMNtxUwHNSV1jrpcKjR8Ga5yZyVphHZ8bxlgapylRymuuenvqypMQcMUV3GmG
         vfKDzDUA0MSE9bJj2qAmR5R7jlVip4MxhX9CvT/vlP4PFYWkTNqKdtL1NYrc6aLgXCLR
         PR1RbqEd07fmd8cqaH5gaRfnKgkyKF+MnaLkHWXvBQqLvlsXSXASHdEXjT0OginCb5ZC
         dPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741171655; x=1741776455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c683FXgJRo4NsVKQbVNw1bopCDyxsKJraoigFNHCJw=;
        b=MY/l98Q9LZPrcrzxaI86TUljsWtClynJNIDcxHjtY3rSb3fvRhkY7uc5cBWUo0QYB2
         EDNAaB/snuiAWps9hC9yFCXvoZRchaWOgsWZmMphbDdfVXVOvbpe/dhj2PYjzFTOZHPO
         Ueyk5AyLV6VEoOas9EKucwsmowJD7jJRzdpF+mGrcoOnqZOpZ5A8WfEvCu30M+2v7wIa
         +/OLxz6Lfpux+n/7Uvh+gvo+ZV4KAHRMumO8TarpCxrt1UrtK40wAYiX6Jnwfak9zMg6
         xwCiepUu6EQ0K3afdsGF1OyAoemSTnEbCXlpCFWixgw83VfKAsRFDdSnTeEDYUFuCZ4A
         kFBw==
X-Forwarded-Encrypted: i=1; AJvYcCUqhXlwdZdKl42Am+XPL8Vl5TgzQlVEviWN8+vbFLRGYuufuCzVlq+Tt2z32MQK84tXijDJRa4tg8e0Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1v0A/AOthctTdngpl/h4JpGOb3aukSCtjroK/B5Z0XjGjZyXc
	zh7ofTyd2dfCpTpytLpotCWj+CokE4Q/3BPhFB7fHfnniNnJHAV5EZUDJTuzKYuzRUpeSG2W1aa
	YEkzNhvsZ8sB6gcPXCly3njPL14TqhRUWZOVpRg==
X-Gm-Gg: ASbGnct/rwXZJwiut7VOxT85xmybHrrW6AG+jNDK46F4TiXFsnxyatiFDUiToCdm64d
	spChV24rmplnIt4mDLc0nhrZP9bK4o+HvGnzV2wQvcM0hATNdOUH9z0kL2UzghBvhu7KUNMk0P3
	lNGCr2Yc5HBAY9mXNeeFdjUJ6U
X-Google-Smtp-Source: AGHT+IEDRe9fxejb5VrE73ymDvnXhY7FuPqRfvjm38/fKwrPDMKlNdqLyI0FLgS5aAw5jWtzotNheXMU2Zr42Q3+9OI=
X-Received: by 2002:a05:6402:5290:b0:5e0:348a:e33b with SMTP id
 4fb4d7f45d1cf-5e59f3c203bmr2525682a12.12.1741171654855; Wed, 05 Mar 2025
 02:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304172712.573328-1-neelx@suse.com> <e8cd2383-1466-4f4f-bc88-cf0ba8f04e60@gmx.com>
 <20250305102459.GC5777@twin.jikos.cz>
In-Reply-To: <20250305102459.GC5777@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Mar 2025 11:47:23 +0100
X-Gm-Features: AQ5f1Jr_O7U_Xjw2K7B4rGDNZZhyQ15nMHlnlchtfK_5HBnA_jNhj3z7xUKiXN4
Message-ID: <CAPjX3Fc5iwVbRw9Q4SN15hjRYE+GF4664nfRQyM2WjDrfH6tLQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: fi defrag: allow passing compression levels
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 at 11:25, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Mar 05, 2025 at 08:10:24AM +1030, Qu Wenruo wrote:
> >
> >
> > =E5=9C=A8 2025/3/5 03:57, Daniel Vacek =E5=86=99=E9=81=93:
> > > zlib and zstd compression methods support using compression levels.
> > > Enable defrag to pass them to kernel.
> > >
> > > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > > ---
> > >   Documentation/ch-compression.rst | 10 +++---
> > >   cmds/filesystem.c                | 55 +++++++++++++++++++++++++++++=
+--
> > >   kernel-shared/uapi/btrfs.h       | 10 +++++-
> > >   libbtrfs/ioctl.h                 |  1 +
> > >   libbtrfsutil/btrfs.h             | 12 +++++--
> > >   5 files changed, 77 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/Documentation/ch-compression.rst b/Documentation/ch-comp=
ression.rst
> > > index a9ec8f1e..f7cdda86 100644
> > > --- a/Documentation/ch-compression.rst
> > > +++ b/Documentation/ch-compression.rst
> > > @@ -25,8 +25,8 @@ LZO
> > >           * good backward compatibility
> > >   ZSTD
> > >           * compression comparable to ZLIB with higher compression/de=
compression speeds and different ratio
> > > -        * levels: 1 to 15, mapped directly (higher levels are not av=
ailable)
> > > -        * since 4.14, levels since 5.1
> > > +        * levels: -15 to 15, mapped directly, default is 3
> > > +        * since 4.14, levels 1 to 15 since 5.1, -15 to -1 since 6.15
> >
> > I believe the doc updates can be a separate patch since it's not relate=
d
> > to the new defrag ioctl flag.
>
> In progs I don't mind either way, included in the functional change or
> separate.

Next time I'll split them. But if you're happy with it as it is,
there's no need for v2 I guess.

