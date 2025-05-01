Return-Path: <linux-btrfs+bounces-13592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED60AA5D10
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 May 2025 12:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE47E4C2BF1
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 May 2025 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7B22D4E5;
	Thu,  1 May 2025 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCoBen/U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2A944F;
	Thu,  1 May 2025 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746094401; cv=none; b=bJHyEjbFZLJlt3riRIzvbTb0X66EF/xDKV843XSU7sexPZF11SC6bnidoau9WCqiEnm9e4+EW4NAte8yahHNqU3qxgzbAV1SfyS4MVUp5z+CQm6tT9XWUmkOFyMMhhfpTNge4DXMuxNNH/kqYjIt9wPcnKrGcd9dM7UIeauP8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746094401; c=relaxed/simple;
	bh=eGZvK6YHqob7EVL3Px0n1wgeJO7eSGwL0cfHw6UZv5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0Z6MjYLGLHM/EMja2KfxmRlpTxwkifnpikirVaJ0ndVh7sZrlNqPf9DJ+9mzTJCiSdyK4fJig3SdoxG75AFkv7z40xnAa+0mLXvPYNfcoa439Um6rKLD1ls0w3k3HavMtQQPvaMs4OS4P2KVHYNtQK2VgPl2aFBTxYK43uui4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCoBen/U; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so962092e87.1;
        Thu, 01 May 2025 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746094397; x=1746699197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40Xk8UduXrUR8p6xdfUyx6lwsQ+qcOeGv4M1ttwV7zs=;
        b=fCoBen/UyEj51TZ+bERmRzzy55SPcVNL0e5G7lNZuGGWV/YqfETl2WONfpztfRYgR3
         GKP8cJgEZwuLXDqZ4SwRnLPSxd6E19AcFYX6MnOeSbOA6SO3l8sR4d5OzJveTo450Jbp
         HFmaTARrGYkUN4IADFUA5962YvLCN8nncfdcgMtdBaNtAwrpchJacnGix1ZLglFPuBx6
         CnHw5fTbX8LMIYXNq60IfBlh4dZlCUdOB3ishbszmGCeROh1Se6V6NOpNMpUb05NpVD1
         YVOT2rDhlDd4wqXp5vEvI6D2/onoNHkalJ8BKYyL6gqgTUJgRLsxVI+MNvC186mBPqjF
         HGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746094397; x=1746699197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40Xk8UduXrUR8p6xdfUyx6lwsQ+qcOeGv4M1ttwV7zs=;
        b=dkirmTDv96z+xVH4wMTbeXytMqvAZfQNea8TMPFWKNnS39fmXg1Viy5V+1TCfjAsgI
         ti35lJoD51IrgXUXaQ4iYhKnZI5DfuTBRgr/k0bXVNrcBDjou5LOuuZmjrYeeBK7mLOz
         hfYr/OitgMP6Qi+hhV93C+FeGvrYu1TV63C7DoChPzOkLCfLKQQrUXMKghHvAwDpjoG5
         zApYuFTipYtYLVPo6sUIhybQ+7WfIKcmmrhFErHlRohEsg572C4YRUE+1VJBtqhZxU5U
         DK+ZXyv8mviy8+zIflXHQjPq1TEDFQxDum62y5PLeNQTkBviRpSsrermFL995ZNP4Hg+
         G1bg==
X-Forwarded-Encrypted: i=1; AJvYcCU/zkYcKImH/S99GiL8taIe9/AU4ExC5n9W1pw2P1uLUwHW/ALfSGQ7JfVSBJ5h9bxi44IXyfi413XEeg==@vger.kernel.org, AJvYcCV4EbE7M8FaDTByF22KQa5ErI05ot0XfP17nel9BtTaWTtzCTGNAnCXcd5F7XsgmcAlBFHAkK0EHnwtVXPe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxej91pUKv0ToimpJBxboPXFdfspagnVJZfn6krRnr2pxLhKTiP
	ih2C8C30U4KM0oz5sU5apv2iiAffpm2X6AQ+DbRf9af33FZBSoxPbsEXJwvsPm6PMhTPVORFGug
	aNTMm2/lysuQ7eO5WLKzKXt854bI=
X-Gm-Gg: ASbGnctaD/2YWQk0qsz49/dAhrAMOUrqxGwLNfjcYdkn+oqMtr19qnbIzpC7xqeMMQS
	u+uGtrDWwAEoUnsZwENWJtWYQw1MeVQV72xAbec6sEhqpJFWinJfmoXddQfkPktWbRhqBeapOOG
	X6Xjr7ncO5n3eNMUdy1Uye1g==
X-Google-Smtp-Source: AGHT+IFA9KX1RFPCGmnCMl8LswkuzDCXbjQ7Pa4SVSE+BUyE8WRDgH6GGbLDORhBaou6R0oyU034cLDh5ISoli4dq84=
X-Received: by 2002:a05:651c:1501:b0:30b:a20b:eccc with SMTP id
 38308e7fff4ca-31f93f1a524mr6617271fa.11.1746094397235; Thu, 01 May 2025
 03:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430181052.55698-1-ryncsn@gmail.com> <20250430181052.55698-3-ryncsn@gmail.com>
 <20250430140608.6f53896a1f09d58e65dd1cc2@linux-foundation.org> <38af3e39-a639-4807-aed2-d15c956cf2cc@redhat.com>
In-Reply-To: <38af3e39-a639-4807-aed2-d15c956cf2cc@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 1 May 2025 18:13:00 +0800
X-Gm-Features: ATxdqUGeNs8Lte0FxicmqaiLcIWcPd9pyTZBEijP_DgRZkc71bjgYkH2e5anOoE
Message-ID: <CAMgjq7C+r4hUKf7w9JHST_EJy8z7SYE5R6n653j0RMJS6ZmRSQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] btrfs: drop usage of folio_index
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "Huang, Ying" <ying.huang@linux.alibaba.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 5:07=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 30.04.25 23:06, Andrew Morton wrote:
> > On Thu,  1 May 2025 02:10:48 +0800 Kairui Song <ryncsn@gmail.com> wrote=
:
> >
> >> Cc: Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM)
> >> Cc: Josef Bacik <josef@toxicpanda.com> (maintainer:BTRFS FILE SYSTEM)
> >> Cc: David Sterba <dsterba@suse.com> (maintainer:BTRFS FILE SYSTEM)
> >
> > Please tell us where these extra tags came from.  Did some tool
> > generate them?
> >
> > I think they're quite useful - perhaps something we could encourage.
> >
>
> I guess that's just the get_maintainers output?

Yes, `./scripts/get_maintainer.pl fs/btrfs/` generated these,
`./scripts/checkpatch.pl` didn't complain so I forgot to truncate
them. Glad to know it's considered helpful :)

