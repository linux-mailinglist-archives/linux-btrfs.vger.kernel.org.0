Return-Path: <linux-btrfs+bounces-11378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03718A31572
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 20:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729791883CB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119C72638BA;
	Tue, 11 Feb 2025 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxSlqmS4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5ED262D13
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302307; cv=none; b=Hq22O3sWdan96SxXz/qpNPPdtZ6huZHMykH6Rvd6j9avwcbtOC6Zr9fQ8fQ1ILRjWKWxFoBzPEKjsyXUE5HTEFTCBKi9m906pN68JIw1/htFvFWnxgwIpuq/kbNj+eifgo7VngNqPrutmyJvY6ER31cVxLaQOO+QDbewhhieABE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302307; c=relaxed/simple;
	bh=7iLNo2NiT+EDUzPdJZQL4AjKWtkuHZGsz8H2lKLPjUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NesCL+6jfM/hdBCR6mW9sAAuomT7xI6TOrPdWjI7a9HKy5Hqcni1UOuPTc0jtzZqWDd7xV1vwkP5qpzzGkb4e8g77jWr3Nhd7LtzFKUhFwxpaFbgcPThzJha/kZ4mKNlHyLHYha6wT5xZpmwVzsiw1EucxEhVmUrCyZ+M/cQV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxSlqmS4; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e4565be0e0so36480276d6.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 11:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739302304; x=1739907104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dwCk/vymur7cds9RWbwMcUoXsn3+WBqkYFHmYBkyFM=;
        b=ZxSlqmS49J1ZIy0cREBK78k5hBNodZobXYETbecTTBIYHVWyxTlptk+i0PPMEsMAFy
         Kxdb6JlD918vFcYrft08PD+7WWNhwC2ZEmeZn1AwE5jeS76eHmRhRupxHgbQJG0wle1k
         fjjMKodFdIO0oGxj47wLiuk0CDCKRPE7F29Cia/iFfw+Y/yCgfRxTinB55MCe8JryPLv
         iIFoZEkJHM+qPBouIwEYPmKHaHQcpdsmzqmeLsvHIoBsurzrS9MSgcqUnTaLtCULnWfm
         uNeAgkkw+KtMIWm0Dn0Y1PYFf+gwlYGz9S20vgMFCwG8QtwBXcQWoWT0iFthWJpzzac6
         Su7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302304; x=1739907104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dwCk/vymur7cds9RWbwMcUoXsn3+WBqkYFHmYBkyFM=;
        b=UR63E1Rszw9fe4OrNOvc0078F4+6Q1f9QUsgV81iO1OlBRM073zNrK3oX3wMWxVQ8D
         AVCq8AgqAQMlTCCfXj44N6C/a62RjZVFC0M3y70Y1C5+5u5egZ1PPOC+Du1fOlgLIcXD
         M2MnhT3Kphxz4rePumLJmBBWMG7ZykBcbWdYMAtf7kXqOtpAfICvHhPqum2XQRNetiFe
         OzPO0HpwgTenPlISeg5CEFmaDZCsTKNTTRI/u4LNbk+ysjHQst4+GW3D/Q5ijVAnK4XK
         LFSTgC8gecKHvOzn8SfsFiM7/e7CZJ3aeWiBsvJTZhdX7lI9Hmn6gB0iW3oSNNJHREbh
         vWww==
X-Gm-Message-State: AOJu0YzfDjPDNY9ioVRCtgJOFlxs2xBPaIWbLscIs0rECoHplQlcJxSo
	WnnbPEIYU1qGR8IaUTiBptN/A3QP6cedFbtjg01wD7GVsJS4O0bqEYt48T7kR9CqT7jG1ZEit0j
	fVHC37DYxZkd2ZAbHBvpctb5qoHNum9gI
X-Gm-Gg: ASbGncupMYepvfKEhdV5ckonFKnca7g/imZarGqVZ4LpqFLXsA+xerEczQNdHCzlTrX
	SWZ4UiloKrrpEULwOPobOMVrNjKVuRZDThTfVvxocM8FuUZa9jo7s0SIJ4Gu3KHZRl+fTYlI=
X-Google-Smtp-Source: AGHT+IG7xknoTcx+OuIKjVBgdyb5vc1steLQ5FQPa8OKSdqVFN8WWawLjMXcadhINyYb5p3yONrraqFo0u5CFyX9jrA=
X-Received: by 2002:ad4:5d6b:0:b0:6e1:6bdf:ed1c with SMTP id
 6a1803df08f44-6e46ed9ab3cmr11659986d6.14.1739302304574; Tue, 11 Feb 2025
 11:31:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207023302.311829-1-racz.zoli@gmail.com> <20250207023302.311829-2-racz.zoli@gmail.com>
 <20250211191457.GU5777@suse.cz>
In-Reply-To: <20250211191457.GU5777@suse.cz>
From: Racz Zoli <racz.zoli@gmail.com>
Date: Tue, 11 Feb 2025 21:31:33 +0200
X-Gm-Features: AWEUYZn7iJczBYwmImSF4su81o9-JS3mViPWCHCSWHBhy_3UYSJPCAlO2J5F6UU
Message-ID: <CANoGd8mhGau83LU-bWjyi-A2jnzZoAyhqzo3yuxnhC2sETpfWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Removed redundant if/else statement
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I simplified that if/else block because looking at it it seemed the
only difference between the two was that in the if block
pretty_size_mode received UNITS_RAW and in else it received unit_mode.
Didn`t know about the underlying reason you mentioned.
But if the second patch containing the json output implementation is
ok, I can rewrite it so it uses the function as it was before my
commit.

Thank you.

On Tue, Feb 11, 2025 at 9:15=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Fri, Feb 07, 2025 at 04:33:01AM +0200, Racz Zoltan wrote:
> > Removed unnecesary if/else statement in the print_scrub_summary
> > function. If unit_mode =3D=3D UNITS_RAW, bytes_per_sec and limit get co=
nverted to
> > UNITS_RAW, otherwise to unit_mode, but in both cases the exact same mes=
sage is
> > written to the output
> >
> >  cmds/scrub.c | 28 +++++++++-------------------
> >  1 file changed, 9 insertions(+), 19 deletions(-)
> >
> > diff --git a/cmds/scrub.c b/cmds/scrub.c
> > index b2cdc924..3507c9d8 100644
> > --- a/cmds/scrub.c
> > +++ b/cmds/scrub.c
> > @@ -207,25 +207,15 @@ static void print_scrub_summary(struct btrfs_scru=
b_progress *p, struct scrub_sta
> >        * Rate and size units are disproportionate so they are affected =
only
> >        * by --raw, otherwise it's human readable
> >        */
> > -     if (unit_mode =3D=3D UNITS_RAW) {
> > -             pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
> > -                     pretty_size_mode(bytes_per_sec, UNITS_RAW));
> > -             if (limit > 1)
> > -                     pr_verbose(LOG_DEFAULT, " (limit %s/s)",
> > -                                pretty_size_mode(limit, UNITS_RAW));
> > -             else if (limit =3D=3D 1)
> > -                     pr_verbose(LOG_DEFAULT, " (some device limits set=
)");
> > -             pr_verbose(LOG_DEFAULT, "\n");
> > -     } else {
> > -             pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
> > -                     pretty_size_mode(bytes_per_sec, unit_mode));
> > -             if (limit > 1)
> > -                     pr_verbose(LOG_DEFAULT, " (limit %s/s)",
> > -                                pretty_size_mode(limit, unit_mode));
> > -             else if (limit =3D=3D 1)
> > -                     pr_verbose(LOG_DEFAULT, " (some device limits set=
)");
> > -             pr_verbose(LOG_DEFAULT, "\n");
> > -     }
> > +
> > +     pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
> > +             pretty_size_mode(bytes_per_sec, unit_mode));
> > +     if (limit > 1)
> > +             pr_verbose(LOG_DEFAULT, " (limit %s/s)",
> > +                     pretty_size_mode(limit, unit_mode));
> > +     else if (limit =3D=3D 1)
> > +             pr_verbose(LOG_DEFAULT, " (some device limits set)");
> > +     pr_verbose(LOG_DEFAULT, "\n");
>
> It's true that the branch is redundant and it's been like since the
> first commit d60d48fce5d32a ("btrfs-progs: scrub status: add unit mode
> options") where I added. The idea is to separate the other size options
> from the rate, e.g. a 20TB sized device may not give more than 200MB/s
> of rate and selecting --tbytes as size option will print number like
> 0.000MB/s
>
> How it works now:
>
> $ sudo btrfs scrub status /data
> ...
> Total to scrub:   5.14TiB
> Bytes scrubbed:   7.08GiB  (0.13%)
> Rate:             207.07MiB/s
> ...
>
>
> $ sudo btrfs scrub status --tbytes /data
> ...
> Total to scrub:   5.14TiB
> Bytes scrubbed:   0.00TiB  (0.09%)
> Rate:             0.00TiB/s
> ...
>
> but scrub is still running so the Rate is really not 0. The point is to
> print sensible numbers for Rate regardless of the other options but with
> the exception of --raw that will always print the raw numbers.
>
> Digging in the log it seems it got broken in ec3c8428590e90
> ("btrfs-progs: scrub status: with --si, show rate in metric units"), the
> fix should have been to add the SI modifier to the units, not forcing
> the unit_mode from the command line.

