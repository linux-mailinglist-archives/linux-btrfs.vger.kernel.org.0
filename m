Return-Path: <linux-btrfs+bounces-1185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17E3821AC9
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 12:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A6B1F22758
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 11:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59CDF6A;
	Tue,  2 Jan 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzkQOQb6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E23DDBA;
	Tue,  2 Jan 2024 11:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEC8C433C8;
	Tue,  2 Jan 2024 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704194316;
	bh=rNOu+c5czE0KtPo8iz1r2bSTsy9aL/mniTA7AN4otns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OzkQOQb6SxgdQgWeEawgbGfZN7qdQjy8kPjoCHr9i6QafsD7olcrIv+U2d2R2XU9q
	 K1IulnIB3wkJRQkafyyFWGSkubuFdBccElhPZDcwG+AP9DWQXSBHX78LnhqDDpnFGu
	 gqbIB13kGJQGr3bahtLQQEgAfBeQfjY2/iE+GYeWIXiwEodM4DAKdeUbVX1lSyzWYb
	 3JZODuE1moIkQmfuxGHGjk5Cgdkah+VFXqsgVAvohA9/R9Zp/MtJz0TnYg+r0N4jxa
	 T2qOnU7nW+kws3xpGHm1FLrDlXAJQKNMeZGaoSrVP7oir5pXIyEpnO/CSI3u6fDOQe
	 z6dK5x6jDRCyA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7be1c65dso5846081e87.3;
        Tue, 02 Jan 2024 03:18:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yy+mhgYUEQnK6GUBN3GFmZnirM6XrOKcwnSFWim9K7zH6s8jYdm
	n0o4p5zjrFzYBnpLWnglIhMAkkHw21y7DoRc55A=
X-Google-Smtp-Source: AGHT+IGgsUYGXA4bqYRKpYjLJHjv6nWrKFKnucQsap6r6UJnExeXJRUsvXf6giawUUtzd5X7dNSyjCfo9snU+EmV1Rw=
X-Received: by 2002:a05:6512:34cb:b0:50e:5c73:f17e with SMTP id
 w11-20020a05651234cb00b0050e5c73f17emr6464530lfr.123.1704194314603; Tue, 02
 Jan 2024 03:18:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703838752.git.anand.jain@oracle.com> <cf58eed9c9b9134b94fb6872d37b75a0c0bbe914.1703838752.git.anand.jain@oracle.com>
 <CAL3q7H7C10hZKyKgP=6H-+umNVawUn=vwJ6-gqDA8s0QZNFVTw@mail.gmail.com> <0cf6e6a1-c347-4dd9-98cd-4a95f36c84eb@oracle.com>
In-Reply-To: <0cf6e6a1-c347-4dd9-98cd-4a95f36c84eb@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Jan 2024 11:17:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5MyiJLgB5Pu5UxG9gNzTo0xJPKYSfqDAeLdVuEFOGTFQ@mail.gmail.com>
Message-ID: <CAL3q7H5MyiJLgB5Pu5UxG9gNzTo0xJPKYSfqDAeLdVuEFOGTFQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] common: add _filter_trailing_whitespace
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 8:02=E2=80=AFAM Anand Jain <anand.jain@oracle.com> w=
rote:
>
>
>
> On 12/29/23 20:57, Filipe Manana wrote:
> > On Fri, Dec 29, 2023 at 11:02=E2=80=AFAM Anand Jain <anand.jain@oracle.=
com> wrote:
> >>
> >> The command 'btrfs inspect-internal dump-tree -t raid_stripe'
> >> introduces trailing whitespace in its output.
> >> Apply a filter to remove it. Used in btrfs/30[4-8][.out].
> >>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>   common/filter | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/common/filter b/common/filter
> >> index 509ee95039ac..016d213b8bee 100644
> >> --- a/common/filter
> >> +++ b/common/filter
> >> @@ -651,5 +651,10 @@ _filter_bash()
> >>          sed -e "s/^bash: line 1: /bash: /"
> >>   }
> >>
> >> +_filter_trailing_whitespace()
> >> +{
> >> +       sed -e "s/ $//"
> >> +}
> >
> > If we're having such a generic filter in common file, than I'd rather
> > have it delete any number of trailing white spaces, not just a single
> > one, and also account for tabs and other white spaces, so:
> >
> > sed -e "s/\s+$//"
> >
>
>   I'll amend.
>
>
> > Also, since this is so specific to the raid stripe tree, I'd rather
> > have this filter included in the raid stripe tree filter introduced in
> > patch 2, _filter_stripe_tree(). That would make the tests shorter and
> > cleaner by avoiding piping yet over another filter that is used only
> > for the raid stripe tree dump...
>
>   I kept this as a separate function so that it can be used elsewhere
>   when needed. Doesn't that make sense?

Not so much if there's only one use case for it... specially if it's
such a trivial filter...

Even if we had multiple cases, doing this pattern in the tests:

$BTRFS_UTIL_PROG inspect-internal dump-tree (... ) |
_filter_trailing_whitespace | _filter_btrfs_version |
_filter_stripe_tree

Is ugly and verbose. The filtering could be done in
_filter_stripe_tree() by calling "_filter_triling_whitespace" there...
And mentioning that, we could also call _filter_btrfs_version there,
since it's always wanted and to make tests shorter and easier to read.

So in the end it would only be

$BTRFS_UTIL_PROG inspect-internal dump-tree (... ) | _filter_stripe_tree

With _filter_stripe_tree() as:

_filter_stripe_tree()
{
    _filter_trailing_whitespace | _filter_btrfs_version | sed -E -e (....)
}

Or:

_filter_stripe_tree()
{
    _filter_btrfs_version | sed -E -e "s/\s+$//" -e (...)
}

A lot more clean.

Thanks.


>
> Thanks, Anand

