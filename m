Return-Path: <linux-btrfs+bounces-15212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF5AF62DB
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 21:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B9D521EE9
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503922F5C43;
	Wed,  2 Jul 2025 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QUHkN5Iy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E02D46AE
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751485903; cv=none; b=JSqDZipT1Ty3JFjY23CIlWg+gtZsNVeGdh3cuqYZjCOuz+jetUN8RdrDS1RhB5coy1Sqz2vqJjRoZ8NwwfGPZ6eA5ecJc7oaKFP3S7VuON9rOOZn9IoXC/OuEDHDZLysY0ahbFYv+ypu9BX7vIrVOGwYmC9P/KlGd1uYfVoYSkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751485903; c=relaxed/simple;
	bh=s084wtR88k+Zm0T48J86wDm0Hr7gnC1awK4eSCCArW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaG3KN4MvylhkEzlcRIel5V0TYwpxBA1Ppwen+TL/d0eiYs+LnDf6HNEUlncJLcUX9TItIVJ6ku9NmQ3lov/KsBQr/6rGxFE8uxA5xW2MNY7ZOB+yTcgF0SiA1xzFkJhJU78Nr2SKICCaNUrel9VXTQwM0WPCv+Zq9QxgF7sExc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QUHkN5Iy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2369da67bacso7509775ad.3
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Jul 2025 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751485900; x=1752090700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FztTel//e5oyaa7vSr+Ve5ZZ9B/kFDNC6EmcHFeFbgE=;
        b=QUHkN5Iywct1or5wb2t3ssdRk8eTVsaWTmsS4Ap4npa7wXD47/p1UC8VpWb7s/t2pk
         jWUU0xjgQdLmyVbtVcsOBKatgYYT6keeN8X8E0812GQ/wC+iWbxzPTzGwL6dIDL+NHrN
         hzJO3Q7ibV0Hi0MrNNcHnrIwfWxT6gGKs/EvRVgSu/doAFCHmCsyQ6Il5307C4hu/JGu
         leDzC1nNzwrSesoWI/JtgcfiDgUWCldox/r+vXzmS2EM0na8OB4SFSILY7Q4PAGVLis+
         RnsMFvcp+rm4FhqTIe6bD+YAJuhyX9mRvt0Q15/Oxu+ocxqx68bd7dywHEaZp8RWp7g4
         oVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751485900; x=1752090700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FztTel//e5oyaa7vSr+Ve5ZZ9B/kFDNC6EmcHFeFbgE=;
        b=I7pSqz9tSjR2zgY+phOM/AuQlBQ3wxuZJtpX7G4Yky2OahMjR0k9heHGxQpA8X4G9W
         WAl0Csukfk/1864hv86g7ZgTd6VjbqL89WJpwkmVHartZg/uEjupxzHY8HlSqxG+mPhk
         JqOb3qiAa94MkAT5a99v4mVUsCpbS68HgAJjhYRPA9AoLtjHUsnal4aUno07j24tJfZ1
         aTH21R0uMcZrxfjZNuoEtMW3aJJcUIBy9UCuOsMM99ljfH1n7Q80rx9SUx3+YegeUiIn
         Df4lp7D2RORGqrwkEtyEP0YrlZcIq7WoFepY+YqAtvCeoARJLyEMexkE5ASssMwybLVh
         UQsA==
X-Forwarded-Encrypted: i=1; AJvYcCU6INp/r3X1Qc3HKX1wez4YhRBjczfqTmaOC/k0M7vVBOT0mNqgi8JndS3px5lf52d7dI0o8Rt8Fq8Cig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzkqORf20q9OYuchecCmbeNh4FOu5lXrqvDboMCgazOLer9vJ0
	m6iCZixMikO+KkgzHo3uvePbJ7KH1GzfQ9alC/sK0usie3H3c9syEb+dxNyPzJ67WmzHixgdTW+
	a1dvy4aad8fZV9CHuccIMw4vSK1twvfxlqbrq57ppag==
X-Gm-Gg: ASbGncvOI0Vs1W1Ot4rULRp+gR2f/88RsBpPMJgaTPl5P/Xv6atQQhn8KuMIas/wwKO
	qxWaObmVTnvwho+jKCAvEMASPL5H982JGNr+VFlQzzjW2eSJqw9tInfZtY1G8a3c1+NsLwC8rkW
	vK+lnGVxpHQPfr/63BYy5M7Eb3xIcaqVS8n32Bo3jsw9Q1tNQ3L125Vg==
X-Google-Smtp-Source: AGHT+IHzKax4rWzgTagFExREvUdZKzP7gz6GIK5OKEX/A1gv3DbccqXrJXg9Q79q2ToGLz5xqYGJ7FpbAJTwCWI+3ts=
X-Received: by 2002:a17:903:124d:b0:23c:5f36:46a6 with SMTP id
 d9443c01a7336-23c6fcea87bmr20535465ad.12.1751485900234; Wed, 02 Jul 2025
 12:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619192748.3602122-1-csander@purestorage.com>
 <20250619192748.3602122-4-csander@purestorage.com> <c83a2cb6-3486-4977-9e1e-abda015a4dad@kernel.dk>
In-Reply-To: <c83a2cb6-3486-4977-9e1e-abda015a4dad@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 2 Jul 2025 15:51:28 -0400
X-Gm-Features: Ac12FXzYvCEJprNA84OmEAiR_yc-BbACnKsWI1JFO0q24cJQIzcr5F8BHED8eZ4
Message-ID: <CADUfDZr6A51QxVWw2hJF6_FZW7QYoUHwH-JtNEgmkAefMiUjqQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs/ioctl: store btrfs_uring_encoded_data in io_btrfs_cmd
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 3:06=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> > @@ -4811,11 +4813,15 @@ static int btrfs_uring_encoded_read(struct io_u=
ring_cmd *cmd, unsigned int issue
> >       loff_t pos;
> >       struct kiocb kiocb;
> >       struct extent_state *cached_state =3D NULL;
> >       u64 start, lockend;
> >       void __user *sqe_addr;
> > -     struct btrfs_uring_encoded_data *data =3D io_uring_cmd_get_async_=
data(cmd)->op_data;
> > +     struct io_btrfs_cmd *bc =3D io_uring_cmd_to_pdu(cmd, struct io_bt=
rfs_cmd);
> > +     struct btrfs_uring_encoded_data *data =3D NULL;
> > +
> > +     if (cmd->flags & IORING_URING_CMD_REISSUE)
> > +             data =3D bc->data;
>
> Can this be a btrfs io_btrfs_cmd specific flag? Doesn't seem like it
> would need to be io_uring wide.

Maybe. But where are you thinking it would be stored? I don't think
io_uring_cmd's pdu field would work because it's not initialized
before the first call to ->uring_cmd(). That's the whole reason I
needed to add a flag to tell whether this was the first call to
->uring_cmd() or a subsequent one.
I also put the flag in the uring_cmd layer because that's where
op_data was defined. Even though btrfs is the only current user of
op_data, it seems like it was intended as a generic mechanism that
other ->uring_cmd() implementations might want to use. It seems like
the same argument would apply to this flag.
Thoughts?

Best,
Caleb

