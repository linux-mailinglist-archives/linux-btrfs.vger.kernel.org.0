Return-Path: <linux-btrfs+bounces-6261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B56819294EA
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 19:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18162B21F27
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9830013C681;
	Sat,  6 Jul 2024 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6W+Z9z7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6062757FC;
	Sat,  6 Jul 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720287481; cv=none; b=AP4etG4hqsA/KMeiDv69LinGnEXwGJ+7OwLzZ4B4zH1OIEnhDAfnlYJvdz8F0WWRec6LTBl03v12MLIOUVdbgRqtvNLAtelIH02tJUZRy/0wrhPiVbu8IqV43fGh9SjKlmsoNFR0ZQHBPQdPhOsZaimEoUeb3KppGzJKci6cjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720287481; c=relaxed/simple;
	bh=G8HAvOUQlBzu7G/UjupxOn5yO3GOMwZPT+ciOrnoizg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEugX5Yvfdsk3SG+odjW1jvxE2VBexnsTR2Cas9rxFKJgQETJq8Z5j+okBQFBNCP+Xp/bTlfUFlYv2zqEc4+0ZZrZ2Bm6co8CBDAAGzOgt9N3w1raTxDLkMZ7hdlyq/51OOoE5rxojDTYZQGuvXzdhYaiCOCf1q/iy0sAiMDjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6W+Z9z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50494C4AF0A;
	Sat,  6 Jul 2024 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720287481;
	bh=G8HAvOUQlBzu7G/UjupxOn5yO3GOMwZPT+ciOrnoizg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D6W+Z9z7t5b1kMOTrKieOgN8eP330WS1YFeQOs3l9n2oxJLeRH4JxSEKJBIA5p/AS
	 gixphbw2tD7EYiB+T6aTT2xd2ZgTEr4Tpgm39Q+UV+2fPP6LZvzLvkX7kfR69ZXyAM
	 IAncBuIcT7mP7YJ+thvdiJINz255wtrX7tUaBbBJ1XiHDwNSrufLkYynWQxUGoNKTp
	 1MPIQhXP230ksGQP4GZcZw1mXVdg/wsDpZHTMLYiYwYrbQKfY/aG0djIRSUETXUvJ1
	 smay4fENmOsNdLACqj3D1TsCy5/eMSV0UafNUYp//hbu4wp9DBSOdujpqzlNuP0kZ6
	 9v8IaJE3H2AvA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77e2f51496so72720166b.0;
        Sat, 06 Jul 2024 10:38:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeITYL2SJC0ueuTfwifXr9OIG2zbE9EN1FOEK3qsgftUKgOZINilJil4sLyuyl98+OVOq7S8uHZxxt337lRQKebNqTI9GQLUklbxCsSskpIiZ95pnDD53qIyaWfw7SuLeiFvFFqiUF240=
X-Gm-Message-State: AOJu0Yx8xRsSeReTF9EwmWOHT6QJSwov+BOSg5WjuQ2XhdV4Am83ulEN
	5joIUVCpBe+kMTM4IhZQQP8AalXHZ2Z8PUh4o8NfSx5cmWwcg0GxJMJgy0HSDQmLd2xT4g82zYC
	YUUigb99lDsMDpHHEKInstOzJ0io=
X-Google-Smtp-Source: AGHT+IFJnEIjQr2TMHx6R9QnPx1HaevVsaLMROke+LS5GWjcZlwwSzJKRYzqL7AWu3WJFj0TJ7SauUVWWPUfhZv4oyk=
X-Received: by 2002:a17:907:72d0:b0:a77:c84b:5a60 with SMTP id
 a640c23a62f3a-a77c84b5b74mr467337266b.26.1720287479897; Sat, 06 Jul 2024
 10:37:59 -0700 (PDT)
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
 <CAK-xaQaesuU-TjDQcXgbjoNbZa0Y2qLHtSu5efy99EUDVnuhUg@mail.gmail.com> <CAK-xaQbcpzvH1uGiDa04g1NrQsBMnyH2z-FPC4CdS=GDfRCsLg@mail.gmail.com>
In-Reply-To: <CAK-xaQbcpzvH1uGiDa04g1NrQsBMnyH2z-FPC4CdS=GDfRCsLg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 6 Jul 2024 18:37:22 +0100
X-Gmail-Original-Message-ID: <CAL3q7H63GexJexkDxSz9Av_s=XyYotJqLqjUubZmuU7vynaQNQ@mail.gmail.com>
Message-ID: <CAL3q7H63GexJexkDxSz9Av_s=XyYotJqLqjUubZmuU7vynaQNQ@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 1:07=E2=80=AFPM Andrea Gelmini <andrea.gelmini@gmail=
.com> wrote:
>
> Il giorno sab 6 lug 2024 alle ore 02:11 Andrea Gelmini
> <andrea.gelmini@gmail.com> ha scritto:
> > For the moment it seems we have a winner!
>
> I confirm this, but I forgot to add this (a lot of these):

Oh, those I added on purpose to confirm what the bpftrace logs
suggested: concurrent calls into the shrinker.


> [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm firefox-bin nr_to_scan 2
> [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm firefox-bin nr_to_scan 2
> [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:06 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
> [sab lug  6 13:12:07 2024] BTRFS warning (device dm-0): extent
> shrinker already running, comm cc1plus nr_to_scan 2
>
> Just for the record, compiling LibreOffice.
>
> In the meanwhile running restic (full backup to force read
> everything), no sluggish at all.

That's great!

So I've been working on a proper approach following all those test
results from you and Mikhail, and I would like to ask you both to try
this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=
=3Dtest3_em_shrinker_6.10

Again, this is based on 6.10-rc6 plus 3 fixes for this issue you're both ha=
ving.

Can you guys test that branch?

Thank you a lot for all the time spent on this!

