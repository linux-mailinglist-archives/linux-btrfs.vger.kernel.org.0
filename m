Return-Path: <linux-btrfs+bounces-11034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D7A18EC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 10:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E1B163885
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C016211297;
	Wed, 22 Jan 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CE0Lgcud"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E002101A1
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737539354; cv=none; b=X1Yn6U0XgIKO+wFNv2QiwxHsWYzaS0I9ulWDaSdVLtFFGZoSUHK6InNcxdITdeHCsROCbQ1+KG3NGmNVmUF3MjuZIIxfkOP9nR0AVBmiu315f1eRlVOsCZKTPsyInK+SDPlnzqsSn2lzZ7zBI/3lm+XJpFYI8QJh/VreFndDzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737539354; c=relaxed/simple;
	bh=zolDYIWoDAQc6jukB3Glwyfuwlk0h+GE8NBGC1DE5Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F52M5J8l99V0IbYyhUhXkJGzGgQWN10JUFF1R1F4rOJzjN1KhzG8ltC6rLTKrDcsbFmGTR9w54Y0wSvDQLTZ1dpFk1FWkKZHGBDl+dzWGPYH8EaHna/ThMzDMdY+g49HblxShH7qpVaK30S5mJewVu6atnwAcABkdLxADtWazKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CE0Lgcud; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso1024091866b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 01:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737539350; x=1738144150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zolDYIWoDAQc6jukB3Glwyfuwlk0h+GE8NBGC1DE5Fk=;
        b=CE0Lgcudq/4pdGfywSG3Gk2o+A1FO0JLlAyT16wl0Pu8YwLuD1aYbYtroeBJzvhLIH
         3EFMEW/zP0+1MQNxMGwIvM6iAh6a4DffHMGKFjT+eZ66Il5TZYpWcb3/b0c99LB74qpr
         GEhZDBC0JwPm3Y2X0bGr+1k1SUrgikv86IwaJmo3eDtPvs93GKipvjIcl25bCcHbLcC8
         JtfENL1SOPfXfzvltaOQ6qNY91+FfYKtLWlEvI1Aczc1gpIJNjqUU7J86xq01GCGHLY+
         Xy07h9CpGeOOQ0CNSJxLcYnQ/oUr9EINCXosii1mKlEBOfJ2rRIXgSfGzG0MVS656V6y
         31Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737539350; x=1738144150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zolDYIWoDAQc6jukB3Glwyfuwlk0h+GE8NBGC1DE5Fk=;
        b=xOQxsH6Xq0o47IZ4uk21SFKXjZH5QFtrhUskaKNYXWBZiwNedFHIt3kS5xupjwtLU3
         kXilXNHoalaCIAB7zG2nrtTrDUqWWeAinNAiKQD4Lnvw0itrgkOeWkWmwDmDbhdfQAQX
         N2i9P2M7vY4oMjW2o0uUhLi9bjfD+lhvCFKUxVESDJAjHY7V5yufIPXe1FW0BfUXOZeC
         m69iY5VVXE3oswEarZVef0YJaK0BmTcjJmfpwl/pvsBf4gF4WuTE6zpgvQ8il/YUjg69
         zk74yMSY4cZ9KEay/U7pSI38magDOS+d3kVxf8rRbMDEY2iKmtlnBjvC0jyeJD+GvWgF
         JYNg==
X-Forwarded-Encrypted: i=1; AJvYcCWZMRAuubLqEasF/qBZjp97KeqS2A3aYwv6mZsAVd+NaPPiEGKLGJC7pFnSwQzRaOAqnMuuC2gFNYQ6PA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnL5TYdJxcesQ6xoFSFApD6jqH/68/WYUmWgw9nLWe7PyEm8wO
	qvz8sjw16enn56pL8kMxMzjW3enShj3staeRePEmW+kkJc5SLnreDk5OQiY4EYwdSnsYqx05tpS
	KCBndud5Y0g9DHPKJx+tQtXBdlNe9pQOCJwkak/CrrbnPxdsfJFlOPA==
X-Gm-Gg: ASbGnct68QWT1HjQZgsOQqH2HjmykZSR8UQop+dIy5igsX8wc7Y00+3GUGWqtja6IWy
	PWOiMC0pSNE/Xe1qG4esvWcdR5wj8rCdB33X2ZuwR4e2VEMF0kA==
X-Google-Smtp-Source: AGHT+IGoQY7ZjJrsCfPCBruPSWXpUw5QgjpVcd1dfUjyoj4Uta1agP9QX1XrMdFYO4AVk5EsqpF6+0C/VYRuyfj3YN0=
X-Received: by 2002:a17:907:1ca2:b0:aac:4325:a604 with SMTP id
 a640c23a62f3a-ab38b3d63a6mr2130024366b.49.1737539350284; Wed, 22 Jan 2025
 01:49:10 -0800 (PST)
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
In-Reply-To: <CAGdWbB5CfN_0i5u2iofPp1Wred9Kq5OsR6F6Q6uOKpnD4PR3Ow@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 22 Jan 2025 10:48:59 +0100
X-Gm-Features: AbW1kvb3eTuTadQ6zhrUneDQNcTk2_Z6gmWPmhVppstmvBC_cEV01TO7sSpIPcs
Message-ID: <CAPjX3Ff_QTBKe9Z3QMxVqJyzs6KTQEw=Ut-1nATEkAn-rgDfmQ@mail.gmail.com>
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Dave T <davestechshop@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jan 2025 at 22:50, Dave T <davestechshop@gmail.com> wrote:
>
> > > The laptop doesn't have ECC RAM. Is it even worth it to run memtest?
> >
> > Still recommended, as if it's really bad RAM and it's soldered, you
> > should make sure that you didn't run btrfs check --repair, which is a
> > dangerous operation with possible unreliable memory.
>
> That was good advice! Thanks.
> I'm glad I listened to it. The laptop has bad memory. It failed the memtest.
>
> It is soldered, but I'll check with some repair shops.

That sounds like the warranty expired already. If repair is not
possible or it is too expensive (or till it's done) you can just
blacklist the failing pages as a workaround.

Check the `memmap` kernel option [1]. Something like
`memmap=<size>$<address>` based on the memtest output should tell the
kernel not to use the unreliable failing block of memory.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt?h=v6.13#n3378

For example, for a single page starting at physical offset 0xbf307000
you can use something like `memmap=4K$0xbf307000` and so on.

To verify, `/proc/iomem` should then list the range as `Reserved`
instead of `System RAM`. If it does not work you may need to escape
the dollar `$` sign as grub may process it eventually before passing
it to the kernel. This can also be checked with `cat /proc/cmdline`.

--nX

