Return-Path: <linux-btrfs+bounces-8079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1149197AE7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 12:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274241C216DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA81165F19;
	Tue, 17 Sep 2024 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8SD4KPG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C516190B;
	Tue, 17 Sep 2024 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567681; cv=none; b=P2TEIE9GrAtHJ99phK1RmgyPrvhycYIINLk1hfg4vF+f5vVvJ2uVKqi1XGzDnBTQ+y3V9u/7lv8ElqURiDTHrRQCnExcNhF2E9di+gwYjux/dpJx48IeJR702HEvcJZ2QrnpfM78G/poyiVOMYX/w2Jb0jg6V/VYL92oyNOuSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567681; c=relaxed/simple;
	bh=o5ol+cE6vz/oNmxm8DgNvdozLRil5ax36g+ymqC2xxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjMii9NjolBd0Z1VVAPC+ed2vQKUAg3u6dqG2jKuLcFg8en80NH4Zb/I0NlQvz9k424Mc6pdI8xsPCZjR64sJmJ51w+n5moSXaxTkOFGug5lKfdDoOam+EVHte6kDxQp/f7vmPjlihgGCuFjLy9uAi2oL/Qkc69aX9k9IC8RPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8SD4KPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E05C4CECE;
	Tue, 17 Sep 2024 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726567681;
	bh=o5ol+cE6vz/oNmxm8DgNvdozLRil5ax36g+ymqC2xxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i8SD4KPGkFA1rAAS9hCegbbHVLIWH73atTCTVjmRjYYKgr3Uf+o3GS5a2oyktSQfl
	 q9CCiY+KbZTcYevoJMvdtDWuJVJpama6+kMWRxbwMms+MFXqaTWuImHxAQMxdq12Uq
	 dl6GtNS73Te2cvEFKwYIDj5hNa+WVgywkr7Q1u6rN8bVGs1PSgem0otkh/Mmu8yndl
	 WyKDt5X4LSv+r/tWjojXPf8EooUbXbIihMwUPJRY+7gP/BH0LCG0ZxOJ0BGlZuY8zc
	 69ef+Q5nW4NgIAFzohZcozmEXsJ7ejAVOuQczfZmnZFmjQo79QyjE5LDI7DbTfIogZ
	 8KhWYJ6d6uQkQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d64b27c45so684361266b.3;
        Tue, 17 Sep 2024 03:08:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGWpksa6C7GKrQ+CDl1aV37u5VGidlRNRWdV90SSs2yYBZ8Q56gwUaV06/4zaA9IPtgi+zA32+hIzAKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/YLPAkp0XOfFE3ikoXR5aSJF1D73P8Hqownr349jQY2EkWqu
	951z6d/6OwhO6mTsxp2aOPclQgkcLXOm4vt2rHL/3KSRVS2DHAkAYNS4bt+mKoEuY/U1siswOAv
	xEvDDNfk7qYhydQ0O7hPGGSobZ3Y=
X-Google-Smtp-Source: AGHT+IF/SbZJQAVvoLjt+CKNjGAT6zQbqHSHSjb6rphF1ex3gyYY1smvi1f7QEavfSwGOPGIUXBeKsQilHCZwvF46Hw=
X-Received: by 2002:a17:907:971b:b0:a89:ffd0:352f with SMTP id
 a640c23a62f3a-a90481045d7mr1575193666b.48.1726567679687; Tue, 17 Sep 2024
 03:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d6ec0b588b578b9f9aabef91b8ecdf9950b682a.1726488132.git.fdmanana@suse.com>
 <ZukRreQ--325baAG@infradead.org>
In-Reply-To: <ZukRreQ--325baAG@infradead.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Sep 2024 11:07:22 +0100
X-Gmail-Original-Message-ID: <CAL3q7H426o19pjDEp_Jo1=GBpEEperV3m9-QbQHv-8TZSKjL-Q@mail.gmail.com>
Message-ID: <CAL3q7H426o19pjDEp_Jo1=GBpEEperV3m9-QbQHv-8TZSKjL-Q@mail.gmail.com>
Subject: Re: [PATCH] fstests: fix min_dio_alignment logic for getting device
 block size
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 6:20=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 16, 2024 at 01:03:12PM +0100, fdmanana@kernel.org wrote:
> > Fix this by checking that the ioctl succeeded.
>
> The fixes look good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> What file do you manage to open but fail BLKSSZGET on here?  This smells
> like we have an issue in high level logic.

I haven't hit any case where the ioctl failed. I was just saying that
in case it fails, we may return an uninitialized/undefined value.


>
> And btrfs really should implement STATX_DIOALIGN with it's multi-device
> setup that doesn't make the fallback very useful.
>
> >

