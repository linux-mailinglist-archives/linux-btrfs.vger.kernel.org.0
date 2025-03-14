Return-Path: <linux-btrfs+bounces-12287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7842A61AB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 20:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E14519C6B9E
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F7115749C;
	Fri, 14 Mar 2025 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/UCaiUF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5371553BC
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980781; cv=none; b=COXxJoijjbjmGC54cw9dbIeqdcYWk6tf473Hs5BX3wW0Vu6Q7ei+aikH6Pevy4W7HCG/g9//6G2+lfXgGn4JYG5FdHPq0gBzq3fJyhcRvAgMjHYw652HSf8sivMqLKES+C3jZK90GN4kYswcaSpMSUYaqx3Tq5RG4LYB4h7pILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980781; c=relaxed/simple;
	bh=4sxI9LwDANHW1jKoLIm2r461hYtifvWVHhZkZ4mMKt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nc0+R85uivco0OrmO7pZx8GOxKKXx+TFkpHtVm/ZSlz56aXqBKh5+KTt2pidWZls/GUG1VPliYUWU0jNMuvjWBAFRt1a61rDYTXh+d8aFgVGMRPc/lLKnTeYDBl88Yvi8tfe8914d4zQb8nUXY1bEySEnORzKKsHY8G6Y4rNe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/UCaiUF; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f916e75fso40496946d6.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741980777; x=1742585577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6SqXOGFceBeoD6WRbe1CX0cVESIZ4I1RE6ksDkcnA4=;
        b=h/UCaiUFZ9MeyA7+GrWTH31GoRX8a3A+IhTFeKH9VbS16bb0v0/mAiVUhFcDgcjZvM
         J06dqdS7lnVLfHyiTov05fVcgkmydV9YVoWYsSzsN+X/di27cUfkVj5rFmkCnZDlHqf0
         ecsXE0ruQYGjxzDzUyV63z6zezQuuC0IujXt4guqIoBMyiCv9Ol8YtXUUousYU62YX90
         pLvhJWRgbmeh1ogYWF+6pAQrgXvruFMObDI1+eIjs4R4+xM3CRQAWc1JfAZzUufcHZ9H
         CN5BY5kSqFHOywsfxDAPlO2PQCo8B9O3BcFUh4ukgnCieCTFM+LTFqtEAUORq0zTn52Y
         v2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741980777; x=1742585577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6SqXOGFceBeoD6WRbe1CX0cVESIZ4I1RE6ksDkcnA4=;
        b=dMHse11WhGXhkgDWwJAEcTHlSY2vEPKJiWQsQOCdOYBu9jxE5pPi8fDGg6fuutjINE
         xDhAiS7HPVFE9Uu2vNrK9ql89AjlGvNwOXtx0Rcdb/6TBpWvh+I5SqukooHrNA1ts3Kg
         am4leSLbKtR0Y/zeb5B7YIl8ZPboMr+2JeFcD3NW9hDbNaGcX0LXJoe0f0rQ0yU8bC1M
         876QW5Cm8mwVuPk4YjSjjfIQTfdVzc1AmYgQYl5zRdMe0xUNN1k5HjtFwei2Rw86F2WL
         tbvHk0a568Yk2fRVS6JcMStz1ZTsTtRqwOsFtaLOZ60AhMv5bEor4OkKrMjSykq35A+w
         LLeQ==
X-Gm-Message-State: AOJu0YxQdSgqiC9mbg8CVBi3EKzfjPnO06HVqwlJJYLik64JLIl1GclR
	tBMASbYdbDmLp9ItY5HaO9LF5F0z3BpUDOBYMz0ydudL4GTfJEPm6gFiYgnRJM/Gw2sMHbgcts5
	jsxU+Ovol0tZhprPc+9Xk5Wfrx3g=
X-Gm-Gg: ASbGncsVjRs6FOyZalk8p9K/6KsaH93QxPLzyFXbYwIaoJrxlfo9w9EvP6/XkscsqLb
	x6o2PyhGYx+Zz35HsYkNe/5A5tTdWxr88To/v7JqFPZ1cnn4+bEx5/XkpyUetHSWi7XMWM4AIHW
	LgksOV9Vlo9EWD5CWAr2Uod0a0Kos=
X-Google-Smtp-Source: AGHT+IGi1mBF3GK2JV1c9Y9IlMaScxi6YzLWxlmRGm7iWvH4VE9mT1PpVUwCsNb3wS2aSENGO6D+TmO3P4r6+OazwJY=
X-Received: by 2002:a05:6214:4497:b0:6e4:540b:5352 with SMTP id
 6a1803df08f44-6eaddfbb865mr125067206d6.16.1741980777076; Fri, 14 Mar 2025
 12:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23840777.EfDdHjke4D@xev> <0bedb9d8-0924-4c19-a5d1-9951b04f2781@suse.com>
 <1924801.tdWV9SEqCh@xev> <3349775.aeNJFYEL58@xev>
In-Reply-To: <3349775.aeNJFYEL58@xev>
From: Thiago Ramon <thiagoramon@gmail.com>
Date: Fri, 14 Mar 2025 16:32:46 -0300
X-Gm-Features: AQ5f1Jp7pBDAL_sVdIVp4SlljhnTV5PdFTXXevuQ3JaSyGURS81ZHIVOmHSOQBE
Message-ID: <CAO1Y9wpT=gZgWD0=69TUefB-+qOSEY+9+zypo89PMQdgdO_P9w@mail.gmail.com>
Subject: Re: strangely uncorrectable errors with RAID-5
To: russell@coker.com.au
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:54=E2=80=AFPM Russell Coker <russell@coker.com.au=
> wrote:
>
> On Friday, 14 March 2025 23:27:51 AEDT Russell Coker wrote:
> > Just to see if anything had changed I ran the same tests with RAID-5 da=
ta
> > and metadata again with the Debian kernel 6.12.17-amd64 and this time g=
ot
> > properly uncorrectable errors in less than a minute.  I don't know if t=
he
> > error happened faster and worse than before because of some kernel
> > difference, luck, or some timing difference when running on different
> > hardware.
>
> I did it again but with RAID-5 data and RAID-1 metadata and it took a few
> hours this time but again got to an uncorrectable state.
>
> [15653.298999] BTRFS warning (device vdc): checksum error at logical
> 5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) =
in
> tree 5
> [15653.299001] BTRFS error (device vdc): unable to fixup (regular) error =
at
> logical 5157748736 on dev /dev/vdc physical 1673199616
> [15653.299002] BTRFS warning (device vdc): checksum error at logical
> 5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) =
in
> tree 5
> [15653.299003] BTRFS error (device vdc): unable to fixup (regular) error =
at
> logical 5157748736 on dev /dev/vdc physical 1673199616
> [15653.299005] BTRFS warning (device vdc): checksum error at logical
> 5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) =
in
> tree 5
> [15653.299006] BTRFS error (device vdc): unable to fixup (regular) error =
at
> logical 5157748736 on dev /dev/vdc physical 1673199616
> [15653.299007] BTRFS warning (device vdc): checksum error at logical
> 5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) =
in
> tree 5
> [15653.299009] BTRFS error (device vdc): unable to fixup (regular) error =
at
> logical 5157748736 on dev /dev/vdc physical 1673199616
> [15653.299010] BTRFS warning (device vdc): checksum error at logical
> 5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) =
in
> tree 5
>
> Below is the script that broke it.
>
> #!/bin/bash
> set -e
> while true ; do
>   for DEV in c d e f ; do
>     dd if=3D/dev/zero of=3D/dev/vd$DEV oseek=3D$((20+$RANDOM%3*1000)) bs=
=3D1024k
> count=3D1000
>     sync
>     btrfs scrub start -B /mnt
>     sync
>   done
>   date
> done
Your script is writing randomly to ALL your disks. You just need to
get lucky for them to overwrite the same sector in 2 different disks
to ruin RAID5 and RAID1. If you want to stress test the filesystem you
need to pay more attention to what you're doing.
>
> --
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
>
>
>
>

