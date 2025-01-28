Return-Path: <linux-btrfs+bounces-11095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D5A20669
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 09:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C9C168DFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 08:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19A1DE8A0;
	Tue, 28 Jan 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CUJycoxz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F71E521
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2025 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053979; cv=none; b=HCY+njne/a/ZZcf805RJ6nH9vD08vKN760PXMoGxAPzW9Ee7o6W6PjKVQHu7sHm217+0MXeSIiwnqJJwTdmmyRNw8qm2yB4DSNu7eix5wr+796V3cDLOR474xbSCmykPB7wboRPSyBNopVL51uvBZI4Kv2/XPraewL6DZVUoohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053979; c=relaxed/simple;
	bh=Zbfh0/HfCpytNFR7zGXeaOiMeMyFfbgSLVda9yTwWfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiH3+osf55MFnlrk98oEL7Ql05MRBJPfmf1WQ09Qaz52OvjfTvhHbR3h0OJRgb7Sjs/5jdpAXUW+taDsiCV0UO2o+hhzWcUFNJLirdwGdmSr3TsfltTlPI9NOBt2fnXJrGad52f+KRyJ8B49bRgoy2MS0rgMMDAu9j9i/37Wpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CUJycoxz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab68d900c01so521164366b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2025 00:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738053973; x=1738658773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fTy4seQAg08vjQLcHyfz96Rj9J/ObrS8gJZyjJ3tmeQ=;
        b=CUJycoxzSPYo1LMc5EXcOtPUUL/lDWxxa5yoJFSXV5X+A2TItZxWUXN4IfmxZ9XQeM
         4xtB7MDOO4U3W3ITOe1yK1rZHjMDc2yktIvuLebnc/NmOYZ+yMyGQwff0VguK6dSqIba
         9WsaHNbin1ufQH1k20fowSG6zxy8D0ey8NBYo2dMjiIUKU1oUDGQtJ6/ZLjd2D8bMkCW
         Erj4PyfwSkiXYAOiW5qhFJmN2RTL7wEna3d3iSHvdZmVYybvv2OWI55UzpuSPcG+CMSH
         jwQ5HWf4F4gHzPXDAsO4MZ++a3UgmB25D2sLhjLpS2ZwUQvNwPC3o5HJR25K16c97OPr
         DP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738053973; x=1738658773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTy4seQAg08vjQLcHyfz96Rj9J/ObrS8gJZyjJ3tmeQ=;
        b=NHOyzUqekRVQI2ytiLbSocr0k4Qb4de4pQAtcQGEKgS5esJ7AV4nkDYXJj4d8q4nee
         ovtnvLC79vgpyro+wPAtSOMgaA/C/YmTUgSG1donuJB+eA+54wBstFhWgYLiwMvZ1kAX
         kHsVOtHUOIh7XSHfGRdJ7fzya/BCIEo0veulM17ckMCWeLKfvaefZNxQViZQKaRb6W10
         +jOGPpmMagvEs6MPpRoYv/GjL9aKc1QrMb4B/7T20yl9Ed/2d1LIkSsWO+Dblow2HMdp
         2xv5rJVVq5kfLbE8clOCUdL+nYMGAzoKTiq/VlOh8DVf9YkhsagFQvaYOKD2ONB41LJ3
         Wt6g==
X-Forwarded-Encrypted: i=1; AJvYcCUVb7c7Ei17+/LCsdF1PYsYi2cfBlBhwFHuWLEhFr3UEi3k8Ngr6oXwfbgYgIiZQTaW0+EV3vucDwgftQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8fVMvvhmk4VrWFGP1Z1VYWTQ6mEdKYefelDEI4WqEpvPHZvh
	lEkOlC6nB41HcyjnLYacuuteFP9A7IL39egDgjyD6IdtMsGDbOPkpgAEG1kepb14q7kVHGTcDeK
	e+vwrEiHgtyDHHPD8LpiumQJ33WieLvAe0I7ToI2RvbN7RCs8Kp0=
X-Gm-Gg: ASbGnctxTUM77rn/1E+m44VD9JpqEKwDr0F19fU9+IL342eVpi+BLMR08PflGEP/oC0
	75fVtAlvCufYowjdbniMJ1p3pIPZC0Hjqufm4B1YKXoC5aZv+4xPawHob81Zu9Fci008jX2m4EE
	6Hhhy0rA==
X-Google-Smtp-Source: AGHT+IFNNEktyQ/D9zow5JEOjNNmbmP1ay96RH+a9inLGHPGsQXGe9SKc/ycZBv4sbz8sgLf69cChvVXVV9+/bXLEQ0=
X-Received: by 2002:a17:907:7ea6:b0:aa6:75f4:20df with SMTP id
 a640c23a62f3a-ab6bbaaa587mr255113266b.9.1738053973145; Tue, 28 Jan 2025
 00:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124075558.530088-1-neelx@suse.com> <20250127180250.GQ5777@twin.jikos.cz>
In-Reply-To: <20250127180250.GQ5777@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 28 Jan 2025 09:46:02 +0100
X-Gm-Features: AWEUYZk_i_5HVN7BVzvsv0pFOTEMUmroAVTPTVcOyzKn7pVuFcmFnxQ9kT2Q7aU
Message-ID: <CAPjX3FdaxfzULnRjN7TqyS9uK_ZJSk2PRzLgQCLVGBrR0yKLGw@mail.gmail.com>
Subject: Re: [PATCH] btrfs/zstd: enable negative compression levels mount option
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 19:02, David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Jan 24, 2025 at 08:55:56AM +0100, Daniel Vacek wrote:
> > This patch allows using the fast modes (negative compression levels) of zstd.
> >
> > The performance benchmarks do not show any significant (positive or negative)
> > influence other than the lower compression ratio. But %system CPU usage
> > should also be lower which is not clearly visible from the results below.
> > That's because with the fast modes the processing is IO-bound and not CPU-bound.
> >
> > for level in {-15..-1} {1..15}; \
> > do printf "level %3d\n" $level; \
> >   mount -o compress=zstd:$level /dev/sdb /mnt/test/; \
> >   grep sdb /proc/mounts; \
> >   sync; time { time cp /dev/shm/linux-6.13.tar.xz /mnt/test/; sync; }; \
> >   compsize /mnt/test/linux-6.13.tar.xz; \
> >   sync; time { time cp /dev/shm/linux-6.13.tar /mnt/test/; sync; }; \
> >   compsize /mnt/test/linux-6.13.tar; \
> >   rm /mnt/test/linux-6.13.tar*; \
> >   umount /mnt/test/; \
> > done |& tee results | \
> > awk '/^level/{print}/^real/{print$2}/^TOTAL/{print$3"\t"$2"  |"}' | \
> > paste - - - - - - -
> >
> >                       linux-6.13.tar.xz       141M          |         linux-6.13.tar          1.4G
>
> It does not make much sense to compare it to a .xz type of compression,
> this will be detected by the heuristic as incompressible and skipped
> right away.

Yeah, these results are mostly useless.

> The linux sources are highly compressible as it's a text-like source, so
> this is one category. It would be good to see benchmarks on file types
> commonly found on systems, with similar characteristics regarding
> compressibility.
>
> - document-like (structured binary), ie. pdf, "office type of documents"
>
> - executable-like (/bin/*, libraries)
>
> - (maybe more)

I'll do some more tests with different data.

> Anything else can be considered incompressible, all the formats with
> internal compression or very compact binary format that is beyond the
> capabilities of the in-kernel implementation and its limitations.
>
> >               copy wall time  sync wall time  usage   ratio | copy wall time  sync wall time  usage   ratio
> > ==============================================================+===============================================
> > level -15     0m0,261s        0m0,329s        141M    100%  | 0m2,511s        0m2,794s        598M    40%  |
> > level -14     0m0,145s        0m0,291s        141M    100%  | 0m1,829s        0m2,443s        581M    39%  |
> > level -13     0m0,141s        0m0,289s        141M    100%  | 0m1,832s        0m2,347s        566M    38%  |
> > level -12     0m0,140s        0m0,291s        141M    100%  | 0m1,879s        0m2,246s        548M    37%  |
> > level -11     0m0,133s        0m0,271s        141M    100%  | 0m1,789s        0m2,257s        530M    35%  |
>
> I found an old mail asking ZSTD people which realtime levels are
> meaningful, the -10 was mentioned as a good cut-off. The numbers above
> confirm that although this is on a small sample.

The limit is really arbitrary. We may as well not even set one and
leave it to the user. It's not like we allocate additional memory or
any other resources.

> > level -10     0m0,146s        0m0,318s        141M    100%  | 0m1,769s        0m2,228s        512M    34%  |
> > level  -9     0m0,138s        0m0,288s        141M    100%  | 0m1,869s        0m2,304s        493M    33%  |
> > level  -8     0m0,146s        0m0,294s        141M    100%  | 0m1,846s        0m2,446s        475M    32%  |
> > level  -7     0m0,151s        0m0,298s        141M    100%  | 0m1,877s        0m2,319s        457M    30%  |
> > level  -6     0m0,134s        0m0,271s        141M    100%  | 0m1,918s        0m2,314s        437M    29%  |
> > level  -5     0m0,139s        0m0,307s        141M    100%  | 0m1,860s        0m2,254s        417M    28%  |
> > level  -4     0m0,153s        0m0,295s        141M    100%  | 0m1,916s        0m2,272s        391M    26%  |
> > level  -3     0m0,145s        0m0,308s        141M    100%  | 0m1,830s        0m2,369s        369M    24%  |
> > level  -2     0m0,150s        0m0,294s        141M    100%  | 0m1,841s        0m2,344s        349M    23%  |
> > level  -1     0m0,150s        0m0,312s        141M    100%  | 0m1,872s        0m2,487s        332M    22%  |
> > level   1     0m0,142s        0m0,310s        141M    100%  | 0m1,880s        0m2,331s        290M    19%  |
> > level   2     0m0,144s        0m0,286s        141M    100%  | 0m1,933s        0m2,266s        288M    19%  |
> > level   3     0m0,146s        0m0,304s        141M    100%  | 0m1,966s        0m2,300s        276M    18% *|
> > level   4     0m0,146s        0m0,287s        141M    100%  | 0m2,173s        0m2,496s        275M    18%  |
> > level   5     0m0,146s        0m0,304s        141M    100%  | 0m2,307s        0m2,728s        261M    17%  |
> > level   6     0m0,138s        0m0,267s        141M    100%  | 0m2,435s        0m3,151s        253M    17%  |
> > level   7     0m0,142s        0m0,301s        141M    100%  | 0m2,274s        0m3,617s        251M    16%  |
> > level   8     0m0,136s        0m0,291s        141M    100%  | 0m2,066s        0m3,913s        249M    16%  |
> > level   9     0m0,134s        0m0,283s        141M    100%  | 0m2,676s        0m4,496s        247M    16%  |
> > level  10     0m0,151s        0m0,297s        141M    100%  | 0m2,424s        0m5,102s        247M    16%  |
> > level  11     0m0,149s        0m0,296s        141M    100%  | 0m3,485s        0m7,803s        245M    16%  |
> > level  12     0m0,144s        0m0,304s        141M    100%  | 0m3,954s        0m9,067s        244M    16%  |
> > level  13     0m0,148s        0m0,319s        141M    100%  | 0m5,350s        0m13,307s       247M    16%  |
> > level  14     0m0,145s        0m0,296s        141M    100%  | 0m6,916s        0m18,218s       238M    16%  |
> > level  15     0m0,145s        0m0,293s        141M    100%  | 0m8,304s        0m24,675s       233M    15%  |
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> > Checking the ZSTD workspace memory sizes it looks like sharing
> > the level 1 workspace with all the fast modes should be safe.
> > >From the debug printf output:
> >
> >                                  level_size  max_size
> > [   11.032659] btrfs zstd ws: -15  926969  926969
>
> Yeah the level 1 should have enough memory, I think there are some
> tricks inside ZSTD to reduce the requirements on the dictionary so
> almost 1MiB is quite excessive (not only for the realtime levels), as we
> do only 128K at a time anyway.
>
> > [   11.032662] btrfs zstd ws: -14  926969  926969
> > [   11.032663] btrfs zstd ws: -13  926969  926969
> > [   11.032664] btrfs zstd ws: -12  926969  926969
> > [   11.032665] btrfs zstd ws: -11  926969  926969
> > [   11.032665] btrfs zstd ws: -10  926969  926969
> > [   11.032666] btrfs zstd ws:  -9  926969  926969
> > [   11.032666] btrfs zstd ws:  -8  926969  926969
> > [   11.032667] btrfs zstd ws:  -7  926969  926969
> > [   11.032668] btrfs zstd ws:  -6  926969  926969
> > [   11.032668] btrfs zstd ws:  -5  926969  926969
> > [   11.032669] btrfs zstd ws:  -4  926969  926969
> > [   11.032670] btrfs zstd ws:  -3  926969  926969
> > [   11.032670] btrfs zstd ws:  -2  926969  926969
> > [   11.032671] btrfs zstd ws:  -1  926969  926969
> > [   11.032672] btrfs zstd ws:   1  943353  943353
> > [   11.032673] btrfs zstd ws:   2 1041657 1041657
> > [   11.032674] btrfs zstd ws:   3 1303801 1303801
> > [   11.032674] btrfs zstd ws:   4 1959161 1959161
> > [   11.032675] btrfs zstd ws:   5 1697017 1959161
> > [   11.032676] btrfs zstd ws:   6 1697017 1959161
> > [   11.032676] btrfs zstd ws:   7 1697017 1959161
> > [   11.032677] btrfs zstd ws:   8 1697017 1959161
> > [   11.032678] btrfs zstd ws:   9 1697017 1959161
> > [   11.032679] btrfs zstd ws:  10 1697017 1959161
> > [   11.032679] btrfs zstd ws:  11 1959161 1959161
> > [   11.032680] btrfs zstd ws:  12 2483449 2483449
> > [   11.032681] btrfs zstd ws:  13 2632633 2632633
> > [   11.032681] btrfs zstd ws:  14 3277111 3277111
> > [   11.032682] btrfs zstd ws:  15 3277111 3277111
> >
> > Hence the implementation uses `zstd_ws_mem_sizes[0]` for all negative levels.
> >
> > I also plan to update the `btrfs fi defrag` interface to be able to use
> > these levels (or any levels at all).
> >
> > @@ -332,8 +335,9 @@ void zstd_put_workspace(struct list_head *ws)
> >               }
> >       }
> >
> > -     set_bit(workspace->level - 1, &wsm.active_map);
> > -     list_add(&workspace->list, &wsm.idle_ws[workspace->level - 1]);
> > +     level = max(0, workspace->level - 1);
>
> This seems to be a quite frequent pattern how to adjust the level,
> please create a helper for that so it's not the plain max() everywhere.

Ok.

> > +     set_bit(level, &wsm.active_map);
> > +     list_add(&workspace->list, &wsm.idle_ws[level]);
> >       workspace->req_level = 0;

