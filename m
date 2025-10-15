Return-Path: <linux-btrfs+bounces-17855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8DCBE0CA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 23:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A58F4E3C2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 21:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E702F49FB;
	Wed, 15 Oct 2025 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T5thXHM8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841312475CB
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563174; cv=none; b=bylE7IiBk24jEZn8V2VCGoZF5vJfyTsCTCiYqYyp8OOFO7sAwdi/lHNTiIZKRNNC/2kdf88N94IX8W/Ar0bvTqSPOGXQ/KB1gvyM7DhM64RAVeoQK4WtpEexzFTS3Q5I9eWiYDPi1+YD+wa3VEXmRLTnfycFqySniSCE3eomxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563174; c=relaxed/simple;
	bh=EU8+XF7TtaL4xwtXRMZW+paU5fQqVXMQyXX8w7H0dyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5VM9j/CioUlhi47H2u2xh3nWAZSA1gnaD2hr2jbLO2iRZak4ygbtpswOooar9UPO7aWw76E3QW5G9PGO1bWGuVN///Rqm9oVCsAzFRInDkxZf+/W62H41t0/71IQtciIjNZXDpxAePQwFfFhTBSBIr8mecfD95+t/oRvQqERfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T5thXHM8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so370055e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760563170; x=1761167970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLx9Zq395CEzG/qQGW7hUhEGsRbIEoCYy692RFkYGog=;
        b=T5thXHM8dlPy3NkA4/sx6jd3kS5kk8/3KBUFpmk7PUAyi1AcPqAmCl4suXuOvK/Jul
         xBpwnib7whQNSaNDsTU+e8Lc0wJ6TUf3cgd19z+ZM6iJ9+Fd51ZYbD0ghlWCkMjJsMrC
         0M6ur+c8814eMFDliy9g/wZn2Y2OmdhATn4zTNFMLzheZ5k5pvI/iSPpb3L97W+XQhWL
         eyK0qUgWD6ZylE07PAjUEztVzxKELuMsRQAbqtD3MvP1KSz9P4Ju5cD6/ZGep5Qi+sfx
         wOQnYFLtKfzZpBpTAbzyQbgZDVZPCgo08qLF9CJAqC4LdjpEYT/WmwtyAVZgLEZ5RXGV
         yYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563170; x=1761167970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLx9Zq395CEzG/qQGW7hUhEGsRbIEoCYy692RFkYGog=;
        b=in5QGrjE1ulk4TKmloJrjrvlxH+HKHHHjRSpiv7frQVS5Fs1o6oZsqHpWrajw+PgHV
         eRD2+jh4E47uHwdxVk21kEMLyApBDNNGPVZNfucq2cyAf8dONelya5eHIWyBOt0/SqB0
         Xj4S1V79ychl9w2y0m6/1kRcghqYOGyVHfnjEj6nDLS9BAlHXg6i36CRc5H2JT424lk2
         ocM7U5DJixXSd1BXcQPRfSEhyu+boda6qEiHJ08wpLWMjIyBiHcVy1X3kPsw6y4Q3iDc
         ozBM0uoJrhaUOCEp8xBRnjCl2h69nITQUvrFsNLgdLGI0hmspLPsLco3DMDBAarZGRqK
         TB8w==
X-Forwarded-Encrypted: i=1; AJvYcCVCx2tVgYRn7PX/uoi1SH52MgppZifi+aRlJFW9mqjCCq77fyyK1Y1Xkb5+eb7POSfT0DOJ7aoxa3/Vkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFmgyavuE/LjOpkmjBdkUe6WI2IHtufzzdaU92mOsRHL5OVsG
	hIpaPdnlm6vgxGRasCbVM4PSASg2amIlW0CoPdnHRj7KvPhewGKz6BOSzAt3Rw5gsxbZYbf4O0K
	GmXCKOsDvxYrq1wJ683ESiXYF0fiYzPiF3BZqWMPeYq+M2KM+JOjX
X-Gm-Gg: ASbGncucKf05lXpDzeJAT89xqLrP443FdhoBucalbS4DbcJqA/Q+TXUqZQEIc+muPCt
	9i3zyLGXpxS2d07DE+BFlcVsDG4q+hFRYlzX/Yr9ErVOm86WvY47egCL2HBlmjntCCxeVvjUhIX
	7i4MPjglCPYHEsiwWG0K7cTAnT3BPS/J3MFHviWgkPDKwJUQfLCdo2LPmmlqAykWC5QzdZ38zo7
	EG4Ozttr8zMefzW6Be4dB19wETU+ODHXAd5gkSIQCcI1prrODGO5bMFipHJvjAWkYGMFQ==
X-Google-Smtp-Source: AGHT+IGCkgy4XtbFUPH71GAnFoknJIGU+6lko/DYaPM3GeJL51HS9L0AZnHRVTd6836KeGTQt1N07lHRDeXDKSxjEvI=
X-Received: by 2002:a05:6000:43c6:20b0:426:f157:47b8 with SMTP id
 ffacd0b85a97d-426f157498cmr4805031f8f.45.1760563169794; Wed, 15 Oct 2025
 14:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015121157.1348124-1-neelx@suse.com> <84dabbbd-1b7b-4d51-b585-d3dcad3fd88f@gmx.com>
In-Reply-To: <84dabbbd-1b7b-4d51-b585-d3dcad3fd88f@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 15 Oct 2025 23:19:18 +0200
X-Gm-Features: AS18NWBL_Qtrnktt2leULVtRo0CapPusfvRkPmbfy6UxceylyvzNqSMiH1hGzdM
Message-ID: <CAPjX3FeuNDtzGRH8EGw3WLsTpOiszDdAVJ6Yv=rkkpjv8qSyzQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] btrfs-progs: fscrypt updates
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 at 23:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2025/10/15 22:41, Daniel Vacek =E5=86=99=E9=81=93:
> > This series is a rebase of an older set of fscrypt related changes from
> > Sweet Tea Dorminy and Josef Bacik found here:
> > https://github.com/josefbacik/btrfs-progs/tree/fscrypt
>
> I'm wondering if encryption (fscrypt) for btrfs is still being pushed.
> IIRC meta has given up the effort to push for this feature.

Yeah, I'm trying to finish it. This is part of the effort.

--nX

> Thanks,
> Qu
>
> >
> > The only difference is dropping of commit 56b7131 ("btrfs-progs: escape
> > unprintable characters in names") and a bit of code style changes.
> >
> > The mentioned commit is no longer needed as a similar change was alread=
y
> > merged with commit ef7319362 ("btrfs-progs: dump-tree: escape special
> > characters in paths or xattrs").
> >
> > I just had to add one trivial fixup so that the fstests could parse the
> > output correctly.
> >
> > Daniel Vacek (1):
> >    btrfs-progs: string-utils: do not escape space while printing
> >
> > Josef Bacik (1):
> >    btrfs-progs: check: fix max inline extent size
> >
> > Sweet Tea Dorminy (6):
> >    btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
> >    btrfs-progs: start tracking extent encryption context info
> >    btrfs-progs: add inode encryption contexts
> >    btrfs-progs: interpret encrypted file extents.
> >    btrfs-progs: handle fscrypt context items
> >    btrfs-progs: check: update inline extent length checking
> >
> >   check/main.c                    | 36 ++++++++++--------
> >   common/string-utils.c           |  1 -
> >   kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
> >   kernel-shared/ctree.h           |  3 +-
> >   kernel-shared/print-tree.c      | 41 +++++++++++++++++++++
> >   kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++-----=
-
> >   kernel-shared/uapi/btrfs.h      |  1 +
> >   kernel-shared/uapi/btrfs_tree.h | 27 +++++++++++++-
> >   8 files changed, 186 insertions(+), 31 deletions(-)
> >
>

