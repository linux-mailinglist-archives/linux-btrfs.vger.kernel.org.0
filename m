Return-Path: <linux-btrfs+bounces-10311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE39EE240
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 10:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EDD16785A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA21220E325;
	Thu, 12 Dec 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UY9zbmE1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419120A5D1
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994499; cv=none; b=TWvmQlWHABbl+TkkO93FxPVx5UKAlERX+X+ptcM72uzJzGnqUsrWTSBNiab+yIvE2ySHVXcNxg2yljOtYc8LBjP4uw3V0Nk5bnqBWK1KBACFzG1tA1p9wFGEcW3C5YteD9ktP+g/H8xuqpF/+BcqTipSilkZV83eIxY2Bu9NC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994499; c=relaxed/simple;
	bh=7mkNhNohCRInUoNEgtBbSXisKCJhOCIqilr1bctY9qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2jl0vo9R9TYK9vxuqrymWwJ80QdC8ZoWy9+JQRP3wBUwKS66ntJVKOKd8mlNlkM0jzC8ttxfbrvwgZsIZmoFPKkJd754V/2B+6sOx1mFJ7JPU+g5mNXnMHUZg+P5q5MMml3OPCWsnFxXQl405I/Jmvd4Cz9ac1sCBYXCaW6EpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UY9zbmE1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso56253666b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 01:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733994496; x=1734599296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy+XHWudhy1v5FQx+HPpD7u/EehmML+tWjPRArge5Pk=;
        b=UY9zbmE1ruDn0cJyFk3s5No7MYdK40/t7SxvnC0MbCorrBZCJk2K+oWpMH3G1NxKS0
         cX6BGCqyM8v0c4ssk88tKeAHa8QzRZBCYEuxT36YQDNH7duWdGbIxV9JHm+nKWbNqnoR
         w/MMliVYdcnIRiKeMEOp52K2zSSpyPvLjYBohIcRjDskjaAOArp7UrAQEcmJ1yUrwGEB
         VeMk1viVs/9XQ+0h4Yc8byYxMoW4BDm5f/XDtkuiwahXxn4oUZBuTniVYArtQUIt+ngw
         V2nsceY40jsbupLgK0co4IncKIpSQkN3zl/S+ZojF5d81o4NboWsEbMwdihwIuEzSRhX
         ogPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733994496; x=1734599296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy+XHWudhy1v5FQx+HPpD7u/EehmML+tWjPRArge5Pk=;
        b=fIm+iTeKhC1muo2C1B+Hheua4t/Lrsf/DDs4cuc9bSAIn21CsdYqG1z3ETOPX41L6f
         NE4YhG7qPLmIbnfYvUNVVSAdeTVfykjwEaNbUzvrHktNAfJSCIebcL2HFILNjuo8Dds1
         yz2NEsZE3h6E2g9K3vN5tryNy8aCYjGaU8B5Xooen3ee806aUO4uvE2i6Mcs5Kzq2jLs
         pyLLHD6jDeVOMXHIcz754P+0HnAcPDXht38STYlcTyni6Dg3JAQaOOIums2mvd4c/i8m
         rUn3G5S3w/5/0M+yD/CfREP7iH6fsVLg5a8G+Et29jpp5yuswoDi2nRbnmVbSTttILZl
         AQgw==
X-Forwarded-Encrypted: i=1; AJvYcCV0n5nAeYOZ/8i66Oa1L0b/gs724cBAR1zVcnrEwY5POhBjJKC47A+MEJDUAe1mwnCfzJU1iAoqK/Y6MA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN6dCrpSQcj0teQvLEe2FbKvdeBAwt8lWwRNrcwGpX6nOJC/vz
	w9OWKNqEaQYw1UjjPTOcJhQYJp4i+kZmh1in2OdQDZS8GQoCyA5Y0xaVyAzm7WRjsDIEPkrHaZq
	WmmAJ6sbpluZXEQlympzaDMZw19iwFD5IjBceWQ==
X-Gm-Gg: ASbGncup0ur4Egpd6Pu/1KwcRAszRSAWY9tvOBVjGLs23vnH0MfYqhc0bGR4Ay+w0TO
	TNfAZWFwiPN93AVSfKz/+c3irY6YoTSrBJZts
X-Google-Smtp-Source: AGHT+IHEeJ3cn9fsQUrmcRwGKGFNz+w9xyhYxVnY2x3y6VbhboijLIDasxIc1jaQaLdp8+eNSrWDe+me41Cfc3kAJW0=
X-Received: by 2002:a17:906:2929:b0:aa6:8096:204d with SMTP id
 a640c23a62f3a-aa6b1141caamr537934766b.3.1733994496399; Thu, 12 Dec 2024
 01:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com> <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com>
In-Reply-To: <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 10:08:05 +0100
Message-ID: <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Omar Sandoval <osandov@fb.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 10:02=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.12.24 09:53, Daniel Vacek wrote:
> > On Thu, Dec 12, 2024 at 9:35=E2=80=AFAM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 12.12.24 09:09, Daniel Vacek wrote:
> >>> Hi Johannes,
> >>>
> >>> On Thu, Dec 12, 2024 at 9:00=E2=80=AFAM Johannes Thumshirn
> >>> <Johannes.Thumshirn@wdc.com> wrote:
> >>>>
> >>>> On 12.12.24 08:54, Daniel Vacek wrote:
> >>>>> While testing the encoded read feature the following crash was obse=
rved
> >>>>> and it can be reliably reproduced:
> >>>>>
> >>>>
> >>>>
> >>>> Hi Daniel,
> >>>>
> >>>> This suspiciously looks like '05b36b04d74a ("btrfs: fix use-after-fr=
ee
> >>>> in btrfs_encoded_read_endio()")'. Do you have this patch applied to =
your
> >>>> kernel? IIRC it went upstream with 6.13-rc2.
> >>>
> >>> Yes, I do. This one is on top of it. The crash happens with
> >>> `05b36b04d74a` applied. All the crashes were reproduced with
> >>> `feffde684ac2`.
> >>>
> >>> Honestly, `05b36b04d74a` looks a bit suspicious to me as it really
> >>> does not look to deal correctly with the issue to me. I was a bit
> >>> surprised/puzzled.
> >>
> >> Can you elaborate why?
> >
> > As it only touches one of those four atomic_dec_... lines. In theory
> > the issue can happen also on the two async places, IIUC. It's only a
> > matter of race probability.
> >
> >>> Anyways, I could reproduce the crash in a matter of half an hour. Wit=
h
> >>> this fix the torture is surviving for 22 hours atm.
> >>
> >> Do you also have '3ff867828e93 ("btrfs: simplify waiting for encoded
> >> read endios")'? Looking at the diff it doesn't seems so.
> >
> > I cannot find that one. Am I missing something? Which repo are you usin=
g?
>
> The for-next branch for btrfs [1], which is what ppl developing against
> btrfs should use. Can you please re-test with it and if needed re-base
> your patch on top of it?
>
> [1] https://github.com/btrfs/linux for-next

I did check here and I don't really see the commit.

$ git remote -v
origin    https://github.com/btrfs/linux.git (fetch)
origin    https://github.com/btrfs/linux.git (push)
$ git fetch
$ git show 3ff867828e93 --
fatal: bad revision '3ff867828e93'

Note, I was testing v6.13-rc1. This is a fix not a feature development.

--nX

> Thanks,
>         Johannes

