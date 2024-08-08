Return-Path: <linux-btrfs+bounces-7046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD294BAAD
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 12:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321531F225E9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 10:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91E184526;
	Thu,  8 Aug 2024 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uin5/Ml1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711C189F58
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112232; cv=none; b=sxishOld7Ux5NmTunaSxrakgivgotjgvgdUGA6s12pYTpvtBHLQSm8bzPm4QUBGZYKKDLDlxGewuFV9wVseCuO9v8AQjnRwOZg22Jxp3p4rFsKwfBePuk+JBOm164QOj7WcbaHDb39H1L1Vg2gzBvoWtCW72n+XDkGRPulYxVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112232; c=relaxed/simple;
	bh=Q9wsY4PzEFTjrZCU4c/iXtAUAIEUZJTBtDCGEibPn4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3lHh5uB7d3XaAPEzMBk+q+9bLefoPCorrWUKttFr8xPM9bl9C4ajsGvYrgNzgYKrrRi8bAjA2BD1cgFT2DA2cs4sgsYlhNQk2qt9uwF+xg4ucg4HShm8vyS8e6+qnmIjvtIIO8Heg8cwTDakwK1QiB+HiJQKjgipBuKDQidevA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uin5/Ml1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968B6C4AF09
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723112232;
	bh=Q9wsY4PzEFTjrZCU4c/iXtAUAIEUZJTBtDCGEibPn4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uin5/Ml16qzI0pkJc+X9q4JJaWd3Unp2qvTPfb5510R1KDfTY6GfrzKYfsVPdDiZX
	 f84AkX8G3YdvdN8VfrSw8mJDC4c5snxUJtCdqocc/tyj2tn1930/BZ34OxbXDxR4Tj
	 9XFV2Cvz+0wI1P8TkU7JeltU6w/pyOjnNVthZiRj7dcJH3RYvUP50fJDI/QtoYuvEa
	 69/tVFHEdnczY6j2kSNd9rLMJHxDt3IOPUh1Use2arhRQvXpIJAdmg2bA0/R967wf4
	 HyQxvWn8vneqZuZiyjG3tVSJfMm9vfc8VsK4QaLWC7fBPv/xtu83TUR2+h1ZB3f5Ny
	 n/8OYPzOgqu6w==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f189a2a841so7058981fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2024 03:17:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YzsIDjcrpEvIb10c0nWSiA+THs6lBE1NK0WAooX3qDydDJp4BA2
	F5/mBugkiyeC3+J0cZxNx6Xpi0JZLig495vSur3+ktjRqYEnvRlXBOiBkyzzX0VF5ZIYLqUdB69
	7iE5dXI6RRfw54RnlQpid9K2J7oA=
X-Google-Smtp-Source: AGHT+IGZQQIDnmZ3hXG2ySMXX7kKpxAOGmhnBIf29RitB0EN124KWPTs1BSXKD2keVpFAWsrjryQ/h4KFAIYvq/VSn8=
X-Received: by 2002:a05:6512:3094:b0:52e:9f6b:64 with SMTP id
 2adb3069b0e04-530e58560a3mr1005208e87.34.1723112230905; Thu, 08 Aug 2024
 03:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723096922.git.wqu@suse.com>
In-Reply-To: <cover.1723096922.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 8 Aug 2024 11:16:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5UCmCOM4d8M+HXMq_EmFwa9HJY_ZZeDYGjGT2KM6rVDQ@mail.gmail.com>
Message-ID: <CAL3q7H5UCmCOM4d8M+HXMq_EmFwa9HJY_ZZeDYGjGT2KM6rVDQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] btrfs: reduce extent map lookup overhead for data write
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:06=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Unlike data read path, which use cached extent map to reduce overhead,
> data write path always do the extent map lookup no matter what.
>
> So this patchset will improve the situation by:
>
> - Move em_cached into bio_ctrl
>   Since the lifespan of them is the same, it's a perfect match.
>
> - Make data write path to use bio_ctrl::em_cached
>
> Unfortunately since my last relocation, I no longer have any dedicated
> storage attached to my VMs (my laptop only has one NVME slot, and my main
> workhorse aarch64 board only has one NVME attached either).
>
> So no benchmark yet, and any extra benchmark would be very appreciated.

You don't need to test with dedicated NVME or any dedicated hardware.

Use a VM and use a null block device.
Make the test scenario doing a 1M write into a file that has a few
thousand extent maps loaded in the inode's io tree, then measure the
total time taken by submit_one_sector() calls with a bpftrace script.

>
> Qu Wenruo (2):
>   btrfs: introduce extent_map::em_cached member

The subject doesn't match the change, should be btrfs_bio_ctrl::em_cached.
The name is also odd, "cached_em" would be more correct, but given
it's inside a context structure, just "em" would be fine.

>   btrfs: utilize cached extent map for data writeback
>
>  fs/btrfs/extent_io.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> --
> 2.45.2
>
>

