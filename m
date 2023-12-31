Return-Path: <linux-btrfs+bounces-1171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C335E820B7E
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Dec 2023 15:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF81B2107B
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Dec 2023 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7364A63B5;
	Sun, 31 Dec 2023 14:13:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E76111;
	Sun, 31 Dec 2023 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so4960172e87.0;
        Sun, 31 Dec 2023 06:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704031998; x=1704636798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meBsux30PDhxX/nY+Qz4C4OMxLX76pAecghMGbRF+ag=;
        b=U3XJGaqm9oZgBQHOyNBjISKKX5SDMwToPPashQDUZCmPwhyoYUCdd8nwS7B1WavW17
         /qmwyjAtQY0YxJzH4oEg9mGkv6o6Zr4hCsV308kSyjnrBIAYNrb+9N5HfYr59sNGr+x5
         WsIGYieqdgJzdaXc1XDrORQrsqO6/iXW7Kshid1Fq6VcRuQnXQokvmXACev5jt33wjBJ
         LfGbZYwzQkVwVw57cmXAUH+CKeOMLCWy4lnrHkVYmlKKp0GaIF5Qw9y8CQgbuVfC8SIM
         XcaKhpRraCcvUTikpxS0OUqLot/RlFOZm6hCFFs7WXFOaKpi0Zx1Rtb9CB7QLIiYpemx
         3B/Q==
X-Gm-Message-State: AOJu0YxqXSt60icZNtZPv7ubFAvEWHuIkIIZH6boqnLnKYPvDGLCIV9Y
	SYDQviE3Bitnuc4S/Ay3zLfsojgCAfG+Nw==
X-Google-Smtp-Source: AGHT+IG5QwHH7aqkp9PoGlKvEMUfbZZh5KQJpCdnyER3IBUUtocebjIZZEKFC7nvj/hKT8A3MXfSJA==
X-Received: by 2002:a05:6512:159b:b0:50e:5623:d8 with SMTP id bp27-20020a056512159b00b0050e562300d8mr4017645lfb.197.1704031997592;
        Sun, 31 Dec 2023 06:13:17 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id z4-20020a170906434400b00a2744368bdesm4289596ejm.82.2023.12.31.06.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 06:13:17 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so957185566b.1;
        Sun, 31 Dec 2023 06:13:17 -0800 (PST)
X-Received: by 2002:a17:906:218:b0:a27:76ff:6a51 with SMTP id
 24-20020a170906021800b00a2776ff6a51mr1280120ejd.115.1704031997226; Sun, 31
 Dec 2023 06:13:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f09fb4edd69cf42fbb816e806384f79340e9d2b4.1703979415.git.wqu@suse.com>
In-Reply-To: <f09fb4edd69cf42fbb816e806384f79340e9d2b4.1703979415.git.wqu@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 31 Dec 2023 09:12:40 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9vT-VwVtkqj2pszP08kmk9npPkf-OsSwe3G93m0YsxXw@mail.gmail.com>
Message-ID: <CAEg-Je9vT-VwVtkqj2pszP08kmk9npPkf-OsSwe3G93m0YsxXw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: remove test case btrfs/131
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 6:37=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Test case btrfs/131 is a quick tests for v1/v2 free space related
> behavior, including the mount time conversion and disabling of v2 space
> cache.
>
> However there are two problems, mostly related to the v2 cache clearing.
>
> - There are some features with hard dependency on v2 free space cache
>   Including:
>   * block-group-tree
>   * extent-tree-v2
>   * subpage support
>
>   Note those features may even not support clearing v2 cache.
>
> - The v1 free space cache is going to be deprecated
>   Since v5.15 the default mkfs is already going v2 cache instead.
>   It won't be long before we mark v1 cache deprecated and force to
>   go v2 cache.
>
> This makes the test case to fail unnecessarily, the false failure would
> only grow with new features relying on v2 cache.
>
> So here let's removing the test case completely.
>

Can we pair this change with a corresponding change in btrfs-progs
that blocks using v1? I don't think it's actually worth splitting this
change up in phases, especially when we're explicitly dropping the
tests around it.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

