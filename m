Return-Path: <linux-btrfs+bounces-3198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836A4878941
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 21:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6401C21346
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E956B63;
	Mon, 11 Mar 2024 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVBgKaj4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A282252F82;
	Mon, 11 Mar 2024 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187629; cv=none; b=dnrVjkd+zySwYvVe7Qw9D7FZtPrF2PyrOq9+Ff0kkSDt/6pEdO4qbjjD4AujxyCRFSEDBDka0ZIbqiSfeIpIXKQI5a5r5KAT535GylV3EcJRq3OOdJbB3zvXGhh3E6OXOJkDt4svxPQbdw1bec1WG7PQ6OAlqqaxwhRVs4UsjYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187629; c=relaxed/simple;
	bh=DrWeY4URI4asygk4lhluNXO0hGNpWVzUWRGv0/b6Xp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4Pci1mGHPd6BQzq3BTNOa/mWWK+35rJd+ezpOcZUbNoQlOL+pVvDXkRvoys+kznCmyUqthNeUdL9eam76p+PejNIEzG4jueCEkppmsnX728xTv4IauGJpthuoW1+qD6L7VLW0EfnW9EZqsCodJcEPvInsIrW/6PtQfNywxoIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVBgKaj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A55EC433B2;
	Mon, 11 Mar 2024 20:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710187629;
	bh=DrWeY4URI4asygk4lhluNXO0hGNpWVzUWRGv0/b6Xp8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HVBgKaj46DDvlZF7YVALiNNlcZMWlXZCyWPePJUojTwe/IsQjYcpidHteFQXZ90GU
	 lrfrELPvZpShwB1BeWiQeX6R28l9OP7a7z029bFzBVphkSrnVOMPF4ewuPHOKKfXJN
	 C6CprsF7WC+czo7KhkYIRmnxeK5ob2m1XUlzYJZT7esJTe1E36C1O7QvGnXp8TqNqe
	 hR7MmBkoAqkgySmfRBcQ5Xpf82Z8VY3YWD5b5geTMn6z48aBfKJSj8brxsReXo7fXq
	 IegWjghbF+NWRmLaLMh1YFKwQQSwW74xIHUGHnmDC9ld1+dZMWbkGcBDf/rjyWHLUb
	 Xcc/jrRjzyGsg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a461d0c90c1so206782166b.2;
        Mon, 11 Mar 2024 13:07:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoN+lOiQPmnJarbciFFkbB3xRor937uKo6ZTghjxn5a7fusFA7RftA3Ad4UZOpQmXBYubqCoCEXZXVg3tIxsipoj9JzW4ooGeH1hUlch5Ri0eaENPeDcmVAC596TUnh1phCfY=
X-Gm-Message-State: AOJu0YxAOEUkPpJDASy/zEwMTLVQ+2FNlmDZ9Ji98tH09ZZz512EeWTO
	yVh95eXlv7B93x+p7STGtfaw5bP1/ULkuJmPdaU7EFL8J0unSDjLvqus5l9YbA1kwUJn6CxAMAQ
	l4n+ad3IHzmMexnY1/6zjDqGMAHk=
X-Google-Smtp-Source: AGHT+IG18EuAA35kdphCrB2tABhQCQA2nnSt3znj87TE2dP669Iykk9AuOQnThtnLt0Pt9+VxTpa3FQyOl2ZdHBH/4o=
X-Received: by 2002:a17:906:d14b:b0:a46:389b:2351 with SMTP id
 br11-20020a170906d14b00b00a46389b2351mr818583ejb.59.1710187627597; Mon, 11
 Mar 2024 13:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211551.833500257@linuxfoundation.org> <20240304211551.880347593@linuxfoundation.org>
 <CAKisOQGCiJUUc62ptxp08LkR88T5t1swcBPYi84y2fLP6Tag7g@mail.gmail.com>
 <da17e97b-1880-415d-8cdb-07e79808e702@leemhuis.info> <20240311184108.GS2604@twin.jikos.cz>
 <d9d46e16-ae73-4495-98a4-ab08ac501132@leemhuis.info>
In-Reply-To: <d9d46e16-ae73-4495-98a4-ab08ac501132@leemhuis.info>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 11 Mar 2024 20:06:30 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7kZkTMfzb0Xg_m1EbNyjj1eqqs4m=ovHM80MqCCCD7gw@mail.gmail.com>
Message-ID: <CAL3q7H7kZkTMfzb0Xg_m1EbNyjj1eqqs4m=ovHM80MqCCCD7gw@mail.gmail.com>
Subject: Re: [PATCH 6.7 001/162] btrfs: fix deadlock with fiemap and extent locking
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dsterba@suse.cz, Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>, 
	stable@vger.kernel.org, patches@lists.linux.dev, 
	Josef Bacik <josef@toxicpanda.com>, Sasha Levin <sashal@kernel.org>, Chris Mason <clm@fb.com>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 7:23=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 11.03.24 19:41, David Sterba wrote:
> > On Mon, Mar 11, 2024 at 10:15:31AM +0100, Linux regression tracking (Th=
orsten Leemhuis) wrote:
> >> On 06.03.24 13:39, Filipe Manana wrote:
> >>> On Mon, Mar 4, 2024 at 9:26=E2=80=AFPM Greg Kroah-Hartman
> >>> <gregkh@linuxfoundation.org> wrote:
> >>>>
> >>>> 6.7-stable review patch.  If anyone has any objections, please let m=
e know.
> >>>
> >>> It would be better to delay the backport of this patch (and the
> >>> followup fix) to any stable release, because it introduced another
> >>> regression for which there is a reviewed fix but it's not yet in
> >>> Linus' tree:
> >>>
> >>> https://lore.kernel.org/linux-btrfs/cover.1709202499.git.fdmanana@sus=
e.com/
> >>
> >> Those two missed 6.8 afaics. Will those be heading to mainline any tim=
e
> >> soon?
> >
> > Yes, in the 6.9 pull request.
>
> Great!
>
> >> And how fast afterwards will it be wise to backport them to 6.8?
> >> Will anyone ask Greg for that when the time has come?
> > The commits have stable tags and will be processed in the usual way.
>
> I'm missing something. The first change from Filipe's series linked
> above has a fixes tag, but no stable tag afaics:
> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=
=3Dfor-6.9&id=3D978b63f7464abcfd364a6c95f734282c50f3decf

It has no stable tag because when I sent the patch there was yet no
kernel release with the buggy commit, which landed in 6.8-rc6.
Now it would make sense to add the stable tag because 6.8 was released
yesterday and it's the first release with the buggy commit.

>
> So there is no guarantee that Greg will pick it up; and I assume if he
> does he only will do so after -rc1 (or later, if the CVE stuff continues
> to keep him busy).

Don't worry, we are paying attention to that and we'll remind Greg if neces=
sary.

> As Filipe wrote "can actually have serious
> consequences" this got me slightly worried. That's why I'm a PITA here,
> sorry -- but as I said, maybe I'm missing something.
>
> The second of the patches has none of those tags, but well, from the
> patch descriptions it seems that is just a optimization, so that is
> likely not something to worry about:
> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=
=3Dfor-6.9&id=3D1cab1375ba6d5337a25acb346996106c12bb2dd0

Yes, it's an optimization. If it were a bug fix, I would have added a
Fixes tag and would have described what the bug was.

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>

