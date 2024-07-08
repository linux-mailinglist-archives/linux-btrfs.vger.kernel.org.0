Return-Path: <linux-btrfs+bounces-6285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92EC92A46E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207EA1C21A6A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29E513C806;
	Mon,  8 Jul 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ0R1v/3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29A1D54A;
	Mon,  8 Jul 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448186; cv=none; b=J0Wjcm0HE3tsnQFwiOKp84g6tNHVK8BJsolp+QoRtrdd/VsVtPZogReFkiafzwJ/CDtQore0iYUqjTL7DI7PlB5qotiGg7/qI22xJ6RNqxKtCachG9sHZnxkCW0/CWvxPpKiRyQwkRzMrh25r3sNSLc8GD7T/Hz5WThdDWhi3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448186; c=relaxed/simple;
	bh=FgcQ9yN4o1kQ+a55KbWLYhrnj3J8YjDuKyMmaGE3KVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCZqHls13daJKxGy2+MMhKRbpVQn/XdpQjlUpkge529zvxKXnA8SaCFQKZs5haZg7S/2qI23UTyFbSrYuOIOCP2ONjSKwb9LMv9RwlPA5VX2pDV2DqSjcwsRoIhtngJrqrA9/lBylTAb1vA5nHUvBcvz63SuibZEYhj9GRMq2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ0R1v/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71872C32786;
	Mon,  8 Jul 2024 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720448186;
	bh=FgcQ9yN4o1kQ+a55KbWLYhrnj3J8YjDuKyMmaGE3KVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IQ0R1v/3PmT4JmG1nLlCohG9zs3RwdsRF38x5kSBW4K6GrNgM6h/StgZcl1AcpWW+
	 W9z1tsATbEFkEHgMEsegGKEQjZ2198ZQP07iHeDbvgjmyAjiHvN9HaZhkKHnaTnXS1
	 ijg9DyKQIjFJoEiFI+Niy8OtY5xViIAfRvOnz5TMS+WAbCyuoCqb/eaLsv6p6gwhoN
	 4kzN4OAfxZ2ugvec7lomKy0ckrVKo06z4cApEGOftVdFgLYAdF3R4MkdhKEGpxBdfy
	 JD/HI8RDC0FncJSR9zY2J9AdTRh4sR8k8YinEnH2pXnPGCoxrkv+cloRDdAVbVYLqA
	 6hkLwn9HwJoxQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a75131ce948so480810466b.2;
        Mon, 08 Jul 2024 07:16:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZqsx8zQlempVBSYSuB4pVqpDiDOLxkfvCvGWsEFyyc30LoDn+Rk34HVvRf4dUFFYZWXp8cle2frPhSIn6Yc3HuB27z3+xAo+yQR7Fk+tjv6ac1oq84TjTSdMXoHYwoN669QUpQ/3mH6c=
X-Gm-Message-State: AOJu0YwebTMAspvQUY57UjD+n1hLe5rn/AxSNy3peMYlsrv+JyCuG1z+
	eW+jO19YuXVNnz0E9Qbfd5QPa/XcFBSLGYcBQz18ONcLY78kguKzfLWG5vVyScwbkbWMJPrFWiC
	nXtSeFiV0kv3YmxpwqQrLIcM4ydA=
X-Google-Smtp-Source: AGHT+IERLtMd2OfFHU2P+fXHlx0JnkHsh4Y0GYWvCgqIZO1TZGoRX0fR8Fg5cP2TjvxuwFJDTgPPK9XFWssFcnedS9c=
X-Received: by 2002:a17:906:605:b0:a72:428f:cd66 with SMTP id
 a640c23a62f3a-a77ba4cca35mr659280266b.39.1720448185018; Mon, 08 Jul 2024
 07:16:25 -0700 (PDT)
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
 <CAL3q7H63GexJexkDxSz9Av_s=XyYotJqLqjUubZmuU7vynaQNQ@mail.gmail.com>
 <CABXGCsO_6cJruBxKdqXzEze_hDGVsPtN8DBCob=OWF5OpT4s7Q@mail.gmail.com>
 <CAL3q7H46BxXUnrZ8Q3WxYf=2Tx0taMt9-2wf0TCrwj_kOiC=Dg@mail.gmail.com> <CABXGCsOcpzy7QvRUuSDT-Ouvp_jJHDvuziPQbej4rHLh9te58g@mail.gmail.com>
In-Reply-To: <CABXGCsOcpzy7QvRUuSDT-Ouvp_jJHDvuziPQbej4rHLh9te58g@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 8 Jul 2024 15:15:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6FwUFKb5oODK8jcAbRbjTjsZ2=4usW1_4A6b-t5nF7ng@mail.gmail.com>
Message-ID: <CAL3q7H6FwUFKb5oODK8jcAbRbjTjsZ2=4usW1_4A6b-t5nF7ng@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 8:16=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Sunday, Jul 7, 2024, at 5:15 PM Filipe Manana <fdmanana@kernel.org>, w=
rote:
> > That's good. And is the DE unresponsiveness gone too?
>
> Yes. I don=E2=80=99t know how to objectively measure responsiveness, but =
there
> There were no more freezes like those on my video.

That's good.

>
> > I see you tested d22fedf5058d, but I updated the branch a couple hours
> > ago, now the top commit is fa8b5dd7fa18.
> > Can you test the updated branch? It may help further in your case.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/comm=
it/?h=3Dtest3_em_shrinker_6.10&id=3Dfa8b5dd7fa18a4dc2ea6bdeaf5525b1af348f38=
3
>
> 6.10.0-rc6-test3_em_shrinker_6.10-fa8b5dd7fa18
> up  1:00
> root         269 13.1  0.0      0     0 ?        S    18:01   7:54 [kswap=
d0]
> up  2:00
> root         269  9.8  0.0      0     0 ?        S    18:01  11:46 [kswap=
d0]
> up  3:00
> root         269 10.8  0.0      0     0 ?        S    18:01  19:36 [kswap=
d0]
> up  4:00
> root         269 11.9  0.0      0     0 ?        R    18:01  28:37 [kswap=
d0]
> up  5:00
> root         269 13.1  0.0      0     0 ?        S    18:01  39:29 [kswap=
d0]
> up  6:00
> root         269 13.1  0.0      0     0 ?        S    Jul07  47:24 [kswap=
d0]
>
> It=E2=80=99s as if kswapd0 got worse based on time measurements (it becam=
e
> like on the test2 branch), but subjectively, the responsiveness got
> better.

That's weird, I think you might be observing some variance.
I noticed that too for your reports of the test2 branch and the old
test3 branch, which were very identical, yet you got a very
significant difference between them.

Thanks.

>
> --
> Best Regards,
> Mike Gavrilov.

