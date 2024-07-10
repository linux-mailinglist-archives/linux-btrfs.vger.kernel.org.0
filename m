Return-Path: <linux-btrfs+bounces-6339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FDF92CFE3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 12:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3031C23AA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDFD18FC68;
	Wed, 10 Jul 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLWt3CKt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01160176AD5;
	Wed, 10 Jul 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608839; cv=none; b=VT3fhP2mxTHZpbby1fTrsZNmCDV21JUA64z4Vp2xiEsI6xun5l13JOoGnhMJ2JT5zuP1BN8Sj6OXk8wsuEI6NpGrT+5pR59Al3CQR/mxRRcjZOg8VOuZsRzQIZ0Y7hH4U0fThcu2NJ7N8grCxOtS9qyRxb6C4s473jIFxHUKfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608839; c=relaxed/simple;
	bh=OD3bqGvL2hPkyOSps3OHYrVBAjoKhSimI4RhpJ9k4mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEy0+ytK26TGMjROKlAoyf1qXxTUW0FRbG2RLfSNCSG4TnEBkpl+ReEwufQzVPGrjR7DZctlbTkzfQC2oMGI/9Rj+TSYla/c0vxpEOVRucd7H+OFyiE8BJwnfV+JlVi2yv/VkUCYZ/kg4NSQHPLezdTlYbCcViXwztV8u2nH/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLWt3CKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A080DC32786;
	Wed, 10 Jul 2024 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720608838;
	bh=OD3bqGvL2hPkyOSps3OHYrVBAjoKhSimI4RhpJ9k4mg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qLWt3CKtxsB5Azz4cujIwWErXOQYbp8JczXL+F1U/0yEAsZEu/KP9OmUtRkJFmrRX
	 jN0NiCKuyPF5qxXqA7Qc+OYiC2KQz1hjeTGn2sxGfmLBBwd3MMBw1UNpH3luwQJsdb
	 7c02jBUpbWat6d2eTGiEZX9ZokiKeASqYeBsBfm3N42/egW2/7brA87idfJAcpfNpU
	 CDX1w3Tyq1vuRFA/mC7kt6p8jPg7WuMXxO3oF0mJh3uxe+kosNn6KYeEXd4BuplK11
	 l/jzs2F5ulTbH+bUedrOGoNGlHATR5gSufOJuEojPHsaeLg9s0IAwh779O2mxOTP20
	 7ZsYWzwpx/gcA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso618426966b.2;
        Wed, 10 Jul 2024 03:53:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhhVqxvY3UoMvEVitWQtj1ancoix6vnBlNLy0VcaTMhKHFwL5TpS/BWf5BMLUZSRXaHPapT6D7GOmNjunaA3eQnRFayH387ewVIy7q/mQXTKv8OkCf0X/F9X6Jt1VyXsoXYzxK5RjRR6Y=
X-Gm-Message-State: AOJu0YzpYMUAyNsR1SfP7jkZFYsAzcONTz5yQ5dtN2eNJw5mAcwORi80
	k0szbrtYsrUgADENlWx81woYpLDELTqwRL8KeoctUs/xdzMLs3aa4BYnGtRNiYLK2yav6M6WblQ
	chjIOc2+AdFLMBI6QVNasNYElWrk=
X-Google-Smtp-Source: AGHT+IHpD80G3Seki3XvE5LyhZ4sCGFSCXxvHpad6cyq05UMHyp/ueL/EP8hXnuK/LcWCyN0vZycsZF3Iv0QNg7ooz8=
X-Received: by 2002:a17:906:478f:b0:a74:914b:ffb2 with SMTP id
 a640c23a62f3a-a780b89e8f0mr413161266b.72.1720608837248; Wed, 10 Jul 2024
 03:53:57 -0700 (PDT)
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
 <CAL3q7H46BxXUnrZ8Q3WxYf=2Tx0taMt9-2wf0TCrwj_kOiC=Dg@mail.gmail.com>
 <CABXGCsOcpzy7QvRUuSDT-Ouvp_jJHDvuziPQbej4rHLh9te58g@mail.gmail.com>
 <CAL3q7H6FwUFKb5oODK8jcAbRbjTjsZ2=4usW1_4A6b-t5nF7ng@mail.gmail.com> <CABXGCsP_V-Dh97SkLbYZvHSUdfhgXY_-RSqdRwv16hz+r3B3FQ@mail.gmail.com>
In-Reply-To: <CABXGCsP_V-Dh97SkLbYZvHSUdfhgXY_-RSqdRwv16hz+r3B3FQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 10 Jul 2024 11:53:20 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
Message-ID: <CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:24=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Mon, Jul 8, 2024 at 7:16=E2=80=AFPM Filipe Manana <fdmanana@kernel.org=
> wrote:
> >
> > That's weird, I think you might be observing some variance.
> > I noticed that too for your reports of the test2 branch and the old
> > test3 branch, which were very identical, yet you got a very
> > significant difference between them.
> >
> > Thanks.
> >
>
> up  1:00
> root         269 10.2  0.0      0     0 ?        S    10:06   6:13 [kswap=
d0]
> up  2:01
> root         269  9.1  0.0      0     0 ?        S    10:06  11:07 [kswap=
d0]
> up  3:00
> root         269  8.4  0.0      0     0 ?        R    10:06  15:18 [kswap=
d0]
> up  4:21
> root         269 11.7  0.0      0     0 ?        S    10:06  30:33 [kswap=
d0]
> up  5:01
> root         269 11.7  0.0      0     0 ?        S    10:06  35:19 [kswap=
d0]
> up  6:27
> root         269 11.5  0.0      0     0 ?        S    10:06  44:39 [kswap=
d0]
> up  7:00
> root         269 11.2  0.0      0     0 ?        R    10:06  47:18 [kswap=
d0]
>
> The measurement error can reach =C2=B110 min.
> Did you plan to merge the fix before the 6.10 release?

I've submitted a patchset with the goal to apply against 6.10 (see the
notes there in the cover letter):

https://lore.kernel.org/linux-btrfs/cover.1720448663.git.fdmanana@suse.com/

But it's up to David to submit to Linus, as he's the maintainer.
Though I haven't heard from him yet.

I plan at least one more improvement for the shrinker, but I would
like to know too if those patches go into 6.10 before it's released or
not,
because there are conflicts with the for-next branch.

> --
> Best Regards,
> Mike Gavrilov.

