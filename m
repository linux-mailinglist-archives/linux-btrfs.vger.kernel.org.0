Return-Path: <linux-btrfs+bounces-8643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF91995229
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 16:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408041C22667
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9061DFDBB;
	Tue,  8 Oct 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3urbqTR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21D1DF971;
	Tue,  8 Oct 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398691; cv=none; b=s6sSBXIOlmHeGtyhrmZQq+0QnJuDmip+8vE9uMztSb45o+w2481ZqB6ZVtT+7n7+Jm9hGDRm9EYyIIrj1YF7nj3nmA1SxYSwmwzI9iaiJ/pjrIN29gQt4lBCkpetOd2TEfxNS8qeiHwwiChTMdTzCVU0lcU0C7ZpV4gNyDY6K6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398691; c=relaxed/simple;
	bh=ERDihioP17pHxuG/4a2EH5lYQa6/1GH1mNIybpg7ZaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltZSywB+uF3pMOiop5QyP0dx0auKuHpJZQnxgQ0c6aBHkygRLpeYfgSGNUYTJzfZjbaqhjxNy6fZ3SlVmIubvIHHZkGbzMxeDrtBTVqPoPOG97nXSp7PQyDaYpm+O/D4x7dcyu6OBMkpVA/X8cz7ZmGTXwCQxt2nqlySwlwHNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3urbqTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1094BC4CEC7;
	Tue,  8 Oct 2024 14:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728398691;
	bh=ERDihioP17pHxuG/4a2EH5lYQa6/1GH1mNIybpg7ZaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B3urbqTRtLtSAUbjw7qxC88I36+i3eT8kpcUwFytOkD5vWZeM45G2M8+tAbgY7DUu
	 57vW1XMPSjIpDZmkyBDnKFv+I/gu99kHrf3z4yEeTLEaIRFmdIcFQUk62olLsSZxfW
	 /NMhQiGW4noMfJYny4ho0X9D29+2RPtinABkq5BCOa2yp3db6S3wSrb6kO+fzTgIro
	 ZibXSGn2adGIXZs/2ss4npuseB7YhlErjBCED3B24rNLGBuPLYZGOiGnO6UC6p92hC
	 OeMVaXyLdrKPOx7hupcZwzeI2grDCRxS9du8y0khk2O3RIGMXILDylQZSgQwSxcdRe
	 TJYVtSjGrjcDw==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso77113895e9.2;
        Tue, 08 Oct 2024 07:44:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmBjthI7JkdLZ+BpRBbligUzpvgFB27+pP2tSgpQm9t9KN8tA0uAVGgIJ88WXYWNk7YXPEx1lrXU32FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkB7lfjdeZ2ybnSPCYWbtkn11afwACx5XVQWIq0QifVxtCZYA
	Zba2tIqyQ7NyxuqFCztMHaFuV2yXBJ92pBquSE2mE6KSjcnG3wUd77Y+ii5HURLKpg8Irgvh1A5
	xv8k/RT0qc3hxq6fpRefovXMh1bo=
X-Google-Smtp-Source: AGHT+IEZWx0+Z0jJTO+gz5OiipVQ9YXePfyDG9ACRny9IM3j5uQgXS8rtp0uN3KyyJutyiHrSyBq9L0V8kAMcHvKfoc=
X-Received: by 2002:a5d:4e45:0:b0:37c:d2e3:1298 with SMTP id
 ffacd0b85a97d-37d0e8f10a0mr12197967f8f.55.1728398689667; Tue, 08 Oct 2024
 07:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008112302.2757404-1-maharmstone@fb.com> <CAL3q7H4oGiDQ4bahbJmxw9zp8CuzAF+VzJvqqdx10A8qyNk1Ag@mail.gmail.com>
 <ae203ea9-d5d4-4d25-825f-e017f23b3bf7@meta.com> <CAL3q7H4izTkoF=RspYASMcn2wQK4cYpx8ecT84wSq2b+zsuNRQ@mail.gmail.com>
 <6f9235ff-004b-4754-80bc-757ec273a013@meta.com>
In-Reply-To: <6f9235ff-004b-4754-80bc-757ec273a013@meta.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Oct 2024 15:44:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4VeiLoRa336WO6_22pTf96W=UfGWkk6o=nALbS1qFYKw@mail.gmail.com>
Message-ID: <CAL3q7H4VeiLoRa336WO6_22pTf96W=UfGWkk6o=nALbS1qFYKw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add test for missing csums in log when doing async
 on subpage vol
To: Mark Harmstone <maharmstone@meta.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:35=E2=80=AFPM Mark Harmstone <maharmstone@meta.com=
> wrote:
>
> On 8/10/24 15:18, Filipe Manana wrote:
> >>> There's also nothing in this test that is btrfs specific, it could be
> >>> made a generic test instead.
> >>
> >> Yes there is, it's running btrfs check every time.
> >
> > Right, but instead of calling it explicitly, it could pass
> > "_check_scratch_fs" as an argument instead, and the test becomes
> > generic:
> >
> > _log_writes_fast_replay_check fua "$SCRATCH_DEV" "_check_scratch_fs"
>
> Well, we could, but this is a test for a btrfs-specific race that
> existed between two known commits - this isn't a generic stress test.
> There's no reason to believe a) that other filesystems are vulnerable to
> this, or b) that their check programs would even pick it up.

Does it mean other filesystems can never have any similar bugs in the
future? Or never had similar bugs in the past but no one wrote a test
for them.

Does it mean all check programs for all filesystem don't have and will
never have such checks?

How do you know that? No one can.

We write generic test cases when we are not exercising features
specific to a filesystem.
Similarly, we write filesystem specific test cases  when we are
exercising features unique for a specific filesystem.

If you check git history and the mailing list, you'll see tons of
examples where a generic test case was written even if a bug was
detected (so far) only on a particular filesystem - i.e. what the test
does can be run on any filesystem.

>
> Mark
>

