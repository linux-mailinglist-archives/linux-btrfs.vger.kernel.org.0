Return-Path: <linux-btrfs+bounces-1174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54788211A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jan 2024 01:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADC71C21CA2
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jan 2024 00:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66803CA4A;
	Mon,  1 Jan 2024 00:00:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07450C8CF;
	Mon,  1 Jan 2024 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so5075970e87.3;
        Sun, 31 Dec 2023 16:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704067248; x=1704672048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GB5pl5ZTuPfaCfWoS7lZD2imOyQWT9+xStwkcEg2vuI=;
        b=HCkPpBNM9S7GttJ8cRxuZjDoOlXsokwyk3ZrU3vT4DqXZLo2otiDB/Q1bnlD1JoAGg
         DEin4/i5E4JutM/3SFIZp/HW6wcxaF890CwJMjLS1Oe45S9spQt+6ja3/q1RqevjLik/
         i1JblIfhaB09N0rZibUHBUmj7tRlpjVWiIBZ3+uy6yyGSIPXnMwVx7cUdeKxvC67KfZJ
         4wFQjwimpXvPeS9KB0zgL1qe4vELLkXx0eNNK/3ouLT8rI3BKAet4omIRfCNuEFDRlsp
         5CTy4OTUwJERUjv2ZCcuo3f3QdGSMzh3HA2/nXpb88xPuA6/EBjauteeRBNPWzysGnDe
         Zh9w==
X-Gm-Message-State: AOJu0YzUSre4p7+3s5Q/rqzW2IPWlM99EvPkh3y5xeb2xKr3Y43jTOHl
	JiiERaI+jT37Zkx4+l+TMfvU8awQWrwlYA==
X-Google-Smtp-Source: AGHT+IFiQbNKDsIGVAnCPgx9QFtEyakOt7+dGjhKetQpz7REHmiUXKtQ8XHhawDuvSD1onQHdUU4rA==
X-Received: by 2002:ac2:4d17:0:b0:50e:771e:e09e with SMTP id r23-20020ac24d17000000b0050e771ee09emr2883943lfi.125.1704067247411;
        Sun, 31 Dec 2023 16:00:47 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id w5-20020a19c505000000b0050e7fe37a29sm1819597lfe.200.2023.12.31.16.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 16:00:47 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e72e3d435so5927310e87.2;
        Sun, 31 Dec 2023 16:00:47 -0800 (PST)
X-Received: by 2002:a05:6512:3ab:b0:50e:70b4:79ce with SMTP id
 v11-20020a05651203ab00b0050e70b479cemr3177755lfp.185.1704067246967; Sun, 31
 Dec 2023 16:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f09fb4edd69cf42fbb816e806384f79340e9d2b4.1703979415.git.wqu@suse.com>
 <CAEg-Je9vT-VwVtkqj2pszP08kmk9npPkf-OsSwe3G93m0YsxXw@mail.gmail.com> <cea1fa09-df9c-4234-9b00-941d07afb706@suse.com>
In-Reply-To: <cea1fa09-df9c-4234-9b00-941d07afb706@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 31 Dec 2023 19:00:10 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-xcrZ5BKN9tGETgwq-wd8NXmWehDf2AFvLO6Nhgqyc1Q@mail.gmail.com>
Message-ID: <CAEg-Je-xcrZ5BKN9tGETgwq-wd8NXmWehDf2AFvLO6Nhgqyc1Q@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: remove test case btrfs/131
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 5:14=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2024/1/1 00:42, Neal Gompa wrote:
> > On Sat, Dec 30, 2023 at 6:37=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Test case btrfs/131 is a quick tests for v1/v2 free space related
> >> behavior, including the mount time conversion and disabling of v2 spac=
e
> >> cache.
> >>
> >> However there are two problems, mostly related to the v2 cache clearin=
g.
> >>
> >> - There are some features with hard dependency on v2 free space cache
> >>    Including:
> >>    * block-group-tree
> >>    * extent-tree-v2
> >>    * subpage support
> >>
> >>    Note those features may even not support clearing v2 cache.
> >>
> >> - The v1 free space cache is going to be deprecated
> >>    Since v5.15 the default mkfs is already going v2 cache instead.
> >>    It won't be long before we mark v1 cache deprecated and force to
> >>    go v2 cache.
> >>
> >> This makes the test case to fail unnecessarily, the false failure woul=
d
> >> only grow with new features relying on v2 cache.
> >>
> >> So here let's removing the test case completely.
> >>
> >
> > Can we pair this change with a corresponding change in btrfs-progs
> > that blocks using v1? I don't think it's actually worth splitting this
> > change up in phases, especially when we're explicitly dropping the
> > tests around it.
>
> That sounds pretty reasonable.
>
> I'll craft one to deprecate v1 cache in progs too.
>

As part of the deprecation, it should probably be difficult to use v1
cache and if we're not already automatically migrating people to v2,
we should probably start doing that.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

