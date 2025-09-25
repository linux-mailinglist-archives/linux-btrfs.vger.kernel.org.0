Return-Path: <linux-btrfs+bounces-17191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919A4BA0F0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 19:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5CF2A4883
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9EE30F937;
	Thu, 25 Sep 2025 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFBgya4P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995627FB35
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822526; cv=none; b=nG/2s2sKVloraasmtRDSP0WFJkTI/ZYRPbKbGwbZpO2UJQRuKxizGckMguoBClRDbU9KiBbE6MNjNWWKyJuNpCuwI0wg6f/CcK1jDJ1d4pgtuYgi8G/zS8dvx/0ZXcW90u98Esmcj1X0VB+ysL/SsuyrUi9ZJ7N97UDKCCwRMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822526; c=relaxed/simple;
	bh=7zrdKHhlppiRPY8Wgp0eX6coVCqDsIp1DQXVBqI4RfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZ8fSNRuNupRNk9gH7Oc0z6rOBh5Qx1HUrIPRDAlwnhnJ/gYWUzBtsP7L74ChboS4okoGayVRyKriWc4Ceg62gQKLQp1PvkOD1yraXrB4M20kWH3RhVBFnf9nXrmsuTuJFYSqnElxmHgkeQLYawPmYtMd//kco5G5p/K93GWK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFBgya4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A70C113D0
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758822525;
	bh=7zrdKHhlppiRPY8Wgp0eX6coVCqDsIp1DQXVBqI4RfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UFBgya4PlbelUDE316mGiiXiSnVPMB1+Zk0rpHK2a9OhizhrXJ8iap3qEjX/P/Ogw
	 MI5YCXYyUL2oV0eiNBhs2PcBWr1b/Ybmph+zcK8oiUuHxhazGA2EecfDgq+fLUSqLn
	 8qn4wZQRyIDNNC8Oa3jVUKU5kXGE3PzEgT1dK297TPt1N0WxfS7xxr6OfPWP58NClz
	 2le/VNBML1s9pqN/rMAMdWvcjfHFD10RY1AoyojbL4dOHmmuK2LmB3/s8HLoeRV01H
	 30OC4E1soYmIMNfHDTBR+tjv/8E6vze1LOKTVWXHJbvac1FBO8ejTH9frV1pnuCnY2
	 ylfMtwUyBAOOg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b2ac72dbf48so234808766b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 10:48:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTo8RTkm1LGJN/mK9G3WNnYffmOAMTQOhPp4Eor7sHTovfBxvcNhXVZWM0LQC6uuaY77DA2Qi2qyXqkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHyBdv9gHOV7fbCIcGwkwUlDEqqmDGE2LPB3X1raDiBvwYOUE8
	N4swNg9e5N5D2i5Crdzib4yQ4PHlHn1MK8CXmjFaE2HfW84CXxlCCyUqT074eUoK+dUhSEKpJie
	LaHjq1N6pbV0up5TdY1uGEpec2LHlW8E=
X-Google-Smtp-Source: AGHT+IER3LKaqqQhCWgv03UaWEfeDgNEu+ODWtuGJMhOfztOvKHFFxQFcOiF/eO1wanfCdpiD5Udn4cS0Fb644bRIYI=
X-Received: by 2002:a17:907:6093:b0:ae1:a6a0:f2fe with SMTP id
 a640c23a62f3a-b34bad28537mr487948366b.36.1758822524523; Thu, 25 Sep 2025
 10:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925145331.357022-1-mssola@mssola.com> <20250925172529.GA1937085@zen.localdomain>
In-Reply-To: <20250925172529.GA1937085@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 25 Sep 2025 18:48:06 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6860uRYyT2O9wRA99pD_MqFKdu=-tTngSJReM5hGNZwA@mail.gmail.com>
X-Gm-Features: AS18NWAmKAgr3UKJioHbpmnALU4HD6lsuoPSxEeyBqYnyq9OGprJk1M7tZs5i0Y
Message-ID: <CAL3q7H6860uRYyT2O9wRA99pD_MqFKdu=-tTngSJReM5hGNZwA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: ioctl: Fix memory leak on duplicated memory
To: Boris Burkov <boris@bur.io>
Cc: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>, 
	linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:25=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Sep 25, 2025 at 04:53:31PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
> > On 'btrfs_ioctl_qgroup_assign' we first duplicate the argument as
> > provided by the user, which is kfree'd in the end. But this was not the
> > case when allocating memory for 'prealloc'. In this case, if it somehow
> > failed, then the previous code would go directly into calling
> > 'mnt_drop_write_file', without freeing the string duplicated from the
> > user space.
> >
> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>
> LGTM, thanks for the fix!
>
> One thing though: I don't like the label names. I think with multiple
> cleanups the best way is to name each label with the cleanup it is for.
> Once you have some named ones, "out" feels unspecific, and encoding
> every single action like "out_sa_drop_write" doesn't scale as you add
> more cleanups, so it's just not a useful pattern. It's already quite
> clunky with just two.
>
> If you fixup the names, you can add:
>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > ---
> >  fs/btrfs/ioctl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 185bef0df1c2..00381fdbff9d 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -3740,7 +3740,7 @@ static long btrfs_ioctl_qgroup_assign(struct file=
 *file, void __user *arg)
> >               prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNEL);
> >               if (!prealloc) {
> >                       ret =3D -ENOMEM;
> > -                     goto drop_write;
> > +                     goto out_sa_drop_write;
> >               }
> >       }
> >
> > @@ -3775,6 +3775,7 @@ static long btrfs_ioctl_qgroup_assign(struct file=
 *file, void __user *arg)
> >
> >  out:
>
> call this free_prealloc
>
> >       kfree(prealloc);
> > +out_sa_drop_write:
>
> and this one free_args


Rather than adding yet one more label, which over time has proven
error prone, I'd rather have a single label.
Just the existing 'out' label and then the fix would be to replace the

goto drop_write;

with

goto out;

kfree() against a NULL pointer is safe.

Also, missing a Fixes tag which should be:

Fixes: 4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding
a relation")

Thanks.

>
> >       kfree(sa);
> >  drop_write:
> >       mnt_drop_write_file(file);
> > --
> > 2.51.0
> >
>

