Return-Path: <linux-btrfs+bounces-3249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E67F87A8B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 14:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E77286F8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D042E4436C;
	Wed, 13 Mar 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gysu9iY5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ECB46535;
	Wed, 13 Mar 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337707; cv=none; b=F00m24NjhJhdYfEuH3DHLqdgNyF87cIXzGql9ks3RW76tTJ38LSQm+3hv+8cXGHWg8UaT2k49vyuvCz0XvZXbW0j6TAou84H2XjdMNOaVBNpRQmkZZ3yHIdkUncj2lJuDF4Ta19z9g9k8sigYhKXkoR9W+i+ynTrkBzWnkwNPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337707; c=relaxed/simple;
	bh=1vk1dW5yulwl98bZqyU0j1DXY9vZePqONTWNRuWKVdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV7G/JKGr2Yb0qqvTEHhofzhzQfQRkbpVx1RKrYtcAM2P66oYexP+nmLCXrYxALaeAOJ0CIy7Js/7qSNW+KzTADzP8tgzonMtwgp4e6R5yVqalrI0rWL1stz42yP2QU9iQ5eiZZha3zptx31Xzmf7wHtONyuHF5TwUvbZAFEOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gysu9iY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA89C433C7;
	Wed, 13 Mar 2024 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710337706;
	bh=1vk1dW5yulwl98bZqyU0j1DXY9vZePqONTWNRuWKVdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gysu9iY5eVpRhX+phTpgU7qWi+1P/J7ppsO2XIJV2IF3chQKSZl5ivxrwyX5DJNSl
	 NtWBtv2cdlajq4nh9JXqMqxgOzGK1au+i+HYkH0vFf03azCLLRtzSg4vYEDMTpqkOK
	 86pxiLz1VTyt7oROFfDPB2BEtREw5zbQaKS3vclmPn5CRL9O2apuMSyKq01YfHbJpg
	 2+r/IiKrX9zxIm8zYpr/9tCxYL6praPAwBnZMbepCdLK8Fakn1nI7HSdkOZlv/jB8v
	 JusNJOWSGss+0rKb/niI+7tm7jf4CkW/ryvjIsN8Q0zgzvQhZHjU71cwR5zxZfbylK
	 xLJO4Xts3rhqQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512e4f4e463so1201171e87.1;
        Wed, 13 Mar 2024 06:48:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvvtCVz71dsVQY43/C47Qt65gI2onZjLdbpO0/muyyyNNu0rRvMrRVAVKMKFqL52ec3yOTMaCKlqZyW0JdGtHmbsyag1/pps/O8ZXusgTu2dTW+Dx2+sFIehKV6YoiZmJFCYI=
X-Gm-Message-State: AOJu0Yyp/pE9S0H+SKc5vBGdLZlc6eeWGQkQcn3dlMMRGCsibwhabx1O
	ox0FvsujEzq1yqe4aHcIdCcGVYzad6Gz2YCwIcbC2DlPKMV/kt8LzRTxGMrkZyLxqSYSSDHdQKW
	hdXtazHH5Wh70ZTdk1fgzyRMsrIY=
X-Google-Smtp-Source: AGHT+IEVlJlsAN6K07N+wQAFEo4ls5fHweELumESuiLz248WzwUqQxvzIc75kcPW8hPB8rs4CfPlqS16WCiaYe9WXAc=
X-Received: by 2002:ac2:4c42:0:b0:513:3dc5:cd5f with SMTP id
 o2-20020ac24c42000000b005133dc5cd5fmr6564753lfk.40.1710337704736; Wed, 13 Mar
 2024 06:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211551.833500257@linuxfoundation.org> <20240304211551.880347593@linuxfoundation.org>
 <CAKisOQGCiJUUc62ptxp08LkR88T5t1swcBPYi84y2fLP6Tag7g@mail.gmail.com>
 <da17e97b-1880-415d-8cdb-07e79808e702@leemhuis.info> <20240311184108.GS2604@twin.jikos.cz>
 <d9d46e16-ae73-4495-98a4-ab08ac501132@leemhuis.info> <CAL3q7H7kZkTMfzb0Xg_m1EbNyjj1eqqs4m=ovHM80MqCCCD7gw@mail.gmail.com>
 <5f7b720c-3516-42b2-826c-68fb5ba18353@leemhuis.info>
In-Reply-To: <5f7b720c-3516-42b2-826c-68fb5ba18353@leemhuis.info>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 13 Mar 2024 13:47:47 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6jVfg2GkhEsJk64+TdRq5CdapfSfSgXvqoCa4U6zXbKg@mail.gmail.com>
Message-ID: <CAL3q7H6jVfg2GkhEsJk64+TdRq5CdapfSfSgXvqoCa4U6zXbKg@mail.gmail.com>
Subject: Re: [PATCH 6.7 001/162] btrfs: fix deadlock with fiemap and extent locking
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dsterba@suse.cz, Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>, 
	stable@vger.kernel.org, patches@lists.linux.dev, 
	Josef Bacik <josef@toxicpanda.com>, Sasha Levin <sashal@kernel.org>, Chris Mason <clm@fb.com>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 1:42=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 11.03.24 21:06, Filipe Manana wrote:
> > On Mon, Mar 11, 2024 at 7:23=E2=80=AFPM Linux regression tracking (Thor=
sten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> On 11.03.24 19:41, David Sterba wrote:
> >>> On Mon, Mar 11, 2024 at 10:15:31AM +0100, Linux regression tracking (=
Thorsten Leemhuis) wrote:
> >>>> On 06.03.24 13:39, Filipe Manana wrote:
> >>>>> On Mon, Mar 4, 2024 at 9:26=E2=80=AFPM Greg Kroah-Hartman
> >>>>> <gregkh@linuxfoundation.org> wrote:
> >>>>>>
> >>>>>> 6.7-stable review patch.  If anyone has any objections, please let=
 me know.
> >>>>> It would be better to delay the backport of this patch (and the
> >>>>> followup fix) to any stable release, because it introduced another
> >>>>> regression for which there is a reviewed fix but it's not yet in
> >>>>> Linus' tree:
> >>>>> https://lore.kernel.org/linux-btrfs/cover.1709202499.git.fdmanana@s=
use.com/
> >>>> Those two missed 6.8 afaics. Will those be heading to mainline any t=
ime
> >>>> soon?
> >>> Yes, in the 6.9 pull request.
> >> Great!
> >>
> >>>> And how fast afterwards will it be wise to backport them to 6.8?
> >>>> Will anyone ask Greg for that when the time has come?
> >>> The commits have stable tags and will be processed in the usual way.
> >
> >> I'm missing something. The first change from Filipe's series linked
> >> above has a fixes tag, but no stable tag afaics:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit=
/?h=3Dfor-6.9&id=3D978b63f7464abcfd364a6c95f734282c50f3decf
> >
> > It has no stable tag because when I sent the patch there was yet no
> > kernel release with the buggy commit
>
> Obviously, no need to explain, the discussion got unintentionally
> sideways after David mistakenly said "The commits have stable tags
> [...]". Happens, no worries.
>
> >> So there is no guarantee that Greg will pick it up; and I assume if he
> >> does he only will do so after -rc1 (or later, if the CVE stuff continu=
es
> >> to keep him busy).
> >
> > Don't worry, we are paying attention to that and we'll remind Greg if n=
ecessary.
>
> Thx. But well, for the record: I would really have liked if you or David
> would simply have just answered my earlier "And how fast afterwards will
> it be wise to backport them to 6.8?" question instead of avoiding it.

If I avoided that question it's because I can't give an answer to it.

David is the maintainer who picks patches for Linus and does the pull reque=
sts.
So the "how fast" depends on him and then how fast Linus merges and
then how fast Greg and the stable people pick it.

> Just knowing a rough estimate would have helped. And I guess Greg might
> have liked to know the answer, too. But whatever.
>
> Side note: I'm here to "worry". It's not that I don't trust you or would
> ask Greg behind your back to pick the patches up. It's just that we are
> all humans[1]. And regression tracking is here to help with the flaws
> humans have: they miss things, they suddenly need to go to hospitals for
> a while, they become preoccupied with solving the next complicated and
> big bug of the month, or just forget something they wanted to do because
> something unexpected happens, like aliens landing in a unidentified
> flying object. And from all the regressions I see that are not handled
> well and the feedback I got it seems doing this work seems to be worth it=
.
>
> Ciao, Thorsten
>
> [1] at least I think so...
> https://en.wikipedia.org/wiki/On_the_Internet,_nobody_knows_you%27re_a_do=
g
> :-D
>

