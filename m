Return-Path: <linux-btrfs+bounces-14394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6914FACBB0A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 20:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F99E173C23
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C781CDFD4;
	Mon,  2 Jun 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOG/AozZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CFA40849
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888413; cv=none; b=HtP7FlW6kNGoZEQW6eokRm7Iveh9FIV14Rwrv3R2GDWcPbYE8VVrBnfQOl7wGvym80zkYX4xHSq6bupaveySVcVFmkXZU85Lf3mEiw5XlZM3Bc23OJjR7IxyD6RqUwn7N3dhLCCfzkzf9f4k+aVC0e8Mz6QAy4aDrNeAf/e3yds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888413; c=relaxed/simple;
	bh=VEvLoSuzEMrlofp63xht9FRFhoDE55oy1kAf2IC8pnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsWgx7623RyDZYmQXqcPkDJFiPbSoF6jZr1f4JdCor6bcX4Lzaw8ecYPGT0ZQ5/ZQNAE87Rcme0AfxgRU1wXGq0ltW1GcQwduAGoFREA94XH76l6xMNF273hRKUdIHrUpRhm3QPCJ0t7ATe0zs59DOUJ5+dBfrAqwqOOfDTrwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOG/AozZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C552CC4CEEB
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748888412;
	bh=VEvLoSuzEMrlofp63xht9FRFhoDE55oy1kAf2IC8pnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fOG/AozZeXkYbRW7GNjWMUx+QmDacesMFDSoFVNbnpVtpRQxv596Dt9xP5CpFKaum
	 LW4WpTtTyEugzsCloEL4Jr2XePHQD1BZk0plFpzdW6QKICyY0DPnp5ls1FYSQWaiFq
	 zpgilO6VyTq0mesKUP14m/2t2n8qjrz6hJu6qUABGYfDsaCNtEBYHVELTaOY68hIck
	 kFqJFd3iOrF40UVhASzuXMiaQ6wBGutb/9Co8pCE6dPt6vhvufe/MSHwPsUGFzzOzB
	 sQ83Hz9w+8jVI2e+EbmdTifwy+z7MVnehkwldddmCLsJ/Ua2RQ3kmO73nNrQB9P7Lg
	 Q2Y+REHVfpA1Q==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6046ecc3e43so7906103a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 11:20:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV60YYl8LFs2blgZf3c8qr8Flznob5ikHBAX9RObn0WyYn+KqNRlDwt34IGcMnMVNjSgpSqcTgvskv6SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsyCr1vbto7qP3a11KA0IcR/PG/JyrsUXPmTsNppGYzpPMeuqV
	J3hoU2j/9tEk5A4dq531Tbb3FBVP9z8VUaBbGN9+0II30Kcw/x8S6h0S7U3bjKoFcHYyhQfHEFk
	JXuwqNBXwFM/ULyROAsyVnOvc1Rdvw1A=
X-Google-Smtp-Source: AGHT+IF49z5sIcVK82Kdgt8zsATGQdIoc5md3oz1VMgM0xRi7SMFPfYv1By/rJ5LDEDHlVVZjtsfPjqynZM6wmVno1g=
X-Received: by 2002:a17:907:7ea4:b0:ad8:9909:20a3 with SMTP id
 a640c23a62f3a-adb3242f4f0mr1407823566b.43.1748888411362; Mon, 02 Jun 2025
 11:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602162038.3840-1-jth@kernel.org> <CAL3q7H4p4RQ46vCUJYREn3BgYa9SBY1eMeaGpyM=0Jz15WH35A@mail.gmail.com>
 <7b04d71a-fe25-4d98-bb7b-25515be65177@wdc.com>
In-Reply-To: <7b04d71a-fe25-4d98-bb7b-25515be65177@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Jun 2025 19:19:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Cp9hTpwebScKaVc73d6HQLYVesnb=xXJdMYbhE53upA@mail.gmail.com>
X-Gm-Features: AX0GCFsjPAxVCmOrzSnaekUcEF0TfpOZ6dG04njUayhaAkGW453M_oeAmz5s_mw
Message-ID: <CAL3q7H5Cp9hTpwebScKaVc73d6HQLYVesnb=xXJdMYbhE53upA@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: zoned: reserve data_reloc block group on mount
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <Naohiro.Aota@wdc.com>, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 5:46=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 02.06.25 18:37, Filipe Manana wrote:
> > Instead of duplicating the iteration code, we could use a label and a
> > boolean to track if we already allocated a chunk, something like this:
> >
> > https://pastebin.com/raw/jrFtUVFj
>
> Not quite, the 1st one iterates over data_sinfo the 2nd over space_info
> which is data_sinfo->sub_spaceinfo[0].
>
> I could've made a helper function, but that seemed a bit excessive for th=
is.

There's no need for that, the again label approach still works if we
just used a local list_head pointer variable and use it in the
list_for_each_entry() call, like this:

https://pastebin.com/raw/Aq2SVB4W

>
> Note: locally I've deleted the line breaks for the set_bit() calls as
> well. They fit in 80 chars now.

Nice.

Thanks.

>
> Thanks,
>         Johannes

