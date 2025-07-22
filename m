Return-Path: <linux-btrfs+bounces-15627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876DDB0D65F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 11:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF19FAA5A7C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28F28D840;
	Tue, 22 Jul 2025 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6HFR0Ch"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075C1DC9BB
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178164; cv=none; b=iUz7zMscskO0JTyMFid7e4cuQ43PviEJ2iRqEwCQ0V/qCEIejItFAy0y6jouey7+5oNkDkZtX9TJ41l0oAUjvS1fX0MdF+/1DaZqBXVx1Fp+aNqblFn+2hnjl7mmftQU4RiaZxFjoZLcgKWol5a3O/O9KjawXfgWj2G/d8BSx4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178164; c=relaxed/simple;
	bh=yXU+wZIvIayrg5RARKkqXd9w9VRoLWp0DoC56EdMrbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JP4DgT52Y5J5KTR6Z84N4WUPKZxYt1tCWKbMLe9uZAQiNJnBL20wrP217IvMLL6yepIBRePIHAi6RPaQvvN33xZpF1H+F8bLb4FSXu2eVmPRaf+4Y8mqd/FPPXiwcVhiIdj2J5NuJ1mAr8xycSh15Hk4TwfhkdRtzcvqOk3nSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6HFR0Ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741B7C4CEFA
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753178163;
	bh=yXU+wZIvIayrg5RARKkqXd9w9VRoLWp0DoC56EdMrbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f6HFR0ChNi0g8oS8aF1OQ14ONfPSHwRXgGQIa0HKFDnMW7DsSNnhhK5tPG4wlK8I7
	 CyLR/PrQ1zae5GCcQCazdxV+2VdpBf0V2iQjm4D1v9RYpoNN7Lp5yiN/q7h8D6qY4C
	 iPvZlaUy0z5HmUWqFNMIsCEXLgv1fcx+Qjyr1m/w3BTHO3WTSzny8pWnpMpJk+GqQ7
	 sEDTdi+Jn0POVHctyNWqAdwqD+1jzpT31my3Q4C/SA/dK7dLDQXf5NjaVtAD82xoaV
	 InST219qrKev0zhthcuNgVHeaFLVZcxe6S+2iuxRN4iPQfujmuLS7WXAzh7Hw2c+tG
	 sbKtk/PQBIs/w==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so10092153a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 02:56:03 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzm1dcWARCjKoogwn3A5hT2cI3CjaXZ8xxPV4NZ0ySNjY++2Pg2
	ov1zNggBCb45HX5PiYc3dyFDMu2UB+N9HtXpyfYSr0EgQGnNpBX3yGvRVn9J1DXgaT8XgUMVFPf
	szesqQpcgiNOT4WM+g2W6EemDMzQmhEc=
X-Google-Smtp-Source: AGHT+IGKr+g/kNUVbg9MYKlIu9JR61yrZr+bbSSUuPwGFT4JMkaTNGkOFs9iGY25Yy8x3aXe5vb/hXMAtXCbLaQxBe0=
X-Received: by 2002:a17:906:7315:b0:aec:56e3:ce0b with SMTP id
 a640c23a62f3a-aec56e3d7bemr1554608266b.19.1753178161906; Tue, 22 Jul 2025
 02:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753117707.git.fdmanana@suse.com> <20250721202418.GA2071341@zen.localdomain>
In-Reply-To: <20250721202418.GA2071341@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 22 Jul 2025 10:55:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H78uZum1OJM0NELv2LPPhxtDpmv-UTXY=aeUgCU4Zgntg@mail.gmail.com>
X-Gm-Features: Ac12FXx4D92B9ViQAVtbwAn8GwbVHFHSOe-wt23pkhwK-OQCCIryO31nNL4TPPQ
Message-ID: <CAL3q7H78uZum1OJM0NELv2LPPhxtDpmv-UTXY=aeUgCU4Zgntg@mail.gmail.com>
Subject: Re: [PATCH 00/10] btrfs: improve error reporting for log tree replay
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 9:22=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Mon, Jul 21, 2025 at 06:16:27PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Most errors that happen during log replay or destroying a log tree are =
hard
> > to figure out where they come from, since typically deep in the call ch=
ain
> > of log tree walking we return errors and propagate them up to the calle=
r of
> > the main log tree walk function, which then aborts the transaction or t=
urns
> > the filesystem into error state (btrfs_handle_fs_error()). This means a=
ny
> > stack trace and message provided by a transaction abort or turning fs i=
nto
> > error state, doesn't provide information where exactly in the deep call
> > chain the error comes from.
> >
> > These changes mostly make transacton aborts and btrfs_handle_fs_error()
> > calls where errors happen, so that we get much more useful information
> > which sometimes is enough to understand issues. The rest are just some
> > cleanups.
>
> Reviewed-by: Boris Burkov <boris@bur.io>

Don't forget to hit "reply all" so that the list gets cc'ed :)

>
> >
> > Filipe Manana (10):
> >   btrfs: error on missing block group when unaccounting log tree extent=
 buffers
> >   btrfs: abort transaction on specific error places when walking log tr=
ee
> >   btrfs: abort transaction in the process_one_buffer() log tree walk ca=
llback
> >   btrfs: use local variable for the transaction handle in replay_one_bu=
ffer()
> >   btrfs: return real error from read_alloc_one_name() in drop_one_dir_i=
tem()
> >   btrfs: abort transaction where errors happen during log tree replay
> >   btrfs: exit early when replaying hole file extent item from a log tre=
e
> >   btrfs: process inline extent earlier in replay_one_extent()
> >   btrfs: use local key variable to pass arguments in replay_one_extent(=
)
> >   btrfs: collapse unaccount_log_buffer() into clean_log_buffer()
> >
> >  fs/btrfs/tree-log.c | 659 +++++++++++++++++++++++++++-----------------
> >  1 file changed, 401 insertions(+), 258 deletions(-)
> >
> > --
> > 2.47.2
> >

