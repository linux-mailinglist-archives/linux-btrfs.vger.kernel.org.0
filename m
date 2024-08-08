Return-Path: <linux-btrfs+bounces-7045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD63194BA2A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 11:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACF61C2040E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17A189BA3;
	Thu,  8 Aug 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7GXQ7NE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB778274;
	Thu,  8 Aug 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110962; cv=none; b=JLPoJM5FqMpqP63ke8omiUIYIFjVYyDBLjmQae0BC38m1YxI+KbFjgAuwKaRTRjelyCBoQMzma6niL8f4obWBJ+5qs8ieBpZHBNBIJwdw0oNbJTEVN1pZ0xu//g9AEnGRzhlSUCkN7yUptnUPaXYhKMM7pTuKEw0Q3mpBENURUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110962; c=relaxed/simple;
	bh=E7DJ9k78FBrNHKcRO9Tl8MONF7YiMg7kqswA/XFPfRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTmeIGeaBEialjgOOOVhhh8vWhDnfrpq+5kHG8E3Tb3hiIlv/J1QABO6jvh5DfWOVq6izNZxBCqd2zN9235Ul3gd+12s5sGdhXZpnw2aduSbRLSQqXNRei+xyDKtNZ0Pia/9vWU4G7vQm/x8jU8KLhLld52VmE4ECW6twqXfzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7GXQ7NE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6ABDC32782;
	Thu,  8 Aug 2024 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723110960;
	bh=E7DJ9k78FBrNHKcRO9Tl8MONF7YiMg7kqswA/XFPfRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p7GXQ7NEFOtPdVaW/5WxZxOoNjnIy/G+FRf0X99lveWyE6Vr3C1r3ab/IWwsdlUxA
	 Gqi1ELpL1P3ZWHctEWJ1xmXFDKPYDp/V6W4at9XD7BnEQ5GpUVQFvrUNOmnCXQMJV6
	 T9MxamSC6jqJAKxeZsjuKChQMD5qb0sB/zc/RayHNsmgwrn+qN79Wiby9lB20bFH6u
	 giAH2EpO+KEygsfI554n8uPtT/v21879TMwqnjIUB2pV5K8CCMFdPNtezpOfszp6Ss
	 BkgbORd/WR53alUIXCJ/wnwuAkm3ohqqEgUKjgTvRvnkojHrSrbS6RF0kJ8ZvIOlhc
	 Iwx4149kZIjkw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7d26c2297eso89259066b.2;
        Thu, 08 Aug 2024 02:56:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2yiK9vh+QnjFJLhhgJlKpOzEsRElV/1ZXA4oEgvkZtSjjss2ur8JhwOS9ZvO2kuvFv3AHyZ/Q73AXdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdaIXwilzwTtr3aIxuTugQi+zR006cvi90OAH95t0lo7UHVlhr
	qjW0fHqbDan8kS7V4b0hc677nIIBzl5rAnw6MTre8GvKeUtT1yZ6Av8KUu8wVoQeMgcKcUAH4FQ
	FKfEQV5DI99eV47SkgK4lJZ0BCMs=
X-Google-Smtp-Source: AGHT+IHY9g2W5TpN4HoCll0fuIKgpSKdGV1pU2q+tKF69eHsPJQeIk7zADy9mD41otFKK2V1C8uKBnYT1V4A+qi4dWk=
X-Received: by 2002:a17:907:1b1a:b0:a7a:97ca:3056 with SMTP id
 a640c23a62f3a-a8090c7fe9dmr109991266b.16.1723110959441; Thu, 08 Aug 2024
 02:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723044389.git.fdmanana@suse.com> <d17ff87e1c8302c6ef287e81888c1334f014039e.1723044389.git.fdmanana@suse.com>
 <20240808075340.FEF5.409509F4@e16-tech.com>
In-Reply-To: <20240808075340.FEF5.409509F4@e16-tech.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 8 Aug 2024 10:55:22 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4TwKUyhTdigA7x90KCW=oO_cpRn4bWxGaTMBJ_ZTXJEg@mail.gmail.com>
Message-ID: <CAL3q7H4TwKUyhTdigA7x90KCW=oO_cpRn4bWxGaTMBJ_ZTXJEg@mail.gmail.com>
Subject: Re: [PATCH for 6.6 stable] btrfs: fix corruption after buffer fault
 in during direct IO append write
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: stable@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	gregkh@linuxfoundation.org, Filipe Manana <fdmanana@suse.com>, 
	Hanna Czenczek <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:55=E2=80=AFAM Wang Yugui <wangyugui@e16-tech.com> =
wrote:
>
> Hi,
>
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > commit 939b656bc8ab203fdbde26ccac22bcb7f0985be5 upstream.
> >
> > During an append (O_APPEND write flag) direct IO write if the input buf=
fer
> > was not previously faulted in, we can corrupt the file in a way that th=
e
> > final size is unexpected and it includes an unexpected hole.
>
> Could we apply the patch
>         70f1e5b6db56ae99ede369d25d5996fa50d7bb74
>         btrfs: rename err to ret in btrfs_direct_write()
> to 6.6 stable, and then rebase this patch?

Why?

Generally we don't backport cleanups and refactorings, only bug fixes.
Adding that patch wouldn't make the backport easier, that is, we still
couldn't pick the commit from Linus' master branch without any
changes,
because at least the commit would fail to apply due to the move of the
direct IO code into a new file, and possibly other changes too.

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2024/08/08
>
>

