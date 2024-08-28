Return-Path: <linux-btrfs+bounces-7611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEACD96265C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 13:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB2028366B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C73174EEB;
	Wed, 28 Aug 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhnuLfcS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697515B12F;
	Wed, 28 Aug 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845861; cv=none; b=IiJYCFR2K76wlujveshWk5Eu5JmvXLPOSCtZFm1GGxez/KZEk4qA40VYt+pxS1zPrKLKrttNupNC4i540HcPgHB+FgUbYKbvpyHGQOt/8L+c3T3Zf4YT+bkCFc0WjRLr9bTf+HQTBgpq/5ZPlt7RI8SuInYkWmgfcsbwuU8Ix9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845861; c=relaxed/simple;
	bh=W6vl4mDA3+v4crm8Fj7paGy4jlpqrKbUPK8vENUlUuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4IdqLkq7fqSU1x9dJkua55BvNpLXGPbpyss9AOUkg5r1+5rgN4Rd8LGEf3v+ffDnClRRgvxMgnsZ6CmY4PA0CstZ1zr3lXU1/FYrxYqC8D229YSYLIU7y4/dKUuAOunQEe5nli3c+Y7pq2MJf4/gH2xD6MNyI2akO/ss7NLr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhnuLfcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741DEC98ED2;
	Wed, 28 Aug 2024 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724845861;
	bh=W6vl4mDA3+v4crm8Fj7paGy4jlpqrKbUPK8vENUlUuU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YhnuLfcSBaTHzJDNA6GaszJh0/ai3mou9NcfqRoHm5CqUyrYIxy74lgnbToWwMLNY
	 NX/EIvnEvqCEsuZ11Fk9t2i5Og6o/7e4GNM5f8/zDMCuHSQDaOPqdjTRQGjaFu8Q2G
	 tnKvSkg5Oev6G+VZi7xjqNSlodFV/U9fhlQadgUlqu1JQ3b1UOVOMSR+shz+oKo8Qd
	 g/hgnb+qZRavKubPIQF/REFkHTYPWXDdnlzR/HoqjVvIlGXRvEdMsGsNIIJd7G1zps
	 c++G8A+6FXqf3Vn1v3HLT1xj2oeIYR0Kx6/Kjn3MxJH4mZjzRRKuXVWzz2WWcy/nKP
	 l6w5Ec/EuW09Q==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86910caf9cso102868666b.1;
        Wed, 28 Aug 2024 04:51:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7Kec72mZN0SA7BEE0VLwc/NSJ219WEo9TxEnA87dMBcQqXl6leQraEeqP9MY1ktjGCCoD8xZ68YCf8w==@vger.kernel.org, AJvYcCXeAftv2jyZFPxnU/M1VixrtrDAVvSlO5LKUr/kPo/2AQYHMnNEcnaZU0qepOnYbh1XDJeGRSaI59JfMFIo@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSNuLUNxwLfGeZ7PAZW5Hq2rUf2NPr15Ha/gLpva9tUgkwLVY
	1qM2K8cqi8Okwku3GGDWItgxkL14P4M6yiMcBk2fUZiY8gLnRtcygxAkevyuHzfwffYBz4RvarA
	M5KC0I5hA2lkeWBTgCt8feYk/bLY=
X-Google-Smtp-Source: AGHT+IGKY+y0ITJs1NlttvaukWau5KEZ6zPElyET/Jg1biFki/zyk2t9V5vK15OAw0luscG5jfwhorYdnfiQxvVj/0A=
X-Received: by 2002:a17:907:2d8b:b0:a73:9037:fdf5 with SMTP id
 a640c23a62f3a-a870a92234emr211183166b.6.1724845859960; Wed, 28 Aug 2024
 04:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724844084.git.dsterba@suse.com>
In-Reply-To: <cover.1724844084.git.dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 28 Aug 2024 12:50:22 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5L9ebGLyPkVFOtG7sEfAj7f17e6uzH2g7s5MUc59FAsQ@mail.gmail.com>
Message-ID: <CAL3q7H5L9ebGLyPkVFOtG7sEfAj7f17e6uzH2g7s5MUc59FAsQ@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.11-rc6
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:23=E2=80=AFPM David Sterba <dsterba@suse.com> wr=
ote:
>
> Hi,
>
> a few more misc fixes. Please pull, thanks.
>
> - fix use-after-free when submitting bios for read, after an error and
>   partially submitted bio the original one is freed while it can be still=
 be
>   accessed again
>
> - fix fstests case btrfs/301, with enabled quotas wait for delayed iputs =
when
>   flushing delalloc
>
> - fix regression in periodic block group reclaim, an unitialized value ca=
n be
>   returned if there are no block groups to reclaim

There's some confusion here.

First, it's not a regression because the uninitialized return value
has been there since periodic block group reclaim was introduced.

Secondly, and more important, is that it doesn't cause any problem
because the only caller of the function ignores its return value.

So this is effectively more of a cleanup than anything else, and could
have waited for the next merge window.
I see you also added a Fixes tag to the changelog, which will trigger
stable backports.

Unless there are compiler versions or static analysis tools that
complain with warnings, it will be just overhead to backport to stable
releases.

Thanks.

>
> - fix build warning (-Wmaybe-uninitialized)
>
> ----------------------------------------------------------------
> The following changes since commit 534f7eff9239c1b0af852fc33f5af2b62c00ed=
df:
>
>   btrfs: only enable extent map shrinker for DEBUG builds (2024-08-16 21:=
22:39 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-=
6.11-rc5-tag
>
> for you to fetch changes up to ecb54277cb63c273e8d74272e5b9bfd80c2185d9:
>
>   btrfs: fix uninitialized return value from btrfs_reclaim_sweep() (2024-=
08-27 16:42:09 +0200)
>
> ----------------------------------------------------------------
> David Sterba (1):
>       btrfs: initialize last_extent_end to fix -Wmaybe-uninitialized warn=
ing in extent_fiemap()
>
> Filipe Manana (1):
>       btrfs: fix uninitialized return value from btrfs_reclaim_sweep()
>
> Josef Bacik (1):
>       btrfs: run delayed iputs when flushing delalloc
>
> Qu Wenruo (1):
>       btrfs: fix a use-after-free when hitting errors inside btrfs_submit=
_chunk()
>
>  fs/btrfs/bio.c        | 26 ++++++++++++++++++--------
>  fs/btrfs/fiemap.c     |  2 +-
>  fs/btrfs/qgroup.c     |  2 ++
>  fs/btrfs/space-info.c | 17 +++++------------
>  fs/btrfs/space-info.h |  2 +-
>  5 files changed, 27 insertions(+), 22 deletions(-)
>

