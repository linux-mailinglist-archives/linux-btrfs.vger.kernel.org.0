Return-Path: <linux-btrfs+bounces-8641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9330D995153
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 16:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B591F22545
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277371DFDA3;
	Tue,  8 Oct 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHRlMuOP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E011DFD80;
	Tue,  8 Oct 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397131; cv=none; b=hVCFxWZePwBWEE3jEOkW3gs8bBiwOXh9+gN+Ct1xWGOZaY9UILlT5dNPlh8LPbx2+/IMypgB3+NfhOEuSYTs28m6z06Tx3KFNAbjaoNJyiC6rE/ne7a1jdtHhS119x1BvTxMdCHSa5ePw+HjF3dfxRRkE+/tDTdGribZwyrpI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397131; c=relaxed/simple;
	bh=FgQacFkSKoqINFn6Px05i/9GjaJb1hQMc4IcaqwEygU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn+9vYkUtgq7uR7vdMeMp3vhamksWVgO86e9gISYUGN3OGdB8m84hl26xbCewYiOf8v8WWxJp2ZCIv6g07RV73lbwtrqBcsJ6QRMxkX539sBXiqL9NSDGgv3wCKj6aMMvsJgit9kkV8R+c2+4Nap1RG7yuiBatQ4XDAZgRUkCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHRlMuOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B6DC4CECC;
	Tue,  8 Oct 2024 14:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728397130;
	bh=FgQacFkSKoqINFn6Px05i/9GjaJb1hQMc4IcaqwEygU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gHRlMuOPVSU4PJvHYBWxkWMBly7bTyDgGyVEkiZVr6FYeV4R5uG8U1g06xCY900wn
	 Scw9eWIUZN+z7osM8RE7KDjG4noVkDE6DjacXRmjxPyYoTFU14bHcWsstv3WViGJO5
	 tnHHcO8jj67fHsWuJ4HxASEWax01/MhYiCN+zrsCVPWaduIbX8DiS6p9uHjAYjo+BV
	 bQooTrUjaWR1tCZurzaov014LLWux0zZwSfThT1u7hlR+cQBNmprohrHYACsfZ1Q6v
	 MjA+ypcicFkdP+11LDGvKdMjB3g4p9j+ij6WY9G3gR9/C8piHGsJWzb3fDHAvZNKIk
	 T5h78pHqsT0Ig==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5389917ef34so6539470e87.2;
        Tue, 08 Oct 2024 07:18:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRYLM0nBYwR9dg8QyOZ8Lc7o6pIiNWETZtwaW30SM+jJfscst1VYfNsO+6nhD1XscWvGTsdN9Lbh2mmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OIrMZ72oaMxIDZRd7KYcOwpVGJnoZ1GtsU2iJdsHli2AP2Gi
	u+5WAV7HkB3P1iN6LtKe8x7XwE1BMDTJxhWi39gsBqCR+oJMZBEkL8HOeQNZJqSYdgsvNocY5HM
	FVZrHGwvfPVLVpOqSGLrRrUGR210=
X-Google-Smtp-Source: AGHT+IFSLyyoPof5xI06XZfoEs0I5dXuTMENpBaNrseV1RxeZIOMdjZs64yHUNVxPcA7oP8rEGOPOuwSAsN2S1kadBU=
X-Received: by 2002:a05:6512:31c3:b0:530:ae99:c7fa with SMTP id
 2adb3069b0e04-539ab85b452mr8441900e87.10.1728397129135; Tue, 08 Oct 2024
 07:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008112302.2757404-1-maharmstone@fb.com> <CAL3q7H4oGiDQ4bahbJmxw9zp8CuzAF+VzJvqqdx10A8qyNk1Ag@mail.gmail.com>
 <ae203ea9-d5d4-4d25-825f-e017f23b3bf7@meta.com>
In-Reply-To: <ae203ea9-d5d4-4d25-825f-e017f23b3bf7@meta.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Oct 2024 15:18:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4izTkoF=RspYASMcn2wQK4cYpx8ecT84wSq2b+zsuNRQ@mail.gmail.com>
Message-ID: <CAL3q7H4izTkoF=RspYASMcn2wQK4cYpx8ecT84wSq2b+zsuNRQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add test for missing csums in log when doing async
 on subpage vol
To: Mark Harmstone <maharmstone@meta.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:06=E2=80=AFPM Mark Harmstone <maharmstone@meta.com=
> wrote:
>
> Thanks Filipe.
>
> On 8/10/24 14:35, Filipe Manana wrote:
> >> +_begin_fstest auto quick metadata log volume
> >
> > Why the volume group? The test isn't doing any volume management stuff.
> >
> > However it should be in the "recoveryloop" group.
>
> No worries, I'll change that.
>
> >> +_log_writes_replay_log mkfs $SCRATCH_DEV
> >> +
> >> +_log_writes_fast_replay_check fua "$SCRATCH_DEV" "$BTRFS_UTIL_PROG ch=
eck $SCRATCH_DEV"
> >
> > Why do we need to do the replays twice? Once with
> > _log_writes_replay_log mkfs and then again with
> > _log_writes_fast_replay_check fua.
>
> _log_writes_replay_log mkfs to put the FS back how it was after
> mkfs.btrfs, _log_writes_fast_replay_check to replay it from there. Is
> _log_writes_replay_log redundant here?

No, I missed the mkfs mark passed to _log_writes_replay.
Though it still seems redundant because _log_writes_fast_replay_check
is called for each fua mark, and after mkfs we have a fua.

>
> > There's also nothing in this test that is btrfs specific, it could be
> > made a generic test instead.
>
> Yes there is, it's running btrfs check every time.

Right, but instead of calling it explicitly, it could pass
"_check_scratch_fs" as an argument instead, and the test becomes
generic:

_log_writes_fast_replay_check fua "$SCRATCH_DEV" "_check_scratch_fs"

Thanks.

>
> Mark

