Return-Path: <linux-btrfs+bounces-17257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC68BA8E90
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 12:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D843ABDA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375E52FBE1E;
	Mon, 29 Sep 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVy+erGe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537E1A9FBD
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142538; cv=none; b=AT5M/jHepzVIYUdQFXQ1jE13l8yaiW4wC8Q0YfqhaYMQYLpo6p/Ea/eMWVWnfkcG3FrARd6dUvJPVZ3XJQxc7Jpj4uDMXlfxHYDlydttf2g257Yt10oEf9WbJSpDi0DrfOTvT8g4pwwOVxrO6WKRYEnpRv56a13+CZLbw2qtbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142538; c=relaxed/simple;
	bh=a8OBZ0g6LYqCHiJVCrsbC9Z4XeWOULpxh3eJcS0SIXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZvCp2WPNgbjFQ9yGXzvyEZJ6L0qvvMfrwL7zCA9oho/gZztBuM+dWN8mfuZlmge7cfyAUobulvDBC6/kiGUkI9Sb+mLSiflOAAukL5uwZxlOjKlgW6M8dYP9pcNV9G8O2heH1SHYHugPLVtQXQeHBA/rADUj8FjyXFSt1DEpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVy+erGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EB4C4CEF7
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759142538;
	bh=a8OBZ0g6LYqCHiJVCrsbC9Z4XeWOULpxh3eJcS0SIXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oVy+erGeMXI1qQJQdCl/6ipEupoAKIAtScghRiubpKHXykG1dUCDgPyFsIpf/fR7L
	 Oo9iL8gLX01ctYIOe1/8eIw84L4JZAKURCXYgglzVygI5aESkIVKBD4KfHDpjqKfxf
	 Wi/z7K4EBr7vkBara/pKw0pwTa+CIWpbALAMxgxUuuI+wZb5FDDdqMn77JIoq6A5Rs
	 SJCforCNnO9O0+U2r4+qCzsFyyB4q3nZ85TOs5NTgZMr69GjmWAN7JIO6Hrboh8XmR
	 VNepV5fyxl3V/O+Qq4wEcce0mZhlYcrVNPNfqKJHNxqMq2M/8jpzbSn5J4mdd033ef
	 22/8r1mzDTehg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a16441so731678966b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 03:42:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YyT/IpDE93OCo6yoeGT/9DUrzsRK1VzDfozh3AbfjUX/ArWOI7o
	Lyr/dn/5jX8N2OmfhbmtY3qkyJUaJtVwORCsc3lrI7W8N5uEV6pkS04Uon2XafBt4b45wPDXn51
	84u/dVWv+nIHz+WDDzUSAAONhUojRel8=
X-Google-Smtp-Source: AGHT+IEACAcH0bbJusaJXmjlhHX3kuB9jg/hvOgySlh0E+Ej+L7lQpXGpYbC+B6W/cyIrCgpr+rJ6+00uAkNs56Wzp4=
X-Received: by 2002:a17:907:6093:b0:afe:6c9b:c828 with SMTP id
 a640c23a62f3a-b34bd93b2e9mr1714556166b.61.1759142536534; Mon, 29 Sep 2025
 03:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H5OvZrFZDzhds98vwLNXO1ttWjJVajCwQRhPHmt+dDJCQ@mail.gmail.com>
 <5926212.DvuYhMxLoT@saltykitkat>
In-Reply-To: <5926212.DvuYhMxLoT@saltykitkat>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 29 Sep 2025 11:41:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4ZR1P3wCCgq6MbNnOjcy0ing5_qyi=41rz3f5hQpFUeQ@mail.gmail.com>
X-Gm-Features: AS18NWA_pREVaUs6ppXgojdRYlmUcMuGscLmj3eXuh9TPB56rz7WZ-4gsumjEHA
Message-ID: <CAL3q7H4ZR1P3wCCgq6MbNnOjcy0ing5_qyi=41rz3f5hQpFUeQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reorganize error handling in btrfs_tree_mod_log_insert_key
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:24=E2=80=AFAM Sun YangKai <sunk67188@gmail.com> =
wrote:
>
> > > -       ret =3D tree_mod_log_insert(eb->fs_info, tm);
> > > -out_unlock:
> > > +       /* Deal with allocation error. */
> >
> > This is a useless comment... The existing comment is much more helpful
> > and the fact that's in the else statement above, makes it easier to
> > grok.
>
> I agree that the existing comment is much more helpful, while I personall=
y
> don't like the else branch appears after a return/goto/continue/break
> statement. So I think it's just about personal code style.
>
> > I also wonder why you picked only this function, since this pattern is
> > followed in several other functions...
>
> Because I happened to read this, and it takes me minutes to realise what =
is
> happening and why it was written like this...

Well, having to spend minutes to understand something isn't unusual,
even for more experienced people.
You can't expect to understand all the details of the tree mod log in
just a few minutes, that's unreasonable.

> And I'm not sure how to make it better. Since this is the most simple one=
 with
> this pattern, I just have a try to make it more clear IMO.

This is a short function and I find the existing flow and comments a
lot better to understand (well, I wrote them actually).

>
> > Not a fan of the proposed change.
> >
> > > +       if (tm)
> > > +               ret =3D tree_mod_log_insert(eb->fs_info, tm);
> > > +       else
> > > +               ret =3D -ENOMEM;
> > > +
> > >
> > >         write_unlock(&eb->fs_info->tree_mod_log_lock);
> > >         if (ret)
> > >
> > >                 kfree(tm);
> > >
> > > --
> > > 2.51.0
>
>
>
>

