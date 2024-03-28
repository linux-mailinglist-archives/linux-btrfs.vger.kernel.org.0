Return-Path: <linux-btrfs+bounces-3712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1788FB5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535351F22BF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54B6FE07;
	Thu, 28 Mar 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX1qNHe2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3832952F6D;
	Thu, 28 Mar 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617989; cv=none; b=Vt7fjSBf+bPs6/n6ou7lxX96Tv3cOdiofWVpW2izabyBeDsDa72MZpPnn79z4LN7N7gcG5xGc06N5EeHZIr3QImqvHKbtSkF3Nvu7A2SwK1CXThX/7brgIssC/5AET3nAlJ8/aHjj0M/w9QDR+D5P7d02WguUVuqZWZAr5Y61G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617989; c=relaxed/simple;
	bh=46ajUGacT80fVMezKjGffjefmAN+m1jiCXu+nXP3SsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZJvETgOxdYO12xJGtGgyEzV/3zNgLKov8IzaskqmL0rRr6aBp25q9Kso+H3pt8uAncm8cf5Zvw9V7LbOrzCx4HMnibgOxbHWyy83nE3+DmX00m5Uu96PHR/r+OCJ1PPRw/Qs0fMaD+wr6NyxcT1nWot0PzyAZLWsOdWIkdI8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX1qNHe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A75C43390;
	Thu, 28 Mar 2024 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711617988;
	bh=46ajUGacT80fVMezKjGffjefmAN+m1jiCXu+nXP3SsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TX1qNHe2uOjeE/F0ag8uIrWS/+caPcsKxRzmFT3pgyu46ly/XoxKvxqBbqhiVYoWG
	 r2l/BfY3XepLms1CLpGkGYe9g2t+AsmRyWsN9fW3RgOxMhTNs+3gHWqBl2/bKvMQ8I
	 gneAzd4wL8MNxaF5CVoImCtqixC+ujcnQbozyk+O8subU0TdmEFpbOOCxd38JdvWR9
	 XCgOKJqsbk2dYECVfVFceBe1c96qeKEtz/R6G4dyTp7tDBPbtxcQAexR6yG7ea4ycR
	 jIEjxRRGiOU4uwcJy5Zp50kInRWyBgfN84yvvpOdTLUzEHJ3g0vtgCyXc7gov09CfY
	 bsF06NNMgGk6w==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-568c714a9c7so766133a12.2;
        Thu, 28 Mar 2024 02:26:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUChTZn5LGXF9ZZE7gFhtKATq2dXRcZAZ0z8rn7n0Ll9HFgYZ6iyhcaTySu9hWLI8Prv4JL1HIngnaFL0RqF/hdU/SRtjydcX9ZeT0=
X-Gm-Message-State: AOJu0YzOlRI7EDTvRAvXLH21oSWL4K6neOmYY3LwwQ5JQpQj6ph95wJP
	ubFXNnEJ3pAPpJowGAQz5Y9VXAd2m9hzJ62FJ40Ir2+Zj3I+ODuzFGCVMvORPuXzY/OEvpPa6UO
	lWM39UMktiWcvDDN9ny2uGI4NzkY=
X-Google-Smtp-Source: AGHT+IFFkzn1//WqRKIAu91ti45K+mrZbIG8BW1k34HqvZ+jrULEiSnxYdipZJ3344SN79VnUPZmis+5G7PY1hQVVf0=
X-Received: by 2002:a17:906:414b:b0:a47:438e:c6f7 with SMTP id
 l11-20020a170906414b00b00a47438ec6f7mr1338337ejk.63.1711617987382; Thu, 28
 Mar 2024 02:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711558345.git.fdmanana@suse.com> <375e94a8cc448c369d4346cba2f6ef6f65b34df6.1711558345.git.fdmanana@suse.com>
 <64c47fe3-8db9-4f9a-aac0-64cc5bb07fb1@oracle.com>
In-Reply-To: <64c47fe3-8db9-4f9a-aac0-64cc5bb07fb1@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 28 Mar 2024 09:25:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5eaAg=avgdnDjXzOOSYOFuQ_znwAcqwdg+4gDxJ1kMQQ@mail.gmail.com>
Message-ID: <CAL3q7H5eaAg=avgdnDjXzOOSYOFuQ_znwAcqwdg+4gDxJ1kMQQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] btrfs/028: use the helper _btrfs_kill_stress_balance_pid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:41=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> On 3/28/24 01:11, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Now that there's a helper to kill a background process that is running
> > _btrfs_stress_balance(), use it in btrfs/028. It's equivalent to the
> > existing code in btrfs/028.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/028 | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/tests/btrfs/028 b/tests/btrfs/028
> > index d860974e..8fbe8887 100755
> > --- a/tests/btrfs/028
> > +++ b/tests/btrfs/028
> > @@ -44,12 +44,9 @@ balance_pid=3D$!
> >
> >   # 30s is enough to trigger bug
> >   sleep $((30*$TIME_FACTOR))
> > -kill $fsstress_pid $balance_pid &> /dev/null
> > -wait
> > -
> > -# kill _btrfs_stress_balance can't end balance, so call btrfs balance =
cancel
> > -# to cancel running or paused balance. > -$BTRFS_UTIL_PROG balance can=
cel $SCRATCH_MNT &> /dev/null
> > +kill $fsstress_pid &> /dev/null
> > +wait $fsstress_pid &> /dev/null
> > +_btrfs_kill_stress_balance_pid $balance_pid
>
>   I didn't understand the point of replacing 'balance cancel'
>   with 'kill'. The Git change log also doesn't say anything
>   about it. The old code also tested BTRFS_IOC_BALANCE_CTL ioctl.

The point is to use the helper to kill the background task running
balance in a loop, so for every _btrfs_stress_balance() call we have a
matching _btrfs_kill_stress_balance_pid().

Doing the kill + cancel is equivalent to what the helper does, and the
goal of the test is not to exercise the balance cancel.

Thanks.


>
> Thanks, Anand
>
>
> >   _run_btrfs_util_prog filesystem sync $SCRATCH_MNT
> >
>

