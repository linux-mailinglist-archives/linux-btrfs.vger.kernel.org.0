Return-Path: <linux-btrfs+bounces-15095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62271AEDC3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 14:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5343B5E54
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 12:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5B1289808;
	Mon, 30 Jun 2025 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+3cmejP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E01257435
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285173; cv=none; b=McvDXSuGlpXQJCiJV4N1WHGpitabENKwAlAyOhVQWAZjwbpjAtz4wv7QVoAMS3KNw0ZDhQ9BJP5ZckpCL6ySWe95KEsN0CSs0OaTydIBAF2Vh5bvUP2ebF2oodOVTkYcxIfthT9vDuY197M/s7Jjq7bVkC/+Pzx1QZo8uwUIWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285173; c=relaxed/simple;
	bh=YnNoiKFzXsAK+aNUJCj8tkr4gMlaAsGu8wtnpocYjdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUZfJ67rN1pRgp1Z40DOfxTEcvq9mD59rwoRNYmOkfCTCcXFWP325zxScKiZG+6V42ndMkz2urYOtisypynzfh4qtO6m6pkcgu2LXIPscqXqJi2oQiEc7X1adOgCXCwveNE20AR9bNWQZbZjfKEVTEEjq0CMz79bfj5/qfED0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+3cmejP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0894C4AF09
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751285173;
	bh=YnNoiKFzXsAK+aNUJCj8tkr4gMlaAsGu8wtnpocYjdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P+3cmejP8PqwAuf0aMfZnc0KY+KR2MfeoHYuNK6BJIfLp7h/izcLJhZHjDaBka2PK
	 g3x8pqpnuSXsruaARUO5CPzkQ5GfSUU14i1Mfy7cTOmKrNJD6cYcpmze+L22R9H9rJ
	 nzwEclz9Vf63sFviNTrO8mGRMX7uc7OP01eP5qwIPokD1UoyU2lEoD3Jc0sQVN6R0J
	 j6aAinwe3+ersAy97jDwmHBPQ/L4031D+LWa4CEv7fCHFZVwNhNnKan603IGkUSBCU
	 aAr22mWwlf743ue4WUC9o64L09obuv6jfdGdykG6gjYy8NI/KwsX1PiHLvITywHJG6
	 1/wrxchSnxxIQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae36e88a5daso392820866b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:06:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNU+Cud383OqJzotPKEA8BNbpLmTJGhvrYHe/g3cHfUjtq5e64iTITkBhSVUc3mbA8YtRvWvpcT1OZUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0uc/BKfyZR0AAPAFlCJG5IOTLURv3uVFvBiJKct7A4zXWRTZ
	caXBgMrggyN2FwQppO/7tQYVimyLfu23348jxZFLHCEiXhOVSO9IJkpbK61SPTiufbdUCu7J7p4
	gUSOYJOg/vWLr8MoQ8d9VvH5HR8eQ0Sk=
X-Google-Smtp-Source: AGHT+IFq4XOwfSJBCoAxwykVmIdZVHKz5vRqvSQ+syOiG1isS487cLEPLHpJUEYkzULIYumbakDS1iu5hOhrm2i0H2Q=
X-Received: by 2002:a17:907:3d8b:b0:ae3:60e5:ece3 with SMTP id
 a640c23a62f3a-ae360e5eebemr1098270966b.6.1751285171450; Mon, 30 Jun 2025
 05:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627091914.100715-1-jth@kernel.org> <20250627091914.100715-10-jth@kernel.org>
 <aF6CzXUlUNE5ruWH@infradead.org> <79d8cfd1-ec0d-4eec-a3e2-7875b94d0e53@wdc.com>
In-Reply-To: <79d8cfd1-ec0d-4eec-a3e2-7875b94d0e53@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 30 Jun 2025 13:05:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6GU2E40oaj+=UsC53o0a0vF+iy6EoWtcJYLKEahCK8ig@mail.gmail.com>
X-Gm-Features: Ac12FXyT0vp0kzUYwm2h24xzKUo5MK9CNDziMbBcCA_M1hWx--8-uUcGr3nZ9zM
Message-ID: <CAL3q7H6GU2E40oaj+=UsC53o0a0vF+iy6EoWtcJYLKEahCK8ig@mail.gmail.com>
Subject: Re: [PATCH RFC 9/9] btrfs: remove unused bgs on allocation failure
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>, Johannes Thumshirn <jth@kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <Naohiro.Aota@wdc.com>, David Sterba <dsterba@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 12:46=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 27.06.25 13:39, Christoph Hellwig wrote:
> > On Fri, Jun 27, 2025 at 11:19:14AM +0200, Johannes Thumshirn wrote:
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> In case find_free_extent() return ENOSPC, check if there are block-gro=
ups
> >> in the filsystem which have been marked as 'unused' and if so, reclaim=
 the
> >> space occupied by these block-groups.
> >>
> >> Restart the search for free space to place the extent afterwards.
> >>
> >> In case the allocation is targeted for the data relocation root, skip =
this
> >> step, as it can cause deadlocks between block group deletion and reloc=
ation.
> >
> > Assuming an unused BG is one without space in it that just needs a zone
> > reset or discard (a quick look at the code seems to confirm that, but
> > with some extra caveats):  why don't you reclaim it ASAP once it become=
s
> > unused, at least modulo those space reservation caveats (which I don't
> > understand from that quick look).
> >
> >
>
> I've looked into it looks promising. Threw it into fstests and (up to
> now) nothing broke. So I'll run Damien's scripts on a ZNS drive and
> we'll see if it helps.

That brings a new problem.

For example a data block group becomes empty and you delete it immediately.
If a data allocation happens before the transaction used to delete the
block group is committed and there are no other data block groups with
enough space and there's no more unallocated device space, we will
-ENOSPC, whereas before we wouldn't.

Remember that a delete block group's space can only be allocated again
after the transaction used to delete it is committed, to respect COW
semantics.
That's why you see the allocator using the commit root (at
find_free_dev_extent()).
And you can't commit the transaction as soon as the bg becomes used,
as we're holding a transaction handle open and would deadlock.

