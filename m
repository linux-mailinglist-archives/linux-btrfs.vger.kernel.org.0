Return-Path: <linux-btrfs+bounces-6269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E1A9297C5
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCCB1C208ED
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BDC1CF9A;
	Sun,  7 Jul 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4ZyUiHE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD71078B;
	Sun,  7 Jul 2024 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720354557; cv=none; b=Y9zJW04o01C4HStJnJa40qhMzVPuG6uolS0/up5DF6b2cp3zVr0QLMLND/cviIrS2Jhp/8C9rlqlSCMbUqwfgxjBlnuT78l6Zx9MyMNphCQ7vKNh8kpTVpfLdgV7IsWlY7cQFgSNQXlfrM7yDKpbWDCJQBP6elZRjowY8qTMV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720354557; c=relaxed/simple;
	bh=cFKTEh2qd2OkxQvLdlG7DvgFOUbWL6ynQqseB8Y1hSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/nNm/KrbdDxAbcRGASJFp1VITxavqv5TkqAETDrVLea5haYIWe6M8Sxiqm4lk4zjnS+qpStx5XZq9YbrlFFqO+kN9uRi6/10U2WalMJ+Lp8VU7zxYqtniHng2D4Kb67qC6zYvaqOIAt0pT6CmBFJrxmdyitAnco5/rwUk5b+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4ZyUiHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B52C4AF0D;
	Sun,  7 Jul 2024 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720354557;
	bh=cFKTEh2qd2OkxQvLdlG7DvgFOUbWL6ynQqseB8Y1hSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P4ZyUiHEvZafr1zT25Dglm8QEnK0QvijBIYAq2nJ+OUwstbEFjoOeNieHuQ2Gaz9s
	 g0+TZUpjJt+YubHjtstMoXmAMMXv4N4t+WiHuP7/RJqZ+GCKzDEQwiaISJQoTlxNkI
	 prI5S3wUcRlxYXwKuGdKzfNm+SxWm/H7NgyqsBX9kvmORNLqN0zphDNbFYnS0m7RoJ
	 TZ835GkbPl2KFYgq8TE2QQbYOhLuxB0wDDDg+I9ZRiDbRjUkzqfzGiFJXGxVRWVW9l
	 S05LKethWB4Eo5pTcpQCjLQ7ujhEkm2l8d9Mdig1dE5Q/0B8Ltltmcb25TtJkKsAqB
	 U6HZm4hYTJKOA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e9c55febcso3878090e87.2;
        Sun, 07 Jul 2024 05:15:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVa2g7+dvQz+GdnFtfZXNL1GvCQ/X1YSRbL50UKrKIuQ6Y+tMnex9GKd2T32CbTB2MA2Aw2o95iwDSq0zQsIuJxlCtAt0EWy7NAWthN69DoAoxom5HYSf9yM+PlmzZfVxWNCJzGwdKx8uM=
X-Gm-Message-State: AOJu0Yza1fQViJX63jAsV2e8NRzsDNOIVzze8kMcky6NNOpB16TtVY8P
	w3zXtCSfZwCvUnzOvKBCpQC63goNWvm7zQsU9fIjDI9sMJKfJi+psTNWeQs0KOqxXq9T9CUq6S8
	zT5jyaomtFkvhHorWuPIbNe5agwE=
X-Google-Smtp-Source: AGHT+IFu7/fRbXxCQEqScaQZK0y/JZqv8wO8tL6UxI5Y7elizVotqtWelGeFXSSvAvpMkQtgKeKc5V98gw6KK56dGQ0=
X-Received: by 2002:a19:5f5c:0:b0:52e:9ebe:7325 with SMTP id
 2adb3069b0e04-52ea065f06cmr6301234e87.31.1720354555481; Sun, 07 Jul 2024
 05:15:55 -0700 (PDT)
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
 <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
 <CAK-xaQaesuU-TjDQcXgbjoNbZa0Y2qLHtSu5efy99EUDVnuhUg@mail.gmail.com>
 <CAK-xaQbcpzvH1uGiDa04g1NrQsBMnyH2z-FPC4CdS=GDfRCsLg@mail.gmail.com>
 <CAL3q7H63GexJexkDxSz9Av_s=XyYotJqLqjUubZmuU7vynaQNQ@mail.gmail.com> <CABXGCsO_6cJruBxKdqXzEze_hDGVsPtN8DBCob=OWF5OpT4s7Q@mail.gmail.com>
In-Reply-To: <CABXGCsO_6cJruBxKdqXzEze_hDGVsPtN8DBCob=OWF5OpT4s7Q@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 7 Jul 2024 13:15:18 +0100
X-Gmail-Original-Message-ID: <CAL3q7H46BxXUnrZ8Q3WxYf=2Tx0taMt9-2wf0TCrwj_kOiC=Dg@mail.gmail.com>
Message-ID: <CAL3q7H46BxXUnrZ8Q3WxYf=2Tx0taMt9-2wf0TCrwj_kOiC=Dg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 12:35=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Sat, Jul 6, 2024 at 10:38=E2=80=AFPM Filipe Manana <fdmanana@kernel.or=
g> wrote:
> > So I've been working on a proper approach following all those test
> > results from you and Mikhail, and I would like to ask you both to try
> > this branch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/=
?h=3Dtest3_em_shrinker_6.10
> >
> > Again, this is based on 6.10-rc6 plus 3 fixes for this issue you're bot=
h having.
> >
> > Can you guys test that branch?
> >
> > Thank you a lot for all the time spent on this!
>
> 6.10.0-rc6-test1_em_shrinker_6.10
> up  1:01
> root         269 25.8  0.0      0     0 ?        R    10:59  15:47 [kswap=
d0]
> up  2:00
> root         269 25.5  0.0      0     0 ?        S    10:59  30:46 [kswap=
d0]
> up  3:00
> root         269 27.9  0.0      0     0 ?        S    10:59  50:18 [kswap=
d0]
> up  4:00
> root         269 27.8  0.0      0     0 ?        S    10:59  67:08 [kswap=
d0]
> up  5:00
> root         269 27.5  0.0      0     0 ?        S    10:59  83:01 [kswap=
d0]
> up  6:00
> root         269 27.5  0.0      0     0 ?        S    10:59  99:31 [kswap=
d0]
> kswapd0 on the test1 branch is bad as
> https://gist.githubusercontent.com/fdmanana/9cea16ca56594f8c7e20b67dc66c6=
c94/raw/557bd5f6b37b65d210218f8da8987b74bfe5e515/gistfile1.txt
>
>
> 6.10.0-rc6-test2_em_shrinker_6.10
> up  1:00
> root         269 11.7  0.0      0     0 ?        S    19:23   7:03 [kswap=
d0]
> up  2:02
> root         269 11.9  0.0      0     0 ?        S    19:23  14:38 [kswap=
d0]
> up  3:00
> root         269 11.9  0.0      0     0 ?        S    19:23  21:30 [kswap=
d0]
> up  4:01
> root         269 11.2  0.0      0     0 ?        S    19:23  27:15 [kswap=
d0]
> up  5:00
> root         269 11.4  0.0      0     0 ?        R    Jul06  34:25 [kswap=
d0]
> up  6:00
> root         269 13.9  0.0      0     0 ?        S    Jul06  50:14 [kswap=
d0]
> On the test2 branch, kswapd0 is two times better.
>
>
> 6.10.0-rc6-test3_em_shrinker_6.10 (d22fedf5058d)
> up  1:02
> root         269 11.0  0.0      0     0 ?        S    09:54   6:50 [kswap=
d0]
> up  2:00
> root         269 10.7  0.0      0     0 ?        S    09:54  12:54 [kswap=
d0]
> up  3:00
> root         269 10.1  0.0      0     0 ?        S    09:54  18:18 [kswap=
d0]
> up  4:00
> root         269  9.5  0.0      0     0 ?        S    09:54  23:03 [kswap=
d0]
> up  5:01
> root         269 10.0  0.0      0     0 ?        S    09:54  30:24 [kswap=
d0]
> up  6:00
> root         269  9.9  0.0      0     0 ?        S    09:54  35:42 [kswap=
d0]
> On the test3 branch, kswapd0 is thee times better.

That's good. And is the DE unresponsiveness gone too?

I see you tested d22fedf5058d, but I updated the branch a couple hours
ago, now the top commit is fa8b5dd7fa18.
Can you test the updated branch? It may help further in your case.

https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/commit/?=
h=3Dtest3_em_shrinker_6.10&id=3Dfa8b5dd7fa18a4dc2ea6bdeaf5525b1af348f383

>
> To catch up with the 6.9 branch, the timing needs to be 4 times better.

Hopefully it will be much closer to that with the updated branch.
The upcoming changes for 6.11 would help there too, but anyway we can
still further optimize on top of the 6.10-rc code.

Thanks Mikhail!

>
> --
> Best Regards,
> Mike Gavrilov.

