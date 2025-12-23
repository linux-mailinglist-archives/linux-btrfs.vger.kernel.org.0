Return-Path: <linux-btrfs+bounces-19991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6353CD9134
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 12:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6CBD30139AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C22E32E737;
	Tue, 23 Dec 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDQfwKNY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791422DBF76
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488794; cv=none; b=j9G48w/qPumSYjpmidkifbyVAKvneFLjUjqudnX4VyHBl/qS96rmORir1p8OWnrVk8n7UqxOEE6kxwuDi4jyz/OvdE98xl04bP1doG54xT5Ee3ymsw/KNMTZzbUOBEo6+/YOTqyneWnOJGSRT2Zsy039wG62Orfg5UrdkOeRDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488794; c=relaxed/simple;
	bh=mefPhnE7/MfDUe1T8pAHF4jmEpt+Uc81I28S4plP9wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRVDrQzqtnoL9njQu06add5rO7coC+uX3AaE3vleNEmq5Da9QxIdyrfDz4VDU8+6DVK746pX72HzxmOxgZvgjNqnMkaSuMIfilMS35tcxMaT9sewLbrwZ1j7D5jSTUEe86Eq9pu0qWGwlcFQK2FM4z35YT+YrNsWWaH0csthlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDQfwKNY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so5172506a91.1
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488793; x=1767093593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqU7V+l2BY9L+TNaDU6SPd0c+MjIvW45CoFhBkBL3Pg=;
        b=DDQfwKNY7yAND45qr/vCOcTdwCdhaNEkPkpncwQihwyahij+l+fvnuva/pX0EYMctd
         DDitdBb6Qh4qXMz/8tPemrpdPgsdEo/1dQcwBEURbNEFexeBJDX+NSVb+IR8k3zC6Kzb
         6HHNC/R1o+IU8xwX7d8l9jG0O3wg03AFBkep1q5Z/r4xctJ03rWu++zbAKYzXdl34j4Z
         CKqycxANs3umx4ajs27IBn9GT3QHxTl7jDDBzm7JkpfyowfMMkAE9dMkhFFxkmdZPYnD
         VSufYqAbIQAL1rXW5sLZOol9aHnZDeQRNG83lVJoRSoIIq3vuE5nz9iK0EXE6jGD+JmF
         3/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488793; x=1767093593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqU7V+l2BY9L+TNaDU6SPd0c+MjIvW45CoFhBkBL3Pg=;
        b=XW/sHVe2BKP41kcWfLDpLQAQjiNUoNk9YtwcLe2I0VHjypCwHSuVv7etYLE5P9Mh7N
         CZAb3Sd38KrjmGMN+yOvl0TXza9jO/OGPvw3VW0o6rdWL35VZYIsrRfBN0SZ/r50zkoC
         KXlR6hwXYBafHRbK0MChsQ2bpgoaxJCm/eQFxjMIL2nW84nCHUBEqKUOb4+Wn9ixhbkx
         IQzPySOp1FVRLfR5taOxzHqe25XE5nv2wOmFZr+B+e1Po29KUxxrFwRXsbcUlR4/jlZX
         sRKtHw3BYFSWQv2chOnNBE2yGMjwKOlYCM+jrBZV05RqOHZLkY5KAKZquttT4xHTzI6h
         nZMg==
X-Forwarded-Encrypted: i=1; AJvYcCWMWTShr7UU773HkMcBTj+uTxbSlDcaaBNN87hLoO03ZZf6Z5gaW0e/nqox/HAVyT/C0Yn+xAE1gGgGlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dbCrd+Aw0JzEh+Efy/sESTcdvW7khVsI2JrlpB6uCJBXNy5o
	sr+f5GSPBIJ42pNAgcddufeapjs09zgsOCyAk4YEUb273Ld3crS1jv5ujJhp8e73q+V3VsbCZq9
	2LPV9p8zBcq2vXiODY6Deq04F/fr/m1E/qA==
X-Gm-Gg: AY/fxX4Ht7vcGtYwF4fgDe69UJxNF7wYmo7VdkfRFlr+IU2SU+1tvcj80/ZNc+cXaZF
	7JzladIeYSOa7nWOAqviYlmv7D4WGWNkxnI+HJ93/SCpGVdOZsIzZtwvR1e1y3BHkMYAydNNAgS
	kZIaqipFed2QffjVr5UkD0Ybl6FR+6nu03E8+0RzTyeRzbNRarY7gxlrqPTcaWbWVp8nFm/P4cs
	DLCAF+itFWTU3xcDe6qxLKN/96yUJJbpPn9JVBVfs+8u6arzt4euw641RTzMx2a9CGv6Yh3cdpK
	wwCp2bA=
X-Google-Smtp-Source: AGHT+IEGpKm5mkGd7xNkM3G9d9Vu/xIpakL2UXM8a2+v6j2nhyhyxWDS/eNhCBXVd/riCnz+RlWMRR8xLG9Sb/sjYPs=
X-Received: by 2002:a17:90b:52:b0:34c:94f0:fc09 with SMTP id
 98e67ed59e1d1-34e92139d60mr11861990a91.10.1766488792552; Tue, 23 Dec 2025
 03:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <79ae6c26545c107010719ee389947c1c@posteo.net> <20251223125647.6626b266@nvm>
 <1403c713e107106e18e000d7b0f81eaf@posteo.net>
In-Reply-To: <1403c713e107106e18e000d7b0f81eaf@posteo.net>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Tue, 23 Dec 2025 14:19:41 +0300
X-Gm-Features: AQt7F2osS5cy3JONjls6FVpOxyyJcFWtr80NRa74vcW6yoQ0hENJ8Ac0UVsAK8I
Message-ID: <CAA91j0XJNaGMyxJegYr7kr+JDg1RRFv9mOcGkwmoDKKk5dDp8g@mail.gmail.com>
Subject: Re: Snapshots of individual files
To: BP25 <bp25@posteo.net>
Cc: Roman Mamedov <rm@romanrm.net>, Linux btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 1:26=E2=80=AFPM BP25 <bp25@posteo.net> wrote:
>
> Dear Roman,
> Thanks for your informative answer. But this is precisely the wrong
> solution: btrfs snapshots shouldn't and in fact don't clutter the
> filesystem with previous versions of the files because such ghost
> versions materialise when the snapshot is mounted.

That depends on your subvolume layout. Nothing forces you to place the
file copy into the same directory as the source either.

> In my original
> message I seek for the analogous behaviour.

It is exactly analogous.

> Also I don't want to
> generate more and more copies...
>

To reference a snapshot (be it subvolume or file) it must have a name
which you must provide. To create a snapshot with a given name in some
location this location must be accessible at the time the snapshot is
being created. As long as this location remains accessible its content
remains accessible. There is no difference between file and subvolume.

If you complain that you cannot mount a single file outside of the
default subvolume and can only mount subvolumes - it is an entirely
different question which is unrelated to how this file was created.

> On 23.12.2025 08:56, Roman Mamedov wrote:
> > On Tue, 23 Dec 2025 00:43:25 +0000 wrote:
> >
> >> Hello,
> >> Can any of you guys help me understand why it hasn't been made
> >> possible
> >> to snapshot individual files? Because technically it's trivial to
> >> implement therefore I suspect there must be some abstract reason...
> >> The
> >> only thing I can think of is the case where some file which was
> >> snapshotted is then deleted hence there is no way to 'select such
> >> file'
> >> and ask btrfs for the snapshotted versions... but even in this case I
> >> see no problem: either the convention is that when you delete a file
> >> then all snapshots of such individual file are also deleted, or better
> >> there is a command that shows all files who have been deleted but have
> >> have been snapshotted in the past.
> >> Any ideas?
> >> Please CC or BCC me cause I'm not subscribed.
> >
> > You can make "snapshots" of a file with:
> >
> >   cp -a --reflink filename filename.snap
> >
> > from what I tested this appears to be atomic (entire file is reflinked
> > at
> > once), someone might correct me if I'm wrong.
> >
> > Works on modern XFS too.
>
>

