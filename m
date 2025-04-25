Return-Path: <linux-btrfs+bounces-13428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B1A9CD84
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 17:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF67B63E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1728E61A;
	Fri, 25 Apr 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HfeVgKLW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B41401B
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596000; cv=none; b=egRhyEUyP+mQXNHsivf4F1FdTB148bqbymrAWrI4zbblqn0yKuMYymnBfnKvgRJA8VPNbcf70DxF2JkR7/s5Sxv1snMLtwAV/ddFXoqg5gzVwU0eju+VU2bPiqpbxdZlZnl4ULq50PA47MN9bxBI0yT97jReeepJ5xXAWbU8tqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596000; c=relaxed/simple;
	bh=6+oT7OPME5W5AGeISVCplZJ6U+5PWZGaOGF9GnV7lsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtqHYhMMEDLkpiBPrmomjg8iIeNTG7VMfogXJ5tT8fl8qaNc6lCWLQ4ebCMv+/fLrPIEz/knfWXT8Xb2cj5MndwUHYXnxoU7qTfJxWPukovdSmW6t9KzT9CRlYMFWUYMNRgQlvp8X61XhRLEM1k/TUJoOuZADglvxx8WKpuCUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HfeVgKLW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acb39c45b4eso374158266b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745595996; x=1746200796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+oT7OPME5W5AGeISVCplZJ6U+5PWZGaOGF9GnV7lsk=;
        b=HfeVgKLWpOHQgnJSKhCB3kOnBuTGLTc7HOkPWingNkvwqGUzZ3LKJpD49qilOJzAUB
         N3wQ07cRa4MxoYI4v7K/vanAmHSQr1gshPMAbA3zZULHfX+gSPN48/UHFH11Zz3kU35I
         kdLt+d1lJlDM9YKE1omfo6jPVqsjgswp9dE+bAZrkrk03ijdjSepy1/hUz8orRal4+HW
         cweM9KqtFQCH0o/p5BEISsQvFMb+dNn8thhHksNT4vFBW9BPHrgaLmPvPkI6RLXtUjd0
         iWi9pPQLghZPTOHxyPRsrhBI51a9Hotrti4P4FrmV7djiQIBM/Mc/K63DR0hydpTTfLE
         A0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595996; x=1746200796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+oT7OPME5W5AGeISVCplZJ6U+5PWZGaOGF9GnV7lsk=;
        b=D8k3h/jV2EtoDLONHKufZPtFTix2pQW3ocRo6b83kr8QhyHEhyP7JyVgvD2GnwAbgd
         zUQNEs7m2H/KToJ3u7be9ltIyb95Jb3GJbn36jTPDSgSVs63w5IsUTn7AruhL1NbGlpD
         FmCO0XaKmv1y04IXHDi4zTKmX+JJRS181rhA0bPXuUlZvNJIQrp/HSzJDqQMoDRkxuIs
         lrxosGhhGd+fACNaXVy95c70JdCiYgRljUIWWydSLXZ6igiCUc9LsE65+GbWsLsbPz35
         AbUjfd+75+jM9xiPxvmDkGOVahuzQTgTWWZwYLR6QfVOYQ2AZWwgSdwyn/eU755s42Jr
         lPpg==
X-Forwarded-Encrypted: i=1; AJvYcCXkhKfIuaS6IZ8AHnBE+MhenPMNgl4CupKv4urapPVQlOSs5+5E8XifGz1SM6+wGbPjZ37RsrXB9sZt8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwmfy2mZq2/Wr/8zezBsXyCdlDJrycsEuP93/hsX4UFlySgSt+
	1IRc6uRbbtnJjXZR9tG9v0VQfyYzFZjE03eHllgN/Ui01enmoGqb7XfkWAEYCCm8SWGdXpgKIzk
	iu++PTr62BacITYazNjd1chKELRJ2lp9mc+SHRA==
X-Gm-Gg: ASbGncvzTM5Tt5iG1ECSvjFD8NvKo/s76lDTbGsN8Iv2HzQfMZIhvSVROeM7/v9iB0S
	REweikG3dsHa9IsHyn8PrDYHSd3nGtaiZFvIWstDMoMUzCi79bhndKMZN5289WPevm9C/UrTN0X
	fDXUSYc2PI2znZM/uP1EbL
X-Google-Smtp-Source: AGHT+IGr+VKlulMf5Cx6x9oG34hCDw2NMc0/Wkcu29MCN5XVU15ncJbgcddyu2GbRYNOr2mGn0vqXQ1s3vvyKd2vDK4=
X-Received: by 2002:a17:906:478b:b0:acb:aea9:5ab0 with SMTP id
 a640c23a62f3a-ace73b1cd63mr222162066b.39.1745595996519; Fri, 25 Apr 2025
 08:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
 <CAL3q7H60DfC0+ysf_Yw7bBOaDExPqpRU4==xHz4pYxHt3k-woQ@mail.gmail.com>
 <20250425115813.GE31681@suse.cz> <20250425153943.GA1567505@zen.localdomain>
In-Reply-To: <20250425153943.GA1567505@zen.localdomain>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 25 Apr 2025 17:46:25 +0200
X-Gm-Features: ATxdqUG5GH9nt664XN4OsSSRZgzOE9HlPC44QnkuZ5JGR6m8IMK3q5Clu78cbtk
Message-ID: <CAPjX3FdsMM+vvCYr4-F1AEVACcxaaWvTn1JJ-sbYES6QKYTNVw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix folio leak in btrfs_clone_extent_buffer()
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Apr 2025 at 17:38, Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Apr 25, 2025 at 01:58:13PM +0200, David Sterba wrote:
> > On Fri, Apr 25, 2025 at 10:18:38AM +0100, Filipe Manana wrote:
> > > On Thu, Apr 24, 2025 at 10:54=E2=80=AFPM Boris Burkov <boris@bur.io> =
wrote:
> > > >
> > > > If btrfs_clone_extent_buffer() hits an error halfway through attach=
ing
> > > > the folios, it will not call folio_put() on its folios.
> > > >
> > > > Unify its error handling behavior with alloc_dummy_extent_buffer() =
under
> > > > a new function 'cleanup_extent_buffer_folios()'
> > >
> > > So this misses any indication that this fixes a bug introduced by:
> > >
> > > "btrfs: fix broken drop_caches on extent buffer folios"
> >
> > Thanks for noticing, this was not obvious.
> >
> > > With a subject and description like this, it's almost sure this patch
> > > will be automatically picked for stable backports, and if it gets
> > > backported it will break things unless that other patch is backported
> > > too.
>
> Oops.
> I was trying to *avoid* it getting backported by ommitting the Fixes:
> tag. I should have just squashed them together as you guys say. I was
> worried it might be confusing with Daniel also making related changes,
> but it should have been fine anyway.
>
> Speaking of which, I believe his patch
> "btrfs: put all allocated extent buffer folios in failure case"
> also fixes a leak from my first patch, for folios that are past the
> attached counter in the fail case, so that needs the Fixes: tag too.

Yep, true. Or feel free to squash it to your patch. That's also fine with m=
e.

> > >
> > > Also, since the bug was introduced by the other patch and it's not ye=
t
> > > in Linus' tree, it would be better to update that patch with this
> > > one's content.
> > > That's normally what we do - I know both patches are already in
> > > github's for-next (I didn't even get a chance to review this one sinc=
e
> > > it all happened during my evening), and it's ok to rebase and squash
> > > patches.
>
> Copy
>
> >
> > Agreed, as long as the a buggy patch is in for-next there shuld be no
> > need for a fixup unless the branch is frozen for merge window.
> >
> > Also non-trivial patches should not be pushed to for-next too quickly,
> > exactly to give people chance to have a look. For trivial, clearly
> > correct or non-code updates I would not care much if it's applied
> > without much delay.
>
> Apologies. How long should I leave a fix on the list without pushing it?
> I did get a non-trivial review (as in he didn't just blindly stamp it)
> from Qu.
>
> Shall I leave it up for ~24 hours or until review from one of you two in
> the future? Or since Filipe noticed the bug in the first place, wait for
> his review in this particular case? For me, getting things off my plate
> makes it less likely I will get pulled away from finishing them, which
> is why I wanted to push it while I was focused on it and felt done. If
> that's inappropriate, that's totally fine by me, just saying.
>
> Sorry for making this a headache with the buggy initial fix and churny
> followups.
>

