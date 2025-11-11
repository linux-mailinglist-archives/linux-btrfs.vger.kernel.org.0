Return-Path: <linux-btrfs+bounces-18861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFE0C4D8C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 12:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA27A4F7683
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A3351FDE;
	Tue, 11 Nov 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kedGt62l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305A2F8BD2
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861669; cv=none; b=D5K6EcExlwR4/ZngEcz53YDl/6IeW4iiIZybIld0PVDjSQk21g/bTFpvKNtxTZeHbyCgYl9zx2cDZ8xfPDFpR31yoLOETL9dlx4cCamejO868zc51QDX2MrKn726qRt2VDkfhKNYwH2G4SN1G2Io7mgmmeSOfYiYcfLKK6yWqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861669; c=relaxed/simple;
	bh=jhqtP7s3J6aXUrsWY8SH4BcYvf5qE7GblQujzK699wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeXA/Rz/m9Rp4axuvPUMCshRkE54x4NZPdytmsG4U9injMOSfCDnOumyCeDwn7rNINsgqvwuMR9jGZVZQ7epZ7gZE68JqT7xySeuLiOq4O6thmTthswf0joMx6c/8lXBho3xVXDTyz4dlkd72PmfieTYzc2H0CENrlwI91dGnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kedGt62l; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso3571235a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 03:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762861666; x=1763466466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y/CoERQP/gGJ1rgb0QyOuyq2NoruU8Gd9wvvvICRo8=;
        b=kedGt62ldvN4v2vAxqdPzD0PeRYq+puEI1PlzsiE6hYiLMw7BiKre47WRdDZjc+/wc
         TO/RVIv8XdHBTLluK9aiRF3PMYl9B35gp92gifjk41QkKy3mr1ckJBGlEE98A/pyD2oT
         mHvN2Q2FFQyT137UkIAKRzR9VVVH/60840wCCH9mQtDRSRSBWr4V6T8iNqQT90mPzfZN
         E7REPmmsC97EUZ2mlHJPQCLkk/oUQNZfKAjQJAH0SgSTv1A2AZ5ATrbCU/Vexq/df4Jj
         4AnaZ1xKpMyfaaB1ILLYpyWffCHBH3B/lPgmDcdwq9fUseRoa4ElpZVhivvfEQFLthSO
         B2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861666; x=1763466466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8y/CoERQP/gGJ1rgb0QyOuyq2NoruU8Gd9wvvvICRo8=;
        b=LuQdjhZxtq5gjRW0sHgQLA8XBGqCwO77xy5I0Fza+mLQBvvf93VCFGaoGLIZbtY1NW
         Qj2cETTU+jwbXwTf41u7/oXPrVmBZUD6GHDz0srI9fyFEVSwthhgeEU7nOM0tZwDt/AZ
         tyD5K6Q9VdNEog1bDl2F+weHcl1S6s00PuC356K3keayk7VMDsAvC9YDwnZdoxqyF91Z
         D3tP5HfYUpCLUawIcWIKlcm1W3XKFgVLJZH/nzXGeDJfG2Slcv8kgdfgAK55IsnO0Ozq
         p8kmRDPMBRxRiPp6FuAUVMQZxLed3/jyclJH46LRUg8sT5knmL7xX/qULFy7Z3yLdu9F
         zdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwtyuY5fC7swEnRJ+8xVVBT6gZG2QnL4QePa2kRVSuVQyS+aSYM8r+LtVBCQQfaWESVB9wBMlR6XYyfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSlbinvmDtGHSkvZfaZSaXxKBsKyOdEJiBlo+IZhoyudSmQtjI
	PU73HZeujZlWOWJybuWG+OB39XzCbV0pKTBGJv05feFuf/biGiPqhajDx8NMGAbMinWBxVf0AcX
	AER/9mMSe3oS8dA2jZ4UVIclwBgSsdBk=
X-Gm-Gg: ASbGncsm4Mnuj9nSLWysdIxZF/hejMeBg73BejFU+moP+v4zLzsETWhofWmd0HGd73J
	bxKuq2TCCWABpi9kQGVCDX4SDDH7jI14lGRThjkgh32shZ91DR5Cn8aduQqaksX6vkG6iZR0WwI
	VSv7Y9VvsYAZb05nZ4lvL5jzXB0aTgRKiGwXsejqbDCQ8d1j1qnZUi98hTf83OzIkSjC9hDlaUY
	yUq1xd/4LVBKfZnS6wmzli78E6yHd/wYautPBdY/DsSYNapGwmNrXO873sxC5DLaoKdx5VlqFgT
	qlMPIQLvpoFeWGgCmCRXU8rQIQ==
X-Google-Smtp-Source: AGHT+IHPgX7/cQUS/SIkRBOM8pcz3hJsiOAlFjo0Fb0yGdPgC0U7mQuUxEs+ewdADJ8NOEpX3yO5a/UCUe9UhwbXEp8=
X-Received: by 2002:a05:6402:27d0:b0:640:c8b8:d55 with SMTP id
 4fb4d7f45d1cf-6415dbf4b40mr10417786a12.3.1762861665470; Tue, 11 Nov 2025
 03:47:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107142149.989998-1-mjguzik@gmail.com> <20251107142149.989998-2-mjguzik@gmail.com>
 <20251111-zeitablauf-plagen-8b0406abbdc6@brauner> <CAGudoHEXQb0yYG8K10HfLdwKF4s7jKpdYHJxsASDAvkrTjd0bw@mail.gmail.com>
In-Reply-To: <CAGudoHEXQb0yYG8K10HfLdwKF4s7jKpdYHJxsASDAvkrTjd0bw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Nov 2025 12:47:33 +0100
X-Gm-Features: AWmQ_bmVl00-gq76dJA6KDpo9yPluWXIzE9z1CQp_8ryN3rR25PxN1oBL_2n39I
Message-ID: <CAGudoHHGvXsks+V2Gd0dr66idZdM9bJFriHrqzx5z_vfA9CA0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: speed up path lookup with cheaper handling of MAY_EXEC
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	torvalds@linux-foundation.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:51=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Tue, Nov 11, 2025 at 10:41=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> >
> > On Fri, Nov 07, 2025 at 03:21:47PM +0100, Mateusz Guzik wrote:
> > > +     if (unlikely(((inode->i_mode & 0111) !=3D 0111) || !no_acl_inod=
e(inode)))
> >
> > Can you send a follow-up where 0111 is a constant with some descriptive
> > name, please? Can be local to the file. I hate these raw-coded
> > permission masks with a passion.
> >
>
> #define UNIX_PERM_ALL_X 0111?
>
> I have no opinion about hardcoding this vs using a macro, but don't
> have a good name for that one either.

Apart from usage added by me here there is:

fs/coredump.c:          if
((READ_ONCE(file_inode(vma->vm_file)->i_mode) & 0111) !=3D 0)
fs/namei.c:      *  - multiplying by 0111 spreads them out to all of ugo
fs/namei.c:     if (!((mask & 7) * 0111 & ~mode)) {

That's ignoring other spots which definitely want 0111 spelled out in
per-fs code.

I would argue the other 2 in namei.c want this spelled out numerically as w=
ell:

          =E2=94=82*  - 'mask&7' is the requested permission bit set
          =E2=94=82*  - multiplying by 0111 spreads them out to all of ugo
          =E2=94=82*  - '& ~mode' looks for missing inode permission bits
          =E2=94=82*  - the '!' is for "no missing permissions"
[snip]
          if (!((mask & 7) * 0111 & ~mode)) {

But then it may make sense to keep this numerical in the new code as
well so that anyone looking at lookup_inode_permission_may_exec() and
inode_permission()->generic_permission()->acl_permission_check() can
see it's the same thing.

I figured maybe a comment would do the trick above the 0111 usage, but
the commentary added at the top of the func imo covers it:
   * Since majority of real-world traversal happens on inodes which
grant it for
   * everyone, we check it upfront and only resort to more expensive
work if it
   * fails.

All that said, now that I look at it, I think the code is best left
off with spelled out 0111 in place so I wont be submitting a patch to
change that.

Given that hiding it behind some name or adding a comment is a trivial
edit, I don't think it's much of a burden for you to do it should you
chose to make such a change anyway.

