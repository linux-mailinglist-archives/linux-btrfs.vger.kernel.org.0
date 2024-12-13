Return-Path: <linux-btrfs+bounces-10354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E667B9F1369
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 18:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F5228426E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E191E47C7;
	Fri, 13 Dec 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpA1HbLs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA251E22FC
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110112; cv=none; b=RwRVSBkX5KQTvX9+g7V30DmhLY8quN9ok1ATbN3685hVtpjELLVIf6/b6w9YG7Wt4C401zZelEiAXjCUz0Tpng+QxONl/KtdIv83MyrBepkVueQAbLAD0JiJluRo6uGZihMnLTTloR6xEkQejVQjJox9A5UFtN6CWG2Arv8RrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110112; c=relaxed/simple;
	bh=saugkRws+Xl1HUIuIG2wAySTGsDY/0vOR4E2I0VEo5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPG3P5lBD+gf+JyMm3cZ81V/IwZZDxZsRKxBrnDYs7NuuVXLtiVNQiPZNNqtjI7ysJaeKaj2gvpwhid1s3pKBKlKJ2H6I92DOTV5dkeEnTRwJ4PUjWfTWUGbu/n2S4pYFH1jOMTV6y5vvdXns487rQ2dXUoRjguxA/TLwXDPlUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpA1HbLs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436281c8a38so11769895e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734110109; x=1734714909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saugkRws+Xl1HUIuIG2wAySTGsDY/0vOR4E2I0VEo5U=;
        b=UpA1HbLs1TzCP+c0nylDF4gU+oF1FWYaA3zFXsiOvxBa1IYLfS30fuheJjwR30HI90
         Vqvfu6Y2UI11aBUWeaX/h4S1zKfsaMEmHmTCButgWzl1HFltsl0QPxhvYqlqC9rIDRxp
         JocWS2ntkNePXwICEYcCPedXN7fv4IXW0SnvkboK0Nwhn/XAO7+jSRKorpWRPTlQ4eRE
         NaJ+aQoBMliaqpTqjKmVAL1e8//AAUdVFq2lGlnSSWo4oZuCLW0Vm8Da95UnSod7/p7T
         iaPQ+Tmo8tTcJaUcyBvDGj3Bb4y5D5jDfiJFaHremfoXOUe94s3GUdJJuoBiaGmNEI0L
         VR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110109; x=1734714909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saugkRws+Xl1HUIuIG2wAySTGsDY/0vOR4E2I0VEo5U=;
        b=nPvjPxSAEUqWbVRoAkj3sRvnSGDQ7wYWAH3/Sya57qLnWt/bo2ulNIN0U6CnPSKZru
         c/1w2l/JV0k7DsigTHLB/JLaH5XrsPfRARRB9CASHxM89mcdjJmSwEP6FTDBlIaYNcnA
         5yKbebeQzWZsML1n0+b7e8QbDsFuJ/e/0MXI2WSHhmd9eGm/8XuzHLsntQBbPV6W/7Xi
         RwjJJfTYiaKpoNT4fiDxCh9S0D5yOlLyIa5+dsU/lsxCn9br9KfbW+aiJjrUlFF/nhs1
         FWqeM/utNohC2zvYVUwmxMmBv7wjG4J7IeGfwW2MowWRX8Hnm0WgAfEdVQwDYpYe6tKV
         11Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUhfORQ279ApDAVH5DmnmPWwjPqz4+87JERZ8X/hLNUMOVa+qrSr568b58zB7xH+3fGCjgcuK6sqqm75A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsL8qC7y8nXXID9uR1SFluXKv3nTgwdqw2buI5rFP3EZ3uks1
	dttOjHLeAVoi9qFj/MsBRaHm3f4JTQGgmpDlFVarBJQ1rVwr3AVNrJ7n29cYr9B/NVeMjS4IYoP
	SNiMb1tsPTMJpG2rBMW9CWc54NQpnHMzdwZI=
X-Gm-Gg: ASbGncvaLhW/0qIObbMN97QqPEmdKaDXGRzgZI5fFujY2rdEJOHON9/l5XBcLRrTAPc
	cErMgy6qqFF3OwkC7F4wwL5ML1L8sgr/PjfrZwFo=
X-Google-Smtp-Source: AGHT+IEactQbZWjMFXm7DdBKFdIajuEj4nfbFL2TaxfT4E8Cr6udQA9tvAsf01QsyPfT0iGq2Sx2aqcfI0LPaOAmNuo=
X-Received: by 2002:a5d:64eb:0:b0:385:ed1e:2105 with SMTP id
 ffacd0b85a97d-38880ada764mr2511478f8f.26.1734110109272; Fri, 13 Dec 2024
 09:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734033142.git.beckerlee3@gmail.com> <c80d0f92b73983e7454291154b3fb6ae555f6053.1734033142.git.beckerlee3@gmail.com>
 <6c633f79-9808-4537-be9f-fc201c032a6b@suse.com> <fe2b0dfb-1b3b-4e98-8c81-b4dc98af59cf@wdc.com>
 <8ce3be5f-2a88-460c-b1c5-e80fbe349014@suse.com>
In-Reply-To: <8ce3be5f-2a88-460c-b1c5-e80fbe349014@suse.com>
From: Lee Beckermeyer <beckerlee3@gmail.com>
Date: Fri, 13 Dec 2024 11:14:34 -0600
Message-ID: <CAMNkDpBAUO4EDdKkXYZev8-aGoTM+Kz4sBNvOVcmVMV+b91xfg@mail.gmail.com>
Subject: Re: [PATCH 6/6] btrfs: update tree_insert() to use rb helpers
To: Qu Wenruo <wqu@suse.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 1:32=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2024/12/13 18:00, Johannes Thumshirn =E5=86=99=E9=81=93:
> > On 13.12.24 07:19, Qu Wenruo wrote:
> >>
> >>
> >> =E5=9C=A8 2024/12/13 06:59, Roger L. Beckermeyer III =E5=86=99=E9=81=
=93:
> >>> update tree_insert() to use rb_find_add_cached().
> >>> add cmp_refs_node in rb_find_add_cached() to compare.
> >>>
> >>> note: I think some of comparison functions could be further refined.
> >>>
> >>> V2: incorporated changes from Filipe Manana
> >>
> >> Firstly changelog should not be part of the commit message. It should =
be
> >> after the "---" line so that git-am will drop it when applying.
added it to the cover letter this time, also was more thorough in
documenting the changes.
> >>
> >> Secondly if you're updating a series of patches, please resend the who=
le
> >> series and put the change log into the cover letter to explain all the
> >> changes.
> >> Updating one patch of a series is only going to make it much harder to
> >> follow/apply.
Roger (pun intended) I'll resend the whole patch series once I get a
reply on this, I've been utilizing the help message on the first
message I sent so it all stays the same more or less. Should I not be
doing that when I send a new patch series?
> >>
> >> And put a version number for the whole series. It can be done by
> >> git-formatpatch with `--subject=3D"PATCH v2"` option.
> >
> > Nit: git format-patch -v 2 also gives you a nice v2-XXX.patch prefix fo=
r
> > the files as well as "PATCH v2" for the subject.
>
> Thanks a lot! It saves quite a lot of key strikes, and even added the
> "v2-" prefix.
>
> Never too old to learn.
>
> Thanks,
> Qu

