Return-Path: <linux-btrfs+bounces-6137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F992401B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E591C236EA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85641BA062;
	Tue,  2 Jul 2024 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOXefRw+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9255B1E531;
	Tue,  2 Jul 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929615; cv=none; b=nDf/+fLwyztq/45rKn4gRPnveY+ABgbBxrBeGQnmjRRO85LZSvj16Yi1eD8XTreFhwCmFnUxKQMX+P9Adkas5ZzJsCBk43nDo4aiz9aZ3IBvUtuOmCl2aIN0/gwuX9jryABhDt16uki13a1Bo7JfoaO6BH6P/WQ/jSSR7zTerzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929615; c=relaxed/simple;
	bh=nyiy8AT5jGhchwJjyM4q1iEH8XKHmHgh3pCJbFwSXEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouLBqRXwEtffi78ACHylgX3d6d6OHOHA5elmotV7UAIVAbI47bKD6eYnz3NavvhYgwsQ5JZzdd/aqChR7jhVv2P9STNniOzX19noH0V7uMSIxFMZEs8WiMLVv2xif7uatX5fzBL7/BhU1wL6X4FcDEgXN8kMJ3d9HvY6xx+aOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOXefRw+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b50ab031a6so5700166d6.2;
        Tue, 02 Jul 2024 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719929612; x=1720534412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRkiN3tNig0E9yCGyOzoW9HEt2shQBH+E4YeHpZOoTI=;
        b=AOXefRw+F6PULWI4mkPvtXCKIoLYwAeorVfeYa7OMrL5HdFQuBUvLeyjlm1mJWD2Jk
         2HNESblVU/1MGSNsI8R0AIVsMc0dUF4E9nqDucOpLGDgrh3J0d9R5wO/FuTcEa1GJPjL
         ZYrjUq13VSj62JibyklyO7daCl+155BQooiZFbaExwJRKezP33MSgRHGAnnOKUFPo9GC
         7GFR3FdwgkFWntSS7f73kZr/DfGnHtXGlvZQeg44bzuncuNapOn0RljiVKjFSNd5mh4U
         b4VGeQqp/HKdjhBLQPBsTsCGo6IrDRUJZ6rkpa+EA7X2yPHclN/5Hooz12nsYjoOdxwV
         aYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929612; x=1720534412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRkiN3tNig0E9yCGyOzoW9HEt2shQBH+E4YeHpZOoTI=;
        b=XrSzN8GnJ4YiYj+8uggcIvhaHzeUj8QcaHdAaeT8I+ZbwZ8UQBn9arzLz49YJuyh0q
         J1IIIVey3Di4mogCwKx0S6NHPuY/Xoj9El1YlD+4zfWPXA9zlyiNG9uQ7PuLsJAnZxsv
         t4dhb0dxlM2h1cwqmfpFsrqcimmOSyg9hCznbNP+EbDqNa7JOE7uzmBGmGSthar3Wo58
         BU81dfgvaIX0gqurDwUjcJq5Upjs9GU++N4vN5SZXJEyYPN80PKUJyu5p7n/TPzcnZ+r
         3SHK2cDxVKiX1nLQr8MeK3d1fl8kfV4X7CLTfjdkKpCtC2esznDHr55bMAoWUu+H9LEi
         mnDg==
X-Forwarded-Encrypted: i=1; AJvYcCW0inWu3OSlsirKcgIsD5S2Rs5HtBOP9kDMwSffAqcRkVLWrfwNDuc5AT5icwI7mZjCchSSUnFoG7QV8Vj6Dl2fC2tHl6iZHM8wk9k=
X-Gm-Message-State: AOJu0YzObcvONAKXhN8T+WA/2Bd4fAGV+hMND7c/ydYpmuewmgWeolVl
	6wdeRR62oF8f6oZRfhg/k+o9nU3ZTCoHZNmFY8uvrceUOdpvSnWpuwwEih06yD7l+aDufGLhutm
	l/WosTKv0/3dumg4mc+aMin12Oa5u4jpTV4bEwtOn
X-Google-Smtp-Source: AGHT+IHR8tWm3As7EFimYegkJ2aEH11DJZlSqpt7hxp2toPtKiyzrb5SnNq0dyiEPvt5NEjoGvgT61ZwQZfb/E9fudo=
X-Received: by 2002:a05:6214:5016:b0:6b0:6370:28d4 with SMTP id
 6a1803df08f44-6b5b71f6644mr97861346d6.6.1719929611963; Tue, 02 Jul 2024
 07:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com> <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
In-Reply-To: <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 2 Jul 2024 19:13:20 +0500
Message-ID: <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 2:31=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> Try this:
>
> https://lore.kernel.org/linux-btrfs/cb12212b9c599817507f3978c910276726762=
5b2.1719825714.git.fdmanana@suse.com/
>
> That applies only to the "for-next", it will need conflict resolution
> for 6.10-rc, as noted in the commnets.
> For a version that cleanly applies to 6.10-rc:
>
> https://gist.githubusercontent.com/fdmanana/5262e608b3eecb9a3b2631f8dad49=
863/raw/1a82fe8eafbd5f6958dddf34d3c9648d7335018e/btrfs-don-t-loop-again-ove=
r-pinned-extent-maps-when-.patch

I tested this patch on top of v6.10-rc6

> Btw, besides the longer kswapd execution times, what else do you observe?
> Is it impacting performance of any applications?

I observe that the system freezes under load.
Demonstration: https://youtu.be/1-gUrnEi2aU
The GNOME shell stops responding, and even the clock in the GNOME
status bar stops updating seconds.
And this didn't happen when the v6.9 kernel was running. Second, I
spotted high CPU usage by process kswapd0 when freezes occurred.
Therefore, I decided to find the commit that led to high CPU
consumption by the kswapd0 process.
As we found out, this commit turned out to be 956a17d9d050.

> I think no matter what we do, it's likely that kswapd will take more
> time than before, because now there's extra work of going through
> extent maps and dropping them.
> We had to do it to prevent OOM situations because extent map creation
> was unbounded.

Unfortunately, the patch didn't improve anything.
kswapd0 still consumes 100% CPU under load.
And my system continues to freeze.

6.10.0-0.rc6.51.fc41.x86_64+debug with patch
up  1:00
root         269 13.1  0.0      0     0 ?        S    12:24   7:53 [kswapd0=
]
up  2:00
root         269 29.9  0.0      0     0 ?        R    12:24  36:02 [kswapd0=
]
up  3:00
root         269 37.8  0.0      0     0 ?        S    12:24  68:19 [kswapd0=
]
up  4:05
root         269 39.3  0.0      0     0 ?        R    12:24  96:40 [kswapd0=
]
up  5:01
root         269 38.8  0.0      0     0 ?        R    12:24 117:00 [kswapd0=
]
up  6:00
root         269 40.3  0.0      0     0 ?        S    12:24 145:24 [kswapd0=
]

--=20
Best Regards,
Mike Gavrilov.

