Return-Path: <linux-btrfs+bounces-16930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D48EB848BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 14:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159BF7C0D0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA5F2C17A3;
	Thu, 18 Sep 2025 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DatTUPYU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C126E6F4
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197910; cv=none; b=KcA+1qX3maMRyWWFWjHAOOt/fSQtF2FAMA9DSNrrQ+tbDJx+0Ikkpj50nsLzO4QsBwj8fN747gMBeoKCJsw5ifIc75MDiRAkM/Ju2ht9qN3Nb/nXZeKm/ztO1SKy/sCqmS1vVg8HhsYPcpuVX2FZf/RQGfrbnsKOGqPaPPKErT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197910; c=relaxed/simple;
	bh=jigK9oYsVjh3RpJAoTsAeFebb0m7mvuR06/vNKpx0jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG7KcZFBbTcBVDm55ZyZv0Fy91FYwv3NoEVjMIAYjgzroqOtKZViP+dwj9Vx6xIt5g7NKE/ET9yZ3rTU/L8RF7CnSDvJ7DgnucfHvRnM2SB2JvLUQ+aAZuPRN+9XDZZmhX+7kmq22IXFC79MVsd/yvFUgKXlCl+QUPHS+fG3xyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DatTUPYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42AFC4CEFA
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758197909;
	bh=jigK9oYsVjh3RpJAoTsAeFebb0m7mvuR06/vNKpx0jI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DatTUPYUn7QrSMhLUGfvF5UN8Kp3aC10kWm9VudxAe0jdonKAJ8u6TmqTROUonqG9
	 U92/5fVWZFX7Th6+srpo7KB0YoMs/WkuMB53q5kvMB3kJeFyOTAIo9KZvLxG1i46+H
	 h23ao1BgCNMhf1ajun+q50rzZp9etFJsGWFLV+b233oVE/Gd1PQ1LN23rd4pPgBpNA
	 CH+yPVYbyIIgDt+SQ7BbGtPbYH7XR7RwMsWKRYRt/PAulwRNKrllbg6hsmyuhg70mc
	 42FuXiCI6KbXW7M0WqKTM3B23djRz8/HnEYrt3AyNDtLtEudh62Loj0eNowMnHvgwh
	 qs+1vQjKGhYYA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b07883a5feeso168209566b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 05:18:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2FL5poXzBODdhheJOYjcu6fJ/oNqKhrVEIAKPcr9nkmejU6Av8ayf79C/u8gpD5qjSkc85CIqFKz+BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycmxNizZJo0fwChVgvMBjLJoJ0AykxAFGSwVP/Ox1af1OJqvCI
	oVAvuPxUVuIN2C/LrCEhNdIOBZLk/cli9xqTBCemIvAUHiSCEldTox/HDOW9uu/x6/wSh5fvu7v
	WYRu8hahNK9lcut/7TdUrr4ZtYokKBSc=
X-Google-Smtp-Source: AGHT+IFHVlr04TZCxmA6mwLe9jPAjcgBvnLkNiKigfk64awC0qq+7DcEeOzJwm0U4zgZur11b7MHLvUWVMRP5hyV4ws=
X-Received: by 2002:a17:907:dac:b0:b04:4975:e648 with SMTP id
 a640c23a62f3a-b1bbd49ae49mr666225466b.35.1758197908193; Thu, 18 Sep 2025
 05:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910175007.23176-1-dsterba@suse.com> <CAL3q7H4vXmz4pGXayq98XZqPbFh6H6Z4=eaM-gFX7fsRLnFfEQ@mail.gmail.com>
 <20250918003344.GH5333@suse.cz> <26c2e470-6277-4957-8b8b-b12a2e567daa@harmstone.com>
In-Reply-To: <26c2e470-6277-4957-8b8b-b12a2e567daa@harmstone.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 18 Sep 2025 13:17:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4WX5XddPyQ2+0a8yQaCW757+V8VVVO6byscY9ch+LzQw@mail.gmail.com>
X-Gm-Features: AS18NWAQmLfeS4gq6_57fGhU-KDt-refPieOg2st_II_vLSFU5B0v-esGWGJTgw
Message-ID: <CAL3q7H4WX5XddPyQ2+0a8yQaCW757+V8VVVO6byscY9ch+LzQw@mail.gmail.com>
Subject: Re: Btrfs progs release 6.16.1
To: Mark Harmstone <mark@harmstone.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:10=E2=80=AFAM Mark Harmstone <mark@harmstone.com>=
 wrote:
>
> On 18/09/2025 1.33 am, David Sterba wrote:
> > On Wed, Sep 17, 2025 at 04:41:43PM +0100, Filipe Manana wrote:
> >> With this btrfs-progs release, running 'btrfs check' fails on a
> >> filesystem created by an older mkfs.btrfs.
> >
> >> A bisection points to:
> >>
> >> commit e2cf6a03796b73d446b086022c0dfcf6a6552928
> >> Author: Mark Harmstone <maharmstone@fb.com>
> >> Date:   Fri Jul 18 15:26:27 2025 +0100
> >>
> >>      btrfs-progs: use btrfs_lookup_block_group() in check_free_space_t=
ree()
> >
> > Thanks for the report, I'll do a release with this patch reverted unles=
s
> > there's an updated fix.
>
> The patch is correct: older versions of mkfs were creating spurious
> free-space entries. btrfs-check was supposed to diagnose this but there
> was a bug that meant it only triggered for entries at the end of the tree=
.

Sure, but now we have btrfs check failing for every fs created up to
btrfs-progs v16.0 since we have the free space tree feature.
That makes scripts fail since btrfs check returns a non-zero status
now for such fs.
Do we have any code to remove those unnecessary and harmless free space ent=
ries?

This will confuse and potentially scare some users, besides breaking
scripts that verify the result from btrfs check exit status.

