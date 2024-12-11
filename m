Return-Path: <linux-btrfs+bounces-10215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1169EC1B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 02:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DDC164758
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 01:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E122878F45;
	Wed, 11 Dec 2024 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b="vLWWF8KF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30422451CF
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 01:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881710; cv=none; b=YJLie4S096GCYaO23axmwbPt6p9YBmv8C7YmP2v7xNughiAnDMRi6JqBEgLH3dre3+hKdO8CI7Wdx2K/qYqO8yQpEnBuXlvvhT46boXFHOnREpLY3dAOoijvHWaMVtv+NSXFlkcBXab8EWiryYCp3v9mfo+cM/DTFVi2R2Lh+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881710; c=relaxed/simple;
	bh=vNT33i8UME4wH6pGCTUPJ4TmZwjlNIxeKPzbFLTiXnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgJgxPoKRM8NhuYyvqQzW941RF45DMeqMv0ieUjMTj+f5Epw7f4x6LQazjbsAOidUJaawkKEQ8UePY+QSO/jDicUBp57ut29w4ruekmaYrpno9N8lLqTXrxs1RdaTxlLfekCRTr0ZM2JTO/8Wv0RmylXc06GamhvfLpnFl3WBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io; spf=pass smtp.mailfrom=jse.io; dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b=vLWWF8KF; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jse.io
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3a272afc24so445461276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 17:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20230601.gappssmtp.com; s=20230601; t=1733881707; x=1734486507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfEYisryGKWjBbt/JQseMNMW97upPVL/z9s2mmI9/Jw=;
        b=vLWWF8KFhb7LDLf92LpfI5cY6dqGCBAR0b7VFlCMpu5uZq7R1KoC6e3nA7vwBe6vWY
         HQV6Q73/mS5ntMcTkW2HhWasBTfng08C5vBgoscW8LrzMhVnIn0RYPhWaqlyrv29X/X9
         1CvPoHogd3C5KLI0ynSzeTSiAWEK4SmfU5p56KK4nXOEUAzF13ivOX/IKlIPn356HU+8
         Ffim2aBAHAW82sjvrWaHcf14+XOdIjwO5MfQFWHTLGHgYHnph08K35KXFRtGO38rzD95
         5wNu6voocduLYfUsFu/clGDHd061HxJE+nE1Cyfwt5Uqwn7x3T77D2rgs3+CBLdLGo1/
         PjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733881707; x=1734486507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfEYisryGKWjBbt/JQseMNMW97upPVL/z9s2mmI9/Jw=;
        b=YTRJeAqaBi9Q3wUAh+gunselngr3MTj7bRzf4UOqbKiSf73liRpIpaZ4ANj2Nxsyb4
         4gmJiVz2Qj0ybUf++fu9z009z2J+ZdWNguYbrhYLNVHoHcxrFlIjut4RUYy6k3GtXDXQ
         kRfoxcgCucpac/lHanpGWFF5XdhenhvWu1WEvJXqQ4FzPcUJ/2v7D7UT0+T0Hdm24t/n
         rmfIWgLtmWPQFzhvyDzuqFrCkLygw+nBdl8aJsh+WsDoXXKh5buYel0/cGmEhJCHkE0P
         PCwoR6NApVLw+fCVmeZgxtKeQX8IlM5+JCqVjtF4zW8jeS+VXnfyA1tmlrBh8gsGXrhc
         ecRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3y7KHJ9cwR2VIhnScq+vbPpY6OxqH2wlyhuQ7kE7LVYYsuOHmSaOlfanG5rsJRVo6FM32Qo8T2lCwRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkZuPsjcDdH/8qYaaMG52LsHdLsmq0MZFaL33lXORo0UyD08Z
	sFp5b0WmC1gPtNrfKcJE0vRn8fydIcTXJO1ZI/vIZvLcxEW90s1mm7MK07wNzN581D1G2e7i+zn
	Uv7qM6SwVVD/eLFx8auo3zkvOsfz2o2dnsAVWhQ==
X-Gm-Gg: ASbGncuNrNJ9MvRw6k0WuKfMrpwx7rGAnBfqmoY7u7Kd5nTwGRpVqobTEWPup3Wln7L
	HucFqRpCH2WYbPf7yY5LlIloAeAfKf9s86yiXNQ==
X-Google-Smtp-Source: AGHT+IGjA8GxzlSA8KFH0d0hBiBBngZllvcBocV65KJiYMKqlPEJZboRJyLzU9hLJ3UojFIKhaJB0r5JNmQHXxjuR1I=
X-Received: by 2002:a05:6902:2781:b0:e39:921c:e421 with SMTP id
 3f1490d57ef6-e3c8e6ffa5dmr641079276.7.1733881707638; Tue, 10 Dec 2024
 17:48:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com> <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com> <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com> <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
 <b5f70481-34a1-4d65-a607-a3151009964d@suse.com> <9ae3c85e-6f0b-4e33-85eb-665b3292638e@gmail.com>
 <cfa74363-b310-49f0-b4bf-07a98c1be972@gmx.com> <Z1eonzLzseG2_vny@hungrycats.org>
 <08082848-9633-4b3c-9d9d-6135efab8e2d@libero.it>
In-Reply-To: <08082848-9633-4b3c-9d9d-6135efab8e2d@libero.it>
From: Jonah Sabean <jonah@jse.io>
Date: Tue, 10 Dec 2024 21:47:51 -0400
Message-ID: <CAFMvigepXThcYt0W3fm9vmN3jXC8TaNSEGf-1HKzF5=9S0Z0UA@mail.gmail.com>
Subject: Re: Using btrfs raid5/6
To: kreijack@inwind.it
Cc: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>, Scoopta <mlist@scoopta.email>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:36=E2=80=AFPM Goffredo Baroncelli <kreijack@liber=
o.it> wrote:
>
> On 10/12/2024 03.34, Zygo Blaxell wrote:
> > On Sun, Dec 08, 2024 at 06:56:00AM +1030, Qu Wenruo wrote:
>
>
> Hi Zygo,
>
>
> thank for this excellent analisys
>
> [...]
>
>
> > There's several options to fix the write hole:
> >
> > 1.  Modify btrfs so it behaves the way Qu thinks it does:  no allocatio=
ns
> > within a partially filled raid56 stripe, unless the stripe was empty
> > at the beginning of the current transaction (i.e. multiple RMW writes
> > are OK, as long as they all disappear in the same crash event).  This
> > ensures a stripe is never written from two separate btrfs transactions,
> > eliminating the write hole.  This option requires an allocator change,
> > and some rework/optimization of how ordered extents are written out.
> > It also requires more balances--space within partially filled stripes
> > isn't usable until every data block within the stripe is freed, and
> > balances do exactly that.
>
> My impression  is that this solution would degenerate in a lot of waste s=
pace, in case
>
> of small/frequent/sync writes.

In the case of SSDs, I'd also like to avoid the need to run balance as
much as possible so I don't think this is a good solution. Just more
writes that contribute to wear.

>
> > 2.  Add a stripe journal.  Requires on-disk format change to add the
> > journal, and recovery code at startup to replay it.  It's the industry
> > standard way to fix the write hole in a traditional raid5 implementatio=
n,
> > so it's the first idea everyone proposes.  It's also quite slow if you
> > don't have dedicated purpose-built hardware for the journal.  It's the
> > only option for closing the write hole on nodatacow files.
>
> I am not sure about the "quite slow" part. In the journal only the "small=
" write should go. The
>
> "bigger" write should go directly in the "fully empty" stripe (where it i=
s not needed a RMW
>
> cycle).
>
> So a typical transaction  would be composed by:
>
> - update the "partial empty" stripes with a RMW cycle with the data that =
were stored in the journal
>
> in the *previous* transaction
>
> - updated the journal with the new "small" write
>
> - pass-through the "big write" directly to the "fully empty" stripes
>
> - commit the transaction (w/journal)
>
>
> The key point is that the allocator should know if a stripe is fully empt=
y or is partially empty. A classic
>
> block-based raid doesn't have this information. BTRFS has this informatio=
n.
>
>
>
> BR
>
> G.Baroncelli
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>
>

