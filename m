Return-Path: <linux-btrfs+bounces-10351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1909F0C19
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 13:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56620188AFD6
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 12:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4561DFDB5;
	Fri, 13 Dec 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI/cWOQS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832471DF276
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092356; cv=none; b=awo9jo1cjYFfM4zHzyOKmMQxnZVLk/LgaxUnKKm8jNy+rR9QmtW6++vOVVXz6FshlFCkCQ1oIsF22j5LVcR3+Sd5tq7CnLRSs0imoE/pGCgSJcqbeVfCOqBi0nTzUyifiH3R9iXS/h5vAitWVaUkOMrTUEa6fAW1Kmt1toL8ITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092356; c=relaxed/simple;
	bh=+agX/hxnK7PsbXVWPwKhiB1V054xuEENK8nIoWK3fi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/mNVk2yJexUwx2ST3nPpbUXbcwqef8Q21Q43J1jygyOw4VKncJJXaEQ+CV6PcQGj7fL4juNMpGyy9rfhdqGBp9b+7Ksb4E9dCcg41t8lbiGjzvVuS6wpXnjPVBU9i3R4W3lUlm60j+E4nyg/dnWH3wsanIzLz3CFDDKyuDEaiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZI/cWOQS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so2946776a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 04:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734092353; x=1734697153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rswNLiWFuDKiW42rbnE3/FFvogIGFwro7QX3xwapVa8=;
        b=ZI/cWOQSTK7j4jTHtoeuwX9Lb+TTFgPctFxAljDqcqJJdejmoMXhJrrdZHRmEGK9x+
         F4dQZxd3p2sLGblz6ghca40YOLqTyK3h15sJaOQ6ii0zZMQm4c4ShqymyH6RH4ri6eKl
         kOZNPGAfnRFZEXJjuxUzKr1E90D9Ki0qaMTiDYN1nqfq9Fjjlxd2ddSaUbiyYsU0z10C
         Ij8a/AvyprryOGojNbPzulITQGxaUUOii5FEoUSsHoHFPsCvH8h6QVHj92tu+TZYS9Yw
         0epvuWXhOpJIpzQttx/C8mnurNpx2oGBUH2JrpIkYcBaAoHvu3aLbmbtRdL0Le4aQBBo
         lG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734092353; x=1734697153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rswNLiWFuDKiW42rbnE3/FFvogIGFwro7QX3xwapVa8=;
        b=ORCKvoxJGD3qIhesn3k0yVydnJI4jSCvazkrgAjT1caqtLmH6Pe17+Ek2/nXTjAVdh
         t5sw4uHCNevSvHr60qLSGz8K5EaPTpP33ve/zAcG+ubLSSNJB4ZbdMX6EO/FDK3qOo8X
         ldh5cNfRJj1NPBeEYjSa0XzXBkvgCWg9oCQbRLcJK8uC3DTAkRcWIn3qz/JaJnF1BbNO
         ag2Ba9McaBnCtG81p2FdI1rk1Fy/50Eap9O6oOawHCcE0e/b0zLwBIxSwJ+AeGrO/BZv
         JNGRNMWTeaO8OrQm9DvMs8o8Was2hlcLMZxgvi2DZT/xyc35sC4i7ccNnwUOqsjlcu4W
         W+OA==
X-Forwarded-Encrypted: i=1; AJvYcCVXqG1OWF23dfgLQS+m9VPJa6P7k3lm2QMoXiVmbYQQKH3zJuPA6pA4AbL+I6SH362QDoDpy08mDLS/lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSXcYbc1JeMPi3UILdhx3bJeg89BXydKsxKt9fUpfHTsjQlPhu
	IV/Nr7A4ytVHlqmlPcln6OEY20mYF3xxhh9LwULYnsgE6amq2vBW1onkvcrlZwYweZL6Rc4AuRr
	gPT8Pj/jB0sdLPZ9AO7CyWNG/o3LihDK49+Au
X-Gm-Gg: ASbGncuDu/C6vo/d2XISLex7ejtPPYmGlYheGMiCedza1m1YU5WlSfdu7IYVHBNkpZH
	FC5jLL2lY5e8S5dCzg2csOQbZ4BIaa690kPxH/A==
X-Google-Smtp-Source: AGHT+IGRpkdDBASQbA4W9W4t1BgK2dSzLTzvJG9Vc9UhANfCeYe2U4Z/qo2tMOoP0ps7OytKBednRAPV6i81BAZBwaE=
X-Received: by 2002:a05:6402:2790:b0:5d0:b51c:8478 with SMTP id
 4fb4d7f45d1cf-5d63c3158c3mr1721305a12.12.1734092352701; Fri, 13 Dec 2024
 04:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675b61aa.050a0220.599f4.00bb.GAE@google.com> <675c1dc6.050a0220.17d782.000c.GAE@google.com>
In-Reply-To: <675c1dc6.050a0220.17d782.000c.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Dec 2024 13:19:01 +0100
Message-ID: <CANn89i+Zm_0a5jqtsL5m-S4=E06mdQXA8RLaFEF75Y6umFWxpQ@mail.gmail.com>
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
To: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
Cc: alsa-devel@alsa-project.org, asml.silence@gmail.com, axboe@kernel.dk, 
	clm@fb.com, davem@davemloft.net, dennis.dalessandro@cornelisnetworks.com, 
	dsterba@suse.com, eric.dumazet@gmail.com, horms@kernel.org, 
	io-uring@vger.kernel.org, jasowang@redhat.com, jdamato@fastly.com, 
	jgg@ziepe.ca, jmaloy@redhat.com, josef@toxicpanda.com, kuba@kernel.org, 
	kvm@vger.kernel.org, leon@kernel.org, linux-block@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, miklos@szeredi.hu, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	pbonzini@redhat.com, perex@perex.cz, stable@vger.kernel.org, 
	stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, tiwai@suse.com, 
	viro@zeniv.linux.org.uk, virtualization@lists.linux-foundation.org, 
	ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 12:43=E2=80=AFPM syzbot
<syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit de4f5fed3f231a8ff4790bf52975f847b95b85ea
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed Mar 29 14:52:15 2023 +0000
>
>     iov_iter: add iter_iovec() helper
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1742473058=
0000
> start commit:   96b6fcc0ee41 Merge branch 'net-dsa-cleanup-eee-part-1'
> git tree:       net-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D14c2473058=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10c2473058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1362a5aee630f=
f34
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4f66250f6663c0c=
1d67e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D166944f8580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1287ecdf98000=
0
>
> Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
> Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

Great, thanks syzbot.

Patch is under review :

https://patchwork.kernel.org/project/netdevbpf/patch/20241212222247.724674-=
1-edumazet@google.com/

