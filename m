Return-Path: <linux-btrfs+bounces-16466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF74EB38B94
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95CF0687BB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57130DD24;
	Wed, 27 Aug 2025 21:43:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666A283680
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331004; cv=none; b=DgR/X3e2HJoFrTRc5m8SvbvV0fJTJG+QJKmazcKOvXy0RVdKJ0rDkO6V4+EWLokAL0MF83/RUaRIXfneypXqay7XhMKD41m5jJStxh9I8PlNFowQ9CwpwQ6z0WcdMxXzTRHG8GZmASOrEGaQhRu3E7gOwdGjIfZImAcjk4Hmjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331004; c=relaxed/simple;
	bh=+JWsUxvoEUaWI+WBTOv6Zkj4BPf/6GM0ilesYK1/dRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HO8z7BvrZkDiN3h9rCPfsruo4/oFnR4EAkT1IJm3bcd98w3dhTQO7QpE7jaWGtTM+iidWImFU+E0MVkt8+S77c809BGwlhFGKRFh1hz1vgiTWcanATtaSpQE2XYsg5SisIProiygt+G89P61Gh3C9JsoSxfOY/Q59FnORrQfYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afee6037847so2385866b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 14:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756331001; x=1756935801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMFCnr4BvZRTFnxhaD14N+y8/9azDHMLJJby2N6NgD0=;
        b=dIdX9VCrUieaeeL9E61sInq3qGzNBsWxgVrryI+gC83dyzZD5hDnyDRg4mYvn29Qhu
         32gksJhSSvV1sAFKr8+nj3aee1lbLG0+vKF2FrQR7lXuvLy/+Hc35Dhg021OSLIzbJeQ
         ZtAvU7t3XbPhsRM7H1IPi6Nkwne+1xFaHuxH9Fz9gvvtK5YDRLBk0unwr2VtGenvTxHv
         9ipTMCZc3adRJLcJYh4r5Hz0uOrL34JPrAhNuldV27roj9L+Fa2dkFhdEOi50lSmoIoj
         DKlahZKKbTkdPSKFMvm4/h+GMnNh6qVnt83nVBqnv3UtN7R6XWEoHh55clquIVWkqCr8
         qO2g==
X-Gm-Message-State: AOJu0Yz3pYoey6kyRox/QKv1v9CMF2hOBdQ2bbgIThmdpnjfF1D7++dc
	SMeqMBdSnTicKTbwVEmXgWWQGmLMmCEeGEeXYC0h/t+6dfZpdXv3y3s2OgMaC2hv
X-Gm-Gg: ASbGncuNYudgTJLuaslS/9ecabOVfmYdno7kH+WAg4xTQvsezHbH/tgS8BorTk4K5ru
	2v/e0fs109PxaIKTnKon4Kp6WCzSNucLBm+w4Jf1OiTOavFo72RM5+VVZgc3dzEAz//t7oMKBTi
	A/CK376oRkoHIJHlONm0iM6Sj0Y1+xH0Nw0OhmXxW8PGcwr3Hi6p56hKfd7ICSViFGnYka7E9Na
	yi8sYWG5cm7lCdc1KQg7OfRH9/R+zZbkkBMXME6FeIhycETLWq+c4XGXMBEgz9GDVRX0LEwEIQo
	g88+7Jl2FwqJ9Ua2MS5f9pNpoco61U8vEP6MPdsHIaA6urN+8+hMFwG9YckkRYe2nzCHbjPdT7V
	eq/X79WFFr3V63LYPnooPAHZ3MW3Yl0AQMbZ8SaVS8NUB8NJmAXuoIHu65oEZ0p3oTclHrATZzp
	bShZa5gLGE
X-Google-Smtp-Source: AGHT+IHPX6c46HhUUSPh6ctBKwv/ukRVqd0hrkQasgTqrCd4O6hk+VebNX8nkeSbyON5TUzyaLxl0w==
X-Received: by 2002:a17:907:934c:b0:add:fe17:e970 with SMTP id a640c23a62f3a-afe28fbaffcmr1923960266b.14.1756331000606;
        Wed, 27 Aug 2025 14:43:20 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe92b3dc53sm594530966b.3.2025.08.27.14.43.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 14:43:20 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so306551a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 14:43:20 -0700 (PDT)
X-Received: by 2002:a05:6402:21c1:b0:61b:ff85:398b with SMTP id
 4fb4d7f45d1cf-61c1b4a2163mr17649357a12.14.1756331000073; Wed, 27 Aug 2025
 14:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821225742.1151914-1-dsterba@suse.com>
In-Reply-To: <20250821225742.1151914-1-dsterba@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 27 Aug 2025 17:42:42 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-x4pnuO8VnP_+BQyOmA57H0xHndUFZ=5-y=UWoiRJ3cw@mail.gmail.com>
X-Gm-Features: Ac12FXzKI1P7BeSPDGragaPmiEgdCOVipaSqr1KbhGl8lr-Rq01vupVUdKDoaAA
Message-ID: <CAEg-Je-x4pnuO8VnP_+BQyOmA57H0xHndUFZ=5-y=UWoiRJ3cw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix typos in comments and strings
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 7:01=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> Annual typo fixing pass. Strangely codespell found only about 30% of
> what is in this patch, the rest was done manually using text
> spellchecker with a custom dictionary of acceptable terms.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/accessors.c                |  2 +-
>  fs/btrfs/backref.c                  |  2 +-
>  fs/btrfs/backref.h                  |  4 ++--
>  fs/btrfs/block-group.c              |  4 ++--
>  fs/btrfs/block-group.h              |  2 +-
>  fs/btrfs/compression.c              |  2 +-
>  fs/btrfs/defrag.c                   |  2 +-
>  fs/btrfs/delayed-ref.c              |  2 +-
>  fs/btrfs/dev-replace.c              |  2 +-
>  fs/btrfs/disk-io.c                  |  2 +-
>  fs/btrfs/extent-io-tree.c           |  2 +-
>  fs/btrfs/extent-tree.c              |  8 ++++----
>  fs/btrfs/extent_io.c                | 10 +++++-----
>  fs/btrfs/fiemap.c                   |  2 +-
>  fs/btrfs/file.c                     |  4 ++--
>  fs/btrfs/free-space-cache.c         |  4 ++--
>  fs/btrfs/fs.c                       |  2 +-
>  fs/btrfs/fs.h                       |  2 +-
>  fs/btrfs/inode.c                    | 10 +++++-----
>  fs/btrfs/ioctl.c                    |  2 +-
>  fs/btrfs/locking.c                  |  2 +-
>  fs/btrfs/locking.h                  |  2 +-
>  fs/btrfs/scrub.c                    |  2 +-
>  fs/btrfs/send.c                     |  6 +++---
>  fs/btrfs/space-info.c               |  4 ++--
>  fs/btrfs/subpage.c                  |  2 +-
>  fs/btrfs/subpage.h                  |  2 +-
>  fs/btrfs/super.c                    |  2 +-
>  fs/btrfs/tests/delayed-refs-tests.c |  4 ++--
>  fs/btrfs/tests/extent-map-tests.c   |  2 +-
>  fs/btrfs/transaction.c              |  2 +-
>  fs/btrfs/tree-checker.c             |  2 +-
>  fs/btrfs/tree-log.c                 |  4 ++--
>  fs/btrfs/volumes.c                  | 10 ++++------
>  fs/btrfs/volumes.h                  |  4 ++--
>  35 files changed, 59 insertions(+), 61 deletions(-)
>

Overall LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

