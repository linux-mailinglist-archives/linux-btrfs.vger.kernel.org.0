Return-Path: <linux-btrfs+bounces-11481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9A6A36EDF
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 15:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5923AE64D
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5BA1D89FA;
	Sat, 15 Feb 2025 14:43:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CB1A2643
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739630604; cv=none; b=HZPJUa+Zay131WFvrgPSBCZY6ya2BwrOlixm26w9q2zHUU+ok228XLl+f0SWSHIezp6IBB4L2hC0T24sYsEUEP49U3FeesAcH+8KJXeAN4ERK1hevNWAGHyf+ufjjusOtJhU4NtVboWnsJUTwXy9UvzVyFs609D8r5sp5HcYW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739630604; c=relaxed/simple;
	bh=lvHMn5W7kbzZ18maSKJjYz+xbIg8obFn4jC2QYchE0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QePJd0RS8q0a2fL5bOxZYW/bBLgy8gjtkZaRbll7TShoX91Ix3oJOT03JJb59YCDuj1GQBA//QFkkoWlmbNd20OczZKMiR6ePpbDgIgXlH6SdIF+uP1EFQHiKiFM+bpusd5n1xO45E/XBkZ8nli3Ujn6qekEmo+g3e+1QmDa0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e04c044224so10230a12.0
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 06:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739630600; x=1740235400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4eailxb+R4gpm24VLzByyrHh+Aoqg2pDQwV9K00ZJU=;
        b=B6pqmmiFMwTcMJ1bzfzvbb/P82pVRLbQmhTSuP5Aq2IFcbmfJ20/Ggn3PpNozGSv99
         yKp3aUY9VMe2EsUXLpRI/bU+f5pOBTTYHGfFRToE0JrswePVg/r0phXJsi2xbHS0MeUc
         9PWH9q7xTicBHhWWk+TcQypWgSLr0uiqOjmKLB/5Qe+Xvz44RdRrPOg6Kug+/IlV2Jvt
         49ucotA3xSeb+se8Wxl4Y+Ubc8O/RDPYso1K4UTAElaKzxsUw+ZAgjSQrM8/FiOKPYkT
         o4RA0HWZBdcgZQN6SVbyKgXe66P1yuLgwDF6I6vLowSHlamDeymEPLP7xEhIhQJEbMsz
         6DoA==
X-Gm-Message-State: AOJu0YyBxXtpG7OKJ44zOHfm3k9Q3HRK5yzX2zdyXZjR3533GX6CURvc
	Tk3sIORPoqRT2Uc4sP2Bb6XVBnniim7k1vRq6fvReojvW39UVmg92msTeksYDAM=
X-Gm-Gg: ASbGnctXPf+iYLOPwmi3UUQrySGZXpAFHqcg5U0hP0U9kIrSjSyghNo1IS6/zpuWAUb
	k+CLm5CMczmivRlu0WDUYw9YJt2qzcKZVqv8RqRWZ5U2fGzjGDU3OflrHxRhEH23+6qemcYbddt
	hx3saBv3DDJrMM9fGaIsj9fmQh1TSvwLuNDCdjyqURjvqHzKDYh97+1jZSISV38KaF0bb6pvAu1
	ddVYUT4Kek7JKWKMi1s3t1CVno2RmyRf6jwNZeYx/wLhDpCB0yEypl9DtzB4HvQNdd3v1iG8GEz
	sp6QKBCnKyrlhiz4rRA1hybtgUD6d9W61cta/PL9OzYOgg==
X-Google-Smtp-Source: AGHT+IFnBdveFPrxRjP0gOWMzqE7woZyl2fQsnVSYlF5t5sMkMVLMvbeCkSe7nijth6uoEFF0Vyqgw==
X-Received: by 2002:a05:6402:5210:b0:5de:be17:8 with SMTP id 4fb4d7f45d1cf-5e0361c7ebdmr2630312a12.23.1739630600097;
        Sat, 15 Feb 2025 06:43:20 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2721d9sm4655114a12.56.2025.02.15.06.43.19
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 06:43:19 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e04c044224so10208a12.0
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 06:43:19 -0800 (PST)
X-Received: by 2002:a17:907:7209:b0:ab7:bf2f:422e with SMTP id
 a640c23a62f3a-abb70bacd75mr298910166b.27.1739630599515; Sat, 15 Feb 2025
 06:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739608189.git.wqu@suse.com>
In-Reply-To: <cover.1739608189.git.wqu@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Sat, 15 Feb 2025 09:42:42 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-49QL43Q9O6ObqGniBbo+YPJ9P70vW61DkEgK0Y_UV9w@mail.gmail.com>
X-Gm-Features: AWEUYZnSMkTCrcKOEmTV-DqblpBJpvv4CRI0gdoY1toqXG46MJWScu5wGabXjXM
Message-ID: <CAEg-Je-49QL43Q9O6ObqGniBbo+YPJ9P70vW61DkEgK0Y_UV9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] btrfs: allow creating inline data extents for
 sector size < page size case
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 3:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [CHANGELOG]
> v2:
> - Add the previous inline read fix into the series
> - Add a patch to remove the subpage experimental warning message
>   The main reason for the warning is the lack of some features, but it's
>   no longer the case.
>
> For btrfs block size < page size (subpage), there used to a list of
> features that are not supported:
>
> - RAID56
>   Added in v5.19
>
> - Block perfect compressed write
>   Added in v6.13, previously only page aligned range can go through
>   compressed write path.
>
> - Inline data extent creation
>
> But now the only feature that is missing is only inline data extent
> creation.
>
> And all technical problems are solved in v6.13, it's time for us to
> allow subpage btrfs to create inline data extents.
>
> The first patch is to fix a bug that can only be triggered with recent
> partial uptodate folio support.
>
> The second patch fixes a minor issue for qgroup accounting for inlined
> data extents.
>
> The third path enables inline data extent creation for subpage btrfs.
>
> And finally remove the experimental warning message for subpage btrfs.
>
> Qu Wenruo (4):
>   btrfs: fix inline data extent reads which zero out the remaining part
>   btrfs: fix the qgroup data free range for inline data extents
>   btrfs: allow inline data extents creation if sector size < page size
>   btrfs: remove the subpage related warning message
>
>  fs/btrfs/disk-io.c |  5 -----
>  fs/btrfs/inode.c   | 30 ++++++++++--------------------
>  2 files changed, 10 insertions(+), 25 deletions(-)
>
> --
> 2.48.1
>
>

This is fantastic! :)

The series looks good to me, so...

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

