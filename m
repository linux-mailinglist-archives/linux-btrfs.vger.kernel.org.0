Return-Path: <linux-btrfs+bounces-10085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C39E63DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 03:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D031B16A0AB
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 02:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D94145B22;
	Fri,  6 Dec 2024 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b="iGs5yi8q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82D193
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450651; cv=none; b=Y9MdZ3VhT1owxXrhHQTrnJhOMdDOQ+I8+kaiNuvtFE13xHASNLJSHq+GAjYIsA2K1Y00+uMO82+e/q19s80x0BNviwEefsy9VTL3dPzGnJx75s6kezcyM9a3sRocUAU/qCm/6OeL8u6R7eB/fTl0PqzIqUH6LXlBdyvqud6FWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450651; c=relaxed/simple;
	bh=tEcSTUv9IdIl+MOUsQuIX0BOrMYPmg+4d5T7hGx+fpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR3o2Ro0yMehNk6nfOkSpSDQUqIUdicK1kYiaVq/DR8YXhJPpJa+HeLJ56E4lyWIrkLCEm0rzfwVPXfvlj/RUdHOi8yWrxpXp48caDwhiFymn5JfuWXKj1YEziWDIANhLghD8K/TwGWUQQtWVoqgacRsXJDGzkX6nu23sMWbn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io; spf=pass smtp.mailfrom=jse.io; dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b=iGs5yi8q; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jse.io
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ef63e73bf6so1128067b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2024 18:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20230601.gappssmtp.com; s=20230601; t=1733450648; x=1734055448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEcSTUv9IdIl+MOUsQuIX0BOrMYPmg+4d5T7hGx+fpY=;
        b=iGs5yi8qzJeIG1SPe9YUTWu8vTA8oWqDgIGxeieKpUOlEppKBhij8raA7lozOyBDfW
         NXm3TjZz5lAu2ufEx3FepENsGeA4e6RYocYB75NKBy4cRNXaHDHSCrp+fBe0dfbkCaJ2
         qMP6I/6n9uSL15wwwWyi1tEj6dd4iStS8T+7TdEirNsFzwxoc8RWr/Mc17/c28yxJGS8
         Rb/78RqIcgBKk3gKxj1beGZL5+PdnJ8VqV4si2qVE1dRznmWNi9hJWjL7+E7D+xX0NeY
         aAhlUg+Se+6xhSPfy5XlX86CPrUqmWySyMKY+5eHoczLA7h/c48yFLvY+7LnDIOXM8JM
         c2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733450648; x=1734055448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEcSTUv9IdIl+MOUsQuIX0BOrMYPmg+4d5T7hGx+fpY=;
        b=WIY6sxtsgZj2HlttelkiEhK2cQ8a6azjJGXBxTAm/rO2o1r9NzgRMIGXXuR3bY7Lj2
         vMGVch5jg0C6+EyFeIzgV1Dp89MnBfxr5ZqC+6jHTNSdZ7JFyxxBkEDa95PB5t7FTaWY
         YFsT7rjUfb16rXNWjA3pO62spFZJ65+Vl+iTmaCyCEjwvpFA2nEaAiBZMtLOsEyp1oWp
         l5DqUVCH9eU6sJUmsch3OZZ9sF+QBrYkkvLECjN08OoXmeb4ISl+L7TkIRkCRnmzw+aK
         QlmlfrS7gvp/HM0jslZBR6xuxtfvY23bo5jKPGbuUAEZTKrB1wLjTH7Gn85sf3wAL50h
         on5A==
X-Forwarded-Encrypted: i=1; AJvYcCWsY495pdyHOxbCmykrSJpo4vvCXcUzWZDJftEPxBzHRpWMpGzUsnOID4exJeu8abD51qeDkbXFs0wvlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsq7HeWmh0l0ADuPcgm8MIvCK4SIb1TqrPPpqRMaiWkA/uTR3Q
	nyfbjnudvxvakmnsmmHPz/rYiVyqgIn5UxOQmmoqUjXa7Jy7hwFK8uA8pCy72IZJzP7sqViZIOL
	uGFLMZKKgmdAizOIsxwBXweDOJb6ecYMRfJXJpjrH5xQKy0yznnw=
X-Gm-Gg: ASbGnct+Zg2QBOcQyGGHUEU8UvyQbLsmiHHob3s8bSTRcGr4u01DeoK12ECO1+/sJ7+
	/Z7jITfWAcdU1C6YonM9e9zh9E+fBXv9DnQ==
X-Google-Smtp-Source: AGHT+IGbRMNA6D3gSpTEYB07pQ7rajOuLEWXCvBcZwdtIm6tQGDnLxru+AzJ3nlcUu/tsmKyLHtfw8YiIFKPpKXJtMo=
X-Received: by 2002:a05:690c:4686:b0:6ef:5c7c:839a with SMTP id
 00721157ae682-6efe3bf867emr6966117b3.3.1733450648109; Thu, 05 Dec 2024
 18:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email> <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
In-Reply-To: <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
From: Jonah Sabean <jonah@jse.io>
Date: Thu, 5 Dec 2024 22:03:32 -0400
Message-ID: <CAFMvigdQPC_cV5td1j0e2CR=qPT=W0Lp=+n74_UrSzahayMJWA@mail.gmail.com>
Subject: Re: Using btrfs raid5/6
To: Qu Wenruo <wqu@suse.com>
Cc: Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:40=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2024/12/4 14:04, Scoopta =E5=86=99=E9=81=93:
> > I'm looking to deploy btfs raid5/6 and have read some of the previous
> > posts here about doing so "successfully." I want to make sure I
> > understand the limitations correctly. I'm looking to replace an md+ext4
> > setup. The data on these drives is replaceable but obviously ideally I
> > don't want to have to replace it.
>
> 0) Use kernel newer than 6.5 at least.
>
> That version introduced a more comprehensive check for any RAID56 RMW,
> so that it will always verify the checksum and rebuild when necessary.
>
> This should mostly solve the write hole problem, and we even have some
> test cases in the fstests already verifying the behavior.
>
> >
> > 1) use space_cache=3Dv2
> >
> > 2) don't use raid5/6 for metadata
> >
> > 3) run scrubs 1 drive at a time
>
> That's should also no longer be the case.
>
> Although it will waste some IO, but should not be that bad.

When was this fixed? Last I tested it took a month or more to complete
a scrub on an 8 disk raid5 system with 8tb disks mostly full at the
rate it was going. It was the only thing that kept me from using it.

>
> >
> > 4) don't expect to use the system in degraded mode
>
> You can still, thanks to the extra verification in 0).
>
> But after the missing device come back, always do a scrub on that
> device, to be extra safe.
>
> >
> > 5) there are times where raid5 will make corruption permanent instead o=
f
> > fixing it - does this matter? As I understand it md+ext4 can't detect o=
r
> > fix corruption either so it's not a loss
>
> With non-RAID56 metadata, and data checksum, it should not cause problem.
>
> But for no-data checksum/ no COW cases, it will cause permanent corruptio=
n.
>
> >
> > 6) the write hole exists - As I understand it md has that same problem
> > anyway
>
> The same as 5).
>
> Thanks,
> Qu
>
> >
> > Are there any other ways I could lose my data? Again the data IS
> > replaceable, I'm just trying to understand if there are any major
> > advantages to using md+btrfs or md+ext4 over btrfs raid5 if I don't car=
e
> > about downtime during degraded mode. Additionally the posts I'm looking
> > at are from 2020, has any of the above changed since then?
> >
> > Thanks!
> >
> >
>
>

