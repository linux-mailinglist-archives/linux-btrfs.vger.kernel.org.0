Return-Path: <linux-btrfs+bounces-18792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DBAC3E13D
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 02:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D4904E1F36
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 01:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587092F0685;
	Fri,  7 Nov 2025 01:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stanfordalumni.org header.i=@stanfordalumni.org header.b="Fs5SO/Y9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F272D7DC8
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477477; cv=none; b=IDB3UAqrjWDxxK7/RiZZSkM5NHpn/Z2Pyr8L3WKGVaQowUln9IlI1jxTwcrD/Ii1wwvlFQySxOd6GXX1JfkCYkYEIZZ8PURGB+MWKnkJ3uK/yTscHVWghAdQA1mZIVblcpBccg19uC0AVdfc7R7/j7wl1XhE9zfhNdjabgXztas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477477; c=relaxed/simple;
	bh=qWHHa1wThcPrdduolocOglUUSf055MkIH6Y6/jLQvJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JY4G3IZbxTPuDkCRlzYU7md8ZoyL/YgeFlWSqdedIVPsGy7cPBn3JSzL6MqnbCOmUybgEAH1aE5z7/+Qu2F/W3kpOqlqzKCmduRQjhWVKkCQQSh2Ez2fZovnwnJiZ5Co5RIdgvPnOnbMNKZjeHtwnGUR8Dyos7dFg05Ok3QN7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stanfordalumni.org; spf=pass smtp.mailfrom=alumni.stanford.edu; dkim=pass (1024-bit key) header.d=stanfordalumni.org header.i=@stanfordalumni.org header.b=Fs5SO/Y9; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stanfordalumni.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alumni.stanford.edu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ea0d71f607so357231cf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 17:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stanfordalumni.org; s=google; t=1762477474; x=1763082274; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+ctgPMHWw5CQGpfsa9E7MdJUM/MqkST1g4PK080MFw=;
        b=Fs5SO/Y9MXTMta5PG8oLz3832Ob5Dbg2d2BSMe4sVEAEAtjWkVbyliisl96/4TBEmj
         3spD+RVknAPAO1uJbkgaAj1FMDdkJB50FUh274BKtTkNzEiRktmlb6+/qss7grbRxS11
         P9vi0J1O+4gwNVf49wdSnF/jND2gZR9cXlBQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477474; x=1763082274;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+ctgPMHWw5CQGpfsa9E7MdJUM/MqkST1g4PK080MFw=;
        b=IKIIRLi66voxP477hc7VcsSjtus995M/rcciSnlgrXUxyqdw0HTICKQna2SnMj9XCH
         uu97UMLsL+85Igw03Mbs9Vb7xJv0Yb0sMPdTgWHTyuABzALXSrQSHOXy3PfQv59L0j81
         oFclDn7cA9KRv1wxadxOqcL+/igz9azKPhgC54B13pUjq4sqVrjNL6TysYX96vFQdlqU
         33oWjcrReEUW1peYxsIPrlODJnCzSPv2kbv8PbGMNCeQLdowAY8hPKNpUnXhRe18ElhJ
         t8UkFyaXs9hbdMBSBXQIydjGXWb1pJBsc1a4ozZYSjs69uYTvZM0o+1EGTq2CMbVJ5WA
         7P3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAf856+in6Hk2JOGytgeBVexpdfP0Rmnb6wyhDVzjEmBVZXg1aoHvxlgAreISPtvqaT3a+UckdBwTrxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGR3hPQW5Pc9GZcsvQpErraqyGurTIpLDyi/YY2YjjQoK9E4W
	TW+nW7JW/kv6bNw2nhNjGAPy9/YMBG/uosI1YfzaSaN8veJZr00QvsPnIX+gtMQMWSdVvjsulKo
	phQikAtErNJSmzaJw0akcZQgWwZq5HY9yfj1mSu2ur4Zf7VdadjLTksB2
X-Gm-Gg: ASbGnctN9Zqrg/QkukyqrlAWS85NVzgh8+oyxtDoBwmfAve+VLpZXrQuUYS5lMI2cCD
	Zu6IMULHM/gQZxSdGOHFbgmIU44b0O6v9a1KOhgCSHhJp5EB8fR393awua8eQ+h49ENCx9FM27s
	LWZL40B+Z6aJm60s4fxWkYH0lcGIV0kiwuuHcdgnhwIvapSNbVeh7mVBdZUnOsnaz4yUHezAEk3
	TOHFjgt3ujT3jA6MG/W1ihLRmNMtHFLlHCFpP/RPwijTc+w4oaZPYp/f7o=
X-Google-Smtp-Source: AGHT+IGmKIWH+MS5NxQOd8Z64RfcBL0IFnnYxX3VjDQS6hQy0OhVPCyMe3HABArg5TFiU9ffyPZ1TpO67ZDaMDRrHLc=
X-Received: by 2002:a05:622a:1195:b0:4ed:7ce:8497 with SMTP id
 d75a77b69052e-4ed9497dd8bmr13791251cf.3.1762477473852; Thu, 06 Nov 2025
 17:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3NTRCBV0jTPrHb_tmWzdrLqx9xnvKpcqA7-_Cxm9TfJAGGSQ@mail.gmail.com>
 <20251028001329.GA3148826@zen.localdomain>
In-Reply-To: <20251028001329.GA3148826@zen.localdomain>
From: Ross Boylan <rossboylan@stanfordalumni.org>
Date: Thu, 6 Nov 2025 17:04:21 -0800
X-Gm-Features: AWmQ_bl11x9C0SZJETZi-LPoJ7aX6GB-q_AZTPGu32Jet9xus3Vl7dYsWlbLs84
Message-ID: <CAK3NTRAhxaHU4Mh3vz9VWnonDS7dFjVvC0fnYhz0kH5Lrqorfg@mail.gmail.com>
Subject: Re: btrfs fragmentation
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Answers below

On Mon, Oct 27, 2025 at 5:13=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Mon, Oct 27, 2025 at 03:40:59PM -0700, Ross Boylan wrote:
> > When recording over-the-air television the results are typically very
> > fragmented when saved to btrfs, e.g., several thousand segments for
> > 6GB.
> > This occurred even on a large, nearly empty, filesystem of 5.5TB.
> > Automatic defragmentation doesn't seem to make much difference,
> > although manual defragmentation does.
>
> Our max extent size is 128MiB which gives a best case of 48 extents, I
> believe. Is that what you get after you do the manual defrag? If there
> is compression (I think you said there isn't, but doesn't hurt to check
> with compsize on the file..) that maximum is 128KiB in which case we
> would expect ~50k extents for a 6GiB file.
>
Here's a test for a file originally reported as 3931 extents by filefrag.
# btrfs filesystem defrag -t 128M
/usr/local/myth26/media26/10501_20251031040000.ts
filefrag now reports 35 extents.
Checking
# compsize /usr/local/myth26/media26/10501_20251031040000.ts
Processed 1 file, 70 regular extents (70 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      5.6G         5.6G         5.6G
none       100%      5.6G         5.6G         5.6G

I'm not sure why one is 35 and the other is 70.  Also, I've been
assuming extents are
not contiguous; maybe they can be?

No compression, as seen above.  I tried compression and it seemed to
make no difference;
I guess that the video streams are already compressed.  The file
command says the file is a
"MPEG transport stream data".

BTW, I've tended to use filefrag because it gives reports on
individual files if I say `filefrag *.ts`
while compsize only gives me the total.  In a few spot checks they've
been close, but clearly in
this case the difference is significant.
> >
> > I first noticed the fragmentation when I started getting messages that
> > the writes were taking a long time, although I have not seen those
> > recently.
> >
> > It seems this application (the one recording the TV) may not be a good
> > fit for btrfs.  The developers recommend xfs, but it would be nice to
> > have the
> > more flexible volume management of btrfs.
>
> Have you been able to try with xfs?
Yes. It seemed fine.  Channel 5.1 gives the biggest recordings.  On
btrfs they range from
2090 through 4019 extents (filefrag), and all the lower values were
for half hour recordings.

On xfs, files from the same channel range from 7 to 822 extents.
Those files are mostly
shorter (3G) than the longest ones on btrfs, but one is 11G (almost
double the largest
on btrfs) and has only 195 extents.
>
>
> If you are able, some kind of trace of what is going on when you run the
> program would be helpful. strace would be a good start, I think. I can
> give you some useful bpftrace scripts to try too, but who knows if they
> will work on your old kernel :)
>
I'm concerned that would generate a flood of information since the program,
I assume, is more or less constantly writing to disk.  I see strace has an
option to attach to an existing process, which will at least make it easier
to get to the right process (myth is started as service, and in turn spawns
other processes).

I attached strace for a minute while recording.  Here's the first part
of the log.  It's long enough to
capture some recvfrom and sendto; at least some of the latter is
clearly directed to the database,
not to the file with the recording.  I think it writes time stamp sync
information (not disk syncs) to
the database as it reads the stream.
--------------------------------------------------------------------
restart_syscall(<... resuming interrupted read ...>) =3D 1
read(3, "\5\0\0\0\0\0\0\0", 16)         =3D 8
write(59, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D -1 EAGAIN
(Resource temporarily unavailable)
write(80, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D -1 EAGAIN
(Resource temporarily unavailable)
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D32,
events=3DPOLLIN}, {fd=3D33, events=3DPOLLIN}, {fd=3D34, events=3DPOLLIN},
{fd=3D35, events=3DPOLLIN}, {fd=3D36, events=3DPOLLIN}, {fd=3D37,
events=3DPOLLIN}, {fd=3D44, events=3DPOLLIN}, {fd=3D51, events=3DPOLLIN},
{fd=3D52, events=3DPOLLIN}], 11, 349) =3D 0 (Timeout)
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D32,
events=3DPOLLIN}, {fd=3D33, events=3DPOLLIN}, {fd=3D34, events=3DPOLLIN},
{fd=3D35, events=3DPOLLIN}, {fd=3D36, events=3DPOLLIN}, {fd=3D37,
events=3DPOLLIN}, {fd=3D44, events=3DPOLLIN}, {fd=3D51, events=3DPOLLIN},
{fd=3D52, events=3DPOLLIN}], 11, 24999) =3D 1 ([{fd=3D3, revents=3DPOLLIN}]=
)
read(3, "\5\0\0\0\0\0\0\0", 16)         =3D 8
write(59, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D -1 EAGAIN
(Resource temporarily unavailable)
write(80, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D -1 EAGAIN
(Resource temporarily unavailable)
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D32,
events=3DPOLLIN}, {fd=3D33, events=3DPOLLIN}, {fd=3D34, events=3DPOLLIN},
{fd=3D35, events=3DPOLLIN}, {fd=3D36, events=3DPOLLIN}, {fd=3D37,
events=3DPOLLIN}, {fd=3D44, events=3DPOLLIN}, {fd=3D51, events=3DPOLLIN},
{fd=3D52, events=3DPOLLIN}], 11, 24151) =3D 1 ([{fd=3D3, revents=3DPOLLIN}]=
)
read(3, "\5\0\0\0\0\0\0\0", 16)         =3D 8
write(59, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D 0
write(80, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D32,
events=3DPOLLIN}, {fd=3D33, events=3DPOLLIN}, {fd=3D34, events=3DPOLLIN},
{fd=3D35, events=3DPOLLIN}, {fd=3D36, events=3DPOLLIN}, {fd=3D37,
events=3DPOLLIN}, {fd=3D44, events=3DPOLLIN}, {fd=3D51, events=3DPOLLIN},
{fd=3D52, events=3DPOLLIN}], 11, 15343) =3D 1 ([{fd=3D3, revents=3DPOLLIN}]=
)
read(3, "\5\0\0\0\0\0\0\0", 16)         =3D 8
write(59, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D -1 EAGAIN
(Resource temporarily unavailable)
write(80, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D32,
events=3DPOLLIN}, {fd=3D33, events=3DPOLLIN}, {fd=3D34, events=3DPOLLIN},
{fd=3D35, events=3DPOLLIN}, {fd=3D36, events=3DPOLLIN}, {fd=3D37,
events=3DPOLLIN}, {fd=3D44, events=3DPOLLIN}, {fd=3D51, events=3DPOLLIN},
{fd=3D52, events=3DPOLLIN}], 11, 14077) =3D 1 ([{fd=3D3, revents=3DPOLLIN}]=
)
read(3, "\5\0\0\0\0\0\0\0", 16)         =3D 8
write(59, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D 0
write(80, "\1\0\0\0\0\0\0\0", 8)        =3D 8
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D32,
events=3DPOLLIN}, {fd=3D33, events=3DPOLLIN}, {fd=3D34, events=3DPOLLIN},
{fd=3D35, events=3DPOLLIN}, {fd=3D36, events=3DPOLLIN}, {fd=3D37,
events=3DPOLLIN}, {fd=3D44, events=3DPOLLIN}, {fd=3D51, events=3DPOLLIN},
{fd=3D52, events=3DPOLLIN}], 11, 5337) =3D 1 ([{fd=3D3, revents=3DPOLLIN}])
read(3, "\5\0\0\0\0\0\0\0", 16)         =3D 8
write(59, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D -1 EAGAIN
(Resource temporarily unavailable)
write(80, "\1\0\0\0\0\0\0\0", 8)        =3D 8
futex(0x7ffc20b3ea30, FUTEX_WAIT_PRIVATE, 0, NULL) =3D -1 EAGAIN
(Resource temporarily unavailable)
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D32,
events=3DPOLLIN}, {fd=3D33, events=3DPOLLIN}, {fd=3D34, events=3DPOLLIN},
{fd=3D35, events=3DPOLLIN}, {fd=3D36, events=3DPOLLIN}, {fd=3D37,
events=3DPOLLIN}, {fd=3D44, events=3DPOLLIN}, {fd=3D51, events=3DPOLLIN},
{fd=3D52, events=3DPOLLIN}], 11, 4073) =3D 0 (Timeout)
sendto(9, "8\0\0\0\26DELETE FROM settings WHERE "..., 60,
MSG_DONTWAIT|MSG_NOSIGNAL, NULL, 0) =3D 60
recvfrom(9, 0x55617dcaaa90, 16384, MSG_DONTWAIT, NULL, NULL) =3D -1
EAGAIN (Resource temporarily unavailable)
poll([{fd=3D9, events=3DPOLLIN}], 1, 300000) =3D 1 ([{fd=3D9, revents=3DPOL=
LIN}])
recvfrom(9, "\f\0\0\1\0\35
\0\0\0\0\2\0\0\0\0\30\0\0\2\3def\0\0\0\1?\0\0\f"..., 16384,
MSG_DONTWAIT, NULL, NULL) =3D 81
sendto(9, "\5\0\0\0\32\35 \0\0", 9, MSG_DONTWAIT|MSG_NOSIGNAL, NULL, 0) =3D=
 9
recvfrom(9, 0x55617dcaaa90, 16384, MSG_DONTWAIT, NULL, NULL) =3D -1
EAGAIN (Resource temporarily unavailable)
poll([{fd=3D9, events=3DPOLLIN}], 1, 300000) =3D 1 ([{fd=3D9, revents=3DPOL=
LIN}])
recvfrom(9, "\7\0\0\1\0\0\0\2\0\0\0", 16384, MSG_DONTWAIT, NULL, NULL) =3D =
11
sendto(9, "/\0\0\0\27\35
\0\0\0\1\0\0\0\0\1\376\0\376\0\27MusicStream"..., 51,
MSG_DONTWAIT|MSG_NOSIGNAL, NULL, 0) =3D 51
recvfrom(9, 0x55617dcaaa90, 16384, MSG_DONTWAIT, NULL, NULL) =3D -1
EAGAIN (Resource temporarily unavailable)
poll([{fd=3D9, events=3DPOLLIN}], 1, 300000) =3D 1 ([{fd=3D9, revents=3DPOL=
LIN}])
recvfrom(9, "\7\0\0\1\0\0\0\2\0\0\0", 16384, MSG_DONTWAIT, NULL, NULL) =3D =
11
sendto(9, "\5\0\0\0\31\35 \0\0", 9, MSG_DONTWAIT|MSG_NOSIGNAL, NULL, 0) =3D=
 9
sendto(9, ";\0\0\0\26SELECT data FROM settings W"..., 63,
MSG_DONTWAIT|MSG_NOSIGNAL, NULL, 0) =3D 63
-----------------------------------------------------------------------

On a quick look, it continues in that way.  The string sync is not
there, (case-insensitive).
Maybe this indicates it's writing to the file 8 bytes at a time?

> The important things to get to the bottom of are:
> - does mythtv try to fallocate the file ahead?
> - does mythtv do random writes as opposed to sequentially appending?
>   From glancing at the code I could find online, it looks like no..
> - how often does mythtv sync/fsync
> - is something else on your system forcing frequent writeback (memory
>   pressure, vm knobs, etc..)
>

I thought btrfs didn't do advance allocation of space.
I assume, but do not know, that myth simply dumps the stream and never
goes back to rewrite anything.

So I take it your thought is that syncs are screwing up the ability of
btrfs to accumulate
data and put it out in bigger chunks?

The disk holding the filesystem only has the myth directory on it, and
so I don't think
any other application would be doing a sync on it, unless it's some general=
 OS
housekeeping.

Ross

> In theory it should be quite possible to get btrfs to pile up a decent
> amount of delayed allocations for dirty pages and allocate them all at
> once quite contiguously when doing the writeback. This assumes:
> 1. we get to build up some good delayed allocations
> 2. there are big contiguous chunks of free space (as you mentioned in
>    your next paragraph, this is a concern, but you said it reproduces on
>    a fresh system)
>
> So unfortunately, the devil is in the details with issues like this one.
>
> > However, I've noticed that even when I cp a complete file to btrfs it
> > ends up pretty fragmented, albeit the target filesystem in that case
> > was very full.
>
> If you can reproduce with a simpler program than mythtv on your empty
> fs on the same system, that could be interesting, too. Worth a shot.

I tried the following:
# dd if=3D10501_20251028025900.ts of=3Dtest.tst bs=3D8 count=3D10000
10000+0 records in
10000+0 records out
80000 bytes (80 kB, 78 KiB) copied, 0.133328 s, 600 kB/s
root@barley:/usr/local/myth26/media26# compsize test.tst
Processed 1 file, 1 regular extents (1 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       80K          80K          80K
none       100%       80K          80K          80K

While that clearly shows no problems, doing something larger might
With 100x bigger count, total 8MB, still ended up with "only" 3
segments.  Although, scaled up
to several GB that would be a pretty fragmented file.  Naively, 8GB ->
3000 segments, which is in line
with what I'm seeing for the original files.

Assuming segments are not contiguous it's a little surprising to me
there isn't only a single segment.  Maybe
a result of filling in holes left from previous recordings?  Nothing
else was going on on the filesystem
when I did the dd.

Ross
>
> Thanks,
> Boris

