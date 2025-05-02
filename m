Return-Path: <linux-btrfs+bounces-13634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35821AA75B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 17:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11C11BA2D13
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7CF2571D5;
	Fri,  2 May 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sd+njuRy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A822566FA
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198640; cv=none; b=VkjYlUXDjhSZJq9gU9yoAyuDt2B1tH8MiY84Tee/fboFrYfm/pToOYDURl1kmWP91Suft0nKzxwjiXfaw89kKHYpW+sOyOMloKn0qagbdqhxP1bIF+pPnlzRFQcCa9DlinisLK6v/9sQdNG89sCrqmP6bYIE04MhBwA0ffu7e3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198640; c=relaxed/simple;
	bh=o+WFCDYwVR+5leRGmhvc+YBGp9yqqAwhjrwRO+zO43M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GH/AaBwMaX85KxXAjm39BryL4NSsPcf6W0PG06iir50It/8Uy4W1uBfFuvfFwa5xcQZkmf93O+VZKXieA7IW/5rGJUn6SY17fcbU4GaK1GwlvbG0TTfEZPNQZ5n37Cy8EneWElz4ToTa2bQfQujFQAMUZ1HMZtfqlVYCOwwTSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sd+njuRy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ace333d5f7bso381330666b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 02 May 2025 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746198636; x=1746803436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cb2oTzrOGvUTvFRyJiyJpHh/Rz9JDLRP7fWk6U3R36c=;
        b=Sd+njuRylGQ52g50gKhJ7LmVOK/TNXf38GxRH5NxRjb2T6UC9Uk5/XIhOUbfXudH+f
         +LDQdx6dh5Xi2Wqroja0ywIiIWIqnp/LXa6JpU3I0cU8lW/i1XzYGDa9cmsaBb6qHT1C
         Ibb8YLHO5DbXnlU690VXzvoKO/kndpS2fz+CLx7XULZPzs2ySeFrJK00JNGCKz8muEgc
         90UuRcto99SHICakIDhghkF1aIWni5oDRf/DxSePdsN5WGX/B2/GOALNdkvidgZSpS56
         37MeHutfYhQgX7qBzXtIc/UVyoYvJkXqBt5Lgv82XRVUTNDkyev8QRDjrrympr21gIwx
         3lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198636; x=1746803436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cb2oTzrOGvUTvFRyJiyJpHh/Rz9JDLRP7fWk6U3R36c=;
        b=Kp4C9EsNdMabNt/D0HGrHVo+e0GVXDXtZGl6zPaZ/qU6EQ8/FRY/IobRzpXuRfCsi8
         C77v1Vj6UDHRv0cNIhRJ9SgA/c+fUDyP84CuPjkUHASbWLGrBqNmQ4dzXFX2plgLL0a6
         IVUO4D43SUd1zmMsklU2JAdZRcV4XHouCQ9vcsLuCsM7UGWv+u8hAqsZLE6UlBDpLin+
         bBLj+MrazDayFZCdIaHwUDsB/N+6AGKW2DWvghOv6dwLf5gJHmosKQOVvz7wuplDPUnI
         MAK++ss6WpHHOfIuj1H59QXBD7XACabgyXlSY29WD/imisI7NX7TNChuNagctoCpVy5P
         pgLw==
X-Forwarded-Encrypted: i=1; AJvYcCWFPy5w4A/wnDO3Q0SIcmTIgsMufSTaHeBjpEiYZGH5xjdgLPudNuLe/nD2r00Og9HmBodFDb0cKVWenw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8gjGmuiUqzMhKWdvfQm6CTTbRoAm0TQ5ixeYi/XVrBYzqyoxm
	uPrBAz5GIo1YI8ViOgtwjnzz6F4inQYijt780VzuHqrAWMDC96tL0j3bR4DQV+HNDvTMm/gM623
	CeaI9VazgNOq1b4grpMa8rFr9DEWD4yt1/D14PA==
X-Gm-Gg: ASbGnctY/EizeA1ZdXjpe1cddYedZhUcOcf8flG1vizEKXhbuAEU0fFY6AgxkxS+QKP
	+QVoNluk+3Y6RziFf5s6ZGYOARfKKSoR4OEgHMKZo8dHPAl+ba+sVNFOpIU/bCtdSFujl96IrST
	sCEYYY1MN86bIyYvevu5ZWarxfJ6izvgs=
X-Google-Smtp-Source: AGHT+IFPsz43VezwgYy9eMGAtrm6JhSfTjQdF1J+TAooTgEFM8LavfReBiTALRZ1I7C5rWvx8ItM5aTodZJpYCzbNwE=
X-Received: by 2002:a17:907:3da1:b0:acb:b267:436b with SMTP id
 a640c23a62f3a-ad17adc2c4amr388869866b.25.1746198636583; Fri, 02 May 2025
 08:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746031378.git.dsterba@suse.com> <CAPjX3FcAA=2cR4WqxFUOXZ4zYHS8hS75-ii0HPKQddgwhtr=Vg@mail.gmail.com>
 <20250502132407.GR9140@suse.cz> <CAPjX3FfMsjumdvv+BxtknhuGbXROKSioo5KGf-pj0_DafXsYkA@mail.gmail.com>
 <20250502143142.GS9140@suse.cz>
In-Reply-To: <20250502143142.GS9140@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 2 May 2025 17:10:25 +0200
X-Gm-Features: ATxdqUHhhXnRc4dTZ4sS3dyj-yTA2AS1c4PzQaq63dyjDEJDaLHL44pHPVr-J8Q
Message-ID: <CAPjX3FcD=+HDk4te-VQ0ujRjEQo8gaR1AfqEDovFh4jnx9BJaw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Transaction aborts in free-space-tree.c
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 16:31, David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, May 02, 2025 at 03:32:52PM +0200, Daniel Vacek wrote:
> > On Fri, 2 May 2025 at 15:24, David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Fri, May 02, 2025 at 03:15:49PM +0200, Daniel Vacek wrote:
> > > > On Wed, 30 Apr 2025 at 18:45, David Sterba <dsterba@suse.com> wrote:
> > > > >
> > > > > Fix the transaction abort pattern in free-space-tree, it's been there
> > > > > from the beginning and not conforming to the pattern we use elsewhere.
> > > > >
> > > > > David Sterba (4):
> > > > >   btrfs: move transaction aborts to the error site in
> > > > >     convert_free_space_to_bitmaps()
> > > > >   btrfs: move transaction aborts to the error site in
> > > > >     convert_free_space_to_extents()
> > > > >   btrfs: move transaction aborts to the error site in
> > > > >     remove_from_free_space_tree()
> > > > >   btrfs: move transaction aborts to the error site in
> > > > >     add_to_free_space_tree()
> > > > >
> > > > >  fs/btrfs/free-space-tree.c | 48 +++++++++++++++++++++++++-------------
> > > > >  1 file changed, 32 insertions(+), 16 deletions(-)
> > > >
> > > > This looks like unnecessary duplicating the code. Shall we rather go
> > > > the other way around?
> > >
> > > What do you mean? There's some smilarity among the functions so yeah
> > > the add/remove pairs can be merged to one, but this is orthogonal to the
> > > transaction abot calls.
> >
> > Not that. I meant the code looks simpler without these patches. If
> > this is the pattern used elsewhere, maybe we should rather change
> > elsewhere to follow free-space-tree.c?
>
> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#error-handling-and-transaction-abort
>
> "Please keep all transaction abort exactly at the place where they happen
> and do not merge them to one. This pattern should be used everywhere and
> is important when debugging because we can pinpoint the line in the code
> from the syslog message and do not have to guess which way it got to the
> merged call."

/*
 * Call btrfs_abort_transaction as early as possible when an error condition is
 * detected, that way the exact stack trace is reported for some errors.
 */
#define btrfs_abort_transaction(trans, error)

Indeed, that's clever. It was not clear from the commit message why
this pattern is preferred.

Thanks for the explanation.

