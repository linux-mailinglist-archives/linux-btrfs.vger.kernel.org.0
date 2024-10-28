Return-Path: <linux-btrfs+bounces-9192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BFE9B2EC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 12:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A11F220FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A81DE88B;
	Mon, 28 Oct 2024 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaAyAqoT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8A42A82
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2024 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114304; cv=none; b=cEvl91kzUGR+3XOg2YL0EBYIoNAqqkoi2V9B9UGTngXAHN+uM4Awm16qBTxkcUMYGMVdIZmPmq/kKSMhcLRbFrpqtSctHRechCOAAVIT+4Auk8pVS9cH6KCG+sTn3FF2XM73wl5UCu9u/JffTPxznDILASc0kzQYkIzjpRp5XB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114304; c=relaxed/simple;
	bh=5dJIV79MbJ8y+zpp9tMZGTUzFQoGBElkiU5NEPwsG2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTRd8j/K0rDESAG0qXX0/UMv/qQoukAQ1UdIvewKF0n61heVdpAdqM4Qpl7yDLswsdM1nCWsT0Xt+9Zqc4F4cyEQtUmGKDrrg+gPraQoctC/JGOn/0/mGlYYkqOjocbVQVzYXdgFNUnx9k+Zh9Y2Z/rwdgsP36GlKKgrST/pBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaAyAqoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B49C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2024 11:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730114304;
	bh=5dJIV79MbJ8y+zpp9tMZGTUzFQoGBElkiU5NEPwsG2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uaAyAqoTl/kFHUffqjTcKfpvhpJACm2g5pxzSGvuZGiI8ETUC5Ex0nA5X1hBQBK9C
	 cl+lmH3Bi1zsHbpjkXZignZCE0wSKuaKX1VTEfaKENTE2uIMtU1aQL28JRfuN1jT0Z
	 oLApus6YABtKWfn8SfWCJm+OoQwCNNzgTK4SomMFRk7jQF6ZjxomKQ1k3Cx5FRUArq
	 LjcOn+fUSx1Ogl86Lp4jDlpBOLt5d1k3joqOyLNE0MTNoqgl6LnmhJcVbsun3Zzxts
	 NEd0i+I2CMozAp3I8tWM8MT9wGD1sqQ050k14hHWX2QN5T5BXi/qh/yK/70yvtwHf4
	 UJ1N2ZMhs5jGQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so5928517a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2024 04:18:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzCwBRst4u8/NdAHQLp9JaO1KdowNV3H0B6d/2Yd8DEJwTjrqIN7B1GK+5AlSgG3g8vEQqh4UNP8xpDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12M6V3EJCMYw6bzQ+uliz9wKdARpjeRDxZDJGhv293nTVkUOw
	3m/A66nCR0KMQ4QMgYz7TwVzcv2IeL4Zz+b3ZolEDAVakLf1SGUANPrFJbLQbhKjJ74KFtWvsk4
	wIvIRFMvXEwK9PqGarHCbzdBlGxg=
X-Google-Smtp-Source: AGHT+IG/8BhRcX/dmSin/hPXB639wldjmSotftcFY/wNOfz7P1hgBmCCDHiPkoQYFD3xeXmlv4YI4m5LvV9RF/ftnTM=
X-Received: by 2002:a17:907:1c9d:b0:a9a:5b8d:68ad with SMTP id
 a640c23a62f3a-a9de615abc0mr813332766b.48.1730114302662; Mon, 28 Oct 2024
 04:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729784712.git.fdmanana@suse.com> <49b1a5df-eefc-437a-b175-2e9532932dfe@wdc.com>
 <CAL3q7H61-kM26sNZC6rLzbv2D3ku7NQ_B+PT9-eQYLMGxuySxQ@mail.gmail.com> <32b261ae-9b75-4da4-a883-5387ffe5bd08@gmx.com>
In-Reply-To: <32b261ae-9b75-4da4-a883-5387ffe5bd08@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 28 Oct 2024 11:17:45 +0000
X-Gmail-Original-Message-ID: <CAL3q7H52yj5+6_h0ixgLwAQRPypW25g5j0eg48afm-62HLV2Jg@mail.gmail.com>
Message-ID: <CAL3q7H52yj5+6_h0ixgLwAQRPypW25g5j0eg48afm-62HLV2Jg@mail.gmail.com>
Subject: Re: [PATCH 00/18] btrfs: convert delayed head refs to xarray and cleanups
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:18=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/10/26 00:05, Filipe Manana =E5=86=99=E9=81=93:
> > On Fri, Oct 25, 2024 at 2:19=E2=80=AFPM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 24.10.24 18:24, fdmanana@kernel.org wrote:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> This converts the rb-tree that tracks delayed ref heads into an xarra=
y,
> >>> reducing memory used by delayed ref heads and making it more efficien=
t
> >>> to add/remove/find delayed ref heads. The rest are mostly cleanups an=
d
> >>> refactorings, removing some dead code, deduplicating code, move code
> >>> around, etc. More details in the changelogs.
> >>
> >> Stupid question (and by that I literally mean, it's a stupid question,=
 I
> >> have no idea): looking at other places where we're heavily relying on
> >> rb-trees is ordered-extents. Would it make sense to move them over to
> >> xarrays as well?
> >
> > For ordered extents I wouldn't consider it, because I don't think it's
> > common to have thousands of them per inode.
> > Same for delayed refs inside a delayed ref head for example.
> > For delayed ref heads, for every cow operation we get one to delete
> > the old extent and another one for the new extent, so these can easily
> > be thousands even for small filesystems with moderate and even low
> > workloads.
> >
> > It may still be worth just to reduce structure sizes and memory usage,
> > though it would have to be analyzed on a case by case basis.
> >
>
> Another question related to this is, if we switch ordered extent or
> extent map to XArray, how do we find such structure that covers a bytenr?

You don't, not without doing something like xa_for_each() and iterate
the xarray until either:

1) we find a matching entry (within the ragne of an element in the xarray);
2) we find the first entry that starts beyond the offset/range we are
looking for and stop, meaning there's no entry covering the range we
want;
3) we reach the end of the array.

The rbtree based search is more practical for that.

>
> For delayed ref and extent buffer (which uses radix tree) we are working
> with the exact bytenr, but for OE/EM we do a lot of search using a bytenr=
.
>
> Or do I miss some XArray feature that can do that?

There isn't any. There are ranges for xarray but they basically mean
having a range of indexes point to the same value, which doesn't help
in these cases.

For extent maps and states for example, beside the range search,
there's also the detail of merging adjacent entries, which is not
doable in a practical and efficient way with xarrays, especially to
find the previous entry.

>
> Thanks,
> Qu

