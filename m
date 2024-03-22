Return-Path: <linux-btrfs+bounces-3516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03028874ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 23:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5778AB22BBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 22:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2835F82898;
	Fri, 22 Mar 2024 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="PHwrZpX/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933B82877;
	Fri, 22 Mar 2024 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147821; cv=none; b=OW3P4tss7U0Cf0dE9CsASPgdG1jRwKQXpOYk8KwyjtoI5y3kX8VMN4vLu1k2gMUHjSJ1zlVB85L+HYpx/Ww03CETZ84v7qTYTHg9aaHztQwdyic059B8Lb5qiPJxAz8kR9GVaSK9mBlW1C1cCvkZxoCZxTRwgjKsM4xoYa4tXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147821; c=relaxed/simple;
	bh=ZFlaPdt559uAs47oc6IE0gQK6MnRp7l3qSAbJoCMdIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0C9WsDZsDxu+fVvjwBaBSjbKFZvWyq4nOVgagnoXDPHJfeLuevd9WFpGjFJWA+/sLYXDhMjcnSJj+a7gWTjkYTUCu2lFicnnF82hY25yJuON//llLq9NfzVw32JF6oirJ4jUVFkyN6HQTJ2a4QBXPgpFuniG4qinY46kpPz4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=PHwrZpX/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6904a5d71abso14377096d6.1;
        Fri, 22 Mar 2024 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1711147818; x=1711752618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlLyuQSpWDKF2CPWLpjsrssa+zzqFuorN63Va35uQ8I=;
        b=PHwrZpX/y+MpQl8c+qGXSzVZftvMUMj58IJo/+o8kjzu2gslEZXp3T8GOMaaS7EMeV
         PzhDeMf7m8mqAUl30/EcKkVaYKFb50N6uWcVQ0ZCDHluD8fHXujZWiQUuSouKxksA1oZ
         Y+ZnLi7HYB8IXs4C4+cM9mzlJXD7n2tmkuOsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711147818; x=1711752618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlLyuQSpWDKF2CPWLpjsrssa+zzqFuorN63Va35uQ8I=;
        b=UpzjgG3WG6W0xxRfvSWUJrzz8+2h6+8jHfIr/46ou5pOMSyNKZGyxS8VQyHIKTQqu5
         OEl0NBhpYZ7SDtzPeV5dJA/1YvqXUQELQrZg0VTfrOvZMu9mUen6b8VSp/kthyMG/NB9
         OWsV1Xi4cTLIloZ856M5WBf3UZxqHKY3irmAKFWbI7JZm96Jz9rRnwU+o1VP01Neebk+
         /n1ur1kNEeDjYxNnKT5cPgFx1gmpFx4W7fSmsq5+dP6cueZwePLFDEM4/Cjg5b2YJePQ
         oVA95mZjDq0zWVNmTBTb83ZeXMw2TSTymE9qvWOmq3BQRLwn86OdkmO3r7dh7Z1r/oNj
         HkvA==
X-Forwarded-Encrypted: i=1; AJvYcCXdmZR75ALvdXVM3QCyPQEkyU/5PYcs658WRqHK3NiDhpWRa0UsL7XsWQsR2h2h6J5xP28YqdQJS4sn+Fin8nSnxVFip96IK6FfzKgF
X-Gm-Message-State: AOJu0YzWSAXCPW5GbQWznVkY3G69KCf2SoBUSxuSSd4ZUnD48rsX+cyp
	QDaMw90nwJpqi2MnCYhf7HbcT7+XPAPOshr9MRBdFqVMq4f/vnXj9ShkPMTT5+qVbKAEOmCgA8g
	ZoxNMTo8xeiOssq+z9QnZ5oZVuD8=
X-Google-Smtp-Source: AGHT+IH41iAEFxxMNpI5XNoJ58+JMEcq1MPkfYHvrPwq6W6mheqBkoCPtL32doCFSKmyOvmTifLBW3O4HnhE8+NcEG0=
X-Received: by 2002:a05:6214:2a86:b0:691:3c21:2c11 with SMTP id
 jr6-20020a0562142a8600b006913c212c11mr1251149qvb.26.1711147818301; Fri, 22
 Mar 2024 15:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ca6e688950ee82b1526bb3098852af99b75e6ba.1710551459.git.tavianator@tavianator.com>
 <20240322192108.GK14596@twin.jikos.cz>
In-Reply-To: <20240322192108.GK14596@twin.jikos.cz>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Fri, 22 Mar 2024 18:50:07 -0400
Message-ID: <CABg4E-n=iWjM3K0dvrrwQ9BOEiqTawJ4YUVL6RPWaq2DT2AKvQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Fix race in read_extent_buffer_pages()
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:28=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
> On Fri, Mar 15, 2024 at 09:14:29PM -0400, Tavian Barnes wrote:
> > To prevent concurrent reads for the same extent buffer,
> > read_extent_buffer_pages() performs these checks:
> >
> >     /* (1) */
> >     if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
> >         return 0;
> >
> >     /* (2) */
> >     if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
> >         goto done;
> >
> > At this point, it seems safe to start the actual read operation. Once
> > that completes, end_bbio_meta_read() does
> >
> >     /* (3) */
> >     set_extent_buffer_uptodate(eb);
> >
> >     /* (4) */
> >     clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
> >
> > Normally, this is enough to ensure only one read happens, and all other
> > callers wait for it to finish before returning.  Unfortunately, there i=
s
> > a racey interleaving:
> >
> >     Thread A | Thread B | Thread C
> >     ---------+----------+---------
> >        (1)   |          |
> >              |    (1)   |
> >        (2)   |          |
> >        (3)   |          |
> >        (4)   |          |
> >              |    (2)   |
> >              |          |    (1)
> >
> > When this happens, thread B kicks of an unnecessary read. Worse, thread
> > C will see UPTODATE set and return immediately, while the read from
> > thread B is still in progress.  This race could result in tree-checker
> > errors like this as the extent buffer is concurrently modified:
> >
> >     BTRFS critical (device dm-0): corrupted node, root=3D256
> >     block=3D8550954455682405139 owner mismatch, have 118582055676422943=
56
> >     expect [256, 18446744073709551360]
> >
> > Fix it by testing UPTODATE again after setting the READING bit, and if
> > it's been set, skip the unnecessary read.
> >
> > Fixes: d7172f52e993 ("btrfs: use per-buffer locking for extent_buffer r=
eading")
> > Link: https://lore.kernel.org/linux-btrfs/CAHk-=3DwhNdMaN9ntZ47XRKP6DBe=
s2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com/
> > Link: https://lore.kernel.org/linux-btrfs/f51a6d5d7432455a6a858d51b49ec=
ac183e0bbc9.1706312914.git.wqu@suse.com/
> > Link: https://lore.kernel.org/linux-btrfs/c7241ea4-fcc6-48d2-98c8-b5ea7=
90d6c89@gmx.com/
> > Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
>
> Thank you very much for taking the time to debug the issue and for the
> fix. It is a rare occurrence that a tough bug is followed by a fix from
> the same person (outside of the developer group) and is certainly
> appreciated.

Thank you!

Sorry to nitpick, but the paragraph you added to the commit message
[1] has a typo:

> There are reports from tree-checker that detects corrupted nodes,
> without any obvious pattern so possibly an overwrite in memory.
> After some debugging it turns out there's a race when reading an extent
> buffer the uptodate status is can be missed.

s/is can/can/

[1]: https://github.com/btrfs/linux/commit/402887e0e9ad76d72496aefebd37bd72=
9748be79

--=20
Tavian Barnes

