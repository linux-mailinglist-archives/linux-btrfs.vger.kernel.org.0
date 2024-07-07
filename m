Return-Path: <linux-btrfs+bounces-6265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B346392976B
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE782818D3
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E6018E2A;
	Sun,  7 Jul 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGBsr0zW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27418028;
	Sun,  7 Jul 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720348120; cv=none; b=badonVAsue3RMey7QuvFo3HM6lGFGRAyRVDp11IxnNaWWjGn6RYplXVc29K4D7ND1gd3hQl0nG3n6a/SxeI08bRgFHg0oFqZsgXPULIgrLtj3E7JGcx8tEYxAmOD08Vm+0LXKoSMa5UEXT89r3sjxtuh9qwE8YiB5jxOeBpJlAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720348120; c=relaxed/simple;
	bh=3G0DFg9bvl3HPl8xx+gvWAqgjvemDx8liAboiamergg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFL8JS+cCBfXLlodShTJkqOReHzooUirBLYfg1+0IgAbinFLAFTw9SeTSDNsi/j25o1Qbq64BOWf1iBXIWQVfq+knDXLNyTobB9OepYo96Z/oBZHAM3lU2FzEAcpiTOysLNbHAa0lRqXRBh2gIobxkwhGVuFdYeMjx3ViHt2aXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGBsr0zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9439BC3277B;
	Sun,  7 Jul 2024 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720348119;
	bh=3G0DFg9bvl3HPl8xx+gvWAqgjvemDx8liAboiamergg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JGBsr0zWCerbyKhskkmOm1/C+QMvN+mnAHz3kLZxJzN69gUwfUOl+h7o83Fp6efSH
	 BGive9uADXRMgzQE2rrOJNlh9J7g5N6tmAPN4uda/ImvGQ9N/on1mRvMIAl0nM38Dz
	 /roKYZjlysTN18T2Bflpq/oA/1bhTLKtsEbvHKkbPUtaa4vqNoEU6cq71yyAWD7PLL
	 SJCsSKGmBzOrSLP6fRAzRMnjWBcFbZlDqvDzJBfPLoi9gb9E5kxNNFVw9INngqs2rH
	 vXgryKome95mxi7pNmeNP6stp2bMhvMgg9Ewl0+8upuxIW7+yGQOq6eApxLc7cGgFH
	 Ya9b4N+UHKubg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77baa87743so320290766b.3;
        Sun, 07 Jul 2024 03:28:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwhKsJyKNx/AV+Oqvdr1uiRxzId70FtZp2f59zkH66AMDP7QgchplcoP+lmJlUteslSQUcYXjj951AWrEklYeTytzslBGiZdUCkm9mj8GphBBc00U9buQ5zjVIZTlu9ONnSJWmoMHuEL8=
X-Gm-Message-State: AOJu0Yzcf+8lh6o6ExgS48QWU9HjuNxgS5DEyLE0z7Sbnv66WL+9iQ3y
	Bu5gxb12ysG1/C732MwG8GlqBvUxLMYc+mg1vhg23hPtvzd527xFeWUskLuNC8IZn43O0pVZuVc
	9Sa9AUQgpdU4kKzvC2v7nh3IFyZ4=
X-Google-Smtp-Source: AGHT+IFvaXeDANtBu2YY9A4rHP+oiYP9PpC5L3P07om7XsV13YCPdbO9jKJdoq/5c0YiMUOGgQeWKZY7PU/Ibv285qI=
X-Received: by 2002:a17:906:b858:b0:a77:d8c9:ae23 with SMTP id
 a640c23a62f3a-a77d8c9ae6amr387649366b.59.1720348118187; Sun, 07 Jul 2024
 03:28:38 -0700 (PDT)
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
 <CAL3q7H5fogJTfdkj_7y8upZj7+4dz65o-tKzyGf0WfLwm3nfUw@mail.gmail.com> <CAK-xaQaYDg60DizL3kJ3XKU5JD3kKVi3kecb2s18Po96T9tAHg@mail.gmail.com>
In-Reply-To: <CAK-xaQaYDg60DizL3kJ3XKU5JD3kKVi3kecb2s18Po96T9tAHg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 7 Jul 2024 11:28:01 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6rir8w6ge6zDPXYFaBoLyHsbcApr9WXb+A1Vc+8RP77w@mail.gmail.com>
Message-ID: <CAL3q7H6rir8w6ge6zDPXYFaBoLyHsbcApr9WXb+A1Vc+8RP77w@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 11:15=E2=80=AFAM Andrea Gelmini <andrea.gelmini@gmai=
l.com> wrote:
>
> Il giorno dom 7 lug 2024 alle ore 11:41 Filipe Manana
> <fdmanana@kernel.org> ha scritto:
> > > Again, this is based on 6.10-rc6 plus 3 fixes for this issue you're b=
oth having.
> > >
> > > Can you guys test that branch?
>
> Used yesterday and today. Seems fine. Just in quick test, I see
> sometimes PSI memory spike over 40, but - important thing - no effect
> on interactivity. So I didn't investigated more.

Awesome!

>
> Well, just to be sure. I compiled the latest git with -rc6 and
> test3_em_shrinker_6.10. Nothing more about patches.

That's right, just that branch. It has all the necessary patches (3),
no need to apply any other patches on top of it.

>
> Anyway, just for the record:
> kernel: test3
>        fresh: 0:03:44 [ 241MiB/s]
>        aged: 0:02:07 [ 801MiB/s]
>        funny thing: next runs of aged no more than  0:03:22 [
> 504MiB/s] (but, as I wrote, no problem with interaction).
>
> > I just updated the branch with a last minute change to avoid an
> > unnecessary reschedule and re-lock, therefore helping reduce latency.
>
> Ok, recompile now and test!

Thanks! Much appreciated!

