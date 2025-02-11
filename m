Return-Path: <linux-btrfs+bounces-11383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C96CA319A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 00:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E03A72FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 23:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4802268FE3;
	Tue, 11 Feb 2025 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbGC0MfO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9B253B51
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317076; cv=none; b=DTF13pTslGFUY6+zs/vixAaEHtRLPSW6i5hZzas2L4gfMw+UmBJbmDEBuyJF6aUvCbqb7EPqWGLeaffwUSOrpN8gKR6Dp5yOB7mVnmBcidjUf7jCVV3MfjacDQqgBhEE0lKoMcc7DR9gjFiQroZCNfbR5nXFfBZ1zWqeMI52w6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317076; c=relaxed/simple;
	bh=Ce1CoHZKut5gt/6fBqmjn4yqEj56M5MXhYCzRavYFQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBvPT1YM62UddAEA69nRdR0cVMaIIW7xnZ+r4LhflT0joGaM/uI3mg9MJDdSA3Mb2VeD1XWJo8xHAU3859Arx/Rm+f78vRha3BvstY6nADhBgMXBDOFKGaENddpqFyOnb+WgaDEV1nQ1x5pnkqsXTtnj4ygiUmgFnIWXK7y8w0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbGC0MfO; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso94187126d6.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 15:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739317073; x=1739921873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLi+3HpQivF5Ex4akHnqxKkFuaKNgxOv6/Ty4XEOygk=;
        b=nbGC0MfOT6a4iqSQA9yvB6udkHPxLS9hk2qTnrqKJqN1jFscl7FHTyFVdfo9Ax8UMs
         UreVIeO8QVizvD+GX7c+IvDEwQtpAxKwsfsVx4tu9Z6188MauiVa7jDiASzkLCAzASgY
         iXEMjtqOLfXeD01TpAG6j5xU4ccNXZjOPSoVncNFo18/x9h06YRorKROWeSMNj9q7TT+
         Sw0lQO1FNrwJ15MFlX70wFvXk2k096Nv8KkEufzQmNb5wv0JNEE+lF2N1B59DhFtXz07
         Kbw0QIsAmN5BiEjSWxrSQ/e/ZAUWtW858SieoAb9Yl3SX5t8Fdr5rblhp/R8ktwuupA1
         Uj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739317073; x=1739921873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLi+3HpQivF5Ex4akHnqxKkFuaKNgxOv6/Ty4XEOygk=;
        b=onxoZoGSl3GlCYFDUn14OjMre2hUKqZ8ATgWE542LfmJ8IqDMKTcR4SEYbiX1enqja
         PfgjQgqkhlph1EoAJNd+ZomO0rxYB09gBJoC9jYPydP6HXuLHY+tQEYsp4Pf5pG5XPgh
         5NuylQHYhxhWO9oWOIeq6nU2NyI0hu8cHJ6JVwOPBNBveNp9GC8dd8+p2PxbvDt20XJw
         alhJ4MbVaUwG+LT0N9Qs+DXvS775lfYfgswCwj+fSEoiUEf/gbNWVfyp1HbPaNQGafmw
         SD+tPSlAXNboJGp19fDV6mRCdCJHshj2BRkAm7g+tJ6e3+0yZWh7EoLI60qm653AKyi/
         kIaw==
X-Gm-Message-State: AOJu0YwRdnhUoirZxPJLxB/UEN+Ibeqsja9+/ks0bqsYNZ2jaLCj+Dx4
	5ckIFV8oeYDl5rE9pxGZDJhsXbUgiYyicoPSW3XkdrsJXl5Hoi7V0kSms36b/E2eorBTEOh/9aB
	ZWNsUyab9sN9xf5Kx9Qd90fWdPRk=
X-Gm-Gg: ASbGncsjNb+59TmgRLeVW4izLgOsLNc+pJvos/fTciA3EMrvBxKV1rwummWoYAgGJwu
	DQ+n7OpYLIuItZjARKzuZKgfUXxb9r1qoFwYLPPPuqZ7Wkk71D27rvGaLNUi/Icg/UdE1PJg=
X-Google-Smtp-Source: AGHT+IHIQ35+MVelWRkcj8YMTs0PCxiIRwoSssTqf4AhsXS2ToeInl1r0y1IGp8sjumYzIgzdS1Yr1FWZmEU2M5Vcsw=
X-Received: by 2002:a05:6214:130d:b0:6d8:9124:8795 with SMTP id
 6a1803df08f44-6e46ed7753cmr19015536d6.1.1739317073215; Tue, 11 Feb 2025
 15:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207023302.311829-1-racz.zoli@gmail.com> <20250207023302.311829-3-racz.zoli@gmail.com>
 <20250211194135.GV5777@suse.cz>
In-Reply-To: <20250211194135.GV5777@suse.cz>
From: Racz Zoli <racz.zoli@gmail.com>
Date: Wed, 12 Feb 2025 01:37:42 +0200
X-Gm-Features: AWEUYZn0UqJX-uHDtaKUic3Q8iS7tTo2n8XsWjvO6waqtyYLrHoGer8I8QNUwnM
Message-ID: <CANoGd8njgkmKUibQo=D+6+6CqNhUddx1VMnKNc6VOZ6s0VdC9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] scrub status: add json output format
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just submitted a patch to the mailing list with the subject "[PATCH]
btrfs-progs: add duration format to fmt_print" which adds the format
type you suggested.
And I have a question about the timestamp format. As I saw in
format-output.c there is a type named "date-time" which accepts
seconds as the input and prints out something like "2025-02-12
14:25:30 +0200", so I think it would be usable for the timestamp
format you mentioned.

On Tue, Feb 11, 2025 at 9:41=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Fri, Feb 07, 2025 at 04:33:02AM +0200, Racz Zoltan wrote:
> > This patch adds support for json formatting of the "scrub status"
> > command. Please not that in the info section the started-at key in
> > 02:00:00 1970 because i bypassed the "no stats available" so I can make
> > sure those stats are correctly formatted in the output as well.
> >
> > Example usage:
> > 1. btrfs --format json scrub status /
>
> Thanks. The status in json is useful and it found a few things than may
> be missing in the json formatting. The most obvious one is that there's
> too much duplication of the code in plain vs json output. The ideal
> version is that there's only rowspec definition of all the keys and only
> fmt_print for each one, it'll get formatted properly given the selected
> output format.
>
> But there are already exceptions in other code that prints both json and
> plain text due to the requirements that can't be done with fmt_ but we
> need to keep the visual output.
>
>
> > +static const struct rowspec scrub_status_rowspec[] =3D {
> > +     { .key =3D "uuid", .fmt =3D "%s", .out_json =3D "uuid"},
> > +     { .key =3D "status", .fmt =3D "%s", .out_json =3D "status"},
> > +     { .key =3D "duration", .fmt =3D "%u:%s", .out_json =3D "duration"=
},
>
> We'll need a new internal json type for dration, so the value is number
> of seconds and formatted automatically. The .fmt can be any proper
> printf formatter but it's left for flexibility until we find a reason to
> make a separate type for that to avoid code repetition or differences
> how the same type of information is formatted.
>
> > +     { .key =3D "started_at", .fmt =3D "%s", .out_json =3D "started-at=
"},
>
> And another type for timestamp, input in seconds, formatted as some
> standard human readable format that can be parsed back eventually.
>
> > +     { .key =3D "resumed_at", .fmt =3D "%s", .out_json =3D "resumed-at=
"},
> > +     { .key =3D "data_extents_scrubbed", .fmt =3D "%lld", .out_json =
=3D "data-extents-scrubbed"},
>
> The keys are internal, I'd prefer to use "-" as separator.
>
> > +     { .key =3D "tree_extents_scrubbed", .fmt =3D "%lld", .out_json =
=3D "tree-extents-scrubbed"},
> > +     { .key =3D "data_bytes_scrubbed", .fmt =3D "%lld", .out_json =3D =
"data-bytes-scrubbed"},
> > +     { .key =3D "tree_bytes_scrubbed", .fmt =3D "%lld", .out_json =3D =
"tree-bytes-scrubbed"},
> > +     { .key =3D "read_errors", .fmt =3D "%lld", .out_json =3D "read-er=
rors"},
> > +     { .key =3D "csum_errors", .fmt =3D "%lld", .out_json =3D "csum-er=
rors"},
> > +     { .key =3D "verify_errors", .fmt =3D "%lld", .out_json =3D "verif=
y-errors"},
> > +     { .key =3D "no_csum", .fmt =3D "%lld", .out_json =3D "no-csum"},
> > +     { .key =3D "csum_discards", .fmt =3D "%lld", .out_json =3D "csum-=
discards"},
> > +     { .key =3D "super_errors", .fmt =3D "%lld", .out_json =3D "super-=
errors"},
> > +     { .key =3D "malloc_errors", .fmt =3D "%lld", .out_json =3D "mallo=
c-errors"},
> > +     { .key =3D "uncorrectable_errors", .fmt =3D "%lld", .out_json =3D=
 "uncorrectable-errors"},
> > +     { .key =3D "unverified_errors", .fmt =3D "%lld", .out_json =3D "u=
nverified-errors"},
> > +     { .key =3D "corrected_errors", .fmt =3D "%lld", .out_json =3D "co=
rrected-errors"},
> > +     { .key =3D "last_physical", .fmt =3D "%lld", .out_json =3D "last-=
physical"},
>
> All the numbers seem to be u64, so %llu format should be there but it's
> wrong in current version already. This would be nice to fix first (in a
> separate patch).
>
> > +     { .key =3D "time_left", .fmt =3D "%llu:%02llu:%02llu", .out_json =
=3D "time-left"},
>
> Duration again, also it may need to be formatted with days taken into
> account. With a filesystem it's not impossible.
>
> > +     { .key =3D "eta", .fmt =3D "%s", .out_json =3D "eta"},
>
> Timestamp type.
>
> > +     { .key =3D "total_bytes_to_scrub", .fmt =3D "%lld", .out_json =3D=
 "total-bytes-to-scrub"},
> > +     { .key =3D "bytes_scrubbed", .fmt =3D "%lld", .out_json =3D "byte=
s-scrubbed"},
> > +     { .key =3D "rate", .fmt =3D "%lld", .out_json =3D "rate"},
> > +     { .key =3D "limit", .fmt =3D "%lld", .out_json =3D "limit"},
> > +
> > +     ROWSPEC_END
> > +};
>
> So the plan for now is to first update the formatter and then use it for
> scrub status in json. Let me know if you're up for it. Adding the types
> should be easy, it's in fmt_print().

