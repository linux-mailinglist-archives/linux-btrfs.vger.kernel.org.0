Return-Path: <linux-btrfs+bounces-3722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E3488FE93
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 13:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA89C1C22EFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21B37D3FD;
	Thu, 28 Mar 2024 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgTyohMR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5ED2E419;
	Thu, 28 Mar 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627441; cv=none; b=WB7iP74pszfP+RA1dreC+zlyNZabXfpOPAlEWgNWsKth1jD8VyevuseAQC5NiUPQZI3smcLMF13i2kYtVFTosX3CxD6Imt44KnmE6yLItjTC+Zfa646htlAEqaKS2Byctv7I61fMdog8oOYBCREvWvqp14mKAAl3ublt0fpe7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627441; c=relaxed/simple;
	bh=RzD9c4fn8HUOLQNBC27TERmJNDeCZavDEd1N9Xf6i8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU3bVzzN7U1inxk6rPerBXN0shc0ZdL3VIC4aM5XZblqP3tenT3PFprUrOEA/JKtCbCZOlXF939dlL6rGNOu4fKyWB4NC/vlk1V8tQ6RA9XpSMDtn0J1DlZ31vywHgJ14zLRfrjbteP+6dIW9vDd03zSNQxK3Xuz8hPT7ZexN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgTyohMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C3AC433F1;
	Thu, 28 Mar 2024 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711627441;
	bh=RzD9c4fn8HUOLQNBC27TERmJNDeCZavDEd1N9Xf6i8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AgTyohMReoxYDuc+Kky9utrqxXuQS50bDOpJfFGa4a/3kbYYSgHf52L6Og4MwsKVw
	 xbhzn5JwLEtYk+11eKHRbi083sFOc7E4nbhUuYl7O1Rewu9xX4pNqXUvEbNcsMehFc
	 EQHenGY8TYgIxb96iyhoAUQhK8GKfG2u1fTMAgELnB6YL8i58L0ZU59Eyeg4psZdeY
	 hb+SrpPmzxA01fsK8aQcRrmw2ec7MYlZjmP2wrFV+qf4scTLQO952QxfvkTCYIbGbc
	 eYWNscxeDTVvfXd+HkAIEu+R/T86XFYfGkqYRv1qKYFRSLTWnCLuMEDUauyKhjKkh8
	 Z0Fn2SOE8UgMg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a470d7f77eeso112522366b.3;
        Thu, 28 Mar 2024 05:04:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqac2mY7KfePrHlXJh+/JnjQiVYeq9p0HRv9zDNsBnR4i3B1XZcV468UNt9rArfHTJ2pUKt2CQGuIOWAHojqcHHNGYq6zfRkF6Irc=
X-Gm-Message-State: AOJu0YweWCvMuME2zwTZQYosvi0upZmxYVezdcM0mbnQ4++5H+4+aHL2
	AOy8myM3oolhe/UFWqYmeAwTCkGvXZ13yB87EIY1T+TnsnE850UQIbSk0Ni5Bt0HCLyWTZI5Vs7
	S7evpfpFJ9WhQ0vVhu5QNBQO1bpo=
X-Google-Smtp-Source: AGHT+IFTCoIphygeANimvrz6TL42uXOx9f59lVne9yZAb33oOufwwISEkbb+jYaoWMjt6ehLag2JSxN3p3bobL0+E84=
X-Received: by 2002:a17:906:1b45:b0:a4e:2691:49a6 with SMTP id
 p5-20020a1709061b4500b00a4e269149a6mr762547ejg.10.1711627440007; Thu, 28 Mar
 2024 05:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711558345.git.fdmanana@suse.com> <0689a969e9834f4c2e694404f41f0bf8b7a34a2f.1711558345.git.fdmanana@suse.com>
 <9383298f-a74b-4e2e-8f62-f1359ae68bc8@oracle.com> <58997574-3333-4ddd-aa37-3b177f19c0e0@oracle.com>
In-Reply-To: <58997574-3333-4ddd-aa37-3b177f19c0e0@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 28 Mar 2024 12:03:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4GjntZwft1tixdOK-0Kj1HyFEmixMHopA+XMP6nS1aWA@mail.gmail.com>
Message-ID: <CAL3q7H4GjntZwft1tixdOK-0Kj1HyFEmixMHopA+XMP6nS1aWA@mail.gmail.com>
Subject: Re: [PATCH 06/10] btrfs: add helper to kill background process
 running _btrfs_stress_remount_compress
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:46=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
>
> >> diff --git a/tests/btrfs/071 b/tests/btrfs/071
> >> index 6ebbd8cc..7ba15390 100755
> >> --- a/tests/btrfs/071
> >> +++ b/tests/btrfs/071
> >> @@ -58,17 +58,15 @@ run_test()
> >>       echo "$remount_pid" >>$seqres.full
>
>
>
> >>       echo "Wait for fsstress to exit and kill all background workers"
> >> >>$seqres.full
> >> -    wait $fsstress_pid
> >> -    kill $replace_pid $remount_pid
> >> -    wait
> >> +    kill $replace_pid
> >> +    wait $fsstress_pid $replace_pid
>
> The change first kills the replace and then wait for fsstress. Was this
> intentional?

It wasn't. But after all patches applied, everything's correct, we
wait for fsstress to finish and then kill replace.
Do you want me to fix that?

The sequence will have to be:

wait $fsstress_pid
kill $replace_pid
wait $replace_pid

Thanks.

>
> This patch is causing a regression. The replace never gets killed, as
> the echo-comment specifically states to wait for fsstress and then kill
> the replace. Following it fixes the issue.
>
> Which the patch 7/10 reversed the order to fix. But why?
>
> Thanks, Anand
>
>
> >> -    # wait for the remount and replace operations to finish
> >> +    # wait for the replace operationss to finish
>
>
>
>
> >>       while ps aux | grep "replace start" | grep -qv grep; do
> >>           sleep 1
> >>       done
> >> -    while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
> >> -        sleep 1
> >> -    done
> >> +
> >> +    _btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
> >>       echo "Scrub the filesystem" >>$seqres.full
> >>       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1

