Return-Path: <linux-btrfs+bounces-6260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3104D929379
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 14:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEED0B20E6D
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 12:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BE87D401;
	Sat,  6 Jul 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+3XmhCi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6F50246;
	Sat,  6 Jul 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720267672; cv=none; b=rg7WJMcdksfP7kkZI6fR4GKsMQRcEN4fNdgBjuY7QsZFjCAqIYcj2jqPBGnbmp1tHL19Om07q81MHWvHLYRuE3GYughnwrXGimEz6NkgmIa8YDckTQ+S8EDXUOkUFMP5vx5vW+otOGagKISW5ioJ6FT7Q03gZgN7OBR+MzX0esQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720267672; c=relaxed/simple;
	bh=g130VdJy4X5RQveGbr0aWPyXnw4vw6OGxH70BzO++x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1MdBGWNkL5pUlKRpUViJHQandiiY0MFa/4CgRSkPjzI4lgPxjtMCGoEQedDSXzOI9eHH49wGpVvFObKF2OIbwo/WPpfFcVehJFhH9kAPzUtdvgx93UPy12Xj/aCLbP+eoFr4PHeW8bR0UzEO/4nQwIfsFWvYbVybDiZi9D3+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+3XmhCi; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-651815069f8so29234127b3.1;
        Sat, 06 Jul 2024 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720267670; x=1720872470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UqjVGacvr99k3S0wau6SJoKWQts7Y2bmo2bsBuOmljA=;
        b=f+3XmhCiaJkJs+q0npMTL4J8UvClVfUk9Ef0rKiJZXKETFjj2zuYjyj5SqJ2kfDlk7
         ef7bUf+QAauC5aRnBqnz8Sflgp/rbDq6ahUiq4a3zPWaeLYBVcZllbwVcVroqax5aqh1
         VGqCzjMDBT5n+HfJsSDmIUU0SsJmKcMEGb0JZ4nZXCAZBCcHLS74MvF2nqgVOQx8WCmd
         OB/1F85sn6oMGzm4WK3yV/DstxwHQoTumTklprq2Xy1agv3d2hgzMwu0GDPZrXUetIHU
         lcKzLxZ4BuTpmCPFssTGGk0lWDhprM4SaZFBfOKMQyc90zQEHMS9JhFQ1b55f0zbu6fO
         iDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720267670; x=1720872470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqjVGacvr99k3S0wau6SJoKWQts7Y2bmo2bsBuOmljA=;
        b=lpKFDGZsYLN75h9nInqEqaAXt+4BgJsO66MUd5Vg3RvtphhnpgpFzdBbK1xCPsBgum
         yhSeNmBdd6VWEitNzMbrjlTFpjY+KUuhobFY70LsbPR0BXSlMNkO1FKLv6/avKh14Ehu
         YTRYy0AJsJ+yw25//oX902N2IHQKwwprPbFErxAg9JnMsKTd7rzRQODzPXrj0hkaKEhK
         VtWR7bZkqY6DDetRVn7bq+0RVSv/gX3HWeHtDYgcecckO+mGnPdXwKiFN0u0rZ1nAodY
         gZq1yH2i/Hg/oW8AAf+7tQ95/Qio4ts1pUUaUCjzGiCe+IqPS1rWj7pxqPBRQvMU5yMQ
         ou7g==
X-Forwarded-Encrypted: i=1; AJvYcCVihZUALY2J3j8R+AiGeNdA8znzkjSJwZaD+x6LKAFUS6YfXc5wanxhBJlysTThMzs07Bx4T9Ifizce3OFLfDyaChVyhauXEOuVeSI3SQAybXhizkCOPLtEPpL9CZTcCsvJs4UihXK1y/o=
X-Gm-Message-State: AOJu0Yy6EARObuezYu9OGPbn1aMWGJPoWGMFtpt51oU5ZNBnA4sSgtGz
	5a+lO6r3wlhOpMHpHvpSkVNjYC6AhkDgSb4a84dx+RqsyKjf+T/TEW120bTL9MtUCACFUmsjwVe
	/2CBn8aY7fW0aTXDh1bL2/odDuu6LC/KV
X-Google-Smtp-Source: AGHT+IEBZ/FUz/DsO7jOLpOU0J6Jmcc/4QS4QIM895fzsXyrUnDATeRHsjxnAed8u+yDzbzNAiteUqr+agzXrZOR0OY=
X-Received: by 2002:a05:690c:f02:b0:62f:206e:c056 with SMTP id
 00721157ae682-652f5778c41mr49833507b3.5.1720267670059; Sat, 06 Jul 2024
 05:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
 <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
 <CAK-xaQZ=c7aociwZ5YQreTmT+sBLGdH0rkTKmFzt4i_mrXBmgg@mail.gmail.com>
 <CAK-xaQb2OrgNOKKXp8d_43kqMNyuHxS1V8jSDL6PdNZPTv79+g@mail.gmail.com>
 <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com>
 <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com> <CAK-xaQaesuU-TjDQcXgbjoNbZa0Y2qLHtSu5efy99EUDVnuhUg@mail.gmail.com>
In-Reply-To: <CAK-xaQaesuU-TjDQcXgbjoNbZa0Y2qLHtSu5efy99EUDVnuhUg@mail.gmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Sat, 6 Jul 2024 14:07:33 +0200
Message-ID: <CAK-xaQbcpzvH1uGiDa04g1NrQsBMnyH2z-FPC4CdS=GDfRCsLg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

Il giorno sab 6 lug 2024 alle ore 02:11 Andrea Gelmini
<andrea.gelmini@gmail.com> ha scritto:
> For the moment it seems we have a winner!

I confirm this, but I forgot to add this (a lot of these):
[sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm firefox-bin nr_to_scan 2
[sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm firefox-bin nr_to_scan 2
[sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2
[sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
shrinker already running, comm cc1plus nr_to_scan 2

Just for the record, compiling LibreOffice.

In the meanwhile running restic (full backup to force read
everything), no sluggish at all.

