Return-Path: <linux-btrfs+bounces-11670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B76A3E385
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 19:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDEB3BC21D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 18:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7AD213E84;
	Thu, 20 Feb 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYEcly1o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D0213E87
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075192; cv=none; b=JW7sA48FJHnJ8bDf2yEHVopIvEu8HohU+3mmdfK6AP7DkdTmzPfEozcL+BfFtCysN/tTx1e85LYEkBdTfupY+to5eWW39AFBV+1QPACcJJnXFZuftG2ue+/1neS7We2Sn2WKAw3u3laXNoTSnVjnRUkhhBjtocHls+7ckZrch/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075192; c=relaxed/simple;
	bh=abPLwqMrhV9Yr/28ODl3bjeNEX/Qlutzlv4jS2Fz/+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdU8CrtZ/QoyqkS8cSNWbZsLjxW5PxYgIrwxJqK9NS74tjzKVsVvmzl74FcutZEyaqLEJCo5WrtrRAlEc2p+pDbkuGOKezv0zl81DYYTM7sIcQU4SwxiwyPtc+iEAvaigmoE5b08EYkb+W7B5a64lBHmOQpDT61Pl9PlDACOeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYEcly1o; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so1190623276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740075190; x=1740679990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abPLwqMrhV9Yr/28ODl3bjeNEX/Qlutzlv4jS2Fz/+E=;
        b=KYEcly1omBbDes03oxqjyy0YLhmyzRY7yNx/gNNelCxlyvYZVb1FJq1U11MT0ICwAa
         HPefRsFzP+yxsLRHQvJ3sEPraJ77Mc+5MPolUl32iU+ZaMQxHUSG/YKHKxXyQqiVPoQ0
         CIAeTBdzJbfW5ApLVMDJ7Am25ydPnMwJB9nLDRcZE0b2jMvTglSGKT8l+LN0eVXx/iVH
         AEa7TIaN9fHZwKDo5nwDwxD7MBc7EtgV+HQu0TzU/W6fzGka7gc4Be2dMPVb9lv27+76
         T5Jh0m1QpCYH2vBEVQPEicATAYAx5K/c0vzNXa3vl8veRdwF/OGfiaojEgvqQ18dqIf1
         8Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075190; x=1740679990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abPLwqMrhV9Yr/28ODl3bjeNEX/Qlutzlv4jS2Fz/+E=;
        b=Hu1oKlg27jIAsOB6bC5yqeNcMLcvdlV55Mkao9Svmbfi5WaR1erHqgPAJcSd8YLp8D
         bOW+De7s3HvLvJjY/qlgL8PdRPERbvpDUjt1qc7Ad9DYyWkGbKGkxqo+PTTARNTd6pge
         El/jNc7UO6sL+wc+Xatx2LUmBCOE9hyfJlrD4g5ygjORxa4mF8To/PxuF1QwA603q8Hd
         mFRKd4GyWi2jx8tEZJpHAEhMlwnQzO3THIBUF2i9ap1TCxVdho2UUEIFIF7/b0mDtwY2
         1wbP5148xW78FYektX7T7USdIqL7UrXgD+OrEgDuHrQK0xHProc7qwpWDcM9A/wZ4owJ
         e03Q==
X-Forwarded-Encrypted: i=1; AJvYcCXs+H/BL/CmD3CTg4ZqeIhrlCEOVc3UyYLDRlaRh6fa/MP5/Ut0lTRctijE7hcM1q+9+XPL3NG2vciWsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYuNc4BI0R4QLsy90e9+IAHXrHTRaZjofXU+IfatwiKUDAvQU0
	TFixg4T1yWFlXljGq/ocHCdH3nr5oFFByvjLi92pH0zW6oBLZBk+tZ3SIAHux0DbTLkawE9qCRX
	XS0xG7YHiO2ee61Q1p0Scytkjug99kKIj
X-Gm-Gg: ASbGncsyoN4VaJRSb6OVcd/ZdPHf6Eh7sYueeTmK++eTYHQjAvqmZTGpZI/a2ywC0LW
	K8kP0BNU4xI4xA+3zOLALVv1HgXOV1Ahtu8n3CSn+ue7VN4kVEXK8ef74dTBG+9H0CQbkWnym
X-Google-Smtp-Source: AGHT+IHQt1vC1kHRlBH0w+ax2V7TfxathB3uCLDavTXJ7E6ah5WY7c1mH2XPhnu5+bZ3IcT2z3URP9Iyme7ZCgyvTXM=
X-Received: by 2002:a05:690c:6a12:b0:6ee:5cf9:f898 with SMTP id
 00721157ae682-6fba57a3696mr84583727b3.33.1740075188644; Thu, 20 Feb 2025
 10:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
 <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com> <CAGdWbB6A5S7-+VM9HsPyb=5FMTqOSb3GVCzS+ix0vvRg3sfJ5g@mail.gmail.com>
 <34c2418a-c08e-4408-bf6e-3216d6b64ea3@gmx.com> <CAGdWbB7tFj_CT_XGEb0egRF+pDqB9+bVeP-Y1643y0WvsMcfMg@mail.gmail.com>
 <b2267eca-5528-4cec-8956-d0f666f79c9c@gmx.com> <CAGdWbB46VJrjDMUxcNmeXsAfxq+YCD52v4pKcHK7OjpRpgc8rA@mail.gmail.com>
 <cf1b590c-6ffa-4c92-bc39-7d72a4282d28@gmx.com> <CAGdWbB5CfN_0i5u2iofPp1Wred9Kq5OsR6F6Q6uOKpnD4PR3Ow@mail.gmail.com>
 <CAPjX3Ff_QTBKe9Z3QMxVqJyzs6KTQEw=Ut-1nATEkAn-rgDfmQ@mail.gmail.com>
In-Reply-To: <CAPjX3Ff_QTBKe9Z3QMxVqJyzs6KTQEw=Ut-1nATEkAn-rgDfmQ@mail.gmail.com>
From: Dave T <davestechshop@gmail.com>
Date: Thu, 20 Feb 2025 13:12:57 -0500
X-Gm-Features: AWEUYZmCMUgAMDUAVaW0u51cBgSF0dMKEaYo0Le3gGHC9XJiDHOg8W8cNF5ESi0
Message-ID: <CAGdWbB7NnryCQbtShqo5LLj1pc5N2P_KUpzZ3uzPgpwT=_9xNA@mail.gmail.com>
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Daniel Vacek <neelx@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> If repair is not possible or it is too expensive (or till it's done) you =
can just blacklist the failing pages as a workaround.

Thank you! I'm going to try this.

On Wed, Jan 22, 2025 at 4:49=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrote=
:
>
> On Sun, 19 Jan 2025 at 22:50, Dave T <davestechshop@gmail.com> wrote:
> >
> > > > The laptop doesn't have ECC RAM. Is it even worth it to run memtest=
?
> > >
> > > Still recommended, as if it's really bad RAM and it's soldered, you
> > > should make sure that you didn't run btrfs check --repair, which is a
> > > dangerous operation with possible unreliable memory.
> >
> > That was good advice! Thanks.
> > I'm glad I listened to it. The laptop has bad memory. It failed the mem=
test.
> >
> > It is soldered, but I'll check with some repair shops.
>
> That sounds like the warranty expired already. If repair is not
> possible or it is too expensive (or till it's done) you can just
> blacklist the failing pages as a workaround.
>
> Check the `memmap` kernel option [1]. Something like
> `memmap=3D<size>$<address>` based on the memtest output should tell the
> kernel not to use the unreliable failing block of memory.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/admin-guide/kernel-parameters.txt?h=3Dv6.13#n3378
>
> For example, for a single page starting at physical offset 0xbf307000
> you can use something like `memmap=3D4K$0xbf307000` and so on.
>
> To verify, `/proc/iomem` should then list the range as `Reserved`
> instead of `System RAM`. If it does not work you may need to escape
> the dollar `$` sign as grub may process it eventually before passing
> it to the kernel. This can also be checked with `cat /proc/cmdline`.
>
> --nX

