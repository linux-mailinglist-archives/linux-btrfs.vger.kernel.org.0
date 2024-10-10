Return-Path: <linux-btrfs+bounces-8814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A2998DCF
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 18:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB37D283293
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E5319992D;
	Thu, 10 Oct 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7mVpnl+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3363F7462
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579016; cv=none; b=PnolfxgMKmG6Qi5fRVkCjOXrZmM0Ht53NVLOGjiHdCO5lWJmLKW7smJWLUWhaDnGFawRJh3by9u2GcpAFKGvgqaa8mupIBUpYpO4JgSdV/9cSYJSjIwxSUPS1AxD5CZsQspqPb9743h8G3z4vjPkWQsHZ8FYKD0Pkmcmz9V4sfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579016; c=relaxed/simple;
	bh=mT3tnS8Alm7UsXjfKaz0PNaw2uOUuKJguP00D/T9A0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cd3198QYq9d19IJ/4wwnxaCSNd8fA/mGvpi294j+rt3QOE/89X8BA63SEHDgYuKOPQzNPr0B+CWAgxZaVPIsr5ewiPS/VD9HGW0XFQYazlUuEMY85Ux0UmZKesF2w5rlT3Ix5KWIZuv/9qKz6AFBOff4wKm5AoxdZeTxFl4gBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7mVpnl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A478BC4CEC5
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728579015;
	bh=mT3tnS8Alm7UsXjfKaz0PNaw2uOUuKJguP00D/T9A0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F7mVpnl+Y40MQf23fkoX69ShBkbxQjCw8Ke0JliRip0sqEaH96DfpwyX2ls5LhXKt
	 GoFHCf1Qvoxy/eyF3zg8EWTJLu79qpDYFI3DtJb/2UotMMNa0LH0MkuZn1Y0r0/xBd
	 lfQlCs8ODH5U8QTscHecnyn+qyjb7pZP4I0pVy/EuMhMLUqUWY92gsIe2JUjYAspjA
	 HGzZMnke0sg4/Pb7zlk/3jKG4VtbTmzQ78309YRgHjjUe69MLvhxupXkl4T5qtC/uC
	 wBAHFyv36/fReWg96fOFLcKzOdC5NoQU0W2n9rZhi8rEKJM/j+tuBrPNW9jnuz7e0I
	 f1TWD6fLj5A/w==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso186549366b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 09:50:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YwBQ+TM+YYHJWwAkH88unPlVuNijU8Gmr17dFLKbABuhvGHMukF
	7KzPzSXej5b0owot8sItsTHWgXubddFdnuRbnNLSMvGaL5gUCLgeHjZbksk+nR44gOB/p7twnA1
	GkbjZ9J83paa5wsCMJUP3Mx21n98=
X-Google-Smtp-Source: AGHT+IH5ahkGTXl6n6BdlKD0l04tdeBLKkHAfyDmX0+SevCd/E/hxr/Yq3gioe2ZVyCAdWgiVD0v8wRxV5xIKlZi5s0=
X-Received: by 2002:a17:907:944c:b0:a80:f840:9004 with SMTP id
 a640c23a62f3a-a998d11fc90mr566152866b.12.1728579014229; Thu, 10 Oct 2024
 09:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727174151.git.fdmanana@suse.com> <20241010144826.GA10456@fedora>
In-Reply-To: <20241010144826.GA10456@fedora>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 10 Oct 2024 17:49:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5o6kVwVoe4=Ueqfqeg36h5Y-b1x+Nv73eR1L8donJV2A@mail.gmail.com>
Message-ID: <CAL3q7H5o6kVwVoe4=Ueqfqeg36h5Y-b1x+Nv73eR1L8donJV2A@mail.gmail.com>
Subject: Re: [PATCH 0/5] btrfs: make extent map shrinker more efficient and
 re-enable it
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 3:48=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Tue, Sep 24, 2024 at 11:45:40AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > This makes the extent map shrinker run by a single task and asynchronou=
sly
> > in a work queue, re-enables it by default and some cleanups. More detai=
ls
> > in the changelogs of each patch.
> >
> > Filipe Manana (5):
> >   btrfs: add and use helper to remove extent map from its inode's tree
> >   btrfs: make the extent map shrinker run asynchronously as a work queu=
e job
> >   btrfs: simplify tracking progress for the extent map shrinker
> >   btrfs: rename extent map shrinker members from struct btrfs_fs_info
> >   btrfs: re-enable the extent map shrinker
> >
>
> I think as a first step this is good.
>
> I am concerned that async shrinking under heavy memory pressure will
> lead to spurious OOM's because we're never waiting for the async
> shrinker to do work.  I think that a next step would be to investigate
> that possibility, and possibly use the nr_to_scan or some other
> mechanism to figure out that we're getting called multiple times and
> then wait for the shrinker to make progress.  This will keep the VM from
> deciding we aren't making progress and OOM'ing.

Right.
The problem is how to decide when to wait and if the waiting will
introduce latencies - maybe wait only if the current task is a kswapd
task.
If you have concrete ideias, I'm all for it.

Thanks.

>
> That being said this series looks good to me, you can add
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> to the whole thing.  Thanks,
>
> Josef

