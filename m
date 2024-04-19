Return-Path: <linux-btrfs+bounces-4429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D88AAD97
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 13:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6951F2231A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903768173C;
	Fri, 19 Apr 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi08sQSz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B881216
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525605; cv=none; b=iAu46OBNQolT5gHfgtDLzSmbJGO8syVDo4PvOz1WUD7K+fSRVBo+11bDi1LDJola+PdRcuqMh1MtQujm6uWf9DKCwiiM1IqkM09o7KR6+FjNL/gsQgb+p+N8Xts9+y3kLJnk08aeSC5r+tR4FPQLMaONYq3CbK/zd3cB/6d4OwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525605; c=relaxed/simple;
	bh=mktiCish+J1HSRKFbSaapZ4fYqx9KPYceUC1NkqYz1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A02fsrMPAfwWnUBU9aUFeUdvnnDhjA+/fbwvOwzbcosEoCqVCDyREvocMk2rbT3lZylZ8tMFUHM3Bh3k4CKtJAO5ipKyQwFz6fVGhzjJYkUJoWkWOud9Pv2HeIVJEBF4ygdJDdznirSLG6gJYmJX/wxbtvbNklE4UvIG5INWIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi08sQSz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dba429a246so2538211fa.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713525602; x=1714130402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hFxoNiTWa8Z1FFER0fWsZSS4qwY6drEiUAvzlBQB40=;
        b=fi08sQSzSZd2/RVlG+9+5EtKlgpiD/RbzWz0b15EGD6OCRWMQqAAt4uQECWfeWCH3K
         1cYU6V/56KUHmfqyBTEYPGv6r1P+OnRpEkRWtA6QIyNxj0esnJmeCFHFmhcTcSxoSAoq
         qI3RAVoaUv1EAkN6K5U3gdf8NafA1i5+Po8drqZRLSinZENd3WBC8I60aPqDkTufmrO4
         ylCFLsBvKiNfEZUWEnLVAY9SQCI5rKjLNQHZnBQLx1piwbYmvlN4ezmSJbeDM7PalqBw
         N2V0ZlWGJWLjEAF5gnhg2ghQiXtBPXNyMP69FNBFx02nW65p9jpK8xs/gmvZk5uFWx4I
         P/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713525602; x=1714130402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hFxoNiTWa8Z1FFER0fWsZSS4qwY6drEiUAvzlBQB40=;
        b=CSKRQhxWF6sxDDr7sWhSUdyX9eo4wOK8tLkHI3asZ3x9ivwCTsgAQv4CXLDmJmI+rh
         QHHdKxp7bP9jLDphriymOcQNdBOo9tf1hr1lzfG7AlKVZdA10Agl7yAd7Xll6Bh3joN1
         j5gndAzFMnkx3sT03jBONEfTR3JQLwqAuh6w+cfXi642kr7ybiuQrLrw7hjWMTveRYGK
         SuQOsR6X07AkJHI2lH4fqm/lHEQ2GJS9gGYEPmVBTA74EbdzphYjiYgCQ3O9g5pY7KwF
         xwiReeRnqpZgGl2Coa+IBNy4U7Oz8c4GeuOmDoXadN+iova7+Pg8G8bFZokNmFgTJcUO
         xvow==
X-Gm-Message-State: AOJu0YweVDkPahww21IdXrd2UFhI1H6OwQJCBbTAY0ihc7vBDv5BwYyv
	WfzSQdEwHYSq3HRk+jTP2osndNfy8Fi0ovN3NzgJP+sH/0yOBdNxYMvb7juTXFWCyJ4Hx7bc7YB
	KbRKq4H8NlS12CmI0U0a/bz2o5l37vw==
X-Google-Smtp-Source: AGHT+IHg0zxFR5cGE5SvuRBIPsSgI1FLSaL4r3MW3ra+k4VWO9BFNUNKE9brUwJZcIBAWbVE8aWHIjoZuaMSOEQZAVs=
X-Received: by 2002:a05:6512:3281:b0:519:2e3d:213 with SMTP id
 p1-20020a056512328100b005192e3d0213mr988736lfe.5.1713525601938; Fri, 19 Apr
 2024 04:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b996820e-efa5-4fb5-ba4e-57cc295c1b64@gmail.com>
In-Reply-To: <b996820e-efa5-4fb5-ba4e-57cc295c1b64@gmail.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Fri, 19 Apr 2024 14:19:50 +0300
Message-ID: <CAA91j0VmxAE=XmCPJwT9m6YXKJzDKtP-+vpcTXbp=_=fROyqnA@mail.gmail.com>
Subject: Re: support request: btrfs df reports drive is out of space, cannot
 find what occupies it
To: Skirnir Torvaldsson <skirnir.torvaldsson@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:40=E2=80=AFAM Skirnir Torvaldsson
<skirnir.torvaldsson@gmail.com> wrote:
>
> Dear btrfs experts,
>
> Could you please help me sort out the following situation:
>
> btrfs df reports my 100Gb device is almost out of space (which agrees wit=
h the results produced by the standard "df"):
>
> root@next:/home/support# btrfs fi df /
> Data, single: total=3D82.00GiB, used=3D78.23GiB
> System, DUP: total=3D32.00MiB, used=3D16.00KiB
> Metadata, DUP: total=3D1.00GiB, used=3D153.70MiB
> GlobalReserve, single: total=3D68.45MiB, used=3D0.00B
> root@next:/home/support# df -h /
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sda3        96G   79G   16G  84% /
>
> However  when I try to locate files to delete with du that's what I get:
>
> root@next:/home/support# du -hd1 /
> 70M     /boot
> 0       /dev
> 2.2G    /.snapshots
> 14M     /bin
> 4.5M    /etc
> 2.5M    /home
> 348M    /lib
> 4.0K    /lib64
> 0       /media
> 0       /mnt
> 0       /opt
> 0       /proc
> 40K     /root
> 2.7M    /run
> 12M     /sbin
> 0       /srv
> 0       /sys
> 0       /tmp
> 566M    /usr
> 5.0G    /var
> 29G     /next
> 38G     /
>
> I.e. almost 40Gb just gone somewhere.

Huh?

2.2G + 5.0G + 29G + 38G =3D=3D 75.2G out of 78G reported for DATA. What
40G are you talking about?

If you have some other mount points, you could start with explaining
your storage layout first.

> Am I doing something wrong? Is there a problem or a piece of theory I'm m=
issing? Kindly advice.
>
> +++++++++++++++++++++++++++++++++++++
> root@next:~#  uname -a
> Linux next 5.10.0-28-amd64 #1 SMP Debian 5.10.209-2 (2024-01-31) x86_64 G=
NU/Linux
> root@next:~#  btrfs --version
> btrfs-progs v5.10.1
> root@next:~#  btrfs fi show
> Label: 'NEXT_ROOTFS'  uuid: abc71bdb-c570-461d-a28a-54294a646089
>         Total devices 1 FS bytes used 78.37GiB
>         devid    1 size 95.46GiB used 84.06GiB path /dev/sda3
>
> root@next:~#  btrfs fi df /
> Data, single: total=3D82.00GiB, used=3D78.22GiB
> System, DUP: total=3D32.00MiB, used=3D16.00KiB
> Metadata, DUP: total=3D1.00GiB, used=3D153.64MiB
> GlobalReserve, single: total=3D68.45MiB, used=3D0.00B
>

